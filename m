Return-Path: <linux-rdma+bounces-8683-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E464A60121
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 20:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7584F3BBCF9
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 19:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1E41F460E;
	Thu, 13 Mar 2025 19:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mBICZvWE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBEF1F2B94;
	Thu, 13 Mar 2025 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741893968; cv=fail; b=gZCHxwThgMuOkGdxrpOJqCb3Wr/FVuWu7J/PJSXweVZb7ZcZPRyyEuVuL6j9Rm1w4seF6r6CKeo4RzP638s5zcdNz1nuzItaWhgLrsG3HM2B6iuJd0AL+zENh4oFoEJl+wCgqed+L3x0UGOLFEZa54ydGvq+gpLlitfr2Ul/+lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741893968; c=relaxed/simple;
	bh=Jhpm6baP3ylkYt0lI/ZloktDNvCpqaQfcm3ntfjXn4A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mv3JosfLXxUhg2hGNhW5chvT93BhSP72yJo8pKbIo7OtDSOcCDAG2xmVZ9DJ7rtfMw5+PqBi3k1sI8IKFmVP7CNEg9LQTbU5zMgN+fij+Q/LeXGrQ0NbEvea7GpAFvcdxlIY1iJdtpYuEc+uUOmQIc7wWrK3Fka/cfx6R0W2VPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mBICZvWE; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXHUEogdfS3Jm41hfCtoo+8dOJpiS7wJwSlYvZC9svlBirlK26AJ+jOQ39meFh9lO7uefhyMtKHN6QQ1RZ5mBNKVUQf/6nNWI3IbqQrwrrP2feaQjxAxQIgUNMfkWkpmqL0qIwegv6pAh1pPXy8uDl87X5GWGakFHmodrZtjJH8RrJGPZRA67xes3qOvRYMwdk3HuJMOCMaKxj5wzGUuC0tuobwNooAaIRc6Hni1rry6KB+eT2oh//upmS2nKvcOBNEqERutV3FhUMjeRp9VZfsNDZhgKeFNeW0NwaDD+1aD6sRG0F61n797zb2AyjWc2CF4JcV6XXCQRxpwpPvo3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDSWNNg3jk+5/ZPc2OkfvYYFzVUIW4IJ1YlTOCRdgVs=;
 b=mk1MwE26uG0MGbtdJRFSOaGG7LYUaJXRzK63x5QyeDsAui4p0xAeYodYkeXbiqLHbmkG1ycgD9BUg2EcaFidkDkQWJHRyrpHTiSMvx40+6yoq+X+IOZMvO/nKbVNm0iYA7Zt7bSy2+EzL/f28unOfSwpBLkS8uzNJk6JoVshfl5hw2arI9VbiF3dLbveHyzk+o/aScfSpfpKVHQgvInyIhXzGerJ77jvbqr8sFDWS5pYTB6+qWWduRjOc9+nJ46Bevy4SosaP/ORWKCdluP0uLHqpqU4cvP92OqGe+EB2NqtuEYy5XyXwE/PJskwuEfrTv0haF1zqw+RfI3W7X3JdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDSWNNg3jk+5/ZPc2OkfvYYFzVUIW4IJ1YlTOCRdgVs=;
 b=mBICZvWEhKu5tusiXE3mRLLTvbB6kt0JDW0uQal9CfJ3KzzT693L5nyJJGfxBQZiVSm/JyuylOLq1sm+QirIgx/K8qaKKHtZARTUlighRbkZENoQAlV3ANsiWfjz+xaUd2YV/clofrZDVr7LQfto8q/2cyDHInMfVOrQkPy8xTbzBM543qVJGTaiZ1a7a5iL3hudJ7Q4NzXgAm3Ymk5eR33QbqGFFaIjzpnNOJbga9bC4hCJrdecQXE8qeG7W8a+Qvea86tnSoGTcNucAdTdqee1NM6FiKDULnu5dq7LWbZvxBU4whHnfLli33bgOwwWdCz0xdSA1/od8ctQ2tcMeA==
