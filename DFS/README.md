# Listing all the folders in a folder
This script lists all the folders in a main folder using the [Depth First Search](https://www.hackerearth.com/practice/algorithms/graphs/depth-first-search/tutorial/)

## Test
to test this algorithm: 

```
mkdir -p root/{a/{a1,a2/{a21,a22,a23},a3/{a31,a32}},b/b1/{b21,b22},c/{c1,c2},d}
```
Tha command above will create the following tree:

```
root
├── a
│   ├── a1
│   ├── a2
│   │   ├── a21
│   │   ├── a22
│   │   └── a23
│   └── a3
│       ├── a31
│       └── a32
├── b
│   └── b1
│       ├── b21
│       └── b22
├── c
│   ├── c1
│   └── c2
└── d
```
Now place the script dfs.sh and run it

```
chmod +x dfs.sh
./dfs.sh
```

The output should be:

```
==> treating /home/yassine/root
	--> The stack now contains /home/yassine/root
==> treating a
	--> The stack now contains /home/yassine/root /home/yassine/root/a
==> treating a1
	--> The stack now contains /home/yassine/root /home/yassine/root/a /home/yassine/root/a/a1
	 --> cannot go further! unstacking /home/yassine/root/a/a1
==> treating a2
	--> The stack now contains /home/yassine/root /home/yassine/root/a /home/yassine/root/a/a2
==> treating a21
	--> The stack now contains /home/yassine/root /home/yassine/root/a /home/yassine/root/a/a2 /home/yassine/root/a/a2/a21
	 --> cannot go further! unstacking /home/yassine/root/a/a2/a21
==> treating a22
	--> The stack now contains /home/yassine/root /home/yassine/root/a /home/yassine/root/a/a2 /home/yassine/root/a/a2/a22
	 --> cannot go further! unstacking /home/yassine/root/a/a2/a22
==> treating a23
	--> The stack now contains /home/yassine/root /home/yassine/root/a /home/yassine/root/a/a2 /home/yassine/root/a/a2/a23
	 --> cannot go further! unstacking /home/yassine/root/a/a2/a23
	 --> cannot go further! unstacking /home/yassine/root/a/a2
==> treating a3
	--> The stack now contains /home/yassine/root /home/yassine/root/a /home/yassine/root/a/a3
==> treating a31
	--> The stack now contains /home/yassine/root /home/yassine/root/a /home/yassine/root/a/a3 /home/yassine/root/a/a3/a31
	 --> cannot go further! unstacking /home/yassine/root/a/a3/a31
==> treating a32
	--> The stack now contains /home/yassine/root /home/yassine/root/a /home/yassine/root/a/a3 /home/yassine/root/a/a3/a32
	 --> cannot go further! unstacking /home/yassine/root/a/a3/a32
	 --> cannot go further! unstacking /home/yassine/root/a/a3
	 --> cannot go further! unstacking /home/yassine/root/a
==> treating b
	--> The stack now contains /home/yassine/root /home/yassine/root/b
==> treating b1
	--> The stack now contains /home/yassine/root /home/yassine/root/b /home/yassine/root/b/b1
==> treating b21
	--> The stack now contains /home/yassine/root /home/yassine/root/b /home/yassine/root/b/b1 /home/yassine/root/b/b1/b21
	 --> cannot go further! unstacking /home/yassine/root/b/b1/b21
==> treating b22
	--> The stack now contains /home/yassine/root /home/yassine/root/b /home/yassine/root/b/b1 /home/yassine/root/b/b1/b22
	 --> cannot go further! unstacking /home/yassine/root/b/b1/b22
	 --> cannot go further! unstacking /home/yassine/root/b/b1
	 --> cannot go further! unstacking /home/yassine/root/b
==> treating c
	--> The stack now contains /home/yassine/root /home/yassine/root/c
==> treating c1
	--> The stack now contains /home/yassine/root /home/yassine/root/c /home/yassine/root/c/c1
	 --> cannot go further! unstacking /home/yassine/root/c/c1
==> treating c2
	--> The stack now contains /home/yassine/root /home/yassine/root/c /home/yassine/root/c/c2
	 --> cannot go further! unstacking /home/yassine/root/c/c2
	 --> cannot go further! unstacking /home/yassine/root/c
==> treating d
	--> The stack now contains /home/yassine/root /home/yassine/root/d
	 --> cannot go further! unstacking /home/yassine/root/d
	 --> cannot go further! unstacking /home/yassine/root
done

```
## Used programming languages
 
  * bash

## Authors

* **Yassine Fadhlaoui** - *Initial work* - [Yassine Fadhlaoui](https://github.com/YassineFadhlaoui)

