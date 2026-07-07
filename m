Return-Path: <linux-rdma+bounces-22820-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jgYwHgT7TGrLswEAu9opvQ
	(envelope-from <linux-rdma+bounces-22820-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:11:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6C271BB79
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:11:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=gzxG4UpA;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22820-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22820-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 548C9307055A
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 13:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ADE414A32;
	Tue,  7 Jul 2026 13:10:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E593FAE1F;
	Tue,  7 Jul 2026 13:10:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429851; cv=fail; b=jagbsUXA1s6Vh8kvk2MEotSx+L/8n3bYp2khrc0PaQj52GTaPq0fGADoGTYIffRrQMSxlM61HYu/Izu8OItj8/7dDcWgUXSGdQPLTkwVCidIGJv5L4726Xn9PCKS4+pWQApnc5E2m2Xp7xzRiEGZw3kus/mSyst4e1P1yKZ6gOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429851; c=relaxed/simple;
	bh=q6sTfq3a92Z0mWhg+La3QpdBqvQj4j0xNava+x0GA1o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRkn4marbmINyQwbFN8lkENez1+xrhsJH+3t41YEG8hNvXo0TIlyzlf9Xezlu7bAQtNyvnjaEHk7NEb9RnmuS1sw16WU/zy+sW/dkynzyn1GyPhlMhgJPCNmcDvkFGOBebEdN055avwVNQhu6P9KVf/l7eFG830tNd2uuPzno6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gzxG4UpA; arc=fail smtp.client-ip=52.101.56.63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/8w+FtDCg+c0a/GlC+aHAfhoGZrma97nUoopufkzfnXvAomJJ1I2kRJh2fnDNzIwz/oaCiNJ/TVtvyGDpHnZH1NQpvmAZayXwK2cqwvmVB3kpcQxHptUvI9eyKxLehJXlsejLSVijlkITSeEvponFoJJQOCqxPjJDG79YYdbZbXu5myjPPXb80r0UL7XDJrG5b7vtCs4YMSDFbQg9ggfJCoFz1K+a2338IlrfywmFKeEzC+jv7S9UWVqrc4NPfpVZEZyksDTB6ttHjGL7866c7pl3Jx5dhPtjzyWUrEFm29cBhL4fyfwDMmBaJdY5ZZYc4VV3dyR9ha0Vk1iRu6QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kt8ExIkKg9eHkwvUOuj+m0S8GbUhbL66JtdeTX02DOA=;
 b=C/fZML/NmIMJ4/+r4zSv3Tv8K1MG4SchweBTAyne0FcX3DfJguIcjDBGUXtXJB0GPj/f6jLiyr5aFbAW+IPFbKsFow2xyTl4O9yTSgRIT3Bab3ztLMYTLg0c8S8i2GwY6BRtoiiHlgcJlMGAx8QAl40d13Gh32MMq9T5j2k4XOIQZ5ECxgrqqX3fUIz+zdcVcXZX69vZNLpVh0hwoWH+vCCeKDM21AZdOp8CfRaNQkeROI+767fSnym0mcwD/L+0Fdr5uqWVC7ljM6ODr7WjCeB7eAVIykh0oQqXukaAKgLGjXu0tKl25F+y4stmYCKTsWS5SLEGCx/Qm1S1GXaACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kt8ExIkKg9eHkwvUOuj+m0S8GbUhbL66JtdeTX02DOA=;
 b=gzxG4UpAYUmJLADmIIvW6//2cmVitjyl4fuOTS3nYCqdGf7/87hDB3rukkD0LK0iSynNxyM0r/ao646XxoQveCICIrGVjzJ1Ht+3hjdc/IQJ11sfMhyWBF2GiCWZSiuVIyPgH/ymukjo4hdQOdGDZe441Qn63Lz/38H655P/ZMwYc3HzXJVbdXSPPBLXcoEkdkBuFeH4MrAtaaaKc0lrJyg3IaHOkfXLicOx59E6pyiugiu/hk4S4rXP5GbmLkia01MpkX0rGRq5FzXzVWDO1pcyLihCoS4PTQO7OHu5zHfRdQFpC+EekRhXulrn8BjhyZj3nz6psKJKOYtjaa4o5w==
Received: from BN9PR03CA0299.namprd03.prod.outlook.com (2603:10b6:408:f5::34)
 by PH7PR12MB7987.namprd12.prod.outlook.com (2603:10b6:510:27c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 13:10:39 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::ac) by BN9PR03CA0299.outlook.office365.com
 (2603:10b6:408:f5::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 13:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 13:10:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:10:13 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:10:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Jul
 2026 06:10:06 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Boris Pismenny
	<borisp@nvidia.com>, Chris Mi <cmi@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Jianbo Liu <jianbol@nvidia.com>, Lama Kayal
	<lkayal@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Raed Salem <raeds@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, Stanislav Fomichev <sdf.kernel@gmail.com>,
	"Tariq Toukan" <tariqt@nvidia.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next 01/15] net/mlx5e: psp: Rename the saved psp_dev to 'psd'
Date: Tue, 7 Jul 2026 16:08:44 +0300
Message-ID: <20260707130858.969928-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260707130858.969928-1-tariqt@nvidia.com>
References: <20260707130858.969928-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|PH7PR12MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f76d92-4405-46f4-acab-08dedc292438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|82310400026|1800799024|36860700016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UYgFetkQvdX1rLS2stM4zZvq9WR/PhVh5k6wt/ttPBMP+ZpkfNQYneR5o7NqhnPctL/ehSYvkiFGNbpBrG+E0G1e8lD5hc0kTw1luucnAV+ZLDBGWXQWTJfX5oFXKSJCyCBQX9Kf1332XR4ckHC/KqfFHLxtpnPXHmZQcbvaBWOapLQlQeXqFtYv7GFlamClFJNCpdq1pAafkrNBJjMALe17MKvnkkD9anjuSJk1Iaxtye8GpaW0zXGpviwx084ZHDBM0MjQZZtJFtarzP2WYFiOxW+5IsIsgdOVHOoTo/d797vTXE2xEJzG206pl1zW/DDPpogFjcxIyX5hcSHuZMfe8rs87pTCZd4uVNaAN4wI4i8hJ/NUXdc0fXW1TMcU54wizkiWnYRMKUs2MIXH9j+rh6UPeDN/ifd/JNq6MiqaM1juA4lxFlfqJejAXKjzIdoK/mS0D3LQiEauuECk2Uobv4p7Rkpgh1EuB8BUmQARdimJvbHMOwyj4U2+r+p2rlU0pxVrRjYsVi3BOL/WIvLY2wxH4p6vd3ZFZ4MNJVrG95Nob3mwa3nvSfY19vqvoWdHOMdftRRHbsn/5rF3vc+Nfoz+MxncCdeeAMQKQcgNyQBT2u/pg4EoLrJu/OiQoha2/gf9ccy0zau1lXulg1ZFLsEvZpjx3Xy+XLqQZHkd2YHk+rSGfIpBCvvVso0HgLKMDTx/+v5LhRr2074YMw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zxjDw+DVtTzUhtoGSVkmTH+jPOWWvFwh3Ymx2id3vDaywjI/5Q+acW2Y5TZffDTl9OejjTwX+hOW3wxGKLMhhF+1QpZUh1+NpbORWjcrFA6CTyp6UUnpc7sBXTsJmjlrW7FkeWjTFUB5gcv7vY1v36ZKH1XAqQXYLaiNrjXICz1wOYM2BoNx5Y/Cp1wq8aUZUWAMHrd+K8fZJOCpyJQF3vifAe4j/CQ4or5czhb/J/X4iYkBoUmRFtw5JD1TBO+QgD1yhW8zq8moVqUssa8Q5ZZJU6u4SzNiqU+9ZU/4zl1AEyE2j7gK+/wI0HSL7JaMMhjAabJVZb/opcsZp7Avqnlphyb0fNJK5T+uzrZYQAGw+2h1TYJwHDiD8/lQi2oH9WeAMT7vrySVlfLAVc/ZTMrGi6Wu62gy4U+BPQ1NFsamw2HLcnjv9OgWnt69+WCb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:10:39.1155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f76d92-4405-46f4-acab-08dedc292438
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:aleksandr.loktionov@intel.com,m:borisp@nvidia.com,m:cmi@nvidia.com,m:cratiu@nvidia.com,m:daniel.zahka@gmail.com,m:dtatulea@nvidia.com,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:jianbol@nvidia.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:raeds@nvidia.com,m:rrameshbabu@nvidia.com,m:saeedm@nvidia.com,m:sdf@fomichev.me,m:sdf.kernel@gmail.com,m:tariqt@nvidia.com,m:willemdebruijn.kernel@gmail.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:sdfkernel@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22820-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,nvidia.com,gmail.com,kernel.org,vger.kernel.org,fomichev.me];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F6C271BB79

