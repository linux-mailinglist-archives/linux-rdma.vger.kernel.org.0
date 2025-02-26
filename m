Return-Path: <linux-rdma+bounces-8109-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D793A4542E
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 04:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C483A999E
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 03:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62467266F16;
	Wed, 26 Feb 2025 03:55:42 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92DE218821;
	Wed, 26 Feb 2025 03:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740542142; cv=fail; b=PsEFAB8qif1S/Ux1kx1GT8YyA/je+GdF2cNom5phBuSG9h8ZMD9c5NYS1CDeWe+wiAPZBOwhxfyToosQpKwQspgUCMAwiPcViHk+q+lLQ+2/Vehi8ZXOYOGdBvs6wXy8k5IIVjPNpDxDoo5TurLZMEq+i0JXQ1O4X7Py7DbcVeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740542142; c=relaxed/simple;
	bh=CTPV7tJIMxI3OVFLb5B0VP3DJ1qe+SjuLjpvUwNeXV8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qcXJR16CTUmESW4avM42dvkERlqfSh//ql7EoJavWS3JobnOlV9HGT3EKALGjkr7yjENzLHMK4QJZDHynkHTWaa9ejvfe0QWuexslmX7RwtSUEE8AJZR/xcGvZ0CAAdpa/lzyC+BbR90csuoqzouCYx6Ct5sPkurO6dCp0gyXhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com; spf=pass smtp.mailfrom=mellanox.com; arc=fail smtp.client-ip=40.107.95.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mellanox.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0Q8/T+YzmiyRU5gPPpFlEg8ppyzfICAwVHqYE8kR0FBaDXoxq7B5FyPGFLKv5FGCgMceV8AqyQBeD9Qfk31dilUJsOvzXmBB46mQz5n/mDXbtr4ldN2y6oBQv1B/ycbrI3/0Z1iHZCTaxd4RIEdRSSaSyA0+T7Qqx5+OyHErKaPgHfvS+L7LBsa8lNUm0rUlPACks3OIv28IOWbehXD8i0q6eD75Ru51BeeiSew7xD2ke7CRdo+lEvBUFZdDvPgRdMaXzjBBvK2UFM9TSEU3ECsqjPh+RZO05Pe07D9dCU6msAaNplRVBWEAZ4fPiKteqO8hNzcgaza6NkP5BjUVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+NvoGXWfS1BvOMnxhSXwhXqZ+3KFH+cM1NKLtUagx8=;
 b=rT1rof5cBVQRLmcDCBAa9K9lKkbvypeVmmhTTIAd6pMtb0j7zjklNQj62Ih9PpMsKB9mmZ5LEuEmnlhJkDWD7CvYPFPw/q/Ld7RK71uVAH0McdlIMlb0WyrkuB+2ugMEmtoMJiwh9PPmyl3r2DRPiAMlKN4eJ34VEKhJM4iHn+tPatLGMkSSYRswOUXH9W9w8yrPB1KYyWSaDP4h0eJF5fX5xaSuOFz1HGUHtW5PNici8lEkA5aFyI7B7xuXF04KvBx4x8C6NMjzIznyP28WVyE9SwHkZ47ILrOhCJByVJ6JBuAF07xBWKaqiuswDSN6OLPkcRrSWkE9urtiUg1LLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by MW4PR12MB6827.namprd12.prod.outlook.com (2603:10b6:303:20b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 03:55:37 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%3]) with mapi id 15.20.8466.013; Wed, 26 Feb 2025
 03:55:37 +0000
From: Parav Pandit <parav@mellanox.com>
To: Roman Gushchin <roman.gushchin@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, Maher Sanalla <msanalla@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] net: RDMA: don't expose hw_stats into non-init net
 namespaces
Thread-Topic: [PATCH 2/2] net: RDMA: don't expose hw_stats into non-init net
 namespaces
Thread-Index: AQHbh/+DjPTHv3+fbEeq4dTuvuU+87NY8fLQ
Date: Wed, 26 Feb 2025 03:55:37 +0000
Message-ID:
 <CY8PR12MB71954B7C87C0667B57A29207DCC22@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250226033526.2769817-1-roman.gushchin@linux.dev>
 <20250226033526.2769817-2-roman.gushchin@linux.dev>
