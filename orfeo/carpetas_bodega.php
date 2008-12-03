<?php
/**
 * carpetas_bodega.php
 * Autor: Superintendencia de la Economía Solidaria
 * Fecha creación: 23 - Marzo - 2006
 * Fecha última modificación: 13 - Diciembre - 2006
 * Descripción: Este script permite crear la estructura de directorios requerida
 * por el Sistema de Gestión Documental ORFEO dentro del directorio bodega.
 * Dentro del directorio definido como ruta raiz ($ruta_raiz) debe haberse creado
 * previamente el directorio bodega.
 * En la tabla DEPENDENCIA de la Base de Datos se deben haber ingresado previamente todas
 * las dependencias con su respectivo código.
 */

// Ruta del directorio que contiene el enlace a la bodega de imágenes
//$ruta_raiz = "./orfeo_3.5";
$ruta_raiz = "/var/www/orfeo";

include_once ( "$ruta_raiz/include/db/ConnectionHandler.php" );

// Verifica si existe un directorio cuyo nombre corresponde al año actual
if ( is_dir( $ruta_raiz.'/bodega/'.date( "Y" ) ) )
{
    // Función para crear los directorios asociados a cada dependencia
    creaDirDepe( $ruta_raiz );
}
// Si no existe un directorio cuyo nombre corresponde al año actual lo crea
else
{
    // Crea un directorio cuyo nombre corresponde al año actual
    if ( mkdir ( $ruta_raiz.'/bodega/'.date( "Y" ), 0777 ) )
    {
        print "Directorio ".$ruta_raiz.'/bodega/'.date( "Y" )." creado.<br>";
        
        // Función para crear los directorios asociados a cada dependencia
        creaDirDepe( $ruta_raiz );
    }
    else
    {
        print "No se pudo crear el directorio ".$ruta_raiz.'/bodega/'.date( "Y" )."<br>";
    }
}

// Directorio fax
// Verifica si no existe el directorio fax
if ( ! is_dir( $ruta_raiz.'/bodega/fax' ) )
{
    // Crea un directorio llamado fax
    if ( mkdir ( $ruta_raiz.'/bodega/fax', 0777 ) )
    {
        print "Directorio ".$ruta_raiz.'/bodega/fax'." creado.<br>";
    }
    else
    {
        print "No se pudo crear el directorio ".$ruta_raiz.'/bodega/fax.<br>';
    }
}

// Directorio masiva
// Verifica si no existe el directorio masiva
if ( ! is_dir( $ruta_raiz.'/bodega/masiva' ) )
{
    // Crea un directorio llamado masiva
    if ( mkdir ( $ruta_raiz.'/bodega/masiva', 0777 ) )
    {
        print "Directorio ".$ruta_raiz.'/bodega/masiva'." creado.<br>";
    }
    else
    {
        print "No se pudo crear el directorio ".$ruta_raiz.'/bodega/masiva.<br>';
    }
}

// Directorio pdfs
// Verifica si no existe un directorio pdfs
if ( ! is_dir( $ruta_raiz.'/bodega/pdfs' ) )
{
    // Crea un directorio llamado pdfs
    if ( mkdir ( $ruta_raiz.'/bodega/pdfs', 0777 ) )
    {
        print "Directorio ".$ruta_raiz.'/bodega/pdfs'." creado.<br>";
        
        // Directorio guias
        // Verifica si no existe un directorio guias
        if ( ! is_dir( $ruta_raiz.'/bodega/pdfs/guias' ) )
        {
            // Crea un directorio llamado guias
            if ( mkdir ( $ruta_raiz.'/bodega/pdfs/guias', 0777 ) )
            {
                print "Directorio ".$ruta_raiz.'/bodega/pdfs/guias'." creado.<br>";
            }
            else
            {
                print "No se pudo crear el directorio ".$ruta_raiz.'/bodega/pdfs/guias.<br>';
            }
        }
        
        // Directorio planillas
        // Verifica si no existe un directorio planillas
        if ( ! is_dir( $ruta_raiz.'/bodega/pdfs/planillas' ) )
        {
            // Crea un directorio llamado planillas
            if ( mkdir ( $ruta_raiz.'/bodega/pdfs/planillas', 0777 ) )
            {
                print "Directorio ".$ruta_raiz.'/bodega/pdfs/planillas'." creado.<br>";
                
                // Directorio dev
                // Verifica si no existe un directorio dev
                if ( ! is_dir( $ruta_raiz.'/bodega/pdfs/planillas/dev' ) )
                {
                    // Crea un directorio llamado dev
                    if ( mkdir ( $ruta_raiz.'/bodega/pdfs/planillas/dev', 0777 ) )
                    {
                        print "Directorio ".$ruta_raiz.'/bodega/pdfs/planillas/dev'." creado.<br>";
                    }
                    else
                    {
                        print "No se pudo crear el directorio ".$ruta_raiz.'/bodega/pdfs/planillas/dev.<br>';
                    }
                }
                
                // Directorio envios
                // Verifica si no existe un directorio envios
                if ( ! is_dir( $ruta_raiz.'/bodega/pdfs/planillas/envios' ) )
                {
                    // Crea un directorio llamado envios
                    if ( mkdir ( $ruta_raiz.'/bodega/pdfs/planillas/envios', 0777 ) )
                    {
                        print "Directorio ".$ruta_raiz.'/bodega/pdfs/planillas/envios'." creado.<br>";
                    }
                    else
                    {
                        print "No se pudo crear el directorio ".$ruta_raiz.'/bodega/pdfs/planillas/envios.<br>';
                    }
                }
            }
            else
            {
                print "No se pudo crear el directorio ".$ruta_raiz.'/bodega/pdfs/planillas.<br>';
            }
        }
    }
    else
    {
        print "No se pudo crear el directorio ".$ruta_raiz.'/bodega/pdfs.<br>';
    }
}

