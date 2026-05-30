object LinearAutoDestroyModule:
  // Definição do Tipo Nominal Opaco
  opaque type LinearAutoDestroy[T] = Container[T]

  private class Container[T](var value: T, var isDestroyed: Boolean)

  def init[T](val: T): LinearAutoDestroy[T] = 
    Container(val, false)

  extension [T](container: LinearAutoDestroy[T])
    def consume(): T =
      if container.isDestroyed then 
        throw new IllegalStateException("VariableAlreadyDestroyed")
      
      val extracted = container.value
      container.value = null.asInstanceOf[T] // Limpa a referência do GC
      container.isDestroyed = true
      extracted
