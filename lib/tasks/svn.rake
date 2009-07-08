# from http://blog.unquiet.net/archives/2005/11/06/helpful-rake-tasks-for-using-rails-with-subversion/

namespace :svn do
  desc "Configure Subversion for Rails"
  task :configure do
    system "svn remove log/*"
    system "svn commit -m 'removing all log files from subversion'"
    system 'svn propset svn:ignore "*.log" log/'
    system "svn update log/"
    system "svn commit -m 'Ignoring all files in /log/ ending in .log'"

    system "svn propset svn:ignore '*' tmp/"
    system "svn update tmp/"
    system "svn commit -m 'Ignoring all files in /tmp/'"
    
    system 'svn propset svn:ignore "*.db" db/'
    system "svn update db/"
    system "svn commit -m 'Ignoring all files in /db/ ending in .db'"
  end
      
  desc "Add new files to subversion"
  task :add_new_files do
     system "svn status | grep '^\?' | sed -e 's/? *//' | sed -e 's/ /\ /g' | xargs svn add"
  end

  desc "shortcut for adding new files"
  task :add => [ :add_new_files ]
end