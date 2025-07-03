defmodule ErrorHandling do
  @doc """
  ** (RuntimeError) Oops!
  """
  def raise_error() do
    raise "Oops!"
  end

  @doc """
  ** (ArgumentError) raised argument error
    error_handling_example.exs:15: ErrorHandling.raise_error2/0
    error_handling_example.exs:19: (file)
  """
  def raise_error2() do
    raise ArgumentError, message: "raised argument error"
  end

  @doc """
  (rescued) An error occured: Oops!
  """
  def try_rescue() do
    try do
      raise "Oops!"
    rescue
      e in RuntimeError -> IO.puts "(rescued) An error occured: #{e.message}"
    end

    IO.puts "application continues..."
  end

  @doc """
  unable to read source file, enoent
  after block
  application continues...
  """
  def rescue_matching() do
    # try -> try
    # rescue -> catch
    # after -> finally
    # javaから見ると上のような感じ
    try do
      [source_file: "wrong_file.log"]
        |> Keyword.fetch!(:source_file)
        |> File.read!()
    rescue
      e in KeyError -> IO.puts("missing :source_file option, #{e}")
      e in File.Error -> IO.puts("unable to read source file, #{e.reason}") # hit!
    after
      IO.puts "after block"
    end

    IO.puts "application continues..."
  end

  defmodule CustomError do
    defexception key: :error, message: "default error message"
  end

  @doc """
  error message: error, key: my_custom_error
  application continues...
  """
  def raise_custom_error() do
    try do
      raise %CustomError{message: "error", key: :my_custom_error}
    rescue
      e in CustomError -> IO.puts "error message: #{e.message}, key: #{e.key}"
    end

    IO.puts "application continues..."
  end
end
