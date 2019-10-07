Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F068FCEE53
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2019 23:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfJGVSz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Oct 2019 17:18:55 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:57431 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbfJGVSx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Oct 2019 17:18:53 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N0qmr-1hwMca18BJ-00wmyc; Mon, 07 Oct 2019 23:18:29 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Shaobo Xu <xushaobo2@huawei.com>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Xi Wang <wangxi11@huawei.com>, Tao Tian <tiantao6@huawei.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/hns: Fix build error again
Date:   Mon,  7 Oct 2019 23:18:08 +0200
Message-Id: <20191007211826.3361202-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EWiNtZuGapRE+xX1PdtaFNnMOeHZZ8DNLe6GyszUnhUPAIMsWRd
 +7JZjySSe+lzQIBYcSqcZYMF0teNr+S0b0Bgw0gu8IBq7zI59qfH6MgaBuuxq3frVb9o+Ud
 OhevsJQQSGs6rJWEgNS+GrJcGjNLj+w5RuUAI0zjTduNkbJac6a7x5qZTOSDQtCUNF0SktU
 8rHgKAQ7GcQWdyE6Mdlvg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LG5/IVF1Aus=:dEwU4fUmO4LXKB528E/eiF
 azbIpFIGe8I8qZqUKzVBpHVDKlsT6ZGX1TDE955icdCig9ES/mRViuK7BRrwe4qWCIrvVekvE
 juFv3PJ/xY8Qy9YccE+2Yn4P7ZWnG0Dy6DU6+FFPxQBkenEU0T4a7E7rk/02knOMuT2uVFqu+
 sRiJTLmZJESoI/4ngWv9fgd0zo5cxjfEKJIBjj19n69cjYge3Bpdsw85K00bG6+HATlZaQ3tf
 W3Wljb9cZN4fjN6o8lnGMESAvSs0LsP28hlEIZwSGFhHquVn+K0hpcO9BlL6f4mDmo58hRgcE
 rfaNNrQ3lbGSgX0YqZtwmS2r2otOjZa2emKDTCAXuNnXFVVSvHXDYuXnSNf5MHPRNxkVN/J17
 SZYsKZjADPBVVO+r4QzrbJjDkpLzgexVT7FPbnGx0c9Ud8SsYVehRRySvOBBFgHwPFTV4YoDW
 QDd6K9eETIiple3I0bNuHKg7OLaEphVClc9HuwY6/QeMMIwnrU9SH15miNJJNxQIGpFos/nRj
 7BzUvZVLjrYHz3PfOzfXb1vVIKA9Jz9gFIAXXWC5FavFgv+JQmGVnqXzQb2CEJI4XrBPXmLov
 neoEmIxyG+hUzRBnviXQNJOdHVA2A8jrExddQ816tC9D4O8q3jUzdpGceZyv25CnNCeCFEnRG
 EUZS59Nzi9+DsFFGWNEdbN+bGVeqjLJAGek/tsUw/X2E6/yQEywbcRO3zv3TrmQ1XiUy69gXH
 jxlOJEI4mNIpmzOteoztMa5zgRQeJdZsHtKyuwbEjT675mZsZL48djD2BpJM0v2UfBL8YqNKZ
 GwEyfmaEpL7wy89De/LFHEc2Iz7Q7SvgmgDhhCN45BfuWN7sFKcnFOp5fHli8MZYwWsgcBXvR
 81Mty/DSXVJgZk3RhOEQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is not the first attempt to fix building random configurations,
