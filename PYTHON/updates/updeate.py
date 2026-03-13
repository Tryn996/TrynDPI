from lastversion import lastversion
import sys

vers = "v" + str(lastversion.latest("Tryn996/TrynDPI"))
with open("vers.txt", "w", encoding="utf-8") as file:
    file.write(vers)


def check_args():
    # Получаем все аргументы, кроме имени файла
    arguments = sys.argv[1:]

    if "--admin" in arguments:
        print("Запуск в режиме администратора")

    if len(arguments) > 0:
        print(f"Передано аргументов: {len(arguments)}")
        for i, arg in enumerate(arguments, 1):
            print(f"Аргумент {i}: {arg}")
    else:
        print("Аргументы не переданы")
