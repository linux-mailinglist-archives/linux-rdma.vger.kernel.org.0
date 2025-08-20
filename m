Return-Path: <linux-rdma+bounces-12834-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04833B2DDEB
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 15:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF39724F16
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 13:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5F8322528;
	Wed, 20 Aug 2025 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eIm1Yxrb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EF53218BE;
	Wed, 20 Aug 2025 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696789; cv=fail; b=Wn40IULTxz7bsMujkgfsA78A/K9aaMU9dMJwEFYcm9AOfUWAbRrkp3ESxmMk8LQV8xJi++dmWY/fUCjxVe85/ca8NikOddJstvdIl4F4kBHodv8jGF/N2mmeLAwoUGXcBSUutTon7U5iCHscvq086cZJKgEz7M+YE2reKh+UJek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696789; c=relaxed/simple;
	bh=521YgZgQtsOhLsrZ0ue/k7p7OBgDZk21RdpQZhqUc0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzSQHYcVlUJK5AaXFHp6hi++UELeBAoNfnAYenwRMRZSkVftTdy41VeMMMzYEeFU8HO/oP77pYJTKKnbyutwRGV44CjivouHFPn77zFLR1bKh/G0RwWJ0ggRwk1z+MXdSiV4+p5g3Yl1EZfiVMbrJDCEUq/J0g3aqpfbQIjCkG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eIm1Yxrb; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYJ/Yp3ta358y3k8RAjJL3zfAJA+zbYERZ6AaZJnvWqO+mW3pPqrqND0IAqmN2PDPMDrllFhokDjHXFG6h2yOUAZd+FH7NXCnvM5rNaTUNY4WpHHf18huoxGyw0+orVWmE2GHa2LY64BJaS2ZO0iSALdOSZXzdaKjuePXcwBLjlEf4tdVkHuZB+z3rg+8CV3Lrh8MTkV72TLYRTR+5XiLtyCFW2MbDhK++L2ZUZRAjSLqCZcFbFS5FvNj7BekJ+TuPK9JYxCJrmYzVRF9kNZXURRb0sbuM6a25yXYLyg7S9//17rV9kfnye7Yoqe5C4KaXZCqFlqOy7+rRr1Kj8BuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoWVerikjJY7HBVbtQF1RHB5F4uSEcgS59m9BoNzrNg=;
 b=kf1Nf1ouwK9Mex2D7M11T7+mAu6ww8dS3zYDfAQSnm4pWu/sOlVrOYzdNGLKksv79lYRIg16v52EtdCcgfIVRKc+AtBkgbHZW8hb0X+rHmxe20fWD62H1f5Woa0yM38DxRvtCtgaZsQWqXANBpWlZo2AwTtHLZRmG/7RSt0y0/MoBt30TL6GmAjmn71R0AQlUg8/kh6ApzOwGAMOY8SfHWeGi5DuHAHo9VKFzPLTWihD1j4sWz8dxEZR6dwhQKk4mTztU+/7ZfIstzEJh/KqCfyg9bGOWZvvm4zzEdkXjfiKj8NVDJSStEurccXNA+l8n0BAQxfC8ut+Jy5LClqk/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoWVerikjJY7HBVbtQF1RHB5F4uSEcgS59m9BoNzrNg=;
 b=eIm1YxrbJSFipMoSW1x0Q+/Frca/BP4CqeUx1E4u32KUotazEbZYhNOkX7/lQUeD+jPPo/9K01VXuvYYC49hu++Rcfp0GKlf33VH+mdPZyUfEgqTffbguClJiL/5vG58vDYNGHMSzC/+zcfk+5NhrUJlUNeeZH2JXm5oXGsT3+ygpE8/dawINXcClNeb4Vw2N7gaMfAePvzr2wCns9bKx/mf60jBWWLgrQeTwysEWi1ZuAfvKh5cySuam4UJx662nrbf2yNQuBOysccL3ifRBsCpEMMaklF9Vb0PG8ccEbztHVITpuESTuCqYO/G51A84b60KZOaplS2iyvK6i0Akw==
Received: from BYAPR05CA0013.namprd05.prod.outlook.com (2603:10b6:a03:c0::26)
 by CH1PPF946CC24FA.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 13:33:05 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:a03:c0:cafe::fa) by BYAPR05CA0013.outlook.office365.com
 (2603:10b6:a03:c0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Wed,
 20 Aug 2025 13:33:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 13:33:04 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 06:32:42 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 06:32:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 20
 Aug 2025 06:32:37 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, <przemyslaw.kitszel@intel.com>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Mohamad Haj Yahia
	<mohamad@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH V2 net 4/8] net/mlx5: Destroy vport QoS element when no configuration remains
