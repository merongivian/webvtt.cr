require "./spec_helper"

Spectator.describe WebVTT::File do
  let(file) { File.read(File.join("spec/fixtures", "tolson.vtt")) }
  let(vtt_file) { WebVTT::File.new(file) }

  it "returns the first cue content correctly" do
    first_cue = vtt_file.cues.first

    expect(first_cue.identifier).to eq("1")
    expect(first_cue.start).to eq("00:00:00.000")
    expect(first_cue.end).to eq("00:00:03.000")
    expect(first_cue.settings).to eq("D:vertical A:start")
    expect(first_cue.text).to eq("I grew up in Eastern North Carolina, <b>Edgecombe</b> County")
  end

  it "has 2 cues" do
    expect(vtt_file.cues.size).to eq 2
  end

  it "returns the last cue text" do
    expect(vtt_file.cues.last.text).to eq "on a tobacco and dairy farm outside of\nTarboro."
  end
end
