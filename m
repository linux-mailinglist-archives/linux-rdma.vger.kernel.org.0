Return-Path: <linux-rdma+bounces-1187-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D762886EE36
	for <lists+linux-rdma@lfdr.de>; Sat,  2 Mar 2024 03:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F791C20DD2
	for <lists+linux-rdma@lfdr.de>; Sat,  2 Mar 2024 02:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6E510A22;
	Sat,  2 Mar 2024 02:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VLG/PPyn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2099.outbound.protection.outlook.com [40.107.95.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD68BA45;
	Sat,  2 Mar 2024 02:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709348285; cv=fail; b=RKt5mTcmQtf2T2R8RVWJI8nnwqTC2xSqxQYmoGvk2ISfv63xDZuv27mz+PZUrb8QOTFpieNFLVplWOYHB0O1jVb9kBFmtAw6tgbIfP2xx0uqbjokUezd/EM4B3Pfx09zFfrycpJwt+QMX7ZVQB82H+ITAdTn4LuS+0UAOInOtkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709348285; c=relaxed/simple;
	bh=FgvfsdKABg+Lo22c77gu+JIdCXRuakBSwYNVgqZwJPc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g69MmJEwsRoYIVkB1OEda2C53qU59Lu6iPFPyQ+zu7UnNsgBaAeeNUrJwCoFZQqFAHJ8Y8/nqHO64EofDGrUzyaNwoL+Dr9AEQfEPttVQpDg3+Lh02GwuBzZPv+Xri3a3hz3qKj/ACpL1GRx6phBi94A68Z29JUP/F0rMHd/gwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=VLG/PPyn; arc=fail smtp.client-ip=40.107.95.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCx0s+qwyrEuvAFk2dj/B5dFG2ivrfUfQOgVU7vi/qMWZ2v3BxDEYM7uQ3hO5M7rhqGLZVV0nphNNio4b85JtBKV914kf8aCGybG7yv0Ij+aEza0LA/8xNBmQKgTwUEItM3+2wtxr6Tlmz6xoPfs2IoqX0XzO3Ho5eb/Jj0Pjnpwgr4b99hK0abI1rNEMFkAkDoFO2Mw+seru0Yrc/mOar7eMu2C7n5EKHoCfIRhjaoJFS1Kpl/nTmsQRzRx9hS7WEzyxXRmCYt0LhsjuEwbvaffdscUtVQBK1HplG27IM+3FbKKVsjVEYRXJCmzaLHFimPR+TxSueaZdQpGp2HZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+j/jlyc4Xawg6AfLiRLLLouhXbucqyqut9+zAHcHEI=;
 b=VMYv9re7XYAHDnZqMRjzDXV8fWZcSYSw7L/y3nCjXZZdjhvTeb4eKFSwl9reR8RGH9fn+ZV9QILp3SVnEWjlH7qlaYRUA4K+rj1rNBAWX5xChB4VeUzgugrCBFsfjfxza3n2G8BS9Xz7IVwZpGiEP4AyRuxaJB2tsgdOAQphVaesmj1oK9Gx9S4+9E4Ms0RE99ZDS+K7Rrx1AvzUZRMVlgs3Cu5txsVEwahgwuz2TkVGRxDWbg+5YgOq3O4Ub4ToYzNZnKOUtV/FdBKeypf7hE3+NxLXbIVXyCOLBmPXYpQ/tMcfDzXg0LZPBt8ILyyDejGpb620Q9qak4WCShwQng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+j/jlyc4Xawg6AfLiRLLLouhXbucqyqut9+zAHcHEI=;
 b=VLG/PPynyyFgaN+JBfaMM77GwlfnA5NBdBoM1E+j/EaC+IM8y7Nxkbt8Go5tgevHZ0iHAS9iKTAR0gDn4qYqKcTv0I30h+2DuwrlV41oNI0NcK3qjhUMNYWyKM9noOUZ9+N3Kfr5Uq5BRKEonXlRpqf+P81buMk+H5kIDAl+JX8=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by SJ1PR21MB3528.namprd21.prod.outlook.com (2603:10b6:a03:454::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.17; Sat, 2 Mar
 2024 02:58:00 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7%4]) with mapi id 15.20.7362.017; Sat, 2 Mar 2024
 02:58:00 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v2 2/2] RDMA/mana_ib: Use virtual address in dma
 regions for MRs
