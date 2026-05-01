Return-Path: <linux-rdma+bounces-19826-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK8lFNkp9GlA+wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19826-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:19:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E598C4AA3B6
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 532F4301DD5F
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 04:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727D030DD11;
	Fri,  1 May 2026 04:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qf6zPVu8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35343303A35;
	Fri,  1 May 2026 04:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777609101; cv=fail; b=Gr/JNsS05AHrFZjCEg5BF0VTVUOLiVmQFAacLSvG80TU5pXwbJb083hU9pQlpZ1s5q/xREGANFbA+f596oIRhms0gek7LsyjRJ+pjblxwHYLgphPlYpK06h/GscZRUlYj3L5m7ZQ/O6vFWnQBKD3LivqlzYcE/BJk+MC9JWSJaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777609101; c=relaxed/simple;
	bh=JCsxAMgLE7uq7AGozlg/RGrbvvWX8C/9o/nlVMg84x4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvtUh56NIiCyC4IOgOXPt5DZlqu1WFq38OljFlFKJoLr30SheNT10XYu5MCw8OBGzN8MZky8+0i5EIZ6nBXF0v5+T+ejpx8vb+xGaAdfIfcTiNS740RzTUN8dhFHzUP+WEDhOo/+MIjDOKWv84cRBU9ac0wBDrBeFc8aAjcDraA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qf6zPVu8; arc=fail smtp.client-ip=52.101.53.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWdm2ShWAXeKPkqF46EY9AY/3uErI986uV7OVx+rIkF/YgE+APitczkyo1hKTAvm73oLhWPLkGjiGwJVnXDIz4Wu1Fx0jBxg/cr4T1HgnqmY2Z3whgnKU3EZ/2iRadX7rEbzP1wc3sx/IpLT6qt3X7RsA5naU4xBqRCwLrdbpLWNK8WgwZQtsHpBzSOVZRvPRK8IZiQUaExKbRx4S0DGmsqkRPla2xv87d22egyY9OUf5Cn608ooeCFM1VmayJi9hXbV63OlUDW6k5YBz6ek30NWCx2UnknV0TQy78qsOgvW+BXtrN/PwQHW48wK29RBuHIn54A3OOgFG2fja1Q98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cmv/C+x6J6gcyHasImi8Fwhl9P8fIBGyN18hIeVFGdQ=;
 b=NzvjHo8piuo3tTFLi0RrgL0JwINWYJ6iNiNbGkeEINqZlPm8Rauf/2JI354yeYFjbyAryLMxqQN7KWUrN7+GwXPTdrvtdPtFQ0LcinlS1CMAI0MdstDKzYIa2RkjOIKoJTwP5RcjpF54ZGpPnOzW1N0CCIgyriSreMAqT6FVcz1yPm1Eq2KPyjlHPbVwNnvAsOmYgA7MP69cCPpSd2JAy2AYzMhAyRlUty7s/4HOz5dHEkg1EHW8ssVpYh6ZfRYVSXy6ZnS3ymrzCwpk8DozNZuxbKTk3yMy4Jw4GbdgnCYWC8XYE8uSbszEk9Ytn2Ct3yRpVq79eX3M36SQlCQVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cmv/C+x6J6gcyHasImi8Fwhl9P8fIBGyN18hIeVFGdQ=;
 b=qf6zPVu8sQ1BVIziqohORba8FUfejaFljx4dQm8ii4f5atbAjxuw6SPKDp+MuJMXfBGzLTvcllZCS/rvsC+MG+p1boa76UPO7vEql4zZQ60Q0I+vnMkjt8ivH9aziZ6e0GzyXDq7KObEvl6cV/QIyowHkbfsCDe375cm9Hu5sDzVev1pp8FiPXTgHg5dQT9HunOw1XupmiXlMTtI/zFHEAHeJn98QFkN3hTiTWkrYb5/DoXUrvl5iM0eOxnsrc8ijh9ine2TxD+y8Sa58sbz6Z/M8GEicba3L5xJxyFa+CJWRISstTetzcPe0f2a8bQasKFQ64+IVneeIdVj0i+rfg==
