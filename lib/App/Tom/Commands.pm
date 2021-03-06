package App::Tom::Commands;
use v5.10;
use strict;
use warnings;

use English;

use File::Basename;
use File::Copy;
use File::Path qw{ remove_tree make_path };
use File::Spec;
use File::Tail;

use Getopt::Long;

use Mojo::DOM;

use lib qw{ lib };
use App::Tom::Config qw{ config };
use App::Tom::Utils qw{ error path plural slurp spit delay_while http_is_up http_get fmt_params };
use App::Tom::Commands::Utils;

BEGIN {
    # Win32 requirements
    if ( $^O =~ /win32/i ) {
        require Win32::OLE;
        Win32::OLE->import();
    }
}

use Exporter qw{ import };
our @EXPORT = qw{
  commands
  ctl
  restart
  list
  ping
  default_version
  available
  uninstall
  install
  register_install
  tail
  apps
  deploy
  remove
  env
  show_path
  java
  help
  art
  server
};

sub commands {
  my %cmds = @_;
  my $cmd  = shift @ARGV;

  sub {
    my ($cmd) = @_;
    if ( $cmd && $cmds{$cmd} ) { $cmds{$cmd}->() }
    else {
      $cmd = '' unless defined $cmd;
      if ( $cmd ) {
        error(\&help => "'$cmd' is an invalid command");
      }
      else {
        error(\&help);
      }
    }
  };
}

=head1 FUNCTIONS

=head2 up

    tom up [VERSION]

Starts up the version of tomcat specified or the default version if
the version is omitted.

=head2 down

    tom down

Shutsdown the currently running tomcat instance

=cut

sub ctl {
    my ($cmd, $version) = @_;
    $version // error(\&list, "Must specify version or set a default version");

    if ( $cmd eq 'shutdown' && ping() == 1 ) {
        say "Tomcat doesn't appear to be running.";
        return 0;
    }

    if ( $cmd eq 'startup' && ping() == 0 ) {
        say "Tomcat is already up.";
        return 0;
    }

    select_version($version => sub {
        my ($v) = @_;
        my $ext = $^O =~ /win32/i ? '.bat' : '.sh';
        my $root = path(config('INSTALL') => "apache-tomcat-$v");
        my $bin  = path($root => bin => "${cmd}${ext}");
    
        $ENV{CATALINA_HOME} = $root; # for windows scripts
    
        error(\&help => "must specify version") unless $v;
    
        if ( -e $bin ) {
            say "$cmd: Tomcat $v...";
            say "running '$bin'";
            system $bin;
            say "DONE.";
            if ($cmd eq 'startup') {
              delay_while
                sub { ping() == 1 },
                sub { open_browser "http://localhost:8080" };
            }
            return 0;
        }
        else {
            say STDERR "'$bin' doesn't exist";
            return 1;
        }
    });
}

=pod

=head2 restart

    tom restart [VERSION] [OPTIONS]

Restarts a currently running instance of tomcat if one is running otherwise
it just starts a new instance.  Can specify the host, port and timeout (in
seconds) for testing if a tomcat instance is currently running.

=cut

sub restart {
    my ($version) = @_;
    ctl(shutdown => $version);
    delay_while
      sub { ping() == 0 },
      sub { ctl(startup  => $version) };
}

=pod

=head2 list

    tom list

List all installed versions of Tomcat

=cut

sub list {
    my ($version) = @_;
    my @versions =
        map { $version && /$version/ ? "$_ * default " : $_ }
        get_versions();

    if ( @versions ) {
        say "Installed Tomcat versions:";
        say for @versions;
    }
    else {
        say "There doesn't appear to be any installed versions of Tomcat.\n",
            "Try using the 'install' command.";
        return 1;
    }

    return 0;
}

=pod

=head2 ping

    tom ping [OPTIONS]

Test if a HTTP server is running at a given host and port combination,
can also specify a timeout in seconds.  The default host is "localhost",
the default port is 8080, and the default timeout is 2 seconds.

=cut

