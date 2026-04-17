Return-Path: <linux-rdma+bounces-19409-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDUbKVG/4WnixgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19409-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 07:04:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E50416F90
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 07:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18CDB30C4FD3
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 05:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A53314B8F;
	Fri, 17 Apr 2026 05:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bh0ILVVG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C007F1643B;
	Fri, 17 Apr 2026 05:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776402186; cv=fail; b=OS56aSi13KBJA1w+pNUiAICkYaU8clGxywwDRx9H0PDFVZWnJiuVg7RbbhPE6jZ938gEJNQcDaArvHzM3fneEFEyP1OWT7jIf4NxSaKNLAkm1tYoOnlxcA1+uL3Z0SspvzgB1aRMF/dWUFL3VJzZSnF20VUcq6+FKiCvt28QXE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776402186; c=relaxed/simple;
	bh=+fdE4o+qdC17NKbjDhP6jqJCf6pFfo0Q/j2PGy9h9TM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+ZoxZRYFGcpwFIqmny/KA4uweHVbSXJM/JAy5CsP+60kOLvUXUodD835+42afF1tJG1DRYiaUIoVcDopXSD+NzIX4pofflqNbpx4jBAgnFl47LeIx+ZGuZtEmRkpapMVn73gUi0lx1dzWv0i9V87xexYlFKCN546IR2Ai25mDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bh0ILVVG; arc=fail smtp.client-ip=52.101.62.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhf+xstvYhOVzhdtEqC+4UPItjU5bCzv/4ktj776tCEjy0pa+SdbpE2R6D7X/kMUou94EWzV5Ey+hFh3lAb5q7DQ9dtyKxC+dZXIwiGUUOg5mRp/YCG+jo/r20szVpUlodOfRyWBIum/+m0IWfL+zi9otO60FGFbrZCRdBkDvRA5E4TNauVte16dzw51NVtsCScmT4LrOQr90IoeOxk+T71e1zZO4y/gW3iwD+FtIqCiQcAxhSWP9XK9rLduK22Cl6PoKYoQ2qJOS5D9R/3ZNpYUsEuCYHTjQEkl76i+NPiGLnKz34t2sJGiaCUu1J9tnL5Pasfu2wajjsm5e55Afw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kG9N1WUfyFP80XOAwiT53lBujzv2HAEhL5stIP9qEGs=;
 b=iVLiMLCO/NoADyMinOPLCRxztPJ5fAUp3vBpcHxOQFTx04vosv+o8BDEb8wqW/BvknNRLwVaHHqU0sZT2USCgh60U0mXqZCZvS92hw8hWg5c7kguUoToM7BZ7ZUqo5rVK1d0BKl4FTu0vY/btpXXnfUAw29S+icSYt3n0UtqK7byWBV2ahpMLkIfxmpXmTAHtHaQomc1mDd+ES7FyRTKbtHAZZipO0nk5Wiq8/buhLriyJQhvga5e5wrqGeAMllyFv3yEtlLAXBK/IfORSBVawUfKCxFOsnIGZjh66ReH3Poa1mRfzaaRVUW01WXOH9L7G3upL8eBuOJ7OHVSr7/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kG9N1WUfyFP80XOAwiT53lBujzv2HAEhL5stIP9qEGs=;
 b=Bh0ILVVGG6eyNHNdVb/wiCpgq6jdsZdTNO38JIgdqOULwXvoq/5m52QeAdlfx1o1pNGI4crKtioAYSnkAPxv5XRPKRXE4oK6a56QCDe9VnKrn6+vnZwV5FkCQzbfoIW5NogEssRtunRRoDo5w/+sLgoURgRUYgQfq2dc5zMfJFDTeaP4DBp5zEx6gfxU7mGL2CagcxJlZhvNBx6mNJt66u3qC+VvFuRG90FYqTYQnsxZqrJxJn04olW8rP84B75BRPSoSEr83T2lHg85O+L6Ih/d6z0VgC+5J4gGHv9U8fzQdR+5IQY+KGURnt2sJVw0l+jPeMUhWx7RNRJSThpYgw==
Received: from DS7PR03CA0197.namprd03.prod.outlook.com (2603:10b6:5:3b6::22)
 by SN7PR12MB7203.namprd12.prod.outlook.com (2603:10b6:806:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 17 Apr
 2026 05:02:58 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::4f) by DS7PR03CA0197.outlook.office365.com
 (2603:10b6:5:3b6::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 05:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 17 Apr 2026 05:02:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 22:02:50 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 16 Apr 2026 22:02:50 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Apr 2026 22:02:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Boris Pismenny <borisp@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Raed Salem <raeds@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, Kees Cook <kees@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net 2/2] net/mlx5e: psp: Hook PSP dev reg/unreg to profile enable/disable
