Return-Path: <linux-rdma+bounces-2644-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D508D258D
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 22:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92271C22E24
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 20:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AD0178CCD;
	Tue, 28 May 2024 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hnO7mWuA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11022010.outbound.protection.outlook.com [52.101.56.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF10810A3E;
	Tue, 28 May 2024 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716927268; cv=fail; b=ZjT5sqNB0ERweEKnqUt8rEomd55Fzd29wQVrbeThwk6tjYLcrpFPDKJfnZzE08SMPxSeUe0Kqup35jS6PVhrMmFEcDclwjNpOhefBxfhwbe+AI6I6flUH1oBnxc/EHYnkPbLNOupo1S2wEfupJfAgyZOy39RrE0Vr3/xBuMZC90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716927268; c=relaxed/simple;
	bh=KDpCHfyldYylrBd3UsuZui5aG3ZUr+HrOUYRobD++/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LVDCdMyVZ+Xqc2R4Pm8jnkjy7DPe6nTavCtQCSRPLMG957vix5n/gq4iPzT2CAHlf1QjCaHIYT29JLVOlxxOMeDTldfYJXkMTpgiKQDjLa6K2ZCYY2dzD9X6Z7IP7UUJly6yOYkNN+0G2260hEKcvDNAgJuif0ymq/W2XTijy08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=hnO7mWuA; arc=fail smtp.client-ip=52.101.56.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUmUdJYpWG2eB/WCSlyFD8H+jmXY7dmK8mjoce9t21Qmbg3KtECPLnu2ZH5ubzfmHPmMic8q0DFashnOVJexO0G40oeKBTz/nDEmfbxuhZZ3MhElQD+RBTULZSy+0hzkIDoLUABmEFmbFJJ/Cd+x3OyM65J2e1PdJBRRkBDHi0Oh2NdiDY4l+B6plg5fsoo582iDQXziqC+0gdVI03GBZEBvgmvnU1AfR4/2zuifCaGFm2QiZIXse5On31ysMyMic0Yacjw2TJxp52jsMDL3N3+6lyyZsNUe3u6docmGFomtZNMj14A+2+YFz0Eig2iBVaR56d7ssanwYEmOVysF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3k6nSeqNHP5zp2F4zSjjk2AKYbuHiW6IWh9HDAnnQ0=;
 b=cbeKqIwdmRB0zP0PGk7s4KemrcJiI+yYU/NyIZ2+EwYhJiOUi1q/BFJmRQTcRGt3S8E7O8dOHX4HY0d+DmroVgF/OKNK2thfU7U4bUpN6jQpb+e+vYTHN5F4xRIJFwLccg3lgLvQr3ySGjH0mpvyJPjxPnet3PA29i8NAE7l0w/LW19A3HIH2g4N/jYpwh33mQFWbPr+zoPMPk1F+g4GjIYH7vStWH2CBcPUWoBGWhkiKiEGbJw+vIaxcQYWdDm4QSacua6jIFi8y85kfUJVnryqa3fztom7rJEDT0lLR70W5B0kIxsom3bnjKMmn1TdlYVNfapyiFgYGSAS7XxiLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3k6nSeqNHP5zp2F4zSjjk2AKYbuHiW6IWh9HDAnnQ0=;
 b=hnO7mWuAeCrwChCW3si7CSuZ5jZXsgyi+c4caJuisVfxJuC+hZktUzXq/XNtpuAK784rbXM3cKpZNOM5mlQO8/QQuTcmn8HUPm4WNSc5PCVBt72nHa/ajF6hAETAfcrgIRaO93x50peZlG8mpl2hBAsw3bubrYX1Z7pFZ5PFfCY=
Received: from PH7PR21MB3071.namprd21.prod.outlook.com (2603:10b6:510:1d0::12)
 by DM6PR21MB1434.namprd21.prod.outlook.com (2603:10b6:5:25a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.0; Tue, 28 May
 2024 20:14:23 +0000
Received: from PH7PR21MB3071.namprd21.prod.outlook.com
 ([fe80::204c:c88b:65d2:7d3a]) by PH7PR21MB3071.namprd21.prod.outlook.com
 ([fe80::204c:c88b:65d2:7d3a%3]) with mapi id 15.20.7656.000; Tue, 28 May 2024
 20:14:22 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 2/2] RDMA/mana_ib: extend query device
Thread-Topic: [PATCH rdma-next 2/2] RDMA/mana_ib: extend query device
Thread-Index: AQHarREBjrgSbvhcc0GDjv4whEc0obGtHKsQ
Date: Tue, 28 May 2024 20:14:22 +0000
Message-ID:
 <PH7PR21MB30711A6DBAAD7D8863735CBECEF12@PH7PR21MB3071.namprd21.prod.outlook.com>
References: <1716469137-16844-1-git-send-email-kotaranov@linux.microsoft.com>
 <1716469137-16844-3-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1716469137-16844-3-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=39a8e2db-5319-458d-b4f3-cd2fa6fc7747;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-05-28T20:12:44Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3071:EE_|DM6PR21MB1434:EE_
x-ms-office365-filtering-correlation-id: 28fd4baf-83d8-4b49-db84-08dc7f52c38e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?l4nzFGRkWE6C95g/HRmv5XBEXo+qp5NNNzPyVJgOz00M0beDNee4xK9FeAvp?=
 =?us-ascii?Q?ozY8sw0IhYYKOSvjCq4QfxoDVcGGXxhSWq62+/0p3LoFQ6+Sz11bjYiL1V+O?=
 =?us-ascii?Q?mxL/C1x36UJSvDhOHL8EJDbAc0tzhCtS8CDfPhYOh5B+rAqTtff4uCRDt9t9?=
 =?us-ascii?Q?mYmUfdkgw0ckHJsdobPwfGqClksq0naP4P5RFaDGU3JchYx1Z3nM/ZX7kKMz?=
 =?us-ascii?Q?yMj8StjldY8j7Jc4zOm7OOovASFYhWVpxtUeL4TYr7IinmzXCrcJyRnjQoRw?=
 =?us-ascii?Q?XehmeE86thbuOEDmEJHJ2wh5PxhiH3xcv4J9NWaKchhGtC1/0GsC0MY+yKp7?=
 =?us-ascii?Q?oCLO3D1at26whXvshN6shDaMJlnUAoMtEuH4tb+lu4pVtFID8bkQhV+23r6/?=
 =?us-ascii?Q?PtFrimgnimDYvSDapW12hmt3Pmrre6p38XTQ3izM2TQ1CHGOugbO46Z0s/AI?=
 =?us-ascii?Q?+wqyq9PYbTe+uXXm/NNyGUUL8NPAhro03Abhwcllt6X/y5YwMPhiYkdlPsaT?=
 =?us-ascii?Q?aXeIh6mTZlbg77w9x9ypMwU9cBJhHmBCda4TDNza6c/H28HxvkVAJkHAB+6i?=
 =?us-ascii?Q?OVMXss2oBMOAhOG4p5YOfv0d30ZUF17eyTgXh6knNhdfwAYulHrFmbpbX83t?=
 =?us-ascii?Q?4tPKpwN7dsfquYJhYnHTytWo7v9YlFT7QCXv0YHPHFfHwOqLt+SyjHDNtNex?=
 =?us-ascii?Q?0yYCnM1NgM4mJprDiw212zBomlcXPEvV2aJrvMl53ufMLdDAVcje2QQplVGh?=
 =?us-ascii?Q?VcTxZFKL/u+CXmGWK47PoiN0cHNaroaeYHv1xD4U1esUyDSsdm/I7+wuPq3L?=
 =?us-ascii?Q?rsTL/Pf4jKl5K0AyaBHDYhhG8MnuZXPBj1oK+LOPP+W3zycE9B8E2UT8KBqZ?=
 =?us-ascii?Q?02prcN8CgkiqsBOdmfq53fmC0PcZS2bLt6cDDcdoWWGImqCgeH0aQKZkeWSP?=
 =?us-ascii?Q?ck3EYigaNrz5olfxt2tJHyXZgnt4rrVlrJo6CCP/RMiCAWsynquuAWwn0BVl?=
 =?us-ascii?Q?O/a/FzdWbD62VcOeMqwaOFGpS7VhS/Y3mPSlZmVT7328hd3hB36EE9Y6YjOM?=
 =?us-ascii?Q?VHtSWTVb+DIImQ71lxE5yPlcEoyeR4wMBqVDfQqdtGk84c9fmUJukpkTrIz+?=
 =?us-ascii?Q?PrfzHUETprnaas2k21NAXEcT3sJgMnpfHjgK/FP9unR0uASgvLwmksXrytev?=
 =?us-ascii?Q?ICJ4gfQcrpzwuhoTHqiSue7CiriQ5UPOtewYMaagUUD8u5orr8zlxOmC+ckg?=
 =?us-ascii?Q?aYWYvgMrs8kr7kxKSXBHjBuDMOpFgFcyw4FCOc1CqWf4PCv739EIgx8dLlQu?=
 =?us-ascii?Q?9HCKr199OSCPIxjv3y9LXdYAixrsIOgMSZa+B0B9prihBQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3071.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XYVLs8M9oNsQ1Xx+6AojmhCGJ8erR7ikN2c1JvyAi2OLANBw6Ue7k5rYDmyH?=
 =?us-ascii?Q?HeuCGpqZig9Oj1yyAvzLq1uPDEjvuoeKAgxBueG3BvqZXONYrdnpNU4uGj/S?=
 =?us-ascii?Q?m4IwCz1LzhJFRpwVsrUPUP9EU1j2ZIJKpIlaDNkw1pVk5DF5ZwKg8L6aV1/i?=
 =?us-ascii?Q?SxqQ/XH1BbAgTDyZdq/gjf1GrtqUR8DnDQGI6e3EZlGpZAdyeLlZB0+SApYe?=
 =?us-ascii?Q?VlK7YZvdhJeWeT6S9fgVZNeLw2PFF8g3mgjMTHICVN3DCUdAuL00jpyTGNeQ?=
 =?us-ascii?Q?uavJGqGFaTJXb0T2e0lMLx+lmJXuSkJ/wxVMVnPRSJjDhriPwRl7Cq3GjVYx?=
 =?us-ascii?Q?YFcQMcRCH2yK9p9z4nKYmEcUa2W/2JTyONT+ucITBMq7pXhQCcOpiT1LxXc+?=
 =?us-ascii?Q?ov1k4DqJE+Q46ig+tB0YyYYpvbOoH3vgwEDI7av87fkOnl3uXy1kK7BnSKek?=
 =?us-ascii?Q?tirpH2rfQXkpjyc3T5BG70fxjFBLRkENaEAfIZH3q3/RpS28rCXwyc5IXpCo?=
 =?us-ascii?Q?8mH1a1AsTtV6ngSUublo13rRO6ks0jfWXaapf4ONnwBhF/VG5l+TADEactBv?=
 =?us-ascii?Q?MrxBfxN9AiCtF6Y3g03RVZY4gb8OPH+48peuuLp2FRzpfZ/OoDIvOKxSS6jS?=
 =?us-ascii?Q?k4f2mOMytCd+hTlDgF54Bp0J8Jqy62TWB4gf7I7tBNwB+CfRPNlXOaihoU/p?=
 =?us-ascii?Q?LKB0B2AFXuLlUscQku1isOdDCccx2OdXpZGQuYc4qHMvSTzGPrCMQyxjw4w9?=
 =?us-ascii?Q?ZDukRZ+F35YsNqeW5CfXd22PMP3pA9URagPGbpBR1DKfgZ8DJl9acyIyATCX?=
 =?us-ascii?Q?tmsYrFltJ+zUTTkd+0JzQOoEXMxEGnZAr15XWF0DYzQYjj+Kmj41Zh+R6c4+?=
 =?us-ascii?Q?PWiEj67EtwnuBoUPafyrSaN1WACUhFw6Ln+DJXDPAiqBPta9oOjgu9muVDAX?=
 =?us-ascii?Q?gXLXSFkvOyo12FH8az1EPN6FjgIhhG3IWzdvgL04w1suc6+hNaZKMNOOUGyv?=
 =?us-ascii?Q?Cir/5+e6aElXyZ/z2eTs2gt/3GlXjIDExrwB+vqPV2/zsjYmjBXtjrX88NQu?=
 =?us-ascii?Q?0p8+4V7pVtlt3IujB6CswHz9TyyNJvASvv5uM8jeWPLSHwz+NrWhH1XYbL8S?=
 =?us-ascii?Q?sEHvhz0hXel4Pq5VTwFXsdUZTxf/kveplwOw8KeiNNy+zFmUCMoNIdxH0JT/?=
 =?us-ascii?Q?nJGfNEtVcs825dbSEo3FRiUko49cF+mXC9FEYQfudK5e7asQ+yIRujfbdF8x?=
 =?us-ascii?Q?0VdDV1oC1Yg/OY54xClHTpLHuDK9D9pWXW10/fbMN07lBBZ0N2aHOWf1PdD+?=
 =?us-ascii?Q?58/fT2us9X2R5+/ujd69hbpGD4GFPz6XBEVGCQKel0gXb7lr+pckBuMhaN/7?=
 =?us-ascii?Q?8+OyiQx/yHj42b9dGDXZj1lSPu4MMqJKhEXzpZl3Y4U3J3OfDW91dLgCgUyU?=
 =?us-ascii?Q?+DYORXpC1gSK1NBnpT67rfJZKP+DV8HYgsxY7fdRlyPL4Q5EfV6QB8YKW0ct?=
 =?us-ascii?Q?AwiuXqTEjezl2MiqJNJ+pr7CFeZtzUxg6+xNy2RSPk/q7y6RbUXVIZOTLmVj?=
 =?us-ascii?Q?gIKtLPPrNpylmichISRIaXwk8u1BB46qqrI9khHN?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3071.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fd4baf-83d8-4b49-db84-08dc7f52c38e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 20:14:22.4272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sZIpYfPDBNai1WTZj4GjlfV9YUSaa/n+yxCZDrteOaS8B+xiqwalirgA9iGJ3nj6lYU+0MKpNVvMrLMUDS200g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1434

> Subject: [PATCH rdma-next 2/2] RDMA/mana_ib: extend query device
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Fill in properties of the ib device.
> Order the assignment in the order of fields in the struct ib_device_attr.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/main.c    | 19 ++++++++++++++++---
>  drivers/infiniband/hw/mana/mana_ib.h |  5 +++++
>  2 files changed, 21 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/main.c
> b/drivers/infiniband/hw/mana/main.c
> index 2a41135..814a61e 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -547,14 +547,27 @@ int mana_ib_query_device(struct ib_device *ibdev,
> struct ib_device_attr *props,
>  	struct mana_ib_dev *dev =3D container_of(ibdev,
>  			struct mana_ib_dev, ib_dev);
>=20
> +	memset(props, 0, sizeof(*props));
> +	props->max_mr_size =3D MANA_IB_MAX_MR_SIZE;
> +	props->page_size_cap =3D PAGE_SZ_BM;
>  	props->max_qp =3D dev->adapter_caps.max_qp_count;
>  	props->max_qp_wr =3D dev->adapter_caps.max_qp_wr;
> +	props->device_cap_flags =3D IB_DEVICE_RC_RNR_NAK_GEN;
> +	props->max_send_sge =3D dev->adapter_caps.max_send_sge_count;
> +	props->max_recv_sge =3D dev->adapter_caps.max_recv_sge_count;
> +	props->max_sge_rd =3D dev->adapter_caps.max_recv_sge_count;
>  	props->max_cq =3D dev->adapter_caps.max_cq_count;
>  	props->max_cqe =3D dev->adapter_caps.max_qp_wr;
>  	props->max_mr =3D dev->adapter_caps.max_mr_count;
> -	props->max_mr_size =3D MANA_IB_MAX_MR_SIZE;
> -	props->max_send_sge =3D dev->adapter_caps.max_send_sge_count;
> -	props->max_recv_sge =3D dev->adapter_caps.max_recv_sge_count;
> +	props->max_pd =3D dev->adapter_caps.max_pd_count;
> +	props->max_qp_rd_atom =3D dev->adapter_caps.max_inbound_read_limit;
> +	props->max_res_rd_atom =3D props->max_qp_rd_atom * props->max_qp;
> +	props->max_qp_init_rd_atom =3D dev-
> >adapter_caps.max_outbound_read_limit;
> +	props->atomic_cap =3D IB_ATOMIC_NONE;
> +	props->masked_atomic_cap =3D IB_ATOMIC_NONE;
> +	props->max_ah =3D INT_MAX;
> +	props->max_pkeys =3D 1;
> +	props->local_ca_ack_delay =3D MANA_CA_ACK_DELAY;
>=20
>  	return 0;
>  }
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index 68c3b4f..1348bfb 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -27,6 +27,11 @@
>   */
>  #define MANA_IB_MAX_MR		0xFFFFFFu
>=20
> +/*
> + * The CA timeout is approx. 260ms
> + */
> +#define MANA_CA_ACK_DELAY	16

Looks good. But can you add a comment on where 16 is coming from 260ms?

