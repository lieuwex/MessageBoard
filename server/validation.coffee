if Meteor.isServer
    class User
        constructor: (@userId) -> @time = Date.now()

        @allowed: () ->
            now = Date.now()
            return @time <= (now - 500)

    `Users = new Meteor.Collection("users")`

    allowed = (userId) ->
        user = Object.create User, Users.findOne { userId: userId }
        if user?
            return user.allowed()
        else
            Users.insert(new User(userId))
            return true

	Meteor.startup ->
		Messages.allow
			insert: (userId, doc) ->
				if doc.message == "clearrAll"
					Messages.remove {} # Removes all entries
					return false       # Avoid adding 'clearrAll' in the collection
				else
					return allowed userId