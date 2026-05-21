Return-Path: <linux-rdma+bounces-21097-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA7HKEHrDmqwDAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21097-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:23:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEF65A3F65
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B08E308E87B
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 11:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3F53B27D0;
	Thu, 21 May 2026 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nUil3cBX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010050.outbound.protection.outlook.com [52.101.193.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2253BB9E3;
	Thu, 21 May 2026 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779361932; cv=fail; b=QM2OTa+AdfRm0qlY0KZsdKIUKCO8GyR6C9ec1L363Id6KJQyoDbFww5sOLOK5aLm+EXZiws5QCrvKuQ7tzk9fhqGRAhxhuafyAGsq3jzuWBO/+xCr0Kjab41XyMkHkaJ9OQhBaC+bzju2R0JIUny98cVWtwXW+PvxuxGx9T/PC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779361932; c=relaxed/simple;
	bh=TgHXHmUmbwbAR8UDaQo7K6lEtlVIO49PoML/b2OqXe0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ucjanu8erhF7UvUrR3g7BhVsQb5q4wLylIAXxKLzIt2ttdU03yxiEO7rfU0vdtMbAg1ZKrUUFEL4DCe+RN8HalTd+X+RMswlPYyivK3UXQKVT38oCwVAoWoJeHTPXhj9q+7dLgqkDvXBDDrLCcNzDNW+7bd6DcRowdlrBih53nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nUil3cBX; arc=fail smtp.client-ip=52.101.193.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5Y7lf91VOq3quo6yBzvib2hLI/Yo/hStjGyVlpjmXSpV7QabY3iGHxxpgA4reYM1v2yGgAsiUkRfqI4zQJfOp90gRiN5SnrJhBrd+djf69XRJ7l4HkwlOk6kRdIeTtE5beCaqUs0x6isMcSVZIhQT9Ui2Tlva0Z/uC6drv3EhYUbfItUTI5c0bpJyVIzSZcFjwZ4bvEu/i9/swsV/dgKz8a5u/Vd+Fg1UFl3fBE0S8ZCumk08kiuSGBsGQsKK0WsCaD3qa4nVIHRAwjPIofGx0ihlBqUsLh12oLgtCsh6ePCW1wPB4f4GJXs0PNfUTCjPbr+nW5oAvvBT97/K19bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iErXhlZpoK89BNKE/hUJ2Xu63AHLn3hvuS2ZHg101oY=;
 b=Q53cypY1gx+rZrqDZo9kyLT8IlUWNYxclAR1ohmY3RdPVzB6yXKV6vgd7azTP7cYl6R6jQ6y1mu2T2HFwe0+0FccOs+1IW1TN4imhSAHkqzGKXg95ubgP0quA/UdjKw/rWr6Pu+VYXzXfrPLEJXLhbwa3swFO3YFx5yabXIDkOVR1QNVzzggiZeDxu7q6BjZWJnoI3i79aY8M0Q+nf6vcCVZe+nlj7mar9rsEpBzskPMDpsgYlJV7XTkyuoRalzUF1Gx+2PKoZnYCyLIQ1IoXBSknjNrZDH4iaf0l7B5KMMjYtfX8zfjDdHjp/Fa/DVHCmlTBkYiey1p1yv6Q+t4qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iErXhlZpoK89BNKE/hUJ2Xu63AHLn3hvuS2ZHg101oY=;
 b=nUil3cBXHwvroO0xi0ZpYP8n9mUepzo7Ze3r14wWaEBIzGghuEKU0Ox6qk6ruvU+Qu/c2azgTDoSlgnOb8ZznloJOKYg2ZG1JYbwElC/qjzMY8XP4/vFSTArxqtviJ42BOVEByKQD85BicL7/0fA9d7QnYNsSQhD8oFjn9BvJ52PKsTREtbtJGiA7BT1S6FaXCew86VFf+BR0cJsbTV/+inie64Gy4xvTgRrbcnkh0+55wDXF5d3YBPQfHjV6j1I6v+AHM9MBoo3roIVzsVrCDIfo3n4m+N71KBrRPlxlmG8vUlcW3RQ+lHNM5qT1kLlQNFUzgevzVhhVpWvc/jEoA==
Received: from CH0PR03CA0225.namprd03.prod.outlook.com (2603:10b6:610:e7::20)
 by LV8PR12MB9111.namprd12.prod.outlook.com (2603:10b6:408:189::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 11:11:53 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::fd) by CH0PR03CA0225.outlook.office365.com
 (2603:10b6:610:e7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Thu, 21
 May 2026 11:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Thu, 21 May 2026 11:11:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:11:36 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:11:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 21
 May 2026 04:11:30 -0700
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
Subject: [PATCH net-next 03/12] net/mlx5: Initialize host PF host number earlier
Date: Thu, 21 May 2026 14:08:34 +0300
Message-ID: <20260521110843.367329-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|LV8PR12MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: 70368ab4-96d1-4e71-bb64-08deb729c39b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|56012099003|22082099003|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	oHYENmYdtJw7W6jHjVa8dP4Jl7g8StYZBmPvQ1qXX2CWInsmiXR0CRns3OCrmrQ4wVLyd0i58LOZYVOF/bunJYvqCt7DIslfDFsUb5yYXSUzIBHzMBs9AZMntQzxhiLmKHx9p3TxOPZJyC/uEQ6rhdwhmvsJHHEw1yS8uTibiz2yWoLjZHrg0Yi6LbjzSmWXqIMIanuqjzdTJr1tl8bzHIkS0ybTGwfYjcvcPC0yidVaa7D6lEtJdG2H4dNtAkkXvMwjWGqwHBjRsKbswNYxAdnFtyL6nUmwwRditAThkk1SRIxE785SQQGzd5aJ7ujeiFYM8o6I9fMJ99/JIEx7evZ/mwMoq06PMI6WcHmQjHaQR5ap1a3E7HXXBRNsGbA0nOn2WlyKtYiL2kw2aJNNyqPDnzM/Sf6Nv3y/4dHdJ4xwJqjapsG8mRdGLLaMXkMQLECPQ8EkowMPoAL1bmLW+4r1AVWo7fG+/wB6K6jr5y7HKm7mPRw3PK7Jn+o5zrTEhTVoOqYF5pq0hieV/fkrjbhVmuvHuQAMjmkhRInGpz4ZA0S8soa95yoCKVJ10UPem+59Zt2UUh68yp0QAP6ff53oqhREcZyrhp0SvTtkh9ysaNdbRp8wF5ee9kx/CMc4ahwH4HpcWsITP1R0N2I2UIbaVkoGi/Ci7yu/Naa3vuaj1Gy5V+sUR8YUwugX+p4PMxCsXNhIzv6ZbJzTDyn0QyXCr3J6VHUizRa5bLEmaTI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(56012099003)(22082099003)(18002099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EMwaFTP4ylj4ktp6ExvTH0Xm10Fdiq+zIgIr6UaIUQdPvJJyK1Nb4dQABVHADE+FtbrU1Hrd27ZXWF5asl52hYa8814VIx6leUd1HVRZJeiaBNCVLZPkZ8wxEFsMyPn3c2H+NhvlLj8kp0kYBBELtMbjyEjH1oy6u06jyRxLMHsOmuUzYmkB367azn5IXwHGFGYVKRLHLoFjyhHFvzhcR8h1FCzcYlwTXUgX9/HgEbRQ78FvOxe4i1+O7hFrtMcdwhnGEv/U/YpKjlRXvL/NVFRA7M6f7NOJoqEEfvXDlvgorl0hHloWC1OArofBTTwvoaQipSdm5FL6N4iXoch2fIfqToMRH+GX/9/MuDMOf/bDFRRXFXT6AvO6O5GcjJLV1BrVEgHqI1oCtuALiOoT9ncMcFUeOj1BCtVQznLPEC/586qZwBo4LKuOqvHbrVJA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 11:11:53.4809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70368ab4-96d1-4e71-bb64-08deb729c39b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9111
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
	TAGGED_FROM(0.00)[bounces-21097-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: DCEF65A3F65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Moshe Shemesh <moshe@nvidia.com>

Move host_number from esw->offloads to esw->esw_funcs as hpf_host_number
and initialize it during vports_init instead of offloads_enable. This
makes the host PF host number available earlier in the initialization
sequence, which is required for upcoming SF hardware table support for
satellite PFs.

Add a mlx5_esw_get_hpf_host_number() accessor to retrieve the stored
host number.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/esw/devlink_port.c     |  2 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 33 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  4 ++-
 .../mellanox/mlx5/core/eswitch_offloads.c     | 25 +-------------
 4 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 0730f0c883fe..e723f05cd4d3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -34,7 +34,7 @@ static void mlx5_esw_offloads_pf_vf_devlink_port_attrs_set(struct mlx5_eswitch *
 	pfnum = PCI_FUNC(dev->pdev->devfn);
 	external = mlx5_core_is_ecpf_esw_manager(dev);
 	if (external)
-		controller_num = dev->priv.eswitch->offloads.host_number + 1;
+		controller_num = mlx5_esw_get_hpf_host_number(dev) + 1;
 
 	if (vport_num == MLX5_VPORT_HOST_PF) {
 		memcpy(dl_port->attrs.switch_id.id, ppid.id, ppid.id_len);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 815538ba754f..f9085b8dc20b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -2062,6 +2062,35 @@ int mlx5_esw_sf_max_hpf_functions(struct mlx5_core_dev *dev, u16 *max_sfs,
 					    sf_base_id);
 }
 
+u16 mlx5_esw_get_hpf_host_number(struct mlx5_core_dev *dev)
+{
+	struct mlx5_eswitch *esw = dev->priv.eswitch;
+
+	if (!mlx5_esw_allowed(esw))
+		return 0;
+
+	return esw->esw_funcs.hpf_host_number;
+}
+
+static int mlx5_esw_hpf_host_number_init(struct mlx5_eswitch *esw)
+{
+	struct mlx5_esw_pf_info host_pf_info;
+	const u32 *query_host_out;
+
+	if (!mlx5_core_is_ecpf_esw_manager(esw->dev))
+		return 0;
+
+	query_host_out = mlx5_esw_query_functions(esw->dev);
+	if (IS_ERR(query_host_out))
+		return PTR_ERR(query_host_out);
+
+	/* Mark non local controller with non zero controller number. */
+	host_pf_info = mlx5_esw_get_host_pf_info(esw->dev, query_host_out);
+	esw->esw_funcs.hpf_host_number = host_pf_info.host_number;
+	kvfree(query_host_out);
+	return 0;
+}
+
 int mlx5_esw_vport_alloc(struct mlx5_eswitch *esw, int index, u16 vport_num)
 {
 	struct mlx5_vport *vport;
@@ -2211,6 +2240,10 @@ static int mlx5_esw_vports_init(struct mlx5_eswitch *esw)
 
 	xa_init(&esw->vports);
 
+	err = mlx5_esw_hpf_host_number_init(esw);
+	if (err)
+		goto err;
+
 	if (mlx5_esw_host_functions_enabled(dev)) {
 		err = mlx5_esw_vport_alloc(esw, idx, MLX5_VPORT_HOST_PF);
 		if (err)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 19419799a26d..abdb4c460b06 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -332,7 +332,6 @@ struct mlx5_esw_offload {
 	u64 num_block_mode;
 	enum devlink_eswitch_encap_mode encap;
 	struct ida vport_metadata_ida;
-	unsigned int host_number; /* ECPF supports one external host */
 };
 
 /* E-Switch MC FDB table hash node */
@@ -359,6 +358,7 @@ struct mlx5_esw_functions {
 	bool			host_funcs_disabled;
 	u16			num_vfs;
 	u16			num_ec_vfs;
+	u16			hpf_host_number;
 	struct mlx5_esw_spf	*spfs;
 	int			num_spfs;
 };
@@ -879,6 +879,8 @@ struct devlink_port *mlx5_esw_offloads_devlink_port(struct mlx5_eswitch *esw, u1
 
 int mlx5_esw_sf_max_hpf_functions(struct mlx5_core_dev *dev, u16 *max_sfs, u16 *sf_base_id);
 
+u16 mlx5_esw_get_hpf_host_number(struct mlx5_core_dev *dev);
+
 int mlx5_esw_vport_vhca_id_map(struct mlx5_eswitch *esw,
 			       struct mlx5_vport *vport);
 void mlx5_esw_vport_vhca_id_unmap(struct mlx5_eswitch *esw,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index b06b10d443bd..f17db51abe2d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3819,25 +3819,6 @@ int mlx5_esw_funcs_changed_handler(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static int mlx5_esw_host_number_init(struct mlx5_eswitch *esw)
-{
-	struct mlx5_esw_pf_info host_pf_info;
-	const u32 *query_host_out;
-
-	if (!mlx5_core_is_ecpf_esw_manager(esw->dev))
-		return 0;
-
-	query_host_out = mlx5_esw_query_functions(esw->dev);
-	if (IS_ERR(query_host_out))
-		return PTR_ERR(query_host_out);
-
-	/* Mark non local controller with non zero controller number. */
-	host_pf_info = mlx5_esw_get_host_pf_info(esw->dev, query_host_out);
-	esw->offloads.host_number = host_pf_info.host_number;
-	kvfree(query_host_out);
-	return 0;
-}
-
 bool mlx5_esw_offloads_controller_valid(const struct mlx5_eswitch *esw, u32 controller)
 {
 	/* Local controller is always valid */
@@ -3848,7 +3829,7 @@ bool mlx5_esw_offloads_controller_valid(const struct mlx5_eswitch *esw, u32 cont
 		return false;
 
 	/* External host number starts with zero in device */
-	return (controller == esw->offloads.host_number + 1);
+	return (controller == mlx5_esw_get_hpf_host_number(esw->dev) + 1);
 }
 
 int esw_offloads_enable(struct mlx5_eswitch *esw)
@@ -3867,10 +3848,6 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 	if (err)
 		goto err_roce;
 
-	err = mlx5_esw_host_number_init(esw);
-	if (err)
-		goto err_metadata;
-
 	err = esw_offloads_metadata_init(esw);
 	if (err)
 		goto err_metadata;
-- 
2.44.0


