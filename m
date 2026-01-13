Return-Path: <linux-rdma+bounces-15528-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5915CD1A931
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 18:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D594300E434
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 17:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA3433CE86;
	Tue, 13 Jan 2026 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dRVgpOnk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BEC34FF49
	for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768324692; cv=none; b=Aer5M1yHsL4lh4TojfOjs3osmctq81hy2J+HhiRohw5q9GC9V3PxVFErctjFgN2/HRD1WpHxlW4whm71WF3l0ah0JpgYOQjwnK4tgw7sfe9hp98pzijtWfs/oX5WIuDV8kzDe/LhqLG2MabgVrZ393JPo37mPBtIugI3V6b6BVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768324692; c=relaxed/simple;
	bh=boBLZwtDWwatm341YnocDoDqT5P84t4CMIqU6mpKhzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAdPlH0AnaGoYUUxE2WL2HorFA2yu2J1/pAivMhoDmRxH1zHsgDcHSxT0lwjfM/89ZGK710pC7M/XV3wW0+NBXlvnc7+DLF1Nht0UH3kq4mzsh/nGeYy+0MW9iUu8Da89dZSeJIIuW71Rdii2uZfUurnDgi7quMG2boKqEHKLHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dRVgpOnk; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-78e7ba9fc29so81910937b3.2
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 09:18:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768324689; x=1768929489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7vMwmxtTASNBvBFAwowT+YJrSK2JfOTzJj31OS0+kAc=;
        b=MV67ovWtNThNGkZszAcpUOTUy85VuO/fVWvyesqycjk++654fH0yQZthXs+rHZNNNE
         gqburFcs1KlYPygYaueHckO5etANEHWvBIKYQdrHUGjcLmle9cr0JR3Qy5TXJxztI1fg
         o8EBoLCHZDTN8UiXrvPVFlJjYgvA7e6nHQrZFbwvSTvJUoLp3Dkdjr+iePoRLeqx/3z8
         efh7js4v1nX/n2m1BX7nPs94TcebFi7X6mejLFcoYuiszl8bJcqp71KM4ha+LppRfjq/
         vDt0C/cZKh9R39Rvm4LSOl94u4rY/mRVSX8WwWpd5aYvDhkXwgs5vSAD6FCmRUtMVHCa
         W+wQ==
X-Gm-Message-State: AOJu0YyLTYed5MH2cEnQ2+oKAbA8R5R0qgXLNdvTHHbuvXR1Rb+AxK/m
	ouBimHkl7jByhf0KnAQ1VBdF4xxiA/TIFR6kyLoSlRztlbP5fJkGhdJrPJYQIbzcPvlxKmD5z+C
	GQ/yDC/pYmlI/3ZGYmiI0sxd/AFQUZUDxgkxBF1MHbyK/cZWkCYsBPLEHkvx5T9TCS9rcTrH59V
	6UKf3oFZGb7HubRUth6Ki+gusfCm2DsR3+7FFzN1DHt77+de5QS3zGYniiZqZGd+SnqXAduZvAq
	4mBqilyJSeQHiyHavJQ5hCV8Q7D
X-Gm-Gg: AY/fxX6+hmMDUxveH7tIJk97dT1xcr6tfZ+Jc4njBSCWOSONOkClpEchYRTSoghrLWD
	cumiZHWXPwjIOEOhdO2g+n6lHTQZwAEXix/LFNsf9kB3MRzHPPxEHWaQ6sXnRxU9296WD8dMDbh
	znFcJNFFwQjEAyhS2Q7NHvuxXCdJJ8PyXK6AZ5lg1ZXReIVB0APZxyHzE6ec4/mZdAaqN0VrhFJ
	MYoUSiPzCECHa4/GoM9rXePvCrluBL1UtBTJ6hknc14NwV7tQ+jIbxk6f9r8UJWXVFjywWLwRI3
	Yiyy1A/OisqRGXynC+20TV3P1MXD0JFe7P/sNrOBPF/VKBCl+c/KH2j7BJ/emKOMIt+rYgbyIGA
	7WDmlTar8Kb2bRkrKAY79i0R71aQQUc4WY9zkZYCJ3RCP3VHo6w4yqja/BMgfBIGwwnfNinTa4W
	UU7QTr
