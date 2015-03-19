# encoding: UTF-8
require "spec_helper"

describe CLD do

  context ".detect_language" do
    context "English text" do
      subject { CLD.detect_language("This is a test") }

      it { subject[:name].should eq("ENGLISH") }
      it { subject[:code].should eq("en") }
      it { subject[:reliable].should be_true }
    end

    context "French text" do
      subject { CLD.detect_language("plus ça change, plus c'est la même chose") }

      it { subject[:name].should eq("FRENCH") }
      it { subject[:code].should eq("fr") }
      it { subject[:reliable].should be_true }
    end

    context "Italian text" do
      subject { CLD.detect_language("sono tutti pazzi qui") }

      it { subject[:name].should eq("ITALIAN") }
      it { subject[:code].should eq("it") }
      it { subject[:reliable].should be_true }
    end

    context "French in HTML - using CLD html " do
      subject { CLD.detect_language("<html><head><body><script>A large amount of english in the script which should be ignored if using html in detect_language.</script><p>plus ça change, plus c'est la même chose</p></body></html>", false) }

      it { subject[:name].should eq("FRENCH") }
      it { subject[:code].should eq("fr") }

    end

    context "French in HTML - using CLD text " do
      subject { CLD.detect_language("<html><head><body><script>A large amount of english in the script which should be ignored if using html in detect_language.</script><p>plus ça change, plus c'est la même chose</p></body></html>", true) }

      it { subject[:name].should eq("ENGLISH") }
      it { subject[:code].should eq("en") }

    end

    context "Simplified Chinese text" do
      subject { CLD.detect_language("你好吗箭体") }

      it { subject[:name].should eq("Chinese") }
      it { subject[:code].should eq("zh") }
    end

    context "Traditional Chinese text" do
      subject { CLD.detect_language("你好嗎繁體") }

      it { subject[:name].should eq("ChineseT") }
      it { subject[:code].should eq("zh-Hant") }
    end

    context "Unknown text" do
      subject { CLD.detect_language("") }

      it { subject[:name].should eq("Unknown") }
      it { subject[:code].should eq("un") }
      it { subject[:reliable].should_not be_true }
    end

    context "nil for text" do
      subject { CLD.detect_language(nil) }

      it { subject[:name].should eq("Unknown") }
      it { subject[:code].should eq("un") }
      it { subject[:reliable].should_not be_true }
    end
  end

  context ".detect_language_summary" do
    context "get the result as well as a summary" do
      subject { CLD.detect_language_summary("This is a test") }

      it { subject[:result].should eq(CLD.detect_language("This is a test")) }
      it { subject[:summary].should_not be_nil }
    end

    context "result and summary[0] are the same language" do
      subject { CLD.detect_language_summary("This is a test") }

      it { subject[:result][:name].should eq(subject[:summary][0][:name]) }
      it { subject[:result][:code].should eq(subject[:summary][0][:code]) }
    end

    context "summary[0] should have a higher confidence than the other two" do
      subject { CLD.detect_language_summary("Hola amigos") }

      it { subject[:summary][0][:confidence].should be >= subject[:summary][1][:confidence] }
      it { subject[:summary][0][:confidence].should be >= subject[:summary][2][:confidence] }
    end

    context "English text" do
      subject { CLD.detect_language_summary("This is a test") }

      it { subject[:result][:name].should eq("ENGLISH") }
      it { subject[:result][:code].should eq("en") }
      it { subject[:result][:reliable].should be_true }
      it { subject[:summary][0][:confidence].should be_within(10).of(100) }
    end

    context "French in HTML - using CLD html " do
      subject { CLD.detect_language_summary("<html><head><body><script>A large amount of english in the script which should be ignored if using html in detect_language_summary.</script><p>plus ça change, plus c'est la même chose</p></body></html>", false) }

      it { subject[:summary][0][:name].should eq("FRENCH") }
      it { subject[:summary][0][:code].should eq("fr") }
    end

    context "French in HTML - using CLD text " do
      subject { CLD.detect_language_summary("<html><head><body><script>A large amount of english in the script which should be ignored if using html in detect_language_summary.</script><p>plus ça change, plus c'est la même chose</p></body></html>", true) }

      it { subject[:summary][0][:name].should eq("ENGLISH") }
      it { subject[:summary][0][:code].should eq("en") }

    end

    context "Unknown text" do
      subject { CLD.detect_language_summary("") }

      it { subject[:summary][0][:name].should eq("Unknown") }
      it { subject[:summary][0][:code].should eq("un") }
      it { subject[:summary][0][:confidence].should eq(0) }
    end

    context "nil for text" do
      subject { CLD.detect_language_summary(nil) }

      it { subject[:summary][0][:name].should eq("Unknown") }
      it { subject[:summary][0][:code].should eq("un") }
      it { subject[:summary][0][:confidence].should eq(0) }
    end
  end

end
