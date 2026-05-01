Return-Path: <linux-rdma+bounces-19828-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCFHCxUq9GlA+wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19828-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:20:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DC24AA418
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2C093017D6C
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 04:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7CC3019A9;
	Fri,  1 May 2026 04:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JYV186V9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010047.outbound.protection.outlook.com [52.101.193.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A682F90C9;
	Fri,  1 May 2026 04:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777609123; cv=fail; b=EvlgRQ0pWK7vmk31iagmw5b1zakQPC5ymqL/JjPE4hpocTkNNFXKDIGbFpw4dE/WUjIHAmHtLSfSoqI5/Or4KyCr/wMUkSmzZChxCEgQHylHrBj7QqOwBl8NGsAvbdiq3TRCSrdlQ/HDGManvolIbgx0prAgTf4VxYf4cJLLI0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777609123; c=relaxed/simple;
	bh=vrq34g7znpO2Qqpqt8u3pmA9GpdXKpul7ekKj2S1sAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/cBlL/V5EB/ry5Nr3ChPYE3vf7GuXbdeZMcry4t3AkFHoftndEfd+RV+dfp//DJbVnpE/wX43Hp43S11tDa1RaVRwdBtUxSirm+3nKxUm6ZPM28GH+TvygBNKtNAK9UvciXbz6rDq5WpKWYGJveRpNNmmq+jkFheZDSw/gRWeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JYV186V9; arc=fail smtp.client-ip=52.101.193.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJww/h0X4yRnwaEoc9bn3Y0av2pwsgl70/suJwsE2bHG3KYJp0G6PJySLPvB3gmu8tjjLlOZXv4enM2GO/nWi8efpabj4KWsg0RGhgg2eX0Hbil1JdPCVLlRS+X6A+5JTHYGLVXbUwKrYZz9YSQ+p/dyVe+/4MjauTleaxi4IRMXNl7mgfBLxLEanmfzfxcHQTBVfioI1Yuo3c0ySILHR1r71XK+A67H+Tp+2ToPLVCX8AHdyeknUTh0sUhL25/Dx4V3ttonToTqCcSgqcR3BVEWBghxgUE2uRgio39oz898HbTgZ4Fd7iS2WilkeNkSC87WNaixpwy8TVHDIPog6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dfoD2jB6LcnrT0r4uXRYo/+TRabmPd4uF2DxjEJHQ4=;
 b=HC/O1jOy5eeMmqieZmjsMPliVJxCfbwsciQv1C9q1u7jKSnscVEhiM1KjeQNYTMNjCBI0PF03w4rZPLF+5IissrQaSfo349rrf4FIzHMWumbNsMGO1AAgpNYZfdk0KPQqd/m/zHyJE0e97Fq4YwwV+3V0RO6PQMPIEfY0GPh96egQBlbqOQDAYeXsPGyDPnAFXtBPQ+WwtEAQcamCX5vUrA9SwXRsP5xbZdezQfiE2UdZaeajeOjbFfE/VePwz7e1skQwP41q3FG1M9r5uc9k/Q6gT0PpJJi0//kA4UbwL2wKhpUKcO+tJGrPceO1RgNEw3QE/Bi6HO80mqjltX5gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dfoD2jB6LcnrT0r4uXRYo/+TRabmPd4uF2DxjEJHQ4=;
 b=JYV186V9vvcbcgk6W/abNXQMetaZXTmOUeBgfBhrxD5HYXaBiAdtzmJGI6vokXJqLJyD+tkKSHnPp7CD3bKrs7BC5+chnYUw81D6KpE3oB3ufAIHcnlfdN5LPmB57L8Gpy6RLJBApRNnSpY9K8A7kVS9K3du66cHXYgWfekA6bkITcImYKUAKtA7uWGfLPlFknwlwxVCwhXtPvNNhLDqFZ4d5TDliQjEnp5utmYh8g5t/AKuyb+dD/Ejgtr8s1BTICwTNmyOJk2x7ZotX/71UGEG5Dg0iq4CgHEY/oWEXNSdm4AJyRr/t7r4VdpkYonxHPmIhFxwX8C+TqqV200ung==
Received: from PH7PR13CA0011.namprd13.prod.outlook.com (2603:10b6:510:174::26)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Fri, 1 May
 2026 04:18:29 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::87) by PH7PR13CA0011.outlook.office365.com
 (2603:10b6:510:174::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.8 via Frontend Transport; Fri, 1
 May 2026 04:18:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 1 May 2026 04:18:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:18:13 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:18:12 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Apr 2026 21:18:05 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shay Drory <shayd@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>, Maher Sanalla
	<msanalla@nvidia.com>, Simon Horman <horms@kernel.org>, Gerd Bayer
	<gbayer@linux.ibm.com>, Moshe Shemesh <moshe@nvidia.com>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V2 7/7] net/mlx5: Add profile to auto-enable switchdev mode at device init
