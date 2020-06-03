Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B5C1ECD57
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2020 12:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgFCKR6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jun 2020 06:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCKR5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jun 2020 06:17:57 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C866C08C5C0
        for <linux-rdma@vger.kernel.org>; Wed,  3 Jun 2020 03:17:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d128so1424703wmc.1
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jun 2020 03:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=faL3WMD45X3eLpTE7c3WIWQehhZEPMB49mY1nPPajMs=;
        b=SOIMdNOHKDQkAwUMHqXBh1be3JzNvedoFA1epnNyIjP826usyGTT/FkTXmRsl30Sg0
         bOdFunuv2wX2rI7Wvddvf9ZJ1ecxCodWMPdSVi13mRGwxuumcG22P1qNVt40V56YGjXL
         n0HxsohEDJ82sqiWVQVGVw+WdefY0ob1swU1/UVEE76YZdsf4GwcCtCsbNkrHYsK1x4P
         XsrpNFsH7jfkxa7jgFW4aQgUtCm4ETZLy0FjocuXTJZTbG5kJ4u5UwkeEMREV+fEGGa1
         jyhI/Oe/2vV0cUViSE714rvKKLOlGi/H5DbI77GEX5RPW3UmUfgA3aBfI8lassMWUAgI
         IIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=faL3WMD45X3eLpTE7c3WIWQehhZEPMB49mY1nPPajMs=;
        b=rIyGp34f8vBg7zNr9YtfROAcrrsGYE/+F2z4KbsPsG9fIDAOPh6cMXJDs9p06OMI4j
         ESdDLagh7y8b7ttRuClOCInrkaq2YWgbId7NyLrujdi3yuvDDIi5F7CbbJW0B8//KugO
         iQC3+oLxH3dY2h3ki7f9Tyy7shGNCDGpwjj5lrzVSLHb1UWP9nz9xGYEhZnbNJX5exhp
         j0/M+yHJHL7TzySu3zz2f9B2UI8I001Xsggt2dn+FRBF58VZ+jNPpTyyOuR+0V2lHTLv
         3BM8nMBRBiSpQWT4tCnHI++VX8lhcIhwkfol/mBypcM0qEGjVuyQM9GPX6CBGilIjGsw
         RyTA==
X-Gm-Message-State: AOAM530AW7pkEz5ttZ32rF+JIEIwwR8noSOH5lElUvSfSODkgfu7Motc
        ZdLaCn9aDe18CAjG0GlCLnTcQ5geMn4=
X-Google-Smtp-Source: ABdhPJyvkkTqNi/eSeYDJ658JTc5NqQhRQTqVVtm1mAHRgblRpNUt2bu0t/4Aze1b616nAlMkVMnkQ==
X-Received: by 2002:a7b:ce15:: with SMTP id m21mr8113414wmc.117.1591179475779;
        Wed, 03 Jun 2020 03:17:55 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id s5sm2263159wme.37.2020.06.03.03.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 03:17:55 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@mellanox.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc] RDMA/rxe: Fix QP cleanup flow
Date:   Wed,  3 Jun 2020 13:17:38 +0300
Message-Id: <20200603101738.159637-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Avoid releasing the socket associated with each QP in rxe_qp_cleanup()
which can sleep and move it to rxe_destroy_qp() instead, after doing
this there is no need for the execute_work that used to avoid calling
rxe_qp_cleanup() directly. also check that the socket is valid in
rxe_skb_tx_dtor() to avoid use-after-free.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Fixes: bb3ffb7ad48a ("RDMA/rxe: Fix rxe_qp_cleanup()")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c   | 14 ++++++++++++--
 drivers/infiniband/sw/rxe/rxe_qp.c    | 22 ++++++----------------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  3 ---
 3 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 312c2fc961c0..298ccd3fd3e2 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -411,8 +411,18 @@ int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb, u32 *crc)
 static void rxe_skb_tx_dtor(struct sk_buff *skb)
 {
 	struct sock *sk = skb->sk;
-	struct rxe_qp *qp = sk->sk_user_data;
-	int skb_out = atomic_dec_return(&qp->skb_out);
+	struct rxe_qp *qp;
+	int skb_out;
+
+	if (!sk)
+		return;
+
+	qp = sk->sk_user_data;
+
+	if (!qp)
+		return;
+
+	skb_out = atomic_dec_return(&qp->skb_out);
 
 	if (unlikely(qp->need_req_skb &&
 		     skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW))
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 6c11c3aeeca6..89dac6c1111c 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -787,6 +787,7 @@ void rxe_qp_destroy(struct rxe_qp *qp)
 	if (qp_type(qp) == IB_QPT_RC) {
 		del_timer_sync(&qp->retrans_timer);
 		del_timer_sync(&qp->rnr_nak_timer);
+		sk_dst_reset(qp->sk->sk);
 	}
 
 	rxe_cleanup_task(&qp->req.task);
@@ -798,12 +799,15 @@ void rxe_qp_destroy(struct rxe_qp *qp)
 		__rxe_do_task(&qp->comp.task);
 		__rxe_do_task(&qp->req.task);
 	}
+
+	kernel_sock_shutdown(qp->sk, SHUT_RDWR);
+	sock_release(qp->sk);
 }
 
 /* called when the last reference to the qp is dropped */
-static void rxe_qp_do_cleanup(struct work_struct *work)
+void rxe_qp_cleanup(struct rxe_pool_entry *arg)
 {
-	struct rxe_qp *qp = container_of(work, typeof(*qp), cleanup_work.work);
+	struct rxe_qp *qp = container_of(arg, typeof(*qp), pelem);
 
 	rxe_drop_all_mcast_groups(qp);
 
@@ -828,19 +832,5 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 		qp->resp.mr = NULL;
 	}
 
-	if (qp_type(qp) == IB_QPT_RC)
-		sk_dst_reset(qp->sk->sk);
-
 	free_rd_atomic_resources(qp);
-
-	kernel_sock_shutdown(qp->sk, SHUT_RDWR);
-	sock_release(qp->sk);
-}
-
-/* called when the last reference to the qp is dropped */
-void rxe_qp_cleanup(struct rxe_pool_entry *arg)
-{
-	struct rxe_qp *qp = container_of(arg, typeof(*qp), pelem);
-
-	execute_in_process_context(rxe_qp_do_cleanup, &qp->cleanup_work);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 92de39c4a7c1..339debaf095f 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -35,7 +35,6 @@
 #define RXE_VERBS_H
 
 #include <linux/interrupt.h>
-#include <linux/workqueue.h>
 #include <rdma/rdma_user_rxe.h>
 #include "rxe_pool.h"
 #include "rxe_task.h"
@@ -285,8 +284,6 @@ struct rxe_qp {
 	struct timer_list rnr_nak_timer;
 
 	spinlock_t		state_lock; /* guard requester and completer */
-
-	struct execute_work	cleanup_work;
 };
 
 enum rxe_mem_state {
-- 
2.25.4

