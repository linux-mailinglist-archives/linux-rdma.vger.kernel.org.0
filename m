Return-Path: <linux-rdma+bounces-15982-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GItoA/wJdmnYKwEAu9opvQ
	(envelope-from <linux-rdma+bounces-15982-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 13:18:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E39807E1
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 13:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BE03300AB08
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2091E319847;
	Sun, 25 Jan 2026 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tmudvVnw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E2E2DBF45;
	Sun, 25 Jan 2026 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769343452; cv=fail; b=PiIYM8xtGv5N+clj6IvoQeTm4XMSuejD2FzHKhBlxoGD/5EYssxRBV+7HrTphxWrnd3AperlGUFjDSAaoy06DzD1g/9OoPbELOyotyx/7/t39JQ8rVXg9LQUlqA0Mh1lTi4GSn6BPqLCdl53MAl9bdFoZCTQ6ABIpvVb79W6KME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769343452; c=relaxed/simple;
	bh=aDXhobxJuJm3alCrY4byl/rCwHIIwTlcGjV5dn562J0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxeXftdxDcUIgSjEu96SYAjL8OyosEvFh/lTGWAVAlnYQBunOWTf/ZoxRp1pLJDyZ/c4cyv8hmt3C4Jn+MQpcTZ5t1VbaRqsVXU/YBQNVTRcV+CLYRtWlOzd+EJjfUFVKCSpw5nPfOzfe6y/w+g0/qAhlKGTRAXl+yqRr1UDC2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tmudvVnw; arc=fail smtp.client-ip=40.107.208.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HR3jYOWpIH+9UikI8p0YxKXwtD7zKtxQ6pfT+veh5eOpxnt63pqzyUCQ2YOdvIXZaAF/SMdnz/vrisUauqdKMJyfY9nVQ+UJ79IsU0Dg8H+WwjyjxUC+F9fUeNpqz6tvIOSjQHjIsWXyAT+NMmj8rsP+MzigdQJ4YEH0ihGqHL2XKCqoMaZ472rvJmNMuOhsKHEGIUlc/QyprdyHJNuHBsFf5U2Xry+8Sf0PNPfTTU6YEqZsIJ98kx7eVuGxSuguja+JXbDlAnQ3FfocnSHrsPV1accEIdNvusueKX5AXuxblu9O59cuDuOkmHmrWBxM7blouJM/jCjHbTWdcbAS4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMTrn8H4ECEakzGy4Av1nRbFykENrymYTn2MCXbVyvM=;
 b=ezIcUlAo6o4H/OJ2rIW64RwL/1GIYDi+qfo5BkeIutpPWLxZUobvvbbwuPZkAoaLBVZCIyzA7IfS4ZNudpl19O2jMcHBaR4aawLLUr9HHdGUeOiSuWDelILpIoxGfyrpbG9bbBX//9sePhWQB4RUpt15XFAQr6/O0d+d9svHAlxTHqOQCDFVj6FI6/5iXoQD7ub2XD7zEdutAytu8ic9YE2hFw3RFQpSpioyI8rD70u+wI/UU6fC3z2SWTwufV+mPNUP6a+WpyjMiNJToidPxWIKzQCvN8BdZip4hlFzOj3gZJ5OBFFUWOOMun04r2ZIf9k63teNHNJnthBs+UyQug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMTrn8H4ECEakzGy4Av1nRbFykENrymYTn2MCXbVyvM=;
 b=tmudvVnwmBoLm2NQWthXqLQ9rsFTPPNRADYcFJuKDtdosLE6lo04JDf7mBxa1RrLJ4fRrKVnUd9LQRpC+oz9Y4S2SEpju11t9PRI67cN0Qksh3m3ibvOn50hEf2Q5uQ9rPFHbhUnLsm/dUmkjPA5G2iH55Ft/PgsP/PQ9DFhkBoCKfNtoEzGmc5CLA+UxVoiqssqm95x0wn6I3l1fgyC6/IBG5W4cfa/0IFVA1Qkaxy6tWTTVtWWRgxnz6UreLqnJHwpFvHr0384TR+zwSx/TklkCu0+y0T7ue503jgc1AT4zjh0M4lcUOjrAd5gcN+Q1vdARsNzllruOqavnU/pRw==
Received: from BL1PR13CA0193.namprd13.prod.outlook.com (2603:10b6:208:2be::18)
 by CH1PPF16C2BD7B0.namprd12.prod.outlook.com (2603:10b6:61f:fc00::607) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sun, 25 Jan
 2026 12:17:27 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::90) by BL1PR13CA0193.outlook.office365.com
 (2603:10b6:208:2be::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.6 via Frontend Transport; Sun,
 25 Jan 2026 12:17:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Sun, 25 Jan 2026 12:17:26 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 04:17:11 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 04:17:10 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 25
 Jan 2026 04:17:06 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Igor Russkikh <irusskikh@marvell.com>, Boris Pismenny <borisp@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, David Ahern
	<dsahern@kernel.org>, Simon Horman <horms@kernel.org>, Alexander Duyck
	<alexanderduyck@fb.com>, <linux-rdma@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 2/3] net/mlx5e: Remove redundant UDP length adjustment with GSO_PARTIAL
