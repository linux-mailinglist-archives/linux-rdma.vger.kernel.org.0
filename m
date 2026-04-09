Return-Path: <linux-rdma+bounces-19155-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAPrD1CV12mGPwgAu9opvQ
	(envelope-from <linux-rdma+bounces-19155-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 14:02:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAB73CA045
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 14:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 836F63051B5B
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5413C73F6;
	Thu,  9 Apr 2026 11:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aDsmL2Ni"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012003.outbound.protection.outlook.com [40.93.195.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6603C73DD;
	Thu,  9 Apr 2026 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735838; cv=fail; b=ChOw86RQdlXLdeRjsqNR3BFC/W7imZpXI/Xn7BLDz88zErnANc7pIDzLZZW2FcyJmeoxJg+EfENVOWJAi5BQIvuCOQiYrm2ozuc+ZJAAcvc550TAOF5o6GxnmCkdwheDDroNBdrYe7S+hyd3JIfXN08Zo1S8D+bR+6N/HNW0bsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735838; c=relaxed/simple;
	bh=fGNIVLbZKOjQBw6T3kOAF1PQhsK6x5y2820+vv5akmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCsGWi/tBbqy2VN6ks7OPTWlPvFb92a0uIktt9B2Xuq6CQH8NvjnDcpJaXmZ9wuQeN/dYEiml7V1qAuM2eeMpaQ7D0pHQVe3NkB2jCV1FBol/4tVprnIs12lV/uxsCY7Je4cGpvbk5OSuSTc2iyqC4+xOgTj3WGChl7ZAy3/VmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aDsmL2Ni; arc=fail smtp.client-ip=40.93.195.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lno+wXynsDJ5UmfeFtlVAT5g0J0dYxNbZfkWZuPsxU9CmG6A+UoFirdcMQN/GfGZbr1SFLJyYgBL5hQP9OnO1IXB/4RCCcAfFSIO31CaWfzWHI3JlidNaJAPu+dL6gf/DaYRiuKoLqzJRmEZ5stuSnnGpwFCb88Kpse5ai0B1vRGTXHYpKETOyD/P2XolRfidGyGJJ12tktionHns87hevtZ7wNsSQkGVzUrmi2sUmaeVsd7aM5GzqoTcczGIGyxsgO263TEhCSdEXd0w62BK1PUzV91scBefEd7zqFkTH4zNTPo6E+6HUjNk7CPd9p/V0uR62wB+mdBwIEPRXNHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojIbns5BG2sltdz/YvTc8/KH6gDrHpw3HUi8mfnSQN4=;
 b=PiUX0JP1aBWCvcsOSclA/mBYG6ADPU60je1Vj4ZQvDGRtKBBuW0LH7vKhkBYVAmNuw2QFLF8QcW35VwYlqEx/BL0wkLtVR6EMuObQKsCyGdGHRRjA7T2/XDlCx4T580/Lc6ePipD1r6f+7zt+3X78gvWq1Jenfw19UxF36sYU/eJdcE/X3BZCczb/0tUDvWP1Sutg0UnVe2XtQc0mcX6yJeUIfVSWCDT3JraRlVMfGJXjqi7UN/R7f7lCFMAsbw2vxdUNljnZHC75kRoFi5EnaRFyb819jJ5K6MUdZ2SVjlak1M/QmVI4TWWrNIZmR5xoPRTM2+fq4dkI/84Vyw9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojIbns5BG2sltdz/YvTc8/KH6gDrHpw3HUi8mfnSQN4=;
 b=aDsmL2NiwdQmoalaNo+wvjwDVbwOK+16S9dgjelzuwrHtGHa2rBGeFtAu3q1OMh2hfvcj87BQs0m98XbL925+uz4CkoodJsMmHbaD/yMOz9d/R0kgw/23GTjnmNAWpTg4Qdc1b4UeEyX/jXU0Hw5g1MQ1kW1vdFPiiqSHTzfA4fujT11hjE/8DBaArBvfGdMbDSsGvQhAFVHkHpuc3NEKgWobZycjO/wsTHrm+11neiiTfRsVdKeJKaB7TkqVWSthVivtYdyqnXqbINrypVf+90rPa/h/s9Rm3m2SNl2wUq/0PyZRlpNvetuzPudbsMtNrXdh1VNhFqIcanspIp75A==
Received: from BY5PR17CA0008.namprd17.prod.outlook.com (2603:10b6:a03:1b8::21)
 by SJ2PR12MB7824.namprd12.prod.outlook.com (2603:10b6:a03:4c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 11:57:10 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::88) by BY5PR17CA0008.outlook.office365.com
 (2603:10b6:a03:1b8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 11:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 11:57:10 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 04:57:00 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 9 Apr 2026 04:56:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 04:56:54 -0700
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
Subject: [PATCH net-next 5/7] net/mlx5: E-Switch, block representors during reconfiguration
Date: Thu, 9 Apr 2026 14:55:48 +0300
Message-ID: <20260409115550.156419-6-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|SJ2PR12MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 7416c3d3-5277-41b5-0b43-08de962f2191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	2/vxrjPhOxba1XM/Cllxzl6eFnJF9LTGurv44TP8ShtOPI+uKynXWquvK9SNit63s4JfI3BA9+loPkdN3Daxdm+vV53DerJ4+ApwwRYNQm7fG1BRkh3fWCSyyt4YAsPP9Rbt1nHFUSsv0yvA8LhMguf7cVfHpX1NNZfcFWBabW+iL6JDIpcdl18ueGdVONg9mJhPznT4Q3vl92GNzfE6LieU/GAXEiGQGcuPDkBopIdSOcbGtrTABEkDvkCr+8liCzVwPFT4h7TVZAS/2weVb7J2/uDAGR1PCbzdACIV4ORPVC1oNLDghTeZ/11ZUPkx3Wyh5vfkyrO9O3yFIUYf4xYNJr+hdFAYW1s3zuHKzzkKxshyfA52+vbxKm6drKewTr4cyraJ1aYIwXHNq3BjpesQHwhqC91Bjs+6mAuvLJl05e878jIDP6ZQQ/AYzo6YK3u986kCHOgn1xV7cIPynrU7IE6WVKGLfy9ebkW4hK9BxSYsS2kBac0lsmZ3NWgNX3kiu7VSzMnoOadPG7ZzqKcQR3UdBF7Bu6OSJCPcqc4xZGKKR523VMCZlH/9lJQBx81f/VabY2wLjLRui2xUy8Uzql5J9JsEf04YSGIEIXk/TT3ulaW3UcOmFweOnJ9YNuRBe6Q4zz1mhRJtECpyG4glDfO9LfhVAlNm28H7WHoblKckSvzRbx7AQMOcE7J15h3ElXDGmR5tyzuBQ993Z3gg6pBBRxW4lp52kipyTHso5Am4f4Q9WXbSaVKWO7frO4TtFe7Txd910x4hSXx/nA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mv5M7c5DcI9zuFUkSmQoPu8GJt9FKsuYR1kKmYfCYUCB1RYOn2UnTNSP7KIZgwf2Z4BQIyUFsaUsGaKco1ElhPXQ/gsRKMN94Ei0Se6HoIzrfE3ePIc1b4BQgSaS7NSyi7pAZea6UHiJsZBguyO3srXpjBL3EErHFMhAIs/THGvaDV2UobM5aLqcebAVVsyW3ZyPNEkwVzJ1yjihQ32J1IJKi23k7yz1lwkCkDycfUBunVxveWZlphsfBUKyntY8xRBrsDiycZJkGV7HhOPBiywsRc3bhm+1/c0fr5hxv7jyUZ3ViUls4LRKg3CZwZ5ubORnDFoCl4cq+p/PNg+aBH1OxtKZADTds4yuitJkSw2mbTvym0NK1dKEjo0VzRFM4P1lJUEo3l4oHp0nzE36ukrEeukW6I5ZKYHx61uvUl8GkAlzK0SKifQMGfMsGA1V
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 11:57:10.3753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7416c3d3-5277-41b5-0b43-08de962f2191
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7824
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
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19155-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3FAB73CA045
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mark Bloch <mbloch@nvidia.com>

Introduce a simple atomic block state via mlx5_esw_reps_block() and
mlx5_esw_reps_unblock(). Internally, mlx5_esw_mark_reps() spins a
cmpxchg between the UNBLOCKED and BLOCKED states. All E-Switch
reconfiguration paths (mode set, enable, disable, VF/SF add/del, LAG
reload) now bracket their work with this guard so representor changes
won't race with the ongoing E-Switch update, yet we remain
non-blocking and avoid new locks.

A spinlock is out because the protected work can sleep (RDMA ops,
devcom, netdev callbacks). A mutex won't work either: esw_mode_change()
has to drop the guard mid-flight so mlx5_rescan_drivers_locked() can
reload mlx5_ib, which calls back into mlx5_eswitch_register_vport_reps()
on the same thread. Beyond that, any real lock would create an ABBA
cycle: the LAG side holds the LAG lock when it calls reps_block(), and
the mlx5_ib side holds RDMA locks when it calls register_vport_reps(),
and those two subsystems talk to each other. The atomic CAS loop avoids
all of this - no lock ordering, no sleep restrictions, and the owner
can drop the guard and let a nested caller win the next transition
before reclaiming it.

With this infrastructure in place, downstream patches can safely tie
representor load/unload to the mlx5_ib module's lifecycle. Loading
mlx5_ib while the device is in switchdev mode has failed to bring up
the IB representors for years; those patches will finally fix that.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 13 ++++
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  6 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 77 +++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  2 +
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  |  5 ++
 include/linux/mlx5/eswitch.h                  |  5 ++
 6 files changed, 100 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index d315484390c8..a7701c9d776a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1700,6 +1700,7 @@ int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs)
 		mlx5_lag_disable_change(esw->dev);
 
 	atomic_inc(&esw->generation);
+	mlx5_esw_reps_block(esw);
 
 	if (!mlx5_esw_is_fdb_created(esw)) {
 		ret = mlx5_eswitch_enable_locked(esw, num_vfs);
@@ -1723,6 +1724,8 @@ int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs)
 		}
 	}
 
