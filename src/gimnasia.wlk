class Rutina {
    method descanso(tiempo)
    method intensidad()

    method caloriasQuemadas(tiempo) {
        return 100 * (tiempo - self.descanso(tiempo)) * self.intensidad() 
    }
}
class Running inherits Rutina {
    const intensidad

    override method intensidad() {
        return intensidad
    }

    override method descanso(tiempo) {
        return if (tiempo > 20) {
                5
        } else {
                2
        }
    }
}
class Maraton inherits Running() {

    override method caloriasQuemadas(tiempo) {
        return super(tiempo) * 2
    }   
}
class Remo inherits Rutina() {

    override method intensidad() {
        return 1.3
    }

    override method descanso(tiempo) {
        return tiempo/5
    }
    
}
class RemoDeCompeticion inherits Remo() {

    override method intensidad() {
        return 1.7
    }

    override method descanso(tiempo) {
        return 2.max(super(tiempo)-3)
    }
}

class Persona {
    var property peso

    method kilosPorCaloríaQuePierde()
    method tiempo()
    
    method pesoPerdidoAlHacer(rutina) {
        return self.caloriasQuemadasSiHace(rutina) / self.kilosPorCaloríaQuePierde()
    }

    method caloriasQuemadasSiHace(rutina) {
        return rutina.caloriasQuemadas(self.tiempo())
    }

    method hacerRutina(rutina) {
        self.validarHacerRutina(rutina)
        peso -= self.pesoPerdidoAlHacer(rutina)
    }

    method validarHacerRutina(rutina) {
        if (not self.puedeHacerRutina(rutina)) {
            self.error("No puede hacer rutina.")
        }
    }

    method puedeHacerRutina(rutina)
}

class Sedentaria inherits Persona() {
    const property tiempo

    override method kilosPorCaloríaQuePierde() {
        return 7000
    }

    override method puedeHacerRutina(rutina) {
        return self.peso() > self.pesoMinimoParaHacerUnaRutina()
    }

    method pesoMinimoParaHacerUnaRutina() {
        return 50
    } 
}

class Atleta inherits Persona() {

    override method pesoPerdidoAlHacer(rutina) {
        return super(rutina) - 1
    }

    override method kilosPorCaloríaQuePierde() {
        return 8000
    }

    override method tiempo() {
        return 90
    }

    override method puedeHacerRutina(rutina) {
        return rutina.caloriasQuemadas(self.tiempo()) > self.caloriasQuemadasMinParaHacerUnaRutina()
    }

    method caloriasQuemadasMinParaHacerUnaRutina() {
        return 10000
    } 
}
   
class Club {
    const predios = #{} 

    method mejorPredioPara(persona) {
        return predios.max({
            predio => predio.caloriasQuemadasSiHaceTodo(persona)
        })
    }

    method prediosTranquis(persona) {
        return predios.filter({
            predio => predio.alMenosUnaRutinaDeMenosDe500Cals(persona)
        })
    }

    method rutinasMasExigentes(persona) {
        return predios.map({
            predio => predio.laQueMasCaloriasQuemaPara(persona)
        }).asSet()
    }


}

class Predio {
    const property rutinas = #{} 

    method caloriasQuemadasSiHaceTodo(persona) {
        return rutinas.sum({
            rutina => persona.caloriasQuemadasSiHace(rutina) 
        })
    }

    method alMenosUnaRutinaDeMenosDe500Cals(persona) {
        return rutinas.any({
            rutina => persona.caloriasQuemadasSiHace(rutina) < self.caloriasParaSerTranqui()
        })
    }

    method caloriasParaSerTranqui() {
        return 500
    }

    method laQueMasCaloriasQuemaPara(persona) {
        return rutinas.max({
            rutina => persona.caloriasQuemadasSiHace(rutina)
        })
    }
}