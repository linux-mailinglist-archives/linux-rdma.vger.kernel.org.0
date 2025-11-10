Return-Path: <linux-rdma+bounces-14365-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1DFC47658
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 16:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473D51887B98
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 15:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3133126BD;
	Mon, 10 Nov 2025 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TlDB28Vx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7D03128DA
	for <linux-rdma@vger.kernel.org>; Mon, 10 Nov 2025 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787049; cv=none; b=FyUlvqcSx4CYuZ4jirZXe4J8gz7ahFk2Lmsj7WRWYfrItObK+Xm0U09sLytzjoBVLUigPnyWI1YUu+YObk1FsbizOpwu5NyXHx5aWKt+4tKx/0taICUc74CssdwxAI7wMa3bS6RmvWhNjE/YbJVM7vzhJfk4Iies5Si+M9Huqj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787049; c=relaxed/simple;
	bh=H6Pen4alM9YRsm8RMyo9lbcRlSTrx2xdmB7VpcrlEi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qsd+3HgSViWaQRfk/RAvQFlrG7HPf1bjynH2TuN477sGRwnobaCEkezFNjyIy11fMN1ezDd03wT+UEWkKamiBmZlp7FMaQs0RkTiHAKRMe+twfhGqzxXoTgfgqtQod4Db7dT6xBhaPZcZuyvlF30CiZFAew0GE8h8fSC8hkhwqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TlDB28Vx; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-43380a6fe8cso9959625ab.0
        for <linux-rdma@vger.kernel.org>; Mon, 10 Nov 2025 07:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762787043; x=1763391843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qm65VSAY9atDoPBinHSYZme9NKZlIlKHX16Xqyu9Yko=;
        b=R7TBhnGpjYxUM/IGqIx2/t441Um71gRXIMoDBTQ+n6PGUdfqPdnJ0roPJc8wfvH9U4
         Ee8o5ycJ5dukvcsnvWFMDAEDtjFe17nFG+zVms6UTtb5eSIHRqM5/iYEaZEldjFc+y6G
         IXbb2QSCAQYjRExlnMukJ5iqPYWU9Z3FvUg2dXkL+N/xWcurbIf5rq+Mlz/6GZdISzoN
         R2qsSW1OcigMz4o0oo37y59XT7Ht7qPJCjOo5i7ot9/96xQevcbV/q9ubUmv9rL0Hx8Y
         4trD0dqJyEYDdUdx+ZIXgJJAcr2KOpaH1NWpOblkwVoSY4VuNVwimv7caFQbh/SgOt1M
         Rexg==
X-Gm-Message-State: AOJu0YwApOlc61h5IYFpcbAdfFy4Lk//BRuw5mYcVaVq7swe3zenLDWs
	jUDQXj5rNLNevaGLEcD0ncYBuMmRAh3uLWw/eqFR3IY1tCKDytHmgKRs9NETAoBvpn05VCgpSIl
	ceIgHqf8QHZzuMeISThv3oyuei1YcTCsL7B1A2KMK5YRbdLKRgYKtdkYKY3ZzIDGBMrGNjhgNGj
	vOf+LTrL4bLTDQkXM2Lr6H21E0r2lzdobMXItNmhQ++ZZVeehS279VJQtDXOJFQVfuFf/z8EVYB
	B5q52qmauj6pXplh3DOAef93zM5
X-Gm-Gg: ASbGncuZW20dzBol12h0OwgBop6su5bShF31AZctd7qoVXAF2DWF36F6/sY3ClVxAJo
	h1Ugx9WE8TAC173thTKxw9Jqhax7WCpQFXt9rlnSjhJk6CQSE9FYVebvwC9oObspC2Hch2vjoZr
	3BcuoSn8u1NcprPVORoN0BbE1J5GZAgLzXYeaI+BL0OOQ8o/vwcKD5vh7EiwztZXNIeHlmuEyQZ
	2bTuKycFB/AHX2Wt2djpfM0G3war4XhnDgW6dQ6vxRiPXXk22nvugbZgP2xptg8imQTIBs+QhkZ
	hs0Kk+UAfnNsUV7dQSRAItRVS/w8XGZMFgSJRx6xMSLAvTFoboXkR532uljvZ9iGdhv5LBp18YS
	RcOQHe3SrcgZgWbjj4/XJ9QVV9h/ghm5wizLIzlzO//eH88p4qRaA6J43upqovYyIf3gfHJK+VD
	RjFD9Q6UXVSrpRgPPOw2BCrMkdf49DUDFBaMt+Gsd6Imfv1A==
X-Google-Smtp-Source: AGHT+IFWvu38LTUB0Of+M4HXbsAJg/lg+l3AX33xa1I1Y3d1pb4XvqRvAQ9zpACqUVrZhK3Ejl6EEa9JS3yu
X-Received: by 2002:a05:6e02:3e8d:b0:433:70e2:6292 with SMTP id e9e14a558f8ab-43370e265f6mr94252995ab.15.1762787043112;
        Mon, 10 Nov 2025 07:04:03 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5b76b85a5e7sm801920173.40.2025.11.10.07.04.02
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Nov 2025 07:04:03 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6ceeea4addso2872686a12.1
        for <linux-rdma@vger.kernel.org>; Mon, 10 Nov 2025 07:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762787041; x=1763391841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qm65VSAY9atDoPBinHSYZme9NKZlIlKHX16Xqyu9Yko=;
        b=TlDB28VxK+P9HKmszPC3VBP95I07q5tpgF6slhak5UTN4zb1IiGWHzXYzhBkY3nuvd
         Psn4zaAMD3wQpJ0K6JrBaJIDDzPBpkCQRsfZK9iHzZuuhu+ycNv8qQ/g6szznDlALsTN
         EAUuw0vH6kyuObaJf3AlUagNnYWfcFMrjpqig=
X-Received: by 2002:a17:902:ef52:b0:27e:ec72:f67 with SMTP id d9443c01a7336-297e54070a9mr100158515ad.6.1762787040689;
        Mon, 10 Nov 2025 07:04:00 -0800 (PST)
X-Received: by 2002:a17:902:ef52:b0:27e:ec72:f67 with SMTP id d9443c01a7336-297e54070a9mr100157585ad.6.1762787039775;
        Mon, 10 Nov 2025 07:03:59 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c8f07csm153216885ad.78.2025.11.10.07.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:03:58 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v3 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ and QP verbs
Date: Mon, 10 Nov 2025 20:26:28 +0530
Message-ID: <20251110145628.290296-5-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20251110145628.290296-1-sriharsha.basavapatna@broadcom.com>
References: <20251110145628.290296-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The following Direct Verb (DV) methods have been implemented in
this patch.

CQ Direct Verbs:
----------------
- BNXT_RE_METHOD_DV_CREATE_CQ:
  Create a CQ of requested size (cqe). The application must have
  already registered this memory with the driver using DV_UMEM_REG.
  The CQ umem-handle and umem-offset are passed to the driver. The
  driver now maps/pins the CQ user memory and registers it with the
  hardware. The driver returns a CQ-handle to the application.

- BNXT_RE_METHOD_DV_DESTROY_CQ:
  Destroy the DV_CQ specified by the CQ-handle; unmap the user memory.

QP Direct Verbs:
----------------
- BNXT_RE_METHOD_DV_CREATE_QP:
  Create a QP using specified params (struct bnxt_re_dv_create_qp_req).
  The application must have already registered SQ/RQ memory with the
  driver using DV_UMEM_REG. The SQ/RQ umem-handle and umem-offset are
  passed to the driver. The driver now maps/pins the SQ/RQ user memory
  and registers it with the hardware. The driver returns a QP-handle to
  the application.

- BNXT_RE_METHOD_DV_DESTROY_QP:
  Destroy the DV_QP specified by the QP-handle; unmap SQ/RQ user memory.

- BNXT_RE_METHOD_DV_MODIFY_QP:
  Modify QP attributes for the DV_QP specified by the QP-handle;
  wrapper functions have been implemented to resolve dmac/smac using
  rdma_resolve_ip().

- BNXT_RE_METHOD_DV_QUERY_QP:
  Return QP attributes for the DV_QP specified by the QP-handle.

Note:
-----
Some applications might want to allocate memory for all resources of a
given type (CQ/QP) in one big chunk and then register that entire memory
once using DV_UMEM_REG. At the time of creating each individual
resource, the application would pass a specific offset/length in the
umem registered memory.

