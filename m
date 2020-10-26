Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E92E298DBB
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 14:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421363AbgJZNXV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 09:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1421312AbgJZNXT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 09:23:19 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AE4F207DE;
        Mon, 26 Oct 2020 13:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603718598;
        bh=Wqyhlt/zYMpL8iZMsoMxIRDiAqiLMR+CelNVahqUIow=;
        h=From:To:Cc:Subject:Date:From;
        b=1ZQYMT2NJa9lTsguGJvVAaQvqxNHRDc53YNS3VCWSFKeweT7hh2MYV1oqvkW28jxu
         nYwBnQcVGvJCbXowZ9V0S0TY51BqSqW80pXZZRRoqFYIDq5/Zna9m8cPWThPkPOiyb
         3zEkzayrJhE90t7pszv9rQqKYvJQVwDLXcz0/WNY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 0/5] Use ib_umem_find_best_pgsz() when creating MRs
Date:   Mon, 26 Oct 2020 15:23:09 +0200
Message-Id: <20201026132314.1336717-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

From Jason:

The new common code does a better job finding large page sizes. Use it in
mlx5 for MRs.

This requires moving the MTT population for mailboxes and UMR over to
rdma_for_each_dma_block().

Thanks

Jason Gunthorpe (5):
  RDMA/mlx5: Change mlx5_ib_populate_pas() to use rdma_for_each_block()
  RDMA/mlx5: Move xlt_emergency_page_mutex into mr.c
  RDMA/mlx5: Split the WR setup out of mlx5_ib_update_xlt()
  RDMA/mlx5: Split mlx5_ib_update_xlt() into ODP and non-ODP cases
  RDMA/mlx5: Use ib_umem_find_best_pgsz() for mkc's

 drivers/infiniband/core/umem.c       |   9 +
 drivers/infiniband/hw/mlx5/cq.c      |   6 +-
 drivers/infiniband/hw/mlx5/devx.c    |   4 +-
 drivers/infiniband/hw/mlx5/main.c    |  26 +-
 drivers/infiniband/hw/mlx5/mem.c     |  73 +-----
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  37 ++-
 drivers/infiniband/hw/mlx5/mr.c      | 364 ++++++++++++++++++---------
 drivers/infiniband/hw/mlx5/qp.c      |   6 +-
 drivers/infiniband/hw/mlx5/srq.c     |   2 +-
 9 files changed, 312 insertions(+), 215 deletions(-)

--
2.26.2

