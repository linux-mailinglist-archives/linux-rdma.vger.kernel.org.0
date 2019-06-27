Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2D355852E
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 17:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfF0PGf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 11:06:35 -0400
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]:63118
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726441AbfF0PGe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Jun 2019 11:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHm4SR7pthYPI+zzjRrdoNWigsm54TVGNowg51vhMdk=;
 b=S+qOZ20q5W3Lx7UwuJxsf09TDZMQSJ3xEaf05m2SnRJLGFcVQyr4Tizvev0s1jqzqqF6ZF5uAFPImBVcscX1LFAQTdnkdApS0SVe6cSOhUlXsJAgnC2gce6ykWU16SBYh4k5CLQ3/7rk6kZn96jTkfowI44JusUcCKo1mE0h6Sg=
Received: from DB6PR0501MB2167.eurprd05.prod.outlook.com (10.168.58.144) by
 DB6PR0501MB2343.eurprd05.prod.outlook.com (10.168.56.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.17; Thu, 27 Jun 2019 15:06:28 +0000
Received: from DB6PR0501MB2167.eurprd05.prod.outlook.com
 ([fe80::f46e:3c7c:f7ff:a8f7]) by DB6PR0501MB2167.eurprd05.prod.outlook.com
 ([fe80::f46e:3c7c:f7ff:a8f7%7]) with mapi id 15.20.2008.017; Thu, 27 Jun 2019
 15:06:28 +0000
From:   Ali Alnubani <alialnu@mellanox.com>
To:     Ali Alnubani <alialnu@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "sean.hefty@intel.com" <sean.hefty@intel.com>
Subject: RE: [PATCH] rsockets: fix variable initialization
Thread-Topic: [PATCH] rsockets: fix variable initialization
Thread-Index: AQHVLPjOIcKwZSkjj0yFTRmzKKOCbKavmaiQ
Date:   Thu, 27 Jun 2019 15:06:28 +0000
Message-ID: <DB6PR0501MB2167F64CF8BD84F618424E65D7FD0@DB6PR0501MB2167.eurprd05.prod.outlook.com>
References: <20190627144918.4453-1-alialnu@mellanox.com>
In-Reply-To: <20190627144918.4453-1-alialnu@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alialnu@mellanox.com; 
x-originating-ip: [212.29.221.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a44169b6-5332-4b37-6943-08d6fb1107f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB6PR0501MB2343;
x-ms-traffictypediagnostic: DB6PR0501MB2343:
x-microsoft-antispam-prvs: <DB6PR0501MB2343D22503D939878E4E757ED7FD0@DB6PR0501MB2343.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(346002)(39860400002)(136003)(13464003)(199004)(189003)(74316002)(66556008)(8936002)(186003)(26005)(476003)(71200400001)(102836004)(71190400001)(14454004)(2501003)(486006)(5660300002)(33656002)(110136005)(6436002)(4326008)(66946007)(73956011)(76176011)(66446008)(64756008)(66476007)(76116006)(81156014)(81166006)(66066001)(99286004)(7736002)(305945005)(7696005)(11346002)(25786009)(6246003)(316002)(9686003)(478600001)(55016002)(8676002)(68736007)(6506007)(53546011)(53936002)(86362001)(256004)(229853002)(6116002)(2906002)(52536014)(3846002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2343;H:DB6PR0501MB2167.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h5bBO8QVZp5DV05rgtCsGt+0ZhBD0MlhWmWFeTLuwZp/ZzwS6FjI/XRwQDPbTwPb8W8PuWnURn7vSNUR1Q4QjUDl0y3txDcv88a6LOODqksW2Z/xQb92eGdDgTTezyPr1QU82WcBaMPJeAvynOfZvbaa865GtfrkRsgrhtqRF7y90ReXyMpI9uwUZqoE4Ynebzr6LmjotGCGYWcXSmuNgJKVGSKj0mBxPCOuIOIpF+QSVfKWPHgGmedfXKhwb5ug5CWpjhzc4S/Y48bxd/0yJ19LNFn+D0BGHvghDovHdHPv4xDgkH3VgRTTqK8yR5nE0JLaYdj6dwMX/dTXtLPnD7ZJhTKbsP5eo2T/rz8i9BbeE+ppnOlyiLNlt3JivdlqPB2q2hEKBOAqiA8KqhcPzGVlhe+DX6PowIi36Nc0yVs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44169b6-5332-4b37-6943-08d6fb1107f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 15:06:28.4124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alialnu@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2343
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SSBhcG9sb2dpemUgZm9yIHNlbmRpbmcgdGhpcyB0d2ljZS4gSSB0aG91Z2h0IGl0IHdhc24ndCBy
ZWNlaXZlZCB0aGUgZmlyc3QgdGltZS4NClBsZWFzZSBpZ25vcmUgdGhpcyB0aHJlYWQuDQoNClRo
YW5rcywNCkFsaQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGxpbnV4
LXJkbWEtb3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1yZG1hLQ0KPiBvd25lckB2Z2VyLmtl
cm5lbC5vcmc+IE9uIEJlaGFsZiBPZiBBbGkgQWxudWJhbmkNCj4gU2VudDogVGh1cnNkYXksIEp1
bmUgMjcsIDIwMTkgNTo0OSBQTQ0KPiBUbzogbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IHNlYW4uaGVmdHlAaW50ZWwuY29tDQo+IFN1YmplY3Q6IFtQQVRDSF0gcnNvY2tldHM6IGZp
eCB2YXJpYWJsZSBpbml0aWFsaXphdGlvbg0KPiANCj4gVGhpcyBpcyB0byBmaXggdGhlIGVycm9y
Og0KPiAgIGBgYA0KPiAgIFsxMTcvMzgwXSBCdWlsZGluZyBDIG9iamVjdCBsaWJyZG1hY20vQ01h
a2VGaWxlcy9yZG1hY20uZGlyL3Jzb2NrZXQuYy5vDQo+ICAgRkFJTEVEOiBsaWJyZG1hY20vQ01h
a2VGaWxlcy9yZG1hY20uZGlyL3Jzb2NrZXQuYy5vDQo+ICAgL3Vzci9iaW4vY2MgIC1EX0ZJTEVf
T0ZGU0VUX0JJVFM9NjQgLURyZG1hY21fRVhQT1JUUyAtV2Vycm9yIC1tMzINCj4gICAtc3RkPWdu
dTExIC1XYWxsIC1XZXh0cmEgLVduby1zaWduLWNvbXBhcmUgLVduby11bnVzZWQtcGFyYW1ldGVy
DQo+ICAgLVdtaXNzaW5nLXByb3RvdHlwZXMgLVdtaXNzaW5nLWRlY2xhcmF0aW9ucyAtV3dyaXRl
LXN0cmluZ3MgLVdmb3JtYXQ9Mg0KPiAgIC1XZm9ybWF0LW5vbmxpdGVyYWwgLVdyZWR1bmRhbnQt
ZGVjbHMgLVduZXN0ZWQtZXh0ZXJucyAtV3NoYWRvdw0KPiAgIC1Xbm8tbWlzc2luZy1maWVsZC1p
bml0aWFsaXplcnMgLVdzdHJpY3QtcHJvdG90eXBlcw0KPiAgIC1Xb2xkLXN0eWxlLWRlZmluaXRp
b24gLVdyZWR1bmRhbnQtZGVjbHMgLU8yIC1nICAtZlBJQyAtSWluY2x1ZGUgLU1NRA0KPiAgIC1N
VCBsaWJyZG1hY20vQ01ha2VGaWxlcy9yZG1hY20uZGlyL3Jzb2NrZXQuYy5vIC1NRg0KPiAgICJs
aWJyZG1hY20vQ01ha2VGaWxlcy9yZG1hY20uZGlyL3Jzb2NrZXQuYy5vLmQiIC1vDQo+ICAgbGli
cmRtYWNtL0NNYWtlRmlsZXMvcmRtYWNtLmRpci9yc29ja2V0LmMubyAgIC1jIC4uL2xpYnJkbWFj
bS9yc29ja2V0LmMNCj4gICAuLi9saWJyZG1hY20vcnNvY2tldC5jOiBJbiBmdW5jdGlvbiDigJhy
c19nZXRfY29tcOKAmToNCj4gICAuLi9saWJyZG1hY20vcnNvY2tldC5jOjIxNDg6MTU6IGVycm9y
OiDigJhzdGFydF90aW1l4oCZIG1heSBiZSB1c2VkDQo+ICAgdW5pbml0aWFsaXplZCBpbiB0aGlz
IGZ1bmN0aW9uIFstV2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRdDQo+ICAgICAgcG9sbF90aW1l
ID0gKHVpbnQzMl90KSAocnNfdGltZV91cygpIC0gc3RhcnRfdGltZSk7DQo+ICAgICAgICAgICAg
ICAgICAgXg0KPiAgIC4uL2xpYnJkbWFjbS9yc29ja2V0LmM6IEluIGZ1bmN0aW9uIOKAmGRzX2dl
dF9jb21w4oCZOg0KPiAgIC4uL2xpYnJkbWFjbS9yc29ja2V0LmM6MjMwNzoxNTogZXJyb3I6IOKA
mHN0YXJ0X3RpbWXigJkgbWF5IGJlIHVzZWQNCj4gICB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVu
Y3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXplZF0NCj4gICAgICBwb2xsX3RpbWUgPSAo
dWludDMyX3QpIChyc190aW1lX3VzKCkgLSBzdGFydF90aW1lKTsNCj4gICAgICAgICAgICAgICAg
ICBeDQo+ICAgLi4vbGlicmRtYWNtL3Jzb2NrZXQuYzogSW4gZnVuY3Rpb24g4oCYcnBvbGzigJk6
DQo+ICAgLi4vbGlicmRtYWNtL3Jzb2NrZXQuYzozMzIxOjE1OiBlcnJvcjog4oCYc3RhcnRfdGlt
ZeKAmSBtYXkgYmUgdXNlZA0KPiAgIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdl
cnJvcj1tYXliZS11bmluaXRpYWxpemVkXQ0KPiAgICAgIHBvbGxfdGltZSA9ICh1aW50MzJfdCkg
KHJzX3RpbWVfdXMoKSAtIHN0YXJ0X3RpbWUpOw0KPiAgICAgICAgICAgICAgICAgIF4NCj4gICBj
YzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycw0KPiAgIFsxMjIvMzgwXSBC
dWlsZGluZyBDIG9iamVjdCBwcm92aWRlcnMvZWZhL0NNYWtlRmlsZXMvZWZhLmRpci92ZXJicy5j
Lm8NCj4gICBuaW5qYTogYnVpbGQgc3RvcHBlZDogc3ViY29tbWFuZCBmYWlsZWQuDQo+ICAgYGBg
DQo+IFdoaWNoIHJlcHJvZHVjZXMgb24gUkhFTDcuNSB3aXRoIDQuOC41IDIwMTUwNjIzIChSZWQg
SGF0IDQuOC41LTI4KSBhbmQgMzItDQo+IGJpdCBsaWJyYXJpZXMuDQo+IA0KPiBCdWlsZCBzdGVw
cyB0byByZXByb2R1Y2U6DQo+ICAgYGBgDQo+ICAgbWtkaXIgYnVpbGQzMiAmJiBjZCBidWlsZDMy
ICYmIENGTEFHUz0iLVdlcnJvciAtbTMyIiBjbWFrZSAtR05pbmphIFwNCj4gICAtREVOQUJMRV9S
RVNPTFZFX05FSUdIPTAgLURJT0NUTF9NT0RFPWJvdGggLUROT19QWVZFUkJTPTEgJiYNCj4gXA0K
PiAgIG5pbmphLWJ1aWxkDQo+ICAgYGBgDQo+IA0KPiBtZXNvbiB2ZXJzaW9uOiAwLjQ3LjINCj4g
bmluamEtYnVpbGQgdmVyc2lvbjogMS43LjINCj4gDQo+IEZpeGVzOiAzOGM0OTIzMmI2N2EgKCJy
c29ja2V0czogUmVwbGFjZSBnZXR0aW1lb2ZkYXkgd2l0aCBjbG9ja19nZXR0aW1lIikNCj4gQ2M6
IHNlYW4uaGVmdHlAaW50ZWwuY29tDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGkgQWxudWJhbmkg
PGFsaWFsbnVAbWVsbGFub3guY29tPg0KPiAtLS0NCj4gIGxpYnJkbWFjbS9yc29ja2V0LmMgfCA2
ICsrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9saWJyZG1hY20vcnNvY2tldC5jIGIvbGlicmRtYWNtL3Jz
b2NrZXQuYyBpbmRleA0KPiA1OGRlMjg1Ni4uYWE5MTJjMWEgMTAwNjQ0DQo+IC0tLSBhL2xpYnJk
bWFjbS9yc29ja2V0LmMNCj4gKysrIGIvbGlicmRtYWNtL3Jzb2NrZXQuYw0KPiBAQCAtMjEzMyw3
ICsyMTMzLDcgQEAgc3RhdGljIGludCByc19wcm9jZXNzX2NxKHN0cnVjdCByc29ja2V0ICpycywg
aW50DQo+IG5vbmJsb2NrLCBpbnQgKCp0ZXN0KShzdHJ1Y3QgcnMNCj4gDQo+ICBzdGF0aWMgaW50
IHJzX2dldF9jb21wKHN0cnVjdCByc29ja2V0ICpycywgaW50IG5vbmJsb2NrLCBpbnQgKCp0ZXN0
KShzdHJ1Y3QNCj4gcnNvY2tldCAqcnMpKSAgew0KPiAtCXVpbnQ2NF90IHN0YXJ0X3RpbWU7DQo+
ICsJdWludDY0X3Qgc3RhcnRfdGltZSA9IDA7DQo+ICAJdWludDMyX3QgcG9sbF90aW1lID0gMDsN
Cj4gIAlpbnQgcmV0Ow0KPiANCj4gQEAgLTIyOTIsNyArMjI5Miw3IEBAIHN0YXRpYyBpbnQgZHNf
cHJvY2Vzc19jcXMoc3RydWN0IHJzb2NrZXQgKnJzLCBpbnQNCj4gbm9uYmxvY2ssIGludCAoKnRl
c3QpKHN0cnVjdCByDQo+IA0KPiAgc3RhdGljIGludCBkc19nZXRfY29tcChzdHJ1Y3QgcnNvY2tl
dCAqcnMsIGludCBub25ibG9jaywgaW50ICgqdGVzdCkoc3RydWN0DQo+IHJzb2NrZXQgKnJzKSkg
IHsNCj4gLQl1aW50NjRfdCBzdGFydF90aW1lOw0KPiArCXVpbnQ2NF90IHN0YXJ0X3RpbWUgPSAw
Ow0KPiAgCXVpbnQzMl90IHBvbGxfdGltZSA9IDA7DQo+ICAJaW50IHJldDsNCj4gDQo+IEBAIC0z
MzA2LDcgKzMzMDYsNyBAQCBzdGF0aWMgaW50IHJzX3BvbGxfZXZlbnRzKHN0cnVjdCBwb2xsZmQg
KnJmZHMsIHN0cnVjdA0KPiBwb2xsZmQgKmZkcywgbmZkc190IG5mZHMpICBpbnQgcnBvbGwoc3Ry
dWN0IHBvbGxmZCAqZmRzLCBuZmRzX3QgbmZkcywgaW50IHRpbWVvdXQpDQo+IHsNCj4gIAlzdHJ1
Y3QgcG9sbGZkICpyZmRzOw0KPiAtCXVpbnQ2NF90IHN0YXJ0X3RpbWU7DQo+ICsJdWludDY0X3Qg
c3RhcnRfdGltZSA9IDA7DQo+ICAJdWludDMyX3QgcG9sbF90aW1lID0gMDsNCj4gIAlpbnQgcG9s
bHNsZWVwLCByZXQ7DQo+IA0KPiAtLQ0KPiAyLjIyLjANCg0K
