Return-Path: <linux-rdma+bounces-19554-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECRKE4/P7WmwnwAAu9opvQ
	(envelope-from <linux-rdma+bounces-19554-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 10:40:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE4A4691D4
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 10:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 781D6301862C
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 08:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E75348883;
	Sun, 26 Apr 2026 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J0qC2Jzt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CC8348477;
	Sun, 26 Apr 2026 08:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777192753; cv=fail; b=hnTONef2s/r3zqw9gpNeLiConZt/iNI+Hhr/4KAkFKEB869UHEJVjNly7MAXI/2PMxgfqC2Y5HpDGD8Q7HghmARgmobMkpj6L6lU0quEhKyyTghvoCFTcGajHoLZBJl8mj0EnUpTYdehpcXw5yoRPC5sFPsHFh4bXNY47VLkTaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777192753; c=relaxed/simple;
	bh=3byHFNC93gAfJOtDdU71buXfOsl1qA18d9jbQWI1Nr8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyuJBbrNuDpWmsntPtf9dH4uMk0vuQxJjnJ2sByk2ZiTGNSGSRbMgyzZNa4EetS5ozcZC+AUJZPhfyA323PVCnBGA27ryFHFz8GqlG6rprwApB2T6Nidp0X5kjRbRFZnTNdHzpRTQ3adfVNEk6XrOoX/y7UAmUR4aHmuqoy3DUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J0qC2Jzt; arc=fail smtp.client-ip=52.101.48.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXOGc5TASoj2Ktv6tctosaxJDPC6Vsv/EJKwDMMfklWOUQVZB/JZZ58NMWeVvrTkf6dszTZbn6Dd88Y7TNW3OOgsPZrn181+CQZ9+RBizFEu7+0Kz+loDABzWX2LsTfKzhIxSOqr42lhFfw55unjaebTRT59NjKkbfiFEBROemcM6/9btyDIOm2O5lX+ZLzt4ALsMLNdR0/0m2qUiIOZrbs9ZGCwyzmrQp2DZri8Hn7U71KyL904rE7Pjmf8GWzWmGlh1iMFuMq2YVMR+pzMza5L0iJBX1GZ9pNidv1c8HDT5heyQBfqoFSOYUfGaFJNyY+ZJWK3TC28UnSuSEcMqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Q/GigAVK00gM2QCf1u2hzP1KeoY3ZFSBiy+dTlMHXM=;
 b=ARenSlYkbeUUjIveuc5MaUCKXduf9wZBDfoIqmDhm0ADD/4X63RNixP16n4BxZixjY1nN5F5mjDXTN0TmfufVuobCaPwwnWUmr8InXPaCGgwSQ+a4jtlQSadYyjnHTcqw1YYrM2X0DW6tMEkVnBgwfgWn46pFqnDa6Y+wS5qeIzQ1ibZftR8Y372/R7As5rF5SFV9ALbihQB5co6oQDk5GNq1ourzGUwGPyIz10hqH186dVk5OHIxMZ5JGKEWxUgmr0gojm58QenoceJ+v0EX6yFGyq6MuP+ljCieThxfUap0uALTKIiwafzToA6gniPrLS903/WRL5vYYFuJcpcRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Q/GigAVK00gM2QCf1u2hzP1KeoY3ZFSBiy+dTlMHXM=;
 b=J0qC2Jzt/9r6/dcccOBaLXoNNO88hZ/ct1AYu/dzWp5aJxpBAavCk8Tw7DsGiShEwIqw9RL+uLaZbBZ8kADWbzt5yZ7Y/3GGQR1RW4NyBVD2LiMxnj/TNDaL/SW1ljv/WLYE0XjXWH8Rd7WlOLqGSAqMHI8tYB01nlrK/PzUfDgUyVj8bYoDlt+CVkpZ0eh+WetvhksnLxTrM3/Mw7MLhWnjuocvsYDlHz9fA6IRxEXzhNGj5T6gSmsaVxUEP7kA6+hZ4vnU6fwGIuVvHncYNAXT1NrN8V+25j18zAjTsdBL3ULXH24qjZQ1/fTvqaEJFjkndY4Y1LBWF/ZH95qMWg==
Received: from SJ0PR13CA0065.namprd13.prod.outlook.com (2603:10b6:a03:2c4::10)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.12; Sun, 26 Apr 2026 08:39:06 +0000
Received: from MW1PEPF0001615E.namprd21.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::26) by SJ0PR13CA0065.outlook.office365.com
 (2603:10b6:a03:2c4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.25 via Frontend Transport; Sun,
 26 Apr 2026 08:39:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MW1PEPF0001615E.mail.protection.outlook.com (10.167.249.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Sun, 26 Apr 2026 08:39:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Apr
 2026 01:38:51 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Apr
 2026 01:38:50 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 26
 Apr 2026 01:38:45 -0700
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
Subject: [PATCH net V2 2/2] net/mlx5e: psp: Hook PSP dev reg/unreg to profile enable/disable
Date: Sun, 26 Apr 2026 11:38:19 +0300
Message-ID: <20260426083819.208937-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260426083819.208937-1-tariqt@nvidia.com>
References: <20260426083819.208937-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615E:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: bfbb4eee-603b-423a-4c1c-08dea36f4712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dBV43aTyQdXzmTgPiVHzaIuptvqFbXalO4LVVexGjXo1VkhJ5lQuKRn/OTAlRhI26T8rc8VtVXcwum9BqkodOjjAbXjzSYGrdwcTjgcCa7JHwj+eRqT7z+i/OZmhOsqmj+oH7cbXkguxHGaCnEj9krrDrpRIUbsmNyJ1bI14qRccB6CgLH4dVLX2fzH9JnoqCVr4GF9C/IQID9nVJemxDV+WierIo7LpU6MorL0aRkhuty4x9du2uhOeXqSdK2RwRG87x8I0ytGL1Zl9wREeDaZ5KwiSDsrsMjK1QR1FfoVv5v+848NRUlmChfZyrMph/sX3M+egecJUiD2tsNVrqcj8UNFAWOcAbZAl5ysvEYE2GXyO5CCBxsfd5/mqZQA8g2Gvg2eDSLQCMscuPQepGM+2BPwSnRviINFR60ns39DjsjhfT69JfHtZeRmee4FLdqHGdlLnalRV66FBY4dEAqrIuwkmUQeNUWe7BWigIgm5S4gD/5CjCbOdw77JlLcteAOjZ8+N71cLN6nh39xWX9gmSFmFdwc42YSYVmWZUjGZZFjB5Cc/rX9C/Sm9HJCs2ZTpVH6kRQ5A6ontsAkOniy3861jbaaThGsea6onKmG4Gc7DJ0Vr6NVltybe5hM8uI2AYsgRRG2bpAzC3D+1lsiqm/KM8cYMNLyq8tJ7qdgCMCWyVI6OJkVCQAoKxeZXW9JTgKotyuf04GKFPyDhZz52FDBIOrTGiqQUlUFUPh9QNfFVXAVnJfuTrz2GtFfLLFspUj/N4tgKHCWVVCbjFA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DkD4ha2FkqEXtaCVU5u2NgPmv183bseJzy71cwhHldC103OiKPJ4wZLdDFM/LnV/JxtUlQXqQMni1m24Y6G8Mtf0ZI4stgzc7hWEEIzzyec/x+ZS1OPc5oKTgVT1YQ11wduuIFIDyOvO3tyK9jeM+hS09nIcqaopA9/Y92vE7N2/9ywvbqVgsR//YhxSWz1PqqMM9Bc5viQnABfQPF4Uzwi0PAckdRhYhz6PP6DA0wNub6/uaILi9Qp0WNG4YK0sl9VF4L/n4/aXWs9zTOhZncrIqNLZPnCkBgNztinhGyWWAgbYg7AsKvaOjL3fwqRjKpka1Ppzabq2KiuR7cwlpYcQVh/WF8WgNb62qyIjaPLkbV985xCizdbVH9iNoJ2JQxpUGbEKURE92x2RQHiKeRiyUSxGRJ4Ri/Xnao/4aMhN5pnIiE0AehIeq/uHcMBX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2026 08:39:06.1300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbb4eee-603b-423a-4c1c-08dea36f4712
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021
X-Rspamd-Queue-Id: 2BE4A4691D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19554-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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


