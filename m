Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5FD9FC15
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 09:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfH1HlS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Aug 2019 03:41:18 -0400
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:42816
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726154AbfH1HlS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Aug 2019 03:41:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iT5gvqjZLA3psNUTJcpkEsFqBqVW25NwOwolGfdRe1uszYl9iPapSUAYWIdybaBaYwIpCXZYrVF+sAUdHNNu6oGKQw3uhzaAByGZNDPFZ7PCKz/62Zpi7+VNeGZlwp6ShmObHshe9rojQZ5EfqNk6rgcZP/bl9xzacgbufeb7d1riArwImQwK6uJRdBbaAopWikD9q2oDmlzHsrH07fmD+DFNUJdzbGrXTCnjcNt8QjlY3Vj0zJeW3Fw3dxNU2X1fsx2fp3TqX3gs+UrtDp1Hsef1xotsD85uvHto42BExYDdzFGjxFI5Qd8xhV3a8yxvH4b2p3b+tUyv9Gqdgkn0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWKQzT9K4Qq19UqC6t8xYDSbaxilkenoc5ihoYjgsbQ=;
 b=MGS236Vozubo19F5LqPZZ4Jccsnm3kvuTzvOqfiK+uhO1F2UZJt9+BnUvwLwAee9mDPYfzvK5uVJPnxmMjdhM8BBskUB7O8Uo2RE6VpoT8XwvlCymsZUtHDfyHV3ocA271GqYAvxjCXYWK+M3C4LAyUGvsPhWBYjSI7RczScQjywpWVwlFAdSDyjxKa4R+jwdKlYH28bcSN48HNA+pXaroPBpALuJm2qf2KqZRAyZT4Jvrfee0IajvV0vrtkfxT+pULNxHxrMAN3GkCWsdaq6kc7ZF/KsrWWMXr4H08dAS0OEQxMym+o/5kLmlgKWQZQtx/9JAvWFEhyH7TCMiOUwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWKQzT9K4Qq19UqC6t8xYDSbaxilkenoc5ihoYjgsbQ=;
 b=GuRKiFMGb/x463jdVzHSZdGQ1YUs1HS7LYDjzNXwtED1yxTsodR015s9Ua/KjbImT2KplRlRkvbbRSsEzGYHI/COBGuTdlDKgOE4o9s2AxjBnpY9qFGGH3gg3ij6/iDALL4P5e1/eaW7hp39lfLsMLAsW9m9g0l+9GGYmoiaUDc=
