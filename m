Return-Path: <linux-rdma+bounces-18452-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKNeMjVUvWlr8gIAu9opvQ
	(envelope-from <linux-rdma+bounces-18452-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 15:05:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C4F2DB903
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 15:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4407A300FEE1
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 14:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B064C31D362;
	Fri, 20 Mar 2026 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PjMN9h+m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D847531E828
	for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015426; cv=none; b=hcc1OIL6RzggBsN38Rsp4cjjEfAAey7OY53AOKwA7jiCNqg2WUP6yjHyvQCnSigP6v9w4S5eBopfUAorkoD+VMJvjV4X1++VAuS6vd8ZHHnaFJEQf/rIe33YJ6CCeN3nghJIKBS6JnyR0zwXvpGe6HunNY1u2x/1rVvyRCSgnjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015426; c=relaxed/simple;
	bh=cKL5edeZmtkHpPprmIY4GV6mKji8aYQYsf2wKfUfIq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5q1kNA9+8KrQZBglpUTKxSDgD5h4UIeYCBIRL4t9EVtVfHN0BZCH8ELE5GzAJH2wNRrTfuCiD4TZPNineMS7VIgDmO9Jxg9b+R8uDjA2yW1oTc/FNy7Ge7bvQDNvIEGsTVw9tIsW1gezahxDnlXCerWh3etldRhoKybMJgumZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PjMN9h+m; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-89c4feaaeb4so21287406d6.2
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 07:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774015420; x=1774620220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9aMKwPz/eJg+Ilm9qo3IRVBSOhEPtCLz8iZOfu9ERLg=;
        b=Wdn3/Falm2EP0n2fB/+fjspQFM+lfJ0wrW9Tpo9Kd/kd6WItlIO+OpMdyOOXKUd7n8
         Yg9JttRW1YJl18YJ/PVcUAXZS1WcHEbJ9Ykmok/i8lppvEEDj2drVg2jx7zOlaoFc3ps
         d4hxkukMTZ9xTkEPTVnjnuEufa0mM74izkHX7KtdU0DkefMYG3/GFe8IIBq0TMtAyYAE
         eJw/u4EO8+Z7SPJ0bEkCC5DqhPahR67lO5Oc5iCKGtCfcwZwF/d1gTJJONkbq2V81zMn
         cxmS3hDIfYjb4xqxm4T6g7gO4gfRqdQsYI7SvO1JcY+/B/sJ3MmOGp4MERlYjDZzTTZh
         m0XA==
X-Gm-Message-State: AOJu0YwZSdcAWyes3RNMF9r2+fSiCfeaq5XVUAmc8ToHDNVVvfS2ZdNt
	RKnY8CdHQGpQp7VJBblcPfpnlh/tgfDgK+6XJRDazVGeV5TnfeD1kOGUgCot2OgYsyHiFp/8nqO
	pE793OV7XFQcTWOyT8cRcCZki6gzk7IAqTToWHY7ZCS/ZsroRWAsCnRp3h1E0fqUA+UbF//raGL
	zij+OmRLS+ssN5VciSsxQ3tri+Lxf410rJrb0JPtRl+uCHtmWP76H/BP5TnVv6mzG84OPxRS2G0
	V9LNf3A+1NhGWpR65onqGvhWdzo
X-Gm-Gg: ATEYQzxBM2RVl1BZqzS9/yFpUvfVtwfknoV8jmh9xSuHvFv9qbjqbsqwJkTnEpHZ7iz
	JX2Z6UhxlpEbm/cmzvkdgtfA21TlxzpdC1mEJYkkUqWcGx9++uemHFjsZkuwAAfRLRwHcwirico
	NxLn6VRFxGpuF3GlcSWNd+geMpjdwJoXdzmyk066QkX4VWdchdLPCVSpw4ndQttjbJzzojO1Uph
	pj6uEasSzgKXwlWDa2OSRiUeVGYsv0S8E2VARrCBbMeehjxKYl+8Lr83bGFMujA9i6p6F5Iq0ns
	wYfssX7y6/KRrQUioeR+MU9qWCFNLEFtk1b8Kh+nH9i0Guzq4TIPcK/C7+oXIu2WXdv2JBPEdvz
	9tsYGAEy6LKW10yJThoMWqLE60NixTv/9aVqpPxDeeyuIQytEbuC+pTGz8NjfvtqgtCWBBvl9qU
	XWagSCR4nj35HB1Gp/6tHJKj2O35i/xgTwL6wM6tEZK5VVUHN5ciD0/KDkqajSb2lxNaNoxs4=
X-Received: by 2002:a05:6214:478e:b0:89c:5e9c:4159 with SMTP id 6a1803df08f44-89c858e04e7mr37553766d6.0.1774015420070;
        Fri, 20 Mar 2026 07:03:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89c852dedadsm2445326d6.14.2026.03.20.07.03.39
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2026 07:03:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82c2054b584so1072697b3a.2
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 07:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774015418; x=1774620218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aMKwPz/eJg+Ilm9qo3IRVBSOhEPtCLz8iZOfu9ERLg=;
        b=PjMN9h+mhPHNMt+ySJWwHmo9dVSl1tqKZLStuoaEeXaiGPovrdlXAZdfkjfYcpxQ5V
         +av35XKLzp7RYuM84bYF2Drl6x0cR9bOGP6ghUd99AN14bnGiL90WWcHIKdHYHXZW5HX
         NIQ4aESsk6iD1CveO607LoT54vMQ6HomkEuvc=
X-Received: by 2002:a05:6a00:198d:b0:828:f1d9:22cc with SMTP id d2e1a72fcca58-82a8c234f59mr2551380b3a.20.1774015417397;
        Fri, 20 Mar 2026 07:03:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:198d:b0:828:f1d9:22cc with SMTP id d2e1a72fcca58-82a8c234f59mr2551232b3a.20.1774015414890;
        Fri, 20 Mar 2026 07:03:34 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da3dfsm2136099b3a.45.2026.03.20.07.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:03:34 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next 1/9] RDMA/bnxt_re: Refactor bnxt_re_init_user_qp()
Date: Fri, 20 Mar 2026 19:24:29 +0530
Message-ID: <20260320135437.48716-2-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260320135437.48716-1-sriharsha.basavapatna@broadcom.com>
References: <20260320135437.48716-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18452-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D1C4F2DB903
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
index 182128ee4f24..c021d96188be 100644
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
@@ -3348,26 +3387,6 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
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


