import { application } from './application'

import HelloController from './hello_controller'
application.register('hello', HelloController)

import MediaTypeController from './media_type_controller'
application.register('media-type', MediaTypeController)

import TracksController from './tracks_controller'
application.register('tracks', TracksController)
