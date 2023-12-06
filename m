Return-Path: <linux-rdma+bounces-280-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DF2807193
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 15:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CAA281B93
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 14:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9EB3C6AC;
	Wed,  6 Dec 2023 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIYY42O7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270183C497;
	Wed,  6 Dec 2023 14:01:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A0AC433C7;
	Wed,  6 Dec 2023 14:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701871305;
	bh=/smgYwrNiywTTOUBDU8u9NXotG8+d5x1VH+6Q14bcgE=;
	h=From:To:Cc:Subject:Date:From;
	b=QIYY42O737W5KvHlLRD+NnFnvcHBU33Xptq4n48C+y6W77vkWAo68OhPytfSqCW5m
	 mLcO4qS6/jTSNIFEq0MhxxXSgvzM3lonJOMDjXfk0k55MblKghDkztH3vy7CA2FD6y
	 Q0BKCKolqdkocKPkjTLQRJEArUATMFlxNmdqKsJJoOINLfayFlJhSUv3D3fU2a/lJR
	 45tRqIldjL7Ee+QFVIj+x0uUr/XP/lHzzmLzpmUIJ6gMezgEU1cpnu9p99x6I6kEIZ
	 qvAifQtP8tO4cmadQQ4l8SbU42+uj4iishys2xEKIAfUMDYyxBplKTNRKBC31aEkNb
	 h6W2JzWIW0aGg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shun Hao <shunh@nvidia.com>
Subject: [PATCH mlx5-next v1 0/5] Expose c0 and SW encap ICM for RDMA
Date: Wed,  6 Dec 2023 16:01:33 +0200
Message-ID: <cover.1701871118.git.leon@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v1:
 * Reordered patches
v0: https://lore.kernel.org/all/cover.1701172481.git.leon@kernel.org

-----------------------------------------------------------------------
Hi,

These two series from Mark and Shun extend RDMA mlx5 API.

Mark's series provides c0 register used to match egress
traffic sent by local device.

Shun's series adds new type for ICM area.

Thanks

Mark Bloch (2):
  net/mlx5: E-Switch, expose eswitch manager vport
  RDMA/mlx5: Expose register c0 for RDMA device

Shun Hao (3):
  net/mlx5: Introduce indirect-sw-encap ICM properties
  RDMA/mlx5: Support handling of SW encap ICM area
  net/mlx5: Manage ICM type of SW encap

 drivers/infiniband/hw/mlx5/dm.c               |  5 +++
 drivers/infiniband/hw/mlx5/main.c             | 24 ++++++++++++
 drivers/infiniband/hw/mlx5/mr.c               |  1 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  7 ----
 .../net/ethernet/mellanox/mlx5/core/lib/dm.c  | 38 ++++++++++++++++++-
 include/linux/mlx5/driver.h                   |  1 +
 include/linux/mlx5/eswitch.h                  |  8 ++++
 include/linux/mlx5/mlx5_ifc.h                 |  9 ++++-
 include/uapi/rdma/mlx5-abi.h                  |  2 +
 include/uapi/rdma/mlx5_user_ioctl_verbs.h     |  1 +
 10 files changed, 86 insertions(+), 10 deletions(-)

-- 
2.43.0


