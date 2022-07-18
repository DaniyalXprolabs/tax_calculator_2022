# frozen_string_literal: true

require_relative "tax_calculator_2022/version"

module TaxCalculator2022
   # frozen_string_literal: true

require_relative "tax_computation/version"

  RANGES = {600000.0...1200000.0 => {percentage: 2.5, fixed_amount: 0, low: 600000.0},
            1200000.0...2400000.0 => {percentage: 12.5, fixed_amount: 15000, low: 1200000},
            2400000.0...3600000.0 => {percentage: 20, fixed_amount: 165000, low: 2400000},
            3600000.0...6000000.0 => {percentage: 25, fixed_amount: 405000, low: 3600000},
            6000000.0...12000000.0 => {percentage: 32.5, fixed_amount: 1005000, low: 6000000},
            12000000.0...Float::INFINITY => {percentage: 35, fixed_amount: 2955000, low: 12000000.0}
          }

  private

  def self.calculate_monthly_tax(salary)
    salary = salary * 12
    if salary <= 600000.0
      0
    else
      calculate(salary) / 12.to_f
    end
  end

  def self.calculate_yearly_tax(salary)
    if salary <= 600000.0
      0
    else
      calculate(salary)
    end
  end

  def self.calculate (salary)
    range = RANGES.select{|range| range === salary}
    range.values[0][:fixed_amount] + (((salary - range.values[0][:low]) / 100) * range.values[0][:percentage])
  end
end
