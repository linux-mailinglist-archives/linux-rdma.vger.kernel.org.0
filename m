Return-Path: <linux-rdma+bounces-21103-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qH4KAdPpDmqwDAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21103-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:17:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE92E5A3DBC
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7DAC306DD02
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 11:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA83E3C37A6;
	Thu, 21 May 2026 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E/r+JIzQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872933A544E;
	Thu, 21 May 2026 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779361965; cv=fail; b=Z+BPWEtvfoIUALw1TMfvt5upMcqvPzJwKQAOMSZ7bRwM/66dbqUIs2GGj1NBgXt0QRMBP+SKxBd/J9m7RIVff66ISlJEBx6esMv5n7VrLlP3FAo28TR9OryE9Z3suEWnAPBYs/qLpE11NiHcAwyxhm4xk7wdmCPoHTOf+/DUvkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779361965; c=relaxed/simple;
	bh=eSjTt/mzKr4wgydF8eJh/D34UUS68cArNplnrxv6Gqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYG1gbLsrRJs9BKGr5oGXehV0uoneOB/cK6QB9gJzGr+MW0aTDfgl1ziymPgOUwqUGR82rEQzdBv2xRrgu+sNjEWmWInVkImKhP7qOwi4Y9xQRlmzlGyu0UbBUtXD/6GK4K09yr8V/7FBpTvlzW681fAdzjbLh3nKQPnb1EoLkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E/r+JIzQ; arc=fail smtp.client-ip=40.107.209.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3A3ARmucL5gTAYrRnMMYwFTNUH2fS/xIupjEPTTopBf5YlKLKZBkM0HiYwbR0IwqTquu08BrUuLFzOpxi8MYRyGW+xnH6JDSrvWQkhxXp9cIG7OsjzwgBP2/whV5JY2TKyjeM4iA5XKlnWnziDxXzNypNO2g7rp5J7vMal3rRm9s8NbqOSlj5wfWKW8DKwRWmLJtpSkUoHCkpBKbwSOU+MNf2hKEuQj3v7X2Y9qfH+KepUVGf1iYgK3qMw7p/+gauVzkSBUEEOi709DfRw0sKDjprrI+bnQ9luCPaLlc5WvSw0zU9oLNoHAzHAa5uzYVyFnpPR3Z/BKLlOUPGXpfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPlquY1pqOo4e6Ntmn9sYVF3ZD4euq/qrjpgCgRdA5Q=;
 b=EVhgj7UPVMLcj2vhkqV/56Zdv5JarqNl/JThyprhtQnZglfS1TsKTPiEtoz2zCfGaRdbXbaMQGR4QiNfnospJ5OwBoRQ00kOnHizD4gXmuCfzSqdznilZhYpym6Ju1ymahYVIszxVKaZZ0C0MkYKvIHKdy70tpY1Z7jG/c59M3tBgVGgiwbYctHWmNHYjGVAZSsMp58uJDUFCxhp30XG/C/omtXCbEdZQpEHnw1U6Qov1YqmFqmGQsrdYBdoSYccxGLVcWj0X9eIzrpA4TC9SfRpGem/DNnLiBBQ8CohFIgHE93eG1Pp4jeFwg/mBE/I0199t4igNLQM5e3xCwPaRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPlquY1pqOo4e6Ntmn9sYVF3ZD4euq/qrjpgCgRdA5Q=;
 b=E/r+JIzQZmuXztaLwYdsISvGLZEBc+vgc9VquWobVObIRa9jQQoigvp8VAFC37I2rz+ZDSVhZCwxSzaPdcIjmvjhsX4gMOTSSnD9YVZf+H0lDqH3afiKP2HNENLTj78qfkDOgtXnGCQ+bycn8MSelmn2hfam8Iz+sxgyLSp7kvKzRcsfUhao0IjGfyOeGfsTdzStbWJE2axEgy4wVmV+CJn3MZtcNAAg2h3d7TsyvhmfSh2/R9zMQvbJwR/QeX8apY5A7xPR+Czu5LlCmvBwFvM9x3ucQxHS//wwelMTrhYLtg7LR4GmR+AXKaKqj8+MniSYDAcfLo0FrtfBQmZbjw==
