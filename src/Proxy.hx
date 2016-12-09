package;

import haxe.Json;
import haxe.io.Bytes;
import haxe.io.BytesOutput;
import haxe.zip.*;

import haxelib.SemVer;
import haxelib.Data;
import haxelib.client.Main.SiteProxy;

class Proxy extends haxelib.client.Main.SiteProxy {
  override public function infos(project:String):ProjectInfos {
    return 
      if (project == 'laserunicorn') {
        name: 'laserunicorn',
        desc: 'the laserunicorn',
        website: 'laserunicorn.org',
        owner: 'laserunicorn himself',
        license: 'MIT',
        curversion: SemVer.DEFAULT,
        downloads: 0,
        versions: [ { 
          name: SemVer.DEFAULT,
          date: '',
          downloads: 0,
          comments: 'the one version',
          
        }],
        tags: new List(),
      }
      else
        super.infos(project);
  }

  public function getZip(name:String) {
    var infos:Infos = {
      name: ProjectName.ofString('laserunicorn'),
      license: License.Mit,
      version: SemVer.DEFAULT,
      releasenote: 'nuff said',
      contributors: ['laserunicorn'],
    }
    
    var out = new BytesOutput();
    var w = new Writer(out);
    var entries = new List<Entry>();
    
    var data = Bytes.ofString(Json.stringify(infos));
    
    entries.push({
      fileTime: Date.now(),
      fileName: 'haxelib.json',
      fileSize: data.length,
      dataSize: data.length,
      compressed: false,
      data: data,
      crc32: null,
    });
            
    w.write(entries);
    
    return out.getBytes();
  }
}