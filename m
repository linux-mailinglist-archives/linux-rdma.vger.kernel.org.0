Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8C72C7F70
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Nov 2020 08:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgK3H70 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Nov 2020 02:59:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:56544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgK3H7Z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 30 Nov 2020 02:59:25 -0500
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86A4420709;
        Mon, 30 Nov 2020 07:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606723125;
        bh=122yKBAyUpF7eYqq1cRrDvmVgtFxd5CNvvo6EC4D21M=;
        h=From:To:Cc:Subject:Date:From;
        b=VeZ8QgUT4DtqX9msq7QipOxesEEquXooq3cft+EbmIakIvD6TU5Ak1eq57XFaPGet
         R4n1qc2ts+KQ7ZO8MJal8yYLPwL/EQmH6zFZvmnO6JMrRB1TB7Krs/tzfLQq5KwoIt
         XKL1aoh84a8rWeuQssRHe6K4L2lWTGHUmfKQNlRE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 0/5] Clean up rereg_mr handling
Date:   Mon, 30 Nov 2020 09:58:34 +0200
Message-Id: <20201130075839.278575-1-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The mlx5 rereg_mr implementation is convoluted. Such code causes
to hard to spot bugs and even harder task - code review.

This series from Jason cleans that flow.

Thanks

Jason Gunthorpe (5):
  RDMA/uverbs: Tidy input validation of ib_uverbs_rereg_mr()
  RDMA/uverbs: Check ODP in ib_check_mr_access() as well
  RDMA/uverbs: Allow drivers to create a new HW object during rereg_mr
  RDMA/mlx5: Reorganize mlx5_ib_reg_user_mr()
  RDMA/mlx5: Fix error unwinds for rereg_mr

 drivers/infiniband/core/rdma_core.c           |  51 ++
 drivers/infiniband/core/uverbs_cmd.c          | 114 ++--
 drivers/infiniband/core/uverbs_std_types_mr.c |   2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h   |   7 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c       |  15 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h          |   8 +-
 drivers/infiniband/hw/mlx4/mr.c               |  16 +-
 drivers/infiniband/hw/mlx5/devx.c             |   2 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  10 +-
 drivers/infiniband/hw/mlx5/mr.c               | 532 ++++++++++--------
 drivers/infiniband/hw/mlx5/odp.c              |  16 +-
 include/rdma/ib_verbs.h                       |  13 +-
 include/rdma/uverbs_types.h                   |   5 +
 13 files changed, 482 insertions(+), 309 deletions(-)

--
2.28.0

