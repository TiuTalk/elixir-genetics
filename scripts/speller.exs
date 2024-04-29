defmodule Speller do
  alias Types.Chromosome

  @behaviour Problem

  @target "hello world"

  @impl true
  def genotype do
    # genes = Stream.repeatedly(fn -> Enum.random(?a..?z) end) |> Enum.take(String.length(@target))
    genes = String.to_charlist(@target) |> Enum.shuffle()

    %Chromosome{genes: genes, size: Enum.count(genes)}
  end

  @impl true
  def fitness_function(chromosome) do
    guess = List.to_string(chromosome.genes)

    String.jaro_distance(@target, guess)
  end

  @impl true
  def terminate?([best | _], _generation), do: best.fitness == 1
end

solution = Genetic.run(Speller, population_size: 1000)

IO.puts("\n")
IO.inspect(solution)