X-Google-Smtp-Source: AGHT+IGsDC7qx4FKzYu9XvCYmKtHKapauWlhXffypZFJeDPLBBem2WIKx+bDRmlgijKX1Pl61rx9hkvdw1EZ
X-Received: by 2002:a53:de06:0:b0:644:60d9:8673 with SMTP id 956f58d0204a3-64716ca08d0mr13863330d50.88.1768324689230;
        Tue, 13 Jan 2026 09:18:09 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6470d81bb3bsm2224163d50.6.2026.01.13.09.18.08
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jan 2026 09:18:09 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a377e15716so170594185ad.3
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 09:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768324688; x=1768929488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vMwmxtTASNBvBFAwowT+YJrSK2JfOTzJj31OS0+kAc=;
        b=dRVgpOnkY0xlEW1cWihljJLL69YH0FJXXI/fEpxLtTzswiac9knYnMlQzHMB8JJdOH
         VHpvuq5m0AU2QeNJ2eWmvmg49AXrQHKZSOR2ch9i5aVR7A0SSHWQoEDWwbvQ5yw6vF3x
         wLvbSyyWjf5gP10C1cuLbTXHMAg7EHVrWyqMs=
X-Received: by 2002:a17:903:9ce:b0:2a2:f1d4:3b64 with SMTP id d9443c01a7336-2a3ee4447e1mr220996785ad.21.1768324687562;
        Tue, 13 Jan 2026 09:18:07 -0800 (PST)
X-Received: by 2002:a17:903:9ce:b0:2a2:f1d4:3b64 with SMTP id d9443c01a7336-2a3ee4447e1mr220996545ad.21.1768324687028;
        Tue, 13 Jan 2026 09:18:07 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a2a4sm19357855ad.13.2026.01.13.09.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:18:06 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v7 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ and QP verbs
Date: Tue, 13 Jan 2026 22:39:56 +0530
Message-ID: <20260113170956.103779-5-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260113170956.103779-1-sriharsha.basavapatna@broadcom.com>
References: <20260113170956.103779-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The following Direct Verbs have been implemented, by enhancing the
driver specific udata in existing verbs.

CQ Direct Verbs:
----------------
- CREATE_CQ:
  Create a CQ using the specified udata (struct bnxt_re_cq_req).
  The driver maps/pins the CQ user memory and registers it with the
  hardware.

- DESTROY_CQ:
  Unmap the user memory and destroy the CQ.

QP Direct Verbs:
----------------
- CREATE_QP:
  Create a QP using the specified udata (struct bnxt_re_qp_req).
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
 drivers/infiniband/hw/bnxt_re/dv.c       | 458 +++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |  60 ++-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  11 +
 include/uapi/rdma/bnxt_re-abi.h          |  17 +
 5 files changed, 532 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index ca1327ea7e57..47aa4be18943 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -236,6 +236,8 @@ struct bnxt_re_dev {
 	union ib_gid ugid;
 	u32 ugid_index;
 	u8 sniffer_flow_created : 1;
+	atomic_t dv_cq_count;
+	atomic_t dv_qp_count;
 };
 
 #define to_bnxt_re_dev(ptr, member)	\
@@ -279,6 +281,9 @@ static inline int bnxt_re_read_context_allowed(struct bnxt_re_dev *rdev)
 	return 0;
 }
 
