CREATE TABLE RHU.RAD_DOCUMENTOS (
    RAD_CODIGO              NUMBER PRIMARY KEY,
    INC_RADICACION           NUMBER NOT NULL,
    TPD_CODIGO               NUMBER NOT NULL,
    DEA_CODIGO               NUMBER,
    RAD_REQUERIDO           VARCHAR2(2),
    RAD_ESTADO              VARCHAR2(15) DEFAULT ('SIN_VALIDAR'),
    RAD_OBSERVACIONES       VARCHAR2(1000),
    AUD_USUARIO              VARCHAR2(15) NOT NULL,
    AUD_FECHA                DATE NOT NULL
);

ALTER TABLE RHU.RAD_DOCUMENTOS ADD CONSTRAINT  RAD_REQUERIDO CHECK (RAD_REQUERIDO IN ('S' , 'N'));
ALTER TABLE RHU.RAD_DOCUMENTOS ADD CONSTRAINT  RAD_ESTADO_C CHECK (RAD_ESTADO IN ('APROBADO' , 'RECHAZADO', 'SIN_VALIDAR'));

ALTER TABLE RHU.RAD_DOCUMENTOS ADD  CONSTRAINT FK_RADTIPODOCUMENTO FOREIGN KEY (TPD_CODIGO) REFERENCES ADM.TIPO_DOCUMENTO(TPD_CODIGO);
ALTER TABLE RHU.RAD_DOCUMENTOS ADD  CONSTRAINT FK_RADINCAPACIDAD FOREIGN KEY (INC_RADICACION) REFERENCES RHU.INCAPACIDAD(INC_RADICACION);
GRANT SELECT ON RHU.RAD_DOCUMENTOS TO PUBLIC;
CREATE PUBLIC SYNONYM RAD_DOCUMENTOS FOR RHU.RAD_DOCUMENTOS;
GRANT ALL ON RHU.RAD_DOCUMENTOS TO PUBLIC;
CREATE SEQUENCE RHU.SEQ_RAD_DOCUMENTOS INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCACHE;
GRANT ALL ON RHU.SEQ_RAD_DOCUMENTOS TO PUBLIC;

CREATE OR REPLACE TRIGGER "RHU"."DB_RAD_DOCUMENTOS" 
Before
  INSERT ON  RHU.RAD_DOCUMENTOS REFERENCING NEW AS NEW
  FOR EACH ROW

  Begin
	Select SEQ_RAD_DOCUMENTOS.Nextval
      INTO :NEW.RAD_CODIGO
      FROM dual;	
  --
EXCEPTION
  WHEN OTHERS THEN
    raise_application_error(-20001, 'Error secuencia DB_RADICACION_DOCUMENTOS'||sqlerrm);
End;
