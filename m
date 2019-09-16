Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F573B4088
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2019 20:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfIPSs3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Sep 2019 14:48:29 -0400
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:57309
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730107AbfIPSs3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Sep 2019 14:48:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvqDfgvGD8bVNdK8Y11yB1lXwZOAzOIINrbHixda2UyH3Wp5Tw/T6gquqHI5y7GSXtdL0e7El0LxSWDJybX5UfEKGaRs4B53TOHW9sZQbHZaPyvseH3gbZi5aaHd7hT+qo0Bx5Ly4DjzWAEAtwWIgdhYIr6yCvLIUIe5LZfEBjpD4aqF5sgE+aYWgP3XcsI02fULoBQQLyS6hQwCsXmOzZoUzBjX/10Bh1t22jZOW/amGGhLg9lClgh1guOObXMH1lHkH/dqLGT+f0Kxis5u9VtNhT237ApZkTxuyEkOhwu7C377VMxopCmsUv5LchJRKf29gaL5KdyLW1k0PhMXpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHPtSk9qyIqPk0wgXvxIYZ8b3kMrCx4U8e7iuEs042A=;
 b=eP4xQrzLi3awWA/8moeOdQyG6UuEdY8suhkHDLNKIniIwUtSu+p4OstlRa5vzQ55U3c2FOomJWLouhD9As3LrgmbGPyWmfYhG8Qxb8exshii0J2gOw8dwkku0DZ3j91vIjx1+UjA5xw0i86zj1L1i6IvweB22rzySiFhvLKg6hOHf5Fn2NzJQlTCdIU4sGVmJheJxWvSvmG1mj82fVlCTbAYXNb8il68czyDiMkgLsEVFA1k8dN/kX8J9UllL/rs4b/gub95Y3eYFfI+7iplgGjUyRZKUujckh2BOllF4lJjV6dP/duBufPa6MV8z2zfjEtshqtgxERdRXlOcnJrdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHPtSk9qyIqPk0wgXvxIYZ8b3kMrCx4U8e7iuEs042A=;
 b=Ad8k1Y4H4fx5ZcpdQ7TBMYyTisORxl7YLTClGuCQcuXfsWOH7cawnx0tej3dXh0eVR0hVGLAxhFvljmwazucVQr1loef2HGWhAFRspG3yGOmtX6/OkQcEoD3yLLmrzeL3LJOYeBzVWooLMyO7YKYA77gMjPguy9ppCKO0/0PG+8=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5087.eurprd05.prod.outlook.com (20.177.52.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Mon, 16 Sep 2019 18:48:24 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 18:48:24 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH 3/4] RDMA/nldev: Reshuffle the code to avoid need to
 rebind QP in error path
Thread-Topic: [PATCH 3/4] RDMA/nldev: Reshuffle the code to avoid need to
 rebind QP in error path
Thread-Index: AQHVbF4Pz7BoqdVnqkqAEaxh4j37uKcupd8A
Date:   Mon, 16 Sep 2019 18:48:24 +0000
Message-ID: <20190916184818.GH2585@mellanox.com>
References: <20190916071154.20383-1-leon@kernel.org>
 <20190916071154.20383-4-leon@kernel.org>
In-Reply-To: <20190916071154.20383-4-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: QB1PR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::30) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.167.223.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 365fca81-069c-4028-05bc-08d73ad67419
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR05MB5087;
x-ms-traffictypediagnostic: VI1PR05MB5087:|VI1PR05MB5087:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB508768331A272B620E892AA8CF8C0@VI1PR05MB5087.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(199004)(189003)(64756008)(66476007)(476003)(2616005)(25786009)(6512007)(107886003)(3846002)(6486002)(6246003)(71190400001)(486006)(99286004)(6916009)(305945005)(14444005)(7736002)(66066001)(256004)(71200400001)(6436002)(186003)(1076003)(76176011)(14454004)(386003)(86362001)(229853002)(66946007)(6506007)(26005)(36756003)(102836004)(6116002)(5660300002)(66446008)(478600001)(4326008)(81156014)(81166006)(54906003)(8936002)(316002)(53936002)(8676002)(2906002)(11346002)(446003)(33656002)(52116002)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5087;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZANmL5dhVqHc1pjdnl8DvlTrINobnUKpK4x5AIwKDPPrAIpQQw2ckK21XqpuqGF11tkUDx3iz2g8nZUua8jj3vwwBKgmlln0LSVpYPdmZcbtZj2GZJumAQxHOufhb16rt9Xj20mMdmYtRTtzeJvSlFX6J/iy7fPoxX0rQn9uALRs2qUUIAkaIu7Q9WwG48wrI3XHYxaTXso909I3UvsRBQ+LpF+ie6++7ig/09zYEDPGHRTRJ2umFzITQfpo0SznMnevOOx3s5K0yficolmRCEco5wt/BNSAFl0JxGUdAjp1ACsloRlScowzBil2QanQhNUdJ2jFn4VYTsElWjV/w8BbHGiHj/V0nrbD3mqHrdXgdFWtM0ODqk8/Xd6qK29n4CN2r46iZfIfSs9owz+0EDMaP/Uy078IgrJqFGEOLzA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5AF6D394365FEF478329E2AEA639BDB1@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365fca81-069c-4028-05bc-08d73ad67419
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 18:48:24.5041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: exjZ2VN2kGpv87Mp2QGhc7Fh2r9Q4r2W7vCFShEpJL5dyY4sRH/IebKtdmjiyyC5DasYOeHqixmr/DkzTnhezw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5087
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 16, 2019 at 10:11:53AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>=20
> Properly unwind QP counter rebinding in case of failure.

What is the actual problem here? Calling 'bind' in an error
unwind seems insane, is that the issue?
=20
> Fixes: b389327df905 ("RDMA/nldev: Allow counter manual mode configration =
through RDMA netlink")
> Reviewed-by: Mark Zhang <markz@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/core/nldev.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nl=
dev.c
> index 5e2b7eb0761b..6eb14481a72e 100644
> +++ b/drivers/infiniband/core/nldev.c
> @@ -1860,24 +1860,22 @@ static int nldev_stat_del_doit(struct sk_buff *sk=
b, struct nlmsghdr *nlh,
>=20
>  	cntn =3D nla_get_u32(tb[RDMA_NLDEV_ATTR_STAT_COUNTER_ID]);
>  	qpn =3D nla_get_u32(tb[RDMA_NLDEV_ATTR_RES_LQPN]);
> -	ret =3D rdma_counter_unbind_qpn(device, port, qpn, cntn);
> -	if (ret)
> -		goto err_unbind;
> -
>  	if (fill_nldev_handle(msg, device) ||
>  	    nla_put_u32(msg, RDMA_NLDEV_ATTR_PORT_INDEX, port) ||
>  	    nla_put_u32(msg, RDMA_NLDEV_ATTR_STAT_COUNTER_ID, cntn) ||
>  	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_LQPN, qpn)) {
>  		ret =3D -EMSGSIZE;
> -		goto err_fill;
> +		goto err_unbind;

These label names don't make much sense anymore

Jason
