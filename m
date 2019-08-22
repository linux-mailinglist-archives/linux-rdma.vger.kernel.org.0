Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2836B99997
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 18:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390172AbfHVQw5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 12:52:57 -0400
Received: from mail-eopbgr140051.outbound.protection.outlook.com ([40.107.14.51]:34432
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388526AbfHVQw4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Aug 2019 12:52:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICcdDfgo5DL82r0uBuPBbNDTwLUSdGDtu2S3o5WG1rbItKahwKeH+ja4IORVXGeKGzBH9hIXYhmchI0l1KjBevV3vrrXUYZIauARlpO38n7Bz2oqPHaxDZFZyb8N52ZcsIazxTMc6zmBTd6D3xzjo9m2HbvoTOAFnaB0N44NBxU5e4s5fclQpX8a5okwd5MpNtseJlGkW9k3Yri/Qk9MmDtpFSaZ2ahBHHyS8nBLkJF2LjrnDvN0Zx4f4k8fgVuBLV7Vxqr2Uki7t1inHZbdeVSZFplfbgTqLMWrlLOWY1YytErbLfrADxwctKRcsBRofScNKejGhBixAz19O4Ix/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJVJVUyxdWpXzE6bHOds7r5W18KZnIjSdSyhB0jPMFU=;
 b=OUCtI/Obnj57D6+cTK7M6Ae9ftIu5xcbAzJpptKFKOAYwH1nhdbKpF4xlmWvxdu7PuxXfFEun+rD/V0wKppjQQBxNiKuA8Uko3VbY65WYV+DFf1fRIFtd5waZEtDuJ8YnYCv05d8p0GEluD3y1lBvizF5NRmqDu4VKOzr9O+q79sdzA9A5KONIMSwZdlboUuw+G4XIgtvltkYa+v7SEDQVM8dxUcM2Dr0h/ySCItu/3j2ooxh/6XZwIDAjwAuZATITMMOe9p/FbmrB6eawYNEeTuQU+c+3DT0XaF/wDnr0QUAI6lGVNsTxvD2afOuh9rvQempaRNmT0dZjc7LC3ElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJVJVUyxdWpXzE6bHOds7r5W18KZnIjSdSyhB0jPMFU=;
 b=pOxCA4wAW3/bE7tPlnHkxn+U0hMfVBAbFv+/U32brGs9lSRPRAfAFN7Qp8XDgfTtUkeQqhKunWfx9BG0bjk5YKyGkQjCCn/Zfa4idxaUBjZcfHsqABgJq9gtyihh0jT05x/ySczmZIGclGzRIC7C1QBze9s2zmf7YNk1AT3K/Ao=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6128.eurprd05.prod.outlook.com (20.178.205.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 16:52:52 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 16:52:52 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leonro@mellanox.com>
CC:     Noa Osherovich <noaos@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core 03/14] build: Add pyverbs-based test to the
 build
Thread-Topic: [PATCH rdma-core 03/14] build: Add pyverbs-based test to the
 build
Thread-Index: AQHVVluS1gyMnCV6Q06tSLNUVr8RuacCfVyAgAGEfoCAA1vgAIAACZuA
Date:   Thu, 22 Aug 2019 16:52:52 +0000
Message-ID: <20190822165247.GB8325@mellanox.com>
References: <20190819065827.26921-1-noaos@mellanox.com>
 <20190819065827.26921-4-noaos@mellanox.com>
 <20190819135019.GF5080@mellanox.com>
 <2ac30209-2c89-15ef-3907-98d3cd552f4d@mellanox.com>
 <20190822161813.GI29433@mtr-leonro.mtl.com>
In-Reply-To: <20190822161813.GI29433@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::20) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d412a23-9a48-408b-ceae-08d727212bf5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR05MB6128;
x-ms-traffictypediagnostic: VI1PR05MB6128:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB61281E88972281BC65CB5E41CFA50@VI1PR05MB6128.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(189003)(199004)(53936002)(102836004)(36756003)(186003)(25786009)(6486002)(8936002)(1076003)(81156014)(54906003)(81166006)(8676002)(99286004)(37006003)(6246003)(229853002)(478600001)(6512007)(71200400001)(71190400001)(52116002)(486006)(76176011)(4326008)(6636002)(6862004)(3846002)(6506007)(386003)(86362001)(446003)(33656002)(256004)(66446008)(66556008)(66476007)(26005)(53546011)(305945005)(66066001)(66946007)(316002)(6116002)(2906002)(5660300002)(6436002)(14454004)(2616005)(64756008)(11346002)(476003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6128;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1Cpid/KN9tQWkWvtYkrDCspyOeRcQ9y7fjVe1IZSrxmR6map/NEIPpE3uRof6vZ4hPsAUTTbZvhsmbPivroEI/o1U5LuM3WCkt4mupdx0bydU8IXqBA5xD5WODNMFixCkuDQ7EbuGl1Oby4eTL878SSkZWyJCWqvbR7nohzjDAnogj0i0RWgHWA7KCiPq6Ty0p3oX9attQhP4GWGxfwHeSHiejHRpzS9zZrHfgJ3QQhsVgB9dDh1NuNetLcSp0oZpPud9j0LQWtytMPlB2bTvxgZw8RZ1TWVP4z//yFl4oSb3Y6xQXGgVnSZ+9VIx+wql+AL7ob0K7IGiq/ogNPQ3FmPKdHZ9Qs11w0ppgGGsVe7vnSrhUzTQZQWVkpLLbTfKSwo40Ohk1fv2XacVBRmZRJWBMiPQqx5IZqfLhot+wc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21E117C2E412AE41B7C905CF9D4EA6DE@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d412a23-9a48-408b-ceae-08d727212bf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 16:52:52.3416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nzY+OTcBNW43SnENqvC0esUWN2MihXGlW/EYmH0XZfg9If20TwTmNhkdE0wl+IZSTWadH9NGPbzWTi1Rd+AHRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6128
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gVGh1LCBBdWcgMjIsIDIwMTkgYXQgMDE6MTg6MjRQTSAtMDMwMCwgTGVvbiBSb21hbm92c2t5
IHdyb3RlOg0KPiBPbiBUdWUsIEF1ZyAyMCwgMjAxOSBhdCAwMTowMDo0N1BNICswMDAwLCBOb2Eg
T3NoZXJvdmljaCB3cm90ZToNCj4gPiBPbiA4LzE5LzIwMTkgNDo1MCBQTSwgSmFzb24gR3VudGhv
cnBlIHdyb3RlOg0KPiA+DQo+ID4gPiBJJ2QgcHJlZmVyIHJ1bl90ZXN0cyB0byBiZSBpbiB0aGUg
dGVzdHMgZGlyZWN0b3J5Li4NCj4gPiA+DQo+ID4gPiBKYXNvbg0KPiA+DQo+ID4gUFIgd2FzIHVw
ZGF0ZWQNCj4gDQo+IDEuDQo+IElNSE8sIHJ1bl90ZXN0cy5weSBzaG91bGQgYmUgcGxhY2VkIGlu
c2lkZSB0ZXN0cyBkaXJlY3RvcnkgdG9vIGFuZCBub3QNCj4gb25seSBpbnN0YWxsZWQgaW50byB0
ZXN0cy8uDQoNClllcywgdGhpcyBpcyB3aGF0IEkgbWVudC4gVGhlIGZpbGUgc2hvdWxkIGJlIGlu
IHRlc3RzLyBhbmQgaXQgc2hvdWxkDQpiZSBidWlsdCBpbnRvIGJ1aWxkL2JpbiwgYW5kIGluc3Rh
bGxlZCBpbnRvIHRoZSBleGFtcGxlcw0KDQoNCj4gMi4NCj4gRXhlY3V0aW9uIG9mIHJ1bl90ZXN0
cy5weSBwcm9kdWNlcyBhIGxvdCBvZiB1bnRyYWNrZWQgZmlsZWQNCj4g4p6cICByZG1hLWNvcmUg
Z2l0Oihub2Fvcy1wci10ZXN0cykg4pyXIGdpdCBzdA0KPiBPbiBicmFuY2ggbm9hb3MtcHItdGVz
dHMNCj4gVW50cmFja2VkIGZpbGVzOg0KPiAgICh1c2UgImdpdCBhZGQgPGZpbGU+Li4uIiB0byBp
bmNsdWRlIGluIHdoYXQgd2lsbCBiZSBjb21taXR0ZWQpDQo+IA0KPiAJcHl2ZXJicy9fX2luaXRf
Xy5weWMNCj4gCXB5dmVyYnMvcHl2ZXJic19lcnJvci5weWMNCj4gCXRlc3RzL19faW5pdF9fLnB5
Yw0KPiAJdGVzdHMvYmFzZS5weWMNCj4gCXRlc3RzL3Rlc3RfYWRkci5weWMNCj4gCXRlc3RzL3Rl
c3RfY3EucHljDQo+IAl0ZXN0cy90ZXN0X2RldmljZS5weWMNCj4gCXRlc3RzL3Rlc3RfbXIucHlj
DQo+IAl0ZXN0cy90ZXN0X29kcC5weWMNCj4gCXRlc3RzL3Rlc3RfcGQucHljDQo+IAl0ZXN0cy90
ZXN0X3FwLnB5Yw0KDQoqLnB5YyB3aWxsIGhhdmUgdG8gYmUgYWRkZWQgdG8gdGhlIC5naXRpZ25v
cmUNCg0KPiAzLiBydW5fdGVzdHMucHkgbGFja3Mgb2YgcHl0aG9uMyBzaGViYW5nDQoNCk9yaWdp
bmFsbHkgaXQgd2FzIG5vdCBpbnN0YWxsZWQsIHNvIHRoaXMgd2FzIGZpbmUsIGFzIHRoZSBidWls
ZC9iaW4NCnNjcmlwdCBkb2VzIGFsbCB0aGUgcmVxdWlyZWQgc2V0dXAsIGhvd2V2ZXIgbm93IHRo
YXQgaXQgaXMgdG8gYmUNCmluc3RhbGxlZCBpdCBzaG91bGQgaGF2ZSB0aGUgIyEgLSBhbmQgaXQg
c2hvdWxkIGFsc28gd29yayB3aXRob3V0IGFueQ0KdHJvdWJsZSBmcm9tIGl0J3MgZXhhbXBsZSBs
b2NhdGlvbi4NCg0KSmFzb24NCg==
