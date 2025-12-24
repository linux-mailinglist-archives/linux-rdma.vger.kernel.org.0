Return-Path: <linux-rdma+bounces-15198-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D585CDB574
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 05:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABD7A3008045
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 04:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17D62BE02A;
	Wed, 24 Dec 2025 04:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AnyjZlMm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315C329B793
	for <linux-rdma@vger.kernel.org>; Wed, 24 Dec 2025 04:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766550992; cv=none; b=BWgN/RDCalsBfXNH8DL6VYNgXVJOn1F0zOOKYGMw0eoV4VN/1Ra6Ls5AhLTI6LQ/CGv68qTioW+RNQBAxZMsuAF2lr48tMoBYuJsH4sqEHGhXg9WhAYYa9qAflbFbZpgUsTrldis2s9rn6ePpGnsQuS4tdqMS/FsHd5UemIUKt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766550992; c=relaxed/simple;
	bh=d7F5WeL0ysqO0Cwud5L/MjeJqs60kUaoxsMfaV8yy+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYDHRK9u2VUJtkL69Fu0LIe2Z6uSsQ9r1fmf06McTn0jaAqmfOVXfJZn5pW0ECI3BPbEaCBu+ITewE9hOC3mQ4MYQVu9Lg8eEmRHZL2wI4a8mR5lrn+LyEVRXJzPiXRu04q+a68uT8G/GbtEZeyfmTO+e25e6fbkfdkohkC7r4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AnyjZlMm; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-88a367a1db0so91977046d6.3
        for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 20:36:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766550989; x=1767155789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ime1HF8f1XzYLUYioBzKwFoAp/LGt22heVno5904iZw=;
        b=nYXIheof72K4sPS5zhaYIu+uop5wo94ARmG/r3lJ+b0vyHciqiWlV/GgxTAyCLFEGv
         GVV6uOksn23axMZgNX/phf3wIQknScjoUcyl3+WYMRDS700yy8TVsrA/yu8x2ZqLycOG
         CWKftCm47fDOJe9lSVHuVsVwn3xwzC19Np1kFVi7k5a5isroyau+2N8+/+YKmEUtej0P
         qTzxVtlVhLy1+mrbQVGlvDt2GWm/ThvoioeslY3GOKHJK4B3Hgyq7BoHM66xE/KBeXIg
         rq8Qv1dC8PtLXbgBHcWVClx2mXopbJd1zMtBBGF2l1tFqB28c461AxDqTEqe64KarTOH
         kwug==
X-Gm-Message-State: AOJu0Yy9d4oVm5xHqEX2iNr3GWSmdfWNBhm66gPNvkdSGw9HuZcvkJJf
	TEJK1J+sDVHdwdcnpqjUUxW+x6iUWAOfYr6QyVKbuCElA/IT2tBacCoBYUdtysEG7LIwO5CqdTk
	+djSK3Ujn2+osdQuGhuQITDfyc3sFSayuXAASVYG9mHrS1Wfm8B800FexZ/qk5iw+HexMH4nI4o
	Wb7UUkqZ0EUa0leH8KtotlwB00nTS7O+Qs52QOVNKsp2osSH7bZyyWD1ja5tVLwtV9S904cKA7Y
	+8hfKtTkrtAANeO+7Uv0d29W9J3
X-Gm-Gg: AY/fxX6AdN8GxOAJf4utV559y5o/SNUiheh+8S7IJwiqjiMtC6P+VoDXAmSgzM8aS7l
	JXci03ImBml6t/RcdcfnalcGlE4q+kOZgYYfjeMZwVWohoxaQFSBkGP9MfA2a+Cfm1D7kPsvrvj
	5QIb8yYqpPRwqzJjF4UrGZA/D1dLolp/SQI7USH87dJI9tTLub9kYJmNnVSsPltgtJ6pt+sXDsO
	RGoJJ1PF8o6KY+rwYrnh/L3kQO/wZd1agjvhpQ/mFm6zsBSiUN+qBfclEPcSTwZq0i+LQp2GcdH
	6OfXT46hdhuyXWsGyaIFdX9FhM7Vi0mKdqaHJaouo8RiNHApXBCqfno/eU4WNTP6wxLtMyEf4Uy
	W06wwGxI2XnUupOOWE7thB5+Vrv9GIKwiELToZp6M9j75lAOVmkjIQpo35BO/D2bvDFx845+Wnp
	i/4yye3wZzSF7e4NJIlFCFwlRa3Q6juoxltXzM2icRJj4R2vuSBpJcug==
X-Google-Smtp-Source: AGHT+IHBInFA3Xa+I/QdbXmaxnFij7aFL6hqaR4nMnUmlkHfcpBLt+17/cjWm7PhbRneW8MJSwlF/XpJgmU1
X-Received: by 2002:a05:6214:240f:b0:88a:449d:73d7 with SMTP id 6a1803df08f44-88d82339423mr277895956d6.28.1766550989025;
        Tue, 23 Dec 2025 20:36:29 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88d94fcc0dasm20614416d6.5.2025.12.23.20.36.28
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Dec 2025 20:36:29 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34ea5074935so4087866a91.0
        for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 20:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1766550988; x=1767155788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ime1HF8f1XzYLUYioBzKwFoAp/LGt22heVno5904iZw=;
        b=AnyjZlMm8Y7LbGde7NlizyrbxoZ3+h5LvqIf4FOmTbPno+ixsQFaaiFSnlQMxAnX4W
         iDNHmqJWJ/9cOkvZP6MsnfTdF0vtJtCZ2jb+axOdbtSN6o1dbdyRLhNgrC9PQqE6eKLJ
         nIhwZLz5H1vhnbWNNfcZ+GE2UwC8VHyapCZyo=
