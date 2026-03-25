Return-Path: <linux-rdma+bounces-18640-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPyLMhwbxGnlwQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18640-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 18:27:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3479C329C93
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 18:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EF533123959
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 17:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0AB3E5563;
	Wed, 25 Mar 2026 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="A4fHZZZK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020101.outbound.protection.outlook.com [52.101.61.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB9C40148B;
	Wed, 25 Mar 2026 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774458893; cv=fail; b=dJiM1N75Q4/bHaRRp/gaj6p6WeFw/u2QuKPNKdJwidExTHAAbM1pXRHUONhM5tX/a+UpKTi2A3sRUmhAkfqODJSnTKmCApg64mfbmErdSGr4Adz/xekZGrE9p+h9Z27I6WqTj3rLli3Uk8b+OSTtzHH4CvEMvl7Cm05euu7x/Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774458893; c=relaxed/simple;
	bh=Rs9s0jfZbh06ISLWOsfF8E9nWVjZAGP6yTV5R7fLo/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H++vIuCmCU+jZQWw7DVYlm7LE+UFZR6lUA3JVq0z4ftGGTsshAcQNcJCBWR7NEhZp2+Z+yBJQ8I2YzRiermhy/dQcnHoeASqJJDdV8m8NES2o9mi6D0Xo4Nwwb3jctuSZmZSo3q+EFurtHADoF3iRSPoHSflIlydVwzL08aleRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=A4fHZZZK; arc=fail smtp.client-ip=52.101.61.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVcBUUC1ERI0IAsEMBYwfKOnX0Sx8r/J5B8V93nDkd2J7ppMElASVYKwyxQkcExq18FvjNC7xrK9gz2k+uhbBam31IXcJnD8PESRUhfNsuVQtAvsJLT2Q7X/MVYU1ez22gwuOWeffMRdwXVtW1/tXwst2/8xE5jviOWKovBikpQUHm7GZe9fQnoeZD4xP/rThsai+yN1PqQZkExqAO35jdcFT9lgN48OYVdzKkKPDoEHZEXR4G0s8KO6SueCNZ6L1am3WCVNUiviC/opx1IzeJWPrhc+S/IutyuJfewJn7cRSXwG+cGy9kh2H03RssYavVmz1qnlnrd4KCsdrktzJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxkQQd0cokl0KNf8t3hS2hVE8ddQeJGJVSMhTVHJHuw=;
 b=nuN3zAYEr7VdelL55+a5XlBjuryzvF+DT+E2WeOl6pKaNB2EzI3IAHvwpYI87ypn0rzhbyzwpWcntrU4J2Nd/09RupqY5oWz3JGvDMyNdslsr9fsZddpprF4rdJrkRbfKdgbpBlGfyh5d8/GJbuUPGfKt3e6ZVaVGl5vcOb2i6NSCOqlZu8TapGYrh8yjDIEyuXHCjWNOdSMwIqgecXqHYEtkCKAuyHBXuxRFcvjcPu2SOLXbIJdDCjjlFsMKeQ/2S21/DWP7QV3OQ7t8hkjHnKDqDSYjl+Z6iDLyofFWiVaZiVMAnqVr72D/FFcjehC8w9DsaYmO75rPfFYW6OEow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxkQQd0cokl0KNf8t3hS2hVE8ddQeJGJVSMhTVHJHuw=;
 b=A4fHZZZK1Ng87k1kKTT01fGEVpNVw0ABygJ81JG7AQhjSfJ5wFIGFxS/OLsOiUi/OCTYIcBQ3fVhrjhUw1Jcrcgt4T8F6IuX4UV4tDN6x28H4q1gXTPSGcEIaz4kWEML/eC9zq8zU4AjCLV7OXkECMNxVmCYStr4m1N9zU2Shrg=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6585.namprd21.prod.outlook.com (2603:10b6:806:4ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Wed, 25 Mar
 2026 17:14:47 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9769.006; Wed, 25 Mar 2026
 17:14:47 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v2 1/1] RDMA/mana_ib: memory windows
