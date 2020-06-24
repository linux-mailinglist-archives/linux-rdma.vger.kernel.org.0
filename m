Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C7120718C
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2020 12:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgFXKy2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jun 2020 06:54:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbgFXKy1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Jun 2020 06:54:27 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94A822084D;
        Wed, 24 Jun 2020 10:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592996067;
        bh=17HsD0S2DwoaJk72Px33RJQQ3gZ+iYWU0EbiEkKf4Ro=;
        h=From:To:Cc:Subject:Date:From;
        b=VpoLCrnRxhJ9t0qLYtfKn9Y8ADwmdYyywHTQ/zPl4WOyr7dpGHqnyYn8KDBhzzJdF
         WUo1Uqij5ZfJ0FvBSB9tYopQ1Q7AAAa0WlRPKk3Mk+xqiNSti5ilfCtiYaOhrITCo0
         SG205qIESqUf7dZpjaZBPGV9RD+TnmTnmp8qOv5s=
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
Subject: [PATCH rdma-next 0/5] ib_core allocation patches
Date:   Wed, 24 Jun 2020 13:54:17 +0300
Message-Id: <20200624105422.1452290-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Let's continue my allocation work.

Leon Romanovsky (5):
  RDMA/core: Create and destroy counters in the ib_core
  RDMA: Clean MW allocation and free flows
  RDMA: Move XRCD to be under ib_core responsibility
  RDMA/core: Delete not-used create RWQ table function
  RDMA/core: Convert RWQ table logic to ib_core allocation scheme

 drivers/infiniband/core/device.c              |  4 +
 drivers/infiniband/core/uverbs.h              |  2 +-
 drivers/infiniband/core/uverbs_cmd.c          | 63 ++++++++-----
 drivers/infiniband/core/uverbs_main.c         | 10 +-
 drivers/infiniband/core/uverbs_std_types.c    | 16 +++-
 .../core/uverbs_std_types_counters.c          | 17 ++--
 drivers/infiniband/core/verbs.c               | 94 +++++--------------
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |  5 +-
 drivers/infiniband/hw/cxgb4/mem.c             | 35 +++----
 drivers/infiniband/hw/cxgb4/provider.c        |  4 +-
 drivers/infiniband/hw/hns/hns_roce_device.h   |  5 +-
 drivers/infiniband/hw/hns/hns_roce_main.c     |  2 +
 drivers/infiniband/hw/hns/hns_roce_mr.c       | 31 ++----
 drivers/infiniband/hw/mlx4/main.c             | 43 ++++-----
 drivers/infiniband/hw/mlx4/mlx4_ib.h          | 17 ++--
 drivers/infiniband/hw/mlx4/mr.c               | 32 ++-----
 drivers/infiniband/hw/mlx4/qp.c               | 40 +++-----
 drivers/infiniband/hw/mlx5/main.c             | 27 +++---
 drivers/infiniband/hw/mlx5/mlx5_ib.h          | 18 ++--
 drivers/infiniband/hw/mlx5/mr.c               | 42 ++++-----
 drivers/infiniband/hw/mlx5/qp.c               | 77 +++++----------
 include/rdma/ib_verbs.h                       | 33 +++----
 22 files changed, 249 insertions(+), 368 deletions(-)

--
2.26.2