+	mlx5_esw_reps_unblock(esw);
+
 	if (toggle_lag)
 		mlx5_lag_enable_change(esw->dev);
 
@@ -1747,6 +1750,8 @@ void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf)
 		 esw->esw_funcs.num_vfs, esw->esw_funcs.num_ec_vfs, esw->enabled_vports);
 	atomic_inc(&esw->generation);
 
+	mlx5_esw_reps_block(esw);
+
 	if (!mlx5_core_is_ecpf(esw->dev)) {
 		mlx5_eswitch_unload_vf_vports(esw, esw->esw_funcs.num_vfs);
 		if (clear_vf)
@@ -1757,6 +1762,8 @@ void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf)
 			mlx5_eswitch_clear_ec_vf_vports_info(esw);
 	}
 
+	mlx5_esw_reps_unblock(esw);
+
 	if (esw->mode == MLX5_ESWITCH_OFFLOADS) {
 		struct devlink *devlink = priv_to_devlink(esw->dev);
 
@@ -1812,7 +1819,11 @@ void mlx5_eswitch_disable(struct mlx5_eswitch *esw)
 	devl_assert_locked(priv_to_devlink(esw->dev));
 	atomic_inc(&esw->generation);
 	mlx5_lag_disable_change(esw->dev);
+
+	mlx5_esw_reps_block(esw);
 	mlx5_eswitch_disable_locked(esw);
+	mlx5_esw_reps_unblock(esw);
+
 	esw->mode = MLX5_ESWITCH_LEGACY;
 	mlx5_lag_enable_change(esw->dev);
 }