Received: from CH5PR02CA0005.namprd02.prod.outlook.com (2603:10b6:610:1ed::7)
 by CY8PR12MB7515.namprd12.prod.outlook.com (2603:10b6:930:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Fri, 1 May
 2026 04:18:08 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::ad) by CH5PR02CA0005.outlook.office365.com
 (2603:10b6:610:1ed::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.23 via Frontend Transport; Fri,
 1 May 2026 04:18:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 1 May 2026 04:18:08 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:17:50 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:17:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Apr 2026 21:17:42 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shay Drory <shayd@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>, Maher Sanalla
	<msanalla@nvidia.com>, Simon Horman <horms@kernel.org>, Gerd Bayer
	<gbayer@linux.ibm.com>, Moshe Shemesh <moshe@nvidia.com>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V2 4/7] net/mlx5: E-Switch, serialize representor lifecycle
Date: Fri, 1 May 2026 07:16:30 +0300
Message-ID: <20260501041633.231662-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260501041633.231662-1-tariqt@nvidia.com>
References: <20260501041633.231662-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|CY8PR12MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4447e4-1b35-4469-b98c-08dea738a634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Prf3uE0d1VG1z6WQZTYmGGUMvaYgVTwRc/E3pblaRFr/7ovPbYD9iBTaPH+9INMIXbm8Y4riy17mX7pcWZnciV/8PdpF6vZu4fwh293JsTke8ZDKJwRW7dlQZ8LfcVccsSmxxQ6mruUFRdp4AtY3teFK5B55f3HPvkJHZKvEOLKgZqf4Pi4bOqXrMQIorcSq85LWhp7aDc6/ll/zxoxvWWevW+7Lk55PRa2VTNasGKKoXGKnhjvXqd57BkIq35dDrdUPmNRCyygdMWnG2ZHoiYnfj8v/k4tv73Tp9WCkjQNLBqhY76UYmO/C9QQbXZESpCWHm0j72PU/br3O7R/8jcrTF32quN8dL11CfgxGodoFtQs5u8sgH1jGhZehtzIACkB2l/5ZkP/ghpY6pR+YKXU7cCJ7fvR5+TCwpbFBpVn0IFRkpU/sxPpRvuRJZnSKfZpExP4bicKT9d/SU7Q6to1jrJRtQL65wtuf3TljYxj2jjtad73lIQoygaAinP+FitXiceRRaEVuz5iEi5rYEhHFMCZfEBMnSuXzvKosNsW9u/V0ulJvSXVYrg7JbLtcCU+rmKXPPvbzAP6szd15n88TOKNZwgZRlajmSZtMevjjspPYTvIubYdJERzwSNI4s4t/JnbTA29V5XKytWTQjnafKrZwa5UIG3OvPpyfD9yY4e0B7PCcYZOVAId6Bob0aknIOrwgdvn4avi92F7ns8jpwKNiOgpvRFO9H8qngpI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xP4e601LJwqf0HGssNezcvccREdZAlL4+tVK+KNB2frWJ1wHhDcNI5/nx+McOn5VuQoWhA+yNzF2aY3Lo+slSijuLAGRG8PuR+PBI23aO8OlOOInRhGCzAQfunpVHl3plklsXvmVo/Hc20Cg98Myi4QGSkt/js7H6sCO/JZU2qoeFDNY8If8UFD5t6K0b8Rsr0oQDzQzkgY+iC9i6I8ZW7oyNyjof749bDCWl17K93dmDaLJB2jxlqeSLNbjcb/c2LmT2adzH4aE0T3i9/R4hrTRnxRe5wngA86RcTo23YlQ8+Yu+eXqDUkh5O66PbtEI1ui2XUkIo+CzFvpqvISiz3bXIIxcvsCFWX3Den1OTVxDgqfMJGZcqFcMCfoZLUY15r+NxWwO/ulFvE7HUkX0EJH9ZmgfxV74Nc2a7Ypa/mw/dEO2l5fWIj+NqDH4vVg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 04:18:08.0079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4447e4-1b35-4469-b98c-08dea738a634
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7515
X-Rspamd-Queue-Id: E598C4AA3B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19826-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Mark Bloch <mbloch@nvidia.com>

