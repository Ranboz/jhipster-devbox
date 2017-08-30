# Modified from - JHipster official "development box"

(I won't repeat the details - please see the "forked from" link above.

## Changed
+ Ubuntu Desktop
+ Eclipse-JEE
+ Google Chrome installed
+ Speed up package downloads with an APT Cache server(See "Optional" Below).
- Not Guake
- Not IntelliJ


## Manual installation

This generates a new "development box" directly from this repository.

- Clone this repository: `git clone https://github.com/Ranboz/jhipster-devbox`
- Run `vagrant up`

## Optional - APT CACHE
If doing multiple vagrant builds, using a apt cache VM will GREATLY speed your builds.  
- To try, prior to creating the devbox, clone from: 
  - 'git https://github.com/Ranboz/apt-cache-vagrant' 
  - Or, use the most excellent original repo: 'git https://github.com/rgl/apt-cache-vagrant'.
- and then 'Vagrant up cache'
- Prior to generating the devbox, edit the'jhipster-devbox/scripts/setup.sh' file and uncomment where indicated: 

## Login 
using the `vagrant`,Password is `vagrant`
