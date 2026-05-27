Return-Path: <linux-rdma+bounces-21353-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJp2JqrrFmruvgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21353-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:03:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 175D95E48EF
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6335308A700
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 12:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8859D3E92B6;
	Wed, 27 May 2026 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RjZtS8Y7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD9A2F531F;
	Wed, 27 May 2026 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886543; cv=fail; b=AinZqK6zzKWUU0lsFCzSpsNUMlAYgtDFDUv0AfSl20VfJwtJLWellNPbbgECLaiku3c7M9BW0W4e1knVfYAD/aXasNuk4zHmTANXD/fCOuxpGcM4ZU6p7pyzyQaorhf13tccpX1oyg6ybATHoqhHGO18p+15BRjLlVy76Op4Oe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886543; c=relaxed/simple;
	bh=VwCN/gTvDkGz4QK7ZevNf8NadOVWhmAlMfhhqNhnEqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcHMAX8vq0pm6Zi2Ck0S/RdRgBVEmCCVMqYhGQP1UqcPEuQMmd08EwEXRhtjykNMVqAlChLsRM0v35twt+7k77p7pRdagRaBpgU2b+4pDiDAejUsLbT8TauoVck6IwP7KJipLpJ5eB6R2i/53r2xQ92TpMbuvObnoGJXZ264tQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RjZtS8Y7; arc=fail smtp.client-ip=52.101.46.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUGwliDZDQfRd98nieEyf0WkytfrSPnGNHGk09hqzHpef2QWp2PQxB2R+j8MAmxCR9eTLsFc1aCAai+jehFFRL2kwRf7FHHC0540mD1PyZOBOfM60lFyq0dyVddUcbMGYrWfYjBgLprH2RjeuQDjRReF8W07134xIVF97ffj2O1xb3Z3C+uH3kFCDAA17fL+++rwXnr2s9i1mFeZf5MQhGLb5JNl5aNSPLwDLKDthlME5QVoEFtyzCUfeh0+KCljoKj5dcCrthHnNJZKRl7uGsBMR6zzYgyxBNYFncVL+duP1rHsIwTP9+KqMF34v7ljI5qAITyVQOQNkErmMEwTBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7BppHUEN3cLSj6DuQJcoY/ZC7Gqf88Jhcd/53s5NLo=;
 b=cVBHfAm6OzShroDqseCUyGZZ8RYC+p7Qavt7p2Ki80iOyREbCxz1YsrPlS2p1OEIkSOY8wVTzejZOaqmXqvw2Ex5xOYxQjhSveoJQvL4/9rf+VMIqRMSh3ZOoY/dsys63hMu++FyR11uTuuPm6IXbSUsEPPuwch1Fok16O6i/WiTkZxDv8gDF5p2QZRmAXxVJTg+0TZWGOVXokRBzBn3eoGDNgdyZc5cfg2fJyKB9H1mwn8iATuTuWHuU57fQi9U2U2sKvaWSezmAnSkLM2hbXojTAot8Q+uM1MjAr8J6pCCoBUjYRiVqyOJbovIz/xQ+byGfm66EtEcwusJuKbF0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7BppHUEN3cLSj6DuQJcoY/ZC7Gqf88Jhcd/53s5NLo=;
 b=RjZtS8Y7snmu+odSRBeWqnmfUa7ew5qzKteMvvATikYVlyyyKVVSRwbuiKsr2LTRxSnX9zyTuRzkA6jDPvyIbvdhaDq5Twf6iINaSir64ccwZg/fKb+TAeSKgXkF/Ko096Y2V687RQFTqjhnfxS9YpfQMuaj98By+elcyKZRrMCrbCMFRXSMdSRIVczTjAKE9scyOtNPjAMH6zso0sUplZh2mqoSF317vhsv/Kq3fU5hS6t53CRWh/F+fkR3utyl7zJyipbziso8VlB6EFcf4fgMC+Y9eNrMHUaXZ/MY29sAe6OwAB1KFwgUbnm5gm7PyuS3/EZzYwgLiJq6djtkrw==
