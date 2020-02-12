Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75EFB15A1EA
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2020 08:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgBLH0p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Feb 2020 02:26:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728294AbgBLH0p (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Feb 2020 02:26:45 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B21F02073C;
        Wed, 12 Feb 2020 07:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581492405;
        bh=EDc8/ccu0dVjOUUmWXmB2qfPz0QR7pmifOZfvGhxq88=;
        h=From:To:Cc:Subject:Date:From;
        b=kswiPS3ZrRq818IsuYP75T23KCSn7PRXiIzx9KMrUSk8lPXy9MPjeeGjtALuN/bgb
         fslJaeyptgf5PzSt7UPSmMBKt4yhHMzey6Gq5DxYFIgu2SlD7YpWj/rHbbBhKqf2Jo
         t4/lMAmunggBDNimi4BDsKlL6d0nj960hB+r/MN8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Maor Gottlieb <maorg@mellanox.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Valentine Fatiev <valentinef@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Yonatan Cohen <yonatanc@mellanox.com>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: [PATCH rdma-rc 0/9] Fixes for v5.6
Date:   Wed, 12 Feb 2020 09:26:26 +0200
Message-Id: <20200212072635.682689-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

This pack of small fixes is sent as a patchset simply to simplify their
tracking. Some of them, like first and second patches were already
sent to the mailing list. The ucma patch was in our regression for whole
cycle and we didn't notice any failures related to that change.

Changelog of second patch:
1. Maor added IB_QP_PKEY_INDEX and IB_QP_PORT checks and I rewrote the
code logic to be less hairy.

Thanks

Leon Romanovsky (2):
  RDMA/ucma: Mask QPN to be 24 bits according to IBTA
  RDMA/mlx5: Prevent overflow in mmap offset calculations

Maor Gottlieb (1):
  RDMA/core: Fix protection fault in get_pkey_idx_qp_list

Michael Guralnik (1):
  RDMA/core: Add missing list deletion on freeing event queue

Parav Pandit (1):
  Revert "RDMA/cma: Simplify rdma_resolve_addr() error flow"

Valentine Fatiev (1):
  IB/ipoib: Fix double free of skb in case of multicast traffic in CM
    mode

Yishai Hadas (1):
  IB/mlx5: Fix async events cleanup flows

Yonatan Cohen (1):
  IB/umad: Fix kernel crash while unloading ib_umad

Zhu Yanjun (1):
  RDMA/rxe: Fix soft lockup problem due to using tasklets in softirq

 drivers/infiniband/core/cm.c               |  3 ++
 drivers/infiniband/core/cma.c              | 15 +++++--
 drivers/infiniband/core/security.c         | 24 ++++------
 drivers/infiniband/core/ucma.c             |  2 +-
 drivers/infiniband/core/user_mad.c         |  5 ++-
 drivers/infiniband/core/uverbs_std_types.c |  1 +
 drivers/infiniband/hw/mlx5/devx.c          | 51 ++++++++++++----------
 drivers/infiniband/hw/mlx5/main.c          |  4 +-
 drivers/infiniband/sw/rxe/rxe_comp.c       |  8 ++--
 drivers/infiniband/ulp/ipoib/ipoib.h       |  1 +
 drivers/infiniband/ulp/ipoib/ipoib_cm.c    | 15 ++++---
 drivers/infiniband/ulp/ipoib/ipoib_ib.c    |  8 +++-
 drivers/infiniband/ulp/ipoib/ipoib_main.c  |  1 +
 13 files changed, 78 insertions(+), 60 deletions(-)

--
2.24.1

