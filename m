Return-Path: <linux-rdma+bounces-7991-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C921DA4011D
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 21:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607A71707EA
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 20:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A1A254B17;
	Fri, 21 Feb 2025 20:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Xpv5bxvI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020087.outbound.protection.outlook.com [40.93.198.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E1C254AF6;
	Fri, 21 Feb 2025 20:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740170088; cv=fail; b=i6Ujd3jKJ13NyE9w8Ceq2qHru++yVaq601c5dsbrkGmzN9HBImI6cZnUu5dpbKoAQ3MLSxfNo/4CzfTnqcslWNBWQ72TRtzBRrn0TBfXse9ffY9I/uMlVF5aHM79l25R9AcX43gGRu4/oPjx/Immgc465JgBCqKPgtTW8Szv3tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740170088; c=relaxed/simple;
	bh=TV5eDWzrRodHTVgikpvQwhi/f/mMZGRw06+XwSgKFuU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SkBi8SUB9thL9Yt3nuMQmItsjCF2gH7iCWnenlGSwvXXuRQYMnfFXvvuWadzMmJORc52Jd+z5XnZDKdpIwphHtW87ZftQUo0oVtZseFZEjrzenjme/kywVeXFyz+H8o/BsedZ2b/SY7zdev9M2hDSjTsc0CIB8GrT0GW00hz+AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Xpv5bxvI; arc=fail smtp.client-ip=40.93.198.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwq/nXkIboc503ELWBtPake4+wJf77W1oeGSkQQgG5qZ48aBKs1E/PwRKDtGDKEbWyfJ/mGehsxklDT/8QzC7qnDPMAujbWUuROXPQlaq2cOO7VyUrEkMqCPlQcgZcUmI/6EtxbW32IxqTXbB4PtouG/Bsh9oKXGpeO01WiSR3cRJmoFX53sQII8CbfeWdrtg6jkmJGnyJkpN8jv53T5gGkBmT2xtyOKvXkyIrQDKDC2Z/ueXZxF2zE3gVVp/81vTMIEbRqCmuV5Pxt5MNi4n80vPsFD2fZhAgr8hIxgE2DWyGW7JcxCgpKWa5M7R/XtxtbJmAWf2kt1g37HVpPAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chun3cK4KSsrZKWkUkzYKZwrMgOTK8i7R5jO9MwCSpQ=;
 b=prkCcHW6bAXdseyAvN09kAid81HzbtO2WehpkAfzElNfTtEbFMmjvctYSqet3VlyNybIGikAn4sDyes000tzjbEPS+v0klJl609ypVbC4V3oYWJKK2YCgGtQ17HMUcAj3X8g+ZE+t+cPeLCnH+iFi1xvqDpjC7LSBdQCs8ApLYWofAg5kxPy/pwAnwBFHxqoF4Sp/EneuWLwe5O3nKaVQE4c8LknnENB/D9oAC6arP8oJjbEWB3YrdZaC0AMc8WSaPE5yxY1UO6Fbl6N+Zh+10xOIVa4gPKCqgduY+LN+C0Y7VLx476wXFbRs/cFauDQ0C7b1EjHTp5ISsmphhPnsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chun3cK4KSsrZKWkUkzYKZwrMgOTK8i7R5jO9MwCSpQ=;
 b=Xpv5bxvIeT/Nh9ehrjSPvgTU3GAlA3SsTAPrVhuk+AL3gx8VyKBeqKrfZuSAHq/HIflORQAPcMpQkempBiNBOOJ863KT6AXXkqDELjy3zJMqaTOlTsr/ZkzKOKAmqARF1q5S0UuuWclYmxhVUb+HF2tMpsgQg6cgLpsL+CFIq0w=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA1PR21MB2067.namprd21.prod.outlook.com (2603:10b6:806:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.9; Fri, 21 Feb
 2025 20:34:43 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8489.010; Fri, 21 Feb 2025
 20:34:43 +0000
From: Long Li <longli@microsoft.com>
To: Kees Bakker <kees@ijzerbout.nl>, Konstantin Taranov
	<kotaranov@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH] RDMA/mana_ib: Ensure variable err is
 initialized
Thread-Topic: [EXTERNAL] [PATCH] RDMA/mana_ib: Ensure variable err is
 initialized
Thread-Index: AQHbhJr/8Lryl8mBg0+HEUlqi4JsJLNSNp7Q
Date: Fri, 21 Feb 2025 20:34:43 +0000
Message-ID:
 <SA6PR21MB4231810186481AF0A68AAC6ECEC72@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <20250221195833.7516C16290A@bout3.ijzerbout.nl>
In-Reply-To: <20250221195833.7516C16290A@bout3.ijzerbout.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b66b7baf-60e6-4867-96e4-0a8946a7d9d2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-02-21T20:33:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA1PR21MB2067:EE_
x-ms-office365-filtering-correlation-id: c4b4b409-1d56-4bfb-8e67-08dd52b72c87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Kh0jTzh6rPsjsKVbhmYPNEpd0u22fs/7YAfOXIa0thjRq0zBu1tLY9wvORbg?=
 =?us-ascii?Q?pszLQ9BEwVumLg+IySMkp1LJheIxrjTKmlVpoxYbDmOvC5GoLQ6u5MJsm06w?=
 =?us-ascii?Q?YAWZYgV9eTgbHyCuJ60Enxnj8vHbtepNFbqq67262diWEZYkr1p/k0Mj2xLp?=
 =?us-ascii?Q?bLVs5noF4lYhbauZS41tTv9F6glnOu1hVNTJXtvarlJU+Hkwclui0csNIMed?=
 =?us-ascii?Q?MVkT+fFYaMxZIHxjMzn++/57LeOd+kliCZG8FccEPs5c/1bscPH+sRf+M0TM?=
 =?us-ascii?Q?PAPDTCNcds5vAdN25bBioP1SnnqSga41Dni5kF8F/gFxtMpJT2BbNHfnRLhB?=
 =?us-ascii?Q?D/UV7tWxHFjfGlCn6sEXRUFvZi7RCphCdeYUTTxYc+UZ0Dk26bvR4C0pudff?=
 =?us-ascii?Q?EGVC0iIZ3UZXwp6h2tw7TxMJiwqLu50afnYwQe6htNDbGlek4ZaCKQW5RaEc?=
 =?us-ascii?Q?Pu3l7ng/5IUiZgLaY+/8B7xXsBwYmyld5xR3hBZ2jbXogdMf96ResR5zPNT/?=
 =?us-ascii?Q?Rp1BeAincVnpWAH/MP6oNW8tJQmP6YpfR7MQLXyO6/f38KTKOpPo3mLjvmpM?=
 =?us-ascii?Q?wK4hga+NubtFO8k50H4rO1rs/6qHzaipUYBIH7t3SThAFQeNVF/AlXDL5WUV?=
 =?us-ascii?Q?sUNuzJ4EEmtzjoP0FQMAMkxIMiyuHvxH20rO5t/7kDzR1hBtk3TOsdEnOsD0?=
 =?us-ascii?Q?o9gvdmL5z8ArHz5vNaa4zR0zlkh4FLURaDaYvpU+/e9+fWxbDjRgtMRBx1Tj?=
 =?us-ascii?Q?JhxTptw8kr30iW6rfQUbylkBz45PKXqnapO18Zgl7PDO2tug3tSJtmD55KtQ?=
 =?us-ascii?Q?cC6uTj46uQnN7sVniVxnYeogV8eoNnGBQTDx0i7PwtSpJsVi0gr2gclVfEdn?=
 =?us-ascii?Q?ICgKVkO+FxJODYhw9TnI+kiGKrSbnE8b7CYlxqfUSBXTmJRWIUage7PPjgiA?=
 =?us-ascii?Q?WxEEU9UJ1Ul2s8U10R0z7hVNK2ndRGY7fLoYKaydgivHsvWni290eVCHhIWH?=
 =?us-ascii?Q?fj6gTde+qZLx8LTYgRdMai1FoclnWHZO8yAePPgPqWunPG4DrSVukaf8X9n6?=
 =?us-ascii?Q?DYg/0I3wqIG6jQIOmmbXs9SubPHDcH1WF1hOLSE7Hy3dRf+IvDMgWKaOuET9?=
 =?us-ascii?Q?JbusGOhpfS3CJ8kWyrUTBBaPdnRRomWpMU8Kitu2VIbXk8OI2Hlfm2RWbM5s?=
 =?us-ascii?Q?JujhlPEu7ZkTREch9AoQIqPalpmTLRPv8W1wh/DBgJAUEKI71SH2ANms1Jcb?=
 =?us-ascii?Q?WDJPTaDSyL4oS9Gp5Ck6H8TFIja1/Yz+8m3Hta9Cvtr2DkLhjP9f+wXWBtPX?=
 =?us-ascii?Q?qzKd6MsjnUVChWs/rkbIFmavmQV4ihnn3iDJeRdlGJUNKqx1704NBffQyOhR?=
 =?us-ascii?Q?29hUmozuvdWwEDrCGWSXL1cpBl6HcwVVhq8WXIYNnRXXJy/5tgYQKvnwK1JZ?=
 =?us-ascii?Q?1U3lSpBKLimstC3sBJvV89ZHN6+yqXg8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ftqtr0hjVol0XtZTLpcRigqK4+sE7fL3yuqb6jgqIPTFFlixdgb7ZmVV59Y3?=
 =?us-ascii?Q?1PUYnzfFThMV1LCfagu9yhQ9PBLf/TaorNVfZOgMQMYz+p4ABwgIK2sS/Tgh?=
 =?us-ascii?Q?Q3BrpPsyhM0Jj3ZGc2MMmuQ/iGnuVmsJxCl9xmW1cTbUrXkMGULG2yTpvwnn?=
 =?us-ascii?Q?iHEcft0wzUToJffr+8ZLqRgX/17onkRH6tiu2Pux6fUoyTVFSNXf6UWEVPSe?=
 =?us-ascii?Q?mltr0/0PpqxQKwF6MUiihfXzYs7Untb3uDBSphkbfaIB1TmnXY5H0hpFccam?=
 =?us-ascii?Q?EyucZN4NBH+nsGcw0A920oU+IlmjM0WTWDXOzejnZ19dDifjQj5DtIZiiIqg?=
 =?us-ascii?Q?Ving2RW8/wds7nd9SxXdfgo0QE9Y8ZpPMHJzDo9w0+nHVl8k7qfApngu3hDn?=
 =?us-ascii?Q?7oo4g3ro1bvySdv4KJNyBuQAYFPN75oM05wL1Z1DXTZ35iI28zpZ9iFvm5g7?=
 =?us-ascii?Q?UhXruvnHn2iJY1dSiSXrH6crl5CenSMsBzENU7kkmKouGIoTmVR8LmrSguzb?=
 =?us-ascii?Q?QMHdAqYz/7OXZyTJrzaRITBtMWI3hJIbshSaL/ByHPofpq24l/vwuX1LIYzz?=
 =?us-ascii?Q?/QefBHyZazOq7gvUbtXOKNWfs8F/eGmYdrBd0w1gKkKPh1CsOu9lGFyDh3Tf?=
 =?us-ascii?Q?AqCk2tTsnGas1msruYJ9HW8usOW7xaewHVXKHFyjUOA75MNUFBmOkeKU3p8r?=
 =?us-ascii?Q?oGm6mVYNkeLdWImBemH+KlSpleN7UjB/fjAAb0AiGV4qt7ae6qStZiNd4eCD?=
 =?us-ascii?Q?7lKIET76WaMwTbtgQcc1ybImEqm0EDZK5ARJ1pnnO0CjiqfKCMBFCF8tYJ9b?=
 =?us-ascii?Q?PH+bTS4RCmqvU51B5j9JtiFGIYMT24jOaFaM4GdG9dPyXuURhW6dris1TjwA?=
 =?us-ascii?Q?IL8kB0+CvxHHnaJKHe8/aDePYHUVDzcYi93GzKfEIx4NEd4XeiQjs2zEmycX?=
 =?us-ascii?Q?siqqQASeZmRZVC9sQZjAf5gsM05Hhd1JA2Q7cQceUdL7eGzqYQCeh6K8RlQs?=
 =?us-ascii?Q?7x1izRE7oO3HiWtNjM9TzylaE+EJfu5LVb7qs1R91ylHaNPD9ZeJ24WlUKzV?=
 =?us-ascii?Q?GLlg7M2sgj2de2Wa4gviO1Y7dp8wILGqhri61iHNr4sT7yAGblb1T1hUxQEm?=
 =?us-ascii?Q?/KU+IYw1EOPiYH0ZyhnDd4Snz1/9HzAhB+deXE1MWUiqac6VUcRZL2Rp8B5+?=
 =?us-ascii?Q?Wf4gtPGkVIjngHRo14YyviZqhNT1hDX4yOOcry7geXoeR+ZnlfpmY6coRfHH?=
 =?us-ascii?Q?6ImHzwFFRMiRSwjIKexS31MOdHM3BWxFwkBjNUuT2m+OmmEq3sZcmGlcQ5qr?=
 =?us-ascii?Q?JJR0ai1tzTjHcKOEu3ThrD69y0lsdrjIOU1CuMeLhT74DMcGCZ3aXgleRVAE?=
 =?us-ascii?Q?6BWkt8kzJX/gS+53LJc/dZTYlDhFlLlnLIanyAsPRkIRKZ8DoO1IML77svw+?=
 =?us-ascii?Q?nGrRaZFptrTwZ8XOzYZdXyCX8LCJwNAz9t2Frass2nQ+b/CpykxS12XF/dky?=
 =?us-ascii?Q?eRPdm0Zo32XywWjlVhG3eOIz4Bonyv8mFDEheUpmlJ6q13UPqndrI6UaGNzk?=
 =?us-ascii?Q?ENUFatNi6EdFT9HCNddo1jMQ30Qnt2BMV4vNg5VwaGGd8AoiKHRUskU78F6c?=
 =?us-ascii?Q?6i76sVL6zVSY/nusb541WoOjFAJd7BcUH5JIVPAk3Rgr?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b4b409-1d56-4bfb-8e67-08dd52b72c87
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 20:34:43.6011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P2ahIzyd+xEdoeZcLn2wXw5J8+3I2PUuXWyHhFjGjYvwrVWsA6m6i7A7+ATLjkKJ+v8ND9SXgU9OdtNogqNRXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB2067

> Subject: [EXTERNAL] [PATCH] RDMA/mana_ib: Ensure variable err is initiali=
zed
>=20
> [Some people who received this message don't often get email from
> kees@ijzerbout.nl. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> In the function mana_ib_gd_create_dma_region if there are no dma blocks t=
o
> process the variable `err` remains uninitialized.
>=20
> Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure
> Network Adapter")
> Signed-off-by: Kees Bakker <kees@ijzerbout.nl>

I think it's an impossible condition, but the patch looks good to me.

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/main.c
> b/drivers/infiniband/hw/mana/main.c
> index 114ca8c509ce..eda9c5b971de 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -384,7 +384,7 @@ static int mana_ib_gd_create_dma_region(struct
> mana_ib_dev *dev, struct ib_umem
>         unsigned int tail =3D 0;
>         u64 *page_addr_list;
>         void *request_buf;
> -       int err;
> +       int err =3D 0;
>=20
>         gc =3D mdev_to_gc(dev);
>         hwc =3D gc->hwc.driver_data;
> --
> 2.48.1


