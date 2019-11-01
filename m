Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8DA3EC39B
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2019 14:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfKANWi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Nov 2019 09:22:38 -0400
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:65326
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726667AbfKANWi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 1 Nov 2019 09:22:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yp7+eEvP7/blMveYUERy8kNnO58++Cq1DR1xj/g3z+0aSt2bA/xNNFb5AdpI3hmg6y2iMgmu8HGgX7Z5aJ/4hI8Uko2bjY6FHreFxj7zcMRiiRJ4nC6a2sZYF9m4MfXWCM9rrNyWg8wcyYhuHDK1oMjKLdYY/huxm1WcLcrUNtnxLMrx5j6yHMm7Qson/+znomaiOWqde+golI6JzawvN5tUXTAq04EUY/+kZhuSh9GnNACOCH2RjwirqxsY5Ss4LFEVffDMHtTQBmfuqJsm12/1RM9y7i5fsSJXF/uVqUoR9DZ1I+gN/SV0xBzV258FGHm+QQDjxImiLfTO9dgG4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17/ztEIjQSnubH7PTFMV6Yb4I9v2CWCT/yBbkVikEp4=;
 b=j9EJe/EOsGlXU070zy2zyqBdSZxwa5gyRMMfzVP+c//DcqoZu2rxF7QfBL9eIJtLS2lB1CGPT/HOGNkZo18en8GhabhlujF7agGyYjgut4scSm0+oD+3EXYv14zTl7CIjAq9E4BKdBkyITAAU2nsn+Uh7gR2Dapa3UGIL+y+6yNsFZBX4OBwBSKa/xwFLGITdMOVpg+JoHRwqEYyJv7KgSMhQEE+HMHPl+DRJz+wPIPSw0QB+ZmbuWIvd0PTFwVB8RLlGgBraj5stMXZ0JgoZgv58/R2W+r0iV2+pdVVPmh0CqYAfxvQRAK7mGfr5rH7aj9K5qTPOO5axJ+p8ZRIFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17/ztEIjQSnubH7PTFMV6Yb4I9v2CWCT/yBbkVikEp4=;
 b=KpwesA8HywatBJY1d/IQGR2M78G0F4SYMraf9pdvLXxTO1pyd56HXjzUXH5ZtoQ2o7/Es53yrCVDxylFmd0UXq0YRAAnc16/NVW5JsxhGXbF84lDA3hxdQh8UuztrD+PJQfR7TYVD119Yw8FCMTQORDDEGHaoJ3kolTGxFuLUKk=
