Return-Path: <linux-rdma+bounces-5030-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A9C97D862
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 18:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2A51F21B24
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 16:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38CB27713;
	Fri, 20 Sep 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tdk/OA1H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BD1481D5;
	Fri, 20 Sep 2024 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726849948; cv=fail; b=F4ZqDOidY9QP4eOlv6cjWkP8lf+Jb9ardaG1K/o+0WdTsESi6TmGB6VGGH6LFuoc/ZKmGyjJhco5jrTQrxJn5+9SPtwTFK1SFb0tG0lUcwYVTDwUCA63mn7AXCRhvBn3ntEaxkyDouizduNCvzFgIDitKm0Uwg7mkpqzrdZSkqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726849948; c=relaxed/simple;
	bh=FEykNo/R6SPMOX8xSAigtrq3+L7kSvSMoVjLyX3hbcE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gEReFv8RurhEMDv5ubG2T6N1Jm+FXSGcVDVqkbaLy7frVbT9rbuC/+MTWmQYV3RtkTyNl/AhEAV74UI7/3weXbZrpk3N0R5YOJzTMY8/CcHAuUYg+5evvLswT76f66Dwhh0GWY7URmDEgNj8NLoFoSVpL0AJPckFB6ymbxjcN2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tdk/OA1H; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZOndZ0JGi+hW/s1ESo+o7e/+prThpg2b1ZfBYxKaRSxuYV0E0iU2QXQVdsbpz2oLYNy0HHMVIVjQKN4pae7+HjtHRSNiSDI13DrZnQD2GwVgIiI2mFczuO3ChOhzxEfNsw9niP7dLkb6uCqg9WvRDu/ioA/IIv1gnrKgflsV1p7ewhtaCcYyZleo5Mudhu5pqnVBdTt35yXp9tEvNLDHBrosdPrdoalJ89DZkqO59KlsrZPnfUeYsQGVp/f3vrHkeSypWye3Tn2l3Wxx5zZ3nc2rW0nvGn6PgJitvy7MYmDJBnQWfCtjsMZhO773zdGbL5aRFrc21t9HvlRawMZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFncIEOMsT55t7PcwE7rbY60r87CxULliDDkgV497vk=;
 b=pjTrFQP8TicQLv5ro7wvT/VtkYwwtu88In9XtujuranCshmyGM7xB+f6arzCKWki7HGkLiooyXC8MM2exDlfIscefB60e0wn7kng2LJ5eZLoke7iLB+SoJfoE9qIbQV5gn5n3v3s/s4AfOcgBjO4Mh6x7aBKDEni/CAuvS3JEKiFXTFe5tSl5w0rk96l7RH9+NHOvNkTQ29fSYOyZJf9k5ZPxxipmHwP7hFHa8yBgE8RkjXYDuUVeWQs+lFgIM6nleq26rf6k3xGMtiViXNM7Vg6rk1eL9+GfyAQu1L4ArZsF+kQiCfyY8a6L74YCbJwQDmJC23KSUO20+tcaIR02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFncIEOMsT55t7PcwE7rbY60r87CxULliDDkgV497vk=;
 b=tdk/OA1HKjPRJbq24e9zCMuZSNjAMCYx53gHmwaFpJJyhw0tyEGtL81iYYcM6SiYeiNBx1Rpz6RkqoD5pX/5TDjMBWkm2EriWJEsDVfYJLe5GQyn8xcemM3zqqg7JrjqJ28Hq1vmIhKpWt+7uPqT/mm6XtoHL1b4bQyXpnDNQvIohBaLDpJ3IxrqLcP9PQ8FC+uYxpihi3uLwqkiRu8uwfymZTU1q5/Pog0L5VYNm/kj0viigK1TkIpyo01dHrdBj36K+MM0SETzBSu/z8wkAdjVatDCRDF6nINd4o3fH6ziywV/5uvzR+5+Ap3qfXv+gz9c+4ogu/FQ2feTVT9kOQ==
