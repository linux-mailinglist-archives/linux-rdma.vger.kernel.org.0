Return-Path: <linux-rdma+bounces-19154-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMtzNIuU12mGPwgAu9opvQ
	(envelope-from <linux-rdma+bounces-19154-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 13:59:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1AB3C9F77
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 13:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFA1B3038F02
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 11:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD16D3C6A29;
	Thu,  9 Apr 2026 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AtSc/i2f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012038.outbound.protection.outlook.com [40.93.195.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA0B3C661D;
	Thu,  9 Apr 2026 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735835; cv=fail; b=tAucRsnQhVd6A6c/bon33NTzhtZLYO0tlm/ViddJCB7+lZJhs7ClyzD3G964sPY9saMN1690MkGoNJSHu8jIuAgOWNkwJ44iVq8SKbDuA5mqcTmZqozYof8XWfFK4as4ktxjqctd9a5zn3IKCkHEAqP0C5dnsWmddWPNmWrLK/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735835; c=relaxed/simple;
	bh=vibA7T73tn3XKSN2RewOrwpT2J5OgltrvE5n/AAKV2I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ceCd1uEGfeLzvuFIPadnWHY/WARuFkbEx72fxJ9+eHMvK1mSEjMi+qS8ZXcHPbs6TqC+dcxwWlP4CKZiXfYXVE/F+MbuM5hdWSwrycVJlVBJrkU+SShM6VjdJo+qpvfcWUihxpoJBkkrnRflRbgQgVn+N3VXYWwN1hdOqTr+gWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AtSc/i2f; arc=fail smtp.client-ip=40.93.195.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSdecLy7T1ZPxKQiPdWqtv4g9Emsj0N1dKz1uXwQyt18pUTfPzylz5EwEFVF4ivJnq/LbdT+kMsAgFaSEN9sXeR1M1JlM+2RoJnkpvfc4m1Hg5a0qQ3bM9Igdv1hjQjnDIGdUCDORFvOmuRkNIXlp2cXNXQrLsp2kE2qdiBP9KITFlu9nmMPYU2iXqU76UOXXS6omdKWBUqtshX/7qCrvC8HB1phJU5b3IehKVOic1hRSl3+EQnGYXAnpvQZBojS0+cpAOkS3ggXTJrEcjcCIoGs+CG/SqjqmSLvaiaf4XGFzivfEItisQtpDwI5N6dWxoMInQydst1MTAoPd54D9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypQ65QFO1RGmkU10+qxL8xGIqMvtK+2CgrgcsN2e7Fg=;
 b=Izwqe6NxSo/C6Y3SK7Foj9Nt6OIAH3V6IpNycWplB/1lO02sRffxOvL80R8tA+7vRSJQzNml/Bvf4a12BSTKOQGMWF5MwpqJrR8sjB18hhwu2HE2nGGBLxB82WskOkYKNtJrChuiTMOzNTghBAjWm7NwfCJyGO7W8T/KJKPMfRVMw7QHDrTo4AScFHJK2Jely/jX7PsirAMpWvlcGC+Dfgw+tfqWJ7+Mu/WGahznPHimixLEP52DqcO2bAiwQH5XwE5xaOOR3PYilFyOQBJxbdQEjVK/URWGWAHEGBH9/daUl//k6xavVy0tclbCsiyFCmy5JrfyybUhlkyJkAMoSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypQ65QFO1RGmkU10+qxL8xGIqMvtK+2CgrgcsN2e7Fg=;
 b=AtSc/i2fFq41zczjgKci0xY5XYYMaC53KuXwqL9iLeej9sDCs1e2LixpEbCaXka+xamUUy00u8YrSYz9TSbVkkJmknbPY55mAiRMaxt6pcXzG+DCNePEqCB+kzrE8D79fzkKM/zjU3mgUvO9nmIaJLL5jl+wd3F93Pbnk++rKwMXzRg76/rBy1iLbiS+8cbUemfQe7JPh2m5l7XLSfEpkh8FEf7mvshKTJDcFJp7dr6+tgKSRzMIg6Z266SCn4FlfS7p4WJwkOM0whSCeh6J+bS8m/ImiDZ8PzQ3qI+SzyKCG1Cu/wUzWQVdoYW4xmCHrCx9SuGA7Oi9qOv5X2HNgA==
Received: from CH5P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::7)
 by IA1PR12MB8335.namprd12.prod.outlook.com (2603:10b6:208:3fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 11:57:08 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::7f) by CH5P223CA0009.outlook.office365.com
 (2603:10b6:610:1f3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 11:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 11:57:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 04:56:54 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 9 Apr 2026 04:56:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 04:56:48 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Gerd Bayer
	<gbayer@linux.ibm.com>, Parav Pandit <parav@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 4/7] net/mlx5: E-Switch, fix deadlock between devlink lock and esw->wq
Date: Thu, 9 Apr 2026 14:55:47 +0300
Message-ID: <20260409115550.156419-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260409115550.156419-1-tariqt@nvidia.com>
References: <20260409115550.156419-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|IA1PR12MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: f529d793-ef52-44ad-0045-08de962f2016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	r1X6TRiPHkGidTTVdUnqHEgH08tCFpsP94WE0yRoSxDUg32YvqLYn8iUUGptjrFh/9nP4vFtkoOtj1vgfJkjlZ/iwCPfqrlWvmeCanLgsAtkZGYJ5YLUvtPRjad0SU68Kk8c+uBh7mJKySZEc5dZ3c2f1xDNmzjJFqiP9Fl9Ip7JbbI4rTEit3P5rxNBvvmOhxcpFZ+LJoHlwI/WU9iuMnCnM1HBxiqtHK1kO06qJ/OkIoDOnsHlpxG0tNQzTM5rTXp47qGq4v7P4BkB8TndlklrncerTrAnr/C16q0zJfyYujelaE9HwOuGb7pXAXAP3vEGWKMAjUaVcj+ApttkkPUQZXxxTycVIAvu4T/UZYoDuZOnSDTfcTxS7LORLlW7TqSzdPJnu9twIkUozIF5m27lytcN14JbCZinRYBWvrzRAbvWm1Q1HwmKKo1hqVNKafoZvw6hfYUxIz0ZaE0zSpKVXU7KJ8ic9fk8XYjwzqtNSubWTPK4pIdBgdwLf0/BkcmByC4YEfKAS6YRQygG7BAJqQ/QGlcOfMgP0H2NWLOkpOtv/2ExSQ9o9SSvTdTA92Fv6oo+cvC0gaaFZVavPzq6jxBs+7/7JG8Yet7kg82u0L2AGqDPGCrPL8wRW1bxpigCzx03BjIzm4gOY0et6k6PBFyF7tZ0Ch43oKgcrCflf8FTBaNdItLxyqfJAu/LFfnxGS91cPdzF8Ocgi6pt70fLPozzQHXA0u2ccWGiJ6DtJVoU1ix22GXpVqSOpGzepFS9zQWk56itfhBFMo6Qg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	skcjyuVeU9HjynhhtYPnqycrXyHSVyNGJgCqk5AvuyLk3CLmHeleOQc1ac32msloiDDgaS7GwlLw9JLSGPJv1YMuxq/pWGLisRhn7af8BKQ2E3a5Rv5HpEfkBw6gca73rJUJDVE+dI+T1mag/rTx78vObT/Uw58AaoQ56DFmy3cN+Gnka7dOfGYv/K9nt99K6ATv15vTY3RWaw461q/rhu10iAdZGoP8ras++jVXI7K/5YD2oeLQ+fU8xXMOgDHkc5MGz/ALWQs0oGcR2QsizGbb05KLazwP5kRCBJ37uDva72qr9vWxigdYkFsiR01Y1V7mA2WieMvzcVjLeTrUNtQMmzKVO3z4ZkXPvNTWUykiYbPxaHbVmtqDEy2TxwLFiwakscXwSzu+pxLxNuJtlBsme0D/NjDVjCmiTkghZ+l2FHT/lTboeirXXW9Hw4HT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 11:57:07.7507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f529d793-ef52-44ad-0045-08de962f2016
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8335
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19154-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BB1AB3C9F77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mark Bloch <mbloch@nvidia.com>

mlx5_eswitch_cleanup() calls destroy_workqueue() while holding the
devlink lock (via mlx5_uninit_one()). Workers on the queue call
devl_lock() before checking whether their work is stale, which
deadlocks:

  mlx5_uninit_one (holds devlink lock)
    mlx5_eswitch_cleanup()
      destroy_workqueue()     <- waits for workers to finish
                                 worker: devl_lock() <- blocked on
                                         devlink lock held above

The same pattern affects mlx5_devlink_eswitch_mode_set(), which can
drain the queue while holding devlink lock.

Fix by making esw_wq_handler() check the generation counter BEFORE
acquiring the devlink lock, using devl_trylock() in a loop with
cond_resched(). If the work is stale the handler exits immediately
without ever contending for the lock.

To guarantee stale detection, increment the generation counter at
every E-Switch operation boundary:

- mlx5_eswitch_cleanup(): increment before destroy_workqueue() so
  any in-flight worker sees stale and drains without blocking. Also
  move mlx5_esw_qos_cleanup() to after destroy_workqueue() so it
  runs only once all workers have finished.
- mlx5_devlink_eswitch_mode_set(): increment before starting the
  mode change so workers from the previous mode are discarded.
- mlx5_eswitch_disable(): increment so workers queued before the
  disable see stale and exit.
- mlx5_eswitch_enable() and mlx5_eswitch_disable_sriov(): increment
  so in-flight work against an old VF count or mode is discarded
  when these operations begin.

Remove the conditional atomic_inc() in
mlx5_eswitch_event_handler_unregister(); the mlx5_eswitch_disable()
increment now covers it unconditionally and earlier in the call chain.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c  | 11 +++++++----
 .../mellanox/mlx5/core/eswitch_offloads.c      | 18 +++++++++++++++++-
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 1986d4d0e886..d315484390c8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1073,10 +1073,8 @@ static void mlx5_eswitch_event_handler_register(struct mlx5_eswitch *esw)
 static void mlx5_eswitch_event_handler_unregister(struct mlx5_eswitch *esw)
 {
 	if (esw->mode == MLX5_ESWITCH_OFFLOADS &&
-	    mlx5_eswitch_is_funcs_handler(esw->dev)) {
+	    mlx5_eswitch_is_funcs_handler(esw->dev))
 		mlx5_eq_notifier_unregister(esw->dev, &esw->esw_funcs.nb);
-		atomic_inc(&esw->generation);
-	}
 }
 
 static void mlx5_eswitch_clear_vf_vports_info(struct mlx5_eswitch *esw)
