# pacman-vs-jekyll
Convert your Opendylan's pacman catalog to a Jekyll website

## Usage

```
pacman-vs-jekyll
```

If used without parameters it will create a directory called
`pacman-catalog-website` in the working directory. The program will
populate the directory with a Jekyll website listing all packages in
the catalog.

```
pacman-vs-jekyll -h
```

to see the usage

## Install

1. Clone the repository

```
git clone https://github.com/fraya/pacman-vs-jekyll
```

2. Enter the repository directory

```
cd pacman-vs-jekyll
```

3. Update the project dependencies


```
dylan update
```

4. Build

```
dylan build --all
```