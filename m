Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8A2D01CE
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2019 21:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfJHT6h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Oct 2019 15:58:37 -0400
Received: from mail-eopbgr50046.outbound.protection.outlook.com ([40.107.5.46]:59399
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729436AbfJHT6h (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Oct 2019 15:58:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUE2o4rHQy7yVJNF8DaiVohexToG9XmRr+Qv9Nkx89I+5KZ+cM8vnSbBtmkIuiZQku1fKRneVDVYXzl7tYvKr2S1phELHiY+VSRTcd9YKi9kMVlR2k54Z/I9j+H4URhFT8oFU8HiLf2+X8q6CqcVrQjnx6XRlaWIBpzK7bPq1exUzqo/bpHsclt/bD9rcLCZrqXNNKjAVj2KD92KgWODhteUqoAPLKr9yrIMke2sb1kGWrqCGNMXSwnUVxI+QNsPKy3Ss72Zqia6cZYJrT+fxuf6rVt+P8CKNBCBTYC0+P4TUVSywLNuyx8r7LkWrkrutFOsoyX9Sxss0cbN9V2VVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjFRhpLz5tA8ZSOV5UFIA0jOiKvfw2sdBSvQEpNOiZw=;
 b=RPL+h2F6Y1mONmK4GlI79RtqXIw6ShCB3NrNFrooXJWUom9PG0a+U1+1EKopywIsuxUWPs9q+hz0ogCQ9W6i28nDdp+yQyoKZxVVjAJKdMnhyfnrYExC+ymh3TNcqROPNVYPv/ulUnW/X23lKJssY5/ViFz/nkxmi4FMtAlN1HQAuaCgsO8KJoIsTL4KgsW/NzY2upmB9FrvyG3degQVH2Y4QJyqLc+p3LY+8xKfqyV8m2dho9x4hu5IMx2Znr3O25GSJlPJ9yD6n8WTefprioTd/jcnXTMYTXIDx9O1ingB783qjoKPcJZVDpTTNMfXtEKkvY5p9C05NbtkPYmWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjFRhpLz5tA8ZSOV5UFIA0jOiKvfw2sdBSvQEpNOiZw=;
 b=ESGgjsG3nboJU6DoT34KpJAhMr/xNMAgDRMKo3jJSjcX5w5xYRoD9/FCVfgIk3XGeLZp0y7W0qxqf0wVHYI9l9WjaQDorerlIAyBuMxHx5dzd8If/q87TneZBj6NkvaABVvcLljAKEYsUQjtUjGCwTNKQl3nBbGRHlher1eMRX8=
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com (52.135.129.16) by
 DB7PR05MB5541.eurprd05.prod.outlook.com (20.177.122.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.23; Tue, 8 Oct 2019 19:58:33 +0000
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::18c2:3d9e:4f04:4043]) by DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::18c2:3d9e:4f04:4043%3]) with mapi id 15.20.2327.023; Tue, 8 Oct 2019
 19:58:33 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: Re: [PATCH rdma-next v2 2/4] RDMA/nldev: Allow different fill
 function per resource
Thread-Topic: [PATCH rdma-next v2 2/4] RDMA/nldev: Allow different fill
 function per resource
Thread-Index: AQHVfF368sqaXuIGnkePryNSdjBGRadRLMAA
Date:   Tue, 8 Oct 2019 19:58:33 +0000
Message-ID: <20191008195824.GF22714@mellanox.com>
References: <20191006155139.30632-1-leon@kernel.org>
 <20191006155139.30632-3-leon@kernel.org>
In-Reply-To: <20191006155139.30632-3-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::26) To DB7PR05MB4138.eurprd05.prod.outlook.com
 (2603:10a6:5:23::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1db72ae8-bb48-40dc-ee74-08d74c29e61f
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB7PR05MB5541:|DB7PR05MB5541:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR05MB554128D5117FA51BB258EBAECF9A0@DB7PR05MB5541.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(71200400001)(66946007)(256004)(6436002)(71190400001)(66476007)(66446008)(64756008)(86362001)(66556008)(7736002)(305945005)(478600001)(25786009)(229853002)(14454004)(6486002)(2906002)(4326008)(6512007)(36756003)(107886003)(6246003)(33656002)(11346002)(2616005)(476003)(446003)(8676002)(81166006)(81156014)(26005)(6916009)(76176011)(316002)(486006)(54906003)(8936002)(3846002)(99286004)(5660300002)(52116002)(102836004)(386003)(6506007)(66066001)(186003)(4744005)(1076003)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB5541;H:DB7PR05MB4138.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pQWDsvmS2xZzOJhdGegvH5/aRqCX0eNuWyUm/UC6wr/NN/Q/WJAWeg7+KBhRRWWNsbGW142n10n02EDFLNGPJaPH5HVoDI7mK6R/mtOcLsNdML/QJaVGsMw8cCbcZFJcDdtGlzRVEd1x7ZNyu5yzqU34dbXqcva8sKwOYIicHXcWxmmfPwRa5rKjBobkzVgPfe9hOxcfpwN54N4RRVgHxWhGbM3jyvLf9K+S+i1MIjl66rRCedxN/YVYqWZVxh6t+AwsNLHfBHZC1QGStwp0jPyEVeKfJv+O7sbpeNvdkIfXS+6S9UnH899tpbW+sIm9PRf3StnzQVl89K9mpahP1cp3pMx0FTn8l/ks68ne1bSUHHs95h73Z0QTxMg16ttBHpre76TR8JYPtBh8tq8/j6ff1DDFOE38B16tsVZAljE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9360D9059417E345A05B86EA3D18BDAB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db72ae8-bb48-40dc-ee74-08d74c29e61f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 19:58:33.6435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AV1FDF7bOD1SAgYJwbnjfNEvR7+9XZEdPSrw2Dmc4bMVUB/mqBdUbxKTsd5EJYeNvjLCLDaSqT2Vyu0NCHYd0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5541
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 06, 2019 at 06:51:37PM +0300, Leon Romanovsky wrote:
> From: Erez Alfasi <ereza@mellanox.com>
>=20
> So far res_get_common_{dumpit, doit} was using the default
> resource fill function which was defined as part of the
> nldev_fill_res_entry fill_entries.
>=20
> Add a fill function pointer as an argument allows us to use
> different fill function in case we want to dump different
> values then 'rdma resource' flow do, but still use the same
> existing general resources dumping flow.
>=20
> Signed-off-by: Erez Alfasi <ereza@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/nldev.c | 44 +++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 21 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
