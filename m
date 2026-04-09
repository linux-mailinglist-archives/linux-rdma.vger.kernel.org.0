Return-Path: <linux-rdma+bounces-19152-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIvIGJCV12mGPwgAu9opvQ
	(envelope-from <linux-rdma+bounces-19152-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 14:03:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F13F63CA08E
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 14:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8442030B7FD0
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 11:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9843C3BEE;
	Thu,  9 Apr 2026 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HWX+mOJ0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011039.outbound.protection.outlook.com [40.93.194.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146DB3C344D;
	Thu,  9 Apr 2026 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735828; cv=fail; b=dtS6PSOQ3HAyhGhsFrFwMJP95O+K5zTgqtj5/72UBKrzV8HkI+7DMmY/clm2PzDQVnHbYTmDOlE3DEXCtaxcUBahbbvKv5APhPtj7zXinFd/aFOqQrobxZXoBxlOSi0sJ078R379m+3PJfHiTSgW9g2k/3NGorO1omxaptIMjig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735828; c=relaxed/simple;
	bh=FeBegYHgxC6g+9IP5tP2bIci31VFVeMh73B4SPPxolI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKR4YzX94cdJLPbAuyojXLPFd5/8bJxHrVAWRMUBsB578YhXVIFEoDgp2VaD/D61wEkZCsnnewCCkvWTwfh0gvbtxlUDuvd4CgjToWxSaeQ2RsK9KNNrud1cR5E/guLdLClDClKG7pDDSrfBpNhKd1OGhR6WgcCBHBxuycqCzkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HWX+mOJ0; arc=fail smtp.client-ip=40.93.194.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rl+XNTc4IL+TxiIY9ymmF0rysxVBvNxSG+X1Eb4AVep1/G64Bzu+5yquLVerqWOMCiMKJR8akxwTiDjeDFvn6mAxe/rMAbvHbs+Iy6xsa3BHsqKlE9aA+Py3MOy0za0DH8uRM9q4TqbVojQISk6w9pPxQnAvhNr/SX61wEg2d7V4hC0i4MEIseVivTtOpLCAQjec8ZJJhqFAgtrHH0QD2jo7Xk4+Az7N42z+G5bU6T60FGEjh8MTR0k+gUP3RYu+biz3Dnw1HIw4ChCmmVDucpffn56wapA/HTdEKPAToujr0i/IeOUHdCeZ/iQt5AhTx8ZGulhBIjJTGeSzVwxSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIVcmXoATeaL70Wf+2FAe7lz8UQh7lDareZCkJH7G1c=;
 b=oz3UzFoJTC8SqhNxiZmBTbolmURXVcevQyjU8tOvspDxXErs3+pqJszx1d5PoGJ+i9YVxQLpgSjMqQBSt1rdE46WqIROr9Y9cGpBEtA3Hy1Yk4Ql3Kk0RvGmEMLhj/k16cQJ9CW3WmcPmqtt2EMBY+hkJ/XmujS7/thEuOUwvL0m6lX2cl3RgibyeUgIyCA4IatpQ8n9hRZZ+IJnk+ybfzZOjn+Reb9P/reiInJU2YG6ucecUDuy0hKbiBPUA/EQgiXXHbfEP6KYqOUPY7v1LJc1SDvPLYkalg4jr3rbuF9enZtCMXzyvXKNzjCQICSg8Pi1r+zOn7Ef8/M2ZedRkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIVcmXoATeaL70Wf+2FAe7lz8UQh7lDareZCkJH7G1c=;
 b=HWX+mOJ0l15P2eASGlIRgz/H3do/kBvFmDZrGKifJISzSJcud8zB2b2JUtDDcKVswy/bFjwDtPUEmKNkY211MJZG5zeXjdBS0f0bS97fouNa6DjRgTzhTaUF+fmaHsMeclonsgAp89PyW1Jr5eaqtFSk17a51uhq5WiWS2Itjwfl1iTswynrYAl7g/oYPL+JVcTKtFQWEAleB6vMJNZlnr01A3PThcExUFrNbmu4CD/bHaCjdjWjDrcPVjctaVycj13Mlez6emVSZv30+KHz15ihd1Lr+E5yEuDHTLO4L2RwanjTLQuM8HJlm1HgWBuV3IiNSTf4ZFqLUKjC8JkEGg==
Received: from CH3P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::14)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.20; Thu, 9 Apr 2026 11:56:59 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::a0) by CH3P220CA0025.outlook.office365.com
 (2603:10b6:610:1e8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.40 via Frontend Transport; Thu,
 9 Apr 2026 11:56:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 11:56:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 04:56:41 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 9 Apr 2026 04:56:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 04:56:35 -0700
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
Subject: [PATCH net-next 2/7] net/mlx5: E-Switch, move work queue generation counter
Date: Thu, 9 Apr 2026 14:55:45 +0300
Message-ID: <20260409115550.156419-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: d897aa55-fde3-4254-d274-08de962f1ad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AJSyCSpAuAxUPgWU5HED8P1zyq61JlmQUReQsT0HpYEwOXVlE1uRLuVN9PGEq6N/Noy33ZDSn8jjZQbsxRgtzuxlJZ5NSwffzPJXBFRlrxn+kJ4tkunvLdtfFXS71jTmQ4bY12ICQFe0e4r0BZNHgSDcZJ6AGurTOQTpVHf8z4hJ0LECCbY4Sw+zAKObwOCWtHBEynTrbmm5GZasscbNoH7B8WaYOr6k/DIBwuPlAT/0f51B9PNxc0AF18dobWN35672ZuBgMcXj3cLHo3xlNeRpwX3D/pYCPYrT7J7LB82LMh/0IBb8LgyLb/FgKbTL6iaTOINlpjQB/Osx5swUrRzaIuG/KB0TsWCITqMSA5+0Sx4LmxptwZrima8/cq2wn+uGbipebElkEJux0aXoQpRP0o7YdGDHM2sku2M2hKSv7RK5kY5JGgG8PfHLnq42b9uoWrzCIPa3eg6nwlRdO3Z8VD0O59r8UtPzOHsTY/fo2pH9lM3RXlqrh6M96kBxA7rsmMLWz4zzhF1e6XEdfAEnU9zGle+/kmwIqbMgq1+yVxG5exG4RxyfS1awYgf/qIAbStlXOax/4uAsFt2iNTBBKGvTluVl+kZJ5MexzzNApWXepahdkrM/QMiqFZPzDdZw+TJIx++aYncZO+pi+9v6OvFNgoPIeYbm4A28Pp9oYnSd6alvs+9RloWoput1gy4y0XFNE1I6AtU+894BOaQUFix1Dbw3CQEJeXAF1nl5Jz+aW7kFknyqE20tvCELlDxnLSE4z3regCYWGlBmKw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qBDVQxxANm7hmWfbIu6EcAmpYbe+LaFFWTPTRKTAy8jZzPnYmMA7aKQjZ8CjqbIHGJbw9ysMFAevs7ZCNhf2Llhp0tL70bI6IormzVHTexvNiwRheExnHeDdoCi7wUx3oeAw11/qNk5ZEQp/WfhuNlgot2rLwWLdodTwRjFBgenzwcgcjUGNszRIfoJTYqRrdl1iIR9f87btavVRHCRg4YYVpWNB+11k13HweeKeiNFMlZdssWLWuVRUQuZx+LHFOcrEA4NRXm1lT5t+dHufCJDTSHzSsnKc+rmyWwT8mpP+UMrIJF3vS5k6Mtwl8rDI+wau6QV3rFlG3PSo2e309rOg48rMZ/R/JcNrwwFMc3Bz0BArSYrpgrxumnafNuTgA9Gl92EYnSwgULUy/tbgRK+P5CagtN+piIe/TvMOmxhu9JlbnheMV7O31Vz84fXm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 11:56:58.9579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d897aa55-fde3-4254-d274-08de962f1ad7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19152-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: F13F63CA08E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mark Bloch <mbloch@nvidia.com>

The generation counter in mlx5_esw_functions is used to detect stale
work items on the E-Switch work queue. Move it from mlx5_esw_functions
to the top-level mlx5_eswitch struct so it can guard all work types,
not just function-change events.

This is a mechanical refactor: no behavioral change.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c          | 3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h          | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 123c96716a54..1986d4d0e886 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1075,7 +1075,7 @@ static void mlx5_eswitch_event_handler_unregister(struct mlx5_eswitch *esw)
 	if (esw->mode == MLX5_ESWITCH_OFFLOADS &&
 	    mlx5_eswitch_is_funcs_handler(esw->dev)) {
 		mlx5_eq_notifier_unregister(esw->dev, &esw->esw_funcs.nb);
-		atomic_inc(&esw->esw_funcs.generation);
+		atomic_inc(&esw->generation);
 	}
 }
 