sub ping {
    my ($host, $port, $time) =
      (config('HOST'), config('PORT'), config('TIMEOUT'));

    my $url = "http://$host:$port";
    if ( http_is_up($url, $time) ) {
        say "An HTTP server is up at $url";
        return 0;
    }
    else {
        say "Timed out after ", plural($time => "second"), " when testing $url.";
        return 1;
    }
}

=pod

=head1 version

    tom version VERSION

Set a default version

=cut

sub default_version {
    my ($version) = @_;

    select_version($version => sub {
        my ($v) = @_;
        spit(config('VFILE') => $v);
        say "Default version set to $v";
        return 0;
    });
}

=pod

=head2 available

    tom available

List all versions of Tomcat that are available for install

=cut

sub available {
    my ($version) = @_;

    my @installed = get_versions();

    say "Tomcat versions available for install:";
    for my $v (get_available()) {
        if ( grep { /$v/ } @installed ) {
            say "$v - installed";
        }
        else {
            say $v;
        }
    }

    return 0;
}

=pod

=head2 uninstall

    tom uninstall VERSION

Uninstalls a version of Tomcat

=cut

sub uninstall {
    my ($pattern) = @_;

    error(\&list => 'A version must be specified') unless $pattern;
    
    select_version($pattern => sub {
        my ($version) = @_;
        my $install = path(config('INSTALL') => "apache-tomcat-$version");
        if ( -e $install ) {
            # TODO: check if this works on windows
            remove_tree $install or error(undef, $!);
    
            my $v = slurp(config('VFILE'));
            if ( $v and $v eq $version ) {
                if ( my @vs = get_versions() ) {
                    spit(config('VFILE') => $vs[0]);
                }
                else {
                    spit(config('VFILE') => '');
                }
            }
    
            say "Tomcat $version has been removed";
            return 0;
        }
        else {
            error(\&list => "Tomcat $version does not apear to be installed");
        }
    });
}

=pod

=head2 register

    tom register VERSION PATH

Registers a version of Tomcat

=cut

sub register_install {
  my ($version, $path) = @_;

  error(\&help => 'A version must be specified') unless $version;
  error(\&help => 'A path must be specified')    unless $path;

  my %reg = registry();
  $reg{$version} = $path;

  write_registry %reg;
}

=pod

=head2 install

    tom install VERSION [PATH]

Installs a version of Tomcat

=cut

sub install {
    my ($version, $path) = @_;

    $path //= config('INSTALL');

    error(\&help => 'A version must be specified') unless $version;

    my $install = path($path => "apache-tomcat-$version");
    if ( -e $install ) {
        say "Tomcat version $version is already installed at $install";
        return 0;
    }
    else {
        say "Trying to install version $version in $install...";
        my $r = fetch_install($path, $version => mirrormap($version => "apache-tomcat-$version"));
        register_install $version, $path;
        return $r;
    }
}

=pod

=head2 tail
    
    tom tail [VERSION] [LOGFILE]

Display log entries as they are logged can optionally specify a Tomcat
version or a log file in CATALINA_HOME/logs.

=cut

sub tail {
    my ($version, $log);
    if    ( @_ == 1 ) { ($version, $log) = ($_[0], 'catalina.out') }
    elsif ( @_ == 2 ) { ($version, $log) = @_ }
    else              { die "tail died" }

    select_version($version => sub {
        my ($v, $p) = @_;
        if ( -e $p ) {
            my $file = do {
                if ( -e $log ) { $log }
                else {
                    path($p => logs => $log);
                }
            };
            say "Viewing '$file':";
            my $t = File::Tail->new(name => $file, tail => 20);
            while ( local $_ = $t->read ) { print }
            0;
        }
        else {
            say "Installation path '$p' does not exist";
            1;
        }
    });
}

=pod

=head2 apps
    
    tom apps [VERSION]

Deploy a web application to a given version of Tomcat via a warfile
or directory.

=cut

