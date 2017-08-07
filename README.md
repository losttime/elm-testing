# elm-testing

Just playing around with elm

## Setup

Must have elm-platform installed on your machine. [Install](https://guide.elm-lang.org/install.html)

1. Clone this repository
2. Run `elm-reactor`

## Architecture

This is what works for now. It's not the way it must be.

- `Main.elm` is where everything starts.
- `Component.elm` is something akin to a "component" that is loaded by `Main.elm`.
- When `Main.elm` loads, it calls into `Component.elm` to get it's model so it can be included in the global model.
- When `Main.elm` renders (`view` function) is renders `Component.elm` by calling its `view` function.
- When anything fires a Message it is handle by the `update` function in `Main.elm`.
- `Main.elm` checks the Messages received in its `update` function and delegates them to `Component.elm` when appropriate.
- `Main.elm` handles any Messages its interested in. Those don't get delegated.

The basic idea is that the Component declares it's own model, view, and update functions, but they're called by the parent. Other public functions could exist on the Component to help in customizing the Component (for guidance, see: https://guide.elm-lang.org/reuse/more.html)
