Return-Path: <linux-rdma+bounces-10449-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA44AABE315
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 20:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F763BB6FE
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 18:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EED280A52;
	Tue, 20 May 2025 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WkJsiNng"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A608326C390;
	Tue, 20 May 2025 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747766852; cv=fail; b=KrRXvmrsgvN/Jqpc7pk7Sc0EwAfk49BE7821snGPpJDpng9qBKVdj42fIMVgp+eHzr9z61VG3ACQSfGbjLh65Qv8a53JHiyVLiLA0KjdxChLmx74Ey8z3R6xR31fIMaDK24N+C5ayA/zoyNnxTJpx9QxZ7/QC9OJjAfdEqDYa/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747766852; c=relaxed/simple;
	bh=ZeI7Zz7BmCiFA1CKJNGwrxCNoP2DLQCd4djMZoOAZEM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtH5Gkq58JSBNPJWURXciGzTMQY+EXd4fDazEA7PqHtJtDJAky4w49bylGVkLy2g/L/x2JZiuJdN1OCilE2qbDnmKqy+NXMAX63FUb/lnAYPDQQ+2V8fKAv3wsWYWcpmuw5Qtx03SFEgb0XQ7HE31wR3tLjA3bwYtrucPye8IOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WkJsiNng; arc=fail smtp.client-ip=40.107.101.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXQqs5NPHnKqF5Zl3J9nuSYophxDhXL9w1ra8ehtWBdfTvpPb5ODOsLy8nQZtumRDrOvRU75huD32N/dhmV6X62qrF8w4X5MES4YSElQYwsPDU96VzUqP/J51EZRJzJh9uRQ89+uWygL4TgHu4IdfNAB7deOIUpNwmTzyEt005md7zv4MOJq4Y8CxXtOkO4x4w0Q5Wvwa/9Gy1TXbp7bTKeywBlLVBxyZOXCToChHebzydNJnK6dn/ZnuVrw4ZIcjFzwAisQqB/BBdMVj3bRqsCjInIcHhr3AYH+2syNcNGgLZczR3QXn8FsyDke5jJ77nl40aogzbbthc+s97mZ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALQZ3ElS3370N3TjjIWVntyuDTFazLwf3JyVrRK/V/s=;
 b=MGcJtfLKiAUMVcbsZVxC3mmyG53umaiM1c9F2418ziyvS7P/tcCd6buSJCS0ILCE2njXZ5Kd98EPc/k9m65XTGrWUIJtEtOvbXZP1ifpeXfjsqz4tKIVerXDHxzybIInsQ8h9YU0rPTG30d13WrtyeDlsfjSJys8/mINtOvr2UX3jtCNrF11RYdWuwxyoluOoK0tdw4yufP9duecG1IP3/HP2mK1sECV31yHpWD2xj02lOXPeyI02Td/GcTCDkhisw4yCSl+2vWEOuHvUz0BUC3ailseQKAQB0Hs6QgDB4y8OCXCRPy7pGFYH4SuUpTb6CTIn+YywE31NJRGQIWi0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALQZ3ElS3370N3TjjIWVntyuDTFazLwf3JyVrRK/V/s=;
 b=WkJsiNngpFZHqIQbylcihKkwQkD2J7VMmshPUsZwPCN99NpSvgsbEAFgffyWVw3vQ4FD14cFleXckbWitjE3cz57QWmQ9VZ5I+DZAlZIP+0yuAqomPYl38BtgIt4phHE8gptZOSbi6DDxGRIyqU+mRpJ5gvT1z1DEWFxAB7Rgud7dxD/4t692Z7RomfjNG5+8Dl46Q7rB8cNzK2w8N+SW0jgHaD5BMZf1L5R983ACxEoauCPdxMJr6KAdKRTFeLmNFN7i3J+k3KwHth6OaFSE1XHS4p43769QFIfB0Ybh8Ld00CbQCvUo9h1rKC9B2dAKSw955oKtM+vFM8O5oFPNw==
Received: from PH8P221CA0047.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::26)
 by CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 18:47:25 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:510:346:cafe::7b) by PH8P221CA0047.outlook.office365.com
 (2603:10b6:510:346::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 20 May 2025 18:47:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.4 via Frontend Transport; Tue, 20 May 2025 18:47:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 May
 2025 11:47:06 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 20 May
 2025 11:47:06 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 20
 May 2025 11:47:02 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next 1/4] net/mlx5: SWS, fix reformat id error handling
