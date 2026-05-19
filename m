Return-Path: <linux-rdma+bounces-20984-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPW9EuGADGprigUAu9opvQ
	(envelope-from <linux-rdma+bounces-20984-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:25:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9848B581659
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B40A23077DE8
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 15:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE993769FE;
	Tue, 19 May 2026 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OBRNql/n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A7B3AFD1C
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203434; cv=none; b=rSa4tUDfomm1BKYMnsuhR3GHRiRoRbSG9//cmrT2HLVkrGuHrClhsojT3TWUOcSb3wMrokz8xefG7FdGRFwIu/kgRsHTBgiDKQ4MKGT9vjljyxYx8pUSzVm3fBe0IleqS3Mdj2w8aVrRxp7AfWSL7JieHYImNgEHpdg7GUhP254=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203434; c=relaxed/simple;
	bh=jYnMMNbv17CsmGhzOCXvfTPdBZb01z4bjm9uyQilxcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Par9stBBZ4Z8TSYtfEpMPMcqiOA9Gl85a/qck9nK7w7tcNS4MVlJFOrWjIG6E6nO+2Ao04KvMoLejLw3RphdqHQKGrLBqp+GbD97gKJWd5S3uoN/MNQaMLV8JiMyAolG5cUp7D/pcxoLkOfA6Epi9WjL/mxDzMOIwd6JAsn5YE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OBRNql/n; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-36974221f93so1844224a91.2
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203429; x=1779808229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6YWk2fn+UaS2+6P0E5RHPThUO74RpAtHJonHo/dk6o=;
        b=WMfE8WC0tTqzAbE0fsuQVrYEHQ7OpaZkpR9238/Qjz50E5OKKRIdLIFOShONwbk0dg
         esGy7dx1hPBpf5BsV26cOELRiQUNbusgWrdn5B8rS8XRqnaAUseAM9xaNbXHE7dKd/2e
         kC97slP4wMjWEJbXJSe4IkCPMG4+xOBVRzJ1Hstu5iXVyNtgH0iiYZ9F/U8Jc0kRzu5A
         eTwjbAJXBnQGm899txoNR3JdHj7nHUriC1mIRxInkHB/NkQA8qPz15CG2Pb6KEi9IuNJ
         5SOvyzSBYm2LDTuYWKq8payYBwq7nQoLXPcBrAv+9XQ2oTpvHYoh/V+wetNLQ2HesItZ
         Egkw==
X-Gm-Message-State: AOJu0YxJpSFgMFwwStMBsmCp+ZXThjqww1DvongT4N17cIPHYrTMySUD
	wHZny5MRIjGuNgz+/NdvilBWonQJ5BXVd3Zgwn1G8LgQ4MqLJVvrk4Xi2d1jsEleVgKJBsBRBb+
	YHnnmR8ciiKZuIlhuUKMTAYDfhYCvPKo8MmUzsX2S8plKdyBUkhcGwKtNUMM+MahtgFEc3BB0ii
	BP1d32sSZB8iFNCoxVAxVXT+sNfyfBx8mzVHHTG5Cekb8L76+nhQASG56zKSWI7vThlWVLSKGa5
	X9KqYLTOa7my/WqMavmq73+In0Q
X-Gm-Gg: Acq92OERNzVQpXFPoUKPJ6iB0LfVUiGoBZtY1RvPVMEwPLLsv7LZ2eeh79lw12ayMlN
	M08zfhGj7HixLMb8rnwg8adYArvSJq51nxBU9cWFuM8Zyr2a4Z4e1h5K8VytpOXhqMerCcjt4Hm
	imTkMBxbR7u0pKqyed6fztE+3YhcbUJvqNXBFJvg3Z4G3yh6FrjmtChyGDNx6zOZ6FZSFflomec
	Jqq4wJVkg0QTAW18QAhjAUGhDK/K0BjLjt8I8lKixd7fGHt6533VOe1Q0uATyGt1lR8/YEU4yko
	msSpdVJu66TLSOZzFAvJs+SFQ/PIyMEHNVxsIy1h+noy3zTRJ1UNOJMXmMw2kQel6sk0QynU/JV
	4h92/PM0RbfHfEyAJ4m5RsK+bGfVEu1T9F+7yxW80Js1XGcuIMHRMCVDTwRNYWvAx+pg1pFfHZF
	+724r5+8yuLhYSNu+DeNYIy/gsivYLvPXUJ0PEWBw9Gr7JYmUA7d1a2pQv+Ldf3w23IJdh
X-Received: by 2002:a17:90b:2809:b0:36a:ee1:fc1c with SMTP id 98e67ed59e1d1-36a0ee203d9mr1917098a91.8.1779203429116;
        Tue, 19 May 2026 08:10:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-369f48af42asm223601a91.2.2026.05.19.08.10.28
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2026 08:10:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bd6cc53fd6so37895295ad.3
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779203427; x=1779808227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6YWk2fn+UaS2+6P0E5RHPThUO74RpAtHJonHo/dk6o=;
        b=OBRNql/nFRhquGLxvZRkelBPq0e3hfFEJ95Uv0ZEC7Grn4Zq6VgYp6F7/W7zUPYN1N
         K1iOEJUJVhLfrIwEIk+rXvfFSZ8VXXMx+fXN9VTGkrUqCoZ5m0hmbTizHLB4QoP32gcn
         /FdSRb3KSXe822j8gqlfF1RB3tZ+aoyuKmyrU=
X-Received: by 2002:a17:902:c943:b0:2b2:b117:1e1b with SMTP id d9443c01a7336-2bd7e8133e4mr211192695ad.17.1779203426942;
        Tue, 19 May 2026 08:10:26 -0700 (PDT)
X-Received: by 2002:a17:902:c943:b0:2b2:b117:1e1b with SMTP id d9443c01a7336-2bd7e8133e4mr211192185ad.17.1779203426413;
        Tue, 19 May 2026 08:10:26 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d1062e9sm190739735ad.67.2026.05.19.08.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:10:25 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v7 9/9] RDMA/bnxt_re: Enable app allocated QPs
