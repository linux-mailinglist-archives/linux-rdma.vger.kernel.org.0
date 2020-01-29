Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF65614CA93
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2020 13:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgA2MOm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jan 2020 07:14:42 -0500
Received: from mail-eopbgr130084.outbound.protection.outlook.com ([40.107.13.84]:60743
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726643AbgA2MOm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Jan 2020 07:14:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jR5gnow4eQjfCVO9wh50PEWlKtKzD0mAUjlUvYS00uK/EMrAE/wmZ5hj+oIVy9ICGf2Mqx5DecbiCkeB4E06QLGN/TaARTbqk939WrYjksODyPz81LQxvBPQoM81e55fHKGbZYB5sUQK2hASpEo7ozzm7Mj2d1WvqJG2cS72BZJLv4PoydwbEan6hNGG+cZoKBo1XMOcCu/IWe2lvkR1QpNFd0h5vbUKc/WlFSnQCCHLnhO9JFfHaMlh88i5WcBuJMHB5nlK7ydTr1PiCONjR6qy+2VU5dbSRBgea4w+FUgW/9n0Hi96AbBKfGWUc34pOhzCoLUlf6G9Zk5tM0TiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiDkfsgkrwhFsCMoocCKDgsmN7LJMc+Ra8TQAw8glkA=;
 b=DZxiqC41LE7vgJKdSdM+oaAd9MFK9PhL8KfY4vXocgnbEFZ0SlOwai4kWUTaRMQlytBrFJv0fUdi3VEEd9YMSb7TRvM12WHkd9g9xdWTg6REnGfIZoW5DUtgGjg7+xDG3eiPIrgr9hrIKF+0oyr/90MFkIAq90CZIMKpKUwqFKVby/5AriTjZBpLezewMrRuUi34YHq8vdNmcwBY52A+w7vZ6mGObzUa8QOyk+xSUCM3zIZTZZM88edyQjO2uwODdhwOOQjAOoOm9CgsCA/Vl4G7EvO3xS8c7E8fW0LHjHuMZGAkqNwq5Iv0AL1XncRm7YBQ1FXDMB+a8gyXmgz76w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiDkfsgkrwhFsCMoocCKDgsmN7LJMc+Ra8TQAw8glkA=;
 b=gq1LEUeHN5YPU+oVKUe7/iwt1aOZq3qZR+wg2uL50B7w1AvgJaJgZ38GmxJ/5IANWXEyKUH8jBeT2iHKf1ju2QFTsXqMgwJXcgqb9hyvdUSXwBLGM0pRsBcn4TNRS7lX59WP1PffODRdrwaFSQBQISlK/c/asy8P7Vba/+pDKHk=
Received: from AM0PR05MB5873.eurprd05.prod.outlook.com (20.178.117.153) by
 AM0PR05MB4884.eurprd05.prod.outlook.com (20.177.41.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Wed, 29 Jan 2020 12:14:39 +0000
Received: from AM0PR05MB5873.eurprd05.prod.outlook.com
 ([fe80::a556:1de2:ef6c:9192]) by AM0PR05MB5873.eurprd05.prod.outlook.com
 ([fe80::a556:1de2:ef6c:9192%4]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 12:14:39 +0000
Received: from [10.80.3.21] (193.47.165.251) by FRYP281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Wed, 29 Jan 2020 12:14:38 +0000
From:   Maor Gottlieb <maorg@mellanox.com>
To:     Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/core: Fix protection fault in
 get_pkey_idx_qp_list
Thread-Topic: [PATCH rdma-next] RDMA/core: Fix protection fault in
 get_pkey_idx_qp_list
Thread-Index: AQHV1GxJAjpoCWfOp0KWVbijrJ0hGagBkCEAgAACXgA=
Date:   Wed, 29 Jan 2020 12:14:39 +0000
Message-ID: <35d59005-4bab-38dc-c6c1-a1e1f4cbd8be@mellanox.com>
References: <20200126171553.4916-1-leon@kernel.org>
 <fceb1026-0fb1-5e4f-d617-01a0bcfa21f8@amazon.com>
In-Reply-To: <fceb1026-0fb1-5e4f-d617-01a0bcfa21f8@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.47.165.251]
x-clientproxiedby: FRYP281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::19)
 To AM0PR05MB5873.eurprd05.prod.outlook.com (2603:10a6:208:125::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=maorg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d367bc0-4d37-473b-32a9-08d7a4b4d03d
x-ms-traffictypediagnostic: AM0PR05MB4884:|AM0PR05MB4884:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB4884745BC11613E2D2ECD8CCD3050@AM0PR05MB4884.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(199004)(189003)(8936002)(64756008)(66446008)(5660300002)(31686004)(186003)(16526019)(6486002)(107886003)(81166006)(4326008)(81156014)(66556008)(66946007)(956004)(2616005)(71200400001)(66476007)(8676002)(4744005)(26005)(52116002)(31696002)(2906002)(36756003)(110136005)(53546011)(16576012)(54906003)(86362001)(316002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4884;H:AM0PR05MB5873.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /S2AAfQ5wCy63CUBrBjAzLyN8Y+lIZWkRdhSUKawNba9NReYvJZ+p8monVEhizq0yV7KO5kSNEvriW1jdjInFoyNlkELgOwQkvTetmv7X8eOEngOWwdE34amEhOt2/frP8x06+Fd1A/ApP91myud76i5vLDgPW28Qfb2SDmeuaJum8VTA0It3Lc0NZH4pixgfcSo9JscmAGwVPldN1TgQSw1uo1dUWpLyeul3CVf1UnrSza1Ej2L2nyorAfUa1kBe+20M86uyKbAu290XsnB3MKRt4bidOtkOFozBhp6NglLmXm6hVLQXzgEY2X7IGOXzoCgPhToYyXm8pVgHa1W4GTMSdg946JfMXQ/fBPyms/j382mu/c8lo9Kq1CWDprvARbwA2oFGjb9NX7FmCsFMgLu29kNCZHU1EcCUDWALaTAMMNbcDMhe7Qnbq09Gmd1
x-ms-exchange-antispam-messagedata: zcXmo5Bsr2NfsUQiTN5m6WeA6Yk0TiymB63zP50JLB+MMtRLXNRWOdqoqEjhjHFEs9cHTxkpG6U6zYHQbpiay0+P85PUBZ48BYF/ALBU69an03ehfABkU7Y29sUFrc86Lr9S6RGItUfKnRoNqe5Xmg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <50384F6894DBE64588867BB7BD440F49@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d367bc0-4d37-473b-32a9-08d7a4b4d03d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 12:14:39.2553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eu4TQ9OLgp22DK8lRKBrQoRoO8FLo1UpxBaY13Nlql6RPObzr/RDbMQZ8QqIIp++h4T1TnHLyc58g2S97qNNPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4884
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQpPbiAxLzI5LzIwMjAgMjowNiBQTSwgR2FsIFByZXNzbWFuIHdyb3RlOg0KPiBPbiAyNi8wMS8y
MDIwIDE5OjE1LCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+PiBGcm9tOiBNYW9yIEdvdHRsaWVi
IDxtYW9yZ0BtZWxsYW5veC5jb20+DQo+Pg0KPj4gV2UgZG9uJ3QgbmVlZCB0byBzZXQgcGtleSBh
cyB2YWxpZCBpbiBjYXNlIHRoYXQgdXNlciBzZXQgb25seSBvbmUNCj4+IG9mIHBrZXkgaW5kZXgg
b3IgcG9ydCBudW1iZXIsIG90aGVyd2lzZSBpdCB3aWxsIGJlIHJlc3VsdGVkIGluIE5VTEwNCj4+
IHBvaW50ZXIgZGVyZWZlcmVuY2Ugd2hpbGUgYWNjZXNzaW5nIHRvIHVuaW5pdGlhbGl6ZWQgcGtl
eSBsaXN0Lg0KPiBXaHkgd291bGQgdGhlIHBrZXkgbGlzdCBiZSB1bmluaXRpYWxpemVkPyBJc24n
dCBpdCBpbml0aWFsaXplZCBhcyBhbiBlbXB0eSBsaXN0DQo+IG9uIGRldmljZSByZWdpc3RyYXRp
b24/DQoNCkl0IHdpbGwgdHJ5IHRvIGFjY2VzcyB0byBsaXN0IG9mIGludmFsaWQgcG9ydCAvIHBr
ZXksIGUuZy4gdG8gbGlzdCBvZiANCnBvcnQgMC4gcG9ydF9kYXRhIGlzIGluZGV4ZWQgYnkgcG9y
dCBudW1iZXIuDQpkZXYtPnBvcnRfZGF0YVtwcC0+cG9ydF9udW1dLnBrZXlfbGlzdA0KDQo=