Date: Fri, 1 May 2026 07:16:33 +0300
Message-ID: <20260501041633.231662-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260501041633.231662-1-tariqt@nvidia.com>
References: <20260501041633.231662-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|CH2PR12MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: d110495b-e169-4bfc-2cd4-08dea738b29f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rQgVvqScC93/is3a+adR2D0Tas1y04X9Yq0HAFOVBHP8W0a7upqrSz9CLgq/yIgq/4rAy7fkGlYXMsPxnZVI0c5Nnl1GqKeAA08floOq5YtqOghc2cJb8mH7MarSuxPyN6orCpNSnTkG6h0heeGSoRiGaPO0FxNWX7M9AufrjuMLdvivX4ZslMq5Xmw4lLiamMHkl6W8e6ky2khF87VXVTDKGkt6LciloX5PqfBGUvbuBXW8/xiXyYE0C2SVQDFG4+X5JyiYnHmmb8gG2Eb06bR3dyENZqOb3AFIlxZ0cIg7Y17fUhf2ZtSRvd9c40Zj6cuJq/5Cz9rYeS2jV0qZ+jMuGw9lfCM9pAsGYJLWWo7kaKdStrL8HqYdk/hmHUhw77gQ2WycAyq1QoR1gxpXrS+DvQK6wdnE3lx5CblMyi3VOFuAmepDk9aaazSDBEiGpzEVeXvpqaC8QxF8BMzoFIbxDBQafkavi0H1Sm4HvWv4TFaVPiOAJHOEC6khuh83SD3nXSC/K7ra6A3EUOtPJcMLLl+U7G7k4wMBuCrVf7zSzYJtcHvVN7un81sfFKUue3Ev+lysNM9ltxZeBSdHEMB472drycNXLFm4zA2+tJCoCDmZXnbAv/s9RWIBBOroYx48XQV18+l/MBTvqABetgXFNV+qjLAhWBjJ9oxS0X88JVJhssu0LNIr8ZFBakR9b0iACmvIDCg99AO3iikJoVgRnVf6IGZQ4hp6iOqTlBI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ok2uk8EC1RNUj/ugC7j4Svl0FTJC5kq6Ab2NUYJ4TyInJTN4yi2FH2+PbL8dW0JxKVIQm+vQXDzQZMzHBrGIrKaJPEBMkmDntE1RwDOAAHLiDa7FTcbDwP512R9L133WTRARWCx4lObMwoOMhhFPa65Rl5IQ7csN85AuMTmjSJbjw/nvPaEi+dQYdd34huyML9/ARCOljJ2urOppPBCjr6CQcG5YrNDzkSa5mFHpMmUMD73+ICArWjJ2WbhXT2SWninaLByIw9wg44zrDl9Jzpcu+JAwbUwBUK6fzPeOCsY1L6pDCCvryRqfhl3kKtQpiaZgh/b+G3WOgS8ctxQ4M5AMm3cgRNIpD48HKgvqx3XpRevVU+nz5Fa2tzy2/KoXKvNMmzu5ygkXsEWwAYRFzrS5YcE0ZwmcGxBBWIwC1Kh7I4OoXQovji2lJJb7lTiU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 04:18:28.8489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d110495b-e169-4bfc-2cd4-08dea738b29f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038
X-Rspamd-Queue-Id: F1DC24AA418
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19828-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Mark Bloch <mbloch@nvidia.com>

Deployments that always operate in switchdev mode currently require
manual devlink configuration after driver probe, which complicates
automated provisioning.

Introduce MLX5_PROF_MASK_DEF_SWITCHDEV, a new profile mask bit, and
profile index 8. When a device is initialized or reloaded with this
profile, the driver automatically switches the e-switch to switchdev
mode by calling mlx5_devlink_eswitch_mode_set() immediately after
bringing the device online.

