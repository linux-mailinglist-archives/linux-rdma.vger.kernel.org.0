Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4FC66A78
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 11:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfGLJtt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 05:49:49 -0400
Received: from mail-eopbgr50046.outbound.protection.outlook.com ([40.107.5.46]:24077
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbfGLJts (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Jul 2019 05:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42v6ksylWm05fuwaDYP/bk+Laya2OZku8YBShJn/O/E=;
 b=jsGueN4jaaO+tkYMLQyralZjJm3u1tTSE0LXh7uJ4EeMzoKmgF1c6+rkiCRz+56QDmrzpAYA3KjnuQrzVhTmX5YfGZqAtyoXJ1LecV0fbmBSrkcyVXPgy2uwGZX3RTzQk+TjO82nP+p85U15tE2W7CgCEtUwmYsLE3ftChsfx4Y=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB5298.eurprd05.prod.outlook.com (20.178.18.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Fri, 12 Jul 2019 09:49:43 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::217d:2cd7:c8da:9279]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::217d:2cd7:c8da:9279%5]) with mapi id 15.20.2052.020; Fri, 12 Jul 2019
 09:49:43 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
CC:     Yi Zhang <yi.zhang@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: RE: regression: nvme rdma with bnxt_re0 broken
Thread-Topic: regression: nvme rdma with bnxt_re0 broken
Thread-Index: 2UfSPBB7aurhIBgBOMtlZZ/Acg5lQJrLV3lwgAA5BsCAAKCFgIAAD6MggAAPzICAAF+3EIAAAyXAgAACz1A=
Date:   Fri, 12 Jul 2019 09:49:42 +0000
Message-ID: <AM0PR05MB4866665D5CACB34AE885BCA2D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <1310083272.27124086.1562836112586.JavaMail.zimbra@redhat.com>
 <619411460.27128070.1562838433020.JavaMail.zimbra@redhat.com>
 <AM0PR05MB48664657022ECA8526E3C967D1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866070FBADCCABD1F84E42ED1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <66d43fd8-18e8-8b9d-90e3-ee2804d56889@redhat.com>
 <AM0PR05MB4866DEDB9DE4379F6A6EF15BD1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <CA+sbYW17PGAW57pyRmQB9KsDA9Q+7FFgSseSTTWE_h6vffa7UQ@mail.gmail.com>
 <AM0PR05MB4866CFEDCDF3CDA1D7D18AA5D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866CCD487C9D99BD9526BA8D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
