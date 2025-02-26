Return-Path: <linux-rdma+bounces-8138-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23825A45F14
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 13:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8018B1889EA2
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 12:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1499221D3DF;
	Wed, 26 Feb 2025 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tjZriNvj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5360F2192F0;
	Wed, 26 Feb 2025 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572816; cv=fail; b=gkuGjp1Y3ayqBnIdeDWOH6jLkyQ9ms9RXrIRFabciIufIfcvJgR8HHaNErfvEkSaBeEQYnycKQ75OrXom2jADznwtBTdTOU+naggeIFKzZyq4++9rZFYI+pZZTk979rqlrfpmaxhMAZUQE335zM8wXsQVgPdDR4LJPONR0EYb8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572816; c=relaxed/simple;
	bh=8OESgjOG301uqCdCLVrfS10OIx/eBClDuyqiPaEbkg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOerlFLXqRy/u1jxVXIOooCtITVMoHBzGFr14UGNGZJvV8lD2p0oZvhZYEFUa7DtohMRGC1kPCcY6szjX03N4iHyPV8WoiVaRe53sbY/X2VPTIVoygXuOGvsvdsZhm0WkhWxgPoJZ26e+rdfV3XHRpm//jHrdExFccaTO07Ow90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tjZriNvj; arc=fail smtp.client-ip=40.107.102.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvdEHSd+LBruOwNY1tswuNqq34ZZ8JDn5JBuGsyU5HEy2m6B0Cx4vmGOlcjxEZBs3Y4lWDS5XQ+TWj90stAZwZszaQzsO4clrx8l4ovqtJaUMZMorwrfjG8ierYR+MUGKNQkixudjwDEOWltxuKfx/QtdcwSBXepAG923j4Yuocc18J1JtNFV1M6koTCtFTmh6S0OM/7NRJgK6j3LHT4w12COHJV1NrdwR7N+XCv5WSVrbHP0ZvBwO6YeorAr1zQprO0PhLg6dcR4L/TrNtaGAMDxRsPvIHmJ6gNtRwM6HnX3LGDrh81SgSfkziIg7Ae5bX4nHGO3y3TBFeRGUphzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9Lyuh+dtQ1iJI1OCjrwDXSDa2xXpKzIUCedBsbIVRg=;
 b=v96TwOm09gW4cgf+KpP2jfez2DRnV4i1vsDszf4bYMUbrNE7HkQE0mk5TIcGjGVdHInm/wBuqjHvkYGo8LcB6i+cKsRob2r/tiFNxf9Vrnx2K756gh3AVwrRCXx5kWrPyOLMm44RBL0+BStkJYgCM5WKheMFHmKstbWqzM12Sy4PZeOY2LM6guNpidj7WGygnE+G+dPn1WnqCKgOP2sxN7jLJhO7770X6NA3lejGbEZAcYgaYpMh46v9xktu3l5aZnbD691xYYyqs9df8AMC/BGZjq8l3YF9LoFfDV8/xJfh+aznOtm9yrsi+rewPk/jKzKi8BvVKZo9K4ZtJujFnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9Lyuh+dtQ1iJI1OCjrwDXSDa2xXpKzIUCedBsbIVRg=;
 b=tjZriNvj7z185N5Yo6b7gfGQU6mpWdUlAXBbI8FYeu+U0CM1MV/wU7YK4wmo0RM6F37GQvT3JswGaMU6SiBSptj+yWeVUIc/fI6Z1lOuPaOaOik6FMGTWNaLZitIQf1bVQokrzFJy1mKMml9xqnMF0Rit5BuJujZxoWZcogrEUU8pok8+7cBHKFM32ed1IRa8PfDSuhi4DJP10j4yw5x32XUY5tSt8NDboDIW1MZ0J1vYa3iwQQZIYnbTKa2y73LQKOJExVsQXuedYa6/LxHU7i+JPud0/iLClsvbjz+Q4RmuLE4XU1mNKVqCvYBTcTFlHg72LF8Iwnxfi2Oqj+w/A==
