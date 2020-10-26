Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73622298DB0
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 14:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1779961AbgJZNWq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 09:22:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1776648AbgJZNTn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 09:19:43 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F09B722263;
        Mon, 26 Oct 2020 13:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603718382;
        bh=WN48BsDW4YWDZH9vRbJ0KsZM81iUpHmuKeC2degqmfI=;
        h=From:To:Cc:Subject:Date:From;
        b=RAL8/S1dVoRwxVEhEzNJDtjG8WqUV9vQwS6fwfRMgCDitEeM9fuXQQ60MI6BwY1iE
         imEcO9farQ2c/z6mKAaxVn9p7vjw0pQs7QyHnj0l/p6gFtggF4DyaDZZnXQyjUtMxa
         cxbO7JTFG7svAy05IYo7+4llSbrp4wtkAT66gK28=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        linux-rdma@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH rdma-next 0/7] Use only a umem and HW page_shift to calculate MR sizes
Date:   Mon, 26 Oct 2020 15:19:29 +0200
Message-Id: <20201026131936.1335664-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

From Jason:

The MR code computes and passes around a tuple of (npages, page_shift,
ncont, order) to represent the size of the MR in various terms.

This is quite confusing about what term refers to what, and overlaps with
data already stored and computed inside the umem. Rework all of this to be
more umem centric and use these identities instead:

      npages == ib_umem_num_pages(mr->umem)
      page_shift == mr->page_shift
      ncont == ib_umem_num_dma_blocks(mr->umem, 1 << mr->page_shift)
      order == order_base_2(ncont)

By storing the page_shift inside the mlx5_ib_mr it becomes nearly self
describing.

Thanks

Jason Gunthorpe (7):
  RDMA/mlx5: Remove mlx5_ib_mr->order
  RDMA/mlx5: Fix corruption of reg_pages in mlx5_ib_rereg_user_mr()
  RDMA/mlx5: Remove mlx5_ib_mr->npages
  RDMA/mlx5: Move mlx5_ib_cont_pages() to the creation of the mlx5_ib_mr
  RDMA/mlx5: Remove order from mlx5_ib_cont_pages()
  RDMA/mlx5: Remove ncont from mlx5_ib_cont_pages()
  RDMA/mlx5: Remove npages from mlx5_ib_cont_pages()

 drivers/infiniband/hw/mlx5/cq.c      |  39 ++++---
 drivers/infiniband/hw/mlx5/devx.c    |  20 ++--
 drivers/infiniband/hw/mlx5/mem.c     |  30 ++---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   6 +-
 drivers/infiniband/hw/mlx5/mr.c      | 168 ++++++++++++---------------
 drivers/infiniband/hw/mlx5/qp.c      |  39 +++----
 drivers/infiniband/hw/mlx5/srq.c     |   8 +-
 7 files changed, 134 insertions(+), 176 deletions(-)

--
2.26.2

