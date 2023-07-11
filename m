Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F34874F78E
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jul 2023 19:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjGKRxS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jul 2023 13:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjGKRxR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jul 2023 13:53:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2714E55
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jul 2023 10:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689097996; x=1720633996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UCMTpmw21y3uzOlGpdf3BM0hksxK2jGdaP/9qtBBAE0=;
  b=eCoM/6YBin7A1S8nNyz/IwMBnNHcX97SPhQ8t0xVZvy3iMjsV9d2m45e
   B8IS9YX6gQ+SwK2uFQTrPWkulPkSCNztBMTwxTQersTTq1N1NB6W4ZPet
   YUPYg8shwb7LP4w9BlPLpHJ7M8liiDT4/2vJ3sYVJyGPYi3+Iz3pAC1Cr
   A9A77rtu7t8ygN5lo14QGSOu5Mni+gQ82XxBIAH1so5rfgsjqRK80wy+G
   HGcjSRAgrZdsG4jSb1OxD9+MeZIiejxzhWlz7tT4XqABuobd9UhbmEeGq
   DxY2w1ggq6EjhM+QmigcrBF9nMi1r+M+CTY7sX51RitslDcRG2+c8E8c9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="395482614"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="395482614"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:53:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="724542505"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="724542505"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.92.33.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:53:08 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 3/3] RDMA/irdma: Fix data race on CQP request done
Date:   Tue, 11 Jul 2023 12:52:53 -0500
Message-Id: <20230711175253.1289-4-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230711175253.1289-1-shiraz.saleem@intel.com>
References: <20230711175253.1289-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

KCSAN detects a data race on cqp_request->request_done memory location
which is accessed locklessly in irdma_handle_cqp_op while being
updated in irdma_cqp_ce_handler.

Annotate lockless intent with READ_ONCE/WRITE_ONCE to avoid any
compiler optimizations like load fusing and/or KCSAN warning.

[222808.417128] BUG: KCSAN: data-race in irdma_cqp_ce_handler [irdma] / irdma_wait_event [irdma]

[222808.417532] write to 0xffff8e44107019dc of 1 bytes by task 29658 on cpu 5:
[222808.417610]  irdma_cqp_ce_handler+0x21e/0x270 [irdma]
[222808.417725]  cqp_compl_worker+0x1b/0x20 [irdma]
[222808.417827]  process_one_work+0x4d1/0xa40
[222808.417835]  worker_thread+0x319/0x700
[222808.417842]  kthread+0x180/0x1b0
[222808.417852]  ret_from_fork+0x22/0x30

[222808.417918] read to 0xffff8e44107019dc of 1 bytes by task 29688 on cpu 1:
[222808.417995]  irdma_wait_event+0x1e2/0x2c0 [irdma]
[222808.418099]  irdma_handle_cqp_op+0xae/0x170 [irdma]
[222808.418202]  irdma_cqp_cq_destroy_cmd+0x70/0x90 [irdma]
[222808.418308]  irdma_puda_dele_rsrc+0x46d/0x4d0 [irdma]
[222808.418411]  irdma_rt_deinit_hw+0x179/0x1d0 [irdma]
[222808.418514]  irdma_ib_dealloc_device+0x11/0x40 [irdma]
[222808.418618]  ib_dealloc_device+0x2a/0x120 [ib_core]
[222808.418823]  __ib_unregister_device+0xde/0x100 [ib_core]
[222808.418981]  ib_unregister_device+0x22/0x40 [ib_core]
[222808.419142]  irdma_ib_unregister_device+0x70/0x90 [irdma]
[222808.419248]  i40iw_close+0x6f/0xc0 [irdma]
[222808.419352]  i40e_client_device_unregister+0x14a/0x180 [i40e]
[222808.419450]  i40iw_remove+0x21/0x30 [irdma]
[222808.419554]  auxiliary_bus_remove+0x31/0x50
[222808.419563]  device_remove+0x69/0xb0
[222808.419572]  device_release_driver_internal+0x293/0x360
[222808.419582]  driver_detach+0x7c/0xf0
[222808.419592]  bus_remove_driver+0x8c/0x150
[222808.419600]  driver_unregister+0x45/0x70
[222808.419610]  auxiliary_driver_unregister+0x16/0x30
[222808.419618]  irdma_exit_module+0x18/0x1e [irdma]
[222808.419733]  __do_sys_delete_module.constprop.0+0x1e2/0x310
[222808.419745]  __x64_sys_delete_module+0x1b/0x30
[222808.419755]  do_syscall_64+0x39/0x90
[222808.419763]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

[222808.419829] value changed: 0x01 -> 0x03

Fixes: 915cc7ac0f8 ("RDMA/irdma: Add miscellaneous utility definitions")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/hw.c    | 2 +-
 drivers/infiniband/hw/irdma/main.h  | 2 +-
 drivers/infiniband/hw/irdma/utils.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 795f7fd..1cfc03d 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -2075,7 +2075,7 @@ void irdma_cqp_ce_handler(struct irdma_pci_f *rf, struct irdma_sc_cq *cq)
 			cqp_request->compl_info.error = info.error;
 
 			if (cqp_request->waiting) {
-				cqp_request->request_done = true;
+				WRITE_ONCE(cqp_request->request_done, true);
 				wake_up(&cqp_request->waitq);
 				irdma_put_cqp_request(&rf->cqp, cqp_request);
 			} else {
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index def6dd5..2323962 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -161,8 +161,8 @@ struct irdma_cqp_request {
 	void (*callback_fcn)(struct irdma_cqp_request *cqp_request);
 	void *param;
 	struct irdma_cqp_compl_info compl_info;
+	bool request_done; /* READ/WRITE_ONCE macros operate on it */
 	bool waiting:1;
-	bool request_done:1;
 	bool dynamic:1;
 };
 
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 775a799..eb083f7 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -481,7 +481,7 @@ void irdma_free_cqp_request(struct irdma_cqp *cqp,
 	if (cqp_request->dynamic) {
 		kfree(cqp_request);
 	} else {
-		cqp_request->request_done = false;
+		WRITE_ONCE(cqp_request->request_done, false);
 		cqp_request->callback_fcn = NULL;
 		cqp_request->waiting = false;
 
@@ -515,7 +515,7 @@ void irdma_put_cqp_request(struct irdma_cqp *cqp,
 {
 	if (cqp_request->waiting) {
 		cqp_request->compl_info.error = true;
-		cqp_request->request_done = true;
+		WRITE_ONCE(cqp_request->request_done, true);
 		wake_up(&cqp_request->waitq);
 	}
 	wait_event_timeout(cqp->remove_wq,
@@ -571,7 +571,7 @@ static int irdma_wait_event(struct irdma_pci_f *rf,
 	do {
 		irdma_cqp_ce_handler(rf, &rf->ccq.sc_cq);
 		if (wait_event_timeout(cqp_request->waitq,
-				       cqp_request->request_done,
+				       READ_ONCE(cqp_request->request_done),
 				       msecs_to_jiffies(CQP_COMPL_WAIT_TIME_MS)))
 			break;
 
-- 
1.8.3.1

