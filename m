Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2054C134098
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 12:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgAHLfe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 06:35:34 -0500
Received: from mail-eopbgr20087.outbound.protection.outlook.com ([40.107.2.87]:21988
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726107AbgAHLfd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Jan 2020 06:35:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnlRyzbyYDHcT/RTfGGCPzRA4RzF2wbOBbX/Uu05ZKod9BeXjvkUeisimzanfMwmz2CwfCbuNxB2cROEhHj4vckkI+FB5Pctjoga9PHXCZYG8YToQVXuz6VbKq3lIb+bCYS5GRLFz7i7dz3kV/E1fPXwsUXu9i8oBgIHN9z49YpjL1259HYdtb6A6OLAdMRA2Gu2yNMqB/MWmNq2DVNLgNDvMKk7U8R460qatKXU+MeUFN4GC+Wfv0eWeV5MipQzvf84mQYNyg0km23fNETTBrUigEFwNkWVnRU4kW6Y36hcvHFlpp+ZjdTIc40HGzPf/2YHy7MJ9mmZa1ZxHkGHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/6T14B25MXc2hE3/CNlwpbfSnrohmTd+12LXElj+cU=;
 b=NX19Ef5lrV3zxcg1j/r+Ku3JOKHkrBSgXMKsCdA+KNYevsX4qyKvR6/SmSbtPjAy5l0aBWAsfRdcO48716GU82ruLQjMYQEL7aDDFcBHsuRM6KjjzPxmN+qYYFNUgOckiQ5rHB38KHbb+VvhpZ/rKaUa4pwWyOawPnBAWOBuWs8g9e3MQIcjN+RM9s5gjs6hK8PnyZ0EmN/IdtPIEgTTFfCXZLSadxOhiPvaLwRpLhVRYGDSMcb00rVFTzoQW0/DfJBUJqaUzEoM+mUv4EBCKpSjbae/Drmr5nsy/GDkD0rEEGHW3SL7c7TiioIT7Ry/jnjtHtelHklXMaI+FkhTWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/6T14B25MXc2hE3/CNlwpbfSnrohmTd+12LXElj+cU=;
 b=HAiOIi5jcu8oz4K3ky7RQQrjZtjq4gfSTUS85ZFcZmXO0Rl/Kqsnduzd9sxm0bCFbMII5Az2wT2X5etRxnzd/j5XoGqNnmi7mhI6U98BrYP/FujfXUN2joOKXzIrrTfqV5+SMm4ZtctqeCsU6/6yi2eoOn8GDT7UC+6yYEBVi4k=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB6818.eurprd05.prod.outlook.com (10.186.175.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 8 Jan 2020 11:35:30 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::445c:4a14:1020:2346]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::445c:4a14:1020:2346%7]) with mapi id 15.20.2602.017; Wed, 8 Jan 2020
 11:35:30 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 2/4] IB/core: Let IB core distribute cache
 update events
Thread-Topic: [PATCH rdma-next v1 2/4] IB/core: Let IB core distribute cache
 update events
Thread-Index: AQHVsN+WLT1q3001602HsZdJTK35Oaff2cwAgADz6YA=
Date:   Wed, 8 Jan 2020 11:35:30 +0000
Message-ID: <ff0e5aa8-d931-0270-9aa1-0a8aacd2a253@mellanox.com>
References: <20191212113024.336702-1-leon@kernel.org>
 <20191212113024.336702-3-leon@kernel.org> <20200107210230.GA7774@ziepe.ca>
