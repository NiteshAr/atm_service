class DenominationsController < ApplicationController

  # GET /get_denomination/?input_amount=25
  def get_denomination
    input_amount = denomination_params.to_i
    if input_amount.positive?
        @curreny_details = find_minimum(input_amount)
    else
      render :json => {}, :status => :bad_request
    end
  end

  def find_minimum(input_amount)
    curreny = Hash.new(0)
    currenct_denomination = CURRENCY['currency_denomination']
    while(input_amount > 0)
      if(currenct_denomination['quarter'] <= input_amount)
        curreny['quarter'] += 1
        input_amount -= currenct_denomination['quarter']
      elsif(currenct_denomination['dime'] <= input_amount)
       curreny['dime'] += 1
       input_amount -= currenct_denomination['dime']
      elsif(currenct_denomination['nickel'] <= input_amount)
       curreny['nickel'] += 1   
       input_amount -= currenct_denomination['nickel']
      elsif(currenct_denomination['penny'] <= input_amount)
       curreny['penny'] += 1
       input_amount -= currenct_denomination['penny']
      end
    end
    return curreny
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Only allow a list of trusted parameters through.
    def denomination_params
      params.fetch(:input_amount)
    end
end