Representor callbacks can be registered and unregistered while the
E-Switch is already in switchdev mode, and the same E-Switch may also be
reconfigured by devlink, VF changes and SF changes. Serialize these paths
with the per-E-Switch representor mutex instead of relying on ad-hoc bit
state and wait queues.

Take the representor lock around the mode transition, VF/SF representor
changes and representor ops registration. Keep mode_lock and the
representor lock unnested by using the operation flag while the mode lock
is dropped. During mode changes, drop the representor lock around the
auxiliary bus rescan because driver bind/unbind may register or unregister
representor ops.

Split representor ops registration into locked public wrappers and blocked
internal helpers, clear the ops pointer on unregister, and add nested
wrappers for the shared-FDB master IB path that registers peer
representor ops while another E-Switch representor lock is already held.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/infiniband/hw/mlx5/ib_rep.c           |   6 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  10 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 102 ++++++++++++++++--
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  |   5 +
 include/linux/mlx5/eswitch.h                  |   6 ++
 5 files changed, 119 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/ib_rep.c b/drivers/infiniband/hw/mlx5/ib_rep.c
index 1709b628702e..65d8767d1830 100644
--- a/drivers/infiniband/hw/mlx5/ib_rep.c
+++ b/drivers/infiniband/hw/mlx5/ib_rep.c
@@ -262,9 +262,10 @@ mlx5_ib_vport_rep_unload(struct mlx5_eswitch_rep *rep)
 			struct mlx5_core_dev *peer_mdev;
 			struct mlx5_eswitch *esw;
 
+			/* Called while the master E-Switch reps_lock is held. */
 			mlx5_lag_for_each_peer_mdev(mdev, peer_mdev, i) {
 				esw = peer_mdev->priv.eswitch;
-				mlx5_eswitch_unregister_vport_reps(esw, REP_IB);
+				mlx5_eswitch_unregister_vport_reps_nested(esw, REP_IB);
 			}
 			mlx5_ib_release_transport(mdev);
 		}
@@ -284,9 +285,10 @@ static void mlx5_ib_register_peer_vport_reps(struct mlx5_core_dev *mdev)
 	struct mlx5_eswitch *esw;
 	int i;
 
+	/* Called while the master E-Switch reps_lock is held. */
 	mlx5_lag_for_each_peer_mdev(mdev, peer_mdev, i) {
 		esw = peer_mdev->priv.eswitch;
-		mlx5_eswitch_register_vport_reps(esw, &rep_ops, REP_IB);
+		mlx5_eswitch_register_vport_reps_nested(esw, &rep_ops, REP_IB);
 	}
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 66a773a99876..f70737437954 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1712,6 +1712,7 @@ int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs)
 		mlx5_lag_disable_change(esw->dev);
 
 	mlx5_eswitch_invalidate_wq(esw);
+	mlx5_esw_reps_block(esw);
 
 	if (!mlx5_esw_is_fdb_created(esw)) {
 		ret = mlx5_eswitch_enable_locked(esw, num_vfs);
@@ -1735,6 +1736,8 @@ int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs)
 		}
 	}
 
+	mlx5_esw_reps_unblock(esw);
+
 	if (toggle_lag)
 		mlx5_lag_enable_change(esw->dev);
 
@@ -1759,6 +1762,7 @@ void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf)
 		 esw->esw_funcs.num_vfs, esw->esw_funcs.num_ec_vfs, esw->enabled_vports);
 
 	mlx5_eswitch_invalidate_wq(esw);
+	mlx5_esw_reps_block(esw);
 
 	if (!mlx5_core_is_ecpf(esw->dev)) {
 		mlx5_eswitch_unload_vf_vports(esw, esw->esw_funcs.num_vfs);
@@ -1770,6 +1774,8 @@ void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf)
 			mlx5_eswitch_clear_ec_vf_vports_info(esw);
 	}
 