Date: Wed, 20 Aug 2025 16:32:05 +0300
Message-ID: <20250820133209.389065-5-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820133209.389065-1-mbloch@nvidia.com>
References: <20250820133209.389065-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|CH1PPF946CC24FA:EE_
X-MS-Office365-Filtering-Correlation-Id: 4adc8db9-8f87-40ed-ec70-08dddfee17c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tVQSSI4yhgbtQ91v17KwHE1W0o/cTQS/QV0EbKLpxWhVrfoyE/OyyLYJhZ45?=
 =?us-ascii?Q?RS7hSq7N15bebrOYHF49vYZULLA0g1H94KKASDexw6asO2UJ2UEYwPQiP1KB?=
 =?us-ascii?Q?psIPeCYwrPFNK/jK+qlZB/qwpKucqJhreVmaLPBMe0t06JuJvVz4K/pPTY8i?=
 =?us-ascii?Q?/I1K+q1Qn5fzIFx3vGwkf0BUlhZqrnSqIZBFe9+XiTU1X42O7vqRA5E/qDFX?=
 =?us-ascii?Q?Sp5CRbtKOdkaC4LL+P5d4IRaC05HzvXrTplAXr5tCg2jxlgkrD72rmx//jIM?=
 =?us-ascii?Q?GOkwNeqHbdWHzpy7fjP78gQf7tFXZ5rsk5UJ0j1xyv9Zaxf+x0RWNmMsgf6e?=
 =?us-ascii?Q?FBDTWPpMUQlklyxPieP7np6wSQ/q0GfiXDP5ULUnNVB6k5Ag9eTxgt40aOAu?=
 =?us-ascii?Q?K26av0fj/uT57GBKhhEyhOwQGFMmgNjxirYUC9/L+AsvQ8O8JNNl8Bpb4xSr?=
 =?us-ascii?Q?ExOKTkFXmAPLlSfo3incKUQukcxnGJ8XGs84QLmX118XbH7QMcPLdNMYB1St?=
 =?us-ascii?Q?iZaI9oOKtnehnG40euWfNci7VQj+wVdeoXXdUcvAiWWC+pBk2jzuQqhojQne?=
 =?us-ascii?Q?eJZTiZUsspLxXTdNM2iZq/sVQFCWZB0kvVPPZn0M1mN7UDINJLJxAdIJZJ6Q?=
 =?us-ascii?Q?c33dqszaKXx8MT1oxLt0X6qO3LIFmSmD3MkSk4sOeLTn1aV72tuHVBN0nUqw?=
 =?us-ascii?Q?ANKJWh4ALDOCqVb4PAKUNHwcfugPpGOJqwXUuOdw+hUc36mwV3Dk/rnWNkcJ?=
 =?us-ascii?Q?DgrTSF7RvKKDK3fB4ZXKn+rqy9+9clunDQbvbkwdzoY39IcKEa/3fN3JvhIZ?=
 =?us-ascii?Q?NmMOj4qFeFKOh7ZR60DPGo4uVEqqoLMmrkJ5FPlO3fLc4488xnqybirWd1bb?=
 =?us-ascii?Q?lXKYfichh0ObWED/8usNTxeholezzU5h9ZkTYlRFlWNzO1vyPOcmVlNLiory?=
 =?us-ascii?Q?FEIu/AQgWS3N0p61dIx5o1ku9CKDNiEy64oIF1xzh7X8M7D7CHxFcv7rZc1r?=
 =?us-ascii?Q?OlMhxOMD50yGrHId2+Jvinax2kPXOxZHrI4qjr9XTcteafdsg2vdsenbJjUg?=
 =?us-ascii?Q?CJBWxA9Au57c09DklmWVFQEGWN50VJo6YiGf73qTYmealtxrPpqE9NYcQByv?=
 =?us-ascii?Q?pQXHmjKh0DoS26K0ST5OfydbrDz3FM+DTqPZHeG2cUsq1Gh15rUMr7yRZiwn?=
 =?us-ascii?Q?2ce7offrG02sKRCEVYdZJdLaMQWgK+flVoEtghZ7QL12VlvT05TAgr/CHL8E?=
 =?us-ascii?Q?ykCmyIlGIbtmcgxWudSUZPVQxvTL3DHLkVapS3Qzz0BoDgbFz0OWpbNMkIxt?=
 =?us-ascii?Q?sm/QJc4o5ZVESUhT54Fe0tcJ/fO7axpSyfKvY+9ZAmsz5CIQoKZh83cMPMf9?=
 =?us-ascii?Q?pjG7Xyl9nvYAwChL22AR1uDhRwzsQlAkvN7XQ/FAXcajQA+TrdjqO8/7RxnF?=
 =?us-ascii?Q?OtdNG2wTlSmFOOm2Uqb9n9O0Xy7iBMiUy4/AKcUKxiX+QFjRK11gPHnWLlGd?=
 =?us-ascii?Q?4VjA2SEPNr4ItYAljmmSQ0L+8lxTM5zH1Dnd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 13:33:04.8963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4adc8db9-8f87-40ed-ec70-08dddfee17c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF946CC24FA

