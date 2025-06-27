# ruby-chess

## Description
A two-player command-line chess game in Ruby, with RSpec tests.

## Installation
You need Ruby and Bundler.

```
git clone https://github.com/4R1u/ruby-chess.git
cd ruby-chess
bundle install
```

## Running

Run the `main.rb` file

```
ruby lib/main.rb
```

## Usage

Once you've launched the project, enter moves in [chess notation](https://en.wikipedia.org/wiki/Chess_notation).
One thing to note is that I haven't implemented `++` or `#` for checkmate, the game will detect a game over condition automatically.

The game also declares check automatically, and prohibits illegal moves or those that put you into check.

## Shortcomings

This project was part of The Odin Project, but I skipped some features because the project was dragging on for too long:

 - Serialization(save/load), a core requirement
 - A nicer interface
 - Single-player mode
