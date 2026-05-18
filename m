Return-Path: <linux-rdma+bounces-20917-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LMTJKY2C2qgEgUAu9opvQ
	(envelope-from <linux-rdma+bounces-20917-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 17:56:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 512EB5706A6
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 17:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C53F03080F1D
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 15:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D5648AE3A;
	Mon, 18 May 2026 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UyQ75p/y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD7D36F419
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119223; cv=none; b=HlmNdCW2epJavnl6azGSU/Z2vBhu+8ZL50bBGciwnRAsnJ6flwTt+aYz0z4NhVitLRMl4kRDfISLz7SzFwitbXdwrrLY9fbCiA5KHDSgXnq5dB4PagyeaU0q4wpO5r57/5qlc4FDvDyGbPWaf+YRr3qYynp52pBtYVflJPO7/co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119223; c=relaxed/simple;
	bh=ZkiR0ZbYuYTF6r0+55yABmcpKRK++QPVzmZpL72tGm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRkpaeRKT5BZg5EE2oBSzFmn8ak2ESXkfQT/0kFy/iXPgQPGrydBh57nCOif1Z3HaTBopOl7JSHxSHbgx0H5Ws0qVV4Iv2r8uTTmx7akKPY5AxyDZYA2SUKQxPXPOaRjnaj30E7AHTb9jmGNb4gJoIzYF8unbX1AgZ1i3YzgHtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UyQ75p/y; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-7bdaa68cf81so17781687b3.3
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 08:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119212; x=1779724012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwWfaryRAuRaBtHh5cCWVYkVSEfWEunhgtZEaPUDx4k=;
        b=DnJjq0cQo5L9OUONhFzhxB7YfpkaNkwfTb52eNwWY7ROWZVJLRbO81kHsiCSi7Hy0J
         Z76ymU/fg5cWZ0b0GQISVmatYmhO+/tz+ohC3GNOzgmgZOCK4qcxjqNXwDRhmThj2A2S
         +yVAuPohrhRZX7p4j1dHEmUAyb5Mi8ksflLm54pVdt2CKOGskXSVD1NlxIxFHYoJH5iw
         bjJ+XxUrSsgW7ZgjVd9BOuqPvnLIKfOQzrv3XOcbilRfUUv7tW4X/sHTllFpvu1iQiFA
         cqLiPpT5g4f+aaQcZSoAUp1+0f5hu7II/4I1fbv9m10ep2AClKtHZoM7sw54BhBS2xXH
         mYJQ==
X-Gm-Message-State: AOJu0Yz44osCInyMK1u8Y1US6lDvmW3JxMSShXeH34MQ8kgwVouKd4jD
	8HOdXXzsy/lXb71qHllF779eEGztrhilbZNRIJ2qA2PTXKDEbM3M0uQd6Hf6+UdPpnm7NLcHt31
	FiINkot4aLj8Y+XKgMilyw83NN0Rx/qM8wcP6YIhyPt3PlA0OUykGGYAzFFShompkv7I62xXPkQ
	MAapvBffLND+WBzAfiYHyN529Wzq/B1SkVrbJ7c6+S3gixw1tDZsEzr4kBCT9xZAFOJs+FnBIlS
	oo1JLnbYTMaqAPxmN5+RRmPJrDP
X-Gm-Gg: Acq92OFdBVrwPas77lQ7me1X6ztGP3xrUyslXq6Cc5LT6DqturReWqsCBizSbI17AV7
	/TYtoiRk5RSoZPhP1u8aBeZ1c7FM7v4iR3MDo6eda6WakMWQONtcoJezusRzMFNG/jVBaV8TZ3L
	viw9MedWMiBbT0c1iMNWSCwEMk2Ggdcv3uN7O9HjrfJtRR4YCyyDTVzqsIzjf35CXsC2jc3DWeK
	KtCwTTvaSxJfQIbb9ADonooj4EziPRKjpTqNX/lTNV66GDCjPuS8nxEo8Oyl/7Rrlt3TGkCE4o7
	qZqO50Wgsn4sdrSehNZiCJiOVaZ8QMHAM0sf+PDkkGazo+9bWzSYvCAludeBupEVpHZPxQOQ5LO
	f7NcAYJyTHjnS91Gc8CE+zJ3ZRjNdyB4M7MyJBB3oniBqbh6kxMDLHsIVdQJkaRvkQ/HIdxYZR8
	F9HHH/+8VSh3SebAhovftZYTc/hnWtH3AQ/jIRJceLsBvXXVxxveb2qCTcVLCtEB9gsUQRDvo=
X-Received: by 2002:a05:690c:c1a:b0:7a0:4a34:16d6 with SMTP id 00721157ae682-7c95c6f979amr161570407b3.44.1779119212009;
        Mon, 18 May 2026 08:46:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7cc9b14cd76sm3446547b3.13.2026.05.18.08.46.51
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2026 08:46:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ba718173d1so25136115ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 08:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779119211; x=1779724011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwWfaryRAuRaBtHh5cCWVYkVSEfWEunhgtZEaPUDx4k=;
        b=UyQ75p/yrubLRUQBA/l5hm/hqr6LuLZWuKO11ZXCOhvhJ3/z+WRGmhJeEmpLuRkljV
         dED6UunpbTF+SN2yApEE4h6aQjMwuKJfZv+wJlkr8bh9YjeVs/ViT4PjyBnYtXhG6qea
         u8tq74W9whD0UqWBAfFnq0Ft3Uy5EeByLw0fg=
X-Received: by 2002:a17:902:cf0a:b0:2ba:6ca2:bd9 with SMTP id d9443c01a7336-2bd7e97a6efmr164825195ad.41.1779119210698;
        Mon, 18 May 2026 08:46:50 -0700 (PDT)
X-Received: by 2002:a17:902:cf0a:b0:2ba:6ca2:bd9 with SMTP id d9443c01a7336-2bd7e97a6efmr164824805ad.41.1779119210133;
        Mon, 18 May 2026 08:46:50 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d2360e8sm163954285ad.82.2026.05.18.08.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:46:49 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v6 4/9] RDMA/bnxt_re: Update msn table size for app allocated QPs
