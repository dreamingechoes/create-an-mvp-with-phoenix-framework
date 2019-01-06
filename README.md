# Create An MVP With Phoenix Framework

<p align="center"><img src="./files/images/logo.png"></p>

## About

This repository is the base for a workshop about how to create an [MVP](https://en.wikipedia.org/wiki/Minimum_viable_product) with [Elixir](https://elixir-lang.org/) and [Phoenix Framework](https://phoenixframework.org/). In this workshop, we're going to tackle the development of a product idea, setting our development environment, seeing the structure of a regular [Phoenix](https://phoenixframework.org/) application, modeling the business logic, building the web and shipping the final result to production.

You can check the slides for this workshop [here](./files/slides/Create.an.mvp.with.phoenix.framework.pdf).

## Contents

- [The Idea](#the-idea)
- [Environment Setup](#environment-setup)
  - [Natively](#natively)
  - [Version Manager](#version-manager)
  - [Docker](#docker)
- [Final Product](#final-product)

## The Idea

The product we want to create will be a simple application which with we can sync all our notes in the cloud. For the **MVP**, we just need to store the **user’s information**, a series of **blocknotes** created by the user, and the **notes** which belongs to the **blocknotes**. The models diagram will look pretty simple, something like this:

<p align="center"><img src="./files/images/schemas.png"></p>

So once we have defined the product we're going to develop, and with the data modeling done, the first step we need to do is to setup our development environment.

## Environment Setup

We'll need to install the following dependencies:

* [Erlang](https://www.erlang.org/): a programming language used to build **massively scalable soft real-time systems** with requirements on **high availability**. Some of its uses are in **telecoms**, **banking**, **e-commerce**, **computer telephony** and **instant messaging**. Erlang's runtime system has built-in support for **concurrency**, **distribution** and **fault tolerance**.
* [Elixir](https://elixir-lang.org/): a dynamic, **functional language** designed for building **scalable and maintainable** applications. **Elixir** leverages the **Erlang VM**, known for running low-latency, distributed and fault-tolerant systems, while also being successfully used in web development and the embedded software domain.
* [Phoenix Framework](https://phoenixframework.org/): a productive web framework that **does not compromise speed and maintainability**.
* [Node.js](https://nodejs.org/): asynchronous event driven **JavaScript** runtime, designed to build **scalable network applications**.
* [PostgreSQL](https://www.postgresql.org/): a **powerful**, open source **object-relational database system** with over 30 years of active development that has earned it a strong reputation for **reliability**, **feature robustness**, and **performance**.

There're three main ways to install all this stuff: **by instaling all natively**, using a **version manager** to install it in our machine, or creating an isolated **Docker container** with all the dependencies.

### Natively

The first way to have all these dependencies ready is by installing directly in your machine natively. Here you have all the documentation resources so you can check the instructions for your operative system:

* **Erlang**: [installation guide](https://rlang.org/doc/installation_guide/INSTALL.html).
* **Elixir**: [installation guide](https://elixir-lang.org/install.html).
* **Phoenix Framework**: [installation guide](https://hexdocs.pm/phoenix/installation.html).
* **Node.js**: [installation guide](https://nodejs.org/en/download/package-manager).
* **PostgreSQL**: [installation guide](https://postgresql.org/docs/current/static/tutorial-install.html).

### Version Manager

If you need to deal with multiple versions of these dependencies, the best option is to install them with a **version manager**. If you are into [Ruby on Rails](https://rubyonrails.org/), probably you have used [rvm](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv). In this case, we need a version manager capable to handle not only one technology but multiple ones. Here it's when [asdf](https://github.com/asdf-vm/asdf) comes to help us.

[asdf](https://github.com/asdf-vm/asdf) is an extendable version manager with support for Ruby, Node.js, Elixir, Erlang & more. The setup's quite easy, just follow the steps [specified in its setup process](https://github.com/asdf-vm/asdf#setup). In order to be able to install all our dependencies, we need a plugin for each one. Here you have the list of plugins so you can follow the setup instructions:

* **Erlang**: [asdf-erlang](https://github.com/asdf-vm/asdf-erlang).
* **Elixir**: [asdf-elixir](https://github.com/asdf-vm/asdf-elixir).
* **Node.js**: [asdf-nodejs](https://github.com/asdf-vm/asdf-nodejs).
* **PostgreSQL**: [asdf-postgres](https://github.com/smashedtoatoms/asdf-postgres).

It's the **best option** for setup all natively.

### Docker

We can **recreate the setup of our servers** to have a development environment in the **same conditions as the production one**. The key files to achieve this are `Dockerfile` and `docker-compose.yml`. First you have to install **Docker** first (following the instructions provided [here](https://docs.docker.com/install)), so you can start to config your project.

You can check the [official documentation](https://docs.docker.com/) in order to see in detail how **Docker** works, but you can check some examples files to dockerize a [Phoenix](https://phoenixframework.org/) application I made some time ago [here](https://github.com/dreamingechoes/docker-elixir-phoenix).

## Final Product

You can check the final result for our **MVP** [here](./nevernote).

----------------------------

This project was developed by [dreamingechoes](https://github.com/dreamingechoes).
It adheres to its [code of conduct](https://github.com/dreamingechoes/base/blob/master/files/CODE_OF_CONDUCT.md) and
[contributing guidelines](https://github.com/dreamingechoes/base/blob/master/files/CONTRIBUTING.md), and uses an equivalent [license](https://github.com/dreamingechoes/base/blob/master/files/LICENSE).
