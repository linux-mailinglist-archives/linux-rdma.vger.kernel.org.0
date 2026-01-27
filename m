Return-Path: <linux-rdma+bounces-16068-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP9zFy2WeGnmrAEAu9opvQ
	(envelope-from <linux-rdma+bounces-16068-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 11:40:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C374492F30
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 11:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D650830117A8
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 10:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD587342511;
	Tue, 27 Jan 2026 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EYwEuVQk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com [74.125.82.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DA2342507
	for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510385; cv=none; b=mNxehCNYY9JwR4LSmVm6ka+o8jur/oJu2EsvnBt+8bulcHJWxSyC8C0wuiNgO7sY8E5HVn7KrOFCUUi3S3kSiE5Wwzt7Ze6D9rHGZf42cs6STCNsq7PgbLrxxYJDHJKn57nyzoNb4pRBdhN1UOaqs3q4RgqLRr+YdTpYcAxYCRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510385; c=relaxed/simple;
	bh=X8AMKR85YLBKiO/uN9UXpGW3972gTYfyi3DnzRfahoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HW9jth5rXjjX3RYQukmi8zdGd5JwA08iv5w6RjGpFCJ1Tq8AlSb9cABMdNksDhC6vZhuXLwE3SwUFPrgZX0YZ/1erkHIEPSIyGIEC19IauD5X9KpbpGtINiNujZuYRLC0Nm7z8EeaH9yPGr6/wd/WbmgIGEr5JfY5vlhA1NA4GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EYwEuVQk; arc=none smtp.client-ip=74.125.82.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f226.google.com with SMTP id 5a478bee46e88-2b7070acfdcso6554867eec.0
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 02:39:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769510382; x=1770115182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15to5Iz8PyeVC+IP9FwWBb+UH18Qxvflh54tR1ZQNt0=;
        b=fBdDbYLUjZAMXaMcwyC9ttmweLl6TG7yGtv9mU88kYj+Tb/dpA65SGAFqo9f31kfG8
         EycB98SUCXTjH1aKgwjx4SXGoxEgNI3oj70QkNNw4rHo2ypE2khIAWT2x7aqkLLW4azt
         KnycIf7R3TtizfiULb46M82KHChh+lD+J4DMlAIpmuuictXORBHC6/JC49UCWLPdfjw7
         GYptpGnDHAQ3SFNb/gBzJoB5XSxBN2agIj/xKLsuKb1rRSuCl35D3yOzgSPuy8yvVk8q
         ZCuv+E1SQZRuvBwQkEjiiIlPywWBIAcfyhpsifsn4HzQU1HY0rSet8rxy3/cwhO1c6Ra
         u7Yg==
X-Gm-Message-State: AOJu0Yw++w6b1AqRwc6PUicplwbvD0JscWl5xTAyDzwgVwddFOwbiFrW
	KjwjxzcUDXAhZTrz5WCZRtG/dkfCjyY7oPdW7ijeK/4iJb8EXnsTmCdiZVgt8G9Tu27tK7BKgCB
	07CTU0/zzkAnJp/LbTK1ybjQnRzRrPpXO9Egtt9QjZFmpZWeIW87q+RM9N4lOU8a2vuXJkb2yxF
	oJ1THQH1UTDv03QyrXccRoXRjbl7mWW77Ft1+8zZXeAaWkVjfK6UUA+kUPsmKIQYvP2cRYvnMwz
	6jmeYW4gqbI+AQj8QvrcrTZafhS
X-Gm-Gg: AZuq6aKp7zu1UwcYFgM4yA/pKLNiEd7UnRWM6wW8XQgCzulFu3kVJsSmYePVervSaGl
	fGwwl1aQqR2T3r2TXDE8uWn8UImhYrSq5QICDw97Vjl6081VYxD84A4RJa1mMALkwXumOAh5qZf
	CTfbYZidnOnpHf5DWGn3qKD7Cry8ogFgQUiaUfNr3VyKrLUBVzaORHx37Vfd2EC0fvZ5yMXcsBL
	+3OTyl7xeaO3xE30V6R8O6dI1KemEz0yBIM3Fw1Sr55qylwav3oQRomdY05OaUQCx5vvphBicIu
	i3O8rdJNU5+S6v2/dcuhXdFFuaNLFe2FJmg7CeFAbwZdWPPo3p50TQ4QP4wWVcnNJ/LpujG+tc9
	l13ZOeYTkfho5DbN9PRo1hb4nT3im4gxvvnVJEROaMplU+VFKAOIk+YXPh3qgZitcYVjZoRsYeN
	pHSY6s7SJoCRBwjneu3AC2IRgoM9PTWf7/g75nPVur6qfVtX5J1Mo1YQ==
X-Received: by 2002:a05:7300:6c84:b0:2b7:3240:542f with SMTP id 5a478bee46e88-2b78da4ef6amr832290eec.37.1769510382246;
        Tue, 27 Jan 2026 02:39:42 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2b73a4d4c9csm1771082eec.3.2026.01.27.02.39.41
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jan 2026 02:39:42 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a08cbeb87eso56633035ad.3
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 02:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769510380; x=1770115180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15to5Iz8PyeVC+IP9FwWBb+UH18Qxvflh54tR1ZQNt0=;
        b=EYwEuVQkFiTtz3vl70cfHD0IjfG55Fo0z3wa4fBk22IJ7SxGJNZxPrRJMInKK26inn
         pLAlxe6cXwP0ulHKwIhE2FkwAFl1w6/wUm+Z8xGH9Tl0vf2vK3SIoTDRjtHNCb8zJhUB
         UGsnihmsWAd20+uSM6yksLz8E6NXxwGNZlyho=
X-Received: by 2002:a17:903:350d:b0:2a7:b8f9:5a5e with SMTP id d9443c01a7336-2a870e00597mr15831735ad.46.1769510379539;
        Tue, 27 Jan 2026 02:39:39 -0800 (PST)
X-Received: by 2002:a17:903:350d:b0:2a7:b8f9:5a5e with SMTP id d9443c01a7336-2a870e00597mr15831405ad.46.1769510379010;
        Tue, 27 Jan 2026 02:39:39 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802daa792sm114502875ad.19.2026.01.27.02.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 02:39:38 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v9 5/5] RDMA/bnxt_re: Direct Verbs: Support CQ and QP verbs
Date: Tue, 27 Jan 2026 16:01:09 +0530
Message-ID: <20260127103109.32163-6-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
References: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16068-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C374492F30
X-Rspamd-Action: no action

The following Direct Verbs have been implemented, by enhancing the
driver specific udata in existing verbs.

CQ Direct Verbs:
----------------
- CREATE_CQ:
  Create a CQ using the specified udata (struct bnxt_re_cq_req).
  The driver registers a new device op 'create_cq_umem' that is
  used to process CQ memory allocated by the userspace application.
  The driver maps/pins the CQ user memory and registers it with the
  hardware.

- DESTROY_CQ:
  Unmap the user memory and destroy the CQ.

QP Direct Verbs:
----------------
- CREATE_QP:
  Create a QP using the specified udata (struct bnxt_re_qp_req).
  The driver registers a new device op 'create_qp_umem' that is
  used to process QP memory allocated by the userspace application.
  The driver maps/pins the SQ/RQ user memory and registers it
  with the hardware.

- DESTROY_QP:
  Unmap SQ/RQ user memory and destroy the QP.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Co-developed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Co-developed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |   5 +
 drivers/infiniband/hw/bnxt_re/dv.c       | 447 +++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 171 ++++++---
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  20 +
 drivers/infiniband/hw/bnxt_re/main.c     |   2 +
 include/uapi/rdma/bnxt_re-abi.h          |  15 +
 6 files changed, 613 insertions(+), 47 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 0999a42c678c..f28acde3a274 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -234,6 +234,8 @@ struct bnxt_re_dev {
 	union ib_gid ugid;
 	u32 ugid_index;
 	u8 sniffer_flow_created : 1;
+	atomic_t dv_cq_count;
+	atomic_t dv_qp_count;
 };
 
 #define to_bnxt_re_dev(ptr, member)	\
@@ -277,6 +279,9 @@ static inline int bnxt_re_read_context_allowed(struct bnxt_re_dev *rdev)
 	return 0;
 }
 
