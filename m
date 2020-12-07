Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D48E2D0D2D
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Dec 2020 10:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgLGJjC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Dec 2020 04:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLGJjC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Dec 2020 04:39:02 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA13C0613D1
        for <linux-rdma@vger.kernel.org>; Mon,  7 Dec 2020 01:38:21 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id i24so5122387edj.8
        for <linux-rdma@vger.kernel.org>; Mon, 07 Dec 2020 01:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9SjoM/VxTSTPnLxS4k76i7spL82UBE9RfjLWLwkmMU=;
        b=eZE6vqI7jFD2ofCDIjX4XDp71n3dhX74kniTzai1HBXj/vOA/HWs9C3Esat/8RRjw1
         Fgw9rOfXzrr0lOGU5vDqXkwl4VL7YDzsXE25fiSOOSVJI7gIP1opUklBfraP9We/HdwS
         PCgwtIwzXMcjo2bGb1px7FrTi6RI4CT3lbt2FKsDNGDi+sOxvz1iyAZ8XQLmETDJ5Zvt
         5VFGe3zUC9o1jH195QzCSQH3z1btHjP71T7gTCDQ3qMbKBHCgtzadH9IVV/ER9iREZno
         BhLKURR8Ojh62pE5eh/EKM3umZtEiNLQafCcXm7K+AlFLEykSv/8tiJy1N9uuuMKUMv9
         Gspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9SjoM/VxTSTPnLxS4k76i7spL82UBE9RfjLWLwkmMU=;
        b=ECOSe48qaabEOnWFaHk3ezuz4P92PTdmugsQKS8DAa9kw/9aLyyI9HoqhEYiEYWaEJ
         FQ0x3m4So/ofn7jBWOLlRPLIT9EWOXAE549SLrg6hmPcFpUps2KgggezyUmVLpX5gUeO
         4KuUxZZPcWenVIg6aBcZeEOyc3KRbU6yso0Cxa49roSgohmMTdU4Q48MLVVmCt7+4rhb
         D+xROlJS+dyUoOXvLPxaEimYy0aMEJPeNGoAQSsspSwlUIqre3a3QxLVGikZLs/lbG8k
         vytJr0pRzCnxjVW2TI3qH6AWlwkxCVqB9xiw2Ay5Ezjfw/bm0QihJs/iVeZX9+S9Ir60
         +aYw==
X-Gm-Message-State: AOAM532akwgB0OtTegtS6ZkAt5y2UO9SA/dTZL/L4HXP2A2qyMKw6qfV
        7us7rEp9iwE5YyxGpq0jURkiMyFPJV0=
X-Google-Smtp-Source: ABdhPJz/C77t4x1aOfCI7k8q1C/hxUliDVF1RZL+f5r5C4F6c4w01XtsuVREdxRlvqvTUaxmdfooRg==
X-Received: by 2002:a05:6402:3192:: with SMTP id di18mr10946965edb.332.1607333899775;
        Mon, 07 Dec 2020 01:38:19 -0800 (PST)
Received: from kheib-workstation.redhat.com ([77.137.152.100])
        by smtp.gmail.com with ESMTPSA id bn21sm9275007ejb.47.2020.12.07.01.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 01:38:19 -0800 (PST)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc] RDMA/siw: Fix shift-out-of-bounds when call roundup_pow_of_two()
Date:   Mon,  7 Dec 2020 11:37:28 +0200
Message-Id: <20201207093728.428679-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When running the blktests over siw the following shift-out-of-bounds is
reported, this is happening because the passed IRD or ORD from the ulp
could be zero which will lead to unexpected behavior when calling
roundup_pow_of_two(), fix that by blocking zero values of ORD or IRD.

UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
shift exponent 64 is too large for 64-bit type 'long unsigned int'
CPU: 20 PID: 3957 Comm: kworker/u64:13 Tainted: G S     5.10.0-rc6 #2
Hardware name: Dell Inc. PowerEdge R630/02C2CP, BIOS 2.1.5 04/11/2016
Workqueue: iw_cm_wq cm_work_handler [iw_cm]
Call Trace:
 dump_stack+0x99/0xcb
 ubsan_epilogue+0x5/0x40
 __ubsan_handle_shift_out_of_bounds.cold.11+0xb4/0xf3
 ? down_write+0x183/0x3d0
 siw_qp_modify.cold.8+0x2d/0x32 [siw]
 ? __local_bh_enable_ip+0xa5/0xf0
 siw_accept+0x906/0x1b60 [siw]
 ? xa_load+0x147/0x1f0
 ? siw_connect+0x17a0/0x17a0 [siw]
 ? lock_downgrade+0x700/0x700
 ? siw_get_base_qp+0x1c2/0x340 [siw]
 ? _raw_spin_unlock_irqrestore+0x39/0x40
 iw_cm_accept+0x1f4/0x430 [iw_cm]
 rdma_accept+0x3fa/0xb10 [rdma_cm]
 ? check_flush_dependency+0x410/0x410
 ? cma_rep_recv+0x570/0x570 [rdma_cm]
 nvmet_rdma_queue_connect+0x1a62/0x2680 [nvmet_rdma]
 ? nvmet_rdma_alloc_cmds+0xce0/0xce0 [nvmet_rdma]
 ? lock_release+0x56e/0xcc0
 ? lock_downgrade+0x700/0x700
 ? lock_downgrade+0x700/0x700
 ? __xa_alloc_cyclic+0xef/0x350
 ? __xa_alloc+0x2d0/0x2d0
 ? rdma_restrack_add+0xbe/0x2c0 [ib_core]
 ? __ww_mutex_die+0x190/0x190
 cma_cm_event_handler+0xf2/0x500 [rdma_cm]
 iw_conn_req_handler+0x910/0xcb0 [rdma_cm]
 ? _raw_spin_unlock_irqrestore+0x39/0x40
 ? trace_hardirqs_on+0x1c/0x150
 ? cma_ib_handler+0x8a0/0x8a0 [rdma_cm]
 ? __kasan_kmalloc.constprop.7+0xc1/0xd0
 cm_work_handler+0x121c/0x17a0 [iw_cm]
 ? iw_cm_reject+0x190/0x190 [iw_cm]
 ? trace_hardirqs_on+0x1c/0x150
 process_one_work+0x8fb/0x16c0
 ? pwq_dec_nr_in_flight+0x320/0x320
 worker_thread+0x87/0xb40
 ? __kthread_parkme+0xd1/0x1a0
 ? process_one_work+0x16c0/0x16c0
 kthread+0x35f/0x430
 ? kthread_mod_delayed_work+0x180/0x180
 ret_from_fork+0x22/0x30

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/sw/siw/siw_cm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 66764f7ef072..dff0b00cc55d 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1571,7 +1571,8 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 		qp->tx_ctx.gso_seg_limit = 0;
 	}
 	if (params->ord > sdev->attrs.max_ord ||
-	    params->ird > sdev->attrs.max_ird) {
+	    params->ird > sdev->attrs.max_ird ||
+	    !params->ord || !params->ird) {
 		siw_dbg_cep(
 			cep,
 			"[QP %u]: ord %d (max %d), ird %d (max %d)\n",
-- 
2.26.2

