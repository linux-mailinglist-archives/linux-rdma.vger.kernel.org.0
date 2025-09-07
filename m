Return-Path: <linux-rdma+bounces-13135-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16912B47A2A
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Sep 2025 11:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA1537AA10C
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Sep 2025 09:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0B82222D0;
	Sun,  7 Sep 2025 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L6YikHc2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6961EDA0F;
	Sun,  7 Sep 2025 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757238059; cv=fail; b=Ggm4atWre7uNfUWT56oS5wIzFloPgyW4MQygUYe/5PnkWtWB2A+xMQzSdCDshX7BwWSK4YHviUJG2eCjMnsz+KugIyxAnu/vrLa7P/8kHQpG4D/6rvT5rKz0Ym87pt4MDbZvL2KzcOHmBvLIhXrA2MfE9IjhYVYl4KS6M+WCRjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757238059; c=relaxed/simple;
	bh=rhSLSssGL/8u3nplWcCVM5schbIZ/eJ8GCSjr9NYk1U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqWXc9Io/ZYiV9/S/svxXsl52LnUzSweF3IXjSBirxXRFCok9HIymQqXQAH4Q58u/Bx9E5n53HOrnQVs162Oz6LzvIicb3sQZp4lwYqJpD6kairRGqg/Twhn+XPh+9ioRyXwJDsCBv/OYxuMKsalxSlM3WDvAvGpqagYGCqvz5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L6YikHc2; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXvN0gn8+nGYY/mm81dWUUJiaS9MUI3z5eTApSPRUJlQ0rOMrmyQcxn7maHayQhuXXWGBwVcWqc+Z5EMMdkW8mpa9jYdBjgxy3skYO7cBrnMW/YjPy6W1YDurCgGbzxES7XodGRH8ez7hmG854USPQbQK7YWjPe2Yxy+MV5bBZ8Ul7t79RcuNPY2JBiJmdQiLCceqBFp8biloKzMbvteKmTeYzZwaO9G8T0f0C3L2E6njTpU9wOsih3qfQmq0q+6aaNEfNXHfc++JHhS1FBxx2PMbuaIpdLPDW6xS1+s5SvWLJnk8hwjhmKwA7c5ofEccdE2yyQDdNNSZyxM2CbGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRDGfa0DrIRtlG7gSQeu6lg7yAmGgt5i+xI/0gL3CME=;
 b=ZPBeT9+fAkLBzKV91cp5DwZX70qEpaYK4v+KUBTpXF4Q331KnLxP+mDvacX+HCJBPbrZRgp+4JpRvEIjVqiV5gW8aeOzuoDsEW7fazMqJz3k+pPt0CgArNa9kA36mBRm+IbBLiMehMjBuGCZyJy+Y9SYsUK1aS2X3dLQwYXmE5qwFZv1nk7nSCOY3h7CyCXOYqTvWy2cGQkwkjaedRvoKrdAInQnjz5QX1lYuIItGwAuSU5o0grCt+Z2Vri5XLa6Jlbkx8YPwXbxzbukgKByYSFSs7ImxG5fhCI59kmeVqbaJuSYQ0sBTEgH/p9LpUMT1nOe8HOAzM7wsu+rDLhYTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRDGfa0DrIRtlG7gSQeu6lg7yAmGgt5i+xI/0gL3CME=;
 b=L6YikHc2uUISXgysIhBZ9E+C2j0rEpFJcq1M4sxN3sJtn5R8hyHqyZUCS2lPsaZBnuf+5NZ3PyPOY0AOPQ7K1fMxMj0uPaL0+KUhkoz3gsuZRjJ/4H4C0DJbKA30exB6IZXPLNhAZ6IBctqLtcbFhOcRh6ef68s3DaSZf0lqfuO0uGp7nGgRS1jIcn8K+FWUwrs1cl1+Q8SQDSIIOVifKqSQQ/KkHnjCkUvfYzrd05KhP1ZiZnRmS4C8tBGyD6QBYU/JUuAxnphuN6XQo0+UoVxUpcjzzB7OYQtE6J9x3c09MxottDWW5vpOA5sb4PQZ+julVNeAMSRrKar50WbkGg==