+struct bnxt_qplib_nq *bnxt_re_get_nq(struct bnxt_re_dev *rdev);
+void bnxt_re_put_nq(struct bnxt_re_dev *rdev, struct bnxt_qplib_nq *nq);
+
 #define BNXT_RE_CONTEXT_TYPE_QPC_SIZE_P5	1088
 #define BNXT_RE_CONTEXT_TYPE_CQ_SIZE_P5		128
 #define BNXT_RE_CONTEXT_TYPE_MRW_SIZE_P5	128
diff --git a/drivers/infiniband/hw/bnxt_re/dv.c b/drivers/infiniband/hw/bnxt_re/dv.c
index db69f25e294f..a039f1e460e0 100644
--- a/drivers/infiniband/hw/bnxt_re/dv.c
+++ b/drivers/infiniband/hw/bnxt_re/dv.c
@@ -12,6 +12,7 @@
 #include <rdma/ib_user_ioctl_cmds.h>
 #define UVERBS_MODULE_NAME bnxt_re
 #include <rdma/uverbs_named_ioctl.h>
+#include <rdma/ib_umem.h>
 #include <rdma/bnxt_re-abi.h>
 
 #include "roce_hsi.h"
@@ -398,6 +399,9 @@ static int bnxt_re_dv_dbr_cleanup(struct ib_uobject *uobject,
 	struct bnxt_re_dbr_obj *obj = uobject->object;
 	struct bnxt_re_dev *rdev = obj->rdev;
 
+	if (atomic_read(&obj->usecnt))
+		return -EBUSY;
+
 	rdma_user_mmap_entry_remove(&obj->entry->rdma_entry);
 	bnxt_qplib_free_uc_dpi(&rdev->qplib_res, &obj->dpi);
 	return 0;
@@ -459,11 +463,454 @@ DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_GET_DEFAULT_DBR,
 DECLARE_UVERBS_GLOBAL_METHODS(BNXT_RE_OBJECT_DEFAULT_DBR,
 			      &UVERBS_METHOD(BNXT_RE_METHOD_GET_DEFAULT_DBR));
 
+static int bnxt_re_dv_create_cq_resp(struct bnxt_re_dev *rdev,
+				     struct bnxt_re_cq *cq,
+				     struct bnxt_re_cq_resp *resp)
+{
+	struct bnxt_qplib_cq *qplcq = &cq->qplib_cq;
+
+	resp->cqid = qplcq->id;
+	resp->tail = qplcq->hwq.cons;
+	resp->phase = qplcq->period;
+	resp->comp_mask = BNXT_RE_CQ_DV_SUPPORT;
+	return 0;
+}
+
+static int bnxt_re_dv_setup_umem(struct bnxt_re_dev *rdev,
+				 struct ib_umem *umem,
+				 struct bnxt_qplib_sg_info *sginfo,
+				 struct ib_umem **umem_ptr)
+{
+	unsigned long page_size;
+
+	if (!umem)
+		return -EINVAL;
+
+	page_size = ib_umem_find_best_pgsz(umem, SZ_4K, 0);
+	if (!page_size)
+		return -EINVAL;
+
+	if (umem_ptr)
+		*umem_ptr = umem;
+	sginfo->umem = umem;
+	sginfo->npages = ib_umem_num_dma_blocks(umem, SZ_4K);
+	sginfo->pgsize = SZ_4K;
+	sginfo->pgshft = __builtin_ctz(SZ_4K);
+	ibdev_dbg(&rdev->ibdev,
+		  "umem: 0x%llx npages: %d page_size: %d page_shift: %d\n",
+		  (u64)umem, sginfo->npages, sginfo->pgsize, sginfo->pgshft);
+
+	return 0;
+}
+
+static int bnxt_re_dv_create_qplib_cq(struct bnxt_re_dev *rdev,
+				      struct bnxt_re_ucontext *re_uctx,
+				      struct bnxt_re_cq *cq,
+				      struct bnxt_re_cq_req *req,
+				      struct ib_umem *umem)
+{
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
+	struct bnxt_qplib_cq *qplcq;
+	u32 cqe = req->ncqe;
+	u32 max_active_cqs;
+	int rc = -EINVAL;
+
+	if (!atomic_add_unless(&rdev->stats.res.cq_count, 1, dev_attr->max_cq)) {
+		ibdev_dbg(&rdev->ibdev, "Create CQ failed - max exceeded(CQs)");
+		return rc;
+	}
+
+	/* Validate CQ fields */
+	if (cqe < 1 || cqe > dev_attr->max_cq_wqes) {
+		ibdev_dbg(&rdev->ibdev, "Create CQ failed - max exceeded(CQ_WQs)");
+		goto fail_dec;
+	}
+
+	qplcq = &cq->qplib_cq;
+	qplcq->cq_handle = (u64)qplcq;
+
+	rc = bnxt_re_dv_setup_umem(rdev, umem, &qplcq->sg_info, &cq->umem);
+	if (rc)
+		goto fail_dec;
+
+	qplcq->dpi = &re_uctx->dpi;
+	qplcq->max_wqe = cqe;
+	qplcq->nq = bnxt_re_get_nq(rdev);
+	qplcq->cnq_hw_ring_id = qplcq->nq->ring_id;
+	qplcq->coalescing = &rdev->cq_coalescing;
+	rc = bnxt_qplib_create_cq(&rdev->qplib_res, qplcq);
+	if (rc) {
+		ibdev_err(&rdev->ibdev, "Failed to create HW CQ");
+		goto fail_qpl;
+	}
+
+	cq->ib_cq.cqe = cqe;
+	cq->cq_period = qplcq->period;
+
+	max_active_cqs = atomic_read(&rdev->stats.res.cq_count);
+	if (max_active_cqs > rdev->stats.res.cq_watermark)
+		rdev->stats.res.cq_watermark = max_active_cqs;
+	spin_lock_init(&cq->cq_lock);
+
+	return 0;
+
+fail_qpl:
+	ib_umem_release(cq->umem);
+fail_dec:
+	atomic_dec(&rdev->stats.res.cq_count);
+	return rc;
+}
+
+static void bnxt_re_dv_free_qplib_cq(struct bnxt_re_dev *rdev,
+				     struct bnxt_re_cq *re_cq)
+{
+	bnxt_qplib_destroy_cq(&rdev->qplib_res, &re_cq->qplib_cq);
+	bnxt_re_put_nq(rdev, re_cq->qplib_cq.nq);
+	ib_umem_release(re_cq->umem);
+}
+
+int bnxt_re_dv_create_cq(struct bnxt_re_dev *rdev, struct ib_udata *udata,
+			 struct bnxt_re_cq *re_cq, struct bnxt_re_cq_req *req,
+			 struct ib_umem *umem)
+{
+	struct bnxt_re_ucontext *re_uctx =
+		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
+	struct bnxt_re_cq_resp resp = {};
+	int ret;
+
+	ret = bnxt_re_dv_create_qplib_cq(rdev, re_uctx, re_cq, req, umem);
+	if (ret)
+		return ret;
+
+	ret = bnxt_re_dv_create_cq_resp(rdev, re_cq, &resp);
+	if (ret)
+		goto fail_resp;
+
+	ret = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
+	if (ret)
+		goto fail_resp;
+
+	re_cq->is_dv_cq = true;
+	atomic_inc(&rdev->dv_cq_count);
+	return 0;
+
+fail_resp:
+	bnxt_re_dv_free_qplib_cq(rdev, re_cq);
+	return ret;
+};
+
+static int bnxt_re_dv_init_qp_attr(struct bnxt_re_qp *qp,
+				   struct bnxt_re_ucontext *cntx,
+				   struct ib_qp_init_attr *init_attr,
+				   struct bnxt_re_qp_req *req,
+				   struct bnxt_re_dbr_obj *dbr_obj)
+{
+	struct bnxt_qplib_dev_attr *dev_attr;
+	struct bnxt_qplib_qp *qplqp;
+	struct bnxt_re_cq *send_cq;
+	struct bnxt_re_cq *recv_cq;
+	struct bnxt_re_dev *rdev;
+	struct bnxt_qplib_q *rq;
+	struct bnxt_qplib_q *sq;
+	u32 slot_size;
+	int qptype;
+
+	rdev = qp->rdev;
+	qplqp = &qp->qplib_qp;
+	dev_attr = rdev->dev_attr;
+
+	/* Setup misc params */
+	qplqp->is_user = true;
+	qplqp->pd_id = req->pd_id;
+	qplqp->qp_handle = (u64)qplqp;
+	qplqp->sig_type = false;
+	qptype = __from_ib_qp_type(init_attr->qp_type);
+	if (qptype < 0)
+		return qptype;
+	qplqp->type = (u8)qptype;
+	qplqp->wqe_mode = rdev->chip_ctx->modes.wqe_mode;
+	ether_addr_copy(qplqp->smac, rdev->netdev->dev_addr);
+	qplqp->dev_cap_flags = dev_attr->dev_cap_flags;
+	qplqp->cctx = rdev->chip_ctx;
+
+	if (init_attr->qp_type == IB_QPT_RC) {
+		qplqp->max_rd_atomic = dev_attr->max_qp_rd_atom;
+		qplqp->max_dest_rd_atomic = dev_attr->max_qp_init_rd_atom;
+	}
+	qplqp->mtu = ib_mtu_enum_to_int(iboe_get_mtu(rdev->netdev->mtu));
+	if (dbr_obj)
+		qplqp->dpi = &dbr_obj->dpi;
+	else
+		qplqp->dpi = &cntx->dpi;
+
+	/* Setup CQs */
+	if (!init_attr->send_cq)
+		return -EINVAL;
+	send_cq = container_of(init_attr->send_cq, struct bnxt_re_cq, ib_cq);
+	qplqp->scq = &send_cq->qplib_cq;
+	qp->scq = send_cq;
+
+	if (!init_attr->recv_cq)
+		return -EINVAL;
+	recv_cq = container_of(init_attr->recv_cq, struct bnxt_re_cq, ib_cq);
+	qplqp->rcq = &recv_cq->qplib_cq;
+	qp->rcq = recv_cq;
+
+	if (!init_attr->srq) {
+		/* Setup RQ */
+		slot_size = bnxt_qplib_get_stride();
+		rq = &qplqp->rq;
+		rq->max_sge = init_attr->cap.max_recv_sge;
+		rq->wqe_size = req->rq_wqe_sz;
+		rq->max_wqe = (req->rq_slots * slot_size) /
+				req->rq_wqe_sz;
+		rq->max_sw_wqe = rq->max_wqe;
+		rq->q_full_delta = 0;
+		rq->sg_info.pgsize = PAGE_SIZE;
+		rq->sg_info.pgshft = PAGE_SHIFT;
+	}
+
+	/* Setup SQ */
+	sq = &qplqp->sq;
+	sq->max_sge = init_attr->cap.max_send_sge;
+	sq->wqe_size = req->sq_wqe_sz;
+	sq->max_wqe = req->sq_slots; /* SQ in var-wqe mode */
+	sq->max_sw_wqe = sq->max_wqe;
+	sq->q_full_delta = 0;
+	sq->sg_info.pgsize = PAGE_SIZE;
+	sq->sg_info.pgshft = PAGE_SHIFT;
+
+	return 0;
+}
+
+static int bnxt_re_dv_init_user_qp(struct bnxt_re_dev *rdev,
+				   struct bnxt_re_ucontext *cntx,
+				   struct bnxt_re_qp *qp,
+				   struct ib_qp_init_attr *init_attr,
+				   struct bnxt_re_qp_req *req,
+				   struct ib_umem *sq_umem, struct ib_umem *rq_umem)
+{
+	struct bnxt_qplib_sg_info *sginfo;
+	struct bnxt_qplib_qp *qplib_qp;
+	int rc;
+
+	qplib_qp = &qp->qplib_qp;
+	qplib_qp->qp_handle = req->qp_handle;
+
+	/* SQ */
+	sginfo = &qplib_qp->sq.sg_info;
+	rc = bnxt_re_dv_setup_umem(rdev, sq_umem, sginfo, &qp->sumem);
+	if (rc)
+		return rc;
+
+	/* SRQ */
+	if (init_attr->srq) {
+		struct bnxt_re_srq *srq;
+
+		srq = container_of(init_attr->srq, struct bnxt_re_srq, ib_srq);
+		qplib_qp->srq = &srq->qplib_srq;
+		goto done;
+	}
+
+	/* RQ */
+	sginfo = &qplib_qp->rq.sg_info;
+	rc = bnxt_re_dv_setup_umem(rdev, rq_umem, sginfo, &qp->rumem);
+	if (rc)
+		goto rqfail;
+
+done:
+	qplib_qp->is_user = true;
+	return 0;
+rqfail:
+	ib_umem_release(qp->sumem);
+	qplib_qp->sq.sg_info.umem = NULL;
+	return rc;
+}
+
+static int
+bnxt_re_dv_qp_init_msn(struct bnxt_re_dev *rdev, struct bnxt_re_qp *qp,
+		       struct bnxt_re_qp_req *req)
+{
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
+	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
+
+	if (req->sq_npsn > dev_attr->max_qp_wqes ||
+	    req->sq_psn_sz > sizeof(struct sq_psn_search_ext))
+		return -EINVAL;
+
+	qplib_qp->is_host_msn_tbl = true;
+	qplib_qp->msn = 0;
+	qplib_qp->psn_sz = req->sq_psn_sz;
+	qplib_qp->msn_tbl_sz = req->sq_psn_sz * req->sq_npsn;
+	return 0;
+}
+
+static void bnxt_re_dv_init_qp(struct bnxt_re_dev *rdev,
+			       struct bnxt_re_qp *qp)
+{
+	u32 active_qps, tmp_qps;
+
+	spin_lock_init(&qp->sq_lock);
+	spin_lock_init(&qp->rq_lock);
+	INIT_LIST_HEAD(&qp->list);
+	mutex_lock(&rdev->qp_lock);
+	list_add_tail(&qp->list, &rdev->qp_list);
+	mutex_unlock(&rdev->qp_lock);
+	atomic_inc(&rdev->stats.res.qp_count);
+	active_qps = atomic_read(&rdev->stats.res.qp_count);
+	if (active_qps > rdev->stats.res.qp_watermark)
+		rdev->stats.res.qp_watermark = active_qps;
+
+	/* Get the counters for RC QPs */
+	tmp_qps = atomic_inc_return(&rdev->stats.res.rc_qp_count);
+	if (tmp_qps > rdev->stats.res.rc_qp_watermark)
+		rdev->stats.res.rc_qp_watermark = tmp_qps;
+}
+
+int bnxt_re_dv_create_qp(struct bnxt_re_dev *rdev, struct ib_udata *udata,
+			 struct ib_qp_init_attr *init_attr,
+			 struct bnxt_re_qp *re_qp, struct bnxt_re_qp_req *req,
+			 struct ib_umem *sq_umem, struct ib_umem *rq_umem)
+{
+	struct bnxt_re_dbr_obj *dbr_obj = NULL;
+	struct bnxt_re_cq *send_cq = NULL;
+	struct bnxt_re_cq *recv_cq = NULL;
+	struct bnxt_re_qp_resp resp = {};
+	struct uverbs_attr_bundle *attrs;
+	struct bnxt_re_ucontext *uctx;
+	int ret;
+
+	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
+	if (init_attr->send_cq) {
+		send_cq = container_of(init_attr->send_cq, struct bnxt_re_cq, ib_cq);
+		re_qp->scq = send_cq;
+	}
+
+	if (init_attr->recv_cq) {
+		recv_cq = container_of(init_attr->recv_cq, struct bnxt_re_cq, ib_cq);
+		re_qp->rcq = recv_cq;
+	}
+
+	attrs = rdma_udata_to_uverbs_attr_bundle(udata);
+	if (!attrs)
+		return -EINVAL;
+
+	if (uverbs_attr_is_valid(attrs, BNXT_RE_CREATE_QP_ATTR_DBR_HANDLE)) {
+		dbr_obj = uverbs_attr_get_obj(attrs, BNXT_RE_CREATE_QP_ATTR_DBR_HANDLE);
+		if (IS_ERR(dbr_obj))
+			return PTR_ERR(dbr_obj);
+		atomic_inc(&dbr_obj->usecnt);
+		re_qp->dbr_obj = dbr_obj;
+	}
+
+	re_qp->rdev = rdev;
+	ret = bnxt_re_dv_init_qp_attr(re_qp, uctx, init_attr, req, dbr_obj);
+	if (ret)
+		goto dbr_rel;
+
+	ret = bnxt_re_dv_init_user_qp(rdev, uctx, re_qp, init_attr, req,
+				      sq_umem, rq_umem);
+	if (ret)
+		goto dbr_rel;
+
+	ret = bnxt_re_dv_qp_init_msn(rdev, re_qp, req);
+	if (ret)
+		goto free_umem;
+
+	ret = bnxt_re_setup_qp_hwqs(re_qp, true);
+	if (ret)
+		goto free_umem;
+
+	ret = bnxt_qplib_create_qp(&rdev->qplib_res, &re_qp->qplib_qp);
+	if (ret) {
+		ibdev_err(&rdev->ibdev, "Failed to create HW QP");
+		goto free_hwq;
+	}
+
+	resp.qpid = re_qp->qplib_qp.id;
+	resp.comp_mask = BNXT_RE_QP_DV_SUPPORT;
+	resp.rsvd = 0;
+	ret = ib_copy_to_udata(udata, &resp, sizeof(resp));
+	if (ret)
+		goto free_qplib;
+
+	re_qp->ib_qp.qp_num = re_qp->qplib_qp.id;
+	bnxt_re_dv_init_qp(rdev, re_qp);
+	re_qp->is_dv_qp = true;
+	atomic_inc(&rdev->dv_qp_count);
+	return 0;
+
+free_qplib:
+	bnxt_qplib_destroy_qp(&rdev->qplib_res, &re_qp->qplib_qp);
+free_hwq:
+	bnxt_qplib_free_qp_res(&rdev->qplib_res, &re_qp->qplib_qp);
+free_umem:
+	bnxt_re_qp_free_umem(re_qp);
+dbr_rel:
+	if (dbr_obj)
+		atomic_dec(&dbr_obj->usecnt);
+	return ret;
+}
+
+int bnxt_re_dv_destroy_qp(struct bnxt_re_qp *qp)
+{
+	struct bnxt_re_dev *rdev = qp->rdev;
+	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
+	struct bnxt_qplib_nq *scq_nq = NULL;
+	struct bnxt_qplib_nq *rcq_nq = NULL;
+	int rc;
+
+	mutex_lock(&rdev->qp_lock);
+	list_del(&qp->list);
+	atomic_dec(&rdev->stats.res.qp_count);
+	if (qp->qplib_qp.type == CMDQ_CREATE_QP_TYPE_RC)
+		atomic_dec(&rdev->stats.res.rc_qp_count);
+	mutex_unlock(&rdev->qp_lock);
+
+	rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, qplib_qp);
+	if (rc)
+		ibdev_err_ratelimited(&rdev->ibdev,
+				      "id = %d failed rc = %d",
+				      qplib_qp->id, rc);
+
+	bnxt_qplib_free_qp_res(&rdev->qplib_res, qplib_qp);
+	bnxt_re_qp_free_umem(qp);
+
+	/* Flush all the entries of notification queue associated with
+	 * given qp.
+	 */
+	scq_nq = qplib_qp->scq->nq;
+	rcq_nq = qplib_qp->rcq->nq;
+	bnxt_re_synchronize_nq(scq_nq);
+	if (scq_nq != rcq_nq)
+		bnxt_re_synchronize_nq(rcq_nq);
+
+	atomic_dec(&rdev->dv_qp_count);
+	if (qp->dbr_obj)
+		atomic_dec(&qp->dbr_obj->usecnt);
+	return 0;
+}
+
+ADD_UVERBS_ATTRIBUTES_SIMPLE(
+	bnxt_re_qp_create,
+	UVERBS_OBJECT_QP,
+	UVERBS_METHOD_QP_CREATE,
+	UVERBS_ATTR_IDR(BNXT_RE_CREATE_QP_ATTR_DBR_HANDLE,
+			BNXT_RE_OBJECT_DBR,
+			UVERBS_ACCESS_READ,
+			UA_OPTIONAL));
+
+const struct uapi_definition bnxt_re_create_qp_defs[] = {
+	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_QP, &bnxt_re_qp_create),
+	{},
+};
+
 const struct uapi_definition bnxt_re_uapi_defs[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_ALLOC_PAGE),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_NOTIFY_DRV),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_GET_TOGGLE_MEM),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_DBR),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_DEFAULT_DBR),