Received: from BL0PR1501CA0019.namprd15.prod.outlook.com
 (2603:10b6:207:17::32) by DS7PR12MB6357.namprd12.prod.outlook.com
 (2603:10b6:8:96::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 19:25:57 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::84) by BL0PR1501CA0019.outlook.office365.com
 (2603:10b6:207:17::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Thu,
 13 Mar 2025 19:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 19:25:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Mar
 2025 12:25:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 12:25:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 13 Mar 2025 12:25:36 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yael Chemla <ychemla@nvidia.com>
Subject: [PATCH net-next 4/4] net/mlx5e: Expose port reset cycle recovery counter via ethtool
Date: Thu, 13 Mar 2025 21:24:46 +0200
Message-ID: <1741893886-188294-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1741893886-188294-1-git-send-email-tariqt@nvidia.com>
References: <1741893886-188294-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DS7PR12MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 974c9b4b-64bd-42cc-35fe-08dd6264e151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?osbrk686ddROyn/SXl9D6MKumf5o9FJD82EtCK8WUKB+Ywuai4aVEdZ3Ehsa?=
 =?us-ascii?Q?Eh67um2tEvfrSg4N1En0JQKixfa3/XeFfTRv+V+dI2gdCab5Ii/r//VOJCWw?=
 =?us-ascii?Q?WTKCt3tHek9aOPLVK7+pXJZOIMxQ4hCTgHko/zSxOpatYwmFEdFD2Al9uff2?=
 =?us-ascii?Q?PKpLyQrxO8BRcL6Hg3wBQH+8A5TU4rzm7wPTyLi6vQBM+aXmVIWaDDAAe10W?=
 =?us-ascii?Q?y9N5bNo6fxxrBveJ++FfL/coTEJY58kUDrMOSW2gTXRcU47NpHcbZ1OG88La?=
 =?us-ascii?Q?6kSG/3KpLy3kLrd2ahELbzQL1yPTksOHUpLaEfsCLXq8tmkdKR9n4bwwBMq5?=
 =?us-ascii?Q?6Dqb9fEcgcyjtAadsxI3fAUXhWDzpVTBO2s7PFy95IYjPvEWXvWK61W+wZrc?=
 =?us-ascii?Q?jnhpeN4z1t46wJwA61j6UoNnDXfttNgeMZmqVY7Pn0P+McSo97GNH5MiaP+N?=
 =?us-ascii?Q?R7rmJxBqODBQEdY0XiNWO+wYPIMvwpb6uCTNuc+6sIHshMcvZWPPYSk4LTAX?=
 =?us-ascii?Q?ax39m5Y3IXVk5DHftz7I7OwWrXcnWyW7bi1cWYyRUKLjKYotELI+QVM4uqz8?=
 =?us-ascii?Q?qBRLNEFjrjpwBCZbnpC/JAgE6jIuXt6apnbRtNAOw4JjjEL9aBAhbV37rP4D?=
 =?us-ascii?Q?jlIjAqR0V59CTc5e6oJnaxHWYrq9II54WWbpnOSfgjCdKQNk8MWxwkotNcAK?=
 =?us-ascii?Q?kxYxu8ZTWDLILDqmCCLyn2JdcbbocoUBHBDGI82TDFWJbBimTZFAHgn9lCjl?=
 =?us-ascii?Q?UnYcS4jG5k+U3gZXAaNHx+FUeP+gab17r3To6tPeqQdU00G+ZU4KMT7/Q9xd?=
 =?us-ascii?Q?GX80ie89nM5ndffdCs292Vhksrah10LqH3Sdtw1sI2beKkHEr3BJfN+8QHCe?=
 =?us-ascii?Q?r/mBQuAaT3EvDdKnBK01A6fBRR0u9mhoeo6f/TqIM4w4ujvwJwIhTCmDMI9h?=
 =?us-ascii?Q?3a/ZZk1UoV+FEF1etUqCgvIBxoc6J9GJx/zif1V9yWIMTcaVXdCG6HFo1/kO?=
 =?us-ascii?Q?8j6wwqAjLj7ADiYvpHTrYgiZhUBPzWFRp1619ayFDP4cW0dGS+YDc5npzhQt?=
 =?us-ascii?Q?VPsBZQuQwb9M63V142cKItjVqlfCau+1aPrmu0e8nyaMxSESoByINACsbdKW?=
 =?us-ascii?Q?Z5kfkZ+bbtVilhSThrPF4Fh2RjJl+Atv5Cmq1Xp6LEJfVOlxbeBGQiT7tguE?=
 =?us-ascii?Q?KhTwkTT0nw7yOJDGzmbYpRmuwmeuvUKzOF0NBxUrwW5N1pI7M6A4iuDepgGs?=
 =?us-ascii?Q?5t+V26m1+hguJUTyz9QElJn4Lu66qvppkrCIxk2xSQch/kBkY860an79yyPm?=
 =?us-ascii?Q?T3oDL3JvOluBslssCoan3pKq5zgSYrpcgbvnPw2+rLSNCgkf3SGq/J4PzkXr?=
 =?us-ascii?Q?xnfTFvsEBwQBhVkr+bRp4+ldARWMwjl0PtpeF8gxyr6wxHobT9VkucdNxMOj?=
 =?us-ascii?Q?/RGMnymLr/POnXN4RplhHOUAoZBqNyqSDUCiCO94e/ry7KDgXbBhFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 19:25:57.0894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 974c9b4b-64bd-42cc-35fe-08dd6264e151
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6357

From: Yael Chemla <ychemla@nvidia.com>

Display recovery event of PPCNT recovery counters group. Counts (per
link) the number of total successful recovery events of any recovery
types during port reset cycle.

Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/counters.rst       |  5 +++
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 44 ++++++++++++++++---
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  4 ++
 3 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
index 99d95be4d159..f9a1cf370b5a 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
@@ -1082,6 +1082,11 @@ like flow control, FEC and more.
        need to replace the cable/transceiver.
      - Error
 
+  * - `total_success_recovery_phy`
+     - The number of total successful recovery events of any type during
+       ports reset cycle.
+     - Error
+
    * - `rx_out_of_buffer`
      - Number of times receive queue had no software buffers allocated for the
        adapter's incoming traffic.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index a417962acfa9..acb00fd7efa4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1250,12 +1250,22 @@ pport_phy_statistical_err_lanes_stats_desc[] = {
 	{ "rx_err_lane_3_phy", PPORT_PHY_STATISTICAL_OFF(phy_corrected_bits_lane3) },
 };
 
