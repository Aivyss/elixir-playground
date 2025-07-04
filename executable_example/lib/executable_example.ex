defmodule ExecutableExample.CLI do
  def main(args \\ []) do
    args |> OptionParser.parse(
      strict: [
        upcase: :boolean,
        downcase: :boolean,
        trim: :boolean,
        after: :string,
      ],
      aliases: [
        u: :upcase,
        d: :downcase,
        t: :trim,
        af: :after,
      ]
    ) |> process
  end

  defp process({options, arguments, _}) do
    IO.puts "options: #{inspect options}"
    IO.puts "arguments: #{inspect arguments}"

    transformations = [
      {:upcase, &String.upcase/1},
      {:downcase, &String.downcase/1},
      {:trim, &String.trim/1},
    ]

    arguments =
      Enum.reduce(transformations, arguments, fn {key, func}, acc ->
        if options[key], do: Enum.map(acc, func), else: acc
      end)

    (if options[:after] do
      arguments |> Enum.map(fn s -> s <> "_" <> options[:after] end)
    end || arguments) |> Enum.each(&(IO.puts &1))
  end
end
