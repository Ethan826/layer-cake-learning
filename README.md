# Layer Cake Pattern Exploration

This project is a work-in-progress as I learn about and experiment with the
**Layer Cake** pattern for structuring Haskell applications. The **Layer Cake**
architecture emphasizes breaking an application into three distinct layers, each
responsible for different concerns: the orchestration layer, the capability
layer, and the business logic layer. The goal is to handle effects and
side-effects in an organized and modular way, while keeping the core business
logic as pure and testable as possible.

## Project Structure

I've split the project into separate layers following the Layer Cake approach:

- **Layer 1**: Orchestration layer (handles environment setup and running the
  app) - `AppEnv.hs`: Sets up the application's environment, managing file
  paths, and external dependencies like file systems and JSON parsing.
- **Layer 2**: Capabilities (defines interfaces and interactions with the outside world)
  - `Capabilities.hs`: Defines the interfaces (type classes) for the file
    system, JSON parser, and other services the application might need.
  - `Effects.hs`: Implements the actual effects for file system operations and
    JSON parsing.
- **Layer 3**: Business Logic (pure logic with no side effects)
  - `AppLogic.hs`: Contains the core application logic, which processes data and
    generates the final output.
  - `BusinessLogic.hs`: Defines functions that contain the pure business logic
    (e.g., generating summaries).
  - `Types.hs`: Defines the data types used across the application.

## Learning Journey

This project is part of my ongoing exploration of the **Layer Cake** pattern.
I'm still learning the ins and outs of this approach, and I don't claim to have
it fully right just yet. It’s a work-in-progress, and I’m open to feedback and
improvement as I go!

## Resources

Here are some resources I'm drawing from as I learn:

- [Matt Parson’s blog post on the Layer Cake
  Pattern](https://www.parsonsmatt.org/2018/03/22/three_layer_haskell_cake.html):
  This article explains the three-layer architecture in Haskell and gives
  examples of how to structure an application using this pattern.
- [FP Complete’s article on the ReaderT
  Pattern](https://www.fpcomplete.com/blog/2017/06/readert-design-pattern/):
  This article covers the **ReaderT** pattern, which is often used to manage
  environment access and is a key part of the orchestration layer in the Layer
  Cake approach.

## Next Steps

I plan to refine this structure and continue learning how to effectively apply
the Layer Cake pattern in real-world Haskell projects. Contributions and
suggestions are welcome!
