Return-Path: <linux-rdma+bounces-21556-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFRcKvceHGr0JwkAu9opvQ
	(envelope-from <linux-rdma+bounces-21556-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:43:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 515D3615D4F
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16ABB300E17B
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 11:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993DE38736C;
	Sun, 31 May 2026 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CBY/0cd9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15066387346;
	Sun, 31 May 2026 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780227693; cv=fail; b=p/tp74uw6DPbqnsoj2y8Ap2C8TFGMUcPCQAj3J/15rWO3PknUyXq1DmPNqH5U+4TiJOmG6ya5t/5UuA/HZUiad+bnuLpK8dAPHnOY7a5ZLgUudAnHioO4dmAfbVHZDgFab2vJdqBixfclvnm2jiybKftqYb/5XpAdoIiRnHkyTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780227693; c=relaxed/simple;
	bh=AB3uEH9dFvhA7iaeyyJ9iAUnoEfIYuhtc7cKP6GYTUw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORrMiABSRpi87g2lXHhpryOuwvRQ7zBg17pQVUNZvwLhrz0D6T5mBefRYcba7Kgd6VeNUrj/tPxIRjdjN5MYATgmQA9SJx37tS7ONY0q1AuKOCzZGSuVDAdEaQIArl0HyJQik+ayoOZqvIkCZDe/0Pjqt+U1exK9jBZm490dEu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CBY/0cd9; arc=fail smtp.client-ip=40.107.209.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGeeBhAHXc5+VkPtlKebrqJkQHMlqNUx6ipPmNSgigQcHOf4+qdbeIe4yVyesxu5RLvpbyCZ2TUJTuqDnHm1819BaI5pl+t73us1shW/7YMnfuYinwO8GBwZ+5mNxSETPth+Y0nuwk6v/dZ1YijBKz3uxoIp2yGZub/7Vd7okrKw/7Wx+zenvMDvZ+lBoCbTeOtxWyIU/BFRDtB4A4PP92m8oX+Eo7p3/ji1s8okv0aFEfA66OuqrroZefiNwWHfsgN2dk/jQCb/K3OE8fvUvWop3bJqEFRgQ+xa9heTOnYPAGBraoO2co2rSaZjLrYvWSXRUt9W9g76FM/plHhNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+FE2Rfxfwt/67fFxQINumF5g/yJElwrdMiLljIAXlY=;
 b=xQu9ZNZhxp67EFAu8k9e/O3Or/DSXZ8Ush7WqU5JN5XhxhNVemVhL7rokolEauVVRHjjWvgW9AjcqnqGX9oH9N4bW+bifmvACT/Nvq/0hjY24qQp8+Up5HSDg9jf2ATUjOUbhYuvkwIE7HbaRhEiIr/3j0aoIFu1yd5pEwfV3aAsLqlfDTot1Ea/o9tPO9Hif2PVKqz7VOJXT2ZJYan7CvDEaVlaR8XvUnBll9WI8qOoI8ZD/os5oVswbDhJVYUcP3JFPWBBuC0g5sd3Zj2ooTE537hqDDNM0GZYquhOziOWfibFkQQX6a5CQG3v9zxIJhvJAB65ozM+F38CDP7okQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+FE2Rfxfwt/67fFxQINumF5g/yJElwrdMiLljIAXlY=;
 b=CBY/0cd9Ih359004BhnIZ5j9WIu9yx8n0Ccb5i6JJ7L1B9WnPgLFnd8ZjWdrfSmQ6NJfI/ZPGcnMjbWb3oF9ZIpTkTxy1eKPZDhlviCVUdzZDI8YCR5O8D4WHnOm8pncMA0I7lzod4sT2AI434NlyDBJFnLR4BPqLtP7TPyAbqm0aMbxdSt9A61kQBiHCJCg7OJ7AAjYBID3O+TGQAZRQpcb0eMtJWyjeo6UHaNeRRhbi9GTlyaS7Vz/tjLcYs3Mmty6/SU5hS0AVjtqRA2qHQEbdPdOfjDjajbnfnTB09kaduRC3M4KkTRbPS0eFdaSJdc5Q9FYKL44bEWSr5FjJw==
Received: from BL1PR13CA0283.namprd13.prod.outlook.com (2603:10b6:208:2bc::18)
 by CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 11:41:02 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:2bc:cafe::7c) by BL1PR13CA0283.outlook.office365.com
 (2603:10b6:208:2bc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Sun, 31
 May 2026 11:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sun, 31 May 2026 11:41:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 31 May
 2026 04:40:52 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 31 May 2026 04:40:51 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 31 May 2026 04:40:46 -0700
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
Subject: [PATCH net-next V2 08/13] net/mlx5: LAG, block RoCE and VF LAG for SD devices
Date: Sun, 31 May 2026 14:39:48 +0300
Message-ID: <20260531113954.395443-9-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|CY5PR12MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c2c0640-6d3f-480b-d694-08debf097d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|82310400026|3023799007|5023799004|56012099006|18002099003|22082099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	BAU/CEBTf5Gz4PmLkP0Imje0otIOSM7ShCxVFHxHCYFBPtFW5C0Dxceq6dWbu4dLdBjwBZQNfSUFqy2y6ZCKRL0K87SrC+yY40JK1TBFURw/GYcimGNFAeAcOLldEdZD8ve8vldLw5A6xuITUsGibxVzlcMnjntiWgFue+ej9SbBeBgDzvmPd9SY5kpSO+15OHpiPSczIc0zbqt83lOCnGibcoSobCi1RDjc9NPxlW9hNC/bLYD8lTYhPnII/QgkUlrzZK0NDLcEmd/OvqsvIhM3E0y2uIHj37iiCC9lmz/py6mwQPi8DSyiPP0Ok7Pe72a2cPNIblepL401PGObyR4uolcFyIIr6+6Qscj5EvlauCXfJtw2pTluiWKVyhHk5Hyt4Acnahl6ZxRAbHPuIH+KKn4w0YfA0XxvRhAL8pKvWkREOSOTpANYHLLeeAQlosOYXbau2UVijtPVH3fwBGe7TMEdtzjEpALvpmAVFjWPWHttUlTuMbprX86CSs8UkcQ4I1sZYpDWGkUkqy44kVzslaNaTCtTwVCAQYiLfJn4tljzPiDkspuSU0jjy7l8yS5I/OcflqVyiqiZ9oI6t8h5cPmmOleTVUcTdFxJoKxxsSJHgP97y+fL9KkvH8I8vZaopfzDUL57IZRRdrE3MilVQU83jXp1vT1hRusn6Au3o7FwElR8EC1GWxf27ukb6jI8rHS8go1q964gcDXXGvJym3/qIbiJME8GYEyrTdQ=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(82310400026)(3023799007)(5023799004)(56012099006)(18002099003)(22082099003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1NcDuRxY+OytMP3AGM/2mPQ29DotjiSa25WCwxxuq7i7d/L4pXapOCXrqP9Af/Pkot+Psw//LOKwoPBL32gydwkO6x1DEX6sYw5XxJr54gDIwMhO7zkBqLZe3H4Ith3ngg3Ql29/YLsS/qPKvu4LV6YCHDOIa0riijhr0ZAFJo1+f3dSpj0R5BNcREopuscqe/IkP/8aN9YDkyFdcmn7HbkKKjYl5BBywyMz5+CZN3tPO9PojLwH5G46TJ+qKu1IFzy/cVQNOEPMIAHX1Pcr8I+LzNuA0gh7cEm93xbwhKX4zD0839x9D/NTFP9vsuLI+9FY9YThuemuOb5/2TqoJcA/rxfKW+cdciTE2FtFjzrYuUo20liA+VYSBJoOCi4uX6GokHboN6pC93xsV3+/F/X080JAw02J5TMBDF7KsiavjE7vMAyjWBfWYLjeAlG7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 11:41:01.3497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2c0640-6d3f-480b-d694-08debf097d8d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6549
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
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21556-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 515D3615D4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

Socket Direct devices manage their own LAG via SD LAG infrastructure.
Block the standard netdev-event-driven LAG path (RoCE LAG and VF LAG)
for SD devices to prevent conflicting LAG configurations.

Expose mlx5_sd_is_supported() as a public helper that encapsulates all
SD eligibility checks. Use it in mlx5_lag_dev_alloc() to skip netdev
notifier registration for SD-capable devices at alloc time. Some sd
code is reordered to expose the new function, no logic is changed.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 13 ++--
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 60 ++++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h  | 11 ++++
 3 files changed, 63 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 3decb49e9f19..a2c7e2927431 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -293,11 +293,14 @@ static struct mlx5_lag *mlx5_lag_dev_alloc(struct mlx5_core_dev *dev)
 	INIT_DELAYED_WORK(&ldev->bond_work, mlx5_do_bond_work);
 	INIT_WORK(&ldev->speed_update_work, mlx5_mpesw_speed_update_work);
 
-	ldev->nb.notifier_call = mlx5_lag_netdev_event;
-	write_pnet(&ldev->net, mlx5_core_net(dev));
-	if (register_netdevice_notifier_net(read_pnet(&ldev->net), &ldev->nb)) {
-		ldev->nb.notifier_call = NULL;
-		mlx5_core_err(dev, "Failed to register LAG netdev notifier\n");
+	if (!mlx5_sd_is_supported(dev)) {
+		ldev->nb.notifier_call = mlx5_lag_netdev_event;
+		write_pnet(&ldev->net, mlx5_core_net(dev));
+		if (register_netdevice_notifier_net(read_pnet(&ldev->net),
+						    &ldev->nb)) {
+			ldev->nb.notifier_call = NULL;
+			mlx5_core_err(dev, "Failed to register LAG netdev notifier\n");
+		}
 	}
 	ldev->mode = MLX5_LAG_MODE_NONE;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index e341d814873a..8991db3a19cf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -115,7 +115,28 @@ static bool ft_create_alias_supported(struct mlx5_core_dev *dev)
 	return true;
 }
 
-static bool mlx5_sd_is_supported(struct mlx5_core_dev *dev, u8 host_buses)
+static int mlx5_query_sd(struct mlx5_core_dev *dev, bool *sdm,
+			 u8 *host_buses)
+{
+	u32 out[MLX5_ST_SZ_DW(mpir_reg)];
+	int err;
+
+	err = mlx5_query_mpir_reg(dev, out);
+	if (err)
+		return err;
+
+	*sdm = MLX5_GET(mpir_reg, out, sdm);
+	*host_buses = MLX5_GET(mpir_reg, out, host_buses);
+
+	return 0;
+}
+
+static u32 mlx5_sd_group_id(struct mlx5_core_dev *dev, u8 sd_group)
+{
+	return (u32)((MLX5_CAP_GEN(dev, native_port_num) << 8) | sd_group);
+}
+
+static bool mlx5_sd_caps_supported(struct mlx5_core_dev *dev, u8 host_buses)
 {
 	/* Honor the SW implementation limit */
 	if (host_buses > MLX5_SD_MAX_GROUP_SZ)
@@ -142,25 +163,32 @@ static bool mlx5_sd_is_supported(struct mlx5_core_dev *dev, u8 host_buses)
 	return true;
 }
 
-static int mlx5_query_sd(struct mlx5_core_dev *dev, bool *sdm,
-			 u8 *host_buses)
+bool mlx5_sd_is_supported(struct mlx5_core_dev *dev)
 {
-	u32 out[MLX5_ST_SZ_DW(mpir_reg)];
+	u8 host_buses, sd_group;
+	bool sdm;
 	int err;
 
-	err = mlx5_query_mpir_reg(dev, out);
-	if (err)
-		return err;
+	/* Feature is currently implemented for PFs only */
+	if (!mlx5_core_is_pf(dev))
+		return false;
 
-	*sdm = MLX5_GET(mpir_reg, out, sdm);
-	*host_buses = MLX5_GET(mpir_reg, out, host_buses);
+	/* Block on embedded CPU PFs */
+	if (mlx5_core_is_ecpf(dev))
+		return false;
 
-	return 0;
-}
+	err = mlx5_query_nic_vport_sd_group(dev, &sd_group);
+	if (err || !sd_group)
+		return false;
 
-static u32 mlx5_sd_group_id(struct mlx5_core_dev *dev, u8 sd_group)
-{
-	return (u32)((MLX5_CAP_GEN(dev, native_port_num) << 8) | sd_group);
+	if (!MLX5_CAP_MCAM_REG(dev, mpir))
+		return false;
+
+	err = mlx5_query_sd(dev, &sdm, &host_buses);
+	if (err || !sdm)
+		return false;
+
+	return mlx5_sd_caps_supported(dev, host_buses);
 }
 
 static int sd_init(struct mlx5_core_dev *dev)
@@ -198,8 +226,8 @@ static int sd_init(struct mlx5_core_dev *dev)
 
 	group_id = mlx5_sd_group_id(dev, sd_group);
 
-	if (!mlx5_sd_is_supported(dev, host_buses)) {
-		sd_warn(dev, "can't support requested netdev combining for group id 0x%x), skipping\n",
+	if (!mlx5_sd_caps_supported(dev, host_buses)) {
+		sd_warn(dev, "can't support requested netdev combining for group id 0x%x, skipping\n",
 			group_id);
 		return 0;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
index 2ab259095d7e..bf59903ab23f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
@@ -4,6 +4,8 @@
 #ifndef __MLX5_LIB_SD_H__
 #define __MLX5_LIB_SD_H__
 
+#include <linux/types.h>
+
 #define MLX5_SD_MAX_GROUP_SZ 2
 
 struct mlx5_sd;
@@ -18,6 +20,15 @@ struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
 void mlx5_sd_put_adev(struct auxiliary_device *actual_adev,
 		      struct auxiliary_device *adev);
 
+#ifdef CONFIG_MLX5_CORE_EN
+bool mlx5_sd_is_supported(struct mlx5_core_dev *dev);
+#else
+static inline bool mlx5_sd_is_supported(struct mlx5_core_dev *dev)
+{
+	return false;
+}
+#endif
+
 int mlx5_sd_init(struct mlx5_core_dev *dev);
 void mlx5_sd_cleanup(struct mlx5_core_dev *dev);
 
-- 
2.44.0


