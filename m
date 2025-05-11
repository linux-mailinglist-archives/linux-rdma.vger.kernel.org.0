Return-Path: <linux-rdma+bounces-10281-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DC3AB2AA4
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 21:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87109175150
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 19:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280052676EE;
	Sun, 11 May 2025 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qK9PASx2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9742673B6;
	Sun, 11 May 2025 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746992404; cv=fail; b=ao9KyyYqkT7cxM8G9fYyrhnwwj7bbZLnvpxGeB5nTX9k+AmP94rFMRPb7C/oqi3Oa4CH4ccp1ARXkh7wPlqAwC+GsyaaXzGmv2LAw/d/hTt169uZJLEcEDTALt+pYT3dz1N4w4BMi4gmvzQKK0y4pLV2RaNqy6pyiWMcV2rUy0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746992404; c=relaxed/simple;
	bh=bDcrdolzhl8zjEsHtBA7qYeFwxTh6TeiPWaIiS7NYEo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X97eZgQwlALGY7fPHJWrjfJoTm38acVeTtAPoYeqalmgHCJ/HUty03X1rU3ZR36ACkW16z+ABB+F1i/ZIgEsmoSCgEhk62K9tOr8kzbhn93cXLJIbiLOYN5YdHDeZzWyUIeqYEIxTWWrK9y0nMDsxprOgtp+8/codopMXjptv+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qK9PASx2; arc=fail smtp.client-ip=40.107.100.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvCqaa4nYItUoTbsl1suudg0OBucXkyENKpA5kwpH+Aeb9c1gx1rtoJkHFu8WO1x3c8oIK0mARnmnG9OMqo8CvhyPh1bX2X+B75D/RwKO6rAGtETpHkpE7FnPLG5dcJ2LCtmgY/W5uRuVNV/DkCxtAz9ofyKH1iRh6/KKL6YuMnZWX/x9zraH557YUq45pqT5KfMc+t4ybMEMLCUWrYpsZDRuYrTrpmMd5o0VX5puhPiUrkhZWsGd0NiCgskSgcHdWW3t9e5HdpcrhLUW1Oh+O47EklEpi557eL6xvanR6sDa+3ydHXk9ZJZucnMWSOqc2M0/YZdhPBCmf4/LSQJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7UD4EVBB6r+T4K5Vz6vjhUNU3YsvXbgZt7QPTHL3vM=;
 b=uFoM3+JM9z+sEc3vJ72vGNp7lG5kIS/pa2Sv87uHZZI3PG3KhdL39K0o+C7sFdhTn1Ao9lqpMEj3hBaGuLx7YjQ1OtQzpNPabWqGTlHDmJYWoeJAmMxZqMq/4D2UVqlUeGezPKPbWAucbko3p9DORnqzQVb18raUrcMdd7rcaws7qybyeVKUiGv2NGHrEeXhQEmAP/j/mqKFyXHqm9IC3SidCiUwgLV8BQysIQyskCFFHDmo1e/v4hRY1aiZdwnKg0+9ftXjiidUHmPazbw/QWC2jeUXuk9m8OsN597Z3fg53jFfq77f8A3IdaBt7OLzBGY0mPjq/RMB/mSgrmTdjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7UD4EVBB6r+T4K5Vz6vjhUNU3YsvXbgZt7QPTHL3vM=;
 b=qK9PASx22lrKfzgq+CLxPuKjHH0Eovm/SOdki6H62yZUbu/XzPFAolhZvA9+zIVeDFbhZNvzrtd2XolZLSeFYPlSYeia6N63OUm9VSMFaIpA/NWlCuEMuX0c4GIu3UwnmD7VgL31Gv2xE2ry6XZeE4sPlHgccmBZ2Opmppbz32xMzpdTv8XSX7IaHc2oR3dK5rVWQx4Uk+GlCKEaeowEVe8SaxVHy04W2uXh1cobuybyKTK5LQQeDFl772PsXB5f3Qss2hqeUfoYI2YqvCV+G41SfRoPcy++J1dk9E3oP7Itp8UjsEjSOayRXqO8aS2Ozo3MB6/Rt92y2mqiwVhtfw==
