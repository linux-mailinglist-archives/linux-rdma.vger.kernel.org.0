Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC704D7AFB
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Mar 2022 07:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbiCNGtP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Mar 2022 02:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236479AbiCNGtM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Mar 2022 02:49:12 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43F21403B
        for <linux-rdma@vger.kernel.org>; Sun, 13 Mar 2022 23:47:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V74XxKZ_1647240475;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V74XxKZ_1647240475)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 14 Mar 2022 14:47:55 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, chengyou@linux.alibaba.com,
        tonylu@linux.alibaba.com, BMT@zurich.ibm.com
Subject: [PATCH for-next v4 12/12] RDMA/erdma: Add driver to kernel build environment
Date:   Mon, 14 Mar 2022 14:47:39 +0800
Message-Id: <20220314064739.81647-13-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220314064739.81647-1-chengyou@linux.alibaba.com>
References: <20220314064739.81647-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 MAINTAINERS                          |  8 ++++++++
 drivers/infiniband/Kconfig           |  1 +
 drivers/infiniband/hw/Makefile       |  1 +
 drivers/infiniband/hw/erdma/Kconfig  | 10 ++++++++++
 drivers/infiniband/hw/erdma/Makefile |  4 ++++
 5 files changed, 24 insertions(+)
 create mode 100644 drivers/infiniband/hw/erdma/Kconfig
 create mode 100644 drivers/infiniband/hw/erdma/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..6beb3019764d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -723,6 +723,14 @@ S:	Maintained
 F:	Documentation/i2c/busses/i2c-ali1563.rst
 F:	drivers/i2c/busses/i2c-ali1563.c
 
+ALIBABA ELASTIC RDMA DRIVER
+M:	Cheng Xu <chengyou@linux.alibaba.com>
+M:	Kai Shen <kaishen@linux.alibaba.com>
+L:	linux-rdma@vger.kernel.org
+S:	Supported
+F:	drivers/infiniband/hw/erdma
+F:	include/uapi/rdma/erdma-abi.h
+
 ALIENWARE WMI DRIVER
 L:	Dell.Client.Kernel@dell.com
 S:	Maintained
diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index 33d3ce9c888e..cc6a7ff88ff3 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -92,6 +92,7 @@ source "drivers/infiniband/hw/hns/Kconfig"
 source "drivers/infiniband/hw/bnxt_re/Kconfig"
 source "drivers/infiniband/hw/hfi1/Kconfig"
 source "drivers/infiniband/hw/qedr/Kconfig"
+source "drivers/infiniband/hw/erdma/Kconfig"
 source "drivers/infiniband/sw/rdmavt/Kconfig"
 source "drivers/infiniband/sw/rxe/Kconfig"
 source "drivers/infiniband/sw/siw/Kconfig"
diff --git a/drivers/infiniband/hw/Makefile b/drivers/infiniband/hw/Makefile
index fba0b3be903e..6b3a88046125 100644
--- a/drivers/infiniband/hw/Makefile
+++ b/drivers/infiniband/hw/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_INFINIBAND_HFI1)		+= hfi1/
 obj-$(CONFIG_INFINIBAND_HNS)		+= hns/
 obj-$(CONFIG_INFINIBAND_QEDR)		+= qedr/
 obj-$(CONFIG_INFINIBAND_BNXT_RE)	+= bnxt_re/
+obj-$(CONFIG_INFINIBAND_ERDMA)		+= erdma/
diff --git a/drivers/infiniband/hw/erdma/Kconfig b/drivers/infiniband/hw/erdma/Kconfig
new file mode 100644
index 000000000000..8526689fede7
--- /dev/null
+++ b/drivers/infiniband/hw/erdma/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config INFINIBAND_ERDMA
+	tristate "Alibaba Elastic RDMA Adapter (ERDMA) support"
+	depends on PCI_MSI && 64BIT && !CPU_BIG_ENDIAN
+	depends on INFINIBAND_ADDR_TRANS
+	depends on INFINIBAND_USER_ACCESS
+	help
+	  This is a RDMA/iWarp driver for Alibaba Elastic RDMA Adapter(ERDMA).
+
+	  To compile this driver as module, choose M here.
diff --git a/drivers/infiniband/hw/erdma/Makefile b/drivers/infiniband/hw/erdma/Makefile
new file mode 100644
index 000000000000..51d2ef91905a
--- /dev/null
+++ b/drivers/infiniband/hw/erdma/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_INFINIBAND_ERDMA) := erdma.o
+
+erdma-y := erdma_cm.o erdma_main.o erdma_cmdq.o erdma_cq.o erdma_verbs.o erdma_qp.o erdma_eq.o
-- 
2.27.0

