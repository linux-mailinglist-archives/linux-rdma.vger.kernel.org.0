Return-Path: <linux-rdma+bounces-12018-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA53AFFA30
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 08:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD44189CA60
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 06:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902B8288C80;
	Thu, 10 Jul 2025 06:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="omGgxFpM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FA52882DE;
	Thu, 10 Jul 2025 06:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752130358; cv=fail; b=Thdslii6dlSBToZTCQBa1QS9whl8rt7uDGte2ePAXpsFZuzCxvksfs29cwHRuGYXGu1o+yafTinYPWGdbNAWefofkTpbSsgWFVlq3IIwk3+Ss44u/Dnj6gq7g9Wpt9ItVRf2Da9SmKliWqKarjNDhBANT74yCHSX2BgnDm+pUcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752130358; c=relaxed/simple;
	bh=v/RhXCY0RX4KrChOcbodvevl36m1l5GkRSeXKVALN9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Em9LQ/KczJBX59tRIdjz1H/2ItlioyyQ9sTtlSC80KFZevz71G6W/RV7Z//Jq2UwU/+ysZV0Yz7C2dxwxs2s3zHHbY+wIhHVRusgk+1sMWnZx2+GYLiJfV80DoLLPnjBs1CsDFmmfV3l66jutTeTGXNLLS3Ml7AoyIHDUOXGqQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=omGgxFpM; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sj/feFKfNBUGnyacfbWyKVd1Qquv2Ne+xv+kDMez+1V7DdcfZAxtHj2HwSCKOemSTUsajEAFuqezz9D0HM+m7+FDo1IAUtc1d16HGQEOCwsG3tO8HPSmZXPj9pzRQrcgJr1/A5J6p/rJb74B3d4J9STpbhVPLJXkM8yxiYQvv7D/zQatxzr3YwDyrNPHCDkH60tqeCUJ1DJ319u+X7d9pESSuuqSxVc9bGedIjKwTLi4QZrJhLJsPZJ/mWTkXODM4HVD+TPnRHMNWD7aOJKPk2FBtgdA5GZftnefdckmOzFQF7BeiBlYcHrvCDQEfciCV/T7E3WwkAOZ0ulY7auRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qTjs9USelpNlebvp63SRK47bTzSEQR2P0cgxBbrSyU=;
 b=sJtDwqGJBLYmhlP9QTscSlP9jy0K/mBGUMeujIdZEKqbiTvseZt3P+3kgEZkifotnCODn7o3wElQ25btYW9OhIhs9CCW738mjAkjKQcN3/wU0Nh5LBPs16FsV1h9qzS/A7DhnOTZsInXyGF1kdJWEMbRXUinBDnxKoURdgqorGAEjBfv0StSh8FLJ0s9c/WrNs94+LzOmPKnICHu1ii5pwtGyisi+F3wWvbhiuLH6oZkx9Fsp2pcQdRGujknRMGbjMkRfZJFzauv+038P5RU2y5+YWt54iZ7wM8DLg2ddNXtxAEvBJY2JXU4t+aBvq3+kZHoM/TdL8UXpo9WLjZqxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qTjs9USelpNlebvp63SRK47bTzSEQR2P0cgxBbrSyU=;
 b=omGgxFpMIoXtWTGTCB1biI7f4WyAMORf61t7CmhsYYCF18uAMlxXfZdWZTlvdt99JZGkZnCsWSwqyqxr35I8u4k68a9Uo/qmCgB+OATJvF+BCpB/VacIgsyLg/YglP8G+y5UhvNA7wBHa+ph3FzWGh2lD7BGN62AU6dxx5G6wzNiJcUsjSJ5bhGfZYvsxpcChHgUOG9CL69mvJq6Gbj2UpBy4xc9k2DJYKIEeYKt1JpDZjtIB3CG5h4st/KFimCvd2WuWMTi/mpC1zMtNa8BLTS/Q0w061BB7opji9SQlWiV40PM5T7jrAEs1tngwQzYHl79aQLsBubOjCFOY5D0Sg==