In-Reply-To: <20250226033526.2769817-2-roman.gushchin@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mellanox.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|MW4PR12MB6827:EE_
x-ms-office365-filtering-correlation-id: c20cbc03-e4f5-43af-91f0-08dd56196db7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HZnxkAkjByYX+riDA5E1iEPHkvP2BGmnJfKTp5SteT6cKgGYula2YeMxbKCE?=
 =?us-ascii?Q?uBBf/qOGJJQLpO/0JNO+9AQ8I0rrrBROaLCgxFFjtcbTXNu1iu+DuaMZdYRj?=
 =?us-ascii?Q?yGsUTt8Z4nSGxpefLprsStYXASvvVQI7sdaPddmFtscIbQirFg2NU6tRABBU?=
 =?us-ascii?Q?OE+lJ7Un4BcmZTH0dX1BDZXj0jCBC93LzCIOE5W7ICB15DwJaFx2uLVsW9A3?=
 =?us-ascii?Q?1+8QSkSDA4JkFfJNo2uW60N7fLE0pt7go06vkFuc1OFpFFmpN+cZ5XUE77B+?=
 =?us-ascii?Q?MmC/FP+RC1SNznipDYdCYO9SIVyYk78aEEUo5YEKFVgXK3DO0XZpjX6yZe4j?=
 =?us-ascii?Q?wkf8CRCOzWLfuowqedKgmSzzvNjhrMvxCqgNLwhhpcFPB+loZQ40P4xiGx4c?=
 =?us-ascii?Q?7NvFyTs42urUe5+HuxTZnMFixVZ1dlGHnxGbcAN03sDC8rEfqh3IeX+O1mWH?=
 =?us-ascii?Q?foZqSZsHNvx+rC7qLiSZtzWBaLt8BiVm6hAOMFKyxmKEub/P8EBL9TnJdjWp?=
 =?us-ascii?Q?vYIZHqxVr/mRbcMRZzcNLSC0hKTW5826Xt+WujhRqbcZx8WRGDZKKB5PBSYc?=
 =?us-ascii?Q?cCfP6xDe9UFEx6QSbT7QhSg4IxXo/PKNLKmVFOhFMtcaJ20c9mFYxxGeDrYC?=
 =?us-ascii?Q?MQUMYuKJijvMMcEgCb/OA5B8miPj81AkmrGPMTCB8c23ApSkJ2D1eE6lJdjr?=
 =?us-ascii?Q?U6ZSL3DRSQSKC+kQXsp3ovVUPArDJbAFoxmqSLunpYcSs2dOzHNRxzuYx4So?=
 =?us-ascii?Q?ynP+C4R88tyf34e1TS3uJ25wvBHvbvHxD3RPWPliyPHRcWkKwAF5/HdeBDyx?=
 =?us-ascii?Q?7mgmDaqgcPDM3wWh7d6ik1bwu1riL245sGsq7huH0dDZBDes76GsjJcsIXv2?=
 =?us-ascii?Q?DRFsELkHRi6CRmfx9UpSTrCJV2stS/kwWS6ZvtfKa4F3PN/RjmT/CpWBBjso?=
 =?us-ascii?Q?DIvubvk90U69CIVkLcFySARFojLXkFNBEtj/HeondMCvbf+xHEKJM0Tt//uk?=
 =?us-ascii?Q?KFF8yQCfirWYU4Kxl1+uIn/tUVi4si2Pf+K0+mJ1dGObP2RyNRqpCMLKVNic?=
 =?us-ascii?Q?dxefKhSWxS41ufsZUlpFlhOGqJQWbLBhNATAPlvzwjI144UWCB+e2GtqdNX7?=
 =?us-ascii?Q?Az+u2GaJbJhYZWGzbW60y5L6D5NGtgVhNtJQXjGezsAYW3iB0L+xidCBJtEn?=
 =?us-ascii?Q?oaYdAXzqQ+vCrjAK+yTwwZsdqE4xVXlCIypvMjK75zTDjNlo8mplXDlnPnJY?=
 =?us-ascii?Q?SgwA/XfZrxsS1CIYBerSZmxetT/C4Bk6+r51VvDR9DVC1qb8wjpwxdQ2iI1b?=
 =?us-ascii?Q?ih/g3Jb5Z2oyvKzWkxGM3MBzB39/fYIuOcXvDbx7x60dSZeUB9clYS1QIPeU?=
 =?us-ascii?Q?54Y8D0VMX02vf/rJ3h1s1coa/gI1cRF3m4zUBi/cN7fVr7hpTboGNB1FqnfR?=
 =?us-ascii?Q?Ng2j8mVcyJhIc5qGGiozoCq02FLvABF5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eaLd4QAEmW4E4rHtyCurrmjG0N3BObCphKTdNUOsHympDMjnk0hgmdjAEMZ6?=
 =?us-ascii?Q?NIhZDJx3BqoDsx/RxZfhuGkL1t33h0TPwInwsdKWtFo19bc2bT9oZ+AZGnrn?=
 =?us-ascii?Q?jMxCAeEf13K/avP15UmzuVYVlW50989kD3+KlyGBVtZ3HMJ94ChfL/2lU2ZR?=
 =?us-ascii?Q?q1+/sNRDkt95uE68rLiGviimkI/00Vh4Z9U69P2ho/NNfEtOpxhFJJouWSNk?=
 =?us-ascii?Q?ihnV1UatNCwMG2XFghZE6qrOQNNKskAlA3N6Tuka68xNioPWHV7lFr4wyu6V?=
 =?us-ascii?Q?WjgaBg4mpzzoxg1buq+poDEgB1ugzrPmBOIGk2xXzps+DIkX9yX4SlbCNTWv?=
 =?us-ascii?Q?jmzRyWzQYXxgtJakWWw02wD0kQxNxK2ky8KIR2uyewE57foKt7EHrADGcz5K?=
 =?us-ascii?Q?BGoW2Jm/twmuM8bJ/6UzrOWo7rqhaEBj8W6UikCLMxueOPSL6z1zAs/5VIo4?=
 =?us-ascii?Q?Cj4jdDL+RLOhdsqeJVN/zlIG6OJ5OYBTbBsdsBdQEmi3OSwQnFP/PyRNxDn+?=
 =?us-ascii?Q?zKrBX7GJXj/DW+5LoJB+fUNIXVyADgKySyGfZKFzr6FCTsXCpfHMicW7frSO?=
 =?us-ascii?Q?eR458xSz5IMJjIUX7puSmfun6lGMghAEH+0cyvo/NYQ0HHXXGMZWvPERYqiz?=
 =?us-ascii?Q?Nqar0qDZjhnMDbCFnzZLjYYRrmvKaw0dJg7UO6k7sscmMoM8LhttYa/Qy8fr?=
 =?us-ascii?Q?KWZLZLUlhGXeJDTAwAoWItAFB1bSRFAfw3Np2J0LZBXVLKyw0XcxcEotFpTF?=
 =?us-ascii?Q?Z0lPoU2np1quO8UOLjnp6QsT0loHSCWRsCqPk+SeTTByV/5BhU6gX6EZNp+/?=
 =?us-ascii?Q?yeIZ/ZxGZWohPBbJHi6A/Tjj8TgST3PYT7u++xSsXM7nxbUbhIhucyiLFt5v?=
 =?us-ascii?Q?QpG+RFmEfZ2jTgzHrPYYeaqThtza447KwOVi56n+R+zilYAigLQCN4sBDx1u?=
 =?us-ascii?Q?NILg8CPZHr+CsMBjKTq0Q3O42xairyk+1AW5OtZEIzaaocbyuqZMHK9RHeMc?=
 =?us-ascii?Q?ORa2+ggmNluOajmi8gH1ACVYPKeLIe5QcmBhETk4TdhkhR84Yw6osYIA02HE?=
 =?us-ascii?Q?HWiFgdODFAiF4QrljwidWZiqIqjxTHiMkuUsF8xweI6KKFxbmNVl772Hgo/R?=
 =?us-ascii?Q?qvTI8nOtgDrKwDFghi8x/mdRl9zZkz1kguSp9bUa+VWFUT+dmDcVhzIWv4+i?=
 =?us-ascii?Q?Z1DMmXJXhBczQEUWQwKnFt+j7k0bxixIE6oYgYFPtUoloFa1KnJVEBWURQvL?=
 =?us-ascii?Q?2IoLiHT3KomcL9E1kPSJ5h+8Big9Arfvz3dpKslCHg9JFM7AvQfNtLK37g3d?=
 =?us-ascii?Q?rZenFowTYYuidptWZaXfQLUseeckFyp/ISAhHZYemG4SHXl3BhSWWQnwjGOG?=
 =?us-ascii?Q?cVslp/x3yTrHrtnsGvDY6WVQqo/RQyuOv3LhjNoZKxTzIjYfEhUdUKeUBlKZ?=
 =?us-ascii?Q?gfd/nSR4mc/LV0xvbDB9eiFG6Is+C8pZHzGIiN5IDt3m6e7cKiDFHxgZysk4?=
 =?us-ascii?Q?jkGvIoG/7+7HolWTTwRnhAzGbORE7/jsE9yAP2JavaghGYpyOc6t+frFSya3?=
 =?us-ascii?Q?qDis+GikT9OBh6f6jYs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: mellanox.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20cbc03-e4f5-43af-91f0-08dd56196db7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 03:55:37.0864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lEwVU+UMe7R161xilai+sFN3mARMHPzlOw6fVLte/zqrRz+2iWpP+kmA99ddTXO1+dXz4GlYz0AjhlD6UuUZRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6827


