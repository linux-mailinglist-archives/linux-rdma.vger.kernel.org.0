Return-Path: <linux-rdma+bounces-21737-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bdv+NDw5IWpyBQEAu9opvQ
	(envelope-from <linux-rdma+bounces-21737-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 10:37:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C27663E0A8
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 10:37:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NFFN72BT;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21737-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21737-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99F09306B08C
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 08:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868D13C9438;
	Thu,  4 Jun 2026 08:35:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1E538F957
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2026 08:34:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562100; cv=none; b=kF2K7C0OXJOiiOi/cWkDQ1FRdbY99oIDkmzoYimA4U1qrZc9Vi2eTTQMS8aBUWyNeXCSiJJ8xhOjFE0C47OWOvRuXaXFfezY3m4RfnWeDUKN69y//+xhy9lA5cIr2MBc7kmzRmQ6quk8O/UNPNjc00JrXVU/gGyRlB2l1wjwSEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562100; c=relaxed/simple;
	bh=7xkCNWzTHwH4KjhG82guMkcHYLVCOZWaHOgz2v54Nus=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Els9Ai5xf4xbt6r4Fvi9vnwr82n6icRpY9GSX2A4BGCg1+UP3Mw0dPaSM6yi16QPUoI4jHFss+28M2G+0Rof6dPcleHMDKs2arM4fq7hnRA4mdGsK6fanXu4vO2mcVcj/R1B4Wm3RoMVFLg4VYdwu+v+3gbHWVvqeD3pauXCgf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFFN72BT; arc=none smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf30d530bdso4670155ad.3
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jun 2026 01:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780562098; x=1781166898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2bzSs0ZVqqiauGWrvhNjF8srpvUpc4xJa5mRvzbd3e8=;
        b=NFFN72BTn8BIZRQulHqCvRxbr7chbmPbBcl0Ob3Ed/cshmZa/GEI68aAk7c/1rGcyD
         SnkqUyQu0NnAg2vXRbW7DV+LCI++YtCxpTRsEjcEF+QJHP9pzvTsaQ6A501kA41ymJiP
         /hZnlVReKdBycG3U0uG56IUb8T+/ATrJIbx5Zw2XQO5b/9Cn5i2+4uY5dd+3AJrB2pqi
         VhDfbtCipagJNclJhxiS7pat/CY/QKkZBcNaMNI21dJmI51LIpdRgGnWZsFomvFrDAWo
         Sv9Q+hB6TlG/CG++D5uza8sgggqBEe5DawXlv/cKfWU1C5CepeOpN6MbM5mu5Wn6k8A1
         Lm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780562098; x=1781166898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bzSs0ZVqqiauGWrvhNjF8srpvUpc4xJa5mRvzbd3e8=;
        b=ZBvpZnrA+Fx9SrQ7MwVYQeoltaOzD92D8j77dJMeKeadRWVDE4dBagYzzUg1WOLr7c
         cw8Bjht0Ry6S6684okkdtBmfcsodrcSMzNuXrL11zocuhJiguci1BSbVWFfbr6GbOGSa
         o6zwMx62P+XU87zeZr2vbKyaSU83BgUtQr4Xmpi8SgAU1d1B3V/gWHctUW5nn9zZDmCp
         a4GJDQkUBTNMm+teJEtaQH6KvNSLkS9H6MX20BRRdPApJJFwjyHRmW8w6rOyxuLP1tdC
         +osVfb6pQ/rfxuDd6oPuZ69p+wsVqk3KRxWz0JDwClzQ2LicJdu2PHZUhj5S8VdxamQ+
         BTFw==
X-Forwarded-Encrypted: i=1; AFNElJ/5prz3sjroNeWqkNHh7C10N74MM2+Mp6f3XgKQpmfaf/k5/SleoiuajlhTQ7rzPQ8Ae3UjB2EcrJqF@vger.kernel.org
X-Gm-Message-State: AOJu0YwM9JTBi33+778wpml3MMeaQjs5EhBzV/hqGIgBO1zvESCNr9to
	gWH0JzXlw9rPWgC/qd/3CmB+BHWg8R9+qvDiFKfCKteM2mhmNqxYUiO8
X-Gm-Gg: Acq92OEyacGTCVGpAK1oHlJeiDXzbM9LI9ZBQLl6ccXHfzSVVCvt15UO5izvVNKOBFU
	ff5t0tmmV9U+COfNPCQtNZg7FzAoME3JLpPFpAWNh2HyGaO1AT5kYUDX2ObTpSFkJKy2WNcsiR1
	NIwb1d1eyaLicsjiMVen+D1enPzJUChjFawdNSKz8DHkFhDksKX8QP/u/i9dbRZ2pHxqBiyV7ZN
	mI6dIp9t8D3oENCQjucLD1EliCj7oDTGLXjmBYB0CW0MrzKe/+rggtA8+MrfOC3af9Ke9iXpVcw
	DxjXCj8UIWS62vpHsv+kpPJcnH0OIKnn2mjTqVRMY+4NduAuJ3oX4oZdoERNCcJtKQkxTKaC6N6
	SQDjKQ9xdmGe7Of3o4y/6L7hkGEee1tcusvQdzKJlAJXoaIKA6raMsCPOSPgsXoBcLZqmRKB6LZ
	3BPMlWb4re6moGlzlyacriDJEUFMKPqTXITIJY7N96/DXRkIg6Apot8M7cVk7N6HiXuBgMvplc3
	ksgZHCuTIWt10itmBf1YE54egpYoD3GBvZWq8PVDsWkXLXGWhoXJx7IYYfbQwN7YwRc
X-Received: by 2002:a17:903:1a4e:b0:2c0:c4c9:4cb with SMTP id d9443c01a7336-2c163a592f1mr74142365ad.14.1780562098075;
        Thu, 04 Jun 2026 01:34:58 -0700 (PDT)
Received: from bass-virtual-machine.. ([111.202.175.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f84335sm50117445ad.19.2026.06.04.01.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 01:34:56 -0700 (PDT)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: krzysztof.czurylo@intel.com,
	tatyana.e.nikolova@intel.com,
	linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mustafa.ismail@intel.com,
	shiraz.saleem@intel.com,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH] RDMA/irdma: Use acquire/release for CQP request completion
Date: Thu,  4 Jun 2026 16:34:40 +0800
Message-Id: <20260604083440.426033-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[ziepe.ca,kernel.org,intel.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21737-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:krzysztof.czurylo@intel.com,m:tatyana.e.nikolova@intel.com,m:linux-rdma@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:mustafa.ismail@intel.com,m:shiraz.saleem@intel.com,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,m:hanguidong02@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hanguidong02@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hanguidong02@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C27663E0A8

The completion path fills cqp_request->compl_info before marking
request_done and waking waiters. irdma_wait_event() waits for
request_done before reading compl_info.

READ_ONCE()/WRITE_ONCE() do not order these accesses, so a waiter can
observe request_done while still seeing stale completion information.

Use release/acquire helpers for request_done to publish compl_info to the
waiting thread.

Clearing request_done does not publish completion information. It only
reinitializes a private request before returning it to cqp_avail_reqs under
req_lock, so WRITE_ONCE() is enough for the false transition.

Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitions")
Fixes: 915cc7ac0f8e ("RDMA/irdma: Add miscellaneous utility definitions")
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
Found by auditing READ_ONCE() used for synchronization.
A similar fix can be found in 8df672bfe3ec.
---
 drivers/infiniband/hw/irdma/hw.c    |  2 +-
 drivers/infiniband/hw/irdma/main.h  | 22 +++++++++++++++++++++-
 drivers/infiniband/hw/irdma/utils.c |  6 +++---
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index f9be467d137f..96fecb28af97 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -235,7 +235,7 @@ static void irdma_complete_cqp_request(struct irdma_cqp *cqp,
 				       struct irdma_cqp_request *cqp_request)
 {
 	if (cqp_request->waiting) {
-		WRITE_ONCE(cqp_request->request_done, true);
+		irdma_cqp_request_mark_done(cqp_request);
 		wake_up(&cqp_request->waitq);
 	} else if (cqp_request->callback_fcn) {
 		cqp_request->callback_fcn(cqp_request);
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 3d49bd57bae7..57102278ed64 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -167,12 +167,32 @@ struct irdma_cqp_request {
 	void (*callback_fcn)(struct irdma_cqp_request *cqp_request);
 	void *param;
 	struct irdma_cqp_compl_info compl_info;
-	bool request_done; /* READ/WRITE_ONCE macros operate on it */
+	bool request_done; /* Use irdma_cqp_request_*() helpers. */
 	bool waiting:1;
 	bool dynamic:1;
 	bool pending:1;
 };
 
+static inline void
+irdma_cqp_request_clear_done(struct irdma_cqp_request *cqp_request)
+{
+	WRITE_ONCE(cqp_request->request_done, false);
+}
+
+static inline void
+irdma_cqp_request_mark_done(struct irdma_cqp_request *cqp_request)
+{
+	/* Publish compl_info before waking the waiter. */
+	smp_store_release(&cqp_request->request_done, true);
+}
+
+static inline bool
+irdma_cqp_request_is_done(struct irdma_cqp_request *cqp_request)
+{
+	/* Pair with irdma_cqp_request_mark_done(). */
+	return smp_load_acquire(&cqp_request->request_done);
+}
+
 struct irdma_cqp {
 	struct irdma_sc_cqp sc_cqp;
 	spinlock_t req_lock; /* protect CQP request list */
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 495e5daff4b4..566f690a4e58 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -480,7 +480,7 @@ void irdma_free_cqp_request(struct irdma_cqp *cqp,
 	if (cqp_request->dynamic) {
 		kfree(cqp_request);
 	} else {
-		WRITE_ONCE(cqp_request->request_done, false);
+		irdma_cqp_request_clear_done(cqp_request);
 		cqp_request->callback_fcn = NULL;
 		cqp_request->waiting = false;
 		cqp_request->pending = false;
@@ -515,7 +515,7 @@ irdma_free_pending_cqp_request(struct irdma_cqp *cqp,
 {
 	if (cqp_request->waiting) {
 		cqp_request->compl_info.error = true;
-		WRITE_ONCE(cqp_request->request_done, true);
+		irdma_cqp_request_mark_done(cqp_request);
 		wake_up(&cqp_request->waitq);
 	}
 	wait_event_timeout(cqp->remove_wq,
@@ -610,7 +610,7 @@ static int irdma_wait_event(struct irdma_pci_f *rf,
 	do {
 		irdma_cqp_ce_handler(rf, &rf->ccq.sc_cq);
 		if (wait_event_timeout(cqp_request->waitq,
-				       READ_ONCE(cqp_request->request_done),
+				       irdma_cqp_request_is_done(cqp_request),
 				       msecs_to_jiffies(CQP_COMPL_WAIT_TIME_MS)))
 			break;
 
-- 
2.34.1


