Return-Path: <linux-rdma+bounces-597-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8234E82A451
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jan 2024 23:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62511F21B34
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jan 2024 22:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D024F61B;
	Wed, 10 Jan 2024 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MV4hDouZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021007.outbound.protection.outlook.com [40.93.193.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9E8482C1;
	Wed, 10 Jan 2024 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzHUvTcymA6c1b5y6EzT9YKEHbZgCG0t4Cthx2NFDfD9SmaxAmREVqmR9yen0WjoP5nvWhvhgg+Q00bV4xtsq83pVrxh6EGn0xOAyoL3FZp9qNQtNNpBREulcK6q9BYQ2IXKFiy9O/A0sRNLVkS9PPJW1xoV/GGGHXP50qCkcHz1TF5o52/bInojxWCIWnD2fkPZxTCXhc+3a7f7sF7VMfuIua8Xy2xJPr8O1VhWVFOEHKQM4ddFSOobTj3vbvv7LZa2MuN9FFKszTKupZRRSOjIYDMaahfGqggBIZ0IPs8f+H0RcU1ODVxTFcATV6Rj710A+h4K4OCh2Jm8cfLccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBFJP2L9uOcVys+VWQkb5i+Y/65Xj8hJ8o1cSxzPOro=;
 b=D3eysr/cY9q6vuu7e9zl/D4nxqXci+u3rdluNNGKI9U/kkHk+v4nxP/BjvzFfGjt4d7n3TIBJ/CLX9IUb4G00FYWEEPhDZo/ziwhEYnGrUAXbrEWipvuSZEcCLKHCmP+haDI51gE3kofq9fVSjHZ6+kinNaDXVePa/2gytS4hEEV3I2kPX5SC1OKpSnxLl/yYXhElabei0J7qqCLvhwkcfzLKrJP8sXA2fycQvl/duJmQ7lcgTVQAyXH6n7LaBbshygleMcH94k/wdk/+/ol3bLuh17TFG2XMZONDzb8NybaqJ8QclhwTUtRCbpTFDvRflqVN/946YFPRBbUVEELdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBFJP2L9uOcVys+VWQkb5i+Y/65Xj8hJ8o1cSxzPOro=;
 b=MV4hDouZ+DIqeCrTZG5xCWhScT88Dt+O8N5YQDP+NVf/T3PfU10SSZSzrk/id9reuXdUDz0DbTpMsnYdN2F2hDBcDZGkZzEYenZxpUx65PLyxPk2mvPDdXPvXP70mCJk7CsoShoiLdcuX6AN55lJIcCS9Ydr155zrInjQSIDOpE=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by DM4PR21MB3706.namprd21.prod.outlook.com (2603:10b6:8:ae::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.5; Wed, 10 Jan 2024 22:55:45 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::38ce:7072:976c:bb15]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::38ce:7072:976c:bb15%3]) with mapi id 15.20.7202.010; Wed, 10 Jan 2024
 22:55:45 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH next v3 1/1] RDMA/mana_ib: Introduce three helper
 functions to clean mana_ib code
Thread-Topic: [PATCH next v3 1/1] RDMA/mana_ib: Introduce three helper
 functions to clean mana_ib code
Thread-Index: AQHaQ9I4tg92Wr9ulEe3MMAfFibSuLDTp7sg
Date: Wed, 10 Jan 2024 22:55:45 +0000
Message-ID:
 <PH7PR21MB32631D67954449C48ED61901CE692@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1704897301-7253-1-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1704897301-7253-1-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0e6cf3fe-4f32-4d5e-bbdd-f33db5b43905;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-01-10T22:52:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|DM4PR21MB3706:EE_