- The DV_UMEM_REG handler (previous patch) only creates a dv_umem object
  and saves user memory parameters, but doesn't really map/pin this
  memory.
- The mapping would be done at the time of creating individual objects.
- This actual mapping of specific umem offsets is implemented by the
  function bnxt_re_dv_umem_get(). This function validates the
  umem-offset and size parameters passed during CQ/QP creation. If the
  request is valid, it maps the specified offset/length within the umem
  registered memory.
- The CQ and QP creation DV handlers call bnxt_re_dv_umem_get() to map
  offsets/sizes specific to each individual object. This means each
  object gets its own mapped dv_umem object that is distinct from the
  main dv_umem object created during DV_UMEM_REG.
- The object specific dv_umem is unmapped when the object is destroyed.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Co-developed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Co-developed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |   12 +-
 drivers/infiniband/hw/bnxt_re/dv.c       | 1071 ++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |   55 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |   12 +
 include/uapi/rdma/bnxt_re-abi.h          |   93 ++
 5 files changed, 1227 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 3485e495ac6a..44d4a4a83bfe 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -167,6 +167,12 @@ static inline bool bnxt_re_chip_gen_p7(u16 chip_num)
 		chip_num == CHIP_NUM_57608);
 }
 
+enum {
+	BNXT_RE_DV_RES_TYPE_QP = 0,
+	BNXT_RE_DV_RES_TYPE_CQ,
+	BNXT_RE_DV_RES_TYPE_MAX
+};
+
 struct bnxt_re_dev {
 	struct ib_device		ibdev;
 	struct list_head		list;
@@ -231,6 +237,8 @@ struct bnxt_re_dev {
 	union ib_gid ugid;
 	u32 ugid_index;
 	u8 sniffer_flow_created : 1;
+	atomic_t		dv_cq_count;
+	atomic_t		dv_qp_count;
 };
 
 #define to_bnxt_re_dev(ptr, member)	\
@@ -274,6 +282,9 @@ static inline int bnxt_re_read_context_allowed(struct bnxt_re_dev *rdev)
 	return 0;
 }
 
+struct bnxt_qplib_nq *bnxt_re_get_nq(struct bnxt_re_dev *rdev);
+void bnxt_re_put_nq(struct bnxt_re_dev *rdev, struct bnxt_qplib_nq *nq);
+
 #define BNXT_RE_CONTEXT_TYPE_QPC_SIZE_P5	1088
 #define BNXT_RE_CONTEXT_TYPE_CQ_SIZE_P5		128
 #define BNXT_RE_CONTEXT_TYPE_MRW_SIZE_P5	128
@@ -286,5 +297,4 @@ static inline int bnxt_re_read_context_allowed(struct bnxt_re_dev *rdev)
 
 #define BNXT_RE_HWRM_CMD_TIMEOUT(rdev)		\
 		((rdev)->chip_ctx->hwrm_cmd_max_timeout * 1000)
-
 #endif
diff --git a/drivers/infiniband/hw/bnxt_re/dv.c b/drivers/infiniband/hw/bnxt_re/dv.c
index 1485aa0a6818..100e18d07f51 100644
--- a/drivers/infiniband/hw/bnxt_re/dv.c
+++ b/drivers/infiniband/hw/bnxt_re/dv.c
@@ -14,6 +14,7 @@
 #include <rdma/uverbs_named_ioctl.h>
 #include <rdma/ib_umem.h>
 #include <rdma/bnxt_re-abi.h>
+#include <rdma/ib_cache.h>
 
 #include "roce_hsi.h"
 #include "qplib_res.h"
@@ -379,6 +380,76 @@ static int bnxt_re_dv_validate_umem_attr(struct bnxt_re_dev *rdev,
 	return 0;
 }
 
+static bool bnxt_re_dv_is_valid_umem(struct bnxt_re_dv_umem *umem,
+				     u64 offset, u32 size)
+{
+	return ((offset == ALIGN(offset, PAGE_SIZE)) &&
+		(offset + size <= umem->size));
+}
+
+static struct bnxt_re_dv_umem *bnxt_re_dv_umem_get(struct bnxt_re_dev *rdev,
+						   struct ib_ucontext *ib_uctx,
+						   struct bnxt_re_dv_umem *obj,
+						   u64 umem_offset, u64 size,
+						   struct bnxt_qplib_sg_info *sg)
+{
+	struct bnxt_re_dv_umem *dv_umem;
+	struct ib_umem *umem;
+	int umem_pgs, rc;
+
+	if (!bnxt_re_dv_is_valid_umem(obj, umem_offset, size))
+		return ERR_PTR(-EINVAL);
+
+	dv_umem = kzalloc(sizeof(*dv_umem), GFP_KERNEL);
+	if (!dv_umem)
+		return ERR_PTR(-ENOMEM);
+
+	dv_umem->addr = obj->addr + umem_offset;
+	dv_umem->size = size;
+	dv_umem->rdev = obj->rdev;
+	dv_umem->dmabuf_fd = obj->dmabuf_fd;
+	dv_umem->access = obj->access;
+
+	if (obj->dmabuf_fd) {
+		struct ib_umem_dmabuf *umem_dmabuf;
+
+		umem_dmabuf = ib_umem_dmabuf_get_pinned(&rdev->ibdev, dv_umem->addr,
+							dv_umem->size, dv_umem->dmabuf_fd,
+							dv_umem->access);
+		if (IS_ERR(umem_dmabuf)) {
+			rc = PTR_ERR(umem_dmabuf);
+			goto free_umem;
+		}
+		umem = &umem_dmabuf->umem;
+	} else {
+		umem = ib_umem_get(&rdev->ibdev, (unsigned long)dv_umem->addr,
+				   dv_umem->size, dv_umem->access);
+		if (IS_ERR(umem)) {
+			rc = PTR_ERR(umem);
+			goto free_umem;
+		}
+	}
+
+	dv_umem->umem = umem;
+
+	umem_pgs = ib_umem_num_dma_blocks(umem, PAGE_SIZE);
+	if (!umem_pgs) {
+		rc = -EINVAL;
+		goto rel_umem;
+	}
+	sg->npages = ib_umem_num_dma_blocks(umem, PAGE_SIZE);
+	sg->pgshft = PAGE_SHIFT;
+	sg->pgsize = PAGE_SIZE;
+	sg->umem = umem;
+	return dv_umem;
+
+rel_umem:
+	ib_umem_release(umem);
+free_umem:
+	kfree(dv_umem);
+	return ERR_PTR(rc);
+}
+
 static int bnxt_re_dv_umem_cleanup(struct ib_uobject *uobject,
 				   enum rdma_remove_reason why,
 				   struct uverbs_attr_bundle *attrs)
@@ -581,11 +652,1011 @@ DECLARE_UVERBS_NAMED_OBJECT(BNXT_RE_OBJECT_DBR,
 			    &UVERBS_METHOD(BNXT_RE_METHOD_DBR_FREE),
 			    &UVERBS_METHOD(BNXT_RE_METHOD_DBR_QUERY));
 
