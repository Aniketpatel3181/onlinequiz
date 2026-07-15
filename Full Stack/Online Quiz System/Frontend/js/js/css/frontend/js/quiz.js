const quizId = 1;

let questions = [];

let currentQuestion = 0;

let answers = {};

let duration = 0;

let timer;

async function loadQuiz() {

    const token = localStorage.getItem("token");

    const response = await fetch(
        `http://localhost:5000/api/quizzes/${quizId}`,
        {
            headers: {
                Authorization: "Bearer " + token
            }
        }
    );

    const data = await response.json();

    questions = data.questions;

    duration = data.duration * 60;

    displayQuestion();

    startTimer();
}

function displayQuestion() {

    const q = questions[currentQuestion];

    document.getElementById("questionNumber").innerHTML =
        `Question ${currentQuestion + 1} of ${questions.length}`;

    document.getElementById("question").innerHTML = q.question;

    const options = document.getElementById("options");

    options.innerHTML = "";

    q.options.forEach(option => {

        options.innerHTML += `
        <label class="option">

            <input
                type="radio"
                name="answer"
                value="${option.id}"
                ${answers[q.id] == option.id ? "checked" : ""}>

            ${option.option_text}

        </label>
        `;

    });

    document
        .querySelectorAll('input[name="answer"]')
        .forEach(radio => {

            radio.addEventListener("change", () => {

                answers[q.id] = Number(radio.value);

            });

        });

}







document.getElementById("nextBtn").onclick = () => {

    if (currentQuestion < questions.length - 1) {

        currentQuestion++;

        displayQuestion();

    }

};

document.getElementById("prevBtn").onclick = () => {

    if (currentQuestion > 0) {

        currentQuestion--;

        displayQuestion();

    }

};

function startTimer() {

    timer = setInterval(() => {

        duration--;

        let min = Math.floor(duration / 60);

        let sec = duration % 60;

        document.getElementById("timer").innerHTML =
            `${String(min).padStart(2,"0")}:${String(sec).padStart(2,"0")}`;

        if(duration <= 0){

            clearInterval(timer);

            submitQuiz();

        }

    },1000);

}