Date: Tue, 20 May 2025 21:46:39 +0300
Message-ID: <1747766802-958178-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1747766802-958178-1-git-send-email-tariqt@nvidia.com>
References: <1747766802-958178-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: cb25d138-92b3-4753-f34d-08dd97cec30b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q2YEW+BBOLXLBIeAJbT2UiIU0A9zjBEOXpKIYTEL1731WwcnOHENcs/IKIRI?=
 =?us-ascii?Q?9OzsHqMIyOh9sPhXgVyys9z+Kxw1gZVsNvWIqfIX4Pj+gxKeRdEOEOmaHNtH?=
 =?us-ascii?Q?iRRsV950nuw3RulmOVbiwDbUn76XEFra01+ufNAsFQZU7BhLMlfEhxxVlIwh?=
 =?us-ascii?Q?4ds/SqtH11cgBe4K4vbaIF6KRPxlLaxnGWS3bB9MOBSPAlMn1+F/s5Fc7Mpj?=
 =?us-ascii?Q?Ek6mVkC6APlDRZ3UDz8MT3aJbb35lI5GfzbjdMKOwQDgarChIeW7V0Obws5G?=
 =?us-ascii?Q?jrWkSHFcU+RFDCp9grbWVeWKjBiiMfxtLtqg6QCPj8E6GIyBNIPMJhvVlt24?=
 =?us-ascii?Q?YHTn+Bv8t8vZzoJ6FxLn5ZVC7tLcRgrKat2bTXTKJ6PWo5/8/OpXsO+KQZRA?=
 =?us-ascii?Q?/NRf8uZoNpE6HKHHoNrwNcACjzX5EZdwJrEbhBV4mkZZhXuO+yCgNR85OSf7?=
 =?us-ascii?Q?Ntn5mtmbtkearcXB9N2/WURMrAcScC23rejSO/jrBnQ0PMn+qdQ31wr/vaRm?=
 =?us-ascii?Q?Y3srNEjE2pq1b8uZXrCBTcXLKmmjRN0E8dLw6Az5lJOiuuurw8LH1logqgFO?=
 =?us-ascii?Q?U3KdgxipZtue5PKZuvpfejnEHUyiFrOjgMLrhO5lmeronMCYbvqZCddZf7gx?=
 =?us-ascii?Q?+GOiF2aCMGpFucCXEaGNZI8n8/4ihBibhfkZMFqhTsXZ9qAdF2NrjO9yf4A4?=
 =?us-ascii?Q?NH5p7QhdKKKHUehI5mczcpUAx5+RBtuuGb/nBR9NvhP9PXEdCIYEg+gQ+oOn?=
 =?us-ascii?Q?WKADQPm80iqsvQI/9v9yA77RUu2FireAfrfTx6wueqny7MDTy9XGktMRuOkR?=
 =?us-ascii?Q?dw7USyIYq2TWVhl3qsh+ka684gQidHm+vk+RCr+BjI/nOJz/dfHd5breA8Hy?=
 =?us-ascii?Q?gM7+KBLaPYvENYELOObq3xgIJR6ji7awYF9gg/72OGkfE61Yy7s1JPXOfDAa?=
 =?us-ascii?Q?wtNuaWHa0xSsmfYWrc96UdajmFhfMn7RS/Hf+WaaiX4PW2f1fMoKrFbtIbzA?=
 =?us-ascii?Q?oDXUH/11a4H+OjYW6U4UMRnpStTDPdStptMM+mu6nU3pbquoFZ985/uE5/Xr?=
 =?us-ascii?Q?uFVa/RY9MYs4Xbvp03mqgXSD+zR9HY5vzbPxYW5J0YiDihwezEvAwwhLqaQV?=
 =?us-ascii?Q?Fuw/KewIwE2HQc+eFMJoVXmlxio/jR0tAQyzUnhfXTQDeKQAhwumyCv/7MDE?=
 =?us-ascii?Q?Cxl/9IdHiEwXma3CYyvx4kDKcYGaNvbaLH6bCfZaWKPLPJDME2l/FwamcXs2?=
 =?us-ascii?Q?yTOKBbmduq5B9TdqWvZhubZ2Ct9YQsY/wphwhfN9kJNpb8ix3bkFf9QAazx9?=
 =?us-ascii?Q?1SIBDR+H6ql3Br4dlNEd4eMnD4D2XWAN40AUVzx+8X+3c900HaLhywlY/NOB?=
 =?us-ascii?Q?KV7wB828Z5N6M8keTu1E8xQ9as4XS6ETv3esw04o5HqgPCXZ3oB+E1Ln3NGa?=
 =?us-ascii?Q?1lKqc933r4bG+gouBQRtOjl0oyAgehbDFRSNc7BAd8KIpfcVmbVL1petMA6T?=
 =?us-ascii?Q?7Dis9vSFECsvkVWGqC/83Py/Wi+BPVhQaUNA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 18:47:24.6064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb25d138-92b3-4753-f34d-08dd97cec30b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066

