Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A8737B79A
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 10:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhELINk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 04:13:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2637 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhELINi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 May 2021 04:13:38 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fg6rM3RPCzQmH8;
        Wed, 12 May 2021 16:09:07 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 16:12:23 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 0/4] RDMA: Remove unused parameter udata
Date:   Wed, 12 May 2021 16:12:18 +0800
Message-ID: <1620807142-39157-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The first parameter of ib_umem_get() has been changed from udata to
device, but some of its callers retain 'udata' as a parameter without
using it.

Lang Cheng (4):
  RDMA/hns: Remove unused parameter udata
  RDMA/mlx4: Remove unused parameter udata
  RDMA/mlx5: Remove unused parameter udata
  RDMA/rxe: Remove unused parameter udata

 drivers/infiniband/hw/hns/hns_roce_cq.c     | 3 +--
 drivers/infiniband/hw/hns/hns_roce_db.c     | 3 +--
 drivers/infiniband/hw/hns/hns_roce_device.h | 3 +--
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 4 ++--
 drivers/infiniband/hw/mlx4/cq.c             | 8 ++++----
 drivers/infiniband/hw/mlx5/cq.c             | 2 +-
 drivers/infiniband/hw/mlx5/doorbell.c       | 3 +--
 drivers/infiniband/hw/mlx5/mlx5_ib.h        | 4 +---
 drivers/infiniband/hw/mlx5/mr.c             | 2 +-
 drivers/infiniband/hw/mlx5/odp.c            | 1 -
 drivers/infiniband/hw/mlx5/qp.c             | 4 ++--
 drivers/infiniband/hw/mlx5/srq.c            | 2 +-
 drivers/infiniband/sw/rxe/rxe_loc.h         | 2 +-
 drivers/infiniband/sw/rxe/rxe_mr.c          | 2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c       | 2 +-
 15 files changed, 19 insertions(+), 26 deletions(-)

-- 
2.7.4

