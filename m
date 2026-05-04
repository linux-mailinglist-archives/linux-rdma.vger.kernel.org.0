Return-Path: <linux-rdma+bounces-19942-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P17BZ7h+GnM2gIAu9opvQ
	(envelope-from <linux-rdma+bounces-19942-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:12:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABCC4C2587
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAD2930376B1
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 18:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256203E5ED3;
	Mon,  4 May 2026 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dk4+eMFh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AB612E1E9;
	Mon,  4 May 2026 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777918324; cv=fail; b=gBlFxEforf2IR93vSenYq6GwQC742iAoM12WQdJnFftQ2VStbxvWdbeUdF+v87OhvtlRiNUm6BWVNYkAxGrs+on2qmUv4cjJ16MasPJHhCfFFuS+AV6rDKlbMeLo8Ec+TcYxlMv4HH/B1phL7AkTpk9xyxFIzbg0fLk2yc4MMqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777918324; c=relaxed/simple;
	bh=ct+s+epdz8MsXWs5nI3PDM9ZsfWKT6f9+WNtGjO3RIg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DsAJDzYALnY0dOvdj1SszR/hGvRzxT8uNKUo9UlFmoFEpF654aIbxj7aAGC2H44amWop3yfY/z0LCyZrYKxX/84qsbYjfnJ5/v84QfCc7gssy0OrWJ60yZYlLfhn+STzjI1uyIWVMQK241OlszcCHwBudsisZucHvbwqUeFijRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dk4+eMFh; arc=fail smtp.client-ip=40.107.209.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dx+7yJkr44rswzHJKJRwSIPurhNl2f14P+ohKQXowHl0aEGTN2cPPKbGV5hzDnklnxkf8DjDnaHMbccGB0Z7gDwGR3TMg/uCPYrdPo1uD6M+39ek6uL5zNZfwApT+kAT9EbSBp4Yfxc8l8rk3ie7EarLbRDIQQkASM5ryQgCWZWWmoEE2RostTroe3l7Cm9OjyLt/wCmvFkQPn6SB9GfaTtcW3xHqpU02AexdBtSVwYDSHOHd5i/dPAPeNEj6yON0RM4paParoEJIpjWRfhHLVH6qEKMPNyPrQQMPo2bNc4lwnAcyoPY6wmpZGN10iomL6ldgvCiZ4xHoQFT9jdpDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjC+EYtE4bIEXdUqvdXscztQIVvrSkk6JrSmDBuAcEI=;
 b=EdU+GP4mqmzpwWu1IEd12skYCCGs6X2VW75g8ihPEUCULOAnaLonN/ZHxIhLtzSybwcd2BNZ0m/3lv54i/SynILUpqRhmfWsPpcRf29Gw+TwFsOqLUFVqTGsSiyHRvbNG181iwrubogBQeVXcjgkqLL325mT97wUKTc9fgTYqId/lvtaHjgQJng9ZpeU/iRc4uHEHjou3fDUQidbBkXFuilShZjj9AiudSto9EzGurkaBitbaWhG11hB6+Z/o23NkF2SNptiY4+Cn261tpEGqic7yrlF82Lp2TBHzC916U/3sBvuIRjjoBSDdhlF6xDk3cE833WK+xkXS67PrT82Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjC+EYtE4bIEXdUqvdXscztQIVvrSkk6JrSmDBuAcEI=;
 b=Dk4+eMFhIbjkWD7Tj9xlFAdxDsL0sIHRsrtu/14FeQFEhkwmX18GEUVoPfPsft2DT/kvlem4V5qhyKgT+1N+XWBPIDMFK+dIc/+TJrwBUtna2WPwtUOFNpfmuwToXbcYmZC6758xQUH24HRNReM9ZHnjyR+ggoOGJylOQKTR2DtwSoUw7WOe05EzUO1rmrn131n3Q/xjmdVnveRcnAddsp6OYyC7qWvWWD3j7mPH3KEZu25p1eubkisZ5QnJIX9yyJETfO7m1jRWGx8rWWsAMSIlEqyuAEFVfDeTOLj1bjJwaY0eqViiZWLgz/VRnu88Maox5a0WUiGyYGY8ZfzPqA==
Received: from SJ0PR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:332::7)
 by DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:11:58 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::b6) by SJ0PR05CA0062.outlook.office365.com
 (2603:10b6:a03:332::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.13 via Frontend Transport; Mon,
 4 May 2026 18:11:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 18:11:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:11:29 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 4 May 2026 11:11:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 11:11:24 -0700
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
Subject: [PATCH net V3 2/3] net/mlx5e: psp: Expose only a fully initialized priv->psp
Date: Mon, 4 May 2026 21:10:59 +0300
Message-ID: <20260504181100.269334-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|DS0PR12MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 45769e83-01cc-4479-7c1c-08deaa08a14e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	EzXc1s5vXSQDhsZxDD9IiwD1OwF1QEd3yS5NxLElRf0nZmImsxCXHpd5EafOVkBzFWuexcGQifD2IysHtiSqnSXr9Z8/pZh24boR+NVrPZWFe0KDguUv3ny/I6y3yNMK6p+R9InAY0LYULl9g7oCjMO/LXZrmGjVYcjU+ngmKuSOMkci6PUYSBm7OvMT665szOFrV7n3u/QOY6fZPQg7ThdUL4q03SNhaX+4U5/sArbFaVZiKkMTyLwzjTkimUA8gNCXvh4mQtUx71+82F1Rq/JaCxC1xMIdR+mUlOHvw4kkxsoc0cgPe/ctlFXy088MU2pOwsB6MM2rAflT8NNN4R7EUNuJ2a0vxh+3t3jRUkGufScEILMQxAtho4VmSepvT05ne4uYmC8r852JJcwyspCQ7hJBRALgJs+KdICW0hnh0c0sPidnELTU9KZDPf6kAbK7GGn/nWFo92wlOxWla7JTLtz8kcxG6dr8TgKfHdV3gl8SL5thgw8hPjIRIvYhFrHLZMbUVZXe/3fWdajt6TxBZl/GL69Rw9gC0u9/T3Vv1mqiQA7Orxk0qQSZRHpLfuMVKsynLeINmY5xS13BrAvrIlIKSw0PMzTgwkpUOcxYX73xSynnK1Xe099YuTfZ0LwkjK+kyYkxdnvTBdAeAEXq2jba5CGSGcakLTKD068T93KW3y5EryqVU1TKoQAFpRw++GSHhfXsRgLn42plMVLBV1gHTVcWje+Ebs+WOvg=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1hDIMaRgOAPqOkbGUhUdDZ63zI6LAK2tE6mBCGNrM/k/V/w3alCjpl64OuWYbJ9UYuPaM6Mz5rLoFMLm/xqlCTo1JSrhbjqHZKSc7olu4Zd9iwXs46TBMbd+6u4/WAJUvXdweIlxTjYFQiujEkmci593qJRxxaOssdcvB8aH1UY3xbdMQgjPdNahUtKEHEFlycfXlx8QT//WxYMXrP6IE3YxwXY3PlN+vnXBwzvn1w78IiA081BUgx69pL1ckdSnBl36GxzKSNHNxEEMfCVeMHKwJiU9y6NR7j5PHzat+s0X63kdZAEnaAiVmVKxi4yP+pNqXtuS1qQLXgAgeqDSUFOmEUxdehhI9ZEbe6vh2htLbYvWphTO4/7+jb9deNxAd2v9EtWcqXU4bKeRY+vaa0Ltk4Gq3mnVngsZNcH0tiEc2G6VqCxccnBBU42sWuQ1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:11:57.3164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45769e83-01cc-4479-7c1c-08deaa08a14e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993
X-Rspamd-Queue-Id: 6ABCC4C2587
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
	TAGGED_FROM(0.00)[bounces-19942-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Cosmin Ratiu <cratiu@nvidia.com>

Currently, during PSP init, priv->psp is initialized to an incompletely
built psp struct. Additionally, on fs init failure priv->psp is reset to
NULL.

Change this so that only a fully initialized priv->psp is set, which
makes the code easier to reason about in failure scenarios.

Fixes: af2196f49480 ("net/mlx5e: Implement PSP operations .assoc_add and .assoc_del")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index 1ff818fb48df..d9adb993e64d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -1139,22 +1139,18 @@ int mlx5e_psp_init(struct mlx5e_priv *priv)
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


