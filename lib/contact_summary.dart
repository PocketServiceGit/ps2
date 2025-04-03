import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'app_theme.dart';
import 'contact_form.dart';

class ContactSummary extends StatelessWidget {
  final ContactData contactData;

  const ContactSummary({super.key, required this.contactData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Summary'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _generateAndSharePDF(context),
            tooltip: 'Download as PDF',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Information',
              style: AppTheme.headingStyle,
            ),
            SizedBox(height: AppTheme.spacingMedium),
            _buildInfoCard(
              [
                _buildInfoRow('Name', '${contactData.firstName} ${contactData.lastName}'),
                _buildInfoRow('Gender', contactData.gender),
                _buildInfoRow(
                  'Birth Date', 
                  contactData.birthDate != null 
                    ? '${contactData.birthDate!.day}/${contactData.birthDate!.month}/${contactData.birthDate!.year}'
                    : 'Not provided'
                ),
              ],
            ),
            SizedBox(height: AppTheme.spacingLarge),
            
            Text(
              'Contact Information',
              style: AppTheme.headingStyle,
            ),
            SizedBox(height: AppTheme.spacingMedium),
            _buildInfoCard(
              [
                _buildInfoRow('Email', contactData.email),
                _buildInfoRow('Phone', contactData.phone),
              ],
            ),
            SizedBox(height: AppTheme.spacingLarge),
            
            Text(
              'Address',
              style: AppTheme.headingStyle,
            ),
            SizedBox(height: AppTheme.spacingMedium),
            _buildInfoCard(
              [
                _buildInfoRow('Street', contactData.address),
                _buildInfoRow('City', contactData.city),
                _buildInfoRow('ZIP Code', contactData.zipCode),
                _buildInfoRow('Country', contactData.country),
              ],
            ),
            SizedBox(height: AppTheme.spacingLarge),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _generateAndSharePDF(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingMedium),
                ),
                child: const Text('Download as PDF'),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoCard(List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMedium),
        child: Column(
          children: children,
        ),
      ),
    );
  }
  
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.textLightColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTheme.bodyStyle,
            ),
          ),
        ],
      ),
    );
  }
  
  Future<void> _generateAndSharePDF(BuildContext context) async {
    try {
      // PDF erstellen
      final pdf = pw.Document();
      
      // PDF-Seite hinzufügen
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Header(
                  level: 0,
                  child: pw.Text('Contact Information', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                ),
                pw.SizedBox(height: 20),
                
                // Persönliche Informationen
                pw.Header(
                  level: 1,
                  child: pw.Text('Personal Information', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                ),
                pw.SizedBox(height: 10),
                _buildPdfRow('Name', '${contactData.firstName} ${contactData.lastName}'),
                _buildPdfRow('Gender', contactData.gender),
                _buildPdfRow(
                  'Birth Date', 
                  contactData.birthDate != null 
                    ? '${contactData.birthDate!.day}/${contactData.birthDate!.month}/${contactData.birthDate!.year}'
                    : 'Not provided'
                ),
                pw.SizedBox(height: 20),
                
                // Kontaktinformationen
                pw.Header(
                  level: 1,
                  child: pw.Text('Contact Information', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                ),
                pw.SizedBox(height: 10),
                _buildPdfRow('Email', contactData.email),
                _buildPdfRow('Phone', contactData.phone),
                pw.SizedBox(height: 20),
                
                // Adresse
                pw.Header(
                  level: 1,
                  child: pw.Text('Address', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                ),
                pw.SizedBox(height: 10),
                _buildPdfRow('Street', contactData.address),
                _buildPdfRow('City', contactData.city),
                _buildPdfRow('ZIP Code', contactData.zipCode),
                _buildPdfRow('Country', contactData.country),
              ],
            );
          },
        ),
      );
      
      // PDF speichern
      final output = await getTemporaryDirectory();
      final file = File('${output.path}/contact_info.pdf');
      await file.writeAsBytes(await pdf.save());
      
      // PDF teilen
      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'Contact Information',
      );
      
      // Erfolgsmeldung anzeigen
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF generated and shared successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // Fehlermeldung anzeigen
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error generating PDF: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
  
  pw.Widget _buildPdfRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 5),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 100,
            child: pw.Text(
              label,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Expanded(
            child: pw.Text(value),
          ),
        ],
      ),
    );
  }
} 