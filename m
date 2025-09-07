Return-Path: <linux-rdma+bounces-13137-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8ECB47A2F
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Sep 2025 11:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2593C37A2
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Sep 2025 09:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEC22264B6;
	Sun,  7 Sep 2025 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BM8/BsTu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DA21EDA0F;
	Sun,  7 Sep 2025 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757238068; cv=fail; b=FqLFwx1IffNJhpXkyExhabh7NdtA/qwe3JHzPH8cG1+UP3Tw18aQhP8N48xgUFu+orjGafMXQJmntPC65RBLtlu3YfBUzmv+VI+EzGtbiavBXEF6nG+z5PA4l/hev3uCe2W0usilyLQJRykaKwHwPp/BW3w4tl5Od/ft9CKetqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757238068; c=relaxed/simple;
	bh=DldPVdnY5SFmFAs54B+Ihdd8mCsRPpZnNBErY/Hixa4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QfukpKA6WEg4tqK24vpSBJICAS57B1kHFnmTHrGdvGPd2+a/w/kpeLT1qAvUC6CAUo36dVMvjetW6p0B4qrX2VCQqzJrXWBbuTTeXMT3gvaS+GSh4nCeggTFVRoZr7gFhpTQltt04UDyqV9YjnWNbCbMTuqquR4vO6JCNb81Eik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BM8/BsTu; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ln3C+QvUuf40UML0EWBKYVadkpNSfBODyVqj5fchg/G/EHC+CKkjSO1yQZT9iX9rNyDv9TPx2PQpWlfW6dsR2hPhCnfi2tAxhJ2lhURZccBpny46PcUhkI8eHazSM4ivhAYDrBHC0wXVyNVHo7w43fzYd1J0O/WlC9Rb6ymfoh8+I8VNbbxL4uUU3BCErRf9IWmvoecFW/Xd3Z3iWB5b2heJ1Hnf4XwK1wvsn5jy5mihuNCM/rYyf/p9icTp+K+YujWxSLX4fryTQN8tnwx47abNZq1ZVOsgyk1UfF69IZJjiQW82jjWjeyexH1/1zhGAntxTNCbHH1yJxYWrMkvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uajMb74mAMwI1zIC4c8YlkWVlMr2xrwKOLela5paoYg=;
 b=KJU+bafh0srvcZMH1JpcOT5zoUJ57t55Cc9qG8cDfZdQo6unuUGtu+xiqGiqow+q9t9g71A/lMrnbglw0T/6pS1Yf4UlZkXNP/43kH1DjmFbcQ7stqTTD1hAsQSnNnsRWf7wR0eNZkP2etHxZJSpiKIvV3zh4uBYqL5Tl1N+/njg5vdCY/88wz2KfxocRFcigHc71xQZnI2c1tgRaVMKt2dsRyg0CXfJfBmSbClsC4uWS0HeqI1tRfnnx9un8rjWQ8Qiz1FULigRu56oJ1h9FsBdcM28j3N3lVh3jXOIRAiD+CBEhdpjzxzwOBLHuh6tr5O9ZFFrCqJHrk2pznPICw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uajMb74mAMwI1zIC4c8YlkWVlMr2xrwKOLela5paoYg=;
 b=BM8/BsTuSHI8CCOl85k2VJCs+0aPYAPEC/BFQcF/nNnK8HF3GGp3x+Np7CHJTlCaULEfUcWw3MmvPWePA3P2M1y7laJAZ7Vh7klu1TOj6TzXfI3+UYYCresQzFDpt0ABNdBOdhWM0n/bgmKdG6solwy5zPWgk1RzGPeuf+s9FIMj2ov5ba2U89kGEzS47DQ4LBbSqIgqBSU/K8iuXBXNyvzAfFCJ/9Gi3S4Awnlu8QW0mi6Aq/ljSRQGUA3rizP77DSrUNJUabhSzCansja3Tt7o4Oc4GO7G+dX+epiQa70RJPyB+MvD7PwKwGGSRLO/W5L0QBYr+HB8aJp2pU1Zgw==
