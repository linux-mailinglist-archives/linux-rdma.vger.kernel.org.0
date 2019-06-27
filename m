Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 216F9584F1
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 16:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfF0OzU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 10:55:20 -0400
Received: from mail-eopbgr10059.outbound.protection.outlook.com ([40.107.1.59]:15072
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbfF0OzU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Jun 2019 10:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Or9SF9hCKGbkbd/Q+GZ9flg4xnbX9v6Y97gtN6uSnnw=;
 b=MRdh6tyWvSA2wEM5R5kJWFnPDihE/B18m27qkUSYjS7xeSlc/spgAcXS49xeqOTI/wqA50KDJjs6Vofqsp1vU2snqHQbO/z2XskoBqZzzH2wm0aCUXIyDK+U3/A+pr3J2hvcdDoLpjAf2YkrFbKql2X94pm3AOkWrvLAsNRu5js=
Received: from DB6PR0501MB2167.eurprd05.prod.outlook.com (10.168.58.144) by
 DB6PR0501MB2310.eurprd05.prod.outlook.com (10.168.56.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 14:55:15 +0000
Received: from DB6PR0501MB2167.eurprd05.prod.outlook.com
 ([fe80::f46e:3c7c:f7ff:a8f7]) by DB6PR0501MB2167.eurprd05.prod.outlook.com
 ([fe80::f46e:3c7c:f7ff:a8f7%7]) with mapi id 15.20.2008.017; Thu, 27 Jun 2019
 14:55:15 +0000
From:   Ali Alnubani <alialnu@mellanox.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "sean.hefty@intel.com" <sean.hefty@intel.com>
Subject: [PATCH] rsockets: fix variable initialization
Thread-Topic: [PATCH] rsockets: fix variable initialization
Thread-Index: AQHVLPhU9fQYhKi0uEW2GchrIipZrQ==
Date:   Thu, 27 Jun 2019 14:55:15 +0000
Message-ID: <20190627145451.4591-1-alialnu@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.22.0
x-clientproxiedby: VI1PR0102CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::34) To DB6PR0501MB2167.eurprd05.prod.outlook.com
 (2603:10a6:4:51::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alialnu@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [37.142.13.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18b189cf-f654-4baa-a0e3-08d6fb0f7643
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB6PR0501MB2310;
x-ms-traffictypediagnostic: DB6PR0501MB2310:
x-microsoft-antispam-prvs: <DB6PR0501MB2310409EE6FA8F58FC0C8A02D7FD0@DB6PR0501MB2310.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(6512007)(5640700003)(2501003)(6436002)(6506007)(6916009)(50226002)(66066001)(5660300002)(25786009)(386003)(26005)(102836004)(4326008)(2906002)(53936002)(186003)(316002)(36756003)(3846002)(1076003)(2616005)(6486002)(86362001)(476003)(68736007)(14454004)(52116002)(478600001)(99286004)(256004)(7736002)(73956011)(66556008)(66476007)(8936002)(2351001)(66946007)(64756008)(71190400001)(71200400001)(305945005)(486006)(8676002)(81166006)(81156014)(66446008)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2310;H:DB6PR0501MB2167.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZTe1LpdWBw+fi9PVmD4oJzjkNKqP/t1FMkigvJlAozrKRvYnc1EbxyToD7fiklxxf3ywiaQVNAgsEIpEFib3Cqq3LS1JvLBfftctDMteOIGWxze0941mMQH8cLVLi20yoNdDL4hV3hWiaTecSjBX4+41wX/9vUsmr3XyJgyoMv6I7ZeGdIkatGMrvven6Wvp+B2G1tTP9l7uGwHiewTqyEzMwABgbTVfuWs6ZKAgywn6NUDi6OyOflQtK5HBo281hKokMO+qmxOjpniJokSzGPGPMobHd+XprFnqSxzVc2xe23dbYp7HIe5sCY2dLldWLeuBFQnLjoZEzsuZywSyZZJf4gQDOWsILyzo92eKZrgUa6JHtqZ1tReYRDJdllE3s0u3EV/Eqz+Oa/06gzwwueDJPBAQcIKO/d9Si/teuGY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B21C46E05DD1D42BB112391E11113E6@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b189cf-f654-4baa-a0e3-08d6fb0f7643
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 14:55:15.1002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alialnu@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2310
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

VGhpcyBpcyB0byBmaXggdGhlIGVycm9yOg0KICBgYGANCiAgWzExNy8zODBdIEJ1aWxkaW5nIEMg
b2JqZWN0IGxpYnJkbWFjbS9DTWFrZUZpbGVzL3JkbWFjbS5kaXIvcnNvY2tldC5jLm8NCiAgRkFJ
TEVEOiBsaWJyZG1hY20vQ01ha2VGaWxlcy9yZG1hY20uZGlyL3Jzb2NrZXQuYy5vDQogIC91c3Iv
YmluL2NjICAtRF9GSUxFX09GRlNFVF9CSVRTPTY0IC1EcmRtYWNtX0VYUE9SVFMgLVdlcnJvciAt
bTMyDQogIC1zdGQ9Z251MTEgLVdhbGwgLVdleHRyYSAtV25vLXNpZ24tY29tcGFyZSAtV25vLXVu
dXNlZC1wYXJhbWV0ZXINCiAgLVdtaXNzaW5nLXByb3RvdHlwZXMgLVdtaXNzaW5nLWRlY2xhcmF0
aW9ucyAtV3dyaXRlLXN0cmluZ3MgLVdmb3JtYXQ9Mg0KICAtV2Zvcm1hdC1ub25saXRlcmFsIC1X
cmVkdW5kYW50LWRlY2xzIC1XbmVzdGVkLWV4dGVybnMgLVdzaGFkb3cNCiAgLVduby1taXNzaW5n
LWZpZWxkLWluaXRpYWxpemVycyAtV3N0cmljdC1wcm90b3R5cGVzDQogIC1Xb2xkLXN0eWxlLWRl
ZmluaXRpb24gLVdyZWR1bmRhbnQtZGVjbHMgLU8yIC1nICAtZlBJQyAtSWluY2x1ZGUgLU1NRA0K
ICAtTVQgbGlicmRtYWNtL0NNYWtlRmlsZXMvcmRtYWNtLmRpci9yc29ja2V0LmMubyAtTUYNCiAg
ImxpYnJkbWFjbS9DTWFrZUZpbGVzL3JkbWFjbS5kaXIvcnNvY2tldC5jLm8uZCIgLW8NCiAgbGli
cmRtYWNtL0NNYWtlRmlsZXMvcmRtYWNtLmRpci9yc29ja2V0LmMubyAgIC1jIC4uL2xpYnJkbWFj
bS9yc29ja2V0LmMNCiAgLi4vbGlicmRtYWNtL3Jzb2NrZXQuYzogSW4gZnVuY3Rpb24g4oCYcnNf
Z2V0X2NvbXDigJk6DQogIC4uL2xpYnJkbWFjbS9yc29ja2V0LmM6MjE0ODoxNTogZXJyb3I6IOKA
mHN0YXJ0X3RpbWXigJkgbWF5IGJlIHVzZWQNCiAgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0
aW9uIFstV2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRdDQogICAgIHBvbGxfdGltZSA9ICh1aW50
MzJfdCkgKHJzX3RpbWVfdXMoKSAtIHN0YXJ0X3RpbWUpOw0KICAgICAgICAgICAgICAgICBeDQog
IC4uL2xpYnJkbWFjbS9yc29ja2V0LmM6IEluIGZ1bmN0aW9uIOKAmGRzX2dldF9jb21w4oCZOg0K
ICAuLi9saWJyZG1hY20vcnNvY2tldC5jOjIzMDc6MTU6IGVycm9yOiDigJhzdGFydF90aW1l4oCZ
IG1heSBiZSB1c2VkDQogIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdlcnJvcj1t
YXliZS11bmluaXRpYWxpemVkXQ0KICAgICBwb2xsX3RpbWUgPSAodWludDMyX3QpIChyc190aW1l
X3VzKCkgLSBzdGFydF90aW1lKTsNCiAgICAgICAgICAgICAgICAgXg0KICAuLi9saWJyZG1hY20v
cnNvY2tldC5jOiBJbiBmdW5jdGlvbiDigJhycG9sbOKAmToNCiAgLi4vbGlicmRtYWNtL3Jzb2Nr
ZXQuYzozMzIxOjE1OiBlcnJvcjog4oCYc3RhcnRfdGltZeKAmSBtYXkgYmUgdXNlZA0KICB1bmlu
aXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXplZF0N
CiAgICAgcG9sbF90aW1lID0gKHVpbnQzMl90KSAocnNfdGltZV91cygpIC0gc3RhcnRfdGltZSk7
DQogICAgICAgICAgICAgICAgIF4NCiAgY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBh
cyBlcnJvcnMNCiAgWzEyMi8zODBdIEJ1aWxkaW5nIEMgb2JqZWN0IHByb3ZpZGVycy9lZmEvQ01h
a2VGaWxlcy9lZmEuZGlyL3ZlcmJzLmMubw0KICBuaW5qYTogYnVpbGQgc3RvcHBlZDogc3ViY29t
bWFuZCBmYWlsZWQuDQogIGBgYA0KV2hpY2ggcmVwcm9kdWNlcyBvbiBSSEVMNy41IHdpdGggNC44
LjUgMjAxNTA2MjMgKFJlZCBIYXQgNC44LjUtMjgpDQphbmQgMzItYml0IGxpYnJhcmllcy4NCg0K
QnVpbGQgc3RlcHMgdG8gcmVwcm9kdWNlOg0KICBgYGANCiAgbWtkaXIgYnVpbGQzMiAmJiBjZCBi
dWlsZDMyICYmIENGTEFHUz0iLVdlcnJvciAtbTMyIiBjbWFrZSAtR05pbmphIFwNCiAgLURFTkFC
TEVfUkVTT0xWRV9ORUlHSD0wIC1ESU9DVExfTU9ERT1ib3RoIC1ETk9fUFlWRVJCUz0xICYmIFwN
CiAgbmluamEtYnVpbGQNCiAgYGBgDQoNCm1lc29uIHZlcnNpb246IDAuNDcuMg0KbmluamEtYnVp
bGQgdmVyc2lvbjogMS43LjINCg0KRml4ZXM6IDM4YzQ5MjMyYjY3YSAoInJzb2NrZXRzOiBSZXBs
YWNlIGdldHRpbWVvZmRheSB3aXRoIGNsb2NrX2dldHRpbWUiKQ0KQ2M6IHNlYW4uaGVmdHlAaW50
ZWwuY29tDQoNClNpZ25lZC1vZmYtYnk6IEFsaSBBbG51YmFuaSA8YWxpYWxudUBtZWxsYW5veC5j
b20+DQotLS0NCiBsaWJyZG1hY20vcnNvY2tldC5jIHwgNiArKystLS0NCiAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvbGlicmRt
YWNtL3Jzb2NrZXQuYyBiL2xpYnJkbWFjbS9yc29ja2V0LmMNCmluZGV4IDU4ZGUyODU2Li5hYTkx
MmMxYSAxMDA2NDQNCi0tLSBhL2xpYnJkbWFjbS9yc29ja2V0LmMNCisrKyBiL2xpYnJkbWFjbS9y
c29ja2V0LmMNCkBAIC0yMTMzLDcgKzIxMzMsNyBAQCBzdGF0aWMgaW50IHJzX3Byb2Nlc3NfY3Eo
c3RydWN0IHJzb2NrZXQgKnJzLCBpbnQgbm9uYmxvY2ssIGludCAoKnRlc3QpKHN0cnVjdCBycw0K
IA0KIHN0YXRpYyBpbnQgcnNfZ2V0X2NvbXAoc3RydWN0IHJzb2NrZXQgKnJzLCBpbnQgbm9uYmxv
Y2ssIGludCAoKnRlc3QpKHN0cnVjdCByc29ja2V0ICpycykpDQogew0KLQl1aW50NjRfdCBzdGFy
dF90aW1lOw0KKwl1aW50NjRfdCBzdGFydF90aW1lID0gMDsNCiAJdWludDMyX3QgcG9sbF90aW1l
ID0gMDsNCiAJaW50IHJldDsNCiANCkBAIC0yMjkyLDcgKzIyOTIsNyBAQCBzdGF0aWMgaW50IGRz
X3Byb2Nlc3NfY3FzKHN0cnVjdCByc29ja2V0ICpycywgaW50IG5vbmJsb2NrLCBpbnQgKCp0ZXN0
KShzdHJ1Y3Qgcg0KIA0KIHN0YXRpYyBpbnQgZHNfZ2V0X2NvbXAoc3RydWN0IHJzb2NrZXQgKnJz
LCBpbnQgbm9uYmxvY2ssIGludCAoKnRlc3QpKHN0cnVjdCByc29ja2V0ICpycykpDQogew0KLQl1
aW50NjRfdCBzdGFydF90aW1lOw0KKwl1aW50NjRfdCBzdGFydF90aW1lID0gMDsNCiAJdWludDMy
X3QgcG9sbF90aW1lID0gMDsNCiAJaW50IHJldDsNCiANCkBAIC0zMzA2LDcgKzMzMDYsNyBAQCBz
dGF0aWMgaW50IHJzX3BvbGxfZXZlbnRzKHN0cnVjdCBwb2xsZmQgKnJmZHMsIHN0cnVjdCBwb2xs
ZmQgKmZkcywgbmZkc190IG5mZHMpDQogaW50IHJwb2xsKHN0cnVjdCBwb2xsZmQgKmZkcywgbmZk
c190IG5mZHMsIGludCB0aW1lb3V0KQ0KIHsNCiAJc3RydWN0IHBvbGxmZCAqcmZkczsNCi0JdWlu
dDY0X3Qgc3RhcnRfdGltZTsNCisJdWludDY0X3Qgc3RhcnRfdGltZSA9IDA7DQogCXVpbnQzMl90
IHBvbGxfdGltZSA9IDA7DQogCWludCBwb2xsc2xlZXAsIHJldDsNCiANCi0tIA0KMi4yMi4wDQoN
Cg==
