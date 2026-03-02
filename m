Return-Path: <linux-rdma+bounces-17379-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLw5GPxvpWlXAgYAu9opvQ
	(envelope-from <linux-rdma+bounces-17379-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 12:09:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFB71D73BD
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 12:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 214293019440
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 11:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520EF35F61F;
	Mon,  2 Mar 2026 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fhEHCRRK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com [74.125.82.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71E333B951
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 11:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772449784; cv=none; b=NkL3tWnJH5snSdc5oWc762VhjvVOqtebJ5dy+dxKG8GDTQvn3a6p/1Uiz1QGJYdWdgxrFJJNpPp94ApWUCECNeQk67SBYl/tmXuxHnzdjsonkjD7SnqgtNXHphM9ya17MDMR1Zx62SN3eqZc5juyMv7hCCF49WNSw+bqB3IBue4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772449784; c=relaxed/simple;
	bh=mnxXGFA9Ds3UbhjMOqIx+4pXCjQBc61CYQXEtATiV6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCjkRm/W+4Qy9Kota9N9a4qKxFaAzbnea+F47xEswrbybAIhcdq/R1hJXAmXeZAnjWq4k2XCgv5FeMSecrbPgkGW7Zec2ouXIW9F/o0EgX0n2vzl7+BsMDz3WtcS+AK5URcoHDfG/k++jWP3l6SjpnmwHdwFguBfaOtOh9NJA8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fhEHCRRK; arc=none smtp.client-ip=74.125.82.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f228.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so3273013eec.1
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 03:09:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772449782; x=1773054582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xq5wNwZiPS8T478m+WJx9xcIgsFoYM6oQbQHzxgW/SI=;
        b=qhoFwRxRUDNDPldZH9HP3u2KgixCZwmxlnwG1gKgHWKbVU+G+5jOEkv/33n5KkN1y2
         A7JpC9/vMmakolQuzTn6s5cVTwn9dg2rL+H3l57j8S/4Y9i7+qqxTQZXfY+E4Ld3uePH
         L/1gCh1Y13q6GKT0TgO+RXvx4HZzqxqSyvxZPxw8zOXeiT+2L1SvJBwFwlV8JbGLKadN
         pai0uLt0mApN4IhmyBXAFBcfxJ9XaoLLMb+nzerhCDGlTsXMXrnEoOCAbZWJFDVyt71x
         +uqJc15s3bHMAMyA48qDx1PJtwCCwPAl04j/Y+OOHasAeZ6gOL1j/B0JmTpm8T7z6DfU
         gabw==
X-Gm-Message-State: AOJu0Yyj9WcIGOf8zun2gfMofBvWkyP/PbYpHLiR+Y9nqUdNOEDe4TNv
	dlx2HVjPWk4aCtkoG/HwC6JqupRmH6DbBENfwergK95hOVoxKzyOw1nxE3cHmsOipF+SMwdGQV9
	LwwLaOP5/C5AUH8JYX2Xe5/SIXOSWZsJKQrN75xDAjyr8zDHuytpFVMoy3avt516EX3i25hwfaM
	+vttQRymsaJQD4nbPpndf9uxuDjNgoRD0n84Zwkdjb5mm8fRMgk+UrhqmYDx3yUSFACmNgWR5mu
	aJyOZm5FdZlkRDLN6B2nBirj4ql
X-Gm-Gg: ATEYQzxZMIG1zlkzFlp7A3tj+7kYD+5IV20rPNoJjxT9qqn+36+WXNybxuGdrqrxd7P
	Ab9HfAh22O+sQg8U6D1DbcaEMy9VigB7eddUu2h4cMxfM1PeMHMyZPPnK10GB/pMd12BJhuUWfr
	MEhqiQSqzF/OkEmdbwrBkV9FxB9wvEeViHiDZrRKmkI4xOco03mW4JoQldCr0AtAj3VtGW2rDat
	jvjgtSQVWD+sawQ6dRIke8QjWwcjRaeWwvR46qsM1GuyHwbPEdIvP8QOk36k4TAXJ9ZeF00NrU1
	olaFvZL5ZTWxJ0cMC9+tVRtWlIzoNFddsEZWsCU4O6aqgMbx9pnuaAHdNZYONIrYpZlb+Xd6/WP
	bLA5SoykLDzeJH2TqYF+7Ekku1Za+sFcKWt2HrkeC1TAkGBbaPf3le1dk1sWBQdWcYYmFMMOGoD
	0M7t4QMiqxEkZ9jN3EjLkuoEJIngktepxeDf2s3Uw/tLv6CcA9U28nTzZ+8XM2TDSnNP0bgS0=
X-Received: by 2002:a05:7300:8cac:b0:2ba:8018:cc62 with SMTP id 5a478bee46e88-2bde1e6b54dmr3403567eec.38.1772449781593;
        Mon, 02 Mar 2026 03:09:41 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2be10d1dfd5sm337142eec.3.2026.03.02.03.09.41
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2026 03:09:41 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2adef9d486bso40133345ad.2
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 03:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772449779; x=1773054579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xq5wNwZiPS8T478m+WJx9xcIgsFoYM6oQbQHzxgW/SI=;
        b=fhEHCRRKV9Gk6Ngweasl/lZrU2vuk9po4V2lzrPzjxP9wz1AH0gZgky3V09EeXKxIE
         RY0x3tFmq+9/WWw6q+JTOTskBbQteb6AF0QS//kgVL0uH/1NUjzRUfpCqBSrK8zimACg
         Clik5J6qGUbRpHN2A8FQlSwDiKsr0zHsvXbGE=
X-Received: by 2002:a17:903:2b06:b0:2ae:4996:430b with SMTP id d9443c01a7336-2ae499644cfmr54907635ad.26.1772449779117;
        Mon, 02 Mar 2026 03:09:39 -0800 (PST)
X-Received: by 2002:a17:903:2b06:b0:2ae:4996:430b with SMTP id d9443c01a7336-2ae499644cfmr54907195ad.26.1772449778401;
        Mon, 02 Mar 2026 03:09:38 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4651e409sm58391755ad.44.2026.03.02.03.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:09:37 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v14 6/6] RDMA/bnxt_re: Support application specific CQs
Date: Mon,  2 Mar 2026 16:30:36 +0530
Message-ID: <20260302110036.36387-7-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260302110036.36387-1-sriharsha.basavapatna@broadcom.com>
References: <20260302110036.36387-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17379-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EEFB71D73BD
X-Rspamd-Action: no action

This patch supports application allocated memory for CQs.

The application allocates and manages the CQs directly. To support
this, the driver exports a new comp_mask to indicate direct control
of the CQ. When this comp_mask bit is set in the ureq, the driver
maps this application allocated CQ memory into hardware. As the
application manages this memory, the CQ depth ('cqe') passed by it
must be used as is and the driver shouldn't update it.

For CQs, ib_core supports pinning dmabuf based application memory,
specified through provider attributes. This umem is mananged by the
ib_core and is available in ib_cq. Register 'create_cq_user' devop
to process this umem. The driver also supports the legacy interface
that allocates umem internally.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 34 +++++++++++++-----------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  3 ++-
 drivers/infiniband/hw/bnxt_re/main.c     |  1 +
 include/uapi/rdma/bnxt_re-abi.h          |  7 ++++-
 4 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 2044d42357ac..fad39f799be2 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3342,7 +3342,6 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
 
 	bnxt_re_put_nq(rdev, nq);
-	ib_umem_release(cq->umem);
 
 	atomic_dec(&rdev->stats.res.cq_count);
 	kfree(cq->cql);
@@ -3369,8 +3368,8 @@ static int bnxt_re_setup_sginfo(struct bnxt_re_dev *rdev,
 	return 0;
 }
 
-static int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-				  struct uverbs_attr_bundle *attrs)
+int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			   struct uverbs_attr_bundle *attrs)
 {
 	struct bnxt_re_cq *cq = container_of(ibcq, struct bnxt_re_cq, ib_cq);
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibcq->device, ibdev);
@@ -3402,19 +3401,25 @@ static int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_at
 	if (entries > dev_attr->max_cq_wqes + 1)
 		entries = dev_attr->max_cq_wqes + 1;
 