Received: from SJ0PR05CA0113.namprd05.prod.outlook.com (2603:10b6:a03:334::28)
 by IA1PR12MB8311.namprd12.prod.outlook.com (2603:10b6:208:3fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 06:52:30 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::fe) by SJ0PR05CA0113.outlook.office365.com
 (2603:10b6:a03:334::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Thu,
 10 Jul 2025 06:52:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:52:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 23:52:16 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 23:52:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 9 Jul
 2025 23:52:11 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Jonathan Corbet
	<corbet@lwn.net>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next V2 2/3] net/mlx5e: Add device PCIe congestion ethtool stats
Date: Thu, 10 Jul 2025 09:51:31 +0300
Message-ID: <1752130292-22249-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752130292-22249-1-git-send-email-tariqt@nvidia.com>
References: <1752130292-22249-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|IA1PR12MB8311:EE_
X-MS-Office365-Filtering-Correlation-Id: 89cd02f0-821f-4f10-afe3-08ddbf7e5732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k7MPRaybelPqhRKQ9D5yUjEpoauG3wRpMwD/8MXWGmkKocBZJnxuudg+tPL6?=
 =?us-ascii?Q?cPZ6PSAVuO6xMkAVwKSTVg2zyw5gMBYMWL+aUotqYCj1ZNXt9BEGDg0trXj4?=
 =?us-ascii?Q?DgWNa6Tcv3tB1JGPelSDFsm3O6+oIMzHEEuaxJBRSeNUOPF0J/sm2SCGuhus?=
 =?us-ascii?Q?AMP+AIrmBztaa+hZEYJh9zpdgnrPhJiZhgpKEZF3awCGPzuavBAAyHrQ+LoT?=
 =?us-ascii?Q?4REGFt3RWNOZ4DQqrE1cQH4ff4dJNFEOb1z68wxXScXCV4BFLfhQk/omy+Wq?=
 =?us-ascii?Q?wgO1fHdgrAajYAeeSIiAWqI5K684pkQpIUhXVm8GfaiaswDLCaFU1n9PSrQ/?=
 =?us-ascii?Q?T4uqRsn2kJVnMSugfVX5elMFgAeG5En/QA9YLYR9u+yg1mvwMNH/pPISTT5R?=
 =?us-ascii?Q?7Xpt+Fc8WvF+eYdcNKKbRM0tWy9jRutUUMhymqsq+oEUiRClZJixrSOQPTpa?=
 =?us-ascii?Q?V4asK/DTA1LHoDdqYfH1Dt/lNHZBinvaxz2R5Jyuinop/TdrY7oU6Y79peAs?=
 =?us-ascii?Q?uiohGMSDuvXS8T3BrSJeIBurZecYi2Lr0WvySjgbfRHNntyIIgdMblLYThfk?=
 =?us-ascii?Q?3uBKimqJtUe6CbtF4XlptVTf9Ca+rFIn0JeDoI9BQ33O6H7leqfSpmo+oslx?=
 =?us-ascii?Q?OF1phmoWv7NObtAQJ9UQ2MH+7VhUFXlASsmrIU2XaQD+370c4v/Mi+Y4L1fl?=
 =?us-ascii?Q?pbhH7Kj59J5+DwhgMgemWsKPhlJpM44SK3cVHQ74c+/OtgK6xDedZttEe6mQ?=
 =?us-ascii?Q?VVD6N959oNJPNhQQk4lIOD+Pu/PkpKZU0zbtIphcmmyBPhwOP+Y0+KAs1oGa?=
 =?us-ascii?Q?U7HgNkV5oZkPVMETOVDtVW6J2KUQ+CskrZ7ydvqw/PhaIG+dH1U2PsNEqrio?=
 =?us-ascii?Q?3GcjyFdHEL64ieJSPnh5SBM8kUnFEHMdWr6e7HBK+vMaRFtONkMIEuDAPFRv?=
 =?us-ascii?Q?4iqYKVRVksJz74FxKoTp9F1rInbdMmzxyu3UyeL3MizX3ajSApQv87TrDfns?=
 =?us-ascii?Q?NmbUJkhRK1mCEoAISGsZBJBGkU3yb0IUqJGAj42laknT0uho1BuR516aum5E?=
 =?us-ascii?Q?jMc/p2mM0DnL7PRKWaNnv1h1JuLIqtdMbS5kpTS3/Gt+0E2ACdq8qouUbLKW?=
 =?us-ascii?Q?a2Bdw1M3bNc/Le0SzLa4fj2Muh0MKUu3T3DHXjAs/Idv2KFeglRDqm+gZRGM?=
 =?us-ascii?Q?mKgPrDkb/hT87OdlRp4qlsbF/gl3qkstg6XMhs+fcjTikmT3kACtl5a3s47/?=
 =?us-ascii?Q?CiAWhWpmwAPBnRyGJPr/z5f5lYPgUSSMDNuzVMWZBOBJ5uO3WPlaIkj43nlu?=
 =?us-ascii?Q?USnddpjQK8xBTYqA+BSANHpSiGNOSYV3dBEOXmF+2mPUVoaBmP/Z6JD1sx2G?=
 =?us-ascii?Q?CkAvT4+VaHN2Nx5XtMX3W9hRqlQ0yZPGM9ydl1nkQoVFb1QfxFT3aRcTTNOg?=
 =?us-ascii?Q?GTWhyGPFP8x5dBQO4jfNYLo3+p32aEd0NwJo/q/rSbqIjntsc7oeOlMpLvCZ?=
 =?us-ascii?Q?FWhImcn8GCEP+jnFFdJgFDoGZxFY5tOmTVEQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:52:30.5039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cd02f0-821f-4f10-afe3-08ddbf7e5732
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8311