+	UAPI_DEF_CHAIN(bnxt_re_create_qp_defs),
 	{}
 };
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 0d95eaee3885..b1d93327413f 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -967,7 +967,7 @@ static void bnxt_re_del_unique_gid(struct bnxt_re_dev *rdev)
 		dev_err(rdev_to_dev(rdev), "Failed to delete unique GID, rc: %d\n", rc);
 }
 
-static void bnxt_re_qp_free_umem(struct bnxt_re_qp *qp)
+void bnxt_re_qp_free_umem(struct bnxt_re_qp *qp)
 {
 	ib_umem_release(qp->rumem);
 	ib_umem_release(qp->sumem);
@@ -984,6 +984,9 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	unsigned int flags;
 	int rc;
 
+	if (qp->is_dv_qp)
+		return bnxt_re_dv_destroy_qp(qp);
+
 	bnxt_re_debug_rem_qpinfo(rdev, qp);
 
 	bnxt_qplib_flush_cqn_wq(&qp->qplib_qp);
@@ -1029,7 +1032,7 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	return 0;
 }
 
-static u8 __from_ib_qp_type(enum ib_qp_type type)
+u8 __from_ib_qp_type(enum ib_qp_type type)
 {
 	switch (type) {
 	case IB_QPT_GSI:
@@ -1265,7 +1268,7 @@ static int bnxt_re_qp_alloc_init_xrrq(struct bnxt_re_qp *qp)
 	return rc;
 }
 
-static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
+int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp, bool is_dv_qp)
 {
 	struct bnxt_qplib_res *res = &qp->rdev->qplib_res;
 	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
@@ -1279,12 +1282,17 @@ static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
 	hwq_attr.res = res;
 	hwq_attr.sginfo = &sq->sg_info;
 	hwq_attr.stride = bnxt_qplib_get_stride();
-	hwq_attr.depth = bnxt_qplib_get_depth(sq, wqe_mode, true);
 	hwq_attr.aux_stride = qplib_qp->psn_sz;
-	hwq_attr.aux_depth = (qplib_qp->psn_sz) ?
-		bnxt_qplib_set_sq_size(sq, wqe_mode) : 0;
-	if (qplib_qp->is_host_msn_tbl && qplib_qp->psn_sz)
+	if (!is_dv_qp) {
+		hwq_attr.depth = bnxt_qplib_get_depth(sq, wqe_mode, true);
+		hwq_attr.aux_depth = (qplib_qp->psn_sz) ?
+				bnxt_qplib_set_sq_size(sq, wqe_mode) : 0;
+		if (qplib_qp->is_host_msn_tbl && qplib_qp->psn_sz)
+			hwq_attr.aux_depth = qplib_qp->msn_tbl_sz;
+	} else {
+		hwq_attr.depth = sq->max_wqe;
 		hwq_attr.aux_depth = qplib_qp->msn_tbl_sz;
+	}
 	hwq_attr.type = HWQ_TYPE_QUEUE;
 	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
 	if (rc)
@@ -1295,10 +1303,16 @@ static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
 		      CMDQ_CREATE_QP_SQ_LVL_SFT);
 	sq->hwq.pg_sz_lvl = pg_sz_lvl;
 
