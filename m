Return-Path: <linux-rdma+bounces-21104-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKjlARHqDmrTDAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21104-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:18:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C89195A3E20
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4BC2030777B2
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 11:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733C93C4B92;
	Thu, 21 May 2026 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oDB1bY/e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFCA37CD4D;
	Thu, 21 May 2026 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779361971; cv=fail; b=hlCqPoCxstWFNU1srKwNGQl/g9Lwdu85SZO6Q9v2YAN/L1DXSiaQFuUNHibcajynPe1GtAhA0avH/z2NIU+aYrjvp1V+Dh+x/7WzelmXBxrn6iijQRjk8qBEqty8IvYxLXjO1aJupRjzA4UEsmA62kEz90FVkDnBy9dSrafgyt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779361971; c=relaxed/simple;
	bh=b2oYatLmHQ8qWb/a7flLOGEEol7/H6Yhi4p5Rnu86uc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EugQZHebNP2GpDjMijOwJyEurXPhvq0/bvmFmmd8UARjoqJghyReDue03wHVxn/iBZUe2YXM3slv46LUJLblTZBL0QmW0iAH6nkfg7xxcj8b6p4CsFxBYfL2U4EXQAWEfAmEhhWbqYItjFsnvzSS9jbgX39H5m06e+0RqHBbbVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oDB1bY/e; arc=fail smtp.client-ip=52.101.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyTthQBtiqL2lB1gcGPCi10pADzuGqkdoa8zLl7lBxISYOvrBH0kjZ4+WN324EMLvzNx8EFYxODWynfMkEP4Muhi6Ml/4K7fxmyNZThvC7kASFKp3k7yd7G3qvqWIB/FxOXylOgemxboQF1LksiuhNaa8b2UqeVbuZBrfD64RGFKZMrX5bMwHU/qQ+mZL9ibULsX7iUSuPwelfQfkTmPhT2+wP93ikYh1KtRsJXxT8Vly7kcGR0KXvijcRLxRFkXQwoDMDDpPAetU9Fja4n+Xr43TqGRxNZxwA8ZlX5cE4IaUg44qmFqMprAvp+/vsjoaArpj+T+dufl76fLsV25qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gV/grQB++mvKLmL2UO6bSVv7XWhEmuwNT24ouf2kfto=;
 b=MaXHm7QAEDBg/0eG2rx2LKt73SUUjf8qnyMXpgD2OrMKohToDneZo7+Aj7ecBCZqkiADRL6/HBlHRGTJDAfqOWPV+ekWmvoEnGExtmiE1ydlywBDJ5yAlfNnt4eTVU/t5w82lXvKKgo4pUTxNjYasRkbikIeNyQsdqQ9b8lOWaHQMzX/U2vK8W9gnS09YBz+b7A9ll9QHXG5dw0VHtseb0azqiW782+3WlOw6wcwTFzuB4DWuaiXkoocnwZsMapNU/Uyi1/VS5WdgZtWXn/kWud0w7LxJjASvKMN2GfVOQumsUzEYoyMrTmFViv3oNRQ/clZjDwWJj3KhFi3B2kSiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gV/grQB++mvKLmL2UO6bSVv7XWhEmuwNT24ouf2kfto=;
 b=oDB1bY/exOPUeSJpbS18I53hijmSXjEFtP7iiTh+6jZWLe6vIZSyXO2NQmBBPtXB0mu3yHdr78LGBSOC3KSFDLMmLPaSSSPc+4eVpncBJRCudWn8By79mXG99hxLVq/iujTw2aOZJx0XGuOq0BUJjEVY+buZJtrgaEn4aH36me37Zvm/Gf8i2mo4J0rJp8Kh1eNs7GPn4uY7w/8WqJYnxDBjg0LRRHLkWjC7evBOKrel16ihPfIsSIqhpyNyTSDoTar5Xm2w2gQ7HginKjkT2K4l+zBylX5m6NYsyVLSlieY87W2RhaBb88WXsh0FtJC39eCM+5002VqZLcfCUukXA==
