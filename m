Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A65D5E06FB
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 17:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731810AbfJVPFX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 11:05:23 -0400
Received: from mail-eopbgr10050.outbound.protection.outlook.com ([40.107.1.50]:20037
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731531AbfJVPFX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Oct 2019 11:05:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRs3FJ7DqHNELWE1lNY1EosX0piXTswj+1X6ar6SHDDLu6UVa64Ti1v1Fy6GGRsPt1BJcyYEJcFMMLKG98BWP4h2kn025yKWqFggYj1FFGeNif79z2F32HQBCgWnMfVY5miERdfNmTdVYVU6jV9S/l/b0hxK0t7gbqEH3agMgg4JmysWTAb4E2oLmeAQraYcvqoHva83ddeFnsijmt+oXboH5MTW79hzslYOtTICj4/WfCUL9fqMmboGNXi8lBsFv3d2ReOFjGgDT2G2+Hd9IIDPlGn50b+7pp7S7ottQqRSG5TVtFTAC7wkvOGIUrcGRbjsMavWgtlPa2zYmwNkIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2QEvrhiqF3JHU4Y+SVYP9jF1mW5Pf0ccZutthzvK64=;
 b=WAJT0wFWLvE0GYjjZJtYsO8aa/Bv4JdkRltmVosp9YZs0nkqDTAvouX0JK5Td3sxWTosGf4ekFejF2e66Xu66k4EH45PXV2Q+5Z6VyFghKPgx6W0bwII2ugLvtV18WRHlVMACDMiZGQTakT3jKpo66pc8nhEqsGoJ7NNQZGRFF4qvSCk/pLbcMDBVl5ycpDRfcM2x3xFwHH3BbTGh0qXdzvSp8xh+L3+0vV1QofhQxM8/5B0eve7CNBowhMChocs6Nrh2hYQLQgYloOYbowKoXUN+4HWGqgqkhjJIH8dMn5f4TFRVZ6x0r7j9w9H+ksE5G0xWJu0H12+mdwPS1KjDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2QEvrhiqF3JHU4Y+SVYP9jF1mW5Pf0ccZutthzvK64=;
 b=j2hQ+JJOKJpJLsHq6NLacNDa5w3fwfH5TLLti4xFq2enlRt8MaVW13xBzW2ehGzYe145b85PPVH7olmoFVu/k7fbU1zbyj5CUmUm0LGNYRhN6qvojqza1RW0Hm4jxrHJ7WtNbS14DHqlNRsWjxd+QCTyGy8ccLmyNRA10tchIXQ=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4814.eurprd05.prod.outlook.com (20.177.52.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 22 Oct 2019 15:05:18 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0%7]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 15:05:18 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Jerome Glisse <jglisse@redhat.com>
CC:     Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 2/3] mm/hmm: allow snapshot of the special zero page
Thread-Topic: [PATCH v2 2/3] mm/hmm: allow snapshot of the special zero page
Thread-Index: AQHVg5noYFRN6Uol1kOCsSoXbSSn1KdleVOAgAAi3oCAAGI6gIAAzpcA
Date:   Tue, 22 Oct 2019 15:05:18 +0000
Message-ID: <20191022150514.GH22766@mellanox.com>
References: <20191015204814.30099-1-rcampbell@nvidia.com>
 <20191015204814.30099-3-rcampbell@nvidia.com>
 <20191021184927.GG3177@redhat.com>
 <95fa45cf-a2ce-fab8-588d-8d806124aef3@nvidia.com>
 <20191022024549.GA4347@redhat.com>
In-Reply-To: <20191022024549.GA4347@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0100.namprd02.prod.outlook.com
 (2603:10b6:208:51::41) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e0884e9f-88a0-4e00-57b4-08d75701403d