Date: Sun, 25 Jan 2026 14:16:48 +0200
Message-ID: <20260125121649.778086-3-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20260125121649.778086-1-gal@nvidia.com>
References: <20260125121649.778086-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|CH1PPF16C2BD7B0:EE_
X-MS-Office365-Filtering-Correlation-Id: ae82b9e1-10a7-4b84-8e1d-08de5c0bb3d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f2a7trAq/mHw2sNnY4vipHUNzw2nh9B1fHoRKwlZd0+68wFkCDZE/27YS+Sw?=
 =?us-ascii?Q?XZq3aly/3Jl6pkIUIFkeyPo7NmN2+RI7QjD84HbWeyMdhIGK6QgJYCUOTSiy?=
 =?us-ascii?Q?9OSHhpxnDupSBHSo+vTLN2mgj6ZR+uz/2GfblbJfWA2kn0X8ENarR9f0DqOu?=
 =?us-ascii?Q?YkUWrWgoFhLT1DAHT+V6PAOh0umAsU7PiTQgjgMC89NZryfZqscVTqItSXaY?=
 =?us-ascii?Q?L4+RV7dmKDqiaqtPnOde7VVp47EUIITSOxVpX503JDw3rRywbwDcaLuJKddF?=
 =?us-ascii?Q?jCBhBXXN2TQ3eHFWwydbLlX3dYmsI6GrUC3gdZj0d4UWVds52jakpljoaxsW?=
 =?us-ascii?Q?shveJLbcxofXDrJvCDtBVL7/aZbSAhbozrNmSyWS0o25cEyNA0yg7m4gRnSV?=
 =?us-ascii?Q?ZEyOenq6LC0oc2u5vFe0nEgVjxNxPtEmXJI3Ty/zct723JnHIMb78vwR/QXf?=
 =?us-ascii?Q?yHAyAm5I6XYXaDIPZuQ4lfNM3ul8/A+nlKSXNlt4umkVSbrVeOSuFZrWYqbX?=
 =?us-ascii?Q?35xIgCuWDMtItL39bNa9lSReiIsOOVErXspq71TYHfXHPjlG9zapyMISqHgB?=
 =?us-ascii?Q?Uc4ptZh5yA6PBy2cB6izFvq7Rrcr0BlIzx3DZGiFxo1x+OPgBGI6D7gRCpTr?=
 =?us-ascii?Q?2/Ax6vyhkTRrkT0FFRwA4oX9SxwTA/NO0ja773KW8oU9PYSn2OlvKrTIM0Xw?=
 =?us-ascii?Q?eXDMoRlr1YUgsd/vDIxs+SniwYwStOZLl6Rfidsui1EdJiIa5qzOxEXiCNBY?=
 =?us-ascii?Q?HrZSPhCVcep6w3oP3MNfZrCOnoplafy4F98wdo0j/HLSjEfEPoiNkV8FAchk?=
 =?us-ascii?Q?e/2tYUwYJCAk2v3TInjUKbjW0L7vmxS/Pf3EvW4ATMvkH6KKX2wmdlmgdbIP?=
 =?us-ascii?Q?TfnJTQcyOFio3s+VHYss+1Rolz8ym3YihBBuw0g2o7KLiJ5x0K/1J1e0acm2?=
 =?us-ascii?Q?wX8HPRKBHK2BMY/Pui7ZXOtQMFQP5I7drW0WWAUH3+egpIzyyYvHn2ix6iE2?=
 =?us-ascii?Q?x9zSJOSA+eyic2YgcEYQKJHhEq0hpRXkjznqrJbW799hxD5IBPwHdyB8iWvB?=
 =?us-ascii?Q?gc6/XLTdWs9R3o/upt9N/8Q2cphFs3CtVj4a3XxKltbefUw4qqE7KHdTeOdr?=
 =?us-ascii?Q?bokzxvHwywvbtcbZjFVKntVhOxejRKopPSOWkkJ7gGJP34hy+I7CMbayzqYa?=
 =?us-ascii?Q?QHBnrhFOrt0GFQZD6g4WCLBigOb7xzq6MIYknn/zaR0qgHpuWneKgEx/OvQT?=
 =?us-ascii?Q?47WuuhKB/Jh22bYFvgYxpxYLVG3KfDnOs66Ts1Mff+JHl3uJ0fsVJq/0zgeJ?=
 =?us-ascii?Q?rPmiaa4CmFVl6MG+svMSlUq8uX6NT7tNiL0jMIXUy+QkwtgzA9AyvxvVvPKC?=
 =?us-ascii?Q?IqP2JsYbhDwGtYHWElL9eYw+C1z9L3DLkWlYK/SLs+H7q8SYKOP373hBUp2d?=
 =?us-ascii?Q?3A0PGMKrBERQSoTY8LGDs7Z7kzZYVbll9OWHcZkUooLpddajzfU1NLivDrmN?=
 =?us-ascii?Q?UYdK/tt5HO2Lqydat5NOOOqvn28D1N+Iruo9/Nnplootb36X8L2n6piAheIA?=
 =?us-ascii?Q?ftRRvtc13RJs/OSmgMohhdoxiJnSOTZDTKY4QLmGvglgc6xokDzwdJjtc04p?=
 =?us-ascii?Q?aD6MpqY0Sxb+aCJxS0o9EoCqWAZhQp/Xt4mFqVaUcYtgdWi3Qw0XYQ4x+hyb?=
 =?us-ascii?Q?rR0lqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 12:17:26.3058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae82b9e1-10a7-4b84-8e1d-08de5c0bb3d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF16C2BD7B0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15982-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A8E39807E1
