Return-Path: <linux-rdma+bounces-13563-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7076B8FB8B
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 11:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8934018A1869
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 09:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0422877E2;
	Mon, 22 Sep 2025 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y8aF3J+M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3772F287262;
	Mon, 22 Sep 2025 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532766; cv=fail; b=hZ+6243HSXCZRvaEMjMBcQFiwlah4htiO8PNJsLCV+uXTyGMOvOLe5szaLnuRh6QZlSnO0wOuD5VLNm4J0rc10L1SOnf8xAeKh/p/lpSV/IL9MTJKXZbbcuC6CtnzS3t0hJd2wkXywT+4WzUlrvPiK+XzxTt8QEua4JHRXvVgmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532766; c=relaxed/simple;
	bh=z9s4sGjFOnXq2QLWCBMXFj2KC4mOjBaez2/opgnroAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VcU+Uec6zGgKe/2WXtBtiNKljNSFpGXCYpwS7ql6f4i8BLnuPNpB3s0f64ZH0mE4cbrpnix++USiT/mhFG//mmmMySyzjK9j5I6ax4aLKs8hH3IiSyrPdE7431htMGxJur/byoB/vTizzyC35FIQOLyjrU59HDfTtv04mmlq2vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y8aF3J+M; arc=fail smtp.client-ip=52.101.85.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lP/CJNH0KsdcdDhjQiaVmsVoHjnvi/1LdIOVf5QQWGBUuOOruSYpFn8h2a/YGwU0yyR0m+OoCAdDX9jpCke0OXzMX7U0uwNTkZzgM6zNf6BngEyVd131yxxHZpqCpWbGjj7/5D28vR/F3Mc1xE8HQVrbkGi5yi09SpF8OWPpPKSYAKgUASN8yJg9mhnAZGojxx6pWk92XK12irxYpVpFUDyDPRbwwOvUanvfvDpu3oD3HVN5uZeAwaTOtAzapNevVpTIvG9FXH2jsTUT19VXWU28u3XMjUGgbW1w9cBQgBDlJUXC10rP4/sT6ql6qRbbvPpMKnEGy8SjlElSfNBGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WP1Jkj9aWQPKPEgdU8XPHg03E8rM9sktxn8jOrbSWg0=;
 b=O0VdQB9Rttvh9kC+7vVBAh3Ps6CfIKb6tyjlOhEjBMEI1FfGaNr2eeVVydAzUNdVLqpuv94zUCfpyCmiL/lBgqE4Ai4GoxsU3qd9pA+o/btRknXkogMmkVmRUvgUJ5PcR0150wJxL3X14vS1pz3Z864t2bjkxXUg9S+CvU62oRZM0IIva/XqbzY0LiZAJgf8nFC+zjDqfs2+/BlHx1b/xEHRauo5eSgItyZn/uvUbnnKiyqizNWqm6vssim9khEk3x9Lchbk7WDQwyhL1V4gR1+x4cls4CXXBCcBMaqqs/JbNgd4wvwyR9ev2dSjQotfiTK5lWhkVO9Lt1ThV1NMwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WP1Jkj9aWQPKPEgdU8XPHg03E8rM9sktxn8jOrbSWg0=;
 b=Y8aF3J+M+J5Ae6zSMegvC+RrLJJpxC0vlWjEGyTGVHi9PcxHxgJcTYi018lppOOTAiA34FSBGdxP4Zr70xmC77SZVKKlanc02gHYFanY0hsdIB2rp8AH+m+5GUU98kh7GmKr/53G843oasBw0rIBAM6ykXGbMKn7KD4+yjMXnC5y5TVJZBhD7z1BHtO8bi0wUue7JoOZatm99r71/3OunwotCtbIE15UWwwTwU9VruA0Ggd6fcLkpnHPDPIKcVeVfR4mBa6QeDuKedEi1vyZqKliE9Tnydx/oLOEUNhXiqF+c9qw/RdJEBadNK7R89DCFL3SojsV+LxdQfLhVeNlBA==
Received: from CYXPR03CA0067.namprd03.prod.outlook.com (2603:10b6:930:d1::20)
 by BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.17; Mon, 22 Sep
 2025 09:19:20 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:d1:cafe::62) by CYXPR03CA0067.outlook.office365.com
 (2603:10b6:930:d1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 09:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 09:19:20 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 22 Sep
 2025 02:19:09 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 22 Sep 2025 02:19:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Sep 2025 02:19:05 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 1/2] net: page_pool: Expose internal limit
