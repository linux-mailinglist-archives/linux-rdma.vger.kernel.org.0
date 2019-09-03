Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E891A73B9
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2019 21:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfICTdN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Sep 2019 15:33:13 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:11647
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbfICTdN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Sep 2019 15:33:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMkAoDMVojFuGtJnvyyOK9eVwLngK2kvh2SHeHa21fZSD4Yq25uoC2GTQbYFkCwMV44aFSObAslgiAKbHoH5X2VGEREAdJ0iag9ffhOzMkExH+J1vE52NwZSTPanOA8C6LVUP85hKPDSoM+2bEjKsW47jwYDpLqWUB24CVrV+EMrh9ojjy4uA8xOEHUAkTIsKHKkF/Oa1IBzq7B7UxVG6zrgVceVkZkEDr8wskSXioUCsb8rGws9nBGTxn6AWODam3ZEYFoJ4oR6XVPY0lvTRTHRJlFtPzQLWToXfwWC9j0iFcPXc2/2JtkGzBcjRGtejKIfAfU44Ew+HgltSTJLhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVkPNQ1irTaQKkRNTQE4GGJ7aDwd37HStdsRwSRS5xI=;
 b=UJ5ze3rXAWJCSp+FW3GVzOPjbRiVvnmYVfsI3WbFiyRoy2NjuIgi5KU7dLai9p/KJECf6JPkkdBAW6c3pvLJBnUYKU7Xd++mCxZji6C2RIS4HWVwRkAz7fxhZK09DbEDReAPzfajVlWz2NQf8JCQpFIiNDrRLFmXPC1IyeOCZqOgj5RQxh56d6uAkkygCMv2dHW4UsMEI2CzBL7NK9WnxafW3GbzNG8ILGCH36eRZfoVFEigiuxiSjrr0401BEqX6z200M3qsKVnJC+KA5RbU35QuaEB5DwFKvY5zN2epp+5YSJb50gXkXo044cSjBNAY4TNQefbTDl2I3XorFfDOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVkPNQ1irTaQKkRNTQE4GGJ7aDwd37HStdsRwSRS5xI=;
 b=HVI5r354QvSSpeA40Ok11X8MPJ+7GI4tY40I5TsMFIk8m1exSlAeY1jzRU1cK5LvmFpZ7wmqHH3PKa6W2LHjGp3fX7/hKVHCOiCPZiPEf+qMG6QGNaMDPPtQVKR+LmRS6IDczFOU3TJHJ2pZUrlUrXxFGvbkEsBHcqU+BJzl+Oo=