From: Vlad Dogaru <vdogaru@nvidia.com>

The firmware reformat id is a u32 and can't safely be returned as an
int. Because the functions also need a way to signal error, prefer to
return the id as an output parameter and keep the return code only for
success/error.

While we're at it, also extract some duplicate code to fetch the
reformat id from a more generic struct pkt_reformat.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  | 28 +++++++++---------
 .../net/ethernet/mellanox/mlx5/core/fs_core.c | 29 +++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |  3 ++
 .../mellanox/mlx5/core/steering/sws/fs_dr.c   | 10 +++++--
 .../mellanox/mlx5/core/steering/sws/fs_dr.h   | 10 +++++--
 5 files changed, 55 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index a47c29571f64..1af76da8b132 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -527,7 +527,7 @@ static int mlx5_cmd_set_fte(struct mlx5_core_dev *dev,
 	struct mlx5_flow_rule *dst;
 	void *in_flow_context, *vlan;
 	void *in_match_value;
-	int reformat_id = 0;
+	u32 reformat_id = 0;
 	unsigned int inlen;
 	int dst_cnt_size;
 	u32 *in, action;
@@ -580,23 +580,21 @@ static int mlx5_cmd_set_fte(struct mlx5_core_dev *dev,
 	MLX5_SET(flow_context, in_flow_context, action, action);
 
 	if (!extended_dest && fte->act_dests.action.pkt_reformat) {
-		struct mlx5_pkt_reformat *pkt_reformat = fte->act_dests.action.pkt_reformat;
-
-		if (pkt_reformat->owner == MLX5_FLOW_RESOURCE_OWNER_SW) {
-			reformat_id = mlx5_fs_dr_action_get_pkt_reformat_id(pkt_reformat);
-			if (reformat_id < 0) {
-				mlx5_core_err(dev,
-					      "Unsupported SW-owned pkt_reformat type (%d) in FW-owned table\n",
-					      pkt_reformat->reformat_type);
-				err = reformat_id;
-				goto err_out;
-			}
-		} else {
-			reformat_id = fte->act_dests.action.pkt_reformat->id;
+		struct mlx5_pkt_reformat *pkt_reformat =
+			fte->act_dests.action.pkt_reformat;
+
+		err = mlx5_fs_get_packet_reformat_id(pkt_reformat,
+						     &reformat_id);
+		if (err) {
+			mlx5_core_err(dev,
+				      "Unsupported pkt_reformat type (%d)\n",
+				      pkt_reformat->reformat_type);
+			goto err_out;
 		}
 	}
 
-	MLX5_SET(flow_context, in_flow_context, packet_reformat_id, (u32)reformat_id);
+	MLX5_SET(flow_context, in_flow_context, packet_reformat_id,
+		 reformat_id);
 
 	if (fte->act_dests.action.modify_hdr) {
 		if (fte->act_dests.action.modify_hdr->owner == MLX5_FLOW_RESOURCE_OWNER_SW) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 6163bc98d94a..a81b81a3b8f0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -1830,14 +1830,33 @@ static int create_auto_flow_group(struct mlx5_flow_table *ft,
 	return err;
 }
 
+int mlx5_fs_get_packet_reformat_id(struct mlx5_pkt_reformat *pkt_reformat,
+				   u32 *id)
+{
+	switch (pkt_reformat->owner) {
+	case MLX5_FLOW_RESOURCE_OWNER_FW:
+		*id = pkt_reformat->id;
+		return 0;
+	case MLX5_FLOW_RESOURCE_OWNER_SW:
+		return mlx5_fs_dr_action_get_pkt_reformat_id(pkt_reformat, id);
+	default:
+		return -EINVAL;
+	}
+}
+
 static bool mlx5_pkt_reformat_cmp(struct mlx5_pkt_reformat *p1,
 				  struct mlx5_pkt_reformat *p2)
 {
-	return p1->owner == p2->owner &&
-		(p1->owner == MLX5_FLOW_RESOURCE_OWNER_FW ?
-		 p1->id == p2->id :
-		 mlx5_fs_dr_action_get_pkt_reformat_id(p1) ==
-		 mlx5_fs_dr_action_get_pkt_reformat_id(p2));
+	int err1, err2;
+	u32 id1, id2;
+
+	if (p1->owner != p2->owner)
+		return false;
+
+	err1 = mlx5_fs_get_packet_reformat_id(p1, &id1);
+	err2 = mlx5_fs_get_packet_reformat_id(p2, &id2);
+
+	return !err1 && !err2 && id1 == id2;
 }
 
 static bool mlx5_flow_dests_cmp(struct mlx5_flow_destination *d1,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 0767239f651c..248a74108fb1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -386,6 +386,9 @@ u32 mlx5_fs_get_capabilities(struct mlx5_core_dev *dev, enum mlx5_flow_namespace
 
 struct mlx5_flow_root_namespace *find_root(struct fs_node *node);
 
+int mlx5_fs_get_packet_reformat_id(struct mlx5_pkt_reformat *pkt_reformat,
+				   u32 *id);
+
 #define fs_get_obj(v, _node)  {v = container_of((_node), typeof(*v), node); }
 
 #define fs_list_for_each_entry(pos, root)		\
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/fs_dr.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/fs_dr.c
index 8007d3f523c9..f367997ab61e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/fs_dr.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/fs_dr.c
@@ -833,15 +833,21 @@ static u32 mlx5_cmd_dr_get_capabilities(struct mlx5_flow_root_namespace *ns,
 	return steering_caps;
 }
 
-int mlx5_fs_dr_action_get_pkt_reformat_id(struct mlx5_pkt_reformat *pkt_reformat)
+int
+mlx5_fs_dr_action_get_pkt_reformat_id(struct mlx5_pkt_reformat *pkt_reformat,
+				      u32 *reformat_id)
 {
+	struct mlx5dr_action *dr_action;
+
 	switch (pkt_reformat->reformat_type) {
 	case MLX5_REFORMAT_TYPE_L2_TO_VXLAN:
 	case MLX5_REFORMAT_TYPE_L2_TO_NVGRE:
 	case MLX5_REFORMAT_TYPE_L2_TO_L2_TUNNEL:
 	case MLX5_REFORMAT_TYPE_L2_TO_L3_TUNNEL:
 	case MLX5_REFORMAT_TYPE_INSERT_HDR:
-		return mlx5dr_action_get_pkt_reformat_id(pkt_reformat->fs_dr_action.dr_action);
+		dr_action = pkt_reformat->fs_dr_action.dr_action;
+		*reformat_id = mlx5dr_action_get_pkt_reformat_id(dr_action);
+		return 0;
 	}
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/fs_dr.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/fs_dr.h
index 99a3b2eff6b8..f869f2daefbf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/fs_dr.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/fs_dr.h
@@ -38,7 +38,9 @@ struct mlx5_fs_dr_table {
 
 bool mlx5_fs_dr_is_supported(struct mlx5_core_dev *dev);
 
-int mlx5_fs_dr_action_get_pkt_reformat_id(struct mlx5_pkt_reformat *pkt_reformat);
+int
+mlx5_fs_dr_action_get_pkt_reformat_id(struct mlx5_pkt_reformat *pkt_reformat,
+				      u32 *reformat_id);
 
 const struct mlx5_flow_cmds *mlx5_fs_cmd_get_dr_cmds(void);
 
@@ -49,9 +51,11 @@ static inline const struct mlx5_flow_cmds *mlx5_fs_cmd_get_dr_cmds(void)
 	return NULL;
 }
 
-static inline u32 mlx5_fs_dr_action_get_pkt_reformat_id(struct mlx5_pkt_reformat *pkt_reformat)
+static inline int
+mlx5_fs_dr_action_get_pkt_reformat_id(struct mlx5_pkt_reformat *pkt_reformat,
+				      u32 *reformat_id)
 {
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static inline bool mlx5_fs_dr_is_supported(struct mlx5_core_dev *dev)
-- 
2.31.1


