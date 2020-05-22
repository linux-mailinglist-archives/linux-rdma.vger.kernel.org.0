Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF241DE792
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 15:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgEVNDY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 09:03:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39524 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729046AbgEVNDY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 22 May 2020 09:03:24 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C79E1AECDDE6E92D3213;
        Fri, 22 May 2020 21:03:21 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 22 May 2020 21:03:15 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 0/4] RDMA/hns: Misc cleanups
Date:   Fri, 22 May 2020 21:02:55 +0800
Message-ID: <1590152579-32364-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is another series of cleanups for kernel 5.8 if it's not too late.

Lang Cheng (1):
  RDMA/hns: Simplify process related to poll cq

Weihang Li (1):
  RDMA/hns: Remove redundant type cast for general pointers

Wenpeng Liang (1):
  RDMA/hns: Remove redundant parameters from free_srq/qp_wrid()

Yixian Liu (1):
  RDMA/hns: Make the end of sge process more clear

 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 180 ++++++++++-------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  43 +++----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |   2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c    |   7 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c   |   6 +-
 5 files changed, 84 insertions(+), 154 deletions(-)

-- 
2.8.1