A no-op stub of mlx5_devlink_eswitch_mode_set() is added for builds
without CONFIG_MLX5_ESWITCH.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  6 +++
 .../net/ethernet/mellanox/mlx5/core/main.c    | 43 ++++++++++++++++++-
 include/linux/mlx5/driver.h                   |  2 +
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 3858690e09b4..cfb9595f9de8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -1049,6 +1049,12 @@ mlx5_esw_lag_demux_rule_create(struct mlx5_eswitch *esw, u16 vport_num,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline int
+mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
+			      struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_MLX5_ESWITCH */
 
 #endif /* __MLX5_ESWITCH_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 74827e8ca125..4cdda15ed7f5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -86,7 +86,7 @@ MODULE_PARM_DESC(debug_mask, "debug mask: 1 = dump cmd data, 2 = dump cmd exec t
 
 static unsigned int prof_sel = MLX5_DEFAULT_PROF;
 module_param_named(prof_sel, prof_sel, uint, 0444);
-MODULE_PARM_DESC(prof_sel, "profile selector. Valid range 0 - 2");
+MODULE_PARM_DESC(prof_sel, "profile selector. Valid range 0 - 3 and 8");
 
 static u32 sw_owner_id[4];
 #define MAX_SW_VHCA_ID (BIT(__mlx5_bit_sz(cmd_hca_cap_2, sw_vhca_id)) - 1)
@@ -99,6 +99,8 @@ enum {
 
 #define LOG_MAX_SUPPORTED_QPS 0xff
 
+#define MLX5_PROF_SEL_LAST_NIC 3
+#define MLX5_PROF_SEL_FIRST_ESW 8
 static struct mlx5_profile profile[] = {
 	[0] = {
 		.mask           = 0,
@@ -120,6 +122,11 @@ static struct mlx5_profile profile[] = {
 		.log_max_qp	= LOG_MAX_SUPPORTED_QPS,
 		.num_cmd_caches = 0,
 	},
+	[8] = {
+		.mask = MLX5_PROF_MASK_DEF_SWITCHDEV | MLX5_PROF_MASK_QP_SIZE,
+		.log_max_qp = LOG_MAX_SUPPORTED_QPS,
+		.num_cmd_caches = MLX5_NUM_COMMAND_CACHES,
+	},
 };
 
 static int wait_fw_init(struct mlx5_core_dev *dev, u32 max_wait_mili,
@@ -1385,6 +1392,22 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
 	mlx5_free_bfreg(dev, &dev->priv.bfreg);
 }
 
+static void mlx5_set_default_switchdev(struct mlx5_core_dev *dev)
+{
+	int err;
+
+	/* Default switchdev is best-effort; keep the device usable on
+	 * failure.
+	 */
+	err = mlx5_devlink_eswitch_mode_set(priv_to_devlink(dev),
+					    DEVLINK_ESWITCH_MODE_SWITCHDEV,
+					    NULL);
+	if (err && err != -EOPNOTSUPP)
+		mlx5_core_warn(dev,
+			       "Failed to set switchdev as default, continuing in current mode, err(%d)\n",
+			       err);
+}
+
 int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
 {
 	bool light_probe = mlx5_dev_is_lightweight(dev);
@@ -1431,6 +1454,10 @@ int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
 		mlx5_core_err(dev, "mlx5_hwmon_dev_register failed with error code %d\n", err);
 
 	mutex_unlock(&dev->intf_state_mutex);
+
+	if (dev->profile.mask & MLX5_PROF_MASK_DEF_SWITCHDEV)
+		mlx5_set_default_switchdev(dev);
+
 	return 0;
 
 err_register:
@@ -1532,6 +1559,10 @@ int mlx5_load_one_devl_locked(struct mlx5_core_dev *dev, bool recovery)
 		goto err_attach;
 
 	mutex_unlock(&dev->intf_state_mutex);
+
+	if (dev->profile.mask & MLX5_PROF_MASK_DEF_SWITCHDEV)
+		mlx5_set_default_switchdev(dev);
+
 	return 0;
 
 err_attach:
@@ -2314,6 +2345,16 @@ static void mlx5_core_verify_params(void)
 			MLX5_DEFAULT_PROF);
 		prof_sel = MLX5_DEFAULT_PROF;
 	}
+
+	if (prof_sel > MLX5_PROF_SEL_LAST_NIC &&
+	    prof_sel < MLX5_PROF_SEL_FIRST_ESW) {
+		pr_warn("mlx5_core: WARNING: Invalid module parameter prof_sel %d invalid range %d - %d, changing back to default (%d)\n",
+			prof_sel,
+			MLX5_PROF_SEL_LAST_NIC + 1,
+			MLX5_PROF_SEL_FIRST_ESW - 1,
+			MLX5_DEFAULT_PROF);
+		prof_sel = MLX5_DEFAULT_PROF;
+	}
 }
 
 static int __init mlx5_init(void)
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 04b96c5abb57..65298c07df4d 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -705,6 +705,8 @@ struct mlx5_st;
 
 enum {
 	MLX5_PROF_MASK_QP_SIZE		= (u64)1 << 0,
+	MLX5_PROF_MASK_MR_CACHE		= (u64)1 << 1,
+	MLX5_PROF_MASK_DEF_SWITCHDEV    = (u64)1 << 2,
 };
 
 struct mlx5_profile {
-- 
2.44.0