Received: from VI1PR05MB3342.eurprd05.prod.outlook.com (10.170.238.143) by
 VI1PR05MB4526.eurprd05.prod.outlook.com (20.176.3.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.13; Tue, 3 Sep 2019 19:33:08 +0000
Received: from VI1PR05MB3342.eurprd05.prod.outlook.com
 ([fe80::4499:7719:a52f:a63a]) by VI1PR05MB3342.eurprd05.prod.outlook.com
 ([fe80::4499:7719:a52f:a63a%5]) with mapi id 15.20.2220.021; Tue, 3 Sep 2019
 19:33:08 +0000
From:   Mark Bloch <markb@mellanox.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] iwcm: don't hold the irq disabled lock on iw_rem_ref
Thread-Topic: [PATCH] iwcm: don't hold the irq disabled lock on iw_rem_ref
Thread-Index: AQHVYoztRvUvL8cjA0ub6zOyY+bo1acaV7GA
Date:   Tue, 3 Sep 2019 19:33:08 +0000
Message-ID: <3859b00b-9963-32c5-b6ed-8433fc4ec409@mellanox.com>
References: <20190903192223.17342-1-sagi@grimberg.me>
In-Reply-To: <20190903192223.17342-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:102:2::26) To VI1PR05MB3342.eurprd05.prod.outlook.com
 (2603:10a6:802:1d::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=markb@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [208.186.24.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec7c376f-f5c2-4f8e-95af-08d730a58ca5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR05MB4526;
x-ms-traffictypediagnostic: VI1PR05MB4526:
x-microsoft-antispam-prvs: <VI1PR05MB452639F59D5FC22F5427871FD2B90@VI1PR05MB4526.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:126;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(199004)(189003)(11346002)(66946007)(14454004)(4326008)(6246003)(76176011)(186003)(71190400001)(478600001)(71200400001)(52116002)(316002)(8936002)(6506007)(55236004)(110136005)(81166006)(81156014)(31686004)(8676002)(305945005)(99286004)(26005)(6486002)(7736002)(14444005)(31696002)(102836004)(86362001)(386003)(53546011)(2501003)(66556008)(66446008)(6512007)(64756008)(229853002)(6436002)(66476007)(36756003)(2616005)(2906002)(5660300002)(486006)(446003)(6116002)(66066001)(3846002)(256004)(25786009)(53936002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4526;H:VI1PR05MB3342.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PWAr/48cfNqbhZiHNy6FzNewuY4krv2Koqj6KR8YZo/+wkmJuCdmJQV5TDRpv8ZYSaI1lbGxa2tareHXTGen/zAIr6VDEvnxCz7rBwD5UbkVSp2vML9zQdcJbClID2g46G/SriqlTPCmikh3AuQsr5VtSJTe4G6iwVwxwlm5X/7qgGR2NDv6HL0rvScQRNJo97RhNiTpvMrYdyJyza+9SYiWrZeTgW7CL2Mkd6b4t3MsgiIhzSqz7oogyVJLq1y4CFeCygAT7HIZh0zoA14qcI/iaY6jeJvMhx1uQ0REalOAjAVdAUkoy584kkTkpLuuXFhwQkDg65ldg+PlrlXrS4Xh5mOjUOYQvA33Tgv94Zmun+Pq+PLlRv6CObdBrn9gfLOX7QgieW3U/OjwZMbcLAY3XdqX8ak2oAz86xdlbz8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB8E917B791423498BBAF566A256E709@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7c376f-f5c2-4f8e-95af-08d730a58ca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 19:33:08.5949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +wLJ068OQEjhD1rti14BI/iToIF9kZLirfFUQH+VmLhwbBp31uHShtI3oRRnL7C7iRxQyPzZHgA3JouAsQjm4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4526
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDkvMy8xOSAxMjoyMiBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gVGhpcyBtYXkg
YmUgdGhlIGZpbmFsIHB1dCBvbiBhIHFwIGFuZCByZXN1bHQgaW4gZnJlZWluZw0KPiByZXNvdXJj
ZXNhbmQgc2hvdWxkIG5vdCBiZSBkb25lIHdpdGggaW50ZXJydXB0cyBkaXNhYmxlZC4NCj4gDQo+
IFByb2R1Y2UgdGhlIGZvbGxvd2luZyB3YXJuaW5nOg0KPiAtLQ0KPiBbICAzMTcuMDI2MDQ4XSBX
QVJOSU5HOiBDUFU6IDEgUElEOiA0NDMgYXQga2VybmVsL3NtcC5jOjQyNSBzbXBfY2FsbF9mdW5j
dGlvbl9tYW55KzB4YTAvMHgyNjANCj4gWyAgMzE3LjAyNjEzMV0gQ2FsbCBUcmFjZToNCj4gWyAg
MzE3LjAyNjE1OV0gID8gbG9hZF9uZXdfbW1fY3IzKzB4ZTAvMHhlMA0KPiBbICAzMTcuMDI2MTYx
XSAgb25fZWFjaF9jcHUrMHgyOC8weDUwDQo+IFsgIDMxNy4wMjYxODNdICBfX3B1cmdlX3ZtYXBf
YXJlYV9sYXp5KzB4NzIvMHgxNTANCj4gWyAgMzE3LjAyNjIwMF0gIGZyZWVfdm1hcF9hcmVhX25v
Zmx1c2grMHg3YS8weDkwDQo+IFsgIDMxNy4wMjYyMDJdICByZW1vdmVfdm1fYXJlYSsweDZmLzB4
ODANCj4gWyAgMzE3LjAyNjIwM10gIF9fdnVubWFwKzB4NzEvMHgyMTANCj4gWyAgMzE3LjAyNjIx
MV0gIHNpd19mcmVlX3FwKzB4OGQvMHgxMzAgW3Npd10NCj4gWyAgMzE3LjAyNjIxN10gIGRlc3Ry
b3lfY21faWQrMHhjMy8weDIwMCBbaXdfY21dDQo+IFsgIDMxNy4wMjYyMjJdICByZG1hX2Rlc3Ry
b3lfaWQrMHgyMjQvMHgyYjAgW3JkbWFfY21dDQo+IFsgIDMxNy4wMjYyMjZdICBudm1lX3JkbWFf
cmVzZXRfY3RybF93b3JrKzB4MmMvMHg3MCBbbnZtZV9yZG1hXQ0KPiBbICAzMTcuMDI2MjM1XSAg
cHJvY2Vzc19vbmVfd29yaysweDFmNC8weDNlMA0KPiBbICAzMTcuMDI2MjQ5XSAgd29ya2VyX3Ro
cmVhZCsweDIyMS8weDNlMA0KPiBbICAzMTcuMDI2MjUyXSAgPyBwcm9jZXNzX29uZV93b3JrKzB4
M2UwLzB4M2UwDQo+IFsgIDMxNy4wMjYyNTZdICBrdGhyZWFkKzB4MTE3LzB4MTMwDQo+IFsgIDMx
Ny4wMjYyNjRdICA/IGt0aHJlYWRfY3JlYXRlX3dvcmtlcl9vbl9jcHUrMHg3MC8weDcwDQo+IFsg
IDMxNy4wMjYyNzVdICByZXRfZnJvbV9mb3JrKzB4MzUvMHg0MA0KPiAtLQ0KPiANCj4gU2lnbmVk
LW9mZi1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4NCj4gLS0tDQo+ICBkcml2
ZXJzL2luZmluaWJhbmQvY29yZS9pd2NtLmMgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUv
aXdjbS5jIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvaXdjbS5jDQo+IGluZGV4IDcyMTQxYzVi
N2M5NS4uOTQ1NjYyNzFkYmZmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvY29y
ZS9pd2NtLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvaXdjbS5jDQo+IEBAIC00
MjcsNyArNDI3LDkgQEAgc3RhdGljIHZvaWQgZGVzdHJveV9jbV9pZChzdHJ1Y3QgaXdfY21faWQg
KmNtX2lkKQ0KPiAgCQlicmVhazsNCj4gIAl9DQo+ICAJaWYgKGNtX2lkX3ByaXYtPnFwKSB7DQo+
ICsJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmNtX2lkX3ByaXYtPmxvY2ssIGZsYWdzKTsNCj4g
IAkJY21faWRfcHJpdi0+aWQuZGV2aWNlLT5vcHMuaXdfcmVtX3JlZihjbV9pZF9wcml2LT5xcCk7
DQo+ICsJCXNwaW5fbG9ja19pcnFzYXZlKCZjbV9pZF9wcml2LT5sb2NrLCBmbGFncyk7DQo+ICAJ
CWNtX2lkX3ByaXYtPnFwID0gTlVMTDsNCg0KU2hvdWxkbid0IHlvdSBmaXJzdCBkbyBjbV9pZF9w
cml2LT5xcCA9IE5VTEwgYW5kIG9ubHkgdGhlbg0KdW5sb2NrIGFuZCBkZXN0cm95IHRoZSBxcD8N
Cg0KTWFyaw0KPiAgCX0NCj4gIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZjbV9pZF9wcml2LT5s
b2NrLCBmbGFncyk7DQo+IA0K