From: Dragos Tatulea <dtatulea@nvidia.com>

Implement the PCIe Congestion Event notifier which triggers a work item
to query the PCIe Congestion Event object. The result of the congestion
state is reflected in the new ethtool stats:

* pci_bw_inbound_high: the device has crossed the high threshold for
  inbound PCIe traffic.
* pci_bw_inbound_low: the device has crossed the low threshold for
  inbound PCIe traffic
* pci_bw_outbound_high: the device has crossed the high threshold for
  outbound PCIe traffic.
* pci_bw_outbound_low: the device has crossed the low threshold for
  outbound PCIe traffic

The high and low thresholds are currently configured at 90% and 75%.
These are hysteresis thresholds which help to check if the
PCI bus on the device side is in a congested state.

If low + 1 = high then the device is in a congested state. If low == high
then the device is not in a congested state.

The counters are also documented.

A follow-up patch will make the thresholds configurable.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/counters.rst       |  32 ++++
 .../mellanox/mlx5/core/en/pcie_cong_event.c   | 175 ++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_stats.c    |   1 +
 .../ethernet/mellanox/mlx5/core/en_stats.h    |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  |   4 +
 5 files changed, 213 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
index 43d72c8b713b..754c81436408 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
@@ -1341,3 +1341,35 @@ Device Counters
      - The number of times the device owned queue had not enough buffers
        allocated.
      - Error