+	if (qplib_qp->srq)
+		goto done;
+
 	hwq_attr.res = res;
 	hwq_attr.sginfo = &rq->sg_info;
 	hwq_attr.stride = bnxt_qplib_get_stride();
-	hwq_attr.depth = bnxt_qplib_get_depth(rq, qplib_qp->wqe_mode, false);
+	if (!is_dv_qp)
+		hwq_attr.depth = bnxt_qplib_get_depth(rq, qplib_qp->wqe_mode, false);
+	else
+		hwq_attr.depth = rq->max_wqe * 3;
 	hwq_attr.aux_stride = 0;
 	hwq_attr.aux_depth = 0;
 	hwq_attr.type = HWQ_TYPE_QUEUE;
@@ -1311,6 +1325,7 @@ static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
 		      CMDQ_CREATE_QP_RQ_LVL_SFT);
 	rq->hwq.pg_sz_lvl = pg_sz_lvl;
 
+done:
 	if (qplib_qp->psn_sz) {
 		rc = bnxt_re_qp_alloc_init_xrrq(qp);
 		if (rc)
@@ -1379,7 +1394,7 @@ static struct bnxt_re_qp *bnxt_re_create_shadow_qp
 	qp->qplib_qp.rq_hdr_buf_size = BNXT_QPLIB_MAX_GRH_HDR_SIZE_IPV6;
 	qp->qplib_qp.dpi = &rdev->dpi_privileged;
 
-	rc = bnxt_re_setup_qp_hwqs(qp);
+	rc = bnxt_re_setup_qp_hwqs(qp, false);
 	if (rc)
 		goto fail;
 
@@ -1676,7 +1691,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 
 	bnxt_re_qp_calculate_msn_psn_size(qp);
 
-	rc = bnxt_re_setup_qp_hwqs(qp);
+	rc = bnxt_re_setup_qp_hwqs(qp, false);
 	if (rc)
 		goto free_umem;
 
@@ -1803,15 +1818,22 @@ static int bnxt_re_add_unique_gid(struct bnxt_re_dev *rdev)
 	return rc;
 }
 
