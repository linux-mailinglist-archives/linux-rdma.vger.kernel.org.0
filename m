Return-Path: <linux-rdma+bounces-21100-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLtiBzXqDmrTDAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21100-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:19:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0738E5A3E27
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4143D30DADE9
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 11:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062B53C13FC;
	Thu, 21 May 2026 11:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KpLJ06Ma"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013001.outbound.protection.outlook.com [40.93.196.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C573BB130;
	Thu, 21 May 2026 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779361957; cv=fail; b=kluUBoUUC4F/NRla8hxcc9XCG28h630+4os5Wd/voAWL/Bd8m4v+bjNKprtKl/ZYLy78N61S2wJvF9xYb/Hixo6xx7SVmDN6ZR2YastB9WsvTo5se8yBQ6wnFYBqcUm2nVJk6wShYWCG2ITRPsQtVjYzZBuK0U1k1FLLX+9t5Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779361957; c=relaxed/simple;
	bh=fVc52RzxLBS92xGEylxU3Dui/np2jmaU1DLNh8BYkgA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nroYN2PNlvn+Ap1oosuPMvP68lkJoBzak9G7dLftipm/sQxwGnMrBT9OmctFerG8ousMlKgdiL7q37ioqo5bfqjKrbdPmHlcyeuRSoif07GWqld0GIoDLOC8gPEypq8wf1LunYIzHC/mNjQ0mWa5BEjpFQ2ungJOE81rOBuQ058=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KpLJ06Ma; arc=fail smtp.client-ip=40.93.196.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPcPPrfQ1uWyTR5CNX++mxLB9TuvQwwHwuFa0s8RZ/w6LdLVrG4S9TPORyd8RVI9NT/ck83Pt++Z9v8zrIoSbn8lLFHoLYJcsG0cVPe1evcceH/zi9Bk825Ke+MqTy5928o9sExKyYzqeL/dmXqowHNGna+kGr0589PKNHH7e6g4eSSq8+9Ik/6QagP+rPxn1xBURA2FPPgsPq4zV/qS7iuqUtWJs/5Y2bWfqgVrvg8G0h4kc+FFj3hEQCARR+MWVYa5YvwLqISqurGwJCoB6lmUPsIvdx05s5XbONoFzBooaRnsDnJ5KPABz+WH2wR0QdbQXETamy/g5yDklVEHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gZIGrwKPOyn+gBl1ZV3SbXYkPx6RdYEFNuzu99JYoc=;
 b=ob24fHapFyEoejZnJ9mKCTzAOdLGSFuUsELoQ/9ggCM6n2EXqofwhkAtcRsRkBPwwbdA5+339srDQ1VOuPI2SREwfTVltMrtDoThRK8zkgPGlIOIxgsEOqneoIimas6qB+FOQHOD9pk9quLgv4BeV6wJ47RY6mmj/vBUpL1EK1D/DATdITu5jPlQHGqQAEpWAc5N+6WWMcxfkGIZLrVDWI5OxxerrVyi4XnVi3yFyzxD0q3mLG8l2O/QsbuFaiDbX+m5XQAzmd9QJwNM8JUTDwQza7MAtkD2M7QhERxQqu+5rSKpfI3lxYWegxllEeGoTiB+FBmwCuvXkiuqZo/OzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gZIGrwKPOyn+gBl1ZV3SbXYkPx6RdYEFNuzu99JYoc=;
 b=KpLJ06MaO6+G4CYJzduf45U3nNzoywnd26xyuxgTIXdnrzbosX8yq/o1+l0o8x+iDUVEsgneY9KhW/fXWD+lAF7BUpV1Uai9s+1GsetSyZfVwQmSHq8Bp3tXFMKd2hyV5AllZW+Oxv0nvarTcXhpcVoTLYPfOTI3nWlD+X0vRRja02SDCnzpGSAAxHg0S22PXjWqX2UVqHdE+ftr1fp9sPQ4j4eniET+0/IL4RZ6D2uCi998GAP6W2ymY6on1NxbbFhVhyfGTuBQ2Ky9ESPTyZ8bjD86a8ai0NQhg8kWF6+g1+Uep7JdtKvUibYTNQXQqbU+PYA9XyJxE8dVBBJ3Zw==
