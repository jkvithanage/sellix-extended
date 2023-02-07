class DashboardsController < ApplicationController
  # before_action :authenticate_user!

  def show
    @chart_data = {
      labels: scope[0],
      datasets: [{
        label: 'Total revenue',
        backgroundColor: 'transparent',
        borderColor: '#3B82F6',
        data: scope[1]
      },
      {
        label: 'Crypto revenue',
        backgroundColor: 'transparent',
        borderColor: '#00E676',
        data: scope[2]
      },
      {
        label: 'Fiat revenue',
        backgroundColor: 'transparent',
        borderColor: '#E91E63',
        data: scope[3]
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
  end

  private

  def scope
    groups = Order.all.group_by { |order| Time.at(order.created_at).year }
    all_arr = []
    crypto_arr = []
    fiat_arr = []
    groups.values.each do |group|
      sum_all = 0
      sum_crypto = 0
      sum_fiat = 0
      group.each do |order|
        sum_all += order.total
        if ['STRIPE', 'PAYPAL', 'PAYDASH'].include? order.gateway
          sum_fiat += order.total
        else
          sum_crypto += order.total
        end
      end
      all_arr << sum_all
      crypto_arr << sum_crypto
      fiat_arr << sum_fiat
    end
    [groups.keys, all_arr, crypto_arr, fiat_arr]
  end
end
