Return-Path: <linux-rdma+bounces-20230-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLS0Im2p/WmEhAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20230-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 11:14:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1DA4F41E6
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 11:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 975383081CDC
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 09:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C0B37F75E;
	Fri,  8 May 2026 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cD7Iaww9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7280535CB87
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231322; cv=none; b=Zi5esbUjoWnJrUxXhshzI6wIXKXHU6w8uzDFqX2XSAMmlSF7JOk2TW6xhTRNbnskjHkYYQPaO+47ngyEdxrrNZIHQNwwme0RSHwt8rRfad5udkYnl4Corb7AKiXn6iTQNWWOy1G/Hp053ql/lQjYnaG+iGItC4FxSnZUZMO5vdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231322; c=relaxed/simple;
	bh=Gmk2+RQYtpOMvWzZfUBKI4TlcbE1KMq/mC/+zDSe+Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBZAjj4E0LBIku6naQsg7ufGIrppF8s4kUSCv17hFT3zPGwgaUI5P+TEHCJrO7as4Tr9iE8YQPtj125bRwNVW+MXl4CWAhnopqFBNqrcEoFHO/bS7rNCILPRZ+/541TeL7R8zeRovuS1jRt4O5lX0GKNrGBtffR7YFp0lXUPyRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cD7Iaww9; arc=none smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-8ec9f099fc6so198077385a.0
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 02:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778231320; x=1778836120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=imNdPYs52RzSdeRBCRcQw1ZpG4ZT4jWAr0fy5OjGqXs=;
        b=sOLl/WSIPFm21cDSuDdzoKjqKPg4W2Jr3ugTBDvwG6Q8M8JiXkpipH0pDVhhbcf7FT
         4kwFG4qZ96NW/yiAZ4VLBXczb4SN0G3rXEyxMC3AbINAeAl3PHwwLzO9dAqxkHapUzfw
         gCDv1dnWXXoRl0wErX43yvGKa8cILVUAsZvmEcGjMHjNAI/dHs4I+XtIkrVE4J2q9+hY
         0Ggxy+iFMGIvrQ3sV2chZJlVlBDCDULjbTkn36rEbQvVhIOCf7i0PXLg9o8PGXKMXXb4
         TYAnkE49GpJAU1ldfXq0zCb+H+DCH+ptLKKaP3RMe7XT6ZniEqZBZTNbfWfoAWVEx2PG
         8sEg==
X-Gm-Message-State: AOJu0Yzb/hMW6kFOteDsgYI9L2l3YYGG7x3jknFHjWr8UIU6hpFV0QaE
	oR2fHIAZhwtKTYNgcx4LVQcf53rHOITVSDtNxhPO0jIQecXt2vWge+q7PcRZ+h3PBd+cU/M6pPG
	mfFHKpnrCZt2qFEh7vWnALjfAwxoeNUCVFgHZqoHug8hIpl+EMbeWJKBimONTnhlk1bkKKHX0L+
	jXHSA452Fo8zX6bJhRVXslJSLiGbs/DpdzdPZWhC31jQcX1bAhQ/8SVqvREWVsqzpMGp14cHkAw
	l9ITMb/jgWcs13w7FR5p1LGBSzd
X-Gm-Gg: AeBDietEE5EiAHGwYAqLcCkXdksnDHwegoPl5cSpzx9gxikMwv67twbPbpT4WQfflSw
	ei39+DOoCatmDJLbS2AcXR2RhUfofJgYusDW3qhsV8d3KZOJLL4LnsAuyHQX5YBGF+2hiFiRuol
	jeEpzI3L/VPKy8SXJATIAnHhUmCPV3pmzPXR7gqfbu2Dl81/J867OW8TuzWWwJWe1v2yctMdNHD
	7/XNzjvsPom+aeJ3ku14eBDASkL/OXgbdZIbnHHrItmPV8HcG9pgVyZAAxRzAyGPJK4QsG3LZHi
	525CiSBH9UgazMYJFQ39dqFNz26dOxk5lU7DMRr2V/f+sq+SxbwPbZr2HgN+af5SvxszR1DlEPF
	+he2NzNFhQnMCqYmbNIB0nUT0tl6Z0TVPQbYtxQjpnaxFp0gqS84yNb+q9VDp7NBR6PZZ+yl4Zu
	E1gDBzOruk+p5naV53Ta6u3pclYtf3+IAhAlR5CVAZKZCDahRYNosrYX9exwQQAX66SYTPbxA=