+	mlx5_esw_reps_unblock(esw);
+
 	if (esw->mode == MLX5_ESWITCH_OFFLOADS) {
 		struct devlink *devlink = priv_to_devlink(esw->dev);
 
@@ -1825,7 +1831,11 @@ void mlx5_eswitch_disable(struct mlx5_eswitch *esw)
 
 	devl_assert_locked(priv_to_devlink(esw->dev));
 	mlx5_lag_disable_change(esw->dev);
+
+	mlx5_esw_reps_block(esw);
 	mlx5_eswitch_disable_locked(esw);
+	mlx5_esw_reps_unblock(esw);
+
 	esw->mode = MLX5_ESWITCH_LEGACY;
 	mlx5_lag_enable_change(esw->dev);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 6a5143b63dfd..d4ac07c995b9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -36,6 +36,7 @@
 #include <linux/mlx5/mlx5_ifc.h>
 #include <linux/mlx5/vport.h>
 #include <linux/mlx5/fs.h>
+#include <linux/lockdep.h>
 #include "mlx5_core.h"
 #include "eswitch.h"
 #include "esw/indir_table.h"
@@ -2413,11 +2414,21 @@ static int esw_create_restore_table(struct mlx5_eswitch *esw)
 	return err;
 }
 
+static void mlx5_esw_assert_reps_locked(struct mlx5_eswitch *esw)
+{
+	lockdep_assert_held(&esw->offloads.reps_lock);
+}
+
 void mlx5_esw_reps_block(struct mlx5_eswitch *esw)
 {
 	mutex_lock(&esw->offloads.reps_lock);
 }
 