From: Cosmin Ratiu <cratiu@nvidia.com>

This is the canonical name used in the core, so try to be consistent.
No-op change.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c    | 8 ++++----
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h    | 2 +-
 .../net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index d9adb993e64d..4f2fa6756b82 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -1072,11 +1072,11 @@ void mlx5e_psp_unregister(struct mlx5e_priv *priv)
 {
 	struct mlx5e_psp *psp = priv->psp;
 
-	if (!psp || !psp->psp)
+	if (!psp || !psp->psd)
 		return;
 
-	psp_dev_unregister(psp->psp);
-	psp->psp = NULL;
+	psp_dev_unregister(psp->psd);
+	psp->psd = NULL;
 }
 
 void mlx5e_psp_register(struct mlx5e_priv *priv)
@@ -1100,7 +1100,7 @@ void mlx5e_psp_register(struct mlx5e_priv *priv)
 			      psd);
 		return;
 	}
-	psp->psp = psd;
+	psp->psd = psd;
 }
 
 int mlx5e_psp_init(struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
index 6b62fef0d9a7..a53f90f7c341 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
@@ -23,7 +23,7 @@ struct mlx5e_psp_stats {
 };
 
 struct mlx5e_psp {
-	struct psp_dev *psp;
+	struct psp_dev *psd;
 	struct psp_dev_caps caps;
 	struct mlx5e_psp_fs *fs;
 	atomic_t tx_key_cnt;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
index ef7f5338540f..c2f9899d23a5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
@@ -124,7 +124,7 @@ bool mlx5e_psp_offload_handle_rx_skb(struct net_device *netdev, struct sk_buff *
 {
 	u32 psp_meta_data = be32_to_cpu(cqe->ft_metadata);
 	struct mlx5e_priv *priv = netdev_priv(netdev);
-	u16 dev_id = priv->psp->psp->id;
+	u16 dev_id = priv->psp->psd->id;
 	bool strip_icv = true;
 	u8 generation = 0;
 
-- 
2.44.0