In-Reply-To: <20200107210230.GA7774@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [106.51.23.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b74895b1-a424-4386-4f4d-08d7942edd8b
x-ms-traffictypediagnostic: AM0PR05MB6818:|AM0PR05MB6818:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB6818EE9FCDC9E766DE3480A0D13E0@AM0PR05MB6818.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(316002)(81166006)(81156014)(36756003)(54906003)(71200400001)(478600001)(5660300002)(8676002)(53546011)(186003)(8936002)(2906002)(55236004)(26005)(6506007)(110136005)(6512007)(2616005)(4326008)(66556008)(66946007)(66446008)(64756008)(86362001)(31696002)(76116006)(31686004)(91956017)(66476007)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6818;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DyHy+xlpNJebYAQBOBqkW1T8IpGYCi17YRuaW7TP390H0gJNshgY36o33/YxJjXXfd/YxLgAYFyHypymSGOujvZU+4XZT9sIgDtoCuV1ZsEATuNdJw+Gv1XEY42n+jthnZNBE4DV5VnNkrHKORoPfLHkaE1eyn15xNeFDO/TbuwbKoThAeIYiZKDB9xT7R+jt4bhrRULZIQDgNQ1kiQL4xh77blpz8Pt9EgEvywLzPvLyID+gxlJGCZLqfjQ+9RvzvDbMPZQzi6nwEwzocmq+hQtrY0S++L2hmo4pqC9HN9TmRzK+O8lVG+dVuDEwJ5JQVY/VcZ6ITjootdAus4zKMDdfZ8C+PMy8UmMnjY3y440DUKpRlVMlfsk+EBWjqjIRRIB9KvkWv9dqOZvlz00dGEhx4div9qF5CRYdFiXd0J/+0JRdCSevAchz1Ou8NuJ
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A37B0C9D79ED64BAAB6EEDEE7203069@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b74895b1-a424-4386-4f4d-08d7942edd8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 11:35:30.1656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vqYWNVsRvPnPdS4mYZSvqIb50+Scy80QpBVz9sQKvolBSqWvJtvIoA/PRgkyunABUJCghtYvVOJgyZp2l4S57w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6818
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMS84LzIwMjAgMjozMiBBTSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiBPbiBUaHUsIERl
YyAxMiwgMjAxOSBhdCAwMTozMDoyMlBNICswMjAwLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+
IA0KPj4gQEAgLTI2MjcsNyArMjYyNiwxMSBAQCBzdHJ1Y3QgaWJfZGV2aWNlIHsNCj4+ICAJc3Ry
dWN0IHJjdV9oZWFkIHJjdV9oZWFkOw0KPj4NCj4+ICAJc3RydWN0IGxpc3RfaGVhZCAgICAgICAg
ICAgICAgZXZlbnRfaGFuZGxlcl9saXN0Ow0KPj4gLQlzcGlubG9ja190ICAgICAgICAgICAgICAg
ICAgICBldmVudF9oYW5kbGVyX2xvY2s7DQo+PiArCS8qIFByb3RlY3RzIGV2ZW50X2hhbmRsZXJf
bGlzdCAqLw0KPj4gKwlzdHJ1Y3Qgcndfc2VtYXBob3JlIGV2ZW50X2hhbmRsZXJfcndzZW07DQo+
PiArDQo+PiArCS8qIFByb3RlY3RzIFFQJ3MgZXZlbnRfaGFuZGxlciBjYWxscyBhbmQgb3Blbl9x
cCBsaXN0ICovDQo+PiArCXNwaW5sb2NrX3QgZXZlbnRfaGFuZGxlcl9sb2NrOw0KPiANCj4gVGhp
cyBvbmx5IHByb3RlY3RzIHRoZSBvcGVuX3FwIGxpc3QgcmVhbGx5LCB0aGUgZXZlbnQgaGFuZGxl
ciBjYWxsDQo+IGRvZXNuJ3QgbmVlZCBhIHNwaW5sb2NrLiBTbyBsZXRzIG5hbWUgaXQgcHJvcGVy
bHkuIG9wZW5fbGlzdF9sb2NrID8NCj4gDQpZZXMuIGl0IHByb3RlY3RzIG9wZW5fcXAgbGlzdCBh
bmQgZXZlbnQgaGFuZGxlciBpcyBjYWxsZWQgZm9yIGVhY2ggbGlzdA0KaXRlbS4gU28gaXQgZG9l
c24ndCByZWFsbHkgbmVlZCB0byBwcm90ZWN0IGV2ZW50IGhhbmRsZXIgY2FsbHMuDQoNCj4gSXQg
aXMgc29ydCBvZiB3ZWlyZCB0aGF0IHdlIGdsb2JhbGx5IHNlcmlhbGl6ZSBhbGwgdGhlIHFwIGV2
ZW50DQo+IGhhbmRsZXJzPyBpZSB0aGF0IHRoaXMgbG9jayBpc24ndCBpbiB0aGUgaWJfcXAuDQo+
IA0KSXQgcHJvYmFibHkgaXNuJ3QgaW4gZWFjaCBpYl9xcCBiZWNhdXNlIGliX3FwIGlzIGluIGh1
bmRyZWQgdGhvdXNhbmRzDQphbmQgeHJjIHFwIGV2ZW50cyBhcmUgbm90IHNvIGZyZXF1ZW50IGV2
ZW50IHRoYXQgY2FuIGdldCBjb250ZW50ZWQuDQpTbyBJIHRoaW5rIHBlciBkZXZpY2UgcXAgbGlz
dCBsb2NrIHNlZW1zIGZpbmUuDQo=
