Return-Path: <linux-rdma+bounces-11452-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD1BAE0401
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 13:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013F35A2696
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 11:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515F223F424;
	Thu, 19 Jun 2025 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dNxvb8JI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F99227B95;
	Thu, 19 Jun 2025 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750333077; cv=fail; b=CdBBYMkFQgHG1uNT1aZ7sDPK1WlZIy2YXCcQmVw25g6RfOR/iG77vZbrTbVlAM84cUW0IaRokSzAzIUmHUXY3G6AdETfDCxCYmMR/dUMUFxGClDlSUKmn0QFaCDSA/Wk89P4n4k6seuYAh1+svcR5AClod2+MBeDRxfmgWNMITg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750333077; c=relaxed/simple;
	bh=JHPaq1aK4uBvzoAlhaqX85M3v1mTRP1RzP91z0anDrU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqAeyFH7LxabHIKkhLvhQpj9hU2Ph/i+AmuRG4PLrjs0XK91JJe2JslMjXEPXp47t1sagLnChwXQ28oDg2k6VBoxQqF6GpNucvinHX0Vy9Ir81ZzJBMErdKjnrHlaSAfVMRPPYODtLuFv6/ENT8yZzw6x5PkldnsQIKaHZ4ohn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dNxvb8JI; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSbprHTQWZY7M3jKtunoCJUObu6VhWKByYlaf9d4LqJfxg5g9bVXKukwCXtCfiu24YKC2dN76ID7mso0rwh7y+eyfyNmGUh3QcVELSqhMGBxiQUWPG3zQc4Kts7kDykOCWHNBcICCLwL+lukNAQE4H2sQGOMzUduFW0rcDXp3lXrlnnowyA+Yw2BX7X0SLuPsMeme0a6pBcPBjmhBoDN6IitSl35JiZe9ifVEy77tgLZt9kO+XLL/Uw11o072QQnbm+pEL5sflwLHmAgqsvojVEAdNaw05GWxC5JFit5t8p2SXe95D1mqTALrArosuHkgWtshP5K9gjgBjdQABHZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heimAQqmzu7SlNagM27dhcYmHciDpHkAOaWUD+hd97M=;
 b=eNYW9GlrulKviZH2WdpWvgdu5RfeJgh7WRNh7z+j7SdbZaKvFt6AQKZ1pEd55qOyBC+VmZFbueO4xafCMXof/Q35EvmksAoN2rq4qYjypR30A4eCx9dhmRJ+ep2NJ5no0zOHWxLGiJM2VZqfeu9W/cltzCWWQfx36CZdYBZnW3JSx0PY0u74tVt7VVY7bvyqkk0BACTuPVr0zb5odqgoNlYANpb3x+3nb/QU69ad9Vr/aDczjRrfheqIL2LqVjISqjI20De2v9WLGu/ivEXKOsRaYUiCIPX/+U0uNONXXAp5NXLKHeZ8sGCzfWMMam470TW6WBHPogmevFRWG95JsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heimAQqmzu7SlNagM27dhcYmHciDpHkAOaWUD+hd97M=;
 b=dNxvb8JI7g39oXyiyZVjyHxG3M4WO+mRZSXj4tWI3JNi2PmQCU8vaLiseFXlFgs43sEuxo0GHyPzApTRgzv0FfECu+s7NcPn/0JBELh+B78zsXU6SIMkS2hLX5RoizQYR3DjWreLyzUNPeI3TQdK0Uw5iGDC187SXzX91QGFlE6CCXXRVPxFbHq47PhvJul2eCDH+SnBrLkrzJ7psSRIzDEFWdemapY5xsY/PEygY602VJS0Pjv6ufRdgU2T4FRJxmHdKB+hwqcDM1FGxerKmpYz897Tk5iRQBkDxSm57r4+4M73siMAj8t5H8kwvQp4jGnPQ6NIzRFO/ohQOhrSPQ==
Received: from CY5P221CA0076.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::26) by
 LV3PR12MB9437.namprd12.prod.outlook.com (2603:10b6:408:21d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Thu, 19 Jun 2025 11:37:52 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:9:cafe::25) by CY5P221CA0076.outlook.office365.com
 (2603:10b6:930:9::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.34 via Frontend Transport; Thu,
 19 Jun 2025 11:37:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 11:37:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Jun
 2025 04:37:45 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 19 Jun 2025 04:37:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 19 Jun 2025 04:37:41 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next 4/5] net/mlx5e: Add device PCIe congestion ethtool stats