x-ms-office365-filtering-correlation-id: cfd0a406-2493-4be7-3250-08dc122f479b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VQ2j4esBj3XUNekUFumLu5+494qesvyFMcWNfj3wYSdQ0h8prAT4AQX+VhAB+uE+2LFAIedF3RThjQdF7AAjsps9S7RavX5qigM/9z+HZAgHxqQUPoCX58PLQdk8WXsLY/bqjMTgo9YlBc1PAesbPNhvZTLmSyT1Fi3OnCvkDqes2G8LF9N08QS7HHj+qm1rKm/rFx7AKp4ZxbofWPi1oKdIo17Nxv7vetC2GKVhwcMU4HS3uKYYqM3IqQQH6IN42gjOh9gNgTQb4DbrJCmZHZRzDdFtYagfVRNpkQ2UZrqSr3EQldh6dDKPU/PY+dGusRwRwgueQOXhV6RteOu29SiUnZdPWq1k4hzGuSsh+RA1jLLMV5d8OeAs/Kyd/UR+l6EdHTjiPlCjOQKFM5a1SvsZ69RNETGNxJ6wKJwbTG8wnMTx479A+dQ7zMjaGCIGwaeEbCdxiherDSP/a/Fs1FZpiHYmu2/7BiGGodRq/2XxAstx0TaUl+b7+3l3C8XwcjzhQ/OzT7cRe78kR3D3OMI+eYphOdCM7LLoq2Nr+yn9b1ZfL9R2bmgpZv7ey7YdmVjrKv6Y4cf6LaFPsg9J/Zsl+E/5Fj6UpFdIzrGebEw0hKD/FjwLAYkarW3EDCtG/P62DgXyv32I0dQleSKLF2e4AfRdvPYozJvm6z550Dc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(376002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(7696005)(26005)(55016003)(38070700009)(9686003)(83380400001)(6506007)(38100700002)(82950400001)(478600001)(10290500003)(122000001)(71200400001)(66556008)(66946007)(82960400001)(66476007)(66446008)(76116006)(64756008)(316002)(54906003)(110136005)(33656002)(4326008)(52536014)(8936002)(8676002)(66899024)(5660300002)(30864003)(2906002)(8990500004)(86362001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EKZlXx4JM+/Xv3vRwnzXFyPdF+kV/D8VJ3dz/FJS3NsOPfGghs5cmS2n6Kvu?=
 =?us-ascii?Q?4ijH7Vp6pErAPDzo8raSbEoy8UoJZnRRkLjIzIK1/ghxX2L4qMELrQUJEBP/?=
 =?us-ascii?Q?sfhHLA9bgitGfZbUGsuobtxv1RUE0Dud0a63963B9pnLuUZXfxdGmmamJ76q?=
 =?us-ascii?Q?VbvLIg6fm2rm9iSw63BaWuAQqEfN26GBxvH9a3wfHZpTJlVVRxaawIYOvtTm?=
 =?us-ascii?Q?4ytKvi17v1SWVBMj99iSjkn1Ola1NVbksGqcvkgA7FFfNaoWjh1L5O9wyC5u?=
 =?us-ascii?Q?Mcbr3Dqph9VlFtPOVn26MIpILosDycSaYUzLawUHgEOHaRXKxWIaFycdCA6X?=
 =?us-ascii?Q?+niqE2DQ6OXxLdaMZFFHL0BeNRDPDE+bHY9DYlERtv6snETfK2f1amPSXQLc?=
 =?us-ascii?Q?N7JSyg2QYEz0v92Pm/1Cia7xq8DXFAjwBML6hVcVSlcGgWt/11KPQ/a3wyhn?=
 =?us-ascii?Q?9bK3dIxxYRc3K0DoOzKP06odsm82+WwiPK3ZhQWZm1bVW1KOBkUCujZ7GF13?=
 =?us-ascii?Q?mUjkg7V4oXPzoUUENckO9QR5uwK7fBr3ZVqOWhgFEkbN9GX4oybejMGW/CpI?=
 =?us-ascii?Q?ST9yjDOMPE2bTXnmrkI8DlXqDKt3TTeIAlnY/CLyvvmh85nZ1VWfRl5hdzxh?=
 =?us-ascii?Q?NIVUMYv/lcUTnLTanoY/uOi4GU4ESsYrhaNiQUcTdjzwyQ9HXMLF3IqVlUUJ?=
 =?us-ascii?Q?M6YEYoa7mUKXO+vcpVcGZWb9gRUpgp9aoQgZgnO27Erf3NGOHlXroLtlvI4w?=
 =?us-ascii?Q?jyF37+njq044nZ9VNgZQuaCTV2o9GYJrciw5/6Wn5oEn0bHVrZY4LUVkQ8lt?=
 =?us-ascii?Q?A/9hzvgqy1X99Ai1QKicc4QmXI2HroLCcwkKH/63i4Tsl5pg/UPBWGD4w6NJ?=
 =?us-ascii?Q?opsy5ExkDvYmLQCODT53ZQBC/T2aPfjBIpHvI6YBYygrvMpwOkrw7iVIR09u?=
 =?us-ascii?Q?kpEDumMxfxJKaw+nRaYLUr7HxLNCfmop+ligFUfIOKsghEGrAnqMGLRNa4Fl?=
 =?us-ascii?Q?utRe0e4inybL5VTZ8Umaub6LSwBE4EUrLFZdXHhb2mdH/gneAbKGIZyXI/Ld?=
 =?us-ascii?Q?rcXvINmrqit5je2qxFoomGqL4OV+zuacpIKyNlhLpRTTjq2ZGS2mSpep+C1j?=
 =?us-ascii?Q?xeKZ9XazIM/GjDMFoHGfTE/xwNB8fZ7imW+2akVQ/g+zyjujfqF5WZzYNL3v?=
 =?us-ascii?Q?9BOmUdUJN5On3LE1OuidNh9Bi+1UsXMxH02x09JeLLw9nM2Ox7Cg8gIlDluS?=
 =?us-ascii?Q?X0tPAwRfRVQ4Jt4NefbsMPmZMiUmnCon4WNkGzRbMiXdIBFSBA1pzAEIKybo?=
 =?us-ascii?Q?UkQQH00VIMWWR2j+LevSfYCEiW2J27IuSxXoGbh6Cmqr2DETEkYdtN1OOqlG?=
 =?us-ascii?Q?RBIxBeTnXuxAOt0WFvWTp8bTPVL8dudkq6ze9OXwca+LZn+jh/DHkaqWecrc?=
 =?us-ascii?Q?ZhEvSobt9XMehSjq65rq/W1HO0EHHHWc6HDc5FFBSW8MN+0Kl+lIo93x85tP?=
 =?us-ascii?Q?10C7ZO8gufZqSVfMI0kzjbnEH4agxVff67Yidg34qNaas/BxP9FzKbcQcQKN?=
 =?us-ascii?Q?BVGoR5Wyo7XnjEU/0lYo/ZIApq+RgWuvXWKlNTMf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd0a406-2493-4be7-3250-08dc122f479b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 22:55:45.3551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FeDZgId9ETW45J1bxfoAGRw/qj9u+O+Me/xA3OZjg+VNhe1yG/CtFcPqkedix6JlRf2VFU/UAvpa43vwr1EXyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3706

> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> This patch aims to address two issues in mana_ib:
> 1) Unsafe and inconsistent access to gdma_dev and  gdma_context
> 2) Code repetitions
>=20
> As a rule of thumb, functions should not access gdma_dev directly
>=20
> Introduced functions:
> 1) mdev_to_gc
> 2) mana_ib_get_netdev
> 3) mana_ib_install_cq_cb