Received: from SJ0PR13CA0086.namprd13.prod.outlook.com (2603:10b6:a03:2c4::31)
 by DS0PR12MB8414.namprd12.prod.outlook.com (2603:10b6:8:fb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Thu, 21 May 2026 11:12:40 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::7b) by SJ0PR13CA0086.outlook.office365.com
 (2603:10b6:a03:2c4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.6 via Frontend Transport; Thu, 21
 May 2026 11:12:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 11:12:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:12:22 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:12:21 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 21
 May 2026 04:12:15 -0700
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
Subject: [PATCH net-next 10/12] net/mlx5: Support state get/set for satellite PF ports
Date: Thu, 21 May 2026 14:08:41 +0300
Message-ID: <20260521110843.367329-11-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|DS0PR12MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: cb90d2aa-126e-444b-fa89-08deb729df6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|18002099003|22082099003|56012099003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	3P8ass9NQCYhnfXsKXCZLjeaXeAgtnKg5j22aUCpZDDixzqXz0v4XUQGmv9lU4rJL09X4iJIzy8aBavAJFllUj0s9eTdOmYArJUGbV95pBPsE0ZJ5BdpfvSEbfkDunW7uxUBqQoODww6aSeBZF/YhaT2L/pGjQ4KdhplmT/lx/pQdReIM8WhjWE2+UsHLZnyDYQxOQohLG/ix7u90+SnvZjI/cY4rntId0Bi6qZrcNZT1dtVf8YN1snmkDDCAbGcJFI5caT7WxALaqE4s8bpXYSwsa23RdzWnfLaxsEMwBrDSK5TrfdG0d2xETViM5dUWihnsIBNoAixXVmX1FNe+zNYXrgt4oEl05y35wDh8hValE5gWcaESUoCYz7DdrVBO1RjHMmssRWfTnO3e2ecq+uaWVx7tKhnJLVOQ6yJQ1HgDvT4/FeB1xh91OF8YzVhynsfFyn/wkwVpnU8O3tQsadGVlnrZhsIT3Iz42m1TJhY1eXcjurV9R7UhofZj75/E8XEYpO7eezEiTvdN30AjVMlkcGuTlsKhYCgwPDLUk2VuEzIuhYxtakR5DSy3C/TVxiPs2E8dSTnxytGqTLzO1Ll281xJtlIF2tNiVyhYfDOXG2d82B4EnvU92+0aEnKeuMqsR8PQWwAdFb95+wFaGDh3D/P1PnqWqZoRxX/Mf0NVOBLMOHm/v4rafZdAauvh2bIeZmT6HLcqaySFaq6Wc13r7aELoEd29N3ObLjaeM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003)(3023799007)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jfHIYkfitbQVrb+v693CeqwGiG3JelyIL9jU7iXOMSuRPRR3nHjMuxtGfsuOpl2s23K/VfiNSQFzMRLcF10VAsHAQwNw/YsyR/8BG9rWR1YKDDs6fhxOHzRwM7RkQ0udAhx+jK07uH41PimdRZgLc1yp3gWg1odJn4y6NBgkg4j1xt8WiSLIGL/OiruOz9imN7LR/9dk6JBG8r7EE6XrWHOpBGSFDaGWNPd+oBzjhPLWN8g0a6/NLmIoeL8KkywVma9vLBFCxWV70iChRPazjTelSKm+C8NGALSTXXzZ/PeeFd3fG03iVxl2RPuTPTineU4CysaNEoN+La5DVJhQg8700g9iDepT4EsSXGnW/+nFx4D1JlZ9zf2ULSx2rqB5dwYuTpJ2E6IInhwMYD1o42kemWuX1gGwDamlRjtYWOeXP0xsyYso4r/KVEx4/J4O
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 11:12:40.2045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb90d2aa-126e-444b-fa89-08deb729df6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8414
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
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21104-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C89195A3E20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Moshe Shemesh <moshe@nvidia.com>

Extend mlx5_devlink_pf_port_fn_state_get() to support satellite PF
vports by querying their vhca_state from the query_esw_functions output
using the vport's vhca_id.

Extend mlx5_devlink_pf_port_fn_state_set() to support satellite PFs by
using the generic mlx5_esw_pf_enable/disable_hca() functions.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 31 +++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  4 +++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 28 +++++++++++------
 3 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 8bee014140b8..9f82fc4dbf43 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1187,6 +1187,33 @@ mlx5_esw_get_host_pf_info(struct mlx5_core_dev *dev, const u32 *out)
 	return mlx5_esw_host_pf_from_host_params(entry);
 }
 
