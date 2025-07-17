Return-Path: <linux-rdma+bounces-12281-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C710B092C2
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 19:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CDE3B1D69
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 17:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516BA302CCC;
	Thu, 17 Jul 2025 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W7cIueY6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DB030206D;
	Thu, 17 Jul 2025 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771900; cv=fail; b=iqh2F7ptNA0Izkz0TLS7BnteZXRYtbfDNIIRn5bXyf/tLHr6BV3z8sYP1uOnbzAZF0RQQFD9RXTvhWSJ4CvMBUbTKQjKFL3T7181ZEUP/yUu8iBH8tFA9WerHE4+HjKhqY9Pbc0dRKl23R22yQ3OQjtTReZeoojs6iNZ8//cTDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771900; c=relaxed/simple;
	bh=TJccO/jSBGTmUnNR8Vi/rSyh/pIRh+e5/ij2IP2/Pks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HqpKCWadOFZQIAsX26zKKPT6/fl4tZgHI3ZguoKA9tLounJdn7P+weWxJksEJKiCOldWumsjKDTkzQaM/jRll38JFOVQ5Kv6VV/qpV+x9Bm1V3zi9nE41qzS2jRTGajBQKvjqNNbeagDghhfpfGLiHXTMlVpqiRmUvYT3letZjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W7cIueY6; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qksquEtL5aRNgmvQc+E1dZQCgdR9FHhx+KuXEtQxBuMbwIjbDTvvYX6BGfhPwES4pze9T1ReXzYzO9fCpQDVlMSdTQI/RXE0Ik571TY2j2XHhfKWuLNI+3m2dmF8DSegmJxpIarefN09a37iIlTAre3CuUSrHEOtd5C7mQA9jo+e/Bh6P0GSjxYWaGslR3TbvtkGpwinu69FvlnX2BATZQWcRnN7OmV338lPIKts71eIk8ueQcykrgop2O69Tz9uc+30RQbGJwAUPBDk+oSurUvypbw/Mxj+myuT8713sGW4pXlmHZY7Wh/L28B26yBShWim7li05kVuajbM19xH+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCMjTO/XnrMam6OspOQ4i9ACFILSLvP6WMpsPzskZr0=;
 b=yGtgLTanvVVrTm32zVFCAhyH4J0g8cx6QYXupihV/fV2UypcTcGBHOoiCWJfYSMBO3eKtWtphKuqQiAscTz5m7bKvmXCz7cx2NgH6muqhpW8G3KY6X0yT/w12DTVmtJ1nKfxMMpftrthhRzq988HvKxwOXuh8gDrK2P6ZjwtNvv07dlc0ZdDP3008sUjX6d5o+G9Oys5HuCDcU6ydSLhb8dqQPV+dsKmC0RZL9xhr10t/bBmGf4r7tb2rTa+4UKO5X+Obxd+AHO910JIhN4CV9CevxlSg/YniMIqriOSzLuXMr5YwCO3pjaXPSU85wQWFEnhwIYA9Bm0BXFA+RWuZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCMjTO/XnrMam6OspOQ4i9ACFILSLvP6WMpsPzskZr0=;
 b=W7cIueY6L8rleAceZWfkdhGjctgtigd2KL9/xBPxsfmtuMSKW0533vBE9L6nmB2aB3hsOdtxEbRgW+PKcBxLyxnubOGWXtfc37+Wnh+OD7CWDcQ6sI4JNr0DDgIJ85Bp4Lk64YlFTWpNTh3ro2wO1Xqj0WfQkB4P4YUOe3IaJwgBkRHokNJol42JJI1bpRNu/YvHQ7jYjYhDPftiT7d7Ytz9ab6BPSPr4sbq+sSiBIrzXdEEZmmoMMR3hX4kPkch77kh37BzxiWMK1bLD0cbYRBuDVynZrXT6zmT3hY/HQgJGiQK48ZRoVUeqiuBQsmfZtHhUkN910rWHlet4R6p2Q==