@@ -2075,6 +2086,8 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 	init_rwsem(&esw->mode_lock);
 	refcount_set(&esw->qos.refcnt, 0);
 	atomic_set(&esw->generation, 0);
+	atomic_set(&esw->offloads.reps_conf_state,
+		   MLX5_ESW_OFFLOADS_REP_TYPE_UNBLOCKED);
 
 	esw->enabled_vports = 0;
 	esw->offloads.inline_mode = MLX5_INLINE_MODE_NONE;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index e3ab8a30c174..256ac3ad37bc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -315,6 +315,7 @@ struct mlx5_esw_offload {
 	DECLARE_HASHTABLE(termtbl_tbl, 8);
 	struct mutex termtbl_mutex; /* protects termtbl hash */
 	struct xarray vhca_map;
+	atomic_t reps_conf_state;
 	const struct mlx5_eswitch_rep_ops *rep_ops[NUM_REP_TYPES];
 	u8 inline_mode;
 	atomic64_t num_flows;
@@ -949,6 +950,8 @@ mlx5_esw_lag_demux_fg_create(struct mlx5_eswitch *esw,
 struct mlx5_flow_handle *
 mlx5_esw_lag_demux_rule_create(struct mlx5_eswitch *esw, u16 vport_num,
 			       struct mlx5_flow_table *lag_ft);
+void mlx5_esw_reps_block(struct mlx5_eswitch *esw);
+void mlx5_esw_reps_unblock(struct mlx5_eswitch *esw);
 #else  /* CONFIG_MLX5_ESWITCH */
 /* eswitch API stubs */
 static inline int  mlx5_eswitch_init(struct mlx5_core_dev *dev) { return 0; }
@@ -1026,6 +1029,9 @@ mlx5_esw_host_functions_enabled(const struct mlx5_core_dev *dev)
 	return true;
 }
 
+static inline void mlx5_esw_reps_block(struct mlx5_eswitch *esw) {}
+static inline void mlx5_esw_reps_unblock(struct mlx5_eswitch *esw) {}
+
 static inline bool
 mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 988595e1b425..4b626ffcfa8e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2410,23 +2410,56 @@ static int esw_create_restore_table(struct mlx5_eswitch *esw)
 	return err;
 }
 
