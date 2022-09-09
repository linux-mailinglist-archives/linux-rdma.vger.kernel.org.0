Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6245B3425
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Sep 2022 11:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiIIJio (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Sep 2022 05:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiIIJia (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Sep 2022 05:38:30 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FB99A9D0
        for <linux-rdma@vger.kernel.org>; Fri,  9 Sep 2022 02:38:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VP8mhQT_1662716305;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VP8mhQT_1662716305)
          by smtp.aliyun-inc.com;
          Fri, 09 Sep 2022 17:38:25 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 2/4] RDMA/erdma: Remove redundant includes
Date:   Fri,  9 Sep 2022 17:38:20 +0800
Message-Id: <20220909093822.33868-3-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220909093822.33868-1-chengyou@linux.alibaba.com>
References: <20220909093822.33868-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Many of erdma's includes are redundant, because they are already included
indirectly by kernel headers or custom headers. So we remove all the
unnecessary direct-includes. Besides, add linux/pci.h to erdma.h because
it's also used in the file.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma.h       | 1 +
 drivers/infiniband/hw/erdma/erdma_cm.c    | 8 --------
 drivers/infiniband/hw/erdma/erdma_cmdq.c  | 6 ------
 drivers/infiniband/hw/erdma/erdma_cq.c    | 3 ---
 drivers/infiniband/hw/erdma/erdma_eq.c    | 6 ------
 drivers/infiniband/hw/erdma/erdma_main.c  | 9 ---------
 drivers/infiniband/hw/erdma/erdma_qp.c    | 9 ---------
 drivers/infiniband/hw/erdma/erdma_verbs.c | 7 -------
 drivers/infiniband/hw/erdma/erdma_verbs.h | 8 --------
 9 files changed, 1 insertion(+), 56 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
index 07bcd688fdb7..cc5e4eb3a21e 100644
--- a/drivers/infiniband/hw/erdma/erdma.h
+++ b/drivers/infiniband/hw/erdma/erdma.h
@@ -9,6 +9,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/netdevice.h>
+#include <linux/pci.h>
 #include <linux/xarray.h>
 #include <rdma/ib_verbs.h>
 
diff --git a/drivers/infiniband/hw/erdma/erdma_cm.c b/drivers/infiniband/hw/erdma/erdma_cm.c
index f13f16479eca..74f6348f240a 100644
--- a/drivers/infiniband/hw/erdma/erdma_cm.c
+++ b/drivers/infiniband/hw/erdma/erdma_cm.c
@@ -10,15 +10,7 @@
 /* Copyright (c) 2008-2019, IBM Corporation */
 /* Copyright (c) 2017, Open Grid Computing, Inc. */
 
-#include <linux/errno.h>
-#include <linux/inetdevice.h>
-#include <linux/net.h>
-#include <linux/types.h>
 #include <linux/workqueue.h>
-#include <net/addrconf.h>
-
-#include <rdma/ib_user_verbs.h>
-#include <rdma/ib_verbs.h>
 
 #include "erdma.h"
 #include "erdma_cm.h"
diff --git a/drivers/infiniband/hw/erdma/erdma_cmdq.c b/drivers/infiniband/hw/erdma/erdma_cmdq.c
index c8f93dc11449..6ebfa6989b11 100644
--- a/drivers/infiniband/hw/erdma/erdma_cmdq.c
+++ b/drivers/infiniband/hw/erdma/erdma_cmdq.c
@@ -4,13 +4,7 @@
 /*          Kai Shen <kaishen@linux.alibaba.com> */
 /* Copyright (c) 2020-2022, Alibaba Group. */
 
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/types.h>
-
 #include "erdma.h"