@@ -1701,6 +1699,8 @@ int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs)
 	if (toggle_lag)
 		mlx5_lag_disable_change(esw->dev);
 
+	atomic_inc(&esw->generation);
+
 	if (!mlx5_esw_is_fdb_created(esw)) {
 		ret = mlx5_eswitch_enable_locked(esw, num_vfs);
 	} else {
@@ -1745,6 +1745,7 @@ void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf)
 	esw_info(esw->dev, "Unload vfs: mode(%s), nvfs(%d), necvfs(%d), active vports(%d)\n",
 		 esw->mode == MLX5_ESWITCH_LEGACY ? "LEGACY" : "OFFLOADS",
 		 esw->esw_funcs.num_vfs, esw->esw_funcs.num_ec_vfs, esw->enabled_vports);
+	atomic_inc(&esw->generation);
 
 	if (!mlx5_core_is_ecpf(esw->dev)) {
 		mlx5_eswitch_unload_vf_vports(esw, esw->esw_funcs.num_vfs);
@@ -1809,6 +1810,7 @@ void mlx5_eswitch_disable(struct mlx5_eswitch *esw)
 		return;
 
 	devl_assert_locked(priv_to_devlink(esw->dev));
+	atomic_inc(&esw->generation);
 	mlx5_lag_disable_change(esw->dev);
 	mlx5_eswitch_disable_locked(esw);
 	esw->mode = MLX5_ESWITCH_LEGACY;
@@ -2110,8 +2112,9 @@ void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw)
 
 	esw_info(esw->dev, "cleanup\n");
 