X-Received: by 2002:a17:90b:2682:b0:34c:6e10:fe71 with SMTP id 98e67ed59e1d1-34e921dcba4mr13375368a91.25.1766550987511;
        Tue, 23 Dec 2025 20:36:27 -0800 (PST)
X-Received: by 2002:a17:90b:2682:b0:34c:6e10:fe71 with SMTP id 98e67ed59e1d1-34e921dcba4mr13375360a91.25.1766550986967;
        Tue, 23 Dec 2025 20:36:26 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e921b165bsm14219525a91.6.2025.12.23.20.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 20:36:26 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v6 2/4] RDMA/bnxt_re: Refactor bnxt_qplib_create_qp() function
Date: Wed, 24 Dec 2025 09:56:00 +0530
Message-ID: <20251224042602.56255-3-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20251224042602.56255-1-sriharsha.basavapatna@broadcom.com>
References: <20251224042602.56255-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Inside bnxt_qplib_create_qp(), driver currently is doing
a lot of things like allocating HWQ memory for SQ/RQ/ORRQ/IRRQ,
initializing few of qplib_qp fields etc.

Refactored the code such that all memory allocation for HWQs
have been moved to bnxt_re_init_qp_attr() function and inside
bnxt_qplib_create_qp() function just initialize the request
structure and issue the HWRM command to firmware.

Introduced couple of new functions bnxt_re_setup_qp_hwqs() and
bnxt_re_setup_qp_swqs() moved the hwq and swq memory allocation
logic there.

This patch also introduces a change to store the PD id in
bnxt_qplib_qp. Instead of keeping a pointer to "struct
bnxt_qplib_pd", store PD id directly in "struct bnxt_qplib_qp".
This change is needed for a subsequent change in this patch
series. This PD ID value will be used in new DV implementation
for create_qp(). There is no functional change.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 205 ++++++++++++--
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 310 +++++++---------------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  10 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h |   6 +
 4 files changed, 301 insertions(+), 230 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index f758f92ba72b..0d95eaee3885 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -967,6 +967,12 @@ static void bnxt_re_del_unique_gid(struct bnxt_re_dev *rdev)
 		dev_err(rdev_to_dev(rdev), "Failed to delete unique GID, rc: %d\n", rc);
 }
 
