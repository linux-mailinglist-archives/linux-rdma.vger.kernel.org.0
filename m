Return-Path: <linux-rdma+bounces-17529-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0K7xKnGWqWnYAQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17529-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 15:42:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 114D2213B3C
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 15:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B45231D2ACD
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 14:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D683A7F6B;
	Thu,  5 Mar 2026 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YdkJU0hM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720453A0B35;
	Thu,  5 Mar 2026 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720857; cv=fail; b=V/yQi8gxEsSNZehOvaa6HJWyZlnMm2Y3HTWJZrruqxody495uXNUzzYGfBEvQWhCeoE0uI4WAmFG3zP0eZ6wZB/IxF8kWe+cZpB+i/LFRof3zNAHm4wdR9GIOZ9uvnLMRdVZ3w98uZ+FqOFue1vCIJ1Az625zyJ5ZoTvBJjWhUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720857; c=relaxed/simple;
	bh=2kL1gb0Gf6hVpKETZGZd61y+EEVe4CPzI0D0zCvvh5E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqCr5//xWuaJ26JsHm3IfYpai4Engr+exF71RM5sDc7YBoLo5TKN0+Zbu5GA2Bsx+5OHft2YciWZvdKe1/NxLeAAxQaGbAxnwO+eHkEGhaJCp2mwh/Jwj8IPzrsHUtkAFf37GTe4e8zr68JqqgGsmpciXBH3K7PRN24FXU5+qxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YdkJU0hM; arc=fail smtp.client-ip=52.101.48.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXWKJWN6p2LgXakHY0lqfX/7TvS28orT2DlL3o1KKasQRc7kvVu72VcBpbyfjhCi5S+Gn+zJ582ve+hsLcJkNiZUzXCeGQKVNSqNH686y6tAg4uEp7k21mknoxuckNfMxi/c82XkmAPvaAWq2uY+dWh9tGxBppJuKgbIh+0S18tYMPwhpIvP5PZfcNv526iLhLaQ9EirPXw4tE41239dL76Z4UQhVT5KhTyRZCKDEPIj8j3ptgrftgO7SwF3xFM0YgyWDFOyNvMHcHEkZ+qDaALFWnaglgPr2LjKWQ4k0mXQsEXNlm7eeqDg84aJOTCVLipovTt4zhxqR4+SDMSVbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CF4SjfyCTrbMgDhTbiK9IVA4IuoipP1wXV4yMqypYHs=;
 b=HAO5NWJzn9bECHb31m3oejr8BCzirwBzadQn6zw/wTl3C+PCvntb9nTvdw/qUA3ruzt92TFdKqB+V5WmH98KwTJ1mFe+SoSy5qnGLHMmsWsaa1eaAlbX54cD3yuIvcZAtHtBHRCat9NBtYxsNfZB7eMePzZ+BDLqG9mu0jYusP5gmCiY5TdoCZGL1c7Hw41cC4db0TOpkp3Cq/uJtuhMK99smSDSYVAGBd/WR7LhaHM6A8ANww0T2/sXS9BTOvafIoxrnBvGSjCv0rkp7LUDDRKW6Tx/7290Yvn6F+Qx2m+NzlS64y62wQ8HRItLb2lCFEozd+IkFyuBDYvJ4ZqpZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CF4SjfyCTrbMgDhTbiK9IVA4IuoipP1wXV4yMqypYHs=;
 b=YdkJU0hMPdTw6T8Bn/j0CVZqgkQA+bgd4eK8U61aoEN3nD3NKfRGjDptgBNa0M0Ul89f0IHfRL+Ky6e8Bn4gapzpZSShk5O4ik8sDZODpUKlt5njzqEg+oTC0q0TjhxecAQ2ynCNA8gGdtrrRpW28LWBl+tPBhCYeFzURVtFJH2CBZYGeURt5yT9oKnK+rWwcb7/bPijM7I7jxYxZBWd1Cn7dk37S3IHjp5PEkBgDqTMlM+c41crxYOjBApRCQW6xcO1RfBehvX5dRjCRsd5r9YNlwOcP/+KVOcXxc3Bm5RjP8F250J13RWFWeTM/PUB4LukAMJy0LA8pGhHmdVuCg==
