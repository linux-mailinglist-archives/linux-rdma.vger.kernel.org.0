Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24B622E757
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jul 2020 10:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgG0ILu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jul 2020 04:11:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43656 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726451AbgG0ILt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Jul 2020 04:11:49 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 674FE8259CC000584AB1;
        Mon, 27 Jul 2020 16:11:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 27 Jul 2020 16:11:37 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 0/7] RDMA/hns: Updates for kernel v5.8
Date:   Mon, 27 Jul 2020 16:10:42 +0800
Message-ID: <1595837449-29193-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These are some miscellaneous changes of hns driver. #1 ~ #5 are cleanups
and #6 ~ #7 are small fixes.

Lang Cheng (4):
  RDMA/hns: Remove redundant hardware opcode definitions
  RDMA/hns: Remove support for HIP08A
  RDMA/hns: Delete unnecessary memset when allocating VF resource
  RDMA/hns: Fix error during modify qp RTS2RTS

Weihang Li (2):
  RDMA/hns: Refactor hns_roce_v2_set_hem()
  RDMA/hns: Remove redundant parameters in set_rc_wqe()

Xi Wang (1):
  RDMA/hns: Fix the unneeded process when getting a general type of CQE
    error

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 209 +++++++++++++++--------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  19 +--
 drivers/infiniband/hw/hns/hns_roce_qp.c    |  10 --
 3 files changed, 113 insertions(+), 125 deletions(-)

-- 
2.8.1