Thread-Topic: [PATCH rdma-next v2 1/1] RDMA/mana_ib: memory windows
Thread-Index: AQHctvvsZqqVDA/mgkqCnfmPDG1QorW/h7OA
Date: Wed, 25 Mar 2026 17:14:47 +0000
Message-ID:
 <SA1PR21MB66832597B9D1570AD1C70BF7CE49A@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260318172323.1416803-1-kotaranov@linux.microsoft.com>
In-Reply-To: <20260318172323.1416803-1-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d601db01-42fb-4db5-a264-290d6e22d70d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-25T17:14:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6585:EE_
x-ms-office365-filtering-correlation-id: d5b3b6bb-a130-4135-2a9d-08de8a920464
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 LNG6W4UdsHSV0Gts896zWe5SAkMQ/1Hcmwxhz6qtaiXvN3HxZ3NKOq7WJD+hvVS6ps1blNcuw+jha0eRn6pvcUWz5BIEKvaVzRhvIPbRkUq6zHcCFpFBu24cS6s1k7+glE2wojJIxgvLkaOE62M+X44Ntxabup9KJNE+shjQsUDuRTdXddtaklfwf6gwxZUr7E2mJFkukI3JFrmjMdEw/VcWmQy5nC8UK/3UFdYtOBcmv6gdnwqtDvfzBL87JEYLd2bBv9RDnqlWsjbE6OqLxMQuOrTRWxyA44j3a5E2a42gRmFKI8FLHkWd1a1LUy1F+/u3FGv3bSChHwlGxG21IAhPoWV9J9uMnzw8+vAZh6Tf7FOkzk0KZGoG+EfOYTDjUVWWDwHo+ftJLhIfElTZUs8sTNFuwmCzLAPeKIdCkoogEHcntevWM0rFTAsvU1vH7DKbQqbt7EizVyE4Dks6bxpAu+ct0AHkX4O+1dWnqkoWvj14LRq2yc1HxWYyc2YxTJpidaQdcu7I1Nu1k9xFdyYoJb4gyBK8bnLip0pO0A4PlonU11/Y78s/F07tdtVNaujjztsJfBo/Bv5TOKX8j1HRVMnCippwbEHMoRmx0qaqZVk/NEAszlp7FKwJHfbm9HAoR4LBjT3FvqOCNyxWNqV8cgH0d5TT9Cv+IOVLhYcFvMae6UaPwrfSf2EB8fg7g6eawNLmEPUV5WuEq58P0fkcZinQu+clljBKiGwgiXkVbmzdz6Nmjwx7rDqq6kCiK1+ELjpz+SwPbORxWjc+0MDcb5yy8+lj4/Iv2XMcm0U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZGej0XIFPyuQwJiQOhFFNb7FNy/IaeJgTDfwbKBqq2JzkhxIOcEI8/UvaTdS?=
 =?us-ascii?Q?3/XeLQny9wzVCVaRnZLuSv9TN1DT72TXPUVrTrDDAiM8hWJW/ydipOkdbiqV?=
 =?us-ascii?Q?NJfL9GU1BUpVu14nSApfz+JcpZJ95qke0ZkGqaw0ifT82Jxm5AEocCGnrLVy?=
 =?us-ascii?Q?F1KDGy9yb7pmAvVXV8N4+d6UQL4WPtozemt/sqfh5227IaL7kiAWn9KOV5dg?=
 =?us-ascii?Q?q1DYs9eduXggkdW7SmAhlj8YWm/NEzpTNWEkSV5WUx3JbGYM204HpvlTgtnw?=
 =?us-ascii?Q?7HjfKq/p8/JqKjPT39lshuN+XG60vxlURu2tXAL4pJC8TQ0ibmHowKju93Ze?=
 =?us-ascii?Q?RnlOSnDiZjVQ3i7oUohvB0qg1dyPa1nh0t9Xe2Ilq39CcYbafF3DVN82UCBn?=
 =?us-ascii?Q?EmYxMWtuUqvXAnhdMgNfskMayMOr8mzrjFuKvuROdUKdjq4+7lrrK6UdFro3?=
 =?us-ascii?Q?xHhcxMbcLhQrvYt6oXW7drru2BsD7eW0wmIFhqvh1mvlrSm6gF1CGAGuBtQ1?=
 =?us-ascii?Q?1/aI8skdVFVW2DpBI7WaP74jITBJxXE1HdBUMtJ91lv7AVNCr6gtBPfDpiRm?=
 =?us-ascii?Q?JQ82G/CzpXaHq2K3K4BiqlShH3INvWaGnTCCAOWATrcl4iF8HC+3O4bAGypB?=
 =?us-ascii?Q?1UouGZc5lJTQ2aAhXYZiM9NmcLLcD95CSzggA0JP21KcG9iYBGpiorRuQbtz?=
 =?us-ascii?Q?gcXkhMEWgZx183CotOhSdty/Yz/tBWtyFmjSnczjMqw4Q6ME2hFlf5/dIsjL?=
 =?us-ascii?Q?HELRURcGOlk0i1s0tQVW/D0kaU/ALrl4cqmuTf24++8a2zCxtH3CCAB8yAsC?=
 =?us-ascii?Q?kBQxYpbQhaOLwukT0Ick7sNRoDd5qd0jRGERnC0EgPsFJbu3T3d1oO7Qh3Kv?=
 =?us-ascii?Q?71W5EbW6du60zSozLnu5R7IazjGgwKzMOF2Ei4QCqBxnt51YZ6MLcX8aQbaE?=
 =?us-ascii?Q?WcUErod+byUGNzWa8sMtZdVn26YZ+Prte6xz82h36dn3jiahDvMl5aKzAaGh?=
 =?us-ascii?Q?sVSNYHXgcq3sO1CfxIChqNpBDPhnhMC4yANrXQeXTBhi5GKWmz+NxCg6bvLM?=
 =?us-ascii?Q?obeQm7RlBW6xVD1uyrmrlMR4gCnxMtP9eWeStlDB3/rKSVk9mjc6bvwT8JWP?=
 =?us-ascii?Q?IekrjytpTX3plarO0C2QrNQ4cA+f13v1lM3f4aaTCIt1yBlEGUz/USGO//T8?=
 =?us-ascii?Q?mlfBoKZCNZp5zsZQY95g2n1EaRii2xhHX39Y1usAXncrot7QRhLQuL6M8cWa?=
 =?us-ascii?Q?eF0i8B6VVuEkLC/6SsvD7TAALfUM5NnX4vziMhGxvkJA2dk3XQcIjxbLEAzm?=
 =?us-ascii?Q?KgghIiLp7yPum9Rv7hLeJjWQ2PaVQ7aGfcXFomX2D8qPQqcOWvBzKX7NqKVM?=
 =?us-ascii?Q?+dXdDXYBoG09jwkhZoYPJg/VE5Of+sDUaBA7nsJZW/uZNc4LKQlusoFEiNRG?=
 =?us-ascii?Q?GSPHgbMvgshCQrpRSFJlz9GsfptnSEpe0Lz56e6LttNHp8YmT4ynokUrz3eI?=
 =?us-ascii?Q?VWUAGushjd47BlQVWlssvsINcdsf5admEmzSDeF6l4Old+2dTEfiBymUq9pb?=
 =?us-ascii?Q?UR710THaRDublVLOqboMJ+yxFEwKtgHrwT8haZQnfv/KDniSC18Kg1g7ydwF?=
 =?us-ascii?Q?E+OxbJy/pav2CCf+nrXgxZvlVAs15v7Ao29D3hzdIXiuQPQAHnpG/0m3XJlP?=
 =?us-ascii?Q?I/oc95DA/UjYjprfl9GEVXYdkaKcnPK/F8HY32y0QXMlfPoG?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b3b6bb-a130-4135-2a9d-08de8a920464
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 17:14:47.6183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Vxc/t2rYAm3hyHbvth+nQ7t24nXL8CoWM1uawvvI3KcO3FTmZV/TnzYnBkCsJWG92xAfbKx/pjnIpByV9cHoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6585
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18640-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3479C329C93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Implement .alloc_mw() and .dealloc_mw() for mana device.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
> v2: fixed comments. Cleaned up the use of mana_gd_send_request()
> drivers/infiniband/hw/mana/device.c  |  3 ++
> drivers/infiniband/hw/mana/mana_ib.h |  8 +++++
>  drivers/infiniband/hw/mana/mr.c      | 53
> +++++++++++++++++++++++++++-
>  include/net/mana/gdma.h              |  5 +++
>  4 files changed, 68 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/device.c
> b/drivers/infiniband/hw/mana/device.c
> index ccc2279ca..9811570ab 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -17,6 +17,7 @@ static const struct ib_device_ops mana_ib_dev_ops =3D {
>  	.uverbs_abi_ver =3D MANA_IB_UVERBS_ABI_VERSION,
>=20
>  	.add_gid =3D mana_ib_gd_add_gid,
> +	.alloc_mw =3D mana_ib_alloc_mw,
>  	.alloc_pd =3D mana_ib_alloc_pd,
>  	.alloc_ucontext =3D mana_ib_alloc_ucontext,
>  	.create_ah =3D mana_ib_create_ah,
> @@ -24,6 +25,7 @@ static const struct ib_device_ops mana_ib_dev_ops =3D {
>  	.create_qp =3D mana_ib_create_qp,
>  	.create_rwq_ind_table =3D mana_ib_create_rwq_ind_table,
>  	.create_wq =3D mana_ib_create_wq,
> +	.dealloc_mw =3D mana_ib_dealloc_mw,
>  	.dealloc_pd =3D mana_ib_dealloc_pd,
>  	.dealloc_ucontext =3D mana_ib_dealloc_ucontext,
>  	.del_gid =3D mana_ib_gd_del_gid,
> @@ -53,6 +55,7 @@ static const struct ib_device_ops mana_ib_dev_ops =3D {
>=20
>  	INIT_RDMA_OBJ_SIZE(ib_ah, mana_ib_ah, ibah),
>  	INIT_RDMA_OBJ_SIZE(ib_cq, mana_ib_cq, ibcq),
> +	INIT_RDMA_OBJ_SIZE(ib_mw, mana_ib_mw, ibmw),
>  	INIT_RDMA_OBJ_SIZE(ib_pd, mana_ib_pd, ibpd),
>  	INIT_RDMA_OBJ_SIZE(ib_qp, mana_ib_qp, ibqp),
>  	INIT_RDMA_OBJ_SIZE(ib_ucontext, mana_ib_ucontext, ibucontext),
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index a7c8c0fd7..c9c94e86a 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -125,6 +125,11 @@ struct mana_ib_ah {
>  	dma_addr_t dma_handle;
>  };
>=20
> +struct mana_ib_mw {
> +	struct ib_mw ibmw;
> +	mana_handle_t mw_handle;
> +};
> +
>  struct mana_ib_mr {
>  	struct ib_mr ibmr;
>  	struct ib_umem *umem;
> @@ -736,6 +741,9 @@ void mana_drain_gsi_sqs(struct mana_ib_dev
> *mdev);  int mana_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct =
ib_wc
> *wc);  int mana_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags fla=
gs);
>=20
> +int mana_ib_alloc_mw(struct ib_mw *mw, struct ib_udata *udata); int
> +mana_ib_dealloc_mw(struct ib_mw *mw);
> +
>  struct ib_mr *mana_ib_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start,
> u64 length,
>  					 u64 iova, int fd, int mr_access_flags,
>  					 struct ib_dmah *dmah,
> diff --git a/drivers/infiniband/hw/mana/mr.c
> b/drivers/infiniband/hw/mana/mr.c index 9613b225d..02236488f 100644
> --- a/drivers/infiniband/hw/mana/mr.c
> +++ b/drivers/infiniband/hw/mana/mr.c
> @@ -6,7 +6,7 @@
>  #include "mana_ib.h"
>=20
>  #define VALID_MR_FLAGS (IB_ACCESS_LOCAL_WRITE |
> IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_READ |\
> -			IB_ACCESS_REMOTE_ATOMIC | IB_ZERO_BASED)
> +			IB_ACCESS_REMOTE_ATOMIC |
> IB_ACCESS_MW_BIND | IB_ZERO_BASED)
>=20
>  #define VALID_DMA_MR_FLAGS (IB_ACCESS_LOCAL_WRITE)
>=20
> @@ -27,6 +27,9 @@ mana_ib_verbs_to_gdma_access_flags(int access_flags)
>  	if (access_flags & IB_ACCESS_REMOTE_ATOMIC)
>  		flags |=3D GDMA_ACCESS_FLAG_REMOTE_ATOMIC;
>=20
> +	if (access_flags & IB_ACCESS_MW_BIND)
> +		flags |=3D GDMA_ACCESS_FLAG_BIND_MW;
> +
>  	return flags;
>  }
>=20
> @@ -304,6 +307,54 @@ struct ib_mr *mana_ib_get_dma_mr(struct ib_pd
> *ibpd, int access_flags)
>  	return ERR_PTR(err);
>  }
>=20
> +static int mana_ib_gd_create_mw(struct mana_ib_dev *dev, struct
> +mana_ib_pd *pd, struct ib_mw *ibmw) {
> +	struct mana_ib_mw *mw =3D container_of(ibmw, struct mana_ib_mw,
> ibmw);
> +	struct gdma_context *gc =3D mdev_to_gc(dev);
> +	struct gdma_create_mr_response resp =3D {};
> +	struct gdma_create_mr_request req =3D {};
> +	int err;
> +
> +	mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_MR, sizeof(req),
> sizeof(resp));
> +	req.pd_handle =3D pd->pd_handle;
> +
> +	switch (mw->ibmw.type) {
> +	case IB_MW_TYPE_1:
> +		req.mr_type =3D GDMA_MR_TYPE_MW1;
> +		break;
> +	case IB_MW_TYPE_2:
> +		req.mr_type =3D GDMA_MR_TYPE_MW2;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	err =3D mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp),
> &resp);
> +	if (err)
> +		return err;
> +
> +	mw->ibmw.rkey =3D resp.rkey;
> +	mw->mw_handle =3D resp.mr_handle;
> +
> +	return 0;
> +}
> +
> +int mana_ib_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata) {
> +	struct mana_ib_dev *mdev =3D container_of(ibmw->device, struct
> mana_ib_dev, ib_dev);
> +	struct mana_ib_pd *pd =3D container_of(ibmw->pd, struct mana_ib_pd,
> +ibpd);
> +
> +	return mana_ib_gd_create_mw(mdev, pd, ibmw); }
> +
> +int mana_ib_dealloc_mw(struct ib_mw *ibmw) {
> +	struct mana_ib_dev *dev =3D container_of(ibmw->device, struct
> mana_ib_dev, ib_dev);
> +	struct mana_ib_mw *mw =3D container_of(ibmw, struct mana_ib_mw,
> ibmw);
> +
> +	return mana_ib_gd_destroy_mr(dev, mw->mw_handle); }
> +
>  int mana_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)  {
>  	struct mana_ib_mr *mr =3D container_of(ibmr, struct mana_ib_mr,
> ibmr); diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> index 766f4fb25..fc6468ac7 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -778,6 +778,7 @@ enum gdma_mr_access_flags {
>  	GDMA_ACCESS_FLAG_REMOTE_READ =3D BIT_ULL(2),
>  	GDMA_ACCESS_FLAG_REMOTE_WRITE =3D BIT_ULL(3),
>  	GDMA_ACCESS_FLAG_REMOTE_ATOMIC =3D BIT_ULL(4),
> +	GDMA_ACCESS_FLAG_BIND_MW =3D BIT_ULL(5),
>  };
>=20
>  /* GDMA_CREATE_DMA_REGION */
> @@ -870,6 +871,10 @@ enum gdma_mr_type {
>  	GDMA_MR_TYPE_ZBVA =3D 4,
>  	/* Device address MRs */
>  	GDMA_MR_TYPE_DM =3D 5,
> +	/* Memory Window type 1 */
> +	GDMA_MR_TYPE_MW1 =3D 6,
> +	/* Memory Window type 2 */
> +	GDMA_MR_TYPE_MW2 =3D 7,
>  };
>=20
>  struct gdma_create_mr_params {
> --
> 2.43.0


