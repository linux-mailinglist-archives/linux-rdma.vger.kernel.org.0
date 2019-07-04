Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C98325F2C9
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2019 08:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfGDG0Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jul 2019 02:26:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34986 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbfGDG0Q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Jul 2019 02:26:16 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E0BC66B07F6697DD95CE;
        Thu,  4 Jul 2019 14:26:13 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Thu, 4 Jul 2019 14:26:03 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Bugfix for hns Makefile
Date:   Thu, 4 Jul 2019 14:22:58 +0800
Message-ID: <1562221378-73312-1-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here has a bug for hns Makefile and will lead to a build error
when use allmodconfig to build hns driver.

The build log as follows:
After merging the rdma tree, today's linux-next build (x86_64
allmodconfig) failed like this:

WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_ah.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_alloc.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_cmd.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_cq.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_db.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_hem.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_mr.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_pd.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_qp.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_restrack.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_srq.o
see include/linux/module.h for more information
ERROR: "hns_roce_bitmap_cleanup" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
ERROR: "hns_roce_bitmap_init" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
ERROR: "hns_roce_free_cmd_mailbox" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
ERROR: "hns_roce_alloc_cmd_mailbox" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
ERROR: "hns_roce_table_get" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
ERROR: "hns_roce_bitmap_alloc" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
ERROR: "hns_roce_table_find" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!

Fixes: e9816ddf2a33 ("RDMA/hns: Cleanup unnecessary exported symbols")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/Makefile b/drivers/infiniband/hw/hns/Makefile
index b956cf4..b06125f 100644
--- a/drivers/infiniband/hw/hns/Makefile
+++ b/drivers/infiniband/hw/hns/Makefile
@@ -9,8 +9,8 @@ hns-roce-objs := hns_roce_main.o hns_roce_cmd.o hns_roce_pd.o \
 	hns_roce_cq.o hns_roce_alloc.o hns_roce_db.o hns_roce_srq.o hns_roce_restrack.o
 
 ifdef CONFIG_INFINIBAND_HNS_HIP06
-hns-roce-hw-v1-objs := hns_roce_hw_v1.o
-obj-$(CONFIG_INFINIBAND_HNS) += hns-roce-hw-v1.o $(hns-roce-objs)
+hns-roce-hw-v1-objs := hns_roce_hw_v1.o $(hns-roce-objs)
+obj-$(CONFIG_INFINIBAND_HNS) += hns-roce-hw-v1.o
 endif
 
 ifdef CONFIG_INFINIBAND_HNS_HIP08
-- 
1.9.1

