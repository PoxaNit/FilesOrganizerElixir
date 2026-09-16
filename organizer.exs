defmodule Organizer do

    def remove_file(file, directory) do

	path = Path.join directory, file

	File.rm path

    end


    def copy_file(src, dest) do

	File.copy src, dest

    end


    def create_directory(path) do

	# create directory if not exists

	if !File.exists?(path), do: File.mkdir path

	path

    end


    def create_directory(directory, file_ext) do

	case file_ext do

	    ".txt" -> create_directory Path.join(directory, "txts")

	    ".pdf" -> create_directory Path.join(directory, "documents")

	    ".jpg" -> create_directory Path.join(directory, "images")

	    _ -> nil

	end

    end


    def organize(directory, files, index) do

	file = Enum.at files, index

	if file != nil do

	    extension = Path.extname file

	    dir = create_directory directory, extension

	    if dir != nil do

		srcPath = Path.join directory, file

		destPath = Path.join dir, file

		copy_file srcPath, destPath

		remove_file file, directory


	    end

	    organize directory, files, index + 1

	end

    end

    def run(directory) do

	files = elem(File.ls(directory), 1)

	organize directory, files, 0

    end

end

directory = Enum.at System.argv(), 0

Organizer.run directory
