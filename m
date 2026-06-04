Return-Path: <linux-rdma+bounces-21723-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K22MC6rUIGok8QAAu9opvQ
	(envelope-from <linux-rdma+bounces-21723-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:28:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B71C63C310
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:28:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=K7ffb8re;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21723-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21723-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F3CA3019DB4
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 01:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C01261B70;
	Thu,  4 Jun 2026 01:28:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBF2263C8C
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2026 01:28:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780536483; cv=fail; b=WhE03x+9PcNIBC9Zdz+6S4g74cnWKsSV4qo5XP61H+P3yOseQ6n0xA4ZRcaKJ90Sb4M1EoTKxdmYZQS87/I0n3pgosQQDKbKKb+w4nxLiH3rne74pn7xuU77siTtntVz0P5VTyEzqPptrQHzP8zw7CPIxkM/26rbv4cgC0Kb9dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780536483; c=relaxed/simple;
	bh=vYVkwHV6TfCNPkCtBgz4lf4Kq3nk1Mm6yYrDYeEZi5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H3goDM0DY+jx3wlX/WY3+jrFuTJwjzPepmcORzW/lOPRhGXnAfFix3nKFeZ5kuH2s1TTCEZJkIOnegMGoIi5o+oIMzkRhzmJx5n6fKQLEjErNABvEM5oO9DEavGc9W7TcdUArRnSWoSTNhARJX+CTSnqY0BZ5jvx2aFFUwTvhcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K7ffb8re; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWnPTPSFXT7HlB37zbYN8S2jKpwzRWfvFUEjwRcoqi5uc/FGidkFtWuWY0tuJEfS6DTFJGvRJU4JCJyjzUHWNSzF7v8GS7w2B2c9CqJMzbb0cV1R+RA3Q3N3oiAwkWS1CiULPmhsDxBJLBKvdTDf4vsQeBke4GXltpPenPnBy08QbKzoVtg9emS6dl4gzA1/PHazwYEXJ4nFWBvOA9TKDxz9QW8FD6oP0JXTkosnvxXgp/ghTE0SslattJT659CfbHxrE0/Z+m/lNxkKqCf6GJFPKv0fLPBCKZQ5M0F2zle2db4Gp+GtTFePUDBULoGqHZXqfR2K2cgYwgpo3F0MVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6E1k+Keps82fjIZrgdckhVXU9K+vSTZZL0PexunFE4=;
 b=n9/AoAdQRJERC0Cy82hgSjt1TOgHXh4ryppaK/etweFzjmJzb8jHbPJhebo00zuounTM7mbpxTNwGL4leHNiVqyZpq9INl77wTOgeAK+8nCnzZ/wlqi57lQJsfM6KB3Q4bfuDCL+7Cp3ywJ26fZlDAUQjFvpsmtXt0u/FfG9LX2zIlGofCQ2/wLt8mOdqB5fv7sgdrLMa5s0DW87dx3iDcYHHDGaYTqL7jJy1vICL5Te2GU6CpRZiGQpqAyuFV/vUVMZPbduwwZRvQTfABiIWPS13y9llyBckUNBbDUcpz+VW5J150PWgNlbvSHaE0t4H1nVYGpnPQyHcjkBsq4Uhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6E1k+Keps82fjIZrgdckhVXU9K+vSTZZL0PexunFE4=;
 b=K7ffb8repu0PBV01nttBBQ1Iyzr0tTfX6YgrQ9dYMeca6vK32TJZBx2yGRfdGwP5TMGxnXnEENjMjyv6mtKmhJeI1x+QqXNsmOagFeER2WqX56fjACdzR5ZUNl1XUB35lDDyEy5fxUjcYYV7AfiCvYtLjO2JA5j0JMn0hOu9bOqqrvKzaJbtM2RrYF4FEgINVnhqceSCiZnOSQ0MQOfCC8dvGh1TsNSMOpmh4w5hjM4PI8voD0oOBTzbZAZsT0uAakhoN5eTEAKL1RY0WVqg+1xzdlNot7rwbwXTxOTN1pnGVR+DMQcFhQlnM5cIRISk8zgVmvQuB4JrB/0zO8xq7w==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 01:27:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 01:27:53 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Doug Ledford <dledford@redhat.com>,
	Edward Srouji <edwards@nvidia.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Matan Barak <matanb@mellanox.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Noa Osherovich <noaos@mellanox.com>,
	patches@lists.linux.dev,
	Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH 08/10] IB/mlx5: Push pdn above mlx5r_umr_update_xlt()
