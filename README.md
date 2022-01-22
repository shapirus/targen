# NAME

targen - create customizable shooting targets

# DESCRIPTION

This software produces vector images of customizable shooting targets. Output format is SVG.
The elements of the target can be scaled relative to the desired shooting distance by using
angle-based units (minute of angle and milliradian) or set to an absolute length.

Supported units of distance: mm, cm, m, km, in, ft, yd, mi; will assume mm if not specified.

Supported angle units: moa, mil. One mil is defined as distance / 1000.

Not all options support both the linear and angular units. See the option descriptions for details.

Supported color definitions: everything that is allowed by the SVG format specification, e.g.,
black, red, white, #rrggbb notation.
100% transparency can be set using a special color keyword "none".

# SYNOPSIS

    targen [options]

Options (values listed are used as defaults, abbreviated options are allowed as per [Getopt::Long](https://metacpan.org/pod/Getopt%3A%3ALong)):

    --help
      Print usage information.

    --output=
      Output file name, write to stdout by default.

    --page=210mm,297mm
      Page dimensions: <width>,<height>. Defaults to A4 in portrait orientation.
      Swap width and height dimensions to toggle between portrait and landscape.

    --page-margin=10mm
      Page margin, will be the same on all edges.

    --background=white
      Page background color, including margins.

    --layout=1,1
      Number of rows and columns to draw the targets in.

    --target-separator=0[,<color>]
      Target separator line width and color.
      Default for multi-target layouts: --target-separator=3.5mm,none.
      Angle units are allowed.

    --grid=1moa
      Grid major division step. A multiple of the scope turret's click value
      will be a natural choice when making zeroing-in targets.
      Set to zero to disable grid.
      Angle units are allowed.

    --grid-minor=2
      Minor grid divisions per each major division.

    --grid-line=0.4mm,#101010
      Line width and color for the major grid lines.

    --grid-line-minor=0.2mm,#181818
      Line width and color for the minor grid lines.

    --distance=50m
      Shooting distance. Used to calculate the absolute length of moa and mil.

    --circles=1moa[,1.5moa,...]
      Diameters of the concentric circles placed at the center of the target,
      starting with the innermost circle.
      Default: draw one 1 MOA circle. Use --circles=0 to disable.
      Diameters are measured by the outer edge.
      Angle units are allowed.

    --circle-line=1.5mm[,black]
      Line width and color with which the circles are drawn.
      Angle units are allowed.

    --center-fill=grey
      Color to fill the innermost circle with.
      Use "none" to disable.

    --squares=1${grid_unit},2.5${grid_unit}
      Draw four squares at the corners of the square at the center of the target.
      First argument sets the size of the squares, second sets the center offset
      from the center of the target.
      Use --squares=0 to disable. Use a small size like 0.1mm if the squares
      themselves are not desirable, but you still want to draw the lines
      that connect them (see below).
      Angle units are allowed.

    --squares-fill=black
      Color to fill the squares with.

    --connect-squares=2mm[,black]
      Connect the centers of the four squares using the provided line width and color.
      Set to zero to disable.

    --cross=-5mm
      Draw a cross at the center of the target. Positive values set the distance
      from the center to the ends of the lines, negative values set the distance
      from the edge of the target to the ends of the lines.
      Zero disables the cross. If you want it to reach the edges of the target, use
      a very small value like -0.01mm.
      Angle units are allowed.

    --cross-line=2mm[,black]
      Line width and color with which the cross lines are drawn.
      Angle units are allowed.

    --annotation=
      Target annotation (e.g., "1 MOA @50m"). Set to empty to disable.

# EXAMPLES

Create an A4-sized image with a single target for zeroing in at 50 meters with a 1 MOA-based grid
using default options:

    targen --output=1moa@50m.svg

1x1 layout, darker background, red bullseye, convert to pdf on the fly:

    targen -a '1MOA @50m' --page=210mm,297mm --squares=1moa,3moa --center-fill=#750000 \
      -l=1,1 --background=#f8f8f8 -o=1x1-1moa@50m.svg

2x1 layout, landscape orientation:

    targen -a '1MOA @50m' --page=297mm,210mm --squares=0.5moa,2.5moa --center-fill=#750000 \
      -l=2,1 --background=#f8f8f8 --target-separator=3.5,#f5f5f5 -o=2x1-1moa@50m.svg

2x3 layout, tighter element placing:

    targen -a '1MOA @50m' --squares=0.5moa,1.5moa --center-fill=#750000 -l=2,3 \
      --background=#f8f8f8 --target-separator=3.5,#f5f5f5 -o=2x3-1moa@50m.svg

1x1 layout, 1 MOA bullseye (default), 0.5 mil grid, 0.1 mil minor division:

    targen -a '50m, bullseye: 1MOA, grid: 0.5 mil' --grid=0.5mil --grid-line=0.6mm --squares=0.25mil,1mil \
      --grid-minor=5 --center-fill=#750000 -l=1,1 --background=#f8f8f8 -o=1x1-1moa-milgrid-50m.svg

# DEPENDENCIES

Non-base perl modules required to run targen:

[SVG](https://metacpan.org/pod/SVG) (debian: [libsvg-perl](https://packages.debian.org/stable/libsvg-perl))

# HINTS

Use cairosvg (debian: [cairosvg](https://packages.debian.org/stable/cairosvg)) or rsvg-convert (debian: [librsvg2-bin](https://packages.debian.org/stable/librsvg2-bin)) to produce a platform-independent printable lossless vector PDF document:

    targen | cairosvg -f pdf - -o 1moa@50m.pdf

# DEVELOPMENT

Ideas are welcome. Use GitHub issues to tell the author what you think. Pull requests are even more welcome.

Targen is not expected to crash or throw warnings under any conditions. Please submit an issue if you encounter anything unexpected or undocumented.

# REFERENCES

https://github.com/shapirus/targen

# LICENSE

    Copyright (C) 2022  shapirus https://github.com/shapirus/

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