Received: from BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::15)
 by MW6PR12MB8959.namprd12.prod.outlook.com (2603:10b6:303:23c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 11:12:35 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::88) by BY1P220CA0004.outlook.office365.com
 (2603:10b6:a03:59d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 11:12:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 11:12:35 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:12:15 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:12:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 21
 May 2026 04:12:09 -0700
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
Subject: [PATCH net-next 09/12] net/mlx5: Register SF resource on satellite PF ports
Date: Thu, 21 May 2026 14:08:40 +0300
Message-ID: <20260521110843.367329-10-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|MW6PR12MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: 00061c75-2307-47c6-0d65-08deb729dc86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700016|1800799024|6133799003|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	wgUTrl5Zy43XIGb4HqE+ocwC9ESq27+YsfGnFvoxeIFsBGbCKzXgoCPS3B5EDNzm4pX4t9GK7RHEoK/yfTgxyMyvfQZLRuU1j1WY331udxfMkxrFRxVp8brZi5JWxAp1LiPE+weCf6G47oPircLa9APtkeB6F/kbImsBQVv4qFu+Tk8YEkdlMgx7eLMW495tGV12/XA0O+xAyocx7TbJeOrdM2HCs4lGljWti7wQdJr0DXaEqIcDuE9/XeB/BUyQ/4n3QfiUK/6W4U/VpdsNqyyK297SkTmS3ciniiEvKfLPu7Q/qLq3ql9uGGzbS73cBtupXBRi4DWTSdR5/jUJSIhLXIuUczKnjFuW63gV/qm/lUN6BdGZvUBbDW6xxVt027Yd+VUeXZEI+pCzG9XrftJbBD6pnKfq2VsX4ucQ3w3RzEkflLJBN/AEx8VgIOmhimhOLkL/VQtf6/NMp4BT8OhXpwzryj72hebyogGZoixVz/9gE72fvkqyZIh/9wKanmVlFoe2ZUZrGE58D/e3iziEus/WIj486EkPKRkEEmkNNAHUqS+gy9/4fLu7AJfMfIyGd3cUW8lgwIwit0nun197FIlNDo5CLgY5F4CtJb9E+wjM4gO3GA8FDLg8Wxos0HIXPt9BJAjzKUakpIG0t3mtmflonMjCdkVZwdHQsJBLrZ8bA5iShzh5UOSdmtWXbfwj7TVuCHsjwxsXeqInDhV1BdpX+a8xUNsVro7MIv8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700016)(1800799024)(6133799003)(11063799006)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xuJZnwLWaXvYKDLnZYC2iN1MCVTIoSz1uWjJbWDO43JlV9t1Wmkts25k77+aivdQiqViUouZHE3t7x2a45p0Am8IP4Nk9lSS1WExEAvqNsvDC+rRcLircwlhhD5J960Ox1Y+lu3dZ1nQ0q/lc/ZKIObdTDezFn1uVZEC5YT4/8Z2ebS4oVezNvwy8Y5X1r9Gbh8zCJRo2oih/38q7DpxSV6uhOeg7zQFZnvlck0G9YAZkz6+AXPujFUdx/lDFPmgG9KKmNieDDNJhR/olurK1Pj2hZYmuNQTgBo83ihhW+a8Q0T8C2+WMrrQIdX3ifH3/WUCjrI/BC4DjlYOTKM//Al/uGwgGL/UBP9YRhZd0Jm8qOqzW1qH40x9EVEPE0KyRVXD9xXslmO06TbnOtwK90QRZYKtU20R3ObjXlMJTEslHl0/ei3adNqTsmGXfT5y
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 11:12:35.3165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00061c75-2307-47c6-0d65-08deb729dc86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8959
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
	TAGGED_FROM(0.00)[bounces-21103-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: CE92E5A3DBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Or Har-Toov <ohartoov@nvidia.com>

Extend port-level resource registration to satellite PF vports.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/esw/devlink_port.c     | 31 +++++++++++++------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 05d89769b917..6e50311faa27 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -176,14 +176,28 @@ static const struct devlink_port_ops mlx5_esw_dl_sf_port_ops = {
 };
 
 static int mlx5_esw_devlink_port_res_register(struct mlx5_eswitch *esw,
-					      struct devlink_port *dl_port)
+					      struct devlink_port *dl_port,
+					      u16 vport_num)
 {
 	struct devlink_resource_size_params size_params;
 	struct mlx5_core_dev *dev = esw->dev;
 	u16 max_sfs, sf_base_id;
 	int err;
 
-	err = mlx5_esw_sf_max_hpf_functions(dev, &max_sfs, &sf_base_id);
+	if (vport_num != MLX5_VPORT_HOST_PF &&
+	    !mlx5_esw_is_spf_vport(esw, vport_num))
+		return 0;
+
+	if (vport_num == MLX5_VPORT_HOST_PF) {
+		err = mlx5_esw_sf_max_hpf_functions(dev, &max_sfs,
+						    &sf_base_id);
+	} else {
+		int spf_idx = mlx5_esw_spf_vport_to_idx(esw, vport_num);
+
+		err = mlx5_esw_sf_max_spf_functions(dev, spf_idx, &max_sfs,
+						    &sf_base_id);
+	}
+
 	if (err)
 		return err;
 
@@ -232,14 +246,11 @@ int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, struct mlx
 	if (err)
 		goto rate_err;
 
-	if (vport_num == MLX5_VPORT_HOST_PF) {
-		err = mlx5_esw_devlink_port_res_register(esw,
-							 &dl_port->dl_port);
-		if (err)
-			mlx5_core_dbg(dev,
-				      "Failed to register port resources: %d\n",
-				       err);
-	}
+	err = mlx5_esw_devlink_port_res_register(esw, &dl_port->dl_port,
+						 vport_num);
+	if (err)
+		mlx5_core_dbg(dev, "Failed to register port resources: %d\n",
+			      err);
 
 	return 0;
 
-- 
2.44.0


