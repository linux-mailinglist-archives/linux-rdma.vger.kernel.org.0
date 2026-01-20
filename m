Return-Path: <linux-rdma+bounces-15734-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD099D3C0F2
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 08:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47D7456468B
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 07:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581C63A9DB6;
	Tue, 20 Jan 2026 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="fKJcfgFY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5F93A900B;
	Tue, 20 Jan 2026 07:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895097; cv=none; b=SxWQuLmharTWX/oN1wfwKHRD1lf3R3eXemSZHjV72Eys1xudZWxvCXmHRMmvN+bxMYwuLehiSMQhtOOMVbZ/+BmK7RFrJTdtIRrZd5uVT7Bqv6aQyRWjCnEeCLDaj0PAQiwaqbehjSCoYApIyJZLgAwjRgF67guszhv55vXtx+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895097; c=relaxed/simple;
	bh=+yRr32asiV0HwleEpZkFCbCoL0REfEaWVlYBxNP0/K0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rhfw6k4DI7A0KGQ+wJCYx88K6uR6vwycPYULwB2Cs2ZrWnSxV2k31u3XJXra21MObzVyGaPjUrgoEn2bQk2HRsinO3KrM491QJNB3U/dHVsTFRvdtAhj9nb8reAHQOfNhL26I8kpqirrbrObpoJodQpPduOtffOpQxVeXyoWjrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=fKJcfgFY; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1768895095; x=1800431095;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+yRr32asiV0HwleEpZkFCbCoL0REfEaWVlYBxNP0/K0=;
  b=fKJcfgFYL7FVLpRF1wVw5eyvBHn+4+wwgHwttmXBL51xjUQZgBF9VYTX
   Z8gS+bSel6nDEpPEYI1HOjRPKXX3OPQhaiUdBg+mOzTZNaVvboyt/sZd+
   UiHMfShd8ovvseBXl6FCZdiOT+rBfcu/YyK6O5cs6jSPvybfZFTTZbfvB
   +PXgbJ2FHwoA0/UBthLVmWq83i/yNxfDlaYaslsjFWslKzMyunoTVcyg3
   XT3v5r+4MGMTPbcbtwOOKz+md8cy1+NZ4p9iCff3YRZs27CrgEF5NI3CN
   7mF6AGexJISWiJcLC20DjEZV5sZqM10KeNPWaZlWaW62UE4QOb4nQahRw
   Q==;
X-CSE-ConnectionGUID: 3HZbqTuhRNa/+9t/s+Xesg==
X-CSE-MsgGUID: 6mMgXP+sSPSwi8PpMGG7dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="214987155"
X-IronPort-AV: E=Sophos;i="6.21,240,1763391600"; 
   d="scan'208";a="214987155"
Received: from unknown (HELO az2nlsmgr1.o.css.fujitsu.com) ([20.61.8.234])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 16:44:46 +0900
Received: from az2nlsmgm4.fujitsu.com (unknown [10.150.26.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr1.o.css.fujitsu.com (Postfix) with ESMTPS id AC72C1C00086;
	Tue, 20 Jan 2026 07:44:46 +0000 (UTC)
Received: from az2nlsmom1.o.css.fujitsu.com (az2nlsmom1.o.css.fujitsu.com [10.150.26.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm4.fujitsu.com (Postfix) with ESMTPS id 5F1211001353;
	Tue, 20 Jan 2026 07:44:46 +0000 (UTC)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
	by az2nlsmom1.o.css.fujitsu.com (Postfix) with ESMTP id CFE8D8230B6;
	Tue, 20 Jan 2026 07:44:42 +0000 (UTC)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] RDMA/rxe: Fix race condition in QP timer handlers
Date: Tue, 20 Jan 2026 15:44:37 +0800
Message-ID: <20260120074437.623018-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I encontered the following warning:
 WARNING: drivers/infiniband/sw/rxe/rxe_task.c:249 at rxe_sched_task+0x1c8/0x238 [rdma_rxe], CPU#0: swapper/0/0
...
  libsha1 [last unloaded: ip6_udp_tunnel]
 CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G         C          6.19.0-rc5-64k-v8+ #37 PREEMPT
 Tainted: [C]=CRAP
 Hardware name: Raspberry Pi 4 Model B Rev 1.2
 Call trace:
  rxe_sched_task+0x1c8/0x238 [rdma_rxe] (P)
  retransmit_timer+0x130/0x188 [rdma_rxe]
  call_timer_fn+0x68/0x4d0
  __run_timers+0x630/0x888
...
 WARNING: drivers/infiniband/sw/rxe/rxe_task.c:38 at rxe_sched_task+0x1c0/0x238 [rdma_rxe], CPU#0: swapper/0/0
...
 WARNING: drivers/infiniband/sw/rxe/rxe_task.c:111 at do_work+0x488/0x5c8 [rdma_rxe], CPU#3: kworker/u17:4/93400
...
 refcount_t: underflow; use-after-free.
 WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x138/0x1a0, CPU#3: kworker/u17:4/93400

The issue is caused by a race condition between retransmit_timer() and
rxe_destroy_qp, leading to the Queue Pair's (QP) reference count dropping
to zero during timer handler execution.

It seems this warning is harmless because rxe_qp_do_cleanup() will flush
all pending timers and requests.

Example of flow causing the issue:

CPU0                                   CPU1
retransmit_timer() {
    spin_lock_irqsave
                           rxe_destroy_qp()
                            __rxe_cleanup()
                              __rxe_put() // qp->ref_count decrease to 0
                            rxe_qp_do_cleanup() {
    if (qp->valid) {
        rxe_sched_task() {
            WARN_ON(rxe_read(task->qp) <= 0);
        }
    }
    spin_unlock_irqrestore
}
                              spin_lock_irqsave
                              qp->valid = 0
                              spin_unlock_irqrestore
                            }

Ensure the QP's reference count is maintained and its validity is checked
within the timer callbacks by adding calls to rxe_get(qp) and corresponding
rxe_put(qp) after use.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 3 +++
 drivers/infiniband/sw/rxe/rxe_req.c  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index a5b2b62f596b..1390e861bd1d 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -119,12 +119,15 @@ void retransmit_timer(struct timer_list *t)
 
 	rxe_dbg_qp(qp, "retransmit timer fired\n");
 
+	if (!rxe_get(qp))
+		return;
 	spin_lock_irqsave(&qp->state_lock, flags);
 	if (qp->valid) {
 		qp->comp.timeout = 1;
 		rxe_sched_task(&qp->send_task);
 	}
 	spin_unlock_irqrestore(&qp->state_lock, flags);
+	rxe_put(qp);
 }
 
 void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 373b03f223be..12d03f390b09 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -102,6 +102,8 @@ void rnr_nak_timer(struct timer_list *t)
 
 	rxe_dbg_qp(qp, "nak timer fired\n");
 
+	if (!rxe_get(qp))
+		return;
 	spin_lock_irqsave(&qp->state_lock, flags);
 	if (qp->valid) {
 		/* request a send queue retry */
@@ -110,6 +112,7 @@ void rnr_nak_timer(struct timer_list *t)
 		rxe_sched_task(&qp->send_task);
 	}
 	spin_unlock_irqrestore(&qp->state_lock, flags);
+	rxe_put(qp);
 }
 
 static void req_check_sq_drain_done(struct rxe_qp *qp)
-- 
2.41.0


