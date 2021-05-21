Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D2238C31D
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 11:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhEUJb5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 May 2021 05:31:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3613 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbhEUJbp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 May 2021 05:31:45 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fmh7V38kzzQqdM;
        Fri, 21 May 2021 17:26:30 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 17:30:02 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 21 May 2021 17:30:02 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 0/5] RDMA/hns: Changes about memory allocation and configuration
Date:   Fri, 21 May 2021 17:29:50 +0800
Message-ID: <1621589395-2435-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These series includes several cleanups and fixes for HEM and MTR.

Weihang Li (1):
  RDMA/hns: Use refcount_t APIs for HEM

Xi Wang (4):
  RDMA/hns: Optimize the base address table config for MTR
  RDMA/hns: Refactor root BT allocation for MTR
  RDMA/hns: Fix wrong timer context buffer page size
  RDMA/hns: Clean the hardware related code for HEM

 drivers/infiniband/hw/hns/hns_roce_alloc.c  |  51 ++---
 drivers/infiniband/hw/hns/hns_roce_cq.c     |   4 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |  17 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c    | 342 +++++++++++++---------------
 drivers/infiniband/hw/hns/hns_roce_hem.h    |  13 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  77 +++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v1.h  |   5 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  32 ++-
 drivers/infiniband/hw/hns/hns_roce_mr.c     |  14 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     |   2 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c    |  10 +-
 11 files changed, 315 insertions(+), 252 deletions(-)

-- 
2.7.4