+static int bnxt_re_dv_create_cq_resp(struct bnxt_re_dev *rdev,
+				     struct bnxt_re_cq *cq,
+				     struct bnxt_re_dv_cq_resp *resp)
+{
+	struct bnxt_qplib_cq *qplcq = &cq->qplib_cq;
+
+	resp->cqid = qplcq->id;
+	resp->tail = qplcq->hwq.cons;
+	resp->phase = qplcq->period;
+	resp->comp_mask = 0;
+	return 0;
+}
+
+static struct bnxt_re_cq *
+bnxt_re_dv_create_qplib_cq(struct bnxt_re_dev *rdev,
+			   struct bnxt_re_ucontext *re_uctx,
+			   struct bnxt_re_dv_cq_req *req,
+			   struct bnxt_re_dv_umem *umem_handle,
+			   u64 umem_offset)
+{
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
+	struct bnxt_re_dv_umem *dv_umem;
+	struct bnxt_qplib_cq *qplcq;
+	struct bnxt_re_cq *cq = NULL;
+	int cqe = req->ncqe;
+	u32 max_active_cqs;
+	int rc = 0;
+
+	if (atomic_read(&rdev->stats.res.cq_count) >= dev_attr->max_cq) {
+		ibdev_err(&rdev->ibdev, "Create CQ failed - max exceeded(CQs)");
+		return NULL;
+	}
+
+	/* Validate CQ fields */
+	if (cqe < 1 || cqe > dev_attr->max_cq_wqes) {
+		ibdev_err(&rdev->ibdev, "Create CQ failed - max exceeded(CQ_WQs)");
+		return NULL;
+	}
+
+	cq = kzalloc(sizeof(*cq), GFP_KERNEL);
+	if (!cq)
+		return NULL;
+
+	cq->rdev = rdev;
+	cq->uctx = re_uctx;
+	qplcq = &cq->qplib_cq;
+	qplcq->cq_handle = (u64)qplcq;
+	dv_umem = bnxt_re_dv_umem_get(rdev, &re_uctx->ib_uctx, umem_handle,
+				      umem_offset, cqe * sizeof(struct cq_base),
+				      &qplcq->sg_info);
+	if (IS_ERR(dv_umem)) {
+		rc = PTR_ERR(dv_umem);
+		ibdev_dbg(&rdev->ibdev, "%s: bnxt_re_dv_umem_get() failed, rc: %d\n",
+			  __func__, rc);
+		goto fail_umem;
+	}
+	cq->umem = dv_umem->umem;
+	cq->umem_handle = dv_umem;
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
+	atomic_inc(&rdev->stats.res.cq_count);
+	max_active_cqs = atomic_read(&rdev->stats.res.cq_count);
+	if (max_active_cqs > rdev->stats.res.cq_watermark)
+		rdev->stats.res.cq_watermark = max_active_cqs;
+	spin_lock_init(&cq->cq_lock);
+
+	return cq;
+
+fail_qpl:
+	ib_umem_release(cq->umem);
+	kfree(cq->umem_handle);
+fail_umem:
+	kfree(cq);
+	return NULL;
+}
+
+static int bnxt_re_dv_uverbs_copy_to(struct bnxt_re_dev *rdev,
+				     struct uverbs_attr_bundle *attrs,
+				     int attr, void *from, size_t size)
+{
+	return uverbs_copy_to_struct_or_zero(attrs, attr, from, size);
+}
+
+static void bnxt_re_dv_finalize_uobj(struct ib_uobject *uobj, void *priv_obj,
+				     struct uverbs_attr_bundle *attrs, int attr)
+{
+	uobj->object = priv_obj;
+	uverbs_finalize_uobj_create(attrs, attr);
+}
+
+static void bnxt_re_dv_init_ib_cq(struct bnxt_re_dev *rdev,
+				  struct bnxt_re_cq *re_cq)
+{
+	struct ib_cq *ib_cq;
+
+	ib_cq = &re_cq->ib_cq;
+	ib_cq->device = &rdev->ibdev;
+	ib_cq->uobject = NULL;
+	ib_cq->comp_handler  = NULL;
+	ib_cq->event_handler = NULL;
+	atomic_set(&ib_cq->usecnt, 0);
+}
+
+static int UVERBS_HANDLER(BNXT_RE_METHOD_DV_CREATE_CQ)(struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uobject *uobj =
+		uverbs_attr_get_uobject(attrs, BNXT_RE_DV_CREATE_CQ_HANDLE);
+	struct bnxt_re_dv_umem *umem_handle = NULL;
+	struct bnxt_re_dv_cq_resp resp = {};
+	struct bnxt_re_dv_cq_req req = {};
+	struct bnxt_re_ucontext *re_uctx;
+	struct ib_ucontext *ib_uctx;
+	struct bnxt_re_dev *rdev;
+	struct bnxt_re_cq *re_cq;
+	u64 offset;
+	int ret;
+
+	ib_uctx = ib_uverbs_get_ucontext(attrs);
+	if (IS_ERR(ib_uctx))
+		return PTR_ERR(ib_uctx);
+
+	re_uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
+	rdev = re_uctx->rdev;
+
+	ret = uverbs_copy_from_or_zero(&req, attrs, BNXT_RE_DV_CREATE_CQ_REQ);
+	if (ret)
+		return ret;
+
+	umem_handle = uverbs_attr_get_obj(attrs, BNXT_RE_DV_CREATE_CQ_UMEM_HANDLE);
+	if (IS_ERR(umem_handle))
+		return PTR_ERR(umem_handle);
+
+	ret = uverbs_copy_from(&offset, attrs, BNXT_RE_DV_CREATE_CQ_UMEM_OFFSET);
+	if (ret)
+		return ret;
+
+	re_cq = bnxt_re_dv_create_qplib_cq(rdev, re_uctx, &req, umem_handle, offset);
+	if (!re_cq)
+		return -EIO;
+
+	ret = bnxt_re_dv_create_cq_resp(rdev, re_cq, &resp);
+	if (ret)
+		goto fail_resp;
+
+	ret = bnxt_re_dv_uverbs_copy_to(rdev, attrs, BNXT_RE_DV_CREATE_CQ_RESP,
+					&resp, sizeof(resp));
+	if (ret)
+		goto fail_resp;
+
+	bnxt_re_dv_finalize_uobj(uobj, re_cq, attrs, BNXT_RE_DV_CREATE_CQ_HANDLE);
+	bnxt_re_dv_init_ib_cq(rdev, re_cq);
+	re_cq->is_dv_cq = true;
+	atomic_inc(&rdev->dv_cq_count);
+	return 0;
+
+fail_resp:
+	bnxt_qplib_destroy_cq(&rdev->qplib_res, &re_cq->qplib_cq);
+	bnxt_re_put_nq(rdev, re_cq->qplib_cq.nq);
+	if (re_cq->umem_handle) {
+		ib_umem_release(re_cq->umem);
+		kfree(re_cq->umem_handle);
+	}
+	kfree(re_cq);
+	return ret;
+};
+
+static int bnxt_re_dv_free_cq(struct ib_uobject *uobj,
+			      enum rdma_remove_reason why,
+			      struct uverbs_attr_bundle *attrs)
+{
+	struct bnxt_re_cq *cq = uobj->object;
+	struct bnxt_re_dev *rdev = cq->rdev;
+	int rc;
+
+	rc = bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
+	if (rc)
+		ibdev_err_ratelimited(&rdev->ibdev,
+				      "%s id = %d failed rc = %d",
+				      __func__, cq->qplib_cq.id, rc);
+
+	bnxt_re_put_nq(rdev, cq->qplib_cq.nq);
+	if (cq->umem_handle) {
+		ib_umem_release(cq->umem);
+		kfree(cq->umem_handle);
+	}
+	atomic_dec(&rdev->stats.res.cq_count);
+	atomic_dec(&rdev->dv_cq_count);
+	kfree(cq);
+	uobj->object = NULL;
+	return 0;
+}
+
+DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_DV_CREATE_CQ,
+			    UVERBS_ATTR_IDR(BNXT_RE_DV_CREATE_CQ_HANDLE,
+					    BNXT_RE_OBJECT_DV_CQ,
+					    UVERBS_ACCESS_NEW,
+					    UA_MANDATORY),
+			    UVERBS_ATTR_PTR_IN(BNXT_RE_DV_CREATE_CQ_REQ,
+					       UVERBS_ATTR_STRUCT(struct bnxt_re_dv_cq_req,
+								  comp_mask),
+								  UA_MANDATORY),
+			    UVERBS_ATTR_IDR(BNXT_RE_DV_CREATE_CQ_UMEM_HANDLE,
+					    BNXT_RE_OBJECT_UMEM,
+					    UVERBS_ACCESS_READ,
+					    UA_MANDATORY),
+			    UVERBS_ATTR_PTR_IN(BNXT_RE_DV_CREATE_CQ_UMEM_OFFSET,
+					       UVERBS_ATTR_TYPE(u64),
+					       UA_MANDATORY),
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_DV_CREATE_CQ_RESP,
+						UVERBS_ATTR_STRUCT(struct bnxt_re_dv_cq_resp,
+								   comp_mask),
+								   UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_METHOD_DESTROY(BNXT_RE_METHOD_DV_DESTROY_CQ,
+				    UVERBS_ATTR_IDR(BNXT_RE_DV_DESTROY_CQ_HANDLE,
+						    BNXT_RE_OBJECT_DV_CQ,
+						    UVERBS_ACCESS_DESTROY,
+						    UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_OBJECT(BNXT_RE_OBJECT_DV_CQ,
+			    UVERBS_TYPE_ALLOC_IDR(bnxt_re_dv_free_cq),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_DV_CREATE_CQ),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_DV_DESTROY_CQ));
+
+static int bnxt_re_dv_init_qp_attr(struct bnxt_re_qp *qp,
+				   struct ib_ucontext *context,
+				   struct bnxt_re_cq *send_cq,
+				   struct bnxt_re_cq *recv_cq,
+				   struct bnxt_re_srq *srq,
+				   struct bnxt_re_alloc_dbr_obj *dbr_obj,
+				   struct bnxt_re_dv_create_qp_req *init_attr)
+{
+	struct bnxt_qplib_dev_attr *dev_attr;
+	struct bnxt_re_ucontext *cntx = NULL;
+	struct bnxt_qplib_qp *qplqp;
+	struct bnxt_re_dev *rdev;
+	struct bnxt_qplib_q *rq;
+	struct bnxt_qplib_q *sq;
+	u32 slot_size;
+	int qptype;
+
+	rdev = qp->rdev;
+	qplqp = &qp->qplib_qp;
+	dev_attr = rdev->dev_attr;
+	cntx = container_of(context, struct bnxt_re_ucontext, ib_uctx);
+
+	/* Setup misc params */
+	qplqp->is_user = true;
+	qplqp->pd_id = init_attr->pd_id;
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
+	if (!send_cq)
+		return -EINVAL;
+	qplqp->scq = &send_cq->qplib_cq;
+	qp->scq = send_cq;
+
+	if (!recv_cq)
+		return -EINVAL;
+	qplqp->rcq = &recv_cq->qplib_cq;
+	qp->rcq = recv_cq;
+
+	if (!srq) {
+		/* Setup RQ */
+		slot_size = bnxt_qplib_get_stride();
+		rq = &qplqp->rq;
+		rq->max_sge = init_attr->max_recv_sge;
+		rq->wqe_size = init_attr->rq_wqe_sz;
+		rq->max_wqe = (init_attr->rq_slots * slot_size) /
+				init_attr->rq_wqe_sz;
+		rq->max_sw_wqe = rq->max_wqe;
+		rq->q_full_delta = 0;
+		rq->sg_info.pgsize = PAGE_SIZE;
+		rq->sg_info.pgshft = PAGE_SHIFT;
+	}
+
+	/* Setup SQ */
+	sq = &qplqp->sq;
+	sq->max_sge = init_attr->max_send_sge;
+	sq->wqe_size = init_attr->sq_wqe_sz;
+	sq->max_wqe = init_attr->sq_slots; /* SQ in var-wqe mode */
+	sq->max_sw_wqe = sq->max_wqe;
+	sq->q_full_delta = 0;
+	sq->sg_info.pgsize = PAGE_SIZE;
+	sq->sg_info.pgshft = PAGE_SHIFT;
+
+	return 0;
+}
+
+static int bnxt_re_dv_init_user_qp(struct bnxt_re_dev *rdev,
+				   struct ib_ucontext *context,
+				   struct bnxt_re_qp *qp,
+				   struct bnxt_re_srq *srq,
+				   struct bnxt_re_dv_create_qp_req *init_attr,
+				   struct bnxt_re_dv_umem *sq_umem,
+				   struct bnxt_re_dv_umem *rq_umem)
+{
+	struct bnxt_qplib_sg_info *sginfo;
+	struct bnxt_re_dv_umem *dv_umem;
+	struct bnxt_qplib_qp *qplib_qp;
+	int rc = -EINVAL;
+
+	if (!sq_umem || (!srq && !rq_umem))
+		return rc;
+
+	qplib_qp = &qp->qplib_qp;
+	qplib_qp->qp_handle = init_attr->qp_handle;
+	sginfo = &qplib_qp->sq.sg_info;
+
+	/* SQ */
+	dv_umem = bnxt_re_dv_umem_get(rdev, context, sq_umem,
+				      init_attr->sq_umem_offset,
+				      init_attr->sq_len, sginfo);
+	if (IS_ERR(dv_umem)) {
+		rc = PTR_ERR(dv_umem);
+		ibdev_dbg(&rdev->ibdev, "%s: bnxt_re_dv_umem_get() failed, rc: %d\n",
+			  __func__, rc);
+		return rc;
+	}
+	qp->sq_umem = dv_umem;
+	qp->sumem = dv_umem->umem;
+
+	/* SRQ */
+	if (srq) {
+		qplib_qp->srq = &srq->qplib_srq;
+		goto done;
+	}
+
+	/* RQ */
+	sginfo = &qplib_qp->rq.sg_info;
+	dv_umem = bnxt_re_dv_umem_get(rdev, context, rq_umem,
+				      init_attr->rq_umem_offset,
+				      init_attr->rq_len, sginfo);
+	if (IS_ERR(dv_umem)) {
+		rc = PTR_ERR(dv_umem);
+		ibdev_dbg(&rdev->ibdev, "%s: bnxt_re_dv_umem_get() failed, rc: %d\n",
+			  __func__, rc);
+		goto rqfail;
+	}
+	qp->rq_umem = dv_umem;
+	qp->rumem = dv_umem->umem;
+done:
+	qplib_qp->is_user = true;
+	return 0;
+rqfail:
+	ib_umem_release(qp->sumem);
+	kfree(qp->sq_umem);
+	qplib_qp->sq.sg_info.umem = NULL;
+	return rc;
+}
+
+static void
+bnxt_re_dv_qp_init_msn(struct bnxt_re_qp *qp,
+		       struct bnxt_re_dv_create_qp_req *req)
+{
+	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
+
+	qplib_qp->is_host_msn_tbl = true;
+	qplib_qp->msn = 0;
+	qplib_qp->psn_sz = req->sq_psn_sz;
+	qplib_qp->msn_tbl_sz = req->sq_psn_sz * req->sq_npsn;
+}
+
+static void bnxt_re_dv_init_ib_qp(struct bnxt_re_dev *rdev,
+				  struct bnxt_re_qp *re_qp)
+{
+	struct bnxt_qplib_qp *qplib_qp = &re_qp->qplib_qp;
+	struct ib_qp *ib_qp = &re_qp->ib_qp;
+
+	ib_qp->device = &rdev->ibdev;
+	ib_qp->qp_num = qplib_qp->id;
+	ib_qp->real_qp = ib_qp;
+	ib_qp->qp_type = IB_QPT_RC;
+	ib_qp->send_cq = &re_qp->scq->ib_cq;
+	ib_qp->recv_cq = &re_qp->rcq->ib_cq;
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
+
+	bnxt_re_dv_init_ib_qp(rdev, qp);
+}
+
+static int UVERBS_HANDLER(BNXT_RE_METHOD_DV_CREATE_QP)(struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uobject *uobj =
+		uverbs_attr_get_uobject(attrs, BNXT_RE_DV_CREATE_QP_HANDLE);
+	struct bnxt_re_alloc_dbr_obj *dbr_obj = NULL;
+	struct bnxt_re_dv_create_qp_resp resp = {};
+	struct bnxt_re_dv_create_qp_req req = {};
+	struct bnxt_re_dv_umem *sq_umem = NULL;
+	struct bnxt_re_dv_umem *rq_umem = NULL;
+	struct bnxt_re_ucontext *re_uctx;
+	struct bnxt_re_srq *srq = NULL;
+	struct bnxt_re_dv_umem *umem;
+	struct ib_ucontext *ib_uctx;
+	struct bnxt_re_cq *send_cq;
+	struct bnxt_re_cq *recv_cq;
+	struct bnxt_re_dev *rdev;
+	struct bnxt_re_qp *re_qp;
+	struct ib_srq *ib_srq;
+	int ret;
+
+	if (IS_ERR(uobj))
+		return PTR_ERR(uobj);
+
+	ib_uctx = ib_uverbs_get_ucontext(attrs);
+	if (IS_ERR(ib_uctx))
+		return PTR_ERR(ib_uctx);
+
+	re_uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
+	rdev = re_uctx->rdev;
+
+	ret = uverbs_copy_from_or_zero(&req, attrs, BNXT_RE_DV_CREATE_QP_REQ);
+	if (ret)
+		return ret;
+
+	send_cq = uverbs_attr_get_obj(attrs,
+				      BNXT_RE_DV_CREATE_QP_SEND_CQ_HANDLE);
+	if (IS_ERR(send_cq))
+		return PTR_ERR(send_cq);
+
+	recv_cq = uverbs_attr_get_obj(attrs,
+				      BNXT_RE_DV_CREATE_QP_RECV_CQ_HANDLE);
+	if (IS_ERR(recv_cq))
+		return PTR_ERR(recv_cq);
+
+	re_qp = kzalloc(sizeof(*re_qp), GFP_KERNEL);
+	if (!re_qp)
+		return -ENOMEM;
+
+	re_qp->rdev = rdev;
+	umem = uverbs_attr_get_obj(attrs, BNXT_RE_DV_CREATE_QP_SQ_UMEM_HANDLE);
+	if (!IS_ERR(umem))
+		sq_umem = umem;
+
+	umem = uverbs_attr_get_obj(attrs, BNXT_RE_DV_CREATE_QP_RQ_UMEM_HANDLE);
+	if (!IS_ERR(umem))
+		rq_umem = umem;
+
+	ib_srq = uverbs_attr_get_obj(attrs, BNXT_RE_DV_CREATE_QP_SRQ_HANDLE);
+	if (!IS_ERR(ib_srq))
+		srq = container_of(ib_srq, struct bnxt_re_srq, ib_srq);
+
+	if (uverbs_attr_is_valid(attrs, BNXT_RE_DV_CREATE_QP_DBR_HANDLE))
+		dbr_obj = uverbs_attr_get_obj(attrs, BNXT_RE_DV_CREATE_QP_DBR_HANDLE);
+
+	ret = bnxt_re_dv_init_qp_attr(re_qp, ib_uctx, send_cq, recv_cq, srq,
+				      dbr_obj, &req);
+	if (ret)
+		return ret;
+
+	ret = bnxt_re_dv_init_user_qp(rdev, ib_uctx, re_qp, srq, &req, sq_umem, rq_umem);
+	if (ret)
+		return ret;
+
+	bnxt_re_dv_qp_init_msn(re_qp, &req);
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
+	ret = bnxt_re_dv_uverbs_copy_to(rdev, attrs, BNXT_RE_DV_CREATE_QP_RESP,
+					&resp, sizeof(resp));
+	if (ret)
+		goto free_qplib;
+
+	bnxt_re_dv_finalize_uobj(uobj, re_qp, attrs, BNXT_RE_DV_CREATE_QP_HANDLE);
+	bnxt_re_dv_init_qp(rdev, re_qp);
+	re_qp->is_dv_qp = true;
+	atomic_inc(&rdev->dv_qp_count);
+	if (dbr_obj)
+		ibdev_dbg(&rdev->ibdev, "%s: QP DPI index: 0x%x\n",
+			  __func__, re_qp->qplib_qp.dpi->dpi);
+
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
+static int bnxt_re_dv_free_qp(struct ib_uobject *uobj,
+			      enum rdma_remove_reason why,
+			      struct uverbs_attr_bundle *attrs)
+{
+	struct bnxt_re_qp *qp = uobj->object;
+	struct bnxt_re_dev *rdev = qp->rdev;
+	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
+	struct bnxt_qplib_nq *scq_nq = NULL;
+	struct bnxt_qplib_nq *rcq_nq = NULL;
+	int rc;
+
+	mutex_lock(&rdev->qp_lock);
+	list_del(&qp->list);
+	atomic_dec_return(&rdev->stats.res.qp_count);
+	if (qp->qplib_qp.type == CMDQ_CREATE_QP_TYPE_RC)
+		atomic_dec(&rdev->stats.res.rc_qp_count);
+	mutex_unlock(&rdev->qp_lock);
+
+	rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, qplib_qp);
+	if (rc)
+		ibdev_err_ratelimited(&rdev->ibdev,
+				      "%s id = %d failed rc = %d",
+				      __func__, qplib_qp->id, rc);
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
+	if (qp->sgid_attr)
+		rdma_put_gid_attr(qp->sgid_attr);
+	atomic_dec(&rdev->dv_qp_count);
+	kfree(qp);
+	uobj->object = NULL;
+	return 0;
+}
+
+static void bnxt_re_copyout_ah_attr(struct ib_uverbs_ah_attr *dattr,
+				    struct rdma_ah_attr *sattr)
+{
+	dattr->sl               = sattr->sl;
+	memcpy(dattr->grh.dgid, &sattr->grh.dgid, 16);
+	dattr->grh.flow_label = sattr->grh.flow_label;
+	dattr->grh.hop_limit = sattr->grh.hop_limit;
+	dattr->grh.sgid_index = sattr->grh.sgid_index;
+	dattr->grh.traffic_class = sattr->grh.traffic_class;
+}
+
+static void bnxt_re_dv_copy_qp_attr_out(struct bnxt_re_dev *rdev,
+					struct ib_uverbs_qp_attr *out,
+					struct ib_qp_attr *qp_attr,
+					struct ib_qp_init_attr *qp_init_attr)
+{
+	out->qp_state = qp_attr->qp_state;
+	out->cur_qp_state = qp_attr->cur_qp_state;
+	out->path_mtu = qp_attr->path_mtu;
+	out->path_mig_state = qp_attr->path_mig_state;
+	out->qkey = qp_attr->qkey;
+	out->rq_psn = qp_attr->rq_psn;
+	out->sq_psn = qp_attr->sq_psn;
+	out->dest_qp_num = qp_attr->dest_qp_num;
+	out->qp_access_flags = qp_attr->qp_access_flags;
+	out->max_send_wr = qp_attr->cap.max_send_wr;
+	out->max_recv_wr = qp_attr->cap.max_recv_wr;
+	out->max_send_sge = qp_attr->cap.max_send_sge;
+	out->max_recv_sge = qp_attr->cap.max_recv_sge;
+	out->max_inline_data = qp_attr->cap.max_inline_data;
+	out->pkey_index = qp_attr->pkey_index;
+	out->alt_pkey_index = qp_attr->alt_pkey_index;
+	out->en_sqd_async_notify = qp_attr->en_sqd_async_notify;
+	out->sq_draining = qp_attr->sq_draining;
+	out->max_rd_atomic = qp_attr->max_rd_atomic;
+	out->max_dest_rd_atomic = qp_attr->max_dest_rd_atomic;
+	out->min_rnr_timer = qp_attr->min_rnr_timer;
+	out->port_num = qp_attr->port_num;
+	out->timeout = qp_attr->timeout;
+	out->retry_cnt = qp_attr->retry_cnt;
+	out->rnr_retry = qp_attr->rnr_retry;
+	out->alt_port_num = qp_attr->alt_port_num;
+	out->alt_timeout = qp_attr->alt_timeout;
+
+	bnxt_re_copyout_ah_attr(&out->ah_attr, &qp_attr->ah_attr);
+	bnxt_re_copyout_ah_attr(&out->alt_ah_attr, &qp_attr->alt_ah_attr);
+}
+
+static int UVERBS_HANDLER(BNXT_RE_METHOD_DV_QUERY_QP)(struct uverbs_attr_bundle *attrs)
+{
+	struct ib_qp_init_attr qp_init_attr = {};
+	struct ib_uverbs_qp_attr attr = {};
+	struct bnxt_re_ucontext *re_uctx;
+	struct ib_qp_attr qp_attr = {};
+	struct ib_ucontext *ib_uctx;
+	struct bnxt_re_dev *rdev;
+	struct ib_uobject *uobj;
+	struct bnxt_re_qp *qp;
+	int ret;
+
+	uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_DV_QUERY_QP_HANDLE);
+	qp = uobj->object;
+
+	ib_uctx = ib_uverbs_get_ucontext(attrs);
+	if (IS_ERR(ib_uctx))
+		return PTR_ERR(ib_uctx);
+
+	re_uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
+	rdev = re_uctx->rdev;
+
+	ret = bnxt_re_query_qp_attr(qp, &qp_attr, 0, &qp_init_attr);
+	if (ret)
+		return ret;
+
+	bnxt_re_dv_copy_qp_attr_out(rdev, &attr, &qp_attr, &qp_init_attr);
+
+	ret = uverbs_copy_to(attrs, BNXT_RE_DV_QUERY_QP_ATTR, &attr,
+			     sizeof(attr));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+struct bnxt_re_resolve_cb_context {
+	struct completion comp;
+	int status;
+};
+
+static void bnxt_re_resolve_cb(int status, struct sockaddr *src_addr,
+			       struct rdma_dev_addr *addr, void *context)
+{
+	struct bnxt_re_resolve_cb_context *ctx = context;
+
+	ctx->status = status;
+	complete(&ctx->comp);
+}
+
+static int bnxt_re_resolve_eth_dmac_by_grh(const struct ib_gid_attr *sgid_attr,
+					   const union ib_gid *sgid,
+					   const union ib_gid *dgid,
+					   u8 *dmac, u8 *smac,
+					   int *hoplimit)
+{
+	struct bnxt_re_resolve_cb_context ctx;
+	struct rdma_dev_addr dev_addr;
+	union {
+		struct sockaddr_in  _sockaddr_in;
+		struct sockaddr_in6 _sockaddr_in6;
+	} sgid_addr, dgid_addr;
+	int rc;
+
+	rdma_gid2ip((struct sockaddr *)&sgid_addr, sgid);
+	rdma_gid2ip((struct sockaddr *)&dgid_addr, dgid);
+
+	memset(&dev_addr, 0, sizeof(dev_addr));
+	dev_addr.sgid_attr = sgid_attr;
+	dev_addr.net = &init_net;
+
+	init_completion(&ctx.comp);
+	rc = rdma_resolve_ip((struct sockaddr *)&sgid_addr,
+			     (struct sockaddr *)&dgid_addr, &dev_addr, 1000,
+			     bnxt_re_resolve_cb, true, &ctx);
+	if (rc)
+		return rc;
+
+	wait_for_completion(&ctx.comp);
+
+	rc = ctx.status;
+	if (rc)
+		return rc;
+
+	memcpy(dmac, dev_addr.dst_dev_addr, ETH_ALEN);
+	memcpy(smac, dev_addr.src_dev_addr, ETH_ALEN);
+	*hoplimit = dev_addr.hoplimit;
+	return 0;
+}
+
+static int bnxt_re_resolve_gid_dmac(struct ib_device *device,
+				    struct rdma_ah_attr *ah_attr)
+{
+	struct bnxt_re_dev *rdev = to_bnxt_re_dev(device, ibdev);
+	const struct ib_gid_attr *sgid_attr;
+	struct ib_global_route *grh;
+	u8 smac[ETH_ALEN] = {};
+	int hop_limit = 0xff;
+	int rc = 0;
+
+	grh = rdma_ah_retrieve_grh(ah_attr);
+	if (!grh)
+		return -EINVAL;
+
+	sgid_attr = grh->sgid_attr;
+	if (!sgid_attr)
+		return -EINVAL;
+
+	/*  Link local destination and RoCEv1 SGID */
+	if (rdma_link_local_addr((struct in6_addr *)grh->dgid.raw) &&
+	    sgid_attr->gid_type == IB_GID_TYPE_ROCE) {
+		rdma_get_ll_mac((struct in6_addr *)grh->dgid.raw,
+				ah_attr->roce.dmac);
+		return rc;
+	}
+
+	rc = bnxt_re_resolve_eth_dmac_by_grh(sgid_attr, &sgid_attr->gid,
+					     &grh->dgid, ah_attr->roce.dmac,
+					     smac, &hop_limit);
+	if (!rc) {
+		grh->hop_limit = hop_limit;
+		ibdev_dbg(&rdev->ibdev, "%s: Resolved: dmac: %pM smac: %pM\n",
+			  __func__, ah_attr->roce.dmac, smac);
+	} else {
+		ibdev_dbg(&rdev->ibdev,
+			  "%s: Failed: %d netdev: %s sgid: %pI6 dgid: %pI6 gid_type: %d gid_index: %d\n",
+			  __func__, rc, rdev->netdev ? rdev->netdev->name : "NULL",
+			  &sgid_attr->gid, &grh->dgid, sgid_attr->gid_type, grh->sgid_index);
+	}
+	return rc;
+}
+
+static int bnxt_re_resolve_eth_dmac(struct ib_device *device,
+				    struct rdma_ah_attr *ah_attr)
+{
+	int rc = 0;
+
+	/* unicast */
+	if (!rdma_is_multicast_addr((struct in6_addr *)ah_attr->grh.dgid.raw)) {
+		rc = bnxt_re_resolve_gid_dmac(device, ah_attr);
+		return rc;
+	}
+
+	/* multicast */
+	if (ipv6_addr_v4mapped((struct in6_addr *)ah_attr->grh.dgid.raw)) {
+		__be32 addr = 0;
+
+		memcpy(&addr, ah_attr->grh.dgid.raw + 12, 4);
+		       ip_eth_mc_map(addr, (char *)ah_attr->roce.dmac);
+	} else {
+		ipv6_eth_mc_map((struct in6_addr *)ah_attr->grh.dgid.raw,
+				(char *)ah_attr->roce.dmac);
+	}
+	return rc;
+}
+
+static int bnxt_re_copyin_ah_attr(struct ib_device *device,
+				  struct rdma_ah_attr *dattr,
+				  struct ib_uverbs_ah_attr *sattr)
+{
+	const struct ib_gid_attr *sgid_attr;
+	struct ib_global_route *grh;
+	int rc;
+
+	dattr->sl		= sattr->sl;
+	dattr->static_rate	= sattr->static_rate;
+	dattr->port_num		= sattr->port_num;
+
+	if (!sattr->is_global)
+		return 0;
+
+	grh = &dattr->grh;
+	if (grh->sgid_attr)
+		return 0;
+
+	sgid_attr = rdma_get_gid_attr(device, sattr->port_num,
+				      sattr->grh.sgid_index);
+	if (IS_ERR(sgid_attr))
+		return PTR_ERR(sgid_attr);
+	grh->sgid_attr = sgid_attr;
+
+	memcpy(&grh->dgid, sattr->grh.dgid, 16);
+	grh->flow_label = sattr->grh.flow_label;
+	grh->hop_limit = sattr->grh.hop_limit;
+	grh->sgid_index = sattr->grh.sgid_index;
+	grh->traffic_class = sattr->grh.traffic_class;
+
+	rc = bnxt_re_resolve_eth_dmac(device, dattr);
+	if (rc)
+		rdma_put_gid_attr(sgid_attr);
+	return rc;
+}
+
+static int bnxt_re_dv_copy_qp_attr(struct bnxt_re_dev *rdev,
+				   struct ib_qp_attr *dst,
+				   struct ib_uverbs_qp_attr *src)
+{
+	int rc;
+
+	if (src->qp_attr_mask & IB_QP_ALT_PATH)
+		return -EINVAL;
+
+	dst->qp_state           = src->qp_state;
+	dst->cur_qp_state       = src->cur_qp_state;
+	dst->path_mtu           = src->path_mtu;
+	dst->path_mig_state     = src->path_mig_state;
+	dst->qkey               = src->qkey;
+	dst->rq_psn             = src->rq_psn;
+	dst->sq_psn             = src->sq_psn;
+	dst->dest_qp_num        = src->dest_qp_num;
+	dst->qp_access_flags    = src->qp_access_flags;
+
+	dst->cap.max_send_wr        = src->max_send_wr;
+	dst->cap.max_recv_wr        = src->max_recv_wr;
+	dst->cap.max_send_sge       = src->max_send_sge;
+	dst->cap.max_recv_sge       = src->max_recv_sge;
+	dst->cap.max_inline_data    = src->max_inline_data;
+
+	if (src->qp_attr_mask & IB_QP_AV) {
+		rc = bnxt_re_copyin_ah_attr(&rdev->ibdev, &dst->ah_attr,
+					    &src->ah_attr);
+		if (rc)
+			return rc;
+	}
+
+	dst->pkey_index         = src->pkey_index;
+	dst->alt_pkey_index     = src->alt_pkey_index;
+	dst->en_sqd_async_notify = src->en_sqd_async_notify;
+	dst->sq_draining        = src->sq_draining;
+	dst->max_rd_atomic      = src->max_rd_atomic;
+	dst->max_dest_rd_atomic = src->max_dest_rd_atomic;
+	dst->min_rnr_timer      = src->min_rnr_timer;
+	dst->port_num           = src->port_num;
+	dst->timeout            = src->timeout;
+	dst->retry_cnt          = src->retry_cnt;
+	dst->rnr_retry          = src->rnr_retry;
+	dst->alt_port_num       = src->alt_port_num;
+	dst->alt_timeout        = src->alt_timeout;
+
+	return 0;
+}
+
+static int bnxt_re_dv_modify_qp(struct ib_uobject *uobj,
+				struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uverbs_qp_attr qp_u_attr = {};
+	struct bnxt_re_ucontext *re_uctx;
+	struct ib_qp_attr qp_attr = {};
+	struct ib_ucontext *ib_uctx;
+	struct bnxt_re_dev *rdev;
+	struct bnxt_re_qp *qp;
+	int err;
+
+	qp = uobj->object;
+
+	ib_uctx = ib_uverbs_get_ucontext(attrs);
+	if (IS_ERR(ib_uctx))
+		return PTR_ERR(ib_uctx);
+
+	re_uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
+	rdev = re_uctx->rdev;
+
+	err = uverbs_copy_from_or_zero(&qp_u_attr, attrs, BNXT_RE_DV_MODIFY_QP_REQ);
+	if (err)
+		return err;
+
+	err = bnxt_re_dv_copy_qp_attr(rdev, &qp_attr, &qp_u_attr);
+	if (err)
+		return err;
+
+	err = bnxt_re_modify_qp(&qp->ib_qp, &qp_attr, qp_u_attr.qp_attr_mask, NULL);
+	if (err) {
+		ibdev_dbg(&rdev->ibdev,
+			  "%s: Modify QP failed: 0x%llx, handle: 0x%x\n",
+			  __func__, (u64)qp, uobj->id);
+		if (qp_u_attr.qp_attr_mask & IB_QP_AV)
+			rdma_put_gid_attr(qp_attr.ah_attr.grh.sgid_attr);
+	} else {
+		if (qp_u_attr.qp_attr_mask & IB_QP_AV)
+			qp->sgid_attr = qp_attr.ah_attr.grh.sgid_attr;
+	}
+	return err;
+}
+
+static int UVERBS_HANDLER(BNXT_RE_METHOD_DV_MODIFY_QP)(struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uobject *uobj;
+
+	uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_DV_MODIFY_QP_HANDLE);
+	return bnxt_re_dv_modify_qp(uobj, attrs);
+}
+
+DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_DV_CREATE_QP,
+			    UVERBS_ATTR_IDR(BNXT_RE_DV_CREATE_QP_HANDLE,
+					    BNXT_RE_OBJECT_DV_QP,
+					    UVERBS_ACCESS_NEW,
+					    UA_MANDATORY),
+			    UVERBS_ATTR_PTR_IN(BNXT_RE_DV_CREATE_QP_REQ,
+					       UVERBS_ATTR_STRUCT(struct bnxt_re_dv_create_qp_req,
+								  rq_slots),
+					       UA_MANDATORY),
+			    UVERBS_ATTR_IDR(BNXT_RE_DV_CREATE_QP_SEND_CQ_HANDLE,
+					    UVERBS_IDR_ANY_OBJECT,
+					    UVERBS_ACCESS_READ,
+					    UA_MANDATORY),
+			    UVERBS_ATTR_IDR(BNXT_RE_DV_CREATE_QP_RECV_CQ_HANDLE,
+					    UVERBS_IDR_ANY_OBJECT,
+					    UVERBS_ACCESS_READ,
+					    UA_MANDATORY),
+			    UVERBS_ATTR_IDR(BNXT_RE_DV_CREATE_QP_SQ_UMEM_HANDLE,
+					    BNXT_RE_OBJECT_UMEM,
+					    UVERBS_ACCESS_READ,
+					    UA_OPTIONAL),
+			    UVERBS_ATTR_IDR(BNXT_RE_DV_CREATE_QP_RQ_UMEM_HANDLE,
+					    BNXT_RE_OBJECT_UMEM,
+					    UVERBS_ACCESS_READ,
+					    UA_OPTIONAL),
+			    UVERBS_ATTR_IDR(BNXT_RE_DV_CREATE_QP_SRQ_HANDLE,
+					    UVERBS_OBJECT_SRQ,
+					    UVERBS_ACCESS_READ,
+					    UA_OPTIONAL),
+			    UVERBS_ATTR_IDR(BNXT_RE_DV_CREATE_QP_DBR_HANDLE,
+					    BNXT_RE_OBJECT_DBR,
+					    UVERBS_ACCESS_READ,
+					    UA_OPTIONAL),
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_DV_CREATE_QP_RESP,
+						UVERBS_ATTR_STRUCT(struct bnxt_re_dv_create_qp_resp,
+								   qpid),
+						UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_METHOD_DESTROY(BNXT_RE_METHOD_DV_DESTROY_QP,
+				    UVERBS_ATTR_IDR(BNXT_RE_DV_DESTROY_QP_HANDLE,
+						    BNXT_RE_OBJECT_DV_QP,
+						    UVERBS_ACCESS_DESTROY,
+						    UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_DV_QUERY_QP,
+			    UVERBS_ATTR_IDR(BNXT_RE_DV_QUERY_QP_HANDLE,
+					    BNXT_RE_OBJECT_DV_QP,
+					    UVERBS_ACCESS_READ,
+					    UA_MANDATORY),
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_DV_QUERY_QP_ATTR,
+						UVERBS_ATTR_STRUCT(struct ib_uverbs_qp_attr,
+								   reserved),
+						UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_DV_MODIFY_QP,
+			    UVERBS_ATTR_IDR(BNXT_RE_DV_MODIFY_QP_HANDLE,
+					    UVERBS_IDR_ANY_OBJECT,
+					    UVERBS_ACCESS_READ,
+					    UA_MANDATORY),
+			    UVERBS_ATTR_PTR_IN(BNXT_RE_DV_MODIFY_QP_REQ,
+					       UVERBS_ATTR_STRUCT(struct ib_uverbs_qp_attr,
+								  reserved),
+					       UA_OPTIONAL));
+
+DECLARE_UVERBS_NAMED_OBJECT(BNXT_RE_OBJECT_DV_QP,
+			    UVERBS_TYPE_ALLOC_IDR(bnxt_re_dv_free_qp),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_DV_CREATE_QP),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_DV_DESTROY_QP),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_DV_MODIFY_QP),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_DV_QUERY_QP),
+);
+
 const struct uapi_definition bnxt_re_uapi_defs[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_ALLOC_PAGE),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_NOTIFY_DRV),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_GET_TOGGLE_MEM),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_DBR),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_UMEM),
