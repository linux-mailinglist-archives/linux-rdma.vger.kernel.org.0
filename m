Return-Path: <linux-rdma+bounces-22709-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m5ghJFSbRmr7ZwsAu9opvQ
	(envelope-from <linux-rdma+bounces-22709-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 19:09:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DECA6FB0FB
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 19:09:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=bixxBZSy;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22709-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22709-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB3FA3001456
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 17:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BC0317146;
	Thu,  2 Jul 2026 17:01:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012054.outbound.protection.outlook.com [40.107.200.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BF726F46F;
	Thu,  2 Jul 2026 17:01:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011683; cv=fail; b=IJz5KQQmzHfkQrdyuoFivIy4eoN8WLlCcKkp5Os7qtT7EKaSSCiuIdGJMXB4VE1GNYR27E8W9kC8MNdoNM+95D3N1D9HPbYpAw7C/9Sa8Myb5vILLqG1fHi26QN4yxDu5IZXnZjkeGy6KnegI8hzdQ+Q9uqAy4o6fBXNskzTWcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011683; c=relaxed/simple;
	bh=3jQ39w2PtktP3UYSJa9T7vy9tkuzGdLFlaSAEDhMMBU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=esVv4L1G/iJ9LKuFt117RqMI/dQ5BUoneUjE8uHTFccUhwD8pq0F+2QJd8qVPglWXaAnKfMJY0D3ScyLclLNT6RdToWsyt8uoOHqmxnnkBI40DY9mQOhIxq4TbGKN73V2DiFQVWvSUyYaoViO9vpfG52uKtj2GPHeHbURYtzEUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bixxBZSy; arc=fail smtp.client-ip=40.107.200.54
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2BGfgbJp/isqf5JsXr42xXBO0hT83O8JZ1dAXFuFB+LsGt0W2/0tx4VcBhnfdbcZ3S3pH60P9ysso/voL12ML/cuKWdPxOdge24Tqf9tQi7hyKLAPucxrd8sNbKJ4KwIiPlXwe8LkSrx7St+bxnCqFOCpbJ7edYAq+E6vTxu+fa/NDrM/fn02x8JbRuHM0IzO5EcWZh1p08pvDmuNhdCvbV+0Yf4EjRnO8KYZZ9JPzA3nSAjiesv2AdzYVtpLduVLbpU2ELtf8A6o496pmeqUeTrsXX3YQqbFRHCYJgGPtTkI99ODyTUerrg6OVFBKEtP/zyyfEBOa6fgUg15/USw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghzcN4eqk7TL9M76tOBQD25lswOUKwIzovqvTgBQazA=;
 b=MtuWhJUW0X9U3JwnbCVL/PtT+cxpfR9kG2hvW1anuFFG/hheLZlK8DUNADOF0wSeXzjmXQ0lBfOZ4Pzo+Y08XoQ+hr7kwLJ4bqNj5rpLTGQsq0lHnEyWowHLkhsVczB0H4sUir8tSleUhOh38jvhMOrco9FOPM7u+v9GZuIh9+zPPzjJ9hZgakqWtxeVmF493bvZqrVbTCaeRsJhUs4VIwc5+W8dwboGEI3LbeoDg6Lx3yhQ89r+1bs5kzJhQnglFX/mkN6TjlTf4NgmMbY3DEao9lrVgtB8RgUN22UKWsSP1chcuBqmV3cGDQiu/bRHKv7eAeeN0l65ohwtwb/Z5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghzcN4eqk7TL9M76tOBQD25lswOUKwIzovqvTgBQazA=;
 b=bixxBZSybdgWNhDWgiV1bBdqoM7YkBS8twmcxswSPOHxUZ/MhLOKaxpmSxAikRlAvNDLTxalx0k2n+Xc78IMIeZDCpseIC/3J8cW5phlQleycOvLP9XEaDmq4kbyGRmx5FdRv9ypK6+10Ehgf0ydSA0UVSwRw9AAepiM//id7N8yKbyxQJmYi2U3h9ExUMUekJufcmMrStfhBv0Ulakz0FJtWTPSH0csHh6YuAmeeb7roUzZIRXnZpfkAYyI/LnUFInM6Wu4mG+2DNW9XgdjlDnCPxaHZh0jsTI1i7dSm31exfHStixwCqglTnxLVVgZxJKHx38ONQfZ+fhWKB3/OQ==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB8775.namprd12.prod.outlook.com (2603:10b6:510:28e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 2 Jul
 2026 17:01:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 17:01:17 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: linux-rdma@vger.kernel.org
Cc: Edward Srouji <edwards@nvidia.com>,
	Jacob Moroni <jmoroni@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	patches@lists.linux.dev,
	stable@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH] RDMA/uverbs: Add UVERBS_ATTR_UHW to UVERBS_METHOD_REG_MR
Date: Thu,  2 Jul 2026 14:00:57 -0300
Message-ID: <0-v1-011199f46f44+319-rdma_reg_mr_uhw_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: a2073337-e881-4849-dbf9-08ded85b7cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	sNnchwiSasUvNoEAfqr81jWmQcGCPs6Hokgw34Of8KB/Rad3JXT3LHytzqKwUmCAQv15rWc//gTfp8XHXr9oNltUQSiMePvfdKRKZhCBG9/Ocv3wP57oFCh6Haf5yLClnQTYizQ3PrcQuJQFm6XODAJz61/agBOHzfO1HV58zdJM4XlSK3Jel+a9fkjjeErISRASyZ51BGXYpiNsfKj8BEW/eMgSuKd2d7g7O+ua2mvel7sr/WIEfn+kUhPFgCSS/OFrQaCprewTzCangHnMooONzQYwf2FvuhwtQhtVLKqWNpxM0xwYXkMercAEDWsKV9tMZ4X9TF3ZOpncCDj7H42xV1pTjsu0TmFKk5jWDLUdM1QZgeqVgASUbYT68GFgWaDQVqx+OCIjnScQtC1xuQ2l7saa16LCGtAws8MIsspCJAw6sDp1FGnesmkDtmD7UtGfhevf/EmGr2HZS7ZoLR6PZUdfB2mgbxFzzQFQXg7wZsYBrk5hRkYyj7RpWP3cpFBR/x9jpF2J79bKAhOXLETQaytM6o2ds8nIB1me4Bq4tWel4gjpLh9492VQmw79F84v4vxCxUymPRDskrB7PffI/sWljNq9bKvVeLLZTzYtipGFvCAR30M5JWkw+67b/7f03SUAL3zxVjg0BMlOGUVOqoQeY/T2CfHZqqgLIbA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0dGYuR0QgKILkweEGie3Bhljk86lUpUJQEJfw+1VyOazqKi0E3eMflZinBDB?=
 =?us-ascii?Q?oI5CUXJHXiqfXYVpDBBYs5urrz7vfJCdyVQyADEF7sqtyVjqRE2xC9BpROZs?=
 =?us-ascii?Q?TaQF8ouPDd+t0DP887J+x3Su974G0EgVxMCy083lcWwsiRh3R9q6Ibwdbhfa?=
 =?us-ascii?Q?mx87oHkyQAhOaj1HbWlcfC8EkWRUDL4rmKelMeDriolri840YM6+8ZFUg6UJ?=
 =?us-ascii?Q?Ib8LdNSfneL4y1i1xXEQ6FVhVYK9FwMMn9svyIyJlIfkpHrg03DpuHIwkjP4?=
 =?us-ascii?Q?FumSLmUGD6Q1xAxT/5eiyAEkOqiyVaqoDQnnWk8euVWWcWzCYXicxpb5o3X5?=
 =?us-ascii?Q?igd1l17pNBNRianDIHiS+hKB6YEwJdG8wuHaJtATQuoP/NgdZZpVBFPyIRVz?=
 =?us-ascii?Q?yA957lx/yRY+KHSo3wLs1YujDdrHFSLexqEAzpGT30mGElbf4kf6t8xcC/ZG?=
 =?us-ascii?Q?370oHw0OhOuvUdVB3EnmNTT0i5i+CNThlN9y+8Tlp5xk1+55wZjd1DLwIsZU?=
 =?us-ascii?Q?c5KAXxploKzNkXLBORI+R8ulQ173kVcDZFrUHTfWTg1OVl7Nm+22XjBbAHhQ?=
 =?us-ascii?Q?39fDJePjEWmHybVJCywYvxaTuPOsqVuibk9l177gr7BJBQZVIb84fvhq71sC?=
 =?us-ascii?Q?pkx4qbAYyasltnzF89C6uvd8cEphWPQfakzWRjLTB0JhJu5aGQydOb543DfZ?=
 =?us-ascii?Q?TGy5l+xrSjdx6hTLADOimGSlYlzSLwmz9N5C6P2kIQHCztn6QnNxpSa710ek?=
 =?us-ascii?Q?iQiN1KrMJc+MdBwNGEl/Ae/8gGJH3nLF/752xk1jVwTQpqObLHQq/dWCZBkP?=
 =?us-ascii?Q?JuFhFkaQax1/E8nLuXEG9YDunbN/CTG94s4ul9O+/jUmdIl+sLKJRhmvmYIV?=
 =?us-ascii?Q?2j/3Qr7vm6j+pksdHXQqQVIu29Pu7Bh2MA0SKImsqtBqSqnir6/zA54Nojca?=
 =?us-ascii?Q?iI3HxUPEisksWFfOViqLUeM+U9T+wQQQix0npveZL+bGL2zBUzlGhKmz7Gy4?=
 =?us-ascii?Q?7ysQ2HEs+d7UI0gXqKihZMFvusWUexocFUr6G0Cy6ScNP0AvWjSSYkLjPymf?=
 =?us-ascii?Q?iQFs6DIXpwB/gyYUFhmOk9Re8ErMJoad8BF3p0oJgZJFDd8Fvi8Tdc9JhgRp?=
 =?us-ascii?Q?CrCSb28UfBaD2U0Fhkwczt5vLVQabet3mMQk43lk/oT1ov/LLl3HXtR7u0ri?=
 =?us-ascii?Q?9G9jvyyB4PFoWKmxHGjDJpaXu8vC8VQLQcwP0GKz42dsPsX6U7Rgk8QY9HHX?=
 =?us-ascii?Q?fHX6ni3cFus6C54SYgHTsPC7fqTuNGChCHc4zsQ7FTqvTJCHGEl+cbyahfjZ?=
 =?us-ascii?Q?qvu1ilXMFW8Ao8ET1Dw6CkDtB8NdNbAU1qYDYNqd3GrarDRFMUqsbAyb3gjO?=
 =?us-ascii?Q?X/YHvN6KObYVf0uITWWX2FiszPhdM6tDFhEogykV5/OZqCtRFgRgo2WZLpJU?=
 =?us-ascii?Q?HuiwXLrDiodJacphF6RaI5Mdh2p+YeG41my0tTjnzaVkccgOrpKQbIINeFUv?=
 =?us-ascii?Q?bEwvmdjlAAq5ilj/cP2rsA3aPW2KtRiSTRgdieccvFsDNLeatR4w6ORaNou/?=
 =?us-ascii?Q?X3o4Og4pTVJGYWTUiqrDACFCWd4FwvjSvv6WbuTVpgod8xrWABU+HKUQNUq6?=
 =?us-ascii?Q?47XFVwvOyBoKpJ+MNC11SAUgILSyHxn6zwE8472qBJHMRZOOs1S0eHKjTqN1?=
 =?us-ascii?Q?zIkZClZ3tT6PiXLuULaQs0MTaxsruI8NVVAaKW1W1Mjkf4w7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2073337-e881-4849-dbf9-08ded85b7cfe
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:00:58.6999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q557Nnzxn+yWodEEzkJniqzD6O45ku0O3veSTYB+FzcHnEKsTJrg1enp31FTtAAT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8775
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22709-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:edwards@nvidia.com,m:jmoroni@google.com,m:leon@kernel.org,m:patches@lists.linux.dev,m:stable@vger.kernel.org,m:yishaih@nvidia.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DECA6FB0FB

The original commit missed that three drivers (mthca, irdma, siw) have UHW
data associated with reg_mr that cannot be passed through the ioctl. They
also assume that the udata cannot be NULL, so failing to pass a valid
udata can trigger a NULL udata crash in those drivers.

This never happens in real systems since in rdma-core ibv_cmd_reg_mr_ex()
does not accept a udata and those three drivers don't use it, however a
malicious userspace could trigger it.

Cc: stable@vger.kernel.org
Fixes: 5b2e45049dc0 ("IB/core: Add UVERBS_METHOD_REG_MR on the MR object")
Reported-by: Jacob Moroni <jmoroni@google.com>
Closes: https://lore.kernel.org/all/CAHYDg1TOGxRGZrS69d4Y--Shj_DZv0nJuM73iHUBwBM70g_t3Q@mail.gmail.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/uverbs_std_types_mr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infiniband/core/uverbs_std_types_mr.c
index 570b9656801d72..0c72f801e0d32d 100644
--- a/drivers/infiniband/core/uverbs_std_types_mr.c
+++ b/drivers/infiniband/core/uverbs_std_types_mr.c
@@ -364,7 +364,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_REG_MR)(
 							dmah, attrs);
 	else
 		mr = pd->device->ops.reg_user_mr(pd, addr, length, iova,
-						 access_flags, dmah, NULL);
+						 access_flags, dmah,
+						 &attrs->driver_udata);
 
 	if (IS_ERR(mr))
 		return PTR_ERR(mr);
@@ -527,7 +528,8 @@ DECLARE_UVERBS_NAMED_METHOD(
 			    UA_MANDATORY),
 	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_REG_MR_RESP_RKEY,
 			    UVERBS_ATTR_TYPE(u32),
-			    UA_MANDATORY));
+			    UA_MANDATORY),
+	UVERBS_ATTR_UHW());
 
 DECLARE_UVERBS_NAMED_METHOD_DESTROY(
 	UVERBS_METHOD_MR_DESTROY,

base-commit: 5911f6d6e7cce5f35bcaabc1895616e10a6d0aa2
-- 
2.43.0