Date: Mon, 22 Sep 2025 12:18:34 +0300
Message-ID: <1758532715-820422-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1758532715-820422-1-git-send-email-tariqt@nvidia.com>
References: <1758532715-820422-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|BL4PR12MB9482:EE_
X-MS-Office365-Filtering-Correlation-Id: 44378bf8-f865-45ab-9c80-08ddf9b91ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/+HMWGdllna7YC+04+EaCWrYwBEsaHV2wkr08tBPHzSqvxVY+YSgzYQa1ar4?=
 =?us-ascii?Q?z97XPF/l1/o24j5ZYeMz48Fcu9oj6k9G1IGcFu88ZwiATwAayJB3U8lJ0YAX?=
 =?us-ascii?Q?7UQNOKPq/vzyOqsQ5KSwCsne4/jvGeKHy7DW7tQN9OJYRmqGLcA5hYP33mhm?=
 =?us-ascii?Q?6LLr5iUIF1Akm1Rq6xfQtj5d8Zd+8Ac0iF+jPFOvaLig1KmQrcD44W4cmlK9?=
 =?us-ascii?Q?jrzZeZ5cyzvEhPWsm1k6sCiswoOTxeYhk7I6TNxtn0rfWrdn6RnVYUJXjOER?=
 =?us-ascii?Q?a327nI6/SVYR/8rDpN6lwioUwoZVzlPXSZpAK8USJY7ZaJBT9b/ugzFXSg0J?=
 =?us-ascii?Q?RmTXeBx42+aJVzjEYuBjYRjoG9wmPWaRDywqwYcELnxCEWVP4bh3Jg2Og9Pv?=
 =?us-ascii?Q?4xfGpoKsB59utD/HXSILYAXpG7Q+CeslhcCxd6+F2HDNozYyuPGJxmtb6n7e?=
 =?us-ascii?Q?jxIEqxJyhckVImJcFpZzkelc4ecaiX9fq0k4W2+EhUytbnVrqYLrjAB239lp?=
 =?us-ascii?Q?Tx5QEf7DIL8+0CeaTJIyn68EmHMnt0RUgNxK7PbAx1qNkEOMBOCttTuYkj1V?=
 =?us-ascii?Q?HaxQsaaEir87O1G3otSgQ0pURWsum+cDr5InooVlcWw8Psv4VsclYcJQTbqO?=
 =?us-ascii?Q?4S3bfiLLv9cQMl1rcpdxfg0hBPwiapwQQBHsBTi4WjYCTOOtPGNrJJZ6s9xS?=
 =?us-ascii?Q?m0xawNn4aFgDQaaidfxIlxr/4sSIwhVZYmk8DTiVEa4FisEcImAKWD7c5uAr?=
 =?us-ascii?Q?s9B4Pk3reAmIFlMUBvnsnoeR6PLbiBQqNMF1tW8XeHlMmdO5h70W5DgocNER?=
 =?us-ascii?Q?9gkwxq1AkLCHBfonGvagUJhEyvSVlxz9jIH4ThkiYlESMZ8Ndt0GcvO8dsc9?=
 =?us-ascii?Q?EjQIlxRU6C0Kcp+iyeDBH63/92AWR6TmPMVXLP1jha12Oa78xvKwIx8M1cCX?=
 =?us-ascii?Q?hpK+wnVbogmAWg5LqsTYmY0KjL06Du++0Dfptv5oqNM3r8kuXT/LADn5GVvw?=
 =?us-ascii?Q?X0F2teUrtmjG2xMiPKRT/N6d0lyifV8omoUlGzXYFWOz2UO7aj4pUiYrH1Yz?=
 =?us-ascii?Q?vbQzmTsKRWVYLUb454RLw6jnAhOuwd8KQSq1mAPI34b/TgjXYh9d0fzJ3NMq?=
 =?us-ascii?Q?66JUAzE82FfbAee3hvHMm0aZrZtWz7HGseowtq/aHDob/dadkTBJVO17kL4v?=
 =?us-ascii?Q?IIi1CtEmB2KDmEkmOFJWe/R86BB6mMnHfSud4JmXAXhPTq19aGDZyc7KZjca?=
 =?us-ascii?Q?gKmE2OpwSoSBf16mb/ldHe8nTDCtm99oHfQeFHEXVHEP7ry5xA/8jb+1vcID?=
 =?us-ascii?Q?Z0fO0p0RWHD07Bv4Bc7BXhrv1g2LemlbLOryZPclEzpbWCglM474sFeSUrav?=
 =?us-ascii?Q?4bWgEETUUmMgv0Jk9ok+RaP22Yq9YqtPXki9fdKTWScPgyuHE34GUu4mVpvl?=
 =?us-ascii?Q?7GutgBQveGcCRuZLWESa60Nu7P+rdaKkG3fpYuT9875hMYhTdXqBA8KdanOA?=
 =?us-ascii?Q?LZVeh4uRy59FlAQPLHBGNKOausfQbKddPxYV?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 09:19:20.3032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44378bf8-f865-45ab-9c80-08ddf9b91ccd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9482

From: Dragos Tatulea <dtatulea@nvidia.com>

page_pool_init() has a check for pool_size < 32K. But page_pool users
have no access to this limit so there is no way to trim the pool_size in
advance. The E2BIG error doesn't help much for retry as the driver has
to guess the next size and retry.

This patch exposes this limit to in the page_pool header.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/net/page_pool/types.h | 2 ++
 net/core/page_pool.c          | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 1509a536cb85..22aee9a65a26 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -163,6 +163,8 @@ struct pp_memory_provider_params {
 	const struct memory_provider_ops *mp_ops;
 };
 
+#define PAGE_POOL_SIZE_LIMIT 32768
+
 struct page_pool {
 	struct page_pool_params_fast p;
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 36a98f2bcac3..1f0fdfb02f08 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -214,7 +214,7 @@ static int page_pool_init(struct page_pool *pool,
 		ring_qsize = pool->p.pool_size;
 
 	/* Sanity limit mem that can be pinned down */
-	if (ring_qsize > 32768)
+	if (ring_qsize > PAGE_POOL_SIZE_LIMIT)
 		return -E2BIG;
 
 	/* DMA direction is either DMA_FROM_DEVICE or DMA_BIDIRECTIONAL.
-- 
2.31.1


