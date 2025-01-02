Return-Path: <linux-rdma+bounces-6777-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A211F9FF8E4
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2025 12:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A66161AC4
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2025 11:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EF71AC456;
	Thu,  2 Jan 2025 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRskpZFE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4280613FEE;
	Thu,  2 Jan 2025 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735817778; cv=none; b=liEfwBCqohHWguKUPi8sIpdERf/YBVBGicaLJQl4I8XwT8+uvToVElwblH4ECyh0iWwG/jP0pqlWcHnOcCzPoeM0iCzmY+N0pcED/iyJB4QOby/wYlDgIwQVVer5sIapxqeme6NloXNl9IDv2L8VANyJb25l3th1eaJlanq8+l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735817778; c=relaxed/simple;
	bh=yjHGcKiL5zM5KXjwjgPEvNLsH7YFyyE3gPZPVjLlatQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZtULxDWgnigoOKNKK797uQN5hve+J7hcp11WIrbGlKAjSD04Zna2qKX5BRlx/TMObzyKmqQ6J/10WoB84bYXyi2iQp2KuhpSsv8ceY4t1AC6UqJZUASG7A2hL+xM5bPt78dIGGeSuXZwksHiZxxZu4XzLNXtXPwMRpPPGwcnqEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRskpZFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534D6C4CED0;
	Thu,  2 Jan 2025 11:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735817777;
	bh=yjHGcKiL5zM5KXjwjgPEvNLsH7YFyyE3gPZPVjLlatQ=;
	h=From:To:Cc:Subject:Date:From;
	b=lRskpZFEq7Ky26CPZStq0P8LIC30pMw6I30ojRSKs+rVl0xgMJEU8ES7672PROx+B
	 iOAFQdhXAYLbLVLyG4oS/VwhbpYEmdFqeirtLPfyTYgEpVSboCCBTb3phTQNOV/YeI
	 jl0eQxviLX1Z9LKHZgW5LxHGhsewiciRJMti5Z3gMq/EnqN7uo8uKybU9xY0uJGAMd
	 O1LjesCQ6f2bI8iXS/xgRB8SOOxdFSryk6omDlH+zB+lyjloyx6gDWtXBGAdm01fy5
	 WyP5oqdPdMSzTpxXXwo0Sj2smHhYZav9rpPzvx8ct1Tr9HfMm1rap304uFmXj2VAzN
	 x7o02oOrUnFHg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH rdma-next 0/3] Add RDMA TRANSPORT steering domain
Date: Thu,  2 Jan 2025 13:36:04 +0200
Message-ID: <cover.1735817449.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From Patrisious,

The following series adds two new steering domains:
RDMA_TRANSPORT_RX - Packets will traverse through it after RDMA_RX
RDMA_TRANSPORT_TX - Packets will traverse through it before RDMA_TX

These domains created on the vport group manager for each vport.
So RDMA application running on VF(or SF) is not aware of this domain,
and the main motivation behind it is to catch control packets, forward
them to VF QP as well as the control SW to help with congestion control.

These new domains are also exposed to users through mlx5dv_create_flow_matcher()
which will now support these two new table types which have to be created with
its corresponding ib_port.

Thanks

Patrisious Haddad (3):
  net/mlx5: Query ADV_RDMA capabilities
  net/mlx5: fs, add RDMA TRANSPORT steering domain support
  RDMA/mlx5: Expose RDMA TRANSPORT flow table types to userspace

 drivers/infiniband/hw/mlx5/fs.c               | 140 ++++++++++++--
 drivers/infiniband/hw/mlx5/fs.h               |   2 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   3 +
 .../mellanox/mlx5/core/esw/acl/helper.c       |   2 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |   6 +-
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  |   2 +
 .../net/ethernet/mellanox/mlx5/core/fs_core.c | 178 ++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |  12 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |   7 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |   1 +
 include/linux/mlx5/device.h                   |  11 ++
 include/linux/mlx5/fs.h                       |  11 +-
 include/linux/mlx5/mlx5_ifc.h                 |  42 ++++-
 include/uapi/rdma/mlx5_user_ioctl_cmds.h      |   1 +
 include/uapi/rdma/mlx5_user_ioctl_verbs.h     |   2 +
 15 files changed, 385 insertions(+), 35 deletions(-)

-- 
2.47.1


