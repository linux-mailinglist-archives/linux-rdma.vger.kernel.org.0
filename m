Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D8320F27D
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2020 12:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbgF3KTC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jun 2020 06:19:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732162AbgF3KTC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jun 2020 06:19:02 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7EBB2073E;
        Tue, 30 Jun 2020 10:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593512341;
        bh=MgqOtwuEJn70fQmOaTWf8tVN+pvLSAlVQJwyozWbKhQ=;
        h=From:To:Cc:Subject:Date:From;
        b=t3k+pYK2Boio044H4pTukIKeNYRUEX2Nl4O5Ms1niVopma5YhnUiMjAIIZOX110uH
         gB7q6nhZtL+Dq5WuY270xbJy+S6WNoeZqq+we3GtuxNkMgnraH1xCL20WuZxjPZ338
         D2ADQkJBh9lUpYVLHKSRnqaCHhXPzItN9tgUvvVk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Lijun Ou <oulijun@huawei.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next v1 0/4] ib_core allocation patches
Date:   Tue, 30 Jun 2020 13:18:51 +0300
Message-Id: <20200630101855.368895-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Changelog
v1:
 * Removed empty "//" comment
 * Deleted destroy_rwq_ind_table from object tree
 * One patch was accepted, so rebased on latest for-upstream
v0:
https://lore.kernel.org/lkml/20200624105422.1452290-1-leon@kernel.org

----------------------------------------------------------------------

Let's continue my allocation work.

Leon Romanovsky (4):
  RDMA/core: Create and destroy counters in the ib_core
  RDMA: Clean MW allocation and free flows
  RDMA: Move XRCD to be under ib_core responsibility
  RDMA/core: Convert RWQ table logic to ib_core allocation scheme

 drivers/infiniband/core/device.c              |  4 +
 drivers/infiniband/core/uverbs.h              |  2 +-
 drivers/infiniband/core/uverbs_cmd.c          | 63 +++++++++------
 drivers/infiniband/core/uverbs_main.c         | 10 +--
 drivers/infiniband/core/uverbs_std_types.c    | 19 +++--
 .../core/uverbs_std_types_counters.c          | 17 ++--
 drivers/infiniband/core/verbs.c               | 51 +++++-------
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |  5 +-
 drivers/infiniband/hw/cxgb4/mem.c             | 35 +++------
 drivers/infiniband/hw/cxgb4/provider.c        |  4 +-
 drivers/infiniband/hw/hns/hns_roce_device.h   |  5 +-
 drivers/infiniband/hw/hns/hns_roce_main.c     |  2 +
 drivers/infiniband/hw/hns/hns_roce_mr.c       | 31 +++-----
 drivers/infiniband/hw/mlx4/main.c             | 43 +++++------
 drivers/infiniband/hw/mlx4/mlx4_ib.h          | 17 ++--
 drivers/infiniband/hw/mlx4/mr.c               | 32 +++-----
 drivers/infiniband/hw/mlx4/qp.c               | 40 +++-------
 drivers/infiniband/hw/mlx5/main.c             | 27 ++++---
 drivers/infiniband/hw/mlx5/mlx5_ib.h          | 18 ++---
 drivers/infiniband/hw/mlx5/mr.c               | 42 ++++------
 drivers/infiniband/hw/mlx5/qp.c               | 77 +++++++------------
 include/rdma/ib_verbs.h                       | 30 ++++----
 22 files changed, 247 insertions(+), 327 deletions(-)

--
2.26.2