Thread-Topic: [PATCH rdma-next v2 2/2] RDMA/mana_ib: Use virtual address in
 dma regions for MRs
Thread-Index: AQHaaIUJDd9nmAvQZky1S7+zCOe6Q7EjyPqw
Date: Sat, 2 Mar 2024 02:57:59 +0000
Message-ID:
 <SJ1PR21MB3457D7E2DE4C06C9C5D2C625CE5D2@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1708932339-27914-1-git-send-email-kotaranov@linux.microsoft.com>
 <1708932339-27914-3-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1708932339-27914-3-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f03f0774-6a73-4eaa-8790-40d8d41ec645;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-02T02:54:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|SJ1PR21MB3528:EE_
x-ms-office365-filtering-correlation-id: 5075939c-b060-47d4-96b6-08dc3a6491e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YKn8s44/+b0KO8WeF3sMMEfUokN9VPsk4WNvkVvT3iae2oFOrVqZMMuhVPVap6osY4Nuhg4Fw5x+yeZ5TR+tsIIQSwTOgqxgYlGriDfLm0yUV2iktpb1gcNOHGkNiV0UBnSucb+dtiLovkh7vdQbyj0LtPlRRXxQ9nMbEnMb51EfDp1ClF2I5eGKu3aQm/LP4YTXNHv7DayomJJOk2nIFak3f9ZTcBwVMWAkjQmYnGNxEhBSFAEU19sYfc9hGZFj6+BJsS78roqnpZxJSQaRt+L0dAbOqON53yOy2mgcrwOaJhzekfpntzrWHa3W9letmXyoytiFdNulbP3KwD/9Jx7GIBaTRY3Fs+3HA5h/yijfIAcOVdeuXTyYmjOXSXmE8JUx9eNvsiuXunm8mcwq0kUorIxh1rs4xfbjIKuEtMvdbndpK2ibhm2XP3Hz+rPvpvJH+CP4lseq/DkalcKgrM5P/lQrrdAvIgeKVhRcLTcaBMWBJAVU1zNIU3fRREfH1gMWwwdLG8mejq3qYXXOPiJgYyEGn4PP2WxfHm+lxbndf+jP/se1O0gmlM8zpuDPJCySe1Jj1BOl6IzrTpiZsPZLw3shdPs/Gylait2D9b7sLZaMmGeA/0XWMwPro1aoVyivMRBO01ZNXyCYq9vTKkLu56GcojyQBWwryuB4YvUHVcf0Ps7KoBqIrKxxfEiTsSVoR453HFGpttiDhfgBSw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?blvMDYEeNUwTu//+LqidbHL6J9bbKUgQ+g4qKmmBjpZtr5vYiuO1I77KEKCZ?=
 =?us-ascii?Q?uNrA/TzSeFJWnvgWCYe79GcSauWKRRILeIr5kUMjaxhgJX3thHsHWn86WZnl?=
 =?us-ascii?Q?3hi+liFY1ylgchWKKQZKljN4EB/iTUpYYPC6ySLQL+LbUOM2n8w/8S582hgu?=
 =?us-ascii?Q?gAizu4xSuXzEWxrlHzwNNijaUnoUqMX8WfbWRgQz3+IKPVgs1hr8bnSgACeD?=
 =?us-ascii?Q?rwyEXTMm/+tpG4wdViAqhU8/O8bbxlgLdVrxOtGpAHRTnVQ61LjUdK2Hbsn2?=
 =?us-ascii?Q?4PyD3e9RnJE5xJ+GA8JnXXU4/DDqEIBq85w37lA95m9YOEjrtLd+Jut/cL+K?=
 =?us-ascii?Q?D3VXpHlHuetFIFImljFtin8/778PfnI/WWkuh4yAriyAQ/Zto1VvzwYFUW1+?=
 =?us-ascii?Q?QtQ79FtHvGat3FMCBoiXKqfRefthHwELMS/luo91WcYHu7R0OZl10SL6EGzu?=
 =?us-ascii?Q?3Sj0m6rMP0Vw63vv4mZ4HYIf51Hkqu8WTScokkdeRS/gQSlWAU3myJluGDzD?=
 =?us-ascii?Q?jdTVnBiIk1v7OUufsyyTBUdrwmtG2xxG5P7kBpCEBATanojnFTwi65AbKqux?=
 =?us-ascii?Q?As05ZWxK/NB53j2pr/j8AFNzHfl5+K1uNPwwcg86LNpot4F21vscUmPYIbuC?=
 =?us-ascii?Q?fjXdRXb3Z/hJn3+Ouh/H+3hGsc+258E6BzGo+b5SFsc4KEouC1BeJCu8LIMk?=
 =?us-ascii?Q?ifekLcTFS1SesrfN9W6Mp7vE1zYROjcSpDTrzHZeyBO+AoCaUykHuwjOKPqv?=
 =?us-ascii?Q?2caKYMTS4kVtkat5LJBqU1q8HnGqwAPvj09zUEqQyDgr7HunVEBH+a1Iv702?=
 =?us-ascii?Q?AKTalx4J4pBKTGRT24Ugl6dRgdiqLzvnkn+6YDisYeXCerDX5fP5lSRyVAFc?=
 =?us-ascii?Q?N5pFmXD0O7eOs+QyAvx89dxtB82V/OOxSqD9Vv8oEIy1q8IcK8dgJolZJp6a?=
 =?us-ascii?Q?EyQeLrdnw5SjjfRZdemaoqcugxVL+jmorPViwPonsN3bO0kQX9sNrtnzfehM?=
 =?us-ascii?Q?fDMn4SAxMZEBjPI2mYPd/KUboxHBvGx09s/Y5rgyzEbfNx/bzrGLXzn/iKpa?=
 =?us-ascii?Q?VLMx3LuF+yMnSfcpyPqExKtq0rRCMF4niFdjc+t9usxS0z7UmYv2xwQWzagv?=
 =?us-ascii?Q?aWAWBm6GLmQGRRFPUxtlBOkdML/et3bBu0V1WJCfkG9PbCplocbGm0SezUao?=
 =?us-ascii?Q?9FhAcANL20oDUbv7l9O6Sq1FqwfNgwoma7YAkj9gtuJW0hsh9c8JkeM3bHH3?=
 =?us-ascii?Q?B3QNhpX7b/rYEI4MLDRz+1BOLuGKgXN/fuYJIiSSC4Q2ibI9W7rS+sJExa1G?=
 =?us-ascii?Q?QLX1j/wy3vJGBhi4BXR2vIM+6Sk5mklmv4/lXofnKh9APeJAMyOG3MZ50l+K?=
 =?us-ascii?Q?hbDjZ8MtKY+XRfqmp2GXpEJxAd9dqFu7FtEMWytBHl42LZuDzWsVvuAjSnf6?=
 =?us-ascii?Q?D5o5FjfkYj5Jdofa3hzmwrDzD9wcHXrpdgeo7im0mZ1C27nzx+42BO3b0R4a?=
 =?us-ascii?Q?BAH9cpqQNq6niEquHyDVMLmuxo0powIPb7vz6XVpLmRZo54iw7HXKzztumgO?=
 =?us-ascii?Q?Yn8Q85liEMRriNkmz+LkkkPceb8lAsXcNVmy+K4o?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3457.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5075939c-b060-47d4-96b6-08dc3a6491e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2024 02:57:59.8537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RzsnEdPNicnhfoytuZgCacsP/tN4NJEZLJ49wyHdjlcCN3Wi8hCpvgD4xsF8hBfGKKXGNiOHSRm5TaIayWZJgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3528