Date: Mon, 18 May 2026 21:07:16 +0530
Message-ID: <20260518153721.183749-5-sriharsha.basavapatna@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-20917-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 512EB5706A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For app allocated QPs, the driver shouldn't use slots/round-up logic
to compute the msn table size. The application handles this logic
and computes 'sq_npsn' and passes it to the driver using a new uapi
parameter.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 61 +++++++++++++++---------
 include/uapi/rdma/bnxt_re-abi.h          |  1 +
 2 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index fd1ea053d563..ae32f86b9e9b 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1159,29 +1159,39 @@ static int bnxt_re_setup_sginfo(struct bnxt_re_dev *rdev,
 static int bnxt_re_get_psn_bytes(struct bnxt_re_dev *rdev,
 				 struct bnxt_re_ucontext *cntx,
 				 struct bnxt_qplib_qp *qplib_qp,
-				 struct bnxt_re_qp_req *ureq)
+				 struct bnxt_re_qp_req *ureq,
+				 bool fixed_que_attr)
 {
 	int psn_sz, psn_nume;
 
-	psn_sz = bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx) ?
-				sizeof(struct sq_psn_search_ext) :
-				sizeof(struct sq_psn_search);
-	if (cntx && bnxt_re_is_var_size_supported(rdev, cntx)) {
-		psn_nume = ureq->sq_slots;
+	if (rdev->dev_attr &&
+	    _is_host_msn_table(rdev->dev_attr->dev_cap_flags2))
+		psn_sz = sizeof(struct sq_msn_search);
+	else
+		psn_sz = bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx) ?
+					sizeof(struct sq_psn_search_ext) :
+					sizeof(struct sq_psn_search);
+	if (!fixed_que_attr) {
+		if (cntx && bnxt_re_is_var_size_supported(rdev, cntx)) {
+			psn_nume = ureq->sq_slots;
+		} else {
+			psn_nume = (qplib_qp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC) ?
+			qplib_qp->sq.max_wqe : ((qplib_qp->sq.max_wqe * qplib_qp->sq.wqe_size) /
+				 sizeof(struct bnxt_qplib_sge));
+		}
+		if (_is_host_msn_table(rdev->qplib_res.dattr->dev_cap_flags2))
+			psn_nume = roundup_pow_of_two(psn_nume);
 	} else {
-		psn_nume = (qplib_qp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC) ?
-		qplib_qp->sq.max_wqe : ((qplib_qp->sq.max_wqe * qplib_qp->sq.wqe_size) /
-			 sizeof(struct bnxt_qplib_sge));
+		psn_nume = ureq->sq_npsn;
 	}