Received: from CH2PR05CA0047.namprd05.prod.outlook.com (2603:10b6:610:38::24)
 by LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Sun, 7 Sep
 2025 09:40:51 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::ee) by CH2PR05CA0047.outlook.office365.com
 (2603:10b6:610:38::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.11 via Frontend Transport; Sun,
 7 Sep 2025 09:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Sun, 7 Sep 2025 09:40:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 7 Sep
 2025 02:40:48 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 7 Sep 2025 02:40:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 7 Sep 2025 02:40:44 -0700
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
Subject: [PATCH net-next 1/2] net/mlx5e: Make PCIe congestion event thresholds configurable
Date: Sun, 7 Sep 2025 12:39:35 +0300
Message-ID: <1757237976-531416-2-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|LV2PR12MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa8caa5-96cd-4b59-aac2-08ddedf2a241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ibsLXbo54XcwQPiv8x0omr3FvC9xHAdRQZEL7XvpOKyr3IOobNZSiYDTsMUA?=
 =?us-ascii?Q?4kiVAJZ3g3CUO0lOvYPKs1WhzgZ5ZvNUI/SLR5N4S6Xf+r1aCj9o+lvpyRT9?=
 =?us-ascii?Q?s1ULWkGsvQO6OYr4hCUH23Ere1YuQf7Joiu5S3459htGsEpN26aYhrhdTrps?=
 =?us-ascii?Q?1fmZcIJ5SlYsSToigHEHylc7w+QqTTFbATTiLobVJUXQOYzVXCONfCV9snK+?=
 =?us-ascii?Q?QNRgwgNrIErMMz+qwm9hsl8Nw/aFPmu5MoMj6zPBdTgVfMX7zWns/quZ9W4J?=
 =?us-ascii?Q?mp/zGI7AwxwPxVbX6Ari3sCLhRUdzXMe+uBNmDN25aNas0Fsnr+TzF9O9Htt?=
 =?us-ascii?Q?gHPodPlmVDl77C2ke0enLD5wd4BG4F+wlWfOBziBn5zL/T1n7751HmMVPgWf?=
 =?us-ascii?Q?JySZzDE91tKUZZkPVFONlNoHXZ4QlU57QLPFldd1ERti8KVROEGD9VWO2O41?=
 =?us-ascii?Q?YL/WqHVxCVRe7qan8gG8ICqbP7f9fE7UAu9RiNDuTsKl0+hFpZn9/IirZPvC?=
 =?us-ascii?Q?20JDmG9RV9siv8z3wBHOeJbrF9nmZj1yQyaIpapI1qB7IgYMQ50ma0vSvWA6?=
 =?us-ascii?Q?d10be5xwjmow6sWXldcxPTNDOoCCP7jPGWshcclppJ02PdrH6FtjIRgqAmcR?=
 =?us-ascii?Q?i4KBCYxwuk+RmvLqA4DzRso7kCSUKRMwqyyfo1oLIN0n6mhjn/ehCW9vA/8Z?=
 =?us-ascii?Q?F6H8XdY3g66Jw+oYunMmGWTnaUm2VF0J1l2GlhgGv2In/hgoerqyVzLymQVG?=
 =?us-ascii?Q?PrN/O9U3OFQvuJkFB51snR9TjWx/TGzDwVphFJV4tbvp8QyASN/nQirQoumf?=
 =?us-ascii?Q?5OCo/S207xzcf34WWTg3iSN0WNJJJkXa/OARFDnrF8EhQpwMZF7j6N+XdmYp?=
 =?us-ascii?Q?4P4Xf6rUEhsu5ogfp3LeXN+T16/kRri+BjCgnA6GEZ2ry+BCNSaAz+faN+EI?=
 =?us-ascii?Q?ROssntN5zGWS9lGXeRmzxYRh+EuT2pf8PPBBVpEyMA9OWtkVIvgLxALexTCp?=
 =?us-ascii?Q?cbVtdW0bMzXukjgvlc1b1exZ5legCbnajIXnpImziTHe8N4gH7mbzl+p8VFB?=
 =?us-ascii?Q?iVMR7ozaOypY4in/qlvSmARYYEedXkrf6LV3W9D6ILOHXF0fKo/YYyGlN3TB?=
 =?us-ascii?Q?m+jTF9k9OkcmU3RmN17v+Bq/Zarzsf3nAWvWkkP4ESwjI/FsK5uWRo/aGOPE?=
 =?us-ascii?Q?xOhysYNQoHll17r10p4HUs7x3oKZ2qQaXX/wGGJIzq6IW6EoXtGR5vzQy7xS?=
 =?us-ascii?Q?wUimcHPh3bhRmtsXp+FZZhbzc7wqDn4I+iRXZlUSbXI8fNHWKGCii5+Cdv/v?=
 =?us-ascii?Q?4mdUxKdUnN6+dTxCVNjo6mYZznA4VuCZXsngNe3QMAQRXBgyfT8T7EkWZf++?=
 =?us-ascii?Q?h8nenxhLxQ/0gUI2QjdxBxwyNgPri23JSg7/kUbLGwnOYQF+lOh6jGXW1AKr?=
 =?us-ascii?Q?ypHFgMwYP58FwVMQi478Hois2GBa+kHCIhFynCtLpEh/jyCUQ89fH6czUI8k?=
 =?us-ascii?Q?m2NP/nTSjABzQbf52SpI6YhrHUYh4zgf9LNs?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2025 09:40:51.5301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa8caa5-96cd-4b59-aac2-08ddedf2a241
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5869

From: Dragos Tatulea <dtatulea@nvidia.com>

Add devlink driverinit parameters for configuring the thresholds for
PCIe congestion events. These parameters are registered only when the
firmware supports this feature.

Update the mlx5 devlink docs as well on these new params.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/networking/devlink/mlx5.rst     |  52 +++++++++
 .../net/ethernet/mellanox/mlx5/core/devlink.c | 106 ++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/devlink.h |   4 +
 .../mellanox/mlx5/core/en/pcie_cong_event.c   |  72 ++++++++++--
 4 files changed, 226 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 7febe0aecd53..f51647536966 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -116,6 +116,58 @@ parameters.
      - u32
      - driverinit
      - Control the size (in packets) of the hairpin queues.
+   * - ``pcie_cong_inbound_high``
+     - u16
+     - driverinit
+     - High threshold configuration for PCIe congestion events. The firmware
+       will send an event once device side inbound PCIe traffic went
+       above the configured high threshold for a long enough period (at least
+       200ms).
+
+       See pci_bw_inbound_high ethtool stat.
+
+       Units are 0.01 %. Accepted values are in range [0, 10000].
+       pcie_cong_inbound_low < pcie_cong_inbound_high.
+       Default value: 9000 (Corresponds to 90%).
+   * - ``pcie_cong_inbound_low``
+     - u16
+     - driverinit
+     - Low threshold configuration for PCIe congestion events. The firmware
+       will send an event once device side inbound PCIe traffic went
+       below the configured low threshold, only after having been previously in
+       a congested state.
+
+       See pci_bw_inbound_low ethtool stat.
+
+       Units are 0.01 %. Accepted values are in range [0, 10000].
+       pcie_cong_inbound_low < pcie_cong_inbound_high.
+       Default value: 7500.
+   * - ``pcie_cong_outbound_high``
+     - u16
+     - driverinit
+     - High threshold configuration for PCIe congestion events. The firmware
+       will send an event once device side outbound PCIe traffic went
+       above the configured high threshold for a long enough period (at least
+       200ms).
+
+       See pci_bw_outbound_high ethtool stat.
+
+       Units are 0.01 %. Accepted values are in range [0, 10000].
+       pcie_cong_outbound_low < pcie_cong_outbound_high.
+       Default value: 9000 (Corresponds to 90%).
+   * - ``pcie_cong_outbound_low``
+     - u16
+     - driverinit
+     - Low threshold configuration for PCIe congestion events. The firmware
+       will send an event once device side outbound PCIe traffic went
+       below the configured low threshold, only after having been previously in
+       a congested state.
+
+       See pci_bw_outbound_low ethtool stat.
+
+       Units are 0.01 %. Accepted values are in range [0, 10000].
+       pcie_cong_outbound_low < pcie_cong_outbound_high.
+       Default value: 7500.
 
 The ``mlx5`` driver supports reloading via ``DEVLINK_CMD_RELOAD``
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 2c0e0c16ca90..fd1b4895f3ac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -650,6 +650,105 @@ static void mlx5_devlink_eth_params_unregister(struct devlink *devlink)
 			       ARRAY_SIZE(mlx5_devlink_eth_params));
 }
 
