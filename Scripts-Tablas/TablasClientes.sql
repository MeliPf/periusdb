CREATE TABLE TiposPagos (
    IdTipoPago INT IDENTITY(1,1) NOT NULL,
    TipoPago VARCHAR(35) NOT NULL,
    CONSTRAINT PK_TiposPagos PRIMARY KEY (IdTipoPago),
    CONSTRAINT UK_TiposPagos UNIQUE (TipoPago)
);

CREATE TABLE TiposDocumentos (
    IdTipoDocumento INT IDENTITY(1,1) NOT NULL,
    Documento VARCHAR(35) NOT NULL,
    CONSTRAINT PK_TiposDocumentos PRIMARY KEY (IdTipoDocumento),
    CONSTRAINT UK_TiposDocumentos UNIQUE (Documento)
);

CREATE TABLE Clientes (
    IdCliente       INT IDENTITY(1,1) NOT NULL,
    IdTipoDocumento INT NOT NULL,
    Nombre          VARCHAR(50) NOT NULL,
    PrimerApellido  VARCHAR(50) NOT NULL,
    SegundoApellido VARCHAR(50) NULL,
    Documento       VARCHAR(9)  NOT NULL,
    FechaAlta       DATETIME NOT NULL DEFAULT(GETDATE()),
    FechaBaja       DATETIME NULL,
    Activo          BIT DEFAULT(1),
    CONSTRAINT PK_Clientes PRIMARY KEY (IdCliente),
    CONSTRAINT UK_Clientes UNIQUE (Documento),
    FOREIGN KEY (IdTipoDocumento) REFERENCES TiposDocumentos(IdTipoDocumento)
);

CREATE TABLE Clientes_DatosBancarios (
    IdDatosBancarios INT IDENTITY(1,1) NOT NULL,
    IdCliente INT NOT NULL,
    IdTipoPago INT NOT NULL,
    CuentaBancaria  VARCHAR(34) NULL,
    TarjetaCredito  INT NULL,
    CONSTRAINT PK_DatosBancarios PRIMARY KEY (IdDatosBancarios),
    CONSTRAINT UK_DatosBancarios UNIQUE (CuentaBancaria, TarjetaCredito),
    FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente),
    FOREIGN KEY (IdTipoPago) REFERENCES TiposPagos(IdTipoPago)
) 

CREATE TABLE TiposDireccion (
IdTipoDireccion INT IDENTITY(1,1) NOT NULL,
TipoDireccion VARCHAR(20) NOT NULL,
CONSTRAINT PK_TiposDirecion PRIMARY KEY (IdTipoDireccion),
CONSTRAINT UK_TiposDirecion UNIQUE (TipoDireccion),
);

CREATE TABLE CodigosPostales(
IdCodigoPostal INT IDENTITY(1,1) NOT NULL,
CodigoPostal INT NOT NULL,
Localidad VARCHAR(80) NOT NULL,
Provincia VARCHAR(50) NOT NULL,
CONSTRAINT PK_CodigosPostales PRIMARY KEY (IdCodigoPostal),
CONSTRAINT UK_CodigosPostales UNIQUE (CodigoPostal, Localidad, Provincia),
);

CREATE TABLE Clientes_Direcciones (
IdDireccion INT IDENTITY(1,1) NOT NULL,
IdTipoDireccion INT NOT NULL,
IdCliente INT NOT NULL,
Direccion VARCHAR(150) NOT NULL,
IdCodigoPostal INT NOT NULL,
CONSTRAINT PK_Direcciones PRIMARY KEY (IdDireccion),
CONSTRAINT UK_Direcciones UNIQUE (IdCliente, IdTipoDireccion),
FOREIGN KEY (IdTipoDireccion) REFERENCES TiposDireccion(IdTipoDireccion),
FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente),
FOREIGN KEY (IdCodigoPostal) REFERENCES CodigosPostales(IdCodigoPostal)
);

CREATE TABLE Clientes_Contacto(
IdContacto INT IDENTITY(1,1) NOT NULL,
IdCliente INT NOT NULL,
Prefijo INT NULL,
Movil INT NULL,
Fijo INT NULL,
CorreoElectronico VARCHAR(100) NULL,
CONSTRAINT PK_Contacto PRIMARY KEY (IdContacto),
CONSTRAINT UK_Contacto UNIQUE (Movil, CorreoElectronico),
FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente),
); 