Received: from BLAPR03CA0035.namprd03.prod.outlook.com (2603:10b6:208:32d::10)
 by CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 17:04:55 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::5) by BLAPR03CA0035.outlook.office365.com
 (2603:10b6:208:32d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Thu,
 17 Jul 2025 17:04:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 17:04:54 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Jul
 2025 10:04:37 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 17 Jul
 2025 10:04:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 17
 Jul 2025 10:04:32 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Feng Liu <feliu@nvidia.com>
Subject: [PATCH net-next 3/3] net/mlx5e: Expose TIS via devlink tx reporter diagnose
Date: Thu, 17 Jul 2025 20:03:12 +0300
Message-ID: <1752771792-265762-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752771792-265762-1-git-send-email-tariqt@nvidia.com>
References: <1752771792-265762-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|CY5PR12MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 8265839b-81e0-418d-5ca0-08ddc5540d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+mjFiqaN43ESv7gUKAdonZeYu3any9Z8b18o+bbs2U7P8x2BQg6jwAYD8zT2?=
 =?us-ascii?Q?JlhLPPXI95gscEf1WRKoLo9RbOa4JFoan1ejuQEpVOx/D6WBViLv1lYPwsNo?=
 =?us-ascii?Q?0Dv7M5rDaXpPWNQClseL+g5oJFLHZhzWyDPIyOKwdkS516/1R7f+vMqCunG6?=
 =?us-ascii?Q?XQ39JvWVn8XksDk6sRMIp+1FPbEABc3pq2OCAtn3rtLpeo+ceUYIj72Rzs7n?=
 =?us-ascii?Q?XOuYXAOVOFZLFJ2jCOWe3vruXYEAioRPc4uk1WrFywGvOu/jv4G62QHqE9D9?=
 =?us-ascii?Q?sKFfk2ab0i3jTNiKJhTjoo3ahu5n5psbJoEnSHsGLtc5eE1w8AGSYMYYYA9J?=
 =?us-ascii?Q?/0O2VMIWGygX7rr03Q2+fZjjlF1gekVncFzSQ0I2bLLbYo5vO5PoBDrX3KcX?=
 =?us-ascii?Q?GS9hKDjdmdvohYSNLBXne6myk+L68x6YTnzafZBwB78cXHOJw3ZNkX+1Lq1i?=
 =?us-ascii?Q?OS20jf064bvIe7Z3eHYDL5MeJIwq/cqcG+eko7+Smpc2+LvDTN/vGiewQl5B?=
 =?us-ascii?Q?7uqZiX6rJeEbHDspZcCs4bnhGCpzO+f9UgsEego+VRdUFcwM50pMut1IKUF0?=
 =?us-ascii?Q?hd/VFg/dXH1dwxSwmVeWCYZ+RB+R5julIEj4oZOWCuYmKOaJUkPldQHlwVaC?=
 =?us-ascii?Q?/KnP+osMdxGE4OUiJ6S9kIi/iZ8t6eQifKitS6Y6vu/uvvmgQ3ssRAuuFNfs?=
 =?us-ascii?Q?5c5mmvbLuplxbgRStDXciKdTjge7dT5iPv3aTUy+Pe9pIoci/yjF39gz6Igu?=
 =?us-ascii?Q?LsBMp+UcB4K0f8ibvgu33CCCcDWSJxiFR1Fnlzc52RVZrsEVnmJ3OP/w01+5?=
 =?us-ascii?Q?M1A0ULmughX0wSInDAO98X5BEXhvxyE0XCcRrYL2qtv6IHDd0b8OTMThd+jv?=
 =?us-ascii?Q?6OA9ZeUV/7vNnL7UKWjJSqsC2FXLHg/HIDKGl5DVEeKpt+QoDzDDx9bIlY9x?=
 =?us-ascii?Q?IbfCYGnCAosPcHSk1SbNX/xY9OvPvW7DG3xHoQU/aitAGZIZAlDoF01KDw7W?=
 =?us-ascii?Q?SAy0aN/O4E1J0MR+2TUyNoQx5biNMBJzj2OvtOmvVOMqyVKAudkChlP7s57c?=
 =?us-ascii?Q?KtDRy5z6oh3oTNNBAsF8NIG0Dv0RA94ffWgXAUNVBciL/CpzQIznw2E1iB1H?=
 =?us-ascii?Q?V/dlznv+nN7IwtskvqH3r9DRSjZ+wxwtUGrRaRLK+tDobWwUJ1u/kQpGSFwB?=
 =?us-ascii?Q?rwGMDb1qhztkoC5upyPKP+oleB3n7kmHh1TYxWMn6Xxpvqx9BxVeo08czVKk?=
 =?us-ascii?Q?GV1r6Sxulx7T451rv/fmIoaNw0dj0oKmro38gqY7bg+wnMeYQ8XMTF316qWm?=
 =?us-ascii?Q?1W69zw0L1XKlgcjZYk4iD+Is1tyEwEbZNXTtjjWOImMCQlqB5QMN499ScJAG?=
 =?us-ascii?Q?Ienq+i5tJRvx8dR5DIDUPaCvdq5P7EzJCnxP8iMsUJ90oI3RhYoljB/vgmqZ?=
 =?us-ascii?Q?4DFqwqp3jLOhTkZNkXxkZFVNOoVbs0I8Sz5ovSSMUv4J6QQZAith2yNTAl5+?=
 =?us-ascii?Q?R/27whA5/diTzVLuZRJphil2voCQf2sGI9/Z?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 17:04:54.6552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8265839b-81e0-418d-5ca0-08ddc5540d5a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6081

From: Feng Liu <feliu@nvidia.com>

Underneath "TIS Config" tag expose TIS diagnostic information.
Expose the tisn of each TC under each lag port.

$ sudo devlink health diagnose auxiliary/mlx5_core.eth.2/131072 reporter tx
......
  TIS Config:
      lag port: 0 tc: 0 tisn: 0
      lag port: 1 tc: 0 tisn: 8
......

Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Aya Levin <ayal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en/reporter_tx.c       | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index bd96988e102c..85d5cb39b107 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -311,6 +311,30 @@ mlx5e_tx_reporter_diagnose_common_config(struct devlink_health_reporter *reporte
 	mlx5e_health_fmsg_named_obj_nest_end(fmsg);
 }
 
+static void
+mlx5e_tx_reporter_diagnose_tis_config(struct devlink_health_reporter *reporter,
+				      struct devlink_fmsg *fmsg)
+{
+	struct mlx5e_priv *priv = devlink_health_reporter_priv(reporter);
+	u8 num_tc = mlx5e_get_dcb_num_tc(&priv->channels.params);
+	u32 tc, i, tisn;
+
+	devlink_fmsg_arr_pair_nest_start(fmsg, "TIS Config");
+	for (i = 0; i < mlx5e_get_num_lag_ports(priv->mdev); i++) {
+		for (tc = 0; tc < num_tc; tc++) {
+			tisn = mlx5e_profile_get_tisn(priv->mdev, priv,
+						      priv->profile, i, tc);
+
+			devlink_fmsg_obj_nest_start(fmsg);
+			devlink_fmsg_u32_pair_put(fmsg, "lag port", i);
+			devlink_fmsg_u32_pair_put(fmsg, "tc", tc);
+			devlink_fmsg_u32_pair_put(fmsg, "tisn", tisn);
+			devlink_fmsg_obj_nest_end(fmsg);
+		}
+	}
+	devlink_fmsg_arr_pair_nest_end(fmsg);
+}
+
 static int mlx5e_tx_reporter_diagnose(struct devlink_health_reporter *reporter,
 				      struct devlink_fmsg *fmsg,
 				      struct netlink_ext_ack *extack)
@@ -326,6 +350,7 @@ static int mlx5e_tx_reporter_diagnose(struct devlink_health_reporter *reporter,
 		goto unlock;
 
 	mlx5e_tx_reporter_diagnose_common_config(reporter, fmsg);
+	mlx5e_tx_reporter_diagnose_tis_config(reporter, fmsg);
 	devlink_fmsg_arr_pair_nest_start(fmsg, "SQs");
 
 	for (i = 0; i < priv->channels.num; i++) {
-- 
2.31.1


