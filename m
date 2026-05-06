Return-Path: <linux-rdma+bounces-20074-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLFvGGhD+2lPYgMAu9opvQ
	(envelope-from <linux-rdma+bounces-20074-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 15:34:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C42444DB085
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 15:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88E9930488FC
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 13:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBD3477E34;
	Wed,  6 May 2026 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NYZ0M1B9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013034.outbound.protection.outlook.com [40.107.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94C047A0BC;
	Wed,  6 May 2026 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074415; cv=fail; b=uUD9BVYbFY9zZehmSvgmQGrbjjlR+eHnr3DZja9ThNyoaoU0Uz6mehgqC0/+7jWe0lNyw2IL1ToRdz25vXcd7/W40GSJYsFMq3lZ+6y+xJTjQzuzwIHqbD72tMntcm8bMXqY/DJXQMSGKWm2RDN+rw1lfO6ATp0fXG2ODQcqCks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074415; c=relaxed/simple;
	bh=4A+zi3fm5TgemW3trg/MrX8w9MKskgdUlpd8xNM7xsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTuYAM+8ZycEv8DhG8R8hpSuVmQTOEQfXbYv9s9Zw7srZGDXWGC3sY3tfKeIAtlCCgKDFXA51GJXUY3NTugWgj2OwQn9iZwopGpMctATeuCqWbm94DT/B5lsmzObrlyVVSPDS+S3cqKk0Q/AiIZs1Bzk+FAgIKF1uP044OcO49o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NYZ0M1B9; arc=fail smtp.client-ip=40.107.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMfnc/Ms4hRRjJIv+4rWISu7w2X0t73puJRJH1Ve4u7Qayvw9CtJOpmPA9n3OYluJDJr/VwGY9+zNrGvwMr0FicYtYq7dnNTooNuXfJ/3fIRGNXrJmJjBo/u8kG0S2q/1VbZWKexGL4JlyvSl3dxz/ulWurtEkbYQzCXnwlivUrwGFN4+QCb5ooxQtXpEc+lEzqVuQ3KUvYipN6z7EnKjhHKs+SzFCgmk+VwKdNJQsBXJWdflV8iyHooWmSZP+fP6ZuzR5zOl3fQRbmEacQjZUOZHhdyV7AKqKHtJaiQb2hURkNK6fG4CcWLiwomhWH2hzxF1S5QsDO1VCp2Yh5YDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6D4+b+/99IRUQOnflu8ud0uYsNvXzdn3HfaKA48jM8w=;
 b=Hg5Ff/R9mfwmu+suIVPZTHv4ISqNbpdALnCx+LoZfv0m/96anlqlUqOTebA1HwtGkrSh43fN3Wv6MSS5XMGXRsHA3wDyFAHD/yuVY+JJGGwXhpVmV2wAnox0x+Mdg6v7x4zqYNZzdJG3f8N6yqID+x9bzK5Il9Jb5flyNW+42GjbGh0GjmVM8G5z8Q+p7PCTq6bJh7dzhxfcuaYijlGtr8n74EVykTev9NfyAcszQtMk3dkzcjJL8r0m1z3HGhtOnz5KsiOw+ehNQM8C8eyjAsO7ZstJr5xhEEsvhpiekyyCPh4/SXpD71VoW5wk38DfixKVsYdRjnwl00WITTWjjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6D4+b+/99IRUQOnflu8ud0uYsNvXzdn3HfaKA48jM8w=;
 b=NYZ0M1B9KvsAeuHPpyPHQKyFcY4CkSacm0+IoMmDdgHQkcHG5Sl0rA2d1hIyzKiWXmsU4mEYz2weITiYYUPjjg/R+0BeUbXR0THpURhiTe905AE7dYOpOVzVdawOS3Q7u/j9+PfhJitILISQLk6sa1GnZEh8IvO2M8LwhdspTrq23euAJKAvSsa6hWqPB752ivET0efE25fQ3UKNSl11226tMIQYBkgygh6dYcph8+/6BPYIDuv3JqirwxDRdcMMUOY+CO21gT4NoItlYWUUzAOFIJKjunCjiyQvit2jRIUvtYpmJbwGYbVERm9xKjmRKGFZCppcbwBbg07NGtLaGg==
Received: from MN2PR04CA0005.namprd04.prod.outlook.com (2603:10b6:208:d4::18)
 by DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.15; Wed, 6 May 2026 13:33:26 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:208:d4:cafe::50) by MN2PR04CA0005.outlook.office365.com
 (2603:10b6:208:d4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 13:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 13:33:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 06:33:04 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 06:33:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 6 May
 2026 06:32:59 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next V2 2/3] net/mlx5: Make debugfs page counters by function type dynamic
Date: Wed, 6 May 2026 16:32:38 +0300
Message-ID: <20260506133239.276237-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260506133239.276237-1-tariqt@nvidia.com>
References: <20260506133239.276237-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|DS7PR12MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a0e7904-e171-4826-1c64-08deab740d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Glhz0IiRFHB2b7CJTsp8p9JmHiK/OKadHj8PQEPsLNxIILE4aeGLqJE0hcE++6BP8NOCJReqmhih/NsfZYFFzu5SsuWgjYsBJ+wWioR5H1pSIVu9/YZtayEK4/rN1x4hMhMw+WfruIw/5TKohTD0KD45N12u+DNlCo/beoa8QaQ++/j3Lo0tH7q65r8j+DjjY5Ro6dvgNir6zl51gQBVPUn25/o/EkN0te72br+d8Fa153LE3fxtWWvZbK3Lngtx/BXzE3OqBMqmQJvcUQdlh4q0+O4ahzePop3F2ci4r5L+SogIbTo06lP1PZW8s/ljfFAAKIua+UHqKJz1ichPxetyoPET2E0S2QI7YlYZkCaTbpDMLC0F7QHM2K/UxKH9JMW7ddt0076cShLaS7ZOhzrzn0UoJuI/yisC+uvZ/RoPrIX7btt0T0zCo/rSQRDMO558hiA0vkI236QvM4EeDf36TQTMZEP3FzWklER8tt79X3LesrlR3C2364o1BbOyCLXKdPX54hwPzWvE3s/HgRAB0LZvPrRJua+nyJ3GSjNNLv3SWiSPE/nRxd7w6UG5FUoJp7A7zathN9CryEi8BIiHF8PIx+1GS8XgIRM9cGy/EZ30HxtQPFQnL5gB+2Nhg/mli/J0qAJiV2Cay9jSfoX4mln5rRdDqTnPH+VY4jXywDjofHYIgwGoqe22JzDi+cbyxMV8UiybGYZSNWcJAx5fa49yGbwal/QlvQKKw3g=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kTR6WH61GvQAYbjjdse5jF2bcLyr+fiz354yCD8cheBwWCbYaF1KUIyDd1BEBAqlLduVSoHPIv3wIrMmCxr75t6uP0d4XwRE9qqCv0nbBhs+iDoYCmeuR1k/yiFeUPH97w65cpZ/s0AV7l/fwVhNsUNbNS0Wz48II+hkQ1YqMwhBE5UXJPgEqwxq6BJadH9rbLJXtnl0YbvQON7y1E/QH9ve6ZWbgsrs5NqBrkAeHujC+jS95E56bImyvpreXqSVoYMHwTxbJeCtrDYgYUiWTQMz7+I0eezJNBvbP1SU+EFmSvEXCDnaIGQ10ulY6kcLbl7yHKNI7l224eskh/FojpRRhE2S+7NLJJYrG/cI1I2gQvnvyufCFiX0bPo6llvGLIg5j2vNBDJwyxOS8QqhNpUs0dMhgr614lTSal4UZU+dek+LL+Drcy1dXlaFJd2x
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 13:33:25.7939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0e7904-e171-4826-1c64-08deab740d3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6048
X-Rspamd-Queue-Id: C42444DB085
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-20074-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Moshe Shemesh <moshe@nvidia.com>

Make the per function type debugfs page counters dynamically added after
mlx5_eswitch_init(). When page management operates in vhca_id mode, only
the function acting as either eSwitch or vport manager can initialize
the eSwitch structure and translate the vhca_id to function type for the
functions to which it supplies pages. The next patch will add support
for page management in vhca_id mode.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Akiva Goldberger <agoldberger@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/debugfs.c | 39 +++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/main.c    |  7 +++-
 include/linux/mlx5/driver.h                   |  2 +
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
index 8fe263190d38..6347957fefcb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
@@ -285,10 +285,6 @@ void mlx5_pages_debugfs_init(struct mlx5_core_dev *dev)
 	pages = dev->priv.dbg.pages_debugfs;
 
 	debugfs_create_u32("fw_pages_total", 0400, pages, &dev->priv.fw_pages);
-	debugfs_create_u32("fw_pages_vfs", 0400, pages, &dev->priv.page_counters[MLX5_VF]);
-	debugfs_create_u32("fw_pages_ec_vfs", 0400, pages, &dev->priv.page_counters[MLX5_EC_VF]);
-	debugfs_create_u32("fw_pages_sfs", 0400, pages, &dev->priv.page_counters[MLX5_SF]);
-	debugfs_create_u32("fw_pages_host_pf", 0400, pages, &dev->priv.page_counters[MLX5_HOST_PF]);
 	debugfs_create_u32("fw_pages_alloc_failed", 0400, pages, &dev->priv.fw_pages_alloc_failed);
 	debugfs_create_u32("fw_pages_give_dropped", 0400, pages, &dev->priv.give_pages_dropped);
 	debugfs_create_u32("fw_pages_reclaim_discard", 0400, pages,
@@ -300,6 +296,41 @@ void mlx5_pages_debugfs_cleanup(struct mlx5_core_dev *dev)
 	debugfs_remove_recursive(dev->priv.dbg.pages_debugfs);
 }
 
+void mlx5_pages_by_func_type_debugfs_init(struct mlx5_core_dev *dev)
+{
+	struct dentry *pages = dev->priv.dbg.pages_debugfs;
+
+	if (!pages)
+		return;
+
+	if (!dev->priv.eswitch &&
+	    MLX5_CAP_GEN(dev, icm_mng_function_id_mode) ==
+	    MLX5_ID_MODE_FUNCTION_VHCA_ID)
+		return;
+
+	debugfs_create_u32("fw_pages_vfs", 0400, pages,
+			   &dev->priv.page_counters[MLX5_VF]);
+	debugfs_create_u32("fw_pages_ec_vfs", 0400, pages,
+			   &dev->priv.page_counters[MLX5_EC_VF]);
+	debugfs_create_u32("fw_pages_sfs", 0400, pages,
+			   &dev->priv.page_counters[MLX5_SF]);
+	debugfs_create_u32("fw_pages_host_pf", 0400, pages,
+			   &dev->priv.page_counters[MLX5_HOST_PF]);
+}
+
+void mlx5_pages_by_func_type_debugfs_cleanup(struct mlx5_core_dev *dev)
+{
+	struct dentry *pages = dev->priv.dbg.pages_debugfs;
+
+	if (!pages)
+		return;
+
+	debugfs_lookup_and_remove("fw_pages_vfs", pages);
+	debugfs_lookup_and_remove("fw_pages_ec_vfs", pages);
+	debugfs_lookup_and_remove("fw_pages_sfs", pages);
+	debugfs_lookup_and_remove("fw_pages_host_pf", pages);
+}
+
 static u64 qp_read_field(struct mlx5_core_dev *dev, struct mlx5_core_qp *qp,
 			 int index, int *is_str)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index b1b9ebfd3866..0c1c906b60fa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -987,11 +987,12 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 		mlx5_core_err(dev, "Failed to init eswitch %d\n", err);
 		goto err_sriov_cleanup;
 	}
