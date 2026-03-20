Return-Path: <linux-rdma+bounces-18460-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMGMEBVVvWlr8gIAu9opvQ
	(envelope-from <linux-rdma+bounces-18460-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 15:09:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D602DB9AE
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 15:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BFCC3131B39
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 14:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC463C1417;
	Fri, 20 Mar 2026 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VMUkxQkX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D963C196F
	for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015451; cv=none; b=bvPlGYk5TNB486/I1a31IcWV5ciReQtY0vNmqJHHjOzDaglkmdZju6ai3fZBXNnrRN1F8TV3EU2U5p3lfIPzOfa4fgD7SN2vQZC+OJ5c+OQYjnX5QHXVIx5b+96OmJv+18COLcY/nAziQ78mtBBcWYgAt1+emj17J9nmOe+NJSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015451; c=relaxed/simple;
	bh=TJuIW6SfjPBxWtUqyspccSJERPkzxCMfF9AhCUakPR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvuBdhKb26wIoveogV0yqZsePlQaserxWIhN08lbgSv+7WEtdU/EvqBhQQDjKwjLyRVPOkHrDgCGQFI+gpnaNPRJdPtmKUjPqYMvrLup9tyeq7LdBx8aNDsDzaBz7HK/gmXAEIMblbZcCaOODGgl6Z7TTXqUVQd9UT25wbKPxPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VMUkxQkX; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3591cc98871so845893a91.3
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 07:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774015447; x=1774620247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BaQ8vC9zDZE9DMAOJ2yWmaeIXzQ5xaQaFURYKFrTLy8=;
        b=csSzzID/eoHL1wo7j+rLX3rVRn8pfjENTn1kPgxDXJTmWdRLTv3s4XR9XYa/ezG9z8
         U3BwEEuobCYey1hQJIxBD7+d7R+498WOJ6Ka50a1+PNFPp5mWX9WZe7/DL1coa5OdsSE
         cibqGvyKT26hFo8g6b4lFQbbaVBdvurto2QWvB0ut1EKRhf0bKUrgykal8hdc8QUOFzU
         bX7ARDRBsgHHYuwvoSNuoCHGFKMD8evSWWb61Z1rZe4P4gR85cCsX7xFE7heiFtfXIEt
         +fMuxbJywq0lVCvkjPas90pe5vUhpbSbvYD8IJi26LEpWHCS09Jl84MsN+xcSYVk870P
         3dww==
X-Gm-Message-State: AOJu0Yz0JMqymV5rdc+fQvffkAM1wr0Zgg5QK6rEIz9SNxMiRKIjyeSQ
	5dNh+03KsSEh0ZnUWNpX+8Xvt51P9zC1yeojHsNcR8nSyQ5Kji88Mfde+aYynyYz0IJdnWXOVYk
	zcapfq7m+CagtE5SOoS/65xs2U9mipGz5sIh9W4qx7j/UAxESmMhfdyzU3aOhu7obNjwHyZOjft
	BncaiMfXhMBVT+g8j1sU/1YXCfgJvYL3KaFfqnvsjAgjm/4N75SmlyOB5Fiz5rz4vQUc/WqeZlv
	5cHjd1A883QlN9PUOVxDX/PcpCR
X-Gm-Gg: ATEYQzz3JgeSuZ6NovD6W6Vx3HKssSnO/2xARITPVmWgagbYLCu7mIlbkeFGDTm7hNW
	vGIkW9575cafnUHsXXmohjfNRKHdm4PYeNdrDrkhlVyEmnHNhAlBeaY0DZyhHoqFfmsOvP61kt5
	kiAN6+i8dGV5gPA4kgznbVNClVnSYko27U070MCm/aTUvrMVMb6feBu6cnR444JHEYD18dY8X+R
	1bIdhen3UBPZyUlrn8NGr5Gy0zPD/gdy1KaBy77GH/v+S1YHPqtmNkd28PpV2E6t9IcbZ6WzsGK
	C5yAuQBhz5VOvwd5J+FwepNCRCPe8p/PdMKyXB7ytD3R8+CRXZBtB9qtiulTOmm3a+8lSaRAemS
	noSkctI6XmCrsGGFhZ6fXgakhHjzOxhF2qc9Vlw8gA40EDglRHaSwsCMEaqkaTfZbZpEmJZCaqg
	Jp8AfHNzUjbu3mc1Ho+OavWclwZwM8JPe0hqplsF1Uo5G1gJjqgSrdEcEkfXgDtYilEFtq6FM=
X-Received: by 2002:a17:90b:3dcc:b0:359:91a0:98fc with SMTP id 98e67ed59e1d1-35bd2c6f1f9mr2386023a91.21.1774015447026;
        Fri, 20 Mar 2026 07:04:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35bd24f2af1sm115789a91.0.2026.03.20.07.04.06
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2026 07:04:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-829ba0e63e8so973513b3a.2
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 07:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774015445; x=1774620245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaQ8vC9zDZE9DMAOJ2yWmaeIXzQ5xaQaFURYKFrTLy8=;
        b=VMUkxQkXDrj9kn2YLTFTKRdzyxuQxO1VrMBfYpU4olLNqzouLvSGFjkkpKwxn4Cvdl
         xbe9PRxcxY/iJuR4Ls0sPsMsZoR+XKxrlTDZY3Qy/XiI/zwGivRneHdgPMpoqcUOApwE
         wiyqQv8aL0IM62uMXd81w0n10cNiB6+dy9z8o=
X-Received: by 2002:a05:6a00:a803:b0:82c:251c:4df2 with SMTP id d2e1a72fcca58-82c251c6a1amr285726b3a.11.1774015444856;
        Fri, 20 Mar 2026 07:04:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:a803:b0:82c:251c:4df2 with SMTP id d2e1a72fcca58-82c251c6a1amr285681b3a.11.1774015444087;
        Fri, 20 Mar 2026 07:04:04 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da3dfsm2136099b3a.45.2026.03.20.07.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:04:03 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next 9/9] RDMA/bnxt_re: Support create_qp_umem() devop
