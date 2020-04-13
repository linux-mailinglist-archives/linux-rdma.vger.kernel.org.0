Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4F71A6602
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 13:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgDML6U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 07:58:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53138 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729304AbgDML6T (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Apr 2020 07:58:19 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7252B21863D37BDEDE0F;
        Mon, 13 Apr 2020 19:58:17 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 13 Apr 2020 19:58:10 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 0/6] RDMA/hns: Support 0 hop addressing
Date:   Mon, 13 Apr 2020 19:58:05 +0800
Message-ID: <1586779091-51410-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add support for 0 hop addressing, which means hip08 supports multi-hops
addressing range from 0 to 3.

Unforunately, there are still some dev_*() in in the initialization process
of the hns driver in this series that can't be replaced by ibdev_*()
currently, but they will be modified in subsequent patches.

Xi Wang (6):
  RDMA/hns: Add support for addressing when hopnum is 0
  RDMA/hns: Optimize hns buffer allocation flow
  RDMA/hns: Optimize 0 hop addressing for EQE buffer
  RDMA/hns: Support 0 hop addressing for WQE buffer
  RDMA/hns: Support 0 hop addressing for SRQ buffer
  RDMA/hns: Support 0 hop addressing for CQE buffer

 drivers/infiniband/hw/hns/hns_roce_alloc.c  | 103 +++----
 drivers/infiniband/hw/hns/hns_roce_cq.c     | 351 +++++++---------------
 drivers/infiniband/hw/hns/hns_roce_device.h | 100 ++++---
 drivers/infiniband/hw/hns/hns_roce_hem.c    |   9 +-
 drivers/infiniband/hw/hns/hns_roce_hem.h    |   5 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  93 +++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 261 ++++++-----------
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 431 ++++++++++++++++++++++++++--
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 182 +++---------
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 368 +++++++++---------------
 10 files changed, 954 insertions(+), 949 deletions(-)

-- 
2.8.1