+#define PPORT_PHY_RECOVERY_OFF(c) \
+	MLX5_BYTE_OFF(ppcnt_reg, counter_set.phys_layer_recovery_cntrs.c)
+static const struct counter_desc
+pport_phy_recovery_cntrs_stats_desc[] = {
+	{ "total_success_recovery_phy",
+	  PPORT_PHY_RECOVERY_OFF(total_successful_recovery_events) }
+};
+
 #define NUM_PPORT_PHY_LAYER_COUNTERS \
 	ARRAY_SIZE(pport_phy_layer_cntrs_stats_desc)
 #define NUM_PPORT_PHY_STATISTICAL_COUNTERS \
 	ARRAY_SIZE(pport_phy_statistical_stats_desc)
 #define NUM_PPORT_PHY_STATISTICAL_PER_LANE_COUNTERS \
 	ARRAY_SIZE(pport_phy_statistical_err_lanes_stats_desc)
+#define NUM_PPORT_PHY_RECOVERY_COUNTERS \
+	ARRAY_SIZE(pport_phy_recovery_cntrs_stats_desc)
 
 #define NUM_PPORT_PHY_STATISTICAL_LOOPBACK_COUNTERS(dev) \
 	(MLX5_CAP_PCAM_FEATURE(dev, ppcnt_statistical_group) ? \
@@ -1263,6 +1273,9 @@ pport_phy_statistical_err_lanes_stats_desc[] = {
 #define NUM_PPORT_PHY_STATISTICAL_PER_LANE_LOOPBACK_COUNTERS(dev) \
 	(MLX5_CAP_PCAM_FEATURE(dev, per_lane_error_counters) ? \
 	NUM_PPORT_PHY_STATISTICAL_PER_LANE_COUNTERS : 0)
+#define NUM_PPORT_PHY_RECOVERY_LOOPBACK_COUNTERS(dev) \
+	(MLX5_CAP_PCAM_FEATURE(dev, ppcnt_recovery_counters) ? \
+	NUM_PPORT_PHY_RECOVERY_COUNTERS : 0)
 
 static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(phy)
 {
@@ -1275,6 +1288,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(phy)
 
 	num_stats += NUM_PPORT_PHY_STATISTICAL_PER_LANE_LOOPBACK_COUNTERS(mdev);
 
+	num_stats += NUM_PPORT_PHY_RECOVERY_LOOPBACK_COUNTERS(mdev);
 	return num_stats;
 }
 
@@ -1295,6 +1309,10 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(phy)
 		ethtool_puts(data,
 			     pport_phy_statistical_err_lanes_stats_desc[i]
 			     .format);
+
+	for (i = 0; i < NUM_PPORT_PHY_RECOVERY_LOOPBACK_COUNTERS(mdev); i++)
+		ethtool_puts(data,
+			     pport_phy_recovery_cntrs_stats_desc[i].format);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(phy)
@@ -1324,6 +1342,13 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(phy)
 			MLX5E_READ_CTR64_BE(
 				&priv->stats.pport.phy_statistical_counters,
 				pport_phy_statistical_err_lanes_stats_desc, i));
+
+	for (i = 0; i < NUM_PPORT_PHY_RECOVERY_LOOPBACK_COUNTERS(mdev); i++)
+		mlx5e_ethtool_put_stat(
+			data,
+			MLX5E_READ_CTR32_BE(
+				&priv->stats.pport.phy_recovery_counters,
+				pport_phy_recovery_cntrs_stats_desc, i));
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(phy)
@@ -1339,12 +1364,21 @@ static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(phy)
 	MLX5_SET(ppcnt_reg, in, grp, MLX5_PHYSICAL_LAYER_COUNTERS_GROUP);
 	mlx5_core_access_reg(mdev, in, sz, out, sz, MLX5_REG_PPCNT, 0, 0);
 
-	if (!MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_statistical_group))
-		return;
+	if (MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_statistical_group)) {
+		out = pstats->phy_statistical_counters;
+		MLX5_SET(ppcnt_reg, in, grp,
+			 MLX5_PHYSICAL_LAYER_STATISTICAL_GROUP);
+		mlx5_core_access_reg(mdev, in, sz, out, sz, MLX5_REG_PPCNT, 0,
+				     0);
+	}
 
