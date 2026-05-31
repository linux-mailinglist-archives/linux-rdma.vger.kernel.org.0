Return-Path: <linux-rdma+bounces-21546-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBjgA1weHGr0JwkAu9opvQ
	(envelope-from <linux-rdma+bounces-21546-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:41:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 07854615CDD
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D6B43008618
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 11:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE3A38422A;
	Sun, 31 May 2026 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TRcGb0oU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5891B3845D5;
	Sun, 31 May 2026 11:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780227637; cv=fail; b=fNNhrrw5QZzegC0I4/TpTpnhjpKmslnmDGlfqMMBJwP604FLegMgrE4OJpeTfppwz9hzOv56qaesXLOpaJHiHEIhTVpDLjMLUK5jNjAtLVZj25JmXuYK0v/2IXcUKsfhiDfcDAoAk0Ns5h0+SPT8YEI5oQTkeWJenAV55YHITdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780227637; c=relaxed/simple;
	bh=VwCN/gTvDkGz4QK7ZevNf8NadOVWhmAlMfhhqNhnEqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHD86n38+2HnYDHSPFdkyT5at6RZaqBCj1I6VGPjjYUwM7JdAcHemMebHQaBmyQfeohx4H1GQg2KuN3dCRj60VFw5tRDtln8ZAw+N1Ao3P1OLhxcyT2N9lE4GlYQTvvDKWpyFEMEAWlC7hailoDPAoXuNMOy9JXOUUfITfKLyjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TRcGb0oU; arc=fail smtp.client-ip=52.101.85.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0BPFYcnaxGYUoc4FSSSaptnZt+HbqVALYQNYZcdMfzzESWoq1GwZkB6muZjqvN2Uh5a7lGlXBV9c8AQshzKmnkMT5QmsQOS08Poy8rguOe5RY9GFnSxfrgwlY/II/K1bH7tVFMYtJXWwVjdFBtkYX7CLWTu4DjSvgaTLhCIP871fFnHjOCWAAVbvqOo4j83/yZJfGOPFqzXxATIUqe3UTSsjSLVRBS6aS7LZjQeNXzFzQScSifW1FxQcEJYriab9bW72EkINN4GB/ZlNS5i3bjRZitGEpgjnB+uSGurkPmV38v/djrmflECmXoRUQ8hXb6hVLlvff9ji6OtTmgFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7BppHUEN3cLSj6DuQJcoY/ZC7Gqf88Jhcd/53s5NLo=;
 b=Yqq3XXifk/CFQlran2Ef1jBA1xwvB8dytkPwOsldhcHi+98aVKKj33i1ay8U+FlL/K3CQ+lPvvAR8lQt6Ilr/2tLX9J2YbvIp1S41OUJpQ3R6G6cy7vg/RAvN59LW8AGZmYDFDDlOQpZCw4tufo0iuizqsiFJrDulesICuptY0FnziKWFLXTcuJC6E05JzY7AZ5rpOQ9v7aQTnmqOfzbv26svSGWL5vXvAeo0ABVvtkv4czA4VHm3JLnN1wS8LkdfY7YHtpcBbtiwsbvYuLOb9yPtRoXuyPUhEMtFuq0YAXYFT6lBQ4fK6kpcDxzT+PeJKTv0rB/FNYS4Zea3hQ1Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7BppHUEN3cLSj6DuQJcoY/ZC7Gqf88Jhcd/53s5NLo=;
 b=TRcGb0oU94CFT+lk+gol788Kcr/h5qXyuD4KfrSm9r5GgaXrWJWLaqGTF7A3oQ+efhX59BzH42A+Qfm67PeVf4m4OMJkN8++GfNeXw1GGmkTw4lKgYbUnDvAbEWgWNl/qOXm5tNkx3lXPOWOg5FF8DJZoJiy9ZNFDOs/nr+YL51Y0gUFzJckpVw83t7c0NA0RrU1JT7voIImANHilS+7wIME5nS8+gvWv4TYdBtwJZy54hEvJbdt0Yk02Hf8gYbKuTPgWBbGmXd0KNO49YUC6teu8zOGPjxF3/NIDEjniv6xcoQvuS8gqMuvln2ewPP0O6+C9+B5mRWINFPs1KPj7w==
Received: from MN0P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::24)
 by IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Sun, 31 May
 2026 11:40:28 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::59) by MN0P222CA0015.outlook.office365.com
 (2603:10b6:208:531::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Sun, 31
 May 2026 11:40:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sun, 31 May 2026 11:40:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 31 May
 2026 04:40:09 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 31 May 2026 04:40:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 31 May 2026 04:40:03 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>
Subject: [PATCH net-next V2 01/13] net/mlx5: LAG, factor out shared FDB code into dedicated file
Date: Sun, 31 May 2026 14:39:41 +0300
Message-ID: <20260531113954.395443-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260531113954.395443-1-tariqt@nvidia.com>
References: <20260531113954.395443-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: bc1d7607-24d8-4824-e94d-08debf0969e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700016|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ReHqfuvz3N6l0shg3nBnfwmTj+w0VmdxribBrdS01cqo0Wd1GzZUEckL9olsq6R7i4+KcJa8nUhtgoVUtgVr8AUc4OUXKVGjmB29dcHL0XqodKcbz8TsrFZxtOZsKPOm9MI+xu7mcbr9Txz+hN00VvR10nwfD46rBUzt4M4VA6+QttCuoF2bfueT6Tiagm/Ju9BCWa6cNF1HGXjb1dURFNrdVKcO98CZcbpNDctlCg8rJtJyZgDBd/9hQpneUEREpif6MjnOXfj4/t7+jJcjkYtCxq3++x9bWnAisdtfNoxWFSD/DxtNXA4vDh1e8XJVnunbJoo/XENpRKkvg1i4KQdw3dB0ZFH0X38tase2BEGbHXj06yFEetZT1LVKwgdsfQCn++uExo5H9s+ZqVfs7LjJRoNSH5TGu8w1dQnU+meUDcf2CWhbYgVLkCf5Ro084MGe+O/8Nx3lGI6Z/gCHZQsjL7wWWcfdfuKgsWw6aSke0krDwp98Ms7r26FUszWeeAUbebK0eUlwU3DScoVjtAPLVjn+pE4j30G5wMcnhnXbvENbL5Szolo0H4/V9J94ZQDpxIcxmttDZ5q9gk2rvtDlXRPIj42H+mU/RJFlZvfT5TzIYYxycH0Hmuf7b+2hxze4wWcEdvbPbKgkCLhKkLzsmllIyVXJ9E8Q1eLQvG3EsAXnoGxLJ1VtxIjLtCif/8V0ACt1+ZwoeSaPu1rFgjBQT8FkX8Ykps8eRjgJFng=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700016)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d3KYoJ9vYOijFopkvuQVvSyDPnWWxZ1gAeW58Z1H2q09xtm11ibZc87ZiaXlcejxC35Nvekoc3qX5eWfKamxKGO+DVkWrlmG6aC1uiiAy/UYcmi124gSTgqm1FS+SlvfoF7KpuPAoOazHUyGfMosGtNi+9Zwrq+Gl/gmXUGfvZCpe0c5aXYHY0pQ6HcYeHDrogo8NtwKk2cC9A4B82IMYH4xyS5Mp1h78f6s7Nooc/ShM4BlCdu3ULn4GxtJiwffTPuinHMpXGOiHrUoKO4RtzNdraQfqChsIoLoQK8SLNM6XTLMAryXTxnhE1Oyb5MEAX8JVMYOfepIe/5qLiSiaantdkqU/MpEZq7NubImpMQw5h9oD7pIow+W+Rla7hIDxQ5BP+oK4WPY3rpLlRtA1jVLqw4BuCkUZ1rIDnWmJ6XbE/cKneQoaSYQdoHB5ciQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 11:40:28.3267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1d7607-24d8-4824-e94d-08debf0969e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21546-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 07854615CDD
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


