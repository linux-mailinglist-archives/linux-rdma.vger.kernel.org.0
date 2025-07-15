Return-Path: <linux-rdma+bounces-12196-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2366EB0617B
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 16:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8CD85C2081
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 14:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB6324A078;
	Tue, 15 Jul 2025 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OpYoQjBD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C1123A9AC;
	Tue, 15 Jul 2025 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589881; cv=fail; b=NT+jgx8aQ10yH08cTyTX7PWThKPrAQUkKFF65PpO8dtwbX//urANMxW+KoVNEcj270MPs3j7LqOk+iEGCUZQ0Ql9a0+3tkjyVMwCWUAxicoN8o/OrkWwDZaO5vRTRUp3e+m7DKT6ns3TfJuugrBaQbzA+8QIh+PFHaqfcjdtOHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589881; c=relaxed/simple;
	bh=e7I7Zc9rclO87F+AM9apCOn32rhH0XpgNIRGhyMYtes=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXFsEpFgArMsJQe0O5xm05nf78w58FfMe9oTLsN4KLIcWqOavXQsn5Q4h3Vj/8Ip2F+ANyv05oIfylImvFhFmV2UD/vtwcoVQ6rACvmveH+1Z7IkE3QI4s0AIrdcGAlIOtc8f0fTVdpuBuZhjvXk3NxEX4G0n+n06KSQ1gyfcfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OpYoQjBD; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3z6LbRTT80YRJdcG1bpEOjl4B++p3s36gBCvbDkdoqmxQsTGlGb2t9gtvOEqPNmoXuuYtAwiHNUaRiegJpwu4tTK4n3K2lGOL6dTRStwf54UKQ8FHMmJNcLIu7xWhAwD21K31WuZxSDPXpF8AKA6TqENHqSrbqO6lPV8I1pCMUYTBWJNn4Wzv31voTDLZ5Rs1PdVcM6qS96xTcYYuJ+1QymYnxXObPi1K6WiL1zbVY4GboAggvvtxGjG4Vn37Zxobp7K7zncCXVnA0C+Jjq8W1ZxqHzBty8pMqa6qa/URhgtavx2b7Se4iNOSsYcFu0W7y2gnZ3WazgUAtgR4GnsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iC+BXbgVqtjgCGfv0jCgeDw+PXMvRNFw91ta0eW3BKU=;
 b=r2gqEHPeL7sZfHZOqaBaQzw55QV08ER9lk0mReDyphRxHqyHS/3rQOUMUryMv8FXw27xUWPCx659wfP8gObmccLj4s5sSD+3kuf2fAVNCBIO02x6nHHG5gWoH4QCX1/QJNQLTNdyIzgFxEtlBMEBNfJtb/dYa1/5+f/gn8fMTGIGLzTCvP1aYrEoVsgDSQplpKfWuU8AhwqJlUgJOLfGXTyYwUiHhT3LTjnbSFLUxEWET9dNssVvfF6KbrgAbIj/asFKw0W5vFXKA8/YOqflx2RUttSxB5lTTAUmvLOTSuU6D4/I8xy+1gxJYWlfM5MgzoR2rDcRNhtpIUnRRNnfEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iC+BXbgVqtjgCGfv0jCgeDw+PXMvRNFw91ta0eW3BKU=;
 b=OpYoQjBDGLBS7e6vOAF0XBXxuD2BTstozLCxeISu1Pzq3jdK6Yibc2jz7GRS5sJhnp14MZJW6yQIF5+wArdYm/kTLEHIBX5Q0qvY7XpmzGD96/2+Ugg3sLgj4GhZJ5khWcrEYJdI8LD/vnq3YwVEyfxJTdFybID77ZZpN56lc+HfuWgzlLeWuk/W+iNZYBMjsVJoR0oRpTT5F0uZcjHBAILhdDpcGTdo1f/+cVHWG0Diyg1M7vY/7hGDYR/Wfhl6SUABBbzt7Z2AWUVUNCg3kHun0gPtQEcedod6pgkcvPZkAp+sMPvkZS8mmTViAuuFRBpuLSpR/BTFord1/hpXNg==
Received: from SA0PR11CA0076.namprd11.prod.outlook.com (2603:10b6:806:d2::21)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 14:31:07 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::ef) by SA0PR11CA0076.outlook.office365.com
 (2603:10b6:806:d2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Tue,
 15 Jul 2025 14:31:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 14:31:06 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 07:30:46 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Jul 2025 07:30:46 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 15 Jul 2025 07:30:42 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V3 2/2] net/mlx5e: Add device PCIe congestion ethtool stats
