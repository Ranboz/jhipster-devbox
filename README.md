# Modified from - JHipster official "development box"

(I won't repeat the details - please see the "forked from" link above.

## Changed
+ Ubuntu Desktop
+ Eclipse-JEE
+ Google Chrome installed
+ For multiple installs, May easily be configured with APT Cache to speed up package downloads.  (Comment out at.
- Not Guake
- Not IntelliJ


## Manual installation

This generates a new "development box" directly from this repository.

- Clone this repository: `git clone https://github.com/Ranboz/jhipster-devbox`
- Run `vagrant up`

## Optional
If doing multiple builds, using a repository cache VM will GREATLY speed your builds.  
- To try, prior to creating the devbox, clone this repository: 'git https://github.com/Ranboz/apt-cache-vagrant' and then 'Vagrant up cache'
- Or, use the most excellent original repo: 'git https://github.com/rgl/apt-cache-vagrant'.
- Prior to generating the devbox, edit this file and uncomment where indicated: 

## Login 
using the `vagrant`,Password is `vagrant`
