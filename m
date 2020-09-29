Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B500027C151
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 11:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgI2Jdj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 05:33:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14769 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725786AbgI2Jdj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Sep 2020 05:33:39 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EF21B20ECEA0AAC0CA12;
        Tue, 29 Sep 2020 17:33:36 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 17:33:30 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next] RDMA/hns: Remove unused variables and definitions
Date:   Tue, 29 Sep 2020 17:32:14 +0800
Message-ID: <1601371934-40003-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Some code was removed but the variables were still there, and some
parameters have been changed to be queried from firmware. So the
definitions of them are no longer needed.

Fixes: 2a3d923f8730 ("RDMA/hns: Replace magic numbers with #defines")
Fixes: 82e620d9c3a0 ("RDMA/hns: Modify the data structure of hns_roce_av")
Fixes: 82547469782a ("IB/hns: Implement the add_gid/del_gid and optimize the GIDs management")
Fixes: 21b97f538765 ("RDMA/hns: Fixup qp release bug")
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
Changes since v1 (https://patchwork.kernel.org/patch/11802025/):
- Add fixes tag for related patches.

 drivers/infiniband/hw/hns/hns_roce_device.h | 8 --------
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 2 --
 2 files changed, 10 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index a8183ef..6d2acff 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -57,7 +57,6 @@
 /* Hardware specification only for v1 engine */
 #define HNS_ROCE_MAX_INNER_MTPT_NUM		0x7
 #define HNS_ROCE_MAX_MTPT_PBL_NUM		0x100000
-#define HNS_ROCE_MAX_SGE_NUM			2
 
 #define HNS_ROCE_EACH_FREE_CQ_WAIT_MSECS	20
 #define HNS_ROCE_MAX_FREE_CQ_WAIT_CNT	\
@@ -87,12 +86,7 @@
 #define HNS_ROCE_V2_QPC_SZ 256
 #define HNS_ROCE_V3_QPC_SZ 512
 
-#define HNS_ROCE_SL_SHIFT			28
-#define HNS_ROCE_TCLASS_SHIFT			20
-#define HNS_ROCE_FLOW_LABEL_MASK		0xfffff
-
 #define HNS_ROCE_MAX_PORTS			6
-#define HNS_ROCE_MAX_GID_NUM			16
 #define HNS_ROCE_GID_SIZE			16
 #define HNS_ROCE_SGE_SIZE			16
 
@@ -120,8 +114,6 @@
 #define PAGES_SHIFT_24				24
 #define PAGES_SHIFT_32				32
 
-#define HNS_ROCE_PCI_BAR_NUM			2
-
 #define HNS_ROCE_IDX_QUE_ENTRY_SZ		4
 #define SRQ_DB_REG				0x230
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 7c3b548..d08e575 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -41,8 +41,6 @@
 #include "hns_roce_hem.h"
 #include <rdma/hns-abi.h>
 
-#define SQP_NUM				(2 * HNS_ROCE_MAX_PORTS)
-
 static void flush_work_handle(struct work_struct *work)
 {
 	struct hns_roce_work *flush_work = container_of(work,
-- 
2.8.1

