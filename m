Return-Path: <linux-rdma+bounces-22281-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PbiRLrh1MWqAjwUAu9opvQ
	(envelope-from <linux-rdma+bounces-22281-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 18:11:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF86691C91
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 18:11:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=nkXKFnCe;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22281-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22281-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 249663103CA7
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 15:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE48A44D6B2;
	Tue, 16 Jun 2026 15:56:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3043144CF44
	for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2026 15:56:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625365; cv=none; b=Pj/qn1IZTqKo7cRvAdxvmCK/OHdKLE5/2p6k9MpiSSOHK9DEyCtG4SaWjlOPClKIffkMnoKxnP33uhx791YEs0MNoMvSugMHPWGQAOPF/jpXsALY1y1V8M4/F6HzS6ddnRypd9/ate9KFi/i/eEoPw7F+0/EgSusqEFG5rIvDBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625365; c=relaxed/simple;
	bh=tVZPNwD/V1mksQohZmv8cQN6vUlXaq7quoVsxbrhCiE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=U8sOrBTGMzrfigvQo7m4i1CYFhbuRKGMiOearkM81ZxnPb/oB7WqV+hCl/PNErbtL7xwFDImp2fFq3ZjrkoMZ2Ns33h+PR9EH+kuWgeudKCj3JkTKtjxTSODYcoJ4T/DZTUQaVLXurLqhpSuRFzkr8SzF2V8Ty5UEqkbXtIQZuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nkXKFnCe; arc=none smtp.client-ip=209.85.222.202
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-915f6ff639aso1311602685a.1
        for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2026 08:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781625363; x=1782230163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gMgAvm/mMkJh8aXM5VMx5CRejsrbakwLznhjIQ8or4E=;
        b=nkXKFnCemwIV6qhQ8CvT/IJ6Yx77gk8DRwoT1G3+faeQlEh7EVjfRm6sOEsdhog+eK
         Vf32feSBypFIYWhkTXG1MrK+rmZkr0QeZ03z2YWGzooD75n/ZftzQDVrPwHrXcCfLMNN
         qk7Wa+SNh5Vsh66kISyo4eFWfEoGKLVVrRZdb4eUE9ovi8LQ08b5lvHAICw/nC1NIz9v
         HgrLLNR5GDpmHzaQLYNihzNmzpqcYqtVT6cKI+sJoeQtBKgaVPYyDpf1ArNOm86nSeMG
         Fqo5dhR/Qnj8hn+wUrmsmLJWCYoiKMbDdginFR73ZdUUafDAETRHSrjlYpu1cS0+yivL
         3k1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781625363; x=1782230163;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gMgAvm/mMkJh8aXM5VMx5CRejsrbakwLznhjIQ8or4E=;
        b=jNhf85+S5h7LZimVzEwm4FJQFmhlXKC3a03djDm4/P2mVxWCbQ1oG3gXwh1LAcrFEW
         Z3WTsSNHAKsWHu6o6Owk5xfM8nR1n2Sbk3I5hs+w7xjVZC+2JShw0IfhKz3ksSmgDH6i
         nSoCn84muBwH29skHtAgaReBRGiCeM99vGapJ3CPZ+OG+1VKyryUm+kT5GI/yMm1oe0K
         jaK/XnBaTxg/0puhTqTG+cTTTUXTj3AKbd1oHLYFChbQJSerROQsqYd5uvjnrrmTGMe3
         10k9j1rVJr1eTcrS8+2ZVUGL9LNd+vO2Pf9hzTxAEAmblnpmjo/1q8ERjQ84K4oz56+D
         aV7Q==
X-Gm-Message-State: AOJu0Yz/68gbNqgumcCCmkmuXoH5iPce8b0tGyWKrnYYYBzwPQvaIhaW
	YOgiTSHB3P378a1ovhWcJ3lkPwrmf5EUWTgwfe3f7zaqf4qUAx9zGfRf0Sic+k/0lWvhU7CCVZ+
	sECZaayLZtA==
X-Received: from qkhp4.prod.google.com ([2002:a05:620a:22a4:b0:915:6dc3:adc2])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:19a2:b0:916:1306:73e3
 with SMTP id af79cd13be357-91d8b5b1c4bmr41839485a.21.1781625362617; Tue, 16
 Jun 2026 08:56:02 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:56:01 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616155601.1081448-1-jmoroni@google.com>
Subject: [PATCH rdma-next] RDMA/irdma: Replace waitqueue and flag with completion
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:jmoroni@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22281-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CF86691C91

The driver previously used a waitqueue along with an explicit
request_done flag, but without proper barriers around request_done.

An earlier patch by Gui-Dong Han <hanguidong02@gmail.com> attempted
to fix this by adding the missing memory barriers. Rather than
adding the barriers, this patch replaces the waitqueue+flag with
a completion, which is designed for this exact purpose.

Link: https://lore.kernel.org/linux-rdma/20260604135513.GU2487554@ziepe.ca/T/#t
Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitions")
Fixes: 915cc7ac0f8e ("RDMA/irdma: Add miscellaneous utility definitions")
Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/hw.c    |  7 +++----
 drivers/infiniband/hw/irdma/main.h  |  3 +--
 drivers/infiniband/hw/irdma/utils.c | 12 +++++-------
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index f9be467d13..c345cc6542 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -235,8 +235,7 @@ static void irdma_complete_cqp_request(struct irdma_cqp *cqp,
 				       struct irdma_cqp_request *cqp_request)
 {
 	if (cqp_request->waiting) {
-		WRITE_ONCE(cqp_request->request_done, true);
-		wake_up(&cqp_request->waitq);
+		complete_all(&cqp_request->comp);
 	} else if (cqp_request->callback_fcn) {
 		cqp_request->callback_fcn(cqp_request);
 	}
@@ -1107,9 +1106,9 @@ static int irdma_create_cqp(struct irdma_pci_f *rf)
 	INIT_LIST_HEAD(&cqp->cqp_avail_reqs);
 	INIT_LIST_HEAD(&cqp->cqp_pending_reqs);
 
-	/* init the waitqueue of the cqp_requests and add them to the list */
+	/* init the completion of the cqp_requests and add them to the list */
 	for (i = 0; i < sqsize; i++) {
-		init_waitqueue_head(&cqp->cqp_requests[i].waitq);
+		init_completion(&cqp->cqp_requests[i].comp);
 		list_add_tail(&cqp->cqp_requests[i].list, &cqp->cqp_avail_reqs);
 	}
 	init_waitqueue_head(&cqp->remove_wq);
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 3d49bd57ba..8c17a201c1 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -161,13 +161,12 @@ struct irdma_cqp_compl_info {
 
 struct irdma_cqp_request {
 	struct cqp_cmds_info info;
-	wait_queue_head_t waitq;
+	struct completion comp;
 	struct list_head list;
 	refcount_t refcnt;
 	void (*callback_fcn)(struct irdma_cqp_request *cqp_request);
 	void *param;
 	struct irdma_cqp_compl_info compl_info;
-	bool request_done; /* READ/WRITE_ONCE macros operate on it */
 	bool waiting:1;
 	bool dynamic:1;
 	bool pending:1;
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 7cc7b107db..e4037d5ef8 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -442,7 +442,7 @@ struct irdma_cqp_request *irdma_alloc_and_get_cqp_request(struct irdma_cqp *cqp,
 		if (cqp_request) {
 			cqp_request->dynamic = true;
 			if (wait)
-				init_waitqueue_head(&cqp_request->waitq);
+				init_completion(&cqp_request->comp);
 		}
 	}
 	if (!cqp_request) {
@@ -480,7 +480,7 @@ void irdma_free_cqp_request(struct irdma_cqp *cqp,
 	if (cqp_request->dynamic) {
 		kfree(cqp_request);
 	} else {
-		WRITE_ONCE(cqp_request->request_done, false);
+		reinit_completion(&cqp_request->comp);
 		cqp_request->callback_fcn = NULL;
 		cqp_request->waiting = false;
 		cqp_request->pending = false;
@@ -515,8 +515,7 @@ irdma_free_pending_cqp_request(struct irdma_cqp *cqp,
 {
 	if (cqp_request->waiting) {
 		cqp_request->compl_info.error = true;
-		WRITE_ONCE(cqp_request->request_done, true);
-		wake_up(&cqp_request->waitq);
+		complete_all(&cqp_request->comp);
 	}
 	wait_event_timeout(cqp->remove_wq,
 			   refcount_read(&cqp_request->refcnt) == 1, 1000);
@@ -609,9 +608,8 @@ static int irdma_wait_event(struct irdma_pci_f *rf,
 	cqp_timeout.compl_cqp_cmds = atomic64_read(&rf->sc_dev.cqp->completed_ops);
 	do {
 		irdma_cqp_ce_handler(rf, &rf->ccq.sc_cq);
-		if (wait_event_timeout(cqp_request->waitq,
-				       READ_ONCE(cqp_request->request_done),
-				       msecs_to_jiffies(CQP_COMPL_WAIT_TIME_MS)))
+		if (wait_for_completion_timeout(&cqp_request->comp,
+					msecs_to_jiffies(CQP_COMPL_WAIT_TIME_MS)))
 			break;
 
 		if (cqp_request->pending)
-- 
2.54.0.1136.gdb2ca164c4-goog


