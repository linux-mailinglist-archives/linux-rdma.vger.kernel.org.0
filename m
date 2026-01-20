Return-Path: <linux-rdma+bounces-15786-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KeZJV8FcGmUUgAAu9opvQ
	(envelope-from <linux-rdma+bounces-15786-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 23:44:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 317C64D2EC
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 23:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D4A1AA2757
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 21:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E163D412F;
	Tue, 20 Jan 2026 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nb1FUFsz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B64E3793C2
	for <linux-rdma@vger.kernel.org>; Tue, 20 Jan 2026 21:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768944352; cv=none; b=urru49f7mY2F0QikckUMJsY0cI34AyzJ9qTprsxBOQlMBtQYslPsLTzOiXwMRhm+IXw8muAdXxvveSQ3Pqv6aIJn1CEMl+fmgXxEWZKjMeMqk7tAdHZcxpPE8+gPh2p2oeBqkDe0xq2umnzLyrzYnv0AIIAvi76vmsQFg2ErZ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768944352; c=relaxed/simple;
	bh=G/aismYNV7DCJY4DNO/ne6MJJA6wep7n+UEEw78cP9g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ilXZ2Lk4k9XcvJwygVtFIwqqmHIvAO7jTn7X0NAff/j7tuW/B12mAm24UhuTnTHMf2+FnW03nh4wYIVSZvNoMN5nL9gD9aXb6iVzG1p+VjI1UYN4UyJn3QNnhp04yXPchDi8N7LxXqift0nPMwnqfp2Yqg9+ABSFm62kJAT5/x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nb1FUFsz; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8824d5b11easo136624806d6.3
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jan 2026 13:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768944349; x=1769549149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xWBcPmb/Tn94aDv9mEM5Aqfnl+Tcn9q3uugv4z01XBQ=;
        b=Nb1FUFszQ04lJ3uDIM2SMarVhFJRbJWaAvsVszC4ghbsx40rE6r4atEMhkZacrrlJi
         U233OjO/5d1X1zV15K2lezz+oRLC10Ey5m9PY7drrqD9vaJc5KoNSDP6J8+rF9DZTupv
         9l8MsfatMRtPBL6U9NXIw+7Od0lN1tpip/95h2sqauLQpD6/XgIPN28nMqoNGtrlTwg1
         ezOA3Nte5yAJM6cvq+XKk64bnKO91S8kCINSdaV3NVDnfZzvQowKZg121A0jrlWub53i
         rvsG2YvVDqa/6ARPvqD2MOLZHstR15FNSd2VoPDHvTK59+cMAn0edgmqqoZ3zu7U6aS6
         v3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768944349; x=1769549149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xWBcPmb/Tn94aDv9mEM5Aqfnl+Tcn9q3uugv4z01XBQ=;
        b=Vx5WquxCYHSSWzKVhHujAfei8g7XjS+AVK/G9q6R8/gUzbuoG9RGdWDL7bFq0P3UzF
         78X5X4u/69P8vtMD0+87erkvS/Wc/9/i1WYYgv+5z6Zuf6/KUHlhlksQsDzUVT7ZYl7m
         T9VC9KrGyV7IhPZARS9R74ig2OaOJ2Vl2uxFAxPDeJ57+IyUi7ZzykJ3H7d94KK540Zz
         gT9Z497U8Wx23H1QqX1/FjD/ZoYSpyZupRkYWVFWCHDfTp0UqaR2u5xgiPfHZAzLWZ/n
         51ZBBf9F07ktChOL1mKBWtyX23vTU41fv+hV3E0jguM9fTcg4KEqjpKY2tNS6H0c2r6R
         NEQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl/G45CCviJUHmL3FOi4ylvio5UgQy7fMQcigQSqLLwqYxk869m7laxHWUuc5XYju5Qoi0fV4PqZuJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyKNFmyXwH0iQLMi78fdLXjuLgHyWoMxccMbsL2fq4D8pFx8m1C
	CgeEqJTUMnUbxBePWMYRYMf48Bm11LvUVR9ms7DefEoS6I2RFNBCKNaZTrapxY3rcFTdKkkhOBI
	jhaILsriP8g==
X-Received: from qvbop28.prod.google.com ([2002:a05:6214:459c:b0:894:7038:8dad])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a0c:f087:0:10b0:894:5cfc:e989
 with SMTP id 6a1803df08f44-8945cfceaa0mr61712416d6.32.1768944349346; Tue, 20
 Jan 2026 13:25:49 -0800 (PST)
Date: Tue, 20 Jan 2026 21:25:46 +0000
In-Reply-To: <20260120212546.1893076-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260120212546.1893076-1-jmoroni@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260120212546.1893076-2-jmoroni@google.com>
Subject: [PATCH rdma-next 2/2] RDMA/irdma: Use CQ ID for CEQE context
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com
Cc: jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org, 
	Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15786-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	R_SPF_SOFTFAIL(0.00)[~all];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 317C64D2EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The hardware allows for an opaque CQ context field to be carried
over into CEQEs for the CQ. Previously, a pointer to the CQ was used
for this context. In the normal CQ destroy flow, the CEQ ring is
scrubbed to remove any preexisting CEQEs for the CQ that may not have
been processed yet so that the CQ structure is not dereferenced in the
CEQ ISR after the CQ has been freed.

However, in some cases, it is possible for a CEQE to be in flight in
HW even after the CQ destroy command completion is received, so it
could be missed during the scrub.

To protect against this, we can take advantage of the CQ table that
already exists and use the CQ ID for this context rather than a CQ
pointer.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/ctrl.c  | 62 ++++++++------------
 drivers/infiniband/hw/irdma/hw.c    | 88 +++++++++++++++++++++++++----
 drivers/infiniband/hw/irdma/puda.c  | 14 +++++
 drivers/infiniband/hw/irdma/type.h  |  6 +-
 drivers/infiniband/hw/irdma/utils.c |  3 +-
 drivers/infiniband/hw/irdma/verbs.c |  5 +-
 6 files changed, 127 insertions(+), 51 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index ce5cf89c4..8f2ba2e78 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -2886,15 +2886,6 @@ static int irdma_sc_resume_qp(struct irdma_sc_cqp *cqp, struct irdma_sc_qp *qp,
 	return 0;
 }
 
-/**
- * irdma_sc_cq_ack - acknowledge completion q
- * @cq: cq struct
- */
-static inline void irdma_sc_cq_ack(struct irdma_sc_cq *cq)
-{
-	writel(cq->cq_uk.cq_id, cq->cq_uk.cq_ack_db);
-}
-
 /**
  * irdma_sc_cq_init - initialize completion q
  * @cq: cq struct
@@ -2956,7 +2947,7 @@ static int irdma_sc_cq_create(struct irdma_sc_cq *cq, u64 scratch,
 		return -ENOMEM;
 
 	set_64bit_val(wqe, 0, cq->cq_uk.cq_size);
-	set_64bit_val(wqe, 8, (uintptr_t)cq >> 1);
+	set_64bit_val(wqe, 8, cq->cq_uk.cq_id);
 	set_64bit_val(wqe, 16,
 		      FIELD_PREP(IRDMA_CQPSQ_CQ_SHADOW_READ_THRESHOLD, cq->shadow_read_threshold));
 	set_64bit_val(wqe, 32, (cq->virtual_map ? 0 : cq->cq_pa));
@@ -3013,7 +3004,7 @@ int irdma_sc_cq_destroy(struct irdma_sc_cq *cq, u64 scratch, bool post_sq)
 		return -ENOMEM;
 
 	set_64bit_val(wqe, 0, cq->cq_uk.cq_size);
-	set_64bit_val(wqe, 8, (uintptr_t)cq >> 1);
+	set_64bit_val(wqe, 8, cq->cq_uk.cq_id);
 	set_64bit_val(wqe, 40, cq->shadow_area_pa);
 	set_64bit_val(wqe, 48,
 		      (cq->virtual_map ? cq->first_pm_pbl_idx : 0));
@@ -3082,7 +3073,7 @@ static int irdma_sc_cq_modify(struct irdma_sc_cq *cq,
 		return -ENOMEM;
 
 	set_64bit_val(wqe, 0, info->cq_size);
-	set_64bit_val(wqe, 8, (uintptr_t)cq >> 1);
+	set_64bit_val(wqe, 8, cq->cq_uk.cq_id);
 	set_64bit_val(wqe, 16,
 		      FIELD_PREP(IRDMA_CQPSQ_CQ_SHADOW_READ_THRESHOLD, info->shadow_read_threshold));
 	set_64bit_val(wqe, 32, info->cq_pa);
@@ -4460,47 +4451,38 @@ int irdma_sc_ceq_destroy(struct irdma_sc_ceq *ceq, u64 scratch, bool post_sq)
  * irdma_sc_process_ceq - process ceq
  * @dev: sc device struct
  * @ceq: ceq sc structure
+ * @cq_idx: Pointer to a CQ ID that will be populated.
  *
  * It is expected caller serializes this function with cleanup_ceqes()
  * because these functions manipulate the same ceq
+ *
+ * Return: True if cq_idx has been populated with a CQ ID.
  */
-void *irdma_sc_process_ceq(struct irdma_sc_dev *dev, struct irdma_sc_ceq *ceq)
+bool irdma_sc_process_ceq(struct irdma_sc_dev *dev, struct irdma_sc_ceq *ceq,
+			  u32 *cq_idx)
 {
 	u64 temp;
 	__le64 *ceqe;
-	struct irdma_sc_cq *cq = NULL;
-	struct irdma_sc_cq *temp_cq;
 	u8 polarity;
-	u32 cq_idx;
 
 	do {
-		cq_idx = 0;
 		ceqe = IRDMA_GET_CURRENT_CEQ_ELEM(ceq);
 		get_64bit_val(ceqe, 0, &temp);
 		polarity = (u8)FIELD_GET(IRDMA_CEQE_VALID, temp);
 		if (polarity != ceq->polarity)
-			return NULL;
+			return false;
 
-		temp_cq = (struct irdma_sc_cq *)(unsigned long)(temp << 1);
-		if (!temp_cq) {
-			cq_idx = IRDMA_INVALID_CQ_IDX;
-			IRDMA_RING_MOVE_TAIL(ceq->ceq_ring);
-
-			if (!IRDMA_RING_CURRENT_TAIL(ceq->ceq_ring))
-				ceq->polarity ^= 1;
-			continue;
-		}
-
-		cq = temp_cq;
+		/* Truncate. Discard valid bit which is MSb of temp. */
+		*cq_idx = temp;
+		if (*cq_idx >= dev->hmc_info->hmc_obj[IRDMA_HMC_IW_CQ].cnt)
+			*cq_idx = IRDMA_INVALID_CQ_IDX;
 
 		IRDMA_RING_MOVE_TAIL(ceq->ceq_ring);
 		if (!IRDMA_RING_CURRENT_TAIL(ceq->ceq_ring))
 			ceq->polarity ^= 1;
-	} while (cq_idx == IRDMA_INVALID_CQ_IDX);
+	} while (*cq_idx == IRDMA_INVALID_CQ_IDX);
 
-	if (cq)
-		irdma_sc_cq_ack(cq);
-	return cq;
+	return true;
 }
 
 /**
@@ -4514,10 +4496,10 @@ void *irdma_sc_process_ceq(struct irdma_sc_dev *dev, struct irdma_sc_ceq *ceq)
  */
 void irdma_sc_cleanup_ceqes(struct irdma_sc_cq *cq, struct irdma_sc_ceq *ceq)
 {
-	struct irdma_sc_cq *next_cq;
 	u8 ceq_polarity = ceq->polarity;
 	__le64 *ceqe;
 	u8 polarity;
+	u32 cq_idx;
 	u64 temp;
 	int next;
 	u32 i;
@@ -4532,9 +4514,10 @@ void irdma_sc_cleanup_ceqes(struct irdma_sc_cq *cq, struct irdma_sc_ceq *ceq)
 		if (polarity != ceq_polarity)
 			return;
 
-		next_cq = (struct irdma_sc_cq *)(unsigned long)(temp << 1);
-		if (cq == next_cq)
-			set_64bit_val(ceqe, 0, temp & IRDMA_CEQE_VALID);
+		cq_idx = temp;
+		if (cq_idx == cq->cq_uk.cq_id)
+			set_64bit_val(ceqe, 0, (temp & IRDMA_CEQE_VALID) |
+				      IRDMA_INVALID_CQ_IDX);
 
 		next = IRDMA_RING_GET_NEXT_TAIL(ceq->ceq_ring, i);
 		if (!next)
@@ -4975,7 +4958,7 @@ int irdma_sc_ccq_destroy(struct irdma_sc_cq *ccq, u64 scratch, bool post_sq)
 		return -ENOMEM;
 
 	set_64bit_val(wqe, 0, ccq->cq_uk.cq_size);
-	set_64bit_val(wqe, 8, (uintptr_t)ccq >> 1);
+	set_64bit_val(wqe, 8, ccq->cq_uk.cq_id);
 	set_64bit_val(wqe, 40, ccq->shadow_area_pa);
 
 	hdr = ccq->cq_uk.cq_id |
@@ -6462,6 +6445,9 @@ int irdma_sc_dev_init(enum irdma_vers ver, struct irdma_sc_dev *dev,
 	int ret_code = 0;
 	u8 db_size;
 
+	spin_lock_init(&dev->puda_cq_lock);
+	dev->ilq_cq = NULL;
+	dev->ieq_cq = NULL;
 	INIT_LIST_HEAD(&dev->cqp_cmd_head); /* for CQP command backlog */
 	mutex_init(&dev->ws_mutex);
 	dev->hmc_fn_id = info->hmc_fn_id;
diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 5d418ef5c..31c67b753 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -98,6 +98,74 @@ static void irdma_puda_ce_handler(struct irdma_pci_f *rf,
 	irdma_sc_ccq_arm(cq);
 }
 
+/**
+ * irdma_process_normal_ceqe - Handle a CEQE for a normal CQ.
+ * @rf: RDMA PCI function.
+ * @dev: iWARP device.
+ * @cq_idx: CQ ID. Must be in table bounds.
+ *
+ * Context: Atomic (CEQ lock must be held)
+ */
+static void irdma_process_normal_ceqe(struct irdma_pci_f *rf,
+				      struct irdma_sc_dev *dev, u32 cq_idx)
+{
+	/* cq_idx bounds validated in irdma_sc_process_ceq. */
+	struct irdma_cq *icq = READ_ONCE(rf->cq_table[cq_idx]);
+	struct irdma_sc_cq *cq;
+
+	if (unlikely(!icq)) {
+		/* Should not happen since CEQ is scrubbed upon CQ delete. */
+		ibdev_warn_ratelimited(to_ibdev(dev), "Stale CEQE for CQ %u",
+				       cq_idx);
+		return;
+	}
+
+	cq = &icq->sc_cq;
+
+	if (unlikely(cq->cq_type != IRDMA_CQ_TYPE_IWARP)) {
+		ibdev_warn_ratelimited(to_ibdev(dev), "Unexpected CQ type %u",
+				       cq->cq_type);
+		return;
+	}
+
+	writel(cq->cq_uk.cq_id, cq->cq_uk.cq_ack_db);
+	irdma_iwarp_ce_handler(cq);
+}
+
+/**
+ * irdma_process_reserved_ceqe - Handle a CEQE for a reserved CQ.
+ * @rf: RDMA PCI function.
+ * @dev: iWARP device.
+ * @cq_idx: CQ ID.
+ *
+ * Context: Atomic
+ */
+static void irdma_process_reserved_ceqe(struct irdma_pci_f *rf,
+					struct irdma_sc_dev *dev, u32 cq_idx)
+{
+	struct irdma_sc_cq *cq;
+
+	if (cq_idx == IRDMA_RSVD_CQ_ID_CQP) {
+		cq = &rf->ccq.sc_cq;
+		/* CQP CQ lifetime > CEQ. */
+		writel(cq->cq_uk.cq_id, cq->cq_uk.cq_ack_db);
+		queue_work(rf->cqp_cmpl_wq, &rf->cqp_cmpl_work);
+	} else if (cq_idx == IRDMA_RSVD_CQ_ID_ILQ ||
+		   cq_idx == IRDMA_RSVD_CQ_ID_IEQ) {
+		scoped_guard(spinlock_irqsave, &dev->puda_cq_lock) {
+			cq = (cq_idx == IRDMA_RSVD_CQ_ID_ILQ) ?
+				dev->ilq_cq : dev->ieq_cq;
+			if (!cq) {
+				ibdev_warn_ratelimited(to_ibdev(dev),
+						       "Stale ILQ/IEQ CEQE");
+				return;
+			}
+			writel(cq->cq_uk.cq_id, cq->cq_uk.cq_ack_db);
+			irdma_puda_ce_handler(rf, cq);
+		}
+	}
+}
+
 /**
  * irdma_process_ceq - handle ceq for completions
  * @rf: RDMA PCI function
@@ -107,28 +175,28 @@ static void irdma_process_ceq(struct irdma_pci_f *rf, struct irdma_ceq *ceq)
 {
 	struct irdma_sc_dev *dev = &rf->sc_dev;
 	struct irdma_sc_ceq *sc_ceq;
-	struct irdma_sc_cq *cq;
 	unsigned long flags;
+	u32 cq_idx;
 
 	sc_ceq = &ceq->sc_ceq;
 	do {
 		spin_lock_irqsave(&ceq->ce_lock, flags);
-		cq = irdma_sc_process_ceq(dev, sc_ceq);
-		if (!cq) {
+
+		if (!irdma_sc_process_ceq(dev, sc_ceq, &cq_idx)) {
 			spin_unlock_irqrestore(&ceq->ce_lock, flags);
 			break;
 		}
 
-		if (cq->cq_type == IRDMA_CQ_TYPE_IWARP)
-			irdma_iwarp_ce_handler(cq);
+		/* Normal CQs must be handled while holding CEQ lock. */
+		if (likely(cq_idx > IRDMA_RSVD_CQ_ID_IEQ)) {
+			irdma_process_normal_ceqe(rf, dev, cq_idx);
+			spin_unlock_irqrestore(&ceq->ce_lock, flags);
+			continue;
+		}
 
 		spin_unlock_irqrestore(&ceq->ce_lock, flags);
 
-		if (cq->cq_type == IRDMA_CQ_TYPE_CQP)
-			queue_work(rf->cqp_cmpl_wq, &rf->cqp_cmpl_work);
-		else if (cq->cq_type == IRDMA_CQ_TYPE_ILQ ||
-			 cq->cq_type == IRDMA_CQ_TYPE_IEQ)
-			irdma_puda_ce_handler(rf, cq);
+		irdma_process_reserved_ceqe(rf, dev, cq_idx);
 	} while (1);
 }
 
