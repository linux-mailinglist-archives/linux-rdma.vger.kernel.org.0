Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9978A59CECC
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Aug 2022 04:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbiHWCxp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Aug 2022 22:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239198AbiHWCxo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Aug 2022 22:53:44 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Aug 2022 19:53:41 PDT
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404F11901E
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 19:53:39 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="85548895"
X-IronPort-AV: E=Sophos;i="5.93,256,1654527600"; 
   d="scan'208";a="85548895"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 23 Aug 2022 11:52:34 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id A84C1D5029
        for <linux-rdma@vger.kernel.org>; Tue, 23 Aug 2022 11:52:33 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (m3003.s.css.fujitsu.com [10.128.233.114])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id F05641079F
        for <linux-rdma@vger.kernel.org>; Tue, 23 Aug 2022 11:52:32 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id D70E32026136;
        Tue, 23 Aug 2022 11:52:32 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     leonro@nvidia.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH] IB/mlx5: Remove duplicate header inclusion related to ODP
Date:   Tue, 23 Aug 2022 02:51:31 +0000
Message-Id: <20220823025131.862811-1-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rdma/ib_umem.h and rdma/ib_verbs.h are included by rdma/ib_umem_odp.h.
This patch removes the redundant entries.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/core/umem_odp.c | 2 --
 drivers/infiniband/hw/mlx5/main.c  | 3 +--
 drivers/infiniband/hw/mlx5/mem.c   | 1 -
 drivers/infiniband/hw/mlx5/mr.c    | 2 --
 drivers/infiniband/hw/mlx5/odp.c   | 1 -
 5 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 186ed8859920..c459c4d011cf 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -43,8 +43,6 @@
 #include <linux/hmm.h>
 #include <linux/pagemap.h>
 
-#include <rdma/ib_verbs.h>
-#include <rdma/ib_umem.h>
 #include <rdma/ib_umem_odp.h>
 
 #include "uverbs.h"
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 7c40efae96a3..e5b5310f6768 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -26,7 +26,7 @@
 #include <linux/mlx5/eswitch.h>
 #include <linux/list.h>
 #include <rdma/ib_smi.h>
-#include <rdma/ib_umem.h>
+#include <rdma/ib_umem_odp.h>
 #include <rdma/lag.h>
 #include <linux/in.h>
 #include <linux/etherdevice.h>
@@ -46,7 +46,6 @@
 #include <rdma/uverbs_ioctl.h>
 #include <rdma/mlx5_user_ioctl_verbs.h>
 #include <rdma/mlx5_user_ioctl_cmds.h>
-#include <rdma/ib_umem_odp.h>
 
 #define UVERBS_MODULE_NAME mlx5_ib
 #include <rdma/uverbs_named_ioctl.h>
diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index 6b29e9ca323e..96ffbbaf0a73 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -30,7 +30,6 @@
  * SOFTWARE.
  */
 
-#include <rdma/ib_umem.h>
 #include <rdma/ib_umem_odp.h>
 #include "mlx5_ib.h"
 #include <linux/jiffies.h>
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 129d531bd01b..bfec9bc3cdd8 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -39,9 +39,7 @@
 #include <linux/delay.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-resv.h>
-#include <rdma/ib_umem.h>
 #include <rdma/ib_umem_odp.h>
-#include <rdma/ib_verbs.h>
 #include "dm.h"
 #include "mlx5_ib.h"
 #include "umr.h"
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 901a8b030236..bc97958818bb 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -30,7 +30,6 @@
  * SOFTWARE.
  */
 
-#include <rdma/ib_umem.h>
 #include <rdma/ib_umem_odp.h>
 #include <linux/kernel.h>
 #include <linux/dma-buf.h>
-- 
2.25.1