Received: from MW4PR02CA0019.namprd02.prod.outlook.com (2603:10b6:303:16d::23)
 by LV3PR12MB9438.namprd12.prod.outlook.com (2603:10b6:408:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 12:26:52 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::c6) by MW4PR02CA0019.outlook.office365.com
 (2603:10b6:303:16d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Wed,
 26 Feb 2025 12:26:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 12:26:51 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 04:26:42 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 04:26:42 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 26 Feb 2025 04:26:39 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>
Subject: [PATCH net-next 2/4] net/mlx5: Log health buffer data on any syndrome
Date: Wed, 26 Feb 2025 14:25:41 +0200
Message-ID: <20250226122543.147594-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250226122543.147594-1-tariqt@nvidia.com>
References: <20250226122543.147594-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|LV3PR12MB9438:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe97dbc-35a2-4d58-97e4-08dd5660d8dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9i9iCxFquiNAJbQml1VB5tAlmZT9jNGbknwD2ycDnjipBXy6bnXoLt3nrguv?=
 =?us-ascii?Q?dlBrLZD2NWArsV/o6qmmz/IMBIw3a+t525kcE+IEalobzYABJMdMFY6iYB3z?=
 =?us-ascii?Q?dMNj1XEODaQAkOmjTQ+WIiehAceR4IV2mdI8n8Rfg8IrTE1osP8nkYkgq6hA?=
 =?us-ascii?Q?oNuC1p6QHAR5D72o+vdIpL6ONo3aay4b098YUgZMl8d1ziH5jM6cOg6FwnUs?=
 =?us-ascii?Q?YbWydxItq2L5bZxH7ZTLaZA4y/yaaGO0XZIp//+IMy0ZDJd8nNHcWwn2gWUr?=
 =?us-ascii?Q?jFhq6PTo9kdpaBh3p0/RHJ6fRO/T/fOXm95Jy67/7QyTe3d/S4CcP6ULcho8?=
 =?us-ascii?Q?uZ9My4/HoAsxFjb9BpKEDvMv6+qS84UiWUDjbH55NnqXTkEYOfdW5O+JxG63?=
 =?us-ascii?Q?hYvZXAPE0TuMJs8ydgdgFziHtZlnJMlCzczz9U4cqoM1n46T2yrcVqzoElTr?=
 =?us-ascii?Q?L846GoJqzl7QL9q9ykMYwyBJLyiro59nCK0rbhcDh36Hurp34+uALYdUxNKT?=
 =?us-ascii?Q?UthPmFKScBe1proRuSDAwh4u+yTMXQASSUJX1D8OxsORycuWwmQQwcTsB34X?=
 =?us-ascii?Q?yVFgPlWV0SjC58TtK4Da73PnXi7t7KQo3YYehfA4nEs0n/pbjuh9MxkB0fhF?=
 =?us-ascii?Q?WvJkqvlg5hD8jFbBkS7hxjsS2NL3O8CR7SC8t4Oj1CSyLA0tpN8rhiPM5ptM?=
 =?us-ascii?Q?K95EyOaGqmW65lSH6wRs8B9MdBDd5l7otXnGtPfYgbKYBxCJOqrUMEvYt1x0?=
 =?us-ascii?Q?Zvnx5Y2VArZuqBQaQ+ebQQV6sX4/tLVAeiaE+6S7fnOqeXjF/udBCkA5yiLV?=
 =?us-ascii?Q?B/aiOIUCDL+/l1QY0X07Q8MC/fRGTheRkw8+W3Ira7RD4k03zvRQCoHf+ufR?=
 =?us-ascii?Q?GHhtDmQc9QzI1t/tk3LM7Rx8/OcNyZeRONdKgLRdqR1avRTVbyTXJQ3ITJ3Q?=
 =?us-ascii?Q?K5kUaa2z4qQrkxZOOzm/5h3X6fM9cvjS7Xagl4Lc2mlmZ6zY3U5H2JxEcEop?=
 =?us-ascii?Q?uMxYLiUcYuwOGZ3nxHCi/8Q6kczWluDTwhijw2tJyca7chWBViYpVt9hL+P8?=
 =?us-ascii?Q?TS1gAq586UwM33JWQBmfjQY4DluwnXlNq+qdlmPhvc/KFEi0hiKgirFyq3eI?=
 =?us-ascii?Q?RUy/bBYP7X7empLHkXTXaCHq7QukmG5J02qqBIYnU1rwZxzibETa3KYK7+7U?=
 =?us-ascii?Q?jrsP0C7B+RoyMMt2oBamFsEoaPapML+eWjvJdMr94yLAjrWtJBx/aIEgVP1L?=
 =?us-ascii?Q?5Jq0Y6fli7vwMCDCzHNnr2Q2VvaUIvwkSz5NqGTUWx5HKnOCc2m8O04DPSdF?=
 =?us-ascii?Q?m6jsjpGTdmtxBMzhbVabBl3sYRnej8Bab78daFEHIoHpbFspo5dKsQex0H4a?=
 =?us-ascii?Q?fEzfZwoFoIHbjcWvzP2wwUU38ERDb0IPxdPu7rVSK08XHN63ROu6bnhNYBHr?=
 =?us-ascii?Q?DG6e/TQnjalWqkRWu1OCVwUK8IkmMRMdojLnTN0148/Q/ZZtofOjtYyapozC?=
 =?us-ascii?Q?JNwGOuExnU5MEMg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 12:26:51.1572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe97dbc-35a2-4d58-97e4-08dd5660d8dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9438

From: Moshe Shemesh <moshe@nvidia.com>

Currently health buffer data is logged either when FW fatal error
detected or miss counter reached max misses threshold.

Log health buffer whenever new health syndrome is detected.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/health.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index 52c8035547be..665cbce89175 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -806,8 +806,10 @@ static void poll_health(struct timer_list *t)
 
 	prev_synd = health->synd;
 	health->synd = ioread8(&h->synd);
-	if (health->synd && health->synd != prev_synd)
+	if (health->synd && health->synd != prev_synd) {
+		print_health_info(dev);
 		queue_work(health->wq, &health->report_work);
+	}
 
 out:
 	mod_timer(&health->timer, get_next_poll_jiffies(dev));
-- 
2.45.0


