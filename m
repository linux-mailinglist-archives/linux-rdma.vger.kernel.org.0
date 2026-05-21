Return-Path: <linux-rdma+bounces-21105-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK3kOcnqDmqwDAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21105-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:21:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F495A3EC8
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7232C31386B7
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 11:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E5C3C76A2;
	Thu, 21 May 2026 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="scUQdr7d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013031.outbound.protection.outlook.com [40.93.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B9E3BB13E;
	Thu, 21 May 2026 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779361983; cv=fail; b=NyOsX7TKMadP3STmwUI/StESORtiF4cbzro4jU9SqDEkmtCBm+NV2tFzuTbGXylU8MFq2hDv6Yqn3o0Qlx9luVY2n3/fgNAkpqnu68ArcLoeQiakeh1NRoUrRK6jW0w6a11USHt01ylfuIExQZlig7urZXnnID9VEYWR7zUCYWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779361983; c=relaxed/simple;
	bh=tfLIVFnNlyn8pPWlR3YBaKliGKwzYs0mU9MNyo3pnFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jnt0nncCmeNE0mRt0TnZUF63GPWqy+SYxcIj4MINqo7NyJNUxY8RSG4FtnxC8zmgn1Hbsgn58YviRqVbYjDwyWKVeTtF+/UY57IFZVzQYSSu4iTCGj0oCJXhabMgcaisXwsbMrXe98RKoC4qWOJs/MhZtJCsGqn6f/xlfuzRW1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=scUQdr7d; arc=fail smtp.client-ip=40.93.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNjFVkcx9Z+UbGt4x0xKAEkTK1stlTmsW9bgqyZVYnCMJeJHCw8vuU/NUK+XGMWEJlv1cjxNB0xfwiCWYklRiT7VAoORU7f6hfn9cVbBwvto8oLmAm2/hVnFVc4wb+iB/vimB4T1KClNaJOPFdveKm9TMpIPIDxVmmR5vhvbpHs1N39ZgO7WfyHNSu0Q8OsClLopi7jG4biS/8Jau6LI/JwlMZ1e+sEiEIGFuLnDU1TpA+QnfinXC3Kqa98ex1N9UdxO9FW6zSGwdAnMOQG9BrAzbeKLIX7MMfBG4zRm1hcW+3bmKxOgTQuJW84kPStkt2kPbd7xjzB1eJI4fgrx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAJYGM9DTvO94TTB3zrP6C8CwYsp7OHKVMslVADPens=;
 b=dD5RSwEBjNwe5L3DpYwgmpnnmLNnl/sQHF4UJ0zEzpq/ByNUQq4CWcWhPKp+hnzVpxmX8BgoCaTooAjjF/lvmKS7Rogv1Hs7FrmLJXOXnAMTZoAzuuWczsKCS6gWD4Gu5UYUttz2KWJ5AOSVr6kpv2o6z/CF59vPL8Z5ZYEn4ysj6tvfsQB0qKNTS8/LyiMPVo+HDBMBElsePDjiFPZFeafHF/ddtMAPP0zC2FEEIsKz9tZvVp85ob9RlsCYbnRDW91YE85XpGIBWx8ImIQSeyJ+rprc3jtEfT/VKUpDLyrEXYcRLWKiuSiIKhOBGfNMi4kxYjT6yU361t4W50Vv5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAJYGM9DTvO94TTB3zrP6C8CwYsp7OHKVMslVADPens=;
 b=scUQdr7d0X5C7sO/bpA4nwjKlYv8wTnBa1puSlf5NlhoEn6QaYE2fgyskpbJpES0nfRXBF4+AA5wotGKeKy+ZIxUkATk8sQGN+kafJboekU86csYliRn/oCqkrgik2ruM3yz9WXd1Ov1K7Zf95ijXlinAPjIuaXHklUIMUB5BLh5pwpVdnFtlB0LcID3HehcoNfTjgP5qHxcU0/vr+oUKe3zIR7hHihNpWdkY7rgKR45Wxp+sm/YDf+bAYgGFOQxDZ//DyjHAvLKKOIrazX2yG1GDBXQ63HN6jm7KRwc0NhpikMlIQU4H0m4OrOVnevzuZ/CC8TiSJsVCVFMRz2SBA==