Date: Thu, 19 Jun 2025 14:37:20 +0300
Message-ID: <20250619113721.60201-5-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250619113721.60201-1-mbloch@nvidia.com>
References: <20250619113721.60201-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|LV3PR12MB9437:EE_
X-MS-Office365-Filtering-Correlation-Id: b7105d3d-d9d1-44f4-4ba8-08ddaf25b96c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SSkCN+QxztGLPgzzezXzRMOMGUdSleSuoWgFNFPS44OkqCBzOIjXu60S+J9i?=
 =?us-ascii?Q?uz/p9xZp2DTD7aMTcOVzem7w2cZXF9GSLUpOFPQ5Z+cvl3uV0wO8OMCnOMHM?=
 =?us-ascii?Q?Jhv3+O7nBwz/PTJIUpjtZR8/X1RWRYeVoxBc78CdwQ7xC0yPTUJ7kmrboxqK?=
 =?us-ascii?Q?2d9M/IhV0fW5cYb4s3p57p/gj25fHx4AKPDJwhw0TEBpN6j5y5IPmbAk7237?=
 =?us-ascii?Q?X7moWE6iLjrPH19j4JcLpqGcIjJ7GUPuoX6C3e6NGzyTsDPWQa4ZSOqjLL62?=
 =?us-ascii?Q?PxHxSAs9kbAknf/aQCLLrxjAQ16oHDJgllWO/b30r4Vlfh2O31LvjpFIBtwo?=
 =?us-ascii?Q?Fq91tw1sn+XplcHg3zGWNHDNMKSzq9duKLfE3uaEyzz+UPmT3NNElw2RjJB3?=
 =?us-ascii?Q?HU6Bf/o3ZMIi70GByQiYRrAQ+yRCgMOjrslkzq1br53pglZ33z3/nxMj9QsS?=
 =?us-ascii?Q?hSKz4FUyXX7AO7BxAUUe1zzuYrvKuY8e+KkPU4tx8HIlgZ2VYae3fk7x4D+f?=
 =?us-ascii?Q?GNYPs8hrQbqtCm2Kw3JEUmbi4Ipe3g1c/Hv1umFLUYu68e9q6EY/2ww3uNKU?=
 =?us-ascii?Q?Z78Ts/fImyAThwi9lA5fOObNeF1e6xRl7c23XCFlzbefST0mxaH0+VXJ6WD3?=
 =?us-ascii?Q?riF7K/qIoK0NIj/ND1HvoNpZ7q6KxFuyVjwf53Fn/zeFLa+u6OtwJ72rbdvZ?=
 =?us-ascii?Q?X2c3SxLaj7j2JlVj+75hN6KzQGnt4JmIvEkGLqomhL6NGEFGo0neCOLf/0+x?=
 =?us-ascii?Q?55wpOxVz7xNc4Hv/jUILMBq51cdDT0vFlXOhdXBiL/WqqQVFEV2/hoHlqWsh?=
 =?us-ascii?Q?Ki5iEdYKiW32FjhjWghPqB3cOVyxH9uMpr3y5S7DP+1QfQzlzZAc3Z+YoTuK?=
 =?us-ascii?Q?hgqf+M4vEARgAOVYL96It15OumBQjtUXNHMCSILdan+vayL2wqSFNQgXxqB9?=
 =?us-ascii?Q?UEMMMv72rG03FV+sR5y0yQdMzuT+VnQcCFGfLkPc3Tz5RMNF5mOr1qp+th4E?=
 =?us-ascii?Q?ZXRw0BYsJyzCkJ9tlhoQtBHFxb/htTqY7wVqM1l6PEVAX9CT7kGkYubRdj7V?=
 =?us-ascii?Q?qHLBZ4DFLLbn9olJrSjzdhE0lv2thst37YOwZlsNsj6TY1cI2f7U5W+LEI21?=
 =?us-ascii?Q?+Vh3bce2Zozy3u7QI2+hvlvfyw2JViieuwJAfxLN7ocfK6Uk6EjobHh0lG+G?=
 =?us-ascii?Q?RotmPJWw2GfONEKs7DLyMh5i17aiYJonVcJOMmj4X4pzNGNyWDCVaVYTgTXr?=
 =?us-ascii?Q?XwuTCIuc5VePVcbnbk8NtctpDtwGY5b4RuCGha+hXl7Q/Sn0pNkzt3IyQQde?=
 =?us-ascii?Q?EfRIl/ZvZDZ3q1/fFs/T2tNlaQXlSS6A9o8dHsZ6gHSXoOgHd3aVeBwNzJst?=
 =?us-ascii?Q?26CUpqb7qFsOgmjz2mB1whmGf0O7KB/dj6ZAD7zKw8XL7Ks1wWO+MhsI5Bad?=
 =?us-ascii?Q?zb4fNQlUpRXA/U7kOHjp/P2euQKuNLK7cu5sYtVckNkVS8aY24n/akmA2fVz?=
 =?us-ascii?Q?vdVZkUKgue1KHVzJJ8xMsdR3rWZSs+dhb3n+?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 11:37:51.5002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7105d3d-d9d1-44f4-4ba8-08ddaf25b96c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9437

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
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
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
2.34.1


