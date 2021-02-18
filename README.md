# ekl

The goal of ekl is to allow you to control an [Elgato](https://elgato.com) 
[Key Light](https://www.elgato.com/en/gaming/key-light) or 
[Key Light Air](https://www.elgato.com/en/gaming/key-light-air) from R.

![](imgs/ekl-demo.gif)

Why would you want to do that, you ask? Because you can. No other reason. 
Though you _could_ use it to flash your Key Light when your machine learning 
model has finished training! ;)

## Installation

You can install ekl from [GitHub](https://github.com/sellorm/ekl) with:

``` r
remotes::install_github("sellorm/ekl")
```

## Setting up

All of the functions in `ekl` take an optional `keylight_ip` parameter.

Instead of supplying this everytime you use it, your life will be much improved 
if you instead set the environment varable `EKL_IP`. I added mine to my local 
`.Renviron` file.

I found the IP address for my light by running `nmap 192.168.0.*` in a terminal 
with the light powered off and then again with it powered on and comparing the 
outputs. Sorry, I can't think of an easier way!

## Usage

Toggle your Key Light on and off:

``` r
ekl::toggle()
```

Get the current state of your Key Light:

``` r
ekl::get_state()
```

Set the state of your Key Light:

``` r
ekl::set_state("on", brightness=50, temperature=178)
```

## Caveats

Brightness is a simple scale from 1-100, but the colour temperature seems to 
run from 143-344 for some reason. 5600 Kelvin, which is considered to be 
"daylight" is about 178.

Maybe at some point in the future I'll work on some conversions so the 
temperature can be expressed in Kelvin instead of this weird scale.

The other big caveat is that I only have a single light to test this with, 
so I have no idea what the behaviour might be with more than 1 light. If anyone 
would like to send me another, please feel free ;)

## License

MIT 2021 Mark Sellors

See LICENSE.md for more info.
