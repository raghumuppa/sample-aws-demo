# Junior hacker training

Welcome! You are a junior hacker, who only recently entered the top-secret school of a legendary master hacker, preceded by incredible legends. Today is your first day of field training, and the master will take you to one of his favorite workplaces -- a crowded urban settlement. What makes such a common place really special? A lot of people without the knowledge of information security basics, with dozens of unsecured routers and default passwords, which invite you to visit their local networks.

You are in a car at the urban settlement parking lot. The master brought his laptop with Kali Linux that, together with his advice, you can use in today's outdoor training. The main goal of today's training is simple: to steal anything that can be valuable.

## Disclaimer

This game is for educational purposes only. Unauthorized use of the tools that are incorporated into the game is illegal. The story is fictitious.

## Level 1: Getting to know the environment

**Objective** (*visible only to the designer, never to the player*):

Get acquainted with Kali Linux and the content of $HOME directory (/root).

---
---

**Task assignment** (*visible to the player*):

The master handed you a laptop, saying to you:
"You studied hard in the past weeks. Now, you are ready for real-world hacking training, but you need the right equipment. In today's lecture, I will teach you using Kali Linux and show you some of its basic functionality, which will make hacking easier."

First, get acquainted with the **command line** at your Kali Linux, the most popular Linux distribution for penetration testing. Or hacking? :-)  

Log in as the user `root` with the password `toor`. Open Terminal (Terminal Emulator in the main menu) and look around your home directory `/root`. You will need this skill when you hack into another Linux machine."

The flag for this level is the name of the single file stored in a non-empty directory in your home directory.

**Hints** (*visible to the player if requested*):

Hint 1 (What tool to use to list directories and files?): Use `ls`. If you want to change the directory, use `cd`. Your home folder is located in `/root` directory.

**Solution**

```
root@attacker:~# ls /root/hacking
wordlist.txt
```

**Flag value** (*visible to the player if (s)he solves the level*):

wordlist.txt

---
---

**Estimated duration** (*visible only to the designer, never to the player*):

3 minutes

**Learning outcomes** (*visible only to the designer, never to the player*):

The player learns to orient in Kali Linux, open terminal a navigate through file system.

**Notes for adaptivity** (*visible only to the designer, never to the player*):

Phases and variants:
- 1.1 = Task assignment (familiar with Linux command line)
- 1.2 = Task assignment + Hint 1 (not familiar with Linux command line)
- 1.3 (default) = Task assignment + Hint 1 + Solution

This level is the prerequisite for levels 4 and 5.

Some players may not use Terminal in Kali GUI and navigate to the directory using GUI.
It can be found out by not seeing any `ls` commands in the logs.

Pre-game assessment: Linux command line (shell)

## Level 2: Looking for server’s IP address

**Objective** (*visible only to the designer, never to the player*):

Scan the IP addresses, discover the server's IP address and running services.

---
---

**Task assignment** (*visible to the player*):

You already managed to guess the password on a Wi-Fi router with the master's help (12345678, really?!), so now you are already connected to the local network of one household.

The address space of your local network is 10.10.20.0/24.

The master told you that your goal is to gain access to the server. Scan the network and recognize the server's IP address. You can recognize the server by its running services.
The server you are searching for has more open ports than other machines in the network.

The flag is the port number on which the file sharing service is running on the server's machine.

**Hints** (*visible to the player if requested*):

Hint 1 (What tool to use?): Use the command-line tool `nmap`. If you can't figure out how to use the tool, call it with the suffix `--help` to get detailed instructions, consult its manual page `man nmap`, or use your favourite search engine.

Hint 2 (How to use the tool?): Run `nmap 10.10.20.0/24` and see open ports in its output. **Nmap scan report for 10.10.20.9** shows the most running services.

**Solution** (*visible to the player if requested*):

```
root@attacker:~# nmap 10.10.20.0/24
```

```
2049/tcp open  nfs
```
```
2049
```

**Flag value** (*visible to the player if (s)he solves the level*):

2049

---
---

**Estimated duration** (*visible only to the designer, never to the player*):

5 minutes

**Learning outcomes** (*visible only to the designer, never to the player*):

The player learns/practice to use nmap tool.

**Notes for adaptivity** (*visible only to the designer, never to the player*):

TODO sandbox definition: hide all machines but Kali in the network topology

Phases and variants:
- 2.1 = Task assignment (familiar with nmap)
- 2.2 = Task assignment + Hint 1 (not familiar with nmap)
- 2.3 (default) = Task assignment + Hint 1 + Hint 2 + Solution

This level is the prerequisite for no further level.

Pre-game assessment: nmap


## Level 3: Connect to the server

**Objective** (*visible only to the designer, never to the player*):

Connect to the server via SSH.

---
---

**Task assignment** (*visible to the player*):

You know the IP address of the server. It was easy, right?

Now comes the more interesting part of how to use this knowledge to your advantage. Connect remotely to the server and use legitimate credentials. The master told you that the login details will most likely one of these: admin/password, admin/123456 or admin/admin. It's worth trying, isn't it?

The flag is the entire command for logging into the server.

**Hints** (*visible to the player if requested*):

Hint 1 (What connection method to use?): Use the command-line tool `ssh`.