+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_DV_CQ),
+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_DV_QP),
 	{}
 };
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 9390624b00e1..c96b56b97159 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -971,10 +971,12 @@ static void bnxt_re_del_unique_gid(struct bnxt_re_dev *rdev)
 		dev_err(rdev_to_dev(rdev), "Failed to delete unique GID, rc: %d\n", rc);
 }
 
-static void bnxt_re_qp_free_umem(struct bnxt_re_qp *qp)
+void bnxt_re_qp_free_umem(struct bnxt_re_qp *qp)
 {
 	ib_umem_release(qp->rumem);
+	kfree(qp->rq_umem);
 	ib_umem_release(qp->sumem);
+	kfree(qp->sq_umem);
 }
 
 /* Queue Pairs */
@@ -1033,7 +1035,7 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	return 0;
 }
 
-static u8 __from_ib_qp_type(enum ib_qp_type type)
+u8 __from_ib_qp_type(enum ib_qp_type type)
 {
 	switch (type) {
 	case IB_QPT_GSI:
@@ -1269,7 +1271,7 @@ static int bnxt_re_qp_alloc_init_xrrq(struct bnxt_re_qp *qp)
 	return rc;
 }
 
-static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
+int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp, bool is_dv_qp)
 {
 	struct bnxt_qplib_res *res = &qp->rdev->qplib_res;
 	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
@@ -1283,12 +1285,17 @@ static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
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
@@ -1299,10 +1306,16 @@ static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
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
@@ -1315,6 +1328,7 @@ static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
 		      CMDQ_CREATE_QP_RQ_LVL_SFT);
 	rq->hwq.pg_sz_lvl = pg_sz_lvl;
 