+static void bnxt_re_qp_free_umem(struct bnxt_re_qp *qp)
+{
+	ib_umem_release(qp->rumem);
+	ib_umem_release(qp->sumem);
+}
+
 /* Queue Pairs */
 int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 {
@@ -1009,8 +1015,7 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	if (qp->qplib_qp.type == CMDQ_CREATE_QP_TYPE_RAW_ETHERTYPE)
 		bnxt_re_del_unique_gid(rdev);
 
-	ib_umem_release(qp->rumem);
-	ib_umem_release(qp->sumem);
+	bnxt_re_qp_free_umem(qp);
 
 	/* Flush all the entries of notification queue associated with
 	 * given qp.
@@ -1154,6 +1159,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	}
 
 	qplib_qp->dpi = &cntx->dpi;
+	qplib_qp->is_user = true;
 	return 0;
 rqfail:
 	ib_umem_release(qp->sumem);
@@ -1211,6 +1217,114 @@ static struct bnxt_re_ah *bnxt_re_create_shadow_qp_ah
 	return NULL;
 }
 
+static int bnxt_re_qp_alloc_init_xrrq(struct bnxt_re_qp *qp)
+{
+	struct bnxt_qplib_res *res = &qp->rdev->qplib_res;
+	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
+	struct bnxt_qplib_hwq_attr hwq_attr = {};
+	struct bnxt_qplib_sg_info sginfo = {};
+	struct bnxt_qplib_hwq *irrq, *orrq;
+	int rc, req_size;
+
+	orrq = &qplib_qp->orrq;
+	orrq->max_elements =
+		ORD_LIMIT_TO_ORRQ_SLOTS(qplib_qp->max_rd_atomic);
+	req_size = orrq->max_elements *
+		BNXT_QPLIB_MAX_ORRQE_ENTRY_SIZE + PAGE_SIZE - 1;
+	req_size &= ~(PAGE_SIZE - 1);
+	sginfo.pgsize = req_size;
+	sginfo.pgshft = PAGE_SHIFT;
+
+	hwq_attr.res = res;
+	hwq_attr.sginfo = &sginfo;
+	hwq_attr.depth = orrq->max_elements;
+	hwq_attr.stride = BNXT_QPLIB_MAX_ORRQE_ENTRY_SIZE;
+	hwq_attr.aux_stride = 0;
+	hwq_attr.aux_depth = 0;
+	hwq_attr.type = HWQ_TYPE_CTX;
+	rc = bnxt_qplib_alloc_init_hwq(orrq, &hwq_attr);
+	if (rc)
+		return rc;
+
+	irrq = &qplib_qp->irrq;
+	irrq->max_elements =
+		IRD_LIMIT_TO_IRRQ_SLOTS(qplib_qp->max_dest_rd_atomic);
+	req_size = irrq->max_elements *
+		BNXT_QPLIB_MAX_IRRQE_ENTRY_SIZE + PAGE_SIZE - 1;
+	req_size &= ~(PAGE_SIZE - 1);
+	sginfo.pgsize = req_size;
+	hwq_attr.sginfo = &sginfo;
+	hwq_attr.depth =  irrq->max_elements;
+	hwq_attr.stride = BNXT_QPLIB_MAX_IRRQE_ENTRY_SIZE;
+	rc = bnxt_qplib_alloc_init_hwq(irrq, &hwq_attr);
+	if (rc)
+		goto free_orrq_hwq;
+	return 0;
+free_orrq_hwq:
+	bnxt_qplib_free_hwq(res, orrq);
+	return rc;
+}
+
+static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
+{
+	struct bnxt_qplib_res *res = &qp->rdev->qplib_res;
+	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
+	struct bnxt_qplib_hwq_attr hwq_attr = {};
+	struct bnxt_qplib_q *sq = &qplib_qp->sq;
+	struct bnxt_qplib_q *rq = &qplib_qp->rq;
+	u8 wqe_mode = qplib_qp->wqe_mode;
+	u8 pg_sz_lvl;
+	int rc;
+
+	hwq_attr.res = res;
+	hwq_attr.sginfo = &sq->sg_info;
+	hwq_attr.stride = bnxt_qplib_get_stride();
+	hwq_attr.depth = bnxt_qplib_get_depth(sq, wqe_mode, true);
+	hwq_attr.aux_stride = qplib_qp->psn_sz;
+	hwq_attr.aux_depth = (qplib_qp->psn_sz) ?
+		bnxt_qplib_set_sq_size(sq, wqe_mode) : 0;
+	if (qplib_qp->is_host_msn_tbl && qplib_qp->psn_sz)
+		hwq_attr.aux_depth = qplib_qp->msn_tbl_sz;
+	hwq_attr.type = HWQ_TYPE_QUEUE;
+	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
+	if (rc)
+		return rc;
+
+	pg_sz_lvl = bnxt_qplib_base_pg_size(&sq->hwq) << CMDQ_CREATE_QP_SQ_PG_SIZE_SFT;
+	pg_sz_lvl |= ((sq->hwq.level & CMDQ_CREATE_QP_SQ_LVL_MASK) <<
+		      CMDQ_CREATE_QP_SQ_LVL_SFT);
+	sq->hwq.pg_sz_lvl = pg_sz_lvl;
+
+	hwq_attr.res = res;
+	hwq_attr.sginfo = &rq->sg_info;
+	hwq_attr.stride = bnxt_qplib_get_stride();
+	hwq_attr.depth = bnxt_qplib_get_depth(rq, qplib_qp->wqe_mode, false);
+	hwq_attr.aux_stride = 0;
+	hwq_attr.aux_depth = 0;
+	hwq_attr.type = HWQ_TYPE_QUEUE;
+	rc = bnxt_qplib_alloc_init_hwq(&rq->hwq, &hwq_attr);
+	if (rc)
+		goto free_sq_hwq;
+	pg_sz_lvl = bnxt_qplib_base_pg_size(&rq->hwq) <<
+		CMDQ_CREATE_QP_RQ_PG_SIZE_SFT;
+	pg_sz_lvl |= ((rq->hwq.level & CMDQ_CREATE_QP_RQ_LVL_MASK) <<
+		      CMDQ_CREATE_QP_RQ_LVL_SFT);
+	rq->hwq.pg_sz_lvl = pg_sz_lvl;
+
+	if (qplib_qp->psn_sz) {
+		rc = bnxt_re_qp_alloc_init_xrrq(qp);
+		if (rc)
+			goto free_rq_hwq;
+	}
+
+	return 0;
+free_rq_hwq:
+	bnxt_qplib_free_hwq(res, &rq->hwq);
+free_sq_hwq:
+	bnxt_qplib_free_hwq(res, &sq->hwq);
+	return rc;
+}
+
 static struct bnxt_re_qp *bnxt_re_create_shadow_qp
 				(struct bnxt_re_pd *pd,
 				 struct bnxt_qplib_res *qp1_res,
@@ -1229,9 +1343,10 @@ static struct bnxt_re_qp *bnxt_re_create_shadow_qp
 	/* Initialize the shadow QP structure from the QP1 values */
 	ether_addr_copy(qp->qplib_qp.smac, rdev->netdev->dev_addr);
 
-	qp->qplib_qp.pd = &pd->qplib_pd;
+	qp->qplib_qp.pd_id = pd->qplib_pd.id;
 	qp->qplib_qp.qp_handle = (u64)(unsigned long)(&qp->qplib_qp);
 	qp->qplib_qp.type = IB_QPT_UD;
+	qp->qplib_qp.cctx = rdev->chip_ctx;
 
 	qp->qplib_qp.max_inline_data = 0;
 	qp->qplib_qp.sig_type = true;
@@ -1264,10 +1379,14 @@ static struct bnxt_re_qp *bnxt_re_create_shadow_qp
 	qp->qplib_qp.rq_hdr_buf_size = BNXT_QPLIB_MAX_GRH_HDR_SIZE_IPV6;
 	qp->qplib_qp.dpi = &rdev->dpi_privileged;
 
-	rc = bnxt_qplib_create_qp(qp1_res, &qp->qplib_qp);
+	rc = bnxt_re_setup_qp_hwqs(qp);
 	if (rc)
 		goto fail;
 
+	rc = bnxt_qplib_create_qp(qp1_res, &qp->qplib_qp);
+	if (rc)
+		goto free_hwq;
+
 	spin_lock_init(&qp->sq_lock);
 	INIT_LIST_HEAD(&qp->list);
 	mutex_lock(&rdev->qp_lock);
@@ -1275,6 +1394,9 @@ static struct bnxt_re_qp *bnxt_re_create_shadow_qp
 	atomic_inc(&rdev->stats.res.qp_count);
 	mutex_unlock(&rdev->qp_lock);
 	return qp;
+
+free_hwq:
+	bnxt_qplib_free_qp_res(&rdev->qplib_res, &qp->qplib_qp);
 fail:
 	kfree(qp);
 	return NULL;
@@ -1445,6 +1567,39 @@ static int bnxt_re_init_qp_type(struct bnxt_re_dev *rdev,
 	return qptype;
 }
 
+static void bnxt_re_qp_calculate_msn_psn_size(struct bnxt_re_qp *qp)
+{
+	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
+	struct bnxt_qplib_q *sq = &qplib_qp->sq;
+	struct bnxt_re_dev *rdev = qp->rdev;
+	u8 wqe_mode = qplib_qp->wqe_mode;
+
+	if (rdev->dev_attr)
+		qplib_qp->is_host_msn_tbl =
+			_is_host_msn_table(rdev->dev_attr->dev_cap_flags2);
+
+	if (qplib_qp->type == CMDQ_CREATE_QP_TYPE_RC) {
+		qplib_qp->psn_sz = bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx) ?
+			sizeof(struct sq_psn_search_ext) :
+			sizeof(struct sq_psn_search);
+		if (qplib_qp->is_host_msn_tbl) {
+			qplib_qp->psn_sz = sizeof(struct sq_msn_search);
+			qplib_qp->msn = 0;
+		}
+	}
+
+	/* Update msn tbl size */
+	if (qplib_qp->is_host_msn_tbl && qplib_qp->psn_sz) {
+		if (wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC)
+			qplib_qp->msn_tbl_sz =
+				roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, wqe_mode));
+		else
+			qplib_qp->msn_tbl_sz =
+				roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, wqe_mode)) / 2;
+		qplib_qp->msn = 0;
+	}
+}
+
 static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 				struct ib_qp_init_attr *init_attr,
 				struct bnxt_re_ucontext *uctx,