Received: from MW4PR04CA0268.namprd04.prod.outlook.com (2603:10b6:303:88::33)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 12:55:32 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::ae) by MW4PR04CA0268.outlook.office365.com
 (2603:10b6:303:88::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 12:55:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 12:55:31 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 05:55:11 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 27 May 2026 05:55:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 27 May 2026 05:55:05 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Kees Cook <kees@kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 01/13] net/mlx5: LAG, factor out shared FDB code into dedicated file
Date: Wed, 27 May 2026 15:54:15 +0300
Message-ID: <20260527125427.385976-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260527125427.385976-1-tariqt@nvidia.com>
References: <20260527125427.385976-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: dbf998f6-6bf7-4df8-9a37-08debbef3c0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	2Bu/uXy16yvGmBITw1I6Rz9yVv05bo8whtu5RSOW+6DKBm5TYkSo0uwcThQ/jJdemxxvYqzZi/rOpCGeEvvwLQ8r+CbjzztB/0SDDoFgmWoouL0k5nHcffT60V0eE0DRLT63qs/zlC0wKKo+BR23czm0V510tfSxa6elmErHXYtuQaY0X8YyKcV2tpvnPpB44bNHPrDf5h/scY0pI/A+knLpTg9GNX4krxCKlwdZEZMY/7cTueJzzBe21MV/qG1EmqSIOWfnmnwPgQ7ThCW1KEwuhxiFyxpoNBR599WG5syOhaeK+mBW05PdAT77kG5p+xj4kp6P1E7mhBa6bIU6+/Bsheoe1rIEehoQXydA6kb/C96teNoBO8KuSzt5QPNWbWignVXZaeDcPmaGPATyhVPOXTK7y0pxQFX/9ExjS4S8C3h2/68a1xezmhDN8UAn9j2mo+XhAS0eS1ntG29CQ55tkgYVrMAdYyRNefXvTcnYNkwyDPu0BHyW+bHj+VbN6k6btOI8QBm3lcbKmyCvGFeC8ZyjJnqxatmGmxKN+6Hsj9LuuX00xyJe4PtA2bsFtTfnl/p61bZPZe8o4SjqRXnEZO1DpaNww7gs/6gPFgCsmhRK4IL1wN5yyP24lqPYfwCJVodKUMStu807nQS3TGpqJ7yqiW2uFmSWXIxPRd2SLkSEOsPZdUl+TBnk4sFcZuXUKrzQNXapgrlq3s+61CXWoOwzDJl8qho+2U6BL7s=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n06U1SL58Lm3M2cMejOr8va2Gi1vQAhTNtDi7BpmaMwo4Sh9pXcXJakiI/kzenxrizMugq9NIeyAWS6RMbDJ1LJk50V8Usnrhq1ihUH8S6pA818styqeJVwv97D4g+BO9/EA9k7fDh7kzB5bmfooj85nDl7gI4xd/RH/2l9HuTjnmelKy3ujcxU4o/sAB86o+BA4MG6611IHgpfU/PER5IHFWv03bd0dDCgY7lU1n3jgp57iw0f0WYl7KJdjHEbK28toEJ85siai6lMnRMgaMvJtolOje716Ad8AOuENC0N22BtSjNTAaxo7kmrX2PM3TT9pcPtJg+jCgCU3PldJSaZbIgCuoc4xucVRIy2bJjagQoTRygkb6RlkqQRtN8JcI6hJQZF5ByrT6ZuO/71xOBZ1zf2kzZkt+DTjuWUXGJcO/JPXedMgkxuDhyW8ziwC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 12:55:31.1240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf998f6-6bf7-4df8-9a37-08debbef3c0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860
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
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21353-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 175D95E48EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

Refactor shared FDB LAG logic into a new lag/shared_fdb.c file to
improve code organization and enable reuse. Move shared FDB specific
functions from lag.c and introduce consolidated APIs:
- mlx5_lag_shared_fdb_create() handles LAG activation with shared FDB
- mlx5_lag_shared_fdb_destroy() handles LAG deactivation with shared FDB

