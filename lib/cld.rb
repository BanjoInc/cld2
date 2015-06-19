require "cld/version"
require "ffi"

module CLD
  extend FFI::Library

  # Workaround FFI dylib/bundle issue.  See https://github.com/ffi/ffi/issues/42
  suffix = if FFI::Platform.mac?
    'bundle'
  else
    FFI::Platform::LIBSUFFIX
  end

  ffi_lib File.join(File.expand_path(File.dirname(__FILE__)), '..', 'ext', 'cld', 'libcld2.' + suffix)

  def self.detect_language(text, is_plain_text=true)
    result = detect_language_ext(text.to_s, is_plain_text)
    build_hash(result)
  end

  def self.detect_language_summary(text, is_plain_text=true)
    summary3 = FFI::MemoryPointer.new(Summary.by_value, 3)

    result = detect_language_summary_ext(text.to_s, is_plain_text, summary3)
    returned = build_hash(result)

    languages3 = summary3.read_array_of_pointer(3)
    summary = languages3.map { |l| build_hash(Summary.new(l)) }

    { result: returned, summary: summary }
  end

  private

  def self.build_hash(result)
    Hash[ result.members.map {|member| [member.to_sym, result[member]]} ]
  end

  class ReturnValue < FFI::Struct
    layout :name, :string, :code, :string, :reliable, :bool
  end

  class Summary < FFI::Struct
    layout :name, :string, :code, :string, :confidence, :int
  end

  attach_function "detect_language_ext", "detectLanguageThunkInt", [:buffer_in, :bool], ReturnValue.by_value
  attach_function "detect_language_summary_ext", "detectLanguageSummaryThunkInt", [:buffer_in, :bool, :pointer], ReturnValue.by_value
end
