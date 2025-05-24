defmodule Skygarden.Helpers do

def decimal_points(number,number_of_decimal_points) do
  :erlang.float_to_binary(number, decimals: number_of_decimal_points)
end

end