> From: Roman Gushchin <roman.gushchin@linux.dev>
> Sent: Wednesday, February 26, 2025 9:05 AM
>=20
> Commit 467f432a521a ("RDMA/core: Split port and device counter sysfs
> attributes") accidentally exposed hw_counters to non-init net namespaces.
>=20
> Fix this by hiding the IB_ATTR_GROUP_HW_STATS group when initializing a
> non-init rdma device.
>=20
> Fixes: 467f432a521a ("RDMA/core: Split port and device counter sysfs
> attributes")
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Maher Sanalla <msanalla@nvidia.com>
> Cc: Parav Pandit <parav@mellanox.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/infiniband/core/device.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/d=
evice.c
> index 8dea307addf1..bf4a016ccb9d 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -528,6 +528,8 @@ static struct class ib_class =3D {  static void
> rdma_init_coredev(struct ib_core_device *coredev,
>  			      struct ib_device *dev, struct net *net)  {
> +	bool is_full_dev =3D net_eq(net, &init_net);
> +
Instead of it, below is more elegant check because=20
a. its limited to do comparison on core dev area and other generic structur=
e.
b. reuses the infra used in sysfs.c to detect coredev.
c. in upcoming future, I plan to expand device creation in non init ns too,=
 where it still will be coredev.
And this conficts with that idea, hinting that comparing in below manner is=
 still more elegant.

bool is_full_dev =3D &device->coredev =3D=3D coredev;=20

>  	/* This BUILD_BUG_ON is intended to catch layout change
>  	 * of union of ib_core_device and device.
>  	 * dev must be the first element as ib_core and providers @@ -539,6
> +541,10 @@ static void rdma_init_coredev(struct ib_core_device *coredev,
>=20
>  	coredev->dev.class =3D &ib_class;
>  	coredev->dev.groups =3D dev->groups;
> +
> +	if (!is_full_dev)
> +		coredev->dev.groups[IB_ATTR_GROUP_HW_STATS] =3D NULL;
> +
Static hard coding to HW_STATS enum is not enough because when IB_ATTR_GROU=
P_DRIVER_ATTR group is not used,=20
ib_setup_device_attrs() will initialize HW_STATS at index =3D DRIVER_ATTR.
So you need to store the index of hw_stats group in the ib_device struct, s=
o you can make it null for non_core_dev.

And if that can be done without introducing the new enums, applying the fix=
 on previous stable kernels will be easy.
Otherwise, this patch needs to do to -rc and other previous patch to -next =
and its difficult.

>  	device_initialize(&coredev->dev);
>  	coredev->owner =3D dev;
>  	INIT_LIST_HEAD(&coredev->port_list);
> --
> 2.48.1.658.g4767266eb4-goog