-	rc = ib_copy_validate_udata_in(udata, req, cq_handle);
+	rc = ib_copy_validate_udata_in_cm(udata, req, cq_handle,
+					  BNXT_RE_CQ_FIXED_NUM_CQE_ENABLE);
 	if (rc)
 		return rc;
 
-	cq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
-			       entries * sizeof(struct cq_base),
-			       IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(cq->umem)) {
-		rc = PTR_ERR(cq->umem);
-		return rc;
+	if (req.comp_mask & BNXT_RE_CQ_FIXED_NUM_CQE_ENABLE)
+		entries = cqe;
+
+	if (!ibcq->umem) {
+		ibcq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
+					 entries * sizeof(struct cq_base),
+					 IB_ACCESS_LOCAL_WRITE);
+		if (IS_ERR(ibcq->umem)) {
+			rc = PTR_ERR(ibcq->umem);
+			goto fail;
+		}
 	}
 
-	rc = bnxt_re_setup_sginfo(rdev, cq->umem, &cq->qplib_cq.sg_info);
+	rc = bnxt_re_setup_sginfo(rdev, ibcq->umem, &cq->qplib_cq.sg_info);
 	if (rc)
 		goto fail;
 
@@ -3462,7 +3467,6 @@ static int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_at
 free_mem:
 	free_page((unsigned long)cq->uctx_cq_page);
 fail:
-	ib_umem_release(cq->umem);
 	return rc;
 }
 
@@ -3542,8 +3546,8 @@ static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
 
 	cq->qplib_cq.max_wqe = cq->resize_cqe;
 	if (cq->resize_umem) {
-		ib_umem_release(cq->umem);
-		cq->umem = cq->resize_umem;
+		ib_umem_release(cq->ib_cq.umem);
+		cq->ib_cq.umem = cq->resize_umem;
 		cq->resize_umem = NULL;
 		cq->resize_cqe = 0;
 	}
@@ -4142,7 +4146,7 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
 	/* User CQ; the only processing we do is to
 	 * complete any pending CQ resize operation.
 	 */
-	if (cq->umem) {
+	if (cq->ib_cq.umem) {
 		if (cq->resize_umem)
 			bnxt_re_resize_cq_complete(cq);
 		return 0;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 33e0f66b39eb..3d02c16f54b6 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -108,7 +108,6 @@ struct bnxt_re_cq {
 	struct bnxt_qplib_cqe	*cql;
 #define MAX_CQL_PER_POLL	1024
 	u32			max_cql;
-	struct ib_umem		*umem;
 	struct ib_umem		*resize_umem;
 	int			resize_cqe;
 	void			*uctx_cq_page;
@@ -254,6 +253,8 @@ int bnxt_re_post_recv(struct ib_qp *qp, const struct ib_recv_wr *recv_wr,
 		      const struct ib_recv_wr **bad_recv_wr);
 int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct uverbs_attr_bundle *attrs);
+int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			   struct uverbs_attr_bundle *attrs);
 int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata);
 int bnxt_re_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int bnxt_re_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc);
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index b576f05e3b26..8d6696f8830f 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1334,6 +1334,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.alloc_ucontext = bnxt_re_alloc_ucontext,
 	.create_ah = bnxt_re_create_ah,
 	.create_cq = bnxt_re_create_cq,
+	.create_user_cq = bnxt_re_create_user_cq,
 	.create_qp = bnxt_re_create_qp,
 	.create_srq = bnxt_re_create_srq,
 	.create_user_ah = bnxt_re_create_ah,
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index b5d2e3d7fd7e..a39974877d0e 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -103,12 +103,17 @@ struct bnxt_re_pd_resp {
 struct bnxt_re_cq_req {
 	__aligned_u64 cq_va;
 	__aligned_u64 cq_handle;
+	__aligned_u64 comp_mask;
 };
 
-enum bnxt_re_cq_mask {
+enum bnxt_re_resp_cq_mask {
 	BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT = 0x1,
 };
 
+enum bnxt_re_req_cq_mask {
+	BNXT_RE_CQ_FIXED_NUM_CQE_ENABLE = 0x1,
+};
+
 struct bnxt_re_cq_resp {
 	__u32 cqid;
 	__u32 tail;
-- 
2.51.2.636.ga99f379adf