+
+   * - `pci_bw_inbound_high`
+     - The number of times the device crossed the high inbound pcie bandwidth
+       threshold. To be compared to pci_bw_inbound_low to check if the device
+       is in a congested state.
+       If pci_bw_inbound_high == pci_bw_inbound_low then the device is not congested.
+       If pci_bw_inbound_high > pci_bw_inbound_low then the device is congested.
+     - Tnformative
+
+   * - `pci_bw_inbound_low`
+     - The number of times the device crossed the low inbound PCIe bandwidth
+       threshold. To be compared to pci_bw_inbound_high to check if the device
+       is in a congested state.
+       If pci_bw_inbound_high == pci_bw_inbound_low then the device is not congested.
+       If pci_bw_inbound_high > pci_bw_inbound_low then the device is congested.
+     - Informative
+
+   * - `pci_bw_outbound_high`
+     - The number of times the device crossed the high outbound pcie bandwidth
+       threshold. To be compared to pci_bw_outbound_low to check if the device
+       is in a congested state.
+       If pci_bw_outbound_high == pci_bw_outbound_low then the device is not congested.
+       If pci_bw_outbound_high > pci_bw_outbound_low then the device is congested.
+     - Informative
+
+   * - `pci_bw_outbound_low`
+     - The number of times the device crossed the low outbound PCIe bandwidth
+       threshold. To be compared to pci_bw_outbound_high to check if the device
+       is in a congested state.
+       If pci_bw_outbound_high == pci_bw_outbound_low then the device is not congested.
+       If pci_bw_outbound_high > pci_bw_outbound_low then the device is congested.
+     - Informative
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
index 95a6db9d30b3..a24e5465ceeb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
@@ -4,6 +4,13 @@
 #include "en.h"
 #include "pcie_cong_event.h"
 