Received: from IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7)
 by CYYPR12MB9013.namprd12.prod.outlook.com (2603:10b6:930:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Fri, 20 Sep
 2024 16:32:23 +0000
Received: from IA0PR12MB8713.namprd12.prod.outlook.com
 ([fe80::9fc9:acc2:bdac:a04a]) by IA0PR12MB8713.namprd12.prod.outlook.com
 ([fe80::9fc9:acc2:bdac:a04a%5]) with mapi id 15.20.7982.022; Fri, 20 Sep 2024
 16:32:22 +0000
From: Parav Pandit <parav@nvidia.com>
To: Sebastian Ott <sebott@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Subject: RE: [PATCH] net/mlx5: unique names for per device caches
Thread-Topic: [PATCH] net/mlx5: unique names for per device caches
Thread-Index: AQHbC2od5XUBVjkR/0KKxMmsWuLY3rJg3G5g
Date: Fri, 20 Sep 2024 16:32:22 +0000
Message-ID:
 <IA0PR12MB8713EC167DC79275451864BADC6C2@IA0PR12MB8713.namprd12.prod.outlook.com>
References: <20240920143335.25237-1-sebott@redhat.com>
In-Reply-To: <20240920143335.25237-1-sebott@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8713:EE_|CYYPR12MB9013:EE_
x-ms-office365-filtering-correlation-id: c7488463-60fd-4832-8d8e-08dcd991cdde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?k2+mBbZE3uLRe0q8wLg7uE6Kn4XZYlLwyNpAWH1dc7jBoLM6841SwweoHIAo?=
 =?us-ascii?Q?iAqBwSNaKr15HLDAkd2CfoTjUrwwyzPkGM/4FPSh3l8SL6czE3SBPgnGFSob?=
 =?us-ascii?Q?LMWeJoiX+zaH6NmBuHLnd4GUo8e/r97UqI7B0NcN7v8+Rw6Gq+4lB9mbeZEU?=
 =?us-ascii?Q?blU2EN+DYg4Ck1B1UDWahHCfh1WhlqBDy1jyDu622I/b8ZZ2sXq8VVPO6JJw?=
 =?us-ascii?Q?GhjI78MPrIwFjjBYktmUq8TrQx3EPYXLZgxJBzDAsviFFzvE2Zvxnnf4gJuC?=
 =?us-ascii?Q?zH+osUbn2Tg9hENTGkeYmMwCZSCnmS+tIv0KbkKOPdVyujSXCRAZJju17muE?=
 =?us-ascii?Q?mQS7fnHvSYtnWb1gggAD8JQjwVVzJjcoGCxFs+118gaicARVYvjRrJ8I9MOQ?=
 =?us-ascii?Q?i6PyE0QXtYNgxqBqfdWw+pDxTcTUVyaApZX8mY4kyEW29WTFtFePyKIpbnez?=
 =?us-ascii?Q?FSCnVBoKGCvSvCh+ryJffA2tizLaiMJZn/w0XKfW10sKaN8bPpaRty1EATvf?=
 =?us-ascii?Q?yffnG9sTOa7XFobNCtejTQaUgRjdZMma6q+AfZ2lpi7KiyYOddGWvY/cfqs8?=
 =?us-ascii?Q?OOvuHaojJJHRR+gVmbs8xZ/f0hN7UdO/bL+tXYzaJtgo2poI1R6WMLA0FXP+?=
 =?us-ascii?Q?lApmlBvs2E1NzZmBDatdLrbcVsQG78lXErIMke0LzA68Zcv6R/W5IoFQcDcv?=
 =?us-ascii?Q?P7rIYLxmdx+XgpeVhiwLSyEzl7OWWxTla/yYtze0zoYAbft3BwU5aa/Io21N?=
 =?us-ascii?Q?Cpgvhh9fQvecNsKb3IAfK6GdvPtQtCsmuQozQ14u2I8eBgY//ytKd6MPABiJ?=
 =?us-ascii?Q?7dD3Z5LnY+71RTTWFJVMljZK3rn4BibS/pWQmZR2hc+Jr9FbQ1J5T4tvwddx?=
 =?us-ascii?Q?NHmqIX9AsuLqa0y6BQ1JUXM/bLt8+pJgt+TJomxPkLhR6ZbWGFuWkV7P0w4x?=
 =?us-ascii?Q?1+2tChTjsoJJ0ETQ7IeJfNf099Xfs6aJ3nLktqBG+OypcD2/HwFaxi33MYvG?=
 =?us-ascii?Q?4uK+l5vtcVSmtdc5Tr+8M7UlkV+Uc1QpqCuE7exWfd4CvDBGAMDIDHa4/c+t?=
 =?us-ascii?Q?nXF3TWBuVQWnWk7xch2qN6/BjwWiJQS7nBQpg79Qlfor0QqnVhtSkkHRsxnK?=
 =?us-ascii?Q?O8TUTRhcX/mtVgLrSHtNh00am0bw0RIJfwkY4e8eE9b5ErFiqt54QRE01t2U?=
 =?us-ascii?Q?YleOXanQ2VOqHAgTpEimpq5V9qrBjZUU3nsZkzZkIGO9+h0qlz7/kUgw2OVq?=
 =?us-ascii?Q?8lGNRMMVglhjhpjrtWx0joQXiHwIjfUv9aF4sspTjdpppnMoPrUSTXXmaVl1?=
 =?us-ascii?Q?omTgLZ/ESnQaP4t5MbFYnj0SvK1ncYWA5KgqoOXvuefglA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8713.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5RakwgtWM7hj4yPUXEaB4Tzl2U1G3AWlpa3YpozGF+Fllb65wCksLrzg3VRs?=
 =?us-ascii?Q?ylpxMsdXXU4uq92WSoehl6XbWrcwd8M4CPRls0s9z/AiEkWE9PlCas3FWluG?=
 =?us-ascii?Q?+VaefXkQbaZs0+knaWSfp0m5Rfanq+FHcsb9ElHAWNEkI2Xi20mQBdjT0aOg?=
 =?us-ascii?Q?8Ho0gTjvtmpszc95z++iG6bm1jtJGLjEYyUz9Nz+xgGNrcyV94j/xIcb1tAM?=
 =?us-ascii?Q?gi5PA4uwW5JyfnVX8H8wNKa0Zk4INqOCcb37KDmlsHRc6BaIhkXux93pmhJu?=
 =?us-ascii?Q?KWmUswxcwDDNEhF9s5VU2EpXRiQ6JOFaFIaSP6S/Gwb58MXKqnW3+SrfZrlF?=
 =?us-ascii?Q?qXIEp/7gfTJBkkSxF6P8dxJ3/gCgF83Mpp669q8KKItVtPrmkJfMQhoyN2jO?=
 =?us-ascii?Q?/y272A0DRw3gpgPnXXPFCPcA/+79BM+WrtK/9wDLaHfVlGagOnpaFhrDR9af?=
 =?us-ascii?Q?IaFHnAzfSs9g1aLLVYuNWz4i8y4sxhw3oA4+aNxi+ImHAEvM9IakzIK2hNnv?=
 =?us-ascii?Q?+hbSFAj9JEEyB7zObnJoD5+KADYyDuuiZw36XH5GKSshaWGgCaQuSYJE8Y/f?=
 =?us-ascii?Q?/uOVgShIIzCH19I2B5xetRCCm2S7QEFPLAJwbI6GTy+fks43ZEDb1AI+Umis?=
 =?us-ascii?Q?dcxFCmE09w+gRnwfdUQxBCRMYFs1P1/0qqnLGEWf9sZ5vj/USi82lKSUY+J7?=
 =?us-ascii?Q?PTFGLAE2lBJgu8rvexpe+7HiCkwhGU3Nrm8Sw0oZnmprHOERYQK+BabM8cfD?=
 =?us-ascii?Q?BW2aG75DZ+wiUkYrcEMX91N4oqmIRBiiUG1KHayNAihiNb9ExEY7b9+Fc13i?=
 =?us-ascii?Q?pfk/9SzIuRNK60X9HLu5J8Xw0ykgb+hktqUaPxevHelGIvPQiupj8uwUs6Ip?=
 =?us-ascii?Q?Zu+P1ddaw34asayEkqLVVZqAce5KhrZI2cpmOWYdsEEa/WNG5hWsWP5VF3uk?=
 =?us-ascii?Q?CGLi2n6hZvfsopsAAEN9rEh0CnTHOEGJMli2Dy3EKNsVellkKnH8hmRo5Ibj?=
 =?us-ascii?Q?u8dNDfLBXWkHBWI5X8l1TdVzfCyLEahWgGg32ErFWIDV6A4OO/F0IY6beAu/?=
 =?us-ascii?Q?b3JlI/eXGVtq/aoxzGcw4koqN16UdJlPSojLU6UMbdpMAZmvpYa8N6gulmPZ?=
 =?us-ascii?Q?fxQqQbX2BOuuKhvEA8TCmKZmmWJWvq7qaMWPme0GoKgjhiICEGeV0Il5DhDb?=
 =?us-ascii?Q?daKVC/yzZd6bEdSGrYxqwu3qz+dkVq5376QWsc8s0vp+J0eDLybERrrfPkY/?=
 =?us-ascii?Q?aOJ4CFyz6BXNE/i6XRP70GgOTd/DYOEegYI8O1kNguAn371fqsJHRlkNT0zO?=
 =?us-ascii?Q?p1s3DgDaO3cH/hdiw7byAaQalkbm1UfeRK49vqRTttg2zd0douq+W5SePgXQ?=
 =?us-ascii?Q?8geEySJ8BhYt4/holL6JVX3ekeELeqi+zDW3QGLe0rXIY711CwgbK4afZmKg?=
 =?us-ascii?Q?mme8/B7/UjjGUThcZ/0u31DSyv68dABXHswwGT1fv7w8dHRrR5wGSh7QyXg5?=
 =?us-ascii?Q?H4zMlPIrldZi8LAwS4jz6Vep4qQgB27EtDbrTZ3KPyrj5+gQ8EFuSSthEFag?=
 =?us-ascii?Q?IMxeCZuTMKo+tSLNmMg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8713.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7488463-60fd-4832-8d8e-08dcd991cdde
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 16:32:22.6670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bRH5y11QGk3X8yEK4QF7CmgQKn+mNPsskxWYGdSRrgwnWbvAh0bXWRxBzurUDmSPNFmdd3NH8EuFh4UZsy0zFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9013

Hi Sebastian,

> From: Sebastian Ott <sebott@redhat.com>
> Sent: Friday, September 20, 2024 8:04 PM
>=20
> Add the pci device name to the per device kmem_cache names to ensure
> their uniqueness. This fixes warnings like this:
> "kmem_cache of name 'mlx5_fs_fgs' already exists".
>=20
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> index 8505d5e241e1..5d54386a5669 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> @@ -3689,6 +3689,7 @@ void mlx5_fs_core_free(struct mlx5_core_dev
> *dev)  int mlx5_fs_core_alloc(struct mlx5_core_dev *dev)  {
>  	struct mlx5_flow_steering *steering;
> +	char name[80];
>  	int err =3D 0;
>=20
>  	err =3D mlx5_init_fc_stats(dev);
> @@ -3713,10 +3714,12 @@ int mlx5_fs_core_alloc(struct mlx5_core_dev
> *dev)
>  	else
>  		steering->mode =3D MLX5_FLOW_STEERING_MODE_DMFS;
>=20
> -	steering->fgs_cache =3D kmem_cache_create("mlx5_fs_fgs",
> +	snprintf(name, sizeof(name), "%s-mlx5_fs_fgs", pci_name(dev-
> >pdev));
> +	steering->fgs_cache =3D kmem_cache_create(name,
>  						sizeof(struct
> mlx5_flow_group), 0,
>  						0, NULL);
> -	steering->ftes_cache =3D kmem_cache_create("mlx5_fs_ftes",
> sizeof(struct fs_fte), 0,
> +	snprintf(name, sizeof(name), "%s-mlx5_fs_ftes", pci_name(dev-
> >pdev));
> +	steering->ftes_cache =3D kmem_cache_create(name, sizeof(struct
> fs_fte),
> +0,
Mlx5 SFs are attached to the auxiliary bus. Hence, they will have duplicate=
 name and this warning will persist.
Please change it to=20
pci_name(dev->pdev) to dev_name(dev->device)

This will uniformly work for PF, VF and SF.

>  						 0, NULL);
>  	if (!steering->ftes_cache || !steering->fgs_cache) {
>  		err =3D -ENOMEM;
> --
> 2.42.0
>=20


