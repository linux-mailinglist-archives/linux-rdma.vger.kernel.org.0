Return-Path: <linux-rdma+bounces-20681-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCgoD+aoBWrtZQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20681-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 12:50:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF5854096C
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 12:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED6BA3014814
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 10:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042BD3B19D4;
	Thu, 14 May 2026 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EuP+fTpO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012055.outbound.protection.outlook.com [52.101.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B263B1034;
	Thu, 14 May 2026 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755810; cv=fail; b=cq4j6Oa0KD/B9n/bwcZMhvVSE7EVEN4wWw6dfHjraAsfnvjTz/3cGumxW3dWqBtwNKHPNBq/tJwgwZpKEilL8xyw2BdqMVFwrrfMd82k3+6OgryFJPc7ExufuOekv70HQmZljrjMlYTeBBALcb02RN2q4fU8+NUddefYSRS1+U8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755810; c=relaxed/simple;
	bh=BIrdIlIQLG6uPFtvrZkzlXEBSXW1utp7zn/J8Pl/m+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dq0kswpwj8CZ0JWjvYjmn+AZSZ4wYP2zeOeZT8qPJbNsU/dbmFJBO7+rTn9NH3o0CYXWaPt7FPKst9ikzwDXl2ARTypyvnuzc5j71vIY66PsECO4kBJLKtmt6pR0j5P3LfeuoyMisvetcRRRafv2kWDfGJyuRKhCD8iWFopMePo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EuP+fTpO; arc=fail smtp.client-ip=52.101.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SU2TlIh3oqpl+B1MG25zvnbvrhOHJhO4i7gtD8morzVDvgdWRC9g2KOVay1Cf3flzFi0RKRWBRD/TIvrmJ7lvIOWSFW2Sab2DR9mkxA/97IneQlQOdwvfkkcFi1hCYA8Im5ebJPuKOtnypU3y08NW2gKXBYnmgrbUikcrp4OdLHIIaKKgC86RHcPaRnaVZU7oC9tRNdrS5UzP93oIqNXVIpmL1anlqJDshCcDI1fl3CI0VaYrdnFIrK2fRR2JSrd3y879xHoTIb9qMcs5XxWZIP7rvgrIy3lig6SGzGBgtay4s1l+rmKJJxsmY3uHMnwqYY3Hey+KNhqJJM1pMtBUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4EiB2D+Bwr+DOQm20I52mKcwqfFdHVb59myw8G/nHc=;
 b=IiHls0I3FyNXho5GGJI9YM0DqK1mSpl5kblXsgpAawSkJoMMg87s4IV4do3JfU64mv3M/rSr6YOVDYcNxbcGUQe4lurZHJYIh5FDxFIzbpFzXjtdgiij0kIXF3vrdmFQu0gWGxfRq0260Fy+9nhTvFSkY0NvBU7d/PXx8dr+1NrcIJ0CAwuEYJcmkXLhwrsy3wf/QPM5GMKkZu/XXDNPZYTkO1N8U9/TQ+7mHcL9aArRsC5OkV9h12qQd0EvPk52sOzofYV/gbEI3hMo8PQUImSLLDNOU0fgz07I6lclxmze2r+oQS4+gGHLs8VlIKDnKRJFaj6Mp3094IG6feOJDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4EiB2D+Bwr+DOQm20I52mKcwqfFdHVb59myw8G/nHc=;
 b=EuP+fTpO0hkJQQFlNP5qX65L/sgn5Rr6gRc8KpEMi/D9q7dyxsyt+cMwIzfiPi0L5lJ3aEV7yy/AQ4ZBuMRrLpTNi4dbz/PvCbrCXpwzlT9WYzfNIYaQi2UOTHJwRkZI8utt12woEpkar2F3f2cJzKARC+TJQJUULGldnUR6Rg40W88oGanXu8cUh909iowapzxBPKyDkRaoycmfA3ve8fIU6VIKeX3IhEyfA+EtZV5KNm9KqJRZjBajpBm8piij5krC+kYj7wHSVaseBkOp9Ms1pgz/MFYOUGG+qmi62G5JimgcuqRGBuh/Tf43OUCwSvozqRZCkwS+cFQaxul+OA==
Received: from DM6PR10CA0034.namprd10.prod.outlook.com (2603:10b6:5:60::47) by
 DS2PR12MB9639.namprd12.prod.outlook.com (2603:10b6:8:27a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Thu, 14 May 2026 10:50:03 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::51) by DM6PR10CA0034.outlook.office365.com
 (2603:10b6:5:60::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Thu,
 14 May 2026 10:50:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 10:50:02 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 14 May
 2026 03:49:50 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 14 May
 2026 03:49:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 14
 May 2026 03:49:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 1/2] net/mlx5: use numa_mem_id() for default frag buf allocations
Date: Thu, 14 May 2026 13:49:24 +0300
Message-ID: <20260514104925.337570-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260514104925.337570-1-tariqt@nvidia.com>
References: <20260514104925.337570-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|DS2PR12MB9639:EE_
X-MS-Office365-Filtering-Correlation-Id: 628cae2c-997a-464a-4aff-08deb1a68d88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pCpSyBSPRiuXJ8knXJDzoVPqURWff5iLEmUfxq7JdLlzrR550mJsgJeTEmSaBZuuVVdCs+XaYE8FezQrVXidz5G8gYpdgFxTTmNbeXX1uXlx6dUDC8QXXebTTVj4sWfHxnFtP8+uexrPnp3T6zhPVdK84IpmZeALP8UpG2kt1mVO7DDUwHuUAdAfwfQjx64pMapd7PpUSRFlHmeYyII0MBZjCItF0jPFhcKmOjfk3WSpjzK+0mXwPto2mPKK9w9i0hIjgvAi95/LWl3bjtmIapoSrGMoGzVkIP61uf5I+UZzmNsSEew2fu/n0lhcVhldDfO49Zv7JRO3YH4ncb2hmUfsL3G3sLVA6AGgSHbkxtPx6JwT5XSOCJNLuTvq4rHwN1r5E8rlAW7k3TmXvY6ZI2HKjkpd77JFIUgN/6Z3soL0x7pZTiEcm2BtgsmpQvJPviXiATu302RB0tMsSBSWX6767A2REI7ar1SUSQfI+kRSBgQl5Yl0blKzb54KOTcViHyogvCcMAREr1KT8C4QWrPnCXZohwXaRMg90xMEDREYU5vl8wwmHLqIpnFf8cP5hVO8EN3hUmZ8wDPR77+LzE7nOtTIQqcxJbGzww51QkguEqWrSR8jkhbcSq+FoyXko3+MvfaG2x3//BEKIra3MbYQDVvChlm26kncJ285qLnYhiZI+Fm1VuqJphpY5/e+XQB61IWr8KFYHc1Yb48DCrWs27k7kLejG8aFrukpybY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(11063799003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nk5AXoMNAd5BOb12NAE2gcluvdrd3S11gC9M7Q/1MlnXBRSoeJHsdhvdVdguC9pMKMBjTYvigHXpiTLfpmOazkz6LQJAtyCY0vkM3wE2Z0jXDkcMJpOi5itDCSS7heTmAdErKEmbMX2Nn7vJYrLAT4IfeW0VXgd9u1cSV8n1dc0Vu/P/UUsEDu4EXiymNduLqtS8bSbDotQp1tXlrvpic9zxwjPugPjIL+WYno3Jv3ap8t24T71PfiG+HRYBzZjNXhk15jfmZMvbsVSDv8dZfrf31rcFMV3Ba/oL9so47Vsw5FSBBTqjBBlNsFaA7hdspnhAVMlRuJl05IJNxeObLnToF/LYE3lDxq3+PhzwhpNg32yrYi38xhEv774IQBg9AYts+AAxeKlPEuKnqHFYeoicAWjSkakKjpGcrDUQrmhPOyjrtrOcHUWeDnNm6LGR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 10:50:02.9123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 628cae2c-997a-464a-4aff-08deb1a68d88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9639
X-Rspamd-Queue-Id: CEF5854096C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20681-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Nimrod Oren <noren@nvidia.com>

Use the current CPU's local memory node when callers do not request a
specific NUMA node for mlx5_frag_buf allocations.

Signed-off-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/alloc.c b/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
index f19644183828..16d6b126a486 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
@@ -305,7 +305,7 @@ int mlx5_frag_buf_alloc_node(struct mlx5_core_dev *dev, int size,
 	struct mlx5_dma_pool *pool;
 	int pool_idx;
 
-	node = node == NUMA_NO_NODE ? first_online_node : node;
+	node = node == NUMA_NO_NODE ? numa_mem_id() : node;
 
 	buf->size = size;
 	buf->npages = DIV_ROUND_UP(size, PAGE_SIZE);
-- 
2.44.0


