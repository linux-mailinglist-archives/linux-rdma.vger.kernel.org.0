Return-Path: <linux-rdma+bounces-20914-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJRLMiM2C2qgEgUAu9opvQ
	(envelope-from <linux-rdma+bounces-20914-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 17:54:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7A6570604
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 17:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5CC6D306D2FB
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 15:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5B148124A;
	Mon, 18 May 2026 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gGe2ROIo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B843F58D2
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119210; cv=none; b=p1L41EFdnxgiA8PF3UW1kVdwzYdE3ojtPIPUnjCzBF2pbbJTe+cocdBEtDXj6TRKGA12BACqtnKKu9ts6aPv3Z/OnnJ+ls0101OFyzKzcyiOhh4WLUQSPkHSgkTvgFGJRAjapBgGE1/aDiy7M+Kp00x8HCn0nL9GXCSOrq4i95o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119210; c=relaxed/simple;
	bh=FH8cVua6L0AhxPtZfcTynMOWhbA6PXRp+WzUAe97oL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWyPhumktNn8nF0iOvct5WyCCclsKtNkszarv2kK3p3rEGZV16UndSkWPTWqRO9VGEFMU2t/59xzZolGdC6brfAJ/IfdisaELx3rFfs14j0n3PUR1Oar6UYaD0yWu0VY8CIQOoQsFPpOsga3bxmQFqgJL6lFnT3PFgYdq2b3rtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gGe2ROIo; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-7bdaa68cf81so17779467b3.3
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 08:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119202; x=1779724002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4KkSy6lcLnWa++8Pbt7WV+fj7lS1HVVB1dF6gHhKoE=;
        b=jJt2VRx4ySSTBFGJ73Mczk/d18WUmKTJX0jQD2dqQqSQAIHRaExYeUKVwERiS1D63T
         kIO8u8DqaAQBREbh805mmnxkvYDlbgGshrwZkClnFE4a/SKGvg+IrwDme4PoLlsHA2w0
         QGcdckZFXK3/V2fj/9yQM+ShppEc6wtaWgLrhGFV8nk5mvjOtVatcEjF3eAC4U5Eusb+
         9g3p3QHfCwUk2S4AemTmKu6KLp+0uO1Qr/iwop6pgr0n0g9V4xMjhqbf2JeXrCRI3OOX
         6HBHLrpYfROLRGTuSmo3Xofc/5UjCLaRFgGXgHtNIZA5e36M0REtnNL/pqc3gw0SwSJL
         CItQ==
X-Gm-Message-State: AOJu0Ywt+wycI1xcduetqwM0qXPhm9c3VI9mFEKd2KUWOXs+fQg+mY9r
	nlFe6HAe2kUDwRfiMFDzRS+U2vKjpZjCApHaL2j9KVraHZq0gPMPvGmX1wWoWh/QF9B2vk0u3k3
	+wpg+2/pkZFD7Prc1V5lD6SKlFUhzCrn901EqMBXnMCBUkzDb3k0wq65Q/Pn+IULhUy80XmGgdr
	NmjKDHATVnDFP9LQqXqSMO8MkDjApgOCc5r5k89VfMOfDMnGScijzZHffQHstZbgfAQ7muDpLg4
	TBwBbXSIxPMTQq4ca2eZ5VbTNiY
X-Gm-Gg: Acq92OHSGwog58QJogoUsHkwF7KYLfyTgtIoWmmaFY/frCT+Meearxf2ZmYCeV02Pvt
	jqmzKSdZoqP+tq0bSZ281V2ipWDhTARPFHq4vIs4weK++kjBp0Pqxa0LOQAkC+RcRPVUm1AkuzB
	qwkH2YP4kW3kRrb52NjSeLBMcdKf2ipnwOMHu1asz/xQspukYpSdCtvVazUQSVdjgiqtUs3hHGp
	OPHHe+ftt4kiBt01effMiNWZX0FEfho2tbtvpo6LlRK+ExreWLmnwq3H1XWO8IMYNDM9wj4QFPQ
	NaoyaKzpuXofmha+5Q+rGVBCMijYYIl3DiZGt4wFB+jss85jsELEz9wVdnFs9a9K9RurH927pTl
	7/0H9AXOre31N/1+2o3tMhB04TWtDrrGM4yaMtsm9XzWsmZteR+ZcYH8D66/L1TIwLDCHzHg0sS
	9xIfPeU2OWk006/Tim
X-Received: by 2002:a05:690c:e3c4:b0:7b3:3a49:752 with SMTP id 00721157ae682-7c95c2f7a01mr184585437b3.41.1779119202139;
        Mon, 18 May 2026 08:46:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7cc9b0573bdsm3422677b3.18.2026.05.18.08.46.41
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2026 08:46:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ba718173d1so25131415ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 08:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779119201; x=1779724001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4KkSy6lcLnWa++8Pbt7WV+fj7lS1HVVB1dF6gHhKoE=;
        b=gGe2ROIoMPtzPFcOCZEG074p0V2XPS+1R79kWhSif9JKQewLHLAeOInrnIGlGSL+Ks
         Tf4VO7bl5AnyytcdJyy/G+7UAf/JpDCtu447b3Lycgvqza4/P9q12ht7S4iL8IrmI+nc
         8s/WySddf0CJ6+Ms6+H+NyY9vw8Mu/p+/U8+g=
X-Received: by 2002:a17:902:c943:b0:2b9:7ad1:bf2b with SMTP id d9443c01a7336-2bd7e927ae1mr177825325ad.29.1779119200762;
        Mon, 18 May 2026 08:46:40 -0700 (PDT)
X-Received: by 2002:a17:902:c943:b0:2b9:7ad1:bf2b with SMTP id d9443c01a7336-2bd7e927ae1mr177825055ad.29.1779119200222;
        Mon, 18 May 2026 08:46:40 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d2360e8sm163954285ad.82.2026.05.18.08.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:46:39 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v6 1/9] RDMA/bnxt_re: Refactor bnxt_re_init_user_qp()
