Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86D82F7699
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Jan 2021 11:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbhAOKZI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Jan 2021 05:25:08 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11540 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbhAOKZG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Jan 2021 05:25:06 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DHHLv6bDxzMKl9;
        Fri, 15 Jan 2021 18:23:03 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Fri, 15 Jan 2021 18:24:22 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH RFC 0/7] RDMA/hns: Add support for Dynamic Context Attachment
Date:   Fri, 15 Jan 2021 18:22:11 +0800
Message-ID: <1610706138-4219-1-git-send-email-liweihang@huawei.com>
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
 drivers/infiniband/hw/hns/hns_roce_device.h |   32 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  223 ++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |    3 +
 drivers/infiniband/hw/hns/hns_roce_main.c   |   27 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  119 ++-
 include/uapi/rdma/hns-abi.h                 |   60 ++
 9 files changed, 1751 insertions(+), 47 deletions(-)
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_dca.c
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_dca.h

-- 
2.8.1

