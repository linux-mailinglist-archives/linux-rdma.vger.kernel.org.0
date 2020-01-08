Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDFA71340C9
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 12:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgAHLmg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 06:42:36 -0500
Received: from mail-db8eur05on2084.outbound.protection.outlook.com ([40.107.20.84]:6188
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727771AbgAHLmf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Jan 2020 06:42:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLckPHCAGzxu1XbX6X/JucrZNqEOI2FAw+qeMjKktU9x4TY8T6JnLb4yxgmG7lwurBLvd59ga6NVQquQuFzMcoWYnw7fmdAH2s2rCMAF8h8YApnr0/K+TbZaXrxvbBLJXbZEnm+gylzO8qEdQSt4YUqe/IrJfi+X5jmeKJLlM06YnLbrwwI4H9ZKL6VUW2M7iZ71qTKXNOA//SjbI7DeJygygJCP7HipfTvddX6vbavvCl+mpq/5rWonaqo/1hsZc8UNU1eC3mjAj77XQQOBTUwO+6mXJK27MUXSCnVRCxNZaejqpUKWp7oLFf+D/2R4GRQ+KLk0SfViptghKQtaUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cvZE6Mrmgs9wHc8estQlShhuof3yoRaI9ve++ozXiw=;
 b=Ojkp7TGgBB6dV2oA9f0f8fESeqsSNTm+4j7ZEdCWe4UztBePQahIPM/IxwwhAOVsuZNy99DegrhBumhHXNL+F66Yc6IW/P/RoLjEdRD5rXDqnWnrvVYShm9hW9hX/G6FMfHQt846vemEUMbKl7lrjsddWw+xnLmkrMbBCpfrNYZNVtnPZS34gewZ8/jjam8T79iJO7b5pUckE4SVb+9FRwPygPyjYOPYpKMaXwPgi5IGzvQ6cUvQcpGOID78N0TfqoPBnrRkDLKcfHp8bGWkdhaStRbZOs8ve8MbmKb1Tj/xCtInutEWD2fDYeCyJnUGc3mfoCj9Pp+k6d/UbgXtgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cvZE6Mrmgs9wHc8estQlShhuof3yoRaI9ve++ozXiw=;
 b=DE1krHOfrweK4XU02scrD4tx1/qJgs9f35KfaObmZSBjrXkA1F9K9MikOmR7sinE6bISycS3ZDF6LaCqflmUP5g3qCXur1Kv24hqdDuWGw+UhXbdZ1cxLIi+oisnVTI1+GbYJjPerclSnz6haSXPUd19NyQ0JH4PqaUDGPNzpm0=
Received: from AM0SPR01MB0081.eurprd05.prod.outlook.com (20.179.39.225) by
 AM0PR05MB4499.eurprd05.prod.outlook.com (52.134.92.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Wed, 8 Jan 2020 11:42:32 +0000
Received: from AM0SPR01MB0081.eurprd05.prod.outlook.com
 ([fe80::84fe:4066:5003:2c6c]) by AM0SPR01MB0081.eurprd05.prod.outlook.com
 ([fe80::84fe:4066:5003:2c6c%5]) with mapi id 15.20.2623.008; Wed, 8 Jan 2020
 11:42:32 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 0/4] Let IB core distribute cache update
 events
Thread-Topic: [PATCH rdma-next v1 0/4] Let IB core distribute cache update
 events
Thread-Index: AQHVsN+TO30D8o4LykakI68T5Oh7UafgE0gAgAC8ZIA=
Date:   Wed, 8 Jan 2020 11:42:32 +0000
Message-ID: <d9572722-466d-eb60-716e-a4de27c618f3@mellanox.com>
References: <20191212113024.336702-1-leon@kernel.org>
 <20200108002814.GA1937@ziepe.ca>
In-Reply-To: <20200108002814.GA1937@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [106.51.23.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0f8e5109-00f0-46c8-04de-08d7942fd93b
x-ms-traffictypediagnostic: AM0PR05MB4499:|AM0PR05MB4499:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB4499B92127050754090A9EA8D13E0@AM0PR05MB4499.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(189003)(199004)(71200400001)(478600001)(36756003)(26005)(6512007)(186003)(31686004)(8676002)(110136005)(316002)(54906003)(4326008)(81156014)(8936002)(2906002)(81166006)(4744005)(5660300002)(6486002)(53546011)(6506007)(15650500001)(55236004)(31696002)(76116006)(66476007)(86362001)(66946007)(2616005)(66556008)(66446008)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4499;H:AM0SPR01MB0081.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EPDRY11EKfHxTbisdYz9/7wME3LKJsYhodilOjfbPe5ZyLq0yPaqOlZzAhgsIUKJgwim9bHAWY5pPXnQdQKjEJ5rpAH5mVtvZfp8mffs72+hP/gKQr09lPEit2AWWjODhEpfG2eY9BYHPy9ZwvAw8s1BMIJm2lBEx+woKO3Lvx7R2XqwJ1RTcLReo2gJj1Rquu2tqsLjj4kkJEKM5VSAATthjPxZ4E9FIKFDzg2wfMyTgwqcx4Qe8+FcOcNoao02WNgKEDZd9ABtH9iixW0W+Xh/rIU7UD31d/u8NQ+QJtI6RsmJ9Ca5NYEz2sc4L/KCpjajTvDWuNdwcWAI6HqLyMwBo6Qe4Xo0EXDHbRyx9QMGQp7eM1AiOyhrhEhtzM1n+lJiVoGwbEqQJWWSnNPpIbysI6MjB+VvtPV0r/HH1t8MOTbG4FZGQMCOp8af1zfG
Content-Type: text/plain; charset="utf-8"
Content-ID: <79670CB99B26684F9A42F97FAF038C23@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8e5109-00f0-46c8-04de-08d7942fd93b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 11:42:32.2173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xVpOnZtLtEEv2tvjdG+3b1nOMnP+CpM2EQKKW0a+2OxM7eJlKxsWQizGUFKdTKRCTsJ8TnJ/YxMOnUj0mRtaew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4499
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMS84LzIwMjAgNTo1OCBBTSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiBPbiBUaHUsIERl
YyAxMiwgMjAxOSBhdCAwMTozMDoyMFBNICswMjAwLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+
IA0KPj4gUGFyYXYgUGFuZGl0ICg0KToNCj4+ICAgSUIvbWx4NTogRG8gcmV2ZXJzZSBzZXF1ZW5j
ZSBkdXJpbmcgZGV2aWNlIHJlbW92YWwNCj4+ICAgSUIvY29yZTogTGV0IElCIGNvcmUgZGlzdHJp
YnV0ZSBjYWNoZSB1cGRhdGUgZXZlbnRzDQo+PiAgIElCL2NvcmU6IEN1dCBkb3duIHNpbmdsZSBt
ZW1iZXIgaWJfY2FjaGUgc3RydWN0dXJlDQo+PiAgIElCL2NvcmU6IFByZWZpeCBxcCB0byBldmVu
dF9oYW5kbGVyX2xvY2sNCj4gDQo+IEkgdXNlZCBxcF9vcGVuX2xpc3RfbG9jayBpbiB0aGUgbGFz
dCBwYXRjaCwgYW5kIEknbSBzdGlsbCBpbnRlcmVzdGVkDQo+IGlmL3doeSBnbG9iYWxseSBzZXJp
YWxpemluZyB0aGUgcXAgaGFuZGxlcnMgaXMgcmVxdWlyZWQsIG9yIGlmIHRoYXQNCj4gY291bGQg
YmUgcncgc3BpbmxvY2sgdG9vLg0KPiANCk15IHVuZGVyc3RhbmRpbmcgaXMgYXMgaW4gZW1haWwg
b2YgcGF0Y2gtMiwgaXRzIG9wZW5fbGlzdF9sb2NrLg0KcHJvYmFibHkgdGhlcmUgaXNuJ3QgdG9v
IG11Y2ggY29udGVudGlvbiwgYnV0IHllcyBpdCBjYW4gYmUgY2hhbmdlZCB0bw0Kcncgc3Bpbmxv
Y2suDQoNCj4gT3RoZXJ3aXNlIGFwcGxpZWQgdG8gZm9yLW5leHQNCj4gDQpUaGFua3MuDQo=
