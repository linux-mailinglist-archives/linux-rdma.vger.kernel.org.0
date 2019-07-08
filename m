Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B3262935
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 21:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbfGHTWu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 15:22:50 -0400
Received: from mail-eopbgr10051.outbound.protection.outlook.com ([40.107.1.51]:29622
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728461AbfGHTWt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 8 Jul 2019 15:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tg6GpmkeZIf0u6HOUf+Pfae/xW1hegSbChLY+D4SdrI=;
 b=SY10zG29dyEhTVoEC4Y5N21a+BlxocZyx9YLosEjCf/8rV01j0scPAQAbJj7DtEMZAnMVQf2CuPzW6Sdg7Po3CHOHj/jAE3gee1Fg7RwMzVnBsiG5ASTpL/WPIpq5U7MHJAaSUGnh7OHJTIzNzCEJU3ALTxpRTChj6lfGBd8PUA=
Received: from AM0PR05MB4403.eurprd05.prod.outlook.com (52.134.125.139) by
 AM0PR05MB5347.eurprd05.prod.outlook.com (20.178.20.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Mon, 8 Jul 2019 19:22:45 +0000
Received: from AM0PR05MB4403.eurprd05.prod.outlook.com
 ([fe80::1016:2c86:974b:abf1]) by AM0PR05MB4403.eurprd05.prod.outlook.com
 ([fe80::1016:2c86:974b:abf1%4]) with mapi id 15.20.2052.020; Mon, 8 Jul 2019
 19:22:45 +0000
From:   Mark Bloch <markb@mellanox.com>
To:     Dag Moxnes <dag.moxnes@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] RDMA/core: Fix race when resolving IP address
Thread-Topic: [PATCH v3] RDMA/core: Fix race when resolving IP address
Thread-Index: AQHVNX63z9a/mwC5LEKB5/+LX+ELSqbBAECAgAAP/ACAAAnHgA==
Date:   Mon, 8 Jul 2019 19:22:45 +0000
Message-ID: <63b9d2cb-f69c-d77c-7803-f08e2a6f755d@mellanox.com>
References: <1562584584-13132-1-git-send-email-dag.moxnes@oracle.com>
 <20190708175025.GA6976@ziepe.ca>
 <4b9ae7b8-310c-e0b6-7a8e-33e6d5bef83d@oracle.com>
In-Reply-To: <4b9ae7b8-310c-e0b6-7a8e-33e6d5bef83d@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::17) To AM0PR05MB4403.eurprd05.prod.outlook.com
 (2603:10a6:208:65::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=markb@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [208.186.24.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ef328da-c5d3-4e59-f80e-08d703d9a7b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR05MB5347;
x-ms-traffictypediagnostic: AM0PR05MB5347:
x-microsoft-antispam-prvs: <AM0PR05MB534788E9B25D39042660640FD2F60@AM0PR05MB5347.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(478600001)(186003)(86362001)(4326008)(6246003)(316002)(31696002)(25786009)(11346002)(2906002)(486006)(476003)(110136005)(54906003)(68736007)(2616005)(446003)(31686004)(14454004)(26005)(36756003)(71200400001)(71190400001)(6512007)(53936002)(6436002)(6486002)(305945005)(6116002)(3846002)(229853002)(99286004)(66066001)(8676002)(256004)(14444005)(55236004)(76176011)(5660300002)(81166006)(81156014)(66946007)(52116002)(386003)(6506007)(66476007)(8936002)(53546011)(66446008)(64756008)(7736002)(66556008)(102836004)(73956011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5347;H:AM0PR05MB4403.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ofSpCV0CVG3tUuV3UfyycpSf4cbAL+UBkm6JVzazJYJMIaXvnhrsaQfh7jyeFp/uPkTMf7RSskSoNj7zp30/fs2SDuCa9ob12sgWHNzU3BgNg9Snv2pah+9bbOCnEQw02MG9QT6sB6rxzPLxWtJEz5pFOcRK5YYTpTIY78aZBzDjqa0d7owXNtOXznQ2iO6VGF45GyMdi/AOMVIMbZA1B/uxtE5EzQUrCPELlbZ7yxxfpXnbrXfTkWstg7MtMFZeVy9WsB1CajGveml8JJO1jwjKAg4sk1H/qu1np02jrNpwjhAjwZ6Bu4HKb8fO2rz4WjKiHYA/bEKtMydCUDEFi90PryFix+XJQ7RR/3XbxVLUTwLLz09kzTpqL9V6kxGZUZl7gngPxDoD+gq4TIa/xLl5dtTUk0tw7jxr2Sk5uqo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1571C690966D18479A9602A0FCA74178@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef328da-c5d3-4e59-f80e-08d703d9a7b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 19:22:45.4402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: markb@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5347
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDcvOC8xOSAxMTo0NyBBTSwgRGFnIE1veG5lcyB3cm90ZToNCj4gVGhhbmtzIEphc29u
LA0KPiANCj4gUmVnYXJkcywNCj4gRGFnDQo+IA0KPiBEZW4gMDguMDcuMjAxOSAxOTo1MCwgc2ty
ZXYgSmFzb24gR3VudGhvcnBlOg0KPj4gT24gTW9uLCBKdWwgMDgsIDIwMTkgYXQgMDE6MTY6MjRQ
TSArMDIwMCwgRGFnIE1veG5lcyB3cm90ZToNCj4+PiBVc2UgbmVpZ2hib3VyIGxvY2sgd2hlbiBj
b3B5aW5nIE1BQyBhZGRyZXNzIGZyb20gbmVpZ2hib3VyIGRhdGEgc3RydWN0DQo+Pj4gaW4gZHN0
X2ZldGNoX2hhLg0KPj4+DQo+Pj4gV2hlbiBub3QgdXNpbmcgdGhlIGxvY2ssIGl0IGlzIHBvc3Np
YmxlIGZvciB0aGUgZnVuY3Rpb24gdG8gcmFjZSB3aXRoDQo+Pj4gbmVpZ2hfdXBkYXRlLCBjYXVz
aW5nIGl0IHRvIGNvcHkgYW4gaW52YWxpZCBNQUMgYWRkcmVzcy4NCj4+Pg0KPj4+IEl0IGlzIHBv
c3NpYmxlIHRvIHByb3Zva2UgdGhpcyBlcnJvciBieSBjYWxsaW5nIHJkbWFfcmVzb2x2ZV9hZGRy
IGluIGENCj4+PiB0aWdodCBsb29wLCB3aGlsZSBkZWxldGluZyB0aGUgY29ycmVzcG9uZGluZyBB
UlAgZW50cnkgaW4gYW5vdGhlciB0aWdodA0KPj4+IGxvb3AuDQo+Pj4NCj4+PiBUaGlzIHdpbGwg
Y2F1c2UgdGhlIHJhY2Ugc2hvd24gaXQgdGhlIGZvbGxvd2luZyBzYW1wbGUgdHJhY2U6DQo+Pj4N
Cj4+PiByZG1hX3Jlc29sdmVfYWRkcigpDQo+Pj4gwqDCoCByZG1hX3Jlc29sdmVfaXAoKQ0KPj4+
IMKgwqDCoMKgIGFkZHJfcmVzb2x2ZSgpDQo+Pj4gwqDCoMKgwqDCoMKgIGFkZHJfcmVzb2x2ZV9u
ZWlnaCgpDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBmZXRjaF9oYSgpDQo+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZHN0X2ZldGNoX2hhKCkNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbi0+
bnVkX3N0YXRlID09IE5VRF9WQUxJRA0KPj4gSXQgaXNuJ3QgbnVkX3N0YXRlIHRoYXQgaXMgdGhl
IHByb2JsZW0gaGVyZSwgaXQgaXMgdGhlIHBhcmFsbGVsDQo+PiBtZW1jcHkncyBvbnRvIGhhLiBJ
IGZpeGVkIHRoZSBjb21taXQgbWVzc2FnZQ0KPj4NCj4+IFRoaXMgY291bGQgYWxzbyBoYXZlIGJl
ZW4gc29sdmVkIGJ5IHVzaW5nIHRoZSBoYV9sb2NrLCBidXQgSSBkb24ndA0KPj4gdGhpbmsgd2Ug
aGF2ZSBhIHJlYXNvbiB0byBwYXJ0aWN1bGFybHkgb3Zlci1vcHRpbWl6ZSB0aGlzLg0KDQpTb3Jy
eSBJJ20gbGF0ZSB0byB0aGUgcGFydHksIGJ1dCB3aHkgbm90IGp1c3QgdXNlOiBuZWlnaF9oYV9z
bmFwc2hvdCgpPw0KDQo+Pg0KPj4+IMKgIGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2FkZHIuYyB8
IDkgKysrKysrLS0tDQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkNCj4+IEFwcGxpZWQgdG8gZm9yLW5leHQsIHRoYW5rcw0KPj4NCj4+IEphc29u
DQo+IA0KDQpNYXJrDQo=