-#include "erdma_hw.h"
-#include "erdma_verbs.h"
 
 static void arm_cmdq_cq(struct erdma_cmdq *cmdq)
 {
diff --git a/drivers/infiniband/hw/erdma/erdma_cq.c b/drivers/infiniband/hw/erdma/erdma_cq.c
index 751c7f9f0de7..2f7390de35d7 100644
--- a/drivers/infiniband/hw/erdma/erdma_cq.c
+++ b/drivers/infiniband/hw/erdma/erdma_cq.c
@@ -4,9 +4,6 @@
 /*          Kai Shen <kaishen@linux.alibaba.com> */
 /* Copyright (c) 2020-2022, Alibaba Group. */
 
-#include <rdma/ib_verbs.h>
-
-#include "erdma_hw.h"
 #include "erdma_verbs.h"
 
 static void *get_next_valid_cqe(struct erdma_cq *cq)
diff --git a/drivers/infiniband/hw/erdma/erdma_eq.c b/drivers/infiniband/hw/erdma/erdma_eq.c
index 09ddedb5c1b5..ed54130d924b 100644
--- a/drivers/infiniband/hw/erdma/erdma_eq.c
+++ b/drivers/infiniband/hw/erdma/erdma_eq.c
@@ -4,12 +4,6 @@
 /*          Kai Shen <kaishen@linux.alibaba.com> */
 /* Copyright (c) 2020-2022, Alibaba Group. */
 
-#include <linux/errno.h>
-#include <linux/pci.h>
-#include <linux/types.h>
-
-#include "erdma.h"
-#include "erdma_hw.h"
 #include "erdma_verbs.h"
 
 #define MAX_POLL_CHUNK_SIZE 16
diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 07e743d24847..6d3e02ba9e77 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -4,21 +4,12 @@
 /*          Kai Shen <kaishen@linux.alibaba.com> */
 /* Copyright (c) 2020-2022, Alibaba Group. */
 
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
 #include <linux/module.h>
-#include <linux/netdevice.h>
-#include <linux/pci.h>
 #include <net/addrconf.h>
 #include <rdma/erdma-abi.h>
-#include <rdma/ib_verbs.h>
-#include <rdma/ib_user_verbs.h>
 
 #include "erdma.h"
 #include "erdma_cm.h"
-#include "erdma_hw.h"
 #include "erdma_verbs.h"
 
 MODULE_AUTHOR("Cheng Xu <chengyou@linux.alibaba.com>");
diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
index 60f898ccc4e4..5fe1a339a435 100644
--- a/drivers/infiniband/hw/erdma/erdma_qp.c
+++ b/drivers/infiniband/hw/erdma/erdma_qp.c
@@ -6,15 +6,6 @@
 /* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
 /* Copyright (c) 2008-2019, IBM Corporation */
 
-#include <linux/errno.h>
-#include <linux/pci.h>
-#include <linux/scatterlist.h>
-#include <linux/types.h>
-
-#include <rdma/ib_user_verbs.h>
-#include <rdma/ib_verbs.h>
-
-#include "erdma.h"
 #include "erdma_cm.h"
 #include "erdma_verbs.h"
 
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index d04b90549cd6..aea93d08af95 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -9,21 +9,14 @@
 
 /* Copyright (c) 2013-2015, Mellanox Technologies. All rights reserved. */
 
-#include <linux/errno.h>
-#include <linux/pci.h>
-#include <linux/types.h>
-#include <linux/uaccess.h>
 #include <linux/vmalloc.h>
 #include <net/addrconf.h>
 #include <rdma/erdma-abi.h>
 #include <rdma/ib_umem.h>
-#include <rdma/ib_user_verbs.h>
-#include <rdma/ib_verbs.h>
 #include <rdma/uverbs_ioctl.h>
 
 #include "erdma.h"
 #include "erdma_cm.h"
-#include "erdma_hw.h"
 #include "erdma_verbs.h"
 
 static int create_qp_cmd(struct erdma_dev *dev, struct erdma_qp *qp)
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index c7baddb1f292..fe93e1ac9674 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -7,15 +7,7 @@
 #ifndef __ERDMA_VERBS_H__
 #define __ERDMA_VERBS_H__
 
-#include <linux/errno.h>
-
-#include <rdma/ib_verbs.h>
-#include <rdma/ib_user_verbs.h>
-#include <rdma/iw_cm.h>
-
 #include "erdma.h"
-#include "erdma_cm.h"
-#include "erdma_hw.h"
 
 /* RDMA Capability. */
 #define ERDMA_MAX_PD (128 * 1024)
-- 
2.27.0