Overall, the patch looks good but it's hard to review.=20

As this patch doesn't change any existing behavior. I suggest you break the=
 patch into three patches, one introduces necessary changes for each helper=
 function.

I'm not sure if you need to add a "next" in the patch header.

Long

>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
> v1->v2: Sorry that was sent again, I forgot to add RDMA/mana_ib to the
> v1->subject
> v2->v3: missing changes in qp.c
> ---
>  drivers/infiniband/hw/mana/cq.c      | 23 +++++++-
>  drivers/infiniband/hw/mana/main.c    | 40 +++++--------
>  drivers/infiniband/hw/mana/mana_ib.h | 17 ++++++
>  drivers/infiniband/hw/mana/mr.c      | 13 +---
>  drivers/infiniband/hw/mana/qp.c      | 88 +++++++++-------------------
>  5 files changed, 82 insertions(+), 99 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/cq.c
> b/drivers/infiniband/hw/mana/cq.c index 83ebd0705..255e74ab7 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -16,7 +16,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>  	int err;
>=20
>  	mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> -	gc =3D mdev->gdma_dev->gdma_context;
> +	gc =3D mdev_to_gc(mdev);
>=20
>  	if (udata->inlen < sizeof(ucmd))
>  		return -EINVAL;
> @@ -81,7 +81,7 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct
> ib_udata *udata)
>  	int err;
>=20
>  	mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> -	gc =3D mdev->gdma_dev->gdma_context;
> +	gc =3D mdev_to_gc(mdev);
>=20
>  	err =3D mana_ib_gd_destroy_dma_region(mdev, cq->gdma_region);
>  	if (err) {
> @@ -107,3 +107,22 @@ void mana_ib_cq_handler(void *ctx, struct
> gdma_queue *gdma_cq)
>  	if (cq->ibcq.comp_handler)
>  		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);  }
> +
> +int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq
> +*cq) {
> +	struct gdma_context *gc =3D mdev_to_gc(mdev);
> +	struct gdma_queue *gdma_cq;
> +
> +	/* Create CQ table entry */
> +	WARN_ON(gc->cq_table[cq->id]);
> +	gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
> +	if (!gdma_cq)
> +		return -ENOMEM;
> +
> +	gdma_cq->cq.context =3D cq;
> +	gdma_cq->type =3D GDMA_CQ;
> +	gdma_cq->cq.callback =3D mana_ib_cq_handler;
> +	gdma_cq->id =3D cq->id;
> +	gc->cq_table[cq->id] =3D gdma_cq;
> +	return 0;
> +}
> diff --git a/drivers/infiniband/hw/mana/main.c
> b/drivers/infiniband/hw/mana/main.c
> index faca09245..29dd2438d 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -8,13 +8,10 @@
>  void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *pd,
>  			 u32 port)
>  {
> -	struct gdma_dev *gd =3D &dev->gdma_dev->gdma_context->mana;
>  	struct mana_port_context *mpc;
>  	struct net_device *ndev;
> -	struct mana_context *mc;
>=20
> -	mc =3D gd->driver_data;
> -	ndev =3D mc->ports[port];
> +	ndev =3D mana_ib_get_netdev(&dev->ib_dev, port);
>  	mpc =3D netdev_priv(ndev);
>=20
>  	mutex_lock(&pd->vport_mutex);
> @@ -31,14 +28,11 @@ void mana_ib_uncfg_vport(struct mana_ib_dev *dev,
> struct mana_ib_pd *pd,  int mana_ib_cfg_vport(struct mana_ib_dev *dev, u3=
2
> port, struct mana_ib_pd *pd,
>  		      u32 doorbell_id)
>  {
> -	struct gdma_dev *mdev =3D &dev->gdma_dev->gdma_context->mana;
>  	struct mana_port_context *mpc;
> -	struct mana_context *mc;
>  	struct net_device *ndev;
>  	int err;
>=20
> -	mc =3D mdev->driver_data;
> -	ndev =3D mc->ports[port];
> +	ndev =3D mana_ib_get_netdev(&dev->ib_dev, port);
>  	mpc =3D netdev_priv(ndev);
>=20
>  	mutex_lock(&pd->vport_mutex);
> @@ -79,17 +73,17 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct
> ib_udata *udata)
>  	struct gdma_create_pd_req req =3D {};
>  	enum gdma_pd_flags flags =3D 0;
>  	struct mana_ib_dev *dev;
> -	struct gdma_dev *mdev;
> +	struct gdma_context *gc;
>  	int err;
>=20
>  	dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> -	mdev =3D dev->gdma_dev;
> +	gc =3D mdev_to_gc(dev);
>=20
>  	mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_PD, sizeof(req),
>  			     sizeof(resp));
>=20
>  	req.flags =3D flags;
> -	err =3D mana_gd_send_request(mdev->gdma_context, sizeof(req),
> &req,
> +	err =3D mana_gd_send_request(gc, sizeof(req), &req,
>  				   sizeof(resp), &resp);
>=20
>  	if (err || resp.hdr.status) {
> @@ -119,17 +113,17 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct
> ib_udata *udata)
>  	struct gdma_destory_pd_resp resp =3D {};
>  	struct gdma_destroy_pd_req req =3D {};
>  	struct mana_ib_dev *dev;
> -	struct gdma_dev *mdev;
> +	struct gdma_context *gc;
>  	int err;
>=20
>  	dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> -	mdev =3D dev->gdma_dev;
> +	gc =3D mdev_to_gc(dev);
>=20
>  	mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_PD, sizeof(req),
>  			     sizeof(resp));
>=20
>  	req.pd_handle =3D pd->pd_handle;
> -	err =3D mana_gd_send_request(mdev->gdma_context, sizeof(req),
> &req,
> +	err =3D mana_gd_send_request(gc, sizeof(req), &req,
>  				   sizeof(resp), &resp);
>=20
>  	if (err || resp.hdr.status) {
> @@ -206,13 +200,11 @@ int mana_ib_alloc_ucontext(struct ib_ucontext
> *ibcontext,
>  	struct ib_device *ibdev =3D ibcontext->device;
>  	struct mana_ib_dev *mdev;
>  	struct gdma_context *gc;
> -	struct gdma_dev *dev;
>  	int doorbell_page;
>  	int ret;
>=20
>  	mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> -	dev =3D mdev->gdma_dev;
> -	gc =3D dev->gdma_context;
> +	gc =3D mdev_to_gc(mdev);
>=20
>  	/* Allocate a doorbell page index */
>  	ret =3D mana_gd_allocate_doorbell_page(gc, &doorbell_page); @@ -
> 238,7 +230,7 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext
> *ibcontext)
>  	int ret;
>=20
>  	mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> -	gc =3D mdev->gdma_dev->gdma_context;
> +	gc =3D mdev_to_gc(mdev);
>=20
>  	ret =3D mana_gd_destroy_doorbell_page(gc, mana_ucontext-
> >doorbell);
>  	if (ret)
> @@ -322,15 +314,13 @@ int mana_ib_gd_create_dma_region(struct
> mana_ib_dev *dev, struct ib_umem *umem,
>  	size_t max_pgs_create_cmd;
>  	struct gdma_context *gc;
>  	size_t num_pages_total;
> -	struct gdma_dev *mdev;
>  	unsigned long page_sz;
>  	unsigned int tail =3D 0;
>  	u64 *page_addr_list;
>  	void *request_buf;
>  	int err;
>=20
> -	mdev =3D dev->gdma_dev;
> -	gc =3D mdev->gdma_context;
> +	gc =3D mdev_to_gc(dev);
>  	hwc =3D gc->hwc.driver_data;
>=20
>  	/* Hardware requires dma region to align to chosen page size */ @@ -
> 426,10 +416,8 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev
> *dev, struct ib_umem *umem,
>=20
>  int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev, u64
> gdma_region)  {
> -	struct gdma_dev *mdev =3D dev->gdma_dev;
> -	struct gdma_context *gc;
> +	struct gdma_context *gc =3D mdev_to_gc(dev);
>=20
> -	gc =3D mdev->gdma_context;
>  	ibdev_dbg(&dev->ib_dev, "destroy dma region 0x%llx\n",
> gdma_region);
>=20
>  	return mana_gd_destroy_dma_region(gc, gdma_region); @@ -447,7
> +435,7 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext, struct
> vm_area_struct *vma)
>  	int ret;
>=20
>  	mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> -	gc =3D mdev->gdma_dev->gdma_context;
> +	gc =3D mdev_to_gc(mdev);
>=20
>  	if (vma->vm_pgoff !=3D 0) {
>  		ibdev_dbg(ibdev, "Unexpected vm_pgoff %lu\n", vma-
> >vm_pgoff); @@ -531,7 +519,7 @@ int
> mana_ib_gd_query_adapter_caps(struct mana_ib_dev *dev)
>  	req.hdr.resp.msg_version =3D GDMA_MESSAGE_V3;
>  	req.hdr.dev_id =3D dev->gdma_dev->dev_id;
>=20
> -	err =3D mana_gd_send_request(dev->gdma_dev->gdma_context,
> sizeof(req),
> +	err =3D mana_gd_send_request(mdev_to_gc(dev), sizeof(req),
>  				   &req, sizeof(resp), &resp);
>=20
>  	if (err) {
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index 6bdc0f549..6b15b2ab5 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -142,6 +142,22 @@ struct mana_ib_query_adapter_caps_resp {
>  	u32 max_inline_data_size;
>  }; /* HW Data */
>=20
> +static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev)
> +{
> +	return mdev->gdma_dev->gdma_context;
> +}
> +
> +static inline struct net_device *mana_ib_get_netdev(struct ib_device
> +*ibdev, u32 port) {
> +	struct mana_ib_dev *mdev =3D container_of(ibdev, struct mana_ib_dev,
> ib_dev);
> +	struct gdma_context *gc =3D mdev_to_gc(mdev);
> +	struct mana_context *mc =3D gc->mana.driver_data;
> +
> +	if (port < 1 || port > mc->num_ports)
> +		return NULL;
> +	return mc->ports[port - 1];
> +}
> +
>  int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct
> ib_umem *umem,
>  				 mana_handle_t *gdma_region);
>=20
> @@ -188,6 +204,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const
> struct ib_cq_init_attr *attr,
>  		      struct ib_udata *udata);
>=20
>  int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
> +int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq
> +*cq);
>=20
>  int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);  int
> mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata); diff --gi=
t
> a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
> index 351207c60..ee4d4f834 100644
> --- a/drivers/infiniband/hw/mana/mr.c
> +++ b/drivers/infiniband/hw/mana/mr.c
> @@ -30,12 +30,9 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev
> *dev, struct mana_ib_mr *mr,  {
>  	struct gdma_create_mr_response resp =3D {};
>  	struct gdma_create_mr_request req =3D {};
> -	struct gdma_dev *mdev =3D dev->gdma_dev;
> -	struct gdma_context *gc;
> +	struct gdma_context *gc =3D mdev_to_gc(dev);
>  	int err;
>=20
> -	gc =3D mdev->gdma_context;
> -
>  	mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_MR, sizeof(req),
>  			     sizeof(resp));
>  	req.pd_handle =3D mr_params->pd_handle;
> @@ -77,12 +74,9 @@ static int mana_ib_gd_destroy_mr(struct mana_ib_dev
> *dev, u64 mr_handle)  {
>  	struct gdma_destroy_mr_response resp =3D {};
>  	struct gdma_destroy_mr_request req =3D {};
> -	struct gdma_dev *mdev =3D dev->gdma_dev;
> -	struct gdma_context *gc;
> +	struct gdma_context *gc =3D mdev_to_gc(dev);
>  	int err;
>=20
> -	gc =3D mdev->gdma_context;
> -
>  	mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_MR, sizeof(req),
>  			     sizeof(resp));
>=20
> @@ -164,8 +158,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd
> *ibpd, u64 start, u64 length,
>  	return &mr->ibmr;
>=20
>  err_dma_region:
> -	mana_gd_destroy_dma_region(dev->gdma_dev->gdma_context,
> -				   dma_region_handle);
> +	mana_gd_destroy_dma_region(mdev_to_gc(dev),
> dma_region_handle);
>=20
>  err_umem:
>  	ib_umem_release(mr->umem);
> diff --git a/drivers/infiniband/hw/mana/qp.c
> b/drivers/infiniband/hw/mana/qp.c index 21ac9fcad..e889c798f 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -17,12 +17,10 @@ static int mana_ib_cfg_vport_steering(struct
> mana_ib_dev *dev,
>  	struct mana_cfg_rx_steer_resp resp =3D {};
>  	mana_handle_t *req_indir_tab;
>  	struct gdma_context *gc;
> -	struct gdma_dev *mdev;
>  	u32 req_buf_size;
>  	int i, err;
>=20
> -	gc =3D dev->gdma_dev->gdma_context;
> -	mdev =3D &gc->mana;
> +	gc =3D mdev_to_gc(dev);
>=20
>  	req_buf_size =3D
>  		sizeof(*req) + sizeof(mana_handle_t) *
> MANA_INDIRECT_TABLE_SIZE; @@ -39,7 +37,7 @@ static int
> mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
>  	req->rx_enable =3D 1;
>  	req->update_default_rxobj =3D 1;
>  	req->default_rxobj =3D default_rxobj;
> -	req->hdr.dev_id =3D mdev->dev_id;
> +	req->hdr.dev_id =3D gc->mana.dev_id;
>=20
>  	/* If there are more than 1 entries in indirection table, enable RSS */
>  	if (log_ind_tbl_size)
> @@ -99,20 +97,17 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp,
> struct ib_pd *pd,
>  	struct mana_ib_qp *qp =3D container_of(ibqp, struct mana_ib_qp,
> ibqp);
>  	struct mana_ib_dev *mdev =3D
>  		container_of(pd->device, struct mana_ib_dev, ib_dev);
> +	struct gdma_context *gc =3D mdev_to_gc(mdev);
>  	struct ib_rwq_ind_table *ind_tbl =3D attr->rwq_ind_tbl;
>  	struct mana_ib_create_qp_rss_resp resp =3D {};
>  	struct mana_ib_create_qp_rss ucmd =3D {};
>  	struct gdma_queue **gdma_cq_allocated;
>  	mana_handle_t *mana_ind_table;
>  	struct mana_port_context *mpc;
> -	struct gdma_queue *gdma_cq;
>  	unsigned int ind_tbl_size;
> -	struct mana_context *mc;
>  	struct net_device *ndev;
> -	struct gdma_context *gc;
>  	struct mana_ib_cq *cq;
>  	struct mana_ib_wq *wq;
> -	struct gdma_dev *gd;
>  	struct mana_eq *eq;
>  	struct ib_cq *ibcq;
>  	struct ib_wq *ibwq;
> @@ -120,10 +115,6 @@ static int mana_ib_create_qp_rss(struct ib_qp
> *ibqp, struct ib_pd *pd,
>  	u32 port;
>  	int ret;
>=20
> -	gc =3D mdev->gdma_dev->gdma_context;
> -	gd =3D &gc->mana;
> -	mc =3D gd->driver_data;
> -
>  	if (!udata || udata->inlen < sizeof(ucmd))
>  		return -EINVAL;
>=20
> @@ -166,12 +157,12 @@ static int mana_ib_create_qp_rss(struct ib_qp
> *ibqp, struct ib_pd *pd,
>=20
>  	/* IB ports start with 1, MANA start with 0 */
>  	port =3D ucmd.port;
> -	if (port < 1 || port > mc->num_ports) {
> +	ndev =3D mana_ib_get_netdev(pd->device, port);
> +	if (!ndev) {
>  		ibdev_dbg(&mdev->ib_dev, "Invalid port %u in creating
> qp\n",
>  			  port);
>  		return -EINVAL;
>  	}
> -	ndev =3D mc->ports[port - 1];
>  	mpc =3D netdev_priv(ndev);
>=20
>  	ibdev_dbg(&mdev->ib_dev, "rx_hash_function %d port %d\n", @@ -
> 209,7 +200,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, stru=
ct
> ib_pd *pd,
>  		cq_spec.gdma_region =3D cq->gdma_region;
>  		cq_spec.queue_size =3D cq->cqe * COMP_ENTRY_SIZE;
>  		cq_spec.modr_ctx_id =3D 0;
> -		eq =3D &mc->eqs[cq->comp_vector % gc->max_num_queues];
> +		eq =3D &mpc->ac->eqs[cq->comp_vector % gc-
> >max_num_queues];
>  		cq_spec.attached_eq =3D eq->eq->id;
>=20
>  		ret =3D mana_create_wq_obj(mpc, mpc->port_handle,
> GDMA_RQ, @@ -237,19 +228,11 @@ static int
> mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
>  		mana_ind_table[i] =3D wq->rx_object;
>=20
>  		/* Create CQ table entry */
> -		WARN_ON(gc->cq_table[cq->id]);
> -		gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
> -		if (!gdma_cq) {
> -			ret =3D -ENOMEM;
> +		ret =3D mana_ib_install_cq_cb(mdev, cq);
> +		if (!ret)
>  			goto fail;
> -		}
> -		gdma_cq_allocated[i] =3D gdma_cq;
>=20
> -		gdma_cq->cq.context =3D cq;
> -		gdma_cq->type =3D GDMA_CQ;
> -		gdma_cq->cq.callback =3D mana_ib_cq_handler;
> -		gdma_cq->id =3D cq->id;
> -		gc->cq_table[cq->id] =3D gdma_cq;
> +		gdma_cq_allocated[i] =3D gc->cq_table[cq->id];
>  	}
>  	resp.num_entries =3D i;
>=20
> @@ -306,14 +289,13 @@ static int mana_ib_create_qp_raw(struct ib_qp
> *ibqp, struct ib_pd *ibpd,
>  	struct mana_ib_ucontext *mana_ucontext =3D
>  		rdma_udata_to_drv_context(udata, struct
> mana_ib_ucontext,
>  					  ibucontext);
> -	struct gdma_dev *gd =3D &mdev->gdma_dev->gdma_context->mana;
> +	struct gdma_context *gc =3D mdev_to_gc(mdev);
>  	struct mana_ib_create_qp_resp resp =3D {};
>  	struct mana_ib_create_qp ucmd =3D {};
>  	struct gdma_queue *gdma_cq =3D NULL;
>  	struct mana_obj_spec wq_spec =3D {};
>  	struct mana_obj_spec cq_spec =3D {};
>  	struct mana_port_context *mpc;
> -	struct mana_context *mc;
>  	struct net_device *ndev;
>  	struct ib_umem *umem;
>  	struct mana_eq *eq;
> @@ -321,8 +303,6 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp,
> struct ib_pd *ibpd,
>  	u32 port;
>  	int err;
>=20
> -	mc =3D gd->driver_data;
> -
>  	if (!mana_ucontext || udata->inlen < sizeof(ucmd))
>  		return -EINVAL;
>=20
> @@ -333,11 +313,6 @@ static int mana_ib_create_qp_raw(struct ib_qp
> *ibqp, struct ib_pd *ibpd,
>  		return err;
>  	}
>=20
> -	/* IB ports start with 1, MANA Ethernet ports start with 0 */
> -	port =3D ucmd.port;
> -	if (port < 1 || port > mc->num_ports)
> -		return -EINVAL;
> -
>  	if (attr->cap.max_send_wr > mdev->adapter_caps.max_qp_wr) {
>  		ibdev_dbg(&mdev->ib_dev,
>  			  "Requested max_send_wr %d exceeding limit\n",
> @@ -352,11 +327,17 @@ static int mana_ib_create_qp_raw(struct ib_qp
> *ibqp, struct ib_pd *ibpd,
>  		return -EINVAL;
>  	}
>=20
> -	ndev =3D mc->ports[port - 1];
> +	port =3D ucmd.port;
> +	ndev =3D mana_ib_get_netdev(ibpd->device, port);
> +	if (!ndev) {
> +		ibdev_dbg(&mdev->ib_dev, "Invalid port %u in creating
> qp\n",
> +			  port);
> +		return -EINVAL;
> +	}
>  	mpc =3D netdev_priv(ndev);
>  	ibdev_dbg(&mdev->ib_dev, "port %u ndev %p mpc %p\n", port,
> ndev, mpc);
>=20
> -	err =3D mana_ib_cfg_vport(mdev, port - 1, pd, mana_ucontext-
> >doorbell);
> +	err =3D mana_ib_cfg_vport(mdev, port, pd, mana_ucontext->doorbell);
>  	if (err)
>  		return -ENODEV;
>=20
> @@ -396,8 +377,8 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp,
> struct ib_pd *ibpd,
>  	cq_spec.gdma_region =3D send_cq->gdma_region;
>  	cq_spec.queue_size =3D send_cq->cqe * COMP_ENTRY_SIZE;
>  	cq_spec.modr_ctx_id =3D 0;
> -	eq_vec =3D send_cq->comp_vector % gd->gdma_context-
> >max_num_queues;
> -	eq =3D &mc->eqs[eq_vec];
> +	eq_vec =3D send_cq->comp_vector % gc->max_num_queues;
> +	eq =3D &mpc->ac->eqs[eq_vec];
>  	cq_spec.attached_eq =3D eq->eq->id;
>=20
>  	err =3D mana_create_wq_obj(mpc, mpc->port_handle, GDMA_SQ,
> &wq_spec, @@ -417,18 +398,9 @@ static int mana_ib_create_qp_raw(struct
> ib_qp *ibqp, struct ib_pd *ibpd,
>  	send_cq->id =3D cq_spec.queue_index;
>=20
>  	/* Create CQ table entry */
> -	WARN_ON(gd->gdma_context->cq_table[send_cq->id]);
> -	gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
> -	if (!gdma_cq) {
> -		err =3D -ENOMEM;
> +	err =3D mana_ib_install_cq_cb(mdev, send_cq);
> +	if (err)
>  		goto err_destroy_wq_obj;
> -	}
> -
> -	gdma_cq->cq.context =3D send_cq;
> -	gdma_cq->type =3D GDMA_CQ;
> -	gdma_cq->cq.callback =3D mana_ib_cq_handler;
> -	gdma_cq->id =3D send_cq->id;
> -	gd->gdma_context->cq_table[send_cq->id] =3D gdma_cq;
>=20
>  	ibdev_dbg(&mdev->ib_dev,
>  		  "ret %d qp->tx_object 0x%llx sq id %llu cq id %llu\n", err, @@
> -450,7 +422,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp,
> struct ib_pd *ibpd,
>=20
>  err_release_gdma_cq:
>  	kfree(gdma_cq);
> -	gd->gdma_context->cq_table[send_cq->id] =3D NULL;
> +	gc->cq_table[send_cq->id] =3D NULL;
>=20
>  err_destroy_wq_obj:
>  	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object); @@ -462,7
> +434,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct
> ib_pd *ibpd,
>  	ib_umem_release(umem);
>=20
>  err_free_vport:
> -	mana_ib_uncfg_vport(mdev, pd, port - 1);
> +	mana_ib_uncfg_vport(mdev, pd, port);
>=20
>  	return err;
>  }
> @@ -500,16 +472,13 @@ static int mana_ib_destroy_qp_rss(struct
> mana_ib_qp *qp,  {
>  	struct mana_ib_dev *mdev =3D
>  		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
> -	struct gdma_dev *gd =3D &mdev->gdma_dev->gdma_context->mana;
>  	struct mana_port_context *mpc;
> -	struct mana_context *mc;
>  	struct net_device *ndev;
>  	struct mana_ib_wq *wq;
>  	struct ib_wq *ibwq;
>  	int i;
>=20
> -	mc =3D gd->driver_data;
> -	ndev =3D mc->ports[qp->port - 1];
> +	ndev =3D mana_ib_get_netdev(qp->ibqp.device, qp->port);
>  	mpc =3D netdev_priv(ndev);
>=20
>  	for (i =3D 0; i < (1 << ind_tbl->log_ind_tbl_size); i++) { @@ -527,15
> +496,12 @@ static int mana_ib_destroy_qp_raw(struct mana_ib_qp *qp,
> struct ib_udata *udata)  {
>  	struct mana_ib_dev *mdev =3D
>  		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
> -	struct gdma_dev *gd =3D &mdev->gdma_dev->gdma_context->mana;
>  	struct ib_pd *ibpd =3D qp->ibqp.pd;
>  	struct mana_port_context *mpc;
> -	struct mana_context *mc;
>  	struct net_device *ndev;
>  	struct mana_ib_pd *pd;
>=20
> -	mc =3D gd->driver_data;
> -	ndev =3D mc->ports[qp->port - 1];
> +	ndev =3D mana_ib_get_netdev(qp->ibqp.device, qp->port);
>  	mpc =3D netdev_priv(ndev);
>  	pd =3D container_of(ibpd, struct mana_ib_pd, ibpd);
>=20
> @@ -546,7 +512,7 @@ static int mana_ib_destroy_qp_raw(struct
> mana_ib_qp *qp, struct ib_udata *udata)
>  		ib_umem_release(qp->sq_umem);
>  	}
>=20
> -	mana_ib_uncfg_vport(mdev, pd, qp->port - 1);
> +	mana_ib_uncfg_vport(mdev, pd, qp->port);
>=20
>  	return 0;
>  }
>=20
> base-commit: d24b923f1d696ddacb09f0f2d1b1f4f045cfe65e
> --
> 2.43.0