Received: from BL1PR13CA0099.namprd13.prod.outlook.com (2603:10b6:208:2b9::14)
 by CH3PR12MB9283.namprd12.prod.outlook.com (2603:10b6:610:1cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 11:12:22 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::36) by BL1PR13CA0099.outlook.office365.com
 (2603:10b6:208:2b9::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Thu, 21
 May 2026 11:12:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 11:12:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:12:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:12:02 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 21
 May 2026 04:11:56 -0700
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
Subject: [PATCH net-next 07/12] net/mlx5: Map SF controller to pfnum for satellite PFs
Date: Thu, 21 May 2026 14:08:38 +0300
Message-ID: <20260521110843.367329-8-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|CH3PR12MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: f80caefc-9f76-47eb-5d1a-08deb729d47e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|82310400026|11063799006|18002099003|56012099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	7HTmJfkQsH8CyFArhPRFmXVkefIt2fLlMlR/Wn+skl+6vTs+IUwT2OnDokJsyslBGbA3AWT7VZ7vNy7XhoRp3slja7w3c2JFcvHHNv4mV/fXUyaBRtyuN0dhUcJexTI+nmegtz1XM+gGPfY19thatxHqhH9RDdtZ9GaEoyOvUsppE/zSDVYwNt1Lz4MaNvPR4OpmehiBYHbwGgsNdykVrz+EQj6uvDy9KbFuXMf6aaM2DSrP0uZdNOFxEDpBjRgTWNkpffaLsqUqq3gKigC+m0Jw+N+0W5SMoGmEAHulT51TYW1vsPdGlvPLJhPHUWHNpW4j2/AgMxxNrhVaVlSQSEw4CikdLeTd0ub+yuHaTn4tMysA3JVEz3MGc21eWXG6P3UMsBP0uqFd+YnFTuBUt+2r2nSpFOtPM2f1G1+qgtwYisFA5ndfLq4b+EOTdeyEGoFRnFZ8C8yr5rz/8Wbd3p7rGD5I5mYjCSRgDeQZOoif4HqcVtlapEUgwqmN4WK8PG0hTvrvT9nL98sNuHt2A4dVv9X+lTDoufqSQULLAoOI0Lh6Fd2m6KMOt068AOGsY3lD0pQm582fke8Yfu+hC/hZ/epelqA7gId4jEPLmE4Ij7prlIH9myuogrOXLssiYEDfZ7muoJ5GJyd+Mg7dx3e2NLb5x06jv93wu8VWoas32iBLlreNXIbfCkHDgpybUeDmQgEW8AnnS6t7XDW8k1pVMK3FkH+xWVFU4Z5h2P8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(18002099003)(56012099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j2yUNMNOElE4UKTIRkZ7ZSgNY6Gft3FaZWym8NJKGzMaQNsDE8c0ScZhz/9rT9b7QQ2BdG32vI9UEHWOXKwir9ElgxmLwS2DftuUxvyZOWGsRX5Ye8H4CqyuTsL2+SeHQWa1cyzddwcC3JisnvX7LJoNN8ekDXKkIY6w3tWXtDf09PBV/g3aARANvAvusTOA8g7tnwqfUASZjiSusBAp65H+VZD+bbATOAHa5v4CWL43o9jApiyPOP1trwQImV9O4euoy6MvlfRrICVYbYtXn5ie77iSMUoh5LyH7rlSxzf7Ew6g0BNom1zWy1ihBBQvGVd6ZCvfD7ILgEVfROx6wQqTrq0uOgY+NAt9Wa4RuRTVnTcsvO0OYaaKh59f3E4UXBmD0iuFqiSfoy03ccfMO6KgJX7HLbikcr8DNbU/sCRvqouFmuuc0vWOpJSRjPzx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 11:12:21.7885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f80caefc-9f76-47eb-5d1a-08deb729d47e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9283
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
	TAGGED_FROM(0.00)[bounces-21100-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0738E5A3E27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Moshe Shemesh <moshe@nvidia.com>

SF devlink port creation and registration used the ECPF's PCI function
as pfnum. Extend this to support satellite PF controllers by introducing
mlx5_esw_sf_controller_to_pfnum() that maps a controller number to the
corresponding PF number, and use it in SF port attribute setup and SF
creation validation.

Reorder the checks in mlx5_devlink_sf_port_new() so that
mlx5_sf_table_supported() runs before attribute validation, since the
new helper requires the eswitch to be initialized.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/esw/devlink_port.c       |  2 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c   | 17 +++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/eswitch.h   |  1 +
 .../ethernet/mellanox/mlx5/core/sf/devlink.c    | 14 +++++++++-----
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index d5f0101aa966..fddb108bcbff 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -125,7 +125,7 @@ static void mlx5_esw_offloads_sf_devlink_port_attrs_set(struct mlx5_eswitch *esw
 	struct netdev_phys_item_id ppid = {};
 	u16 pfnum;
 
-	pfnum = PCI_FUNC(dev->pdev->devfn);
+	pfnum = mlx5_esw_sf_controller_to_pfnum(dev, controller);
 	mlx5_esw_get_port_parent_id(dev, &ppid);
 	memcpy(dl_port->attrs.switch_id.id, &ppid.id[0], ppid.id_len);
 	dl_port->attrs.switch_id.id_len = ppid.id_len;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 8e2ac759d1f3..f734f9364b2c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -2129,6 +2129,23 @@ u16 mlx5_esw_get_hpf_pf_num(struct mlx5_core_dev *dev)
 	return PCI_FUNC(dev->pdev->devfn);
 }
 
+u16 mlx5_esw_sf_controller_to_pfnum(struct mlx5_core_dev *dev, u32 controller)
+{
+	struct mlx5_eswitch *esw = dev->priv.eswitch;
+	struct mlx5_esw_functions *esw_funcs;
+	int i;
+
+	if (!controller)
+		return PCI_FUNC(dev->pdev->devfn);
+
+	esw_funcs = &esw->esw_funcs;
+	for (i = 0; i < esw_funcs->num_spfs; i++)
+		if (controller == esw_funcs->spfs[i].host_number + 1)
+			return esw_funcs->spfs[i].pf_num;
+
+	return mlx5_esw_get_hpf_pf_num(dev);
+}
+
 bool mlx5_esw_has_spf_sfs(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eswitch *esw = dev->priv.eswitch;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 03c7582d7b95..f85be8e39953 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -891,6 +891,7 @@ int mlx5_esw_spf_get_host_number(struct mlx5_core_dev *dev, int spf_idx,
 				 u16 *host_number);
 u16 mlx5_esw_get_hpf_host_number(struct mlx5_core_dev *dev);
 u16 mlx5_esw_get_hpf_pf_num(struct mlx5_core_dev *dev);
+u16 mlx5_esw_sf_controller_to_pfnum(struct mlx5_core_dev *dev, u32 controller);
 bool mlx5_esw_has_spf_sfs(struct mlx5_core_dev *dev);
 
 int mlx5_esw_vport_vhca_id_map(struct mlx5_eswitch *esw,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index 2fc69897e35b..b6cecbcc392d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -265,6 +265,8 @@ static int
 mlx5_sf_new_check_attr(struct mlx5_core_dev *dev, const struct devlink_port_new_attrs *new_attr,
 		       struct netlink_ext_ack *extack)
 {
+	u32 controller;
+
 	if (new_attr->flavour != DEVLINK_PORT_FLAVOUR_PCI_SF) {
 		NL_SET_ERR_MSG_MOD(extack, "Driver supports only SF port addition");
 		return -EOPNOTSUPP;
@@ -284,7 +286,9 @@ mlx5_sf_new_check_attr(struct mlx5_core_dev *dev, const struct devlink_port_new_
 		NL_SET_ERR_MSG_MOD(extack, "External controller is unsupported");
 		return -EOPNOTSUPP;
 	}
-	if (new_attr->pfnum != PCI_FUNC(dev->pdev->devfn)) {
+	controller = new_attr->controller_valid ? new_attr->controller : 0;
+	if (new_attr->pfnum !=
+	    mlx5_esw_sf_controller_to_pfnum(dev, controller)) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid pfnum supplied");
 		return -EOPNOTSUPP;
 	}
@@ -306,10 +310,6 @@ int mlx5_devlink_sf_port_new(struct devlink *devlink,
 	struct mlx5_sf_table *table = dev->priv.sf_table;
 	int err;
 
-	err = mlx5_sf_new_check_attr(dev, new_attr, extack);
-	if (err)
-		return err;
-
 	if (!mlx5_sf_table_supported(dev)) {
 		NL_SET_ERR_MSG_MOD(extack, "SF ports are not supported.");
 		return -EOPNOTSUPP;
@@ -321,6 +321,10 @@ int mlx5_devlink_sf_port_new(struct devlink *devlink,
 		return -EOPNOTSUPP;
 	}
 
+	err = mlx5_sf_new_check_attr(dev, new_attr, extack);
+	if (err)
+		return err;
+
 	return mlx5_sf_add(dev, table, new_attr, extack, dl_port);
 }
 
-- 
2.44.0


