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
  "internal/cld_generated_cjk_delta_bi_32.o",
  "internal/generated_distinct_bi_0.o",
  "internal/cld2_generated_quad0122.o",
  "internal/cld2_generated_deltaocta0122.o",
  "internal/cld2_generated_distinctocta0122.o",
  "internal/cld_generated_score_quad_octa_0122.o",
  "thunk.o"]

if have_library('stdc++')
  create_makefile('libcld2')
end

# to clean up object files under internal subdirectory.
open('Makefile', 'a') do |f|
  f.write <<EOS

  CLEANOBJS := $(CLEANOBJS) internal/*.#{CONFIG["OBJEXT"]}
EOS
end