sub apps {
    my ($version) = @_;
    select_version($version => sub {
        my ($v, $p) = @_;
        if ( -e $p ) {
            my $dir = path($p => 'webapps');
            say "Apps installed for Tomcat version $v:";
            say for sort map { basename $_ } glob "$dir/*";
            0;
        }
        else {
            say "Installation path '$p' does not exist";
            1;
        }
    });
}

=pod

=head2 deploy
    
    tom deploy [VERSION] WARFILE|DIRECTORY

Deploy a web application to a given version of Tomcat via a warfile
or directory.

=cut

sub deploy {
    my ($version, $file);
    if    ( @_ <  1 ) { die "Must specify war file or directory to deploy" }
    elsif ( @_ == 2 ) { ($version, $file) = @_ }
    else              { ($version, undef, $file) = @_ }

    select_version($version => sub {
        my ($v, $p) = @_;
        if ( -e $p ) {
            my $dir = path($p => 'webapps');
            say "Copying $file\n\tto $dir...";
            copy($file, $dir);
            say "DONE.";
            0;
        }
        else {
            say "Installation path '$p' does not exist";
            1;
        }
    });
}

=pod

=head2 remove

    tom remove [VERSION] APPNAME

Remove a deployed app from a given version of Tomcat.

=cut

sub remove {
    my ($version, $file);
    if    ( @_ <  1 ) { die "Must specify an app name to remove" }
    elsif ( @_ == 2 ) { ($version, $file) = @_ }
    else              { ($version, undef, $file) = @_ }

    select_version($version => sub {
        my ($v, $p) = @_;
        if ( -e $p ) {
            my $dir = path($p => 'webapps');
            say "Removing $file from $dir...";
            my $app = path($dir => $file);
            my $war = "$app.war";
            if ( -e $app ) {
                remove_tree($app);
                say "DONE.";
            }
            else {
                say "An app called '$file' has not been deployed for Tomcat version $v.";
            }
            unlink $war if -e $war;
            0;
        }
        else {
            say "Installation path '$p' does not exist";
            1;
        }
    });
}

=pod

=head2 env
    
    tom env

Display environment information

=cut

sub env {
    my ($version) = @_;
    select_version($version => sub {
        my ($v, $p) = @_;
        if ( -e $p ) {
            say "Environment for Tomcat Version $v";
            say "OS: ", determine_os();
            say "Perl: $PERL_VERSION";
            say "Containers Path: ", config('INSTALL');
            say "Java: ", determine_java();
        }
        else {
            say "Installation path '$p' does not exist";
            1;
        }
    });
}

=pod

=head2 path

    tom path [VERSION]

Display a container's path (great for piping to other commands).

=cut

sub show_path {
  my ($version) = @_;

  select_version($version => sub {
      my ($v, $p) = @_;
      print $p;
  });

  0;
}

=pod

=head2 java
    
    tom java [JAVA_VERSION]

Set and view JAVA_HOME environment variable

=cut

sub java {
    my ($version) = @_;
    select_java($version => sub {
        my ($v, $p) = @_;
        $ENV{JAVA_HOME} = $v;
        say_java_home();
    });
}

=pod

=head2 server

    tom server COMMAND

Issue commands to a remote Tomcat server.

=cut

sub server {
  my ($version, $command, %params) = @_;
  my ($host, $port, $ttl) = (config('HOST'), config('PORT'), config('TIMEOUT'));
  my $user = config('USERNAME') or die 'A username is required for remote access';
  my $pass = config('PASSWORD') or die 'A password is required for remote access';
  my $params = fmt_params(%params);

  select_version $version => sub {
    my ($v, $p) = @_;
    my $url;
    if ($v =~ /^6/) {
      $url = "http://$user:$pass\@$host:$port/manager/$command?$params";
    }
    elsif ($v =~ /^8/) {
      $url = "http://$user:$pass\@$host:$port/manager/text/$command?$params";
    }
    else {
      die "not sure what to do";
    }
    print http_get($url);
  };

  0;
}

=head2 help

    tom help

Displays a help message

=cut

