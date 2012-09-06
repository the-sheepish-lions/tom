/**
 * This file has no copyright assigned and is placed in the Public Domain.
 * This file is part of the w64 mingw-runtime package.
 * No warranty is given; refer to the file DISCLAIMER.PD within this package.
 */
DEFINE_GUID(GUID_IO_VOLUME_CHANGE,0x7373654aL,0x812a,0x11d0,0xbe,0xc7,0x08,0x00,0x2b,0xe2,0x09,0x2f);
DEFINE_GUID(GUID_IO_VOLUME_DISMOUNT,0xd16a55e8L,0x1059,0x11d2,0x8f,0xfd,0x00,0xa0,0xc9,0xa0,0x6d,0x32);
DEFINE_GUID(GUID_IO_VOLUME_DISMOUNT_FAILED,0xe3c5b178L,0x105d,0x11d2,0x8f,0xfd,0x00,0xa0,0xc9,0xa0,0x6d,0x32);
DEFINE_GUID(GUID_IO_VOLUME_MOUNT,0xb5804878L,0x1a96,0x11d2,0x8f,0xfd,0x00,0xa0,0xc9,0xa0,0x6d,0x32);
DEFINE_GUID(GUID_IO_VOLUME_LOCK,0x50708874L,0xc9af,0x11d1,0x8f,0xef,0x00,0xa0,0xc9,0xa0,0x6d,0x32);
DEFINE_GUID(GUID_IO_VOLUME_LOCK_FAILED,0xae2eed10L,0x0ba8,0x11d2,0x8f,0xfb,0x00,0xa0,0xc9,0xa0,0x6d,0x32);
DEFINE_GUID(GUID_IO_VOLUME_UNLOCK,0x9a8c3d68L,0xd0cb,0x11d1,0x8f,0xef,0x00,0xa0,0xc9,0xa0,0x6d,0x32);
DEFINE_GUID(GUID_IO_VOLUME_NAME_CHANGE,0x2de97f83,0x4c06,0x11d2,0xa5,0x32,0x0,0x60,0x97,0x13,0x5,0x5a);
DEFINE_GUID(GUID_IO_VOLUME_PHYSICAL_CONFIGURATION_CHANGE,0x2de97f84,0x4c06,0x11d2,0xa5,0x32,0x0,0x60,0x97,0x13,0x5,0x5a);
DEFINE_GUID(GUID_IO_VOLUME_DEVICE_INTERFACE,0x53f5630d,0xb6bf,0x11d0,0x94,0xf2,0x00,0xa0,0xc9,0x1e,0xfb,0x8b);
DEFINE_GUID(GUID_IO_MEDIA_ARRIVAL,0xd07433c0,0xa98e,0x11d2,0x91,0x7a,0x00,0xa0,0xc9,0x06,0x8f,0xf3);
DEFINE_GUID(GUID_IO_MEDIA_REMOVAL,0xd07433c1,0xa98e,0x11d2,0x91,0x7a,0x00,0xa0,0xc9,0x06,0x8f,0xf3);
DEFINE_GUID(GUID_IO_DEVICE_BECOMING_READY,0xd07433f0,0xa98e,0x11d2,0x91,0x7a,0x00,0xa0,0xc9,0x06,0x8f,0xf3);

typedef struct _DEVICE_EVENT_BECOMING_READY {
  ULONG Version;
  ULONG Reason;
  ULONG Estimated100msToReady;
} DEVICE_EVENT_BECOMING_READY,*PDEVICE_EVENT_BECOMING_READY;

DEFINE_GUID(GUID_IO_DEVICE_EXTERNAL_REQUEST,0xd07433d0,0xa98e,0x11d2,0x91,0x7a,0x00,0xa0,0xc9,0x06,0x8f,0xf3);
DEFINE_GUID(GUID_IO_MEDIA_EJECT_REQUEST,0xd07433d1,0xa98e,0x11d2,0x91,0x7a,0x00,0xa0,0xc9,0x06,0x8f,0xf3);

typedef struct _DEVICE_EVENT_EXTERNAL_REQUEST {
  ULONG Version;
  ULONG DeviceClass;
  USHORT ButtonStatus;
  USHORT Request;
  LARGE_INTEGER SystemTime;
} DEVICE_EVENT_EXTERNAL_REQUEST,*PDEVICE_EVENT_EXTERNAL_REQUEST;

DEFINE_GUID(GUID_IO_DRIVE_REQUIRES_CLEANING,0x7207877c,0x90ed,0x44e5,0xa0,0x0,0x81,0x42,0x8d,0x4c,0x79,0xbb);
DEFINE_GUID(GUID_IO_TAPE_ERASE,0x852d11eb,0x4bb8,0x4507,0x9d,0x9b,0x41,0x7c,0xc2,0xb1,0xb4,0x38);

typedef struct _DEVICE_EVENT_GENERIC_DATA {
  ULONG EventNumber;
} DEVICE_EVENT_GENERIC_DATA,*PDEVICE_EVENT_GENERIC_DATA;

DEFINE_GUID(GUID_DEVICE_EVENT_RBC,0xd0744792,0xa98e,0x11d2,0x91,0x7a,0x00,0xa0,0xc9,0x06,0x8f,0xf3);

typedef struct _DEVICE_EVENT_RBC_DATA {
  ULONG EventNumber;
  UCHAR SenseQualifier;
  UCHAR SenseCode;
  UCHAR SenseKey;
  UCHAR Reserved;
  ULONG Information;
} DEVICE_EVENT_RBC_DATA,*PDEVICE_EVENT_RBC_DATA;

DEFINE_GUID(GUID_IO_DISK_CLONE_ARRIVAL,0x6a61885b,0x7c39,0x43dd,0x9b,0x56,0xb8,0xac,0x22,0xa5,0x49,0xaa);

typedef struct _GUID_IO_DISK_CLONE_ARRIVAL_INFORMATION {
  ULONG DiskNumber;
} GUID_IO_DISK_CLONE_ARRIVAL_INFORMATION,*PGUID_IO_DISK_CLONE_ARRIVAL_INFORMATION;

DEFINE_GUID(GUID_IO_DISK_LAYOUT_CHANGE,0x11dff54c,0x8469,0x41f9,0xb3,0xde,0xef,0x83,0x64,0x87,0xc5,0x4a);