Date: Tue, 15 Jul 2025 17:30:21 +0300
Message-ID: <1752589821-145787-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752589821-145787-1-git-send-email-tariqt@nvidia.com>
References: <1752589821-145787-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e18120-25e8-483e-e6df-08ddc3ac3c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yDdgQQPgykZ3nGeDoJ9hI4dFjBIM9ZMdxOY3aZbTPH4yfx+MMs8P9ufGP1lF?=
 =?us-ascii?Q?K5DWkhaemm3P+aOtY4npLu35H5Z0cf7fiaDpVNrAQP89yjXo5ZZR+CJ3NZm2?=
 =?us-ascii?Q?ECiozlp8F5fhExDlXFRfoMzZoh1P5j5rqzqBYAlQXukYIOT4xVEjILn1AyIA?=
 =?us-ascii?Q?4TDTxlEGHjJfXy1Hc7qJVtQjpLGDemiHcPwdmV3bHE3smklH2xnc+RJ+fkmZ?=
 =?us-ascii?Q?J6oN+WYnOABB86RbrqdmAtxn/Wb9oFLKht8/8BgfMt1SBKVChkd+w6zaNejP?=
 =?us-ascii?Q?RPaIITxYIvTC6087jLlcMJWWJZWxt88JntUh6SB4Ldr9UDm9wsi9LtBbQMO3?=
 =?us-ascii?Q?7GSSVnhdQMUhj7BSEybhLrqm8qRZNcVoGLgyITcUDwTX4xP8r0qAeqwOdZXx?=
 =?us-ascii?Q?Kb58CoiFckpSBKqTHqqf7siJOFg7aX6wlfFrVuxWs7ALjz9bBvYBbrT4H5aX?=
 =?us-ascii?Q?Q0bsasw5yfu6yhFrri2h3Ef2U2o79nxwOYCP0eT3ILDY0ctvZWCaaBZAiCiW?=
 =?us-ascii?Q?wzCFf2NSWboVMvfYFef10XBq0i6W3bfDOgU61yXnmtIbGuteFusT76/NxVRD?=
 =?us-ascii?Q?lZLwyLIwSI40FaojSh6dwKAkevTF9qKSo7FpLIpp2grXs3eV4Q9mZSoXO5gX?=
 =?us-ascii?Q?ZiNjQ6H9b1R2cpwI/RyBNLMCehEXm/moBrmb9e8a3wgmfkKNcyofQpa/Qhqg?=
 =?us-ascii?Q?yXoHT/H2aZPxxG5Pq0SCBr+gdVXn/IK2clVm78lrY0aq93RZrai+rI+f9NU3?=
 =?us-ascii?Q?02G59FtH8/MZmkI2iIHST1Sp0iYLydptYIfo/uXghH2tcN/ynMhqes9Vqpo0?=
 =?us-ascii?Q?cVZ+8AneP3U3aC2zjZ9DcAXyZ5JE3Y+7m7FOcanDJW2OPwD3J/tA/dUZBszR?=
 =?us-ascii?Q?egOs7Zddpq3HP59fCnIiCuRkM3pT0Y8lPG3w1hDsHRSzttD+z5ohyAgJ/uz/?=
 =?us-ascii?Q?WdumUB+EQgfIQxqP+nI86uj6I8ilePBtmdf2fBiQm86CXPprQCMCM6+quUek?=
 =?us-ascii?Q?sRfnbgMO8q1PkuIyEq0Tzg66g5HqEHT5XLQGYLxY1P1EGPIGF9GkYuKRPMvY?=
 =?us-ascii?Q?AJEdqGMu5jUC1N7Hfk7SscUyJrIzRw48qf1zn5PuyCkWlynArM/XDymr4y0q?=
 =?us-ascii?Q?XOcwHl6ouvWaJ7YxxcL9ZXioKmub1Fetzqlb0DN1IsDJRcWJlU+DVvG+2Fqa?=
 =?us-ascii?Q?edqezGpGMkCwpurDyllLbq+yycYEqQssKmfxiGEq51fhgBuTotzAkXzLSbCd?=
 =?us-ascii?Q?8m5qIQcvUZWnvarBvhy48ar50R3sEi37VFj5oKqs38DSwk0ek8AEZKl1Gdkj?=
 =?us-ascii?Q?qYg3PZZzdichM/2BjmmrAbboHqXemmDSjS8MSej7ygMnlYH/wlO/NrNVmf1j?=
 =?us-ascii?Q?2secLm/RPvXGuzl0hk2dNWp4D+8ZgKZw6DiisC9ig5nLb9UrAcbln6Yxutlb?=
 =?us-ascii?Q?zT/+9I/R17zZZO7iolOwZlptg39+GetNANEgL4Jy3w1JcZNQy2WkCAN7A7jt?=
 =?us-ascii?Q?ZbFT5Cba+zePJYKgxOuCFYeACLsDN/7YO0sS?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 14:31:06.8217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e18120-25e8-483e-e6df-08ddc3ac3c46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256

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
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  |   3 +
 5 files changed, 212 insertions(+)

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
index 9595f8f9a94d..0ed017569a19 100644
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
 int mlx5e_pcie_cong_event_init(struct mlx5e_priv *priv)
 {
 	struct mlx5e_pcie_cong_event *cong_event;
@@ -103,6 +263,10 @@ int mlx5e_pcie_cong_event_init(struct mlx5e_priv *priv)
 	if (!cong_event)
 		return -ENOMEM;
 
+	INIT_WORK(&cong_event->work, mlx5e_pcie_cong_event_work);
+	MLX5_NB_INIT(&cong_event->nb, mlx5e_pcie_cong_event_handler,
+		     OBJECT_CHANGE);
+
 	cong_event->priv = priv;
 
 	err = mlx5_cmd_pcie_cong_event_set(mdev, &default_thresh_config,
@@ -112,10 +276,18 @@ int mlx5e_pcie_cong_event_init(struct mlx5e_priv *priv)
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
 
@@ -132,6 +304,9 @@ void mlx5e_pcie_cong_event_cleanup(struct mlx5e_priv *priv)
 
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
index dfb079e59d85..66dce17219a6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -585,6 +585,9 @@ static void gather_async_events_mask(struct mlx5_core_dev *dev, u64 mask[4])
 		async_event_mask |=
 			(1ull << MLX5_EVENT_TYPE_OBJECT_CHANGE);
 
+	if (mlx5_pcie_cong_event_supported(dev))
+		async_event_mask |= (1ull << MLX5_EVENT_TYPE_OBJECT_CHANGE);
+
 	mask[0] = async_event_mask;
 
 	if (MLX5_CAP_GEN(dev, event_cap))
-- 
2.31.1