-	out = pstats->phy_statistical_counters;
-	MLX5_SET(ppcnt_reg, in, grp, MLX5_PHYSICAL_LAYER_STATISTICAL_GROUP);
-	mlx5_core_access_reg(mdev, in, sz, out, sz, MLX5_REG_PPCNT, 0, 0);
+	if (MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_recovery_counters)) {
+		out = pstats->phy_recovery_counters;
+		MLX5_SET(ppcnt_reg, in, grp,
+			 MLX5_PHYSICAL_LAYER_RECOVERY_GROUP);
+		mlx5_core_access_reg(mdev, in, sz, out, sz, MLX5_REG_PPCNT, 0,
+				     0);
+	}
 }
 
 void mlx5e_get_link_ext_stats(struct net_device *dev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 5961c569cfe0..0d87947e348d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -309,6 +309,9 @@ struct mlx5e_vport_stats {
 #define PPORT_PHY_STATISTICAL_GET(pstats, c) \
 	MLX5_GET64(ppcnt_reg, (pstats)->phy_statistical_counters, \
 		   counter_set.phys_layer_statistical_cntrs.c##_high)
+#define PPORT_PHY_RECOVERY_GET(pstats, c) \
+	MLX5_GET64(ppcnt_reg, (pstats)->phy_recovery_counters, \
+		   counter_set.phys_layer_recovery_cntrs.c)
 #define PPORT_PER_PRIO_GET(pstats, prio, c) \
 	MLX5_GET64(ppcnt_reg, pstats->per_prio_counters[prio], \
 		   counter_set.eth_per_prio_grp_data_layout.c##_high)
@@ -324,6 +327,7 @@ struct mlx5e_pport_stats {
 	__be64 per_prio_counters[NUM_PPORT_PRIO][MLX5_ST_SZ_QW(ppcnt_reg)];
 	__be64 phy_counters[MLX5_ST_SZ_QW(ppcnt_reg)];
 	__be64 phy_statistical_counters[MLX5_ST_SZ_QW(ppcnt_reg)];
+	__be64 phy_recovery_counters[MLX5_ST_SZ_QW(ppcnt_reg)];
 	__be64 eth_ext_counters[MLX5_ST_SZ_QW(ppcnt_reg)];
 	__be64 per_tc_prio_counters[NUM_PPORT_PRIO][MLX5_ST_SZ_QW(ppcnt_reg)];
 	__be64 per_tc_congest_prio_counters[NUM_PPORT_PRIO][MLX5_ST_SZ_QW(ppcnt_reg)];
-- 
2.31.1