+struct bnxt_qplib_nq *bnxt_re_get_nq(struct bnxt_re_dev *rdev);
+void bnxt_re_put_nq(struct bnxt_re_dev *rdev, struct bnxt_qplib_nq *nq);
+
 #define BNXT_RE_CONTEXT_TYPE_QPC_SIZE_P5	1088
 #define BNXT_RE_CONTEXT_TYPE_CQ_SIZE_P5		128
 #define BNXT_RE_CONTEXT_TYPE_MRW_SIZE_P5	128
diff --git a/drivers/infiniband/hw/bnxt_re/dv.c b/drivers/infiniband/hw/bnxt_re/dv.c
index 0e9b0ddf8194..941ee4d10f16 100644
--- a/drivers/infiniband/hw/bnxt_re/dv.c
+++ b/drivers/infiniband/hw/bnxt_re/dv.c
@@ -12,6 +12,7 @@
 #include <rdma/ib_user_ioctl_cmds.h>
 #define UVERBS_MODULE_NAME bnxt_re
 #include <rdma/uverbs_named_ioctl.h>
+#include <rdma/ib_umem.h>
 #include <rdma/bnxt_re-abi.h>
 
 #include "roce_hsi.h"
@@ -48,6 +49,20 @@ static struct bnxt_re_srq *bnxt_re_search_for_srq(struct bnxt_re_dev *rdev, u32
 	return srq;
 }
 