> Subject: [PATCH rdma-next v2 2/2] RDMA/mana_ib: Use virtual address in
> dma regions for MRs
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Introduce mana_ib_create_dma_region() to create dma regions with iova for
> MRs.
>=20
> For dma regions that must have a zero dma offset (e.g., for queues),
> mana_ib_create_zero_offset_dma_region() is added.
> To get the zero offset, ib_umem_find_best_pgoff() is used with zero
> pgoff_bitmask.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Do you need a "Fixes:" for this patch?

Also, you need to include a "change log" in the cover letter 0/2 since this=
 is a v2 seires.

Long

> ---
>  drivers/infiniband/hw/mana/cq.c      |  4 +--
>  drivers/infiniband/hw/mana/main.c    | 40 +++++++++++++++++++++-------
>  drivers/infiniband/hw/mana/mana_ib.h |  7 +++--
>  drivers/infiniband/hw/mana/mr.c      |  4 +--
>  drivers/infiniband/hw/mana/qp.c      |  6 ++---
>  drivers/infiniband/hw/mana/wq.c      |  4 +--
>  6 files changed, 45 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/cq.c
> b/drivers/infiniband/hw/mana/cq.c index 83d20c3f0..4a71e678d 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -48,7 +48,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>  		return err;
>  	}
>=20
> -	err =3D mana_ib_gd_create_dma_region(mdev, cq->umem, &cq-
> >gdma_region);
> +	err =3D mana_ib_create_zero_offset_dma_region(mdev, cq->umem,
> +&cq->gdma_region);
>  	if (err) {
>  		ibdev_dbg(ibdev,
>  			  "Failed to create dma region for create cq, %d\n",
> @@ -57,7 +57,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>  	}
>=20
>  	ibdev_dbg(ibdev,
> -		  "mana_ib_gd_create_dma_region ret %d gdma_region
> 0x%llx\n",
> +		  "create_dma_region ret %d gdma_region 0x%llx\n",
>  		  err, cq->gdma_region);
>=20
>  	/*
> diff --git a/drivers/infiniband/hw/mana/main.c
> b/drivers/infiniband/hw/mana/main.c
> index dd570832d..30b874938 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -301,8 +301,8 @@ mana_ib_gd_add_dma_region(struct mana_ib_dev
> *dev, struct gdma_context *gc,
>  	return 0;
>  }
>=20
> -int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct
> ib_umem *umem,
> -				 mana_handle_t *gdma_region)
> +static int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct
> ib_umem *umem,
> +					mana_handle_t *gdma_region,
> unsigned long page_sz)
>  {
>  	struct gdma_dma_region_add_pages_req *add_req =3D NULL;
>  	size_t num_pages_processed =3D 0, num_pages_to_handle; @@ -314,7
> +314,6 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev,
> struct ib_umem *umem,
>  	size_t max_pgs_create_cmd;
>  	struct gdma_context *gc;
>  	size_t num_pages_total;
> -	unsigned long page_sz;
>  	unsigned int tail =3D 0;
>  	u64 *page_addr_list;
>  	void *request_buf;
> @@ -323,12 +322,6 @@ int mana_ib_gd_create_dma_region(struct
> mana_ib_dev *dev, struct ib_umem *umem,
>  	gc =3D mdev_to_gc(dev);
>  	hwc =3D gc->hwc.driver_data;
>=20
> -	/* Hardware requires dma region to align to chosen page size */
> -	page_sz =3D ib_umem_find_best_pgsz(umem, PAGE_SZ_BM, 0);
> -	if (!page_sz) {
> -		ibdev_dbg(&dev->ib_dev, "failed to find page size.\n");
> -		return -ENOMEM;
> -	}
>  	num_pages_total =3D ib_umem_num_dma_blocks(umem, page_sz);
>=20
>  	max_pgs_create_cmd =3D
> @@ -414,6 +407,35 @@ int mana_ib_gd_create_dma_region(struct
> mana_ib_dev *dev, struct ib_umem *umem,
>  	return err;
>  }
>=20
> +int mana_ib_create_dma_region(struct mana_ib_dev *dev, struct ib_umem
> *umem,
> +			      mana_handle_t *gdma_region, u64 virt) {
> +	unsigned long page_sz;
> +
> +	page_sz =3D ib_umem_find_best_pgsz(umem, PAGE_SZ_BM, virt);
> +	if (!page_sz) {
> +		ibdev_dbg(&dev->ib_dev, "Failed to find page size.\n");
> +		return -EINVAL;
> +	}
> +
> +	return mana_ib_gd_create_dma_region(dev, umem, gdma_region,
> page_sz);
> +}
> +
> +int mana_ib_create_zero_offset_dma_region(struct mana_ib_dev *dev,
> struct ib_umem *umem,
> +					  mana_handle_t *gdma_region)
> +{
> +	unsigned long page_sz;
> +
> +	/* Hardware requires dma region to align to chosen page size */
> +	page_sz =3D ib_umem_find_best_pgoff(umem, PAGE_SZ_BM, 0);
> +	if (!page_sz) {
> +		ibdev_dbg(&dev->ib_dev, "Failed to find page size.\n");
> +		return -ENOMEM;
> +	}
> +
> +	return mana_ib_gd_create_dma_region(dev, umem, gdma_region,
> page_sz);
> +}
> +
>  int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev, u64
> gdma_region)  {
>  	struct gdma_context *gc =3D mdev_to_gc(dev); diff --git
> a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index 6a03ae645..f83390eeb 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -160,8 +160,11 @@ static inline struct net_device
> *mana_ib_get_netdev(struct ib_device *ibdev, u32
>=20
>  int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq
> *cq);
>=20
> -int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct
> ib_umem *umem,
> -				 mana_handle_t *gdma_region);
> +int mana_ib_create_zero_offset_dma_region(struct mana_ib_dev *dev,
> struct ib_umem *umem,
> +					  mana_handle_t *gdma_region);
> +
> +int mana_ib_create_dma_region(struct mana_ib_dev *dev, struct ib_umem
> *umem,
> +			      mana_handle_t *gdma_region, u64 virt);
>=20
>  int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev,
>  				  mana_handle_t gdma_region);
> diff --git a/drivers/infiniband/hw/mana/mr.c
> b/drivers/infiniband/hw/mana/mr.c index ee4d4f834..b70b13484 100644
> --- a/drivers/infiniband/hw/mana/mr.c
> +++ b/drivers/infiniband/hw/mana/mr.c
> @@ -127,7 +127,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd
> *ibpd, u64 start, u64 length,
>  		goto err_free;
>  	}
>=20
> -	err =3D mana_ib_gd_create_dma_region(dev, mr->umem,
> &dma_region_handle);
> +	err =3D mana_ib_create_dma_region(dev, mr->umem,
> &dma_region_handle,
> +iova);
>  	if (err) {
>  		ibdev_dbg(ibdev, "Failed create dma region for user-mr,
> %d\n",
>  			  err);
> @@ -135,7 +135,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd
> *ibpd, u64 start, u64 length,
>  	}
>=20
>  	ibdev_dbg(ibdev,
> -		  "mana_ib_gd_create_dma_region ret %d gdma_region
> %llx\n", err,
> +		  "create_dma_region ret %d gdma_region %llx\n", err,
>  		  dma_region_handle);
>=20
>  	mr_params.pd_handle =3D pd->pd_handle;
> diff --git a/drivers/infiniband/hw/mana/qp.c
> b/drivers/infiniband/hw/mana/qp.c index 5d4c05dcd..6e7627745 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -357,8 +357,8 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp,
> struct ib_pd *ibpd,
>  	}
>  	qp->sq_umem =3D umem;
>=20
> -	err =3D mana_ib_gd_create_dma_region(mdev, qp->sq_umem,
> -					   &qp->sq_gdma_region);
> +	err =3D mana_ib_create_zero_offset_dma_region(mdev, qp->sq_umem,
> +						    &qp->sq_gdma_region);
>  	if (err) {
>  		ibdev_dbg(&mdev->ib_dev,
>  			  "Failed to create dma region for create qp-raw,
> %d\n", @@ -367,7 +367,7 @@ static int mana_ib_create_qp_raw(struct ib_qp
> *ibqp, struct ib_pd *ibpd,
>  	}
>=20
>  	ibdev_dbg(&mdev->ib_dev,
> -		  "mana_ib_gd_create_dma_region ret %d gdma_region
> 0x%llx\n",
> +		  "create_dma_region ret %d gdma_region 0x%llx\n",
>  		  err, qp->sq_gdma_region);
>=20
>  	/* Create a WQ on the same port handle used by the Ethernet */ diff -
> -git a/drivers/infiniband/hw/mana/wq.c b/drivers/infiniband/hw/mana/wq.c
> index 372d36151..7c9c69962 100644
> --- a/drivers/infiniband/hw/mana/wq.c
> +++ b/drivers/infiniband/hw/mana/wq.c
> @@ -46,7 +46,7 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
>  	wq->wq_buf_size =3D ucmd.wq_buf_size;
>  	wq->rx_object =3D INVALID_MANA_HANDLE;
>=20
> -	err =3D mana_ib_gd_create_dma_region(mdev, wq->umem, &wq-
> >gdma_region);
> +	err =3D mana_ib_create_zero_offset_dma_region(mdev, wq->umem,
> +&wq->gdma_region);
>  	if (err) {
>  		ibdev_dbg(&mdev->ib_dev,
>  			  "Failed to create dma region for create wq, %d\n",
> @@ -55,7 +55,7 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
>  	}
>=20
>  	ibdev_dbg(&mdev->ib_dev,
> -		  "mana_ib_gd_create_dma_region ret %d gdma_region
> 0x%llx\n",
> +		  "create_dma_region ret %d gdma_region 0x%llx\n",
>  		  err, wq->gdma_region);
>=20
>  	/* WQ ID is returned at wq_create time, doesn't know the value yet */
> --
> 2.43.0


