Return-Path: <linux-rdma+bounces-4643-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4C7964AB9
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 17:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95F6281841
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 15:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF741B3B17;
	Thu, 29 Aug 2024 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G4R8w3F5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055DC1B3B1C
	for <linux-rdma@vger.kernel.org>; Thu, 29 Aug 2024 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946913; cv=none; b=FAdtlVUEEioKG5/bUR+BnR7qvBkhdX0lFxX9WEVJguQ/RNT8f/7BIjMpWNPrsMzQPzMvBgOjQuYQWWPQScffkYuP3hlsZxaxQ3H6XWElH5GwTeSC19EfZlVhnBpqQVrcFndOVZZJ3XRa4E/1O0gwql4edvdcTISTJVJZ4o5AgLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946913; c=relaxed/simple;
	bh=yFKXbRr2knPG3/1UJO81I+KF4oUXgVVNPqcysbccjnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NDHvdPdnfcXE0JKEnLPK0ZvWs+jIe0Ckal4xzIA0wBjpIrmZZ5q+fbBXOkRzKafoGl9WaIdroQjJyaxLf5oLaiywhU9JBkp/M3/icTBBTg1eYQo56u9dCePDDTmHzqowTyB1JXNVgWCYqpQJNGnc7vu0PDzh8UzXNLK1Tnq0gmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G4R8w3F5; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7093abb12edso594863a34.3
        for <linux-rdma@vger.kernel.org>; Thu, 29 Aug 2024 08:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724946911; x=1725551711; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rWq8xb9Dyv6rXSK7AG+b5Q7iGXq1GJ1Fw+EtwirSeCY=;
        b=G4R8w3F5XuOL0XgUwJwMDiaflsdHglBtP4uq3zisJe2s7i4LNvYQ8kAXC/QlIrlKT8
         rjnIcpbP9rLlkepmYekaDl5u2zDFlHud2IOBUcyy2QR1awdL7OxfGg6Pty/dxhWw23aQ
         B81Iy5Xs4ADdej7U6Wj6SUrsPt3MllznqRWos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724946911; x=1725551711;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWq8xb9Dyv6rXSK7AG+b5Q7iGXq1GJ1Fw+EtwirSeCY=;
        b=aMqL0NniquxEEuV6qbU7mnew9mlurt+Lo6K/z8H64pxy4RMXEtYZrbKk0hQG98m+4u
         Gvsg7edkqB6ItDF1G/Z0pFOHo7jFmDTG6R19CIU5MM6IDklxMl8bs6gSkaxjPQiyy17b
         wPKRIMOSRDV/g6dPahdYt3BP2zJIKZZlFARsnXfqshy2KE4NlUvHK/ActdEEUUlfxObx
         4KLByokAmddAuunn639KU1tSkG0IyG0Kwg2QSD0U08Sg29kf7Kf55Eva8g+VVrxeyG3p
         4parpd8glBBQcF+mb/TxFGk5mJVw9NPJwE9HPPUM6+rNPkRAv3t8CUk+ocdQuJEDquMy
         cBLA==
X-Gm-Message-State: AOJu0YwbiqmMSsahGLsJgTNrOp065REaiOMwZvLrGpMCuJ6RtFDEoPTO
	kgK0fFtdrcPSehaPKnOxUgrFB/Ikncr+Xw3qF6AQ7xaSSii270PMGWv0ePEXmg==
X-Google-Smtp-Source: AGHT+IE0SHf/++FNldEXVc4ETQ0EfP8oyLnf7Vsn3A5sDoL8ni0DAnKlO3Ug69+o5cDzbcIM6axLVA==
X-Received: by 2002:a05:6358:3392:b0:1b3:9506:7531 with SMTP id e5c5f4694b2df-1b603bebbbemr405260255d.5.1724946910865;
        Thu, 29 Aug 2024 08:55:10 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9be627sm1396735a12.57.2024.08.29.08.55.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2024 08:55:10 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	chandramohan.akula@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 3/3] RDMA/bnxt_re: Share a page to expose per SRQ info with userspace
Date: Thu, 29 Aug 2024 08:34:05 -0700
Message-Id: <1724945645-14989-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1724945645-14989-1-git-send-email-selvin.xavier@broadcom.com>
References: <1724945645-14989-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Chandramohan Akula <chandramohan.akula@broadcom.com>

Gen P7 adapters needs to share a toggle bits information received
in kernel driver with the user space. User space needs this
info to arm the SRQ.

User space application can get this page using the
UAPI routines. Library will mmap this page and get the
toggle bits to be used in the next ARM Doorbell.