Received: from AM6PR05MB4472.eurprd05.prod.outlook.com (52.135.162.157) by
 AM6PR05MB5736.eurprd05.prod.outlook.com (20.178.94.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Fri, 1 Nov 2019 13:21:52 +0000
Received: from AM6PR05MB4472.eurprd05.prod.outlook.com
 ([fe80::6153:6b8:f461:d889]) by AM6PR05MB4472.eurprd05.prod.outlook.com
 ([fe80::6153:6b8:f461:d889%3]) with mapi id 15.20.2387.030; Fri, 1 Nov 2019
 13:21:52 +0000
From:   Mark Zhang <markz@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, oulijun <oulijun@huawei.com>,
        Parav Pandit <parav@mellanox.com>
CC:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: =?utf-8?B?UmU6IOOAkEFzayBmb3IgaGVscOOAkSBBIHF1ZXN0aW9uIGZvciBfX2liX2Nh?=
 =?utf-8?B?Y2hlX2dpZF9hZGQoKQ==?=
Thread-Topic: =?utf-8?B?44CQQXNrIGZvciBoZWxw44CRIEEgcXVlc3Rpb24gZm9yIF9faWJfY2FjaGVf?=
 =?utf-8?Q?gid=5Fadd()?=
Thread-Index: AQHVkLUVzfg4tWU3o0igf5OrzDxDk6d2TSgA
Date:   Fri, 1 Nov 2019 13:21:52 +0000
Message-ID: <f16f1832-6ca2-e606-259e-d039e8e47804@mellanox.com>
References: <fd2a9385-f6c7-8471-b20c-476d4e9fada7@huawei.com>
 <20191101130540.GB30938@ziepe.ca>
In-Reply-To: <20191101130540.GB30938@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:404:a6::27) To AM6PR05MB4472.eurprd05.prod.outlook.com
 (2603:10a6:209:43::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=markz@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [125.118.152.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: edf02831-a479-45ac-1973-08d75ece755b
x-ms-traffictypediagnostic: AM6PR05MB5736:|AM6PR05MB5736:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB5736E138A5A8773E72BDCE98CA620@AM6PR05MB5736.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(54094003)(199004)(189003)(6486002)(4326008)(86362001)(81166006)(81156014)(316002)(64756008)(305945005)(66556008)(31696002)(66476007)(8936002)(54906003)(66946007)(110136005)(71200400001)(6512007)(71190400001)(478600001)(6436002)(6246003)(14444005)(102836004)(2906002)(26005)(186003)(446003)(52116002)(76176011)(6506007)(386003)(36756003)(66446008)(7736002)(25786009)(99286004)(229853002)(14454004)(5660300002)(6116002)(66066001)(3846002)(31686004)(11346002)(486006)(6636002)(476003)(53546011)(2616005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5736;H:AM6PR05MB4472.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /bSzMx0MTFYb8fjogDpfgmn+GWClXxwMQdVqjhqGzfgutiloGPtYncl0Cy9qC1T8npk5+AlfLPGkIVt9dJRrrZsYro30Q3AoP9ssaZumfB55OnDKpPAYCDAsv9BgDIHQ45r29xB4/UeEVh79KF2prMCLxkYonHJPtlVNndScp3ytRcjCgSTBAKvktqTlUPgBWYi5M2VjqfeG6VSicn+EbAL6PV5BdM5OF8nq4uHfyUpV0IpsKd+3rzhb8LuW3iUuGj84KLiBhPivH7+zoFZ9AbdOBydioLg5i+0pta4eOHAIwZTR9yi560GS4ETLMSsECZQBFJlsVyovCUF0I51lopMoVNvlxuhvAuRTcXJtYs+LyDxoHdJzuCY5dchgUIBgkaPh44Rbb1nIOKvC6UXbPSyfNaT+crnD95Q7u+77f3cXUNmsgA22+1zEIXfLbllf
Content-Type: text/plain; charset="utf-8"
Content-ID: <08795D4A3CDD0A49BB60168DFC8FFCCD@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf02831-a479-45ac-1973-08d75ece755b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 13:21:52.4381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: id3GAK3JV7c/p03fF34LPZ1TKyRLrwuvJ0JGyz2R6I5cbb7rXXsYqNeWOW9+icbaIMIchSzQFoUEDXH/vf1Bbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5736
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMTEvMS8yMDE5IDk6MDUgUE0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gRnJpLCBO
b3YgMDEsIDIwMTkgYXQgMDU6MzY6MzZQTSArMDgwMCwgb3VsaWp1biB3cm90ZToNCj4+IEhpDQo+
PiAgICBJIGFtIHVzaW5nIHRoZSB1YnVudHUgc3lzdGVtKDUuMC4wIGtlcm5lbCkgdG8gdGVzdCB0
aGUgaGlwMDggTklDIHBvcnQsLiBXaGVuIEkgbW9kaWZ5IHRoZSBwZXJyIG1hYzEgdG8gbWFjMix0
aGVuIHJlc3RvcmUgdG8gbWFjMSwgaXQgd2lsbCBjYXVzZQ0KPj4gdGhlIGdpZDAgYW5kIGdpZCAx
IG9mIHRoZSByb2NlIHRvIGJlIHVuYXZhaWxhYmxlLCBhbmQgY2hlY2sgdGhhdCB0aGUgL3N5cy9j
bGFzcy9pbmZpbmliYW5kL2huc18wL3BvcnRzLzEvZ2lkX2F0dHJzL25kZXZzLzAgaXMgc2hvdyBp
bnZhbGlkLg0KPj4gdGhlIHByb3RvY29sIHN0YWNrIHByaW50IHdpbGwgYXBwZWFyLg0KPj4NCj4+
ICAgIE9jdCAxNiAxNzo1OTozNiB1YnVudHUga2VybmVsOiBbMjAwNjM1LjQ5NjMxN10gX19pYl9j
YWNoZV9naWRfYWRkOiB1bmFibGUgdG8gYWRkIGdpZCBmZTgwOjAwMDA6MDAwMDowMDAwOjQ2MDA6
NGRmZjpmZWE3Ojk1OTkgZXJyb3I9LTI4DQo+PiBPY3QgMTYgMTc6NTk6MzcgdWJ1bnR1IGtlcm5l
bDogWzIwMDYzNi43MDU4NDhdIDgwMjFxOiBhZGRpbmcgVkxBTiAwIHRvIEhXIGZpbHRlciBvbiBk
ZXZpY2UgZW5wMTg5czBmMA0KPj4gT2N0IDE2IDE3OjU5OjM3IHVidW50dSBrZXJuZWw6IFsyMDA2
MzYuNzA1ODU0XSBfX2liX2NhY2hlX2dpZF9hZGQ6IHVuYWJsZSB0byBhZGQgZ2lkIGZlODA6MDAw
MDowMDAwOjAwMDA6NDYwMDo0ZGZmOmZlYTc6OTU5OSBlcnJvcj0tMjgNCj4+IE9jdCAxNiAxNzo1
OTozOSB1YnVudHUga2VybmVsOiBbMjAwNjM4Ljc1NTgyOF0gaG5zMyAwMDAwOmJkOjAwLjAgZW5w
MTg5czBmMDogbGluayB1cA0KPj4gT2N0IDE2IDE3OjU5OjM5IHVidW50dSBrZXJuZWw6IFsyMDA2
MzguNzU1ODQ3XSBJUHY2OiBBRERSQ09ORihORVRERVZfQ0hBTkdFKTogZW5wMTg5czBmMDogbGlu
ayBiZWNvbWVzIHJlYWR5DQo+PiBPY3QgMTYgMTg6MDA6NTYgdWJ1bnR1IGtlcm5lbDogWzIwMDcx
NS42OTk5NjFdIGhuczMgMDAwMDpiZDowMC4wIGVucDE4OXMwZjA6IGxpbmsgZG93bg0KPj4gT2N0
IDE2IDE4OjAwOjU2IHVidW50dSBrZXJuZWw6IFsyMDA3MTYuMDE2MTQyXSBfX2liX2NhY2hlX2dp
ZF9hZGQ6IHVuYWJsZSB0byBhZGQgZ2lkIGZlODA6MDAwMDowMDAwOjAwMDA6NDYwMDo0ZGZmOmZl
YTc6OTVmNCBlcnJvcj0tMjgNCj4+IE9jdCAxNiAxODowMDo1OCB1YnVudHUga2VybmVsOiBbMjAw
NzE3LjIyOTg1N10gODAyMXE6IGFkZGluZyBWTEFOIDAgdG8gSFcgZmlsdGVyIG9uIGRldmljZSBl
bnAxODlzMGYwDQo+PiBPY3QgMTYgMTg6MDA6NTggdWJ1bnR1IGtlcm5lbDogWzIwMDcxNy4yMjk4
NjNdIF9faWJfY2FjaGVfZ2lkX2FkZDogdW5hYmxlIHRvIGFkZCBnaWQgZmU4MDowMDAwOjAwMDA6
MDAwMDo0NjAwOjRkZmY6ZmVhNzo5NWY0IGVycm9yPS0yOA0KPj4NCj4+IEhhcyBhbnlvbmUgZWxz
ZSBlbmNvdW50ZXJkIGEgc2ltaWxhciBwcm9ibGVtID8gSSB3b25kZXIgaWYgdGhlIF9pYl9jYWNo
ZV9hZGRfZ2lkKCkgaXMgZGVmZWN0aXZlIGluIDUuMCBrZXJuZWw/DQo+IA0KPiBNYXliZSBQYXJh
diBrbm93cz8NCj4gDQpPbmUgcG9zc2liaWxpdHkgaXMsIGR1cmluZyB0aGUgb3BlcmF0aW9uIHlv
dSBoYXZlIHBvcnQgcmVzZXQ7IFRoZW4NCmFsbCBnaWRzIHdpbGwgYmUgZGVsZXRlZCBhbmQgcmUt
Y3JlYXRlZC4gQnV0IGR1cmluZyBnaWRzIHJlLWJ1aWxkDQpnaWQgZW50cnkgIzAgYW5kICMxIGlz
IGluIHVzZSwgc28gdGhleSBjYW5ub3QgYmUgZGVsZXRlZCB0aGVuIHlvdQ0KZ2V0IHRoaXMgZXJy
b3IuDQoNCj4gSmFzb24NCj4gDQoNCg==
