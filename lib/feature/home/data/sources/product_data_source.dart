import 'dart:async';

import '../models/product_model.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> fetchProducts();
}

class LocalProductDataSource implements ProductDataSource {
  @override
  Future<List<ProductModel>> fetchProducts() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    return const [
      ProductModel(
        id: 'p1',
        category: '🍚 চাল ও আটা',
        title: 'মিনিকেট চাল (১ কেজি)',
        subtitle: 'পরিষ্কার ও মানসম্মত',
        price: 85,
        imageUrl:
            'https://images.pexels.com/photos/4110251/pexels-photo-4110251.jpeg?auto=compress&cs=tinysrgb&w=600',
        description:
            'প্রতিদিনের রান্নার জন্য ভালো মানের মিনিকেট চাল। ভাত ঝরঝরে হয় এবং স্বাদ ভালো।',
      ),
      ProductModel(
        id: 'p2',
        category: '🍚 চাল ও আটা',
        title: 'আটা (২ কেজি)',
        subtitle: 'রুটি ও পরোটার জন্য',
        price: 140,
        imageUrl:
            'https://images.pexels.com/photos/6287296/pexels-photo-6287296.jpeg?auto=compress&cs=tinysrgb&w=600',
        description:
            'নরম রুটি, পরোটা ও বেকিংয়ের জন্য উপযোগী ভালো মানের গমের আটা।',
      ),
      ProductModel(
        id: 'p3',
        category: '🧂 মসলা',
        title: 'হলুদ গুঁড়া (২০০ গ্রাম)',
        subtitle: 'খাঁটি ও ঘ্রাণযুক্ত',
        price: 90,
        imageUrl:
            'https://images.pexels.com/photos/4198714/pexels-photo-4198714.jpeg?auto=compress&cs=tinysrgb&w=600',
        description: 'রান্নার রং ও স্বাদ বাড়াতে খাঁটি হলুদ গুঁড়া।',
      ),
      ProductModel(
        id: 'p4',
        category: '🛢️ তেল ও ঘি',
        title: 'সয়াবিন তেল (১ লিটার)',
        subtitle: 'দৈনন্দিন রান্নার জন্য',
        price: 195,
        imageUrl:
            'https://images.pexels.com/photos/33783/olive-oil-salad-dressing-cooking-olive.jpg?auto=compress&cs=tinysrgb&w=600',
        description:
            'ভাজি, ভুনা ও অন্যান্য রান্নার জন্য নির্ভরযোগ্য মানের তেল।',
      ),
      ProductModel(
        id: 'p5',
        category: '🍪 স্ন্যাকস',
        title: 'বাটার বিস্কুট (৩০০ গ্রাম)',
        subtitle: 'চায়ের সেরা সঙ্গী',
        price: 75,
        imageUrl:
            'https://images.pexels.com/photos/230325/pexels-photo-230325.jpeg?auto=compress&cs=tinysrgb&w=600',
        description:
            'কুড়মুড়ে ও মজাদার বাটার বিস্কুট, সকাল-সন্ধ্যার নাশতায় দারুণ।',
      ),
      ProductModel(
        id: 'p6',
        category: '🥤 পানীয়',
        title: 'কমলার জুস (১ লিটার)',
        subtitle: 'ঠান্ডা ও সতেজ',
        price: 160,
        imageUrl:
            'https://images.pexels.com/photos/96974/pexels-photo-96974.jpeg?auto=compress&cs=tinysrgb&w=600',
        description: 'পরিবারের সবার জন্য সতেজ স্বাদের ফলের জুস।',
      ),
      ProductModel(
        id: 'p7',
        category: '🧼 ব্যক্তিগত যত্ন (Personal Care)',
        title: 'ফেসওয়াশ (১০০ মি.লি.)',
        subtitle: 'ত্বক পরিষ্কার ও সতেজ',
        price: 180,
        imageUrl:
            'https://images.pexels.com/photos/6621466/pexels-photo-6621466.jpeg?auto=compress&cs=tinysrgb&w=600',
        description:
            'দৈনন্দিন ব্যবহারযোগ্য ফেসওয়াশ, ত্বকের ময়লা দূর করে সতেজ অনুভূতি দেয়।',
      ),
      ProductModel(
        id: 'p8',
        category: '🧹 পরিষ্কার-পরিচ্ছন্নতা (Cleaning)',
        title: 'ফ্লোর ক্লিনার (১ লিটার)',
        subtitle: 'ঘর পরিষ্কারে কার্যকর',
        price: 220,
        imageUrl:
            'https://images.pexels.com/photos/4239033/pexels-photo-4239033.jpeg?auto=compress&cs=tinysrgb&w=600',
        description: 'ফ্লোর ও টাইলস পরিষ্কার রাখতে লেবু সুগন্ধিযুক্ত ক্লিনার।',
      ),
      ProductModel(
        id: 'p9',
        category: '👶 বেবি প্রোডাক্ট',
        title: 'বেবি ডায়াপার (M সাইজ)',
        subtitle: 'নরম ও আরামদায়ক',
        price: 520,
        imageUrl:
            'https://images.pexels.com/photos/3933250/pexels-photo-3933250.jpeg?auto=compress&cs=tinysrgb&w=600',
        description: 'শিশুর আরাম ও সুরক্ষার জন্য নরম, শোষণক্ষম ডায়াপার।',
      ),
      ProductModel(
        id: 'p10',
        category: '🏠 গৃহস্থালি জিনিস (Home Essentials)',
        title: 'ফুড স্টোরেজ বক্স সেট',
        subtitle: 'রান্নাঘরে গোছানো রাখুন',
        price: 350,
        imageUrl:
            'https://images.pexels.com/photos/4239146/pexels-photo-4239146.jpeg?auto=compress&cs=tinysrgb&w=600',
        description:
            'শুকনা খাবার ও মসলা সংরক্ষণের জন্য টেকসই স্টোরেজ বক্স সেট।',
      ),
    ];
  }
}
