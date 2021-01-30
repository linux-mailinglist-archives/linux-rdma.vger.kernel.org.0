Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DD3309342
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Jan 2021 10:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhA3JX5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 30 Jan 2021 04:23:57 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11957 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbhA3JW6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 30 Jan 2021 04:22:58 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DSSnQ4qf3zjDtN;
        Sat, 30 Jan 2021 16:59:22 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 30 Jan 2021 17:00:21 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 00/12] RDMA/hns: Several fixes and cleanups of RQ/SRQ
Date:   Sat, 30 Jan 2021 16:57:58 +0800
Message-ID: <1611997090-48820-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There are some issues when using SRQ on HIP08/HIP09, the first part of this
series is some fixes on them.

In addition, the codes about RQ/SRQ including the creation and post recv
flow are a bit hard to understand, they need to be refactored.

Lang Cheng (2):
  RDMA/hns: Allocate one more recv SGE for HIP08
  RDMA/hns: Use new interfaces to write SRQC

Wenpeng Liang (8):
  RDMA/hns: Bugfix for checking whether the srq is full when post wr
  RDMA/hns: Force srq_limit to 0 when creating SRQ
  RDMA/hns: Fixed wrong judgments in the goto branch
  RDMA/hns: Remove the reserved WQE of SRQ
  RDMA/hns: Refactor hns_roce_create_srq()
  RDMA/hns: Refactor code about SRQ Context
  RDMA/hns: Refactor hns_roce_v2_post_srq_recv()
  RDMA/hns: Add verification of QP type when post_recv

Xi Wang (2):
  RDMA/hns: Refactor post recv flow
  RDMA/hns: Clear remaining unused sges when post_recv

 drivers/infiniband/hw/hns/hns_roce_device.h |  16 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 407 +++++++++++++++-------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  72 +++--
 drivers/infiniband/hw/hns/hns_roce_main.c   |   3 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  37 ++-
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 329 ++++++++++++----------
 6 files changed, 510 insertions(+), 354 deletions(-)

-- 
2.8.1

