Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74A43D0BC7
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 12:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbhGUIlC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 04:41:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238237AbhGUI0j (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Jul 2021 04:26:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBE4D61175;
        Wed, 21 Jul 2021 09:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626858436;
        bh=7VoEcx51qvBOK70R+BjXD1XtQAG64sl1tn6ZemK1hnM=;
        h=From:To:Cc:Subject:Date:From;
        b=jZfysgo3EMq9kOXczvjVmCxwR87S1uHuwp2L4E3FnzHoiesltQi4AVEuPTNeg0UiX
         DqpIREkJXff0NWIKkugItI01K3eIB/VZgu/7fRwTgvPmCN+ozrvxG8YdXp/mBvM0gg
         MnBpkRYiKm9YGJTg7sqcxYEnapCq7k3WtL0hjLK5qr7bqqX0BzPKmzKIQBcdQA1KAx
         M8b2nXDTsIJ2LGxnEt1cjPtHqAR3pFwKIZ0fsWVPtV98GqvxAvyPqHDjrnkwpEZy9z
         1HcgphaEFQclh55ZTgJ/jqLbu1chJ1jJnWYrFrOD+1JYeHLa+d1wOhwUQhQ4MBmU0X
         C9tyICCu/Y2SA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH rdma-next v1 0/7] Separate user/kernel QP creation logic
Date:   Wed, 21 Jul 2021 12:07:03 +0300
Message-Id: <cover.1626857976.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
iv1:
 * Fixed typo: incline -> inline/
 * Dropped ib_create_qp_uverbs() wrapper in favour of direct call.
 * Moved kernel-doc to the actual ib_create_qp() function that users will use.
v0: https://lore.kernel.org/lkml/cover.1626846795.git.leonro@nvidia.com

---------------------------------------------------------------------------
Hi,

The "QP allocation" series shows clearly how convoluted the create QP
flow and especially XRC_TGT flow, where it calls to kernel verb just
to pass some parameters as NULL to the user create QP verb.

This series is a small step to make clean XRC_TGT flow by providing
more clean user/kernel create QP verb separation.

It is based on the "QP allocation" series.

Thanks

Leon Romanovsky (7):
  RDMA/mlx5: Delete not-available udata check
  RDMA/core: Delete duplicated and unreachable code
  RDMA/core: Remove protection from wrong in-kernel API usage
  RDMA/core: Reorganize create QP low-level functions
  RDMA/core: Configure selinux QP during creation
  RDMA/core: Properly increment and decrement QP usecnts
  RDMA/core: Create clean QP creations interface for uverbs

 drivers/infiniband/core/core_priv.h           |  59 +----
 drivers/infiniband/core/uverbs_cmd.c          |  31 +--
 drivers/infiniband/core/uverbs_std_types_qp.c |  29 +--
 drivers/infiniband/core/verbs.c               | 208 +++++++++++-------
 drivers/infiniband/hw/mlx5/qp.c               |   3 -
 include/rdma/ib_verbs.h                       |  16 +-
 6 files changed, 157 insertions(+), 189 deletions(-)

-- 
2.31.1