X-Received: by 2002:a05:620a:28c3:b0:8d3:ccef:b2c6 with SMTP id af79cd13be357-904d4d50f76mr1721025785a.24.1778231320277;
        Fri, 08 May 2026 02:08:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-907b99654f5sm11128285a.0.2026.05.08.02.08.39
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2026 02:08:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-835444b6ce1so1395927b3a.1
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 02:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778231319; x=1778836119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imNdPYs52RzSdeRBCRcQw1ZpG4ZT4jWAr0fy5OjGqXs=;
        b=cD7Iaww9nDC9bwAr94SO//xmhaiXvAFFIXixlB1BZkWqyoZOsPl5BjRkM/ehIN260N
         jFIJSpsTK7pALRlY/yosfga0v0MFMMVuRKGoL5SjDQZIswxecAZwvVdYoKl1MigTafhh
         b9VCAX1QXNWwB2v4LNalZb5kpiYbQqEIW2gHU=
X-Received: by 2002:a05:6a00:908c:b0:81f:3fbd:ccf with SMTP id d2e1a72fcca58-83a5d18fe1fmr12195021b3a.23.1778231318944;
        Fri, 08 May 2026 02:08:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:908c:b0:81f:3fbd:ccf with SMTP id d2e1a72fcca58-83a5d18fe1fmr12194966b3a.23.1778231317927;
        Fri, 08 May 2026 02:08:37 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c80e7sm14419052b3a.31.2026.05.08.02.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:08:36 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v4 7/7] RDMA/bnxt_re: Enable app allocated QPs
Date: Fri,  8 May 2026 14:28:58 +0530
Message-ID: <20260508085858.21060-8-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260508085858.21060-1-sriharsha.basavapatna@broadcom.com>
References: <20260508085858.21060-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 2F1DA4F41E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20230-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The driver supports a new comp_mask: REQ_MASK_FIXED_QUE_ATTR.
The application sets this comp_mask bit in the CREATE_QP ureq
to indicate direct control of the QP. The driver goes through
the required processing for app allocated QPs (previous patches).
Only variable WQE mode is supported for these QPs.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 14 ++++++++++----
 include/uapi/rdma/bnxt_re-abi.h          |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 5d36a2fc8a10..8ba157abc051 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1721,11 +1721,11 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
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
@@ -1745,6 +1745,8 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		return qptype;
 	qplqp->type = (u8)qptype;
 	qplqp->wqe_mode = bnxt_re_is_var_size_supported(rdev, uctx);
+	if (fixed_que_attr && qplqp->wqe_mode != BNXT_QPLIB_WQE_MODE_VARIABLE)
+		return -EOPNOTSUPP;
 	qplqp->dev_cap_flags = dev_attr->dev_cap_flags;
 	qplqp->cctx = rdev->chip_ctx;
 	if (init_attr->qp_type == IB_QPT_RC) {
@@ -1929,6 +1931,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct uverbs_attr_bundle *attrs;
 	struct bnxt_re_ucontext *uctx;
+	bool fixed_que_attr = false;
 	struct bnxt_re_qp_req ureq;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_re_pd *pd;
@@ -1945,7 +1948,8 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 
 	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	if (udata) {
-		rc = ib_copy_validate_udata_in_cm(udata, ureq, qp_handle, 0);
+		rc = ib_copy_validate_udata_in_cm(udata, ureq, qp_handle,
+						  BNXT_RE_QP_REQ_MASK_FIXED_QUE_ATTR);
 		if (rc)
 			return rc;
 
@@ -1959,6 +1963,8 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 			atomic_inc(&dbr_obj->usecnt);
 			qp->dbr_obj = dbr_obj;
 		}
+		if (ureq.comp_mask & BNXT_RE_QP_REQ_MASK_FIXED_QUE_ATTR)
+			fixed_que_attr = true;
 	}
 
 	rc = bnxt_re_test_qp_limits(rdev, qp_init_attr, dev_attr);
@@ -1969,7 +1975,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 
 	qp->rdev = rdev;
 	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, uctx, &ureq,
-				  dbr_obj);
+				  dbr_obj, fixed_que_attr);
 	if (rc)
 		goto fail;
 
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index 4da8cda337dc..dd6ebe3e2fd3 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -127,6 +127,7 @@ struct bnxt_re_resize_cq_req {
 
 enum bnxt_re_qp_mask {
 	BNXT_RE_QP_REQ_MASK_VAR_WQE_SQ_SLOTS = 0x1,
+	BNXT_RE_QP_REQ_MASK_FIXED_QUE_ATTR = 0x2,
 };
 
 struct bnxt_re_qp_req {
-- 
2.51.2.636.ga99f379adf


