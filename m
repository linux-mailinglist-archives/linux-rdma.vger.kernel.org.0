Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15E4B11EE65
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Dec 2019 00:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfLMXVq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Dec 2019 18:21:46 -0500
Received: from mail-eopbgr50077.outbound.protection.outlook.com ([40.107.5.77]:26499
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725945AbfLMXVq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 13 Dec 2019 18:21:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+zV0e6E7t8i/sV4F23IfgY1wk8rxBAuIl+0SrWbk95+hkVWYADpkokfrKLffol7Aq3O4SbiKZOanuGIjIHOthjt6+Nt0w57ww5S/8nMAf4iGw9+dw8EeDgR+Ksmb4Z6wyFGhaH3N6P2QTLhlHCXRaUlDvPa+F5yJT2STZqj54tVUrCWtWLqpqxEpVJ1351FgzBedVYQFsmlbjmHOXFzDZcRhZZPYEtoQENQMfxsxA6Q4jDP2UZkQqwkWyuqfrN06HmpmbjQ86w2WzEmzZ749/Hc+lAfTuxOH6QWr4HgbwKQE8NcQTPyTodlN4dy2mjO+W7Z3d9cie7Y9Hyf0/iapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCOF7TGA9YBkZdXQ1eEt9OjTTZHYkfPiigUuaPLA9JM=;
 b=XrEC7V1bF/uNOyFM/YbaCxQYRkqkivv1Wg7ejt2xc0is/NB0kixNRu7H05UTiZ2y30Jb6UAFaoiCKxTSxyxR3md42K+AJ16NLnh7BqHNPWylG7owRXVy/y7VMW4Nrepwyuj/1R+AHeMTah1RsVSXQ7mHuPMk13MIuPXCn5SHKd/m1iDURDqR+/kDguG9POfySc2QpUaCfvRByLPTTZypNrfDS2PS2gpbxYCNxqva8k4AJ4l8C6fL46o4Se4qmY6tyJyPIF47xUDD6dB8mteULD2zRwBcRegk09JxrdKgHEsmTVL/bozpOSV0rY2U+D++vTX8s5SJIoocsuyOJAU9Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCOF7TGA9YBkZdXQ1eEt9OjTTZHYkfPiigUuaPLA9JM=;
 b=nseocEiCeM745v8DqH1CCroxNRT9C8Ma8C+VWvck6pBAmoq9cQt21ecN8TaDcQ90YVfxnPsp8nLn3GAn+P6GA/fOV/DW7GzRUWE3+d0I/AfPZuBm2MXGEeXURYYXYB+CgqonsjRklpqEZ2oCfZzXJ2Tfe+nfyfMd01RE+sNsQ70=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB4980.eurprd05.prod.outlook.com (20.176.215.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.17; Fri, 13 Dec 2019 23:21:39 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::16:9951:5a4b:9ec6]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::16:9951:5a4b:9ec6%7]) with mapi id 15.20.2538.017; Fri, 13 Dec 2019
 23:21:39 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: Re: [PATCH for-next 2/2] RDMA/bnxt_re: Retrieve the driver gid
 context from gid_attr
Thread-Topic: [PATCH for-next 2/2] RDMA/bnxt_re: Retrieve the driver gid
 context from gid_attr
Thread-Index: AQHVsNYbcbM5szuwQUejjyv5ioxE5Ke4tnYA
Date:   Fri, 13 Dec 2019 23:21:39 +0000
Message-ID: <7fad633e-69ca-363f-e411-d77baee8ccba@mellanox.com>
References: <1576146143-28264-1-git-send-email-selvin.xavier@broadcom.com>
 <1576146143-28264-3-git-send-email-selvin.xavier@broadcom.com>
