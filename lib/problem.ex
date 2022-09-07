defmodule Problem do
  @moduledoc false

  alias Types.Chromosome

  @callback genotype :: Chromosome.t()
  @callback fitness_function(Chromosome.t()) :: number()
  @callback terminate?(Enum.t(), integer(), float()) :: boolean()
end
