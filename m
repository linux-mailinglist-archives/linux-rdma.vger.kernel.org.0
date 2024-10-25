Return-Path: <linux-rdma+bounces-5523-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C469B080A
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Oct 2024 17:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E951F20F53
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Oct 2024 15:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD4370816;
	Fri, 25 Oct 2024 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="frVthqS1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD90121A4BC
	for <linux-rdma@vger.kernel.org>; Fri, 25 Oct 2024 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869651; cv=none; b=EEN5Ilr0vLfBzvNP7kfiVCkwz3U7LH0iHerED3z8ZiCX+2CSU8tERyaSG1+BYp8pHT5HuYdAKv1T6+Vhx+7WNMeKLHqu/wOOi7JlTZnnGsMWkrvC9uX8pLtLVdZx66bEmxsF93iMNrbvPWukc72kQO6Eg0seNYYsHjHEb4dSxg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869651; c=relaxed/simple;
	bh=xSwpXuiVEDPw2xoKlnnPZGYh9kuXUZc9itSRpwaSgB4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qsRIYshh2H967uEYXP6c3ypMGuNUTiTjpjo9M/h8/9kWS6xskpibn2sPjFL0ubLiKeh03VBGC/TC7/K8S6VjFHs/NNXx3kOZELFmwcTMekOXn6qV+h7vJvnVrlNYPkXezqtZqQOcWJsBnC8LWM3tn45zYP8OOqFjZV+6B35Cubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=frVthqS1; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729869646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7/YongGRqG4AcMmmwelOzs/EXmeRcf7O5QS3wJ7CQ6c=;
	b=frVthqS1q9QPuZpbStnmH03TzPp8anPz9cukh3rOGz1r/y4nk6D4Qht7YfJd2MQnKcfgJf
	fOIvYoZ1vUS2V5JuV7FIDkMqP1FLvh4NBj2jvQnGHigdYP55qqK6wtEoxfbPhyer5uOvTl
	/R3CxLdzDmyiddiH7u2D7gsFuwZbxng=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] RDMA/rxe: Fix the qp flush warnings in req
Date: Fri, 25 Oct 2024 17:20:36 +0200
Message-Id: <20241025152036.121417-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When the qp is in error state, the status of WQEs in the queue should be
set to error. Or else the following will appear.

[  920.617269] WARNING: CPU: 1 PID: 21 at drivers/infiniband/sw/rxe/rxe_comp.c:756 rxe_completer+0x989/0xcc0 [rdma_rxe]
[  920.617744] Modules linked in: rnbd_client(O) rtrs_client(O) rtrs_core(O) rdma_ucm rdma_cm iw_cm ib_cm crc32_generic rdma_rxe ip6_udp_tunnel udp_tunnel ib_uverbs ib_core loop brd null_blk ipv6
[  920.618516] CPU: 1 PID: 21 Comm: ksoftirqd/1 Tainted: G           O       6.1.113-storage+ #65
[  920.618986] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[  920.619396] RIP: 0010:rxe_completer+0x989/0xcc0 [rdma_rxe]
[  920.619658] Code: 0f b6 84 24 3a 02 00 00 41 89 84 24 44 04 00 00 e9 2a f7 ff ff 39 ca bb 03 00 00 00 b8 0e 00 00 00 48 0f 45 d8 e9 15 f7 ff ff <0f> 0b e9 cb f8 ff ff 41 bf f5 ff ff ff e9 08 f8 ff ff 49 8d bc 24
[  920.620482] RSP: 0018:ffff97b7c00bbc38 EFLAGS: 00010246
[  920.620817] RAX: 0000000000000000 RBX: 000000000000000c RCX: 0000000000000008
[  920.621183] RDX: ffff960dc396ebc0 RSI: 0000000000005400 RDI: ffff960dc4e2fbac
[  920.621548] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffffac406450
[  920.621884] R10: ffffffffac4060c0 R11: 0000000000000001 R12: ffff960dc4e2f800
[  920.622254] R13: ffff960dc4e2f928 R14: ffff97b7c029c580 R15: 0000000000000000
[  920.622609] FS:  0000000000000000(0000) GS:ffff960ef7d00000(0000) knlGS:0000000000000000
[  920.622979] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  920.623245] CR2: 00007fa056965e90 CR3: 00000001107f1000 CR4: 00000000000006e0
[  920.623680] Call Trace:
[  920.623815]  <TASK>
[  920.623933]  ? __warn+0x79/0xc0
[  920.624116]  ? rxe_completer+0x989/0xcc0 [rdma_rxe]
[  920.624356]  ? report_bug+0xfb/0x150
[  920.624594]  ? handle_bug+0x3c/0x60
[  920.624796]  ? exc_invalid_op+0x14/0x70
[  920.624976]  ? asm_exc_invalid_op+0x16/0x20
[  920.625203]  ? rxe_completer+0x989/0xcc0 [rdma_rxe]
[  920.625474]  ? rxe_completer+0x329/0xcc0 [rdma_rxe]
[  920.625749]  rxe_do_task+0x80/0x110 [rdma_rxe]
[  920.626037]  rxe_requester+0x625/0xde0 [rdma_rxe]
[  920.626310]  ? rxe_cq_post+0xe2/0x180 [rdma_rxe]
[  920.626583]  ? do_complete+0x18d/0x220 [rdma_rxe]
[  920.626812]  ? rxe_completer+0x1a3/0xcc0 [rdma_rxe]
[  920.627050]  rxe_do_task+0x80/0x110 [rdma_rxe]
[  920.627285]  tasklet_action_common.constprop.0+0xa4/0x120
[  920.627522]  handle_softirqs+0xc2/0x250
[  920.627728]  ? sort_range+0x20/0x20
[  920.627942]  run_ksoftirqd+0x1f/0x30
[  920.628158]  smpboot_thread_fn+0xc7/0x1b0
[  920.628334]  kthread+0xd6/0x100
[  920.628504]  ? kthread_complete_and_exit+0x20/0x20
[  920.628709]  ret_from_fork+0x1f/0x30
[  920.628892]  </TASK>

Fixes: ae720bdb703b ("RDMA/rxe: Generate error completion for error requester QP state")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 479c07e6e4ed..87a02f0deb00 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -663,10 +663,12 @@ int rxe_requester(struct rxe_qp *qp)
 	if (unlikely(qp_state(qp) == IB_QPS_ERR)) {
 		wqe = __req_next_wqe(qp);
 		spin_unlock_irqrestore(&qp->state_lock, flags);
-		if (wqe)
+		if (wqe) {
+			wqe->status = IB_WC_WR_FLUSH_ERR;
 			goto err;
-		else
+		} else {
 			goto exit;
+		}
 	}
 
 	if (unlikely(qp_state(qp) == IB_QPS_RESET)) {
-- 
2.34.1