Received: from CH0PR03CA0423.namprd03.prod.outlook.com (2603:10b6:610:10e::6)
 by CY3PR12MB9679.namprd12.prod.outlook.com (2603:10b6:930:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 11:12:53 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::72) by CH0PR03CA0423.outlook.office365.com
 (2603:10b6:610:10e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Thu, 21
 May 2026 11:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 11:12:52 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:12:34 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:12:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 21
 May 2026 04:12:28 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Simon
 Horman" <horms@kernel.org>, Adithya Jayachandran <ajayachandra@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>, Moshe Shemesh <moshe@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>, Shay Drori <shayd@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>, Kees Cook
	<kees@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 12/12] net/mlx5: Add SPF function type for page management
Date: Thu, 21 May 2026 14:08:43 +0300
Message-ID: <20260521110843.367329-13-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260521110843.367329-1-tariqt@nvidia.com>
References: <20260521110843.367329-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|CY3PR12MB9679:EE_
X-MS-Office365-Filtering-Correlation-Id: 4354091d-a0aa-4813-08f0-08deb729e701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	gwd+KIoou5WJLxwGx/uWR5BUaO38P7OqAdl0/3VylO2vqH1qeEyEHku6PdgxkTf546e11CNMJeQ9vkn6o8s1plPTy1Qrn5XrnrtR0xRUvNT52UwZxNE/2m278U/VFfTx9qIR5oEyofbO1Q1GkkkjAoobl9IUoq6BHbKgFoLHgR1OiwPMRo9TMcuYHXyrro0jNt2A2z/KXqIorwVSJyT3rldJPqwuLwuIKJUUJOq1EdUY4Sgtv2VHhYCdUX/XMFLWnTlSW/fuiQ7mO4zhruqyY1f8X2zwY8Bwb6B8yUohW48/q29F6Hcb1zmKKEKdmEbmITMuUETO/xB+QcBwVL5Etk+mNseQMDgBF+L2MJq3gr2MvNwEugtMY1Dpernx4XyV5SWfHsCWuTOJww2zxAKW26KiCkxjKUYJUUvoCAPXs3LPU/w9I3STwKTzsn6ilJVUshritx48G+vX9+qhuocxf3ZwbUFYnCThyFyLMwHc+MMphExUOU2ON8HBL1Ekpm4fhRc+w7Hn5r7H4dsj2bKb3F5nUkNgBszOBM4bYj72SfGJ7WBTpwgSuS6LI3tPRty8RjUGqFE/jGQWEKDMS0foVMVAG3zXEIzNeUnj15sJTvUksoiZJ6WSneMgXJEQoYrMn/WH29WVYV+BV9o3kTSycwepM+Q+WzXdVQ097hQstEvMcIB8mKfV+iU2P59zpjn9wS1Jrw+1cqMSyVBD1+GQKp4VGhQZAWR1FC1nXswiYbc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(18002099003)(22082099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XcTqnetZ4yzxBPOI47por7CCBK4pIV7dn2W0+LSO290DjmYGPNuBcQA/MCx7k8XcqATOg28RvpS4y/GNwxKPn6IxIX/EM5ujHfz/t7zwp4HmwhS3hrhbSIWiJEAmFecK/ekJcNLcSz+YM6JsTBxjPTQPdCNhzETNk7v9JfPMvnA0jxTXyqlLkWFhAKCETpCC7WoaXHpgG1iKNnihp2BRSiyLloxyRCSaFduIdE5a6+qOzkRID7TaJWNzVd110XLomcnhRDJJ/2r5tAkuqS6EM8uWGUXbw3oL+7lDjvZmfM1hgyp+61Cto4Mo2IYcPsz68mRT0jQiHHnvisZu5lZwdGbewFeakxWVsqlKbb9juvffeMqsgfm63tN7mXcTUNVW/TC5jjJPGfUfL6Fk/ebeVPp6xSexNFK90tWKQyjpnI0qV0u6zarGeGAn4S1WEZyW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 11:12:52.8600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4354091d-a0aa-4813-08f0-08deb729e701
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9679
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21105-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A9F495A3EC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Moshe Shemesh <moshe@nvidia.com>

Add MLX5_SPF to enum mlx5_func_type so SPFs get their own page counter,
and add the corresponding WARN check at page cleanup. Wait for SPF pages
to be reclaimed during ECPF teardown, alongside the existing host PF and
VF page waits.

SPF page requests are always identified by vhca_id, so the legacy
func_id_to_type() path is not reached for satellite PFs.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/debugfs.c   | 3 +++
 drivers/net/ethernet/mellanox/mlx5/core/ecpf.c      | 5 +++++
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c   | 2 ++
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 3 +++
 include/linux/mlx5/driver.h                         | 1 +
 5 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
index 6347957fefcb..30be2b631e7c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
@@ -316,6 +316,8 @@ void mlx5_pages_by_func_type_debugfs_init(struct mlx5_core_dev *dev)
 			   &dev->priv.page_counters[MLX5_SF]);
 	debugfs_create_u32("fw_pages_host_pf", 0400, pages,
 			   &dev->priv.page_counters[MLX5_HOST_PF]);
