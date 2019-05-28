Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78F5F2C922
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 16:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfE1OoN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 10:44:13 -0400
Received: from mail-eopbgr130041.outbound.protection.outlook.com ([40.107.13.41]:30977
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbfE1OoN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 May 2019 10:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJ2Q0i4JMUJ7XkWcP6hNysujfas+cgUKHLxEae+Chls=;
 b=Tx3xaGlN6nWvMBpH0oegELivHVih83HaTzvfxgKWR0/G2nJ94XgwLYfT5Sv5QrEY/DNe6/QhkyMx5tSyAXe8tgMmsFuri+3FO8bDuUmFU8aj2MlcfIfLgpZJCA6UfWi9VKAelsgx5gNDXkhxan4OGwsihe0U+k6dewbRC+bNes4=
Received: from AM4PR05MB3313.eurprd05.prod.outlook.com (10.171.189.29) by
 AM4PR05MB3363.eurprd05.prod.outlook.com (10.170.126.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Tue, 28 May 2019 14:44:09 +0000
Received: from AM4PR05MB3313.eurprd05.prod.outlook.com
 ([fe80::55c3:8aaf:20f6:5899]) by AM4PR05MB3313.eurprd05.prod.outlook.com
 ([fe80::55c3:8aaf:20f6:5899%5]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 14:44:09 +0000
From:   Ariel Levkovich <lariel@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Michal Kubecek <mkubecek@suse.cz>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mlx5: avoid 64-bit division
Thread-Topic: [PATCH] mlx5: avoid 64-bit division
Thread-Index: AQHVDv3WwOrE0ucLYUeqHtLWyvJnYqZz4FaAgAy9coD//8jKAA==
Date:   Tue, 28 May 2019 14:44:09 +0000
Message-ID: <849F6C89-EB21-4EAA-A1C0-1E4941B4812E@mellanox.com>
References: <20190520111902.7104DE0184@unicorn.suse.cz>
 <20190520112835.GF4573@mtr-leonro.mtl.com>
 <20190528140145.GO4633@mtr-leonro.mtl.com>
In-Reply-To: <20190528140145.GO4633@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lariel@mellanox.com; 
x-originating-ip: [96.90.253.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 816cbad7-771e-41ee-bec1-08d6e37af13a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM4PR05MB3363;
x-ms-traffictypediagnostic: AM4PR05MB3363:
x-microsoft-antispam-prvs: <AM4PR05MB3363F860989F0D79C0CC65E9BA1E0@AM4PR05MB3363.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(366004)(396003)(199004)(189003)(33656002)(76176011)(8936002)(2906002)(2616005)(64756008)(25786009)(11346002)(54906003)(36756003)(82746002)(6506007)(91956017)(66446008)(110136005)(7736002)(6246003)(8676002)(73956011)(76116006)(305945005)(66476007)(66946007)(66556008)(476003)(81156014)(81166006)(6486002)(486006)(99286004)(446003)(6436002)(102836004)(71200400001)(229853002)(83716004)(6512007)(86362001)(14454004)(26005)(4326008)(256004)(3846002)(53936002)(6116002)(4744005)(68736007)(478600001)(5660300002)(186003)(66066001)(316002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3363;H:AM4PR05MB3313.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jDzduUSiZJVhszRpZTZRU1ANBojk6DaFHqJq6mM1vcdjfgOdYJO7TatGRhYzMHZYxVDQWuGhJDBdHiuFrNvCfs3SAxVzvnc5HgfjNvOxqsTXQRfBoKAKYc0XAB+y2nyFrjP2PEn1fGR+zXw622aLesbIURBA2/EFDMtLlpg/oSBhHtYHAWbQ0LKvk+QgUboA9evoABphZYcIuzpDfpATBVtJxjHFBL37IPimRF6g0m71dtyI3YtB0+GbYDWqrIQFsqYFrijS0pIikkeQLhQDogJsv7epCB/i0kJIoSA1j8M3vFsZXU8hUEImIi7LOXMe0oT5bxD/rlbR23+k647KrjAJXnRTwMkV/uAtn6Z2u1PhYz+JvebJJiXd0ibQtjJq9xhaVqNdeiy4Zl92p2Iwsq/J+lvv3bq3Pyiul2M1kn0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D2E75104A3334448B4F36227A58C61E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 816cbad7-771e-41ee-bec1-08d6e37af13a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 14:44:09.1048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lariel@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3363
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQogICBPbiBNb24sIE1heSAyMCwgMjAxOSBhdCAwMjoyODozNVBNICswMzAwLCBMZW9uIFJvbWFu
b3Zza3kgd3JvdGU6DQogICAgPiA+IE9uIE1vbiwgTWF5IDIwLCAyMDE5IGF0IDAxOjE5OjAyUE0g
KzAyMDAsIE1pY2hhbCBLdWJlY2VrIHdyb3RlOg0KICAgID4gPiA+IENvbW1pdCAyNWMxMzMyNGQw
M2QgKCJJQi9tbHg1OiBBZGQgc3RlZXJpbmcgU1cgSUNNIGRldmljZSBtZW1vcnkgdHlwZSIpDQog
ICAgPiA+ID4gYnJlYWtzIGkzODYgYnVpbGQgYnkgaW50cm9kdWNpbmcgdGhyZWUgNjQtYml0IGRp
dmlzaW9ucy4gQXMgdGhlIGRpdmlzb3INCiAgICA+ID4gPiBpcyBNTFg1X1NXX0lDTV9CTE9DS19T
SVpFKCkgd2hpY2ggaXMgYWx3YXlzIGEgcG93ZXIgb2YgMiwgd2UgY2FuIHJlcGxhY2UNCiAgICA+
ID4gPiB0aGUgZGl2aXNpb24gd2l0aCBiaXQgb3BlcmF0aW9ucy4NCiAgICA+ID4NCiAgICA+ID4g
SW50ZXJlc3RpbmcsIHdlIHRyaWVkIHRvIHNvbHZlIGl0IGRpZmZlcmVudGx5Lg0KICAgID4gPiBJ
IGFkZGVkIGl0IHRvIG91ciByZWdyZXNzaW9uIHRvIGJlIG9uIHRoZSBzYW1lIHNpZGUuDQogICAg
DQogICAgPiBUaGlzIHBhdGNoIHdvcmtzIGZvciB1cy4NCiAgICANCiAgIFllcywgdGhpcyB2YWx1
ZSBpcyBndWFyYW50ZWVkIHRvIGJlIGEgcG93ZXIgb2YgMi4gIFdlIHNhZmVseSB1c2Ugcm91bmRf
dXAoKSBpbnN0ZWFkIGFzIHN1Z2dlc3RlZCBpbiB0aGUgcGF0Y2guDQoNCg==
