class GenerateCvController < ActionController::Base 
      
  def pdf_export
     create_odt
     @pdf_file = "/tmp/cv_#{@cv.id}.pdf"
     system "rm -rf #{@pdf_file}"
     unless system "export DISPLAY=:8100.0; xvfb-run -a /usr/lib/openoffice/program/soffice.bin -invisible \"-accept=socket,host=localhost,port=8100\" \"macro:///Gimmicks.AutoText.SaveAsPdf(#{@odt_file})\""
       puts $?
     end    
  end

  def doc_export
    create_odt
    @doc_file = "/tmp/cv_#{@cv.id}.doc"
    unless system "export DISPLAY=:8100.0; xvfb-run -a /usr/lib/openoffice/program/soffice.bin -invisible \"-accept=socket,host=localhost,port=8100\" \"macro:///Gimmicks.AutoText.SaveAsDoc(#{@odt_file})\""
      puts $?
    end
  end

  def create_odt
    user_id = @user.id
    @avatar = @cv.avatar
    @moovers_data = @cv.moovers_data    
    @template_name = "template2"
    @template_tmp_dir = "/tmp/#{@template_name}_#{user_id}"

    FileUtils.rm_rf("#{@tempate_tmp_dir}")
    FileUtils.cp_r("#{RAILS_ROOT}/components/#{@template_name}/", @template_tmp_dir)
    # @xml_content = render_to_string :file => "#{RAILS_ROOT}/components/#{@template_name}.rhtml", :layout => false
    path =  File.dirname(__FILE__) + "/../../components/#{@template_name}.rhtml"
    template = ERB.new(File.readlines(path).join(''), nil, '-')
    @xml_content = template.result(binding)

    FileUtils.rm_f "#{@template_tmp_dir}/content.xml"
    File.open("#{@template_tmp_dir}/content.xml", "w") do |file|
      file.write(@xml_content)
    end
    @odt_file = "/tmp/cv_#{user_id}.odt"   
    FileUtils.rm_f("#{@odt_file}")
    unless system("cd #{@template_tmp_dir}/ ; zip -r #{@odt_file} * ")
      puts $?
    end
    
    FileUtils.rm_rf("#{@tempate_tmp_dir}")
    puts " suppression du repertoire #{@template_tmp_dir}"
  end


  def do_next
    
    running = Action.find :all, :conditions => "cv_id IS NOT NULL and status = 'RUNNING' "
    return unless running.empty?
    
    waiting = Action.find :all, :conditions => "cv_id IS NOT NULL and status = 'WAITING' ", :order => "date ASC"
    return if waiting.empty?
    
    action = waiting.first
    action.update_attributes({:status => "RUNNING"})
    @cv_id = action.cv_id
    @cv = Cv.find @cv_id
    @user = @cv.user
    
    puts "Treating the cv #{@cv_id} with an export #{action.action_type}"
    
    case action.action_type
    when "pdf_export"
      pdf_export
    when "doc_export"
      doc_export
    when "odt_export"
      create_odt
    end
      
    action.update_attributes({:status => "DONE_NOT_TAKEN"})        
    UserNotifier.deliver_export_notification(action.cv.user, "#{URL_FOR}/export/get_file/#{action.code}") 
  end
  
  
end
