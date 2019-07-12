Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE3F966F34
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 14:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfGLMw3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 08:52:29 -0400
Received: from mail-eopbgr130088.outbound.protection.outlook.com ([40.107.13.88]:60995
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726466AbfGLMw3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Jul 2019 08:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLKR3QY2bGyt2XUAm+GG5qk8P4MJSItKWt538zo4Q1o=;
 b=lZQ69Piq8W/JYarxgfyHLzQZro9/0rHAbeYe1LYF/qdfV06DEM8/h8rf7LE4kjS/1LGbnOhVIZFUTaubYpNTvSTsgSY4HfXeN9dheErLurQVsY8uhB79QlifDPu6F1DFVWWoIQ+smkkzY/37ht8Vy6ZsaNcBb/bqipvQ0L2YSjo=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB5940.eurprd05.prod.outlook.com (20.178.202.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Fri, 12 Jul 2019 12:52:24 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::217d:2cd7:c8da:9279]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::217d:2cd7:c8da:9279%5]) with mapi id 15.20.2052.020; Fri, 12 Jul 2019
 12:52:24 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Yi Zhang <yi.zhang@redhat.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
CC:     Daniel Jurgens <danielj@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: regression: nvme rdma with bnxt_re0 broken
Thread-Topic: regression: nvme rdma with bnxt_re0 broken
Thread-Index: 2UfSPBB7aurhIBgBOMtlZZ/Acg5lQJrLV3lwgAA5BsCAAKCFgIAAD6MggAAPzICAAF+3EIAAAyXAgAACz1CAAB8vgIAAE91w
Date:   Fri, 12 Jul 2019 12:52:24 +0000
Message-ID: <AM0PR05MB48666463325E1D0E25D63F57D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <1310083272.27124086.1562836112586.JavaMail.zimbra@redhat.com>
 <619411460.27128070.1562838433020.JavaMail.zimbra@redhat.com>
 <AM0PR05MB48664657022ECA8526E3C967D1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866070FBADCCABD1F84E42ED1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <66d43fd8-18e8-8b9d-90e3-ee2804d56889@redhat.com>
 <AM0PR05MB4866DEDB9DE4379F6A6EF15BD1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <CA+sbYW17PGAW57pyRmQB9KsDA9Q+7FFgSseSTTWE_h6vffa7UQ@mail.gmail.com>
 <AM0PR05MB4866CFEDCDF3CDA1D7D18AA5D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866CCD487C9D99BD9526BA8D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866665D5CACB34AE885BCA2D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <ef6a01a1-9163-ef4e-29ac-4f4130c682f1@redhat.com>
