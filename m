Return-Path: <linux-rdma+bounces-13713-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCAABA7870
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 23:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D81F177D27
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 21:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26B92BD5A7;
	Sun, 28 Sep 2025 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PmC1Wlkk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F902BE631;
	Sun, 28 Sep 2025 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759094767; cv=fail; b=eEe0DAPNzxbWTFh9UrbEAdAPf67SFlPObdLhYdwO/+yaft2OgmYJ7W6KpTa4CDpV8bBmLw3Vn+2yswIQwbGuGoXpEQe/dBlwGIln4wesrP6zXU+6tJMHNeifEWjCintciKs4zZkJULjTyrNsm0DRhcxoCDv1zDT0fchHJERLVko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759094767; c=relaxed/simple;
	bh=RHuqGN92Wz2haRZmfdn4+gwfCwxklaLhaXsVtwbTxos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnYZlM+BkvSthnayfDa7Hq3KWmXf86SjNjWaFclAjrz3yy+tkdCUvlMS0d1WK1DxppsFsd77pfMmy9igwXWBhtZhZ6uYhU2WRx9ki4h0leZyRtQEFOo/IKTaQf6okge15kvEscFhxOEQETSJ19zSbGw6yPhqaIqVJIyJo2DEWf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PmC1Wlkk; arc=fail smtp.client-ip=52.101.56.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXswJgdQ8dzOhgv9u3g75fm4wTxfvJJZr4o8ZptXtKgmpkP5mc/lz/OdBsvR7IdUJEttTjSCcfBkFOF3CdKQaO3SwfAyNdgpeygJfICKMp9CuJQ17hQWc3AT0fpy60SDg4DhprvrKzeZ/TkzXSwCoTqqzIooeWXWR24s5lDIfw+4Ia/MOSAoqA4hszV6c85ymjhyavtTOD0vmiPigOup9MZYrz3QAAwzvC/lTZc2KGk3Xq2XB9uLmOFQS46+f4kPNQWiNFwe2GCB897HlezvcCmPscKwoGzVjynygFM2niRm0/1UN2akJeF6jR7wxLY22njvfewfy5+liZ/Eo5Fz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVJ2lQ38HA05NnjBD+fbEOCgLcd8jTahsnUvOA4ZvUA=;
 b=KjC91vTXrhd8+PFdV4aNQKQixvB84kLb4qKn0dIQuUHbVuMDqNVEjtKOiGhYOBSxZa/e4zlrC3W9vMuZI7klUP+Aol4xTzgvYeVLtmceEPfc9mcgtWzKpncLAVwSherbpcUjI/oD1HjnRFcRLD1eEbj8G1018BavJeFaTCavpXbWipK/MHawNZlYHCEuPhC+8ZDPuyb2bit4lOXPl0VKfe/6isoiXjtjpmSPdxfZ8cQOZP/0SJYTs3DmuDV9ONWXxsHQ0l0NPzCyZgdx4aKDX8ouEVytUjA0Rz/yusBBd7Y7hi4Qgp0HWlsVlxrsd+kGN7cutmONR5cWZClcdticVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVJ2lQ38HA05NnjBD+fbEOCgLcd8jTahsnUvOA4ZvUA=;
 b=PmC1WlkkHlH+/L5zKPT6U9gVlEMhytJMZrmNYqJQsbGl6tuMkxJry0/W7AAMH8MTxGTkA4KUZVjcgxut+xnhs+BwxByunoAl0pSRAKFowmaqtVq55ivfdgpPCMyyUrQkZWR9BLZV2Sqc4fyEq82UOfqSk8gmCtze0G/j8xUyKvI9rJhvx+tSK/uSwFBYa0LsC5U83EmJ73ZfKW5qxpXXL6Weq7MNwUF8ioAfmFh2HeGDurJc2jde02erF+FaosYKscXhN5JdjVzz9lvlz6Ic0wdifxvQmSk9uHGy7rqEmP+Vi93EaI7xlNgYRMw0r0BBoQzkHLiVpOLuD2CRPUrE2A==