Received: from CH5PR05CA0008.namprd05.prod.outlook.com (2603:10b6:610:1f0::17)
 by SA1PR12MB7224.namprd12.prod.outlook.com (2603:10b6:806:2bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Sun, 7 Sep
 2025 09:41:01 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::54) by CH5PR05CA0008.outlook.office365.com
 (2603:10b6:610:1f0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13 via Frontend Transport; Sun,
 7 Sep 2025 09:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Sun, 7 Sep 2025 09:41:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 7 Sep
 2025 02:40:53 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 7 Sep 2025 02:40:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 7 Sep 2025 02:40:48 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 2/2] net/mlx5e: Add stale counter for PCIe congestion events
Date: Sun, 7 Sep 2025 12:39:36 +0300
Message-ID: <1757237976-531416-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1757237976-531416-1-git-send-email-tariqt@nvidia.com>
References: <1757237976-531416-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|SA1PR12MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 590f5178-8347-44a1-0916-08ddedf2a7ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qba3o5DYH/HguBkE44m4tvlWh3ushsHIT3EUlYCMVjnUPGZo28y7WGuorKZm?=
 =?us-ascii?Q?Wwd2ujA631Cvdq5D7RjpXF7atjpTjiO1fvsLmkyfjqft4mbT/ZUbavuT3ZpV?=
 =?us-ascii?Q?zZgxdQDomsP4R4BeDdweo2aYIkGqp0aV/hd9wiuQgB0FN7KbzWdgq1MnmF3B?=
 =?us-ascii?Q?0Qb52LkDleB8XUoDhqYUBvt+jncfJoFoOCZC/GoRnQgY6rr5pn82LNWsnwTC?=
 =?us-ascii?Q?hityw4V0SSZOlYrHrcrW9goTpvSeLsgxmRxnVBe6CuATrgs2xf39xldKwSQ8?=
 =?us-ascii?Q?kH3SGXxaTYg5EL1rP4H1PVYZfErF/0QgY7GVMtf8yZgtgtXnouSrJG1YrNI8?=
 =?us-ascii?Q?EOYtIGjMMtR9MMY/ZHRr/MKyWjKgs4Ids9+/5hnskjl+6hBV71YutAZGsA6K?=
 =?us-ascii?Q?VhQpmIoPrtSEVE3uVAlMWsRdABEABMrIZxcjcMxmhRQmpNGfVoeHB/rq+cEp?=
 =?us-ascii?Q?JNqDLCgvdtrMM2j5L4F9TNpQTHh69h4g4Elw3pWiTwKsrEdlLXqtDfFV8CkC?=
 =?us-ascii?Q?zS/9LYR5MOZj3FcWBuZy4pHxTTLIpIFuJqK0Dp1cjlTXtaTDp7hfkY8mW60t?=
 =?us-ascii?Q?/4k8KPBq+MndAqMu8YqxUzYvl5/f60O5jX+FwPV3DZtLSnvvN4AkA6avJpPD?=
 =?us-ascii?Q?IAd4F9vEjVm6+Y82C037/DaQoY7RUgldfYyB6b3h2VJF41l5IJXVQ9DLDsmv?=
 =?us-ascii?Q?VTYC9tq3LF44g/QTFNRN0mR/Yi8cvZjej7KaB2V41IyaYsjmplp4fWzbYCOA?=
 =?us-ascii?Q?0/nXKQkrr4DMxhMWqb08Yl4+csdGVhsjRm4dvGC544Fn3mvH9Zgc0FkDJE++?=
 =?us-ascii?Q?HLeHFwUL8CbXuXwweXDH5JPPcfeMoNYj5SkaRyyciqXRSX7ZnfVgtn/Dhf1X?=
 =?us-ascii?Q?M4thBN2ZDQqdGz0PpIkux08FpeJ01/HRPRC4BtQupO7XA9LKJcPOGayALpjx?=
 =?us-ascii?Q?Qd6x1zIRT7B3HsTB1RSWozmK0yMYbCq0S2t+9bcEkfRIUzKcEsGKEacfRI+o?=
 =?us-ascii?Q?GZsktMpQfGz3HcfjjVVgSIvR74LWpHbjlDIxLQaiF+fDELtKOxomKSsuwHlJ?=
 =?us-ascii?Q?Sa86zWnweLqWVAs/lx67rQhiq9UE3DrJ2/iMhpH/W3auC8/0VK4wCKh+yB9T?=
 =?us-ascii?Q?paLEvzR3gfYHCNnvlcMFRpKH3AYpJCqCMM2LOFYV7qO4V4vUZXAZM4feWiaB?=
 =?us-ascii?Q?eZNz+T275U+G1lW3FJWFmwv9k96cR9iAwY19GM7d8rKwW5wpTr2pRpjlQ/FN?=
 =?us-ascii?Q?y0xsCqP9+SF55w4fN5JiIjuPS/h49OoDIdWvT3gR9f1kdyh78EQA1iWHrht/?=
 =?us-ascii?Q?eRta5KbecGPKmFTAJZ4yIZxOEj04u/g+yqBz2etchQaoCcz8KDTX5UQD8mIL?=
 =?us-ascii?Q?viWN6uLV5f8r2zHuBY/QyBCah+pKBS2ifUQrWwMxdjAw/bwN/tJ3lZM/AzYm?=
 =?us-ascii?Q?RdXU8Hdq4X7hjK5Hhml0/vnDGd352FrIMFNNaUxCPrVbpq5lAZJyJ22qg2cr?=
 =?us-ascii?Q?Tevo6iYW7dtCjrZJy6XWQjrOt/YtAIPuFpJn?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2025 09:41:00.7906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 590f5178-8347-44a1-0916-08ddedf2a7ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7224

