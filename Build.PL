use lib 'lib';
use AudioFile::Info::Build;

my $module = 'AudioFile::Info::MP3::ID3Lib';

my $b = AudioFile::Info::Build->new(module_name => $module,
                                    dist_version => '1.07',
                                    license => 'perl',
                                    requires => {
                                                 perl            => '5.6.0',
                                                 AudioFile::Info => 0,
                                                 MP3::ID3Lib     => 0,
                                    },
                                    build_requires => {
                                                 YAML            => 0,
                                                },
                                    build_recommends => {
                                                 Module::Build   => 0
                                                },
                                    create_makefile_pl => 'traditional',
                                    dynamic_config => 1,
                                   );

$b->create_build_script;

$b->notes(package => $module);
$b->notes(config  => {
                      read_mp3 => 1,
                      write_mp3 => 1,
                      read_ogg => 0,
                      write_ogg => 0,
                      pure_perl => 0
                     });