+done:
 	if (qplib_qp->psn_sz) {
 		rc = bnxt_re_qp_alloc_init_xrrq(qp);
 		if (rc)
@@ -1383,7 +1397,7 @@ static struct bnxt_re_qp *bnxt_re_create_shadow_qp
 	qp->qplib_qp.rq_hdr_buf_size = BNXT_QPLIB_MAX_GRH_HDR_SIZE_IPV6;
 	qp->qplib_qp.dpi = &rdev->dpi_privileged;
 
-	rc = bnxt_re_setup_qp_hwqs(qp);
+	rc = bnxt_re_setup_qp_hwqs(qp, false);
 	if (rc)
 		goto fail;
 
@@ -1680,7 +1694,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 
 	bnxt_re_qp_calculate_msn_psn_size(qp);
 
-	rc = bnxt_re_setup_qp_hwqs(qp);
+	rc = bnxt_re_setup_qp_hwqs(qp, false);
 	if (rc)
 		goto free_umem;
 
@@ -2497,10 +2511,9 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 	return rc;
 }
 
-int bnxt_re_query_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
-		     int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr)
+int bnxt_re_query_qp_attr(struct bnxt_re_qp *qp, struct ib_qp_attr *qp_attr,
+			  int attr_mask, struct ib_qp_init_attr *qp_init_attr)
 {
-	struct bnxt_re_qp *qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
 	struct bnxt_re_dev *rdev = qp->rdev;
 	struct bnxt_qplib_qp *qplib_qp;
 	int rc;
@@ -2558,6 +2571,18 @@ int bnxt_re_query_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 	return rc;
 }
 
