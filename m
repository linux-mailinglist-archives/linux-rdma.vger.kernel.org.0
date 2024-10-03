Return-Path: <linux-rdma+bounces-5195-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 036B398EF42
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2024 14:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB44C2846EC
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2024 12:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBE014830D;
	Thu,  3 Oct 2024 12:30:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ED3823C3
	for <linux-rdma@vger.kernel.org>; Thu,  3 Oct 2024 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727958645; cv=none; b=PWMHCEAfeq0VRHLjSuJVyc4Z6cYxVO3ON1UrJtHKJhZanhpXj+hsbut++yG2Yxpaa2YGS08+TsP3GTiFKirTcaF3Vw7hJ22wjXLCHYseCtL5vsArvXuouK1onfSoFjqMXk3lVq+GcaUNugI383zo1d/qX58EMFfQDPyfM1EyDlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727958645; c=relaxed/simple;
	bh=S8oyj8FF3bfJILBGopWIVwxvKg4moWK23tLbAW88MVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mdxL9tj993lqSZqeQWOrQ+LFymNo6fVoaG2TfBom43Z2ulR8UG8LBsPsGF9cBPFVH2rgCtzOdjUZamIUZm+WOtbqta1441wPtIhzOoWutQpkOlf9shEt53EK3jdGeu//Mro9VPk+rOp1Q+S2na92NCn35M9Us//+eE1Q10+m9hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from sonada.blr.asicdesigners.com (sonada.blr.asicdesigners.com [10.193.186.190])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 493CUSJJ000664;
	Thu, 3 Oct 2024 05:30:29 -0700
From: Showrya M N <showrya@chelsio.com>
To: jgg@nvidia.com, leonro@nvidia.com, bmt@zurich.ibm.com
Cc: linux-rdma@vger.kernel.org, Showrya M N <showrya@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH for-rc] RDMA/siw: add sendpage_ok() check to disable MSG_SPLICE_PAGES
Date: Thu,  3 Oct 2024 18:16:12 +0530
Message-Id: <20241003124611.35060-1-showrya@chelsio.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While running ISER over SIW, the initiator machine encounters a warning
from skb_splice_from_iter() indicating that a slab page is being used
in send_page. To address this, it is better to add a sendpage_ok() check
within the driver itself, and if it returns 0, then MSG_SPLICE_PAGES flag
should be disabled before entering the network stack.

A similar issue has been discussed for NVMe in this thread:
https://lore.kernel.org/all/20240530142417.146696-1-ofir.gal@volumez.com/

stack trace:
...
[ 2157.532917] WARNING: CPU: 0 PID: 5342 at net/core/skbuff.c:7140 skb_splice_from_iter+0x173/0x320
Call Trace:
[ 2157.533064] Call Trace:
[ 2157.533069]  ? __warn+0x84/0x130
[ 2157.533073]  ? skb_splice_from_iter+0x173/0x320
[ 2157.533075]  ? report_bug+0xfc/0x1e0
[ 2157.533081]  ? handle_bug+0x3f/0x70
[ 2157.533085]  ? exc_invalid_op+0x17/0x70
[ 2157.533088]  ? asm_exc_invalid_op+0x1a/0x20
[ 2157.533096]  ? skb_splice_from_iter+0x173/0x320
[ 2157.533101]  tcp_sendmsg_locked+0x368/0xe40
[ 2157.533111]  siw_tx_hdt+0x695/0xa40 [siw]
[ 2157.533134]  ? sched_balance_find_src_group+0x44/0x4f0
[ 2157.533143]  ? __update_load_avg_cfs_rq+0x272/0x300
[ 2157.533152]  ? place_entity+0x19/0xf0
[ 2157.533157]  ? enqueue_entity+0xdb/0x3d0
[ 2157.533162]  ? pick_eevdf+0xe2/0x120
[ 2157.533169]  ? check_preempt_wakeup_fair+0x161/0x1f0
[ 2157.533174]  ? wakeup_preempt+0x61/0x70
[ 2157.533177]  ? ttwu_do_activate+0x5d/0x1e0
[ 2157.533183]  ? try_to_wake_up+0x78/0x610
[ 2157.533188]  ? xas_load+0xd/0xb0
[ 2157.533193]  ? xa_load+0x80/0xb0
[ 2157.533200]  siw_qp_sq_process+0x102/0xb00 [siw]
[ 2157.533213]  ? __pfx_siw_run_sq+0x10/0x10 [siw]
[ 2157.533224]  siw_sq_resume+0x39/0x110 [siw]
[ 2157.533236]  siw_run_sq+0x74/0x160 [siw]
[ 2157.533246]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 2157.533252]  kthread+0xd2/0x100
[ 2157.533257]  ? __pfx_kthread+0x10/0x10
[ 2157.533261]  ret_from_fork+0x34/0x40
[ 2157.533266]  ? __pfx_kthread+0x10/0x10
[ 2157.533269]  ret_from_fork_asm+0x1a/0x30
.
[ 2157.533301] iser: iser_qp_event_callback: qp event QP request error (2)
[ 2157.533307] iser: iser_qp_event_callback: qp event send queue drained (5)
[ 2157.533348]  connection26:0: detected conn error (1011)

Signed-off-by: Showrya M N <showrya@chelsio.com>
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 64ad9e0895bd..d777d06037db 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -334,6 +334,9 @@ static int siw_tcp_sendpages(struct socket *s, struct page **page, int offset,
 		bvec_set_page(&bvec, page[i], bytes, offset);
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
 
+		if (!sendpage_ok(page[i]))
+			msg.msg_flags &= ~MSG_SPLICE_PAGES;
+
 try_page_again:
 		lock_sock(sk);
 		rv = tcp_sendmsg_locked(sk, &msg, size);
-- 
2.39.1


