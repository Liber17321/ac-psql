module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.email
    end

    private

    # FIXME: devise timeoutable will raise error here
    # https://redmine.rocodev.com/issues/16255
    def find_verified_user # this checks whether a user is authenticated with devise
      if (current_user = User.find_by_id cookies.signed['user.id'])
        current_user
      else
        reject_unauthorized_connection
      end
    end

  end
end
