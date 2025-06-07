export default function getCalender() {
  const date = new Date()
  const currentMonth = (date.getMonth() + 1) % 12
  return [
    calcLastMonth(currentMonth, 2),
    calcLastMonth(currentMonth, 1),
    currentMonth,
    calcNextMonth(currentMonth, 1),
    calcNextMonth(currentMonth, 2),
    calcNextMonth(currentMonth, 3)
  ].map(val => addZero(val))
}

function calcLastMonth(currentMonth: number, num: number) {
  return (currentMonth - num + 12) % 12
}

function calcNextMonth(currentMonth: number, num: number) {
  return (currentMonth + num) % 12
}

function addZero(val: number): string {
  return val < 10 ? '0' + val : val.toString()
}