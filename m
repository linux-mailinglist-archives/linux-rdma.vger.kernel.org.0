Return-Path: <linux-rdma+bounces-21565-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDbbEaIkHWq6VwkAu9opvQ
	(envelope-from <linux-rdma+bounces-21565-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 08:20:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4632C61A11C
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 08:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 293B53014248
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 06:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB5B357CEB;
	Mon,  1 Jun 2026 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DZ9zUB1V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85E7357CF4;
	Mon,  1 Jun 2026 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294570; cv=fail; b=nkitqXAx7xiugGVcJKtjVTDHgS1St1pJlSTiPzvbKiIpPF7WrnVfhU/QxchVPemSxfpg2y/yeR94VhXqjSBL8vO6pKOR9m1lPQJW83xCOa1ykOBtUSE0nwrenulmiyha13YKVd6U4dgloio5+LRqg2sOG+bwRBrjHkjtgOdTFKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294570; c=relaxed/simple;
	bh=SqVKi2Od8RayaGP1BgH99Rx9/j3XuuY0MuW5XGtJUEE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1lezSE8cCCj0sNNoVpeWs5i8DEUXNQdf7paDozG1EQpJmVog6XW+++R/HZB5B8PuZMLRam4XowEqHkIce9ovvUeTLahdTxaQBIv1W7dw1A1mjY2moySpOOhd0atxnJmzfL/noT2FDtXFcAzphq6BDrsa6VcrSzNEEo2sMRtuiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DZ9zUB1V; arc=fail smtp.client-ip=52.101.53.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjXtgtcX3V+unUc56VoLuTGogmchgj+n/VHV4bkijFTk/vScc/RMsEetvJShG3f0eim6mRC3N6oge+OUcohN9hYi/hf/xaCk+pVypxlz0uo5iUsqM2mw0eWD179haEjmwAm87rg466P4oSPnfVzD72Fk4sm9N4/3gAf01jsBkAXQsf5bxPRxeQPj94XrSu3eYMZ5QDNLhru85bccTHFed8MTjEiYZzmF0sqqalQYl9h7IO57A1lIvyG0WtMZvp9W28h30joOKCQGQWeK0ggJfKyobETfuPriTAsSkMdclyYiqxqeOmY317lZJfK3FDahxy21GZeokfXGDFv6rO6TWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cj8JirTjfv09RRhY7PND/ybFrpL5RHAkfSdrwdm6u1w=;
 b=FcOAmFNobABqIW6T4toemflOgyEa2d0B+USeG+8gqornm3ppMuZLJ+ZYt7BjXoiCBjeqAfQDXWDer0DTR10r/Al8g5NAJRUN3JkXqBW7APPA1oXvmJgPgFuM3uVM4K1FNmgFx2Y7TkyPS6cQ0sWQXs0v7DjTS8D8XmdiCzFYWEALtatHDVvVes8sT5b54iXRjKhkiK34AP8T9Ldt8qYST11B2yiAq3Be75v1rwd07e0EhFkAobAoSFPMFf7VKXYH7lTa/rmN0M2N9CIWPLhTp2KgZocKulIcOywfbh+zR7V/f0xZhcgCqlJLYCOMQaQKyJgnAN9wobPELKty+iFS1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cj8JirTjfv09RRhY7PND/ybFrpL5RHAkfSdrwdm6u1w=;
 b=DZ9zUB1VX0/SbtT75rYBgWxCzvtQai5ZdsVHHrEDOgB5MWcuY+ybZe38ro99u/DjR1cTsGzuMvOlcZOdr5iiRVSt8pKakD4RhjHS5iC2neciL+4VSuUEBQN34+uiUwGVhcYwca+/iuuaWOqPVyRrDjDmqPaWP3I8bN5hseaaY+jLMga//KpchVMfnRaduugVxIDLwb1VkAaXqBMHBMDDsAc4F/yZxl1hBA9dJs90xJTa3xzOoaBd7hEybhJwrsuw7Tx9M4d1hdGi99DlXW/V1q5Uni/HJNmHLGnpoo07+uOpB2FeXcdxKzCl6B+D1gaaWTCYP55cm0q3wYiV/Gzk4g==
Received: from CY5P221CA0158.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::11)
 by SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 06:16:00 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:930:6a:cafe::2b) by CY5P221CA0158.outlook.office365.com
 (2603:10b6:930:6a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 06:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 06:16:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 31 May
 2026 23:15:49 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 31 May 2026 23:15:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 31 May 2026 23:15:44 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Amery Hung
	<ameryhung@gmail.com>, David Laight <david.laight.linux@gmail.com>,
	"Christoph Paasch" <cpaasch@openai.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V7 2/2] net/mlx5e: Avoid copying payload to the skb's linear part
