Return-Path: <linux-rdma+bounces-14092-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2E1C13357
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 07:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A5D24EA5FF
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 06:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82202D59EF;
	Tue, 28 Oct 2025 06:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t9bl7EZw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3B72C3244;
	Tue, 28 Oct 2025 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761634094; cv=fail; b=i650XWyydunxWRux5bBrEfiGfL7NJqqiTwu2Jqo2PeWCdwhakw08TG5HRgqXOBzb19Jl2XHZkUws1rHSdXNAHKx19qPndrOPx7dULCFnVKqWVF7JWiQc579O9kV+sigZXicsAOTbtr0hHAaGcQBtcSxYyUU6RqvTtvarH72tWVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761634094; c=relaxed/simple;
	bh=GhqWL9TVinjPConP5HqUBtDjth+Sou6AbBYUcd6j68k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poIaHLrDg5HGei2IbnAHmhFrHwR9PExUJDKSBNB+52cjqSBvmj9h1FA9GiQNU3l7ug7czRF0UpdMQXPhqvpCpQZoaU7U4L5Alm/OkM7lFSgR+QN+fDOMFMpSujRoP82GW1H0Gfj+Zp3o4GGNLZyklZpLgiWK2TZZxodXs+Z2F+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t9bl7EZw; arc=fail smtp.client-ip=52.101.62.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rz4eY+XTiYaB1sj5x6GQ6OorOR8bUJoKUkgaso2sJorddX7bJ2ONkPdNKmjnUJ5oOFwfYDH2vubmVvjK6EnL/Vke6GFwv1qHWS6ryObpReaZd6eG8+UwdByL9uM9YKUEB6UTDgyuWOZYB0Hgx3udSyOb+L8AlQTJlFqodHaSXRjPnh0MO4IyR+hnEwFfg1931lu3ZLiaqCaQ4h0sH0IdVNR69A6EasJI6WG5yGLgJTdyvl2Y6Dc7sVaWcqSQN7pEwZl6fKTwVb+xAvFhGg/Fu9sVDlnDBsr7QDuXNXtPgW5MUfV3KaEX36bOKq1daDR0CA8t/SO9Un0aJwbmjX9Stg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GC3PLGXqr7qUur92ikOxDKpVP2mXDp9UpSrDoBhg2A0=;
 b=Nft94MUimVsZQltrkLCqdv+YwHuxIr2l/WjvzdYYUu9Aw8HxF08PJTAvZAltoF7w6zIgV1EoUZbZPgxxIJpY0NQ1EyuibZnIT3i8DDPJgNG/a/NrzCxBjpJ2UH8vtn/IRdCMgnFruLuBB3/Rep4e6d+6EvIgMadJ36pOSaZt2RqOPBgBz+g+hjtDGskBbv7brYGTSw9M4epeDQkqFHMjSVlSg8TC14ZuNSA27HWyVCsPL1YxU79WHzA8V9gp6ZlQeq+c+5HPtwc5Zn71fKLjjhsLymnhgHtMnnL9YDnS1uJ1YDWD4iVYOsEMuowzC0LB/2fr2HCoD5e+SEDipRTq9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GC3PLGXqr7qUur92ikOxDKpVP2mXDp9UpSrDoBhg2A0=;
 b=t9bl7EZw2Ruxs17qu1MBquBs7DJ4ShtA0vzNimiF6qseH8RlepTSag+CNazHqSluNy7YQ3Xw5C/1chHp39gn5eaJC5Lu4UnDFHV/NieJHmkKoJem1RayOt59QXIuG57dUdfSGQNpOCjbuOSYfJklX4AEitr5ysZj287sK1MD01YHpXpMx24RhkDEWnbJVgdWCPOKLo/9gTGfrV1a5A2glK42zzBhXdOMo2eUEfK+IIyLqkJgPvzcElgP23mntZohF+BChtYcA+pnHoCgmNm+CX8YJasvOmlFe5HrxVd3aXfRGXxKrExtWB147KztUF32AQDzJbLzDQfpAJjSaRiRwA==
Received: from BL0PR1501CA0005.namprd15.prod.outlook.com
 (2603:10b6:207:17::18) by DS0PR12MB7945.namprd12.prod.outlook.com
 (2603:10b6:8:153::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 06:48:06 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::61) by BL0PR1501CA0005.outlook.office365.com
 (2603:10b6:207:17::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 06:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 06:48:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 27 Oct
 2025 23:47:53 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Oct 2025 23:47:52 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 23:47:49 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net 3/3] net/mlx5e: SHAMPO, Fix header formulas for higher MTUs and 64K pages
