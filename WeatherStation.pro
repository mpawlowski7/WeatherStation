TEMPLATE = subdirs

SUBDIRS += Source/Gui
!android {
   SUBDIRS += Source/Server
}