+static struct bnxt_re_alloc_dbr_obj *bnxt_re_search_for_dpi(struct bnxt_re_dev *rdev, u32 dpi)
+{
+	struct bnxt_re_alloc_dbr_obj *obj = NULL, *tmp_obj;
+
+	/* Note: Caller should rcu_read_lock()/unlock() */
+	hash_for_each_possible_rcu(rdev->dpi_hash, tmp_obj, hash_entry, dpi) {
+		if (tmp_obj->dpi.dpi == dpi) {
+			obj = tmp_obj;
+			break;
+		}
+	}
+	return obj;
+}
+
 static int UVERBS_HANDLER(BNXT_RE_METHOD_NOTIFY_DRV)(struct uverbs_attr_bundle *attrs)
 {
 	struct bnxt_re_ucontext *uctx;
@@ -466,6 +481,449 @@ DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_GET_DEFAULT_DBR,
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
+static struct ib_umem *bnxt_re_dv_umem_get(struct bnxt_re_dev *rdev,
+					   struct ib_ucontext *ib_uctx,
+					   int dmabuf_fd,
+					   u64 addr, u64 size,
+					   struct bnxt_qplib_sg_info *sg)
+{
+	int access = IB_ACCESS_LOCAL_WRITE;
+	struct ib_umem *umem;
+	int umem_pgs, rc;
+
+	if (dmabuf_fd) {
+		struct ib_umem_dmabuf *umem_dmabuf;
+
+		umem_dmabuf = ib_umem_dmabuf_get_pinned(&rdev->ibdev, addr, size,
+							dmabuf_fd, access);
+		if (IS_ERR(umem_dmabuf)) {
+			rc = PTR_ERR(umem_dmabuf);
+			goto umem_err;
+		}
+		umem = &umem_dmabuf->umem;
+	} else {
+		umem = ib_umem_get(&rdev->ibdev, addr, size, access);
+		if (IS_ERR(umem)) {
+			rc = PTR_ERR(umem);
+			goto umem_err;
+		}
+	}
+
+	umem_pgs = ib_umem_num_dma_blocks(umem, SZ_4K);
+	if (!umem_pgs) {
+		rc = -EINVAL;
+		goto umem_rel;
+	}
+	sg->npages = umem_pgs;
+	sg->pgsize = SZ_4K;
+	sg->pgshft = __builtin_ctz(SZ_4K);
+	sg->umem = umem;
+	return umem;
+
+umem_rel:
+	ib_umem_release(umem);
+umem_err:
+	return ERR_PTR(rc);
+}
+
+static int bnxt_re_dv_create_qplib_cq(struct bnxt_re_dev *rdev,
+				      struct bnxt_re_ucontext *re_uctx,
+				      struct bnxt_re_cq *cq,
+				      struct bnxt_re_cq_req *req)
+{
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
+	struct bnxt_qplib_cq *qplcq;
+	struct ib_umem *umem;
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
+	umem = bnxt_re_dv_umem_get(rdev, &re_uctx->ib_uctx, req->dmabuf_fd,
+				   req->cq_va, cqe * sizeof(struct cq_base),
+				   &qplcq->sg_info);
+	if (IS_ERR(umem)) {
+		rc = PTR_ERR(umem);
+		ibdev_dbg(&rdev->ibdev,
+			  "bnxt_re_dv_umem_get() failed, rc: %d\n", rc);
+		goto fail_dec;
+	}
+	cq->umem = umem;
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
+int bnxt_re_dv_create_cq(struct bnxt_re_dev *rdev, struct ib_udata *udata,
+			 struct bnxt_re_cq *re_cq, struct bnxt_re_cq_req *req)
+{
+	struct bnxt_re_ucontext *re_uctx =
+		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
+	struct bnxt_re_cq_resp resp = {};
+	int ret;
+
+	ret = bnxt_re_dv_create_qplib_cq(rdev, re_uctx, re_cq, req);
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
+	bnxt_qplib_destroy_cq(&rdev->qplib_res, &re_cq->qplib_cq);
+	bnxt_re_put_nq(rdev, re_cq->qplib_cq.nq);
+	ib_umem_release(re_cq->umem);
+	return ret;
+};
+
+static int bnxt_re_dv_init_qp_attr(struct bnxt_re_qp *qp,
+				   struct bnxt_re_ucontext *cntx,
+				   struct ib_qp_init_attr *init_attr,
+				   struct bnxt_re_qp_req *req,
+				   struct bnxt_re_alloc_dbr_obj *dbr_obj)
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
+				   struct bnxt_re_qp_req *req)
+{
+	struct bnxt_qplib_sg_info *sginfo;
+	struct bnxt_qplib_qp *qplib_qp;
+	struct ib_umem *umem;
+	int rc = -EINVAL;
+
+	qplib_qp = &qp->qplib_qp;
+	qplib_qp->qp_handle = req->qp_handle;
+	sginfo = &qplib_qp->sq.sg_info;
+
+	/* SQ */
+	umem = bnxt_re_dv_umem_get(rdev, &cntx->ib_uctx, req->sq_dmabuf_fd,
+				   req->qpsva, req->sq_len, sginfo);
+	if (IS_ERR(umem)) {
+		rc = PTR_ERR(umem);
+		ibdev_dbg(&rdev->ibdev,
+			  "bnxt_re_dv_umem_get() failed, rc: %d\n", rc);
+		return rc;
+	}
+	qp->sumem = umem;
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
+	umem = bnxt_re_dv_umem_get(rdev, &cntx->ib_uctx, req->rq_dmabuf_fd,
+				   req->qprva, req->rq_len, sginfo);
+	if (IS_ERR(umem)) {
+		rc = PTR_ERR(umem);
+		ibdev_dbg(&rdev->ibdev,
+			  "bnxt_re_dv_umem_get() failed, rc: %d\n", rc);
+		goto rqfail;
+	}
+	qp->rumem = umem;
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
+			 struct bnxt_re_qp *re_qp, struct bnxt_re_qp_req *req)
+{
+	struct bnxt_re_alloc_dbr_obj *dbr_obj = NULL;
+	struct bnxt_re_cq *send_cq = NULL;
+	struct bnxt_re_cq *recv_cq = NULL;
+	struct bnxt_re_qp_resp resp = {};
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
+	re_qp->rdev = rdev;
+	rcu_read_lock();
+	if (req->dpi != uctx->dpi.dpi) {
+		dbr_obj = bnxt_re_search_for_dpi(rdev, req->dpi);
+		if (!dbr_obj) {
+			rcu_read_unlock();
+			return -EINVAL;
+		}
+	}
+	ret = bnxt_re_dv_init_qp_attr(re_qp, uctx, init_attr, req, dbr_obj);
+	rcu_read_unlock();
+	if (ret)
+		return ret;
+
+	ret = bnxt_re_dv_init_user_qp(rdev, uctx, re_qp, init_attr, req);
+	if (ret)
+		return ret;
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
+	return 0;
+}
+
 const struct uapi_definition bnxt_re_uapi_defs[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_ALLOC_PAGE),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_NOTIFY_DRV),
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 0d95eaee3885..e9ac01000ef5 100644
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
 
