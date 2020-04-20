Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080771B0F62
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 17:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgDTPLL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 11:11:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbgDTPLL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Apr 2020 11:11:11 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 441DD2074F;
        Mon, 20 Apr 2020 15:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587395471;
        bh=6UFLOWAprSQ5mjEGM3XnD3JuEIBCD19BtpyRyiiFWXM=;
        h=From:To:Cc:Subject:Date:From;
        b=nkV2kPsc9CDPI8+iBM9g1V7mLs/iPl9kpXtIWPC/VV0+Tlx9kNyuXa1L+2BlEeK7f
         FNJs6kQk2dsncVnBeO8+PnlzkZl2tWmC629elTuDcHZU6zvwz5Jz7+oOZF9lrBkiSK
         92rvGw9ob80XZYq9PRZPM7+s4Ao3o6PH0EIBF3po=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 00/18] Refactor mlx5_ib_create_qp (Part I)
Date:   Mon, 20 Apr 2020 18:10:47 +0300
Message-Id: <20200420151105.282848-1-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

This is first part of series which tries to return some sanity
to mlx5_ib_create_qp() function. Such refactoring is required
to make extension of that function with less worries of breaking
driver.

Extra goal of such refactoring is to ensure that QP is allocated
at the beginning of function and released at the end. It will allow
us to move QP allocation to be under IB/core responsibility.

It is based on previously sent [1] "[PATCH mlx5-next 00/24] Mass
conversion to light mlx5 command interface"

Thanks

[1] https://lore.kernel.org/linux-rdma/20200420114136.264924-1-leon@kernel.org

Leon Romanovsky (18):
  RDMA/mlx5: Organize QP types checks in one place
  RDMA/mlx5: Delete impossible GSI port check
  RDMA/mlx5: Perform check if QP creation flow is valid
  RDMA/mlx5: Prepare QP allocation for future removal
  RDMA/mlx5: Avoid setting redundant NULL for XRC QPs
  RDMA/mlx5: Set QP subtype immediately when it is known
  RDMA/mlx5: Separate create QP flows to be based on type
  RDMA/mlx5: Split scatter CQE configuration for DCT QP
  RDMA/mlx5: Update all DRIVER QP places to use QP subtype
  RDMA/mlx5: Move DRIVER QP flags check into separate function
  RDMA/mlx5: Remove second copy from user for non RSS RAW QPs
  RDMA/mlx5: Initial separation of RAW_PACKET QP from common flow
  RDMA/mlx5: Delete create QP flags obfuscation
  RDMA/mlx5: Process create QP flags in one place
  RDMA/mlx5: Use flags_en mechanism to mark QP created with WQE
    signature
  RDMA/mlx5: Change scatter CQE flag to be set like other vendor flags
  RDMA/mlx5: Return all configured create flags through query QP
  RDMA/mlx5: Process all vendor flags in one place

 drivers/infiniband/hw/mlx5/devx.c    |   2 +-
 drivers/infiniband/hw/mlx5/flow.c    |   2 +-
 drivers/infiniband/hw/mlx5/gsi.c     |  10 -
 drivers/infiniband/hw/mlx5/main.c    |   9 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  24 +-
 drivers/infiniband/hw/mlx5/odp.c     |   2 +-
 drivers/infiniband/hw/mlx5/qp.c      | 928 +++++++++++++--------------
 7 files changed, 467 insertions(+), 510 deletions(-)

--
2.25.2