Uses a hash list to map the SRQ structure from the SRQ ID.
SRQ structure is retrieved from the hash list while the
library calls the UAPI routine to get the toggle page
mapping. Currently the full page is mapped per SRQ. This
can be optimized to enable multiple SRQs from the same
application share the same page and different offsets
in the page

Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  2 ++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 34 +++++++++++++++++++++++++++++++-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  1 +
 drivers/infiniband/hw/bnxt_re/main.c     |  6 +++++-
 include/uapi/rdma/bnxt_re-abi.h          |  6 ++++++
 5 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 0912d2f..2be9a62 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -141,6 +141,7 @@ struct bnxt_re_pacing {
 #define BNXT_RE_GRC_FIFO_REG_BASE 0x2000
 
 #define MAX_CQ_HASH_BITS		(16)
+#define MAX_SRQ_HASH_BITS		(16)
 struct bnxt_re_dev {
 	struct ib_device		ibdev;
 	struct list_head		list;
@@ -196,6 +197,7 @@ struct bnxt_re_dev {
 	struct work_struct dbq_fifo_check_work;
 	struct delayed_work dbq_pacing_work;
 	DECLARE_HASHTABLE(cq_hash, MAX_CQ_HASH_BITS);
+	DECLARE_HASHTABLE(srq_hash, MAX_SRQ_HASH_BITS);
 };
 
 #define to_bnxt_re_dev(ptr, member)	\
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 1e76093..0219c8a 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1685,6 +1685,10 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
 
 	if (qplib_srq->cq)
 		nq = qplib_srq->cq->nq;
+	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT) {
+		free_page((unsigned long)srq->uctx_srq_page);
+		hash_del(&srq->hash_entry);
+	}
 	bnxt_qplib_destroy_srq(&rdev->qplib_res, qplib_srq);
 	ib_umem_release(srq->umem);
 	atomic_dec(&rdev->stats.res.srq_count);
@@ -1789,9 +1793,18 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 	}
 
 	if (udata) {
-		struct bnxt_re_srq_resp resp;
+		struct bnxt_re_srq_resp resp = {};
 
 		resp.srqid = srq->qplib_srq.id;
+		if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT) {
+			hash_add(rdev->srq_hash, &srq->hash_entry, srq->qplib_srq.id);
+			srq->uctx_srq_page = (void *)get_zeroed_page(GFP_KERNEL);
+			if (!srq->uctx_srq_page) {
+				rc = -ENOMEM;
+				goto fail;
+			}
+			resp.comp_mask |= BNXT_RE_SRQ_TOGGLE_PAGE_SUPPORT;
+		}
 		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
 		if (rc) {
 			ibdev_err(&rdev->ibdev, "SRQ copy to udata failed!");
@@ -4266,6 +4279,19 @@ static struct bnxt_re_cq *bnxt_re_search_for_cq(struct bnxt_re_dev *rdev, u32 cq
 	return cq;
 }
 
+static struct bnxt_re_srq *bnxt_re_search_for_srq(struct bnxt_re_dev *rdev, u32 srq_id)
+{
+	struct bnxt_re_srq *srq = NULL, *tmp_srq;
+
+	hash_for_each_possible(rdev->srq_hash, tmp_srq, hash_entry, srq_id) {
+		if (tmp_srq->qplib_srq.id == srq_id) {
+			srq = tmp_srq;
+			break;
+		}
+	}
+	return srq;
+}
+
 /* Helper function to mmap the virtual memory from user app */
 int bnxt_re_mmap(struct ib_ucontext *ib_uctx, struct vm_area_struct *vma)
 {
@@ -4494,6 +4520,7 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 	struct bnxt_re_ucontext *uctx;
 	struct ib_ucontext *ib_uctx;
 	struct bnxt_re_dev *rdev;
+	struct bnxt_re_srq *srq;
 	u32 length = PAGE_SIZE;
 	struct bnxt_re_cq *cq;
 	u64 mem_offset;
@@ -4525,6 +4552,11 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 		addr = (u64)cq->uctx_cq_page;
 		break;
 	case BNXT_RE_SRQ_TOGGLE_MEM:
+		srq = bnxt_re_search_for_srq(rdev, res_id);
+		if (!srq)
+			return -EINVAL;
+
+		addr = (u64)srq->uctx_srq_page;
 		break;
 
 	default:
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 4e113b9..9c74dfe 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -78,6 +78,7 @@ struct bnxt_re_srq {
 	struct ib_umem		*umem;
 	spinlock_t		lock;		/* protect srq */
 	void			*uctx_srq_page;
+	struct hlist_node       hash_entry;
 };
 
 struct bnxt_re_qp {
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 9714b9a..1211fe5 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -139,8 +139,10 @@ static void bnxt_re_set_drv_mode(struct bnxt_re_dev *rdev, u8 mode)
 	if (bnxt_re_hwrm_qcaps(rdev))
 		dev_err(rdev_to_dev(rdev),
 			"Failed to query hwrm qcaps\n");
-	if (bnxt_qplib_is_chip_gen_p7(rdev->chip_ctx))
+	if (bnxt_qplib_is_chip_gen_p7(rdev->chip_ctx)) {
 		cctx->modes.toggle_bits |= BNXT_QPLIB_CQ_TOGGLE_BIT;
+		cctx->modes.toggle_bits |= BNXT_QPLIB_SRQ_TOGGLE_BIT;
+	}
 }
 
 static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
@@ -1771,6 +1773,8 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 wqe_mode)
 		bnxt_re_vf_res_config(rdev);
 	}
 	hash_init(rdev->cq_hash);
+	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT)
+		hash_init(rdev->srq_hash);
 
 	return 0;
 free_sctx:
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index e61104f..46ad66a 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -134,8 +134,14 @@ struct bnxt_re_srq_req {
 	__aligned_u64 srq_handle;
 };
 
+enum bnxt_re_srq_mask {
+	BNXT_RE_SRQ_TOGGLE_PAGE_SUPPORT = 0x1,
+};
+
 struct bnxt_re_srq_resp {
 	__u32 srqid;
+	__u32 rsvd; /* padding */
+	__aligned_u64 comp_mask;
 };
 
 enum bnxt_re_shpg_offt {
-- 
2.5.5


