Return-Path: <linux-rdma+bounces-19944-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAlrK//h+GnM2gIAu9opvQ
	(envelope-from <linux-rdma+bounces-19944-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:14:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7214C25AC
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 513033071DA2
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 18:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7462F3E3C52;
	Mon,  4 May 2026 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gqM7gefw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D957A3E5597;
	Mon,  4 May 2026 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777918336; cv=fail; b=QOPVGJX7Sx9d0U8HqN3PGgW0Dh2QoW7BvnS26pPSnrCTNvX/sSpuntg9mm2nphKUwF5VaFwU4dDNyWVWf/Rg1zx7GJvjvIaRrLMfLZuoj3Vhh78628WvSxh+WnFQHjtAvyI+R9V70DpxJLHAiQ7fiu1iHWwJMw495bu437pyj8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777918336; c=relaxed/simple;
	bh=3byHFNC93gAfJOtDdU71buXfOsl1qA18d9jbQWI1Nr8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLC7xY5JDfpkNapaEZYFVToxz3b/KnA+zRHBYjuOEKHNH+kWVAFrCMksip4XhFT2tPm3kLONGvKrRLk/aGSkt8NICjjRVeDLCif9MpTSEXaXkfmh+hGUyGIaN0Ru51paFY5bUGvEWV9IXRW+KOkncWg9GAfBdZx17abEtx7QnNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gqM7gefw; arc=fail smtp.client-ip=52.101.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebnPvrZKzJViBkoDujYxa5JnroLyNRVCSMTDcact2vclBk8gSEhM1Bd31myXbThbRrqfNmA5y062ABra5Ly8gmLf5UWNUdmWA4SBpnTH2ZoiVoeeOD6Ava0S0nCHi4zjYPJhil9uEBq3RJDm2M5yAfMU08UYj433hL2WQsFaMCE6vP5sQHYS1izMjUmVMJw+mXd9rH7yXYj2cqZhlcUorZlrJsvPEmjtQpNFLhKecIqJZWdfBsxlu82shfdMJfpASGakpvmQet8w02g7hQ2YIOOB7/l1rG6YS9W5K5Pstt760mfgwVGhAfYEfpw+vV5sBgWS+jZNwKXXcMWX/Yf6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Q/GigAVK00gM2QCf1u2hzP1KeoY3ZFSBiy+dTlMHXM=;
 b=RY4FQbMU1B2KYsPoO8ro2UtXkwmrKi1bChjGGxG9frj9/rEtXcu05J09T9bUTAjCyyYWtUIVrfILC5RRiSgH0kcfra0+lbZlFvM/6tH1X8UkQDPXjGLrm7bpf+Jc88wc3xabOxAPpg+nKxgpfyOqoJ3Iq4VnIqyPxbZOrD0pwMh3I4kxGFGCw6cAMHQOsoIfc9EBETYzS9VwutugX5EyYzizUcy+qhu9UEQtCtwxn8jBNm69sf2CWNE3uR5aze0+xQIpG4Gx4PTiS5eRHFw5ueZwCRm/FgOk3LUtGpahOKdXEtT2YU5pwUYuPz6uRzdNR7UjaRfsBTmxlzmIrG8PLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Q/GigAVK00gM2QCf1u2hzP1KeoY3ZFSBiy+dTlMHXM=;
 b=gqM7gefw6ocN/4zOQy/SFZ06VJuUoowa0ZEwjWdDUPpQz2qlalH8skMWbNqLbp4oF4xvutNYnFn3m2P4zt/sdv1ZHj4vQmxashfbMQPur3gMtZ5riJD/bFFiidwbZLwMzGjbrhxUrVwGoEg8X1KO0IfsEwXEBCe6kc/7xB3zIS9k3qLTKFKcfLoM28XlGtYjIfPvxpkhuaC5KvB5eJuL0vEQF8NJxKDL/fcwz9AQWF/OTEfSLSxqFg22UfW4lp+7BWZ04sMVqYC6a3dwdciFdsi9qvrY5n6DBvpCUJClwfLtgb+6oWjbQB2n/l7p1vSHftXL8oClWXbaafFUv7tNzg==
Received: from BYAPR06CA0067.namprd06.prod.outlook.com (2603:10b6:a03:14b::44)
 by CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:12:03 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::ff) by BYAPR06CA0067.outlook.office365.com
 (2603:10b6:a03:14b::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 18:12:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 18:12:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:11:34 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 4 May 2026 11:11:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 11:11:29 -0700
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
Subject: [PATCH net V3 3/3] net/mlx5e: psp: Hook PSP dev reg/unreg to profile enable/disable
Date: Mon, 4 May 2026 21:11:00 +0300
Message-ID: <20260504181100.269334-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260504181100.269334-1-tariqt@nvidia.com>
References: <20260504181100.269334-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|CYXPR12MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: 88df928e-15e7-44fb-98d1-08deaa08a4df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nNvjSfCZ+fdK6zqtUZFqdeS3LcbD3NBTE2QZOr+hQSi0Ec6KGSB0NnDYjYdujDCOHVF0j3Fca1m2v9qYU8bHXx6clbZ1TJBi1T/dsO96wzEGBHmjb8gz5wOFxwdFNbRXDPUcaTaBleulZ3LjzD71kqzrOC0BBNzKP3ifvbz24osICl054NJBrjuV1ATPkPh5V0UNZE9LwRyrKtBzy2XCnA4ucdPn/e6JmZ4D8wQlro/0F84RRt7I4HeVMbeZQ6MukSCLBJc/6X0huEjbVIE+ierhQOJvVXNWZDNqkLE5nPeoKp2rk+4qQZbUBGEaMeUXkcoB7jw4ZbEwy0NjeXqNQncAliVr8S/itrnYP8I5EkRA2dJ2y9lF8L/AjjupBf0sm3wpEs0WTpoOcGyLeulG2yMLXQdYuoZSPrUHHNVwJs7DHGhK2mHVZXd5yoe8vvgfgyJX4Aglx/NfejCsp0p1/J7RuxsaUbVWfnbBY80WpivlZ+aWNHPkitjwSeBj6IPvu6+wAUufY01xxpfzooPm1tGDoT1HdJ0DmRYD2GzG7bzcP9U2Y2XG8WdsQKOeniMxj/18cwuSbQd742hrV1uTGR3heASih9OGKhiuKmRdiWqfT8npcNet8MldpFqY7LFUVoCgbeZQfN/dIesC/QfjUj75HR6nhviMHYhPP6dxlC3+R2ZPoNsTxAZM3PgaR4Rcf8QG25QFTd480ov2jMcUAD70iaQ/lbTTz/Gf3Y1f2SA=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+N1FMFvxq+9iCeJee2yiaRd69ev4/hdUsp5DnW7cRD0vIE9wxndMBxv/HJqAHc+93ZFfSLj8OL7hjycGqdL5iit4Yn86Z8D+fIYNguWOa+qdKuFViAaEVCfOiGXAzbKa/XupRXRBJYY7BSja7r0wlodjQsag1qlZ/I1B9cSyO2/gc5gQjdJ1MEVXvESCYdqvT1UmImiFI+eEdglPCYJZRkF03+wRnmf6iPFtT4GYQLxsFiAzsSROmlJxf2Llh4KGJaMgZfZYDCgtw+JVyme8Hx6RWEToDHW8wmvOWHaciLZ3QIkFhMbw7QqUKzWyMF2iM0Ly/IoKufHIQ7YQafKSPmNzCmSqLT/roDecbZ19Bk4xMDWxsHoJ3BVbrNi2REHMN208XVgE1Re5kZXq6Ln7YUK/VrEQOLPgFlFtZVG7hG7BkgdJ2fsqET2sz/sem4AN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:12:03.3037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88df928e-15e7-44fb-98d1-08deaa08a4df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9337
X-Rspamd-Queue-Id: 2A7214C25AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-19944-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

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

Fixes: 89ee2d92f66c ("net/mlx5e: Support PSP offload functionality")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5a46870c4b74..8e9443caa933 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6023,7 +6023,6 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 	if (take_rtnl)
 		rtnl_lock();
 
-	mlx5e_psp_register(priv);
 	/* update XDP supported features */
 	mlx5e_set_xdp_feature(priv);
 
@@ -6036,7 +6035,6 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 static void mlx5e_nic_cleanup(struct mlx5e_priv *priv)
 {
 	mlx5e_health_destroy_reporters(priv);
-	mlx5e_psp_unregister(priv);
 	mlx5e_ktls_cleanup(priv);
 	mlx5e_psp_cleanup(priv);
 	mlx5e_fs_cleanup(priv->fs);
@@ -6160,6 +6158,7 @@ static void mlx5e_nic_enable(struct mlx5e_priv *priv)
 
 	mlx5e_fs_init_l2_addr(priv->fs, netdev);
 	mlx5e_ipsec_init(priv);
+	mlx5e_psp_register(priv);
 
 	err = mlx5e_macsec_init(priv);
 	if (err)
@@ -6230,6 +6229,7 @@ static void mlx5e_nic_disable(struct mlx5e_priv *priv)
 	mlx5_lag_remove_netdev(mdev, priv->netdev);
 	mlx5_vxlan_reset_to_default(mdev->vxlan);
 	mlx5e_macsec_cleanup(priv);
+	mlx5e_psp_unregister(priv);
 	mlx5e_ipsec_cleanup(priv);
 }
 
-- 
2.44.0


