Return-Path: <linux-rdma+bounces-17510-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BzcNp86qWkd3QAAu9opvQ
	(envelope-from <linux-rdma+bounces-17510-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 09:11:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6AA20D3B5
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 09:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49048302084B
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 08:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2181D36681F;
	Thu,  5 Mar 2026 08:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gol/J4hD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013021.outbound.protection.outlook.com [40.107.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8172B30F932;
	Thu,  5 Mar 2026 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772698268; cv=fail; b=a7W6wqPEk82x0JLDcO0pEj0jT1RAmuoOz0A8Co6jIIiuP2aUX7zsefi0IU9EW9CGoGWj118DH3k6MSmMeCAHMZMnhNc4WJm9q+pAd7WNDIIGnwRdsDIa/Wll6Csws9iTzn/rqD3DG6uqqg9IklDAHXUADvrT+d3E47G5exJQa3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772698268; c=relaxed/simple;
	bh=sGJo2aSvQmt7kUzR93A5I+nJj8vlMdnqR7tPoVy9N+k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tyWE83BnaiPJzjfowuX5eBI4sZ8qDdHBSh0fMJNcXXzj6VVFoGG+pVIljRmBvaViuFsrr+Pz+JoIBuX3hdxWaW/Swfolvwemzv2/eHXzH1aEE1B12q3jqC0Ngro8VGoMKwScfQEwmxi2kOF3c21vMbehmcQFLdRD6k05PU83KRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gol/J4hD; arc=fail smtp.client-ip=40.107.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUT5qLWj7aWf9RMA0VMTUjMnK+zKYgh/3RxxVXPSYxSUQpp1hWSwiSN28j22COkWb3Vkms1I1rPm1TnIy8PUR8Jeo3xxudb6/sXyU3s7JlO0HsoHimuKbB4mivDUz64DkNIezxGGt60ovRlxLCgCbhE7SDGQftlHukxnVAUyLiFoDk4wQa5arm3V6YDvm1uulISSzsR7+CmX1yrKQy4mUyDP0PwtNmsuf/ujTxUTXDHR34tRZ/SLDRQynd5/RQQSLvQx65sxD5P5D2HbQh8aUhqKE00wtoIXjI5FLefh6DAl0mxjFCtdZd2627x7mXeuxUobzdxsfwYhezRGJV0vfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLn+GRp6M/EwjzFzEsDf7iVG5AUjmxcV9QYhhGuEkVc=;
 b=iQ+wf/YeVJkRXTXVGj3xQmwqHmUILmXh8jRX/o16M/wFg9WhrE6rXSAnVhoQhznxtlbOZhecpDjHJb75+x4R8M0KgHQ7qZLdtjpiw46UWTSUy/xRlBf7MVsN+pJvPCyxH3X4WqL8GnXS1NKBUvtONWDGvEYeSP0duj4jYrZId0Nzcss01s2JpRDkuZXJZ9TlnNADlq9ESG/+nedQZRbHTwN4LRZp0s00A1DmWQ5spCajdhoC6+VlPgS9rKWMgf6bQJUdMAHdM3Qeb5KM61UeCW9w6XJ2M2Om8g1ecL2EoOZnGpnpjZb25fpJE4paaxZk95zpY9bpRQyWC9cd+2T4lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLn+GRp6M/EwjzFzEsDf7iVG5AUjmxcV9QYhhGuEkVc=;
 b=gol/J4hDAih7TdpGFjp8Vk5Ot4+0NiLPkfQlUqKEcG6bGtii9mh1KgQGB/mNAOdin7v1ucdmYJi3CFcbsj4J2NoK/YGv+XuNhHb6M7bpKZUrAtoUDm7HTe3zTWT899nXXeVuuCuID3GteoTPB9E4HiY6g0w3QU1JNpmuBPddarR4GW5ZpiF4EFilVwI83uL4bWYtNPOGA5t2JICeNLVCpQ/2oSFHVdoVZgF5tNhUphkhf4ws2egPKwMvzhf/ywBtxbYc1g6HMhBklB5HHsqV97C1AxMIvHosY37ydf4QSVsgzZPsWDz/ZrJ0JYWGPKSb5EUhUUEPwZjau0WZbuAkgQ==
Received: from SN6PR05CA0014.namprd05.prod.outlook.com (2603:10b6:805:de::27)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 08:11:01 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::35) by SN6PR05CA0014.outlook.office365.com
 (2603:10b6:805:de::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.17 via Frontend Transport; Thu,
 5 Mar 2026 08:11:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 08:11:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 00:10:45 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 00:10:44 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 5 Mar
 2026 00:10:40 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net V3] net/mlx5: Fix deadlock between devlink lock and esw->wq
Date: Thu, 5 Mar 2026 10:10:19 +0200
Message-ID: <20260305081019.1811100-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1b1107-f47f-4025-9f04-08de7a8ebd1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	R2acKR2jXli0KBdrafn8P4STRxLa1yAJP5RUmkkGjAzsxa0ndONDhAy8mThdy8NyB6Ui6Uh1Qpx/v7Th5aCJPQIM5MtXCRb5urhvNy0EFrhiF/DfGTddGkIZrCZe3ugpgfbQduM1Z1RSbEaxlf0pHyiIxwDFH5hUdVmILpE+8CZoi2Jofh1t5W24VmrQgTXLpXPxHIIarHST15lHx1pkAcjN2SdtvxDOQMeTPl9VB9KFPG3w50p1kuQURpaNfvw4pTRQjFzG0IYOWLydZSDQNbLjoSJ9hPmcEcsAQvz/Bnf9BxI3Elezhpd1ktQXDJuRtvKEDhzisLeuRPC+xsQbi89VBfi6KU7ywHmLVeTS8LQXMead34cOJgc0yY+tI6wNWKRuD2+jDI0l8vGrkY4Mzyuj6CuFig4cLgwAcW1UEzsKTvAovoc99KawhJ03hsWrKAhJnf5EkMcdAQcfkPcTQCcYmmuQ15N03NcRtCIwIwiVrmzATmz2/uYGIccglW+fHsjIYfnjwhvCtdUxzkxFFzxjVjvAp8bpQMfycDPXrVmm+Mh1R3XN4s25c5ZMp7zGMw0feIwcfNo3H2ubKtDc6dFYWht7e/tTPzIVCz62SeUeZ16JKqbezH5QG/lLivLMbtgFVFozWXIAfA9Y/qwz1FnimN6dSoUULBtBEewh0gMVrDP5ozxKzBPGKMXtU2KtmoXgrGz6XaDp+/Jgwb/a4VeQMlRbGiB9lLsXQgzPjwFg5H1Ti5TXPkS9YTLqFDQBvVbJ+0cgPmtfbHTZ5KVjMw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PcIQkEAN/Vt3U0mwxg/+84aZViRuRBx0W3MXD44fwiPaSKfFiMEAy8QRDRIlf8wuZoXf60m12HHbNKrVskwUS9X+estwsxWiORQKrMT0+JiLyjP5uvynYEBNtd/3P0F0gHUZ+PRydGEeWzWINw2iPi+O6dWHhDHdhuTU9iJgFgGmzMNF23PglIDDoVoMZJLcGM61OdI8d0nStyKNHXljQKPjYeFcYbteJymLVBaA3K3hmIBzhI34mSyadkbUJkapKgj9MgWotY+fzLOViy7OMC0TU4IV6l9f1t0nm6j5FI8PaJbi506SOw9RDRIcj4QE8cjA8dejZXi24rBoxDngv4jq7kquw9cNEtvJDJvaRcRF4naiRn01+0Xnn7oS/UyPF8nKqXcmYMRa+h8sj5NHHvGO85udWOMp06mDmbbwyYW9vfRG+SitgSgDcOjdL5ub
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 08:11:00.8352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1b1107-f47f-4025-9f04-08de7a8ebd1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210
X-Rspamd-Queue-Id: 5B6AA20D3B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17510-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Cosmin Ratiu <cratiu@nvidia.com>

esw->work_queue executes esw_functions_changed_event_handler ->
esw_vfs_changed_event_handler and acquires the devlink lock.

.eswitch_mode_set (acquires devlink lock in devlink_nl_pre_doit) ->
mlx5_devlink_eswitch_mode_set -> mlx5_eswitch_disable_locked ->
mlx5_eswitch_event_handler_unregister -> flush_workqueue deadlocks
when esw_vfs_changed_event_handler executes.

Fix that by no longer flushing the work to avoid the deadlock, and using
a generation counter to keep track of work relevance. This avoids an old
handler manipulating an esw that has undergone one or more mode changes:
- the counter is incremented in mlx5_eswitch_event_handler_unregister.
- the counter is read and passed to the ephemeral mlx5_host_work struct.
- the work handler takes the devlink lock and bails out if the current
  generation is different than the one it was scheduled to operate on.
- mlx5_eswitch_cleanup does the final draining before destroying the wq.

No longer flushing the workqueue has the side effect of maybe no longer
cancelling pending vport_change_handler work items, but that's ok since
those are disabled elsewhere:
- mlx5_eswitch_disable_locked disables the vport eq notifier.
- mlx5_esw_vport_disable disarms the HW EQ notification and marks
  vport->enabled under state_lock to false to prevent pending vport
  handler from doing anything.
- mlx5_eswitch_cleanup destroys the workqueue and makes sure all events
  are disabled/finished.

Fixes: f1bc646c9a06 ("net/mlx5: Use devl_ API in mlx5_esw_offloads_devlink_port_register")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c  |  7 ++++---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h  |  2 ++
 .../mellanox/mlx5/core/eswitch_offloads.c      | 18 +++++++++++++-----
 3 files changed, 19 insertions(+), 8 deletions(-)

V3:
- Use another approach to avoid trylock.
- Link to V2: https://lore.kernel.org/all/1769503961-124173-3-git-send-email-tariqt@nvidia.com/

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index d3af87a94a18..123c96716a54 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1072,10 +1072,11 @@ static void mlx5_eswitch_event_handler_register(struct mlx5_eswitch *esw)
 
 static void mlx5_eswitch_event_handler_unregister(struct mlx5_eswitch *esw)
 {
-	if (esw->mode == MLX5_ESWITCH_OFFLOADS && mlx5_eswitch_is_funcs_handler(esw->dev))
+	if (esw->mode == MLX5_ESWITCH_OFFLOADS &&
+	    mlx5_eswitch_is_funcs_handler(esw->dev)) {
 		mlx5_eq_notifier_unregister(esw->dev, &esw->esw_funcs.nb);
-
-	flush_workqueue(esw->work_queue);
+		atomic_inc(&esw->esw_funcs.generation);
+	}
 }
 
 static void mlx5_eswitch_clear_vf_vports_info(struct mlx5_eswitch *esw)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 6841caef02d1..c2563bee74df 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -335,10 +335,12 @@ struct esw_mc_addr { /* SRIOV only */
 struct mlx5_host_work {
 	struct work_struct	work;
 	struct mlx5_eswitch	*esw;
+	int			work_gen;
 };
 
 struct mlx5_esw_functions {
 	struct mlx5_nb		nb;
+	atomic_t		generation;
 	bool			host_funcs_disabled;
 	u16			num_vfs;
 	u16			num_ec_vfs;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 1366f6e489bd..8c5e48d001be 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3582,22 +3582,28 @@ static void esw_offloads_steering_cleanup(struct mlx5_eswitch *esw)
 }
 
 static void
-esw_vfs_changed_event_handler(struct mlx5_eswitch *esw, const u32 *out)
+esw_vfs_changed_event_handler(struct mlx5_eswitch *esw, int work_gen,
+			      const u32 *out)
 {
 	struct devlink *devlink;
 	bool host_pf_disabled;
 	u16 new_num_vfs;
 
+	devlink = priv_to_devlink(esw->dev);
+	devl_lock(devlink);
+
+	/* Stale work from one or more mode changes ago. Bail out. */
+	if (work_gen != atomic_read(&esw->esw_funcs.generation))
+		goto unlock;
+
 	new_num_vfs = MLX5_GET(query_esw_functions_out, out,
 			       host_params_context.host_num_of_vfs);
 	host_pf_disabled = MLX5_GET(query_esw_functions_out, out,
 				    host_params_context.host_pf_disabled);
 
 	if (new_num_vfs == esw->esw_funcs.num_vfs || host_pf_disabled)
-		return;
+		goto unlock;
 
-	devlink = priv_to_devlink(esw->dev);
-	devl_lock(devlink);
 	/* Number of VFs can only change from "0 to x" or "x to 0". */
 	if (esw->esw_funcs.num_vfs > 0) {
 		mlx5_eswitch_unload_vf_vports(esw, esw->esw_funcs.num_vfs);
@@ -3612,6 +3618,7 @@ esw_vfs_changed_event_handler(struct mlx5_eswitch *esw, const u32 *out)
 		}
 	}
 	esw->esw_funcs.num_vfs = new_num_vfs;
+unlock:
 	devl_unlock(devlink);
 }
 
@@ -3628,7 +3635,7 @@ static void esw_functions_changed_event_handler(struct work_struct *work)
 	if (IS_ERR(out))
 		goto out;
 
-	esw_vfs_changed_event_handler(esw, out);
+	esw_vfs_changed_event_handler(esw, host_work->work_gen, out);
 	kvfree(out);
 out:
 	kfree(host_work);
@@ -3648,6 +3655,7 @@ int mlx5_esw_funcs_changed_handler(struct notifier_block *nb, unsigned long type
 	esw = container_of(esw_funcs, struct mlx5_eswitch, esw_funcs);
 
 	host_work->esw = esw;
+	host_work->work_gen = atomic_read(&esw_funcs->generation);
 
 	INIT_WORK(&host_work->work, esw_functions_changed_event_handler);
 	queue_work(esw->work_queue, &host_work->work);

base-commit: ae779bcb18cb0ef0da1402b9dd837e2084e23e27
-- 
2.44.0