sub help {
  my $bin = basename($0);
    say <<HELP;
Usage: $bin [COMMAND] [OPTIONS]

  Commands:
        help - Display this message

  Tomcat Administration:
     install - Install a version of Tomcat
   uninstall - Uninstall a version of Tomcat
        list - List installed versions
   available - List versions available for install
     version - Set default version
        ping - Test if Tomcat is up
          up - Startup Tomcat server
        down - Shutdown Tomcat server
     restart - Restart Tomcat server

  Application Deployment:
        apps - List all web applications deployed to a Tomcat server
      deploy - Deploy a web application to a Tomcat server
      remove - Remove a deployed web application from a Tomcat server

  Environment:
         env - Display environment information
        path - Display Tom's container path
        java - Set or view Java version

  Fun:
         art - View some Java art

  Options:
     --port, -p PORT
        Specify an HTTP port (8080 by default)

     --host, -h HOST
        Specify a network host (localhost by default)

     --timeout, -t TIMEOUT
        Specify timeout in seconds (2 seconds by default)

  returns 0 on success and 1 on failure
HELP

   0;
}

=pod

=head2 art

    tom art

Displays some Java art

=cut

sub art {
  say <<ART;
                          MMMM   MMM    MMM                                     
                           MMMM  MMMM    MMMM                                   
                            MMMM   MMM    MMM                                   
                             MMM    MMM    MMM                                  
                             MMM    MMM    MMM                                  
                            MMMM   MMM    MMM                                   
                           MMMM   MMMM   MMMM                                   
                          MMMM   MMM    MMMM                                    
                         MMM   MMMM   MMMM                                      
                        MMM    MMM    MMM                                       
                        MMM   MMM    MMMM                                       
                        MMM   MMM    MMM                                        
                        MMMM  MMMM    MMM                                       
                         MMMM  MMMM   MMMM                                      
                          MMM   MMMM    MMM                                     
                                                                                
     MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                   
     MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                  
     MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM   MMMMMMMMM      
     MMMM777777777777777777777777777777777777777777777777\$MMMMMMMMMMMMMMMMMMM   
     MMMM777777777777777777777777777777777777777777777777ZMMMMMMMMMM    MMMMMM  
     MMMM777777777777777777777777777777777777777777777777DMMMMMMM         MMMM  
     MMMM777777777777777777777777777777777777777777777777MMMMMMM          MMMMM 
     MMMM777777777777777777777777777777777777777777777777MMMMMM            MMMMM
     MMMM\$1908874354MMMMM             MMMMM
      MMMM77777777777777777777777777777777777777777777777MMMM              MMMMM
      MMMM7777777777777777777777777777777777777777777777\$MMMM              MMMMM
      MMMM7777777777777777777777777777777777777777777777MMMMM              MMMM 
      MMMMM777777777777777777777777777777777777777777777MMMMM             MMMMM 
       MMMM77777777777777777777777777777777777777777777DMMMMM            MMMMM  
        MMMM7777777777777777777777777777777777777777777MMMMMMM          MMMMM   
        MMMM877777777777777777777777777777777777777777MMMMMMMMM       MMMMMMM   
         MMMM7777777777777777777777777777777777777777MMMMM MMMMMMMMMMMMMMMM     
         MMMMM77777777777777777777777777777777777777MMMMM   MMMMMMMMMMMMM       
          MMMMM777777777777777777777777777777777777MMMMM      MMMMMMMMM         
           MMMMMZ777777777777777777777777777777777MMMMM                         
 MMMMMMMMMMMMMMMMNDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDMMMMMMMMMMMMMMMMM              
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM             
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM             
 MMMMMM77777777777777777777777777777777777777777777777777777MMMMM               
   MMMMM87777777777777777777777777777777777777777777777777MMMMMM                
    MMMMMMM77777777777777777777777777777777777777777777MMMMMMM                  
      MMMMMMMMMMZ77777777777777777777777777777777ZMMMMMMMMMMM                   
        MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                      
            MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                          
                   MMMMMMMMMMMMMMMMMMMMMMMMMMMMM                                
ART

  exit 0;
}
1;

