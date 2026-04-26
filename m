Return-Path: <linux-rdma+bounces-19553-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHTNHXDQ7Wn2nwAAu9opvQ
	(envelope-from <linux-rdma+bounces-19553-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 10:44:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C31C346922A
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 10:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 981C53073096
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 08:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8F0344DAB;
	Sun, 26 Apr 2026 08:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WqgNBCyW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EAB342C98;
	Sun, 26 Apr 2026 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777192749; cv=fail; b=hxjnWOecvCrVB9CpN+dcJPrHF4o4RaGQqQ7Bwe49DY828RHPpWsvy4Uq7bj71da3Wl5sS66VzpMLtKdsuJzC1eXirLRKVU4Q05dkg5ASyAsqeWQBpbJNJD3ZkgNjnwdKrP8QzuOITzXL2I2yjYsu7df10xj5j/rtUUccJEEoT0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777192749; c=relaxed/simple;
	bh=+HmZDxRxUqAkRjiEu+A4zMU5EQTuzl8gbitFxFB9/9k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SkGSHDaMGkCfHXGX7Ln1U7yEUpC7ymD5k6R44mH/dRSjpcOi617O6cvtXd2RYPagYD1mQ76fv9XUMh84Q5x7uzeqrYv9IStNwAsR3SVDN+S/4iNLpPicpcT2i+R21lPttQHliOGcFozLoimoNAs58uRMbZ+44J9G7l1bJYtU+Go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WqgNBCyW; arc=fail smtp.client-ip=52.101.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMJdNKEgxvepCn/bjLRKgqFnVCEcc76NI92C1e3rtCasIlSGz57lsce4PEr8bqZ49q2xf8DKq+iA1a82TDbwPHVF7iFYzZ2ATEcXg6hGINYi1NIjMDbo685rnGIp8WECWWsqHkxXmnfcmpQbm5BhldGUVq5m2dcoKtp6LM6kCc1tv3f97g+Cte+DV/0m7uCb6MKS3yOcTjWIMzsFfZKU1Asmr1djrlQHBVxfIBiwIz5h7PyfJGrbj1nV1C+q83ZM8QAsm76CAY+d1IA76oFoAXI6q4jMH+y0lE9Hta75edSBK1uQ0EUfF54vwK3QP4Rn2GTus42dBV9if4muZmHMxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOeuLjfxdQCPgscV5obhoO9gJq4GjSycN1HLr3P+/Os=;
 b=a04mGKQzuAIbjZGlDrA5wEdKsUNpP7B+v7YNhuGzaIeqiJwoftJcWggm2kBD8wJfQFhdLbZiSODXt/LtF/op8J5muqFxnYCqXexSgTOl8RcmAXSvSKYkL7hLwzISSikmt++wEPJEE2/hmqZSHo+iHH3NJ8gb4mt9oUV1CrjrWwKuLhiv/pPk0JT57GZt7zCLmv1I7dvV2FGgTqIMxYUAopOsVajLRkKYjBOmY8R5ToT7vt0ts6CJFO8+tlXVNK7NZoVsC1Xym9eH8/Z55s/Fam5WCAUWj4hnBl11op0EyoRl7xGGOlb+V7ZcgeiKtYdrFdq1V0B/ytZmdDble+msZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOeuLjfxdQCPgscV5obhoO9gJq4GjSycN1HLr3P+/Os=;
 b=WqgNBCyWKt71le5eaUg25eBMprL+SADG6rX3+BuMhOg40gv++ID/EiRO79Cv5AZGSErlevTBcrVlgOwvvY0QrWBvyMHoCTuXSfkixXabBg1OWrjzOg2GdRQxsx46zZU3bvXNd4N/TElrNZp+W4+6GPvjTKQ9fUQhNNw75IlQoqnvNopYGDTOOb5RsAL6skQqBuMxgX9yhr8WSPiBxV2PMmN/3lSUeHU4TO7PKn6VQuzV7gvmf/bP0B9VEKL04DPFbE5AvbM+NlgyajLrYKtdkrbctgkhYY7odgeK8ND+nCcF//cDG9Jwll75PLpOmup0Zxia+985A3CxRbsqFcOnBQ==
Received: from BYAPR04CA0036.namprd04.prod.outlook.com (2603:10b6:a03:40::49)
 by SJ0PR12MB7476.namprd12.prod.outlook.com (2603:10b6:a03:48d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.12; Sun, 26 Apr
 2026 08:39:02 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:40:cafe::50) by BYAPR04CA0036.outlook.office365.com
 (2603:10b6:a03:40::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.25 via Frontend Transport; Sun,
 26 Apr 2026 08:39:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sun, 26 Apr 2026 08:39:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Apr
 2026 01:38:45 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Apr
 2026 01:38:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 26
 Apr 2026 01:38:39 -0700
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
Subject: [PATCH net V2 1/2] net/mlx5e: psp: Fix invalid access on PSP dev registration fail
Date: Sun, 26 Apr 2026 11:38:18 +0300
Message-ID: <20260426083819.208937-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|SJ0PR12MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a12c326-e95e-4085-68c5-08dea36f44a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eTBVwij95BLPR0wsfrZgceA3DtD9bcEZu9/fLFIgUNzrPn/n+FnLBHTyplF2a1DKCauAuOmJikEWcZmfSQB6DUMBFBaaooYGuxgKdAUgDwqCRwkLGfBgSbE2G3DsuT2l3ZN59xw6oSlsRTVm27Uqd411mOvug5kEZ300g5YjEd8ujbDRBHRd1v9zFASeuaxVnPhkLdlnuFUZZbtkER6xIwjvJhg1yi9CpaUrdMEqDyAkFQ7rljowCBlPrBWDxr5E1yTqo0IqksgoQFOBQWaCkfLXKZJ2v6xwRHn080NIe7Exo0jnu7v+0RvvsHfnijzK/yL7IOB+PaTQvfJrNKwr4VnNWH1OCGAmVJdsU/x0C2sgTe/P8+J1qI4fDNXLB87P1xJ7t6V8CxduCisE1qe2cPBH7zFrY3sNmdVF3pLHwi88WwDMW/jQZgkR9XK/3fGv7zpWiHzajOXbBgaHawrKQb3ssCRJ5+nw3KAJQ15BY3gP+L463eA5H9+CRV1NppucAxgWg1YBOjHxGUQDRWCrr1irNV9eI6vgwRux8wmanm4nsRKvIa3LN9P8nQuemOjlaatsmAygl4AeL8kBv2x/TGGD3XUWqNTSBlNAOMLKh2S92ni/Camy6SWCrZq/3Oy4VmwrA/A8ML+7culU5aneeMHBKf0hGSFjWZi7iVdPf+7yKseN4o0UdvOn3Vtb8gDRWD00ZidQjcZQkKpBrqo7O15jyJ6XuVTuSsV56ePkSn7uj+X6ES6XcXLHNYUm/nKWRbQAeXz73L3DEYQvCLlwVg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QABciH2+CI9p48FPxrpOBbEQLoQQ8/b1xVipqoTV/LRQrNW4ongd9YAK3poJ3uGfIFXS0PAVA9yNfsw/RigvwctBATc33PbVvN/DXJvMmA30zkiRZ5loxaEXZaEjMh5Olvhm0ew/1qRbR5InOzHLIGkOmDt4vaR+UrhYARbvMV4LpVwxTglotaOxSJRyxrjGOeyqYToppstRkXDXsPk91uES9JJAWdtPBMESnt+SU1dIJ2h6AgVNI4wWPAfCMXegdYprrrJJsiNNgkg5YDY/k5SJvGHhb8y7cecaFZtJjOCvi1/yhz1r0e4go0cd15lqUkzozr06L0+sdIzZshRZanzIcras2vaYcRnxNDtJCT4dpM4zU831qAxENwcHfLWTlPrRRDOnj1C0IrBKf+U+aJsVINmbsKufKjOto3JJG2LRDPBXRypGGsyQu1987lOd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2026 08:39:02.0577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a12c326-e95e-4085-68c5-08dea36f44a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7476
X-Rspamd-Queue-Id: C31C346922A
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
	TAGGED_FROM(0.00)[bounces-19553-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Cosmin Ratiu <cratiu@nvidia.com>

priv->psp->psp is initialized with the PSP device as returned by
psp_dev_create(). This could also return an error, in which case a
future psp_dev_unregister() will result in unpleasantness.

Avoid that by using a local variable and only saving the PSP device when
registration succeeds.
Also apply some light refactoring of the functions managing the PSP
device in order to make them more readable/safe.

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


