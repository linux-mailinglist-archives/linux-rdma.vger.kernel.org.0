Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE121967BA
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2020 17:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgC1QnO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Mar 2020 12:43:14 -0400
Received: from mx.sdf.org ([205.166.94.20]:50272 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgC1QnO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:14 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGh6YT021790
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:06 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGh6eG002694;
        Sat, 28 Mar 2020 16:43:06 GMT
Message-Id: <202003281643.02SGh6eG002694@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Wed, 27 Mar 2019 12:55:00 -0400
Subject: [RFC PATCH v1 01/50] IB/qib: Delete struct qib_ivdev.qp_rnd
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        linux-rdma@vger.kernel.org
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I was checking the field to see if it needed the full
get_random_bytes() and discovered it's unused.

Only compile-tested, as I don't have the hardware, but
I'm still pretty confident.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/hw/qib/qib_verbs.c | 2 --
 drivers/infiniband/hw/qib/qib_verbs.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_verbs.c b/drivers/infiniband/hw/qib/qib_verbs.c
index 5ef93f8f17a19..7508abb6a0fa1 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.c
+++ b/drivers/infiniband/hw/qib/qib_verbs.c
@@ -39,7 +39,6 @@
 #include <linux/utsname.h>
 #include <linux/rculist.h>
 #include <linux/mm.h>
-#include <linux/random.h>
 #include <linux/vmalloc.h>
 #include <rdma/rdma_vt.h>
 
@@ -1503,7 +1502,6 @@ int qib_register_ib_device(struct qib_devdata *dd)
 	unsigned i, ctxt;
 	int ret;
 
-	get_random_bytes(&dev->qp_rnd, sizeof(dev->qp_rnd));
 	for (i = 0; i < dd->num_pports; i++)
 		init_ibport(ppd + i);
 
diff --git a/drivers/infiniband/hw/qib/qib_verbs.h b/drivers/infiniband/hw/qib/qib_verbs.h
index 8bf414b47b96b..dc0e81f3b6f4f 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.h
+++ b/drivers/infiniband/hw/qib/qib_verbs.h
@@ -177,7 +177,6 @@ struct qib_ibdev {
 	struct timer_list mem_timer;
 	struct qib_pio_header *pio_hdrs;
 	dma_addr_t pio_hdrs_phys;
-	u32 qp_rnd; /* random bytes for hash */
 
 	u32 n_piowait;
 	u32 n_txwait;
-- 
2.26.0

