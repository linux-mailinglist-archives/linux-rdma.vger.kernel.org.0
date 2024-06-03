Return-Path: <linux-rdma+bounces-2771-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4255A8D7FE9
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 12:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76E128A296
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 10:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2303782885;
	Mon,  3 Jun 2024 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="on5pBPWr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6427D3E8;
	Mon,  3 Jun 2024 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717410407; cv=none; b=cFvigcicBEiitaSnudoX+qWHfa6Mw7n/CbW4f32UmXsY8hTxpSqlRBVIzrtzqMgpQv7BO9nGHNt2x1HqvsGxSbnJmSYhF4uOHWk8yP4dqnfk9my/aTGKezChKWXjkR0N9SfVoFa+7/9H2Xh3GilCh+BtA8igtJBJamobFbm7ocM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717410407; c=relaxed/simple;
	bh=YJXqCgio39gKKxptigF5PmqKBej+tn+kRnRb5LjmgpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E/+Wv3RBM8aB2MIWhDqT2Zz4/z/lZA3MNyK81+rtdEl/18GKYsH/3g3B+uDMqlU3PyxhBUUuZCf0aNEBrTEH021z/j2+myjaIrDQh1+x1JEhJ0vnPnKOwUHfS7VZ0tAwEPLKM9rXITjBOmIBW6UMw+BTA6JX5RMk3daC9MMjxkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=on5pBPWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2F8C2BD10;
	Mon,  3 Jun 2024 10:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717410407;
	bh=YJXqCgio39gKKxptigF5PmqKBej+tn+kRnRb5LjmgpI=;
	h=From:To:Cc:Subject:Date:From;
	b=on5pBPWrA6eHtUZKwIDFR7JF+BZqxklml/MbfisQ7vXIQXZF2vB+mkm/8MwdPDi/9
	 pZ4XzDLi13ey4+qUYUNZyXmJxbIJjM3sF50MTNLFoU6joZK+r36Itg7mm01S04yAWL
	 zVsbIk0RGkLiPkYTxuOPO62n3K0VOUwyoc5xmOJy2Zl87EK5AKOLVfu3zN/L3Cubl4
	 3endCE5ULIdkktkZRkhGmWUu1p85OBaDWjm+d49Bt4J3SqJQxX6ZGHv8m9rvt+Wdln
	 jPJLa0GVQaVhWx+W3t8mOQdd6hA2OwAFmkTQflHOjt3Ww3nGLJRQcm/1kM0K86MLBK
	 xM40zScI34agw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jianbo Liu <jianbol@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH rdma-next 0/3] Delay mlx5_ib internal resources allocations
Date: Mon,  3 Jun 2024 13:26:36 +0300
Message-ID: <cover.1717409369.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Internal mlx5_ib resources are created during mlx5_ib module load. This
behavior is not optimal because it consumes resources that are not
needed when SFs are created. This patch series delays the creation of
mlx5_ib internal resources to the stage when they actually used.

Thanks

Jianbo Liu (3):
  net/mlx5: Reimplement write combining test
  IB/mlx5: Create UMR QP just before first reg_mr occurs
  IB/mlx5: Allocate resources just before first QP/SRQ is created

 drivers/infiniband/hw/mlx5/main.c             | 171 ++++---
 drivers/infiniband/hw/mlx5/mem.c              | 198 --------
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   9 +-
 drivers/infiniband/hw/mlx5/mr.c               |   9 +
 drivers/infiniband/hw/mlx5/qp.c               |  20 +-
 drivers/infiniband/hw/mlx5/srq.c              |   4 +
 drivers/infiniband/hw/mlx5/umr.c              |  55 ++-
 drivers/infiniband/hw/mlx5/umr.h              |   3 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/wc.c  | 434 ++++++++++++++++++
 include/linux/mlx5/driver.h                   |  11 +
 12 files changed, 627 insertions(+), 291 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/wc.c

-- 
2.45.1