Date: Fri, 20 Mar 2026 19:24:37 +0530
Message-ID: <20260320135437.48716-10-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18460-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D3D602DB9AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver now has the required changes to support application
allocated QPs, so enable it by registering the 'create_qp_umem'
devop with the stack. The uverbs layer processes SQ/RQ buffer
attributes and pins them before passing sq/rq_umem to the driver.
Refactor to share the code across user and kernel QPs.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 34 ++++++++++++++++--------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  4 +++
 drivers/infiniband/hw/bnxt_re/main.c     |  1 +
 3 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index ed597382e421..2ab1fccc1997 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1932,31 +1932,32 @@ static int bnxt_re_add_unique_gid(struct bnxt_re_dev *rdev)
 	return rc;
 }
 
-int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
-		      struct ib_udata *udata)
+int bnxt_re_create_qp_umem(struct ib_qp *ib_qp,
+			   struct ib_qp_init_attr *qp_init_attr,
+			   struct ib_umem *sq_umem, struct ib_umem *rq_umem,
+			   struct ib_udata *udata)
 {
+	struct bnxt_re_qp *qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
+	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ib_qp->device, ibdev);
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 	struct bnxt_re_dbr_obj *dbr_obj = NULL;
-	struct bnxt_qplib_dev_attr *dev_attr;
-	struct uverbs_attr_bundle *attrs;
-	struct ib_umem *sq_umem = NULL;
-	struct ib_umem *rq_umem = NULL;
-	struct bnxt_re_ucontext *uctx;
+	struct bnxt_re_ucontext *uctx = NULL;
 	struct bnxt_re_qp_req ureq;
-	struct bnxt_re_dev *rdev;
 	struct bnxt_re_pd *pd;
-	struct bnxt_re_qp *qp;
 	struct ib_pd *ib_pd;
 	bool app_qp = false;
 	u32 active_qps;
 	int rc;
 
+	/* Get ucontext only if udata is valid (userspace path) */
+	if (udata)
+		uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
+
 	ib_pd = ib_qp->pd;
 	pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
 	rdev = pd->rdev;
 	dev_attr = rdev->dev_attr;
-	qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
 
-	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	if (udata) {
 		rc = ib_copy_validate_udata_in_cm(udata, ureq, qp_handle,
 						  BNXT_RE_QP_REQ_MASK_APP_ALLOCATED_QP_ENABLE);
@@ -1964,6 +1965,8 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 			return rc;
 
 		if (ureq.comp_mask & BNXT_RE_QP_REQ_MASK_APP_ALLOCATED_QP_ENABLE) {
+			struct uverbs_attr_bundle *attrs;
+
 			attrs = rdma_udata_to_uverbs_attr_bundle(udata);
 			if (uverbs_attr_is_valid(attrs,
 						 BNXT_RE_CREATE_QP_ATTR_DBR_HANDLE)) {
@@ -2055,11 +2058,20 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	bnxt_qplib_free_qp_res(&rdev->qplib_res, &qp->qplib_qp);
 	bnxt_re_qp_free_umem(qp);
 fail:
+	/* Note: sq_umem and rq_umem will be freed by the uverbs handler,
+	 * since they are allocated there (devop->create_qp_mem()).
+	 */
 	if (dbr_obj)
 		atomic_dec(&dbr_obj->usecnt);
 	return rc;
 }
 
+int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
+		      struct ib_udata *udata)
+{
+	return bnxt_re_create_qp_umem(ib_qp, qp_init_attr, NULL, NULL, udata);
+}
+
 static u8 __from_ib_qp_state(enum ib_qp_state state)
 {
 	switch (state) {
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 8b106d6dd112..3462efd1866a 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -243,6 +243,10 @@ int bnxt_re_post_srq_recv(struct ib_srq *srq, const struct ib_recv_wr *recv_wr,
 			  const struct ib_recv_wr **bad_recv_wr);
 int bnxt_re_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *qp_init_attr,
 		      struct ib_udata *udata);
+int bnxt_re_create_qp_umem(struct ib_qp *ib_qp,
+			   struct ib_qp_init_attr *qp_init_attr,
+			   struct ib_umem *sq_umem, struct ib_umem *rq_umem,
+			   struct ib_udata *udata);
 int bnxt_re_modify_qp(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
 		      int qp_attr_mask, struct ib_udata *udata);
 int bnxt_re_query_qp(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 13ad63b9b1de..ffe160dea13c 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1337,6 +1337,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.create_cq = bnxt_re_create_cq,
 	.create_user_cq = bnxt_re_create_user_cq,
 	.create_qp = bnxt_re_create_qp,
+	.create_qp_umem = bnxt_re_create_qp_umem,
 	.create_srq = bnxt_re_create_srq,
 	.create_user_ah = bnxt_re_create_ah,
 	.dealloc_pd = bnxt_re_dealloc_pd,
-- 
2.51.2.636.ga99f379adf


