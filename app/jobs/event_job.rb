class EventJob
  class << self

    # 自动维护状态       delayed job
    # 结束自动更新状态
    def finish(event)
       event.update_attributes(:status => 'finished')
    end


  end
end