+static void mlx5_esw_assert_reps_blocked(struct mlx5_eswitch *esw)
+{
+	if (atomic_read(&esw->offloads.reps_conf_state) ==
+	    MLX5_ESW_OFFLOADS_REP_TYPE_BLOCKED)
+		return;
+
+	esw_warn(esw->dev, "reps state machine violated: expected BLOCKED\n");
+}
+
+static void mlx5_esw_mark_reps(struct mlx5_eswitch *esw,
+			       enum mlx5_esw_offloads_rep_type_state old,
+			       enum mlx5_esw_offloads_rep_type_state new)
+{
+	atomic_t *reps_conf_state = &esw->offloads.reps_conf_state;
+
+	do {
+		atomic_cond_read_relaxed(reps_conf_state, VAL == old);
+	} while (atomic_cmpxchg(reps_conf_state, old, new) != old);
+}
+
+void mlx5_esw_reps_block(struct mlx5_eswitch *esw)
+{
+	mlx5_esw_mark_reps(esw, MLX5_ESW_OFFLOADS_REP_TYPE_UNBLOCKED,
+			   MLX5_ESW_OFFLOADS_REP_TYPE_BLOCKED);
+}
+
+void mlx5_esw_reps_unblock(struct mlx5_eswitch *esw)
+{
+	mlx5_esw_mark_reps(esw, MLX5_ESW_OFFLOADS_REP_TYPE_BLOCKED,
+			   MLX5_ESW_OFFLOADS_REP_TYPE_UNBLOCKED);
+}
+
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
@@ -2761,6 +2794,8 @@ void esw_offloads_cleanup(struct mlx5_eswitch *esw)
 static int __esw_offloads_load_rep(struct mlx5_eswitch *esw,
 				   struct mlx5_eswitch_rep *rep, u8 rep_type)
 {
+	mlx5_esw_assert_reps_blocked(esw);
+
 	if (atomic_cmpxchg(&rep->rep_data[rep_type].state,
 			   REP_REGISTERED, REP_LOADED) == REP_REGISTERED)
 		return esw->offloads.rep_ops[rep_type]->load(esw->dev, rep);
@@ -2771,6 +2806,8 @@ static int __esw_offloads_load_rep(struct mlx5_eswitch *esw,
 static void __esw_offloads_unload_rep(struct mlx5_eswitch *esw,
 				      struct mlx5_eswitch_rep *rep, u8 rep_type)
 {
+	mlx5_esw_assert_reps_blocked(esw);
+
 	if (atomic_cmpxchg(&rep->rep_data[rep_type].state,
 			   REP_LOADED, REP_REGISTERED) == REP_LOADED) {
 		if (rep_type == REP_ETH)
@@ -3673,6 +3710,7 @@ static void esw_vfs_changed_event_handler(struct mlx5_eswitch *esw)
 	if (new_num_vfs == esw->esw_funcs.num_vfs || host_pf_disabled)
 		goto free;
 
+	mlx5_esw_reps_block(esw);
 	/* Number of VFs can only change from "0 to x" or "x to 0". */
 	if (esw->esw_funcs.num_vfs > 0) {
 		mlx5_eswitch_unload_vf_vports(esw, esw->esw_funcs.num_vfs);
@@ -3682,9 +3720,11 @@ static void esw_vfs_changed_event_handler(struct mlx5_eswitch *esw)
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
@@ -4164,6 +4204,7 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 		goto unlock;
 	}
 
+	mlx5_esw_reps_block(esw);
 	esw->eswitch_operation_in_progress = true;
 	up_write(&esw->mode_lock);
 
@@ -4203,6 +4244,7 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 		mlx5_devlink_netdev_netns_immutable_set(devlink, false);
 	down_write(&esw->mode_lock);
 	esw->eswitch_operation_in_progress = false;
+	mlx5_esw_reps_unblock(esw);
 unlock:
 	mlx5_esw_unlock(esw);
 enable_lag:
@@ -4474,9 +4516,10 @@ mlx5_eswitch_vport_has_rep(const struct mlx5_eswitch *esw, u16 vport_num)
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
@@ -4491,9 +4534,20 @@ void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,
 		}
 	}
 }
+
+void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,
+				      const struct mlx5_eswitch_rep_ops *ops,
+				      u8 rep_type)
+{
+	mlx5_esw_reps_block(esw);
+	mlx5_eswitch_register_vport_reps_blocked(esw, ops, rep_type);
+	mlx5_esw_reps_unblock(esw);
+}
 EXPORT_SYMBOL(mlx5_eswitch_register_vport_reps);
 
