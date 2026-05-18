Return-Path: <linux-rdma+bounces-20933-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kExxG2eDC2oZIwUAu9opvQ
	(envelope-from <linux-rdma+bounces-20933-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 23:23:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00202573C7E
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 23:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC7F13036CC1
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 21:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1168399011;
	Mon, 18 May 2026 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgK8aTPt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267A4397338
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139424; cv=none; b=Sh6m+z7A2mVjDdrvflXcjscIPjTHBvvRD7aRMNrWbmRd53DNOLE3MWh0HSIvcCjRrTZHjJ6+o4+5E34Nnkgr9ASVe8MgTLeTkFuurbqEGDgJqfxSoU+Qv+ooNdrk+q170ilPc6/OwRKPgEdHGCuyY6iZzNLUIAaHDDEHBrGsZzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139424; c=relaxed/simple;
	bh=r0lg9YRX6xORkZ7Admw+989oxdaqLorvb/Z1s0NxaLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pxGgUXqVxkkVsJHQSQ2srbT6ac8UJIKlrXFaTU6fCGcNdfqN82PanJaeMOkO3TbSKNdkDpmY52Sri7iDQ6IC3ArmCSNeZmTs6d9uFU6BtSEA91cBwc2AAhRaGnRGG+7aTUfVAKKg4nDIDYqbcr1Ml4u1wBBSAAGmHhat5fDmt7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgK8aTPt; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51306c9f2a8so34433931cf.1
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 14:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779139422; x=1779744222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8dlxczQKkS431AlI89XxhX7yrGqU4XUXJdF6JkeyGzM=;
        b=BgK8aTPto0OtHACqJ95bQkVyQWpwPpSF+dXIfnSK1UWMG9iZHvOH1PfyDBPrxG7vlU
         jSeTqOBngpNZ8KfOQGR/RJv0vzrOHO6v1CSBtTuTukG5h5wQOg1Vupoxt7QHkNIvUKSy
         z+c9BIM1i/6pDk1SOi8IBvmc4/Kr7deyPiuAmW0RDwBcUVB4PF1vD3YZJjCvZ/kLZHUK
         YlhHFpz7EXRO00c7q47ILbgOXm5A4fvtNDPeJPPETJRoUpEMsR4SuBZH6R0JAAnVac8J
         /EzG62SwVdBFlRmbwTFHByuLbTwjZLeUUC1Dac8qCzRFl0tqw/H6nZ9/9Kb+MoCeUazz
         gbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779139422; x=1779744222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dlxczQKkS431AlI89XxhX7yrGqU4XUXJdF6JkeyGzM=;
        b=KJHEfwL/FBDkVHxA+Y8KEF+OgomRKuH8N1aLxpvtpK49hZ8mHsvPqFEBeJjzhk42D5
         c9Mui4gY5Qj76ZHCI78InyssCt7X27oNF/adWfZM0VUivzZQZjPtHr2oS9ToUPCCWMlB
         yjcQDAmyxzprsJiiG1ka++fSuMa9wRh8NKZYlqZG2+5PcqKcmiSxTnli4jkPerznfZne
         IX3PrZ/6zLy5LZvgzECVdf4lSqwm6boxYXAWfpbrGtJF6fbHGx/nQ2K/DeVsXMusDoQE
         5O/8ygeHK9I9jSbinVmUIhxGRQijiPhQDfL64LD7Zj2fSer34SFedlHpgwCTzcRdNf3i
         wTbg==
X-Gm-Message-State: AOJu0YxMiHi0nBMHSIYSESaVEBSc+BeS+HxxY1YYocRrQKyVHXniXjmZ
	7VnEuFdB2EaT2QtHKA5aakG6+mTFbXk9lkbN2xm6pP9L6t4I+gHgRHZp
X-Gm-Gg: Acq92OE5KPR9lwDLMAF6sWgr9Z/GsceLUItHOx0GdrXltvmYrisDu1FI3xt8Van4swG
	g8oekd6ZnG2xpTRBMV7eh8BXQYcwMe1qWAjwVAGmx5kZimG9XDT5XG9MryZYLB5wiZOKs7C6AtY
	Lf1jcgZ3+V/N+liR9qwTTNKeq+/J43ZVQGyYW9XVwVPYjErExhDrTQ3Q+K9UdeLyeWWGy3MTQ9a
	6g95s2HA7bLCGFZ1ReAN7ph1L1HTEJ842lYVB9P02qeuXTESWXyfC2cLGYhTQg643a+8G0fVZZt
	ab7VIn50hj667c6T7EmkderReYCeRMw327ENkrPcdNE5kV9xGcIRZ3l0+eQFchdlqN0xvj6NvoC
	QInx6dpa3vjxo97KSm4u9t8JbRKoxjANNaLd/STPut/j0K3cLUUb78ujHczZi7gK50eaLwbjT/B
	k01QodlYu4v98+xM87sUdF/2KhVgYom+veDHzQ7KR5sqQxz428gtAmfEvF8s5FPbO80YzxtOj2y
	3qd3qvpTPtLqzZ316Le
X-Received: by 2002:a05:622a:5c0d:b0:50d:72e4:6df9 with SMTP id d75a77b69052e-5165a240d60mr229260081cf.50.1779139421988;
        Mon, 18 May 2026 14:23:41 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164df7bfa7sm138911031cf.21.2026.05.18.14.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 14:23:41 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Bob Pearson <rpearsonhpe@gmail.com>,
	Sean Hefty <shefty@nvidia.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH] IB/mad: cap RMPP reassembly window size to bound find_seg_location walk