-	if (_is_host_msn_table(rdev->qplib_res.dattr->dev_cap_flags2))
-		psn_nume = roundup_pow_of_two(psn_nume);
 
 	return psn_nume * psn_sz;
 }
 
 static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 				struct bnxt_re_qp *qp, struct bnxt_re_ucontext *cntx,
-				struct bnxt_re_qp_req *ureq)
+				struct bnxt_re_qp_req *ureq,
+				bool fixed_que_attr)
 {
 	struct bnxt_qplib_qp *qplib_qp;
 	struct ib_umem *umem;
@@ -1193,7 +1203,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	bytes = (qplib_qp->sq.max_wqe * qplib_qp->sq.wqe_size);
 	/* Consider mapping PSN search memory only for RC QPs. */
 	if (qplib_qp->type == CMDQ_CREATE_QP_TYPE_RC)
-		bytes += bnxt_re_get_psn_bytes(rdev, cntx, qplib_qp, ureq);
+		bytes += bnxt_re_get_psn_bytes(rdev, cntx, qplib_qp, ureq, fixed_que_attr);
 
 	bytes = PAGE_ALIGN(bytes);
 	umem = ib_umem_get(&rdev->ibdev, ureq->qpsva, bytes,
@@ -1647,7 +1657,9 @@ static int bnxt_re_init_qp_type(struct bnxt_re_dev *rdev,
 	return qptype;
 }
 
-static void bnxt_re_qp_calculate_msn_psn_size(struct bnxt_re_qp *qp)
+static void bnxt_re_qp_calculate_msn_psn_size(struct bnxt_re_qp *qp,
+					      bool fixed_que_attr,
+					      struct bnxt_re_qp_req *req)
 {
 	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
 	struct bnxt_qplib_q *sq = &qplib_qp->sq;
@@ -1670,12 +1682,17 @@ static void bnxt_re_qp_calculate_msn_psn_size(struct bnxt_re_qp *qp)
 
 	/* Update msn tbl size */
 	if (qplib_qp->is_host_msn_tbl && qplib_qp->psn_sz) {
-		if (wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC)
-			qplib_qp->msn_tbl_sz =
-				roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, wqe_mode));
-		else
-			qplib_qp->msn_tbl_sz =
-				roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, wqe_mode)) / 2;
+		if (!fixed_que_attr) {
+			if (wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC)
+				qplib_qp->msn_tbl_sz =
+					roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, wqe_mode));
+			else
+				qplib_qp->msn_tbl_sz =
+					roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, wqe_mode))
+						/ 2;
+		} else {
+			qplib_qp->msn_tbl_sz = req->sq_npsn;
+		}
 		qplib_qp->msn = 0;
 	}
 }
@@ -1750,12 +1767,12 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		bnxt_re_adjust_gsi_sq_attr(qp, init_attr, uctx);
 
 	if (uctx) { /* This will update DPI and qp_handle */
-		rc = bnxt_re_init_user_qp(rdev, pd, qp, uctx, ureq);
+		rc = bnxt_re_init_user_qp(rdev, pd, qp, uctx, ureq, fixed_que_attr);
 		if (rc)
 			return rc;
 	}
 
-	bnxt_re_qp_calculate_msn_psn_size(qp);
+	bnxt_re_qp_calculate_msn_psn_size(qp, fixed_que_attr, ureq);
 
 	rc = bnxt_re_setup_qp_hwqs(qp);
 	if (rc)
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index 40955eaba32e..db8400f2ce3b 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -135,6 +135,7 @@ struct bnxt_re_qp_req {
 	__aligned_u64 qp_handle;
 	__aligned_u64 comp_mask;
 	__u32 sq_slots;
+	__u32 sq_npsn;
 };
 
 struct bnxt_re_qp_resp {
-- 
2.51.2.636.ga99f379adf


