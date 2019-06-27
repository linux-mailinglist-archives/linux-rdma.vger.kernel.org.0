Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B82F586A1
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 18:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfF0QFv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 12:05:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:4296 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbfF0QFv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Jun 2019 12:05:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 09:05:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,424,1557212400"; 
   d="scan'208";a="164379711"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jun 2019 09:05:40 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Jun 2019 09:05:39 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.11.17]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.109]) with mapi id 14.03.0439.000;
 Thu, 27 Jun 2019 09:05:39 -0700
From:   "Hefty, Sean" <sean.hefty@intel.com>
To:     Ali Alnubani <alialnu@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] rsockets: fix variable initialization
Thread-Topic: [PATCH] rsockets: fix variable initialization
Thread-Index: AQHVLPhU9fQYhKi0uEW2GchrIipZraavqFXw
Date:   Thu, 27 Jun 2019 16:05:38 +0000
Message-ID: <1828884A29C6694DAF28B7E6B8A82373B3EB0374@ORSMSX109.amr.corp.intel.com>
References: <20190627145451.4591-1-alialnu@mellanox.com>
In-Reply-To: <20190627145451.4591-1-alialnu@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODAwNDI3NGYtNzdlZi00Mzc1LWEzYjYtOTdiMGRiMTViZmNkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicG9ObUwzWlpZQjBtMHpxMW11RWIwaXNVbitVNHFlRUZKaVVCc1lNNmNRcXdudHIzWFFGa3VXRzJhdlhmZlhyQSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBkaWZmIC0tZ2l0IGEvbGlicmRtYWNtL3Jzb2NrZXQuYyBiL2xpYnJkbWFjbS9yc29ja2V0LmMN
Cj4gaW5kZXggNThkZTI4NTYuLmFhOTEyYzFhIDEwMDY0NA0KPiAtLS0gYS9saWJyZG1hY20vcnNv
Y2tldC5jDQo+ICsrKyBiL2xpYnJkbWFjbS9yc29ja2V0LmMNCj4gQEAgLTIxMzMsNyArMjEzMyw3
IEBAIHN0YXRpYyBpbnQgcnNfcHJvY2Vzc19jcShzdHJ1Y3QgcnNvY2tldCAqcnMsIGludCBub25i
bG9jaywgaW50DQo+ICgqdGVzdCkoc3RydWN0IHJzDQo+IA0KPiAgc3RhdGljIGludCByc19nZXRf
Y29tcChzdHJ1Y3QgcnNvY2tldCAqcnMsIGludCBub25ibG9jaywgaW50ICgqdGVzdCkoc3RydWN0
IHJzb2NrZXQNCj4gKnJzKSkNCj4gIHsNCj4gLQl1aW50NjRfdCBzdGFydF90aW1lOw0KPiArCXVp
bnQ2NF90IHN0YXJ0X3RpbWUgPSAwOw0KPiAgCXVpbnQzMl90IHBvbGxfdGltZSA9IDA7DQo+ICAJ
aW50IHJldDsNCj4gDQo+IEBAIC0yMjkyLDcgKzIyOTIsNyBAQCBzdGF0aWMgaW50IGRzX3Byb2Nl
c3NfY3FzKHN0cnVjdCByc29ja2V0ICpycywgaW50IG5vbmJsb2NrLCBpbnQNCj4gKCp0ZXN0KShz
dHJ1Y3Qgcg0KPiANCj4gIHN0YXRpYyBpbnQgZHNfZ2V0X2NvbXAoc3RydWN0IHJzb2NrZXQgKnJz
LCBpbnQgbm9uYmxvY2ssIGludCAoKnRlc3QpKHN0cnVjdCByc29ja2V0DQo+ICpycykpDQo+ICB7
DQo+IC0JdWludDY0X3Qgc3RhcnRfdGltZTsNCj4gKwl1aW50NjRfdCBzdGFydF90aW1lID0gMDsN
Cj4gIAl1aW50MzJfdCBwb2xsX3RpbWUgPSAwOw0KPiAgCWludCByZXQ7DQo+IA0KPiBAQCAtMzMw
Niw3ICszMzA2LDcgQEAgc3RhdGljIGludCByc19wb2xsX2V2ZW50cyhzdHJ1Y3QgcG9sbGZkICpy
ZmRzLCBzdHJ1Y3QgcG9sbGZkDQo+ICpmZHMsIG5mZHNfdCBuZmRzKQ0KPiAgaW50IHJwb2xsKHN0
cnVjdCBwb2xsZmQgKmZkcywgbmZkc190IG5mZHMsIGludCB0aW1lb3V0KQ0KPiAgew0KPiAgCXN0
cnVjdCBwb2xsZmQgKnJmZHM7DQo+IC0JdWludDY0X3Qgc3RhcnRfdGltZTsNCj4gKwl1aW50NjRf
dCBzdGFydF90aW1lID0gMDsNCj4gIAl1aW50MzJfdCBwb2xsX3RpbWUgPSAwOw0KPiAgCWludCBw
b2xsc2xlZXAsIHJldDsNCg0KQmVjYXVzZSBwb2xsX3RpbWUgaXMgaW5pdGlhbGl6ZWQgdG8gMCwg
dGhlc2UgZW5kIHVwIGJlaW5nIGZhbHNlIHdhcm5pbmdzLiAgSG93ZXZlciwgaXQgbWF5IGJlIGNs
ZWFuZXIgdG8gaW5pdCBzdGFydF90aW1lID0gMCwgbGVhdmUgcG9sbF90aW1lIHVuaXRpYWxpemVk
LCBhbmQgY2hhbmdlIHRoZSBmb2xsb3dpbmcgY2hlY2sgZnVydGhlciBkb3duIGluIHRoZSBjb2Rl
Og0KDQoJaWYgKCFwb2xsX3RpbWUpIC0tPiBpZiAoIXN0YXJ0X3RpbWUpDQoJCXN0YXJ0X3RpbWUg
PSByc190aW1lX3VzKCk7DQoNClRoYXQgc2hvdWxkIGVsaW1pbmF0ZSB0aGUgd2FybmluZyBhbmQg
bGVhdmUgdGhlIGNvZGUgd2l0aCB0aGUgc2FtZSBudW1iZXIgb2YgYXNzaWdubWVudHMuDQoNCi0g
U2Vhbg0K
