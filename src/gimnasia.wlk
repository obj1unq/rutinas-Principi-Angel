class Rutina {
    var intensidad = null // no se tiene que recordar, sino calcular => method 
    var descanso = null

    method caloriasQuemadas(tiempo) {
        return 100 * (tiempo - descanso) * intensidad // definir de donde sale cada cosa, por eso mejor method
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

class Persona {
    var peso = null
    const kgsXCalQuePierde = null
    var tiempoEjercita = null


    method pesoQueSePierdeAlAplicar(rutina) {
        return rutina.caloriasQuemadas(tiempoEjercita) / kgsXCalQuePierde
    }

    method aplicar(rutina) {
        peso -= self.pesoQueSePierdeAlAplicar(rutina)
    }
}

class PersonaSedentaria inherits Persona( kgsXCalQuePierde = 7000) {

    method tiempoEjercita(_tiempoEjercita) {
        tiempoEjercita = _tiempoEjercita
    }

    override method aplicar(rutina) {
        self.validarAplicarRutina()
        peso =- self.pesoQueSePierdeAlAplicar(rutina)
    }

    method validarAplicarRutina() {
        if (not self.tienePesoSuficiente()) {
            self.error("Esta persona no tiene el peso mínimo necesario para hacer la rutina.")
        }
    }

    method tienePesoSuficiente() {
        return peso > self.pesoMinimoParaAplicarRutina()
    }

    method pesoMinimoParaAplicarRutina() {
        return 50
    }
}
