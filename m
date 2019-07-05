Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C272D60AD1
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2019 19:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfGERQE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Jul 2019 13:16:04 -0400
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:39911
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727217AbfGERQD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 5 Jul 2019 13:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srSOv+oRbNP8ZT/w+zA31mVwiRwFAbwm4L/bw8ixldY=;
 b=SBI7226XZF8Oqmr2yJjTfx7LC7yd+4eMfVvPXbn9QixtnEICfqsAUxBN0oOMOllfcx8uRC78dXv43PDcpSJx/WRytU93EhbTg8m7FuVSp8CGcHm0qIY7i54ucVkKg/eF1vAChXRgMU0sf/NXJSQ7lHwYBH9lqvSXHMaN768eQOc=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3165.eurprd05.prod.outlook.com (10.170.237.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Fri, 5 Jul 2019 17:15:59 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2052.019; Fri, 5 Jul 2019
 17:15:59 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Danit Goldberg <danitg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/mlx5: Report correctly tag matching
 rendezvous capability
Thread-Topic: [PATCH rdma-next] IB/mlx5: Report correctly tag matching
 rendezvous capability
Thread-Index: AQHVM03PMkTOZfAu1E673erRlNxWJ6a8RACA
Date:   Fri, 5 Jul 2019 17:15:59 +0000
Message-ID: <20190705171555.GH31525@mellanox.com>
References: <20190705162157.17336-1-leon@kernel.org>
In-Reply-To: <20190705162157.17336-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::17) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98a0593c-6ebd-4f10-95c1-08d7016c72d4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3165;
x-ms-traffictypediagnostic: VI1PR05MB3165:
x-microsoft-antispam-prvs: <VI1PR05MB3165B8EC6B3542BA24421E08CFF50@VI1PR05MB3165.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(199004)(189003)(6436002)(2906002)(6512007)(7736002)(305945005)(36756003)(229853002)(6486002)(86362001)(3846002)(81156014)(81166006)(6116002)(8676002)(8936002)(99286004)(33656002)(2616005)(486006)(76176011)(52116002)(476003)(11346002)(54906003)(316002)(446003)(107886003)(6246003)(6916009)(68736007)(53936002)(26005)(102836004)(386003)(256004)(186003)(71200400001)(71190400001)(5660300002)(1076003)(66066001)(64756008)(66946007)(73956011)(66476007)(66556008)(66446008)(6506007)(14454004)(25786009)(4326008)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3165;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iLx3aiGTq7FkYbJk3Ejvz5i9OOQ8zNQMzs+PyeX2hk8xo7QSg+r8s+qtHwQDviBfmX8Fss1LkfmqDrFHeTT04lKx9JiGYY6JfRfIyCAn8TpASu942UtURHH0FfDSXLyD8yjV1pRhJH2ykSoUhhaNoB5vCtz77Aj4S84mVZ/vm9NGgxu5UVYhVv3kOcZN3tAfPXBbJ2h0UD5gsfLuZbybLJPzdE+0c65QR5utquKZiV8kK29OUgQOMBqSOkxq5BMEBLbWPkkI6p8My/E9OHgiWCjySB4/W7t40/q+XGV0SdxYqTvg/4ATDLfPXf+Qhz9ZswjsiMEcbHXiZkO34EnmSPgmoh3riuBWMg2f0JXzYyAn+AO9gkySdDZQwQtCdz34JAPInc9njRAOas0rLutpYxpGtKu7SGerSfoVhM4j85k=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB10956432EB0F42ABA6E5E9804117BB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a0593c-6ebd-4f10-95c1-08d7016c72d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 17:15:59.2583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3165
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 05, 2019 at 07:21:57PM +0300, Leon Romanovsky wrote:
> From: Danit Goldberg <danitg@mellanox.com>
>=20
> Tag matching with rendezvous offload for RC transport is controlled
> by FW and before this change, it was advertised to user as supported
> without any relation to FW.
>=20
> Separate tag matching for rendezvous and eager protocols, so users
> will see real capabilities.
>=20
> Cc: <stable@vger.kernel.org> # 4.13
> Fixes: eb761894351d ("IB/mlx5: Fill XRQ capabilities")
> Signed-off-by: Danit Goldberg <danitg@mellanox.com>
> Reviewed-by: Yishai Hadas <yishaih@mellanox.com>
> Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/hw/mlx5/main.c | 8 ++++++--
>  include/rdma/ib_verbs.h           | 4 ++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/ml=
x5/main.c
> index 07a05b0b9e42..c2a5780cb394 100644
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -1046,15 +1046,19 @@ static int mlx5_ib_query_device(struct ib_device =
*ibdev,
>  	}
> =20
>  	if (MLX5_CAP_GEN(mdev, tag_matching)) {
> -		props->tm_caps.max_rndv_hdr_size =3D MLX5_TM_MAX_RNDV_MSG_SIZE;
>  		props->tm_caps.max_num_tags =3D
>  			(1 << MLX5_CAP_GEN(mdev, log_tag_matching_list_sz)) - 1;
> -		props->tm_caps.flags =3D IB_TM_CAP_RC;
>  		props->tm_caps.max_ops =3D
>  			1 << MLX5_CAP_GEN(mdev, log_max_qp_sz);
>  		props->tm_caps.max_sge =3D MLX5_TM_MAX_SGE;
>  	}
> =20
> +	if (MLX5_CAP_GEN(mdev, tag_matching) &&
> +	    MLX5_CAP_GEN(mdev, rndv_offload_rc)) {
> +		props->tm_caps.flags =3D IB_TM_CAP_RNDV_RC;
> +		props->tm_caps.max_rndv_hdr_size =3D MLX5_TM_MAX_RNDV_MSG_SIZE;
> +	}
> +
>  	if (MLX5_CAP_GEN(dev->mdev, cq_moderation)) {
>  		props->cq_caps.max_cq_moderation_count =3D
>  						MLX5_MAX_CQ_COUNT;
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 30eb68f36109..c5f8a9f17063 100644
> +++ b/include/rdma/ib_verbs.h
> @@ -308,8 +308,8 @@ struct ib_rss_caps {
>  };
> =20
>  enum ib_tm_cap_flags {
> -	/*  Support tag matching on RC transport */
> -	IB_TM_CAP_RC		    =3D 1 << 0,
> +	/*  Support tag matching with rendezvous offload for RC transport */
> +	IB_TM_CAP_RNDV_RC =3D 1 << 0,
>  };

This is in the wrong header, right?

Jason