// Directorio tmp
// Verifica si no existe un directorio tmp
if ( ! is_dir( $ruta_raiz.'/bodega/tmp' ) )
{
    // Crea un directorio llamado tmp
    if ( mkdir ( $ruta_raiz.'/bodega/tmp', 0777 ) )
    {
        print "Directorio ".$ruta_raiz.'/bodega/tmp'." creado.<br>";
    }
    else
    {
        print "No se pudo crear el directorio ".$ruta_raiz.'/bodega/tmp.<br>';
    }
}

// Función para crear los directorios asociados a cada dependencia
function creaDirDepe( $ruta_raiz )
{
    $db = new ConnectionHandler( "$ruta_raiz" );
    //$db->conn->debug = true;
    
    $query  = "SELECT DEPE_CODI";
    $query .= " FROM dependencia";
    // print "query: ".$query;
    $db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
    $rs = $db->query($query);
    while( !$rs->EOF )
    {
        // Verifica si existe un directorio cuyo nombre corresponde al código de la
        // dependencia
        if ( is_dir( $ruta_raiz.'/bodega/'.date( "Y" ).'/'.$rs->fields["DEPE_CODI"] ) )
        {
            // Directorio docs
            // Verifica si no existe un directorio docs
            if ( ! is_dir( $ruta_raiz.'/bodega/'.date( "Y" ).'/'.$rs->fields["DEPE_CODI"].'/docs' ) )
            {
                // Crea un directorio llamado docs
                if ( mkdir ( $ruta_raiz.'/bodega/'.date( "Y" ).'/'.$rs->fields["DEPE_CODI"].'/docs', 0777 ) )
                {
                    print "Directorio ".$ruta_raiz.'/bodega/'.date( "Y" ).'/'.$rs->fields["DEPE_CODI"].'/docs'." creado.<br>";
                }
                else
                {
                    print "No se pudo crear el directorio ".$ruta_raiz.'/bodega/'.date( "Y" ).'/'.$rs->fields["DEPE_CODI"].'/docs.<br>';
                }
            }
        }
        // Si no existe un directorio cuyo nombre corresponde al código de la dependencia,
        // lo crea
        else
        {
            // Crea un directorio cuyo nombre corresponde al código de la dependencia
            if ( mkdir ( $ruta_raiz.'/bodega/'.date( "Y" ).'/'.$rs->fields["DEPE_CODI"], 0777 ) )
            {
                print "Directorio ".$ruta_raiz.'/bodega/'.date( "Y" ).'/'.$rs->fields["DEPE_CODI"]." creado.<br>";
                
                // Directorio docs
                // Verifica si no existe un directorio docs
                if ( ! is_dir( $ruta_raiz.'/bodega/'.date( "Y" ).'/'.$rs->fields["DEPE_CODI"].'/docs' ) )
                {
                    // Crea un directorio llamado docs
                    if ( mkdir ( $ruta_raiz.'/bodega/'.date( "Y" ).'/'.$rs->fields["DEPE_CODI"].'/docs', 0777 ) )
                    {
                        print "Directorio ".$ruta_raiz.'/bodega/'.date( "Y" ).'/'.$rs->fields["DEPE_CODI"].'/docs'." creado.<br>";
                    }
                    else
                    {
                        print "No se pudo crear el directorio ".$ruta_raiz.'/bodega/'.date( "Y" ).'/'.$rs->fields["DEPE_CODI"].'/docs.<br>';
                    }
                }
            }
            else
            {
                print "No se pudo crear el directorio ".$ruta_raiz.'/bodega/'.date( "Y" ).'/'.$rs->fields["DEPE_CODI"]."<br>";
            }
        }
        $rs->MoveNext();
    }
}
?>