+#define MLX5E_CONG_HIGH_STATE 0x7
+
+enum {
+	MLX5E_INBOUND_CONG  = BIT(0),
+	MLX5E_OUTBOUND_CONG = BIT(1),
+};
+
 struct mlx5e_pcie_cong_thresh {
 	u16 inbound_high;
 	u16 inbound_low;
@@ -11,10 +18,27 @@ struct mlx5e_pcie_cong_thresh {
 	u16 outbound_low;
 };
 
+struct mlx5e_pcie_cong_stats {
+	u32 pci_bw_inbound_high;
+	u32 pci_bw_inbound_low;
+	u32 pci_bw_outbound_high;
+	u32 pci_bw_outbound_low;
+};
+
 struct mlx5e_pcie_cong_event {
 	u64 obj_id;
 
 	struct mlx5e_priv *priv;
+
+	/* For event notifier and workqueue. */
+	struct work_struct work;
+	struct mlx5_nb nb;
+
+	/* Stores last read state. */
+	u8 state;
+
+	/* For ethtool stats group. */
+	struct mlx5e_pcie_cong_stats stats;
 };
 
 /* In units of 0.01 % */
@@ -25,6 +49,51 @@ static const struct mlx5e_pcie_cong_thresh default_thresh_config = {
 	.outbound_low = 7500,
 };
 
+static const struct counter_desc mlx5e_pcie_cong_stats_desc[] = {
+	{ MLX5E_DECLARE_STAT(struct mlx5e_pcie_cong_stats,
+			     pci_bw_inbound_high) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_pcie_cong_stats,
+			     pci_bw_inbound_low) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_pcie_cong_stats,
+			     pci_bw_outbound_high) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_pcie_cong_stats,
+			     pci_bw_outbound_low) },
+};
+
+#define NUM_PCIE_CONG_COUNTERS ARRAY_SIZE(mlx5e_pcie_cong_stats_desc)
+
+static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(pcie_cong)
+{
+	return priv->cong_event ? NUM_PCIE_CONG_COUNTERS : 0;
+}
+
+static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(pcie_cong) {}
+
+static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(pcie_cong)
+{
+	if (!priv->cong_event)
+		return;
+
+	for (int i = 0; i < NUM_PCIE_CONG_COUNTERS; i++)
+		ethtool_puts(data, mlx5e_pcie_cong_stats_desc[i].format);
+}
+
+static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(pcie_cong)
+{
+	if (!priv->cong_event)
+		return;
+
+	for (int i = 0; i < NUM_PCIE_CONG_COUNTERS; i++) {
+		u32 ctr = MLX5E_READ_CTR32_CPU(&priv->cong_event->stats,
+					       mlx5e_pcie_cong_stats_desc,
+					       i);
+
+		mlx5e_ethtool_put_stat(data, ctr);
+	}
+}
+
+MLX5E_DEFINE_STATS_GRP(pcie_cong, 0);
+
 static int
 mlx5_cmd_pcie_cong_event_set(struct mlx5_core_dev *dev,
 			     const struct mlx5e_pcie_cong_thresh *config,
@@ -89,6 +158,97 @@ static int mlx5_cmd_pcie_cong_event_destroy(struct mlx5_core_dev *dev,
 	return mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
 }
 
+static int mlx5_cmd_pcie_cong_event_query(struct mlx5_core_dev *dev,
+					  u64 obj_id,
+					  u32 *state)
+{
+	u32 in[MLX5_ST_SZ_DW(pcie_cong_event_cmd_in)] = {};
+	u32 out[MLX5_ST_SZ_DW(pcie_cong_event_cmd_out)];
+	void *obj;
+	void *hdr;
+	u8 cong;
+	int err;
+
+	hdr = MLX5_ADDR_OF(pcie_cong_event_cmd_in, in, hdr);
+
+	MLX5_SET(general_obj_in_cmd_hdr, hdr, opcode,
+		 MLX5_CMD_OP_QUERY_GENERAL_OBJECT);
+	MLX5_SET(general_obj_in_cmd_hdr, hdr, obj_type,
+		 MLX5_GENERAL_OBJECT_TYPES_PCIE_CONG_EVENT);
+	MLX5_SET(general_obj_in_cmd_hdr, hdr, obj_id, obj_id);
+
+	err = mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	if (err)
+		return err;
+
+	obj = MLX5_ADDR_OF(pcie_cong_event_cmd_out, out, cong_obj);
+
+	if (state) {
+		cong = MLX5_GET(pcie_cong_event_obj, obj, inbound_cong_state);
+		if (cong == MLX5E_CONG_HIGH_STATE)
+			*state |= MLX5E_INBOUND_CONG;
+
+		cong = MLX5_GET(pcie_cong_event_obj, obj, outbound_cong_state);
+		if (cong == MLX5E_CONG_HIGH_STATE)
+			*state |= MLX5E_OUTBOUND_CONG;
+	}
+
+	return 0;
+}
+
+static void mlx5e_pcie_cong_event_work(struct work_struct *work)
+{
+	struct mlx5e_pcie_cong_event *cong_event;
+	struct mlx5_core_dev *dev;
+	struct mlx5e_priv *priv;
+	u32 new_cong_state = 0;
+	u32 changes;
+	int err;
+
+	cong_event = container_of(work, struct mlx5e_pcie_cong_event, work);
+	priv = cong_event->priv;
+	dev = priv->mdev;
+
+	err = mlx5_cmd_pcie_cong_event_query(dev, cong_event->obj_id,
+					     &new_cong_state);
+	if (err) {
+		mlx5_core_warn(dev, "Error %d when querying PCIe cong event object (obj_id=%llu).\n",
+			       err, cong_event->obj_id);
+		return;
+	}
+
+	changes = cong_event->state ^ new_cong_state;
+	if (!changes)
+		return;
+
+	cong_event->state = new_cong_state;
+
+	if (changes & MLX5E_INBOUND_CONG) {
+		if (new_cong_state & MLX5E_INBOUND_CONG)
+			cong_event->stats.pci_bw_inbound_high++;
+		else
+			cong_event->stats.pci_bw_inbound_low++;
+	}
+
+	if (changes & MLX5E_OUTBOUND_CONG) {
+		if (new_cong_state & MLX5E_OUTBOUND_CONG)
+			cong_event->stats.pci_bw_outbound_high++;
+		else
+			cong_event->stats.pci_bw_outbound_low++;
+	}
+}
+
+static int mlx5e_pcie_cong_event_handler(struct notifier_block *nb,
+					 unsigned long event, void *eqe)
+{
+	struct mlx5e_pcie_cong_event *cong_event;
+
+	cong_event = mlx5_nb_cof(nb, struct mlx5e_pcie_cong_event, nb);
+	queue_work(cong_event->priv->wq, &cong_event->work);
+
+	return NOTIFY_OK;
+}
+
 bool mlx5e_pcie_cong_event_supported(struct mlx5_core_dev *dev)
 {
 	u64 features = MLX5_CAP_GEN_2_64(dev, general_obj_types_127_64);
@@ -116,6 +276,10 @@ int mlx5e_pcie_cong_event_init(struct mlx5e_priv *priv)
 	if (!cong_event)
 		return -ENOMEM;
 
+	INIT_WORK(&cong_event->work, mlx5e_pcie_cong_event_work);
+	MLX5_NB_INIT(&cong_event->nb, mlx5e_pcie_cong_event_handler,
+		     OBJECT_CHANGE);
+
 	cong_event->priv = priv;
 
 	err = mlx5_cmd_pcie_cong_event_set(mdev, &default_thresh_config,
@@ -125,10 +289,18 @@ int mlx5e_pcie_cong_event_init(struct mlx5e_priv *priv)
 		goto err_free;
 	}
 
+	err = mlx5_eq_notifier_register(mdev, &cong_event->nb);
+	if (err) {
+		mlx5_core_warn(mdev, "Error registering notifier for the PCIe congestion event\n");
+		goto err_obj_destroy;
+	}
+
 	priv->cong_event = cong_event;
 
 	return 0;
 
+err_obj_destroy:
+	mlx5_cmd_pcie_cong_event_destroy(mdev, cong_event->obj_id);
 err_free:
 	kvfree(cong_event);
 
@@ -145,6 +317,9 @@ void mlx5e_pcie_cong_event_cleanup(struct mlx5e_priv *priv)
 
 	priv->cong_event = NULL;
 
+	mlx5_eq_notifier_unregister(mdev, &cong_event->nb);
+	cancel_work_sync(&cong_event->work);
+
 	if (mlx5_cmd_pcie_cong_event_destroy(mdev, cong_event->obj_id))
 		mlx5_core_warn(mdev, "Error destroying PCIe congestion event (obj_id=%llu)\n",
 			       cong_event->obj_id);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 19664fa7f217..87536f158d07 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -2612,6 +2612,7 @@ mlx5e_stats_grp_t mlx5e_nic_stats_grps[] = {
 #ifdef CONFIG_MLX5_MACSEC
 	&MLX5E_STATS_GRP(macsec_hw),
 #endif
+	&MLX5E_STATS_GRP(pcie_cong),
 };
 
 unsigned int mlx5e_nic_stats_grps_num(struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index def5dea1463d..72dbcc1928ef 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -535,5 +535,6 @@ extern MLX5E_DECLARE_STATS_GRP(ipsec_hw);
 extern MLX5E_DECLARE_STATS_GRP(ipsec_sw);
 extern MLX5E_DECLARE_STATS_GRP(ptp);
 extern MLX5E_DECLARE_STATS_GRP(macsec_hw);
+extern MLX5E_DECLARE_STATS_GRP(pcie_cong);
 
 #endif /* __MLX5_EN_STATS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index dfb079e59d85..db54f6d26591 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -21,6 +21,7 @@
 #include "pci_irq.h"
 #include "devlink.h"
 #include "en_accel/ipsec.h"
+#include "en/pcie_cong_event.h"
 
 enum {
 	MLX5_EQE_OWNER_INIT_VAL	= 0x1,
@@ -585,6 +586,9 @@ static void gather_async_events_mask(struct mlx5_core_dev *dev, u64 mask[4])
 		async_event_mask |=
 			(1ull << MLX5_EVENT_TYPE_OBJECT_CHANGE);
 
+	if (mlx5e_pcie_cong_event_supported(dev))
+		async_event_mask |= (1ull << MLX5_EVENT_TYPE_OBJECT_CHANGE);
+
 	mask[0] = async_event_mask;
 
 	if (MLX5_CAP_GEN(dev, event_cap))
-- 
2.31.1