+static void mlx5_esw_reps_block_nested(struct mlx5_eswitch *esw)
+{
+	mutex_lock_nested(&esw->offloads.reps_lock, SINGLE_DEPTH_NESTING);
+}
+
 void mlx5_esw_reps_unblock(struct mlx5_eswitch *esw)
 {
 	mutex_unlock(&esw->offloads.reps_lock);
@@ -2425,21 +2436,22 @@ void mlx5_esw_reps_unblock(struct mlx5_eswitch *esw)
 
 static void esw_mode_change(struct mlx5_eswitch *esw, u16 mode)
 {
+	mlx5_esw_reps_unblock(esw);
 	mlx5_devcom_comp_lock(esw->dev->priv.hca_devcom_comp);
 	if (esw->dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_IB_ADEV ||
 	    mlx5_core_mp_enabled(esw->dev)) {
 		esw->mode = mode;
-		mlx5_rescan_drivers_locked(esw->dev);
-		mlx5_devcom_comp_unlock(esw->dev->priv.hca_devcom_comp);
-		return;
+		goto out;
 	}
 
 	esw->dev->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 	mlx5_rescan_drivers_locked(esw->dev);
 	esw->mode = mode;
 	esw->dev->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
+out:
 	mlx5_rescan_drivers_locked(esw->dev);
 	mlx5_devcom_comp_unlock(esw->dev->priv.hca_devcom_comp);
+	mlx5_esw_reps_block(esw);
 }
 
 static void mlx5_esw_fdb_drop_destroy(struct mlx5_eswitch *esw)
@@ -2776,6 +2788,8 @@ void esw_offloads_cleanup(struct mlx5_eswitch *esw)
 static int __esw_offloads_load_rep(struct mlx5_eswitch *esw,
 				   struct mlx5_eswitch_rep *rep, u8 rep_type)
 {
+	mlx5_esw_assert_reps_locked(esw);
+
 	if (atomic_cmpxchg(&rep->rep_data[rep_type].state,
 			   REP_REGISTERED, REP_LOADED) == REP_REGISTERED)
 		return esw->offloads.rep_ops[rep_type]->load(esw->dev, rep);
@@ -2786,6 +2800,8 @@ static int __esw_offloads_load_rep(struct mlx5_eswitch *esw,
 static void __esw_offloads_unload_rep(struct mlx5_eswitch *esw,
 				      struct mlx5_eswitch_rep *rep, u8 rep_type)
 {
+	mlx5_esw_assert_reps_locked(esw);
+
 	if (atomic_cmpxchg(&rep->rep_data[rep_type].state,
 			   REP_LOADED, REP_REGISTERED) == REP_LOADED) {
 		if (rep_type == REP_ETH)
@@ -3691,6 +3707,7 @@ static void esw_vfs_changed_event_handler(struct mlx5_eswitch *esw)
 	if (new_num_vfs == esw->esw_funcs.num_vfs || host_pf_disabled)
 		goto free;
 
+	mlx5_esw_reps_block(esw);
 	/* Number of VFs can only change from "0 to x" or "x to 0". */
 	if (esw->esw_funcs.num_vfs > 0) {
 		mlx5_eswitch_unload_vf_vports(esw, esw->esw_funcs.num_vfs);
@@ -3700,9 +3717,11 @@ static void esw_vfs_changed_event_handler(struct mlx5_eswitch *esw)
 		err = mlx5_eswitch_load_vf_vports(esw, new_num_vfs,
 						  MLX5_VPORT_UC_ADDR_CHANGE);
 		if (err)
-			goto free;
+			goto unblock;
 	}
 	esw->esw_funcs.num_vfs = new_num_vfs;
+unblock:
+	mlx5_esw_reps_unblock(esw);
 free:
 	kvfree(out);
 }
@@ -4188,9 +4207,14 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 		goto unlock;
 	}
 
+	/* Keep mode_lock and reps_lock unnested. The operation flag excludes
+	 * mode users while mode_lock is dropped before taking reps_lock.
+	 */
 	esw->eswitch_operation_in_progress = true;
 	up_write(&esw->mode_lock);
 
+	mlx5_esw_reps_block(esw);
+
 	if (mlx5_mode == MLX5_ESWITCH_OFFLOADS &&
 	    !mlx5_devlink_netdev_netns_immutable_set(devlink, true)) {
 		NL_SET_ERR_MSG_MOD(extack,
@@ -4223,6 +4247,10 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 skip:
 	if (mlx5_mode == MLX5_ESWITCH_OFFLOADS && err)
 		mlx5_devlink_netdev_netns_immutable_set(devlink, false);
+	/* Reconfiguration is done; drop reps_lock before taking mode_lock again
+	 * to clear the operation flag.
+	 */
+	mlx5_esw_reps_unblock(esw);
 	down_write(&esw->mode_lock);
 	esw->eswitch_operation_in_progress = false;
 unlock:
@@ -4496,9 +4524,10 @@ mlx5_eswitch_vport_has_rep(const struct mlx5_eswitch *esw, u16 vport_num)
 	return true;
 }
 
-void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,
-				      const struct mlx5_eswitch_rep_ops *ops,
-				      u8 rep_type)
+static void
+mlx5_eswitch_register_vport_reps_blocked(struct mlx5_eswitch *esw,
+					 const struct mlx5_eswitch_rep_ops *ops,
+					 u8 rep_type)
 {
 	struct mlx5_eswitch_rep_data *rep_data;
 	struct mlx5_eswitch_rep *rep;
@@ -4513,9 +4542,40 @@ void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,
 		}
 	}
 }
+
+static void
+mlx5_eswitch_register_vport_reps_locked(struct mlx5_eswitch *esw,
+					const struct mlx5_eswitch_rep_ops *ops,
+					u8 rep_type, bool nested)
+{
+	if (nested)
+		mlx5_esw_reps_block_nested(esw);
+	else
+		mlx5_esw_reps_block(esw);
+	mlx5_eswitch_register_vport_reps_blocked(esw, ops, rep_type);
+	mlx5_esw_reps_unblock(esw);
+}
+
+void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,
+				      const struct mlx5_eswitch_rep_ops *ops,
+				      u8 rep_type)
+{
+	mlx5_eswitch_register_vport_reps_locked(esw, ops, rep_type, false);
+}
 EXPORT_SYMBOL(mlx5_eswitch_register_vport_reps);
 
