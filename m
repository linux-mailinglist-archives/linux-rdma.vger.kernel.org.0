Return-Path: <linux-rdma+bounces-2039-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3085D8AFCF5
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 01:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37921F22063
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 23:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B154502B;
	Tue, 23 Apr 2024 23:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SblkR8Wm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11020002.outbound.protection.outlook.com [52.101.85.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D91838DC0;
	Tue, 23 Apr 2024 23:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713916679; cv=fail; b=ufXq4hBPlQUXgGmylfd9wQMKtKKDX872RaoxNi84gdF4/Jx3XAkVOM8Uh/wl4CX7DuWcdCkb/sSfiGQIa/AdyG5t3BB5eF2M1s2jQ5zy16kTgptmegu+mSt4icuVFekI4zQ17OLPURZobf3ChuGOmzKmO/SGqxROYCN8To5imVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713916679; c=relaxed/simple;
	bh=W7Ls7+ddgzyjC6Gue6pKxFXyAD4zD7S1prIkBpzXfoY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k+kOM3zgDLarXWXNTijjWI/93FU0bcwZFn4EZJFNE+47wMrotl+1/uJrusmzjG5/G2beoDCL4YyIvIz8usUywNGtzPwxXIpAmPpQ27brSv1ePZfgAZIxiv5oqJ3pxo9VnL4SR+lvHx0+If61ibrvpTVwR04PvETOqjvJ7Nozpao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=SblkR8Wm; arc=fail smtp.client-ip=52.101.85.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=immVHj4j8vCujXmI6grun8gweX6JKO/dAaHNmsVYu31W1rHpUKs/d1phUHKF+54B+kBKeQHE+BOlLP2Jyl1UI51izM3lhitK+Dbg0sRvJ77KnRptSYV2Q7egwkiTo6D8KhXuBbmjC9HFOxN40Cqw9x/nkMdwAHBYvFsB7qDSf/TaFVhdraVEWWOvfdEKeBu+8mXfAmH2fSw9bCS81MIl09C8d9RrnkVSkqdCERLVGyB7QaIPDHbOdDdfCnWG8gD3R228ucRwGRKFwHVUN9ELW1iNkbPMMA8A/Ww6bomh/fPlFTNHPDKouGiA++ZMpQv6yjPJzLJrg/XbgkTQBQpaiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mS6Lp3cYfhlAJ4w8Eg+7NQP5yzgd4sVuqm/1HhCOW4=;
 b=deY9aVAcQOGuPjMtyUEq2d2h733tZv+kJzcdyMikTVwkJ6DFjhUbrFsb1XmWMsI4/DBKr9cRVGP27ajddlGRGpgPZAqYvaMCfcIIRHLUKTvrLw6cSgS89ZBjXEsqe8EWY3pMOY7D7u6E7OZzKalzRafCwsWuRZbMSEZvIvaT50TBmg4T6b2hisrRYDJI7rCI+RJeByIHXtNrq+yacnlUzun1LBo/uMpDk12yyoajexwHyqF48rsnBaiQ0bVRiM7DLCtKc3hcl5hoq9FddGiiH4J4fMtYTSkMkOgBU8kWRVePEf3sajWnoah0sBF8qV6veg3FUXRZne6iHGI8mvW07w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mS6Lp3cYfhlAJ4w8Eg+7NQP5yzgd4sVuqm/1HhCOW4=;
 b=SblkR8Wmd4qoZ5QueTD6HDfxKxbT4tcpBHTcGBZ41bKuCsKYSkPDPvr8ANAq3Wrvz5JDlXEEiV3nOSKcli4U7dJHqPdRvkMBJWe3nbZeCTx/N3KOTrpgY2m+hWoL+9SSyWv1ugX12tQkK77yYeg3AkykNosC9G9pxKt1vWjL7KY=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by MN0PR21MB3147.namprd21.prod.outlook.com (2603:10b6:208:37b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.8; Tue, 23 Apr
 2024 23:57:54 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb%4]) with mapi id 15.20.7544.006; Tue, 23 Apr 2024
 23:57:54 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 6/6] RDMA/mana_ib: implement uapi for creation
 of rnic cq