-void mlx5_eswitch_unregister_vport_reps(struct mlx5_eswitch *esw, u8 rep_type)
+static void
+mlx5_eswitch_unregister_vport_reps_blocked(struct mlx5_eswitch *esw,
+					   u8 rep_type)
 {
 	struct mlx5_eswitch_rep *rep;
 	unsigned long i;
@@ -4504,6 +4558,13 @@ void mlx5_eswitch_unregister_vport_reps(struct mlx5_eswitch *esw, u8 rep_type)
 	mlx5_esw_for_each_rep(esw, i, rep)
 		atomic_set(&rep->rep_data[rep_type].state, REP_UNREGISTERED);
 }
+
+void mlx5_eswitch_unregister_vport_reps(struct mlx5_eswitch *esw, u8 rep_type)
+{
+	mlx5_esw_reps_block(esw);
+	mlx5_eswitch_unregister_vport_reps_blocked(esw, rep_type);
+	mlx5_esw_reps_unblock(esw);
+}
 EXPORT_SYMBOL(mlx5_eswitch_unregister_vport_reps);
 
 void *mlx5_eswitch_get_uplink_priv(struct mlx5_eswitch *esw, u8 rep_type)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index c402a8463081..ff2e6f6caa0c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1105,7 +1105,9 @@ int mlx5_lag_reload_ib_reps(struct mlx5_lag *ldev, u32 flags)
 			struct mlx5_eswitch *esw;
 
 			esw = pf->dev->priv.eswitch;
+			mlx5_esw_reps_block(esw);
 			ret = mlx5_eswitch_reload_ib_reps(esw);
+			mlx5_esw_reps_unblock(esw);
 			if (ret)
 				return ret;
 		}
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
index 67256e776566..786b1ea83843 100644
--- a/include/linux/mlx5/eswitch.h
+++ b/include/linux/mlx5/eswitch.h
@@ -29,6 +29,11 @@ enum {
 	REP_LOADED,
 };
 
+enum mlx5_esw_offloads_rep_type_state {
+	MLX5_ESW_OFFLOADS_REP_TYPE_UNBLOCKED,
+	MLX5_ESW_OFFLOADS_REP_TYPE_BLOCKED,
+};
+
 enum mlx5_switchdev_event {
 	MLX5_SWITCHDEV_EVENT_PAIR,
 	MLX5_SWITCHDEV_EVENT_UNPAIR,
-- 
2.44.0


