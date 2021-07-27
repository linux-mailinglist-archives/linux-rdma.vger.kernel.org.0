Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9F13D6CBE
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 05:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbhG0Cuz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jul 2021 22:50:55 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7438 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbhG0Cuy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Jul 2021 22:50:54 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GYj0S3P8vz8084;
        Tue, 27 Jul 2021 11:27:36 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 11:31:17 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 11:31:06 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH v3 for-next 00/12] RDMA/hns: Add support for Dynamic Context Attachment
Date:   Tue, 27 Jul 2021 11:27:20 +0800
Message-ID: <1627356452-30564-1-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The HIP09 introduces the DCA(Dynamic Context Attachment) feature which
supports many RC QPs to share the WQE buffer in a memory pool. If a QP
enables DCA feature, the WQE's buffer will not be allocated when creating
but when the users start to post WRs. This will reduce the memory
consumption when there are too many QPs are inactive.

Changes since v2:
* Refactor flow of modify_qp and then add a shared memory mechanism to
  synchronize status of DCA, which can save more memory than previous
  scheme.
* Remove some inline functions from #1.
* Add support for dumping DCA mem status in restrack.
* Link: https://patchwork.kernel.org/project/linux-rdma/cover/1620732161-27180-1-git-send-email-liweihang@huawei.com/

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

Xi Wang (12):
  RDMA/hns: Introduce DCA for RC QP
  RDMA/hns: Add method for shrinking DCA memory pool
  RDMA/hns: Configure DCA mode for the userspace QP
  RDMA/hns: Refactor QP modify flow
  RDMA/hns: Add method for attaching WQE buffer
  RDMA/hns: Setup the configuration of WQE addressing to QPC
  RDMA/hns: Add method to detach WQE buffer
  RDMA/hns: Add method to query WQE buffer's address
  RDMA/hns: Add a shared memory to sync DCA status
  RDMA/hns: Sync DCA status by the shared memory
  RDMA/nldev: Add detailed CTX information support
  RDMA/hns: Dump detailed driver-specific UCTX

 drivers/infiniband/core/device.c              |    1 +
 drivers/infiniband/core/nldev.c               |    8 +-
 drivers/infiniband/hw/hns/Makefile            |    2 +-
 drivers/infiniband/hw/hns/hns_roce_dca.c      | 1438 +++++++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_dca.h      |   73 ++
 drivers/infiniband/hw/hns/hns_roce_device.h   |   47 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c    |   12 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    |  173 ++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h    |    1 +
 drivers/infiniband/hw/hns/hns_roce_main.c     |  128 ++-
 drivers/infiniband/hw/hns/hns_roce_qp.c       |  169 ++-
 drivers/infiniband/hw/hns/hns_roce_restrack.c |   85 ++
 include/rdma/ib_verbs.h                       |    1 +
 include/uapi/rdma/hns-abi.h                   |   86 ++
 14 files changed, 2148 insertions(+), 76 deletions(-)
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_dca.c
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_dca.h

--
2.8.1