x-ms-traffictypediagnostic: VI1PR05MB4814:
x-microsoft-antispam-prvs: <VI1PR05MB48146D78AB4CCAEB3E07E29ECF680@VI1PR05MB4814.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(189003)(199004)(102836004)(14454004)(476003)(33656002)(26005)(25786009)(186003)(71190400001)(71200400001)(2616005)(5660300002)(256004)(76176011)(52116002)(99286004)(486006)(66066001)(14444005)(446003)(386003)(6506007)(53546011)(11346002)(66446008)(64756008)(66556008)(66476007)(66946007)(6512007)(3846002)(2906002)(6116002)(86362001)(54906003)(6246003)(36756003)(8936002)(8676002)(316002)(66574012)(1076003)(4326008)(229853002)(6436002)(6486002)(305945005)(81156014)(81166006)(478600001)(6916009)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4814;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5AjAT+yAvSVvAf4rZzpdAbapSvwvz4ciOp4P2yP6abGPWDvQv5fbBW/ZeeDBE3n/dN5X8Secj/OCNCHK4M0IHodgmJfrw1Ozfog8tez5jVqhnPD5W3SoBj/aiXosunhdUINDPW76Jw7FlRxeG+PFiau0/3LbFHwhn6nlXMMYsk3NQ03YRh9OTJ6uKB9+fkmk0u93WOgIP9nFZfijSS3K8tT+W1HdTLolJ3/vIcVHmPcFgpd1XCFjEJFzd4Y4MBa8X6zH7qpT8wsw9hSbRiPVhdGhl48SJrUFzmyRB6CuZJZY9U5MaBkQi4huXDcDxrdH7yOvDHLlsc2SCX2EwUUf4Y86sHKPF27W3v+cK9v3Pw3Xj4qPJMJVr9kIljwUOEEwUPLP30m8uzHkdkB7mAFc+WlnQ2M6+anjbw/IIpjhWbTYw3CQGc/O9TS5u+m8T5+w
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A192D2D6F4A69E45801E683DDC0AC4E8@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0884e9f-88a0-4e00-57b4-08d75701403d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 15:05:18.2179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 79McZwsGsxstETlg870tKpvOhgicqQX2gEBTd2MVuqHi9lhDxHXBaEwt+dpqsdeRINCvVVp4VIjy+Le74qmtbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4814
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gTW9uLCBPY3QgMjEsIDIwMTkgYXQgMTA6NDU6NDlQTSAtMDQwMCwgSmVyb21lIEdsaXNzZSB3
cm90ZToNCj4gT24gTW9uLCBPY3QgMjEsIDIwMTkgYXQgMDE6NTQ6MTVQTSAtMDcwMCwgUmFscGgg
Q2FtcGJlbGwgd3JvdGU6DQo+ID4gDQo+ID4gT24gMTAvMjEvMTkgMTE6NDkgQU0sIEplcm9tZSBH
bGlzc2Ugd3JvdGU6DQo+ID4gPiBPbiBUdWUsIE9jdCAxNSwgMjAxOSBhdCAwMTo0ODoxM1BNIC0w
NzAwLCBSYWxwaCBDYW1wYmVsbCB3cm90ZToNCj4gPiA+ID4gQWxsb3cgaG1tX3JhbmdlX2ZhdWx0
KCkgdG8gcmV0dXJuIHN1Y2Nlc3MgKDApIHdoZW4gdGhlIENQVSBwYWdldGFibGUNCj4gPiA+ID4g
ZW50cnkgcG9pbnRzIHRvIHRoZSBzcGVjaWFsIHNoYXJlZCB6ZXJvIHBhZ2UuDQo+ID4gPiA+IFRo
ZSBjYWxsZXIgY2FuIHRoZW4gaGFuZGxlIHRoZSB6ZXJvIHBhZ2UgYnkgcG9zc2libHkgY2xlYXJp
bmcgZGV2aWNlDQo+ID4gPiA+IHByaXZhdGUgbWVtb3J5IGluc3RlYWQgb2YgRE1BaW5nIGEgemVy
byBwYWdlLg0KPiA+ID4gDQo+ID4gPiBJIGRvIG5vdCB1bmRlcnN0YW5kIHdoeSB5b3UgYXJlIHRh
bGtpbmcgYWJvdXQgRE1BLiBHUFUgY2FuIHdvcmsNCj4gPiA+IG9uIG1haW4gbWVtb3J5IGFuZCBt
aWdyYXRpbmcgdG8gR1BVIG1lbW9yeSBpcyBvcHRpb25hbCBhbmQgc2hvdWxkDQo+ID4gPiBub3Qg
aW52b2x2ZSB0aGlzIGZ1bmN0aW9uIGF0IGFsbC4NCj4gPiANCj4gPiBHb29kIHBvaW50LiBUaGlz
IGlzIHRoZSBkZXZpY2UgYWNjZXNzaW5nIHRoZSB6ZXJvIHBhZ2Ugb3ZlciBQQ0llDQo+ID4gb3Ig
YW5vdGhlciBidXMsIG5vdCBtaWdyYXRpbmcgYSB6ZXJvIHBhZ2UgdG8gZGV2aWNlIHByaXZhdGUg
bWVtb3J5Lg0KPiA+IEknbGwgdXBkYXRlIHRoZSB3b3JkaW5nLg0KPiA+IA0KPiA+ID4gPiANCj4g
PiA+ID4gU2lnbmVkLW9mZi1ieTogUmFscGggQ2FtcGJlbGwgPHJjYW1wYmVsbEBudmlkaWEuY29t
Pg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+
ID4gPiA+IENjOiAiSsOpcsO0bWUgR2xpc3NlIiA8amdsaXNzZUByZWRoYXQuY29tPg0KPiA+ID4g
PiBDYzogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPg0KPiA+ID4gDQo+ID4gPiBO
QUsgcGxlYXNlIGtlZXAgc2VtYW50aWMgb3IgY2hhbmdlIGl0IGZ1bGx5LiBTZWUgdGhlIGFsdGVy
bmF0aXZlDQo+ID4gPiBiZWxvdy4NCj4gPiA+IA0KPiA+ID4gPiAgIG1tL2htbS5jIHwgNCArKyst
DQo+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL21tL2htbS5jIGIvbW0vaG1tLmMNCj4g
PiA+ID4gaW5kZXggNWRmMGRiZjc3ZTg5Li5mNjJiMTE5NzIyYTMgMTAwNjQ0DQo+ID4gPiA+ICsr
KyBiL21tL2htbS5jDQo+ID4gPiA+IEBAIC01MzAsNyArNTMwLDkgQEAgc3RhdGljIGludCBobW1f
dm1hX2hhbmRsZV9wdGUoc3RydWN0IG1tX3dhbGsgKndhbGssIHVuc2lnbmVkIGxvbmcgYWRkciwN
Cj4gPiA+ID4gICAJCQlyZXR1cm4gLUVCVVNZOw0KPiA+ID4gPiAgIAl9IGVsc2UgaWYgKElTX0VO
QUJMRUQoQ09ORklHX0FSQ0hfSEFTX1BURV9TUEVDSUFMKSAmJiBwdGVfc3BlY2lhbChwdGUpKSB7
DQo+ID4gPiA+ICAgCQkqcGZuID0gcmFuZ2UtPnZhbHVlc1tITU1fUEZOX1NQRUNJQUxdOw0KPiA+
ID4gPiAtCQlyZXR1cm4gLUVGQVVMVDsNCj4gPiA+ID4gKwkJaWYgKCFpc196ZXJvX3BmbihwdGVf
cGZuKHB0ZSkpKQ0KPiA+ID4gPiArCQkJcmV0dXJuIC1FRkFVTFQ7DQo+ID4gPiA+ICsJCXJldHVy
biAwOw0KPiA+ID4gDQo+ID4gPiBBbiBhY2NlcHRhYmxlIGNoYW5nZSB3b3VsZCBiZSB0byB0dXJu
IHRoZSBicmFuY2ggaW50bzoNCj4gPiA+IAl9IGVsc2UgaWYgKElTX0VOQUJMRUQoQ09ORklHX0FS
Q0hfSEFTX1BURV9TUEVDSUFMKSAmJiBwdGVfc3BlY2lhbChwdGUpKSB7DQo+ID4gPiAJCWlmICgh
aXNfemVyb19wZm4ocHRlX3BmbihwdGUpKSkgew0KPiA+ID4gCQkJKnBmbiA9IHJhbmdlLT52YWx1
ZXNbSE1NX1BGTl9TUEVDSUFMXTsNCj4gPiA+IAkJCXJldHVybiAtRUZBVUxUOw0KPiA+ID4gCQl9
DQo+ID4gPiAJCS8qIEZhbGwtdGhyb3VnaCBmb3IgemVybyBwZm4gKGlmIHdyaXRlIHdhcyBuZWVk
ZWQgdGhlIGFib3ZlDQo+ID4gPiAJCSAqIGhtbV9wdGVfbmVlZF9mYXVsKCkgd291bGQgaGFkIGNh
dGNoZWQgaXQpLg0KPiA+ID4gCQkgKi8NCj4gPiA+IAl9DQo+ID4gPiANCj4gPiANCj4gPiBFeGNl
cHQgdGhpcyB3aWxsIHJldHVybiB0aGUgemVybyBwZm4gd2l0aCBubyBpbmRpY2F0aW9uIHRoYXQg
aXQgaXMgc3BlY2lhbA0KPiA+IChpLmUuLCBkb2Vzbid0IGhhdmUgYSBzdHJ1Y3QgcGFnZSkuDQo+
IA0KPiBUaGF0IGlzIGZpbmUsIHRoZSBkZXZpY2UgZHJpdmVyIHNob3VsZCBub3QgZG8gYW55dGhp
bmcgd2l0aCBpdCBpZQ0KPiBpZiB0aGUgZGV2aWNlIGRyaXZlciB3YW50ZWQgdG8gd3JpdGUgdGhl
biB0aGUgd3JpdGUgZmF1bHQgdGVzdA0KPiB3b3VsZCByZXR1cm4gdHJ1ZSBhbmQgaXQgd291bGQg
ZmF1bHQuDQo+IA0KPiBOb3RlIHRoYXQgZHJpdmVyIHNob3VsZCBub3QgZGVyZWZlcmVuY2UgdGhl
IHN0cnVjdCBwYWdlLg0KDQpDYW4gdGhpcyB0aGluZyBiZSBkbWEgbWFwcGVkIGZvciByZWFkPw0K
DQpKYXNvbg0K
