Return-Path: <linux-rdma+bounces-16052-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNUoGy59eGkFqQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16052-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 09:54:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2809591516
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 09:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E13AF303F543
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 08:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFFE32A3F3;
	Tue, 27 Jan 2026 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tebd+bFy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6AD2FD691;
	Tue, 27 Jan 2026 08:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504038; cv=fail; b=mBfnzK7b0GwpZ2LhatnY7pU50o7e8wbup0fd+Q2Vu5CFUTKtYuMGg5ZAmJUqURLnFSa/Kakw9oDgR1mFLI1TD1Pbi0WpCuCUYcn3+haODL7mSOFiHCqpkTvihldepRaoVF2cLWSYAGJB7VGR8lRbq1UA4KG1BCereYIKyJ+n7d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504038; c=relaxed/simple;
	bh=8G4NBkWUwOD8wnO2/jZjk5lkEMUPR5sYTqd+FQorb7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKszVhoN4bv5AYZFuiRNdkKTzcjEJ+mgi3TgD27MGdx3hUmB9Upyv9dlGJTcPVyAWXeNiPbedbZXMtYdjQRLb+bbF1Qzsm9p0Yuh8vgZUnh7rHIUubPgqSTcyrmVoEn4W0E71dvrT/VCb5jaTLB4MVpLe8F5dg5dQ78lLSe7KpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tebd+bFy; arc=fail smtp.client-ip=40.107.209.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhxtMBGa7IqbmPXO5qh1lrhw1Bbbnqc1mkUsBkx39JXGpLijVeaOYiErMVFMoW5hR3Q5hQw77ca62bMo9xPprr9mrwTfZ2KolAbYfvduJHMbosY6RxU4nwoKaaEu/29szPWnjaA3MF/jVHhHYcluBLyZ15W/voaGlB3tXQHkLZ7uEu3raPEsMvT+tCa1Vsty/KoZ8iegZy7hX6LVoqrlgsBbd+34CxlK7GwdbEFVgw+pAVgyhmWf/lI6r7Txm4S7LuoWi/C3nnOeW1FJ2yItQbLVlfveD1KSMDuZvzkFxMCBsiQ0yG5olHj+kiWFZDzkghGExiCyiRDdL+5dkeun/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEa1UyQqWY0GwVfPBGM1kJbkcZIJW39/xTM0XKHs1f4=;
 b=fF4WOBt6lLFssKtBkhgp8VHncCTm9WhYfhe3BMCnkwzkUSrQNHTGccPsOR0JtzKuu5p+8PGP5PyZ0x4NpRBJzGQM1kpQJ3kRzGtBj+SSbjCMLpzlggoKc9TGdEfI4jh5ckSKUNWKzXLMZc17GiGMcXw+sNTw4vE9LHfpZKe2LqJtHwVbCzb74+xVZeShIVTOBN3Vu2wfKU/J7R5HTGpkGp0ugWLCUquSHGgWoiXmfukn9O4pownlTI/eJd2HCgeghHkrtAN0zkg/rh8vJVtglO87wSxIZ+6Bv8a4Q94m0n15sTcP+qcAapS1HAOppU5CtPIn+lasog4FiNk60J6+jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEa1UyQqWY0GwVfPBGM1kJbkcZIJW39/xTM0XKHs1f4=;
 b=Tebd+bFyptNzYP7Ot/2m2nSWhL4l1E0gi+QwoaSvKUD0F3QE1cwsRt2l7gtFqTRwCZJy/MNDRY4RHBxEDbHa6MunSqmUAF8zhZX9WPpvEhy8Pv5qvEfH2K31p2ubNOiBz53qVjC0lm77HB/OQr+NmprOaykPbM+ogSVOlqhXui23EHjXhKKlLRcaEMNy7vQ8l1F9k3/mDqw6BFyzNI64ppo3AivXNshlwTDCXcRwQJYefGsc7iuc2vktcwYxvxwxMHkrQj9QtvopzIhtPK8mP06I+yaulmeUvfYGO+/w8SnLDy/NBtEx2iXryFowLJqRc5YGLsgG/+AmRDYN3BrKgw==
