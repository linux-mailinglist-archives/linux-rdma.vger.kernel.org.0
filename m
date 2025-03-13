Return-Path: <linux-rdma+bounces-8661-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CABA5F76B
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 15:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2DBF19C2DAC
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 14:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE97D267B1D;
	Thu, 13 Mar 2025 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I40RYRgp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5D1261389;
	Thu, 13 Mar 2025 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875535; cv=none; b=fxfUb1gBGoPK9uwp/lpQVp7Ui/vTjMOAYR/6f5MNyxK6VgLcUiitix+qN+THvr14bV0PXfuX+WeY18n9b+rJZkIeO6eAWxiSL46hDqCXHg3onFRxyPRCrZCGjIxOH2r3ZccJRLw7DuYOY4sCp8XDmPPFsoRZRE9O11fzUX/RtDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875535; c=relaxed/simple;
	bh=I0vQXDzH4x/d0GbYfFSPFW+0xHKbEIlnpsAJJb51HUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T6KfDHB4rozi5bfJaJsuQsJB4V0YJDkLwPC6FcU8SjUgf4uom5+qOtDuWwUAyK2Ubh2/PrSgc0slzW6y7322y8dFdcl3p7RtmDzjeq1245tDJGhpo8kEKWKuGZ1m4S8AloTWasPBSmwaC05yB2iKfZOVKVSZ2v8cX17g+44RUms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I40RYRgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30356C4CEEB;
	Thu, 13 Mar 2025 14:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875535;
	bh=I0vQXDzH4x/d0GbYfFSPFW+0xHKbEIlnpsAJJb51HUQ=;
	h=From:To:Cc:Subject:Date:From;
	b=I40RYRgpeE8spZWfOJUBXn0Ay5bwU4It1HuDUed4kcQST9aEUOShwZhJiv3zWpHQT
	 EzCiRqC8JtqXBBnYu/2lS+l6OEZartcaHe/y/w9UGgCm1se/6w/5rp09IqZCihmTla
	 piYvsFGZTs8WleyQDRxpbis3ilgfzkjj2t0Boq52CYCZ9QFrPXtQ6p7+lBUUOeWPQr
	 S+LBnrycVrRYcueBiZCv3v1wbNSy4R3lK5GAMLScWlvJoQgRMiLLXbnSQ7k16EclVf
	 rFOact6l7X/q8eoJpEbKtrVy1kGPf4lvtcUsmgkqizTEBxneFklHKy+bbP1n0x7Hqw
	 i6C2MxbqnuASQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Patrisious Haddad <phaddad@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH rdma-next v1 0/6] Add optional-counters binding support
Date: Thu, 13 Mar 2025 16:18:40 +0200
Message-ID: <cover.1741875070.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v1:
 * Added new patch which removed dependency of
   CONFIG_INFINIBAND_USER_ACCESS fron fs.c
v0: https://lore.kernel.org/linux-rdma/cover.1741097408.git.leonro@nvidia.com/

--------------------------------------------------------------------------------
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

Patrisious Haddad (6):
  RDMA/mlx5: Add optional counters for RDMA_TX/RX_packets/bytes
  RDMA/core: Create and destroy rdma_counter using rdma_zalloc_drv_obj()
  RDMA/core: Add support to optional-counters binding configuration
  RDMA/core: Pass port to counter bind/unbind operations
  RDMA/mlx5: Compile fs.c regardless of INFINIBAND_USER_ACCESS config
  RDMA/mlx5: Support optional-counters binding for QPs

 drivers/infiniband/core/counters.c    |  52 +--
 drivers/infiniband/core/device.c      |   2 +
 drivers/infiniband/core/nldev.c       |  18 +-
 drivers/infiniband/core/verbs.c       |   2 +-
 drivers/infiniband/hw/mlx5/Makefile   |   2 +-
 drivers/infiniband/hw/mlx5/counters.c | 195 ++++++++++-
 drivers/infiniband/hw/mlx5/counters.h |  15 +
 drivers/infiniband/hw/mlx5/fs.c       | 483 +++++++++++++++++++++++++-
 drivers/infiniband/hw/mlx5/fs.h       |  15 -
 drivers/infiniband/hw/mlx5/mlx5_ib.h  |  20 ++
 include/linux/mlx5/device.h           |   4 +-
 include/rdma/ib_verbs.h               |  11 +-
 include/rdma/rdma_counter.h           |   7 +-
 include/uapi/rdma/rdma_netlink.h      |   2 +
 14 files changed, 766 insertions(+), 62 deletions(-)

-- 
2.48.1