Date: Wed,  3 Jun 2026 22:27:47 -0300
Message-ID: <8-v1-29ebd2c229b5+fd5-ib_mr_pd_jgg@nvidia.com>
In-Reply-To: <0-v1-29ebd2c229b5+fd5-ib_mr_pd_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0358.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: ec655936-2b12-4e27-e75b-08dec1d87ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	TQZrPR9lpQIIB30GBCAY0JxX/0YtbaVqBCYfp6LOFwf7U0Tc82SRKyZ8hcB1LaRuHol07Sv/KOSfkoIDM8vzTJWz6DxBYC6mYPgWT5AfrKplzCRw1TpDx+N5TaFvLJMeZZNBBcXnqpjidl2LcL0ebk7eCVDoFWBGnx3S7ZoHXRKhhiFbQjSN601K5t29q/OlQF9/snEiiCQfQnBKD4NIfYfTTHZQGRmGjpmvfKywWv3XcH23IeghNpJjaFigX4kjWsqbmp5HbFurSejhWu/ZhlWY56FKfHoZjUiRENGi36/AC9SVHikahX3hOXlI/yz6QqkVAAWtzEE8QgasC1J3CzluhErQT5vDkl1k6spJPcwS6rs5Cux26pVoQdgzwMXQe6ZCKUc5nRMTMfGb0lVd/NUxbuKDLIuaweqs6NVT36S4US01Xtsw6QGjhUggCGLNT3rHj0rQT6Rl08tjpa2Ayi+bdb9J0mKmIMdNpVPOpVsDKuTG30z33g+yyaTSnW06uGnHDHuIrIiM+bfWe/z8BMLiEoRfHExA+7g5gdknZw9jthvHd5EOSkb3HIn0yh8xJGBCAcKv6IRtzVDM+Bvpj3K8/bYzBQaH3orU+ulF1TnTm9IXVM/b1Y0fCgyyTn82jABzDskKt2Vmb8DMTWYiiqMZ8N3LG6wEHhHU18r8lW1DINCgR+F4MaTGCgovIqRD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?btDb6VhKGGzmoMLumsgZSbiI0L68RxGpVJJz84H5Wmti8NK5w9hazD3EJ6OU?=
 =?us-ascii?Q?StlqirVVRaC5/lb6vhFWUg8vVEMipjcrDos9ykv1noE3KsOjVWqZ+YUyOBOK?=
 =?us-ascii?Q?7XEDhpxIWlWfQ1n9S4TyTZzfltaM2H00iGPCQZfW3pWJQCqKAScSioHnTAGu?=
 =?us-ascii?Q?qzk8aAWkWwyJblRzjH1XIHyVXZ1I8a6PRmsyioe26EuCE5pQOIAb1yboIEmJ?=
 =?us-ascii?Q?IPqVG7qiT8CMmSfOXvZvpyAzNkr7ihQr/gk9uGHyfQRhoNZ/OJlZ3j7DX1e3?=
 =?us-ascii?Q?zs+utB9ZBw7OEB6DKi/jEsPQLwJuQsnV1MdIZYR5jEmJ2E9IRyROl8uy8PKW?=
 =?us-ascii?Q?odxK2vNtggK4iRWInjtHYX4EYxw3rY7VrxshK57QnDovVwkvKYSFjlJjR+eX?=
 =?us-ascii?Q?7LgEtcw6auJJwHNRVpyQwSJ/H5BnF0UsQT8YCCGzMUAWGB2A401W1h1bCz1g?=
 =?us-ascii?Q?6uRik2kvuNtdNcj0/ZPDi9hRJKlg5fsEkYZ81bmNOHL+9XCg6pOUFKi5Oj7m?=
 =?us-ascii?Q?UDrxin2pNjjaO8SzWTGEEF/T1gFA2SoGD07FTkS0ktf+A6HsrDgeaqGD25XY?=
 =?us-ascii?Q?spK4wW+irGH+aNjIUMIiqMLywF4OaUuITLQ7Sl2q40+Kl5O2HSz8883RmVBq?=
 =?us-ascii?Q?L9IDWxiu/KWA38A+uYHwy4T1NeDu5nEhGMT2hgIwyHW6n4oPZ75Vf26afI7j?=
 =?us-ascii?Q?mrJJu2KdyqGLfXh+zxrCb9lvGpi0raQN07MqR1fYyJjuqUKjqizdJ3QBaAdV?=
 =?us-ascii?Q?08ZdD33JQah0HsTflYAeVX036BC5SNEIrFOUPX/8es6pGTxs6S4lpml9Gmwr?=
 =?us-ascii?Q?5FPcGptGoWYxKnD20DuHdt5SaSxSKkfhLJGKG6SLQFFfU3PajVtXd9CmK/Ss?=
 =?us-ascii?Q?vCQqaG/6Qs58C7nhF/4CNSjusrd1xtc427EfFga/Y0CKGh42wpnl/TGnE5i+?=
 =?us-ascii?Q?zp+qRx9mUXK3KEx0SQXq0h+Y7q7odjIJJNR4iPW++N4TiyYEbUD4oMa847Jm?=
 =?us-ascii?Q?BgPzwL5SC4aSZX7ZTnfn/5WlFjf1PAdBKNjuH5YArGSA63KGISHulVEoB87T?=
 =?us-ascii?Q?aUWZ5BaW+pPixATw71sLYpdqYk86L5BNS6CuQiQ38B8Acbq5yyX6ttk1chcb?=
 =?us-ascii?Q?bQVf2SxltU6MnVb8QBZSy+/Fh2+WqZe2voHRM8LaJBEkqeZVVNJyc2DmldGO?=
 =?us-ascii?Q?PUafTy6TXnlAOYj92uhsJZa3Di1P6VF7IpsfJ9TuLithy1GJQH6UqmA66woc?=
 =?us-ascii?Q?MGliXnT+8e/Z7IudR9PBLhKZIsaq8tjiaQnsqralWxvOLE5VJunRwjdqxBZi?=
 =?us-ascii?Q?dL2lc6/m8RkrN4LSz7Li/YWkN5qqfCsKp2FBr+uqlpKPhj0MlScywO4vzcE5?=
 =?us-ascii?Q?uDKLxOb6k5KZaIxUYpSCmwovp6XTecOL1wdSVsctfwnfY02h7xpfUQGEm16w?=
 =?us-ascii?Q?sADBPWMfDZyxyYuqoy96MaJaROjHjNACHLRnJEWKzvKWHydmCY99cdLJjyX+?=
 =?us-ascii?Q?u8E8HZRSMqqaLNvmtY7FV8Ncq2Uo0SPwt0Te5OF0hN8YM/hzwxNEqysPra8p?=
 =?us-ascii?Q?IaBrYxgDpAd2CKVmYmDo8Mj8Uw4gEmlDzR0cuayW77wu356P/iN/jo9Yj/ml?=
 =?us-ascii?Q?4aQJhesX1QpFTOE6/IGR21ZElZFcQhxicDib1/41sAgUzsb6Th/C9jZR8lZN?=
 =?us-ascii?Q?p6MEBHxIjSxD1+VK1lah3/oPq2Ib6L8931Olb8vtJOptqv2k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec655936-2b12-4e27-e75b-08dec1d87ed9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 01:27:52.1326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uh50hjaGP/+7HHemrbzghMEKhgsHxvMD0bdkVbXGJ0sy9mVF0tZ+QdrtCHmxw5gK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21723-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:dledford@redhat.com,m:edwards@nvidia.com,m:leonro@mellanox.com,m:leonro@nvidia.com,m:matanb@mellanox.com,m:michaelgur@nvidia.com,m:noaos@mellanox.com,m:patches@lists.linux.dev,m:swise@opengridcomputing.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B71C63C310

