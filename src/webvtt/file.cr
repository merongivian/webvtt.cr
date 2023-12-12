module WebVTT
  class File
    property :file, :cues, :header_lines

    def initialize(input_file : String)
      @file = input_file
      @cues = [] of WebVTT::Cue
      @header_lines = [] of String
      parse
    end

    def parse
      remove_bom
      if !webvtt_line?(file.lines.first)
        return
      end
      in_header = true
      collected_lines = [] of String
      file_lines = file.dup.lines

      file_lines.each_with_index do |line,index|
        line = line.chomp

        if webvtt_line?(line)
          next
        end
        if line.empty?
          # If the line is empty then we can't be in the header anymore.
          if in_header
            in_header = false
          else
            if !collected_lines.empty? && !notes?(collected_lines)
              add_a_cue(collected_lines)
            end
            collected_lines = [] of String
          end
        elsif !line.empty? && file_lines.size == (index + 1) # add our last cue
          collected_lines << line
          add_a_cue(collected_lines)
        elsif in_header
          header_lines << line
        else
          collected_lines << line
        end
      end
    end

    def webvtt_line?(line)
      line[0,6] == "WEBVTT"
    end

    def remove_bom
      @file = file.gsub("\uFEFF", "")
    end

    private def add_a_cue(collected_lines)
      opts = { text: "", identifier: "", cue_line: "" }

      if collected_lines.first.includes?("-->")
        identifier = ""
        cue_line = collected_lines.first
        text = collected_lines[1..-1].join("\n")

        opts = { text: text, identifier: identifier, cue_line: cue_line }
      elsif collected_lines[1].includes?("-->")
        identifier = collected_lines.first
        cue_line = collected_lines[1]
        text = collected_lines[2..-1].join("\n")

        opts = { text: text, identifier: identifier, cue_line: cue_line }
      end

      cues << Cue.new(**opts)
    end

    private def notes?(collected_lines)
      if collected_lines.first.match(/^NOTE/)
        true
      else
        false
      end
    end
  end
end
