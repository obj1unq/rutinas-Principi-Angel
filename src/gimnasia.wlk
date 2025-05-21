class Rutina {
    var intensidad = null
    var descanso = null

    method caloriasQuemadas(tiempo) {
        return 100 * (tiempo - descanso) * intensidad
    }
}
class Running inherits Rutina{

    method intensidad(_intensidad) {
        intensidad = _intensidad
    }

    override method caloriasQuemadas(tiempo) {
        return self.calculoCalQuemadas(tiempo)
    }    
    
    method calculoCalQuemadas(tiempo) {
        return if (tiempo > 20) {
                   self.calculoConDescanso(tiempo, 5)
               } else {
                   self.calculoConDescanso(tiempo, 2)
               }
    }

    method calculoConDescanso(tiempo, desc) {
        return 100 * (tiempo - desc) * intensidad
    }
}
class Maraton inherits Running() {
    override method caloriasQuemadas(tiempo) {
        return self.calculoCalQuemadas(tiempo) * self.valorDeIncrementoRespectoDelRunning()
    }        

    method valorDeIncrementoRespectoDelRunning() {
        return 2
    }
}
class Remo inherits Rutina( intensidad = 1.3) {

    override method caloriasQuemadas(tiempo) {
        return 100 * (tiempo - self.descansoSegun(tiempo)) * intensidad
    }

    method descansoSegun(tiempo) {
        return tiempo / self.valorDeDivisionParaCalcularDescanso()
    }

    method valorDeDivisionParaCalcularDescanso() {
        return 5
    }
}
class RemoDeCompeticion inherits Remo( intensidad = 1.7) {
    override method caloriasQuemadas(tiempo) {
        return 100 * (tiempo - self.descanso(tiempo)) * intensidad
    }

    method descanso(tiempo) {
        return if (self.tiempoDescanso(tiempo) == self.tiempoMinimoDeDescanso()) {  
                   self.tiempoMinimoDeDescanso() 
                } else {
                    self.tiempoDescanso(tiempo) - 3
                }
    }

    method tiempoDescanso(tiempo) {
        return self.tiempoMinimoDeDescanso().max(self.descansoSegun(tiempo))
    }

    method tiempoMinimoDeDescanso() {
        return 2
    }
}