Keep pushing the pdn higher to remove more places touching mr->pd:

- XLT combinations that don't use PDN can just pass 0
- Use local pd values instead of mr->pd
- Implicit MR does not have inplace rereg, so the mr->pd is safe

Assisted-by: Codex:gpt-5-5
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 40 +++++++++++++++++---------------
 drivers/infiniband/hw/mlx5/umr.c |  3 +--
 drivers/infiniband/hw/mlx5/umr.h |  2 +-
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index d7feb49b28fbac..50804b4c90e477 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -221,7 +221,8 @@ static void free_implicit_child_mr_work(struct work_struct *work)
 	mutex_lock(&odp_imr->umem_mutex);
 	mlx5r_umr_update_xlt(mr->parent,
 			     ib_umem_start(odp) >> mlx5_imr_mtt_shift, 1, 0,
-			     MLX5_IB_UPD_XLT_INDIRECT | MLX5_IB_UPD_XLT_ATOMIC);
+			     MLX5_IB_UPD_XLT_INDIRECT | MLX5_IB_UPD_XLT_ATOMIC,
+			     0);
 	mutex_unlock(&odp_imr->umem_mutex);
 	mlx5_ib_dereg_mr(&mr->ibmr, NULL);
 
@@ -318,10 +319,12 @@ static bool mlx5_ib_invalidate_range(struct mmu_interval_notifier *mni,
 			u64 umr_offset = idx & umr_block_mask;
 
 			if (in_block && umr_offset == 0) {
-				mlx5r_umr_update_xlt(mr, blk_start_idx,
-						     idx - blk_start_idx, 0,
-						     MLX5_IB_UPD_XLT_ZAP |
-						     MLX5_IB_UPD_XLT_ATOMIC);
+				mlx5r_umr_update_xlt(
+					mr, blk_start_idx, idx - blk_start_idx,
+					0,
+					MLX5_IB_UPD_XLT_ZAP |
+						MLX5_IB_UPD_XLT_ATOMIC,
+					0);
 				in_block = 0;
 				/* Count page invalidations */
 				invalidations += idx - blk_start_idx + 1;
@@ -329,10 +332,9 @@ static bool mlx5_ib_invalidate_range(struct mmu_interval_notifier *mni,
 		}
 	}
 	if (in_block) {
-		mlx5r_umr_update_xlt(mr, blk_start_idx,
-				     idx - blk_start_idx + 1, 0,
-				     MLX5_IB_UPD_XLT_ZAP |
-				     MLX5_IB_UPD_XLT_ATOMIC);
+		mlx5r_umr_update_xlt(
+			mr, blk_start_idx, idx - blk_start_idx + 1, 0,
+			MLX5_IB_UPD_XLT_ZAP | MLX5_IB_UPD_XLT_ATOMIC, 0);
 		/* Count page invalidations */
 		invalidations += idx - blk_start_idx + 1;
 	}
@@ -502,11 +504,9 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	 */
 	refcount_set(&mr->mmkey.usecount, 2);
 
-	err = mlx5r_umr_update_xlt(mr, 0,
-				   mlx5_imr_mtt_entries,
-				   PAGE_SHIFT,
-				   MLX5_IB_UPD_XLT_ZAP |
-				   MLX5_IB_UPD_XLT_ENABLE);
+	err = mlx5r_umr_update_xlt(mr, 0, mlx5_imr_mtt_entries, PAGE_SHIFT,
+				   MLX5_IB_UPD_XLT_ZAP | MLX5_IB_UPD_XLT_ENABLE,
+				   to_mpd(mr->ibmr.pd)->pdn);
 	if (err) {
 		ret = ERR_PTR(err);
 		goto out_mr;
@@ -647,7 +647,8 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 				   mlx5_imr_ksm_page_shift,
 				   MLX5_IB_UPD_XLT_INDIRECT |
 				   MLX5_IB_UPD_XLT_ZAP |
-				   MLX5_IB_UPD_XLT_ENABLE);
+				   MLX5_IB_UPD_XLT_ENABLE,
+				   pd->pdn);
 	if (err)
 		goto out_mr;
 