@@ -1462,17 +1617,17 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 
 	/* Setup misc params */
 	ether_addr_copy(qplqp->smac, rdev->netdev->dev_addr);
-	qplqp->pd = &pd->qplib_pd;
+	qplqp->pd_id = pd->qplib_pd.id;
 	qplqp->qp_handle = (u64)qplqp;
 	qplqp->max_inline_data = init_attr->cap.max_inline_data;
 	qplqp->sig_type = init_attr->sq_sig_type == IB_SIGNAL_ALL_WR;
 	qptype = bnxt_re_init_qp_type(rdev, init_attr);
-	if (qptype < 0) {
-		rc = qptype;
-		goto out;
-	}
+	if (qptype < 0)
+		return qptype;
 	qplqp->type = (u8)qptype;
 	qplqp->wqe_mode = bnxt_re_is_var_size_supported(rdev, uctx);
+	qplqp->dev_cap_flags = dev_attr->dev_cap_flags;
+	qplqp->cctx = rdev->chip_ctx;
 	if (init_attr->qp_type == IB_QPT_RC) {
 		qplqp->max_rd_atomic = dev_attr->max_qp_rd_atom;
 		qplqp->max_dest_rd_atomic = dev_attr->max_qp_init_rd_atom;
@@ -1502,20 +1657,32 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 	/* Setup RQ/SRQ */
 	rc = bnxt_re_init_rq_attr(qp, init_attr, uctx);
 	if (rc)
-		goto out;
+		return rc;
 	if (init_attr->qp_type == IB_QPT_GSI)
 		bnxt_re_adjust_gsi_rq_attr(qp);
 
 	/* Setup SQ */
 	rc = bnxt_re_init_sq_attr(qp, init_attr, uctx, ureq);
 	if (rc)
-		goto out;
+		return rc;
 	if (init_attr->qp_type == IB_QPT_GSI)
 		bnxt_re_adjust_gsi_sq_attr(qp, init_attr, uctx);
 
-	if (uctx) /* This will update DPI and qp_handle */
+	if (uctx) { /* This will update DPI and qp_handle */
 		rc = bnxt_re_init_user_qp(rdev, pd, qp, uctx, ureq);
-out:
+		if (rc)
+			return rc;
+	}
+
+	bnxt_re_qp_calculate_msn_psn_size(qp);
+
+	rc = bnxt_re_setup_qp_hwqs(qp);
+	if (rc)
+		goto free_umem;
+
+	return 0;
+free_umem:
+	bnxt_re_qp_free_umem(qp);
 	return rc;
 }
 
@@ -1573,6 +1740,7 @@ static int bnxt_re_create_gsi_qp(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
+	qplqp->cctx = rdev->chip_ctx;
 
 	qplqp->rq_hdr_buf_size = BNXT_QPLIB_MAX_QP1_RQ_HDR_SIZE_V2;
 	qplqp->sq_hdr_buf_size = BNXT_QPLIB_MAX_QP1_SQ_HDR_SIZE_V2;
@@ -1676,13 +1844,14 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 		if (rc == -ENODEV)
 			goto qp_destroy;
 		if (rc)
-			goto fail;
+			goto free_hwq;
 	} else {
 		rc = bnxt_qplib_create_qp(&rdev->qplib_res, &qp->qplib_qp);
 		if (rc) {
 			ibdev_err(&rdev->ibdev, "Failed to create HW QP");
-			goto free_umem;
+			goto free_hwq;
 		}
+
 		if (udata) {
 			struct bnxt_re_qp_resp resp;
 
@@ -1733,9 +1902,9 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	return 0;
 qp_destroy:
 	bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp);
-free_umem:
-	ib_umem_release(qp->rumem);
-	ib_umem_release(qp->sumem);
+free_hwq:
+	bnxt_qplib_free_qp_res(&rdev->qplib_res, &qp->qplib_qp);
+	bnxt_re_qp_free_umem(qp);
 fail:
 	return rc;
 }
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index c88f049136fc..43535c6ec70b 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -793,8 +793,6 @@ int bnxt_qplib_post_srq_recv(struct bnxt_qplib_srq *srq,
 	return 0;
 }
 