Update mlx5_do_bond(), mlx5_disable_lag() and mpesw.c to use the new
APIs, which simplifies the shared FDB code paths.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 156 ++++--------------
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  26 +++
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  25 +--
 .../mellanox/mlx5/core/lag/shared_fdb.c       | 143 ++++++++++++++++
 5 files changed, 210 insertions(+), 142 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index d39fe9c4a87c..19e50f0d55af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -41,7 +41,7 @@ mlx5_core-$(CONFIG_MLX5_CORE_EN_DCB) += en_dcbnl.o en/port_buffer.o
 mlx5_core-$(CONFIG_PCI_HYPERV_INTERFACE) += en/hv_vhca_stats.o
 mlx5_core-$(CONFIG_MLX5_ESWITCH)     += lag/mp.o lag/port_sel.o lib/geneve.o lib/port_tun.o \
 					en_rep.o en/rep/bond.o en/mod_hdr.o \
-					en/mapping.o lag/mpesw.o
+					en/mapping.o lag/mpesw.o lag/shared_fdb.o
 mlx5_core-$(CONFIG_MLX5_CLS_ACT)     += en_tc.o en/rep/tc.o en/rep/neigh.o \
 					lib/fs_chains.o en/tc_tun.o \
 					esw/indir_table.o en/tc_tun_encap.o \
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 22b7efea34b8..5dfdd799828f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -817,43 +817,6 @@ char *mlx5_get_str_port_sel_mode(enum mlx5_lag_mode mode, unsigned long flags)
 	}
 }
 
