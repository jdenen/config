defmodule Tracer do
  @moduledoc """
  Module for tracing and debugging calls by module, function, or function arity. The `start_tracing`
  functions are your most likely entry point into using `Tracer`, but other public functions exist for
  better usability.
  """

  @match_spec [{:_, [], [{:return_trace}]}]

  @doc """
  Setup tracing and trace all calls to a module.
  """
  def start_tracing(mod) do
    start_trace()
    trace(mod)
  end

  @doc """
  Setup tracing and trace all calls to a module's function. A list of functions is also possible.
  """
  def start_tracing(mod, fun) do
    start_trace()
    trace(mod, fun)
  end

  @doc """
  Setup tracing and trace all calls to a module's function with a specific arity.
  """
  def start_tracing(mod, fun, arity) do
    start_trace()
    trace(mod, fun, arity)
  end

  @doc """
  Setup `:dbg` for call tracing.
  """
  def start_trace do
    :dbg.start()
    :dbg.tracer(:process, {&nested/2, 0})
    :dbg.p(:all, :call)
  end

  @doc """
  Tear down call tracing with `:dbg`.
  """
  def stop_trace do
    :dbg.stop_clear()
  end

  @doc """
  Tear down and setup tracing with `:dbg`.
  """
  def reset() do
    stop_trace()
    start_trace()
  end

  @doc """
  Trace calls to a module.
  """
  def trace(module) do
    :dbg.tpl(module, :_, :_, @match_spec)
  end

  @doc """
  Trace calls to a function (or list of functions) in a module.
  """
  def trace(module, functions) when is_list(functions) do
    Enum.map(functions, fn f ->
      trace(module, f)
    end)
  end

  def trace(module, function) when is_atom(function) do
    :dbg.tpl(module, function, :_, @match_spec)
  end

  @doc """
  Trace calls to a module's function with specific arity.
  """
  def trace(module, function, arity) do
    :dbg.tpl(module, function, arity, @match_spec)
  end

  defp nested({:trace, _pid, :call, {mod, fun, param}}, level) do
    spaces = String.duplicate("|  ", level)

    IO.puts(
      "#{spaces}#{format_module(mod)}.#{fun} #{
        format_params(inspect(param, charlists: :as_lists, pretty: true))
      }"
    )

    level + 1
  end

  defp nested({:trace, _pid, :return_from, {mod, fun, arity}, rval}, level) do
    level = level - 1
    spaces = String.duplicate("|  ", level)

    IO.puts(
      "#{spaces}#{format_module(mod)}.#{fun}/#{arity} --> #{
        format_rval(inspect(rval, charlists: :as_lists, pretty: true))
      }"
    )

    level
  end

  defp nested(any, level) do
    IO.puts("trace_msg: #{inspect(any)}")
    level
  end

  defp format_params(params) do
    IO.ANSI.green() <> params <> IO.ANSI.reset()
  end

  defp format_module(mod) do
    IO.ANSI.cyan() <> Atom.to_string(mod) <> IO.ANSI.reset()
  end

  defp format_rval(rval) do
    rval
  end
end