Thread-Topic: [PATCH rdma-next 6/6] RDMA/mana_ib: implement uapi for creation
 of rnic cq
Thread-Index: AQHakbDGWN5xsg9n8kSPf5nVicOxXrF2jxXQ
Date: Tue, 23 Apr 2024 23:57:53 +0000
Message-ID:
 <SJ1PR21MB345775858C05B9FE51C2BDF0CE112@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
 <1713459125-14914-7-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1713459125-14914-7-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5704f1bb-46ac-4df3-a9e4-eec64585a9c6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-23T23:52:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|MN0PR21MB3147:EE_
x-ms-office365-filtering-correlation-id: 14fe2238-3cf0-4804-b885-08dc63f130e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1f3M3Y7PH4FRjreIBGmMdbZauGcofwa087s58VTJobXCZXtkNY4Jeu5VEOFB?=
 =?us-ascii?Q?Hg9gGstvaTIe23Wl3KdxKFlaCrHbdPnZA1A1Zl/9LQ0TDcpFyal96buIxZP2?=
 =?us-ascii?Q?0LdqS3LS/Lfe7hcDL5dVRP7GTnj5vC1IQExUBTHPIz8Zm5iGzEFpb1dJsWp0?=
 =?us-ascii?Q?91eFo/saTdUyAM+6o/yOLGCA6Jbsfr0C03WwlMhDI8UZujpAYcLEnDg4PFRy?=
 =?us-ascii?Q?UogQ16E1OvAj0Lb2GfYT93Ni16bkwjgMFbjTvIRDiYXECjPqC3w8Abz/JdUX?=
 =?us-ascii?Q?r47RR1iKu2UUMFAQZB6j9r2rYWVvZKCP1zCoJ/vU6SM/EcBvTDLHhzcvKFtK?=
 =?us-ascii?Q?Dw/MmKc09jA1ztpHpPUAEvrqF+BK531by7GGD9a2WGS3aoIrBfeZWDxzks5o?=
 =?us-ascii?Q?QQMKZ5vUpQk3J8M7/lVJVhxNR6LsL+zdoPRx1/4wIxgtJMCKXYC2UW9i1F9I?=
 =?us-ascii?Q?nV5EeTgJkdsOv7GyHYsbIqrfEcQRQX2ey2RP3rzSXN5OM03Tlz9P1EjhY/GD?=
 =?us-ascii?Q?iOTgPJak5IbdBsyfFpUYRUy0x8G73yEiHf8zRejBaM1XlOnv6SF4Qq2dsr2r?=
 =?us-ascii?Q?CFR85s9G8Hk5lVILAUU/1lq9FvC/4L1MOSdIUUb+sihgkdNAERz7VybRIhSW?=
 =?us-ascii?Q?+Hem4Cuhjc1YDG7EHEb9hJhY8udRxveb4vYxOVRV/zdt/vnwODLmZYkCufwZ?=
 =?us-ascii?Q?VzpEIJZBlYEng3xyLoR3efEU0+6aEe1JtVWHtN8ySRr2uq7x1mK7mCU7kXSm?=
 =?us-ascii?Q?oDO2L5GscuDMO9k/BwOXN32gkzlzUvq5W252gly3gzfASKNWpWCb4VLAYXxX?=
 =?us-ascii?Q?0TSnhT6CiU2IAo35z9SU20OO2d1ZwvfRRSDgBoDDtwR71ohNgFycLkkNSA9l?=
 =?us-ascii?Q?4fN6Q7M6fCP6uK3vkm6NCDz15bJpcY5duJpmnBhZgJYz/UewciLPhMHXBnCc?=
 =?us-ascii?Q?6Bta2RKurFUExPiFREt1nznn/Zl3QNizCtOocHOZaJ9k7HxamXzOdz0IGlve?=
 =?us-ascii?Q?9F3qCsuRe4q/LLRNfn6O+rd/3nvHRhOE2bVMe3NkhSFykaxo1wYqlFXx7coW?=
 =?us-ascii?Q?mGLhzi+axCfIzVzW+8ti1ed8CobihRwFSmeYrHoRjxDNB1Lh8MIKY+6k9fDk?=
 =?us-ascii?Q?eIcufL3rsHecV5rwIvQn9PkkquH945LJ4NARCoyUhUtunE7AdWIa4cMUng2R?=
 =?us-ascii?Q?2EdfGtxCsXvP4gLJG67aAqtqmyIvYy0JDmj6kYjwY0uS54Hwpc51SkjbYN+W?=
 =?us-ascii?Q?+JHgi8iMIVsvbBm3/IhjsCes92mL7ruU3wso2w8cfvEwdyQMST/kJboesige?=
 =?us-ascii?Q?PhwtC4xj7DrG1YCyat1VsbhKHE4SQTPqzaOAY88dDGSieQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5mqmNxs5JToV/59kN/Guz3S6Ba3l61BbLYQ6DlnqQBKTrUDiyO+vKE36LIgU?=
 =?us-ascii?Q?wzAxwvKtyhvlezpYC0dze1lZscfhDldudVDqITqxuZrhHDRXGZk6i4fjkl7Z?=
 =?us-ascii?Q?teHI8bJHHEyT94xQ0Oud5+3yT9eEDw0aJCvWSUs36XoECDQ0owWhIL/dQNeN?=
 =?us-ascii?Q?kxqTTuimtClkCJcth2W9OewCORvLieLY550oCtPaK8oc854XupoyEY7h5Q80?=
 =?us-ascii?Q?GJ6WIOaJrHZslOyjVA1+464nO5H7KO6CKYKDF4Yy0LSPQLA8SghTGmrUURT8?=
 =?us-ascii?Q?rn5WLG7rLisfvSbSV1N/i6l/rBf6d2zpcWCABJmOiT2LIeapaV7O603mqzD4?=
 =?us-ascii?Q?8kfBbC02lwCCpb4ZOxULQcdEuKSSc96EDYpj6jE2DO6G6hXnZpVXhR3dNdeX?=
 =?us-ascii?Q?zjDM0nfD+ZMnM4Dsb6ARA7YwRE+F1+T2BvOMnhBGst5nr4bah/PK3XvEF7y8?=
 =?us-ascii?Q?xVsly1bxBJg1rzXxrG+E7ePDgVL/TDJ0LebpR3COU5VsKhPQNLeiKeK9inb9?=
 =?us-ascii?Q?n/biHu1QkqEpfqlJ0hjItc+93Wbx5+IAIcKxbja4FYSPt4QIkbT1HkbWoM7U?=
 =?us-ascii?Q?VBTZcQatbgbximgDMC3NuCyxrwaqtfHgkwVHlLfrEcIygOoPSUzFHzcMalVh?=
 =?us-ascii?Q?i6bA0LUegmby1JCsbECKCBbnWwm6r1itY4EOBt/MLBZUQb46b7taxv1E4hjx?=
 =?us-ascii?Q?o6OKIrwKPBbVcUM9vwcYB+ilTd+af7Pu9Aa+5VR/Lb9cY/Xo08bgHsH2T3cz?=
 =?us-ascii?Q?vd5KjEoWyDe1kzHRWgEydQK541kxcrLe6ZfxzRxj+duTsrcP1akkgAs+4AL/?=
 =?us-ascii?Q?KDUa/SfAMyslNFvWziNTlMp2tf4gz2GEUFHYqX00nhsy0UvzNkQrQkYA/SRf?=
 =?us-ascii?Q?oGWJW7OoBLAYolrnJTKs0wC3xctnNVDGg+KOVZzXpajAdgK4nwwxReKQ/K2K?=
 =?us-ascii?Q?Q3Lck8ys5VqJDrS4yUJrAVmfLFHnbIRTe90wW9j/5ITmAvDx1nIs6hkyN7Wz?=
 =?us-ascii?Q?b3SU5R/T8Hz7jZT4KDIpgwLw1OQt1DN5Zx0NUjnE1FCDJAcoy1pIQ0HjC+aV?=
 =?us-ascii?Q?eaNn2IGJHfTG21r0HnqDByXWcNxKgUcH+wizbmoiUKiZFDkZ2tlhuifOtxy+?=
 =?us-ascii?Q?/9/IMXr2xgplXxqyTKbKhXGG0L8fSKJb5KQc4CBqCJe/iF9MimIWa3Iw8j6x?=
 =?us-ascii?Q?Z3lnfkbDJQbfvS08rzd9JoyoUoB7F9R9oTsg3OdLTqwBWTOHPIYSuAA5481O?=
 =?us-ascii?Q?VtiOdcrZEjg+/Sns3up2C9dm+iZAOF51h7jz+QwdE7RCD4/2IZIUokAoUvhA?=
 =?us-ascii?Q?0lC/+tsfAY7FXUXfmaHlWpjV+gNP8vFnGEP8CXfkRfO+KfTk3ViYu6RZqSiF?=
 =?us-ascii?Q?GBJYQIvisypo91tiwKa2nxzOSutkMwdy8B6ZC9gRki1tfdCT8aW8AP3Jfee7?=
 =?us-ascii?Q?cOJFURsBsU9Wi+/uQRsm4W9FgdGGYDg3V0wfATSe2ncYSOmocXQsHYIbSa7P?=
 =?us-ascii?Q?665JVXFYb6EQVAS71EUMltAS6MAhm2x8Rj7l9tebS4VLM3OoqWpAB+H8lsdI?=
 =?us-ascii?Q?MxpK/MGhBJmKPEvL6DJB83DOUdP2LPyuDBpXehESUq6g8akgqLiU+F/i/vyP?=
 =?us-ascii?Q?Aww50MuYFQ6awZE951wHgWfBrJDoumWJeUgcKSssIuh4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fe2238-3cf0-4804-b885-08dc63f130e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 23:57:53.8564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ra+vb6gKdzGogYosxyUl4HLUhdm68Z9Eg2Ml5JMVlsnIaRk0o3/03XPHdrMCjxJTSo2JURfx/vyuTbWPXfhmfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3147

