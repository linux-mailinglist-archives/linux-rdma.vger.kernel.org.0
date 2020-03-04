Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA5B1799D6
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 21:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgCDUbT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Mar 2020 15:31:19 -0500
Received: from mail-eopbgr30051.outbound.protection.outlook.com ([40.107.3.51]:13637
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728599AbgCDUbT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 4 Mar 2020 15:31:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdknZPSOMMnOONYUFbiRTG6GCzI4YLU15//FRx7q/tQbgHw1O+34/heYHnQOfhrB+j6NsxBqOKzyBCbpq6FxBPwFAldfasoBhYZfw8ClhRsv1PR+aRAlbMtI4PCRlicPZFPQplSWG+yRJiGfi4vl/tAXg9cuKV+Ns1p5GPxIZQeHmiyQSJFqwWToAzQ8k7U/G8G80uUdU72A6fkPWYfsWKwaKe3XOPbZLoL9geUcM7XvXfdMHU+86bF+I5000Tzlvn6JQF0iLdQrvZwXgs6GzODt2Gud9ZMvMzMfSd3MMKSz55sDJcUPglCgZrnvDP3XI+8/acXGoaIQj8H/oteT+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Buve/iScFVMKr6R0QiuV8ily+FYZvOuomkXtKbROlgU=;
 b=S6hThEtMc9H/9mWuF7S2Bp566pT0loqqBktwQjpas1S93SchcAhrg7nFPYv441/BkASbADwc80kD6xXkJ/7OpWiXF7WMvAsDUMmuQHCdMFZwiEWTjMuCuN7+vaoq7uKe1LhLl8+L3KTuLobMT2B2HrCAHWskQwRKFvZ4UktMqrAj0B+bRIswEGQjUNi5Qiut+BOtzcrUIy8/7J/R9OrWrIqCgnctkUAc/5+MD2cW8tQSTtaKwBoByUDpBrG1AYlYjl+jswSylcYq3cprqm04+bfzeojsjmn3t8WItbsmrUOGKaS0cgtirBhlGyIWXv91bhWecZbF1HkKgzZ3KMN9dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Buve/iScFVMKr6R0QiuV8ily+FYZvOuomkXtKbROlgU=;
 b=NWYJwg9rA0DY71x8TXiMroDUBVsITIaFIDFwIluSjBb8SobGlPCiP/Kwi3JF0Mzii2ZuoctmC1F/1g3SXZZwgTdzvng4shpklPygq1ZON7lqv4Cg+V5XuVz+5sMWSS66pDalywNq6pcH8C8GxnqvHITC/M0iDi6e6uHO/hyWozA=
Received: from VI1PR05MB5102.eurprd05.prod.outlook.com (20.177.51.151) by
 VI1PR05MB3214.eurprd05.prod.outlook.com (10.175.243.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.14; Wed, 4 Mar 2020 20:31:14 +0000
Received: from VI1PR05MB5102.eurprd05.prod.outlook.com
 ([fe80::8cea:6c66:19fe:fbc2]) by VI1PR05MB5102.eurprd05.prod.outlook.com
 ([fe80::8cea:6c66:19fe:fbc2%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 20:31:14 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     Eli Cohen <eli@mellanox.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Mark Bloch <markb@mellanox.com>,
        Paul Blakey <paulb@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH] net/mlx5e: Fix an IS_ERR() vs NULL check
Thread-Topic: [PATCH] net/mlx5e: Fix an IS_ERR() vs NULL check
Thread-Index: AQHV8jBcG8P0LrMi6U+EuXhIUs9Pzqg440EA
Date:   Wed, 4 Mar 2020 20:31:13 +0000
Message-ID: <10527910074442142431505e9d424af9128e8c5c.camel@mellanox.com>
References: <20200304142151.qivcobp6ngrynb2p@kili.mountain>
In-Reply-To: <20200304142151.qivcobp6ngrynb2p@kili.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com; 
x-originating-ip: [209.116.155.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f9743dd-0a26-4236-9991-08d7c07afbf5
x-ms-traffictypediagnostic: VI1PR05MB3214:|VI1PR05MB3214:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB3214C10DE53AAEE9E5FE1DA3BEE50@VI1PR05MB3214.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(189003)(199004)(8676002)(54906003)(110136005)(36756003)(81156014)(8936002)(81166006)(316002)(66446008)(66476007)(6512007)(91956017)(66556008)(6506007)(76116006)(64756008)(66946007)(26005)(5660300002)(478600001)(2616005)(86362001)(4326008)(2906002)(6486002)(186003)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3214;H:VI1PR05MB5102.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y064kEn19MwndlsOHFmGOlVZ2WNO6hL/anZfxWKPojUT6IC8h8a5wBpQf9fxsTyKzNpMiA0lgqMWD2q0hdrSNmcD6KvajrQdcswgTQt2J/zFppSsITlcAoTLfkKqcosLqMbrEU0gqaiddgXPYBp9m1WkA4MQXsX1H4I9J5/cREBsv1KR/N8Ahm69iGc+X8MSYcMQ8JiGbBxKVLBlpcNrvNZxMPhp3X2SNd6wh2iJRzApvVYHSO4HNW91h5NNY2k4bcf0WbSX4RzOVwopyZihW1WcasndAl0gbm8JF/fiFLC6tjFDnODz2x/NQZuHJa2MjpP5RruLUNkcvLeWJ8J+gFtdD5KIt5NVgJaP5ROKAtdvnRRFCeQnsVFYz19qjmtYECJRLeNGQ9fO4ONI9MW5rBWfxEROUlY9uzTlX9D+vlc3GT4Lf4o89bKcEA1a5WNv
x-ms-exchange-antispam-messagedata: oQcJLvW+7p4d77vgXPQSQHRzLHYxSN9IKYGZauXXBwYLFfY/1gXk38g+FtW0JPUCPmvR7DuVWFebF541H8OTDgUi97nDW5s99qgeJJUWy81xz0NQmZoCliA4CSU8LT/Ofv2rJn6f0U3eCKjfv8qs5w==
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9CDC103A68E07449A2A6C453E5C0580@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9743dd-0a26-4236-9991-08d7c07afbf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 20:31:13.9385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+Ksa6r1sqZ9vnpXOoeSMFiBbSpCUo2NRO6L/LG9nMnHq/8Ib1BVZq8r/T3FqFPTI14WN/MX5mp6vIwpdR3hsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3214
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gV2VkLCAyMDIwLTAzLTA0IGF0IDE3OjIyICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBUaGUgZXN3X3Zwb3J0X3RibF9nZXQoKSBmdW5jdGlvbiByZXR1cm5zIGVycm9yIHBvaW50ZXJz
IG9uIGVycm9yLg0KPiANCj4gRml4ZXM6IDk2ZTMyNjg3OGZhNSAoIm5ldC9tbHg1ZTogRXN3aXRj
aCwgVXNlIHBlciB2cG9ydCB0YWJsZXMgZm9yDQo+IG1pcnJvcmluZyIpDQo+IFNpZ25lZC1vZmYt
Ynk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4NCg0KSGkgRGFuIHRo
ZSBwYXRjaCBsb29rcyBmaW5lLCBidXQgeW91IGRpZG4ndCBjYyBuZXRkZXYgbWFpbGluZyBsaXN0
DQpUd28gb3B0aW9uczoNCg0KMSkgSSBjYW4gcGljayB0aGlzIHBhdGNoIHVwIGFuZCByZXBvc3Qg
aXQgbXlzZWxmIGluIGEgZnV0dXJlIHB1bGwNCnJlcXVlc3QNCjIpIHlvdSBjYW4gcmUtcG9zdCBp
dCBhbmQgY2MgbmV0ZGV2IGFsc28gbWFyayBpdCBmb3IgbmV0IFtQQVRDSCBuZXRdDQoNCmxldCBt
ZSBrbm93IHdoYXQgeW91IHByZWZlci4NCg0KVGhhbmtzLA0KU2FlZWQuDQoNCg0KPiAtLS0NCj4g
IGRyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lc3dpdGNoX29mZmxvYWRz
LmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkNCj4gDQo+IGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9t
bHg1L2NvcmUvZXN3aXRjaF9vZmZsb2Fkcy5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVs
bGFub3gvbWx4NS9jb3JlL2Vzd2l0Y2hfb2ZmbG9hZHMuYw0KPiBpbmRleCA0YjViNjYxOGRmZjQu
LjY5MmZlOWU2YTA4ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFu
b3gvbWx4NS9jb3JlL2Vzd2l0Y2hfb2ZmbG9hZHMuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZXN3aXRjaF9vZmZsb2Fkcy5jDQo+IEBAIC0xOTgsNyAr
MTk4LDcgQEAgaW50IG1seDVfZXN3X3Zwb3J0X3RibF9nZXQoc3RydWN0IG1seDVfZXN3aXRjaA0K
PiAqZXN3KQ0KPiAgCW1seDVfZXN3X2Zvcl9hbGxfdnBvcnRzKGVzdywgaSwgdnBvcnQpIHsNCj4g
IAkJYXR0ci5pbl9yZXAtPnZwb3J0ID0gdnBvcnQtPnZwb3J0Ow0KPiAgCQlmZGIgPSBlc3dfdnBv
cnRfdGJsX2dldChlc3csICZhdHRyKTsNCj4gLQkJaWYgKCFmZGIpDQo+ICsJCWlmIChJU19FUlIo
ZmRiKSkNCj4gIAkJCWdvdG8gb3V0Ow0KPiAgCX0NCj4gIAlyZXR1cm4gMDsNCg==
