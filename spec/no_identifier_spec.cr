require "./spec_helper"

Spectator.describe "no identifier" do
  let(file) { File.read(File.join("spec/fixtures", "no-identifier.vtt")) }
  let(vtt_file) { WebVTT::File.new(file) }

  it "returns the first cue with no identifier correctly" do
    first_cue = vtt_file.cues.first

    expect(first_cue.identifier).to eq("")
    expect(first_cue.start).to eq("00:00:00.000")
    expect(first_cue.end).to eq("00:00:03.000")
    expect(first_cue.settings).to eq("D:vertical A:start")
    expect(first_cue.text).to eq("I grew up in Eastern North Carolina, <b>Edgecombe</b> County")
  end

  it "returns the second cue with no identifier and no settings correctly" do
    last_cue = vtt_file.cues.last

    expect(last_cue.start).to eq("00:00:03.300")
    expect(last_cue.end).to eq("00:00:07.800")
    expect(last_cue.settings).to eq("")
    expect(last_cue.text).to eq("on a tobacco and dairy farm outside of\nTarboro.")
  end
end