Received: from PH5P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::16)
 by DS2PR12MB9638.namprd12.prod.outlook.com (2603:10b6:8:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Sun, 28 Sep
 2025 21:25:59 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:34b:cafe::f5) by PH5P222CA0005.outlook.office365.com
 (2603:10b6:510:34b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Sun,
 28 Sep 2025 21:25:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Sun, 28 Sep 2025 21:25:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 28 Sep
 2025 14:25:57 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 28 Sep 2025 14:25:56 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 28 Sep 2025 14:25:53 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net-next V2 3/7] net/mlx5: Improve QoS error messages with actual depth values
Date: Mon, 29 Sep 2025 00:25:19 +0300
Message-ID: <1759094723-843774-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1759094723-843774-1-git-send-email-tariqt@nvidia.com>
References: <1759094723-843774-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|DS2PR12MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: cc3afd7d-b541-4c0a-a2d2-08ddfed59df2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fuC4bZgy2COJ5wvYD/wrCetvGTvnVep2Roa3y4lGiIajqmDTgyCrIjEB3Sfx?=
 =?us-ascii?Q?QyVMrOyIH3uR2HIhpsUupxM2SiadpgmyXyi1oUIExfLmEDkLKxeTlT9LVl8M?=
 =?us-ascii?Q?0mCgr02r88IGeyy2YBD4hDFcVmx/zHQekAIEkEYFoxDqe9UZj2rNM6wNO7HA?=
 =?us-ascii?Q?sBRYt1FcBLbzR5Lwjrl4GJ+HGmv/ubvqErw2M/xMHDGu2jZ9Vp0yjgDzs2+v?=
 =?us-ascii?Q?wVliBt4oK3RvkAdPg/J3g1kA9rmJYYeE43Mb8fHbvnGwyKnmoAaEbmHvTut6?=
 =?us-ascii?Q?I57N8CqfseSgsI06wwcFt97BrlPSK2OgHkOxGJhgreGbiKfi6lxWnb/8v2zU?=
 =?us-ascii?Q?34DqNeP3PiXxKzO/r/zuNlj/BvHyY4vBEbeqjmZwMcDZSlY8k6VFjwR4deCH?=
 =?us-ascii?Q?8Vtx+S0nnqDkFhBPbdrT7UAUOtMbH2Dx+si10IdlveYzg/A7jwBtKZMScFRj?=
 =?us-ascii?Q?bqsOsnEorz7vxGycHG+hbDUaRjqjTJ/HFDaSmP/hPJ67Grc5GozvWnrW0rdi?=
 =?us-ascii?Q?S6++2HbrZd06ERTk+o/p8/Qzwvx61id5DRvNUhonb3q5cjizT/Z62m+DNGck?=
 =?us-ascii?Q?6wiGSAtUXlos0RVxe7gILbiRM9ldZHfqgoTVHHqME6mSragTmQp/6xcvflFb?=
 =?us-ascii?Q?kkJuWe79y+hw4oS20+8OACBmP9jDeJORZJ0wELjfDXgKb8GZvWMI/4JJ20Zq?=
 =?us-ascii?Q?/ycHLblvnZBpFcWgYWJlPF7QY3iP9MuH7EYmCY6+7qtnwlYu3XL+pyGR2R4m?=
 =?us-ascii?Q?M4UerKGvwi3E8lHUuuS9XcGACHYamUVUe8HQ2sRtUfisbD0ZvS84+auYaG/C?=
 =?us-ascii?Q?lFwCU1pMbF8gbIzqjAzMR2rZLoxJ0n2bDRX0303cL6gZ4iHdUIZn4KZbCgHj?=
 =?us-ascii?Q?vT3VSva4lDW05hpZ80TFLA/51m7daUGHXnnGdr4XaS7r3+aMMuyboZQXyVCW?=
 =?us-ascii?Q?RwHddvOOkalGa8Y883fOuyr8xVvA+c6OxEf9OQSTbDLIhjCMhqp4SgBSeP5Y?=
 =?us-ascii?Q?wO1pROLyHLK+pOftsOU2/yXm3POhLdqUpseEl/xMF7yRMmlDkvrCWLa6Kq2u?=
 =?us-ascii?Q?cdZgvjQWbaQpPBFIDjgvZ2uGPuN1MAJicdysecm9kGgrAuiZZhoWjECOJV4y?=
 =?us-ascii?Q?m6hcLhjIia3b37ofw7ruGfa7qWBHK3KlcDl1lF3cLz1WDzPa9iqdKG3uZGHM?=
 =?us-ascii?Q?H7lDw6XZH1y15yvnXdIGypWre3G5EMiBrLU2Q7bIAYXB+b5fSBoS97sWfI2J?=
 =?us-ascii?Q?LTtHnCOBrEaSsKIYlEzH75vhbKIbWwz/7r2XjQPie/1WtOY7px3JF+ZM+fs9?=
 =?us-ascii?Q?M7NTUucSh6d6sbvREg/c73tO0nw7m+sh1qM+AOlKQXT3O+dwBzCO5PFqxJhl?=
 =?us-ascii?Q?4vXQEkziSfELGK6otwSWcGFybOyLZZ9NG7y89+HKjIRnKZQa6PyKUtWf+ceq?=
 =?us-ascii?Q?6gbQchEYtPXLJvfCldClJUNgd11gVe9UaukshrkyUbxufDH+7yxITDfK16Ov?=
 =?us-ascii?Q?jybEadsRzCsdhbUeFOfxos0XC9EwJZE/adRwHCjC5ME+wGAobH0VUdSZHPk3?=
 =?us-ascii?Q?exYsyICzOXKEgrBxMDY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 21:25:58.7361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3afd7d-b541-4c0a-a2d2-08ddfed59df2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9638