unfortunately the attempt in commit a07fc0bb483e ("RDMA/hns: Fix build
error") caused a new problem when CONFIG_INFINIBAND_HNS_HIP06=m
and CONFIG_INFINIBAND_HNS_HIP08=y:

drivers/infiniband/hw/hns/hns_roce_main.o:(.rodata+0xe60): undefined reference to `__this_module'

Revert commits a07fc0bb483e ("RDMA/hns: Fix build error") and
a3e2d4c7e766 ("RDMA/hns: remove obsolete Kconfig comment") to get
back to the previous state, then fix the issues described there
differently, by adding more specific dependencies: INFINIBAND_HNS
can now only be built-in if at least one of HNS or HNS3 are
built-in, and the individual back-ends are only available if
that code is reachable from the main driver.

Fixes: a07fc0bb483e ("RDMA/hns: Fix build error")
Fixes: a3e2d4c7e766 ("RDMA/hns: remove obsolete Kconfig comment")
Fixes: dd74282df573 ("RDMA/hns: Initialize the PCI device for hip08 RoCE")
Fixes: 08805fdbeb2d ("RDMA/hns: Split hw v1 driver from hns roce driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/hw/hns/Kconfig  | 17 ++++++++++++++---
 drivers/infiniband/hw/hns/Makefile |  8 ++++++--
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/Kconfig b/drivers/infiniband/hw/hns/Kconfig
index d602b698b57e..4921c1e40ccd 100644
--- a/drivers/infiniband/hw/hns/Kconfig
+++ b/drivers/infiniband/hw/hns/Kconfig
@@ -1,23 +1,34 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config INFINIBAND_HNS
-	bool "HNS RoCE Driver"
+	tristate "HNS RoCE Driver"
 	depends on NET_VENDOR_HISILICON
 	depends on ARM64 || (COMPILE_TEST && 64BIT)
+	depends on (HNS_DSAF && HNS_ENET) || HNS3
 	---help---
 	  This is a RoCE/RDMA driver for the Hisilicon RoCE engine. The engine
 	  is used in Hisilicon Hip06 and more further ICT SoC based on
 	  platform device.
 
+	  To compile HIP06 or HIP08 driver as module, choose M here.
+
 config INFINIBAND_HNS_HIP06
-	tristate "Hisilicon Hip06 Family RoCE support"
+	bool "Hisilicon Hip06 Family RoCE support"
 	depends on INFINIBAND_HNS && HNS && HNS_DSAF && HNS_ENET
+	depends on INFINIBAND_HNS=m || (HNS_DSAF=y && HNS_ENET=y)
 	---help---
 	  RoCE driver support for Hisilicon RoCE engine in Hisilicon Hip06 and
 	  Hip07 SoC. These RoCE engines are platform devices.
 
+	  To compile this driver, choose Y here: if INFINIBAND_HNS is m, this
+	  module will be called hns-roce-hw-v1
+
 config INFINIBAND_HNS_HIP08
-	tristate "Hisilicon Hip08 Family RoCE support"
+	bool "Hisilicon Hip08 Family RoCE support"
 	depends on INFINIBAND_HNS && PCI && HNS3
+	depends on INFINIBAND_HNS=m || HNS3=y
 	---help---
 	  RoCE driver support for Hisilicon RoCE engine in Hisilicon Hip08 SoC.
 	  The RoCE engine is a PCI device.
+
+	  To compile this driver, choose Y here: if INFINIBAND_HNS is m, this
+	  module will be called hns-roce-hw-v2.
diff --git a/drivers/infiniband/hw/hns/Makefile b/drivers/infiniband/hw/hns/Makefile
index 449a2d81319d..e105945b94a1 100644
--- a/drivers/infiniband/hw/hns/Makefile
+++ b/drivers/infiniband/hw/hns/Makefile
@@ -9,8 +9,12 @@ hns-roce-objs := hns_roce_main.o hns_roce_cmd.o hns_roce_pd.o \
 	hns_roce_ah.o hns_roce_hem.o hns_roce_mr.o hns_roce_qp.o \
 	hns_roce_cq.o hns_roce_alloc.o hns_roce_db.o hns_roce_srq.o hns_roce_restrack.o
 
+ifdef CONFIG_INFINIBAND_HNS_HIP06
 hns-roce-hw-v1-objs := hns_roce_hw_v1.o $(hns-roce-objs)
-obj-$(CONFIG_INFINIBAND_HNS_HIP06) += hns-roce-hw-v1.o
+obj-$(CONFIG_INFINIBAND_HNS) += hns-roce-hw-v1.o
+endif
 
+ifdef CONFIG_INFINIBAND_HNS_HIP08
 hns-roce-hw-v2-objs := hns_roce_hw_v2.o hns_roce_hw_v2_dfx.o $(hns-roce-objs)
-obj-$(CONFIG_INFINIBAND_HNS_HIP08) += hns-roce-hw-v2.o
+obj-$(CONFIG_INFINIBAND_HNS) += hns-roce-hw-v2.o
+endif
-- 
2.20.0

