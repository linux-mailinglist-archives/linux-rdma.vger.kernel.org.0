Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3777150368
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 10:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgBCJcY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 04:32:24 -0500
Received: from mail-db8eur05on2083.outbound.protection.outlook.com ([40.107.20.83]:6148
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727368AbgBCJcY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 3 Feb 2020 04:32:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1vwTi+QV9WFGI7INZFwcIhO2UThyHnOIjmhHnsqz4LwdEgYIfuvYA9uCPrOzbJXgVFt/nho0eVyx94jwfO2AIxHKIH47T5FhunDIGSh+DK3+HZCb0bdrryFHoS5WxLEb9PwpeazuK31sGp5dU66q1ZGCcuJk8F6QKCKbXE2m4gU0Wo4ymSZ6MTX7PFJXq17CBtxc9WlhO88Uoeq9qK5MD7+x3cmM/bHxs8nc0O6rfcHFlJqrzp1tb8kuUUgpLASP6z35BHstvBqguvQLzyWPhqtWDy1hkJyZE2PAiX01UT34B7xhBQVwmxZsJJsVRseRJspuMgNqU5MNBcFSh2qRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mpNMG0bpwT0itlK/Ch9BNbSQ4DRsUU14KrSe7l9USo=;
 b=hoDcoNHHNLr1qwxRvJSmcRsZiHrYihgG/S8xMKSpOQtH2Ck+X3MHklJ/fYzUVhctEd183risgfjWTPZV/wPEpnsbHTx6MBxlF9jJLiQobwmhiLq5216iSDOwKmJMJPRCI9UyPm6+OyjappO7WTLnWItV1uzguuuKVNAqmb19UZCBJ4IitCiCbiAL+JMzlgvOJx4Z+JWdaMXiB9dngzlPMRdBtYGNiWMafxMVUS1/MjJiPdp+28F9/7BCfImMOFkTATLTTWuq21dY5W+mBbW6DXZW0TDHxaGe/9/eEEcg59GOwF4c2hblNU5gFL/w6G7e/gYJ1gTIB6eoqMlkcqE0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mpNMG0bpwT0itlK/Ch9BNbSQ4DRsUU14KrSe7l9USo=;
 b=OkK1bb0xz3oUBUZ8VGgANNm2O5axvx9aaaMT1K0a9eqvn7dv1XOIa9Un35y3z1TtlMqU+/mavza6ZJ79983gCHJrXdQ0JVMUUkTcJHbZ6rgHhWU3Ued2CM3FxRKmi/aA9i6Uzyhclv87q+lo2Am/p2jlTq1Ny1/nex+vv8eB7nw=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB5185.eurprd05.prod.outlook.com (20.178.18.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Mon, 3 Feb 2020 09:32:20 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::445c:4a14:1020:2346]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::445c:4a14:1020:2346%7]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 09:32:20 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Dimitrios Dimitropoulos <d.dimitropoulos@imatrex.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: RDMA without rdma_create_event_channel()
Thread-Topic: RDMA without rdma_create_event_channel()
Thread-Index: AQHV2LyMcnUOPMkllUmX4yFVPngic6gGBI6AgAEN3ICAAHopwIAAmCKAgAETWwA=
Date:   Mon, 3 Feb 2020 09:32:20 +0000
Message-ID: <AM0PR05MB4866E0C180BB66FE15621A6CD1000@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <CAOc41xEmgiw_xekLuhi6uYZ+rKdMrv=5wOJWKisbpYPpBJsdkA@mail.gmail.com>
 <20200201083845.GF414821@unreal>
 <CAOc41xEvwbr5RUMgD2HqEyiX4N6jB0-6mA8btiDbf-moh60oKw@mail.gmail.com>
 <AM0PR05MB4866A0705E7F48EB316F544DD1010@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <CAOc41xFneNFK3KsSkRa5xpsJ04WczLN7DaSa08MBABewE0ekjQ@mail.gmail.com>
