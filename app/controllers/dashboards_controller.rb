class DashboardsController < ApplicationController
  # before_action :authenticate_user!

  def show
    @chart_data = {
      labels: scope[0],
      datasets: [{
        label: 'Revenue by year',
        backgroundColor: 'transparent',
        borderColor: '#3B82F6',
        data: scope[1]
      }]
    }

    @chart_options = {
      scales: {
        y: {
          beginAtZero: true
        }
      },
      tension: 0.5
    }
    # raise
  end

  private

  def scope
    groups = Order.all.group_by { |order| Time.at(order.created_at).year }
    overall = groups.values.map do |group|
      sum = 0
      group.each { |order| sum += order.total }
      sum
    end

    # result = by_gateway(groups)

    [groups.keys, overall]
  end

  def by_gateway(groups)
    groups.map do |group|
      group.values.group_by(&:gateway)
    end
  end
end