Date: Mon, 1 Jun 2026 09:15:22 +0300
Message-ID: <20260601061522.398044-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260601061522.398044-1-tariqt@nvidia.com>
References: <20260601061522.398044-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a646179-1f2c-4be1-ddb7-08debfa5405a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700016|82310400026|376014|18002099003|22082099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	zYTDdFPnKt/J904t/nNA6q5re2cVasSX2VMPhaG5jeYwA0o+VM+9KdTkxEJJq8Q4AWZ8Qvn0nslALhnLlx7Bgf5nAeKxjVeFPUINQ3WEyUeBa43E1FwCO3iCJx5b9381XvLKoGYHLpuVDgQCmgIF8CKbMO7HI2BxQbQdwbGZwDs706wiPbWWxWjV1uR4703n7gQkP07dLer6czjzmXmit5aEOfIzPB5lYFdjPEyxUO0ORW5CWuizSayn4RDEbxCaGzSHxFI5PDoM4CX/nQqzqiX8f2u1PDP3dvRRorBgTBeMDGN8IuOO7rothOS3XW1EvmEshhP6+eaZZ+zwkcNsfy5XBgT6Y9fgGYnFjPrb49oqpN0h6bPg/rHdNjiGicB5GctUupSd8wpNRWZNG/hBdtUe/g3YU6Z2dgq8W3dZ20s0nZbxuNFzUvpDT9vnYRiuR9RTYh1AH8w8Bo1HNmJq0yThVtGWylfBnunwlvHvcHeOQNHm4fH1nvicKtBOCCweTj92YC8H0s9nubs20b8reN6uOLBPzevxcc/8+2pt1YzvRKEQQmbgtGe1RwZDuPq+XoRJhgw3e5FMmeHmglrbUelJ6hQT6SCzHXEU5SW+lQnnK3LCD8UneXzfgBc9hzllnp4NA6xJF8JGNdkwrhrbq8UxY9VihMwUXL2bTIztAnWWbjuNYG+6cTE1hZOGVBfdXw7CtzYVoQuDY9ZeHtQLMpcVzRoqJg/Ee2VFwg+gCkc=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jwhfgGWGDVY/pF+VgYiUhxcIdfiyrdwuHL6epM4jOhDpLoPAUFTN1HRxH1q5EwaiRXpxtlVq4uxMSixu8fBzqehG2RkzqZLIMSr3o2u3qqd1OAyaEmXgGEzxf7751tFxUiT4dKd+T5wWCM6+HP2cgUlxh1TyQGPIea9e3wdtdRjmwAd/y42+UiUDe7s8lpSDrzSQIuee/9LP7KUKVFpxEx68ty+MBAhd52Hi0SBUrhbQnTkxPk/ms2oOoW2tIe5Nc3sfL6aC//zJHvlwY3NzbShNqzEn+mmlPWc2PdXxaC3e0pzR5SiC4fL5VrH9HxQkaXX849GQQqssAGNtguwd+AwOvQMmHjTEWanNOURzd2VKw7CJfpTbm5D6NylIxiH7IRFEF2HAWi7itVU1Ybb6xpxtR4WW/sgoNqVQwU/D0mmfr77IKxxzsUiLvVyqgJ7m
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 06:16:00.1929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a646179-1f2c-4be1-ddb7-08debfa5405a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8744
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,vger.kernel.org,gmail.com,openai.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21565-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openai.com:email,nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4632C61A11C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Christoph Paasch <cpaasch@openai.com>

mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
bytes from the page-pool to the skb's linear part. Those 256 bytes
include part of the payload.

When attempting to do GRO in skb_gro_receive, if headlen > data_offset
(and skb->head_frag is not set), we end up aggregating packets in the
frag_list.

This is of course not good when we are CPU-limited. Also causes a worse
skb->len/truesize ratio,...

So, let's avoid copying parts of the payload to the linear part. We use
eth_get_headlen() to parse the headers and compute the length of the
protocol headers, which will be used to copy the relevant bits of the
skb's linear part.

We still allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking
stack needs to call pskb_may_pull() later on, we don't need to reallocate
memory.

This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC and
LRO enabled):

BEFORE:
=======
(netserver pinned to core receiving interrupts)
$ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
 87380  16384 262144    60.01    32547.82

(netserver pinned to adjacent core receiving interrupts)
$ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
 87380  16384 262144    60.00    52531.67

AFTER:
======
(netserver pinned to core receiving interrupts)
$ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
 87380  16384 262144    60.00    52896.06

(netserver pinned to adjacent core receiving interrupts)
 $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
 87380  16384 262144    60.00    85094.90

Additional tests across a larger range of parameters w/ and w/o LRO, w/
and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), different
TCP read/write-sizes as well as UDP benchmarks, all have shown equal or
better performance with this patch.

For XDP pull at most ETH_HLEN bytes in the linear area so that XDP_PASS
can also benefit from this improvement and keep things simple when
dealing with skb geometry changes from the XDP program.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Christoph Paasch <cpaasch@openai.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 75ccf40a7f17..6fbc0441c4b8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1912,7 +1912,6 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 				   u32 page_idx)
 {
 	struct mlx5e_frag_page *frag_page = &wi->alloc_units.frag_pages[page_idx];
-	u16 headlen = min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
 	struct mlx5e_frag_page *head_page = frag_page;
 	struct mlx5e_frag_page *linear_page = NULL;
 	struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
@@ -1928,6 +1927,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	u32 linear_frame_sz;
 	u16 linear_data_len;
 	u16 linear_hr;
+	u16 headlen;
 
 	if (unlikely(cqe_bcnt > rq->hw_mtu)) {
 		u8 lro_num_seg = get_cqe_lro_num_seg(cqe);
@@ -1971,11 +1971,14 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		net_prefetchw(va); /* xdp_frame data area */
 		net_prefetchw(skb->data);
 
+		headlen = min(MLX5E_RX_MAX_HEAD, cqe_bcnt);
 		addr = page_pool_get_dma_addr_netmem(head_page->netmem);
 		dma_sync_single_for_cpu(rq->pdev, addr + head_offset,
 					ALIGN(headlen, sizeof(long)),
 					rq->buff.map_dir);
 
+		headlen = eth_get_headlen(rq->netdev, head_addr, headlen);
+
 		frag_offset += headlen;
 		byte_cnt -= headlen;
 		linear_hr = skb_headroom(skb);
@@ -2060,9 +2063,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 				pagep->frags++;
 			while (++pagep < frag_page);
 
-			headlen = min_t(u16, MLX5E_RX_MAX_HEAD - len,
-					skb->data_len);
-			__pskb_pull_tail(skb, headlen);
+			if (len < ETH_HLEN)
+				__pskb_pull_tail(skb, min(ETH_HLEN - len,
+							  skb->data_len));
 		}
 	} else {
 		if (xdp_buff_has_frags(&mxbuf->xdp)) {
-- 
2.44.0


