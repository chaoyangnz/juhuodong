authorization do
  role :guest do
    # add permissions for guests here, e.g.
    has_permission_on :events, :to => :read do
      if_attribute :status => 'published'
    end
    has_permission_on :events_tickets, :to => :read do
      if_permitted_to :read, :event
    end
    has_permission_on :events_fields, :to => :read do
      if_permitted_to :read, :event
    end
  end

  # permissions on other roles, such as
  #role :admin do
  #  has_permission_on :conferences, :to => :manage
  #end
  role :user do
    has_permission_on :events, :to => :manage do
      if_attribute :user => is { user }
    end

    has_permission_on :events_tickets, :to => :manage do
      if_permitted_to :manage, :event
    end

    has_permission_on :events_fields, :to => :manage do
      if_permitted_to :manage, :event
    end

    has_permission_on :hosts, :to => :manage do
      if_attribute :user => is { user }
    end
  end

  role :certified_user do

  end
end

privileges do
  # default privilege hierarchies to facilitate RESTful Rails apps
  privilege :manage, :includes => [:read, :create, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end