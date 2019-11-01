Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8FAEC3C9
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2019 14:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfKANgS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Nov 2019 09:36:18 -0400
Received: from mail-eopbgr30078.outbound.protection.outlook.com ([40.107.3.78]:9171
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726860AbfKANgS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 1 Nov 2019 09:36:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+ujkzshahCyR94uay8Df4uUuULJehEP/Df6K1l9BXPK5UMHmbven6vpTb9M+xaSHZZrXhvIwl0VsIgLsylPpadrJHb3YpIhWAzKPHbwIS/gLUSx4OfNCy4UYHTS4C6fVROjNXErdweXECcvm3sIlgi6u2y0eFcH9RcKieVYlf6BWGHPUkI2l99S9ZxhxQ8s9lYm9dSn9p/bv1Dq7Ial6Zv5UFoDspHnzbTPwlWeHKTPuuFxKf6zQUYTaQEXtu8dNrvYN0q9taZlwM+gfnrtfhto95f+rU3KtaaOluR6pZ/Shx7qhFUNEgvdIz517+mWtDkXy5Lt3/on32cFVKySAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oSVuiKFICE7QFAJsALBZQT3ft5Rhq6YgQFNKuvpcf0=;
 b=FYEy2Vgf/kV2tA54C+osipC9QzyNsCz4bqugowDfGnoWYkYpJxgj2Ags8PwwxB5jXTH1AaCMtuahWW33XXc2wEzcThIYq0He3StmCzTaCvkR27+Nt95LDsA5O0Fd6jjryaMW5xltgtFGMHp6NopyMNpLEm0P+f8W48pX8f/6rr6tOobu5w98/6JDZ3R7teb+8IxQy/S9/0Swjdx1NOHu6EHjK9pSul30wxDMiw3m4cF0UPlmuCdqR3PZ712t7qo+Q4DGNwH83E3BN/VhobHEC8O8E+W9G3AKUKqb0HfhRsrYk57rWTCee6CUUc9fPHE0+//oIPur4tCVMVTbBeftQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oSVuiKFICE7QFAJsALBZQT3ft5Rhq6YgQFNKuvpcf0=;
 b=GeClg1Tdl3yz+0mkOsfP8ncuPled9nnUHArLNvvy2QhDYErjq6wUU4cST5ffpaDz5LsezQ9PGGfyun0JGuN3Bha24soQk7lMKj7NNn/6Ib7sD/enl7vHNVxG0UygVNSnWP0BcKrTqW5nCFTFWJkoi+UzmIsb4Ke2YtWG20zRzfU=
Received: from AM6PR05MB4472.eurprd05.prod.outlook.com (52.135.162.157) by
 AM6PR05MB6581.eurprd05.prod.outlook.com (20.179.18.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Fri, 1 Nov 2019 13:36:12 +0000
Received: from AM6PR05MB4472.eurprd05.prod.outlook.com
 ([fe80::6153:6b8:f461:d889]) by AM6PR05MB4472.eurprd05.prod.outlook.com
 ([fe80::6153:6b8:f461:d889%3]) with mapi id 15.20.2387.030; Fri, 1 Nov 2019
 13:36:12 +0000
From:   Mark Zhang <markz@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, oulijun <oulijun@huawei.com>,
        Parav Pandit <parav@mellanox.com>
CC:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: =?utf-8?B?UmU6IOOAkEFzayBmb3IgaGVscOOAkSBBIHF1ZXN0aW9uIGZvciBfX2liX2Nh?=
 =?utf-8?B?Y2hlX2dpZF9hZGQoKQ==?=
Thread-Topic: =?utf-8?B?44CQQXNrIGZvciBoZWxw44CRIEEgcXVlc3Rpb24gZm9yIF9faWJfY2FjaGVf?=
 =?utf-8?Q?gid=5Fadd()?=
Thread-Index: AQHVkLUVzfg4tWU3o0igf5OrzDxDk6d2TSgAgAAEAoA=
Date:   Fri, 1 Nov 2019 13:36:12 +0000
Message-ID: <5d1c9c3d-6e28-0977-f02a-8224e40ae233@mellanox.com>
References: <fd2a9385-f6c7-8471-b20c-476d4e9fada7@huawei.com>
 <20191101130540.GB30938@ziepe.ca>
 <f16f1832-6ca2-e606-259e-d039e8e47804@mellanox.com>
In-Reply-To: <f16f1832-6ca2-e606-259e-d039e8e47804@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY2PR0101CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::11) To AM6PR05MB4472.eurprd05.prod.outlook.com
 (2603:10a6:209:43::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=markz@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [125.118.152.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fddcd062-ddc6-4e5f-ec1b-08d75ed0760e
x-ms-traffictypediagnostic: AM6PR05MB6581:|AM6PR05MB6581:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB6581F9918B1D9CF0D4C54BD7CA620@AM6PR05MB6581.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(189003)(199004)(54094003)(256004)(102836004)(81156014)(8936002)(2906002)(71200400001)(5660300002)(71190400001)(486006)(229853002)(386003)(6506007)(6486002)(6116002)(4326008)(81166006)(3846002)(478600001)(6512007)(316002)(7736002)(26005)(305945005)(31686004)(110136005)(54906003)(446003)(11346002)(14444005)(6436002)(25786009)(86362001)(66946007)(64756008)(52116002)(66446008)(76176011)(66556008)(36756003)(6636002)(66476007)(6246003)(53546011)(99286004)(31696002)(476003)(2616005)(66066001)(14454004)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6581;H:AM6PR05MB4472.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l6VYg8gckzRtuFGUYfU6dub3Yt+9ajapH6q9bdIw6X09ew5Y37WLuu3ttmq5YXRgccoEJFv4ACt/osldmOn+qm58/55O+dGou4l0ExmI8aC/zhl+dZ3Z2oHC9q+3uHUYAuMIYiwXg1ED0VmUQEnivq0v7TzA4NADkJX5LckaR4M9LYlQy0zUboR2TM6PPXmrn2vNORPJmnu5aCMKcVqFo55MI5uaNGwHcGw8rVKkwo7wBPlcqs/Ogx2G3lXAE+ZXw0pPfMsCjRfa9p+cfpfeO2eForNqaXEacJ0HXpSAiQGH/A0T55W5W5zKVUFToQZ8/05sJNzoNKH6m19HwdtghQ0uaB89thjWq59iCMUqnCdsItHtqRM7+isCmRxcvwJL2soBQxNubR/xY6yPUCY/wfraNpK0qbjYpGSACECuILAZ6RN98aQxeddQTARnsL5r
Content-Type: text/plain; charset="utf-8"
Content-ID: <467EBD73556F394E94773E472666EADF@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fddcd062-ddc6-4e5f-ec1b-08d75ed0760e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 13:36:12.4671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bBMv+P2Vo4uh4qB7MXc+xlI6lI9K9rS8WWvs/Qq9S//e8lkS1mlfYLI7NiBGXluqrahlO+bp8mvUfyB9v4hc1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6581
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMTEvMS8yMDE5IDk6MjEgUE0sIE1hcmsgWmhhbmcgd3JvdGU6DQo+IE9uIDExLzEvMjAxOSA5
OjA1IFBNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+PiBPbiBGcmksIE5vdiAwMSwgMjAxOSBh
dCAwNTozNjozNlBNICswODAwLCBvdWxpanVuIHdyb3RlOg0KPj4+IEhpDQo+Pj4gICAgIEkgYW0g
dXNpbmcgdGhlIHVidW50dSBzeXN0ZW0oNS4wLjAga2VybmVsKSB0byB0ZXN0IHRoZSBoaXAwOCBO
SUMgcG9ydCwuIFdoZW4gSSBtb2RpZnkgdGhlIHBlcnIgbWFjMSB0byBtYWMyLHRoZW4gcmVzdG9y
ZSB0byBtYWMxLCBpdCB3aWxsIGNhdXNlDQo+Pj4gdGhlIGdpZDAgYW5kIGdpZCAxIG9mIHRoZSBy
b2NlIHRvIGJlIHVuYXZhaWxhYmxlLCBhbmQgY2hlY2sgdGhhdCB0aGUgL3N5cy9jbGFzcy9pbmZp
bmliYW5kL2huc18wL3BvcnRzLzEvZ2lkX2F0dHJzL25kZXZzLzAgaXMgc2hvdyBpbnZhbGlkLg0K
Pj4+IHRoZSBwcm90b2NvbCBzdGFjayBwcmludCB3aWxsIGFwcGVhci4NCj4+Pg0KPj4+ICAgICBP
Y3QgMTYgMTc6NTk6MzYgdWJ1bnR1IGtlcm5lbDogWzIwMDYzNS40OTYzMTddIF9faWJfY2FjaGVf
Z2lkX2FkZDogdW5hYmxlIHRvIGFkZCBnaWQgZmU4MDowMDAwOjAwMDA6MDAwMDo0NjAwOjRkZmY6
ZmVhNzo5NTk5IGVycm9yPS0yOA0KPj4+IE9jdCAxNiAxNzo1OTozNyB1YnVudHUga2VybmVsOiBb
MjAwNjM2LjcwNTg0OF0gODAyMXE6IGFkZGluZyBWTEFOIDAgdG8gSFcgZmlsdGVyIG9uIGRldmlj
ZSBlbnAxODlzMGYwDQo+Pj4gT2N0IDE2IDE3OjU5OjM3IHVidW50dSBrZXJuZWw6IFsyMDA2MzYu
NzA1ODU0XSBfX2liX2NhY2hlX2dpZF9hZGQ6IHVuYWJsZSB0byBhZGQgZ2lkIGZlODA6MDAwMDow
MDAwOjAwMDA6NDYwMDo0ZGZmOmZlYTc6OTU5OSBlcnJvcj0tMjgNCj4+PiBPY3QgMTYgMTc6NTk6
MzkgdWJ1bnR1IGtlcm5lbDogWzIwMDYzOC43NTU4MjhdIGhuczMgMDAwMDpiZDowMC4wIGVucDE4
OXMwZjA6IGxpbmsgdXANCj4+PiBPY3QgMTYgMTc6NTk6MzkgdWJ1bnR1IGtlcm5lbDogWzIwMDYz
OC43NTU4NDddIElQdjY6IEFERFJDT05GKE5FVERFVl9DSEFOR0UpOiBlbnAxODlzMGYwOiBsaW5r
IGJlY29tZXMgcmVhZHkNCj4+PiBPY3QgMTYgMTg6MDA6NTYgdWJ1bnR1IGtlcm5lbDogWzIwMDcx
NS42OTk5NjFdIGhuczMgMDAwMDpiZDowMC4wIGVucDE4OXMwZjA6IGxpbmsgZG93bg0KPj4+IE9j
dCAxNiAxODowMDo1NiB1YnVudHUga2VybmVsOiBbMjAwNzE2LjAxNjE0Ml0gX19pYl9jYWNoZV9n
aWRfYWRkOiB1bmFibGUgdG8gYWRkIGdpZCBmZTgwOjAwMDA6MDAwMDowMDAwOjQ2MDA6NGRmZjpm
ZWE3Ojk1ZjQgZXJyb3I9LTI4DQo+Pj4gT2N0IDE2IDE4OjAwOjU4IHVidW50dSBrZXJuZWw6IFsy
MDA3MTcuMjI5ODU3XSA4MDIxcTogYWRkaW5nIFZMQU4gMCB0byBIVyBmaWx0ZXIgb24gZGV2aWNl
IGVucDE4OXMwZjANCj4+PiBPY3QgMTYgMTg6MDA6NTggdWJ1bnR1IGtlcm5lbDogWzIwMDcxNy4y
Mjk4NjNdIF9faWJfY2FjaGVfZ2lkX2FkZDogdW5hYmxlIHRvIGFkZCBnaWQgZmU4MDowMDAwOjAw
MDA6MDAwMDo0NjAwOjRkZmY6ZmVhNzo5NWY0IGVycm9yPS0yOA0KPj4+DQo+Pj4gSGFzIGFueW9u
ZSBlbHNlIGVuY291bnRlcmQgYSBzaW1pbGFyIHByb2JsZW0gPyBJIHdvbmRlciBpZiB0aGUgX2li
X2NhY2hlX2FkZF9naWQoKSBpcyBkZWZlY3RpdmUgaW4gNS4wIGtlcm5lbD8NCj4+DQo+PiBNYXli
ZSBQYXJhdiBrbm93cz8NCj4+DQo+IE9uZSBwb3NzaWJpbGl0eSBpcywgZHVyaW5nIHRoZSBvcGVy
YXRpb24geW91IGhhdmUgcG9ydCByZXNldDsgVGhlbg0KPiBhbGwgZ2lkcyB3aWxsIGJlIGRlbGV0
ZWQgYW5kIHJlLWNyZWF0ZWQuIEJ1dCBkdXJpbmcgZ2lkcyByZS1idWlsZA0KPiBnaWQgZW50cnkg
IzAgYW5kICMxIGlzIGluIHVzZSwgc28gdGhleSBjYW5ub3QgYmUgZGVsZXRlZCB0aGVuIHlvdQ0K
PiBnZXQgdGhpcyBlcnJvci4NCj4gDQpJIG1lYW4gdGhlbiB5b3UgZ2V0IHRoaXMgZXJyb3IgbWVz
c2FnZSwgd2hpY2ggaXMgZXhwZWN0ZWQuIENoZWNrDQphbGwgdmFsaWQgZ2lkIGVudHJpZXMgYmVm
b3JlIGFuZCBhZnRlciB0aGUgb3BlcmF0aW9uLg0KDQo+PiBKYXNvbg0KPj4NCj4gDQoNCg==
