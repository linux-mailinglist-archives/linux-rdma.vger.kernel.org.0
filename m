Return-Path: <linux-rdma+bounces-13777-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925A3BB94A9
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Oct 2025 10:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CBAE3BBF4E
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Oct 2025 08:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522AC1F4634;
	Sun,  5 Oct 2025 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uDW4uBh+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54AF1F12F4;
	Sun,  5 Oct 2025 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759653054; cv=fail; b=sn9iYUEpXzKHM1SWhm/s//GCQeeNHlQO+1g0Ysva14dfYCIk43irUt2cqoop+DwXOHWr/SCjuMCczp++BolVfpSTu3deUaj439VwZ27vN8yufh3MHWnINOu06M6cL8Z+QBIzmvKgODIV+5yQJD48wpajq39EBo5KKykS+FjIxM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759653054; c=relaxed/simple;
	bh=j7G0C5fQRd8q7lfNP9ARFkcuPZ8KOPMDfW2kXKKiPPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwSkRCDpbKoLrPfYDH5TIwG0h5jcS241PHFaNJZbVEjGX28yBjgZRjLtIkzZwOB465SBCg3iyLGSIK7CEPrHgHLF4tYae+9pVU1YzvLee6ha90wt7KM02Bj5Z1v55SPStvxFmeDH0VCe4hn+v6M0lCqgsGD2eeoZj4yBtm3IWfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uDW4uBh+; arc=fail smtp.client-ip=52.101.48.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCsHo6tiqegz0U8lg9AC49rPiLopcf6xWobZx3wruz/h86PiwbpMBk/fUEXVz0rhVBLqyIGg7Q4p0WYjTOPsjpHmBfzYqXZg8XEB88uXaYukGd9wVtwly8EUHLq9YXTriY6WV1D8JOK4rIWksx38QD33RU28Qin+CtGOe4gPSrf7AY9i6gv904SLAFxFKbx42bOCGqOROxRC6U8XfqXYWL5azUebXxEOUPWRtanbvLNTz/pOL4Sm0D4VxIeGfm+PHD4aPJa8IHjnvxzRQURVJWAen1MR/6tfpWA9x+SjfL80GbE1/zhaEGnALC8siiT4pjVWn6tnMqj5WtxW03a+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/mBqrkkE4N7HbKA60SQVKwTaU1CH1ORiJ9LZ/P4bZ8=;
 b=MRcKQqB59R1JZD6YdbcYHY+cMMNEvMGpqJRe9VuMw2ZkYcL3IORkTKB/PQ50A/1Gwh8jHA7j8Jwq+3rgM8CASS48wvu4OYmZ7cFsxe/9Ak++xFnLjUiQTd5JB9mYsJKTrm/kvPN3U33Sb00DcUcpAypxiEKOySxB6Mpd9ZdfRQA1Ec8BQ2JrQKoJ2Ctopxh4x0pmLm0cxZs8ko8EEIpCksne20VZ25XnfISCq5b3oXNpK7BM07XzazK2X+yxKjdZ17bl5nklptzPP5Ui7um4BH5nmMx1O3xTuppvKe4zcrjWcQaN6n2TeXIUrqO7A24mRm45Sle3yDmHnt8jMsrIpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/mBqrkkE4N7HbKA60SQVKwTaU1CH1ORiJ9LZ/P4bZ8=;
 b=uDW4uBh+EMT41Vf1tYYS7fTwN5ILHY7h4SC4Y8ygU7dd2P6Hhn2uXj168QBnKOb/+qjwzqaXSLl4/5PSHQo6T7XyUuDTSl7ZZVRtbtHgeMRaXraBBGAyFJWZ3tMgIDyOG8vxkvLUjbqNGgG6a2h/bh2ticc5gLO1x/sGcvkKSuuBmAHuO8G+QFrWWcGEeYsh2QE7+krsJgwE+24L2NvkWBh6mea8VqA2RW2OE/SBLNR7RkO3bvxD66QggFmY7WsY8uwAzysXmqDG6MoSSPdNFSIFFMRP6iUb2FRy7Esc2FBLwKDi7DZU+QAWF3RGE4WGyB+8vrsAR09aEbxUQOWCsw==
