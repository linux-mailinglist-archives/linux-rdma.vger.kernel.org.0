Return-Path: <linux-rdma+bounces-21784-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vbt7DrqJIWqVIQEAu9opvQ
	(envelope-from <linux-rdma+bounces-21784-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 16:20:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C003640C86
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 16:20:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ZckAiztD;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21784-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21784-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 387B430B6768
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 13:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1D447F2E6;
	Thu,  4 Jun 2026 13:55:42 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011013.outbound.protection.outlook.com [52.101.62.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6923E480333;
	Thu,  4 Jun 2026 13:55:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581342; cv=fail; b=JZr9TRDyBEPamTUfLdsX1xrZ9FsC+ibD/8+DqXE4f+058981YdJDpCpIfiQvnx8Wv8F411I+lJ7+p9HjzGw7yVmegmpvRleg9xi4jYT6IM0mSjdJJQ9spoi9DrDtI8NYa/wG/nT1V5chXu44FlO2Qc/Ile16Wbe3LeIv3voLbTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581342; c=relaxed/simple;
	bh=lmeTtp3/lWX1EjeATy3MvV7jwWdf4MFW2rPY561ikVQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BXd+aPgd7HtyNmxFLIXKbc0HP5nEpz1IrnOyYrXoNOjVqhV2JKEdEszOyNFTNdbAm5Jf8RA4YGItHGW6ejRfIYe6uFP8j89NfG0VN9APO/sYsfS/yah33h0C1y63jjoV+6GsPhfpvUky+lfCngbcFaaUNfQ4GNuPrk9syUDDEjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZckAiztD; arc=fail smtp.client-ip=52.101.62.13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdB/DkexH1mhdNO/g7TQX0L7dy1KwBKacETX+NdQxsA5RWo/0/eU2I4RImlhzscF0Ny0W4HUjgprEIcNp/ooYJOSslWHjqCgerETB/4lo3G48+QlxX500ZXfA6dAR89oz0CAWDS/DvquXekrYDHv4VjEIa3DoCqcVWksFQwB0na1G1SYT+lcm1LuHtTYJp1WULIJyw/ziFRWdmma0rgadA73vnjU/AGBeHIg4e2Lv9bcs5tAuA4ZRGiB2bNCy4B43UOYeVTYru0PVjIw3xmT31Kl10/VNjSnhtO9lSAeHaJGS1Cl2l2u0EdzwPwvmJo9jFaB5aCIm+iSmWG64b3+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQZnlHVWnk9xjn1Y3X8WZI1mSdFDQFb7UWGhdkNbJv0=;
 b=bLvoGYrn+ZtnKX8qy2HH5XMXQ3+lSb4OqrmvcD5PGQiXVr0qaUN6gJdnnDtzId4uPIKbvz1GrwKmqAcMHePWkHJRfZMCjAcNUFzcd40PnQVnqmgdCefZ//Qmj3IKviM1CZfGi+MBNwTYIm0FOV9DACc5BaYZ1KrxcyCcAQzIYoqe/7wCydYPi0JnCwkejBgOObYSDPjTl17WD95eTVDjv9c/4/kNICXz5QmXl6hW4M3TDGXNeLXCYGn/Dl8JiqH8FawROxCqwgT61eyt+QR+iDBz7LeLcwX4asFCBCUSfVseObkSoS8q2HNesWOvoGvNyHOG250MPzN1kml87ilU7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQZnlHVWnk9xjn1Y3X8WZI1mSdFDQFb7UWGhdkNbJv0=;
 b=ZckAiztDxSFFAv8eLPQyAatFAcgvh29Gzmmy7SyGdUNIoB6GsZKXEwbPT52RVzYOGmp6TvaUbV2BQmZ9+SxzQObJ2h1v+wl8R9VhIC1QRjI+gm3XLyvD09AIxuHOEQ9cIE1RdipOV+34N6rrxhb94kxTjSL33dbV4lOtoSfR2werO7XF7HBJanHA6iItDiFLvgk/jWsgebaUHIkPSCA2oM4fjGaK1PYunnEh2XtyS4gX0PEEyCXy7FzIXhgBhH45wfSMIEAnSverLzJUsNgWv1W2Fp/E8pcFiLR1rXBDbZkXWZ+jh7Wz0ZEzk25gQeIP5qCebyVKQdZsDdFe3ky2AA==
Received: from PH8PR07CA0028.namprd07.prod.outlook.com (2603:10b6:510:2cf::23)
 by DS7PR12MB5742.namprd12.prod.outlook.com (2603:10b6:8:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 13:55:34 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::10) by PH8PR07CA0028.outlook.office365.com
 (2603:10b6:510:2cf::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 13:55:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 13:55:33 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 06:55:21 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 06:55:21 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 4 Jun
 2026 06:55:15 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Saeed Mahameed
	<saeedm@mellanox.com>, Tariq Toukan <tariqt@mellanox.com>, Maxim Mikityanskiy
	<maxtram95@gmail.com>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net] net/mlx5e: xsk: Fix DMA and xdp_frame leak on XDP_TX xmit failure
Date: Thu, 4 Jun 2026 16:54:46 +0300
Message-ID: <20260604135446.456119-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|DS7PR12MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1ebeb4-9aa1-422b-8521-08dec240f2d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ZqXowQfTf7XMl4X7AAyOntsr0fcZ15zogHmVZStRSYWhMSrtpFSTVzwxvfZj6o4MorpnJVLP3RQQV8z/IpoDPixHnbfstdNMHdz3XKx+p7sKFx1ac0xOHzuNXB2Dl06GttN2O00Q+yVtnhRxLuG7WzmESFbUwEEAxsbXwRiHDI7EWwqCx18DU41KZxUpwym3Tpx/cr1IHXzXgapV7W8mSbn8Qnq+yH+6NVzLb6trcqtSgfzC1OA7OtaTS63fBdev6u6mjVn/7Hx+eNj5xJdZhFz2LkGFb9LrZWRd5FpQju4mCksdoLfDwQuw5d/91Jyrwa5aBlPj6fi92sciuq9cqxLXd9zvaWN/+vptNWSTrgHet/BbWN5wCNx8u42KDE29Ca/GaAXBwp6x7jLIj9aK5xTmeUwqH2mr4YEoI1AyPTLO4ai1+tQUAWF3OnwQi5qRObshspUyLlcl/Aj+/ycR2Vp9kAT/vM8kSZVtiJINuKjCSk4r7UQvv45P2o87psZ9GLirIfEJWk7eHkAGdPEPbhSWb0yj0OYBRGOc20HQaGx5O2MFOJPL/4pLkgWiSax1I4ki6E1+pRNfuiD9DO1hhnPkgPqd3MSqqrnNY+FAPhg0YJVxM4qt2T1tduXhO8accmYPj0I/eHHoQzK5TPe0GzUAXzJsNqGlf41/0plWD9DfknfN6nKkMBk2VMBAH0T4PVUyY7n3Egy58lTfOpiAXMSIHngrfGMYZGmFSZAVx9s=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OZFXapJLdSqOBDtE7IAg1c+kt4EAd3LyPy0pak3DGBdfnDhZjaR70H/GKfmMh8w6ZYqkcI4x/gCFTP9WCjkL1qih5r0Jm+rGWDgJWQOp4h879rdMotvzP6lWoBpcd9BgM8NnCZhOXD7grencCaFmZnaWrunHLyOUPW45ZVp52cu+vskPd5yOO0iqE5PzdjWGRTO1pCulG3V8L7qwJ6aAOpmFGvgulmI4SRPyV0UFasQwSqmDh26Jc+QWsAWln9Rz030NcOIP3W6DS2KvOt88/XUyqvelAnrRF8BbT2M7SMNAAn8CqSH68WEB9EV5RKAqZR7dui0u53cn/oH8QirLH1xRG0IAZusPO1mOujw8S+vfMI5UFN+dIXr4/hm9obXe7AOBsE1zR+9/L9zEUVsz/KdkEAeUUZlOafBOTIklzPZ7ZYM3euJDiWwp/BFSm5TC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 13:55:33.9433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1ebeb4-9aa1-422b-8521-08dec240f2d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5742
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:saeedm@mellanox.com,m:tariqt@mellanox.com,m:maxtram95@gmail.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:dtatulea@nvidia.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21784-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,fomichev.me,nvidia.com,mellanox.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C003640C86

From: Dragos Tatulea <dtatulea@nvidia.com>

In the XSK branch of mlx5e_xmit_xdp_buff(), when sq->xmit_xdp_frame()
returns false (e.g. XDPSQ is full), the function returns without
unmapping the DMA address or freeing the xdp_frame allocated by
xdp_convert_zc_to_xdp_frame(). The xdpi_fifo push only happens on
success, so the completion path cannot recover these entries.

With CONFIG_DMA_API_DEBUG=y, the leak surfaces on driver unbind:

  DMA-API: pci 0000:08:00.0: device driver has pending DMA
  allocations while released from device [count=1116]
  One of leaked entries details: [device address=0x000000010ffd7028]
  [size=1534 bytes] [mapped with DMA_TO_DEVICE] [mapped as phy]
  WARNING: kernel/dma/debug.c:881 at dma_debug_device_change+0x127/0x180
  ...
  DMA-API: Mapped at:
   debug_dma_map_phys+0x4b/0xd0
   dma_map_phys+0xfd/0x2d0
   mlx5e_xdp_handle+0x5ae/0xac0 [mlx5_core]
   mlx5e_xsk_skb_from_cqe_mpwrq_linear+0xc4/0x170 [mlx5_core]
   mlx5e_handle_rx_cqe_mpwrq+0xc1/0x290 [mlx5_core]

Add the missing unmap + xdp_return_frame, matching the cleanup already
done in mlx5e_xdp_xmit(). has_frags is rejected earlier in this branch,
so no per-frag unmap is needed.

Fixes: 84a0a2310d6d ("net/mlx5e: XDP_TX from UMEM support")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index d3bab198c99c..d8c7cb8837d7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -103,9 +103,15 @@ mlx5e_xmit_xdp_buff(struct mlx5e_xdpsq *sq, struct mlx5e_rq *rq,
 
 		xdptxd->dma_addr = dma_addr;
 
-		if (unlikely(!INDIRECT_CALL_2(sq->xmit_xdp_frame, mlx5e_xmit_xdp_frame_mpwqe,
-					      mlx5e_xmit_xdp_frame, sq, xdptxd, 0, NULL)))
+		if (unlikely(!INDIRECT_CALL_2(sq->xmit_xdp_frame,
+					      mlx5e_xmit_xdp_frame_mpwqe,
+					      mlx5e_xmit_xdp_frame,
+					      sq, xdptxd, 0, NULL))) {
+			dma_unmap_single(sq->pdev, dma_addr, xdptxd->len,
+					 DMA_TO_DEVICE);
+			xdp_return_frame(xdpf);
 			return false;
+		}
 
 		/* xmit_mode == MLX5E_XDP_XMIT_MODE_FRAME */
 		mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo,

base-commit: c05fa14db43ebef3bd862ca9d073981c0358b3f0
-- 
2.44.0


