Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23263801CB
	for <lists+linux-rdma@lfdr.de>; Fri, 14 May 2021 04:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhENCNF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 May 2021 22:13:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2726 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhENCNF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 May 2021 22:13:05 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FhBm76YRHz1BMNF;
        Fri, 14 May 2021 10:09:11 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Fri, 14 May 2021 10:11:42 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 0/6] RDMA: Use refcount_t for reference counting
Date:   Fri, 14 May 2021 10:11:33 +0800
Message-ID: <1620958299-4869-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There are some refcnt in type of atomic_t in RDMA subsystem, almost all of
them is wrote before the refcount_t is acheived in kernel. refcount_t is
better than integer for reference counting, it will WARN on
overflow/underflow and avoid use-after-free risks.

Weihang Li (6):
  RDMA/core: Use refcount_t instead of atomic_t for reference counting
  RDMA/hns: Use refcount_t instead of atomic_t for reference counting
  RDMA/hns: Use refcount_t APIs for HEM
  RDMA/cxgb4: Use refcount_t instead of atomic_t for reference counting
  RDMA/i40iw: Use refcount_t instead of atomic_t for reference counting
  RDMA/ipoib: Use refcount_t instead of atomic_t for reference counting

 drivers/infiniband/core/iwcm.c              |  9 +++--
 drivers/infiniband/core/iwcm.h              |  2 +-
 drivers/infiniband/core/iwpm_util.c         | 12 ++++---
 drivers/infiniband/core/iwpm_util.h         |  2 +-
 drivers/infiniband/core/mad_priv.h          |  2 +-
 drivers/infiniband/core/multicast.c         | 30 ++++++++--------
 drivers/infiniband/core/uverbs.h            |  2 +-
 drivers/infiniband/core/uverbs_main.c       | 12 +++----
 drivers/infiniband/hw/cxgb4/cq.c            |  6 ++--
 drivers/infiniband/hw/cxgb4/ev.c            |  8 ++---
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h      |  2 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c     |  8 ++---
 drivers/infiniband/hw/hns/hns_roce_device.h |  6 ++--
 drivers/infiniband/hw/hns/hns_roce_hem.c    | 33 +++++++++---------
 drivers/infiniband/hw/hns/hns_roce_hem.h    |  4 +--
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 12 +++----
 drivers/infiniband/hw/hns/hns_roce_srq.c    |  8 ++---
 drivers/infiniband/hw/i40iw/i40iw.h         |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_cm.c      | 54 ++++++++++++++---------------
 drivers/infiniband/hw/i40iw/i40iw_cm.h      |  4 +--
 drivers/infiniband/hw/i40iw/i40iw_main.c    |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_puda.h    |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_utils.c   | 10 +++---
 drivers/infiniband/ulp/ipoib/ipoib.h        |  4 +--
 drivers/infiniband/ulp/ipoib/ipoib_main.c   |  8 ++---
 25 files changed, 123 insertions(+), 121 deletions(-)

-- 
2.7.4

