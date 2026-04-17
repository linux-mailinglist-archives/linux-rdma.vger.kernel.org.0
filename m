Return-Path: <linux-rdma+bounces-19410-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGaPNB2/4WnixgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19410-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 07:03:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D58B1416F5D
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 07:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D303301E792
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 05:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CC332ED21;
	Fri, 17 Apr 2026 05:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UCf2jYS4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105C02FE07D;
	Fri, 17 Apr 2026 05:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776402200; cv=fail; b=BGoPXIEdJDzpIoBtEeTfuG5cp1GDG37ycXHYptEF7Gj2B7PeSS89ex+oIInrNxmGdZAZkiO3WyZBk6EKOyBeMSr+zo4xu7WDx1D194sSQHC4ni4mNbDWKZ8UhLrrMO7Je9x/SmqSMii8tW9QpzTXqY9cPxq1YC2GbTm2do4pqow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776402200; c=relaxed/simple;
	bh=7Et9Ct+10wGSy6Dw5jxYxxN2QzQiQmpjZrktYcvBot4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9IImzWV+yB6/OPEoo+d45iHF+TU22JrCVbcOfPzGAgZK+RF025uphxJs3Znja3BVUi3gt2hDWBKl0oY8qZbvUZPk0GqKznkWIQWKWvfTuN0FlSfAfeX7Ydl4eH3y9TtFUG5F8NVFbm5zomAjkON5sknZ3/loFkWJnW1gWeEya4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UCf2jYS4; arc=fail smtp.client-ip=52.101.46.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5W1xAdqcRNcCrOzFfLYqMla0ZtURzz/bp2sHID/RQku6f/+gMvh7bgobDT1m2BJ1PpcQjet4qekg1SVZ28sMZelgYFFm1LtVfGiJYWQDph1Ye+T/eLUy2WKyjnfxadLZXDUejwBEdloKX2sSjiU54ESVaKGx3m9A6zUvmDatxr262dlA5p8MbzC3HJ4185XodSHjghP7co69MARvMfGEjthKUPTYx/OlaDYPVXS0q9HNSuz4EOuyvWYuieBrjw6MOvOyME6bzRo2Bl4SkpCIRt5EL9w1Zwbv+FCvYbSPaK928bIOihYGtUQjh8bo5/VOxjPuLbsbK5eRzIbx4L9Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVoqFUObSbbHS035oADtJ+ouy5pMYX9WAOTQgyVS0ZI=;
 b=cj5uDeyUZJZlvwhTu67QqHJqI7jopVyLTHGPKxiyAk/M0WAYFwHrZU702a3IzT8mgNXAy48uXshYCT1eNyopteMnu5ZbmkugI/vm5CtudZRPNwTF+A55xtxJNNveV5RIx32m8EBunNsuFAaaL9kQBsasOemSDaxZCh9gvq6QilU9oI8zkwgH45iypBY+SwXd7fiCw89q2NBEOie3Jtiu0wnkV/YsVfMcOZx/8KiuhRydYtc6To8DON49fKdaYgc0mU2zuWsZUZNz4JWhA/ap0lYNHAdIW8ICmahfAvP0wCEY32vHnnCzsBT6scJEnN4rANwVUTSHkRYD3bbleTgvZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVoqFUObSbbHS035oADtJ+ouy5pMYX9WAOTQgyVS0ZI=;
 b=UCf2jYS4iktzbzV8toC8VgpBlW7jZtkc91MY09d6bpddQ/dD5FcJu7/cg3RWhEfBpVHO1W7P/KS4V8lDPnlNR+3fM3fO06jUHZ/zfeuy4FUdbN1wyjFHgE24WJKRKFHcchiN3Owx30jLq06dUHVtNVW+5Arttj1ycPRXosDDdULrM6qnkiFZdHI4wWp3NBTaGMMCAWJ8hMVE/BwQKN+YMcaqgIovq79z9yxK5YQKIW4L8PWImiZoXX1hEb708R2svlxxcerGHKOfDPqpOLOVMXyc5Z46Ux96lPAqdrfmGzhJqC/rdjpI2FwOwFao+oRR/uOfjWhG5OxjMfG/Wq2HDQ==
