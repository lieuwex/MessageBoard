if Meteor.isServer
    class User
        constructor: (@userId) -> @time = Date.now()

	Meteor.startup ->
		Messages.allow
			insert: (userId, doc) ->
				if doc.message == "clear"
					Messages.remove {} # Removes all entries
					return false       # Avoid adding 'clear' in the collection
				else
					return true