In-Reply-To: <1576146143-28264-3-git-send-email-selvin.xavier@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [107.77.232.237]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87a17373-7678-4ced-d4ea-08d780233506
x-ms-traffictypediagnostic: AM0PR05MB4980:
x-microsoft-antispam-prvs: <AM0PR05MB49803A4D73B58BADF785818ED1540@AM0PR05MB4980.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(189003)(199004)(81156014)(110136005)(81166006)(316002)(36756003)(54906003)(64756008)(76116006)(66946007)(66476007)(66556008)(91956017)(66446008)(8676002)(2906002)(71200400001)(186003)(478600001)(8936002)(6506007)(4326008)(26005)(53546011)(31696002)(31686004)(6486002)(2616005)(5660300002)(86362001)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4980;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aMv6amoZF3CURSfUvfxgVKfy6qW50a0y2tAARENtDuibDGwjuaYF1YKM4kK7t601jLpUzScPtuBrGQN1xvuzrU7jCPMPsp81sRCmtY081PUkooe/yztbN4rjwvYRo7b2xXrHdoxUrBkOA7g9juLG3o8+cM3RlVcxJOOEwW+/irKV9EGWrKJA/Ea871/lDJZAbg/BtcN2n5ywKipvYXZfsI9HoBhJUaxmwwIThvUiElUdcnw3TWdNRvU+khbdyIBOfpnMW5wgUOzLpsYTMaqTFVv50X6oZOIlvrdDrVQW0ayaG4ArsL1Ib9qPcd9TfchebXmzd/hLHAwN5A1NbTQiwc575oJZM3YOzKyHruNza8mBlCz4R19OZ84S9O1e+NA6Nq2TfNCOMYweBRsD4cEiV71vgk6LZfCuT2zvmLEFKQZpxYg06xvHJWlhYtTYpelX
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CCEF0F4D6710D46B9A5BAEC8C089AA2@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a17373-7678-4ced-d4ea-08d780233506
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 23:21:39.7075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FGLr78qukmjwRuQ51xBKqQphMrOIMtfZyVNvNe3Ewxh5/Zx4rUIOe6CGymCrXI/LgPk1lmPEvkZzzIPpXBpgiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4980
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMTIvMTIvMjAxOSAzOjUyIFBNLCBTZWx2aW4gWGF2aWVyIHdyb3RlOg0KPiBVc2UgdGhlIGNv
bnRhaW5lcl9vZiBtYWNybyB0byByZXRyaWV2ZSB0aGUgZHJpdmVyIGdpZA0KPiBjb250ZXh0Lg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogRGV2ZXNoIFNoYXJtYSA8ZGV2ZXNoLnNoYXJtYUBicm9hZGNv
bS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNlbHZpbiBYYXZpZXIgPHNlbHZpbi54YXZpZXJAYnJv
YWRjb20uY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9ibnh0X3JlL2liX3Zl
cmJzLmMgfCAyOCArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pbmZpbmliYW5kL2h3L2JueHRfcmUvaWJfdmVyYnMuYyBiL2RyaXZlcnMvaW5maW5p
YmFuZC9ody9ibnh0X3JlL2liX3ZlcmJzLmMNCj4gaW5kZXggYWQ1MTEyYS4uYmQ2NTdmYiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L2JueHRfcmUvaWJfdmVyYnMuYw0KPiAr
KysgYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvYm54dF9yZS9pYl92ZXJicy5jDQo+IEBAIC02NDAs
NiArNjQwLDggQEAgaW50IGJueHRfcmVfY3JlYXRlX2FoKHN0cnVjdCBpYl9haCAqaWJfYWgsIHN0
cnVjdCByZG1hX2FoX2F0dHIgKmFoX2F0dHIsDQo+ICAJc3RydWN0IGJueHRfcmVfZGV2ICpyZGV2
ID0gcGQtPnJkZXY7DQo+ICAJY29uc3Qgc3RydWN0IGliX2dpZF9hdHRyICpzZ2lkX2F0dHI7DQo+
ICAJc3RydWN0IGJueHRfcmVfYWggKmFoID0gY29udGFpbmVyX29mKGliX2FoLCBzdHJ1Y3QgYm54
dF9yZV9haCwgaWJfYWgpOw0KPiArCXN0cnVjdCBpYl9naWRfYXR0cl9pbmZvICppbmZvOw0KPiAr
CXN0cnVjdCBibnh0X3JlX2dpZF9jdHggKmN0eCA9IE5VTEw7DQpjdHggaXMgYWx3eWFzIGFzaWdu
ZWQgd2l0aG91dCBhbnkgY29uZGl0aW9uIGZyb20gaW5mby4NClNvIG5vIG5lZWQgZm9yIG51bGwg
aW5pdGlhbHphdGlvbi4NCg0KPiAgCXU4IG53X3R5cGU7DQo+ICAJaW50IHJjOw0KPiAgDQo+IEBA
IC02NTEsMjIgKzY1MywyMSBAQCBpbnQgYm54dF9yZV9jcmVhdGVfYWgoc3RydWN0IGliX2FoICpp
Yl9haCwgc3RydWN0IHJkbWFfYWhfYXR0ciAqYWhfYXR0ciwNCj4gIAlhaC0+cmRldiA9IHJkZXY7
DQo+ICAJYWgtPnFwbGliX2FoLnBkID0gJnBkLT5xcGxpYl9wZDsNCj4gIA0KPiArCXNnaWRfYXR0
ciA9IGdyaC0+c2dpZF9hdHRyOw0KPiArDQo+ICsJaW5mbyA9IGNvbnRhaW5lcl9vZihzZ2lkX2F0
dHIsIHN0cnVjdCBpYl9naWRfYXR0cl9pbmZvLCBhdHRyKTsNCj4gKwljdHggPSBpbmZvLT5jb250
ZXh0Ow0KPiArDQo+ICAJLyogU3VwcGx5IHRoZSBjb25maWd1cmF0aW9uIGZvciB0aGUgSFcgKi8N
Cj4gIAltZW1jcHkoYWgtPnFwbGliX2FoLmRnaWQuZGF0YSwgZ3JoLT5kZ2lkLnJhdywNCj4gIAkg
ICAgICAgc2l6ZW9mKHVuaW9uIGliX2dpZCkpOw0KPiAtCS8qDQo+IC0JICogSWYgUm9DRSBWMiBp
cyBlbmFibGVkLCBzdGFjayB3aWxsIGhhdmUgdHdvIGVudHJpZXMgZm9yDQo+IC0JICogZWFjaCBH
SUQgZW50cnkuIEF2b2lkaW5nIHRoaXMgZHVwbGljdGUgZW50cnkgaW4gSFcuIERpdmlkaW5nDQo+
IC0JICogdGhlIEdJRCBpbmRleCBieSAyIGZvciBSb0NFIFYyDQo+IC0JICovDQo+IC0JYWgtPnFw
bGliX2FoLnNnaWRfaW5kZXggPSBncmgtPnNnaWRfaW5kZXggLyAyOw0KPiArCWFoLT5xcGxpYl9h
aC5zZ2lkX2luZGV4ID0gY3R4LT5pZHg7DQo+ICAJYWgtPnFwbGliX2FoLmhvc3Rfc2dpZF9pbmRl
eCA9IGdyaC0+c2dpZF9pbmRleDsNCj4gIAlhaC0+cXBsaWJfYWgudHJhZmZpY19jbGFzcyA9IGdy
aC0+dHJhZmZpY19jbGFzczsNCj4gIAlhaC0+cXBsaWJfYWguZmxvd19sYWJlbCA9IGdyaC0+Zmxv
d19sYWJlbDsNCj4gIAlhaC0+cXBsaWJfYWguaG9wX2xpbWl0ID0gZ3JoLT5ob3BfbGltaXQ7DQo+
ICAJYWgtPnFwbGliX2FoLnNsID0gcmRtYV9haF9nZXRfc2woYWhfYXR0cik7DQo+ICANCj4gLQlz
Z2lkX2F0dHIgPSBncmgtPnNnaWRfYXR0cjsNCj4gIAkvKiBHZXQgbmV0d29yayBoZWFkZXIgdHlw
ZSBmb3IgdGhpcyBHSUQgKi8NCj4gIAlud190eXBlID0gcmRtYV9naWRfYXR0cl9uZXR3b3JrX3R5
cGUoc2dpZF9hdHRyKTsNCj4gIAlhaC0+cXBsaWJfYWgubndfdHlwZSA9IGJueHRfcmVfc3RhY2tf
dG9fZGV2X253X3R5cGUobndfdHlwZSk7DQo+IEBAIC0xNTIxLDYgKzE1MjIsOCBAQCBpbnQgYm54
dF9yZV9tb2RpZnlfcXAoc3RydWN0IGliX3FwICppYl9xcCwgc3RydWN0IGliX3FwX2F0dHIgKnFw
X2F0dHIsDQo+ICAJc3RydWN0IGJueHRfcmVfZGV2ICpyZGV2ID0gcXAtPnJkZXY7DQo+ICAJc3Ry
dWN0IGJueHRfcXBsaWJfZGV2X2F0dHIgKmRldl9hdHRyID0gJnJkZXYtPmRldl9hdHRyOw0KPiAg
CWVudW0gaWJfcXBfc3RhdGUgY3Vycl9xcF9zdGF0ZSwgbmV3X3FwX3N0YXRlOw0KPiArCXN0cnVj
dCBpYl9naWRfYXR0cl9pbmZvICppbmZvOw0KPiArCXN0cnVjdCBibnh0X3JlX2dpZF9jdHggKmN0
eCA9IE5VTEw7DQo+ICAJaW50IHJjLCBlbnRyaWVzOw0KPiAgCXVuc2lnbmVkIGludCBmbGFnczsN
Cj4gIAl1OCBud190eXBlOw0KPiBAQCAtMTU5Miw2ICsxNTk1LDEwIEBAIGludCBibnh0X3JlX21v
ZGlmeV9xcChzdHJ1Y3QgaWJfcXAgKmliX3FwLCBzdHJ1Y3QgaWJfcXBfYXR0ciAqcXBfYXR0ciwN
Cj4gIAkJCXJkbWFfYWhfcmVhZF9ncmgoJnFwX2F0dHItPmFoX2F0dHIpOw0KPiAgCQljb25zdCBz
dHJ1Y3QgaWJfZ2lkX2F0dHIgKnNnaWRfYXR0cjsNCj4gIA0KPiArCQlzZ2lkX2F0dHIgPSBxcF9h
dHRyLT5haF9hdHRyLmdyaC5zZ2lkX2F0dHI7DQo+ICsJCWluZm8gPSBjb250YWluZXJfb2Yoc2dp
ZF9hdHRyLCBzdHJ1Y3QgaWJfZ2lkX2F0dHJfaW5mbywgYXR0cik7DQo+ICsJCWN0eCA9IGluZm8t
PmNvbnRleHQ7DQo+ICsNCj4gIAkJcXAtPnFwbGliX3FwLm1vZGlmeV9mbGFncyB8PSBDTURRX01P
RElGWV9RUF9NT0RJRllfTUFTS19ER0lEIHwNCj4gIAkJCQkgICAgIENNRFFfTU9ESUZZX1FQX01P
RElGWV9NQVNLX0ZMT1dfTEFCRUwgfA0KPiAgCQkJCSAgICAgQ01EUV9NT0RJRllfUVBfTU9ESUZZ
X01BU0tfU0dJRF9JTkRFWCB8DQo+IEBAIC0xNjAyLDExICsxNjA5LDcgQEAgaW50IGJueHRfcmVf
bW9kaWZ5X3FwKHN0cnVjdCBpYl9xcCAqaWJfcXAsIHN0cnVjdCBpYl9xcF9hdHRyICpxcF9hdHRy
LA0KPiAgCQltZW1jcHkocXAtPnFwbGliX3FwLmFoLmRnaWQuZGF0YSwgZ3JoLT5kZ2lkLnJhdywN
Cj4gIAkJICAgICAgIHNpemVvZihxcC0+cXBsaWJfcXAuYWguZGdpZC5kYXRhKSk7DQo+ICAJCXFw
LT5xcGxpYl9xcC5haC5mbG93X2xhYmVsID0gZ3JoLT5mbG93X2xhYmVsOw0KPiAtCQkvKiBJZiBS
b0NFIFYyIGlzIGVuYWJsZWQsIHN0YWNrIHdpbGwgaGF2ZSB0d28gZW50cmllcyBmb3INCj4gLQkJ
ICogZWFjaCBHSUQgZW50cnkuIEF2b2lkaW5nIHRoaXMgZHVwbGljdGUgZW50cnkgaW4gSFcuIERp
dmlkaW5nDQo+IC0JCSAqIHRoZSBHSUQgaW5kZXggYnkgMiBmb3IgUm9DRSBWMg0KPiAtCQkgKi8N
Cj4gLQkJcXAtPnFwbGliX3FwLmFoLnNnaWRfaW5kZXggPSBncmgtPnNnaWRfaW5kZXggLyAyOw0K
PiArCQlxcC0+cXBsaWJfcXAuYWguc2dpZF9pbmRleCA9IGN0eC0+aWR4Ow0KPiAgCQlxcC0+cXBs
aWJfcXAuYWguaG9zdF9zZ2lkX2luZGV4ID0gZ3JoLT5zZ2lkX2luZGV4Ow0KPiAgCQlxcC0+cXBs
aWJfcXAuYWguaG9wX2xpbWl0ID0gZ3JoLT5ob3BfbGltaXQ7DQo+ICAJCXFwLT5xcGxpYl9xcC5h
aC50cmFmZmljX2NsYXNzID0gZ3JoLT50cmFmZmljX2NsYXNzOw0KPiBAQCAtMTYxNCw3ICsxNjE3
LDYgQEAgaW50IGJueHRfcmVfbW9kaWZ5X3FwKHN0cnVjdCBpYl9xcCAqaWJfcXAsIHN0cnVjdCBp
Yl9xcF9hdHRyICpxcF9hdHRyLA0KPiAgCQlldGhlcl9hZGRyX2NvcHkocXAtPnFwbGliX3FwLmFo
LmRtYWMsDQo+ICAJCQkJcXBfYXR0ci0+YWhfYXR0ci5yb2NlLmRtYWMpOw0KPiAgDQo+IC0JCXNn
aWRfYXR0ciA9IHFwX2F0dHItPmFoX2F0dHIuZ3JoLnNnaWRfYXR0cjsNCj4gIAkJcmMgPSByZG1h
X3JlYWRfZ2lkX2wyX2ZpZWxkcyhzZ2lkX2F0dHIsIE5VTEwsDQo+ICAJCQkJCSAgICAgJnFwLT5x
cGxpYl9xcC5zbWFjWzBdKTsNCj4gIAkJaWYgKHJjKQ0KPiANCg0K