Date: Mon, 18 May 2026 21:07:13 +0530
Message-ID: <20260518153721.183749-2-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260518153721.183749-1-sriharsha.basavapatna@broadcom.com>
References: <20260518153721.183749-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20914-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6F7A6570604
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The umem changes for CQ added a helper - bnxt_re_setup_sginfo().
Use the same helper for QP creation since we support only 4K
pages for QP ring memory too.

Add a new helper function bnxt_re_get_psn_bytes() to improve
readability as this code will be updated in subsequent patches.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 127 +++++++++++++----------
 1 file changed, 73 insertions(+), 54 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 7ed294516b7e..561d491f12ff 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1136,34 +1136,64 @@ static int bnxt_re_setup_swqe_size(struct bnxt_re_qp *qp,
 	return 0;
 }
 
+static int bnxt_re_setup_sginfo(struct bnxt_re_dev *rdev,
+				struct ib_umem *umem,
+				struct bnxt_qplib_sg_info *sginfo)
+{
+	unsigned long page_size;
+
+	if (!umem)
+		return -EINVAL;
+
+	page_size = ib_umem_find_best_pgsz(umem, SZ_4K, 0);
+	if (!page_size || page_size != SZ_4K)
+		return -EINVAL;
+
+	sginfo->umem = umem;
+	sginfo->npages = ib_umem_num_dma_blocks(umem, page_size);
+	sginfo->pgsize = page_size;
+	sginfo->pgshft = __builtin_ctz(page_size);
+	return 0;
+}
+
+static int bnxt_re_get_psn_bytes(struct bnxt_re_dev *rdev,
+				 struct bnxt_re_ucontext *cntx,
+				 struct bnxt_qplib_qp *qplib_qp,
+				 struct bnxt_re_qp_req *ureq)
+{
+	int psn_sz, psn_nume;
+
+	psn_sz = bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx) ?
+				sizeof(struct sq_psn_search_ext) :
+				sizeof(struct sq_psn_search);
+	if (cntx && bnxt_re_is_var_size_supported(rdev, cntx)) {
+		psn_nume = ureq->sq_slots;
+	} else {
+		psn_nume = (qplib_qp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC) ?
+		qplib_qp->sq.max_wqe : ((qplib_qp->sq.max_wqe * qplib_qp->sq.wqe_size) /
+			 sizeof(struct bnxt_qplib_sge));
+	}
+	if (_is_host_msn_table(rdev->qplib_res.dattr->dev_cap_flags2))
+		psn_nume = roundup_pow_of_two(psn_nume);
+
+	return psn_nume * psn_sz;
+}
+
 static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 				struct bnxt_re_qp *qp, struct bnxt_re_ucontext *cntx,
 				struct bnxt_re_qp_req *ureq)
 {
 	struct bnxt_qplib_qp *qplib_qp;
-	int bytes = 0, psn_sz;
 	struct ib_umem *umem;
-	int psn_nume;
+	int bytes;
+	int rc;
 
 	qplib_qp = &qp->qplib_qp;
 
 	bytes = (qplib_qp->sq.max_wqe * qplib_qp->sq.wqe_size);
 	/* Consider mapping PSN search memory only for RC QPs. */
-	if (qplib_qp->type == CMDQ_CREATE_QP_TYPE_RC) {
-		psn_sz = bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx) ?
-						   sizeof(struct sq_psn_search_ext) :
-						   sizeof(struct sq_psn_search);
-		if (cntx && bnxt_re_is_var_size_supported(rdev, cntx)) {
-			psn_nume = ureq->sq_slots;
-		} else {
-			psn_nume = (qplib_qp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC) ?
-			qplib_qp->sq.max_wqe : ((qplib_qp->sq.max_wqe * qplib_qp->sq.wqe_size) /
-				 sizeof(struct bnxt_qplib_sge));
-		}
-		if (_is_host_msn_table(rdev->qplib_res.dattr->dev_cap_flags2))
-			psn_nume = roundup_pow_of_two(psn_nume);
-		bytes += (psn_nume * psn_sz);
-	}
+	if (qplib_qp->type == CMDQ_CREATE_QP_TYPE_RC)
+		bytes += bnxt_re_get_psn_bytes(rdev, cntx, qplib_qp, ureq);
 
 	bytes = PAGE_ALIGN(bytes);
 	umem = ib_umem_get(&rdev->ibdev, ureq->qpsva, bytes,
@@ -1172,33 +1202,42 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 		return PTR_ERR(umem);
 
 	qp->sumem = umem;
-	qplib_qp->sq.sg_info.umem = umem;
-	qplib_qp->sq.sg_info.pgsize = PAGE_SIZE;
-	qplib_qp->sq.sg_info.pgshft = PAGE_SHIFT;
-	qplib_qp->qp_handle = ureq->qp_handle;
+	rc = bnxt_re_setup_sginfo(rdev, qp->sumem, &qplib_qp->sq.sg_info);
+	if (rc)
+		goto fail;
+
+	if (qp->qplib_qp.srq)
+		goto done;
 
-	if (!qp->qplib_qp.srq) {
-		bytes = (qplib_qp->rq.max_wqe * qplib_qp->rq.wqe_size);
-		bytes = PAGE_ALIGN(bytes);
-		umem = ib_umem_get(&rdev->ibdev, ureq->qprva, bytes,
-				   IB_ACCESS_LOCAL_WRITE);
-		if (IS_ERR(umem))
-			goto rqfail;
-		qp->rumem = umem;
-		qplib_qp->rq.sg_info.umem = umem;
-		qplib_qp->rq.sg_info.pgsize = PAGE_SIZE;
-		qplib_qp->rq.sg_info.pgshft = PAGE_SHIFT;
+	bytes = (qplib_qp->rq.max_wqe * qplib_qp->rq.wqe_size);
+	bytes = PAGE_ALIGN(bytes);
+	umem = ib_umem_get(&rdev->ibdev, ureq->qprva, bytes,
+			   IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(umem)) {
+		rc = PTR_ERR(umem);
+		goto fail;
 	}
 
+	qp->rumem = umem;
+	rc = bnxt_re_setup_sginfo(rdev, qp->rumem, &qplib_qp->rq.sg_info);
+	if (rc)
+		goto rqfail;
+
+done:
+	qplib_qp->qp_handle = ureq->qp_handle;
 	qplib_qp->dpi = &cntx->dpi;
 	qplib_qp->is_user = true;
 	return 0;
+
 rqfail:
+	ib_umem_release(qp->rumem);
+	qp->rumem = NULL;
+	memset(&qplib_qp->rq.sg_info, 0, sizeof(qplib_qp->rq.sg_info));
+fail:
 	ib_umem_release(qp->sumem);
 	qp->sumem = NULL;
 	memset(&qplib_qp->sq.sg_info, 0, sizeof(qplib_qp->sq.sg_info));
-
-	return PTR_ERR(umem);
+	return rc;
 }
 
 static struct bnxt_re_ah *bnxt_re_create_shadow_qp_ah
@@ -3345,26 +3384,6 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	return ib_respond_empty_udata(udata);
 }
 
-static int bnxt_re_setup_sginfo(struct bnxt_re_dev *rdev,
-				struct ib_umem *umem,
-				struct bnxt_qplib_sg_info *sginfo)
-{
-	unsigned long page_size;
-
-	if (!umem)
-		return -EINVAL;
-
-	page_size = ib_umem_find_best_pgsz(umem, SZ_4K, 0);
-	if (!page_size || page_size != SZ_4K)
-		return -EINVAL;
-
-	sginfo->umem = umem;
-	sginfo->npages = ib_umem_num_dma_blocks(umem, page_size);
-	sginfo->pgsize = page_size;
-	sginfo->pgshft = __builtin_ctz(page_size);
-	return 0;
-}
-
 int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 			   struct uverbs_attr_bundle *attrs)
 {
-- 
2.51.2.636.ga99f379adf


