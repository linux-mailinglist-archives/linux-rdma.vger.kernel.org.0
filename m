Return-Path: <linux-rdma+bounces-777-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE0883F4CC
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jan 2024 10:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910451C20F35
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jan 2024 09:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4E1DDAB;
	Sun, 28 Jan 2024 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKk/dkIG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1AFDF55
	for <linux-rdma@vger.kernel.org>; Sun, 28 Jan 2024 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706434163; cv=none; b=qWgRNFmJgaMsaC8UJ51f3kIZkbBdEShbS/dWvz1IO1VaBE8/CfevO8FZX5uOM2WQALCassw8QYMm91+WlZvBqcKhBp4dA2jKo7MQWCw+o6Z21ZMFc+ih+xD2pU8Fn75TWeOlsbnVEqG8PS3tXOywodQAiQM3AtyXTb7esREeoJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706434163; c=relaxed/simple;
	bh=OZ5BZ5Q2M9EEc0BwWPGZb+e9npIkgKqAVeAgmljJW14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a9f8XzfIRBA4zW3BDRwiIZsuhejFClRtmbR8hPb+1x4fA+rlYme6BsiW1nRucFt4Agg6vV8ef786puwSawoiWsFW3qgoLTKhsg04vLnKDMhOXHUn6YC1Q1KUgK8Uw74k/i7sLwBQCpOopz5n8spArhVcxhhVYieDK2df/yRVNyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKk/dkIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A108C433F1;
	Sun, 28 Jan 2024 09:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706434163;
	bh=OZ5BZ5Q2M9EEc0BwWPGZb+e9npIkgKqAVeAgmljJW14=;
	h=From:To:Cc:Subject:Date:From;
	b=iKk/dkIGLLeN/ZO8z5im8tUoon+Gmvkdh0PMe97ahetoqZcf4BaFrNrZfj4C+3RA+
	 AADHEAztNM779oeLCb1Ah1HHeKOKammtCnnhAw6nkVt6W9+/POhyLWyZrpvYCISwOH
	 wamM1uolaLTROx6985wiEFeo8www16wwHxZ+ZIfP8L04kJCm8eooYPS0lY1gxDOXEH
	 jU+1vcfferZJso2DKJ47DrCAI1x93O2gZFNXrR58LeRMZtI/3s0bNah3zeBTQbKqlZ
	 TjhxiSfV0MqaZX5Iggn1iofaeRZmu927DjqNeq4JmiiA0zDf8QKDROqryJYNQh2R+v
	 kW08fuB8Yipew==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>,
	Mark Zhang <markzhang@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Tamar Mashiah <tmashiah@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next v1 0/6] Collection of mlx5_ib fixes
Date: Sun, 28 Jan 2024 11:29:10 +0200
Message-ID: <cover.1706433934.git.leon@kernel.org>
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
 * Changed function signature is_cacheable_mkey to pass pointer and not value.
v0: https://lore.kernel.org/all/cover.1706185318.git.leon@kernel.org

---------------------------------------------------------------------------------

Hi,

Collection of independent fixes for mlx5_ib driver.

Thanks

Leon Romanovsky (1):
  RDMA/mlx5: Fix fortify source warning while accessing Eth segment

Mark Zhang (1):
  IB/mlx5: Don't expose debugfs entries for RRoCE general parameters if
    not supported

Or Har-Toov (3):
  RDMA/mlx5: Uncacheable mkey has neither rb_key or cache_ent
  RDMA/mlx5: Change check for cacheable user mkeys
  RDMA/mlx5: Adding remote atomic access flag to updatable flags

Yishai Hadas (1):
  RDMA/mlx5: Relax DEVX access upon modify commands

 drivers/infiniband/hw/mlx5/cong.c    |  6 ++++++
 drivers/infiniband/hw/mlx5/devx.c    |  2 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 +-
 drivers/infiniband/hw/mlx5/mr.c      | 18 ++++++++++--------
 drivers/infiniband/hw/mlx5/wr.c      |  2 +-
 include/linux/mlx5/mlx5_ifc.h        |  2 +-
 include/linux/mlx5/qp.h              |  5 ++++-
 7 files changed, 24 insertions(+), 13 deletions(-)

-- 
2.43.0