@@ -720,7 +721,8 @@ static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 	 * No need to check whether the MTTs really belong to this MR, since
 	 * ib_umem_odp_map_dma_and_lock already checks this.
 	 */
-	ret = mlx5r_umr_update_xlt(mr, start_idx, np, page_shift, xlt_flags);
+	ret = mlx5r_umr_update_xlt(mr, start_idx, np, page_shift, xlt_flags,
+				   mlx5_mr_pdn(mr));
 	mutex_unlock(&odp->umem_mutex);
 
 	if (ret < 0) {
@@ -818,9 +820,9 @@ static int pagefault_implicit_mr(struct mlx5_ib_mr *imr,
 	 * next pagefault handler will see the new information.
 	 */
 	mutex_lock(&odp_imr->umem_mutex);
-	err = mlx5r_umr_update_xlt(imr, upd_start_idx, upd_len, 0,
-				   MLX5_IB_UPD_XLT_INDIRECT |
-					  MLX5_IB_UPD_XLT_ATOMIC);
+	err = mlx5r_umr_update_xlt(
+		imr, upd_start_idx, upd_len, 0,
+		MLX5_IB_UPD_XLT_INDIRECT | MLX5_IB_UPD_XLT_ATOMIC, 0);
 	mutex_unlock(&odp_imr->umem_mutex);
 	if (err) {
 		mlx5_ib_err(mr_to_mdev(imr), "Failed to update PAS\n");
diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index f92f222b899f8d..257d8eacd0363a 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -846,7 +846,7 @@ static bool umr_can_use_indirect_mkey(struct mlx5_ib_dev *dev)
 }
 
 int mlx5r_umr_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
-			 int page_shift, int flags)
+			 int page_shift, int flags, u32 pdn)
 {
 	int desc_size = (flags & MLX5_IB_UPD_XLT_INDIRECT)
 			       ? sizeof(struct mlx5_klm)
@@ -862,7 +862,6 @@ int mlx5r_umr_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 	size_t orig_sg_length;
 	size_t pages_iter;
 	struct ib_sge sg;
-	u32 pdn = mlx5_mr_pdn(mr);
 	int err = 0;
 	void *xlt;
 
diff --git a/drivers/infiniband/hw/mlx5/umr.h b/drivers/infiniband/hw/mlx5/umr.h
index 99192ec67957c7..bda7123781a953 100644
--- a/drivers/infiniband/hw/mlx5/umr.h
+++ b/drivers/infiniband/hw/mlx5/umr.h
@@ -104,7 +104,7 @@ int mlx5r_umr_update_mr_pas_range(struct mlx5_ib_mr *mr, unsigned int flags,
 				  u32 pdn, size_t start_block, size_t nblocks);
 int mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags, u32 pdn);
 int mlx5r_umr_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
-			 int page_shift, int flags);
+			 int page_shift, int flags, u32 pdn);
 int mlx5r_umr_update_mr_page_shift(struct mlx5_ib_mr *mr,
 				   unsigned int page_shift);
 int mlx5r_umr_dmabuf_update_pgsz(struct mlx5_ib_mr *mr, u32 xlt_flags, u32 pdn,
-- 
2.43.0