Date: Tue, 28 Oct 2025 08:47:19 +0200
Message-ID: <1761634039-999515-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761634039-999515-1-git-send-email-tariqt@nvidia.com>
References: <1761634039-999515-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DS0PR12MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e43b87-ccaf-45e9-40c4-08de15edf31e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MGsg6123hMoju6ggCx5MM93sYBKZlejJUW3hZWLMjv6tnRboYfGX6ngdsSO7?=
 =?us-ascii?Q?dXuK9Gle3GDFNeYM9OttlOe0pzqTUZOG5qy8A6MitngvieG+LYcMff2F8/7b?=
 =?us-ascii?Q?bsnpt0U/LDcJKre7WEXAyELPAqxCTAxy+TQaBj1200ZS8ED5CFYGa2Mo9ZhG?=
 =?us-ascii?Q?q/iPsLAHQwNnV8BYd8Kd/1bkfM7KTL2nWETt4GfLWcW6syzIzE/lFkOHA/cy?=
 =?us-ascii?Q?5eto5StLwW4wH9buJl1uZYoc44NZFNbhsP8Oug7BNa7RqVRaT60hIzV9nW2l?=
 =?us-ascii?Q?/K7g3Rx6gC1EjAKD9lEdlP1NnxR64x/9Qj8jPIp+e9lsGrIcGwI6dFHxSPK3?=
 =?us-ascii?Q?0+6rj99xH9cdGkCiHfPIK+KBOJxRlQxDMwGYVhfQHmxB7bqzznJh+NTNAGSF?=
 =?us-ascii?Q?Fdjolo4wkP8y8+FsK6m5m6S0g/T4Kpwi+mUEjjIYCeYY1QnhdWoCzBCOPMWo?=
 =?us-ascii?Q?MkjQlxPJQwd2/hvJrur6yKTPn5/IDVWiR0QF7Xu4h+vJHArt0XM+yMfJm3EQ?=
 =?us-ascii?Q?e1DvxfklPVSuLDoIbd2IYMsP2ehBE8uw/JifHH6lGzN2XD+GBYRPlaraJad3?=
 =?us-ascii?Q?MTxeJTOIHH2RCKkFf4KWUntV3RamYSIEsjN3tmk6SZnaMihactM+p/r1hDqq?=
 =?us-ascii?Q?+lSJsDStkzoN30Ka6sHfnQazrvi7fzJh6CxafeB5lwvYYUYmybBLB/wQ+GBP?=
 =?us-ascii?Q?AkxP/I6TTRNHjUQZK1L/lRt2Ctf+3ZTlfxDETeZDJCijQWZt0ZcbXmqejLrE?=
 =?us-ascii?Q?HUTNHotIoJC2qunAyaPvGXliBIu5yfEHGRPiOoyVPwtnm4QxxTtZSuHD1sbJ?=
 =?us-ascii?Q?1/xMeBoYZOVMD5Q57hfSgo52zB5lJ7aheA2Xw6o4aW98L2hax45gUadqEJj0?=
 =?us-ascii?Q?z9INSH7kO8gLa1AhPrFHrk2maICZDyT1odhkPWImKLDP9qJ7SixhxbXkRZpq?=
 =?us-ascii?Q?l80OEL36CVaIxQ55lgxiUP9pgzboXKlQjaTnTtZzz2EIm3pYHIj0FtUeRKz8?=
 =?us-ascii?Q?A1PW3Nxdac58egpvu8rbhsNURisnlR7A56Si2x+E9+qB5NqgAzRbPAhL32yz?=
 =?us-ascii?Q?ZCLxx2LCtJx8v+JqzXNTeQxyywsJTtiRXvKf2OvsQu/FFcrNW7UaoBgE+4ev?=
 =?us-ascii?Q?HC2RQG+skINv/LIG1bkMgLBJ6MB+SEQRJXVOuxJliZKaaGF4r4wTPKlt2ih7?=
 =?us-ascii?Q?BtARy2cL1Oetz253XOKk/G++Azgvrll1rddAF4Ar3GLaW9qAghVMqrBY0rZE?=
 =?us-ascii?Q?mSj0TIXrkitO21zbyyMLxedyfy1c2QAeXIcSYlCrtg6X2+yZVou1JFbhF4wG?=
 =?us-ascii?Q?Y4QC876Cvmd2gdBtEoWApCONeJNsTiYssRXoFjl7rQYqdVhTTRbA9WJP81br?=
 =?us-ascii?Q?8dpCWGWCCT5RUPIG5dWurghrDXD0kiU78PylKtWSkCbgLFub4WvpAXvFwMJ+?=
 =?us-ascii?Q?VhN9Xz8XwDfg1hR5G0i+7v3C+zCAoF56VM+Skoe5TGsqA91/E9wHAeAADUwm?=
 =?us-ascii?Q?fbC41SkKIIYimpExEPiF1YDJh0hsecu0x+EM3KGjazTD886bZkHY5wtXGoWs?=
 =?us-ascii?Q?WbJaLsc4F95svvMHgI4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 06:48:06.1657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e43b87-ccaf-45e9-40c4-08de15edf31e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945