@@ -2072,6 +2072,7 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 	mutex_init(&esw->state_lock);
 	init_rwsem(&esw->mode_lock);
 	refcount_set(&esw->qos.refcnt, 0);
+	atomic_set(&esw->generation, 0);
 
 	esw->enabled_vports = 0;
 	esw->offloads.inline_mode = MLX5_INLINE_MODE_NONE;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 5128f5020dae..0c3d2bdebf8c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -340,7 +340,6 @@ struct mlx5_host_work {
 
 struct mlx5_esw_functions {
 	struct mlx5_nb		nb;
-	atomic_t		generation;
 	bool			host_funcs_disabled;
 	u16			num_vfs;
 	u16			num_ec_vfs;
@@ -410,6 +409,7 @@ struct mlx5_eswitch {
 	struct mlx5_devcom_comp_dev *devcom;
 	u16 enabled_ipsec_vf_count;
 	bool eswitch_operation_in_progress;
+	atomic_t generation;
 };
 
 void esw_offloads_disable(struct mlx5_eswitch *esw);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index a078d06f4567..b2e7294d3a5c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3667,7 +3667,7 @@ esw_vfs_changed_event_handler(struct mlx5_eswitch *esw, int work_gen,
 	devl_lock(devlink);
 
 	/* Stale work from one or more mode changes ago. Bail out. */
-	if (work_gen != atomic_read(&esw->esw_funcs.generation))
+	if (work_gen != atomic_read(&esw->generation))
 		goto unlock;
 
 	new_num_vfs = MLX5_GET(query_esw_functions_out, out,
@@ -3729,7 +3729,7 @@ int mlx5_esw_funcs_changed_handler(struct notifier_block *nb, unsigned long type
 	esw = container_of(esw_funcs, struct mlx5_eswitch, esw_funcs);
 
 	host_work->esw = esw;
-	host_work->work_gen = atomic_read(&esw_funcs->generation);
+	host_work->work_gen = atomic_read(&esw->generation);
 
 	INIT_WORK(&host_work->work, esw_functions_changed_event_handler);
 	queue_work(esw->work_queue, &host_work->work);
-- 
2.44.0