In-Reply-To: <AM0PR05MB4866CCD487C9D99BD9526BA8D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [49.207.52.95]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6361df0a-d476-4069-1cd5-08d706ae43fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR05MB5298;
x-ms-traffictypediagnostic: AM0PR05MB5298:
x-microsoft-antispam-prvs: <AM0PR05MB5298A285A5545FB178D571DDD1F20@AM0PR05MB5298.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(13464003)(189003)(199004)(229853002)(6436002)(66946007)(6246003)(8936002)(6506007)(55236004)(52536014)(9686003)(8676002)(64756008)(66476007)(66446008)(76176011)(66066001)(66556008)(55016002)(2940100002)(7696005)(6916009)(86362001)(54906003)(186003)(53936002)(53546011)(102836004)(316002)(26005)(99286004)(14444005)(446003)(476003)(11346002)(3846002)(6116002)(68736007)(478600001)(71190400001)(81156014)(81166006)(76116006)(4326008)(7736002)(14454004)(71200400001)(5660300002)(25786009)(2906002)(486006)(74316002)(305945005)(33656002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5298;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: td4ayi/QrxshKe088j0DmyInl6NaaKBrhnRUp78S+qMNCSS+T4TbpTIVP2UFZs6QYt3oWUN7LVZGYIMxwBIc+RI+bNKoshhP3bdbXHTcbqj92xm0ZcMpySbtoKdJmmdxrYw4i01MN2lYQ7CNK2smIyTE+jG0Aw2+CiYdGvWv9swpC45rZt3lLvYz/U+++eti5CXesi1OuSeDT5v2ynpAc2/YnuYyAqw/Dwy4jehOrV80nCTSHsdSBy67jlgtY85SBJDo6H82eZnuUXlI5FF1xoRfDaKb8nqmF4luK5UJ6i5qd2yT8cDEpopTF5g9f0vpf8fU5yP0rqkuVUSh5pIaF9wn5MS4JWI6V8z4gxZnxKBJnCB6u13Z48Ik1uy4pdKbb+loRu8H5/9V6ZY3cTEwyut5fQ8QWtOJRTo1DqXFDeM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6361df0a-d476-4069-1cd5-08d706ae43fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 09:49:42.9866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: parav@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5298
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQo+ID4gSGkgU2VsdmluLA0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+ID4gRnJvbTogU2VsdmluIFhhdmllciA8c2VsdmluLnhhdmllckBicm9hZGNvbS5jb20+DQo+
ID4gPiBTZW50OiBGcmlkYXksIEp1bHkgMTIsIDIwMTkgOToxNiBBTQ0KPiA+ID4gVG86IFBhcmF2
IFBhbmRpdCA8cGFyYXZAbWVsbGFub3guY29tPg0KPiA+ID4gQ2M6IFlpIFpoYW5nIDx5aS56aGFu
Z0ByZWRoYXQuY29tPjsgbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gRGFu
aWVsIEp1cmdlbnMgPGRhbmllbGpAbWVsbGFub3guY29tPjsgbGludXgtcmRtYUB2Z2VyLmtlcm5l
bC5vcmc7DQo+ID4gPiBEZXZlc2ggU2hhcm1hIDxkZXZlc2guc2hhcm1hQGJyb2FkY29tLmNvbT4N
Cj4gPiA+IFN1YmplY3Q6IFJlOiByZWdyZXNzaW9uOiBudm1lIHJkbWEgd2l0aCBibnh0X3JlMCBi
cm9rZW4NCj4gPiA+DQo+ID4gPiBPbiBGcmksIEp1bCAxMiwgMjAxOSBhdCA4OjE5IEFNIFBhcmF2
IFBhbmRpdCA8cGFyYXZAbWVsbGFub3guY29tPg0KPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4g
R0lEIHRhYmxlIGxvb2tzIGZpbmUuDQo+ID4gPiA+DQo+ID4gPiBUaGUgR0lEIHRhYmxlIGhhcyAg
ZmU4MDowMDAwOjAwMDA6MDAwMDowMjBhOmY3ZmY6ZmVlMzo2ZTMyIGVudHJ5DQo+ID4gPiByZXBl
YXRlZCA2IHRpbWVzLiAyIGZvciBlYWNoIGludGVyZmFjZSBibnh0X3JvY2UsIGJueHRfcm9jZS40
MyBhbmQNCj4gPiA+IGJueHRfcm9jZS40NS4gSXMgdGhpcyBleHBlY3RlZCB0byBoYXZlIHNhbWUg
Z2lkIGVudHJpZXMgZm9yIHZsYW4gYW5kDQo+ID4gPiBiYXNlIGludGVyZmFjZXM/IEFzIHlvdSBt
ZW50aW9uZWQgZWFybGllciwgZHJpdmVyJ3MgYXNzdW1wdGlvbiB0aGF0DQo+ID4gPiBvbmx5IDIg
R0lEIGVudHJpZXMgaWRlbnRpY2FsIChvbmUgZm9yIFJvQ0UgdjEgYW5kIG9uZSBmb3IgUm9DRQ0K
PiA+ID4gdjIpICAgaXMgYnJlYWtpbmcgaGVyZS4NCj4gPiA+DQo+ID4gWWVzLCB0aGlzIGlzIGNv
cnJlY3QgYmVoYXZpb3IuIEVhY2ggdmxhbiBuZXRkZXYgaW50ZXJmYWNlIGlzIGluDQo+ID4gZGlm
ZmVyZW50IEwyIHNlZ21lbnQuDQo+ID4gVmxhbiBuZXRkZXYgaGFzIHRoaXMgaXB2NiBsaW5rIGxv
Y2FsIGFkZHJlc3MuIEhlbmNlLCBpdCBpcyBhZGRlZCB0byB0aGUgR0lEDQo+IHRhYmxlLg0KPiA+
IEEgZ2l2ZW4gR0lEIHRhYmxlIGVudHJ5IGlzIGlkZW50aWZpZWQgdW5pcXVlbHkgYnkgR0lEK25k
ZXYrdHlwZSh2MS92MikuDQo+ID4NCj4gPiBSZXZpZXdpbmcgYm54dF9xcGxpYl9hZGRfc2dpZCgp
IGRvZXMgdGhlIGNvbXBhcmlzb24gYmVsb3cuDQo+ID4gaWYgKCFtZW1jbXAoJnNnaWRfdGJsLT50
YmxbaV0sIGdpZCwgc2l6ZW9mKCpnaWQpKSkgew0KPiA+DQo+ID4gVGhpcyBjb21wYXJpc29uIGxv
b2tzIGluY29tcGxldGUgd2hpY2ggaWdub3JlIG5ldGRldiBhbmQgdHlwZS4NCj4gPiBCdXQgZXZl
biB3aXRoIHRoYXQsIEkgd291bGQgZXhwZWN0IEdJRCBlbnRyeSBhZGRpdGlvbiBmYWlsdXJlIGZv
cg0KPiA+IHZsYW5zIGZvciBpcHY2IGxpbmsgbG9jYWwgZW50cmllcy4NCj4gPg0KPiA+IEJ1dCBJ
IGFtIHB1enpsZWQgbm93LCB0aGF0ICwgd2l0aCBhYm92ZSBtZW1jbXAoKSBjaGVjaywgaG93IGRv
ZXMgYm90aA0KPiA+IHYxIGFuZCB2MiBlbnRyaWVzIGdldCBhZGRlZCBpbiB5b3VyIHRhYmxlIGFu
ZCBmb3IgdmxhbnMgdG9vPw0KPiA+IEkgZXhwZWN0IGFkZF9naWQoKSBhbmQgY29yZS9jYWNoZS5j
IGFkZF9yb2NlX2dpZCAoKSB0byBmYWlsIGZvciB0aGUNCj4gPiBkdXBsaWNhdGUgZW50cnkuDQo+
ID4gQnV0IEdJRCB0YWJsZSB0aGF0IFlpIFpoYW5nIGR1bXBlZCBoYXMgdGhlc2UgdmxhbiBlbnRy
aWVzLg0KPiA+IEkgYW0gbWlzc2luZyBzb21ldGhpbmcuDQo+ID4NCj4gQWgsIGZvdW5kIGl0Lg0K
PiBibnh0X3JlX2FkZF9naWQoKSBjaGVja3MgZm9yIC1FQUxSRUFEWSBhbmQgcmV0dXJucyAwIHRv
IGFkZF9naWQoKSBjYWxsYmFjay4NCj4gT2suIHNvIHlvdSBqdXN0IG5lZWQgdG8gZXh0ZW5kIGJu
eHRfcXBsaWJfYWRkX3NnaWQoKSBmb3IgY29uc2lkZXJpbmcgdmxhbiB0b28uDQo+IExldCBtZSBz
ZWUgaWYgSSBjYW4gc2hhcmUgYSBwYXRjaCBpbiBmZXcgbWludXRlcy4NCj4gDQo+ID4gWWkgWmhh
bmcsDQo+ID4gSW5zdGVhZCBvZiBsYXN0IDE1IGxpbmVzIG9mIGRtZXNnLCBjYW4geW91IHBsZWFz
ZSBzaGFyZSB0aGUgd2hvbGUgZG1zZw0KPiA+IGxvZyB3aGljaCBzaG91bGQgYmUgZW5hYmxlZCBi
ZWZvcmUgY3JlYXRpbmcgdmxhbnMuDQo+ID4gdXNpbmcNCj4gPiBlY2hvIC1uICJtb2R1bGUgaWJf
Y29yZSArcCIgL3N5cy9rZXJuZWwvZGVidWcvZHluYW1pY19kZWJ1Zy9jb250cm9sDQo+ID4NCj4g
PiBTZWx2aW4sDQo+ID4gQWRkaXRpb25hbGx5LCBkcml2ZXIgc2hvdWxkbid0IGJlIGxvb2tpbmcg
YXQgdGhlIGR1cGxpY2F0ZSBlbnRyaWVzLg0KPiA+IGNvcmUgYWxyZWFkeSBkb2VzIGl0Lg0KPiA+
IFlvdSBtaWdodCBvbmx5IHdhbnQgdG8gZG8gZm9yIHYxL3YyIGNhc2UgYXMgYm54dCBkcml2ZXIg
aGFzIHNvbWUNCj4gPiBkZXBlbmRlbmN5IHdpdGggaXQuDQo+ID4gQ2FuIHlvdSBwbGVhc2UgZml4
IHRoaXMgcGFydD8NCj4gPg0KDQpIb3cgYWJvdXQgYmVsb3cgZml4Pw0KDQpGcm9tIGYzZjE3MDA4
ZDM0YjVhMGMzOGMxOTAwMTAyODFhMzAzMGE4ZTU3NzEgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAx
DQpGcm9tOiBQYXJhdiBQYW5kaXQgPHBhcmF2QG1lbGxhbm94LmNvbT4NCkRhdGU6IEZyaSwgMTIg
SnVsIDIwMTkgMDQ6MzQ6NTIgLTA1MDANClN1YmplY3Q6IFtQQVRDSF0gSUIvYm54dF9yZTogSG9u
b3Igdmxhbl9pZCBpbiBHSUQgZW50cnkgY29tcGFyaXNpb24NCg0KR0lEIGVudHJ5IGNvbnNpc3Qg
b2YgR0lELCB2bGFuLCBuZXRkZXYgYW5kIHNtYWMuDQpFeHRlbmQgR0lEIGR1cGxpY2F0ZSBjaGVj
ayBjb21wYXJpb25zIHRvIGNvbnNpZGVyIHZsYW5faWQgYXMgd2VsbA0KdG8gc3VwcG9ydCBJUHY2
IFZMQU4gYmFzZWQgbGluayBsb2NhbCBhZGRyZXNzZXMuDQoNCkZpeGVzOiA4MjNiMjNkYTcxMTMg
KCJJQi9jb3JlOiBBbGxvdyB2bGFuIGxpbmsgbG9jYWwgYWRkcmVzcyBiYXNlZCBSb0NFIEdJRHMi
KQ0KQ2hhbmdlLUlkOiBJMmUwMjZlYzgwNjVjODQyNWJhMjRmYWQ4NTI1MzIzZDExMmEyZjRlNA0K
U2lnbmVkLW9mZi1ieTogUGFyYXYgUGFuZGl0IDxwYXJhdkBtZWxsYW5veC5jb20+DQotLS0NCiBk
cml2ZXJzL2luZmluaWJhbmQvaHcvYm54dF9yZS9xcGxpYl9zcC5jIHwgNCArKystDQogZHJpdmVy
cy9pbmZpbmliYW5kL2h3L2JueHRfcmUvcXBsaWJfc3AuaCB8IDEgKw0KIDIgZmlsZXMgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2luZmluaWJhbmQvaHcvYm54dF9yZS9xcGxpYl9zcC5jIGIvZHJpdmVycy9pbmZpbmliYW5kL2h3
L2JueHRfcmUvcXBsaWJfc3AuYw0KaW5kZXggNDg3OTNkMzUxMmFjLi44NTY3YjczNjc2NjkgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvYm54dF9yZS9xcGxpYl9zcC5jDQorKysg
Yi9kcml2ZXJzL2luZmluaWJhbmQvaHcvYm54dF9yZS9xcGxpYl9zcC5jDQpAQCAtMjk2LDcgKzI5
Niw4IEBAIGludCBibnh0X3FwbGliX2FkZF9zZ2lkKHN0cnVjdCBibnh0X3FwbGliX3NnaWRfdGJs
ICpzZ2lkX3RibCwNCiAJfQ0KIAlmcmVlX2lkeCA9IHNnaWRfdGJsLT5tYXg7DQogCWZvciAoaSA9
IDA7IGkgPCBzZ2lkX3RibC0+bWF4OyBpKyspIHsNCi0JCWlmICghbWVtY21wKCZzZ2lkX3RibC0+
dGJsW2ldLCBnaWQsIHNpemVvZigqZ2lkKSkpIHsNCisJCWlmICghbWVtY21wKCZzZ2lkX3RibC0+
dGJsW2ldLCBnaWQsIHNpemVvZigqZ2lkKSkgJiYNCisJCSAgICBzZ2lkX3RibC0+dGJsW2ldLnZs
YW5faWQgPT0gdmxhbl9pZCkgew0KIAkJCWRldl9kYmcoJnJlcy0+cGRldi0+ZGV2LA0KIAkJCQki
U0dJRCBlbnRyeSBhbHJlYWR5IGV4aXN0IGluIGVudHJ5ICVkIVxuIiwgaSk7DQogCQkJKmluZGV4
ID0gaTsNCkBAIC0zNTEsNiArMzUyLDcgQEAgaW50IGJueHRfcXBsaWJfYWRkX3NnaWQoc3RydWN0
IGJueHRfcXBsaWJfc2dpZF90YmwgKnNnaWRfdGJsLA0KIAl9DQogCS8qIEFkZCBHSUQgdG8gdGhl
IHNnaWRfdGJsICovDQogCW1lbWNweSgmc2dpZF90YmwtPnRibFtmcmVlX2lkeF0sIGdpZCwgc2l6
ZW9mKCpnaWQpKTsNCisJc2dpZF90YmwtPnRibFtmcmVlX2lkeF0udmxhbl9pZCA9IHZsYW5faWQ7
DQogCXNnaWRfdGJsLT5hY3RpdmUrKzsNCiAJaWYgKHZsYW5faWQgIT0gMHhGRkZGKQ0KIAkJc2dp
ZF90YmwtPnZsYW5bZnJlZV9pZHhdID0gMTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJh
bmQvaHcvYm54dF9yZS9xcGxpYl9zcC5oIGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L2JueHRfcmUv
cXBsaWJfc3AuaA0KaW5kZXggMGVjM2IxMmIwYmNkLi43YTE5NTdjOWRjNmYgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL2luZmluaWJhbmQvaHcvYm54dF9yZS9xcGxpYl9zcC5oDQorKysgYi9kcml2ZXJz
L2luZmluaWJhbmQvaHcvYm54dF9yZS9xcGxpYl9zcC5oDQpAQCAtODIsNiArODIsNyBAQCBzdHJ1
Y3QgYm54dF9xcGxpYl9wZCB7DQogDQogc3RydWN0IGJueHRfcXBsaWJfZ2lkIHsNCiAJdTgJCQkJ
ZGF0YVsxNl07DQorCXUxNiB2bGFuX2lkOw0KIH07DQogDQogc3RydWN0IGJueHRfcXBsaWJfYWgg
ew0KLS0gDQoyLjE5LjINCg==