From: Carolina Jubran <cjubran@nvidia.com>

Enhance error messages in MLX5 QoS scheduling depth validation by
including the actual values that caused the validation to fail.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 5f2d6c35f1ad..56e6f54b1e2e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -971,8 +971,9 @@ esw_qos_vport_tc_enable(struct mlx5_vport *vport, enum sched_node_type type,
 		max_level = 1 << MLX5_CAP_QOS(vport_node->esw->dev,
 					      log_esw_max_sched_depth);
 		if (new_level > max_level) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "TC arbitration on leafs is not supported beyond max scheduling depth");
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "TC arbitration on leafs is not supported beyond max depth %d",
+					       max_level);
 			return -EOPNOTSUPP;
 		}
 	}
@@ -1444,8 +1445,9 @@ static int esw_qos_node_enable_tc_arbitration(struct mlx5_esw_sched_node *node,
 	new_level = node->level + 1;
 	max_level = 1 << MLX5_CAP_QOS(node->esw->dev, log_esw_max_sched_depth);
 	if (new_level > max_level) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "TC arbitration on nodes is not supported beyond max scheduling depth");
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "TC arbitration on nodes is not supported beyond max depth %d",
+				       max_level);
 		return -EOPNOTSUPP;
 	}
 
@@ -1997,8 +1999,9 @@ mlx5_esw_qos_node_validate_set_parent(struct mlx5_esw_sched_node *node,
 
 	max_level = 1 << MLX5_CAP_QOS(node->esw->dev, log_esw_max_sched_depth);
 	if (new_level > max_level) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Node hierarchy depth exceeds the maximum supported level");
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Node hierarchy depth %d exceeds the maximum supported level %d",
+				       new_level, max_level);
 		return -EOPNOTSUPP;
 	}
 
-- 
2.31.1


