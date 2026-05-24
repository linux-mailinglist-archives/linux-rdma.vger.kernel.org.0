Return-Path: <linux-rdma+bounces-21205-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDjMIf8bE2oE7wYAu9opvQ
	(envelope-from <linux-rdma+bounces-21205-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 17:40:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 499FA5C2F08
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 17:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 356743012334
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 15:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C197A3A5E89;
	Sun, 24 May 2026 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="byAeMwmA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25113A3E7F;
	Sun, 24 May 2026 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779637144; cv=fail; b=oim76yaGSyM9PNxURSnauy4h47G5YnXuAlthQ1cLtexMB2s+TeJ7yhFn9CUGRtYE/SLHKvnqqDYCQ8QJ18aXZvccRPX9MlfPDU5Jv4onA+PrtLutHoAwqIjqxlTzn4qRUCwH/S979nPEg0Lx3lTXBTlLl6bMXO2hpTVp7No7G50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779637144; c=relaxed/simple;
	bh=n8vgD+0Zx47ShD19s8iVh1V7iRfLwPzs0zk3LybCjv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=auWrm5/PLw8oF33qVpXPjtLIVgoXC2CvKaD74KAO0oQfdkDlVfPVY31NSwDgXF2NUsqrv19d37i+7R8I/D7RqIcky5W527JOhAlx7C3bLXc5fTpfSVhfzmSiHz7cS7qWYcSsPgUux5hc7FK9i2IMuOfD4ZG7FYHULsCVXV4iINI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=byAeMwmA; arc=fail smtp.client-ip=52.101.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tg52xe4Lklh6mWAO67KzfFuVXt0mTiFWXGxjnZrw+0WDH7fWUUb1I5uZjC7ISL1mu6c/rg9CBzNck/PsAjwz63HGkoqNMsJJK4Cep+V2fCR6W/CkyVMDUrNSqJ68fupjStOBIvN+FKD53oRvNFW4auiVCRh262N+Ux7rmAkJfL6WHVLabhT5Su8CP9G4S7FTfkLEhEGc8ADX8DMgL0hVO6/5jFxu1ZVuorpNGin3U4fXIdiOzboC1/FoIrXQ8gjP1yDb1ENHVpo3Np0Mf/YF2ZxOtwkSe7M3eT5JL4QzLL7D1mUfYo2g81568g6jlRtu7OEr58Kpt44aFuGGEy5rVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IitRrLiG72LosYyPJ0kETv2a49ZpqM723kfu9SQZz+0=;
 b=UjfxNoQu3y3DYq7ZlIbM5I0xhTjbXa99PAsukBTbhQ5bDZCsdbgp8plJNb3D8QI6RMbD+8G4vQfNp2T+rLmoIZyBXyPTeS58/Y2nXACxfCEJrqG/aXNzAJGu0QFDzRV7bgw9uOeeS2zoYsXwc6pLLG/XkY2+EBG67E7qyOeRBWe9RSdH2RtN5XtVkhntRJOr9nu77/PJFgGXuCMYd1aK8nPyY4R6EO1y952xemtkzzXckFkJxlKhfxSqYya/CBjFZgBJHoZlpNJS/xfBMxqRWoQsRsEVV639CDYZ9yPwoUDvU8JbqifWMOmps8g92J1V5FspHJUIkp+IRfjRFPGy3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IitRrLiG72LosYyPJ0kETv2a49ZpqM723kfu9SQZz+0=;
 b=byAeMwmAKm+Xtjyp8ptLAToowlvrpThd12vzc1Ya29q0MY8soHMSv3EPyume+hn33dmsvHSHGApQ1D/w1WDoDfAJJEfVop3IZVCjaK9nlOvCOkd+tw4Y3mY3qA7Cfu1xoWh1L+UhWL4oTflmfoHhi29e39xYWIEi2xnCQXBfTENxjVWlQQH0oWeVfTpgMMigoDYH7RIwcWq6BNh6rJx6QabpHjXA9PuxW3ZmQFbDX+sGwPHiYT0bEBpY+m1YX8f3PcSaIby/ftG9ysPtp1dwJTIG2MRcAHjS7T8SKw/CysiAgo2LwVHmW3ZdMN/rmgeHpeJe5bqmcmABb3+jmnDKEA==
Received: from PH7P220CA0068.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::24)
 by LV5PR12MB9754.namprd12.prod.outlook.com (2603:10b6:408:305::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 15:38:57 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::8f) by PH7P220CA0068.outlook.office365.com
 (2603:10b6:510:32c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Sun, 24
 May 2026 15:38:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Sun, 24 May 2026 15:38:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 24 May
 2026 08:38:48 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 24 May 2026 08:38:48 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 24
 May 2026 08:38:45 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Sun, 24 May 2026 18:38:04 +0300
Subject: [PATCH rdma-next 3/8] RDMA/mlx5: Add support for rate limit in UD
 and UC QPs
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260524-packet-pacing-v1-3-3d79439f8d08@nvidia.com>
References: <20260524-packet-pacing-v1-0-3d79439f8d08@nvidia.com>
In-Reply-To: <20260524-packet-pacing-v1-0-3d79439f8d08@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Selvin Xavier <selvin.xavier@broadcom.com>,
	"Kalesh AP" <kalesh-anakkur.purayil@broadcom.com>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Allen Hubbe <allen.hubbe@amd.com>
CC: <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Edward Srouji <edwards@nvidia.com>, "Maher
 Sanalla" <msanalla@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779637112; l=7493;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=HJAtsJ/1uNEQx7tN4GDSZDpBR6yAyBoPoVDxAFpiGPM=;
 b=uYoHYlKnBtNLlcIaoslTJHSQ73txCzOJBIrHOcoW1e9dhXjWku1DyFHgVY59EfG0E9g5wtEuz
 79Xxqgh5ezZCIjg3EUsdYygLm6cNqYVJ/VMh3JfTVID8KSlI/aYjbgA
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|LV5PR12MB9754:EE_
X-MS-Office365-Filtering-Correlation-Id: 83be2a8d-c1d6-48c1-2226-08deb9aa91da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	NSbjZsIogujL+4LAGF34Z6CoawlMCO4IUSBGxfx6titlJbQZl6IMi+b6+Uob/TmTxB2imskhNkHlLn8+FzUdWlF/WWiqsEGeZSlGhE6iA0+W1aaUHEPbP7ULa7A0gUm0KHeQohFjN6s9sD2T+EtB8/2NaOQQKrDWZ9ktKqL4z3P+V6hxkkZ2n4Po/E6+t1sVVeNJ2zCbBTu+aRjhIWqJArVvr6Meys2MNKJaEmkHyMACPC5iq7ZVHRMASxaY1Hii0GPt5p4N78vdXmIv/LmOdA2OG28FYw/9BTzwjuJKDGwTKaJy1qh9csb9uHJZMdLunD//bUFYky9GMCLcpPT8yuM6pY7ggAjLejq3+qQelGdZZAFcNT3rpFcCiFaryvR1OadxVS+mykgb+muBKdbf5YRCdyBHRdD2yi/WmYAwDI0GBHoervifs2LyA586ZCgZ+2Q+OoDVje9prtYb3p8/KhVRApYYENGb9wvojIeMk3OKzAZ50U77A1Mqsev1iNZvbm+9yn41FUGkSR2PQBOzUN3AfmtGv59HLwSZm8zOTtBogonkfbm6kpS0+2tZSUHoe6SX+Tj4c5lwhwx/FUpmbRtkD+zEff1vq0MuTltqHtl8GpQruaX/69Lpg3AdEMysNj4EBwVUb08oNz95wVBG4du4o+hPOjqyf/iGzeoU2tBxQ1258DZ19n2GsysjwickrpUpmEDDpMOzDT/+sY1773YXrVHDrOks2cRB1ZULB0c=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m8+TNd3oCqYlcNDoYV7AQvkJ4Bu8uurhShok+YWLJkRTgQmFL4IL4ScLewww7qugHOZU7gWZbej5D8GNxhNHMWkX3IWiPlcghIDW8DTXLtfq5PzYG54WxV44UsYAwmrYKbtMhjXYEQHGR7mM/tU5aeFzCu7zthU4QKQeh76zijZehMarPqv8vZ23ozRuB4ooZT2NJnnN+9pyV5yXGdMYXM/PBeoOIni8Uyq2/T+gyibilRrXYSQnX+svcpSiWIJBuS82Jj2I+1VkCr9FprKr0h3urvZN5PlH9rv/CeJUKYCys4zXKqywNPDYZRdr41BN/J6G6INt2aSc+eF5RVcmr3FT2Bhve9MUlyQ1f7CMngUXfHQXn9KHCCy4l+018Y0vxQcl1IR9PbB6So5rM3AVDKcBj7lzgCv9xYs2nU2w65JK/1PnEqId4T3NXVEfwhFL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 15:38:57.4436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83be2a8d-c1d6-48c1-2226-08deb9aa91da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9754
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21205-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 499FA5C2F08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Maher Sanalla <msanalla@nvidia.com>

Rate limiting is currently supported only for raw packet QPs, where
the packet pacing index is programmed into the SQC during SQ modify.

Extend rate limit support to UD and UC QPs by setting the pacing
index in the QPC during RTR2RTS and RTS2RTS transitions.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 107 ++++++++++++++++++++++++++++------------
 include/linux/mlx5/qp.h         |   1 +
 2 files changed, 76 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index fde319a021908317d96f3cdd212ea5ebf691f13a..e96d26253e3b1fabee23947b1a61ab26e7c7067f 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2725,6 +2725,10 @@ static void destroy_qp_common(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 		if (err)
 			mlx5_ib_warn(dev, "failed to destroy QP 0x%x\n",
 				     base->mqp.qpn);
+		if (qp->rl.rate) {
+			mlx5_rl_remove_rate(dev->mdev, &qp->rl);
+			memset(&qp->rl, 0, sizeof(qp->rl));
+		}
 	}
 
 	destroy_qp(dev, qp, base, udata);
@@ -3673,8 +3677,10 @@ static enum mlx5_qp_optpar opt_mask[MLX5_QP_NUM_STATE][MLX5_QP_NUM_STATE][MLX5_Q
 					  MLX5_QP_OPTPAR_RNR_TIMEOUT,
 			[MLX5_QP_ST_UC] = MLX5_QP_OPTPAR_ALT_ADDR_PATH	|
 					  MLX5_QP_OPTPAR_RWE		|
-					  MLX5_QP_OPTPAR_PM_STATE,
-			[MLX5_QP_ST_UD] = MLX5_QP_OPTPAR_Q_KEY,
+					  MLX5_QP_OPTPAR_PM_STATE	|
+					  MLX5_QP_OPTPAR_PP_INDEX,
+			[MLX5_QP_ST_UD] = MLX5_QP_OPTPAR_Q_KEY		|
+					  MLX5_QP_OPTPAR_PP_INDEX,
 			[MLX5_QP_ST_XRC] = MLX5_QP_OPTPAR_ALT_ADDR_PATH	|
 					  MLX5_QP_OPTPAR_RRE		|
 					  MLX5_QP_OPTPAR_RAE		|
@@ -3693,10 +3699,12 @@ static enum mlx5_qp_optpar opt_mask[MLX5_QP_NUM_STATE][MLX5_QP_NUM_STATE][MLX5_Q
 					  MLX5_QP_OPTPAR_ALT_ADDR_PATH,
 			[MLX5_QP_ST_UC] = MLX5_QP_OPTPAR_RWE		|
 					  MLX5_QP_OPTPAR_PM_STATE	|
-					  MLX5_QP_OPTPAR_ALT_ADDR_PATH,
+					  MLX5_QP_OPTPAR_ALT_ADDR_PATH	|
+					  MLX5_QP_OPTPAR_PP_INDEX,
 			[MLX5_QP_ST_UD] = MLX5_QP_OPTPAR_Q_KEY		|
 					  MLX5_QP_OPTPAR_SRQN		|
-					  MLX5_QP_OPTPAR_CQN_RCV,
+					  MLX5_QP_OPTPAR_CQN_RCV	|
+					  MLX5_QP_OPTPAR_PP_INDEX,
 			[MLX5_QP_ST_XRC] = MLX5_QP_OPTPAR_RRE		|
 					  MLX5_QP_OPTPAR_RAE		|
 					  MLX5_QP_OPTPAR_RWE		|
@@ -3840,11 +3848,31 @@ static int modify_raw_packet_qp_rq(
 	return err;
 }
 
+static bool qp_rate_limit_supported(struct mlx5_ib_dev *dev,
+				    struct mlx5_ib_qp *qp)
+{
+	if (qp->type == IB_QPT_RAW_PACKET ||
+	    qp->flags & IB_QP_CREATE_SOURCE_QPN)
+		return true;
+
+	if (qp->type == IB_QPT_UD)
+		return MLX5_CAP_QOS(dev->mdev, packet_pacing_req_ud);
+
+	if (qp->type == IB_QPT_UC)
+		return MLX5_CAP_QOS(dev->mdev, packet_pacing_req_uc);
+
+	return false;
+}
+
 static int qp_rl_parse(struct mlx5_ib_dev *dev,
+		       struct mlx5_ib_qp *qp,
 		       const struct ib_qp_attr *attr,
 		       const struct mlx5_ib_modify_qp *ucmd,
 		       struct mlx5_rate_limit *rl_desired)
 {
+	if (!qp_rate_limit_supported(dev, qp))
+		return -EOPNOTSUPP;
+
 	rl_desired->rate = attr->rate_limit;
 
 	if (ucmd->burst_info.max_burst_sz) {
@@ -3905,15 +3933,20 @@ static void qp_rl_rollback(struct mlx5_core_dev *dev,
 
 static void qp_rl_commit(struct mlx5_core_dev *dev,
 			 struct mlx5_ib_qp *qp,
-			 struct mlx5_rate_limit_ctx *ctx)
+			 struct mlx5_rate_limit_ctx *ctx,
+			 enum ib_qp_state new_state)
 {
-	if (!ctx->rl_changed)
-		return;
-
-	if (ctx->rl_old.rate)
-		mlx5_rl_remove_rate(dev, &ctx->rl_old);
+	if (ctx->rl_changed) {
+		if (ctx->rl_old.rate)
+			mlx5_rl_remove_rate(dev, &ctx->rl_old);
+		qp->rl = ctx->rl_desired;
+	}
 
-	qp->rl = ctx->rl_desired;
+	if (new_state == IB_QPS_RESET || new_state == IB_QPS_ERR) {
+		if (qp->rl.rate)
+			mlx5_rl_remove_rate(dev, &qp->rl);
+		memset(&qp->rl, 0, sizeof(qp->rl));
+	}
 }
 
 static int modify_raw_packet_qp_sq(
@@ -4220,6 +4253,7 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 	struct mlx5_ib_qp *qp = to_mqp(ibqp);
 	struct mlx5_ib_qp_base *base = &qp->trans_qp.base;
 	struct mlx5_ib_cq *send_cq, *recv_cq;
+	struct mlx5_rate_limit_ctx rl_ctx = {};
 	struct mlx5_ib_pd *pd;
 	enum mlx5_qp_state mlx5_cur, mlx5_new;
 	void *qpc, *pri_path, *alt_path;
@@ -4410,20 +4444,31 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 		goto out;
 	}
 
+	if (attr_mask & IB_QP_RATE_LIMIT) {
+		err = qp_rl_parse(dev, qp, attr, ucmd, &rl_ctx.rl_desired);
+		if (err)
+			goto out;
+	} else {
+		rl_ctx.rl_desired = qp->rl;
+	}
+
 	op = optab[mlx5_cur][mlx5_new];
+	if (!mlx5_rl_are_equal(&rl_ctx.rl_desired, &qp->rl)) {
+		err = qp_rl_prepare(dev, qp, op, &rl_ctx);
+		if (err)
+			goto out;
+	}
 	optpar |= ib_mask_to_mlx5_opt(attr_mask);
+	if (rl_ctx.rl_changed)
+		optpar |= MLX5_QP_OPTPAR_PP_INDEX;
 	optpar &= opt_mask[mlx5_cur][mlx5_new][mlx5_st];
 
-	if (attr_mask & IB_QP_RATE_LIMIT && qp->type != IB_QPT_RAW_PACKET) {
-		err = -EOPNOTSUPP;
-		goto out;
-	}
-
 	if (qp->type == IB_QPT_RAW_PACKET ||
 	    qp->flags & IB_QP_CREATE_SOURCE_QPN) {
 		struct mlx5_modify_raw_qp_param raw_qp_param = {};
 
 		raw_qp_param.operation = op;
+		raw_qp_param.rl_ctx = rl_ctx;
 		if (cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT) {
 			raw_qp_param.rq_q_ctr_id = set_id;
 			raw_qp_param.set_mask |= MLX5_RAW_QP_MOD_SET_RQ_Q_CTR_ID;
@@ -4432,22 +4477,8 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 		if (attr_mask & IB_QP_PORT)
 			raw_qp_param.port = attr->port_num;
 
-		if (attr_mask & IB_QP_RATE_LIMIT) {
-			err = qp_rl_parse(dev, qp, attr, ucmd,
-					  &raw_qp_param.rl_ctx.rl_desired);
-			if (err)
-				goto out;
-
-			if (!mlx5_rl_are_equal(&raw_qp_param.rl_ctx.rl_desired,
-					       &qp->rl)) {
-				err = qp_rl_prepare(dev, qp, op,
-						    &raw_qp_param.rl_ctx);
-				if (err)
-					goto out;
-			}
-
+		if (rl_ctx.rl_changed)
 			raw_qp_param.set_mask |= MLX5_RAW_QP_RATE_LIMIT;
-		}
 
 		err = modify_raw_packet_qp(dev, qp, &raw_qp_param, tx_affinity);
 		if (err) {
@@ -4455,8 +4486,13 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 			goto out;
 		}
 
-		qp_rl_commit(dev->mdev, qp, &raw_qp_param.rl_ctx);
+		qp_rl_commit(dev->mdev, qp, &raw_qp_param.rl_ctx, new_state);
 	} else {
+		if (rl_ctx.rl_changed) {
+			MLX5_SET(qpc, qpc, packet_pacing_rate_limit_index,
+				 rl_ctx.rl_desired_index);
+		}
+
 		if (udata) {
 			/* For the kernel flows, the resp will stay zero */
 			resp->ece_options =
@@ -4466,6 +4502,13 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 		}
 		err = mlx5_core_qp_modify(dev, op, optpar, qpc, &base->mqp,
 					  &resp->ece_options);
+
+		if (err) {
+			qp_rl_rollback(dev->mdev, &rl_ctx);
+			goto out;
+		}
+
+		qp_rl_commit(dev->mdev, qp, &rl_ctx, new_state);
 	}
 
 	if (err)
diff --git a/include/linux/mlx5/qp.h b/include/linux/mlx5/qp.h
index d67aedc6ea68ae9f514a1de11626792bfe847c04..40f889403b075ebc6b860705206843aafa5d9a32 100644
--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -72,6 +72,7 @@ enum mlx5_qp_optpar {
 	MLX5_QP_OPTPAR_CQN_RCV			= 1 << 19,
 	MLX5_QP_OPTPAR_DC_HS			= 1 << 20,
 	MLX5_QP_OPTPAR_DC_KEY			= 1 << 21,
+	MLX5_QP_OPTPAR_PP_INDEX			= 1 << 22,
 	MLX5_QP_OPTPAR_COUNTER_SET_ID		= 1 << 25,
 };
 

-- 
2.49.0


