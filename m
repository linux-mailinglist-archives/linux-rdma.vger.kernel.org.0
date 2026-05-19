Return-Path: <linux-rdma+bounces-20976-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHLaMseADGpfigUAu9opvQ
	(envelope-from <linux-rdma+bounces-20976-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:24:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5306C58162B
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75A86308412A
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 15:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FB43AFCE2;
	Tue, 19 May 2026 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NwvAUdav"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f97.google.com (mail-vs1-f97.google.com [209.85.217.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19513AFD18
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203404; cv=none; b=nAAPoSqQg6g0DowsF6pSoHxdeKc+5ETg6qzLZQ7nUyPiWrnqNMu0/jWx5rruaYV0XcUfHE9PtvQ0cWCYr4IBHaMjmcMWlDtiobyowA8FTBfQXjbbH76fSnW9kSkFpAKV/M6yW4RdrZGmMivyBLt3ewFpalJcxk2E0xJxdVYWxR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203404; c=relaxed/simple;
	bh=FH8cVua6L0AhxPtZfcTynMOWhbA6PXRp+WzUAe97oL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSGQg2bTGG0lUsv6PUHLKExVqesL49GSaZDzo48ozSQ4vWgvI4CDWETDnZgCZdf6FG9cpwwHqmBtvNQdKXo2Tc6g5JV99mDWO8WxBLug96omtFB3q5SxPCpcDRLIV1hVwIASaJtSHEPDZiNUPS8bsIrHa1nCEDx6TeUz4PiyxVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NwvAUdav; arc=none smtp.client-ip=209.85.217.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f97.google.com with SMTP id ada2fe7eead31-6312af106e3so2877496137.0
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203402; x=1779808202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4KkSy6lcLnWa++8Pbt7WV+fj7lS1HVVB1dF6gHhKoE=;
        b=ryvXpXMJdAJ6dYlKp14+3kqZZeCRlvix5OzIH0Gn72YTe2v98G+L24AajUORTbnzB3
         gKBKqigkGuApntFIoys/dQBOZDcDnX9k22o8ebM5mG9oYmFcyXhhrez4DMFlg+QIXOpV
         LZxsn/ftdMErjfo3J660oWuykKRDzROcNabArI8DUQAtDOIwDXp1oPNT1BQV8n1TZVPz
         q9DpoDatMD+h4nNX60VA2vpL55rZoedobGaDPd2wNdibBmIT6/Ft+sg0hF4gZKJx97E1
         fM4lo8c8ZY/h83yKk1lxpTrhD72NeHQMzvMkmS0YV8DCde4MYw8/lgiqS2h2D7OMBFHW
         m2hw==
X-Gm-Message-State: AOJu0YwCJPXJD9aAzSAxJfTu46qOjS3zxGTacq6Ha6CpdT3F4BbcDCIz
	OzWTHBycmxZAeRUkJShUkpw5MclZBkvn6Q1jKpvXgjYrT8/Lfv9qhxBTqiInjbXFdJWeKj+2rUy
	QljlhPW6pCrn8srcszGjNTgIpdnm3zaReX78hkZwahCWN3k7bN2iqrfFaIFwPFXWPSovXLfP2WM
	0ndoYBGBlZ+fDFEc7nsiDXdh+ZdQ87w+JccLBQmfS0ZEV9tTPMlrE+rnPMaIpyJfw8+R5+AUvym
	7V4WsPm5GER0KDzIOdAJY0hWyIK
X-Gm-Gg: Acq92OE7vgR3iDwY3jtWqP8anixUsJdp5USQClfkkeJp9reoTjOcayUUL19ok8eDHlP
	6fJ6QiX529NXiE+kclQ7ZMHUJI5pRWM87svj6iTInyZw/er47ZljP5dKsN9drN5IkB4Q2w31guv
	rFGlCPKRK3BZml6Ywwm99EGkjfomv4PsJpghjD6rMkQXL1Dqzp+6QDo/pvHRkUxfSNVx/8sVpGt
	60D0aDdKMhbf82r7wLGZYkJu1NrI6lGS/flOOMuogM4m8BCh4EdUSUGt5I/xnXJpIVZWKDjnUMc
	EI6zrCsx6qEMZcTjQ3QI9mh9BK1oAt4r3drdlsNDgRquDB6pxCMvSwZOEc7kBhEUYQEn4qc1ONM
	coWEE/9LH+fVFx05TOvI+x6IRwFumdIthq+HaeoK57L6H8y7SO073N6q6dXDDbFKzkgitzzc4e5
	84l/maW9zy73g0mdfX
X-Received: by 2002:a05:6102:3752:b0:632:d8d5:291b with SMTP id ada2fe7eead31-63a3fea4ed5mr10026178137.30.1779203401548;
        Tue, 19 May 2026 08:10:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-63ccf18bdb9sm951836137.1.2026.05.19.08.10.01
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2026 08:10:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2baedd2fd43so26015455ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779203400; x=1779808200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4KkSy6lcLnWa++8Pbt7WV+fj7lS1HVVB1dF6gHhKoE=;
        b=NwvAUdavWPqQibiuGpzA0PnW3Zz4VBYNvFyA1HnxBg3vtA45NgZIXS/3kuQYB4jisK
         xQLn/nL4HtBIn20Nx+AD3R9f5Wi6CCxuzVlaN4WMxySVsCIeE1Ap7BM+ocPgtby/6oQv
         aeA+2iyK/DIUKv0iNE/lnxJWYblq9QplVkq8M=
X-Received: by 2002:a17:903:3cd3:b0:2b2:ebed:7af8 with SMTP id d9443c01a7336-2bd7e86c420mr134749905ad.1.1779203400243;
        Tue, 19 May 2026 08:10:00 -0700 (PDT)
X-Received: by 2002:a17:903:3cd3:b0:2b2:ebed:7af8 with SMTP id d9443c01a7336-2bd7e86c420mr134749605ad.1.1779203399669;
        Tue, 19 May 2026 08:09:59 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d1062e9sm190739735ad.67.2026.05.19.08.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:09:58 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v7 1/9] RDMA/bnxt_re: Refactor bnxt_re_init_user_qp()
Date: Tue, 19 May 2026 20:30:33 +0530
Message-ID: <20260519150041.7251-2-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260519150041.7251-1-sriharsha.basavapatna@broadcom.com>
References: <20260519150041.7251-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20976-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5306C58162B
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