Received: from BN9PR03CA0869.namprd03.prod.outlook.com (2603:10b6:408:13d::34)
 by DS4PR12MB9636.namprd12.prod.outlook.com (2603:10b6:8:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 14:27:30 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:13d:cafe::d2) by BN9PR03CA0869.outlook.office365.com
 (2603:10b6:408:13d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Thu,
 5 Mar 2026 14:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 14:27:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 06:27:16 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Mar 2026 06:27:16 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Mar 2026 06:27:11 -0800
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
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Amery Hung
	<ameryhung@gmail.com>, Nimrod Oren <noren@nvidia.com>
Subject: [PATCH net 4/5] net/mlx5e: RX, Fix XDP multi-buf frag counting for striding RQ
Date: Thu, 5 Mar 2026 16:26:33 +0200
Message-ID: <20260305142634.1813208-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|DS4PR12MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c17378e-8d29-4ca1-2d78-08de7ac3550d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	wEFVn3M6fDvPMJWNMW6qwjSVmLt+IYzpaqYc3KPlcgdlmWn7xjVuRNtE8la0JMM+KMQX236K0IZQvTbI/SNzPcWUYNO5S8vNoNyhb1J02f+Tcfi0+CXaPTEBAen6MeFe2wveU71wQCmXLdpG3ge/l/ZESyXRlvA5HDM4KxclB8FXKBpfhlFyNyWysnGZ/7Lf0E75S8HxAgCcjI1rv7KDO8nEsw1J7R+syhl/sbpiSEkHEn+vEmh3joNvXo6KbNv936lwYy44GOy7yavWD9PRYH4ddVV8+MvF79qVjnG4LQby+vrSxPkGSMUANjTkTtZlflTp36othaoXpNUNORaPXiy0RBHBp2zNAXGDZ/MPwT4iKGaqNX/0NZenWIASy9bI55Kt9WBfObpOQN2EqeMi4eqD4aFioJqaeRP4WsS0zb9DKY7Fq1nJheQ3B0mfBGtPEuqVGgx2bhTcmwQStJMg7WcSq/SM3vOByel2kgzvccR9EbvAHH2b12Y5IJOXTBqNyW8sL8jQfhcZduPjAXBLSoQ09O3yZQkzApGxkrsG/Tv8WQuFXploM6pcfjUpznQkdSgVhgbP//tRHjxDEtqq5Lf65U13NrHTB3VI6ukEG26h+I5mCVuAlIT7wBkfRQPD0EAz3vEWFbsaXNV0w0Iw2oUEDzyLK4NHJssBwaVanT3Ovg6IKidx7Md22lf5aWrTcRhOLRqic2JEhitlVW6B5wtGQsAD5wSuMMhLZ2OhW4khMtoUpU6r5nj7HF1YoXk1hafuEAMMhkQhqrC7TTEb7Q==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+5oCRHimKvzplN5+VPjKQbWkIitLmFvSGu1n8pfx4V8AjlmIyJZQO1U28dGVe9nzZguXPANCguPpsmPq/2OJ09ZpD84zyBKMJMYG160mVara5huk/sPi3kxJkaSunNCwUu/t1+9kypFChMp163lbMYp6zy3yezo8NWYH+/DBUYI1C+nHkeTArbIzEZuzyDb5sRr4cAKbp0KyvtY8Kzik/KFI3CmdBrCD2ke9CAI2Z6liZFCQtQ2a6QOEJ9slm0qVfq+3bPBiHecpG1FRJIZkfVHcWFxMBa0LSEiQ7SJn+jO72K3b3oQ5XeIhv/OyhYCtaV3o9q7L72x7sTn5ANSP/e5zEfkJhGOHMhKmH3Y7GFdyQhGk6gPoNAJPN2rwdqTpZg9pwpCcHSyxu+xMH5TM3IBjsCpD+vLgmeEZWUS0kd9LYpuA2XCktyFcLh/s2/eW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 14:27:29.5365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c17378e-8d29-4ca1-2d78-08de7ac3550d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9636
X-Rspamd-Queue-Id: 114D2213B3C
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
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17529-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Dragos Tatulea <dtatulea@nvidia.com>

XDP multi-buf programs can modify the layout of the XDP buffer when the
program calls bpf_xdp_pull_data() or bpf_xdp_adjust_tail(). The
referenced commit in the fixes tag corrected the assumption in the mlx5
driver that the XDP buffer layout doesn't change during a program
execution. However, this fix introduced another issue: the dropped
fragments still need to be counted on the driver side to avoid page
fragment reference counting issues.

The issue was discovered by the drivers/net/xdp.py selftest,
more specifically the test_xdp_native_tx_mb:
- The mlx5 driver allocates a page_pool page and initializes it with
  a frag counter of 64 (pp_ref_count=64) and the internal frag counter
  to 0.
- The test sends one packet with no payload.
- On RX (mlx5e_skb_from_cqe_mpwrq_nonlinear()), mlx5 configures the XDP
  buffer with the packet data starting in the first fragment which is the
  page mentioned above.
- The XDP program runs and calls bpf_xdp_pull_data() which moves the
  header into the linear part of the XDP buffer. As the packet doesn't
  contain more data, the program drops the tail fragment since it no
  longer contains any payload (pp_ref_count=63).
- mlx5 device skips counting this fragment. Internal frag counter
  remains 0.
- mlx5 releases all 64 fragments of the page but page pp_ref_count is
  63 => negative reference counting error.

Resulting splat during the test:

  WARNING: CPU: 0 PID: 188225 at ./include/net/page_pool/helpers.h:297 mlx5e_page_release_fragmented.isra.0+0xbd/0xe0 [mlx5_core]
  Modules linked in: [...]
  CPU: 0 UID: 0 PID: 188225 Comm: ip Not tainted 6.18.0-rc7_for_upstream_min_debug_2025_12_08_11_44 #1 NONE
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
  RIP: 0010:mlx5e_page_release_fragmented.isra.0+0xbd/0xe0 [mlx5_core]
  [...]
  Call Trace:
   <TASK>
   mlx5e_free_rx_mpwqe+0x20a/0x250 [mlx5_core]
   mlx5e_dealloc_rx_mpwqe+0x37/0xb0 [mlx5_core]
   mlx5e_free_rx_descs+0x11a/0x170 [mlx5_core]
   mlx5e_close_rq+0x78/0xa0 [mlx5_core]
   mlx5e_close_queues+0x46/0x2a0 [mlx5_core]
   mlx5e_close_channel+0x24/0x90 [mlx5_core]
   mlx5e_close_channels+0x5d/0xf0 [mlx5_core]
   mlx5e_safe_switch_params+0x2ec/0x380 [mlx5_core]
   mlx5e_change_mtu+0x11d/0x490 [mlx5_core]
   mlx5e_change_nic_mtu+0x19/0x30 [mlx5_core]
   netif_set_mtu_ext+0xfc/0x240
   do_setlink.isra.0+0x226/0x1100
   rtnl_newlink+0x7a9/0xba0
   rtnetlink_rcv_msg+0x220/0x3c0
   netlink_rcv_skb+0x4b/0xf0
   netlink_unicast+0x255/0x380
   netlink_sendmsg+0x1f3/0x420
   __sock_sendmsg+0x38/0x60
   ____sys_sendmsg+0x1e8/0x240
   ___sys_sendmsg+0x7c/0xb0
   [...]
   __sys_sendmsg+0x5f/0xb0
   do_syscall_64+0x55/0xc70

The problem applies for XDP_PASS as well which is handled in a different
code path in the driver.

This patch fixes the issue by doing page frag counting on all the
original XDP buffer fragments for all relevant XDP actions (XDP_TX ,
XDP_REDIRECT and XDP_PASS). This is basically reverting to the original
counting before the commit in the fixes tag.

As frag_page is still pointing to the original tail, the nr_frags
parameter to xdp_update_skb_frags_info() needs to be calculated
in a different way to reflect the new nr_frags.

Fixes: 87bcef158ac1 ("net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for striding RQ")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Amery Hung <ameryhung@gmail.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index efcfcddab376..40e53a612989 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1957,14 +1957,13 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
 	if (prog) {
 		u8 nr_frags_free, old_nr_frags = sinfo->nr_frags;
+		u8 new_nr_frags;
 		u32 len;
 
 		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
 			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
 				struct mlx5e_frag_page *pfp;
 
-				frag_page -= old_nr_frags - sinfo->nr_frags;
-
 				for (pfp = head_page; pfp < frag_page; pfp++)
 					pfp->frags++;
 
@@ -1975,13 +1974,12 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
-		nr_frags_free = old_nr_frags - sinfo->nr_frags;
-		if (unlikely(nr_frags_free)) {
-			frag_page -= nr_frags_free;
+		new_nr_frags = sinfo->nr_frags;
+		nr_frags_free = old_nr_frags - new_nr_frags;
+		if (unlikely(nr_frags_free))
 			truesize -= (nr_frags_free - 1) * PAGE_SIZE +
 				ALIGN(pg_consumed_bytes,
 				      BIT(rq->mpwqe.log_stride_sz));
-		}
 
 		len = mxbuf->xdp.data_end - mxbuf->xdp.data;
 
@@ -2003,7 +2001,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			struct mlx5e_frag_page *pagep;
 
 			/* sinfo->nr_frags is reset by build_skb, calculate again. */
-			xdp_update_skb_frags_info(skb, frag_page - head_page,
+			xdp_update_skb_frags_info(skb, new_nr_frags,
 						  sinfo->xdp_frags_size,
 						  truesize,
 						  xdp_buff_get_skb_flags(&mxbuf->xdp));
-- 
2.44.0


