class TicketTypeJob
  class << self

    # 指定日期开售
    def start_sale(ticket)
      ticket.update_attributes(:status => 'on-sale')
    end

  end
end