-int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
-		      struct ib_udata *udata)
+int bnxt_re_create_qp_umem(struct ib_qp *ib_qp,
+			   struct ib_qp_init_attr *qp_init_attr,
+			   struct ib_umem *sq_umem, struct ib_umem *rq_umem,
+			   struct uverbs_attr_bundle *attrs)
 {
-	struct bnxt_qplib_dev_attr *dev_attr;
-	struct bnxt_re_ucontext *uctx;
-	struct bnxt_re_qp_req ureq;
-	struct bnxt_re_dev *rdev;
+	struct bnxt_re_qp *qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
+	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ib_qp->device, ibdev);
+	struct ib_udata *udata = &attrs->driver_udata;
+	struct bnxt_re_ucontext *uctx = NULL;
+
+	/* Only get ucontext if attrs->context is valid (userspace path) */
+	if (attrs->context)
+		uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
+	struct bnxt_re_qp_req req = {};
 	struct bnxt_re_pd *pd;
-	struct bnxt_re_qp *qp;
 	struct ib_pd *ib_pd;
 	u32 active_qps;
 	int rc;
@@ -1820,12 +1842,31 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
 	rdev = pd->rdev;
 	dev_attr = rdev->dev_attr;
-	qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
 
-	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
-	if (udata)
-		if (ib_copy_from_udata(&ureq, udata,  min(udata->inlen, sizeof(ureq))))
+	/* At this point, udata (attrs->driver_udata) is always valid,
+	 * since even for the kernel path we would have initialized it in
+	 * bnxt_re_create_qp(). But in kernel path, udata->inlen will be 0,
+	 * so we skip userspace data handling.
+	 */
+	if (udata->inlen) {
+		if (ib_copy_from_udata(&req, udata, min(sizeof(req), udata->inlen)))
 			return -EFAULT;
+		if (req.comp_mask & BNXT_RE_QP_DV_SUPPORT) {
+			/* DV QP creation requires umem */
+			if (!sq_umem)
+				return -EINVAL;
+			/* rq_umem is optional if SRQ is used */
+			if (!qp_init_attr->srq && !rq_umem)
+				return -EINVAL;
+
+			return bnxt_re_dv_create_qp(rdev, udata, qp_init_attr, qp, &req,
+						    sq_umem, rq_umem);
+		}
+	}
+
+	/* Standard QP (non-DV): use req.qpsva/qprva */
+	if (sq_umem || rq_umem)
+		return -EINVAL;
 
 	rc = bnxt_re_test_qp_limits(rdev, qp_init_attr, dev_attr);
 	if (!rc) {
@@ -1834,7 +1875,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	}
 
 	qp->rdev = rdev;