Received: from SJ0PR03CA0149.namprd03.prod.outlook.com (2603:10b6:a03:33c::34)
 by MW3PR12MB4490.namprd12.prod.outlook.com (2603:10b6:303:2f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Sun, 11 May
 2025 19:39:54 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::e0) by SJ0PR03CA0149.outlook.office365.com
 (2603:10b6:a03:33c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Sun,
 11 May 2025 19:39:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Sun, 11 May 2025 19:39:54 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 11 May
 2025 12:39:44 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 11 May
 2025 12:39:43 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 11
 May 2025 12:39:39 -0700
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
Subject: [PATCH net-next 10/10] net/mlx5: HWS, dump bad completion details
Date: Sun, 11 May 2025 22:38:10 +0300
Message-ID: <1746992290-568936-11-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1746992290-568936-1-git-send-email-tariqt@nvidia.com>
References: <1746992290-568936-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|MW3PR12MB4490:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b2a8fc-1277-4c86-dd56-08dd90c39aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D8wj2H5WSOR2v7HpGKvBHFAlgcfzMLTeZsni9ZAqBY7UUd1ZV/f4V1VKs4RE?=
 =?us-ascii?Q?vEL4qO+nqnzhIw6KXnBJfJvDpk+T0WxIjwpvQTEhavdd+9ASKUqOtYz1xXYu?=
 =?us-ascii?Q?b+FlSkIdC+SX4sROPxcIiCYD3lewvnsn5s3i4XK43Vrj8TywCOOoqRbboHM2?=
 =?us-ascii?Q?/V5n/SE0Sum+MEjlH4wNcmhGsNiommCwggJGivJqc/A2mqDEUnwYA3wIgUFB?=
 =?us-ascii?Q?X6zvY86qc/7H2MlnGlTyjShXJ526PyA4aPzzlPSytTMYGb5TzIYe6gZlaF1S?=
 =?us-ascii?Q?B3YFZi99hCaigZKBza/n1jXa/P7KT2UUzgaHHTR0z6Re9AhPbG9cnywl8ZFB?=
 =?us-ascii?Q?GrYTbZwsnOkZr8jfL9N7OL56jr4aE+bgAbBMl0sJKMLoxkXlCmtl1zRqXmRo?=
 =?us-ascii?Q?K+VDXAvONSN/WgwDd6VAL6ROCRyIQAT3kGCvbqKSgG0T79OijBQ8EZm912Y2?=
 =?us-ascii?Q?aopWABqergwdK3XwL8wnyT32e6ACdqmvM10/53m8sUlifx3rMTfyQGR9885V?=
 =?us-ascii?Q?9zbFyCowwP2qdSgok3BXMQgQoxGBOu8pP1TaoPNdHPVj6iBEJ5jE7wvwxgk+?=
 =?us-ascii?Q?04hGorKdSL5lTYBgzXCy+WEVXlmxaVkxr5RMKtEkVLvuZe/OdwZMmO2/AQ9l?=
 =?us-ascii?Q?dO9BhmArzZMW5wELwruE5FTYE/yeRLNENYSCXmF7WHxZ+Uj6rijJCLPDE7u0?=
 =?us-ascii?Q?htkmRt8BEBfidNnSdsvD6QdiXasJXx/CfXQJa+S+ZmrzcmsgopCn3jNMT5nW?=
 =?us-ascii?Q?rI3Q+Ctuw8WXtyKVWwIAM7vStdpz6mtBVscvZJNtZmH/gkDW/XSLEM0gCr8K?=
 =?us-ascii?Q?92N2HnMW1JY3/9YNQeNJ97mKR0ggwmgAVitEAOzn95tuaZMyx4e2BVcI4eFg?=
 =?us-ascii?Q?0/LUSR+KEvLnSNbAbQXeV5uUXcTF2rltJLhg5h4ALWFrcgF3RPS5vKifDj8q?=
 =?us-ascii?Q?IaFV0WHD9MyOmKD0CybV9u70xD8cxvF8soMLhHCPo+SxMfJgT+rEk+0qFNAP?=
 =?us-ascii?Q?8so3DeNBrf14k9cMairY7wgxttwNGtsUp+pFS2cEc+vrTK1uVFIrmL2urTaI?=
 =?us-ascii?Q?FnmWOKG/T+FZnzQVTPLXcF3N4jic+DHX6vKRuTEaCfTm7MLJUHIz7uMt6Ixm?=
 =?us-ascii?Q?/NRcPfDo2vRKfre//sGcXwMBRXD2zwUXWppgLzLk66Fr978DV5q4obJFRPz9?=
 =?us-ascii?Q?ZluplN46HTTF/i3JHxe5dbBPqo7E3PKwvBOAkiPwGkPx7YnX6Mkij77IP147?=
 =?us-ascii?Q?G9+Tk2NmWYowVIxuJnmD6xFYf73CXpbraQLA2mn2clhzc9xC506mLKfYacgi?=
 =?us-ascii?Q?EbsHTFxDTHql+X4OYwtuOXWr6aVNg96UsZyAWkzb8uFXcy3tM8DfbaeVpZFi?=
 =?us-ascii?Q?d+HgH+qsK+SKhQahTc9Oho4hogrkmtPk3UVu4YZiwg+XE18OaWv2xHQtp9pp?=
 =?us-ascii?Q?rZaEfNEi0s9P3uXVHQGlIRCTrwc4K/xfI72LLlWSlJhAkvLSsi+q5q0uKIdu?=
 =?us-ascii?Q?NLFnYnNncBnn6ZFbqYoO0/F3KdK9AqtZh0pM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2025 19:39:54.3444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b2a8fc-1277-4c86-dd56-08dd90c39aaf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4490

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Failing to insert/delete a rule should not happen. If it does happen,
it would be good to know at which stage it happened and what was the
failure. This patch adds printing of bad CQE details.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/send.c    | 122 +++++++++++++++++-
 .../mellanox/mlx5/core/steering/hws/send.h    |   1 +
 2 files changed, 120 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
index cb6abc4ab7df..c4b22be19a9b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
@@ -344,18 +344,133 @@ hws_send_engine_update_rule_resize(struct mlx5hws_send_engine *queue,
 	}
 }
 