Received: from BN9PR03CA0558.namprd03.prod.outlook.com (2603:10b6:408:138::23)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Sun, 5 Oct
 2025 08:30:47 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:138:cafe::5) by BN9PR03CA0558.outlook.office365.com
 (2603:10b6:408:138::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Sun,
 5 Oct 2025 08:30:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Sun, 5 Oct 2025 08:30:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 5 Oct
 2025 01:30:26 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 5 Oct
 2025 01:30:26 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 5 Oct
 2025 01:30:22 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>
Subject: [PATCH net 2/3] net/mlx5e: Prevent tunnel reformat when tunnel mode not allowed
Date: Sun, 5 Oct 2025 11:29:58 +0300
Message-ID: <1759652999-858513-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1759652999-858513-1-git-send-email-tariqt@nvidia.com>
References: <1759652999-858513-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: 1744d064-fe8b-4f48-b8ab-08de03e97c07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OBElJxCldLJ3z9ol9ZQMjZbwZ1BMJCPvT34TQ8T3qId2nq4g/C7SjZ+9SnIK?=
 =?us-ascii?Q?QJl0wgfqYi7o/XpYrN0fdksbC9TJ6hDx+fgMNWUTKtCOHz+Asi8aAMs4ia8g?=
 =?us-ascii?Q?PDWJV/ohNHMx23AdQqanr+g1qj7Q5k0eMDg2TWEiYvJiaQZGlosmvKE8VZAy?=
 =?us-ascii?Q?g7eRwRWmFPu4S3EFrdwskcH/Uki+fKyoZV77a+xly5BlJ4HH/e8CHGaBCfNp?=
 =?us-ascii?Q?BGAF3PP3vLaau0JZUA8wsskz04mAsyyE9NL81KSRPXvkhgQqM6dQHMakdEmF?=
 =?us-ascii?Q?TyXtrZ8M0LAYlQF6yyZDbUBPzu2zWmMo6RkhBygJEOdD0fIXVEiWdWsi9mt5?=
 =?us-ascii?Q?3RmIaYqYqCgmmQZj3wPiTba+V2ND9lg4FRsyuvqy2mx5488cTp5KM73sv37r?=
 =?us-ascii?Q?iTwgc7vnhbNpGJvkNVJTJnfD7NJCHZ3hBosqmSyYyzVIyu4MoUzfX0PquRXq?=
 =?us-ascii?Q?peafocuA9QD2425QPwZIeHKdwXIUv9e2DdpKbitMJl3W3+iTkL9BXinUKVnj?=
 =?us-ascii?Q?n5qsrA1+0b2+jH2kFRJHk33VH2AP3YfVcaMUSWbfoGcCuIauPRNz5Y+OrLko?=
 =?us-ascii?Q?X1khYruvNSzZlWR/uztwtCtDzhdmYYWE4/Z/eXuPS6COeCxZWI/LHFTG7L6u?=
 =?us-ascii?Q?9x48nfLziNO+w6QPUJEF8UOx+8FYw9J1D4voc4UL+NT8uCDS5rEiivicXgBc?=
 =?us-ascii?Q?mQ8l5VavZuEgi6clDtLbaZm5Vj4zjOQmYsovtt2NlbDJuA8DmqfvXWWrF+tO?=
 =?us-ascii?Q?TBkG/D6EenPH9pGL3jiI8YySJ3831cw7in9lglA4H8w0G2gFjhgwq2BF++Wj?=
 =?us-ascii?Q?YeUOxY2HEbYDgYlWBM7mRygnBlLsZbIBJvN0LnrB69SArKmzLaOCHaQpPPPZ?=
 =?us-ascii?Q?fvbNJyz6CrzGYLtwK9LblviCjFYFUxDzYnDShiMSuYM1DFMridrAQ7wy+lpz?=
 =?us-ascii?Q?5CN7gSQyayA+ikf6HG9LLLfuMQZMdfqLFCahZZ3hQoMwLNY+MRdNXjw1yJNA?=
 =?us-ascii?Q?0h5gNb9PcYkMnt0JQPX5RUZrUclxksMaAZ6QdLEi9wGVRymrc2UG+s6bD9YL?=
 =?us-ascii?Q?OvRnTSnX3zxja/mU5MwZjMGc5MvJzKod797iot7FkYv+tGeF9q4aB/5dFoII?=
 =?us-ascii?Q?WkecPQAxWVkF++b54/Who7NSHTP9J2MmuiBmHeRcuqbC4+AqGauiatfAH4pa?=
 =?us-ascii?Q?eyzIFCAvC75gyQJeYI2V9gUv3JOuFYKr9PyHm5bYm4KvhKNYhHnTGZD9tzRh?=
 =?us-ascii?Q?J4fhL/q0XUDgiWey9JM8hiUuPq8c5td8ApThSTcqRkgmS+7lfGUoYjg3B2SX?=
 =?us-ascii?Q?RZwnkgF6f3aUoStoQwRt9n6yePjlIRXFdA03UI+9SpaCbNdmy4LaqZtIj/Ri?=
 =?us-ascii?Q?Y3SD6U0wY7SRlfTqgAPguGFwKfRGZXhBm3QlU9G/uMbpjEtt2wPd6oSp6IrF?=
 =?us-ascii?Q?5gPEJYHpooqmpcfScmBo7a37aODMFweAPcBYUbcK1TPgUSvG6W5OOxjsWp+U?=
 =?us-ascii?Q?1FcH3G4stVm7cBwuoFolSZP1d1TBWU5cfG2CLGDMDC4ObN6fBnoVUK446RrF?=
 =?us-ascii?Q?zWb2ibibU+r9hDYUjaQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2025 08:30:47.4387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1744d064-fe8b-4f48-b8ab-08de03e97c07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450

From: Carolina Jubran <cjubran@nvidia.com>

When configuring IPsec packet offload in tunnel mode, the driver tries
to create tunnel reformat objects unconditionally. This is incorrect,
because tunnel mode is only permitted under specific encapsulation
settings, and that decision is already made when the flow table is
created.

The offending commit attempted to block this case in the state add
path, but the check there happens too late and does not prevent the
reformat from being configured.

Fix by taking short reservations for both the eswitch mode and the
encap at the start of state setup. This preserves the block ordering
(mode --> encap) used later: the mode is blocked during RX/TX get, and
the encap is blocked during flow-table creation. This lets us fail
early if either reservation cannot be obtained, it means a mode
transition is underway or a conflicting configuration already owns
encap. If both succeed, the flow-table path later takes the ownership
and the reservations are released on exit.

Fixes: 146c196b60e4 ("net/mlx5e: Create IPsec table with tunnel support only when encap is disabled")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 38 +++++++++++++------
 .../mellanox/mlx5/core/en_accel/ipsec.h       |  2 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 24 +++++++-----
 3 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 00e77c71e201..0a4fb8c92268 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -772,6 +772,7 @@ static int mlx5e_xfrm_add_state(struct net_device *dev,
 				struct netlink_ext_ack *extack)
 {
 	struct mlx5e_ipsec_sa_entry *sa_entry = NULL;
+	bool allow_tunnel_mode = false;
 	struct mlx5e_ipsec *ipsec;
 	struct mlx5e_priv *priv;
 	gfp_t gfp;
@@ -803,6 +804,20 @@ static int mlx5e_xfrm_add_state(struct net_device *dev,
 		goto err_xfrm;
 	}
 
+	if (mlx5_eswitch_block_mode(priv->mdev))
+		goto unblock_ipsec;
+
+	if (x->props.mode == XFRM_MODE_TUNNEL &&
+	    x->xso.type == XFRM_DEV_OFFLOAD_PACKET) {
+		allow_tunnel_mode = mlx5e_ipsec_fs_tunnel_allowed(sa_entry);
+		if (!allow_tunnel_mode) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Packet offload tunnel mode is disabled due to encap settings");
+			err = -EINVAL;
+			goto unblock_mode;
+		}
+	}
+
 	/* check esn */
 	if (x->props.flags & XFRM_STATE_ESN)
 		mlx5e_ipsec_update_esn_state(sa_entry);
@@ -817,7 +832,7 @@ static int mlx5e_xfrm_add_state(struct net_device *dev,
 
 	err = mlx5_ipsec_create_work(sa_entry);
 	if (err)
-		goto unblock_ipsec;
+		goto unblock_encap;
 
 	err = mlx5e_ipsec_create_dwork(sa_entry);
 	if (err)
@@ -832,14 +847,6 @@ static int mlx5e_xfrm_add_state(struct net_device *dev,
 	if (err)
 		goto err_hw_ctx;
 
-	if (x->props.mode == XFRM_MODE_TUNNEL &&
-	    x->xso.type == XFRM_DEV_OFFLOAD_PACKET &&
-	    !mlx5e_ipsec_fs_tunnel_enabled(sa_entry)) {
-		NL_SET_ERR_MSG_MOD(extack, "Packet offload tunnel mode is disabled due to encap settings");
-		err = -EINVAL;
-		goto err_add_rule;
-	}
-
 	/* We use *_bh() variant because xfrm_timer_handler(), which runs
 	 * in softirq context, can reach our state delete logic and we need
 	 * xa_erase_bh() there.
@@ -855,8 +862,7 @@ static int mlx5e_xfrm_add_state(struct net_device *dev,
 		queue_delayed_work(ipsec->wq, &sa_entry->dwork->dwork,
 				   MLX5_IPSEC_RESCHED);
 
-	if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET &&
-	    x->props.mode == XFRM_MODE_TUNNEL) {
+	if (allow_tunnel_mode) {
 		xa_lock_bh(&ipsec->sadb);
 		__xa_set_mark(&ipsec->sadb, sa_entry->ipsec_obj_id,
 			      MLX5E_IPSEC_TUNNEL_SA);
@@ -865,6 +871,11 @@ static int mlx5e_xfrm_add_state(struct net_device *dev,
 
 out:
 	x->xso.offload_handle = (unsigned long)sa_entry;
+	if (allow_tunnel_mode)
+		mlx5_eswitch_unblock_encap(priv->mdev);
+
+	mlx5_eswitch_unblock_mode(priv->mdev);
+
 	return 0;
 
 err_add_rule:
@@ -877,6 +888,11 @@ static int mlx5e_xfrm_add_state(struct net_device *dev,
 	if (sa_entry->work)
 		kfree(sa_entry->work->data);
 	kfree(sa_entry->work);
+unblock_encap:
+	if (allow_tunnel_mode)
+		mlx5_eswitch_unblock_encap(priv->mdev);
+unblock_mode:
+	mlx5_eswitch_unblock_mode(priv->mdev);
 unblock_ipsec:
 	mlx5_eswitch_unblock_ipsec(priv->mdev);
 err_xfrm:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index 23703f28386a..5d7c15abfcaf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -319,7 +319,7 @@ void mlx5e_accel_ipsec_fs_del_rule(struct mlx5e_ipsec_sa_entry *sa_entry);
 int mlx5e_accel_ipsec_fs_add_pol(struct mlx5e_ipsec_pol_entry *pol_entry);
 void mlx5e_accel_ipsec_fs_del_pol(struct mlx5e_ipsec_pol_entry *pol_entry);
 void mlx5e_accel_ipsec_fs_modify(struct mlx5e_ipsec_sa_entry *sa_entry);
-bool mlx5e_ipsec_fs_tunnel_enabled(struct mlx5e_ipsec_sa_entry *sa_entry);
+bool mlx5e_ipsec_fs_tunnel_allowed(struct mlx5e_ipsec_sa_entry *sa_entry);
 
 int mlx5_ipsec_create_sa_ctx(struct mlx5e_ipsec_sa_entry *sa_entry);
 void mlx5_ipsec_free_sa_ctx(struct mlx5e_ipsec_sa_entry *sa_entry);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 0bc080274584..bf1d2769d4f1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -2850,18 +2850,24 @@ void mlx5e_accel_ipsec_fs_modify(struct mlx5e_ipsec_sa_entry *sa_entry)
 	memcpy(sa_entry, &sa_entry_shadow, sizeof(*sa_entry));
 }
 
-bool mlx5e_ipsec_fs_tunnel_enabled(struct mlx5e_ipsec_sa_entry *sa_entry)
+bool mlx5e_ipsec_fs_tunnel_allowed(struct mlx5e_ipsec_sa_entry *sa_entry)
 {
-	struct mlx5_accel_esp_xfrm_attrs *attrs = &sa_entry->attrs;
-	struct mlx5e_ipsec_rx *rx;
-	struct mlx5e_ipsec_tx *tx;
+	struct mlx5e_ipsec *ipsec = sa_entry->ipsec;
+	struct xfrm_state *x = sa_entry->x;
+	bool from_fdb;
 
-	rx = ipsec_rx(sa_entry->ipsec, attrs->addrs.family, attrs->type);
-	tx = ipsec_tx(sa_entry->ipsec, attrs->type);
-	if (sa_entry->attrs.dir == XFRM_DEV_OFFLOAD_OUT)
-		return tx->allow_tunnel_mode;
+	if (x->xso.dir == XFRM_DEV_OFFLOAD_OUT) {
+		struct mlx5e_ipsec_tx *tx = ipsec_tx(ipsec, x->xso.type);
+
+		from_fdb = (tx == ipsec->tx_esw);
+	} else {
+		struct mlx5e_ipsec_rx *rx = ipsec_rx(ipsec, x->props.family,
+						     x->xso.type);
+
+		from_fdb = (rx == ipsec->rx_esw);
+	}
 
-	return rx->allow_tunnel_mode;
+	return mlx5_eswitch_block_encap(ipsec->mdev, from_fdb);
 }
 
 void mlx5e_ipsec_handle_mpv_event(int event, struct mlx5e_priv *slave_priv,
-- 
2.31.1


