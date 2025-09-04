Return-Path: <linux-rdma+bounces-13092-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D10DB4448F
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 19:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19AEEB603A2
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 17:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC043128CC;
	Thu,  4 Sep 2025 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="QrPWqgWj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDE63126A7
	for <linux-rdma@vger.kernel.org>; Thu,  4 Sep 2025 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007387; cv=none; b=OMqaOe6moEIIQtJWznBhCpsGrnBz1QzJ9UKAloolwAN0EEKz0XUW4Cej3XSu/cM3GxF5wkC99UPA0X3xzSl6coavinyGEuO1WnfTeAOcawnqTF+be9GBXD2A6Ikszmdf/xSqvDRG63Ppq1xCWYP+SXZUqHao0kInTLp62isyH24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007387; c=relaxed/simple;
	bh=wGdYw9GHeIPlRp1Ysex7HSV/+gvdo+NiqEXja58PcDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qLMheXvuAZHA626VhdvFzrFnHY/NFAt6Vt7y5ShZPaNzndY0DBGYPRzxMWA4IdhXRW+z9xAwwmpFfyMKExOmIKQVgDHTgQyyi9ZB9SCfNeEB2TCKIoEHH9+f+te6ExGS5uHG+fOvcIRxz1spUCm5p/Y3BlXK/9J9OyU49/hi5M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=QrPWqgWj; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=txwHOt9gKuXqa+PZyotxhB4q1hA3ycpEKMKuDnH8MiE=; b=QrPWqgWj7RgIklL0PNrTZ9otZr
	9LjIk0pfqr4Lt6D1XAqrzfgLrCeKy5lMIhNzmAXQ5sCJgpxjuJC7KBf3i4ptbT3jDzrrhi476U0kC
	t3q4V5Wbg2uhGZoldzNuwHKzXfwoBtxqDxyJm8IWwHXR56VIsxHjhIeH+bBInH/YbFAAtSz0kO2mW
	mDtW08z1md7MAZ7TpLashCqkJlWAyBqiEdEZBFbC7ctXW6IRVGVWbDLPV9z6p4mhkjmKL+2xtmDWG
	CEK4d6vkUBRo8VUtM3N0ezXyByoeF0mUX5Q3MEQSVfXIOUEAPSz0H9iOQBDZdepN0fnJeZvu0zX3G
	R9Qn2/qHV3mzn21pst1+7DuvEvOnSpp5GE36g2uTJRJs2nxgVF7/AMNqa7ceVAhGv2Mhw8JEepwJV
	O1zpDGtJ0spQafseQz3GYeSPpJEy/KLUrNkVBQ1JCTEPnNhz7j3YkGAkts0rxwWhdAk4NTuv0i9zS
	dVygsBC7GRAjU+B0qcWOVcW5;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uuDsd-002RgG-1y;
	Thu, 04 Sep 2025 17:36:15 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-rdma@vger.kernel.org
Cc: metze@samba.org,
	Bernard Metzler <bernard.metzler@linux.dev>
Subject: [PATCH] RDMA/siw: avoid hiding errors in siw_post_send()
Date: Thu,  4 Sep 2025 19:36:08 +0200
Message-ID: <20250904173608.1590444-1-metze@samba.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we hit situations like "sq full", "too many sge's" or similar
things while queueing sqes, we should remember the error before
rv = siw_activate_tx(qp); clears the return value.

Currently we hide such errors and confuse the caller
which is waiting (most likely forever) for a post completion
to arrive.

Also if we already queued some sqes with success we need to process
them as no error happened, but at the end we need to return the
error relative to the bad_wr to the caller.

Cc: Bernard Metzler <bernard.metzler@linux.dev>
Cc: linux-rdma@vger.kernel.org
Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 drivers/infiniband/sw/siw/siw_verbs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 556a2b4b42ed..a3f548652c37 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -770,6 +770,8 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 
 	unsigned long flags;
 	int rv = 0;
+	size_t num_queued = 0;
+	int error = 0;
 
 	if (wr && !rdma_is_kernel_res(&qp->base_qp.res)) {
 		siw_dbg_qp(qp, "wr must be empty for user mapped sq\n");
@@ -948,9 +950,24 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 		sqe->flags |= SIW_WQE_VALID;
 
 		qp->sq_put++;
+		num_queued++;
 		wr = wr->next;
 	}
 
+	if (unlikely(rv < 0)) {
+		/*
+		 * If at least one was queued
+		 * we should start the tx, but
+		 * still return an error with
+		 * the bad_wr at the end.
+		 */
+		error = rv;
+		if (num_queued == 0) {
+			spin_unlock_irqrestore(&qp->sq_lock, flags);
+			goto skip_direct_sending;
+		}
+	}
+
 	/*
 	 * Send directly if SQ processing is not in progress.
 	 * Eventual immediate errors (rv < 0) do not affect the involved
@@ -982,6 +999,9 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 
 	up_read(&qp->state_lock);
 
+	if (unlikely(error != 0))
+		rv = error;
+
 	if (rv >= 0)
 		return 0;
 	/*
-- 
2.43.0