@@ -1823,9 +1838,12 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
 
 	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
-	if (udata)
+	if (udata) {
 		if (ib_copy_from_udata(&ureq, udata,  min(udata->inlen, sizeof(ureq))))
 			return -EFAULT;
+		if (ureq.comp_mask & BNXT_RE_QP_DV_SUPPORT)
+			return bnxt_re_dv_create_qp(rdev, udata, qp_init_attr, qp, &ureq);
+	}
 
 	rc = bnxt_re_test_qp_limits(rdev, qp_init_attr, dev_attr);
 	if (!rc) {
@@ -3241,7 +3259,7 @@ int bnxt_re_post_recv(struct ib_qp *ib_qp, const struct ib_recv_wr *wr,
 	return rc;
 }
 
-static struct bnxt_qplib_nq *bnxt_re_get_nq(struct bnxt_re_dev *rdev)
+struct bnxt_qplib_nq *bnxt_re_get_nq(struct bnxt_re_dev *rdev)
 {
 	int min, indx;
 
@@ -3256,7 +3274,7 @@ static struct bnxt_qplib_nq *bnxt_re_get_nq(struct bnxt_re_dev *rdev)
 	return &rdev->nqr->nq[min];
 }
 
-static void bnxt_re_put_nq(struct bnxt_re_dev *rdev, struct bnxt_qplib_nq *nq)
+void bnxt_re_put_nq(struct bnxt_re_dev *rdev, struct bnxt_qplib_nq *nq)
 {
 	mutex_lock(&rdev->nqr->load_lock);
 	nq->load--;
@@ -3284,6 +3302,8 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 
 	bnxt_re_put_nq(rdev, nq);
 	ib_umem_release(cq->umem);
+	if (cq->is_dv_cq)
+		atomic_dec(&rdev->dv_cq_count);
 
 	atomic_dec(&rdev->stats.res.cq_count);
 	kfree(cq->cql);
@@ -3300,6 +3320,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 	struct bnxt_qplib_chip_ctx *cctx;
+	struct bnxt_re_cq_req req;
 	int cqe = attr->cqe;
 	int rc, entries;
 	u32 active_cqs;
@@ -3317,6 +3338,13 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cctx = rdev->chip_ctx;
 	cq->qplib_cq.cq_handle = (u64)(unsigned long)(&cq->qplib_cq);
 
+	if (udata) {
+		if (ib_copy_from_udata(&req, udata, sizeof(req)))
+			return -EFAULT;
+		if (req.comp_mask & BNXT_RE_CQ_DV_SUPPORT)
+			return bnxt_re_dv_create_cq(rdev, udata, cq, &req);
+	}
+
 	entries = bnxt_re_init_depth(cqe + 1, uctx);
 	if (entries > dev_attr->max_cq_wqes + 1)
 		entries = dev_attr->max_cq_wqes + 1;
@@ -3324,12 +3352,6 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->qplib_cq.sg_info.pgsize = PAGE_SIZE;
 	cq->qplib_cq.sg_info.pgshft = PAGE_SHIFT;
 	if (udata) {
-		struct bnxt_re_cq_req req;
-		if (ib_copy_from_udata(&req, udata, sizeof(req))) {
-			rc = -EFAULT;
-			goto fail;
-		}
-
 		cq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
 				       entries * sizeof(struct cq_base),
 				       IB_ACCESS_LOCAL_WRITE);
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index c6daebd49a3b..91fb98518587 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -96,6 +96,7 @@ struct bnxt_re_qp {
 	struct bnxt_re_cq	*scq;
 	struct bnxt_re_cq	*rcq;
 	struct dentry		*dentry;
+	bool			is_dv_qp;
 };
 
 struct bnxt_re_cq {
@@ -113,6 +114,7 @@ struct bnxt_re_cq {
 	int			resize_cqe;
 	void			*uctx_cq_page;
 	struct hlist_node	hash_entry;
+	bool			is_dv_cq;
 };
 
 struct bnxt_re_mr {
@@ -304,4 +306,13 @@ void bnxt_re_unlock_cqs(struct bnxt_re_qp *qp, unsigned long flags);
 struct bnxt_re_user_mmap_entry*
 bnxt_re_mmap_entry_insert(struct bnxt_re_ucontext *uctx, u64 mem_offset,
 			  enum bnxt_re_mmap_flag mmap_flag, u64 *offset);
+u8 __from_ib_qp_type(enum ib_qp_type type);
+int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp, bool is_dv_qp);
+void bnxt_re_qp_free_umem(struct bnxt_re_qp *qp);
+int bnxt_re_dv_create_cq(struct bnxt_re_dev *rdev, struct ib_udata *udata,
+			 struct bnxt_re_cq *re_cq, struct bnxt_re_cq_req *req);
+int bnxt_re_dv_create_qp(struct bnxt_re_dev *rdev, struct ib_udata *udata,
+			 struct ib_qp_init_attr *init_attr,
+			 struct bnxt_re_qp *re_qp, struct bnxt_re_qp_req *req);
+int bnxt_re_dv_destroy_qp(struct bnxt_re_qp *qp);
 #endif /* __BNXT_RE_IB_VERBS_H__ */
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index 51f8614a7c4f..58b3015a5bed 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -101,10 +101,14 @@ struct bnxt_re_pd_resp {
 struct bnxt_re_cq_req {
 	__aligned_u64 cq_va;
 	__aligned_u64 cq_handle;
+	__aligned_u64 comp_mask;
+	__u32 ncqe;
+	__s32 dmabuf_fd;
 };
 
 enum bnxt_re_cq_mask {
 	BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT = 0x1,
+	BNXT_RE_CQ_DV_SUPPORT = 0x2
 };
 
 struct bnxt_re_cq_resp {
@@ -121,6 +125,7 @@ struct bnxt_re_resize_cq_req {
 
 enum bnxt_re_qp_mask {
 	BNXT_RE_QP_REQ_MASK_VAR_WQE_SQ_SLOTS = 0x1,
+	BNXT_RE_QP_DV_SUPPORT = 0x2,
 };
 
 struct bnxt_re_qp_req {
@@ -129,11 +134,23 @@ struct bnxt_re_qp_req {
 	__aligned_u64 qp_handle;
 	__aligned_u64 comp_mask;
 	__u32 sq_slots;
+	__u32 pd_id;
+	__u32 dpi;
+	__s32 sq_dmabuf_fd;
+	__u32 sq_len;   /* total len including MSN area */
+	__u32 sq_wqe_sz;
+	__u32 sq_psn_sz;
+	__u32 sq_npsn;
+	__s32 rq_dmabuf_fd;
+	__u32 rq_len;
+	__u32 rq_slots; /* == max_recv_wr */
+	__u32 rq_wqe_sz;
 };
 
 struct bnxt_re_qp_resp {
 	__u32 qpid;
 	__u32 rsvd;
+	__aligned_u64 comp_mask;
 };
 
 struct bnxt_re_srq_req {
-- 
2.51.2.636.ga99f379adf


