Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0244A14D715
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2020 08:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgA3Hdp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jan 2020 02:33:45 -0500
Received: from mail-eopbgr60073.outbound.protection.outlook.com ([40.107.6.73]:3717
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbgA3Hdo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Jan 2020 02:33:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuUUdEm5V6RrZ6UqNyP6mw85le609qplPFkMsKaMKfv5TUU6+PZbLohonqCCB7dJLK8/RYRBr/wXv7uNjwuyEHsIzFLwtaBguKgytd4pciUH6vqCTQOZyjnSnkyNCDWGyQy701UtlGN1QuRFmuHZomlnqSwjnpdpXQIYcxeEHjlmHiUTNcZa1elbbh5bTk6fVxS/FtfERabvOHjMzqQ6kv3Oe9oF207B54CkRERnBxuPImgKZY2c0S1x6aOTUO6hb9orNx6XiCuypfn2MHkgx0UqOJSXSAW9ni0ELqIEphbVyYNJCB6128cCBzJBiSUZxjtKfwaPU2CrMV+Z1FzxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0M6+roA/6zJSRbPQOOcqaiSv8p+xVb1MsikyFYq2Ubc=;
 b=hUTzbI1k9d1WJKK9/g/ZSHLZWV3rkzbKlidLWH9Zxk/FawofPM96N5L2IRc4JZvdZyv6KPF6SRuyHq3I2ccdt7nhYz2goC2ubpLhJ66iryqnI6BZzLenyZP4872KkoHUDgRAFFLoAfM/NFZeG5wPoCHQAP2eK+3XeZK2hPK6A0MzrPgZ1ixKmxIR/dkLfsq5lZUvBhx0C+92GTdztnozy6gtE58rhIaw114fM95KJESQHzZVhyd6Fx6hRJp7uct8QBwd/8+Rtkl1eEBe+fwNdPklZ5ERtcZWhMJSQugG5yosFIof5GTdkWVzQQkfy1oI0cLcvltu5T8h8vIq+Ozi3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0M6+roA/6zJSRbPQOOcqaiSv8p+xVb1MsikyFYq2Ubc=;
 b=TG+gT0yMiSVMP60LU9x4RceGY/9ByC+UVYilKpbMQYxgkZpK7jRcN2ZhibVm0Cp4x/vu4lk8eBQ+1og1rHa4ufmL0ZqfpinGMkcLdySrU6qVIkDTYjWbxjMrrhuIubnJmUP0tFg/oyyEw8sXU5cbEZfiTxNIR7vXybxnyHOsW0E=
Received: from AM0PR05MB5873.eurprd05.prod.outlook.com (20.178.117.153) by
 AM0PR05MB6419.eurprd05.prod.outlook.com (20.179.34.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Thu, 30 Jan 2020 07:33:00 +0000
Received: from AM0PR05MB5873.eurprd05.prod.outlook.com
 ([fe80::a556:1de2:ef6c:9192]) by AM0PR05MB5873.eurprd05.prod.outlook.com
 ([fe80::a556:1de2:ef6c:9192%4]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 07:33:00 +0000
Received: from [10.80.3.21] (193.47.165.251) by AM0PR01CA0080.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Thu, 30 Jan 2020 07:32:58 +0000
From:   Maor Gottlieb <maorg@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Gal Pressman <galpress@amazon.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/core: Fix protection fault in
 get_pkey_idx_qp_list
Thread-Topic: [PATCH rdma-next] RDMA/core: Fix protection fault in
 get_pkey_idx_qp_list
Thread-Index: AQHV1GxJAjpoCWfOp0KWVbijrJ0hGagBkCEAgAACXgCAAAgsgIAAfPeAgAC+gIA=
Date:   Thu, 30 Jan 2020 07:32:59 +0000
Message-ID: <2637fe46-ba9d-2a85-af2c-73961edcdf45@mellanox.com>
References: <20200126171553.4916-1-leon@kernel.org>
 <fceb1026-0fb1-5e4f-d617-01a0bcfa21f8@amazon.com>
 <35d59005-4bab-38dc-c6c1-a1e1f4cbd8be@mellanox.com>
 <a2028a8f-bf41-44cc-4b65-0df77ec3406c@amazon.com>
 <20200129201102.GR21192@mellanox.com>
In-Reply-To: <20200129201102.GR21192@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.47.165.251]
x-clientproxiedby: AM0PR01CA0080.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::21) To AM0PR05MB5873.eurprd05.prod.outlook.com
 (2603:10a6:208:125::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=maorg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 05b70f7d-8d82-44c8-3b92-08d7a556a1b9
x-ms-traffictypediagnostic: AM0PR05MB6419:|AM0PR05MB6419:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB6419A76523F56F185AE9362ED3040@AM0PR05MB6419.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02981BE340
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(189003)(199004)(6486002)(5660300002)(31696002)(52116002)(86362001)(31686004)(2616005)(71200400001)(956004)(66446008)(16576012)(316002)(26005)(66476007)(54906003)(4326008)(53546011)(64756008)(66556008)(110136005)(66946007)(186003)(81156014)(8676002)(16526019)(478600001)(36756003)(8936002)(107886003)(2906002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6419;H:AM0PR05MB5873.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iEiABNMPxHYtogh4HB2tYUQ7RrKDEti2Q980qUjlfIgEzPwaX/4QnIFCjirkxyNH4gvmqttHNC8WZia1lH2MreiHqFgNg9Hvf0oG3Q39J5ghbPIntNNjqPu8eIyjFjorU4g+BPNLPLz81HFJPDOjKTVfbnZXvlBMfRgzHVA9697YQf9Y4dKfdpisDVD/LJaZx3NpO1jcH16L0mVogexfHK7ziYTq0qRGcKBZULqF7X4Lw62QNdWDuj6qbvbmFCrRlXsytrFShIpBPkWXWzgQlIStff4XQwznX++W9lTrG78fHvVsbre4rlZpg7JMnyePUSEE+RuJm5Jqa8FIg+8wjNXJwZ+1wDbU/Pr5rzbbl/C4FWVDDG1aiDuKhLn/StXr2sV2LnT/e3+gmaDByssxwAjhj9n1cKZALOew5ibJ8r8zP/6MXKOn7aOkAg1suQhw
x-ms-exchange-antispam-messagedata: 67qeRl/fFV5d8jA7RIvreJzO6oFLUp0/e+ZAq91hKi4/Cklijs5OxaBAJWvSuuQ5VCtwbDcpkmWeXRy7+Vb0z29EvQs3IL7koUD3Oop/ZoIhfY6wlBSRxhXKdxqgegjl6fy3zqi2myP79HKv4s/G2g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EAB773F6A04B64FB0815D032C8B2BA8@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b70f7d-8d82-44c8-3b92-08d7a556a1b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2020 07:32:59.7804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WJLmlIkhgUTt6X+O00cCIc4rvUc0Yf/sIg/ciKIrQigF/bbrORPw9EVB4ELIvQ1pVOupx8CB4ZEYFBXwuyRnew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6419
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQpPbiAxLzI5LzIwMjAgMTA6MTEgUE0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gV2Vk
LCBKYW4gMjksIDIwMjAgYXQgMDI6NDM6NTFQTSArMDIwMCwgR2FsIFByZXNzbWFuIHdyb3RlOg0K
Pj4gT24gMjkvMDEvMjAyMCAxNDoxNCwgTWFvciBHb3R0bGllYiB3cm90ZToNCj4+PiBPbiAxLzI5
LzIwMjAgMjowNiBQTSwgR2FsIFByZXNzbWFuIHdyb3RlOg0KPj4+PiBPbiAyNi8wMS8yMDIwIDE5
OjE1LCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+Pj4+PiBGcm9tOiBNYW9yIEdvdHRsaWViIDxt
YW9yZ0BtZWxsYW5veC5jb20+DQo+Pj4+Pg0KPj4+Pj4gV2UgZG9uJ3QgbmVlZCB0byBzZXQgcGtl
eSBhcyB2YWxpZCBpbiBjYXNlIHRoYXQgdXNlciBzZXQgb25seSBvbmUNCj4+Pj4+IG9mIHBrZXkg
aW5kZXggb3IgcG9ydCBudW1iZXIsIG90aGVyd2lzZSBpdCB3aWxsIGJlIHJlc3VsdGVkIGluIE5V
TEwNCj4+Pj4+IHBvaW50ZXIgZGVyZWZlcmVuY2Ugd2hpbGUgYWNjZXNzaW5nIHRvIHVuaW5pdGlh
bGl6ZWQgcGtleSBsaXN0Lg0KPj4+PiBXaHkgd291bGQgdGhlIHBrZXkgbGlzdCBiZSB1bmluaXRp
YWxpemVkPyBJc24ndCBpdCBpbml0aWFsaXplZCBhcyBhbiBlbXB0eSBsaXN0DQo+Pj4+IG9uIGRl
dmljZSByZWdpc3RyYXRpb24/DQo+Pj4gSXQgd2lsbCB0cnkgdG8gYWNjZXNzIHRvIGxpc3Qgb2Yg
aW52YWxpZCBwb3J0IC8gcGtleSwgZS5nLiB0byBsaXN0IG9mDQo+Pj4gcG9ydCAwLiBwb3J0X2Rh
dGEgaXMgaW5kZXhlZCBieSBwb3J0IG51bWJlci4NCj4+PiBkZXYtPnBvcnRfZGF0YVtwcC0+cG9y
dF9udW1dLnBrZXlfbGlzdA0KPj4gTWFrZXMgc2Vuc2UuDQo+PiBTaG91bGRuJ3QgdGhlcmUgYmUg
YSBjaGVjayBpbiB0aGUgKCFxcF9wcHMpIHNlY3Rpb24gYXMgd2VsbD8gV2Ugc2hvdWxkbid0IGFz
c2lnbg0KPj4gdGhlIGZpZWxkIHVubGVzcyB0aGUgbWFzayBpcyBnaXZlbi4NCj4gSW5kZWVkLCBy
ZWFkaW5nIGEgcXBfYXR0ciBmaWVsZCB3aXRob3V0IHRoZSBjb3JyZXNwb25kaW5nIGJ0IGluDQo+
IHFwX2F0dHJfbWFzayBzZXQgc2hvdWxkIGJlIHdyb25nLg0KDQpBZ3JlZSwgYnV0IGl0IGRvZXNu
J3QgYWZmZWN0IGNhdXNlIHdlIGRvbid0IHVzZSB0aGlzIHZhbHVlIGlmIHRoZSBwa2V5IA0KaXMg
bm90IHZhbGlkLiBIb3dldmVyIEkgY2FuIGFkZCBpdC4NCj4gICANCj4+IERvZXMgdGhpcyB3b3Jr
IGNvcnJlY3RseSBpZiB0aGUgdXNlciBpc3N1ZXMgdHdvIGNhbGxzIHRvIG1vZGlmeV9xcCB3aGVy
ZSB0aGUNCj4+IGZpcnN0IG9uZSBtb2RpZmllcyB0aGUgcGtleSBpbmRleCBhbmQgdGhlIHNlY29u
ZCB0aGUgcG9ydCBudW1iZXIgKGlmIHRoYXQncyBldmVuDQo+PiBwb3NzaWJsZSk/DQo+PiBJcyBp
dCBleHBlY3RlZCB0aGF0IHRoZSBzdGF0ZSB3b3VsZCBzdGF5IGludmFsaWQ/DQo+IEFsc28gc291
bmRzIHdyb25nDQoNCldoZW4gUVAgaXMgbW9kaWZpZWQgZnJvbSByZXNldCB0byBpbml0LCBib3Ro
IHBrZXkgYW5kIHBvcnQgc2hvdWxkIGJlIA0Kc2V0LCBidXQgdGhpcyBjaGVjayBoYXBwZW5zIGxh
dGVyIHdoZW4gdGhlIHZlbmRvciBjYWxsIHRvIA0KaWJfbW9kaWZ5X3FwX2lzX29rLg0KPg0KPiAu
LiBhbmQgdGhlbiB0aGVyZSBpcyB0aGUgY29uZnVzaW5nIHRlc3Rpbmcgb2Ygc3RhdGUgIT0NCj4g
SUJfUE9SVF9QS0VZX05PVF9WQUxJRCBidXQgbm90aGluZyBldmVyIGFzc2lnbnMNCj4gSUJfUE9S
VF9QS0VZX05PVF9WQUxJRC4uIEh1bW0uDQoNCklCX1BPUlRfUEtFWV9OT1RfVkFMSUQgaXMgdGhl
IGRlZmF1bHQgdmFsdWUsIHNldCB3aGVuIHdlIGRvIGt6YWxsb2MuDQoNCj4NCj4gSmFzb24NCg==
