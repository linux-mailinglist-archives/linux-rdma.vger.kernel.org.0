Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A188845B2
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 09:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfHGH0m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 03:26:42 -0400
Received: from mail-eopbgr50069.outbound.protection.outlook.com ([40.107.5.69]:27927
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727566AbfHGH0m (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 03:26:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mESmSZxU/Bzjv/xeaL8QJhTxspkuZdq1BvR3UybZSWGMsOFx83tVF8mOoqqd9DA3Ceg5sNDIvrq2asb1qr79DFeyF7L9T6GC2+0STgn2161J08Ex8VJoqAg3wKN877FsOhrtw1npJJplYa9XLFMiy045tED9tgqhgIMBtvSoMbz8XWEQBQxpyR1TmtRwPe8qrsWgZ2PN7hJBRdRwUNaOlknsxYel9m6c8Pxh6K0M3quaXds0RjmHtsp97j3rdlB37B3mYCqij1K5phjcfwh2sxkna5Tgo/0zMEFgx0bnuvQ5csTCRUN572cbXilPNQFeIP0blrVD1K90Cb190Foi6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfv1RWinWzEg/w4yjekreB61K1ENf6g2eCWanSZqOMI=;
 b=FKHjhwcIcHz1VQurL3fBqiBrN+qAS3JMVF9n53ruip8iiIwIxqn1+EmoUY+hOioPozd8IRRLXwbSbL6Kkb/cawGGeVtICyljWhVOkvoANwv1ZJZ9BNNM6MQQpONNShqHFxYii3FKhb9o5H6/MrXLpyLIt++AR0eJnz6MJvNVG/fYFYnd6baBb9+np7JaqkiJLtYdv94TquBZEJHj2fpZbruEyhheJ+R3le6LGuM0Ae5X+DS4+z3x6nKvK9msY3VRyzemdynhI1ZrsvFL8MASCyW0nw43eGmn8ItA2LxK/ZFXOkFfWTEO5/9x9gCvFDAjZx+ViFCXedp/clEeKfEkmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfv1RWinWzEg/w4yjekreB61K1ENf6g2eCWanSZqOMI=;
 b=HUaie+gm8TCLrzA53YBrH14N19y4M3SBYAjdlPjoDlTbM3zOyDrTIHJlkO44HHJ3S5Ge9IIVo9kERCNfIk9INq+ZaTyyTLd9JmixFACylCwsGZRX89O2Da49R4YGSdnE1whWyaSN/pfbVeQdrSHJhtio2KOAsUrKsRulWLVgXSM=
Received: from AM5PR0502MB2931.eurprd05.prod.outlook.com (10.175.40.12) by
 AM5PR0502MB2866.eurprd05.prod.outlook.com (10.175.45.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Wed, 7 Aug 2019 07:26:35 +0000
Received: from AM5PR0502MB2931.eurprd05.prod.outlook.com
 ([fe80::e85f:70d5:5157:f3bf]) by AM5PR0502MB2931.eurprd05.prod.outlook.com
 ([fe80::e85f:70d5:5157:f3bf%4]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 07:26:35 +0000
From:   Vladimir Koushnir <vladimirk@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Haim Boozaglo <haimbo@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 1/3] libibumad: Support arbitrary number of IB devices
Thread-Topic: [PATCH 1/3] libibumad: Support arbitrary number of IB devices
Thread-Index: AQHVTGS1dlbRQYFwGUWbpTsg4FFs4KbuRQEAgAEEEkA=
Date:   Wed, 7 Aug 2019 07:26:35 +0000
Message-ID: <AM5PR0502MB2931A53B02F2615B967F3B30CED40@AM5PR0502MB2931.eurprd05.prod.outlook.com>
References: <1565102334-20903-1-git-send-email-haimbo@mellanox.com>
 <20190806155206.GZ4832@mtr-leonro.mtl.com>
In-Reply-To: <20190806155206.GZ4832@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vladimirk@mellanox.com; 
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 928a434a-39a5-4270-2805-08d71b0893ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM5PR0502MB2866;
x-ms-traffictypediagnostic: AM5PR0502MB2866:
x-microsoft-antispam-prvs: <AM5PR0502MB286645266DAFDBC59D3C6EA3CED40@AM5PR0502MB2866.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(189003)(13464003)(199004)(55016002)(76116006)(66946007)(6636002)(14444005)(229853002)(476003)(486006)(81156014)(256004)(81166006)(446003)(8676002)(11346002)(64756008)(66556008)(66476007)(66446008)(9686003)(8936002)(6436002)(5660300002)(102836004)(74316002)(76176011)(305945005)(53936002)(33656002)(3846002)(2906002)(68736007)(6116002)(4326008)(7696005)(316002)(14454004)(25786009)(7736002)(66066001)(53546011)(6506007)(478600001)(6246003)(186003)(71200400001)(71190400001)(86362001)(26005)(99286004)(110136005)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0502MB2866;H:AM5PR0502MB2931.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: unDMebUS/JIciL3eWrsnt/4TplwfSRO+Qb/xSffsoWc6FRa96CZcfH+0no46xf/pxFyJfr9ST4M1NOtSnjeUq9AQWYra4ga914Fwx1qs+THlFghsXgc5R2m5SJEf+wt4Ed76LmyBJndRP30AuhoA8B4jiD1D0M41+ZaufVrn25YWQRcVEbFkJI5NHAbsrkAU4ndAYaWkZbdvzf3JHHf7wWRrP5bNWHZ3LgaiG8ZijdSdhzLk5lHX7OwJZKXuYY+yMH9KXpkqG24WT7NTsOfk0seBOALXwSCfjFllGQa0fEYRsmrFglRNDUmV6DcMgYwyrDFA07NSlEp/agMTjBfXsk3X8icEuwA70pzrGWj7eaDm/uN53lUGbpFnNWv0JL3zgDuvY2DNVpTQFJOgQgI1d5CfamCOKlL+9rHijt7NG3g=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 928a434a-39a5-4270-2805-08d71b0893ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 07:26:35.1151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vladimirk@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0502MB2866
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Leon,

For comment #3:
We are not planning to change implementation of libibumad.=20
The patches were developed with existing libibumad code and extending exist=
ing capability to provide list of devices on the node beyond 32 devocs

For comment #4:
Hot-plug is out-of-scope of the libibumad as no persistent data is maintain=
ed by libibumad.

-----Original Message-----
From: Leon Romanovsky <leon@kernel.org>=20
Sent: Tuesday, August 6, 2019 6:52 PM
To: Haim Boozaglo <haimbo@mellanox.com>
Cc: linux-rdma@vger.kernel.org; Vladimir Koushnir <vladimirk@mellanox.com>
Subject: Re: [PATCH 1/3] libibumad: Support arbitrary number of IB devices

On Tue, Aug 06, 2019 at 02:38:52PM +0000, Haim Boozaglo wrote:
> From: Vladimir Koushnir <vladimirk@mellanox.com>
>
> Added new function returning a list of available InfiniBand device names.
> The returned list is not limited to 32 devices.
>
> Signed-off-by: Vladimir Koushnir <vladimirk@mellanox.com>
> Signed-off-by: Haim Boozaglo <haimbo@mellanox.com>
> ---
>  libibumad/CMakeLists.txt              |  2 +-
>  libibumad/libibumad.map               |  6 +++++
>  libibumad/man/umad_free_ca_namelist.3 | 28 ++++++++++++++++++++++++
>  libibumad/man/umad_get_ca_namelist.3  | 34 +++++++++++++++++++++++++++++
>  libibumad/umad.c                      | 41 +++++++++++++++++++++++++++++=
++++++
>  libibumad/umad.h                      |  2 ++
>  6 files changed, 112 insertions(+), 1 deletion(-)  create mode 100644=20
> libibumad/man/umad_free_ca_namelist.3
>  create mode 100644 libibumad/man/umad_get_ca_namelist.3

1. Please use cover letter for patch series.
2. There is a need to update debian package too.
3. Need to use the same discovery mechanism as used in libibverbs - netlink=
 based.
4. Does it work with hot-plug where device name can change?

Thanks
