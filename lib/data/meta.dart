class Meta {
  final int id;
  final String title_en;
  final String title_kh;
  final String address;
  final String image;
  final List<dynamic> implemented_by_logos;
  final List<dynamic> funded_by_logos;
  final String email;
  final Email_Form email_form;
  final String home_en;
  final String home_kh;
  final String android_share_link;
  final String ios_share_link;
  final String disclaimer;
  final String disclaimer_image;
  final String first_logo_section_text;
  final String second_logo_section_text;

  Meta(
      this.id,
      this.title_en,
      this.title_kh,
      this.address,
      this.email,
      this.implemented_by_logos,
      this.funded_by_logos,
      this.image,
      this.email_form,
      this.home_en,
      this.home_kh,
      this.android_share_link,
      this.ios_share_link,
      this.disclaimer,
      this.disclaimer_image,
      this.first_logo_section_text,
      this.second_logo_section_text);

  Meta.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title_en = json['title_en'],
        title_kh = json['title_kh'],
        home_en = json['home_en'],
        home_kh = json['home_kh'],
        address = json['address'],
        email = json['email'],
        implemented_by_logos = json['implemented_by_logos'],
        funded_by_logos = json['funded_by_logos'],
        image = json['image'],
        android_share_link = json['android_share_link'] ?? "",
        ios_share_link = json['ios_share_link'] ?? "",
        disclaimer = json['disclaimer'] ?? "",
        disclaimer_image = json['disclaimer_image'] ?? "",
        first_logo_section_text = json['first_logo_section_text'] ?? "",
        second_logo_section_text = json['second_logo_section_text'] ?? "",
        email_form = Email_Form.fromJson(json['email_form']);
}

class Email_Form {
  final String name_en;
  final String name_kh;
  final String email_en;
  final String email_kh;
  final String subject_en;
  final String subject_kh;
  final String message_en;
  final String message_kh;
  final String send_button_en;
  final String send_button_kh;
  final String success_message_en;
  final String success_message_kh;
  final String failed_message_en;
  final String failed_message_kh;
  final String missing_name_en;
  final String missing_name_kh;
  final String missing_email_en;
  final String missing_email_kh;
  final String missing_subject_en;
  final String missing_subject_kh;
  final String missing_message_en;
  final String missing_message_kh;

  Email_Form(
      this.name_en,
      this.name_kh,
      this.email_en,
      this.email_kh,
      this.subject_en,
      this.subject_kh,
      this.message_en,
      this.message_kh,
      this.send_button_en,
      this.send_button_kh,
      this.success_message_en,
      this.success_message_kh,
      this.failed_message_en,
      this.failed_message_kh,
      this.missing_name_en,
      this.missing_name_kh,
      this.missing_email_en,
      this.missing_email_kh,
      this.missing_subject_en,
      this.missing_subject_kh,
      this.missing_message_en,
      this.missing_message_kh);

  Email_Form.fromJson(Map<String, dynamic> json)
      : name_en = json['name_en'],
        name_kh = json['name_kh'],
        email_en = json['email_en'],
        email_kh = json['email_kh'],
        subject_en = json['subject_en'],
        subject_kh = json['subject_kh'],
        message_en = json['message_en'],
        message_kh = json['message_kh'],
        send_button_en = json['send_button_en'],
        send_button_kh = json['send_button_kh'],
        success_message_en = json['success_message_en'],
        success_message_kh = json['success_message_kh'],
        failed_message_en = json['failed_message_en'],
        failed_message_kh = json['failed_message_kh'],
        missing_name_en = json['missing_name_en'],
        missing_name_kh = json['missing_name_kh'],
        missing_email_en = json['missing_email_en'],
        missing_email_kh = json['missing_email_kh'],
        missing_subject_en = json['missing_subject_en'],
        missing_subject_kh = json['missing_subject_kh'],
        missing_message_en = json['missing_message_en'],
        missing_message_kh = json['missing_message_kh'];
}
