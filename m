Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF787F0E1B
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Nov 2023 09:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjKTIst (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Nov 2023 03:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjKTIsd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Nov 2023 03:48:33 -0500
X-Greylist: delayed 963 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Nov 2023 00:48:18 PST
Received: from m15.mail.126.com (m15.mail.126.com [45.254.50.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42D4E172B;
        Mon, 20 Nov 2023 00:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=wPUpl
        deWYcVXn5AodmDP/GZx6MOGIrvel6eWAm0PBww=; b=hjfbULW0k2N+jLr6ohmvL
        u0KxerwNSxD13ETpTjsft/RR9/k/UPZbOuPigOjHp3NMp/nwWIq5ReQ7XnnvzOaK
        iDv8gpEEksJvH+97WH7oP01okfgwe6HFupnVUBHB/g7Kpk++cOYO+crmrjbBmx/m
        G9ukrlI0l9u432C/O3V/ac=
Received: from ubuntu.localdomain (unknown [111.222.250.119])
        by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wDXX9hoGVtlCptuAw--.16030S2;
        Mon, 20 Nov 2023 16:31:55 +0800 (CST)
From:   Shifeng Li <lishifeng1992@126.com>
To:     mustafa.ismail@intel.com
Cc:     shiraz.saleem@intel.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinghui@sangfor.com.cn, Shifeng Li <lishifeng1992@126.com>
Subject: [PATCH] RDMA/irdma: Avoid free the non-cqp_request scratch
Date:   Mon, 20 Nov 2023 00:31:22 -0800
Message-Id: <20231120083122.78532-1-lishifeng1992@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXX9hoGVtlCptuAw--.16030S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrykWFy5GF1DCr1rtryxKrg_yoW5tryDpr
        45Jr12krWFyry5Gw1UA3s8JFyUJF4jyasrJFsrA343J3WUW3WYqF18ArW09rnxJF18JF47
        Jr1qqr4vvrnFgaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U4WlkUUUUU=
X-Originating-IP: [111.222.250.119]
X-CM-SenderInfo: xolvxx5ihqwiqzzsqiyswou0bp/1S2mtgwur1pD4PG+MwABs-
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When creating ceq_0 during probing irdma, cqp.sc_cqp will be sent as a
cqp_request to cqp->sc_cqp.sq_ring. If the request is pending when removing
the irdma driver or unplugging its aux device, cqp.sc_cqp will be dereferenced 
as wrong struct in irdma_free_pending_cqp_request().

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
Signed-off-by: Shifeng Li <lishifeng1992@126.com>
---
 drivers/infiniband/hw/irdma/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 445e69e86409..222ec1f761a1 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -541,7 +541,7 @@ void irdma_cleanup_pending_cqp_op(struct irdma_pci_f *rf)
 	for (i = 0; i < pending_work; i++) {
 		cqp_request = (struct irdma_cqp_request *)(unsigned long)
 				      cqp->scratch_array[wqe_idx];
-		if (cqp_request)
+		if (cqp_request && cqp_request != (struct irdma_cqp_request *)&cqp->sc_cqp)
 			irdma_free_pending_cqp_request(cqp, cqp_request);
 		wqe_idx = (wqe_idx + 1) % IRDMA_RING_SIZE(cqp->sc_cqp.sq_ring);
 	}
-- 
2.25.1

