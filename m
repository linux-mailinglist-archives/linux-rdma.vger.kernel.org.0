Return-Path: <linux-rdma+bounces-162-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDD47FEAAF
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Nov 2023 09:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15471C20C09
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Nov 2023 08:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FF220DE6;
	Thu, 30 Nov 2023 08:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-rdma@vger.kernel.org
X-Greylist: delayed 598 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Nov 2023 00:31:55 PST
Received: from mail-m17209.xmail.ntesmail.com (mail-m17209.xmail.ntesmail.com [45.195.17.209])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1F7198E;
	Thu, 30 Nov 2023 00:31:55 -0800 (PST)
Received: from ubuntu.localdomain (unknown [111.222.250.119])
	by mail-m12750.qiye.163.com (Hmail) with ESMTPA id C1E3FF2061A;
	Thu, 30 Nov 2023 16:14:19 +0800 (CST)
From: Shifeng Li <lishifeng@sangfor.com.cn>
To: mustafa.ismail@intel.com,
	shiraz.saleem@intel.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	gustavoars@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	dinghui@sangfor.com.cn,
	lishifeng1992@126.com,
	Shifeng Li <lishifeng@sangfor.com.cn>
Subject: [PATCH v2] RDMA/irdma: Avoid free the non-cqp_request scratch
Date: Thu, 30 Nov 2023 00:14:15 -0800
Message-Id: <20231130081415.891006-1-lishifeng@sangfor.com.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQ09JVkwfSkpCTUNIGEkfS1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKSlVJSUlVSU5LVUpKQllXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8c1f4b0834b21dkuuuc1e3ff2061a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NQw6DQw4DjwrKBA5Mh0aKjNI
	SgxPCk5VSlVKTEtKSEhJS01KSk9PVTMWGhIXVRcSCBMSHR4VHDsIGhUcHRQJVRgUFlUYFUVZV1kS
	C1lBWUpKSlVJSUlVSU5LVUpKQllXWQgBWUFPTEJINwY+

When creating ceq_0 during probing irdma, cqp.sc_cqp will be sent as
a cqp_request to cqp->sc_cqp.sq_ring. If the request is pending when
removing the irdma driver or unplugging its aux device, cqp.sc_cqp
will be dereferenced as wrong struct in irdma_free_pending_cqp_request().

crash> bt 3669
PID: 3669   TASK: ffff88aef892c000  CPU: 28  COMMAND: "kworker/28:0"
 #0 [fffffe0000549e38] crash_nmi_callback at ffffffff810e3a34
 #1 [fffffe0000549e40] nmi_handle at ffffffff810788b2
 #2 [fffffe0000549ea0] default_do_nmi at ffffffff8107938f
 #3 [fffffe0000549eb8] do_nmi at ffffffff81079582
 #4 [fffffe0000549ef0] end_repeat_nmi at ffffffff82e016b4
    [exception RIP: native_queued_spin_lock_slowpath+1291]
    RIP: ffffffff8127e72b  RSP: ffff88aa841ef778  RFLAGS: 00000046
    RAX: 0000000000000000  RBX: ffff88b01f849700  RCX: ffffffff8127e47e
    RDX: 0000000000000000  RSI: 0000000000000004  RDI: ffffffff83857ec0
    RBP: ffff88afe3e4efc8   R8: ffffed15fc7c9dfa   R9: ffffed15fc7c9dfa
    R10: 0000000000000001  R11: ffffed15fc7c9df9  R12: 0000000000740000
    R13: ffff88b01f849708  R14: 0000000000000003  R15: ffffed1603f092e1
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
--- <NMI exception stack> ---
 #5 [ffff88aa841ef778] native_queued_spin_lock_slowpath at ffffffff8127e72b
 #6 [ffff88aa841ef7b0] _raw_spin_lock_irqsave at ffffffff82c22aa4
 #7 [ffff88aa841ef7c8] __wake_up_common_lock at ffffffff81257363
 #8 [ffff88aa841ef888] irdma_free_pending_cqp_request at ffffffffa0ba12cc [irdma]
 #9 [ffff88aa841ef958] irdma_cleanup_pending_cqp_op at ffffffffa0ba1469 [irdma]
 #10 [ffff88aa841ef9c0] irdma_ctrl_deinit_hw at ffffffffa0b2989f [irdma]
 #11 [ffff88aa841efa28] irdma_remove at ffffffffa0b252df [irdma]
 #12 [ffff88aa841efae8] auxiliary_bus_remove at ffffffff8219afdb
 #13 [ffff88aa841efb00] device_release_driver_internal at ffffffff821882e6
 #14 [ffff88aa841efb38] bus_remove_device at ffffffff82184278
 #15 [ffff88aa841efb88] device_del at ffffffff82179d23
 #16 [ffff88aa841efc48] ice_unplug_aux_dev at ffffffffa0eb1c14 [ice]
 #17 [ffff88aa841efc68] ice_service_task at ffffffffa0d88201 [ice]
 #18 [ffff88aa841efde8] process_one_work at ffffffff811c589a
 #19 [ffff88aa841efe60] worker_thread at ffffffff811c71ff
 #20 [ffff88aa841eff10] kthread at ffffffff811d87a0
 #21 [ffff88aa841eff50] ret_from_fork at ffffffff82e0022f

Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitions")
Suggested-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Shifeng Li <lishifeng@sangfor.com.cn>
---
 drivers/infiniband/hw/irdma/hw.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

---
v1->v2: replace fix solution and massage the git log.

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 8fa7e4a18e73..df6259c73d28 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -1180,7 +1180,6 @@ static int irdma_create_ceq(struct irdma_pci_f *rf, struct irdma_ceq *iwceq,
 	int status;
 	struct irdma_ceq_init_info info = {};
 	struct irdma_sc_dev *dev = &rf->sc_dev;
-	u64 scratch;
 	u32 ceq_size;
 
 	info.ceq_id = ceq_id;
@@ -1201,14 +1200,13 @@ static int irdma_create_ceq(struct irdma_pci_f *rf, struct irdma_ceq *iwceq,
 	iwceq->sc_ceq.ceq_id = ceq_id;
 	info.dev = dev;
 	info.vsi = vsi;
-	scratch = (uintptr_t)&rf->cqp.sc_cqp;
 	status = irdma_sc_ceq_init(&iwceq->sc_ceq, &info);
 	if (!status) {
 		if (dev->ceq_valid)
 			status = irdma_cqp_ceq_cmd(&rf->sc_dev, &iwceq->sc_ceq,
 						   IRDMA_OP_CEQ_CREATE);
 		else
-			status = irdma_sc_cceq_create(&iwceq->sc_ceq, scratch);
+			status = irdma_sc_cceq_create(&iwceq->sc_ceq, 0);
 	}
 
 	if (status) {
-- 
2.25.1