+#define MLX5_PCIE_CONG_THRESH_MAX	10000
+#define MLX5_PCIE_CONG_THRESH_DEF_LOW	7500
+#define MLX5_PCIE_CONG_THRESH_DEF_HIGH	9000
+
+static int
+mlx5_devlink_pcie_cong_thresh_validate(struct devlink *devl, u32 id,
+				       union devlink_param_value val,
+				       struct netlink_ext_ack *extack)
+{
+	if (val.vu16 > MLX5_PCIE_CONG_THRESH_MAX) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "Value %u > max supported (%u)",
+				       val.vu16, MLX5_PCIE_CONG_THRESH_MAX);
+
+		return -EINVAL;
+	}
+
+	switch (id) {
+	case MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_LOW:
+	case MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_HIGH:
+	case MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_LOW:
+	case MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_HIGH:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static void mlx5_devlink_pcie_cong_init_values(struct devlink *devlink)
+{
+	union devlink_param_value value;
+	u32 id;
+
+	value.vu16 = MLX5_PCIE_CONG_THRESH_DEF_LOW;
+	id = MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_LOW;
+	devl_param_driverinit_value_set(devlink, id, value);
+
+	value.vu16 = MLX5_PCIE_CONG_THRESH_DEF_HIGH;
+	id = MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_HIGH;
+	devl_param_driverinit_value_set(devlink, id, value);
+
+	value.vu16 = MLX5_PCIE_CONG_THRESH_DEF_LOW;
+	id = MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_LOW;
+	devl_param_driverinit_value_set(devlink, id, value);
+
+	value.vu16 = MLX5_PCIE_CONG_THRESH_DEF_HIGH;
+	id = MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_HIGH;
+	devl_param_driverinit_value_set(devlink, id, value);
+}
+
+static const struct devlink_param mlx5_devlink_pcie_cong_params[] = {
+	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_LOW,
+			     "pcie_cong_inbound_low", DEVLINK_PARAM_TYPE_U16,
+			     BIT(DEVLINK_PARAM_CMODE_DRIVERINIT), NULL, NULL,
+			     mlx5_devlink_pcie_cong_thresh_validate),
+	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_HIGH,
+			     "pcie_cong_inbound_high", DEVLINK_PARAM_TYPE_U16,
+			     BIT(DEVLINK_PARAM_CMODE_DRIVERINIT), NULL, NULL,
+			     mlx5_devlink_pcie_cong_thresh_validate),
+	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_LOW,
+			     "pcie_cong_outbound_low", DEVLINK_PARAM_TYPE_U16,
+			     BIT(DEVLINK_PARAM_CMODE_DRIVERINIT), NULL, NULL,
+			     mlx5_devlink_pcie_cong_thresh_validate),
+	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_HIGH,
+			     "pcie_cong_outbound_high", DEVLINK_PARAM_TYPE_U16,
+			     BIT(DEVLINK_PARAM_CMODE_DRIVERINIT), NULL, NULL,
+			     mlx5_devlink_pcie_cong_thresh_validate),
+};
+
+static int mlx5_devlink_pcie_cong_params_register(struct devlink *devlink)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	int err;
+
+	if (!mlx5_pcie_cong_event_supported(dev))
+		return 0;
+
+	err = devl_params_register(devlink, mlx5_devlink_pcie_cong_params,
+				   ARRAY_SIZE(mlx5_devlink_pcie_cong_params));
+	if (err)
+		return err;
+
+	mlx5_devlink_pcie_cong_init_values(devlink);
+
+	return 0;
+}
+
+static void mlx5_devlink_pcie_cong_params_unregister(struct devlink *devlink)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+
+	if (!mlx5_pcie_cong_event_supported(dev))
+		return;
+
+	devl_params_unregister(devlink, mlx5_devlink_pcie_cong_params,
+			       ARRAY_SIZE(mlx5_devlink_pcie_cong_params));
+}
+
 static int mlx5_devlink_enable_rdma_validate(struct devlink *devlink, u32 id,
 					     union devlink_param_value val,
 					     struct netlink_ext_ack *extack)