Date: Mon, 18 May 2026 17:23:36 -0400
Message-ID: <20260518212336.337104-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20933-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 00202573C7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A peer on the same InfiniBand subnet or RoCEv2 L2 (or any UDP/4791-
reachable peer for internet-exposed RoCEv2 ports) can pin a target
port's IB MAD kworker for milliseconds per low-bandwidth RMPP burst
by sending an RMPP management transaction with descending segment
numbers. QP1 GMP traffic is unauthenticated by IBTA spec, so no
credentials are required. The bug sits on the IB management path
(QP1 GMP RMPP reassembly), not the RDMA data plane, so RDMA verbs
throughput is unaffected; deployments that raise recv_queue_size to
tune management-plane throughput are quadratically more exposed,
because per-burst cost grows O(F^2) with the configured window.

drivers/infiniband/core/mad_rmpp.c::find_seg_location() walks
rmpp_recv->rmpp_wc->rmpp_list in reverse on every inbound RMPP DATA
segment to locate the insertion point keyed by segment number. The
walk is O(N) per insert under spin_lock_irqsave(&rmpp_recv->lock) in
kworker context, so F adversarially-reordered segments aggregate to
O(F^2). window_size() returns max(recv_queue.max_active >> 3, 1):
the IB MAD core default recv_queue_size of 512 yields window=64
(per-burst cost in the microsecond range), but tuned production
configs with recv_queue_size=8192 push window to 1024 and let a
single low-bandwidth burst pin the per-port MAD kworker for several
milliseconds.

Cap the effective window at IB_MAD_RMPP_MAX_WINDOW = 64 in
window_size() so admins tuning recv_queue_size for higher RX throughput
do not enlarge the walker attack surface. Real RMPP transactions in
the wild (SA queries, perf-counter reads) are well served by a window
of 64, which is also the IB MAD core default. A structural follow-up
would convert rmpp_recv->rmpp_wc->rmpp_list to an rb_tree keyed by
seg_num and lift the cap; that mirrors tcp_data_queue_ofo post-
CVE-2018-5390. For now the cap suffices.

Fixes: fa619a77046b ("[PATCH] IB: Add RMPP implementation")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
I reproduced this under x86_64 QEMU/KVM (4 vCPUs) on v7.1-rc2 with
CONFIG_RDMA_RXE + CONFIG_INFINIBAND_USER_MAD, a veth pair carrying
two rdma_rxe links, and raw RoCEv2/UDP/4791 packet injection with
descending seg_num while holding seg #1. Without the cap, F=1024
burst produces 1022 paired continue_rmpp invocations whose per-call
walker duration grows from ~1 us (early, near-empty list) to ~5 us
(late, ~1000-deep list), a 4x per-call amplification as the queue
deepens, with aggregate walker time per burst >= 1.5 ms (lower bound,
ftrace 1 us granularity). With the cap, the same F=1024 burst drops
to ~0.28 ms aggregate (5.4x reduction); F=32 in-window legitimate
RMPP still completes normally (30 walker calls, avg 1.5 us, max 3 us).
tools/testing/selftests/drivers/net/rdma/ carries no RMPP-specific
selftest in v7.1-rc2 (rdma_rxe self-tests do not exercise QP1 GMP
RMPP reassembly), so no in-tree selftest delta to report.

 drivers/infiniband/core/mad_rmpp.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/mad_rmpp.c b/drivers/infiniband/core/mad_rmpp.c
index 17c4c52a19e4c..4d55b133c689c 100644
--- a/drivers/infiniband/core/mad_rmpp.c
+++ b/drivers/infiniband/core/mad_rmpp.c
@@ -391,9 +391,25 @@ static inline struct ib_mad_recv_buf *get_next_seg(struct list_head *rmpp_list,
 	return container_of(seg->list.next, struct ib_mad_recv_buf, list);
 }
 
+/*
+ * Cap the per-RMPP-transaction in-flight window. find_seg_location()
+ * walks the rmpp_recv list reverse to find each insertion point, so the
+ * aggregate cost across an attacker-paced reordered window is O(N^2)
+ * under spin_lock_irqsave(&rmpp_recv->lock) in kworker context. The
+ * default recv_queue_size of 512 yields window=64, which keeps that
+ * cost in the noise; tuned configurations (recv_queue_size up to 8192)
+ * push window to 1024 and the per-port kworker measurably stalls under
+ * a low-bandwidth burst from any unauthenticated peer on QP1 GMP. Cap
+ * window at IB_MAD_RMPP_MAX_WINDOW so the bug class is structurally
+ * defused regardless of recv_queue_size tuning.
+ */
+#define IB_MAD_RMPP_MAX_WINDOW 64
+
 static inline int window_size(struct ib_mad_agent_private *agent)
 {
-	return max(agent->qp_info->recv_queue.max_active >> 3, 1);
+	int wsize = agent->qp_info->recv_queue.max_active >> 3;
+
+	return clamp(wsize, 1, IB_MAD_RMPP_MAX_WINDOW);
 }
 
 static struct ib_mad_recv_buf *find_seg_location(struct list_head *rmpp_list,
-- 
2.53.0


