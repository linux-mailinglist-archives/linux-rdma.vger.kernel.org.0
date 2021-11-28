Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3A54605D4
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Nov 2021 12:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345081AbhK1LRw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Nov 2021 06:17:52 -0500
Received: from mga17.intel.com ([192.55.52.151]:6299 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235611AbhK1LPw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 28 Nov 2021 06:15:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="216528351"
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="216528351"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 03:12:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="676009152"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga005.jf.intel.com with ESMTP; 28 Nov 2021 03:12:36 -0800
Received: from lcsmsx603.ger.corp.intel.com (10.109.210.12) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 28 Nov 2021 03:12:35 -0800
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX603.ger.corp.intel.com (10.109.210.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 28 Nov 2021 13:12:33 +0200
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.2308.020;
 Sun, 28 Nov 2021 13:12:33 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] mei: Remove some dead code
Thread-Topic: [PATCH] mei: Remove some dead code
Thread-Index: AQHX16z+MGID8V6pdUm1z2bNCeUOWqv/oKGAgBlBgNA=
Date:   Sun, 28 Nov 2021 11:12:33 +0000
Message-ID: <17d6896a6abf49138556e34cb426d575@intel.com>
References: <3f904c291f3eed06223dd8d494028e0d49df6f10.1636711522.git.christophe.jaillet@wanadoo.fr>
 <80B25490-FE92-420E-A506-C92A996EF174@oracle.com>
In-Reply-To: <80B25490-FE92-420E-A506-C92A996EF174@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.184.70.1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQo+IA0KPiANCj4gPiBPbiAxMiBOb3YgMjAyMSwgYXQgMTE6MDYsIENocmlzdG9waGUgSkFJTExF
VA0KPiA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI+IHdyb3RlOg0KPiA+DQo+ID4gJ2dl
bmVyYXRlZCcgaXMga25vd24gdG8gYmUgdHJ1ZSBoZXJlLCBzbyAidHJ1ZSB8fCB3aGF0ZXZlciIg
d2lsbCBzdGlsbA0KPiA+IGJlIHRydWUuDQo+ID4NCj4gPiBTbywgcmVtb3ZlIHNvbWUgZGVhZCBj
b2RlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoZSBKQUlMTEVUIDxjaHJpc3Rv
cGhlLmphaWxsZXRAd2FuYWRvby5mcj4NCj4gPiAtLS0NCj4gPiBUaGlzIGlzIGFsc28gbGlrZWx5
IHRoYXQgYSBidWcgaXMgbHVya2luZyBoZXJlLg0KPiA+DQo+ID4gTWF5YmUsIHRoZSBmb2xsb3dp
bmcgd2FzIGV4cGVjdGVkOg0KPiA+IC0JZ2VuZXJhdGVkID0gZ2VuZXJhdGVkIHx8DQo+ID4gKwln
ZW5lcmF0ZWQgPQ0KPiA+IAkJKGhpc3IgJiBISVNSX0lOVF9TVFNfTVNLKSB8fA0KPiA+IAkJKGlw
Y19pc3IgJiBTRUNfSVBDX0hPU1RfSU5UX1NUQVRVU19QRU5ESU5HKTsNCj4gPg0KPiA+ID8NCj4g
DQo+IEkgY29uY3VyIGFib3V0IHlvdXIgYW5hbHlzaXMsIGJ1dCBJIGRvIG5vdCBrbm93IHRoZSBp
bnRlbnQgaGVyZS4NCllvdXIgZml4ICBpcyBva2F5LCBJIGNhbiBhY2sgdGhhdCBwYXRjaC4gDQpU
aGFua3MNClRvbWFzDQoNCj4gDQo+IA0KPiBIw6Vrb24NCj4gDQo+ID4gLS0tDQo+ID4gZHJpdmVy
cy9taXNjL21laS9ody10eGUuYyB8IDYgKy0tLS0tDQo+ID4gMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bWlzYy9tZWkvaHctdHhlLmMgYi9kcml2ZXJzL21pc2MvbWVpL2h3LXR4ZS5jDQo+ID4gaW5kZXgg
YTRlODU0YjliOWU2Li4wMDY1MmMxMzdjYzcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9taXNj
L21laS9ody10eGUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWlzYy9tZWkvaHctdHhlLmMNCj4gPiBA
QCAtOTk0LDExICs5OTQsNyBAQCBzdGF0aWMgYm9vbCBtZWlfdHhlX2NoZWNrX2FuZF9hY2tfaW50
cnMoc3RydWN0DQo+IG1laV9kZXZpY2UgKmRldiwgYm9vbCBkb19hY2spDQo+ID4gCQloaGlzciAm
PSB+SVBDX0hISUVSX1NFQzsNCj4gPiAJfQ0KPiA+DQo+ID4gLQlnZW5lcmF0ZWQgPSBnZW5lcmF0
ZWQgfHwNCj4gPiAtCQkoaGlzciAmIEhJU1JfSU5UX1NUU19NU0spIHx8DQo+ID4gLQkJKGlwY19p
c3IgJiBTRUNfSVBDX0hPU1RfSU5UX1NUQVRVU19QRU5ESU5HKTsNCj4gPiAtDQo+ID4gLQlpZiAo
Z2VuZXJhdGVkICYmIGRvX2Fjaykgew0KPiA+ICsJaWYgKGRvX2Fjaykgew0KPiA+IAkJLyogU2F2
ZSB0aGUgaW50ZXJydXB0IGNhdXNlcyAqLw0KPiA+IAkJaHctPmludHJfY2F1c2UgfD0gaGlzciAm
IEhJU1JfSU5UX1NUU19NU0s7DQo+ID4gCQlpZiAoaXBjX2lzciAmIFNFQ19JUENfSE9TVF9JTlRf
U1RBVFVTX0lOX1JEWSkNCj4gPiAtLQ0KPiA+IDIuMzAuMg0KPiA+DQoNCg==