Date: Tue, 19 May 2026 20:30:41 +0530
Message-ID: <20260519150041.7251-10-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20984-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9848B581659
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver supports a new comp_mask: REQ_MASK_FIXED_QUE_ATTR.
The application sets this comp_mask bit in the CREATE_QP ureq
to indicate direct control of the QP. The driver goes through
the required processing for app allocated QPs (previous patches).
Only variable WQE mode is supported for these QPs.

This patch removes an unused comp_mask:
	BNXT_RE_QP_REQ_MASK_VAR_WQE_SQ_SLOTS

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 19 +++++++++++++++----
 include/uapi/rdma/bnxt_re-abi.h          |  2 +-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index dc7f4c019bba..00a9230e40e4 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1717,11 +1717,11 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 				struct ib_qp_init_attr *init_attr,
 				struct bnxt_re_ucontext *uctx,
 				struct bnxt_re_qp_req *ureq,
-				struct bnxt_re_dbr_obj *dbr_obj)
+				struct bnxt_re_dbr_obj *dbr_obj,
+				bool fixed_que_attr)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
-	bool fixed_que_attr = false;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_re_cq *cq;
 	int rc = 0, qptype;
@@ -1741,6 +1741,13 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		return qptype;
 	qplqp->type = (u8)qptype;
 	qplqp->wqe_mode = bnxt_re_is_var_size_supported(rdev, uctx);
+	if (fixed_que_attr) {
+		if (qplqp->wqe_mode != BNXT_QPLIB_WQE_MODE_VARIABLE)
+			return -EOPNOTSUPP;
+		if (!ureq->sq_npsn ||
+		    ureq->sq_npsn > roundup_pow_of_two(ureq->sq_slots / 2))
+			return -EINVAL;
+	}
 	qplqp->dev_cap_flags = dev_attr->dev_cap_flags;
 	qplqp->cctx = rdev->chip_ctx;
 	if (init_attr->qp_type == IB_QPT_RC) {
@@ -1925,6 +1932,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct uverbs_attr_bundle *attrs;
 	struct bnxt_re_ucontext *uctx;
+	bool fixed_que_attr = false;
 	struct bnxt_re_qp_req ureq;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_re_pd *pd;
@@ -1941,7 +1949,8 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 
 	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	if (udata) {
-		rc = ib_copy_validate_udata_in_cm(udata, ureq, qp_handle, 0);
+		rc = ib_copy_validate_udata_in_cm(udata, ureq, qp_handle,
+						  BNXT_RE_QP_REQ_MASK_FIXED_QUE_ATTR);
 		if (rc)
 			return rc;
 
@@ -1955,6 +1964,8 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 			kref_get(&dbr_obj->usecnt);
 			qp->dbr_obj = dbr_obj;
 		}
+		if (ureq.comp_mask & BNXT_RE_QP_REQ_MASK_FIXED_QUE_ATTR)
+			fixed_que_attr = true;
 	}
 
 	rc = bnxt_re_test_qp_limits(rdev, qp_init_attr, dev_attr);
@@ -1965,7 +1976,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 
 	qp->rdev = rdev;
 	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, uctx, &ureq,
-				  dbr_obj);
+				  dbr_obj, fixed_que_attr);
 	if (rc)
 		goto fail;
 
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index 4da8cda337dc..a4599d7b736a 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -126,7 +126,7 @@ struct bnxt_re_resize_cq_req {
 };
 
 enum bnxt_re_qp_mask {
-	BNXT_RE_QP_REQ_MASK_VAR_WQE_SQ_SLOTS = 0x1,
+	BNXT_RE_QP_REQ_MASK_FIXED_QUE_ATTR = 0x1,
 };
 
 struct bnxt_re_qp_req {
-- 
2.51.2.636.ga99f379adf


