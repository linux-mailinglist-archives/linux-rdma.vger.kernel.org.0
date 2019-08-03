Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B344080564
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Aug 2019 10:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387816AbfHCItg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Aug 2019 04:49:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3752 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387817AbfHCItf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 3 Aug 2019 04:49:35 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B1804F30EBDBD0FBB582;
        Sat,  3 Aug 2019 16:49:30 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Sat, 3 Aug 2019 16:49:21 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V3 for-next 00/13] Updates for 5.3-rc2
Date:   Sat, 3 Aug 2019 16:45:06 +0800
Message-ID: <1564821919-100676-1-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here are some updates for hns driver based 5.3-rc2, mainly
include some codes optimization and comments style modification.

Change from V2:
1. Remove the unncessary memset opertion for the tenth patch

Change from V1:
1. Fix the checkpatch warning
2. Use ibdev print interface instead of dev print interface in
   this patchset.

Lang Cheng (6):
  RDMA/hns: Clean up unnecessary initial assignment
  RDMA/hns: Update some comments style
  RDMA/hns: Handling the error return value of hem function
  RDMA/hns: Split bool statement and assign statement
  RDMA/hns: Refactor irq request code
  RDMA/hns: Remove unnecessary kzalloc

Lijun Ou (2):
  RDMA/hns: Encapsulate some lines for setting sq size in user mode
  RDMA/hns: Optimize hns_roce_modify_qp function

Weihang Li (2):
  RDMA/hns: Remove redundant print in hns_roce_v2_ceq_int()
  RDMA/hns: Disable alw_lcl_lpbk of SSU

Yangyang Li (1):
  RDMA/hns: Refactor hns_roce_v2_set_hem for hip08

Yixian Liu (2):
  RDMA/hns: Update the prompt message for creating and destroy qp
  RDMA/hns: Remove unnessary init for cmq reg

 drivers/infiniband/hw/hns/hns_roce_device.h |  65 +++++----
 drivers/infiniband/hw/hns/hns_roce_hem.c    |  15 +-
 drivers/infiniband/hw/hns/hns_roce_hem.h    |   6 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 211 ++++++++++++++--------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   2 -
 drivers/infiniband/hw/hns/hns_roce_mr.c     |   1 -
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 178 ++++++++++++++---------
 7 files changed, 260 insertions(+), 218 deletions(-)

-- 
1.9.1