@@ -895,8 +994,14 @@ int mlx5_devlink_params_register(struct devlink *devlink)
 	if (err)
 		goto max_uc_list_err;
 
+	err = mlx5_devlink_pcie_cong_params_register(devlink);
+	if (err)
+		goto pcie_cong_err;
+
 	return 0;
 
+pcie_cong_err:
+	mlx5_devlink_max_uc_list_params_unregister(devlink);
 max_uc_list_err:
 	mlx5_devlink_auxdev_params_unregister(devlink);
 auxdev_reg_err:
@@ -907,6 +1012,7 @@ int mlx5_devlink_params_register(struct devlink *devlink)
 
 void mlx5_devlink_params_unregister(struct devlink *devlink)
 {
+	mlx5_devlink_pcie_cong_params_unregister(devlink);
 	mlx5_devlink_max_uc_list_params_unregister(devlink);
 	mlx5_devlink_auxdev_params_unregister(devlink);
 	devl_params_unregister(devlink, mlx5_devlink_params,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
index 961f75da6227..bf6191d49616 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
@@ -22,6 +22,10 @@ enum mlx5_devlink_param_id {
 	MLX5_DEVLINK_PARAM_ID_ESW_MULTIPORT,
 	MLX5_DEVLINK_PARAM_ID_HAIRPIN_NUM_QUEUES,
 	MLX5_DEVLINK_PARAM_ID_HAIRPIN_QUEUE_SIZE,
+	MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_LOW,
+	MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_HIGH,
+	MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_LOW,
+	MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_HIGH,
 };
 
 struct mlx5_trap_ctx {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
index 0ed017569a19..0cf142f71c09 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 // Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES.
 
+#include "../devlink.h"
 #include "en.h"
 #include "pcie_cong_event.h"
 
@@ -41,13 +42,6 @@ struct mlx5e_pcie_cong_event {
 	struct mlx5e_pcie_cong_stats stats;
 };
 
-/* In units of 0.01 % */
-static const struct mlx5e_pcie_cong_thresh default_thresh_config = {
-	.inbound_high = 9000,
-	.inbound_low = 7500,
-	.outbound_high = 9000,
-	.outbound_low = 7500,
-};
 
 static const struct counter_desc mlx5e_pcie_cong_stats_desc[] = {
 	{ MLX5E_DECLARE_STAT(struct mlx5e_pcie_cong_stats,
@@ -249,8 +243,60 @@ static int mlx5e_pcie_cong_event_handler(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static int
+mlx5e_pcie_cong_get_thresh_config(struct mlx5_core_dev *dev,
+				  struct mlx5e_pcie_cong_thresh *config)
+{
+	u32 ids[4] = {
+		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_LOW,
+		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_HIGH,
+		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_LOW,
+		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_HIGH,
+	};
+	struct devlink *devlink = priv_to_devlink(dev);
+	union devlink_param_value val[4];
+
+	for (int i = 0; i < 4; i++) {
+		u32 id = ids[i];
+		int err;
+
+		err = devl_param_driverinit_value_get(devlink, id, &val[i]);
+		if (err)
+			return err;
+	}
+
+	config->inbound_low = val[0].vu16;
+	config->inbound_high = val[1].vu16;
+	config->outbound_low = val[2].vu16;
+	config->outbound_high = val[3].vu16;
+
+	return 0;
+}
+
+static int
+mlx5e_thresh_config_validate(struct mlx5_core_dev *mdev,
+			     const struct mlx5e_pcie_cong_thresh *config)
+{
+	int err = 0;
+
+	if (config->inbound_low >= config->inbound_high) {
+		err = -EINVAL;
+		mlx5_core_err(mdev, "PCIe inbound congestion threshold configuration invalid: low (%u) >= high (%u).\n",
+			      config->inbound_low, config->inbound_high);
+	}
+
+	if (config->outbound_low >= config->outbound_high) {
+		err = -EINVAL;
+		mlx5_core_err(mdev, "PCIe outbound congestion threshold configuration invalid: low (%u) >= high (%u).\n",
+			      config->outbound_low, config->outbound_high);
+	}
+
+	return err;
+}
+
 int mlx5e_pcie_cong_event_init(struct mlx5e_priv *priv)
 {
+	struct mlx5e_pcie_cong_thresh thresh_config = {};
 	struct mlx5e_pcie_cong_event *cong_event;
 	struct mlx5_core_dev *mdev = priv->mdev;
 	int err;
@@ -258,6 +304,16 @@ int mlx5e_pcie_cong_event_init(struct mlx5e_priv *priv)
 	if (!mlx5_pcie_cong_event_supported(mdev))
 		return 0;
 
+	err = mlx5e_pcie_cong_get_thresh_config(mdev, &thresh_config);
+	if (WARN_ON(err))
+		return err;
+
+	err = mlx5e_thresh_config_validate(mdev, &thresh_config);
+	if (err) {
+		mlx5_core_err(mdev, "PCIe congestion event feature disabled\n");
+		return err;
+	}
+
 	cong_event = kvzalloc_node(sizeof(*cong_event), GFP_KERNEL,
 				   mdev->priv.numa_node);
 	if (!cong_event)
@@ -269,7 +325,7 @@ int mlx5e_pcie_cong_event_init(struct mlx5e_priv *priv)
 
 	cong_event->priv = priv;
 
-	err = mlx5_cmd_pcie_cong_event_set(mdev, &default_thresh_config,
+	err = mlx5_cmd_pcie_cong_event_set(mdev, &thresh_config,
 					   &cong_event->obj_id);
 	if (err) {
 		mlx5_core_warn(mdev, "Error creating a PCIe congestion event object\n");
-- 
2.31.1


