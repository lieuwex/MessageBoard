`Messages = new Meteor.Collection("messages")`

###*
# Message entry for the 'messages' collection
#
# @class Message
###
class Message
	constructor: (@message) -> @time = Date.now()
		
if Meteor.isClient
	Template.messages.messages = ->
		Messages.find {}, { sort: { time: -1 }}

	Template.message.rendered = ->
		$(@firstNode).animate {
			opacity: .7 
		}, 500

	Template.entry.events
		"keyup #inputmessage": (evt) ->
			if evt.which == 13 && evt.target.value != ""
				Messages.insert new Message evt.target.value
				evt.target.value = ""

	Template.header.events
		'mouseenter #header': -> Animate 1.0, "easeOutQuart"
		'mouseleave #header': -> Animate 0.5, "easeInQuart"

	# Set the 'disconnected' header according to if there's a connection.
	Meteor.setInterval -> 
			_.delay ->  # There is a little overhead for connecting.
				if Meteor.status().connected
					opacity = 0
				else
					opacity = .7

				$("#status").stop()
				$("#status").animate { opacity: opacity }
			, 1200
		, 1000

	###*
	# Animates #header
	# 
	# @method Animate
	# @param opacity {Number} Opacity to animate to
	# @param method {String} Method (Curve) for the animation
	###
	Animate = (opacity, method) ->
		$("#header").stop()    #stop the current animation
		$("#header").animate   #animate!
				opacity: opacity
			, method