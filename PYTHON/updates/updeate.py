from lastversion import lastversion

vers = "v" + str(lastversion.latest("Tryn996/TrynDPI"))
with open("vers.txt", "w", encoding="utf-8") as file:
    file.write(vers)