From: Dragos Tatulea <dtatulea@nvidia.com>

The MLX5E_SHAMPO_WQ_HEADER_PER_PAGE and
MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE macros are used directly in
several places under the assumption that there will always be more
headers per WQE than headers per page. However, this assumption doesn't
hold for 64K page sizes and higher MTUs (> 4K). This can be first
observed during header page allocation: ksm_entries will become 0 during
alignment to MLX5E_SHAMPO_WQ_HEADER_PER_PAGE.

This patch introduces 2 additional members to the mlx5e_shampo_hd struct
which are meant to be used instead of the macrose mentioned above.
When the number of headers per WQE goes below
MLX5E_SHAMPO_WQ_HEADER_PER_PAGE, clamp the number of headers per
page and expand the header size accordingly so that the headers
for one WQE cover a full page.

All the formulas are adapted to use these two new members.

Fixes: 945ca432bfd0 ("net/mlx5e: SHAMPO, Drop info array")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  3 ++
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 24 +++++++++++---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 33 +++++++++++--------
 3 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 14e3207b14e7..a163f81f07c1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -634,7 +634,10 @@ struct mlx5e_dma_info {
 struct mlx5e_shampo_hd {
 	struct mlx5e_frag_page *pages;
 	u32 hd_per_wq;
+	u32 hd_per_page;
 	u16 hd_per_wqe;
+	u8 log_hd_per_page;
+	u8 log_hd_entry_size;
 	unsigned long *bitmap;
 	u16 pi;
 	u16 ci;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 9c46511e7b43..6023bbbf3f39 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -791,8 +791,9 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 				int node)
 {
 	void *wqc = MLX5_ADDR_OF(rqc, rqp->rqc, wq);
+	u8 log_hd_per_page, log_hd_entry_size;
+	u16 hd_per_wq, hd_per_wqe;
 	u32 hd_pool_size;
-	u16 hd_per_wq;
 	int wq_size;
 	int err;
 
@@ -815,11 +816,24 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 	if (err)
 		goto err_umr_mkey;
 
-	rq->mpwqe.shampo->hd_per_wqe =
-		mlx5e_shampo_hd_per_wqe(mdev, params, rqp);
+	hd_per_wqe = mlx5e_shampo_hd_per_wqe(mdev, params, rqp);
 	wq_size = BIT(MLX5_GET(wq, wqc, log_wq_sz));
-	hd_pool_size = (rq->mpwqe.shampo->hd_per_wqe * wq_size) /
-		MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
+
+	BUILD_BUG_ON(MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE > PAGE_SHIFT);
+	if (hd_per_wqe >= MLX5E_SHAMPO_WQ_HEADER_PER_PAGE) {
+		log_hd_per_page = MLX5E_SHAMPO_LOG_WQ_HEADER_PER_PAGE;
+		log_hd_entry_size = MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE;
+	} else {
+		log_hd_per_page = order_base_2(hd_per_wqe);
+		log_hd_entry_size = order_base_2(PAGE_SIZE / hd_per_wqe);
+	}
+
+	rq->mpwqe.shampo->hd_per_wqe = hd_per_wqe;
+	rq->mpwqe.shampo->hd_per_page = BIT(log_hd_per_page);
+	rq->mpwqe.shampo->log_hd_per_page = log_hd_per_page;
+	rq->mpwqe.shampo->log_hd_entry_size = log_hd_entry_size;
+
+	hd_pool_size = (hd_per_wqe * wq_size) >> log_hd_per_page;
 
 	if (netif_rxq_has_unreadable_mp(rq->netdev, rq->ix)) {
 		/* Separate page pool for shampo headers */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index ea4e7f486c8b..e84899a47119 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -648,17 +648,20 @@ static void build_ksm_umr(struct mlx5e_icosq *sq, struct mlx5e_umr_wqe *umr_wqe,
 	umr_wqe->hdr.uctrl.mkey_mask     = cpu_to_be64(MLX5_MKEY_MASK_FREE);
 }
 
-static struct mlx5e_frag_page *mlx5e_shampo_hd_to_frag_page(struct mlx5e_rq *rq, int header_index)
+static struct mlx5e_frag_page *mlx5e_shampo_hd_to_frag_page(struct mlx5e_rq *rq,
+							    int header_index)
 {
-	BUILD_BUG_ON(MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE > PAGE_SHIFT);
+	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
 
-	return &rq->mpwqe.shampo->pages[header_index >> MLX5E_SHAMPO_LOG_WQ_HEADER_PER_PAGE];
+	return &shampo->pages[header_index >> shampo->log_hd_per_page];
 }
 
-static u64 mlx5e_shampo_hd_offset(int header_index)
+static u64 mlx5e_shampo_hd_offset(struct mlx5e_rq *rq, int header_index)
 {
-	return (header_index & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1)) <<
-		MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE;
+	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
+	u32 hd_per_page = shampo->hd_per_page;
+
+	return (header_index & (hd_per_page - 1)) << shampo->log_hd_entry_size;
 }
 
 static void mlx5e_free_rx_shampo_hd_entry(struct mlx5e_rq *rq, u16 header_index);
@@ -684,7 +687,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 		u64 addr;
 
 		frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
-		header_offset = mlx5e_shampo_hd_offset(index);
+		header_offset = mlx5e_shampo_hd_offset(rq, index);
 		if (!header_offset) {
 			err = mlx5e_page_alloc_fragmented(rq->hd_page_pool,
 							  frag_page);
@@ -714,7 +717,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 err_unmap:
 	while (--i >= 0) {
 		--index;
-		header_offset = mlx5e_shampo_hd_offset(index);
+		header_offset = mlx5e_shampo_hd_offset(rq, index);
 		if (!header_offset) {
 			struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
 
@@ -738,7 +741,7 @@ static int mlx5e_alloc_rx_hd_mpwqe(struct mlx5e_rq *rq)
 	ksm_entries = bitmap_find_window(shampo->bitmap,
 					 shampo->hd_per_wqe,
 					 shampo->hd_per_wq, shampo->pi);
-	ksm_entries = ALIGN_DOWN(ksm_entries, MLX5E_SHAMPO_WQ_HEADER_PER_PAGE);
+	ksm_entries = ALIGN_DOWN(ksm_entries, shampo->hd_per_page);
 	if (!ksm_entries)
 		return 0;
 
@@ -856,7 +859,7 @@ mlx5e_free_rx_shampo_hd_entry(struct mlx5e_rq *rq, u16 header_index)
 {
 	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
 
-	if (((header_index + 1) & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1)) == 0) {
+	if (((header_index + 1) & (shampo->hd_per_page - 1)) == 0) {
 		struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
 
 		mlx5e_page_release_fragmented(rq->hd_page_pool, frag_page);
@@ -1219,9 +1222,10 @@ static unsigned int mlx5e_lro_update_hdr(struct sk_buff *skb,
 static void *mlx5e_shampo_get_packet_hd(struct mlx5e_rq *rq, u16 header_index)
 {
 	struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
-	u16 head_offset = mlx5e_shampo_hd_offset(header_index) + rq->buff.headroom;
+	u16 head_offset = mlx5e_shampo_hd_offset(rq, header_index);
+	void *addr = netmem_address(frag_page->netmem);
 
-	return netmem_address(frag_page->netmem) + head_offset;
+	return addr + head_offset + rq->buff.headroom;
 }
 
 static void mlx5e_shampo_update_ipv4_udp_hdr(struct mlx5e_rq *rq, struct iphdr *ipv4)
@@ -2261,7 +2265,8 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 			  struct mlx5_cqe64 *cqe, u16 header_index)
 {
 	struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
-	u16 head_offset = mlx5e_shampo_hd_offset(header_index);
+	u16 head_offset = mlx5e_shampo_hd_offset(rq, header_index);
+	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
 	u16 head_size = cqe->shampo.header_size;
 	u16 rx_headroom = rq->buff.headroom;
 	struct sk_buff *skb = NULL;
@@ -2277,7 +2282,7 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 	data		= hdr + rx_headroom;
 	frag_size	= MLX5_SKB_FRAG_SZ(rx_headroom + head_size);
 
-	if (likely(frag_size <= BIT(MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE))) {
+	if (likely(frag_size <= BIT(shampo->log_hd_entry_size))) {
 		/* build SKB around header */
 		dma_sync_single_range_for_cpu(rq->pdev, dma_addr, 0, frag_size, rq->buff.map_dir);
 		net_prefetchw(hdr);
-- 
2.31.1


