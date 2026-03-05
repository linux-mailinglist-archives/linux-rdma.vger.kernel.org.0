Return-Path: <linux-rdma+bounces-17531-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCQKCw6WqWkWAgEAu9opvQ
	(envelope-from <linux-rdma+bounces-17531-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 15:41:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 24267213A5F
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 15:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F01730716DB
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 14:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA4C3A7F51;
	Thu,  5 Mar 2026 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sRV8zJxG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D003246782;
	Thu,  5 Mar 2026 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720875; cv=fail; b=NEHaoCHEyGh+8lhyhipiGURUFV/1chcWYbcZFC0fJ62zhTFNs1a8lRK+tyG3xRk8zwZqW61Vnoe9RzqgcIByDuHojObjnfNAZ85vJ48844uSQSnB2m/AQ/F4u/f0SINn67DCS6dT7XB12JwNRYGObTCYDEaUCuoFDVy/s5PgunQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720875; c=relaxed/simple;
	bh=772HBWCA3BAzy+hbZjuTvQKZDt0o1iNBQwc8UISudgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnBRqYpjBOwZ0r20vKADT66ZUghBtpyOOw3o/6GMiMXcN6vo1ycDdZyAWko/zIt/D/CtXvIXYreXIYBISHiKvJVlSFx4htAVFCKbSKA1OlJgLx+O0zQmLvvoAGKrNB7udFtP+mijBHjr62Vx3jV7qzTHS+s6B80XpPYVrsD7eGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sRV8zJxG; arc=fail smtp.client-ip=52.101.85.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtnuMFgO25Q8eS3d469WlUsGyEGok70QPCZFjl5hyZO96EWJa7Cts/X+p1IojGPK7QSiNf2cU4jY1p3OdmHrPUgFXgyICThMO59rWIwCo2uYUIUyH7t1rnQWr6sT6TC+C5LRghl6aIItmkT8CVEQI1IVdppy5Qi87xzf3kPRZyyDdAmzbcNhuxE/vqKuIIRZMXqwNwZwAV8zqOPF6G5ERxzANshDUj2wIW5V4sW0kfmBcS5DKEoR2NfyHMIxrrFjRVCZnskmkckmPZk8xskfhMVkMB/3TomuWKMUuLDAfuZruMXxJkgQGtxkD5buerQ+pmfWsoPh75zJ6VXvuIEPdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NwKz3ADesEGXEFYf3zMeRvnZQH6LFUojxCjSMcyduQ=;
 b=PiObT0HhEU7nvIKbun38JxRrT/cgSgGeKromy2XdjscPclDzxAeNy4gbdSc+2dadBNUpQpFpVvkPCl1WzpJg6J1q2VS7bXCJZYFEvnZIfXzEooaWiqDhaaEh5ZC4aEZzlu8HB4C5Y7a8K43s1/TnN53AjMnEjWgqkowlmq1vSPG6olwZNjvBHg+jhevDv5KOhY43FSnncOm9qHXECH2pNkkBRz0s04Hd82xqzmk6EYD94NmUfCuitLwtMC5HftAtxFqPAYcHtwQeQp4IZ9VkDnC+2eMszwVtJ6ROMCfgSLN0c/92NBxLxLeQf47ViLhj3KpCvChsRrcyJHaLRpqquw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NwKz3ADesEGXEFYf3zMeRvnZQH6LFUojxCjSMcyduQ=;
 b=sRV8zJxGi6rUv/izPoFbShBYb0opIiL76PKq5KTC0Q0oq1Gpc89uxpNCOnG3CpsgNtglRuCWdPTL/let8aSs+1cuTzQfHrCykiPDxL3XnfysFljd8i/TSELan5fP89lSABCYMdbWBGmTttKr4oXsnjQcBRu2/hjSxlB5hzdqCGcZU8SDY2Dp5VNZ1E+lR4v3LOwdu7FqpzSuA0XsRgyvNhOJ/1U8/dVQdf4+9xeLiF4WMTNLkKWt9makx4LUPHvKHZsMAoW3zeBxOGBaWXVrSR+We71CsYYqLjjh7kAix4pTK67Jvz/U6SHXEmAaY57mFpV44+kV78U+q0dxvigBzQ==
Received: from BN0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:408:e6::33)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Thu, 5 Mar
 2026 14:27:28 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:e6:cafe::6e) by BN0PR03CA0028.outlook.office365.com
 (2603:10b6:408:e6::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Thu,
 5 Mar 2026 14:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.0 via Frontend Transport; Thu, 5 Mar 2026 14:27:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 06:27:11 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Mar 2026 06:27:10 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Mar 2026 06:27:05 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: [PATCH net 3/5] net/mlx5e: Fix DMA FIFO desync on error CQE SQ recovery
Date: Thu, 5 Mar 2026 16:26:32 +0200
Message-ID: <20260305142634.1813208-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260305142634.1813208-1-tariqt@nvidia.com>
References: <20260305142634.1813208-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c69c2a-a530-437b-7dec-08de7ac353f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700016|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	zbqhWjXos+2wUlxi+lkrw9NsuCqP8XZIQ6LYSpyCPawpDq4lkml8pzO+9Kc8TQIHnTvNBxM01V3EnYQpD5mrJGMKpO/DvR6RTrrXTwYv09GZBnPo702UmPRdeNck+F5uTxW7GJ49/Aa8DDR4BsgdevWoEUHhyJtC1qdcnKePyxwJDLNW7HDQajXX4wGP737XzM/UOzgsROMQ5FhVngu9nCeFsPD0dTIhLrD6vO1oSaZLQrrWHYkal/FdScINXeyFeOFSUgrzzuq7TX4QXrmiz03qXXaeFWCtLlyHL+ug6CGK0z++Kuuaa+4lQsJEX8ncDjVSm0nYb4SCAsbgAzfStfd42b6SDrK6FBp6PJyz/TLHygidXMl92+1voOke9a56z5qAmo07zbzdenflEvHrbskqzEKKEIPXpD4Mg+cYFlh8AW0SszDufboOWtlxqieReuDwCCHU+QhLMOoBrxIutKK4fWN3pGaAqHQ1Z4EBpvRIDQz8DAEkZE/4MZLQYe2bNIj4RHcOfcstZTcBdHaldpRG+D5fCCkAFLL9GmpAAt+buXKJ8flrwurC7qu/0bkuzHBOmMhUXKVRMuOar7xK/2F5kRoV100gpOjaiuAe9mr/LsClqgqPF7LLtp7p5QEBujL8N1iIgWk1/ahsrofhXXh2s3fUOFwj2AG61cD0NuRFmlX7pOOrnfAiGGEZA1AiXks08xKjkcebmTzpfS+qA3ywnkGLAvi/rFKgRjMu9sLXPgj4eI2wQiUMCDSsXbXRm3YAcCDoAozFLF+vfIHPCA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700016)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	abAOZvykS2UhFyDQLtOLNa8RapWLZKv0pdS/H055Et2UBOXCFvAa6rKQhuVPBZms8LpDn4OoReQuXtLsSvtX7irp9h+a8v7po26sIAE0I6/F7qwj4XbQJs5i6dASPDqb+TpyR1nq6nmCyXFaykTNl9vt+3h58kH4ETTXtA+2T+wnUDsZ/GFbs08HCoxWnmcwYJ56eNWyKItLE+zo/0d8Wioy89I+9G8uDPnxcRJFse924K4RmJtTgHYOtuMGgv59iWe5HvbEDytfIO+N4PH46cW7bNjMZL8Xn89FXYA+BAnyJ37k+af1SGY49c2/g5flwtcD9wsfWcLqODctnoQ+ciRnoQeD4ASbgJWK8O5AJk85bHVe1bMtOut52EKYimc+9ThmUbdGwsjGWR1h9/1r5zx+Gfocuo5Rk+ggyN6xfBuCg7y3lSa+/tHAImGiQPZs
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 14:27:27.6448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c69c2a-a530-437b-7dec-08de7ac353f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955
X-Rspamd-Queue-Id: 24267213A5F
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17531-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Gal Pressman <gal@nvidia.com>

