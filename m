Return-Path: <linux-rdma+bounces-3169-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82472909E54
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 18:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993AD28170B
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 16:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D6617991;
	Sun, 16 Jun 2024 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzUg9k+z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AA72F2B;
	Sun, 16 Jun 2024 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718554131; cv=none; b=uKxdmHyBjOW7n4bsk9JbzT47zvRxPhMPcuNvGq7bQWA1MFzlU0L+eZjpq9HR/VkVe25YC5dQPZu8U+I8JkzHGtEkQ0aJ+TutQo9ivaxeS0SShwJTeKRNNqzGOu5NFtt1NS48G6XtYTMDNnlT7RrraKF/uK87K0MLNT17/LP87YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718554131; c=relaxed/simple;
	bh=z0EdUUbDhfEGsBtzB82/No3vcnPi+uA00oEnQaAeLy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJFr/cAuNIbqHum2N3cN4l9NC7iKGzdQyoIR1OaGxmQ5nbamaAb09ev64V73A/kcFNZeixmGkVHY+qaK44K9oYaQsL3FkcyZUS7K4xlSl4bZRz92wLbxzGX9MQPaO8IY0DSJ/zqhA/CoRkaKmlq5N3nX8N5bJ41I6wdoDnyHfZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzUg9k+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93D1C2BBFC;
	Sun, 16 Jun 2024 16:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718554130;
	bh=z0EdUUbDhfEGsBtzB82/No3vcnPi+uA00oEnQaAeLy4=;
	h=From:To:Cc:Subject:Date:From;
	b=WzUg9k+z1JV9WxgtIjA+kUHJGKwHmFEgiVhrXUaM5PnTz0iZeEA1AMBR/itDGyUQ+
	 2r5q6Prs0AqyOEdSTJpeQtRKk0GcQv45acuMuFdvkG/e+1r1vWQBTC3xt8htlCdEBq
	 tcFYYOLss8WlGQH7a18LEteukZpNQYwPHNsnyXPKz/QRxpTSQycNZhFDJHkXWXyWT/
	 w2JBQ5q9ZbXx7zuBcuJ64Bqzycdz8K1D0MN3fY05YM4qQyFc2C6VitMhxmk5fZ44Cj
	 XGtVM9xC8eh7oaIufK4c/xdB9aDlDhBH7RkLp6fWTlUIGxOL3gMRwSrPX0KHTNAsqA
	 j3Ka8ogHALGkQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Mark Zhang <markzhang@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH rdma-next 00/12] Multi-plane support for mlx5
Date: Sun, 16 Jun 2024 19:08:32 +0300
Message-ID: <cover.1718553901.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

From Mark,

This patchset adds support to IB sub device and mlx5 implementation.

An IB sub device provides a subset of functionalists of it's parent.
Currently type "SMI" is supported: A SMI device provides SMI (QP0)
interface and shares same VPort with it's parent; It allows the subnet
manager to configure VPort through this interface when the parent
doesn't support SMI.

In mlx5 cases, when mlx5 multi-plane is supported, a logical mlx5 port
which aggregates multiple physical plane ports is presented, to provide
higher bandwidth. As SMI is per physical port, a mlx5 SMI device is
needed to represents physical plane ports and provides SMI capability.

A sub device can be added or deleted with the rdma tool. When a mlx5 SMI
device is created, all it's ports are created.

Examples:
$ rdma dev add smi1 type SMI parent ibp8s0f1
$ rdma dev show smi1
2: smi1: node_type ca fw 20.38.0458 node_guid 9803:9b03:009f:d20f
sys_image_guid 9803:9b03:009f:d20e type smi parent ibp8s0f1
$ rdma link show
...
link smi1/1 state INIT physical_state LINK_UP
link smi1/2 state INIT physical_state LINK_UP
link smi1/3 state INIT physical_state LINK_UP
link smi1/4 state INIT physical_state LINK_UP
$ rdma dev del smi1

Mark Zhang (12):
  RDMA/core: Create "issm*" device nodes only when SMI is supported
  net/mlx5: mlx5_ifc update for multi-plane support
  RDMA/mlx5: Add support to multi-plane device and port
  RDMA/core: Support IB sub device with type "SMI"
  RDMA: Set type of rdma_ah to IB for a SMI sub device
  RDMA/core: Create GSI QP only when CM is supported
  RDMA/mlx5: Support plane device and driver APIs to add and delete it
  RDMA/nldev: Add support to add/delete a sub IB device through netlink
  RDMA/nldev: Add support to dump device type and parent device if
    exists
  RDMA/mlx5: Add plane index support when querying PTYS registers
  net/mlx5: mlx5_ifc update for accessing ppcnt register of plane ports
  RDMA/mlx5: Support per-plane port IB counters by querying PPCNT
    register

 drivers/infiniband/core/agent.c               |  32 ++-
 drivers/infiniband/core/device.c              |  68 +++++++
 drivers/infiniband/core/mad.c                 |   9 +-
 drivers/infiniband/core/nldev.c               |  69 +++++++
 drivers/infiniband/core/user_mad.c            |  29 +--
 drivers/infiniband/core/uverbs_main.c         |   3 +-
 drivers/infiniband/hw/mlx5/cmd.c              |  12 +-
 drivers/infiniband/hw/mlx5/cmd.h              |   2 +-
 drivers/infiniband/hw/mlx5/mad.c              |  71 +++++--
 drivers/infiniband/hw/mlx5/main.c             | 182 ++++++++++++++++--
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  10 +
 drivers/infiniband/hw/mlx5/qp.c               |   7 +-
 drivers/infiniband/hw/mlx5/qpc.c              |  13 +-
 .../net/ethernet/mellanox/mlx5/core/en/port.c |   2 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |   2 +-
 .../mellanox/mlx5/core/ipoib/ethtool.c        |   2 +-
 .../net/ethernet/mellanox/mlx5/core/port.c    |  10 +-
 .../net/ethernet/mellanox/mlx5/core/vport.c   |   1 +
 include/linux/mlx5/device.h                   |   1 +
 include/linux/mlx5/driver.h                   |   1 +
 include/linux/mlx5/mlx5_ifc.h                 |  61 +++++-
 include/linux/mlx5/port.h                     |   5 +-
 include/rdma/ib_verbs.h                       |  45 +++++
 include/uapi/rdma/rdma_netlink.h              |  13 ++
 24 files changed, 574 insertions(+), 76 deletions(-)

-- 
2.45.2


