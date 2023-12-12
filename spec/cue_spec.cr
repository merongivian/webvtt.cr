require "./spec_helper"

Spectator.describe WebVTT::Cue do
  it "parses an individual cue" do
    cue = WebVTT::Cue.new(identifier: "1", cue_line: "00:00:00.000 --> 00:00:03.000 D:vertical A:start", text: "I grew up in Eastern North Carolina, <b>Edgecombe</b> County")

    expect(cue.identifier).to eq("1")
    expect(cue.start).to eq("00:00:00.000")
    expect(cue.end).to eq("00:00:03.000")
    expect(cue.settings).to eq("D:vertical A:start")
    expect(cue.text).to eq("I grew up in Eastern North Carolina, <b>Edgecombe</b> County")
  end
end