-	mlx5_esw_qos_cleanup(esw);
+	atomic_inc(&esw->generation);
 	destroy_workqueue(esw->work_queue);
+	mlx5_esw_qos_cleanup(esw);
 	WARN_ON(refcount_read(&esw->qos.refcnt));
 	mutex_destroy(&esw->state_lock);
 	WARN_ON(!xa_empty(&esw->offloads.vhca_map));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 23af5a12dc07..988595e1b425 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3699,7 +3699,20 @@ static void esw_wq_handler(struct work_struct *work)
 	esw = host_work->esw;
 	devlink = priv_to_devlink(esw->dev);
 
-	devl_lock(devlink);
+	/* Check for stale work BEFORE acquiring devlink lock.
+	 * mlx5_eswitch_cleanup() increments the generation counter
+	 * before destroy_workqueue() while holding devlink lock,
+	 * so acquiring devlink lock here would deadlock.
+	 */
+	for (;;) {
+		if (host_work->work_gen != atomic_read(&esw->generation))
+			goto free;
+
+		if (devl_trylock(devlink))
+			break;
+
+		cond_resched();
+	}
 
 	/* Stale work from one or more mode changes ago. Bail out. */
 	if (host_work->work_gen != atomic_read(&esw->generation))
@@ -3709,6 +3722,7 @@ static void esw_wq_handler(struct work_struct *work)
 
 unlock:
 	devl_unlock(devlink);
+free:
 	kfree(host_work);
 }
 
@@ -4161,6 +4175,8 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 		goto skip;
 	}
 
+	atomic_inc(&esw->generation);
+
 	if (mlx5_mode == MLX5_ESWITCH_LEGACY)
 		esw->dev->priv.flags |= MLX5_PRIV_FLAGS_SWITCH_LEGACY;
 	if (mlx5_mode == MLX5_ESWITCH_OFFLOADS)
-- 
2.44.0