From: Carolina Jubran <cjubran@nvidia.com>

If a VF has been configured and the user later clears all QoS settings,
the vport element remains in the firmware QoS tree. This leads to
inconsistent behavior compared to VFs that were never configured, since
the FW assumes that unconfigured VFs are outside the QoS hierarchy.
As a result, the bandwidth share across VFs may differ, even though
none of them appear to have any configuration.

Align the driver behavior with the FW expectation by destroying the
vport QoS element when all configurations are removed.

Fixes: c9497c98901c ("net/mlx5: Add support for setting VF min rate")
Fixes: cf7e73770d1b ("net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 57 ++++++++++++++++---
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 4ed5968f1638..452a948a3e6d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1127,6 +1127,19 @@ static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_t
 	return err;
 }
 
+static void mlx5_esw_qos_vport_disable_locked(struct mlx5_vport *vport)
+{
+	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
+
+	esw_assert_qos_lock_held(esw);
+	if (!vport->qos.sched_node)
+		return;
+
+	esw_qos_vport_disable(vport, NULL);
+	mlx5_esw_qos_vport_qos_free(vport);
+	esw_qos_put(esw);
+}
+
 void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
@@ -1140,9 +1153,7 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 	parent = vport->qos.sched_node->parent;
 	WARN(parent, "Disabling QoS on port before detaching it from node");
 
-	esw_qos_vport_disable(vport, NULL);
-	mlx5_esw_qos_vport_qos_free(vport);
-	esw_qos_put(esw);
+	mlx5_esw_qos_vport_disable_locked(vport);
 unlock:
 	esw_qos_unlock(esw);
 }
@@ -1642,6 +1653,21 @@ static bool esw_qos_tc_bw_disabled(u32 *tc_bw)
 	return true;
 }
 
+static void esw_vport_qos_prune_empty(struct mlx5_vport *vport)
+{
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+
+	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
+	if (!vport_node)
+		return;
+
+	if (vport_node->parent || vport_node->max_rate ||
+	    vport_node->min_rate || !esw_qos_tc_bw_disabled(vport_node->tc_bw))
+		return;
+
+	mlx5_esw_qos_vport_disable_locked(vport);
+}
+
 int mlx5_esw_qos_init(struct mlx5_eswitch *esw)
 {
 	if (esw->qos.domain)
@@ -1675,6 +1701,10 @@ int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void
 
 	esw_qos_lock(esw);
 	err = mlx5_esw_qos_set_vport_min_rate(vport, tx_share, extack);
+	if (err)
+		goto out;
+	esw_vport_qos_prune_empty(vport);
+out:
 	esw_qos_unlock(esw);
 	return err;
 }
@@ -1696,6 +1726,10 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 
 	esw_qos_lock(esw);
 	err = mlx5_esw_qos_set_vport_max_rate(vport, tx_max, extack);
+	if (err)
+		goto out;
+	esw_vport_qos_prune_empty(vport);
+out:
 	esw_qos_unlock(esw);
 	return err;
 }
@@ -1733,6 +1767,7 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf,
 		if (vport_node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
 			err = esw_qos_vport_update(vport, SCHED_NODE_TYPE_VPORT,
 						   vport_node->parent, extack);
+		esw_vport_qos_prune_empty(vport);
 		goto unlock;
 	}
 
@@ -1893,14 +1928,20 @@ int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
 					  void *priv, void *parent_priv,
 					  struct netlink_ext_ack *extack)
 {
-	struct mlx5_esw_sched_node *node;
+	struct mlx5_esw_sched_node *node = parent ? parent_priv : NULL;
 	struct mlx5_vport *vport = priv;
+	int err;
 
-	if (!parent)
-		return mlx5_esw_qos_vport_update_parent(vport, NULL, extack);
+	err = mlx5_esw_qos_vport_update_parent(vport, node, extack);
+	if (!err) {
+		struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
+
+		esw_qos_lock(esw);
+		esw_vport_qos_prune_empty(vport);
+		esw_qos_unlock(esw);
+	}
 
-	node = parent_priv;
-	return mlx5_esw_qos_vport_update_parent(vport, node, extack);
+	return err;
 }
 
 static bool esw_qos_is_node_empty(struct mlx5_esw_sched_node *node)
-- 
2.34.1