+int bnxt_re_query_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
+		     int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr)
+{
+	struct bnxt_re_qp *qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
+
+	/* Not all of output fields are applicable, make sure to zero them */
+	memset(qp_init_attr, 0, sizeof(*qp_init_attr));
+	memset(qp_attr, 0, sizeof(*qp_attr));
+
+	return bnxt_re_query_qp_attr(qp, qp_attr, qp_attr_mask, qp_init_attr);
+}
+
 /* Routine for sending QP1 packets for RoCE V1 an V2
  */
 static int bnxt_re_build_qp1_send_v2(struct bnxt_re_qp *qp,
@@ -3245,7 +3270,7 @@ int bnxt_re_post_recv(struct ib_qp *ib_qp, const struct ib_recv_wr *wr,
 	return rc;
 }
 
-static struct bnxt_qplib_nq *bnxt_re_get_nq(struct bnxt_re_dev *rdev)
+struct bnxt_qplib_nq *bnxt_re_get_nq(struct bnxt_re_dev *rdev)
 {
 	int min, indx;
 
@@ -3260,7 +3285,7 @@ static struct bnxt_qplib_nq *bnxt_re_get_nq(struct bnxt_re_dev *rdev)
 	return &rdev->nqr->nq[min];
 }
 
-static void bnxt_re_put_nq(struct bnxt_re_dev *rdev, struct bnxt_qplib_nq *nq)
+void bnxt_re_put_nq(struct bnxt_re_dev *rdev, struct bnxt_qplib_nq *nq)
 {
 	mutex_lock(&rdev->nqr->load_lock);
 	nq->load--;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 1ff89192a728..e48c2cb2e02b 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -96,6 +96,11 @@ struct bnxt_re_qp {
 	struct bnxt_re_cq	*scq;
 	struct bnxt_re_cq	*rcq;
 	struct dentry		*dentry;
+	/* Below members added for DV support */
+	bool			is_dv_qp;
+	struct bnxt_re_dv_umem *sq_umem;
+	struct bnxt_re_dv_umem *rq_umem;
+	const struct ib_gid_attr *sgid_attr;
 };
 
 struct bnxt_re_cq {
@@ -113,6 +118,8 @@ struct bnxt_re_cq {
 	int			resize_cqe;
 	void			*uctx_cq_page;
 	struct hlist_node	hash_entry;
+	bool			is_dv_cq;
+	struct bnxt_re_dv_umem	*umem_handle;
 	struct bnxt_re_ucontext *uctx;
 };
 
@@ -304,4 +311,9 @@ void bnxt_re_unlock_cqs(struct bnxt_re_qp *qp, unsigned long flags);
 struct bnxt_re_user_mmap_entry*
 bnxt_re_mmap_entry_insert(struct bnxt_re_ucontext *uctx, u64 mem_offset,
 			  enum bnxt_re_mmap_flag mmap_flag, u64 *offset);
+u8 __from_ib_qp_type(enum ib_qp_type type);
+int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp, bool is_dv_qp);
+void bnxt_re_qp_free_umem(struct bnxt_re_qp *qp);
+int bnxt_re_query_qp_attr(struct bnxt_re_qp *qp, struct ib_qp_attr *qp_attr,
+			  int attr_mask, struct ib_qp_init_attr *qp_init_attr);
 #endif /* __BNXT_RE_IB_VERBS_H__ */
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index 59a0b030de04..7baf30b7b1b0 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -164,6 +164,8 @@ enum bnxt_re_objects {
 	BNXT_RE_OBJECT_GET_TOGGLE_MEM,
 	BNXT_RE_OBJECT_DBR,
 	BNXT_RE_OBJECT_UMEM,
+	BNXT_RE_OBJECT_DV_CQ,
+	BNXT_RE_OBJECT_DV_QP,
 };
 
 enum bnxt_re_alloc_page_type {
@@ -264,4 +266,95 @@ enum bnxt_re_dv_umem_methods {
 	BNXT_RE_METHOD_UMEM_DEREG,
 };
 
+struct bnxt_re_dv_cq_req {
+	__u32 ncqe;
+	__aligned_u64 va;
+	__aligned_u64 comp_mask;
+};
+
+struct bnxt_re_dv_cq_resp {
+	__u32 cqid;
+	__u32 tail;
+	__u32 phase;
+	__u32 rsvd;
+	__aligned_u64 comp_mask;
+};
+
+enum bnxt_re_dv_create_cq_attrs {
+	BNXT_RE_DV_CREATE_CQ_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+	BNXT_RE_DV_CREATE_CQ_REQ,
+	BNXT_RE_DV_CREATE_CQ_UMEM_HANDLE,
+	BNXT_RE_DV_CREATE_CQ_UMEM_OFFSET,
+	BNXT_RE_DV_CREATE_CQ_RESP,
+};
+
+enum bnxt_re_dv_cq_methods {
+	BNXT_RE_METHOD_DV_CREATE_CQ = (1U << UVERBS_ID_NS_SHIFT),
+	BNXT_RE_METHOD_DV_DESTROY_CQ,
+};
+
+enum bnxt_re_dv_destroy_cq_attrs {
+	BNXT_RE_DV_DESTROY_CQ_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+};
+
+struct bnxt_re_dv_create_qp_req {
+	int qp_type;
+	__u32 max_send_wr;
+	__u32 max_recv_wr;
+	__u32 max_send_sge;
+	__u32 max_recv_sge;
+	__u32 max_inline_data;
+	__u32 pd_id;
+	__aligned_u64 qp_handle;
+	__aligned_u64 sq_va;
+	__u32 sq_umem_offset;
+	__u32 sq_len;   /* total len including MSN area */
+	__u32 sq_slots;
+	__u32 sq_wqe_sz;
+	__u32 sq_psn_sz;
+	__u32 sq_npsn;
+	__aligned_u64 rq_va;
+	__u32 rq_umem_offset;
+	__u32 rq_len;
+	__u32 rq_slots; /* == max_recv_wr */
+	__u32 rq_wqe_sz;
+};
+
+struct bnxt_re_dv_create_qp_resp {
+	__u32 qpid;
+};
+
+enum bnxt_re_dv_create_qp_attrs {
+	BNXT_RE_DV_CREATE_QP_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+	BNXT_RE_DV_CREATE_QP_REQ,
+	BNXT_RE_DV_CREATE_QP_SEND_CQ_HANDLE,
+	BNXT_RE_DV_CREATE_QP_RECV_CQ_HANDLE,
+	BNXT_RE_DV_CREATE_QP_SQ_UMEM_HANDLE,
+	BNXT_RE_DV_CREATE_QP_RQ_UMEM_HANDLE,
+	BNXT_RE_DV_CREATE_QP_SRQ_HANDLE,
+	BNXT_RE_DV_CREATE_QP_DBR_HANDLE,
+	BNXT_RE_DV_CREATE_QP_RESP
+};
+
+enum bnxt_re_dv_qp_methods {
+	BNXT_RE_METHOD_DV_CREATE_QP = (1U << UVERBS_ID_NS_SHIFT),
+	BNXT_RE_METHOD_DV_DESTROY_QP,
+	BNXT_RE_METHOD_DV_MODIFY_QP,
+	BNXT_RE_METHOD_DV_QUERY_QP,
+};
+
+enum bnxt_re_dv_destroy_qp_attrs {
+	BNXT_RE_DV_DESTROY_QP_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+};
+
+enum bnxt_re_var_dv_modify_qp_attrs {
+	BNXT_RE_DV_MODIFY_QP_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+	BNXT_RE_DV_MODIFY_QP_REQ,
+};
+
+enum bnxt_re_dv_query_qp_attrs {
+	BNXT_RE_DV_QUERY_QP_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+	BNXT_RE_DV_QUERY_QP_ATTR,
+};
+
 #endif /* __BNXT_RE_UVERBS_ABI_H__*/
-- 
2.51.2.636.ga99f379adf