diff --git a/drivers/infiniband/hw/irdma/puda.c b/drivers/infiniband/hw/irdma/puda.c
index cee47ddbd..4f1a8c97f 100644
--- a/drivers/infiniband/hw/irdma/puda.c
+++ b/drivers/infiniband/hw/irdma/puda.c
@@ -809,6 +809,13 @@ static int irdma_puda_cq_create(struct irdma_puda_rsrc *rsrc)
 		dma_free_coherent(dev->hw->device, rsrc->cqmem.size,
 				  rsrc->cqmem.va, rsrc->cqmem.pa);
 		rsrc->cqmem.va = NULL;
+	} else {
+		scoped_guard(spinlock_irqsave, &dev->puda_cq_lock) {
+			if (rsrc->type == IRDMA_PUDA_RSRC_TYPE_ILQ)
+				dev->ilq_cq = cq;
+			else
+				dev->ieq_cq = cq;
+		}
 	}
 
 	return ret;
@@ -856,6 +863,13 @@ static void irdma_puda_free_cq(struct irdma_puda_rsrc *rsrc)
 	struct irdma_ccq_cqe_info compl_info;
 	struct irdma_sc_dev *dev = rsrc->dev;
 
+	scoped_guard(spinlock_irqsave, &dev->puda_cq_lock) {
+		if (rsrc->type == IRDMA_PUDA_RSRC_TYPE_ILQ)
+			dev->ilq_cq = NULL;
+		else
+			dev->ieq_cq = NULL;
+	}
+
 	if (rsrc->dev->ceq_valid) {
 		irdma_cqp_cq_destroy_cmd(dev, &rsrc->cq);
 		return;
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index 3de9240b7..da8c54d1f 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -707,6 +707,9 @@ struct irdma_sc_dev {
 	struct irdma_sc_aeq *aeq;
 	struct irdma_sc_ceq *ceq[IRDMA_CEQ_MAX_COUNT];
 	struct irdma_sc_cq *ccq;
+	spinlock_t puda_cq_lock;
+	struct irdma_sc_cq *ilq_cq;
+	struct irdma_sc_cq *ieq_cq;
 	const struct irdma_irq_ops *irq_ops;
 	struct irdma_qos qos[IRDMA_MAX_USER_PRIORITY];
 	struct irdma_hmc_fpm_misc hmc_fpm_misc;
@@ -1344,7 +1347,8 @@ int irdma_sc_ceq_destroy(struct irdma_sc_ceq *ceq, u64 scratch, bool post_sq);
 int irdma_sc_ceq_init(struct irdma_sc_ceq *ceq,
 		      struct irdma_ceq_init_info *info);
 void irdma_sc_cleanup_ceqes(struct irdma_sc_cq *cq, struct irdma_sc_ceq *ceq);
-void *irdma_sc_process_ceq(struct irdma_sc_dev *dev, struct irdma_sc_ceq *ceq);
+bool irdma_sc_process_ceq(struct irdma_sc_dev *dev, struct irdma_sc_ceq *ceq,
+			  u32 *cq_idx);
 
 int irdma_sc_aeq_init(struct irdma_sc_aeq *aeq,
 		      struct irdma_aeq_init_info *info);
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 13d749913..54fc7e85a 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -830,7 +830,8 @@ void irdma_cq_rem_ref(struct ib_cq *ibcq)
 		return;
 	}
 
-	iwdev->rf->cq_table[iwcq->cq_num] = NULL;
+	/* May be asynchronously sampled by CEQ ISR without holding tbl lock. */
+	WRITE_ONCE(iwdev->rf->cq_table[iwcq->cq_num], NULL);
 	spin_unlock_irqrestore(&iwdev->rf->cqtable_lock, flags);
 	complete(&iwcq->free_cq);
 }
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 6d9af41a2..6b0211f7c 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2669,9 +2669,12 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 			goto cq_destroy;
 		}
 	}
-	rf->cq_table[cq_num] = iwcq;
+
 	init_completion(&iwcq->free_cq);
 
+	/* Populate table entry after CQ is fully created. */
+	smp_store_release(&rf->cq_table[cq_num], iwcq);
+
 	return 0;
 cq_destroy:
 	irdma_cq_wq_destroy(rf, cq);
-- 
2.52.0.457.g6b5491de43-goog