-/* QP */
-
 static int bnxt_qplib_alloc_init_swq(struct bnxt_qplib_q *que)
 {
 	int indx;
@@ -813,9 +811,71 @@ static int bnxt_qplib_alloc_init_swq(struct bnxt_qplib_q *que)
 	return 0;
 }
 
+static int bnxt_re_setup_qp_swqs(struct bnxt_qplib_qp *qplqp)
+{
+	struct bnxt_qplib_q *sq = &qplqp->sq;
+	struct bnxt_qplib_q *rq = &qplqp->rq;
+	int rc;
+
+	if (qplqp->is_user)
+		return 0;
+
+	rc = bnxt_qplib_alloc_init_swq(sq);
+	if (rc)
+		return rc;
+
+	if (!qplqp->srq) {
+		rc = bnxt_qplib_alloc_init_swq(rq);
+		if (rc)
+			goto free_sq_swq;
+	}
+
+	return 0;
+free_sq_swq:
+	kfree(sq->swq);
+	return rc;
+}
+
+static void bnxt_qp_init_dbinfo(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
+{
+	struct bnxt_qplib_q *sq = &qp->sq;
+	struct bnxt_qplib_q *rq = &qp->rq;
+
+	sq->dbinfo.hwq = &sq->hwq;
+	sq->dbinfo.xid = qp->id;
+	sq->dbinfo.db = qp->dpi->dbr;
+	sq->dbinfo.max_slot = bnxt_qplib_set_sq_max_slot(qp->wqe_mode);
+	sq->dbinfo.flags = 0;
+	if (rq->max_wqe) {
+		rq->dbinfo.hwq = &rq->hwq;
+		rq->dbinfo.xid = qp->id;
+		rq->dbinfo.db = qp->dpi->dbr;
+		rq->dbinfo.max_slot = bnxt_qplib_set_rq_max_slot(rq->wqe_size);
+		rq->dbinfo.flags = 0;
+	}
+}
+
+static void bnxt_qplib_init_psn_ptr(struct bnxt_qplib_qp *qp, int size)
+{
+	struct bnxt_qplib_hwq *sq_hwq;
+	struct bnxt_qplib_q *sq;
+	u64 fpsne, psn_pg;
+	u16 indx_pad = 0;
+
+	sq = &qp->sq;
+	sq_hwq = &sq->hwq;
+	/* First psn entry */
+	fpsne = (u64)bnxt_qplib_get_qe(sq_hwq, sq_hwq->depth, &psn_pg);
+	if (!IS_ALIGNED(fpsne, PAGE_SIZE))
+		indx_pad = (fpsne & ~PAGE_MASK) / size;
+	sq_hwq->pad_pgofft = indx_pad;
+	sq_hwq->pad_pg = (u64 *)psn_pg;
+	sq_hwq->pad_stride = size;
+}
+
+/* QP */
 int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 {
-	struct bnxt_qplib_hwq_attr hwq_attr = {};
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct creq_create_qp1_resp resp = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
@@ -824,7 +884,6 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	struct cmdq_create_qp1 req = {};
 	struct bnxt_qplib_pbl *pbl;
 	u32 qp_flags = 0;
-	u8 pg_sz_lvl;
 	u32 tbl_indx;
 	int rc;
 
@@ -838,26 +897,12 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	req.qp_handle = cpu_to_le64(qp->qp_handle);
 
 	/* SQ */
-	hwq_attr.res = res;
-	hwq_attr.sginfo = &sq->sg_info;
-	hwq_attr.stride = sizeof(struct sq_sge);
-	hwq_attr.depth = bnxt_qplib_get_depth(sq, qp->wqe_mode, false);
-	hwq_attr.type = HWQ_TYPE_QUEUE;
-	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
-	if (rc)
-		return rc;
-
-	rc = bnxt_qplib_alloc_init_swq(sq);
-	if (rc)
-		goto fail_sq;
+	sq->max_sw_wqe = bnxt_qplib_get_depth(sq, qp->wqe_mode, true);
+	req.sq_size = cpu_to_le32(sq->max_sw_wqe);
+	req.sq_pg_size_sq_lvl = sq->hwq.pg_sz_lvl;
 
-	req.sq_size = cpu_to_le32(bnxt_qplib_set_sq_size(sq, qp->wqe_mode));
 	pbl = &sq->hwq.pbl[PBL_LVL_0];
 	req.sq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
-	pg_sz_lvl = (bnxt_qplib_base_pg_size(&sq->hwq) <<
-		     CMDQ_CREATE_QP1_SQ_PG_SIZE_SFT);
-	pg_sz_lvl |= (sq->hwq.level & CMDQ_CREATE_QP1_SQ_LVL_MASK);
-	req.sq_pg_size_sq_lvl = pg_sz_lvl;
 	req.sq_fwo_sq_sge =
 		cpu_to_le16((sq->max_sge & CMDQ_CREATE_QP1_SQ_SGE_MASK) <<
 			     CMDQ_CREATE_QP1_SQ_SGE_SFT);
@@ -866,24 +911,10 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	/* RQ */
 	if (rq->max_wqe) {
 		rq->dbinfo.flags = 0;
-		hwq_attr.res = res;
-		hwq_attr.sginfo = &rq->sg_info;
-		hwq_attr.stride = sizeof(struct sq_sge);
-		hwq_attr.depth = bnxt_qplib_get_depth(rq, qp->wqe_mode, false);
-		hwq_attr.type = HWQ_TYPE_QUEUE;
-		rc = bnxt_qplib_alloc_init_hwq(&rq->hwq, &hwq_attr);
-		if (rc)
-			goto sq_swq;
-		rc = bnxt_qplib_alloc_init_swq(rq);
-		if (rc)
-			goto fail_rq;
 		req.rq_size = cpu_to_le32(rq->max_wqe);
 		pbl = &rq->hwq.pbl[PBL_LVL_0];
 		req.rq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
-		pg_sz_lvl = (bnxt_qplib_base_pg_size(&rq->hwq) <<
-			     CMDQ_CREATE_QP1_RQ_PG_SIZE_SFT);
-		pg_sz_lvl |= (rq->hwq.level & CMDQ_CREATE_QP1_RQ_LVL_MASK);
-		req.rq_pg_size_rq_lvl = pg_sz_lvl;
+		req.rq_pg_size_rq_lvl = rq->hwq.pg_sz_lvl;
 		req.rq_fwo_rq_sge =
 			cpu_to_le16((rq->max_sge &
 				     CMDQ_CREATE_QP1_RQ_SGE_MASK) <<
@@ -894,11 +925,11 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	rc = bnxt_qplib_alloc_qp_hdr_buf(res, qp);
 	if (rc) {
 		rc = -ENOMEM;
-		goto rq_rwq;
+		return rc;
 	}
 	qp_flags |= CMDQ_CREATE_QP1_QP_FLAGS_RESERVED_LKEY_ENABLE;
 	req.qp_flags = cpu_to_le32(qp_flags);
-	req.pd_id = cpu_to_le32(qp->pd->id);
+	req.pd_id = cpu_to_le32(qp->pd_id);
 
 	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req), sizeof(resp), 0);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
@@ -907,73 +938,39 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 
 	qp->id = le32_to_cpu(resp.xid);
 	qp->cur_qp_state = CMDQ_MODIFY_QP_NEW_STATE_RESET;
-	qp->cctx = res->cctx;
-	sq->dbinfo.hwq = &sq->hwq;
-	sq->dbinfo.xid = qp->id;
-	sq->dbinfo.db = qp->dpi->dbr;
-	sq->dbinfo.max_slot = bnxt_qplib_set_sq_max_slot(qp->wqe_mode);
-	if (rq->max_wqe) {
-		rq->dbinfo.hwq = &rq->hwq;
-		rq->dbinfo.xid = qp->id;
-		rq->dbinfo.db = qp->dpi->dbr;
-		rq->dbinfo.max_slot = bnxt_qplib_set_rq_max_slot(rq->wqe_size);
-	}
+
+	rc = bnxt_re_setup_qp_swqs(qp);
+	if (rc)
+		goto destroy_qp;
+	bnxt_qp_init_dbinfo(res, qp);
+
 	tbl_indx = map_qp_id_to_tbl_indx(qp->id, rcfw);
 	rcfw->qp_tbl[tbl_indx].qp_id = qp->id;
 	rcfw->qp_tbl[tbl_indx].qp_handle = (void *)qp;
 
 	return 0;
 
+destroy_qp:
+	bnxt_qplib_destroy_qp(res, qp);
 fail:
 	bnxt_qplib_free_qp_hdr_buf(res, qp);
-rq_rwq:
-	kfree(rq->swq);
-fail_rq:
-	bnxt_qplib_free_hwq(res, &rq->hwq);
-sq_swq:
-	kfree(sq->swq);
-fail_sq:
-	bnxt_qplib_free_hwq(res, &sq->hwq);
 	return rc;
 }
 
-static void bnxt_qplib_init_psn_ptr(struct bnxt_qplib_qp *qp, int size)
-{
-	struct bnxt_qplib_hwq *hwq;
-	struct bnxt_qplib_q *sq;
-	u64 fpsne, psn_pg;
-	u16 indx_pad = 0;
-
-	sq = &qp->sq;
-	hwq = &sq->hwq;
-	/* First psn entry */
-	fpsne = (u64)bnxt_qplib_get_qe(hwq, hwq->depth, &psn_pg);
-	if (!IS_ALIGNED(fpsne, PAGE_SIZE))
-		indx_pad = (fpsne & ~PAGE_MASK) / size;
-	hwq->pad_pgofft = indx_pad;
-	hwq->pad_pg = (u64 *)psn_pg;
-	hwq->pad_stride = size;
-}
-
 int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
-	struct bnxt_qplib_hwq_attr hwq_attr = {};
-	struct bnxt_qplib_sg_info sginfo = {};
 	struct creq_create_qp_resp resp = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
 	struct bnxt_qplib_q *sq = &qp->sq;
 	struct bnxt_qplib_q *rq = &qp->rq;
 	struct cmdq_create_qp req = {};
-	int rc, req_size, psn_sz = 0;
-	struct bnxt_qplib_hwq *xrrq;
 	struct bnxt_qplib_pbl *pbl;
 	u32 qp_flags = 0;
-	u8 pg_sz_lvl;
 	u32 tbl_indx;
 	u16 nsge;
+	int rc;
 
-	qp->is_host_msn_tbl = _is_host_msn_table(res->dattr->dev_cap_flags2);
 	sq->dbinfo.flags = 0;
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_CREATE_QP,
@@ -985,56 +982,10 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	req.qp_handle = cpu_to_le64(qp->qp_handle);
 
 	/* SQ */
-	if (qp->type == CMDQ_CREATE_QP_TYPE_RC) {
-		psn_sz = bnxt_qplib_is_chip_gen_p5_p7(res->cctx) ?
-			 sizeof(struct sq_psn_search_ext) :
-			 sizeof(struct sq_psn_search);
-
-		if (qp->is_host_msn_tbl) {
-			psn_sz = sizeof(struct sq_msn_search);
-			qp->msn = 0;
-		}
-	}
-
-	hwq_attr.res = res;
-	hwq_attr.sginfo = &sq->sg_info;
-	hwq_attr.stride = sizeof(struct sq_sge);
-	hwq_attr.depth = bnxt_qplib_get_depth(sq, qp->wqe_mode, true);
-	hwq_attr.aux_stride = psn_sz;
-	hwq_attr.aux_depth = psn_sz ? bnxt_qplib_set_sq_size(sq, qp->wqe_mode)
-				    : 0;
-	/* Update msn tbl size */
-	if (qp->is_host_msn_tbl && psn_sz) {
-		if (qp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC)
-			hwq_attr.aux_depth =
-				roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, qp->wqe_mode));
-		else
-			hwq_attr.aux_depth =
-				roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, qp->wqe_mode)) / 2;
-		qp->msn_tbl_sz = hwq_attr.aux_depth;
-		qp->msn = 0;
-	}
-
-	hwq_attr.type = HWQ_TYPE_QUEUE;
-	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
-	if (rc)
-		return rc;
-
-	if (!sq->hwq.is_user) {
-		rc = bnxt_qplib_alloc_init_swq(sq);
-		if (rc)
-			goto fail_sq;
-
-		if (psn_sz)
-			bnxt_qplib_init_psn_ptr(qp, psn_sz);
-	}
-	req.sq_size = cpu_to_le32(bnxt_qplib_set_sq_size(sq, qp->wqe_mode));
+	req.sq_size = cpu_to_le32(sq->max_sw_wqe);
 	pbl = &sq->hwq.pbl[PBL_LVL_0];
 	req.sq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
