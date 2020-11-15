Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21832B34AE
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Nov 2020 12:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgKOLnS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Nov 2020 06:43:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:52432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgKOLnR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 15 Nov 2020 06:43:17 -0500
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86E102225B;
        Sun, 15 Nov 2020 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605440597;
        bh=lbJzMmcIHKZw6icm+u/fUPmEkFsHnOIOxVx+EoPyE14=;
        h=From:To:Cc:Subject:Date:From;
        b=nHTgLmOWJWMrMZOZUWS3Op37vJeQ/ixGG4vT26WQ5PEOfbC+jITx9dbOtSCaxXFzP
         xDpTUGbr/TdlEVLOoN4BD8fpcfVlTGRKRfJLfa7qO45zrb1GuQhCHQovlejx2iHYkj
         hC7LtdT6TtomGtsOX7aSuJScVMdA52J5HOrbB52c=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eli Cohen <eli@mellanox.com>,
        Haggai Abramonvsky <hagaya@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        "majd@mellanox.com" <majd@mellanox.com>,
        Matan Barak <matanb@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Roland Dreier <roland@purestorage.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next v1 0/7] Use ib_umem_find_best_pgsz() for all umems
Date:   Sun, 15 Nov 2020 13:43:04 +0200
Message-Id: <20201115114311.136250-1-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v1:
 * Added patch for raw QP
 * Fixed commit messages
v0: https://lore.kernel.org/lkml/20201026132635.1337663-1-leon@kernel.org

-------------------------
From Jason:

Move the remaining cases working with umems to use versions of
ib_umem_find_best_pgsz() tailored to the calculations the devices
requires.

Unlike a MR there is no IOVA, instead a page offset from the starting page
is possible, with various restrictions.

Compute the best page size to meet the page_offset restrictions.

Thanks

Jason Gunthorpe (7):
  RDMA/mlx5: Use ib_umem_find_best_pgoff() for SRQ
  RDMA/mlx5: Use mlx5_umem_find_best_quantized_pgoff() for WQ
  RDMA/mlx5: Directly compute the PAS list for raw QP RQ's
  RDMA/mlx5: Use mlx5_umem_find_best_quantized_pgoff() for QP
  RDMA/mlx5: mlx5_umem_find_best_quantized_pgoff() for CQ
  RDMA/mlx5: Use ib_umem_find_best_pgsz() for devx
  RDMA/mlx5: Lower setting the umem's PAS for SRQ

 drivers/infiniband/hw/mlx5/cq.c      |  48 +++++---
 drivers/infiniband/hw/mlx5/devx.c    |  66 ++++++-----
 drivers/infiniband/hw/mlx5/mem.c     | 115 +++++++------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  47 +++++++-
 drivers/infiniband/hw/mlx5/qp.c      | 165 ++++++++++++---------------
 drivers/infiniband/hw/mlx5/srq.c     |  27 +----
 drivers/infiniband/hw/mlx5/srq.h     |   1 +
 drivers/infiniband/hw/mlx5/srq_cmd.c |  80 ++++++++++++-
 include/rdma/ib_umem.h               |  42 +++++++
 9 files changed, 343 insertions(+), 248 deletions(-)

--
2.28.0

