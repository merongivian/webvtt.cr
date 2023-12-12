module WebVTT
  class Cue
     @identifier : String
     @start : String
     @end : String
     @settings : String
     @text : String

     property :identifier, :start, :end, :settings, :text

     def initialize(*, identifier, text, cue_line)
       @identifier = identifier
       @text       = text
       cue_parts = cue_line.split("-->")
       @start = cue_parts.first.strip
       remaining_cue_parts = cue_parts.last.split(" ").reject(&.empty?)
       @end = remaining_cue_parts.shift.strip
       @settings = remaining_cue_parts.join(" ")
     end
  end
end