Date: Fri, 17 Apr 2026 08:02:01 +0300
Message-ID: <20260417050201.192070-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260417050201.192070-1-tariqt@nvidia.com>
References: <20260417050201.192070-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SN7PR12MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1ed5fe-f5fe-4a53-55b2-08de9c3e97f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RfegW4BZHMzL9EVmg36iA2jTZBd3BuDhbXXKhNHbPBDutWsqYWUkBlyJFEwWIUJar1Om3pu2DYuhINTLdlzIY6Gy1tgQfay2dUHTaofikXMTfOx8HYKzqKxyOt2apOYqVDxaa2GB4M7Rt5bd8YEGfpYYDLiHzyJQU+VkCTHsODAEgUDC0Ls1glvRrpphHoPSQDl/s6dbY1owPFJ9lEfuro6GBn+ZUhI+MibVnrTEIUzK+5p4eGG73lGwExM8ExaanlrM9qYlt83lD8gOi2R9PMF3tiNlwEG1on1cgThAw9xUI5D6wvnFe9VsSTWCJSBesOQtnls9v6B0SuZ7aN3JlDAE3Z58xrlXOjupTizLsu8ErwN7EdsVAVNabi7weceSpBCnBdZ/5dfej3NN24mZEn2yC7H2NGY5wfJAx0lMyZAYhDZZCkkt3/35zf7t19LypZa3j8viTg6fslt6JwICIbQSz/U4Bw/o1++WT/HZcp9YqwnQEYGUJsaPIZefHpJxaoE04deILjXdn/RkwyUyyvajCbdLe1mWgMO5M37KnMlDRl1F4Qh1G8Xm47liiMX+CfzkHnEgA1cUP9AwwWHm3WwEiRY+67YgqfRscUYtUfs6YoZXtbcrzpPRZj85iK6Lq1u90rxZOlqPFqojRpmYMIJEC5aSQ/bt2UdoHken2bZ8XGxZ7ZjJs+f93uFI4TvwD/ec45I8T+7ETJB7gkDecXNjsBTyGecwcG7lK+CjVPWOUoT4dc0Fw74Kz47ZJbha6nkoCmw5qZhL9Bpg+Ud7Xw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zfYjKlh94okxD/pM97e1RRrO06Dj69xcgqwHmaH0YzzTgADaI/XX+kqlyLaKp+va8pUcRCfmAcYaW8xi+zu9oxtISGe/5+i+FHdgorcTZAIGZAPf43TRNDTplysj0JivvsGHWDy3E5q4eci4R70KSC24y1dKnxOm4KSPUwvkzFocIubqUdkzMnJfskVAjH/H9FNKbYvBzGlPVudkdGCPyJXfXPHREi9CHZkMA3a+DCdUhKVSOk1bPgMfLSN34w56FZrbm+x9NhxBuJmjVD1xW0/qfCykudic3XsWILAlcKjIaBdmda4rS6YrL1n9zA6XLaulz3dI7pkEZd92PFM+A8X1FgOAwtdNsDO62Hf1wHnvoHhgp4z23jjWEFhCHJhQNfRdf7oz4a80PN637OEu/rwRuXOeSlBffTwhNaSuyIRgTT7EKXXZQ6WF3RFH5pQU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 05:02:58.3492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1ed5fe-f5fe-4a53-55b2-08de9c3e97f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7203
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19409-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 40E50416F90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cosmin Ratiu <cratiu@nvidia.com>

devlink reload while PSP connections are active does:

mlx5_unload_one_devl_locked() -> mlx5_detach_device()
-> _mlx5e_suspend()
  -> mlx5e_detach_netdev()
    -> profile->cleanup_rx
    -> profile->cleanup_tx
  -> mlx5e_destroy_mdev_resources() -> mlx5_core_dealloc_pd() fails:
...
mlx5_core 0000:08:00.0: mlx5_cmd_out_err:821:(pid 19722):
DEALLOC_PD(0x801) op_mod(0x0) failed, status bad resource state(0x9),
syndrome (0xef0c8a), err(-22)
...

The reason for failure is the existence of TX keys, which are removed by
the PSP dev unregistration happening in:
profile->cleanup() -> mlx5e_psp_unregister() -> mlx5e_psp_cleanup()
  -> psp_dev_unregister()
...but this isn't invoked in the devlink reload flow, only when changing
the NIC profile (e.g. when transitioning to switchdev mode) or on dev
teardown.

Move PSP device registration into mlx5e_nic_enable(), and unregistration
into the corresponding mlx5e_nic_disable(). These functions are called
during netdev attach/detach after RX & TX are set up.
This ensures that the keys will be gone by the time the PD is destroyed.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Fixes: 89ee2d92f66c ("net/mlx5e: Support PSP offload functionality")
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 6c4eeb88588c..c3938a2dbbfe 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6021,7 +6021,6 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 	if (take_rtnl)
 		rtnl_lock();
 
-	mlx5e_psp_register(priv);
 	/* update XDP supported features */
 	mlx5e_set_xdp_feature(priv);
 
@@ -6034,7 +6033,6 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 static void mlx5e_nic_cleanup(struct mlx5e_priv *priv)
 {
 	mlx5e_health_destroy_reporters(priv);
-	mlx5e_psp_unregister(priv);
 	mlx5e_ktls_cleanup(priv);
 	mlx5e_psp_cleanup(priv);
 	mlx5e_fs_cleanup(priv->fs);
@@ -6158,6 +6156,7 @@ static void mlx5e_nic_enable(struct mlx5e_priv *priv)
 
 	mlx5e_fs_init_l2_addr(priv->fs, netdev);
 	mlx5e_ipsec_init(priv);
+	mlx5e_psp_register(priv);
 
 	err = mlx5e_macsec_init(priv);
 	if (err)
@@ -6228,6 +6227,7 @@ static void mlx5e_nic_disable(struct mlx5e_priv *priv)
 	mlx5_lag_remove_netdev(mdev, priv->netdev);
 	mlx5_vxlan_reset_to_default(mdev->vxlan);
 	mlx5e_macsec_cleanup(priv);
+	mlx5e_psp_unregister(priv);
 	mlx5e_ipsec_cleanup(priv);
 }
 
-- 
2.44.0


