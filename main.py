import flet as ft
import os

questions = [
    "Яку останню книгу ви читали?",
    "Якого жанру вона була?",
    "Хто її автор?",
    "Чи прочитав би ти її ще раз?",
    "Чи порадиш ти прочитати її ще комусь?"
]

def main(page: ft.Page):
    page.title = "Форма опитування"
    page.vertical_alignment = ft.MainAxisAlignment.CENTER
    page.horizontal_alignment = ft.CrossAxisAlignment.CENTER

    current_question = 0

    question_text = ft.Text(
        questions[current_question],
        size=20,
        weight=ft.FontWeight.BOLD,
        text_align=ft.TextAlign.CENTER
    )

    answer_input = ft.TextField(
        hint_text="Введіть відповідь...",
        width=400
    )

    answers_file = os.path.join("Media", "answers.txt")

    def save_answer(e):
        nonlocal current_question

        answer = (answer_input.value or "").strip()
        if not answer:
            return

        os.makedirs("Media", exist_ok=True)

        with open(answers_file, "a", encoding="utf-8") as f:
            f.write(f"{questions[current_question]} {answer}\n")

        answer_input.value = ""
        current_question += 1

        if current_question < len(questions):
            question_text.value = questions[current_question]
        else:
            question_text.value = "Опитування завершено!"
            answer_input.disabled = True
            next_button.disabled = True

        page.update()

    next_button = ft.ElevatedButton("Далі", on_click=save_answer)

    page.add(
        ft.Column(
            [
                question_text,
                answer_input,
                next_button
            ],
            alignment=ft.MainAxisAlignment.CENTER,
            horizontal_alignment=ft.CrossAxisAlignment.CENTER
        )
    )

ft.app(target=main)