-void mlx5_eswitch_unregister_vport_reps(struct mlx5_eswitch *esw, u8 rep_type)
+void
+mlx5_eswitch_register_vport_reps_nested(struct mlx5_eswitch *esw,
+					const struct mlx5_eswitch_rep_ops *ops,
+					u8 rep_type)
+{
+	mlx5_eswitch_register_vport_reps_locked(esw, ops, rep_type, true);
+}
+EXPORT_SYMBOL(mlx5_eswitch_register_vport_reps_nested);
+
+static void
+mlx5_eswitch_unregister_vport_reps_blocked(struct mlx5_eswitch *esw,
+					   u8 rep_type)
 {
 	struct mlx5_eswitch_rep *rep;
 	unsigned long i;
@@ -4525,9 +4585,35 @@ void mlx5_eswitch_unregister_vport_reps(struct mlx5_eswitch *esw, u8 rep_type)
 
 	mlx5_esw_for_each_rep(esw, i, rep)
 		atomic_set(&rep->rep_data[rep_type].state, REP_UNREGISTERED);
+
+	esw->offloads.rep_ops[rep_type] = NULL;
+}
+
+static void
+mlx5_eswitch_unregister_vport_reps_locked(struct mlx5_eswitch *esw,
+					  u8 rep_type, bool nested)
+{
+	if (nested)
+		mlx5_esw_reps_block_nested(esw);
+	else
+		mlx5_esw_reps_block(esw);
+	mlx5_eswitch_unregister_vport_reps_blocked(esw, rep_type);
+	mlx5_esw_reps_unblock(esw);
+}
+
+void mlx5_eswitch_unregister_vport_reps(struct mlx5_eswitch *esw, u8 rep_type)
+{
+	mlx5_eswitch_unregister_vport_reps_locked(esw, rep_type, false);
 }
 EXPORT_SYMBOL(mlx5_eswitch_unregister_vport_reps);
 
+void mlx5_eswitch_unregister_vport_reps_nested(struct mlx5_eswitch *esw,
+					       u8 rep_type)
+{
+	mlx5_eswitch_unregister_vport_reps_locked(esw, rep_type, true);
+}
+EXPORT_SYMBOL(mlx5_eswitch_unregister_vport_reps_nested);
+
 void *mlx5_eswitch_get_uplink_priv(struct mlx5_eswitch *esw, u8 rep_type)
 {
 	struct mlx5_eswitch_rep *rep;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index 8503e532f423..2fc69897e35b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -245,8 +245,10 @@ static int mlx5_sf_add(struct mlx5_core_dev *dev, struct mlx5_sf_table *table,
 	if (IS_ERR(sf))
 		return PTR_ERR(sf);
 
+	mlx5_esw_reps_block(esw);
 	err = mlx5_eswitch_load_sf_vport(esw, sf->hw_fn_id, MLX5_VPORT_UC_ADDR_CHANGE,
 					 &sf->dl_port, new_attr->controller, new_attr->sfnum);
+	mlx5_esw_reps_unblock(esw);
 	if (err)
 		goto esw_err;
 	*dl_port = &sf->dl_port.dl_port;
@@ -367,7 +369,10 @@ int mlx5_devlink_sf_port_del(struct devlink *devlink,
 	struct mlx5_sf_table *table = dev->priv.sf_table;
 	struct mlx5_sf *sf = mlx5_sf_by_dl_port(dl_port);
 
+	mlx5_esw_reps_block(dev->priv.eswitch);
 	mlx5_sf_del(table, sf);
+	mlx5_esw_reps_unblock(dev->priv.eswitch);
+
 	return 0;
 }
 
diff --git a/include/linux/mlx5/eswitch.h b/include/linux/mlx5/eswitch.h
index 3b29a3c6794d..a0dd162baa78 100644
--- a/include/linux/mlx5/eswitch.h
+++ b/include/linux/mlx5/eswitch.h
@@ -63,7 +63,13 @@ struct mlx5_eswitch_rep {
 void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,
 				      const struct mlx5_eswitch_rep_ops *ops,
 				      u8 rep_type);
+void
+mlx5_eswitch_register_vport_reps_nested(struct mlx5_eswitch *esw,
+					const struct mlx5_eswitch_rep_ops *ops,
+					u8 rep_type);
 void mlx5_eswitch_unregister_vport_reps(struct mlx5_eswitch *esw, u8 rep_type);
+void mlx5_eswitch_unregister_vport_reps_nested(struct mlx5_eswitch *esw,
+					       u8 rep_type);
 void *mlx5_eswitch_get_proto_dev(struct mlx5_eswitch *esw,
 				 u16 vport_num,
 				 u8 rep_type);
-- 
2.44.0


