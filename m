Return-Path: <linux-rdma+bounces-12780-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B20DB286A9
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 21:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0730B056DD
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 19:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE3E2561C9;
	Fri, 15 Aug 2025 19:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="le5+wiC8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C6D217F34;
	Fri, 15 Aug 2025 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755287346; cv=none; b=PStxiqqP3hToAVwgeLn2nD6epqXJTISgTnWS1YbSTACLs3l4iqu9++NX2ikXEMKCaividNlNoylm0J2ciuG4D/g1uIkI5/bFYLLciuqqQ/wOPIxMa2lEZTJgiJfLe8dZnRO2O97RiMRD1CyOYrH9ogqpCKRVNDUnkdcqsy7WpTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755287346; c=relaxed/simple;
	bh=rPWcJvQK/bcOJAdv0+HXrKWJauiznY4nDlfwlarhDxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tRdE5ycqJqhLKC6Hg44zGtIwyH75b7eblUYgxyRiB2j1hVsm/dSJyjYesga/z7MsYq3kcjJmyH59vNVJrJUJ3HYMYRC1X9G5x8xWrPiUhQsvSg0lYmi2pvn+sbPu6//F62DtcZRKDDekCZks8JaJy1Smfrzqdx6kBASMRw4R1cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=le5+wiC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D65C4CEEB;
	Fri, 15 Aug 2025 19:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755287345;
	bh=rPWcJvQK/bcOJAdv0+HXrKWJauiznY4nDlfwlarhDxk=;
	h=From:To:Cc:Subject:Date:From;
	b=le5+wiC8zmV5zRGh7rVK7lp70IoWZWe5nZ7fD+RIUF4XjUJhvNnWuU+lV8plPxT25
	 EP8xOcepdfx3XWQgv3a4V5VCqHDiJzbBSuI3HNXagsfvkzqtsDvx/aonjq9AugsGyo
	 6fo+QofQCbfABkDG5iWLz7owdMQuwZ8KcWraUD7fGuxOqkNycyytIOjCnNTHIpm7hA
	 0fUSnR8qsYzlhEoMfGA5YC813ARVIryCTczJ2KjaMLnKkyGx9DCPZeIpcUQJzcyZwi
	 N+pSyetGQUMNpCt1A06Klpn11xp2qBBT0++8huZa38B0aEjB3yeULEeESXIBcuxfLM
	 dJeRd+z9tAHyQ==
From: Saeed Mahameed <saeed@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Parav Pandit <parav@nvidia.com>
Subject: [GIT PULL][mlx5-next 0/4] Cached vhca id and adjacent function vports
Date: Fri, 15 Aug 2025 12:48:57 -0700
Message-ID: <20250815194901.298689-1-saeed@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Hi Jakub, Jason,

This pull request introduces a preparation patchset for caching vhca_id 
and needed HW bits for the upcoming netdev/eswitch series to support
adjacent function vports.

For more information please see tag log below.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git tags/mlx5-next-vhca-id

for you to fetch changes up to 40653f280b2640e5caa94eeedee43e0f1df97704:

  {rdma,net}/mlx5: export mlx5_vport_get_vhca_id (2025-08-15 12:17:47 -0700)

----------------------------------------------------------------
mlx5-next-vhca-id

A preparation patchset for adjacent function vports.

Adjacent functions can delegate their SR-IOV VFs to sibling PFs,
allowing for more flexible and scalable management in multi-host and
ECPF-to-host scenarios. Adjacent vports can be managed by the management
PF via their unique vhca id and can't be managed by function index as the
index can conflict with the local vports/vfs.

This series provides:

- Use the cached vcha id instead of querying it every time from fw
- Query hca cap using vhca id instead of function id when FW supports it
- Add HW capabilities and required definitions for adjacent function vports

----------------------------------------------------------------
Saeed Mahameed (4):
      net/mlx5: mlx5_ifc, Add hardware definitions needed for adjacent vports
      net/mlx5: E-Switch, Cache vport vhca id on first cap query
      net/mlx5: E-Switch, Set/Query hca cap via vhca id
      {rdma,net}/mlx5: export mlx5_vport_get_vhca_id

 drivers/infiniband/hw/mlx5/std_types.c                        |  27 ++++-----------------------
 drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c  |   2 ++
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c             |  18 ++++++++++++++++--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h             |  20 ++++++++++++++++++--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c    |  34 +++++++++++++++++-----------------
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h           |   2 --
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c    |  16 +++++++++++-----
 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_cmd.c |  16 ++++++++++++----
 drivers/net/ethernet/mellanox/mlx5/core/vport.c               |  58 ++++++++++++++++++++++++++++++++++++++++++++++++++++------
 include/linux/mlx5/mlx5_ifc.h                                 | 133 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 include/linux/mlx5/vport.h                                    |   2 ++
 11 files changed, 263 insertions(+), 65 deletions(-)

-- 
2.50.1