Hint 2 (What is the syntax for entering the SSH command?): The syntax is `ssh username@hostname_or_ip`, where the part after `@` is the hostname or IP address of the device you want to connect to.

Hint 3 (What password to use?): Try one of the master's recommendations.

**Solution** (*visible to the player if requested*):

```
root@attacker:~# ssh admin@10.10.20.9
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
admin@10.10.20.9's password: admin
```

**Flag value** (*visible to the player if (s)he solves the level*):

ssh admin@10.10.20.9

---
---

**Estimated duration** (*visible only to the designer, never to the player*):

5 minutes

**Learning outcomes** (*visible only to the designer, never to the player*):

Player learns how to log in remotely using SSH.

**Notes for adaptivity** (*visible only to the designer, never to the player*):

Phases and variants:
- 3.1 = Task assignment (familiar with ssh)
- 3.2 = Task assignment + Hint 1 + Hint 2 (not familiar with ssh)
- 3.3 (default) = Task assignment + Hint 1 + Hint 2 + Hint 3 + Solution

This level is the prerequisite for level 4.

Pre-game assessment: ssh

## Level 4: Find interesting files

**Objective** (*visible only to the designer, never to the player*):

Became familiar with Linux file system and move the hidden ZIP file using SCP.

---
---

**Task assignment** (*visible to the player*):

You are already logged in to the server. Now is the time to find something exciting and ideally compromising, but we don't know exactly what we are looking for. However... do you still remember the list of services running on the server based on the Nmap scan? You already discovered that the server runs the NFS service. NFS protocol is used for file sharing and remote access to files over a computer network. Maybe this server is used to back up data. Try to look whether the admin's home directory stores any files. Then, copy a useful file to your attacker machine.

The flag is the name of the only ZIP file (including the extension) located somewhere the home directory.

**Hints** (*visible to the player if requested*):

Hint 1 (Where to look for the files?): List directories and files **including the hidden ones** in the admin's $HOME directory (`/home/admin`).

Hint 2 (How to copy the ZIP files?): Use `scp` tool to copy the file.

Hint 3 (What is the syntax for SCP?): Use this syntax for copying from remote to local machine:
scp <user>@<host>:<source path on remote machine> <destination on local machine>/

**Solution** (*visible to the player if requested*):

```
root@attacker:/home# scp admin@10.10.20.9:~/personal/.invoices2019.zip .
admin@10.10.20.9's password: admin
```

**Flag value** (*visible to the player if (s)he solves the level*):

.invoices2019.zip

---
---

**Estimated duration** (*visible only to the designer, never to the player*):

5 minutes

**Learning outcomes** (*visible only to the designer, never to the player*):

Player learns to orient in the Linux file system, find a hidden file and copy it using SSH.

**Notes for adaptivity** (*visible only to the designer, never to the player*):

Phases and variants:
- 4.1 = Task assignment (familiar with SSH and Linux)
- 4.2 = Task assignment + Hint 2 + Hint 3 (familiar with Linux commands, but not ssh/scp)
- 4.3 (default) = Task assignment + Hint 1 + Hint 2 + Hint 3 + Solution

This level is the prerequisite for no further level.

Pre-game assessment: ssh

## Level 5: Crack the password to the zip

**Objective** (*visible only to the designer, never to the player*):

Crack the zip's password using the fcrackzip tool.

---
---

**Task assignment** (*visible to the player*):

You have found out that some accounting company's files have been uploaded to this server. And you have a ZIP file with a promising name in your hands, but unfortunately, it is password-protected!

The master advised you that a password cracking tool called `fcrackzip` was installed on his Kali machine. Find out how you could break the password and reveal the content of the ZIP. Use `man fcrackzip` rather than `fcrackzip -h` for instructions on the tool usage.

The flag is the password to the ZIP.

**Hints** (*visible to the player if requested*):

Hint 1 (How to use the Fcrackzip tool?): You can perform a dictionary attack by using `-D` option of the `fcrackzip` command, but be aware that you have to use a wordlist. One is stored somewhere at your attacker machine.

Hint 2 (Where is the wordlist stored?): In `hacking` directory at you Kali, where you have already discover it.

**Solution** (*visible to the player if requested*):

```
root@attacker:~# fcrackzip -D -u -p /root/hacking/wordlist.txt .invoices2019.zip

PASSWORD FOUND!!!!: pw == IhateMyJob

root@attacker:/home# unzip .invoices2019.zip

Archive:  .invoices2019.zip
   creating: .invoices2019/
[.invoices2019.zip] invoices2019/TAX15796252.txt password: IhateMyJob
```

**Flag value** (*visible to the player if (s)he solves the level*):

IhateMyJob

---
---

**Estimated duration** (*visible only to the designer, never to the player*):

10 minutes

**Learning outcomes** (*visible only to the designer, never to the player*):

Player learns to crack a ZIP's password.

**Notes for adaptivity** (*visible only to the designer, never to the player*):

Phases and variants:
- 5.1 = Task assignment (familiar with Linux command line)
- 5.2 = Task assignment + Hint 2 (not familiar with Linux command line)
- 5.3 (default) = Task assignment + Hint 1 + Hint 2 + Solution

This level is the prerequisite for no further level.

Pre-game assessment: Linux command line

TODO add a nice photo to the encrypted zip to provide some fun for players