In-Reply-To: <CAOc41xFneNFK3KsSkRa5xpsJ04WczLN7DaSa08MBABewE0ekjQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [106.51.31.117]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0869846d-8d3a-4a63-973f-08d7a88bf7a1
x-ms-traffictypediagnostic: AM0PR05MB5185:
x-microsoft-antispam-prvs: <AM0PR05MB51856068AC2F27929C91C283D1000@AM0PR05MB5185.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(189003)(199004)(478600001)(2906002)(55236004)(53546011)(6506007)(8936002)(186003)(26005)(81156014)(81166006)(7696005)(66946007)(316002)(33656002)(8676002)(64756008)(52536014)(66446008)(66476007)(76116006)(66556008)(55016002)(9686003)(6916009)(86362001)(7116003)(71200400001)(4744005)(4326008)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5185;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iPkJKYmRQyHq6R8JCdfoHHqG9f4lSZztFAog1IS8scaPbD1mxh68HM+gk6UA4UoWWNM8euPJHHvDOudIgGqUyz9rfw+pOCAnPwVz2R7tJs4I48VIbqyOeN6epz3Dpva6Fcqg7VeRO+JL0AKWZMPQtTvoKwyJvH82m3dfdTdSDvRynlwvL2OITw8O1XgMuJ1/uc6O+xS7trOkTsIMNBU16BEZQCmFwC5f/yhCn1l1POffuChxuNBEHHtdeyiMyTjF9sFJr4OAUlapOdEqEF9b4d9op/609nOzaRH/K6nILCQ2dDcrhoEoowBs7An1waePHAzfC+T7/ZGEfMON8yEEsb2ZD4E2xebnDeG5VFXBH909X5Q6AjF6iTWYfC2gxaKPoV4Cat6H2iuhuyFRqBoHruI2U5m4JRPsBGJ1pOyGTAuc4PEpoJLhCYtBnwYB43aj
x-ms-exchange-antispam-messagedata: 7+cEZ/p4/Pxqi4bSqdk/IDF6vT8zM72qUfu3rmY+ots76rSivFK4XiGxe+Sh0af43HaTrv1ZL6sR63kX2KUD2N+W0ReUc3B2lynEFFpuNyIG9sTC10PwY7aYqhqAHsZyEuf9mo/QCUUfJ3EM2qeA0g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0869846d-8d3a-4a63-973f-08d7a88bf7a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 09:32:20.4477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JBgxxc/5ZtHxuEE2G5mOmacglJhAnkeKdJA8uqgKgP2pdBQ64Me5Daw+Qf4bOYV8MbZS4xHco/e1mNJtIwSyAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5185
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gRnJvbTogRGltaXRyaW9zIERpbWl0cm9wb3Vsb3MgPGQuZGltaXRyb3BvdWxvc0BpbWF0
cmV4LmNvbT4NCj4gU2VudDogU3VuZGF5LCBGZWJydWFyeSAyLCAyMDIwIDEwOjM2IFBNDQo+IFRv
OiBQYXJhdiBQYW5kaXQgPHBhcmF2QG1lbGxhbm94LmNvbT4NCj4gQ2M6IGxpbnV4LXJkbWFAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBSRE1BIHdpdGhvdXQgcmRtYV9jcmVhdGVfZXZl
bnRfY2hhbm5lbCgpDQo+IA0KPiBIaSBQYXJhdiwNCj4gDQo+IFRoaXMgaXMgbm90IG1lYW50IHRv
IHNjYWxlLiBJJ20ganVzdCBsb29raW5nIHRvIGNvbm5lY3QgYSBzbWFsbCBudW1iZXIgb2YNCj4g
ZGV2aWNlcywgc29tZSBvZiB0aGVtIGFyZSByZXF1aXJlZCB0byBoYXZlIHJlYWwtdGltZSBjYXBh
YmlsaXR5Lg0KPiANCj4gSSBjYW4gZWl0aGVyIHVzZSBhIHNpbXBsZSBjdXN0b20gcGFyYW1ldGVy
IGV4Y2hhbmdlIChlZyB1ZHApIG9yIGFkZCBhDQo+IHByb2Nlc3NvciBhbmQgYSBzb2Z0d2FyZSBs
YXllciB0aGF0IGltcGxlbWVudHMgdGhlIHJkbWEtY20uDQo+IA0KPiBTbyB0aGUgMXN0IGp1c3Qg
c2VlbXMgbW9yZSBkZXNpcmFibGUuDQpPay4gZ290IGl0LiB0aGFua3MuDQo=
