defmodule Cargo do
  @moduledoc false
  @behaviour Problem

  alias Types.Chromosome

  @impl true
  def genotype do
    genes = for _ <- 1..10, do: Enum.random(0..1)
    %Chromosome{genes: genes, size: length(genes)}
  end

  @impl true
  def fitness_function(chromosome) do
    profits = [6, 5, 8, 9, 6, 7, 3, 1, 2, 6]
    weights = [10, 6, 8, 7, 10, 9, 7, 11, 6, 8]
    weight_limit = 40

    profit =
      chromosome.genes
      |> Enum.zip(profits)
      |> Enum.map(fn {g, w} -> w * g end)
      |> Enum.sum()

    weight =
      chromosome.genes
      |> Enum.zip(weights)
      |> Enum.map(fn {g, w} -> w * g end)
      |> Enum.sum()

    if weight > weight_limit, do: 0, else: profit
  end

  @impl true
  def terminate?(_population, generation, _temperature), do: generation === 1000
end

solution = Genetic.run(Cargo)

weight =
  solution.genes
  |> Enum.zip([10, 6, 8, 7, 10, 9, 7, 11, 6, 8])
  |> Enum.map(fn {g, w} -> w * g end)
  |> Enum.sum()

IO.puts("Profit: #{solution.fitness}")
IO.puts("Weight is: #{weight}")

IO.inspect(solution)