+bool mlx5_esw_get_spf_disabled(struct mlx5_core_dev *dev, const u32 *out,
+			       u16 vhca_id)
+{
+	int num_entries;
+	const u8 *entry;
+	int i;
+
+	num_entries = MLX5_GET(query_esw_functions_out, out, net_function_num);
+	entry = MLX5_ADDR_OF(query_esw_functions_out, out, net_function_params);
+
+	for (i = 0; i < num_entries; i++) {
+		u16 entry_vhca_id = MLX5_GET(network_function_params,
+					     entry, vhca_id);
+
+		if (entry_vhca_id == vhca_id) {
+			int state;
+
+			state = MLX5_GET(network_function_params, entry,
+					 vhca_state);
+			return state != MLX5_VHCA_STATE_IN_USE;
+		}
+		entry += MLX5_UN_SZ_BYTES(net_function_params);
+	}
+
+	return true;
+}
+
 static int mlx5_esw_host_functions_enabled_query(struct mlx5_eswitch *esw)
 {
 	struct mlx5_esw_pf_info host_pf_info;
@@ -1454,7 +1481,7 @@ static int mlx5_eswitch_load_ec_vf_vports(struct mlx5_eswitch *esw, u16 num_ec_v
 	return err;
 }
 
-static int mlx5_esw_pf_enable_hca(struct mlx5_core_dev *dev, u16 vport_num)
+int mlx5_esw_pf_enable_hca(struct mlx5_core_dev *dev, u16 vport_num)
 {
 	struct mlx5_eswitch *esw = dev->priv.eswitch;
 	struct mlx5_vport *vport;
@@ -1480,7 +1507,7 @@ static int mlx5_esw_pf_enable_hca(struct mlx5_core_dev *dev, u16 vport_num)
 	return 0;
 }
 
-static int mlx5_esw_pf_disable_hca(struct mlx5_core_dev *dev, u16 vport_num)
+int mlx5_esw_pf_disable_hca(struct mlx5_core_dev *dev, u16 vport_num)
 {
 	struct mlx5_eswitch *esw = dev->priv.eswitch;
 	struct mlx5_vport *vport;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 7da1a888aa7c..1d8e2486d518 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -671,6 +671,10 @@ bool mlx5_esw_multipath_prereq(struct mlx5_core_dev *dev0,
 const u32 *mlx5_esw_query_functions(struct mlx5_core_dev *dev);
 struct mlx5_esw_pf_info mlx5_esw_get_host_pf_info(struct mlx5_core_dev *dev,
 						  const u32 *out);
+bool mlx5_esw_get_spf_disabled(struct mlx5_core_dev *dev, const u32 *out,
+			       u16 vhca_id);
+int mlx5_esw_pf_enable_hca(struct mlx5_core_dev *dev, u16 vport_num);
+int mlx5_esw_pf_disable_hca(struct mlx5_core_dev *dev, u16 vport_num);
 int mlx5_esw_host_pf_enable_hca(struct mlx5_core_dev *dev);
 int mlx5_esw_host_pf_disable_hca(struct mlx5_core_dev *dev);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index c229a96a111f..59446c444570 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4961,10 +4961,11 @@ int mlx5_devlink_pf_port_fn_state_get(struct devlink_port *port,
 				      struct netlink_ext_ack *extack)
 {
 	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
-	struct mlx5_esw_pf_info host_pf_info;
+	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	const u32 *query_out;
+	bool pf_disabled;
 
-	if (vport->vport != MLX5_VPORT_HOST_PF) {
+	if (mlx5_eswitch_is_vf_vport(esw, vport->vport)) {
 		NL_SET_ERR_MSG_MOD(extack, "State get is not supported for VF");
 		return -EOPNOTSUPP;
 	}
@@ -4976,11 +4977,19 @@ int mlx5_devlink_pf_port_fn_state_get(struct devlink_port *port,
 	if (IS_ERR(query_out))
 		return PTR_ERR(query_out);
 
-	host_pf_info = mlx5_esw_get_host_pf_info(vport->dev, query_out);
+	if (vport->vport == MLX5_VPORT_HOST_PF) {
+		struct mlx5_esw_pf_info host_pf_info;
+
+		host_pf_info = mlx5_esw_get_host_pf_info(vport->dev,
+							 query_out);
+		pf_disabled = host_pf_info.pf_disabled;
+	} else {
+		pf_disabled = mlx5_esw_get_spf_disabled(vport->dev, query_out,
+							vport->vhca_id);
+	}
 
-	*opstate = host_pf_info.pf_disabled ?
-			DEVLINK_PORT_FN_OPSTATE_DETACHED :
-			DEVLINK_PORT_FN_OPSTATE_ATTACHED;
+	*opstate = pf_disabled ? DEVLINK_PORT_FN_OPSTATE_DETACHED :
+				 DEVLINK_PORT_FN_OPSTATE_ATTACHED;
 
 	kvfree(query_out);
 	return 0;
@@ -4991,9 +5000,10 @@ int mlx5_devlink_pf_port_fn_state_set(struct devlink_port *port,
 				      struct netlink_ext_ack *extack)
 {
 	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
+	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	struct mlx5_core_dev *dev;
 
-	if (vport->vport != MLX5_VPORT_HOST_PF) {
+	if (mlx5_eswitch_is_vf_vport(esw, vport->vport)) {
 		NL_SET_ERR_MSG_MOD(extack, "State set is not supported for VF");
 		return -EOPNOTSUPP;
 	}
@@ -5002,9 +5012,9 @@ int mlx5_devlink_pf_port_fn_state_set(struct devlink_port *port,
 
 	switch (state) {
 	case DEVLINK_PORT_FN_STATE_ACTIVE:
-		return mlx5_esw_host_pf_enable_hca(dev);
+		return mlx5_esw_pf_enable_hca(dev, vport->vport);
 	case DEVLINK_PORT_FN_STATE_INACTIVE:
-		return mlx5_esw_host_pf_disable_hca(dev);
+		return mlx5_esw_pf_disable_hca(dev, vport->vport);
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.44.0


