Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE8D211DE4
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 10:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgGBISP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 04:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbgGBISO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Jul 2020 04:18:14 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EE6D20720;
        Thu,  2 Jul 2020 08:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593677894;
        bh=2dOO5kQOu2YXuUzo51sbC8QuexLQG37+CB+Iz14e9SA=;
        h=From:To:Cc:Subject:Date:From;
        b=Ey1aQpYxoNOTb3Yq3n1wkmMCa+xlzZrdYnYZkI7mWQ8Qd+B8Uls0BoczPWIfBCDyJ
         1xKdnetMiJ+Hx+ao8P2el6LpNOQ09t7ntAkHe0CWxDFvb/cTwqhA0OY/MQmSWZcP2a
         CltTgvV/S9FS4E0k+vnHLyJhkJ970JhO7kueyF3c=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 0/6] Cleanup mlx5_ib main file
Date:   Thu,  2 Jul 2020 11:18:03 +0300
Message-Id: <20200702081809.423482-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Over the years, the main.c file grew above all imagination and was >8K
LOC of the code. This caused to a huge burden while I started to work on
ib_flow allocation patches.

This series implements long standing "internal" wish to move flow logic
from the main to separate file.

Based on
https://lore.kernel.org/linux-rdma/20200630101855.368895-4-leon@kernel.org

Thanks

Leon Romanovsky (6):
  RDMA/mlx5: Limit the scope of mlx5_ib_enable_driver function
  RDMA/mlx5: Separate restrack callbacks initialization from main.c
  RDMA/mlx5: Separate counters from main.c
  RDMA/mlx5: Separate flow steering logic from main.c
  RDMA/mlx5: Cleanup DEVX initialization flow
  RDMA/mlx5: Delete one-time used functions

 drivers/infiniband/hw/mlx5/Makefile   |    3 +-
 drivers/infiniband/hw/mlx5/cmd.c      |   12 -
 drivers/infiniband/hw/mlx5/cmd.h      |    1 -
 drivers/infiniband/hw/mlx5/counters.c |  709 +++++
 drivers/infiniband/hw/mlx5/counters.h |   17 +
 drivers/infiniband/hw/mlx5/devx.c     |  102 +-
 drivers/infiniband/hw/mlx5/devx.h     |   45 +
 drivers/infiniband/hw/mlx5/flow.c     |  765 -----
 drivers/infiniband/hw/mlx5/fs.c       | 2514 +++++++++++++++
 drivers/infiniband/hw/mlx5/fs.h       |   29 +
 drivers/infiniband/hw/mlx5/main.c     | 4112 +++++--------------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h  |   76 +-
 drivers/infiniband/hw/mlx5/qp.c       |    1 +
 drivers/infiniband/hw/mlx5/qp.h       |    1 +
 drivers/infiniband/hw/mlx5/restrack.c |   29 +-
 drivers/infiniband/hw/mlx5/restrack.h |   13 +
 16 files changed, 4184 insertions(+), 4245 deletions(-)
 create mode 100644 drivers/infiniband/hw/mlx5/counters.c
 create mode 100644 drivers/infiniband/hw/mlx5/counters.h
 create mode 100644 drivers/infiniband/hw/mlx5/devx.h
 delete mode 100644 drivers/infiniband/hw/mlx5/flow.c
 create mode 100644 drivers/infiniband/hw/mlx5/fs.c
 create mode 100644 drivers/infiniband/hw/mlx5/fs.h
 create mode 100644 drivers/infiniband/hw/mlx5/restrack.h

--
2.26.2