-static int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev)
-{
-	int master_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
-	struct mlx5_eswitch *master_esw;
-	struct mlx5_core_dev *dev0;
-	int i, j;
-	int err;
-
-	if (master_idx < 0)
-		return -EINVAL;
-
-	dev0 = mlx5_lag_pf(ldev, master_idx)->dev;
-	master_esw = dev0->priv.eswitch;
-	mlx5_ldev_for_each(i, 0, ldev) {
-		struct mlx5_eswitch *slave_esw;
-
-		if (i == master_idx)
-			continue;
-
-		slave_esw = mlx5_lag_pf(ldev, i)->dev->priv.eswitch;
-
-		err = mlx5_eswitch_offloads_single_fdb_add_one(master_esw,
-							       slave_esw, ldev->ports);
-		if (err)
-			goto err;
-	}
-	return 0;
-err:
-	mlx5_ldev_for_each_reverse(j, i, 0, ldev) {
-		if (j == master_idx)
-			continue;
-		mlx5_eswitch_offloads_single_fdb_del_one(master_esw,
-							 mlx5_lag_pf(ldev, j)->dev->priv.eswitch);
-	}
-	return err;
-}
-
 static int mlx5_create_lag(struct mlx5_lag *ldev,
 			   struct lag_tracker *tracker,
 			   enum mlx5_lag_mode mode,
@@ -1218,12 +1181,15 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
 	if (idx < 0)
 		return;
 
+	if (shared_fdb) {
+		mlx5_lag_shared_fdb_destroy(ldev);
+		return;
+	}
+
 	dev0 = mlx5_lag_pf(ldev, idx)->dev;
 	roce_lag = __mlx5_lag_is_roce(ldev);
 
-	if (shared_fdb) {
-		mlx5_lag_remove_devices(ldev);
-	} else if (roce_lag) {
+	if (roce_lag) {
 		mlx5_lag_rescan_dev_locked(ldev, dev0, false);
 		mlx5_ldev_for_each(i, 0, ldev) {
 			if (i == idx)
@@ -1236,49 +1202,8 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
 	if (err)
 		return;
 
-	if (shared_fdb || roce_lag)
+	if (roce_lag)
 		mlx5_lag_add_devices(ldev);
-
-	if (shared_fdb)
-		mlx5_lag_reload_ib_reps_from_locked(ldev,
-						    MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV,
-						    true);
-}
-
-bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
-{
-	struct mlx5_core_dev *dev;
-	bool ret = false;
-	int idx;
-	int i;
-
-	idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
-	if (idx < 0)
-		return false;
-
-	mlx5_ldev_for_each(i, 0, ldev) {
-		if (i == idx)
-			continue;
-		dev = mlx5_lag_pf(ldev, i)->dev;
-		if (is_mdev_switchdev_mode(dev) &&
-		    mlx5_eswitch_vport_match_metadata_enabled(dev->priv.eswitch) &&
-		    MLX5_CAP_GEN(dev, lag_native_fdb_selection) &&
-		    MLX5_CAP_ESW(dev, root_ft_on_other_esw) &&
-		    mlx5_eswitch_get_npeers(dev->priv.eswitch) ==
-		    MLX5_CAP_GEN(dev, num_lag_ports) - 1)
-			continue;
-		return false;
-	}
-
-	dev = mlx5_lag_pf(ldev, idx)->dev;
-	if (is_mdev_switchdev_mode(dev) &&
-	    mlx5_eswitch_vport_match_metadata_enabled(dev->priv.eswitch) &&
-	    mlx5_esw_offloads_devcom_is_ready(dev->priv.eswitch) &&
-	    MLX5_CAP_ESW(dev, esw_shared_ingress_acl) &&
-	    mlx5_eswitch_get_npeers(dev->priv.eswitch) == MLX5_CAP_GEN(dev, num_lag_ports) - 1)
-		ret = true;
-
-	return ret;
 }
 
 static bool mlx5_lag_is_roce_lag(struct mlx5_lag *ldev)
@@ -1493,47 +1418,37 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 
 		roce_lag = mlx5_lag_is_roce_lag(ldev);
 
-		if (shared_fdb || roce_lag)
-			mlx5_lag_remove_devices(ldev);
-
-		err = mlx5_activate_lag(ldev, &tracker,
-					roce_lag ? MLX5_LAG_MODE_ROCE :
-						   MLX5_LAG_MODE_SRIOV,
-					shared_fdb);
-		if (err) {
-			if (shared_fdb || roce_lag)
-				mlx5_lag_add_devices(ldev);
-			if (shared_fdb)
-				mlx5_lag_reload_ib_reps_from_locked(ldev, 0,
-								    true);
-
-			return;
-		}
+		if (shared_fdb) {
+			err = mlx5_lag_shared_fdb_create(ldev, &tracker,
+							 MLX5_LAG_MODE_SRIOV);
+			if (err)
+				return;
+		} else {
+			if (roce_lag)
+				mlx5_lag_remove_devices(ldev);
 
-		if (roce_lag) {
-			struct mlx5_core_dev *dev;
-
-			mlx5_lag_rescan_dev_locked(ldev, dev0, true);
-			mlx5_ldev_for_each(i, 0, ldev) {
-				if (i == idx)
-					continue;
-				dev = mlx5_lag_pf(ldev, i)->dev;
-				if (mlx5_get_roce_state(dev))
-					mlx5_nic_vport_enable_roce(dev);
-			}
-		} else if (shared_fdb) {
-			mlx5_lag_rescan_dev_locked(ldev, dev0, true);
-			err = mlx5_lag_reload_ib_reps_from_locked(ldev, 0,
-								  false);
+			err = mlx5_activate_lag(ldev, &tracker,
+						roce_lag ? MLX5_LAG_MODE_ROCE :
+							   MLX5_LAG_MODE_SRIOV,
+						false);
 			if (err) {
-				mlx5_lag_rescan_dev_locked(ldev, dev0, false);
-				mlx5_deactivate_lag(ldev);
-				mlx5_lag_add_devices(ldev);
-				mlx5_lag_reload_ib_reps_from_locked(ldev, 0,
-								    true);
-				mlx5_core_err(dev0, "Failed to enable lag\n");
+				if (roce_lag)
+					mlx5_lag_add_devices(ldev);
 				return;
 			}
+
+			if (roce_lag) {
+				struct mlx5_core_dev *dev;
+
+				mlx5_lag_rescan_dev_locked(ldev, dev0, true);
+				mlx5_ldev_for_each(i, 0, ldev) {
+					if (i == idx)
+						continue;
+					dev = mlx5_lag_pf(ldev, i)->dev;
+					if (mlx5_get_roce_state(dev))
+						mlx5_nic_vport_enable_roce(dev);
+				}
+			}
 		}
 		if (tracker.tx_type == NETDEV_LAG_TX_TYPE_ACTIVEBACKUP) {
 			ndev = mlx5_lag_active_backup_get_netdev(dev0);
@@ -1545,7 +1460,8 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 						     ndev);
 			dev_put(ndev);
 		}
-		mlx5_lag_set_vports_agg_speed(ldev);
+		if (!shared_fdb)
+			mlx5_lag_set_vports_agg_speed(ldev);
 	} else if (mlx5_lag_should_modify_lag(ldev, do_bond)) {
 		mlx5_modify_lag(ldev, &tracker);
 		mlx5_lag_set_vports_agg_speed(ldev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index 6afe7707d076..23c0457ce799 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -137,7 +137,33 @@ mlx5_lag_is_ready(struct mlx5_lag *ldev)
 	return test_bit(MLX5_LAG_FLAG_NDEVS_READY, &ldev->state_flags);
 }
 
+#ifdef CONFIG_MLX5_ESWITCH
+int mlx5_lag_shared_fdb_create(struct mlx5_lag *ldev,
+			       struct lag_tracker *tracker,
+			       enum mlx5_lag_mode mode);
+void mlx5_lag_shared_fdb_destroy(struct mlx5_lag *ldev);
+int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev);
 bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev);
+#else
+static inline int mlx5_lag_shared_fdb_create(struct mlx5_lag *ldev,
+					     struct lag_tracker *tracker,
+					     enum mlx5_lag_mode mode)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void mlx5_lag_shared_fdb_destroy(struct mlx5_lag *ldev) {}
+
+static inline int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
+{
+	return false;
+}
+#endif
 bool mlx5_lag_check_prereq(struct mlx5_lag *ldev);
 int mlx5_lag_demux_init(struct mlx5_core_dev *dev,
 			struct mlx5_flow_table_attr *ft_attr);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index 8a349f8fd823..64e2d1dd5308 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
@@ -92,38 +92,21 @@ static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
 	if (err)
 		return err;
 
-	mlx5_lag_remove_devices(ldev);
-
-	err = mlx5_activate_lag(ldev, NULL, MLX5_LAG_MODE_MPESW, true);
+	err = mlx5_lag_shared_fdb_create(ldev, NULL, MLX5_LAG_MODE_MPESW);
 	if (err) {
 		mlx5_core_warn(dev0, "Failed to create LAG in MPESW mode (%d)\n", err);
-		goto err_add_devices;
+		mlx5_mpesw_metadata_cleanup(ldev);
+		return err;
 	}
 
-	mlx5_lag_rescan_dev_locked(ldev, dev0, true);
-	err = mlx5_lag_reload_ib_reps_from_locked(ldev, 0, false);
-	if (err)
-		goto err_rescan_drivers;
-
-	mlx5_lag_set_vports_agg_speed(ldev);
-
 	return 0;
-
-err_rescan_drivers:
-	mlx5_lag_rescan_dev_locked(ldev, dev0, false);
-	mlx5_deactivate_lag(ldev);
-err_add_devices:
-	mlx5_lag_add_devices(ldev);
-	mlx5_lag_reload_ib_reps_from_locked(ldev, 0, true);
-	mlx5_mpesw_metadata_cleanup(ldev);
-	return err;
 }
 
 void mlx5_lag_disable_mpesw(struct mlx5_lag *ldev)
 {
 	if (ldev->mode == MLX5_LAG_MODE_MPESW) {
 		mlx5_mpesw_metadata_cleanup(ldev);
-		mlx5_disable_lag(ldev);
+		mlx5_lag_shared_fdb_destroy(ldev);
 	}
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
new file mode 100644
index 000000000000..e5b8e9f1e6fd
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <linux/netdevice.h>
+#include <linux/mlx5/driver.h>
+#include <linux/mlx5/eswitch.h>
+#include "mlx5_core.h"
+#include "lag.h"
+#include "eswitch.h"
+
+bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
+{
+	struct mlx5_core_dev *dev;
+	bool ret = false;
+	int idx;
+	int i;
+
+	idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
+	if (idx < 0)
+		return false;
+
+	mlx5_ldev_for_each(i, 0, ldev) {
+		if (i == idx)
+			continue;
+		dev = mlx5_lag_pf(ldev, i)->dev;
+		if (is_mdev_switchdev_mode(dev) &&
+		    mlx5_eswitch_vport_match_metadata_enabled(dev->priv.eswitch) &&
+		    MLX5_CAP_GEN(dev, lag_native_fdb_selection) &&
+		    MLX5_CAP_ESW(dev, root_ft_on_other_esw) &&
+		    mlx5_eswitch_get_npeers(dev->priv.eswitch) ==
+		    MLX5_CAP_GEN(dev, num_lag_ports) - 1)
+			continue;
+		return false;
+	}
+
+	dev = mlx5_lag_pf(ldev, idx)->dev;
+	if (is_mdev_switchdev_mode(dev) &&
+	    mlx5_eswitch_vport_match_metadata_enabled(dev->priv.eswitch) &&
+	    mlx5_esw_offloads_devcom_is_ready(dev->priv.eswitch) &&
+	    MLX5_CAP_ESW(dev, esw_shared_ingress_acl) &&
+	    mlx5_eswitch_get_npeers(dev->priv.eswitch) ==
+	    MLX5_CAP_GEN(dev, num_lag_ports) - 1)
+		ret = true;
+
+	return ret;
+}
+
+int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev)
+{
+	int master_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
+	struct mlx5_eswitch *master_esw;
+	struct mlx5_core_dev *dev0;
+	int i, j;
+	int err;
+
+	if (master_idx < 0)
+		return -EINVAL;
+
+	dev0 = mlx5_lag_pf(ldev, master_idx)->dev;
+	master_esw = dev0->priv.eswitch;
+	mlx5_ldev_for_each(i, 0, ldev) {
+		struct mlx5_eswitch *slave_esw;
+
+		if (i == master_idx)
+			continue;
+
+		slave_esw = mlx5_lag_pf(ldev, i)->dev->priv.eswitch;
+
+		err = mlx5_eswitch_offloads_single_fdb_add_one(master_esw,
+							       slave_esw,
+							       ldev->ports);
+		if (err)
+			goto err;
+	}
+	return 0;
+err:
+	mlx5_ldev_for_each_reverse(j, i, 0, ldev) {
+		struct mlx5_eswitch *slave_esw;
+
+		if (j == master_idx)
+			continue;
+		slave_esw = mlx5_lag_pf(ldev, j)->dev->priv.eswitch;
+		mlx5_eswitch_offloads_single_fdb_del_one(master_esw, slave_esw);
+	}
+	return err;
+}
+
+int mlx5_lag_shared_fdb_create(struct mlx5_lag *ldev,
+			       struct lag_tracker *tracker,
+			       enum mlx5_lag_mode mode)
+{
+	int idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
+	struct mlx5_core_dev *dev0;
+	int err;
+
+	if (idx < 0)
+		return -EINVAL;
+
+	dev0 = mlx5_lag_pf(ldev, idx)->dev;
+
+	mlx5_lag_remove_devices(ldev);
+
+	err = mlx5_activate_lag(ldev, tracker, mode, true);
+	if (err) {
+		mlx5_core_warn(dev0, "Failed to create LAG in shared FDB mode (%d)\n",
+			       err);
+		goto err_add_devices;
+	}
+
+	mlx5_lag_rescan_dev_locked(ldev, dev0, true);
+	err = mlx5_lag_reload_ib_reps_from_locked(ldev, 0, false);
+	if (err) {
+		mlx5_core_err(dev0, "Failed to enable lag\n");
+		goto err_rescan_drivers;
+	}
+
+	mlx5_lag_set_vports_agg_speed(ldev);
+	return 0;
+
+err_rescan_drivers:
+	mlx5_lag_rescan_dev_locked(ldev, dev0, false);
+	mlx5_deactivate_lag(ldev);
+err_add_devices:
+	mlx5_lag_add_devices(ldev);
+	mlx5_lag_reload_ib_reps_from_locked(ldev, 0, true);
+	return err;
+}
+
+void mlx5_lag_shared_fdb_destroy(struct mlx5_lag *ldev)
+{
+	int err;
+
+	mlx5_lag_remove_devices(ldev);
+
+	err = mlx5_deactivate_lag(ldev);
+	if (err)
+		return;
+
+	mlx5_lag_add_devices(ldev);
+	mlx5_lag_reload_ib_reps_from_locked(ldev,
+					    MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV,
+					    true);
+}
-- 
2.44.0