Received: from CH2PR04CA0014.namprd04.prod.outlook.com (2603:10b6:610:52::24)
 by IA1PR12MB9739.namprd12.prod.outlook.com (2603:10b6:208:465::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Tue, 27 Jan
 2026 08:53:52 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::bf) by CH2PR04CA0014.outlook.office365.com
 (2603:10b6:610:52::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 08:53:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 08:53:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 00:53:35 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 00:53:33 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 27
 Jan 2026 00:53:29 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Simon Horman <horms@kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>
Subject: [PATCH net V2 2/4] net/mlx5: Fix deadlock between devlink lock and esw->wq
Date: Tue, 27 Jan 2026 10:52:39 +0200
Message-ID: <1769503961-124173-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1769503961-124173-1-git-send-email-tariqt@nvidia.com>
References: <1769503961-124173-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|IA1PR12MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: fa8cb76d-60f8-4659-3592-08de5d8198a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2PLozsFMR/Apg/5uOt54OnddUWzrHt5DpiIET2OqOYRh7GrXgJOZ3/+IKXMX?=
 =?us-ascii?Q?csmBp4CXi5PTDvPFeBL+LNcW6242eYJuPEOoqt24QLRcr9mFu+7X7LgHtiXu?=
 =?us-ascii?Q?AVdQ3Wltj+GLUUAeqIaU1I3YqJgiymxAuQYyEo4q+5IluPj335ET2RURO+F3?=
 =?us-ascii?Q?w4EYSBVso6hpsJYPqd39wOlNSGxYI+qa2tS8nSb9CQjhcf2O/gBaAsaPmRz3?=
 =?us-ascii?Q?INvH7UJdldc+QhJpCaBwk4G4q2J0kspf4JGAhsXKTfomNkMljkTULB1S+zTa?=
 =?us-ascii?Q?ORxcVIgC24CyktAl59vMjlGzioRlv7f1fMqBgT5eSrQ+m8AleaeTH9BM6ExY?=
 =?us-ascii?Q?bKlzhqq99fHGc24GlYvVZ2LRQfoLO5H+o72PZMn0/XlUfft0eshtcOOY9akn?=
 =?us-ascii?Q?77mxzk+0ExoIPMbmL+pPTWbeu8RfKa1H7+BCqDnLV07it4zFm2Dgwb+2slfI?=
 =?us-ascii?Q?76yI59ebdmvZKLI0uc3Qpn8gEUyusgEBIMpo1zcJb7CHtR82gE5+fH1sy7zJ?=
 =?us-ascii?Q?oIveYxc4MtU8EjDgVy0CE6prYxjko78OC0waH3yWQnzqendz0Mw+DamWY+c6?=
 =?us-ascii?Q?mpcJTOmbvA9BpN2qA/0Ntq09nwzPSfwjn0PgdiHuqIu+FoXAOhfIPSB0GsyV?=
 =?us-ascii?Q?iRO48U+8it7YrTRnctUAlksjMQbLKRAN7u0tnV3m1a5xFtWzB/EJNNcNJnDz?=
 =?us-ascii?Q?msUb9+uToNkwiPu0rTVyHkwzsM0k9gnx4cUHbKFVAPoLmLesztK8xnKd2ur+?=
 =?us-ascii?Q?hUKBj+emVe0oPW8g0/iib618zRMT4JSoiS+kTVGOzB9GFyZcALDJpGjaVVz7?=
 =?us-ascii?Q?H3ODrObn9XYv2YxObemKXF3uvZzOQG9CxE/WaLvb4YsfstqPcIXvy2HoxCAa?=
 =?us-ascii?Q?WCwwxgGjnexyL8a9+YALTEW+NSoRraHPI1z3ghiAVM/FZJUDFCi3Z3+4dmIr?=
 =?us-ascii?Q?GruhJGpcSoJdibTjBTMfsL8vgPUY+rx02U82yA8TqSxqziXBXfZPvkUF0Ltr?=
 =?us-ascii?Q?+m7lCLPiV16fgTSIh1aFlexgM4Fu70bHyLcsEPlDjLiREBiAXnVsgFZq83Uy?=
 =?us-ascii?Q?nBQ9xTlNwJDlf3NeDDirujWwGz2BXzGe17uUuV6jtM3OhnGR+la2z/njcl05?=
 =?us-ascii?Q?X4aGLJ7pob9mf94FLFjjKBBkcC8NvzbgArlz4Rznfn/TaEOGCNRhZvC9hXOj?=
 =?us-ascii?Q?TcUuNHZT7ifskbA4d9BM9kE2GQmap46vGoC8afYGzsz6f0NF43TCjeYrYhwv?=
 =?us-ascii?Q?SELJhtr0o79s/Kuyd6nf02TZszC4ICtT3D2czLdcLwhyiAVRzn7zdK0BQ1Iy?=
 =?us-ascii?Q?2giQ2elTjPnrdhu9pAkvnbJDXpuibF8fyU4n0y4h3CWLb8rbbwMLSGoymLa5?=
 =?us-ascii?Q?IQaBr68MRdDRu2mWdEEW8ODsxRDosjtimYfEVrHaCy4PxSEIIAMGMP6UU1Dl?=
 =?us-ascii?Q?MAVwKwjAXhySDU4lm+0S2o4Dxzfal47XViv76PHERBKeoVNLYI/glRJ84Zoy?=
 =?us-ascii?Q?5+qQWEw7FqwasFCYnz5hzPXUafM2sakDAGFIt4tkkeSms/JIi3DtH7yQmZDa?=
 =?us-ascii?Q?Oc8rMldpnTO6Eh4ilZNmzu1Ef0zm+oM5v+AkusFkENVykwZf0xEn7n37URPR?=
 =?us-ascii?Q?KlExzBvMPOiuKfBVqGMgyrG467qkJMyqEMuEfb5Lrl8Z6pRURLTuIalayBmd?=
 =?us-ascii?Q?IhadeQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:53:52.4722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8cb76d-60f8-4659-3592-08de5d8198a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9739
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16052-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2809591516
X-Rspamd-Action: no action

From: Cosmin Ratiu <cratiu@nvidia.com>

esw_functions_changed_event_handler -> esw_vfs_changed_event_handler is
called from the esw->work_queue and acquires the devlink lock.

Changing the esw mode is done via .eswitch_mode_set (acquires devlink
lock in the devlink_nl_pre_doit call) -> mlx5_devlink_eswitch_mode_set
-> mlx5_eswitch_disable_locked -> mlx5_eswitch_event_handler_unregister
-> flush_workqueue.

This creates a circular lock dependency which could lead to a real
deadlock, as the code flushing the workqueue is holding the devlink
lock, and the work handler being flushed could try to acquire it.

Fix that by adding a new bool field 'notifier_enabled' next to the event
handler scheduling the work, keeping it true while the notifier is
active, and using it to repeatedly try to acquire the devlink lock from
the work handler while true, with a slight delay to avoid busy looping.

This avoids the deadlock because the event handler will be removed
first (turning 'notifier_enabled' false), and the work handler will
eventually give up in acquiring the lock because the work is no longer
necessary.

Fixes: f1bc646c9a06 ("net/mlx5: Use devl_ API in mlx5_esw_offloads_devlink_port_register")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c    |  6 +++++-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h    |  1 +
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c   | 12 +++++++++++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 4b7a1ce7f406..fddc3b33222d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1066,14 +1066,18 @@ static void mlx5_eswitch_event_handler_register(struct mlx5_eswitch *esw)
 	if (esw->mode == MLX5_ESWITCH_OFFLOADS && mlx5_eswitch_is_funcs_handler(esw->dev)) {
 		MLX5_NB_INIT(&esw->esw_funcs.nb, mlx5_esw_funcs_changed_handler,
 			     ESW_FUNCTIONS_CHANGED);
+		esw->esw_funcs.notifier_enabled = true;
 		mlx5_eq_notifier_register(esw->dev, &esw->esw_funcs.nb);
 	}
 }
 
 static void mlx5_eswitch_event_handler_unregister(struct mlx5_eswitch *esw)
 {
-	if (esw->mode == MLX5_ESWITCH_OFFLOADS && mlx5_eswitch_is_funcs_handler(esw->dev))
+	if (esw->mode == MLX5_ESWITCH_OFFLOADS &&
+	    mlx5_eswitch_is_funcs_handler(esw->dev)) {
+		esw->esw_funcs.notifier_enabled = false;
 		mlx5_eq_notifier_unregister(esw->dev, &esw->esw_funcs.nb);
+	}
 
 	flush_workqueue(esw->work_queue);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index e7fe43799b23..af35312a8ced 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -338,6 +338,7 @@ struct mlx5_host_work {
 
 struct mlx5_esw_functions {
 	struct mlx5_nb		nb;
+	bool                    notifier_enabled;
 	bool			host_funcs_disabled;
 	u16			num_vfs;
 	u16			num_ec_vfs;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index ea94a727633f..0199bea2cb31 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3597,7 +3597,17 @@ esw_vfs_changed_event_handler(struct mlx5_eswitch *esw, const u32 *out)
 		return;
 
 	devlink = priv_to_devlink(esw->dev);
-	devl_lock(devlink);
+	/* Repeatedly try to grab the lock with a delay while this work is
+	 * still relevant.
+	 * This allows a concurrent mlx5_eswitch_event_handler_unregister
+	 * (holding the devlink lock) to flush the wq without deadlocking.
+	 */
+	while (!devl_trylock(devlink)) {
+		if (!esw->esw_funcs.notifier_enabled)
+			return;
+		schedule_timeout_interruptible(msecs_to_jiffies(10));
+	}
+
 	/* Number of VFs can only change from "0 to x" or "x to 0". */
 	if (esw->esw_funcs.num_vfs > 0) {
 		mlx5_eswitch_unload_vf_vports(esw, esw->esw_funcs.num_vfs);
-- 
2.40.1


