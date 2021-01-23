Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAE8301455
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Jan 2021 10:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbhAWJqv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 Jan 2021 04:46:51 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11141 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbhAWJqu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 23 Jan 2021 04:46:50 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DNB6S1VqBz15wQB;
        Sat, 23 Jan 2021 17:44:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 23 Jan 2021 17:45:21 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v2 RFC 0/7] RDMA/hns: Add support for Dynamic Context Attachment
Date:   Sat, 23 Jan 2021 17:43:07 +0800
Message-ID: <1611394994-50363-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The hip09 introduces the DCA(Dynamic Context Attachment) feature which
supports many RC QPs to share the WQE buffer in a memory pool. If a QP
enables DCA feature, the WQE's buffer will not be allocated when creating
but when the users start to post WRs. This will reduce the memory
consumption when there are too many QPs are inactive.

Changes since v1:
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
 drivers/infiniband/hw/hns/hns_roce_dca.c    | 1264 +++++++++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_dca.h    |   68 ++
 drivers/infiniband/hw/hns/hns_roce_device.h |   31 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  223 ++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |    3 +
 drivers/infiniband/hw/hns/hns_roce_main.c   |   27 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  119 ++-
 include/uapi/rdma/hns-abi.h                 |   64 ++
 9 files changed, 1754 insertions(+), 47 deletions(-)
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_dca.c
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_dca.h

-- 
2.8.1