X-Rspamd-Action: no action

GSO_PARTIAL now takes care of updating the UDP header length,
mlx5e_udp_gso_handle_tx_skb() is redundant, remove it.

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/en_accel.h      | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
index 8bef99e8367e..b526b3898c22 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
@@ -100,20 +100,6 @@ static inline bool mlx5_geneve_tx_allowed(struct mlx5_core_dev *mdev)
 
 #endif /* CONFIG_GENEVE */
 
-static inline void
-mlx5e_udp_gso_handle_tx_skb(struct sk_buff *skb)
-{
-	int payload_len = skb_shinfo(skb)->gso_size + sizeof(struct udphdr);
-	struct udphdr *udphdr;
-
-	if (skb->encapsulation)
-		udphdr = (struct udphdr *)skb_inner_transport_header(skb);
-	else
-		udphdr = udp_hdr(skb);
-
-	udphdr->len = htons(payload_len);
-}
-
 struct mlx5e_accel_tx_state {
 #ifdef CONFIG_MLX5_EN_TLS
 	struct mlx5e_accel_tx_tls_state tls;
@@ -131,9 +117,6 @@ static inline bool mlx5e_accel_tx_begin(struct net_device *dev,
 					struct sk_buff *skb,
 					struct mlx5e_accel_tx_state *state)
 {
-	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
-		mlx5e_udp_gso_handle_tx_skb(skb);
-
 #ifdef CONFIG_MLX5_EN_TLS
 	/* May send WQEs. */
 	if (tls_is_skb_tx_device_offloaded(skb))
-- 
2.40.1