> Subject: [PATCH rdma-next 6/6] RDMA/mana_ib: implement uapi for creation
> of rnic cq
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Enable users to create RNIC CQs.
> With the previous request size, an ethernet CQ is created.
> Use the cq_buf_size from the user to create an RNIC CQ and return its ID.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/cq.c | 56 ++++++++++++++++++++++++++++++---
>  include/uapi/rdma/mana-abi.h    |  7 +++++
>  2 files changed, 59 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/cq.c
> b/drivers/infiniband/hw/mana/cq.c index 8323085..a62bda7 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -9,17 +9,25 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>  		      struct ib_udata *udata)
>  {
>  	struct mana_ib_cq *cq =3D container_of(ibcq, struct mana_ib_cq, ibcq);
> +	struct mana_ib_create_cq_resp resp =3D {};
> +	struct mana_ib_ucontext *mana_ucontext;
>  	struct ib_device *ibdev =3D ibcq->device;
>  	struct mana_ib_create_cq ucmd =3D {};
>  	struct mana_ib_dev *mdev;
> +	bool is_rnic_cq =3D true;
> +	u32 doorbell;
>  	int err;
>=20
>  	mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
>=20
> -	if (udata->inlen < sizeof(ucmd))
> +	cq->comp_vector =3D attr->comp_vector % ibdev->num_comp_vectors;
> +	cq->cq_handle =3D INVALID_MANA_HANDLE;
> +
> +	if (udata->inlen < offsetof(struct mana_ib_create_cq, cq_buf_size))
>  		return -EINVAL;
>=20
> -	cq->comp_vector =3D attr->comp_vector % ibdev->num_comp_vectors;
> +	if (udata->inlen =3D=3D offsetof(struct mana_ib_create_cq, cq_buf_size)=
)
> +		is_rnic_cq =3D false;

I think it's okay with checking on offset in uapi message to decide if this=
 is a newer/updated RNIC uverb.

But increasing MANA_IB_UVERBS_ABI_VERSION may make the code simpler. I have=
 a feeling that you may need to increase it anyway, because a new uapi mess=
age "mana_ib_create_cq_resp" is introduced.

Jason or Leon may have a better idea on this.


