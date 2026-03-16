Return-Path: <linux-rdma+bounces-18196-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED0rFDNQuGlHbwEAu9opvQ
	(envelope-from <linux-rdma+bounces-18196-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:47:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA12829F355
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89286308B99B
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 18:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7F13E023E;
	Mon, 16 Mar 2026 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j9B3skJG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DE83E122E
	for <linux-rdma@vger.kernel.org>; Mon, 16 Mar 2026 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686463; cv=none; b=UaaYmFcvSxXTIiBvjRXlyZk2GRQSdM6/i8nIX9AZ0tJeCW8vT19OLTn0nOxK46r1MlYTqTNhAveDQad9k78Y1j0qvFKw9wq6QXvq804BrllkAMl7qxaIZeuysbnLIlzuwrPE9W9AvfX7ElCj7LYvS7vhdgSb9zDaPIMH9zRh29s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686463; c=relaxed/simple;
	bh=JYpXKESzDw8TuJhRA/Ci48Id9XcEAKY0UtOAcOSU7us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ih0I0Qu8iAlI8mcs/u0IPDbvT1Ve2CRne2P2WvzsEQ9L6UvCNT7KdHY3iDQEYtnP7iq6CoqBM+3U3l61sFo5RnpM/74peI3tMjwYhlE3H61J12tU3VGTArvmnZI3Jj30XgNzQ6O8rONwykNYwy5N/xtTjDQHj6M5qLuAYZcYYKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j9B3skJG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773686455; x=1805222455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JYpXKESzDw8TuJhRA/Ci48Id9XcEAKY0UtOAcOSU7us=;
  b=j9B3skJGilFBGNPMEq4qrJ2fXkdIO/UTn8Ox71JXX0GEyi00wkQscVMQ
   8GnmGOzc758sODe+r3OvhAyBtwL/3/aYrh9d9MpeWm6W1rJehLpCjGuh5
   VgZE+b7sRwy21ndwMAXSvaPs4CXwBhVPgxpq/6uKqTx+6Nu5U4n2hE35r
   ipuopz89sZ3BWNHdffxOIBdfYTVhboHsZvBlsvzYXP9hVLjD42WgKpYU+
   4STLo8sQRIOmz362HJG1rac01113oCmIxSbDAXe4pZyxLLRKjdGG84CJt
   IJSYxZhIlXMMvXDz2X7qzXbjRjxpet6+8q/QtnCEsbX6rFMYGAC0fTxlO
   Q==;
X-CSE-ConnectionGUID: dQYISNjcQKaNa7iaiikToA==
X-CSE-MsgGUID: bKoZSrhcQvuUQZ58VZaWVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86067599"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="86067599"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:40:47 -0700
X-CSE-ConnectionGUID: qadR5fuTRhe0+cVRRxgXSw==
X-CSE-MsgGUID: AGzEmem/R9icyIOS3wH03g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="252520412"
Received: from soc-pf51ragt.clients.intel.com ([10.122.184.229])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:40:45 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com
Subject: [for-next 03/12] RDMA/irdma: Change ah_valid type to atomic
Date: Mon, 16 Mar 2026 13:39:40 -0500
Message-ID: <20260316183949.261-4-tatyana.e.nikolova@intel.com>
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
	TAGGED_FROM(0.00)[bounces-18196-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: BA12829F355
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Krzysztof Czurylo <krzysztof.czurylo@intel.com>

Converts ah_valid flag to atomic to protect it against data-race.

[  809.561229] BUG: KCSAN: data-race in irdma_create_hw_ah [irdma] / irdma_gsi_ud_qp_ah_cb [irdma]

[  809.565182] write to 0xffff8d911c8eee73 of 1 bytes by task 38949 on cpu 10:
[  809.567113]  irdma_gsi_ud_qp_ah_cb+0x41/0x60 [irdma]
[  809.567343]  irdma_complete_cqp_request+0x44/0xb0 [irdma]
[  809.567572]  irdma_cqp_ce_handler+0x242/0x290 [irdma]
[  809.567810]  irdma_wait_event+0xf2/0x3c0 [irdma]

[  809.570951] read to 0xffff8d911c8eee73 of 1 bytes by task 38952 on cpu 7:
[  809.573037]  irdma_create_hw_ah+0x1e7/0x370 [irdma]
[  809.573265]  irdma_create_ah+0x61/0x70 [irdma]
[  809.573491]  _rdma_create_ah+0x262/0x290 [ib_core]
[  809.573831]  rdma_create_ah+0xa3/0x140 [ib_core]

[  809.576933] value changed: 0x06 -> 0x07
[  809.581184] Reported by Kernel Concurrency Sanitizer

Fixes: dd90451fac23 ("RDMA/irdma: Add RoCEv2 UD OP support")
Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/cm.c    |  2 +-
 drivers/infiniband/hw/irdma/puda.c  |  2 +-
 drivers/infiniband/hw/irdma/uda.h   |  2 +-
 drivers/infiniband/hw/irdma/utils.c | 16 +++++++++-------
 drivers/infiniband/hw/irdma/verbs.c |  7 ++++---
 5 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index 3d084d4ff577..947fd93f5fb0 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -313,7 +313,7 @@ static struct irdma_puda_buf *irdma_form_ah_cm_frame(struct irdma_cm_node *cm_no
 	u32 pd_len = 0;
 	u32 hdr_len = 0;
 
-	if (!cm_node->ah || !cm_node->ah->ah_info.ah_valid) {
+	if (!cm_node->ah || !atomic_read(&cm_node->ah->ah_info.ah_valid)) {
 		ibdev_dbg(&cm_node->iwdev->ibdev, "CM: AH invalid\n");
 		return NULL;
 	}
diff --git a/drivers/infiniband/hw/irdma/puda.c b/drivers/infiniband/hw/irdma/puda.c
index 4f1a8c97faf1..3410be38f602 100644
--- a/drivers/infiniband/hw/irdma/puda.c
+++ b/drivers/infiniband/hw/irdma/puda.c
@@ -1652,7 +1652,7 @@ static void irdma_ieq_handle_exception(struct irdma_puda_rsrc *ieq,
 	}
 	if (hw_rev == IRDMA_GEN_1)
 		irdma_ieq_process_fpdus(qp, ieq);
-	else if (pfpdu->ah && pfpdu->ah->ah_info.ah_valid)
+	else if (pfpdu->ah && atomic_read(&pfpdu->ah->ah_info.ah_valid))
 		irdma_ieq_process_fpdus(qp, ieq);
 exit:
 	spin_unlock_irqrestore(&pfpdu->lock, flags);
diff --git a/drivers/infiniband/hw/irdma/uda.h b/drivers/infiniband/hw/irdma/uda.h
index 27b8701cf21b..773c33ce62a2 100644
--- a/drivers/infiniband/hw/irdma/uda.h
+++ b/drivers/infiniband/hw/irdma/uda.h
@@ -22,7 +22,7 @@ struct irdma_ah_info {
 	u8 tc_tos;
 	u8 hop_ttl;
 	u8 mac_addr[ETH_ALEN];
-	bool ah_valid:1;
+	atomic_t ah_valid;
 	bool ipv4_valid:1;
 	bool do_lpbk:1;
 };
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index f9c99c216a2c..be2dc92d008f 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -1967,7 +1967,8 @@ int irdma_ah_cqp_op(struct irdma_pci_f *rf, struct irdma_sc_ah *sc_ah, u8 cmd,
 		return -ENOMEM;
 
 	if (wait)
-		sc_ah->ah_info.ah_valid = (cmd == IRDMA_OP_AH_CREATE);
+		atomic_set(&sc_ah->ah_info.ah_valid,
+			   (cmd == IRDMA_OP_AH_CREATE));
 
 	return 0;
 }
@@ -1984,10 +1985,10 @@ static void irdma_ieq_ah_cb(struct irdma_cqp_request *cqp_request)
 
 	spin_lock_irqsave(&qp->pfpdu.lock, flags);
 	if (!cqp_request->compl_info.op_ret_val) {
-		sc_ah->ah_info.ah_valid = true;
+		atomic_set(&sc_ah->ah_info.ah_valid, true);
 		irdma_ieq_process_fpdus(qp, qp->vsi->ieq);
 	} else {
-		sc_ah->ah_info.ah_valid = false;
+		atomic_set(&sc_ah->ah_info.ah_valid, false);
 		irdma_ieq_cleanup_qp(qp->vsi->ieq, qp);
 	}
 	spin_unlock_irqrestore(&qp->pfpdu.lock, flags);
@@ -2002,7 +2003,8 @@ static void irdma_ilq_ah_cb(struct irdma_cqp_request *cqp_request)
 	struct irdma_cm_node *cm_node = cqp_request->param;
 	struct irdma_sc_ah *sc_ah = cm_node->ah;
 
-	sc_ah->ah_info.ah_valid = !cqp_request->compl_info.op_ret_val;
+	atomic_set(&sc_ah->ah_info.ah_valid,
+		   !cqp_request->compl_info.op_ret_val);
 	irdma_add_conn_est_qh(cm_node);
 }
 
@@ -2069,7 +2071,7 @@ void irdma_puda_free_ah(struct irdma_sc_dev *dev, struct irdma_sc_ah *ah)
 	if (!ah)
 		return;
 
-	if (ah->ah_info.ah_valid) {
+	if (atomic_read(&ah->ah_info.ah_valid)) {
 		irdma_ah_cqp_op(rf, ah, IRDMA_OP_AH_DESTROY, false, NULL, NULL);
 		irdma_free_rsrc(rf, rf->allocated_ahs, ah->ah_info.ah_idx);
 	}
@@ -2086,9 +2088,9 @@ void irdma_gsi_ud_qp_ah_cb(struct irdma_cqp_request *cqp_request)
 	struct irdma_sc_ah *sc_ah = cqp_request->param;
 
 	if (!cqp_request->compl_info.op_ret_val)
-		sc_ah->ah_info.ah_valid = true;
+		atomic_set(&sc_ah->ah_info.ah_valid, true);
 	else
-		sc_ah->ah_info.ah_valid = false;
+		atomic_set(&sc_ah->ah_info.ah_valid, false);
 }
 
 /**
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 38bc0e656ecf..9cfcdf7b053e 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -5116,8 +5116,8 @@ static int irdma_create_hw_ah(struct irdma_device *iwdev, struct irdma_ah *ah, b
 
 		if (poll_timeout_us_atomic(irdma_cqp_ce_handler(rf,
 								&rf->ccq.sc_cq),
-					   ah->sc_ah.ah_info.ah_valid, 1,
-					   tmout_ms * USEC_PER_MSEC, false)) {
+					   atomic_read(&ah->sc_ah.ah_info.ah_valid),
+					   1, tmout_ms * USEC_PER_MSEC, false)) {
 			ibdev_dbg(&iwdev->ibdev,
 				  "VERBS: CQP create AH timed out");
 			err = -ETIMEDOUT;
@@ -5236,7 +5236,8 @@ static bool irdma_ah_exists(struct irdma_device *iwdev,
 	hash_for_each_possible(iwdev->rf->ah_hash_tbl, ah, list, key) {
 		/* Set ah_valid and ah_id the same so memcmp can work */
 		new_ah->sc_ah.ah_info.ah_idx = ah->sc_ah.ah_info.ah_idx;
-		new_ah->sc_ah.ah_info.ah_valid = ah->sc_ah.ah_info.ah_valid;
+		atomic_set(&new_ah->sc_ah.ah_info.ah_valid,
+			   atomic_read(&ah->sc_ah.ah_info.ah_valid));
 		if (!memcmp(&ah->sc_ah.ah_info, &new_ah->sc_ah.ah_info,
 			    sizeof(ah->sc_ah.ah_info))) {
 			refcount_inc(&ah->refcnt);
-- 
2.31.1