-	pg_sz_lvl = (bnxt_qplib_base_pg_size(&sq->hwq) <<
-		     CMDQ_CREATE_QP_SQ_PG_SIZE_SFT);
-	pg_sz_lvl |= (sq->hwq.level & CMDQ_CREATE_QP_SQ_LVL_MASK);
-	req.sq_pg_size_sq_lvl = pg_sz_lvl;
+	req.sq_pg_size_sq_lvl = sq->hwq.pg_sz_lvl;
 	req.sq_fwo_sq_sge =
 		cpu_to_le16(((sq->max_sge & CMDQ_CREATE_QP_SQ_SGE_MASK) <<
 			     CMDQ_CREATE_QP_SQ_SGE_SFT) | 0);
@@ -1043,29 +994,10 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	/* RQ */
 	if (!qp->srq) {
 		rq->dbinfo.flags = 0;
-		hwq_attr.res = res;
-		hwq_attr.sginfo = &rq->sg_info;
-		hwq_attr.stride = sizeof(struct sq_sge);
-		hwq_attr.depth = bnxt_qplib_get_depth(rq, qp->wqe_mode, false);
-		hwq_attr.aux_stride = 0;
-		hwq_attr.aux_depth = 0;
-		hwq_attr.type = HWQ_TYPE_QUEUE;
-		rc = bnxt_qplib_alloc_init_hwq(&rq->hwq, &hwq_attr);
-		if (rc)
-			goto sq_swq;
-		if (!rq->hwq.is_user) {
-			rc = bnxt_qplib_alloc_init_swq(rq);
-			if (rc)
-				goto fail_rq;
-		}
-
 		req.rq_size = cpu_to_le32(rq->max_wqe);
 		pbl = &rq->hwq.pbl[PBL_LVL_0];
 		req.rq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
-		pg_sz_lvl = (bnxt_qplib_base_pg_size(&rq->hwq) <<
-			     CMDQ_CREATE_QP_RQ_PG_SIZE_SFT);
-		pg_sz_lvl |= (rq->hwq.level & CMDQ_CREATE_QP_RQ_LVL_MASK);
-		req.rq_pg_size_rq_lvl = pg_sz_lvl;
+		req.rq_pg_size_rq_lvl = rq->hwq.pg_sz_lvl;
 		nsge = (qp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC) ?
 			6 : rq->max_sge;
 		req.rq_fwo_rq_sge =
@@ -1091,68 +1023,34 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	req.qp_flags = cpu_to_le32(qp_flags);
 
 	/* ORRQ and IRRQ */
-	if (psn_sz) {
-		xrrq = &qp->orrq;
-		xrrq->max_elements =
-			ORD_LIMIT_TO_ORRQ_SLOTS(qp->max_rd_atomic);
-		req_size = xrrq->max_elements *
-			   BNXT_QPLIB_MAX_ORRQE_ENTRY_SIZE + PAGE_SIZE - 1;
-		req_size &= ~(PAGE_SIZE - 1);
-		sginfo.pgsize = req_size;
-		sginfo.pgshft = PAGE_SHIFT;
-
-		hwq_attr.res = res;
-		hwq_attr.sginfo = &sginfo;
-		hwq_attr.depth = xrrq->max_elements;
-		hwq_attr.stride = BNXT_QPLIB_MAX_ORRQE_ENTRY_SIZE;
-		hwq_attr.aux_stride = 0;
-		hwq_attr.aux_depth = 0;
-		hwq_attr.type = HWQ_TYPE_CTX;
-		rc = bnxt_qplib_alloc_init_hwq(xrrq, &hwq_attr);
-		if (rc)
-			goto rq_swq;
-		pbl = &xrrq->pbl[PBL_LVL_0];
-		req.orrq_addr = cpu_to_le64(pbl->pg_map_arr[0]);
-
-		xrrq = &qp->irrq;
-		xrrq->max_elements = IRD_LIMIT_TO_IRRQ_SLOTS(
-						qp->max_dest_rd_atomic);
-		req_size = xrrq->max_elements *
-			   BNXT_QPLIB_MAX_IRRQE_ENTRY_SIZE + PAGE_SIZE - 1;
-		req_size &= ~(PAGE_SIZE - 1);
-		sginfo.pgsize = req_size;
-		hwq_attr.depth =  xrrq->max_elements;
-		hwq_attr.stride = BNXT_QPLIB_MAX_IRRQE_ENTRY_SIZE;
-		rc = bnxt_qplib_alloc_init_hwq(xrrq, &hwq_attr);
-		if (rc)
-			goto fail_orrq;
-
-		pbl = &xrrq->pbl[PBL_LVL_0];
-		req.irrq_addr = cpu_to_le64(pbl->pg_map_arr[0]);
+	if (qp->psn_sz) {
+		req.orrq_addr = cpu_to_le64(bnxt_qplib_get_base_addr(&qp->orrq));
+		req.irrq_addr = cpu_to_le64(bnxt_qplib_get_base_addr(&qp->irrq));
 	}
-	req.pd_id = cpu_to_le32(qp->pd->id);
+
+	req.pd_id = cpu_to_le32(qp->pd_id);
 
 	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
 				sizeof(resp), 0);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
-		goto fail;
+		return rc;
 
 	qp->id = le32_to_cpu(resp.xid);
+
+	if (!qp->is_user) {
+		rc = bnxt_re_setup_qp_swqs(qp);
+		if (rc)
+			goto destroy_qp;
+	}
+	bnxt_qp_init_dbinfo(res, qp);
+	if (qp->psn_sz)
+		bnxt_qplib_init_psn_ptr(qp, qp->psn_sz);
+
 	qp->cur_qp_state = CMDQ_MODIFY_QP_NEW_STATE_RESET;
 	INIT_LIST_HEAD(&qp->sq_flush);
 	INIT_LIST_HEAD(&qp->rq_flush);
 	qp->cctx = res->cctx;
-	sq->dbinfo.hwq = &sq->hwq;
-	sq->dbinfo.xid = qp->id;
-	sq->dbinfo.db = qp->dpi->dbr;
-	sq->dbinfo.max_slot = bnxt_qplib_set_sq_max_slot(qp->wqe_mode);
-	if (rq->max_wqe) {
-		rq->dbinfo.hwq = &rq->hwq;
-		rq->dbinfo.xid = qp->id;
-		rq->dbinfo.db = qp->dpi->dbr;
-		rq->dbinfo.max_slot = bnxt_qplib_set_rq_max_slot(rq->wqe_size);
-	}
 	spin_lock_bh(&rcfw->tbl_lock);
 	tbl_indx = map_qp_id_to_tbl_indx(qp->id, rcfw);
 	rcfw->qp_tbl[tbl_indx].qp_id = qp->id;
@@ -1160,18 +1058,8 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	spin_unlock_bh(&rcfw->tbl_lock);
 
 	return 0;
-fail:
-	bnxt_qplib_free_hwq(res, &qp->irrq);
-fail_orrq:
-	bnxt_qplib_free_hwq(res, &qp->orrq);
-rq_swq:
-	kfree(rq->swq);
-fail_rq:
-	bnxt_qplib_free_hwq(res, &rq->hwq);
-sq_swq:
-	kfree(sq->swq);
-fail_sq:
-	bnxt_qplib_free_hwq(res, &sq->hwq);
+destroy_qp:
+	bnxt_qplib_destroy_qp(res, qp);
 	return rc;
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 1b414a73b46d..c862fa7ba499 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -268,7 +268,7 @@ struct bnxt_qplib_q {
 };
 
 struct bnxt_qplib_qp {
-	struct bnxt_qplib_pd		*pd;
+	u32				pd_id;
 	struct bnxt_qplib_dpi		*dpi;
 	struct bnxt_qplib_chip_ctx	*cctx;
 	u64				qp_handle;
@@ -279,6 +279,7 @@ struct bnxt_qplib_qp {
 	u8				wqe_mode;
 	u8				state;
 	u8				cur_qp_state;
+	u8				is_user;
 	u64				modify_flags;
 	u32				max_inline_data;
 	u32				mtu;
@@ -343,9 +344,11 @@ struct bnxt_qplib_qp {
 	struct list_head		rq_flush;
 	u32				msn;
 	u32				msn_tbl_sz;
+	u32				psn_sz;
 	bool				is_host_msn_tbl;
 	u8				tos_dscp;
 	u32				ugid_index;
+	u16				dev_cap_flags;
 };
 
 #define BNXT_RE_MAX_MSG_SIZE	0x80000000
@@ -614,6 +617,11 @@ static inline void bnxt_qplib_swq_mod_start(struct bnxt_qplib_q *que, u32 idx)
 	que->swq_start = que->swq[idx].next_idx;
 }
 
+static inline u32 bnxt_qplib_get_stride(void)
+{
+	return sizeof(struct sq_sge);
+}
+
 static inline u32 bnxt_qplib_get_depth(struct bnxt_qplib_q *que, u8 wqe_mode, bool is_sq)
 {
 	u32 slots;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 2ea3b7f232a3..ccdab938d707 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -198,6 +198,7 @@ struct bnxt_qplib_hwq {
 	u32				cons;		/* raw */
 	u8				cp_bit;
 	u8				is_user;
+	u8				pg_sz_lvl;
 	u64				*pad_pg;
 	u32				pad_stride;
 	u32				pad_pgofft;
@@ -358,6 +359,11 @@ static inline u8 bnxt_qplib_get_ring_type(struct bnxt_qplib_chip_ctx *cctx)
 	       RING_ALLOC_REQ_RING_TYPE_ROCE_CMPL;
 }
 
+static inline u64 bnxt_qplib_get_base_addr(struct bnxt_qplib_hwq *hwq)
+{
+	return hwq->pbl[PBL_LVL_0].pg_map_arr[0];
+}
+
 static inline u8 bnxt_qplib_base_pg_size(struct bnxt_qplib_hwq *hwq)
 {
 	u8 pg_size = BNXT_QPLIB_HWRM_PG_SIZE_4K;
-- 
2.51.2.636.ga99f379adf