+static void hws_send_engine_dump_error_cqe(struct mlx5hws_send_engine *queue,
+					   struct mlx5hws_send_ring_priv *priv,
+					   struct mlx5_cqe64 *cqe)
+{
+	u8 wqe_opcode = cqe ? be32_to_cpu(cqe->sop_drop_qpn) >> 24 : 0;
+	struct mlx5hws_context *ctx = priv->rule->matcher->tbl->ctx;
+	u32 opcode = cqe ? get_cqe_opcode(cqe) : 0;
+	struct mlx5hws_rule *rule = priv->rule;
+
+	/* If something bad happens and lots of rules are failing, we don't
+	 * want to pollute dmesg. Print only the first bad cqe per engine,
+	 * the one that started the avalanche.
+	 */
+	if (queue->error_cqe_printed)
+		return;
+
+	queue->error_cqe_printed = true;
+
+	if (mlx5hws_rule_move_in_progress(rule))
+		mlx5hws_err(ctx,
+			    "--- rule 0x%08llx: error completion moving rule: phase %s, wqes left %d\n",
+			    HWS_PTR_TO_ID(rule),
+			    rule->resize_info->state ==
+			    MLX5HWS_RULE_RESIZE_STATE_WRITING ? "WRITING" :
+			    rule->resize_info->state ==
+			    MLX5HWS_RULE_RESIZE_STATE_DELETING ? "DELETING" :
+			    "UNKNOWN",
+			    rule->pending_wqes);
+	else
+		mlx5hws_err(ctx,
+			    "--- rule 0x%08llx: error completion %s (%d), wqes left %d\n",
+			    HWS_PTR_TO_ID(rule),
+			    rule->status ==
+			    MLX5HWS_RULE_STATUS_CREATING ? "CREATING" :
+			    rule->status ==
+			    MLX5HWS_RULE_STATUS_DELETING ? "DELETING" :
+			    rule->status ==
+			    MLX5HWS_RULE_STATUS_FAILING ? "FAILING" :
+			    rule->status ==
+			    MLX5HWS_RULE_STATUS_UPDATING ? "UPDATING" : "NA",
+			    rule->status,
+			    rule->pending_wqes);
+
+	mlx5hws_err(ctx, "    rule 0x%08llx: matcher 0x%llx %s\n",
+		    HWS_PTR_TO_ID(rule),
+		    HWS_PTR_TO_ID(rule->matcher),
+		    (rule->matcher->flags & MLX5HWS_MATCHER_FLAGS_ISOLATED) ?
+		    "(isolated)" : "");
+
+	if (!cqe) {
+		mlx5hws_err(ctx, "    rule 0x%08llx: no CQE\n",
+			    HWS_PTR_TO_ID(rule));
+		return;
+	}
+
+	mlx5hws_err(ctx, "    rule 0x%08llx: cqe->opcode      = %d %s\n",
+		    HWS_PTR_TO_ID(rule), opcode,
+		    opcode == MLX5_CQE_REQ ? "(MLX5_CQE_REQ)" :
+		    opcode == MLX5_CQE_REQ_ERR ? "(MLX5_CQE_REQ_ERR)" : " ");
+
+	if (opcode == MLX5_CQE_REQ_ERR) {
+		struct mlx5_err_cqe *err_cqe = (struct mlx5_err_cqe *)cqe;
+
+		mlx5hws_err(ctx,
+			    "    rule 0x%08llx:  |--- hw_error_syndrome = 0x%x\n",
+			    HWS_PTR_TO_ID(rule),
+			    err_cqe->rsvd1[16]);
+		mlx5hws_err(ctx,
+			    "    rule 0x%08llx:  |--- hw_syndrome_type = 0x%x\n",
+			    HWS_PTR_TO_ID(rule),
+			    err_cqe->rsvd1[17] >> 4);
+		mlx5hws_err(ctx,
+			    "    rule 0x%08llx:  |--- vendor_err_synd = 0x%x\n",
+			    HWS_PTR_TO_ID(rule),
+			    err_cqe->vendor_err_synd);
+		mlx5hws_err(ctx,
+			    "    rule 0x%08llx:  |--- syndrome = 0x%x\n",
+			    HWS_PTR_TO_ID(rule),
+			    err_cqe->syndrome);
+	}
+
+	mlx5hws_err(ctx,
+		    "    rule 0x%08llx: cqe->byte_cnt      = 0x%08x\n",
+		    HWS_PTR_TO_ID(rule), be32_to_cpu(cqe->byte_cnt));
+	mlx5hws_err(ctx,
+		    "    rule 0x%08llx:  |-- UPDATE STATUS = %s\n",
+		    HWS_PTR_TO_ID(rule),
+		    (be32_to_cpu(cqe->byte_cnt) & 0x80000000) ?
+		    "FAILURE" : "SUCCESS");
+	mlx5hws_err(ctx,
+		    "    rule 0x%08llx:  |------- SYNDROME = %s\n",
+		    HWS_PTR_TO_ID(rule),
+		    ((be32_to_cpu(cqe->byte_cnt) & 0x00000003) == 1) ?
+		    "SET_FLOW_FAIL" :
+		    ((be32_to_cpu(cqe->byte_cnt) & 0x00000003) == 2) ?
+		    "DISABLE_FLOW_FAIL" : "UNKNOWN");
+	mlx5hws_err(ctx,
+		    "    rule 0x%08llx: cqe->sop_drop_qpn  = 0x%08x\n",
+		    HWS_PTR_TO_ID(rule), be32_to_cpu(cqe->sop_drop_qpn));
+	mlx5hws_err(ctx,
+		    "    rule 0x%08llx:  |-send wqe opcode = 0x%02x %s\n",
+		    HWS_PTR_TO_ID(rule), wqe_opcode,
+		    wqe_opcode == MLX5HWS_WQE_OPCODE_TBL_ACCESS ?
+		    "(MLX5HWS_WQE_OPCODE_TBL_ACCESS)" : "(UNKNOWN)");
+	mlx5hws_err(ctx,
+		    "    rule 0x%08llx:  |------------ qpn = 0x%06x\n",
+		    HWS_PTR_TO_ID(rule),
+		    be32_to_cpu(cqe->sop_drop_qpn) & 0xffffff);
+}
+
 static void hws_send_engine_update_rule(struct mlx5hws_send_engine *queue,
 					struct mlx5hws_send_ring_priv *priv,
 					u16 wqe_cnt,
-					enum mlx5hws_flow_op_status *status)
+					enum mlx5hws_flow_op_status *status,
+					struct mlx5_cqe64 *cqe)
 {
 	priv->rule->pending_wqes--;
 
-	if (*status == MLX5HWS_FLOW_OP_ERROR) {
+	if (unlikely(*status == MLX5HWS_FLOW_OP_ERROR)) {
 		if (priv->retry_id) {
+			/* If there is a retry_id, then it's not an error yet,
+			 * retry to insert this rule in the collision RTC.
+			 */
 			hws_send_engine_retry_post_send(queue, priv, wqe_cnt);
 			return;
 		}
+		hws_send_engine_dump_error_cqe(queue, priv, cqe);
 		/* Some part of the rule failed */
 		priv->rule->status = MLX5HWS_RULE_STATUS_FAILING;
 		*priv->used_id = 0;
@@ -420,7 +535,8 @@ static void hws_send_engine_update(struct mlx5hws_send_engine *queue,
 
 	if (priv->user_data) {
 		if (priv->rule) {
-			hws_send_engine_update_rule(queue, priv, wqe_cnt, &status);
+			hws_send_engine_update_rule(queue, priv, wqe_cnt,
+						    &status, cqe);
 			/* Completion is provided on the last rule WQE */
 			if (priv->rule->pending_wqes)
 				return;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.h
index f833092235c1..3fb8e99309b2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.h
@@ -140,6 +140,7 @@ struct mlx5hws_send_engine {
 	u16 used_entries;
 	u16 num_entries;
 	bool err;
+	bool error_cqe_printed;
 	struct mutex lock; /* Protects the send engine */
 };
 
-- 
2.31.1


