Return-Path: <linux-rdma+bounces-8438-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2769A557C4
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 21:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFD53A3CCB
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 20:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B6020764E;
	Thu,  6 Mar 2025 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WwEsmkzc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021121.outbound.protection.outlook.com [52.101.57.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732B8206F16;
	Thu,  6 Mar 2025 20:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294224; cv=fail; b=R0342tRfw/UppZxyMSE122aq2DaJNoNXfLre6+V5ycMrt8RsSZY4lTMCVOD4Td6Epwwf8n0FmOky+Li/AuDXY/jPpUx56La6rfZYGWbKBBfv5vIaecbk07NsM4cjQ6Gm1sF4y7tZ1rRB4nqtOPcMvFqhhit5IR5koNtUTNwwky4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294224; c=relaxed/simple;
	bh=L+TYoJKpcjcxMgQpcjWVr4R7ebdf2HHzCwqw/S1H28U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cs9EaI/3vASo3FYU1TRzbDCxR78J3CD++ZS+t7bj9rIegpKcmofbXn2ewl6O8tx//oA6FtTDjIxkCiZAWr5OaO8FQaI2N0W0Dgv3OnYul9D6bjPhHfiNEnsSIDC2l2ZOK+FO3wASi2JvVPYoFGzF8NwiZn/MHzMugPRJSne415U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=WwEsmkzc; arc=fail smtp.client-ip=52.101.57.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dxwh3gz2Div8ywVpTkpneCu0BVpT0va8aF2wjwBwjjiDl/rM2NnVvFOQ/Kvd4/zxOipPjXcjZrbOjz9LK7lyq/QAzTVSfQyRBmiPIARQNE07YtkRNf2Sue1q51XyF3FtTTV71YDmq24lNeYsPNkU9t5cA3s9EqkyZOgPL0fjQbH4640UszpQeMJk68ufC7zDz1NbeRKA7yjQlkQa5PlKd/aG9av47vRQzZkhaVP8OWuNiAnX5etKM2ifrPOcg1vGuc1wYxsWfHfW0VI8FA7TADl67rK8YNR/Pk7DCcTJswn4BXs1czi5dyR7i/ALGNbTIQw2DIBSf7m1QY4LfaReKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBYfB109Rkhc2rsAZjJE3j1KzMsxYXDghgh8iOPbrwI=;
 b=CJLqCMzsGh4HKUfGQqx52mTjdUDtnllgmpEhGbvRtP/G0fQH4jUdQVolu/5Ev0iSWwkYSO9AFtFdBZEHW7mNu32girYZi45yIGlnRBYbm2bQuzy6G0XD/z/k6NsSGAq+T5HPSEsQq+qHJ9v8Din6wyi9BlctKE70vYtUvf/YeK591E+bvV4/dwlg6m6rnouyjVndhdoUtCHtzjbf3H3Ku6XxG2A0FaN61LxFSgI/SQSHJpPQtan0HMVw+/3QEh7sCTwEeRtF523C4COYPEeWjawgQF+vHG7SoCmn1s0l6bDEVkhQNBWPIYC/5YNmFy9F55nWzW1Hni3K/XDh1OaJHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBYfB109Rkhc2rsAZjJE3j1KzMsxYXDghgh8iOPbrwI=;
 b=WwEsmkzc7hsCEAKDvJiGXgIIXhPS3+0B4ZzCH9H5JwQ3s3B6zCg82hQAQjT8LGMegIzGSgBML+fz/r9FBuUfzJ88VLKawG/BTA0pSoEdZuGK79fCKbrk/kpmq0gJtg2IqsowMTAz0Jhf/ncFfzl9CbtydzFCmPDS5bXVx5QJ6/c=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SN3PEPF00013D7C.namprd21.prod.outlook.com (2603:10b6:82c:400:0:4:0:a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.11; Thu, 6 Mar
 2025 20:50:19 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8511.012; Thu, 6 Mar 2025
 20:50:19 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 1/1] RDMA/mana_ib: Fix integer overflow during
 queue creation
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: Fix integer overflow during
 queue creation
Thread-Index: AQHbjso/3tAAVLsXPUyhCm8tDX1H0rNmkmcQ
Date: Thu, 6 Mar 2025 20:50:19 +0000
Message-ID:
 <SA6PR21MB423152087DEEDD4254C414BBCECA2@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1741287713-13812-1-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1741287713-13812-1-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ff3bf60f-4213-4abb-bdf0-dbf4741973e5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-06T20:40:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SN3PEPF00013D7C:EE_
x-ms-office365-filtering-correlation-id: 45ab3124-b95f-46ab-c11c-08dd5cf0818a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SyuDleuGUfMlj4cuQdtoNVdbkz+3+0wWvalSBML8VW65p2umSAQzggu9DU06?=
 =?us-ascii?Q?2EH4cGcKPllTDaq4OHKvsnQVqwDReg0uM36dDhbVl10iQat1yCarxm3GJE7/?=
 =?us-ascii?Q?6Fm1kTuIn+o+eGrzbXdhVbvYUorSoxd0rWrHOdrcEbNLNHtzFK5XDQOtRqXs?=
 =?us-ascii?Q?BeQkx5ouv2A+NimKg3PZrFimBdKGDt9a0SQi3icbZYry42VIy3oet9CT5OkS?=
 =?us-ascii?Q?bdMfdzNbqm6b2Mw8PapVKtWvUHZ4vrLWQWBNlFyZXCQg/NFrQw05lG09L2y/?=
 =?us-ascii?Q?Wr6nxD5BeBSQUxAM/JCikyOj845arjslsAuHmF7c/tkuSVt2tcOUwV92E8UV?=
 =?us-ascii?Q?A3B/UMgBI7GdTolihP4nXOVKONLGX70Pojr0ahCy7Bku/KWB3Q/su14Kja8p?=
 =?us-ascii?Q?uovKZMFgubckCnNtrizTk6YEnOXQk49ocgNXstiqZaL4AMd+/l4I5WHkErdu?=
 =?us-ascii?Q?gbess2UKp5hA+hixqXhvXmmB/ODpZ/yR9wPCJM30SKcyAP7qokyvdfV30vKh?=
 =?us-ascii?Q?AT5iSprsuCFUXe5mdPwkiISHkW0iwrd7MCgVHkWioBz9o9nR9tBDE45g+7IK?=
 =?us-ascii?Q?WCB0zi7Qevn8WMswafYOT2ppzEhCgKBcbY6TpoDBHIoa2VPGTkfTBv2C6psv?=
 =?us-ascii?Q?lF2RRaDd7OhsNwFA2AN0meA/RR4jq14rqgEUHuWHgE5dTk9k2dKil/zC2Kuw?=
 =?us-ascii?Q?X1wAF7VjCVVRTOYzYcRURslvjsMTdsBkBJjgF8XE+c+reRYrm+EIlSnHFUCy?=
 =?us-ascii?Q?2sMzDCsSr4t4coXlKXyg6qfOLWDX2BDTPKZQyh99RygvDixq9JizCDp6LfRl?=
 =?us-ascii?Q?jB+UkJA99Oysg/cxEPC05PdO8P+m+RZZuN5IKRq7UT5n5EYERPqDhLK4igym?=
 =?us-ascii?Q?ChIN+V/7FBtPW3QSJ8lEFLnedvn7zUvZqtVlWXy7W7LmqrDttI5v/Vk2uoPG?=
 =?us-ascii?Q?BLPDOxNCoqHJeLAa8vH0VESEghVr/ktqMi0p46rgYTWHbbNuceYG6CUYOHje?=
 =?us-ascii?Q?93hCZqqs9Qvt0UaM+MCDNRiTXJo9OJp6AeiFIOeXZAzQKbXJI6g/jse329dW?=
 =?us-ascii?Q?O7TEk7jszsOLVU+LF0ZmCQCPLfy0/ee+dKsVIrTvMJenNVSnTmZrmHdmRC9N?=
 =?us-ascii?Q?YAGPxUP/tnoF7lmn8jFr4/CpiokMSKLj6h/F791wE6WlcdhjCjdFEGBUji9f?=
 =?us-ascii?Q?glwuQ+hnu3blqfXsFJwNJb0o4WcSfeB0vImsoNkqx9EwySW+TzEPNKjfLkQI?=
 =?us-ascii?Q?yW7a6YuVeXnz9fFUsn94SpjLWRi8BpYfYjodxClmr9mwi1x3VGZJ21wyvWpG?=
 =?us-ascii?Q?wW7QpOPYCiKuFQcBml8bixtUaoTXtWrhsoDGZttH59WpQII2g35IEv4gK7nV?=
 =?us-ascii?Q?e70I8cp0W3rx5rjys1TewXVo+sKJhmZIwHhooEemkidds0vlUekaFPOBsW9A?=
 =?us-ascii?Q?wuoi4lMJnyMUals/bJgukoZ574kIYSf3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EWxil4vj2d03Ll/0/xe7DTxwqtmjr46kZjyc2ofA5dS3EeKdoltkRx9tE0bi?=
 =?us-ascii?Q?nrDPb9OgQNvEThpP1BS9P4HQzE3ZSGANZ/UhKJ5UGSW84sRWKSPcOpYcaFt7?=
 =?us-ascii?Q?P8bOEeRsrNADTVcj2AfWSYJVMu0vBjiJWGdImJyOpn148xFxfThQQU2OiTgA?=
 =?us-ascii?Q?bZzBmytFdn4Oaj3dg5z15GI3cLohwfIg/sxZNOxQV/Kh/obRtBkZjR0eMzaK?=
 =?us-ascii?Q?1H3mtHzDp4dX3wMFNKo4bFNRLHt3FcCPGw1NOG0E8CLYybh96ILY0X5Fk7Si?=
 =?us-ascii?Q?jvdMi8U5wP7i0C1UwCJfk2jkDKlyBiCtdR4YeTZTuNwGLUGzIGgAPxV+Vgcj?=
 =?us-ascii?Q?R4uj2jhe3aeENbQ6Ar1lPO4wNGHbZlKQaYTE6MH0BmTcbM3rLLn/YzPfz7Ds?=
 =?us-ascii?Q?Oz46IJ+LStKb+1UNG/hO4QH0tPNOo5e7v/6yetF1oWL1wF9ck9QBxsrPSA3S?=
 =?us-ascii?Q?c4g68Sga9dfGPYN2dP4Mvx9K+PkuJcGNhjpD7nCdTTWCQQZnKRtcQL+UB/da?=
 =?us-ascii?Q?XGtBcSmLea3mStwuA0XpQcVzRlCM4mDngNSYBL7BsBhzHKJuAF1WnC9NQ5bU?=
 =?us-ascii?Q?SpVAcL0Lta6DClMEf+SvQzoZ3bMWCEuKoGrNStE8Omm+Q/B5F9obuuQFjmwo?=
 =?us-ascii?Q?B1MEX8u391XlgZ5hTvNwXtnHfn9LOtNjQs50HILX991paWyaPpNrSmZejTeq?=
 =?us-ascii?Q?N+olxG35jBjhHura3DrxMb6nNiqw9B6+LGqyKxWiWByM8cWMrOThtEaBT3wH?=
 =?us-ascii?Q?l73sO0cLjPOnkWDNpmuVoDI7BiBhhk9eDG104YkWrhwUw/PudwM94YMbKeUX?=
 =?us-ascii?Q?7od/ppAv+u0hmtF8KCSthA8a83hGCZVU3QBaL6AVWA/QXPii3zD88KDbg1o3?=
 =?us-ascii?Q?LJmnVQv6Im9z2PdYT0/nOlaCr+NNgHgp8v9q8FvH+GDZ5IcppjRkTzjgXVGz?=
 =?us-ascii?Q?z8aGXzJOCg+iB1Baevf0emWhn8jQbWQAOjrXTDhIKjKpHCaSpgcNXP0gR6Y2?=
 =?us-ascii?Q?r5Gp/Lcz95dC4EtPgvYQY04t1azdSSM2AAhPPkw99hICtc59yr2Pib/C80iQ?=
 =?us-ascii?Q?qRb3DaEQQ0u+1yKe51MS+93QjAZG6jS+HvClLsDL1WNmTKCDf4HnGmdFX65r?=
 =?us-ascii?Q?ny7l8FZYeTKcsD+/I3YEcGcOCYxj2phtAfNyODE1YJbts8osHwis6UJI0UAF?=
 =?us-ascii?Q?7ri28qrzD3vRRC0B8xMQXH1vcibwkdFq6pnW4pkMblSHseduSr7NgXo5U2C7?=
 =?us-ascii?Q?IbXFwNyXhgAJ6UMrmB1L8bujR1r6qvHyfQUSu4t+qRysdhjMb+jCf6GT74sF?=
 =?us-ascii?Q?K6QqYF2PwbVLtMRDK8S54TMWB3TPNFeds+W8HS9QkaTqrti5l33XOUWUa0kB?=
 =?us-ascii?Q?nBeNsT7DwQHSoAm7xPn8m0z4Q2TmTaGfOVGdRme3DX/PVA1grW0hVx/M9E6K?=
 =?us-ascii?Q?nC/183yZjEKeC8w+5LWjAObr7qXXLb/d4mkG2+ZgCkBG+iXjzJvMOpoTNr0d?=
 =?us-ascii?Q?pFM3sUNtJFQ7i2hWqfV75vvRkO3kgoqodhnKwcVRG/MkIKhtFvJx3molxQqM?=
 =?us-ascii?Q?Ni0oU5exgCHFgqh6erUWBXVsBv+G0dbro7svT7Ov?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ab3124-b95f-46ab-c11c-08dd5cf0818a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 20:50:19.1187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ngAI8AHJWWNP6YjUSqu5eqQXhmioNjPSJcAQRSwQfw0n6wI7v4SQ47RZGwnsaH8fP5M+wJBFDCWmOMRJeIqEDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN3PEPF00013D7C

> Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: Fix integer overflow during
> queue creation
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Use size_t instead of u32 in helpers for queue creations to detect overfl=
ow of
> queue size. The queue size cannot exceed size of u32.
>=20
> Fixes: bd4ee700870a ("RDMA/mana_ib: UD/GSI QP creation for kernel")
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/cq.c      |  9 +++++----
>  drivers/infiniband/hw/mana/main.c    | 15 +++++++++++++--
>  drivers/infiniband/hw/mana/mana_ib.h |  4 ++--
>  drivers/infiniband/hw/mana/qp.c      | 11 ++++++-----
>  4 files changed, 26 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana=
/cq.c
> index 5c325ef..07b97da 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -18,7 +18,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>  	struct gdma_context *gc;
>  	bool is_rnic_cq;
>  	u32 doorbell;
> -	u32 buf_size;
> +	size_t buf_size;
>  	int err;
>=20
>  	mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev); @@ -45,7
> +45,8 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_ini=
t_attr
> *attr,
>  		}
>=20
>  		cq->cqe =3D attr->cqe;
> -		err =3D mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe *
> COMP_ENTRY_SIZE,
> +		buf_size =3D (size_t)cq->cqe * COMP_ENTRY_SIZE;
> +		err =3D mana_ib_create_queue(mdev, ucmd.buf_addr, buf_size,
>  					   &cq->queue);
>  		if (err) {
>  			ibdev_dbg(ibdev, "Failed to create queue for create
> cq, %d\n", err); @@ -57,8 +58,8 @@ int mana_ib_create_cq(struct ib_cq *ib=
cq,
> const struct ib_cq_init_attr *attr,
>  		doorbell =3D mana_ucontext->doorbell;
>  	} else {
>  		is_rnic_cq =3D true;
> -		buf_size =3D MANA_PAGE_ALIGN(roundup_pow_of_two(attr->cqe
> * COMP_ENTRY_SIZE));
> -		cq->cqe =3D buf_size / COMP_ENTRY_SIZE;
> +		cq->cqe =3D attr->cqe;
> +		buf_size =3D
> MANA_PAGE_ALIGN(roundup_pow_of_two((size_t)attr->cqe *
> +COMP_ENTRY_SIZE));

Why not do a check like:
If (attr->cqe > U32_MAX/COMP_ENTRY_SIZE)
	return -EINVAL;

And you don't need to check them in mana_ib_create_kernel_queue() and mana_=
ib_create_queue().