-	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, uctx, &ureq);
+	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, uctx, &req);
 	if (rc)
 		goto fail;
 
@@ -1852,7 +1893,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 			goto free_hwq;
 		}
 
-		if (udata) {
+		if (udata->outlen) {
 			struct bnxt_re_qp_resp resp;
 
 			resp.qpid = qp->qplib_qp.id;
@@ -1909,6 +1950,22 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	return rc;
 }
 
+int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
+		      struct ib_udata *udata)
+{
+	struct uverbs_attr_bundle attrs_wrapper = {};
+	struct uverbs_attr_bundle *attrs;
+
+	if (udata) {
+		attrs = rdma_udata_to_uverbs_attr_bundle(udata);
+	} else {
+		/* Kernel path: use zero-initialized wrapper */
+		attrs = &attrs_wrapper;
+	}
+
+	return bnxt_re_create_qp_umem(ib_qp, qp_init_attr, NULL, NULL, attrs);
+}
+
 static u8 __from_ib_qp_state(enum ib_qp_state state)
 {
 	switch (state) {
@@ -3241,7 +3298,7 @@ int bnxt_re_post_recv(struct ib_qp *ib_qp, const struct ib_recv_wr *wr,
 	return rc;
 }
 
-static struct bnxt_qplib_nq *bnxt_re_get_nq(struct bnxt_re_dev *rdev)
+struct bnxt_qplib_nq *bnxt_re_get_nq(struct bnxt_re_dev *rdev)
 {
 	int min, indx;
 
@@ -3256,7 +3313,7 @@ static struct bnxt_qplib_nq *bnxt_re_get_nq(struct bnxt_re_dev *rdev)
 	return &rdev->nqr->nq[min];
 }
 
-static void bnxt_re_put_nq(struct bnxt_re_dev *rdev, struct bnxt_qplib_nq *nq)
+void bnxt_re_put_nq(struct bnxt_re_dev *rdev, struct bnxt_qplib_nq *nq)
 {
 	mutex_lock(&rdev->nqr->load_lock);
 	nq->load--;
@@ -3284,6 +3341,8 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 
 	bnxt_re_put_nq(rdev, nq);
 	ib_umem_release(cq->umem);
+	if (cq->is_dv_cq)
+		atomic_dec(&rdev->dv_cq_count);
 
 	atomic_dec(&rdev->stats.res.cq_count);
 	kfree(cq->cql);
@@ -3292,6 +3351,27 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 
 int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct uverbs_attr_bundle *attrs)
+{
+	return bnxt_re_create_cq_umem(ibcq, attr, NULL, attrs);
+}
+
+static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
+{
+	struct bnxt_re_dev *rdev = cq->rdev;
+
+	bnxt_qplib_resize_cq_complete(&rdev->qplib_res, &cq->qplib_cq);
+
+	cq->qplib_cq.max_wqe = cq->resize_cqe;
+	if (cq->resize_umem) {
+		ib_umem_release(cq->umem);
+		cq->umem = cq->resize_umem;
+		cq->resize_umem = NULL;
+		cq->resize_cqe = 0;
+	}
+}
+
+int bnxt_re_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			   struct ib_umem *umem, struct uverbs_attr_bundle *attrs)
 {
 	struct bnxt_re_cq *cq = container_of(ibcq, struct bnxt_re_cq, ib_cq);
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibcq->device, ibdev);
@@ -3299,7 +3379,9 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct bnxt_re_ucontext *uctx =
 		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
+	struct bnxt_re_cq_resp resp = {};
 	struct bnxt_qplib_chip_ctx *cctx;
+	struct bnxt_re_cq_req req = {};
 	int cqe = attr->cqe;
 	int rc, entries;
 	u32 active_cqs;
@@ -3317,6 +3399,18 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cctx = rdev->chip_ctx;
 	cq->qplib_cq.cq_handle = (u64)(unsigned long)(&cq->qplib_cq);
 
+	if (udata) {
+		if (ib_copy_from_udata(&req, udata, min(sizeof(req), udata->inlen)))
+			return -EFAULT;
+		if (req.comp_mask & BNXT_RE_CQ_DV_SUPPORT) {
+			/* DV CQ creation requires umem */
+			if (!umem)
+				return -EINVAL;
+
+			return bnxt_re_dv_create_cq(rdev, udata, cq, &req, umem);
+		}
+	}
+
 	entries = bnxt_re_init_depth(cqe + 1, uctx);
 	if (entries > dev_attr->max_cq_wqes + 1)
 		entries = dev_attr->max_cq_wqes + 1;
@@ -3324,12 +3418,11 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->qplib_cq.sg_info.pgsize = PAGE_SIZE;
 	cq->qplib_cq.sg_info.pgshft = PAGE_SHIFT;
 	if (udata) {
-		struct bnxt_re_cq_req req;
-		if (ib_copy_from_udata(&req, udata, sizeof(req))) {
-			rc = -EFAULT;
+		if (umem) {
+			/* Standard CQ (non-DV): use req.cq_va */
+			rc = -EINVAL;
 			goto fail;
 		}
-
 		cq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
 				       entries * sizeof(struct cq_base),
 				       IB_ACCESS_LOCAL_WRITE);
@@ -3370,8 +3463,6 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	spin_lock_init(&cq->cq_lock);
 
 	if (udata) {
-		struct bnxt_re_cq_resp resp = {};
-
 		if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
 			hash_add(rdev->cq_hash, &cq->hash_entry, cq->qplib_cq.id);
 			/* Allocate a page */
@@ -3399,27 +3490,13 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 free_mem:
 	free_page((unsigned long)cq->uctx_cq_page);
 c2fail:
-	ib_umem_release(cq->umem);
+	if (cq->umem && !umem)
+		ib_umem_release(cq->umem);
 fail:
 	kfree(cq->cql);
 	return rc;
 }
 
-static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
-{
-	struct bnxt_re_dev *rdev = cq->rdev;
-
-	bnxt_qplib_resize_cq_complete(&rdev->qplib_res, &cq->qplib_cq);
-
-	cq->qplib_cq.max_wqe = cq->resize_cqe;
-	if (cq->resize_umem) {
-		ib_umem_release(cq->umem);
-		cq->umem = cq->resize_umem;
-		cq->resize_umem = NULL;
-		cq->resize_cqe = 0;
-	}
-}
-
 int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 {
 	struct bnxt_qplib_sg_info sg_info = {};
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 33e0f66b39eb..902135d0aa34 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -96,6 +96,8 @@ struct bnxt_re_qp {
 	struct bnxt_re_cq	*scq;
 	struct bnxt_re_cq	*rcq;
 	struct dentry		*dentry;
+	bool			is_dv_qp;
+	struct bnxt_re_dbr_obj *dbr_obj; /* doorbell region */
 };
 
 struct bnxt_re_cq {
@@ -113,6 +115,7 @@ struct bnxt_re_cq {
 	int			resize_cqe;
 	void			*uctx_cq_page;
 	struct hlist_node	hash_entry;
+	bool			is_dv_cq;
 };
 
 struct bnxt_re_mr {
@@ -243,6 +246,10 @@ int bnxt_re_post_srq_recv(struct ib_srq *srq, const struct ib_recv_wr *recv_wr,
 			  const struct ib_recv_wr **bad_recv_wr);
 int bnxt_re_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *qp_init_attr,
 		      struct ib_udata *udata);
+int bnxt_re_create_qp_umem(struct ib_qp *ib_qp,
+			   struct ib_qp_init_attr *qp_init_attr,
+			   struct ib_umem *sq_umem, struct ib_umem *rq_umem,
+			   struct uverbs_attr_bundle *attrs);
 int bnxt_re_modify_qp(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
 		      int qp_attr_mask, struct ib_udata *udata);
 int bnxt_re_query_qp(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
@@ -254,6 +261,8 @@ int bnxt_re_post_recv(struct ib_qp *qp, const struct ib_recv_wr *recv_wr,
 		      const struct ib_recv_wr **bad_recv_wr);
 int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct uverbs_attr_bundle *attrs);
+int bnxt_re_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			   struct ib_umem *umem, struct uverbs_attr_bundle *attrs);
 int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata);
 int bnxt_re_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int bnxt_re_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc);
@@ -303,4 +312,15 @@ void bnxt_re_unlock_cqs(struct bnxt_re_qp *qp, unsigned long flags);
 struct bnxt_re_user_mmap_entry*
 bnxt_re_mmap_entry_insert(struct bnxt_re_ucontext *uctx, u64 mem_offset,
 			  enum bnxt_re_mmap_flag mmap_flag, u64 *offset);
+u8 __from_ib_qp_type(enum ib_qp_type type);
+int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp, bool is_dv_qp);
+void bnxt_re_qp_free_umem(struct bnxt_re_qp *qp);
+int bnxt_re_dv_create_cq(struct bnxt_re_dev *rdev, struct ib_udata *udata,
+			 struct bnxt_re_cq *re_cq, struct bnxt_re_cq_req *req,
+			 struct ib_umem *umem);
+int bnxt_re_dv_create_qp(struct bnxt_re_dev *rdev, struct ib_udata *udata,
+			 struct ib_qp_init_attr *init_attr,
+			 struct bnxt_re_qp *re_qp, struct bnxt_re_qp_req *req,
+			 struct ib_umem *sq_umem, struct ib_umem *rq_umem);
+int bnxt_re_dv_destroy_qp(struct bnxt_re_qp *qp);
 #endif /* __BNXT_RE_IB_VERBS_H__ */
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 73003ad25ee8..e38724812cc6 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1334,7 +1334,9 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.alloc_ucontext = bnxt_re_alloc_ucontext,
 	.create_ah = bnxt_re_create_ah,
 	.create_cq = bnxt_re_create_cq,