Received: from BN9P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::33)
 by DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Fri, 17 Apr 2026 05:03:01 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::24) by BN9P221CA0006.outlook.office365.com
 (2603:10b6:408:10a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 05:03:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 17 Apr 2026 05:03:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 22:02:45 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 16 Apr 2026 22:02:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Apr 2026 22:02:40 -0700
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
Subject: [PATCH net 1/2] net/mlx5e: psp: Fix invalid access on PSP dev registration fail
Date: Fri, 17 Apr 2026 08:02:00 +0300
Message-ID: <20260417050201.192070-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|DM4PR12MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 10944224-50cd-4717-6fe2-08de9c3e9972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gEMiw8QcnmjPpEgiL/ecMoefFjC+5naFv08eeYZz3VaSjxQazz6wAKSgyyiJHxTuAAmmK4oOaKmk8ehbqaMR8//GDrHYyUPH9QWM973C9C6rdLTYchEzCcU+FV+SdSVP2uMZnBjdoqYgwzMiszjRqzoWDAUvNc1RNRtF4vEopUTpNniaWm0BaxMeTN+e5A4v5bAOjLr5A89VP+0yPmn+NxL9LOfOtbxh6kadbOWfS6ruf+uoYnF7OFEfTMxADSmHxsdZNv8txEhIsq1NztoHNXb0l6MypRiyo9BHRZlevMQuVCOrDbjl6+WlzeYbjrUO/T5S4M3hjT9/oAMk5vTEd1fGBIZAL6PbOGkU5nFeP3bbOZgPkZJXVz4AtfVDDAUF0tKT8z8xAZPMKyniR03rtIZ2H4UUNpJLDoel11Owkl3ybBgmxmKohOo39BcXedJ9OyMtd/3/kK/VoaK2fXraKxCHxxvV7ZwJK3pHMp2VVd2mMPWQXvT+kdBAo3np20iOo+qMW8wNY5t0DWdOUM1WcyPQ1sCTwNTI/GjrsJ2iJj2Rq0wZgDUyuu12jWmULHYjonWzco/dUX40l9cLyCpVhMl1rpSAj2/9FiVGaO2KUeXTOsF4WSMdN5/7w6eB5IutSf74DXH4BRX6CUHDAN6Zzk6Miy5r8PX0VtLoaTf4cLJuzd3olGhjKe4UVvtZAie91ZL4W1tC8AnPTRSRthiU8xWq/ui6NDT6S7Irah7DmKkEQQ715ycwEtrQsluOV8fV1WB30jnf11PrRh9hlKQNVw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DYDAU8QHcJAgN2QH436RYVfGH+a3n5U/AOJug4+PhsAD3Y3o3914F6w+fISYSh2D8IqkJjXGDadwGqcm3QpS/YlF0/rBpfvHNxIBgOnR0lr4/CGXnRVBYMxJiLDuS1CNxqkFgNYt32lueTXfyZ6fQTIOMi9X6qFzGD3+tG/WuEvVXfF15SvsXWcj/eRq5a8Nj/MrMrv7JocCnisQV5x/vXxuTQ0c07SoF0gqeC11oqzgyYEWytmVbFe5l5yUCGhXtrav3EPtrYSiTS2UWN7zIkQhqSkepHmbvV85fa27vacYtwdnyqTYx7buqzjS1yVmSEVsDMeRtUXHOkYMx2bX4hSJ2fl3Gf44DuHdAWJpevD4v+2yZ73ayNsZwWuiBtUfegHHWivqtYikIgxzribgIDrMeTRsmvwWwcw/XtvJpjEMBWmp9UT0pQmTEN7MhBxI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 05:03:00.7431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10944224-50cd-4717-6fe2-08de9c3e9972
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19410-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D58B1416F5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cosmin Ratiu <cratiu@nvidia.com>

priv->psp->psp is initialized with the PSP device as returned by
psp_dev_create(). This could also return an error, in which case a
future psp_dev_unregister() will result in unpleasantness.

Avoid that by using a local variable and only saving the PSP device when
registration succeeds.
Also apply some light refactoring of the functions managing the PSP
device in order to make them more readable/safe.

Fixes: 89ee2d92f66c ("net/mlx5e: Support PSP offload functionality")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/psp.c         | 36 ++++++++++---------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index 6a50b6dec0fa..d9adb993e64d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -1070,29 +1070,37 @@ static struct psp_dev_ops mlx5_psp_ops = {
 
 void mlx5e_psp_unregister(struct mlx5e_priv *priv)
 {
-	if (!priv->psp || !priv->psp->psp)
+	struct mlx5e_psp *psp = priv->psp;
+
+	if (!psp || !psp->psp)
 		return;
 
-	psp_dev_unregister(priv->psp->psp);
+	psp_dev_unregister(psp->psp);
+	psp->psp = NULL;
 }
 
 void mlx5e_psp_register(struct mlx5e_priv *priv)
 {
+	struct mlx5e_psp *psp = priv->psp;
+	struct psp_dev *psd;
+
 	/* FW Caps missing */
 	if (!priv->psp)
 		return;
 
-	priv->psp->caps.assoc_drv_spc = sizeof(u32);
-	priv->psp->caps.versions = 1 << PSP_VERSION_HDR0_AES_GCM_128;
+	psp->caps.assoc_drv_spc = sizeof(u32);
+	psp->caps.versions = 1 << PSP_VERSION_HDR0_AES_GCM_128;
 	if (MLX5_CAP_PSP(priv->mdev, psp_crypto_esp_aes_gcm_256_encrypt) &&
 	    MLX5_CAP_PSP(priv->mdev, psp_crypto_esp_aes_gcm_256_decrypt))
-		priv->psp->caps.versions |= 1 << PSP_VERSION_HDR0_AES_GCM_256;
+		psp->caps.versions |= 1 << PSP_VERSION_HDR0_AES_GCM_256;
 
-	priv->psp->psp = psp_dev_create(priv->netdev, &mlx5_psp_ops,
-					&priv->psp->caps, NULL);
-	if (IS_ERR(priv->psp->psp))
+	psd = psp_dev_create(priv->netdev, &mlx5_psp_ops, &psp->caps, NULL);
+	if (IS_ERR(psd)) {
 		mlx5_core_err(priv->mdev, "PSP failed to register due to %pe\n",
-			      priv->psp->psp);
+			      psd);
+		return;
+	}
+	psp->psp = psd;
 }
 
 int mlx5e_psp_init(struct mlx5e_priv *priv)
@@ -1131,22 +1139,18 @@ int mlx5e_psp_init(struct mlx5e_priv *priv)
 	if (!psp)
 		return -ENOMEM;
 
-	priv->psp = psp;
 	fs = mlx5e_accel_psp_fs_init(priv);
 	if (IS_ERR(fs)) {
 		err = PTR_ERR(fs);
-		goto out_err;
+		kfree(psp);
+		return err;
 	}
 
 	psp->fs = fs;
+	priv->psp = psp;
 
 	mlx5_core_dbg(priv->mdev, "PSP attached to netdevice\n");
 	return 0;
-
-out_err:
-	priv->psp = NULL;
-	kfree(psp);
-	return err;
 }
 
 void mlx5e_psp_cleanup(struct mlx5e_priv *priv)
-- 
2.44.0


