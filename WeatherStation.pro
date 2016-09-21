TEMPLATE = subdirs

SUBDIRS += weathers-gui
!android {
   SUBDIRS += weathers-srv
}

