Return-Path: <linux-rdma+bounces-18194-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL+rIrRPuGlHbwEAu9opvQ
	(envelope-from <linux-rdma+bounces-18194-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:45:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0158E29F32E
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A73093065850
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 18:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79E33E3C5E;
	Mon, 16 Mar 2026 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cthQdFD+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF24A3DFC9D
	for <linux-rdma@vger.kernel.org>; Mon, 16 Mar 2026 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686458; cv=none; b=XmjsJNyECbnWWk/0mW/3p+dw8T122OwQ2mogJ+NvDcjjkPa3dCy6KUEDzweQkQR9OEvsWbtRNI9vf3TQE0l+uUVoERRHcJpv2Io1QKsFfJd/k90FoNj+I1u31VRRFN+cZ1xpCptvAOgt778ogS+oxSFjr/DVgkBPhnIYlcmH90k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686458; c=relaxed/simple;
	bh=3RDmxZzhEyMJUmko1lEtLMIxm0kKjBq8yagWDQyfQDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ir8LcUBioeXfvJrf1y9rrpaWnoqr1AIPvHsvnyoeBLkvS2ujgqNfxx1avmCkUZV7sZ7NpyrxoFPPalk7OSQbRTSBkt/bBhm5plp92vsyjFQ7Sax78IvVrDzmBVlJuGNdflG5kT42jdaw4eLiD3WJFvAVOXxvb/sRFW+AlbUdWJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cthQdFD+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773686450; x=1805222450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3RDmxZzhEyMJUmko1lEtLMIxm0kKjBq8yagWDQyfQDQ=;
  b=cthQdFD+b2gCbAn4pgxZR285FYsVttvgmvMbQa8UD7fkyiVIiord4CDC
   2bYGSyXvBUSWQMuf4WjnCNys1YWdPFSSIQv9uz7oOHPKSFiTEVi8nKla6
   s4ODhfs/yEBSOBi50zO5GQIfvWWiHnmJ7xe+WZ8yJPnbWZ6FpzjBSC3R1
   hUUcpLYgHPGwctsCcEKdjGjTDkO/kuZpAsesi8BcaQMTCnbFW1Ahrc0HS
   JNmpjPNvzfDupSxAosapcRQReLFSNTpUiTsLwHXtGKrPqHH5eWWy+5pSl
   thBtEpes6wPPRYCXv123eS9StBovYt97q5njfYeO0RdtprZWOUJNu8Bzl
   A==;
X-CSE-ConnectionGUID: A6QKbcvSSs+7czcR5eNQ6g==
X-CSE-MsgGUID: BsIBxbO2SH6XXzkBcX9+oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86067596"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="86067596"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:40:46 -0700
X-CSE-ConnectionGUID: /n/+g4+TR3uQJi+sgdCPXA==
X-CSE-MsgGUID: 5GBLQuCyRyeG7/7gluV+9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="252520408"
Received: from soc-pf51ragt.clients.intel.com ([10.122.184.229])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:40:44 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com
Subject: [for-next 02/12] RDMA/irdma: Fix data race on cqp_request->request_done
Date: Mon, 16 Mar 2026 13:39:39 -0500
Message-ID: <20260316183949.261-3-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20260316183949.261-1-tatyana.e.nikolova@intel.com>
References: <20260316183949.261-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18194-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tatyana.e.nikolova@intel.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0158E29F32E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Krzysztof Czurylo <krzysztof.czurylo@intel.com>

Changes type of request_done flag from bool to atomic_t to fix
data race in irdma_complete_cqp_request / irdma_wait_event
reported by KCSAN:

BUG: KCSAN: data-race in irdma_complete_cqp_request [irdma] / irdma_wait_event [irdma]

write (marked) to 0xffffa0bef390ad5c of 1 bytes by task 7761 on cpu 0:
 irdma_complete_cqp_request+0x19/0x90 [irdma]
 irdma_cqp_ce_handler+0x22d/0x290 [irdma]
 cqp_compl_worker+0x1f/0x30 [irdma]
 process_one_work+0x3dc/0x7c0
 worker_thread+0xa6/0x6c0
 kthread+0x17f/0x1c0
 ret_from_fork+0x2c/0x50

read to 0xffffa0bef390ad5c of 1 bytes by task 28566 on cpu 3:
 irdma_wait_event+0x242/0x390 [irdma]
 irdma_handle_cqp_op+0x93/0x210 [irdma]
 irdma_hw_modify_qp+0xe3/0x2f0 [irdma]
 irdma_modify_qp_roce+0x13df/0x1630 [irdma]
 ib_security_modify_qp+0x34a/0x640 [ib_core]
 _ib_modify_qp+0x16b/0x620 [ib_core]
 ib_modify_qp_with_udata+0x3c/0x50 [ib_core]
 modify_qp+0x6e1/0x920 [ib_uverbs]
 ib_uverbs_ex_modify_qp+0xa6/0xf0 [ib_uverbs]
 ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x16c/0x200 [ib_uverbs]
 ib_uverbs_run_method+0x342/0x380 [ib_uverbs]
 ib_uverbs_cmd_verbs+0x365/0x440 [ib_uverbs]
 ib_uverbs_ioctl+0x111/0x190 [ib_uverbs]
 __x64_sys_ioctl+0xc3/0x100
 do_syscall_64+0x3f/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

value changed: 0x00 -> 0x01

Fixes: f0842bb3d388 ("RDMA/irdma: Fix data race on CQP request done")
Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/hw.c    | 2 +-
 drivers/infiniband/hw/irdma/main.h  | 2 +-
 drivers/infiniband/hw/irdma/utils.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 6e0466ce83d1..3ba4809bc1ef 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -235,7 +235,7 @@ static void irdma_complete_cqp_request(struct irdma_cqp *cqp,
 				       struct irdma_cqp_request *cqp_request)
 {
 	if (cqp_request->waiting) {
-		WRITE_ONCE(cqp_request->request_done, true);
+		atomic_set(&cqp_request->request_done, true);
 		wake_up(&cqp_request->waitq);
 	} else if (cqp_request->callback_fcn) {
 		cqp_request->callback_fcn(cqp_request);
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 3d49bd57bae7..e22160e2ba33 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -167,7 +167,7 @@ struct irdma_cqp_request {
 	void (*callback_fcn)(struct irdma_cqp_request *cqp_request);
 	void *param;
 	struct irdma_cqp_compl_info compl_info;
-	bool request_done; /* READ/WRITE_ONCE macros operate on it */
+	atomic_t request_done;
 	bool waiting:1;
 	bool dynamic:1;
 	bool pending:1;
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index ab8c5284d4be..f9c99c216a2c 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -480,7 +480,7 @@ void irdma_free_cqp_request(struct irdma_cqp *cqp,
 	if (cqp_request->dynamic) {
 		kfree(cqp_request);
 	} else {
-		WRITE_ONCE(cqp_request->request_done, false);
+		atomic_set(&cqp_request->request_done, false);
 		cqp_request->callback_fcn = NULL;
 		cqp_request->waiting = false;
 		cqp_request->pending = false;
@@ -515,7 +515,7 @@ irdma_free_pending_cqp_request(struct irdma_cqp *cqp,
 {
 	if (cqp_request->waiting) {
 		cqp_request->compl_info.error = true;
-		WRITE_ONCE(cqp_request->request_done, true);
+		atomic_set(&cqp_request->request_done, true);
 		wake_up(&cqp_request->waitq);
 	}
 	wait_event_timeout(cqp->remove_wq,
@@ -610,7 +610,7 @@ static int irdma_wait_event(struct irdma_pci_f *rf,
 	do {
 		irdma_cqp_ce_handler(rf, &rf->ccq.sc_cq);
 		if (wait_event_timeout(cqp_request->waitq,
-				       READ_ONCE(cqp_request->request_done),
+				       atomic_read(&cqp_request->request_done),
 				       msecs_to_jiffies(CQP_COMPL_WAIT_TIME_MS)))
 			break;
 
-- 
2.31.1