+	mlx5_pages_by_func_type_debugfs_init(dev);
 
 	err = mlx5_fpga_init(dev);
 	if (err) {
 		mlx5_core_err(dev, "Failed to init fpga device %d\n", err);
-		goto err_eswitch_cleanup;
+		goto err_page_debugfs_cleanup;
 	}
 
 	err = mlx5_vhca_event_init(dev);
@@ -1034,7 +1035,8 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 	mlx5_vhca_event_cleanup(dev);
 err_fpga_cleanup:
 	mlx5_fpga_cleanup(dev);
-err_eswitch_cleanup:
+err_page_debugfs_cleanup:
+	mlx5_pages_by_func_type_debugfs_cleanup(dev);
 	mlx5_eswitch_cleanup(dev->priv.eswitch);
 err_sriov_cleanup:
 	mlx5_sriov_cleanup(dev);
@@ -1072,6 +1074,7 @@ static void mlx5_cleanup_once(struct mlx5_core_dev *dev)
 	mlx5_sf_hw_table_cleanup(dev);
 	mlx5_vhca_event_cleanup(dev);
 	mlx5_fpga_cleanup(dev);
+	mlx5_pages_by_func_type_debugfs_cleanup(dev);
 	mlx5_eswitch_cleanup(dev->priv.eswitch);
 	mlx5_sriov_cleanup(dev);
 	mlx5_mpfs_cleanup(dev);
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 531ce66fc8ef..d1751c5d01c7 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1039,6 +1039,8 @@ void mlx5_pagealloc_start(struct mlx5_core_dev *dev);
 void mlx5_pagealloc_stop(struct mlx5_core_dev *dev);
 void mlx5_pages_debugfs_init(struct mlx5_core_dev *dev);
 void mlx5_pages_debugfs_cleanup(struct mlx5_core_dev *dev);
+void mlx5_pages_by_func_type_debugfs_init(struct mlx5_core_dev *dev);
+void mlx5_pages_by_func_type_debugfs_cleanup(struct mlx5_core_dev *dev);
 int mlx5_satisfy_startup_pages(struct mlx5_core_dev *dev, int boot);
 int mlx5_reclaim_startup_pages(struct mlx5_core_dev *dev);
 void mlx5_register_debugfs(void);
-- 
2.44.0


