Return-Path: <linux-rdma+bounces-20553-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK+/H6kcBGpyEAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20553-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 08:39:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C4552E2B4
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 08:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE0FD30BA242
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 06:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B843D4129;
	Wed, 13 May 2026 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jGFmZXDD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011015.outbound.protection.outlook.com [52.101.57.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CABC3D45EC;
	Wed, 13 May 2026 06:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778654271; cv=fail; b=T8gUvw9YG9lXHvnAKWTK054bEPrD/ARS5MDvo09fICf1LBJBgYXbsIvpsIL1PA7wlY+8t/woZHPTCgu/7nB0ByXtmjjx/Fr7urkjtatEnW6zu5quEkPkGiYEFDDHak85rqF8SvLmuzARL5P1bxTkhhGf2OFnVvuxLXq4gBCIvEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778654271; c=relaxed/simple;
	bh=Z3NET3hw5Mbo95xar5MzopKq5lmbKjV2xutRFPIeu7o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SxPsW1m1AFE0mbKXVxKN+8iGa/Ct8CqUlS+gEuUhPFSZ/jkhsgfKxTMJ9OpL/Rv4vF/fXMLTxlymlDFG5sl8UVUB71AeVDhD7/x9hq1gVJgfL6s/bXrEM/FcW5YBms8dqOtDzIChFBfeK4QA9cB4q1Gdc7N82/OE7wwdidJlTcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jGFmZXDD; arc=fail smtp.client-ip=52.101.57.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYkn1LKnBP83QukBaQZZAMy2Y567Eod2LR+J2Uvv8LCBmvdNR4trQ/HjxH85ki45W77XyJyG4wxBtpT33CUrZ2EkkPxg2TSEGhQJdaglBVQjmRf1lOt1XtJhfG6gMJ47rL1iel4qU4wXgMqLFRrATHGx7wt+cfc4Prp0TzpeS2VkqIOEhQLbr3AOY6tVx/lKVxYBZmhnsLVhROvNmYm3RXRIpjMSRJrgKGuXEZqTEw9NfbkUHq9Z05RSPWjJSo2xZBLlQZF6TxMKBqNNaDsHDMQpgEPBBOQSpC0HCkVycBfHG+Iv5V3Q297gwH+Ojvnp6FsnfrFefTMusaJrKRmcDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tG0Fyk21F93qqH0+MeGNnwPDWKFQ9NsGMdG1HMSmgFw=;
 b=uq2NZ2CoKykxhUmbhHk9svRfigVU3jLLCe6B9x7MET9AfqZhw9tnz4dQs/DeS+8we/Tx3S9j8G6e8On2FhTcI+kXLVXsuLTEjDIg3wF3vLW/K9xQ+Oc9VhTr5Xkwj5WGbLjA2BUyOV7W5rrkAECdZTJ1imIpCzC82EcPPjEYJ7ZjkDwTL0h3LbAEy6NFzyg/YCGJPYDfNCb3C1Lgqk/huwbK+kPqR1VKlI3yTcvQxTK6c1Qb5FGfHzB9Ax0bXgx8BrKtzo5pA0jcd4sJVWetLVCyL0P0VrBhnDQ/Rup8EyO/FonMmyXgcV/J6/SU5JRHObGTOwwOXHNo2uD+47OV7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tG0Fyk21F93qqH0+MeGNnwPDWKFQ9NsGMdG1HMSmgFw=;
 b=jGFmZXDDZdRcgSQ82fCVWBHD9IbeUChQPbNpDEhRt4kp7mHLO3M/QiKlrFp9xyRmP5ewD9dUhxs1jHLw2ygu8/pfxgypiRMXOkddDmgo5ZLeaTOKmbO1LGnSIXSYx56hMi/qWYyPmUfe5pvkNlOJD+wW8bZ6+ErmlsIrOTPwj69ST/+GfXqVfQ7LJyqMbb6gX/jaZE4UObBHih5/pTDFoYHFKT+weTw627iFuBDWiGIrqpoAHRJuQq1KlLA1cdjK1oxvXHGWNb3R39q8IEhkc8kY7q3aDLEVrTyKQeykl8w4IddlPDSn2qvn3J9J/D4HsGHjSDRps6G55DXaszVC2w==
Received: from PH7PR02CA0014.namprd02.prod.outlook.com (2603:10b6:510:33d::34)
 by PH7PR12MB6719.namprd12.prod.outlook.com (2603:10b6:510:1b2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 06:37:43 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::4f) by PH7PR02CA0014.outlook.office365.com
 (2603:10b6:510:33d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Wed, 13
 May 2026 06:37:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 06:37:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 12 May
 2026 23:37:25 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 12 May 2026 23:37:24 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 12 May 2026 23:37:18 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Parav Pandit <parav@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Kees Cook <kees@kernel.org>, Patrisious Haddad
	<phaddad@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net] net/mlx5: Skip disabled vports when setting max TX speed
Date: Wed, 13 May 2026 09:36:40 +0300
Message-ID: <20260513063640.334132-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|PH7PR12MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: b1041d1d-3099-485a-e617-08deb0ba22df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|11063799003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	svKSX1P2pI7XeVTTS1wb6XG7k4YuLArkmnBuYGc4gf2/ZnrE2jV/uK42MobGoyyEe3WIrWZzPp6I4mDNwuXdWg65a8eMGZcd9OBl7t4xu5MJkmsmjrLcgeo0Ucrgbe2WZwfbcqnUMHPxUTVQT9dBmx2HbbYnZkE0gC80zU2sknxmZMfl30194vw/2LobxAsGuH8G00yD0V0GjypuUmQYl0b67vWIeyg5rXagMPcPKU+I+lTGO49rTJ10SfaRBvpIYbgxOwfIpbcuYVCD0sIs6V0pywB830rNopZg7X6ZNHMVchk7nX1zdqLKXLv3yNatOn7ct9gLUdnXSPopflL7lD9jyo5kHZsn0VexJkKRNRalse6RhyYEn5eqC6vbz08VosD4aYg/QkoQOm18iyquOAsaxmHVBsoo6k1tqpIQS9m/NqKiCIChmf0Z0rMPu7G7SyRPkmXdRLdx9yOKFFln/8PXFjge4LAaP4+OzRMD2HlKeQ81dmccB9+BGeJvAG3Do24KKYpgm7xkqF9RnjC6g5sRHQfFwS0R9jm3+h/PuawWsnA2fLIopVgqh9hy2W7kyS6ty21EFVookcZwr7UaRrnJjs0WDqnE4m/qXHiHnmG13k79CFgdFG1QBeNe9FODA7e7dXpTwIeG8SNeS87XlMedKFXMoe2hfeZXF772s097xS4VGmQIoIjKiHS/t4crHb77Dbbk4iAfuoFx+k7i0OnG8adHxpfhK1HNTGym3pM=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(11063799003)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PrwMi8eUPZQ4SLskxuMjtPpsdHJJ01B9jDn2UGjTwkMM/1+vJSMKqkKYUQu4VdzlgwhONCJTyaC2VL68UTLw4KIFGwdlRXP8/7Hl/PhvqxQhLCKX2bg7p6j0v/gzXKxBoenbPAq8dVs697yOQY7IrpCRDAyRjErF4gX4WWLmYwx/7ZxIbtXvUEHZmpx2DMgzL3kZvkFpiFRX8wWWgdA7viQ4ZoHpyRF0NNSIiXkuXfLa61XTgKr1NeqTI6ze9XwSWC83AD2sgHZutmZIn6wnyG4iSoqnC6JzBHFTHRR84pPxVcHio1/2G5DpxVDpFtQMZtmaKDM8yO5oHETzCCy122/5LYJk9JrOwsUoGXbDN0MPwOXHDfMLdhrXYl7W+vXjg2t2KC0S5vY5B0+NCfarhW+YmfSZuKmpW8Ghajry6nMINeUY9RHCHeepZ+CH+HN5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 06:37:42.7438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1041d1d-3099-485a-e617-08deb0ba22df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6719
X-Rspamd-Queue-Id: D9C4552E2B4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20553-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Or Har-Toov <ohartoov@nvidia.com>

When setting vports max TX speed during LAG activation or bond state
changes, the code iterates over all eswitch vports. However, some
vports may not be enabled yet.

Skip vports that are not enabled to avoid sending FW commands for
uninitialized vports. Save the LAG aggregated speed in the vport
struct so it can be applied when the vport is enabled later.

Fixes: 50f1d188c580 ("net/mlx5: Propagate LAG effective max_tx_speed to vports")
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 21 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  1 +
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  5 +++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 123c96716a54..7c8311f41232 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -908,6 +908,24 @@ static void esw_vport_cleanup(struct mlx5_eswitch *esw, struct mlx5_vport *vport
 	esw_vport_cleanup_acl(esw, vport);
 }
 
+static void mlx5_esw_vport_set_max_tx_speed(struct mlx5_eswitch *esw,
+					    struct mlx5_vport *vport)
+{
+	int ret;
+
+	if (!MLX5_CAP_ESW(esw->dev, esw_vport_state_max_tx_speed))
+		return;
+
+	ret = mlx5_modify_vport_max_tx_speed(esw->dev,
+					     MLX5_VPORT_STATE_OP_MOD_ESW_VPORT,
+					     vport->vport, true,
+					     vport->agg_max_tx_speed);
+	if (ret)
+		mlx5_core_dbg(esw->dev,
+			      "Failed to set vport %d speed %d, err=%d\n",
+			      vport->vport, vport->agg_max_tx_speed, ret);
+}
+
 int mlx5_esw_vport_enable(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
 			  enum mlx5_eswitch_vport_event enabled_events)
 {
@@ -948,6 +966,9 @@ int mlx5_esw_vport_enable(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
 
 	esw->enabled_vports++;
 	esw_debug(esw->dev, "Enabled VPORT(%d)\n", vport_num);
+
+	if (vport->agg_max_tx_speed)
+		mlx5_esw_vport_set_max_tx_speed(esw, vport);
 done:
 	mutex_unlock(&esw->state_lock);
 	return ret;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 5128f5020dae..e9cf7c592ce9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -247,6 +247,7 @@ struct mlx5_vport {
 	enum mlx5_eswitch_vport_event enabled_events;
 	int index;
 	struct mlx5_devlink_port *dl_port;
+	u32 agg_max_tx_speed;
 };
 
 struct mlx5_esw_indir_table;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 449e4bd86c06..f8e70ac5a85b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1274,6 +1274,11 @@ static void mlx5_lag_modify_device_vports_speed(struct mlx5_core_dev *mdev,
 		if (vport->vport == MLX5_VPORT_UPLINK)
 			continue;
 
+		vport->agg_max_tx_speed = speed;
+
+		if (!vport->enabled)
+			continue;
+
 		ret = mlx5_modify_vport_max_tx_speed(mdev, op_mod,
 						     vport->vport, true, speed);
 		if (ret)

base-commit: f5b2772d14884f4be9e718644f1203d4d0e6f0d6
-- 
2.44.0