Received: from AM0PR0502MB4068.eurprd05.prod.outlook.com (52.133.38.142) by
 AM0PR0502MB3986.eurprd05.prod.outlook.com (52.133.37.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 28 Aug 2019 07:41:14 +0000
Received: from AM0PR0502MB4068.eurprd05.prod.outlook.com
 ([fe80::9d51:ae68:d177:fc94]) by AM0PR0502MB4068.eurprd05.prod.outlook.com
 ([fe80::9d51:ae68:d177:fc94%3]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 07:41:14 +0000
From:   Eran Ben Elisha <eranbe@mellanox.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [bug report] net/mlx5e: Add mlx5e HV VHCA stats agent
Thread-Topic: [bug report] net/mlx5e: Add mlx5e HV VHCA stats agent
Thread-Index: AQHVXA29z7dP6COpT0yDnBbLjkGbz6cQLxgA
Date:   Wed, 28 Aug 2019 07:41:14 +0000
Message-ID: <c48f8323-553f-b726-3b4e-79ab8167e1c3@mellanox.com>
References: <20190826125645.GA32067@mwanda>
In-Reply-To: <20190826125645.GA32067@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0085.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::25) To AM0PR0502MB4068.eurprd05.prod.outlook.com
 (2603:10a6:208:d::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=eranbe@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5bea41e-aaa8-4a6e-f3b9-08d72b8b1a55
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR0502MB3986;
x-ms-traffictypediagnostic: AM0PR0502MB3986:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR0502MB39862C953191CE34819E375CBAA30@AM0PR0502MB3986.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(199004)(189003)(66066001)(8676002)(107886003)(229853002)(476003)(7736002)(3846002)(486006)(81166006)(14454004)(81156014)(6246003)(2616005)(478600001)(6436002)(36756003)(8936002)(6116002)(86362001)(256004)(6916009)(2906002)(25786009)(31686004)(4326008)(14444005)(53546011)(11346002)(6506007)(71190400001)(71200400001)(5660300002)(53936002)(66946007)(6486002)(316002)(26005)(99286004)(66556008)(52116002)(6512007)(64756008)(186003)(66476007)(66446008)(446003)(102836004)(76176011)(54906003)(305945005)(31696002)(386003)(42413003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0502MB3986;H:AM0PR0502MB4068.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l1dRP9irzlsWjrkiuTXiFygNH8OOkrcfDSdRUO+QhFF2YrOBa9gyXXbDWMKPXZQq6SjmtNgorl+6rnuVIug1wIC4nW59EAlOZd8et5MGwm6tRca/e03NFbG5JbMEHE57iH4xnGV7OagfL2FKdrBiWL/AtYb12xUchoXlKREWaIzeauOm3duSIJPpjtU2DQQv8w48dBjJh+Ci9bXT/YWTqdeibyFVP3bz2PMwk6kqhyL5bbBo1E9hOJklTD9ofVQ7yt7te9KDvNkhzlyuKkTUN+bmoiz9yGGpUxnJOCgzOWxf4MENgwcAD+ymjTrT8MIJy5pq8AWMBrztKWB71Wch10JhYAtmG7KHc0SCmca3BYsLnpozT8TIo+1T6mr0wA5vo2j2nqNeiWeO2vcLdqzWz/g7GSLBZvTdvRZtikTW8z4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D413A7A4C6FECF4F805687114571521F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5bea41e-aaa8-4a6e-f3b9-08d72b8b1a55
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 07:41:14.0262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ONsU+BEqYgR1705OUhnzJoRd46pUWlco9S2z2rKFLylygJoxSB6gDePlU6btbtgq6BPGXVvoADe9vjY/0WGNcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB3986
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDgvMjYvMjAxOSAzOjU2IFBNLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0KPiBIZWxsbyBF
cmFuIEJlbiBFbGlzaGEsDQo+IA0KPiBUaGUgcGF0Y2ggY2VmMzVhZjM0ZDZkOiAibmV0L21seDVl
OiBBZGQgbWx4NWUgSFYgVkhDQSBzdGF0cyBhZ2VudCINCj4gZnJvbSBBdWcgMjIsIDIwMTksIGxl
YWRzIHRvIHRoZSBmb2xsb3dpbmcgc3RhdGljIGNoZWNrZXIgd2FybmluZzoNCj4gDQo+IAlkcml2
ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW4vaHZfdmhjYV9zdGF0cy5jOjQx
IG1seDVlX2h2X3ZoY2FfZmlsbF9zdGF0cygpDQo+IAl3YXJuOiBwb3RlbnRpYWwgcG9pbnRlciBt
YXRoIGlzc3VlICgnYnVmJyBpcyBhIHU2NCBwb2ludGVyKQ0KPiANCj4gZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuL2h2X3ZoY2Ffc3RhdHMuYw0KPiAgICAgIDMzICBz
dGF0aWMgdm9pZCBtbHg1ZV9odl92aGNhX2ZpbGxfc3RhdHMoc3RydWN0IG1seDVlX3ByaXYgKnBy
aXYsIHU2NCAqZGF0YSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeXl5eXl5eXl4NCj4gZGF0YSBpcyBhIHU2
NCBwb2ludGVyLg0KPiANCj4gICAgICAzNCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGludCBidWZfbGVuKQ0KPiAgICAgIDM1ICB7DQo+ICAgICAgMzYgICAgICAgICAgaW50
IGNoLCBpID0gMDsNCj4gICAgICAzNw0KPiAgICAgIDM4ICAgICAgICAgIGZvciAoY2ggPSAwOyBj
aCA8IHByaXYtPm1heF9uY2g7IGNoKyspIHsNCj4gICAgICAzOSAgICAgICAgICAgICAgICAgIHU2
NCAqYnVmID0gZGF0YSArIGk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBeXl5eXl5eXg0K
PiANCj4gICAgICA0MA0KPiAgICAgIDQxICAgICAgICAgICAgICAgICAgaWYgKFdBUk5fT05fT05D
RShidWYgKw0KPiAgICAgIDQyICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXpl
b2Yoc3RydWN0IG1seDVlX2h2X3ZoY2FfcGVyX3Jpbmdfc3RhdHMpID4NCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5e
Xl5eXl5eXl5eXl5eXl5eXg0KPiBUaGlzIHBvaW50ZXIgbWF0aCBkb2Vzbid0IHdvcmsuICBJJ20g
c3VycHJpc2VkIHRoZSB3YXJuaW5nIGRvZXNuJ3QNCj4gdHJpZ2dlci4NCg0KSXQgaXQgbm90IHRy
aWdnZXJlZCBhcyBib3RoICdkYXRhJyBhbmQgJ2J1ZicgYXJlIHU2NCosDQphbmQgc2l6ZW9mKHN0
cnVjdCBtbHg1ZV9odl92aGNhX3Blcl9yaW5nX3N0YXRzKSA8IGJ1Zl9sZW4gYXMgZXhwZWN0ZWQu
DQpUaGlzIGNoZWNrZXIgZG9lcyB0aGUgd29yaywgYnV0IG92ZXIgd3JvbmcgcmFuZ2UuDQoNCg0K
PiANCj4gICAgICA0MyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGF0YSArIGJ1
Zl9sZW4pKQ0KPiAgICAgIDQ0ICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm47DQo+ICAg
ICAgNDUNCj4gICAgICA0NiAgICAgICAgICAgICAgICAgIG1seDVlX2h2X3ZoY2FfZmlsbF9yaW5n
X3N0YXRzKHByaXYsIGNoLA0KPiAgICAgIDQ3ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKHN0cnVjdCBtbHg1ZV9odl92aGNhX3Blcl9yaW5nX3N0YXRzICop
YnVmKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXg0KPiBJZiB3
ZSBtYWRlIGJvdGggImRhdGEiIGFuZCAiYnVmIiB2b2lkIHBvaW50ZXJzIHRoZW4gdGhpcyB3b3Vs
ZCBiZQ0KPiBtdWNoIGVhc2llciBhbmQgdGhlIGNhc3RpbmcgY291bGQgYmUgcmVtb3ZlZC4NCg0K
SSBhZ3JlZSBJIGNhbiBtYWtlIGl0IHNpbXBsZXIsIEkgd2lsbCBwb3N0IGEgZml4Lg0KDQo+IA0K
PiANCj4gICAgICA0OCAgICAgICAgICAgICAgICAgIGkgKz0gc2l6ZW9mKHN0cnVjdCBtbHg1ZV9o
dl92aGNhX3Blcl9yaW5nX3N0YXRzKSAvIHNpemVvZih1NjQpOw0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBeXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5e
Xl5eXl5eXl5eXl5eXl4NCj4gVGhpcyBtYXRoIHdvcmtzLCBidXQgaXQncyBzbyBjb21wbGljYXRl
ZCBhbmQgeW91IGhhdmUgdG8gdmVyaWZ5IHRoYXQNCj4gbWx4NWVfaHZfdmhjYV9wZXJfcmluZ19z
dGF0cyAlIHNpemVvZih1NjQpIGlzIHplcm8uDQoNCkl0IHNob3VsZG4ndCBiZSB6ZXJvLiBCYXNp
Y2FsbHksIGl0IGVxdWFscyB0byBhIHN0YXRpYyB2YWx1ZSBvZiA0Li4uDQp0aGUgY29kZSBpcyB3
cml0dGVuIGluIHRoYXQgd2F5IHRvIHN1cHBvcnQgZXh0ZW5zaW9uIG9mIA0KbWx4NWVfaHZfdmhj
YV9wZXJfcmluZ19zdGF0cyB3aXRob3V0IHRvdWNoaW5nIGhlcmUuDQoNCj4gDQo+ICAgICAgNDkg
ICAgICAgICAgfQ0KPiAgICAgIDUwICB9DQo+IA0KPiByZWdhcmRzLA0KPiBkYW4gY2FycGVudGVy
DQoNClRoYW5rcyB5b3UgZm9yIHRoZSByZXBvcnQsDQpFcmFuDQoNCj4gDQo=
