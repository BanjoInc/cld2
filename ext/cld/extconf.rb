require 'mkmf'

# HACK: mkmf doesn't support multiple subdirs for the same library
$objs = ["internal/cldutil.o",
  "internal/cldutil_shared.o",
  "internal/compact_lang_det.o",
  "internal/compact_lang_det_hint_code.o",
  "internal/compact_lang_det_impl.o",
  "internal/debug.o",
  "internal/fixunicodevalue.o",
  "internal/generated_entities.o",
  "internal/generated_language.o",
  "internal/generated_ulscript.o",
  "internal/getonescriptspan.o",
  "internal/lang_script.o",
  "internal/offsetmap.o",
  "internal/scoreonescriptspan.o",
  "internal/tote.o",
  "internal/utf8statetable.o",
  "internal/cld_generated_cjk_uni_prop_80.o",
  "internal/cld2_generated_cjk_compatible.o",
  "internal/cld_generated_cjk_delta_bi_4.o",
  "internal/generated_distinct_bi_0.o",
  "internal/cld2_generated_quadchrome0122_2.o",
  "internal/cld2_generated_deltaoctachrome0122.o",
  "internal/cld2_generated_distinctoctachrome0122.o",
  "internal/cld_generated_score_quad_octa_0122_2.o",
  "thunk.o"]

# Prevents issues compiling with newer GCC versions
$defs.push("-std=c++98")

if have_library('stdc++')
  create_makefile('libcld2')
end

# to clean up object files under internal subdirectory.
open('Makefile', 'a') do |f|
  f.write <<EOS

  CLEANOBJS := $(CLEANOBJS) internal/*.#{CONFIG["OBJEXT"]}
EOS
end