+	.create_cq_umem = bnxt_re_create_cq_umem,
 	.create_qp = bnxt_re_create_qp,
+	.create_qp_umem = bnxt_re_create_qp_umem,
 	.create_srq = bnxt_re_create_srq,
 	.create_user_ah = bnxt_re_create_ah,
 	.dealloc_pd = bnxt_re_dealloc_pd,
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index 51f8614a7c4f..b4ff16a36284 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -101,10 +101,13 @@ struct bnxt_re_pd_resp {
 struct bnxt_re_cq_req {
 	__aligned_u64 cq_va;
 	__aligned_u64 cq_handle;
+	__aligned_u64 comp_mask;
+	__u32 ncqe;
 };
 
 enum bnxt_re_cq_mask {
 	BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT = 0x1,
+	BNXT_RE_CQ_DV_SUPPORT = 0x2
 };
 
 struct bnxt_re_cq_resp {
@@ -121,6 +124,7 @@ struct bnxt_re_resize_cq_req {
 
 enum bnxt_re_qp_mask {
 	BNXT_RE_QP_REQ_MASK_VAR_WQE_SQ_SLOTS = 0x1,
+	BNXT_RE_QP_DV_SUPPORT = 0x2,
 };
 
 struct bnxt_re_qp_req {
@@ -129,11 +133,22 @@ struct bnxt_re_qp_req {
 	__aligned_u64 qp_handle;
 	__aligned_u64 comp_mask;
 	__u32 sq_slots;
+	__u32 pd_id;
+	__u32 sq_wqe_sz;
+	__u32 sq_psn_sz;
+	__u32 sq_npsn;
+	__u32 rq_slots;
+	__u32 rq_wqe_sz;
+};
+
+enum bnxt_re_create_qp_attrs {
+	BNXT_RE_CREATE_QP_ATTR_DBR_HANDLE = UVERBS_ID_DRIVER_NS_WITH_UHW,
 };
 
 struct bnxt_re_qp_resp {
 	__u32 qpid;
 	__u32 rsvd;
+	__aligned_u64 comp_mask;
 };
 
 struct bnxt_re_srq_req {
-- 
2.51.2.636.ga99f379adf


