Return-Path: <linux-rdma+bounces-20710-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPc6Njr5BWqcdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20710-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:32:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 685ED544BC2
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D218300750C
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 16:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F1C32142B;
	Thu, 14 May 2026 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HKsODCXY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8334933A03F
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776375; cv=none; b=DMfuXhSsh/22LXoVQDGC7vWZiNNKdKXUH2EZ9zcpc+pa+6fW2VbOMeRNSdbp1RK0+rgZSHBkzhlbPFHXdl5wqQ7TtlAgOd+nnegzPIdlPB7MYzZiiJs75s4KO1x4LPVBfVo8u5Z+UJsNtN0JwDLz0cx6KURFmX5uklfT4L4qToE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776375; c=relaxed/simple;
	bh=FH8cVua6L0AhxPtZfcTynMOWhbA6PXRp+WzUAe97oL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lc+fRtkoxBq2npdBhjIKjvH11Mi4WziMPBwuiCN/Kgn6pZwdkADcMdWqmYqYwmldji1T7mRoQYejrvMw9PZGsTY3ViJic1Y499OsXNIt19i+6ExH8z6/64tGW1ZEnN7EmHUjoNwg6CgZ2HuLSsYQJGISiXrigq0zygAtHnknZUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HKsODCXY; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-6312b8f8e47so2515970137.3
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 09:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776372; x=1779381172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4KkSy6lcLnWa++8Pbt7WV+fj7lS1HVVB1dF6gHhKoE=;
        b=pqFBv+0ccmN7Gu68Hll6yEGH3nFAqyvPqSxMOkH8Xd8MIEtC4tyl/JLBsbOBJBX62w
         MkUDAnDX8xmELvDtIbHc5LAjqVMo5bu5jlPLLzdkgquC5IzB1kQKkH7LkkERT0vloFpZ
         UuMQpCwarZMF7P56yQIcuPVNr9aMrlLd9OUSTCwCyBCAezL3lRbHUcvO814EgKO6N6dr
         oBTpF30qTIV71fjEzdLcmR2xvpFmAXnd1U4KQ6wHe/QryhiQZ/q1z9GU4oGU9DKz2/Ks
         Y53qGdjDd5vo7Kj89M13jE0noQtHcD4sPiiLoPWKkt/70UKfVk+63WRNDEXaXxn24dcM
         4iwQ==
X-Gm-Message-State: AOJu0Yy+QmJorOuQAR7JAIxqifnazCzDr8+7ilZbM6fiKbcYp996fpl9
	UJnLkeItXWHTaxSriCyOqHklpHbXk6VH4HbfBMJo6TgBxmhDnGnuC1nXUJuF2iUXt0CWq0M3cfD
	JYr+ykanQHjsEfL3bRCgeRdqDN4Hx8/wtAOBleKN6hJy6Cznl0SX7ES9Un3Eni31Fp9YMwEHBzL
	8py3g3gIyvqpivi+/QSDmggdveSj+WjT/bmSiLNAJOCzMkN5UILgp61InbuqmOg0JG0C6dmXg7i
	HIkJlWqPSmH6RlDYCizKZXzX3Cg
X-Gm-Gg: Acq92OFKasO5HjRw7P8Cq7C2kpEppr0RnLdnFL57gBEnzqjdsd084AR0whrdQvl+xRo
	EhG4h2vSFrZek6j23O/7yl+kUvrsqriLmXQGjHdfMU4XVwdUkh9maWbnDXfaMzvX5Yi2yVxMyl1
	CM5Cgqo9GpJR130bE/hfzw3NE6OYEBigs4a9XjSRrqb5Fx4l2Roz8t84Bf0tEH86yg9xaxl2nLU
	80eGmqkPt61FRmBi6ylKBJYoRK52XhnEnysKn0mL6lbyXEZM7lL3Exullk9QPeMJEEbHhXDA/2P
	NLuVWMn8UJV837tKAb71zqnBFH+wf90DxhFnlDXg/9ccqBd5gR45HEKB9ktFeSMJMGtuMZg++rt
	l5HNsvCvdR9srJOeX5uWLi3FEO0KGTzAdcdr2FRBWwo0RvCEgJdgPxvEpMgcf5Ez07z9s9jomCR
	eClltPklKIUcHLyoC+
X-Received: by 2002:a05:6102:c4e:b0:633:7f34:260e with SMTP id ada2fe7eead31-63773f12667mr4494922137.20.1778776372327;
        Thu, 14 May 2026 09:32:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-516456ba93bsm1371551cf.8.2026.05.14.09.32.51
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2026 09:32:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bd5b20aaa6so10900185ad.2
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 09:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778776371; x=1779381171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4KkSy6lcLnWa++8Pbt7WV+fj7lS1HVVB1dF6gHhKoE=;
        b=HKsODCXYUVkRbeR0Eo/gTeILdmIrPolKI78/CVPzkw0Z/HIA/BpumCQA/g3E7Qp28m
         MIYGtfDjTjVpXcMkyr21/+aUjyAWJuIGq9GtAF7Z1EBgE9a9iHl29OxS6ywSANzz25YI
         dB5xzN/IwwCbeZCoFN0xx4/7gi64I0AlL9NjA=
X-Received: by 2002:a17:90b:33c1:b0:365:a5f6:4a5c with SMTP id 98e67ed59e1d1-369518af9admr148556a91.1.1778776370898;
        Thu, 14 May 2026 09:32:50 -0700 (PDT)
X-Received: by 2002:a17:90b:33c1:b0:365:a5f6:4a5c with SMTP id 98e67ed59e1d1-369518af9admr148532a91.1.1778776370267;
        Thu, 14 May 2026 09:32:50 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695157c3cfsm107728a91.5.2026.05.14.09.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:32:49 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v5 1/7] RDMA/bnxt_re: Refactor bnxt_re_init_user_qp()
Date: Thu, 14 May 2026 21:53:30 +0530
Message-ID: <20260514162336.72644-2-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260514162336.72644-1-sriharsha.basavapatna@broadcom.com>
References: <20260514162336.72644-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 685ED544BC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20710-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

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


