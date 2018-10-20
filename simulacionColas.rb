class Caja
	def initialize()
	@reloj=0
	@estado=0
	end

	def getEstado()
	return @estado
	end 

	def getReloj()
	return @reloj
	end

	def setEstado(x)
	@estado=x
	end

	def setReloj(z)
	@reloj=z
	end

	def restarMinuto()
	@reloj=@reloj-1
	end
end

class Cola
	def initialize()

	@clientesEnCola=0
	end
	def agregarClientes(x)
	@clientesEnCola=@clientesEnCola+x
	end

	def getClientesEnCola()
	return @clientesEnCola
	end
	def restarCliente()
	@clientesEnCola=@clientesEnCola-1
	end
end

class Cliente

	def initialize(id)
	@id=id
	@estado=0
	end

end

def unicaCola( tiempoFinal, numCajas)	

	cont=0
	caja=Array.new
	tiempos=Array.new
	while cont<numCajas do
	caja[cont]=Caja.new()
	cont=cont+1 
	end

	cola=Cola.new()

	cont=0
	cont2=3
	cont4=0


	while cont<tiempoFinal do

		if cont2==3 then
			numClientes=rand(5)
			cola.agregarClientes(numClientes)
			cont2=1
		end

		cont3=0

		while cont3<numCajas do
			if cola.getClientesEnCola>0 && caja[cont3].getEstado==0 then
				caja[cont3].setEstado(1)
				caja[cont3].setReloj(rand(4..25))
				tiempos[cont4]=caja[cont3].getReloj
				cont4=cont4+1
				cola.restarCliente

			elsif caja[cont3].getReloj==1 then
					caja[cont3].setReloj(0)
					caja[cont3].setEstado(0)
					
			
			elsif caja[cont3].getReloj>1 then
				caja[cont3].restarMinuto()
			end
		
			cont3=cont3+1
		end 
		cont2=cont2+1
		cont=cont+1
		sleep(1)
	end

	puts cola.getClientesEnCola
end




require_relative 'Boton'
require 'fox16'
include Fox

class Barra < FXMainWindow
  def initialize(app)
    @app = app
    super(app, "Presentación", :width=>1100, :height=>500)
    @dataTarget = FXDataTarget.new(0)
    barra = FXProgressBar.new(self, @dataTarget, FXDataTarget::ID_VALUE, LAYOUT_SIDE_BOTTOM|LAYOUT_FILL_X|FRAME_SUNKEN|FRAME_THICK)
    barra.barColor = "green"
    barra.barBGColor = "black"
   
    @tabla = FXTable.new(self, :opts=>LAYOUT_EXPLICIT, :width=>1000, :height=>500, :x=>20, :y=>20)
    @tabla.visibleColumns = 9
    @tabla.visibleRows = 15
    @tabla.setTableSize(15, 9)


    #@tabla.setItemText(1, 0, "Mundo")

    @tabla.setItemJustify(0,0, FXTableItem::CENTER_X | FXTableItem::CENTER_Y)
    @tabla.setRowText(0, "Clientes Camprando")
    @tabla.setRowText(2, "Clientes En cola ")

    @tabla.setColumnText(0, "Caja 1")
    @tabla.setColumnText(1, "Caja 2")
	@tabla.setColumnText(2, "Caja 3")
	@tabla.setColumnText(3, "Caja 4")
	@tabla.setColumnText(4, "Caja 5")
	@tabla.setColumnText(5, "Caja 6")
	@tabla.setColumnText(6, "Caja 7")
	@tabla.setColumnText(7, "Caja 8")
	@tabla.setColumnText(8, "Caja 9")


  end

  def create
    super
    puts "Ingrese el tiempo de simulacion en minutos:"	
	$t=gets.to_i	

	puts "Ingrese el numero de cajas Registradoras Activas:"	
	$numCajas=gets.to_i

	puts "Ingrese el delta tiempo de cada iteración:"	
	$deltaT=gets.to_i

	 $i=100/$t

    getApp().addTimeout(1000, method(:tiempo))

    $cont=0
	$caja=Array.new
	$tiempos=Array.new

	while $cont<$numCajas do
	$caja[$cont]=Caja.new()
	$cont=$cont+1 
	end

	$cola=Cola.new()

	$cont=0
	$cont2=3
	$cont4=0
	$contNombre=0
	$nombreCliente=Array.new
	$contt=0

	$temp=Array.new


    #unicaCola($t, n )


    show(PLACEMENT_SCREEN)
  end

  def tiempo(sender, sel, ptr)
  	
    @dataTarget.value = @dataTarget.value + $i
    if(@dataTarget.value>=100)
    	
    	puts $cola.getClientesEnCola

    else
    	#puts $i
    	if $cont2==3 then
			numClientes=rand(5)
			$cola.agregarClientes(numClientes)
			contt=0
			while contt<numClientes do

				$nombreCliente.push("C"+$contt.to_s)
				$contt=$contt+1
				contt=contt+1
			end
			cadenaNombres=""
			$nombreCliente.each { |a| cadenaNombres=cadenaNombres+a }
			@tabla.setItemText(2, 0, cadenaNombres )
			$cont2=0
		end

		$cont3=0

		while $cont3<$numCajas do
			if $cola.getClientesEnCola>0 && $caja[$cont3].getEstado==0 then
				$caja[$cont3].setEstado(1)
				$caja[$cont3].setReloj(rand(4..25))
				$tiempos[$cont4]=$caja[$cont3].getReloj
				$cont4=$cont4+1
				$cola.restarCliente
				$temp[$cont3]=$nombreCliente.first
				$nombreCliente.delete_at(0)
				@tabla.setItemText(0, $cont3, $temp[$cont3])
				cadenaNombres=""
				$nombreCliente.each { |a| cadenaNombres=cadenaNombres+a }
				@tabla.setItemText(2, 0, cadenaNombres )

			elsif $caja[$cont3].getReloj==1 then
					$caja[$cont3].setReloj(0)
					$caja[$cont3].setEstado(0)
					
			
			elsif $caja[$cont3].getReloj>1 then
				$caja[$cont3].restarMinuto()
			end
		
			$cont3=$cont3+1
		end 
		$cont2=$cont2+1
		$cont=$cont+1
		if $deltaT!=0 then
		sleep($deltaT)
		end
      getApp().addTimeout(1000, method(:tiempo))
    end
  end
end

app = FXApp.new
Barra.new(app)
app.create
app.run