In-Reply-To: <ef6a01a1-9163-ef4e-29ac-4f4130c682f1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [49.207.52.95]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d94203a3-fc62-4423-be83-08d706c7c980
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR05MB5940;
x-ms-traffictypediagnostic: AM0PR05MB5940:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR05MB5940AC959257071131CB9431D1F20@AM0PR05MB5940.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(189003)(199004)(13464003)(71190400001)(486006)(8936002)(68736007)(8676002)(110136005)(81166006)(33656002)(2906002)(14454004)(54906003)(71200400001)(966005)(86362001)(316002)(3846002)(229853002)(6116002)(81156014)(14444005)(74316002)(7736002)(256004)(305945005)(6506007)(53546011)(52536014)(26005)(66446008)(66556008)(66066001)(476003)(66946007)(76116006)(55236004)(66476007)(5660300002)(53936002)(64756008)(55016002)(99286004)(6436002)(25786009)(9686003)(4326008)(102836004)(6306002)(7696005)(186003)(11346002)(76176011)(6246003)(446003)(478600001)(10126625002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5940;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JNavzv5UpUYeyU0aiSefwGFzFo4B8zQC+TTnb3Z1xlQIVh99mKBlQhjEXoUqyD1EPcpoujecw/xkb264FeC04eaO4Qf5pixZYG1obWmyxr5BwzeSJY5PKASZZPF/wmQJX+gqM9Shp0gCJ/VYn6BvwJf6k5U4WAx4bBUyTBwOP6zlujL8DZBu/I3R6lbrxMD2HnKh90vGaiU1z1SHkrmSbJDG/t9mRRFXtnlrvCCsgkd5Vw9+9/kCIrxilOYj5n4sSrn2rIpCsyHaOHAeFCPm/LpCClulom9iqD1JM4SVJhog8Ilr6hM6C4MeWr221dHNM6AKeixQ7Y5VWLe6Pl3aXcWcmQ4xyRkf/eF7FLG8VeTchEAQCCvveWCLYC7+qxPfwLrIKSwvOspb/m6dl733izc1l0Fp8vuRDhegIS8B9L8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94203a3-fc62-4423-be83-08d706c7c980
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 12:52:24.4601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: parav@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5940
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWWkgWmhhbmcgPHlpLnpo
YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSnVseSAxMiwgMjAxOSA1OjExIFBNDQo+
IFRvOiBQYXJhdiBQYW5kaXQgPHBhcmF2QG1lbGxhbm94LmNvbT47IFNlbHZpbiBYYXZpZXINCj4g
PHNlbHZpbi54YXZpZXJAYnJvYWRjb20uY29tPg0KPiBDYzogRGFuaWVsIEp1cmdlbnMgPGRhbmll
bGpAbWVsbGFub3guY29tPjsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7DQo+IERldmVzaCBT
aGFybWEgPGRldmVzaC5zaGFybWFAYnJvYWRjb20uY29tPjsgbGludXgtDQo+IG52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogcmVncmVzc2lvbjogbnZtZSByZG1hIHdpdGgg
Ym54dF9yZTAgYnJva2VuDQo+IA0KPiBIaSBQYXJhdg0KPiBUaGUgbnZtZSBjb25uZWN0IHN0aWxs
IGZhaWxlZFsxXSwgSSd2ZSBwYXN0ZSBhbGwgdGhlIGRtZXNnIGxvZyB0b1syXSwgcGxzIGNoZWNr
IGl0Lg0KPiANCj4gDQo+IFsxXQ0KPiBbcm9vdEByZG1hLXBlcmYtMDcgfl0kIG52bWUgY29ubmVj
dCAtdCByZG1hIC1hIDE3Mi4zMS40MC4xMjUgLXMgNDQyMCAtbg0KPiB0ZXN0bnFuDQo+IEZhaWxl
ZCB0byB3cml0ZSB0byAvZGV2L252bWUtZmFicmljczogQ29ubmVjdGlvbiByZXNldCBieSBwZWVy
DQo+IFsyXQ0KPiBodHRwczovL3Bhc3RlYmluLmNvbS9pcHZhazBTcA0KPiANCg0KSSB0aGluayB2
bGFuX2lkIGlzIG5vdCBpbml0aWFsaXplZCB0byAweGZmZmYgZHVlIHRvIHdoaWNoIGlwdjQgZW50
cnkgYWRkaXRpb24gYWxzbyBmYWlsZWQgd2l0aCBteSBwYXRjaC4NClRoaXMgaXMgcHJvYmFibHkg
c29sdmVzIGl0LiBOb3Qgc3VyZS4gSSBhbSBub3QgbXVjaCBmYW1pbGlhciB3aXRoIGl0Lg0KDQpT
ZWx2aW4sDQpDYW4geW91IHBsZWFzZSB0YWtlIGEgbG9vaz8NCg0KRnJvbSA3YjU1ZTFkNDUwMDI1
OWNmN2MwMmZiNGQ5ZmJiZWI1YWQxY2ZjNjIzIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJv
bTogUGFyYXYgUGFuZGl0IDxwYXJhdkBtZWxsYW5veC5jb20+DQpEYXRlOiBGcmksIDEyIEp1bCAy
MDE5IDA0OjM0OjUyIC0wNTAwDQpTdWJqZWN0OiBbUEFUQ0ggdjFdIElCL2JueHRfcmU6IEhvbm9y
IHZsYW5faWQgaW4gR0lEIGVudHJ5IGNvbXBhcmlzb24NCg0KR0lEIGVudHJ5IGNvbnNpc3Qgb2Yg
R0lELCB2bGFuLCBuZXRkZXYgYW5kIHNtYWMuDQpFeHRlbmQgR0lEIGR1cGxpY2F0ZSBjaGVjayBj
b21wYW5pb25zIHRvIGNvbnNpZGVyIHZsYW5faWQgYXMgd2VsbA0KdG8gc3VwcG9ydCBJUHY2IFZM
QU4gYmFzZWQgbGluayBsb2NhbCBhZGRyZXNzZXMuDQoNCkdJRCBkZWxldGlvbiBiYXNlZCBvbiBv
bmx5IEdJRCBjb21wYXJpc2lvbiBpcyBub3QgY29ycmVjdC4NCkl0IG5lZWRzIGZ1cnRoZXIgZml4
ZXMuDQoNCkZpeGVzOiA4MjNiMjNkYTcxMTMgKCJJQi9jb3JlOiBBbGxvdyB2bGFuIGxpbmsgbG9j
YWwgYWRkcmVzcyBiYXNlZCBSb0NFIEdJRHMiKQ0KQ2hhbmdlLUlkOiBJMmUwMjZlYzgwNjVjODQy
NWJhMjRmYWQ4NTI1MzIzZDExMmEyZjRlNA0KU2lnbmVkLW9mZi1ieTogUGFyYXYgUGFuZGl0IDxw
YXJhdkBtZWxsYW5veC5jb20+DQotLS0NCiBkcml2ZXJzL2luZmluaWJhbmQvaHcvYm54dF9yZS9x
cGxpYl9yZXMuYyB8IDUgKysrKysNCiBkcml2ZXJzL2luZmluaWJhbmQvaHcvYm54dF9yZS9xcGxp
Yl9zcC5jICB8IDcgKysrKysrLQ0KIGRyaXZlcnMvaW5maW5pYmFuZC9ody9ibnh0X3JlL3FwbGli
X3NwLmggIHwgMSArDQogMyBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvYm54dF9yZS9xcGxp
Yl9yZXMuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9ibnh0X3JlL3FwbGliX3Jlcy5jDQppbmRl
eCAzNzkyOGIxMTExZGYuLjIxNjY0OGI2NDBjZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW5maW5p
YmFuZC9ody9ibnh0X3JlL3FwbGliX3Jlcy5jDQorKysgYi9kcml2ZXJzL2luZmluaWJhbmQvaHcv
Ym54dF9yZS9xcGxpYl9yZXMuYw0KQEAgLTQ4OCw2ICs0ODgsOCBAQCBzdGF0aWMgaW50IGJueHRf
cXBsaWJfYWxsb2Nfc2dpZF90Ymwoc3RydWN0IGJueHRfcXBsaWJfcmVzICpyZXMsDQogCQkJCSAg
ICAgc3RydWN0IGJueHRfcXBsaWJfc2dpZF90YmwgKnNnaWRfdGJsLA0KIAkJCQkgICAgIHUxNiBt
YXgpDQogew0KKwl1MTYgaTsNCisNCiAJc2dpZF90YmwtPnRibCA9IGtjYWxsb2MobWF4LCBzaXpl
b2Yoc3RydWN0IGJueHRfcXBsaWJfZ2lkKSwgR0ZQX0tFUk5FTCk7DQogCWlmICghc2dpZF90Ymwt
PnRibCkNCiAJCXJldHVybiAtRU5PTUVNOw0KQEAgLTUwMCw2ICs1MDIsOSBAQCBzdGF0aWMgaW50
IGJueHRfcXBsaWJfYWxsb2Nfc2dpZF90Ymwoc3RydWN0IGJueHRfcXBsaWJfcmVzICpyZXMsDQog
CWlmICghc2dpZF90YmwtPmN0eCkNCiAJCWdvdG8gb3V0X2ZyZWUyOw0KIA0KKwlmb3IgKGkgPSAw
OyBpIDwgbWF4OyBpKyspDQorCQlzZ2lkX3RibC0+dGJsW2ldLnZsYW5faWQgPSAweGZmZmY7DQor
DQogCXNnaWRfdGJsLT52bGFuID0ga2NhbGxvYyhtYXgsIHNpemVvZih1OCksIEdGUF9LRVJORUwp
Ow0KIAlpZiAoIXNnaWRfdGJsLT52bGFuKQ0KIAkJZ290byBvdXRfZnJlZTM7DQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L2JueHRfcmUvcXBsaWJfc3AuYyBiL2RyaXZlcnMvaW5m
aW5pYmFuZC9ody9ibnh0X3JlL3FwbGliX3NwLmMNCmluZGV4IDQ4NzkzZDM1MTJhYy4uMGQ5MGJl
ODg2ODVmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L2JueHRfcmUvcXBsaWJf
c3AuYw0KKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L2JueHRfcmUvcXBsaWJfc3AuYw0KQEAg
LTIzNiw2ICsyMzYsOSBAQCBpbnQgYm54dF9xcGxpYl9kZWxfc2dpZChzdHJ1Y3QgYm54dF9xcGxp
Yl9zZ2lkX3RibCAqc2dpZF90YmwsDQogCQlyZXR1cm4gLUVOT01FTTsNCiAJfQ0KIAlmb3IgKGlu
ZGV4ID0gMDsgaW5kZXggPCBzZ2lkX3RibC0+bWF4OyBpbmRleCsrKSB7DQorCQkvKiBGSVhNRTog
R0lEIGRlbGV0ZSBzaG91bGQgaGFwcGVuIGJhc2VkIG9uIGluZGV4DQorCQkgKiBhbmQgcmVmY291
bnQNCisJCSAqLw0KIAkJaWYgKCFtZW1jbXAoJnNnaWRfdGJsLT50YmxbaW5kZXhdLCBnaWQsIHNp
emVvZigqZ2lkKSkpDQogCQkJYnJlYWs7DQogCX0NCkBAIC0yOTYsNyArMjk5LDggQEAgaW50IGJu
eHRfcXBsaWJfYWRkX3NnaWQoc3RydWN0IGJueHRfcXBsaWJfc2dpZF90YmwgKnNnaWRfdGJsLA0K
IAl9DQogCWZyZWVfaWR4ID0gc2dpZF90YmwtPm1heDsNCiAJZm9yIChpID0gMDsgaSA8IHNnaWRf
dGJsLT5tYXg7IGkrKykgew0KLQkJaWYgKCFtZW1jbXAoJnNnaWRfdGJsLT50YmxbaV0sIGdpZCwg
c2l6ZW9mKCpnaWQpKSkgew0KKwkJaWYgKCFtZW1jbXAoJnNnaWRfdGJsLT50YmxbaV0sIGdpZCwg
c2l6ZW9mKCpnaWQpKSAmJg0KKwkJICAgIHNnaWRfdGJsLT50YmxbaV0udmxhbl9pZCA9PSB2bGFu
X2lkKSB7DQogCQkJZGV2X2RiZygmcmVzLT5wZGV2LT5kZXYsDQogCQkJCSJTR0lEIGVudHJ5IGFs
cmVhZHkgZXhpc3QgaW4gZW50cnkgJWQhXG4iLCBpKTsNCiAJCQkqaW5kZXggPSBpOw0KQEAgLTM1
MSw2ICszNTUsNyBAQCBpbnQgYm54dF9xcGxpYl9hZGRfc2dpZChzdHJ1Y3QgYm54dF9xcGxpYl9z
Z2lkX3RibCAqc2dpZF90YmwsDQogCX0NCiAJLyogQWRkIEdJRCB0byB0aGUgc2dpZF90YmwgKi8N
CiAJbWVtY3B5KCZzZ2lkX3RibC0+dGJsW2ZyZWVfaWR4XSwgZ2lkLCBzaXplb2YoKmdpZCkpOw0K
KwlzZ2lkX3RibC0+dGJsW2ZyZWVfaWR4XS52bGFuX2lkID0gdmxhbl9pZDsNCiAJc2dpZF90Ymwt
PmFjdGl2ZSsrOw0KIAlpZiAodmxhbl9pZCAhPSAweEZGRkYpDQogCQlzZ2lkX3RibC0+dmxhbltm
cmVlX2lkeF0gPSAxOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9ibnh0X3Jl
L3FwbGliX3NwLmggYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvYm54dF9yZS9xcGxpYl9zcC5oDQpp
bmRleCAwZWMzYjEyYjBiY2QuLjdhMTk1N2M5ZGM2ZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW5m
aW5pYmFuZC9ody9ibnh0X3JlL3FwbGliX3NwLmgNCisrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9o
dy9ibnh0X3JlL3FwbGliX3NwLmgNCkBAIC04Miw2ICs4Miw3IEBAIHN0cnVjdCBibnh0X3FwbGli
X3BkIHsNCiANCiBzdHJ1Y3QgYm54dF9xcGxpYl9naWQgew0KIAl1OAkJCQlkYXRhWzE2XTsNCisJ
dTE2IHZsYW5faWQ7DQogfTsNCiANCiBzdHJ1Y3QgYm54dF9xcGxpYl9haCB7DQotLSANCjIuMTku
Mg0K
