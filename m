Return-Path: <linux-rdma+bounces-19943-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Dl6Msfh+GnM2gIAu9opvQ
	(envelope-from <linux-rdma+bounces-19943-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:13:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7454C2596
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A5D3304EA25
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 18:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45473E5ED1;
	Mon,  4 May 2026 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YWnMSKMD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275CB3E5ED6;
	Mon,  4 May 2026 18:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777918326; cv=fail; b=aKXB/ynshY96tGB5jRX3Rho76muJLQG33nQtfWQVIptrkNb6iLrdh64rhuTIsOpMKM2iNvXFrVhTYEpPydmBZH+cnGuNrB33ZT7SNO6FoXcSXKwiyh+VMQGR3Ps9vD6IQyXUmRm119BDGq2YvczR/m996Dq3vytDvKvlaKWgAVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777918326; c=relaxed/simple;
	bh=c+hEJGunVRsABvIrlCVL2s5Tzn0fQ1mfCBiWT40BGvc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mL3kfXWicyGnJBTNd8JbwTi1O2gz7CsXOpCgsB0/xW6wuOZVUzN3Fvzg6PvthHOMKB+Zf0FSZxMYn9TMPvtv6mUNd3I9wrnSfkopG8CryoT3PHwYvftvyVJl1XgtOM2urCjZ0BBQ2RsBxmVLJJB/aEfmIsJxkuJHpe1bSm6zQL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YWnMSKMD; arc=fail smtp.client-ip=52.101.46.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lv+4Yyfetp9Zy6Eu9rShaE/+T/QoeI55eakTzRErh3Lqcn1EYi2gWyidtanRaZVIfVO2NWcCnmvyOe5iApNV66ibdhgW1qHGDtYuOWXDny+7J5XGN0pqnOq/dWO4LcAmeET65AwbvrI4987zup7QLcJbRz3WROxaTIQvhPeh/k2U5PSYdq2ztYSl8VWdLsqVSLaQvkVM6MP8gJnC/J/jNQWvEDJmgu3LTE8Y/Bi4qpTxPjBQCbQkImdaoxvRnVb+HKZzgNjELc/BKct1lOhRdU6tqgS3IjwoIljZlAcJyNEZiHjtLgTGIi/W4S9cIEGv8EC8NuofEUY9Zoi4Az9AbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhfCYud453JDgeegWkZI92gL7GV6VL54iLQ9OqQzXlM=;
 b=UiOGpxuQCgyhf5PFfbLRNr5PEFQ5q0MZp5AEmNfUN0eWDOYxgQvv5S5+/QSMrZPXBkVtHIDiPuQieW5zpfcuisbc13ncRw21CyaI2Z98Fa/NeEWQj5VTZLW75nBAqwf8UeXmM8T4v93VIXlf9K9ibDg2sUZLKYZv2TZjqP8YNo61Kb8fOUW7O3R05Gp8eBWkzwFVcHXXjJzlLEjpui03EfxmH78t485/7ZC4HcoDJ980e2jSMwZGvhgo/UWZIBGDOAlRuCPOiPJltLOfKvRdMy6EGgv2da5a9oX6QivhHROHMNHjmOaLEaDWRK/Ol31kkk50VWJsaKDGZPKHTcyrug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhfCYud453JDgeegWkZI92gL7GV6VL54iLQ9OqQzXlM=;
 b=YWnMSKMD6hmilhI83i6icKPpUkmlr2zpLd+ijoH+2TBUD82D7j0d9/UOnnDkajJjLwvc5tRo5R0I83nqzV4lxLUQthOF21cpSC9eogRO/AKB0e2mJDJHWOMlOSx7VGkKEna9bZEg4h/pEyRH4lplCalIcwDg+td61lScJs0a+gHOg2kjCWsvBUuokbrOJ1hELaJnmydIFDClEu98fsoeWBJYJcg79WGrLNu3deZDZZS1FypMf85cT6ckp3mgx+OEN+iRVsDMcr8gEHyGIgW/rlAi2qCM4qmdWbtrhxKcV6g8X2TnIfIta57XLjCVJ5Dj+5+FcBBcNnH+MnxXRTPyVA==
Received: from PH8P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::13)
 by LV5PR12MB9753.namprd12.prod.outlook.com (2603:10b6:408:2b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:12:01 +0000
Received: from MW1PEPF00016159.namprd21.prod.outlook.com
 (2603:10b6:510:2d8:cafe::d7) by PH8P221CA0017.outlook.office365.com
 (2603:10b6:510:2d8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 18:12:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MW1PEPF00016159.mail.protection.outlook.com (10.167.249.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.1 via Frontend Transport; Mon, 4 May 2026 18:12:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:11:23 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 4 May 2026 11:11:23 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 11:11:18 -0700
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
Subject: [PATCH net V3 1/3] net/mlx5e: psp: Fix invalid access on PSP dev registration fail
Date: Mon, 4 May 2026 21:10:58 +0300
Message-ID: <20260504181100.269334-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF00016159:EE_|LV5PR12MB9753:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e97261-2776-4e24-6fe1-08deaa08a308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ghDqoGvGAAHgK3Ov+ikHw353dwOyKebTWdRPiJC3TMhHapGhXsHflJo1INlK2M+8mQSyR8SKyBmRyzW8L6fm2llA0dlKct7mbPnl6Kt+b2vV8GWxK8KmhL5YETBDV2rXcO0aWClBmyEVEWP+zo8d+7hMIGfzAogtu/znyL4DpQm5CR85WV0pvDGuWNAyK2okLP7qW0hXfu3aVVU601tZZK1RzknfwU5f8qc6mXwcNK/O0gE+apxuvXy/TLYpoIh4lHRdQy+t9urf6r2F5IBwysm87djtOkHo3B5mhsAt8l8PKHU2ZcPAzjS4FbgXCc8K6rFshgjFNGQdtccpAhwvvABDAbY1F3h7Ex7Lucx6jeZxSXYSpvyJ88E6IvNLOB3ZgqVG0jVB+P3en5ftppA0rW6W65YiOo2RDRgENw/XX0LVEqhjX9bvRUh3FtQbnzhAMayPMhZ0bkHbPDAd0knWEHzJYbMQG85DiHBmLAsloUV2xaD6E0EnjzcKiasqEd2ZsBA55dmJBiwJoXd3nHVIipkHMWkMa+s9tGAj3xkfz6Sk2LcysiCAk2ftul8IStlkeGCbfbE/ak1eNpJxsgpshfJmsMOqQkxm8Y7HvwgRIkQRGny0TTuaUuPiXVmbJCb6YAnoWgVSVstWazqe2gN7dGsqhQgvcwOqXub4yuplMAgAAx+5bH0l3OqZK6/znwjNqd8sWY6ZceDRQv8HkPp9HLGGAZ04kSSow6zVWCD+mYE=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x2lkbazpwcSOcvNJ9nOZ8deERTWTLTTjPH4KHdk0vH4rBtSy0SoDfuws9nxLDXif2NNA/s3ypbYcsvvbFZRJ2nlJqA8rImRcx4L8Bi0rZrWkFBbSvogqWeVKUrGNHBcmR4Q44TwJwSQm0/cOHoQw9fYjGjED3vAaCU6Rm19VqHu7GmC7pdaTArLNYuzSCCCeY0N7sOF7RCz3ugciWyK+OAW8uR9/X0EoWnBVkRR7nmHIFaIiy2IICuLOXAzFhQQDXDRYxx5VT7tr8nkLTwpQj8DePnkz9aAIEYIQ2aYU1AdYVqF1u03HtyPI0K6/GY8+XpMozTe2gHbkozJpza9f+tKp2cqrqKu2tO9gFdEK7XRav8DY8/LOn7hfptH1N5f/cqFuv9sHW6v55TpyEo7AmwD7nX490JNoNrNHbQn3NX/eawSSxwxf76glK6VPfsAW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:12:00.3392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e97261-2776-4e24-6fe1-08deaa08a308
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00016159.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9753
X-Rspamd-Queue-Id: 1D7454C2596
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19943-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Cosmin Ratiu <cratiu@nvidia.com>

priv->psp->psp is initialized with the PSP device as returned by
psp_dev_create(). This could also return an error, in which case a
future psp_dev_unregister() will result in unpleasantness.

Avoid that by using a local variable and only saving the PSP device when
registration succeeds.

In case psp_dev_create() fails, priv->psp and steering structs are left
in place, but they will be inert. The unchecked access of priv->psp in
mlx5e_psp_offload_handle_rx_skb() won't happen because without a PSP
device, there can be no SAs added and therefore no packets will be
successfully decrypted and be handed off to the SW handler.

Fixes: 89ee2d92f66c ("net/mlx5e: Support PSP offload functionality")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/psp.c         | 26 ++++++++++++-------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index 6a50b6dec0fa..1ff818fb48df 100644
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
-- 
2.44.0