In case of a TX error CQE, a recovery flow is triggered,
mlx5e_reset_txqsq_cc_pc() resets dma_fifo_cc to 0 but not dma_fifo_pc,
desyncing the DMA FIFO producer and consumer.

After recovery, the producer pushes new DMA entries at the old
dma_fifo_pc, while the consumer reads from position 0.
This causes us to unmap stale DMA addresses from before the recovery.

The DMA FIFO is a purely software construct with no HW counterpart.
At the point of reset, all WQEs have been flushed so dma_fifo_cc is
already equal to dma_fifo_pc. There is no need to reset either counter,
similar to how skb_fifo pc/cc are untouched.

Remove the 'dma_fifo_cc = 0' reset.

This fixes the following WARNING:
    WARNING: CPU: 0 PID: 0 at drivers/iommu/dma-iommu.c:1240 iommu_dma_unmap_page+0x79/0x90
    Modules linked in: mlx5_vdpa vringh vdpa bonding mlx5_ib mlx5_vfio_pci ipip mlx5_fwctl tunnel4 mlx5_core ib_ipoib geneve ip6_gre ip_gre gre nf_tables ip6_tunnel rdma_ucm ib_uverbs ib_umad vfio_pci vfio_pci_core act_mirred act_skbedit act_vlan vhost_net vhost tap ip6table_mangle ip6table_nat ip6table_filter ip6_tables iptable_mangle cls_matchall nfnetlink_cttimeout act_gact cls_flower sch_ingress vhost_iotlb iptable_raw tunnel6 vfio_iommu_type1 vfio openvswitch nsh rpcsec_gss_krb5 auth_rpcgss oid_registry xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink iptable_nat nf_nat xt_addrtype br_netfilter overlay zram zsmalloc rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core fuse [last unloaded: nf_tables]
    CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.13.0-rc5_for_upstream_min_debug_2024_12_30_21_33 #1
    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
    RIP: 0010:iommu_dma_unmap_page+0x79/0x90
    Code: 2b 4d 3b 21 72 26 4d 3b 61 08 73 20 49 89 d8 44 89 f9 5b 4c 89 f2 4c 89 e6 48 89 ef 5d 41 5c 41 5d 41 5e 41 5f e9 c7 ae 9e ff <0f> 0b 5b 5d 41 5c 41 5d 41 5e 41 5f c3 66 2e 0f 1f 84 00 00 00 00
    Call Trace:
     <IRQ>
     ? __warn+0x7d/0x110
     ? iommu_dma_unmap_page+0x79/0x90
     ? report_bug+0x16d/0x180
     ? handle_bug+0x4f/0x90
     ? exc_invalid_op+0x14/0x70
     ? asm_exc_invalid_op+0x16/0x20
     ? iommu_dma_unmap_page+0x79/0x90
     ? iommu_dma_unmap_page+0x2e/0x90
     dma_unmap_page_attrs+0x10d/0x1b0
     mlx5e_tx_wi_dma_unmap+0xbe/0x120 [mlx5_core]
     mlx5e_poll_tx_cq+0x16d/0x690 [mlx5_core]
     mlx5e_napi_poll+0x8b/0xac0 [mlx5_core]
     __napi_poll+0x24/0x190
     net_rx_action+0x32a/0x3b0
     ? mlx5_eq_comp_int+0x7e/0x270 [mlx5_core]
     ? notifier_call_chain+0x35/0xa0
     handle_softirqs+0xc9/0x270
     irq_exit_rcu+0x71/0xd0
     common_interrupt+0x7f/0xa0
     </IRQ>
     <TASK>
     asm_common_interrupt+0x22/0x40

Fixes: db75373c91b0 ("net/mlx5e: Recover Send Queue (SQ) from error state")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index 60ba840e00fa..afdeb1b3d425 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -47,7 +47,6 @@ static void mlx5e_reset_txqsq_cc_pc(struct mlx5e_txqsq *sq)
 		  "SQ 0x%x: cc (0x%x) != pc (0x%x)\n",
 		  sq->sqn, sq->cc, sq->pc);
 	sq->cc = 0;
-	sq->dma_fifo_cc = 0;
 	sq->pc = 0;
 }
 
-- 
2.44.0


