Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420EF37A5AA
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 13:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhEKLYB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 07:24:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2627 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbhEKLYA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 May 2021 07:24:00 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ffb6S2fnXzPwxy;
        Tue, 11 May 2021 19:19:28 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 19:22:41 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH v2 for-next 0/7] RDMA/hns: Add support for Dynamic Context Attachment
Date:   Tue, 11 May 2021 19:22:34 +0800
Message-ID: <1620732161-27180-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The HIP09 introduces the DCA(Dynamic Context Attachment) feature which
supports many RC QPs to share the WQE buffer in a memory pool. If a QP
enables DCA feature, the WQE's buffer will not be allocated when creating
but when the users start to post WRs. This will reduce the memory
consumption when there are too many QPs are inactive.

Changes since v1:
* Modify return type of hns_roce_enable_dca() to void.
* Link: https://patchwork.kernel.org/project/linux-rdma/cover/1620650889-61650-1-git-send-email-liweihang@huawei.com/

Two RFC versions of this series has been sent before, and it's associated
with the userspace one "libhns: Add support for Dynamic Context
Attachment".

Changes since RFC v2:
* Just fix a typo in commit message of #6.
* Link: https://patchwork.kernel.org/project/linux-rdma/cover/1611394994-50363-1-git-send-email-liweihang@huawei.com/

Changes since RFC v1:
* Replace all GFP_ATOMIC with GFP_NOWAIT, because the former may use
  emergency pool if no regular memory can be found.
* Change size of cap_flags of alloc_ucontext_resp from 32 to 64 to avoid
  a potential problem when pass it back to the userspace.
* Move definition of HNS_ROCE_CAP_FLAG_DCA_MODE to hns-abi.h.
* Rename free_mem_states() to free_dca_states() in #1.
* Link: https://patchwork.kernel.org/project/linux-rdma/cover/1610706138-4219-1-git-send-email-liweihang@huawei.com/

Xi Wang (7):
  RDMA/hns: Introduce DCA for RC QP
  RDMA/hns: Add method for shrinking DCA memory pool
  RDMA/hns: Configure DCA mode for the userspace QP
  RDMA/hns: Add method for attaching WQE buffer
  RDMA/hns: Setup the configuration of WQE addressing to QPC
  RDMA/hns: Add method to detach WQE buffer
  RDMA/hns: Add method to query WQE buffer's address

 drivers/infiniband/hw/hns/Makefile          |    2 +-
 drivers/infiniband/hw/hns/hns_roce_dca.c    | 1262 +++++++++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_dca.h    |   69 ++
 drivers/infiniband/hw/hns/hns_roce_device.h |   33 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  223 ++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |    3 +
 drivers/infiniband/hw/hns/hns_roce_main.c   |   27 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  105 ++-
 include/uapi/rdma/hns-abi.h                 |   64 ++
 9 files changed, 1746 insertions(+), 42 deletions(-)
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_dca.c
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_dca.h

-- 
2.7.4

