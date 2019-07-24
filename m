Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26E69728AF
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2019 08:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfGXGzq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jul 2019 02:55:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60428 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725870AbfGXGzq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Jul 2019 02:55:46 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B64D5D0066629F36656E;
        Wed, 24 Jul 2019 14:55:03 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Jul 2019
 14:54:54 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <oulijun@huawei.com>, <xavier.huwei@huawei.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] RDMA/hns: Fix build error
Date:   Wed, 24 Jul 2019 14:54:43 +0800
Message-ID: <20190724065443.53068-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190723024908.11876-1-yuehaibing@huawei.com>
References: <20190723024908.11876-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If INFINIBAND_HNS_HIP08 is selected and HNS3 is m,
but INFINIBAND_HNS is y, building fails:

drivers/infiniband/hw/hns/hns_roce_hw_v2.o: In function `hns_roce_hw_v2_exit':
hns_roce_hw_v2.c:(.exit.text+0xd): undefined reference to `hnae3_unregister_client'
drivers/infiniband/hw/hns/hns_roce_hw_v2.o: In function `hns_roce_hw_v2_init':
hns_roce_hw_v2.c:(.init.text+0xd): undefined reference to `hnae3_register_client'

Also if INFINIBAND_HNS_HIP06 is selected and HNS_DSAF
is m, but INFINIBAND_HNS is y, building fails:

drivers/infiniband/hw/hns/hns_roce_hw_v1.o: In function `hns_roce_v1_reset':
hns_roce_hw_v1.c:(.text+0x39fa): undefined reference to `hns_dsaf_roce_reset'
hns_roce_hw_v1.c:(.text+0x3a25): undefined reference to `hns_dsaf_roce_reset'

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: dd74282df573 ("RDMA/hns: Initialize the PCI device for hip08 RoCE")
Fixes: 08805fdbeb2d ("RDMA/hns: Split hw v1 driver from hns roce driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/hns/Kconfig  | 6 +++---
 drivers/infiniband/hw/hns/Makefile | 8 ++------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/hns/Kconfig b/drivers/infiniband/hw/hns/Kconfig
index 8bf847b..5478219 100644
--- a/drivers/infiniband/hw/hns/Kconfig
+++ b/drivers/infiniband/hw/hns/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config INFINIBAND_HNS
-	tristate "HNS RoCE Driver"
+	bool "HNS RoCE Driver"
 	depends on NET_VENDOR_HISILICON
 	depends on ARM64 || (COMPILE_TEST && 64BIT)
 	---help---
@@ -11,7 +11,7 @@ config INFINIBAND_HNS
 	  To compile HIP06 or HIP08 driver as module, choose M here.
 
 config INFINIBAND_HNS_HIP06
-	bool "Hisilicon Hip06 Family RoCE support"
+	tristate "Hisilicon Hip06 Family RoCE support"
 	depends on INFINIBAND_HNS && HNS && HNS_DSAF && HNS_ENET
 	---help---
 	  RoCE driver support for Hisilicon RoCE engine in Hisilicon Hip06 and
@@ -21,7 +21,7 @@ config INFINIBAND_HNS_HIP06
 	  module will be called hns-roce-hw-v1
 
 config INFINIBAND_HNS_HIP08
-	bool "Hisilicon Hip08 Family RoCE support"
+	tristate "Hisilicon Hip08 Family RoCE support"
 	depends on INFINIBAND_HNS && PCI && HNS3
 	---help---
 	  RoCE driver support for Hisilicon RoCE engine in Hisilicon Hip08 SoC.
diff --git a/drivers/infiniband/hw/hns/Makefile b/drivers/infiniband/hw/hns/Makefile
index e105945..449a2d8 100644
--- a/drivers/infiniband/hw/hns/Makefile
+++ b/drivers/infiniband/hw/hns/Makefile
@@ -9,12 +9,8 @@ hns-roce-objs := hns_roce_main.o hns_roce_cmd.o hns_roce_pd.o \
 	hns_roce_ah.o hns_roce_hem.o hns_roce_mr.o hns_roce_qp.o \
 	hns_roce_cq.o hns_roce_alloc.o hns_roce_db.o hns_roce_srq.o hns_roce_restrack.o
 
-ifdef CONFIG_INFINIBAND_HNS_HIP06
 hns-roce-hw-v1-objs := hns_roce_hw_v1.o $(hns-roce-objs)
-obj-$(CONFIG_INFINIBAND_HNS) += hns-roce-hw-v1.o
-endif
+obj-$(CONFIG_INFINIBAND_HNS_HIP06) += hns-roce-hw-v1.o
 
-ifdef CONFIG_INFINIBAND_HNS_HIP08
 hns-roce-hw-v2-objs := hns_roce_hw_v2.o hns_roce_hw_v2_dfx.o $(hns-roce-objs)
-obj-$(CONFIG_INFINIBAND_HNS) += hns-roce-hw-v2.o
-endif
+obj-$(CONFIG_INFINIBAND_HNS_HIP08) += hns-roce-hw-v2.o
-- 
2.7.4


