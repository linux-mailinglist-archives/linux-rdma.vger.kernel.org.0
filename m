Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249CE1DB5A7
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 15:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgETNxq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 09:53:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4873 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbgETNxp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 May 2020 09:53:45 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 21857C4AD6F1686EECB1;
        Wed, 20 May 2020 21:53:42 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 20 May 2020 21:53:34 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 0/9] RDMA/hns: Cleanups for 5.8
Date:   Wed, 20 May 2020 21:53:10 +0800
Message-ID: <1589982799-28728-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These are some cleanups, include removing dead code, modifying
varibles/fields types, and optimizing some functions.

Lang Cheng (3):
  RDMA/hns: Let software PI/CI grow naturally
  RDMA/hns: Add CQ flag instead of independent enable flag
  RDMA/hns: Optimize post and poll process

Weihang Li (2):
  RDMA/hns: Change all page_shift to unsigned
  RDMA/hns: Change variables representing quantity to unsigned

Xi Wang (3):
  RDMA/hns: Rename QP buffer related function
  RDMA/hns: Refactor the QP context filling process related to WQE
    buffer configure
  RDMA/hns: Optimize the usage of MTR

Yangyang Li (1):
  RDMA/hns: Remove unused code about assert

 drivers/infiniband/hw/hns/hns_roce_alloc.c  |   2 +-
 drivers/infiniband/hw/hns/hns_roce_common.h |   4 -
 drivers/infiniband/hw/hns/hns_roce_cq.c     |  10 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |  38 ++--
 drivers/infiniband/hw/hns/hns_roce_hem.c    |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hem.h    |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 323 +++++++++++++++-------------
 drivers/infiniband/hw/hns/hns_roce_main.c   |   1 -
 drivers/infiniband/hw/hns/hns_roce_mr.c     |  72 ++++---
 drivers/infiniband/hw/hns/hns_roce_qp.c     |   8 +-
 10 files changed, 249 insertions(+), 213 deletions(-)

-- 
2.8.1