From: Dragos Tatulea <dtatulea@nvidia.com>

This ethtool counter is meant to help with observing how many times the
congestion event was triggered but on query there was no state change.

This would help to indicate when a work item was scheduled to run too
late and in the meantime the congestion state changed back to previous
state.

While at it, do a driveby typo fix in documentation for
pci_bw_inbound_high.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../device_drivers/ethernet/mellanox/mlx5/counters.rst     | 7 ++++++-
 .../net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c   | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
index 754c81436408..cc498895f92e 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
@@ -1348,7 +1348,7 @@ Device Counters
        is in a congested state.
        If pci_bw_inbound_high == pci_bw_inbound_low then the device is not congested.
        If pci_bw_inbound_high > pci_bw_inbound_low then the device is congested.
-     - Tnformative
+     - Informative
 
    * - `pci_bw_inbound_low`
      - The number of times the device crossed the low inbound PCIe bandwidth
@@ -1373,3 +1373,8 @@ Device Counters
        If pci_bw_outbound_high == pci_bw_outbound_low then the device is not congested.
        If pci_bw_outbound_high > pci_bw_outbound_low then the device is congested.
      - Informative
+
+   * - `pci_bw_stale_event`
+     - The number of times the device fired a PCIe congestion event but on query
+       there was no change in state.
+     - Informative
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
index 0cf142f71c09..2eb666a46f39 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
@@ -24,6 +24,7 @@ struct mlx5e_pcie_cong_stats {
 	u32 pci_bw_inbound_low;
 	u32 pci_bw_outbound_high;
 	u32 pci_bw_outbound_low;
+	u32 pci_bw_stale_event;
 };
 
 struct mlx5e_pcie_cong_event {
@@ -52,6 +53,8 @@ static const struct counter_desc mlx5e_pcie_cong_stats_desc[] = {
 			     pci_bw_outbound_high) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_pcie_cong_stats,
 			     pci_bw_outbound_low) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_pcie_cong_stats,
+			     pci_bw_stale_event) },
 };
 
 #define NUM_PCIE_CONG_COUNTERS ARRAY_SIZE(mlx5e_pcie_cong_stats_desc)
@@ -212,8 +215,10 @@ static void mlx5e_pcie_cong_event_work(struct work_struct *work)
 	}
 
 	changes = cong_event->state ^ new_cong_state;
-	if (!changes)
+	if (!changes) {
+		cong_event->stats.pci_bw_stale_event++;
 		return;
+	}
 
 	cong_event->state = new_cong_state;
 
-- 
2.31.1


