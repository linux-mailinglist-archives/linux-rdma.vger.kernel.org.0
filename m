Return-Path: <linux-rdma+bounces-8308-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 728AAA4E075
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 15:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3F71889981
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 14:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BC6204F95;
	Tue,  4 Mar 2025 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdrkYB/j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71721FFC7E;
	Tue,  4 Mar 2025 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097750; cv=none; b=l2jWGum88Vw1w9P8X53cfDR39nsEsPLY2jeA+Ucp59i3oDfWCAlHwiUmG9PFXJFQWMXtOhx4E14EqEvkLZ5KNZA5K8eIgO4MgRPLxcXqbMLQHAkMjghn57r5/P3VQun+1j14BPK8gwaL2/ya53EBKoX5NBxuqeEyK1oKj5slruU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097750; c=relaxed/simple;
	bh=96xysRG4PPJif4L1jxk26pBZ4KZRZf2KfK1YyIOOxUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Znt98D5fbkVQWbku/o2wayAZ7c5Nw/ltt6A+MguLZneSJW5C0RLiMXDBY4ExfAkTcRIanvuUR1GC34lu6oVWlerbA4fC+jPsky1xj9RcJXQzyUQwnDRxP4I6fuO0y6cHXT1+muT3C7Kx2XJvvXX8IVmJCFGzlRw1rEE1flxHqc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdrkYB/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB01BC4CEE5;
	Tue,  4 Mar 2025 14:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741097750;
	bh=96xysRG4PPJif4L1jxk26pBZ4KZRZf2KfK1YyIOOxUE=;
	h=From:To:Cc:Subject:Date:From;
	b=sdrkYB/js9XNAOsvl7Mmzixe/MpYMe/MuBJ3aF6vSDz875fFsWQ0PBPUO9bH/pAwy
	 gW7sNPijltXX2DU5GDtSfKzeXPiWgkHxrEUoqMN0Lbyp/33L7keIcivwsdwISUK1UK
	 1S5KOey31erqupH60VRH+At4cPRab8slrm5oLpUXZXGyjsVsB1ssy6LJ+cPafUoWaw
	 XnMD2KMX7hexjKYe0VaWaRbrCprnkszKrouB11LwHDFW52dz9yuzTd6q1jIR1EVOj0
	 TaEMdGVmQcatEBbdOUd38x3xt5BZLZrbdmMbl9j7q+7HH+xPqMNeSyso7aCEcSSL2s
	 6bkwAc5g/iBng==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Patrisious Haddad <phaddad@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH rdma-next 0/5] Add optional-counters binding support
Date: Tue,  4 Mar 2025 16:15:24 +0200
Message-ID: <cover.1741097408.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

From Patrisious,

Add optional-counters binding support together with new packets/bytes
counters. Previously optional-counters were on a per link basis, this
series allows users to bind optional-counters to a specific counter,
which allows tracking optional-counter over a specific QP group.

The support is added for both binding modes, automatic and manual,
in both cases the bound optional counters are those that are currently
configured over the link when trying to bind the QP.

In addition introduce four new optional-counters :
rdma_tx_bytes, rdma_tx_packets, rdma_rx_bytes, rdma_rx_packets
That just as their name implies allow tracking RDMA egress and ingress
traffic.

This is exposed to users through the iproute2 package which needs to be
updated as well to provide the support for this feature.

Example commands:
- rdma stat set link rocep8s0f0/1 optional-counters
  rdma_tx_bytes,rdma_rx_packets
	Enables rdma_tx_bytes and rdma_rx_packets optional-counters over
	the link.

- rdma stat qp set link rocep8s0f0/1 auto type on optional-counters on
	Enabled link automatic counter binding for QPs of same type,
	with optional-counter binding support.

- rdma stat qp bind link rocep8s0f0/1 lqpn 134
	Manually bind QP number 134 to all available counters.

- rdma stat qp bind link rocep8s0f0/1 lqpn 134 cntn 4
	Manually bind QP number 134 to counter number 4 depending on its
	configured counters.

Thanks

Patrisious Haddad (5):
  RDMA/mlx5: Add optional counters for RDMA_TX/RX_packets/bytes
  RDMA/core: Create and destroy rdma_counter using rdma_zalloc_drv_obj()
  RDMA/core: Add support to optional-counters binding configuration
  RDMA/core: Pass port to counter bind/unbind operations
  RDMA/mlx5: Support optional-counters binding for QPs

 drivers/infiniband/core/counters.c    |  52 +--
 drivers/infiniband/core/device.c      |   2 +
 drivers/infiniband/core/nldev.c       |  18 +-
 drivers/infiniband/core/verbs.c       |   2 +-
 drivers/infiniband/hw/mlx5/counters.c | 187 +++++++++-
 drivers/infiniband/hw/mlx5/counters.h |  20 ++
 drivers/infiniband/hw/mlx5/fs.c       | 474 +++++++++++++++++++++++++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h  |  20 ++
 include/linux/mlx5/device.h           |   4 +-
 include/rdma/ib_verbs.h               |  11 +-
 include/rdma/rdma_counter.h           |   7 +-
 include/uapi/rdma/rdma_netlink.h      |   2 +
 12 files changed, 759 insertions(+), 40 deletions(-)

-- 
2.48.1