+	debugfs_create_u32("fw_pages_spfs", 0400, pages,
+			   &dev->priv.page_counters[MLX5_SPF]);
 }
 
 void mlx5_pages_by_func_type_debugfs_cleanup(struct mlx5_core_dev *dev)
@@ -329,6 +331,7 @@ void mlx5_pages_by_func_type_debugfs_cleanup(struct mlx5_core_dev *dev)
 	debugfs_lookup_and_remove("fw_pages_ec_vfs", pages);
 	debugfs_lookup_and_remove("fw_pages_sfs", pages);
 	debugfs_lookup_and_remove("fw_pages_host_pf", pages);
+	debugfs_lookup_and_remove("fw_pages_spfs", pages);
 }
 
 static u64 qp_read_field(struct mlx5_core_dev *dev, struct mlx5_core_qp *qp,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ecpf.c b/drivers/net/ethernet/mellanox/mlx5/core/ecpf.c
index 350c47d3643b..9839f1a58640 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ecpf.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ecpf.c
@@ -102,6 +102,11 @@ void mlx5_ec_cleanup(struct mlx5_core_dev *dev)
 	if (err)
 		mlx5_core_warn(dev, "Timeout reclaiming external host PF pages err(%d)\n", err);
 
+	err = mlx5_wait_for_pages(dev, &dev->priv.page_counters[MLX5_SPF]);
+	if (err)
+		mlx5_core_warn(dev, "Timeout reclaiming SPF pages err(%d)\n",
+			       err);
+
 	err = mlx5_wait_for_pages(dev, &dev->priv.page_counters[MLX5_VF]);
 	if (err)
 		mlx5_core_warn(dev, "Timeout reclaiming external host VFs pages err(%d)\n", err);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 9f82fc4dbf43..5df3ec641ae3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -863,6 +863,8 @@ esw_vport_to_func_type(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 		return MLX5_SF;
 	if (xa_get_mark(&esw->vports, vport_num, MLX5_ESW_VPT_VF))
 		return MLX5_VF;
+	if (mlx5_esw_is_spf_vport(esw, vport_num))
+		return MLX5_SPF;
 	return MLX5_EC_VF;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
index ce2f7fa9bd48..7fef3a7fee6e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
@@ -885,6 +885,9 @@ int mlx5_reclaim_startup_pages(struct mlx5_core_dev *dev)
 	WARN(dev->priv.page_counters[MLX5_HOST_PF],
 	     "External host PF FW pages counter is %d after reclaiming all pages\n",
 	     dev->priv.page_counters[MLX5_HOST_PF]);
+	WARN(dev->priv.page_counters[MLX5_SPF],
+	     "SPFs FW pages counter is %d after reclaiming all pages\n",
+	     dev->priv.page_counters[MLX5_SPF]);
 	WARN(dev->priv.page_counters[MLX5_EC_VF],
 	     "EC VFs FW pages counter is %d after reclaiming all pages\n",
 	     dev->priv.page_counters[MLX5_EC_VF]);
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 9a4bb25d8e0a..b1871c0821d0 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -557,6 +557,7 @@ enum mlx5_func_type {
 	MLX5_VF,
 	MLX5_SF,
 	MLX5_HOST_PF,
+	MLX5_SPF,
 	MLX5_EC_VF,
 	MLX5_FUNC_TYPE_NUM,
 	MLX5_FUNC_TYPE_NONE = MLX5_FUNC_TYPE_NUM,
-- 
2.44.0


