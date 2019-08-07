Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 924428499F
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 12:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfHGKeN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 06:34:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfHGKeN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 06:34:13 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 780D021E6E;
        Wed,  7 Aug 2019 10:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565174053;
        bh=kEg78J7uc4eeJ+qMTejNy6AMuZbBMrW4NY4PWYUSJtk=;
        h=From:To:Cc:Subject:Date:From;
        b=CDkbCkrPAhs10gPDKVKOHmmc8LnHjuTxS4pY725u3PHmK/Wncp5aKlOtq2g63BFjS
         wW9CuQfXPgpD2gUTjDAjT6gEW5OTnFwPTaBxluoKZEsAdoacX8+qy7Rg375sdc4Mmr
         ye0iXZx9zp912EOtkTTYbvM1uAIubb8ZwlteL680=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: [PATCH rdma-next 0/6] ODP information and statistics
Date:   Wed,  7 Aug 2019 13:33:57 +0300
Message-Id: <20190807103403.8102-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

This series from Erez refactors exposes ODP type information (explicit,
implicit) and statistics through netlink interface.

The iproute2 will be sent a little bit later this week.

Thanks

Erez Alfasi (6):
  RDMA: Embed umem within core MR
  RDMA/umem: Add ODP type indicator within ib_umem_odp
  RDMA/nldev: Return ODP type per MR
  IB/mlx5: Introduce ODP diagnostic counters
  RDMA/nldev: Allow different fill function per resource
  RDMA/nldev: Provide MR statistics

 drivers/infiniband/core/nldev.c              | 101 ++++++++++++++++---
 drivers/infiniband/core/umem.c               |   1 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c     |   4 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h     |   1 -
 drivers/infiniband/hw/cxgb3/iwch_provider.c  |  15 +--
 drivers/infiniband/hw/cxgb3/iwch_provider.h  |   1 -
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h       |   1 -
 drivers/infiniband/hw/cxgb4/mem.c            |  13 +--
 drivers/infiniband/hw/efa/efa.h              |   1 -
 drivers/infiniband/hw/efa/efa_verbs.c        |  19 ++--
 drivers/infiniband/hw/hns/hns_roce_device.h  |   1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c   |   7 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c   |   3 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c      |  42 ++++----
 drivers/infiniband/hw/i40iw/i40iw_verbs.c    |   8 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.h    |   1 -
 drivers/infiniband/hw/mlx4/mlx4_ib.h         |   1 -
 drivers/infiniband/hw/mlx4/mr.c              |  43 ++++----
 drivers/infiniband/hw/mlx5/mlx5_ib.h         |   5 +-
 drivers/infiniband/hw/mlx5/mr.c              |  36 +++----
 drivers/infiniband/hw/mlx5/odp.c             |  39 +++++--
 drivers/infiniband/hw/mthca/mthca_provider.c |  17 ++--
 drivers/infiniband/hw/mthca/mthca_provider.h |   1 -
 drivers/infiniband/hw/ocrdma/ocrdma.h        |   1 -
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  |  12 +--
 drivers/infiniband/hw/qedr/qedr.h            |   1 -
 drivers/infiniband/hw/qedr/verbs.c           |  12 +--
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h    |   1 -
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c |   8 +-
 include/rdma/ib_umem_odp.h                   |  28 +++++
 include/rdma/ib_verbs.h                      |   1 +
 include/uapi/rdma/ib_user_verbs.h            |   5 +
 include/uapi/rdma/rdma_netlink.h             |   5 +
 33 files changed, 279 insertions(+), 156 deletions(-)

--
2.20.1

