Return-Path: <linux-rdma+bounces-14195-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9388DC2B2F6
	for <lists+linux-rdma@lfdr.de>; Mon, 03 Nov 2025 11:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB09918930B1
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Nov 2025 10:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899313009C4;
	Mon,  3 Nov 2025 10:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dpb3Uxko"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F0C2FFF91
	for <linux-rdma@vger.kernel.org>; Mon,  3 Nov 2025 10:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167470; cv=none; b=Ctd8LBRT3/5b4C36+cJ3RwOUd/hi1dn+X3z/ePxx1uP2GuO/6EW2wVmUBlty569b0OD+QJZoSl/WcmeCQg/PeZ4T/f7wX83w5LIW4JokyuoMhhUc3CkhAzlHAIDwyXNDkm5hbIvJTCsCAgmjnBcpqbBH2dUsf+XmLuPe3pJFRsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167470; c=relaxed/simple;
	bh=p4f9IEIbk4gHRL0Y7LKlKlT2ZDEQiRvJYUsl8w9PXKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RogsbpnDhFIJ+d4GUfKNF+PCI8KC3ZEqVMONc+oW0Rn2iFWXqegRyM8QTiSnXZnO6CdvkdxMOpkuji4ozYfOumgPJnnsZLoJF5ndSuOW4xAQWKGuT+9rQkJvXcBDCTetEuAjLW0/jxAqIkUxykri0NNb7sBVonNEieEMtCDv1/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dpb3Uxko; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-945a51050b2so168724539f.0
        for <linux-rdma@vger.kernel.org>; Mon, 03 Nov 2025 02:57:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762167466; x=1762772266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XftOfb/YmeK6Gd+vA9Rt2Jpf+vsCOuqBmm4KlaFBCMM=;
        b=lN2dXkxEVq4hfCjrjmygtGK2B1c49JlBklD/jSjIL3qJcAK58IgWifqKXb93/lSSSG
         slgW5fjsIuU4Rq+emUtyyRnsUtx+M2+zwu/iY5OnhVVJo0q/n6FrRjh9AFmS/3NoffAY
         oEiNR04VYsEtQyS/OUYCvfqdWEpNbfEekcp6750B8qGKIty4P5lGe0faLKND+bKY5OWM
         7I+xqbSSsdT0FSJ2xmNwexZ0BMT7v7Q0lQneGfEnnjonH4aGULpTf8Jp7BpUezGTWl2z
         3WOkBfer696KOG8wUjSpZiwoRFgPc/leY54FER9AHSPJRKLXvdg55ofIWMuPsOk2U0OE
         uqXg==
X-Gm-Message-State: AOJu0Yz8QnPMR9nXGqmeBcxiDA4aAe1WUzWWmwSJRxjK6WfMuEgiWTqs
	tiTBMi3kxF79cv+Gox31km21ZPT6oIP3hEoM9bJhogMNm/if6smhRoROKsrb3DZjAMllrrgn+rX
	DL4VyIsfxJ2XQD8cYtjGcfcXzXQ/xmiWQgSBX+FZZCsvm32nnvda21N8BrjQDZCbH5Pv5ADKiDp
	awliepsF3C3J50nG+37wjHQLwRxLDIgJcN9Ty52AnClZq9ls075EW9DTvcocgpUvyGztit9En1o
	T9mPZQS9MTdmc809vLPrOdi9YeD
X-Gm-Gg: ASbGncsb6gAZ4kzhdSHb3O8+qLSKl3wPqbf766TzHzZU0SHwNPOnw7SUK4lt9ALuR+X
	JGtZFY9p2/XxDY82webpzn5HN2R182RLcm5psCTjVX15OIBP3GzvQZOW3CQIROyUTCS82Yfs+2b
	GveSInzMQWUc7O4l2MCP+GdSGkxFQRIbXXmB7Ad5GShPc2omQNj3x34tapvOKa52jmg0PhWi+nd
	VnnVnnRxZ351n/wPVQyyuWm8Do+0d1zVNNuu1/253xY5eknXjtZtXEcUtZsjNrMKfqASLsAS8Bz
	dj8sSAJVczpT1kj32IMcyTjGw/AsLSnvLxV2GPbsyqLq0/NqkHoh0k41kbBqZiW0jgTBACONtEd
	VGSsWYQVW1/vTMueeLBlbIAZ2B7AP30A5EsjMqScz0LcmPux9Os6SUrnQJ8f28V0VxbEZHIBc0B
	pji62iaBtCwc7qUIONO/xugrMHGkDra6c2xGtbvOQTfCPjaA==
X-Google-Smtp-Source: AGHT+IFHv/caCqu8QdOjLp+VQpucEmyD/IMzFGdyaQt+msV6qSaG4uXUG6h8h2s+GL84IkWYdrHq1mNVIXba
X-Received: by 2002:a92:3649:0:b0:432:fc40:f323 with SMTP id e9e14a558f8ab-433012237c8mr182288085ab.10.1762167466169;
        Mon, 03 Nov 2025 02:57:46 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5b7226c798csm6094173.26.2025.11.03.02.57.44
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2025 02:57:46 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-340299cc2ecso4752946a91.1
        for <linux-rdma@vger.kernel.org>; Mon, 03 Nov 2025 02:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762167464; x=1762772264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XftOfb/YmeK6Gd+vA9Rt2Jpf+vsCOuqBmm4KlaFBCMM=;
        b=dpb3UxkoQqMrBS3dpyq6WDmOgo58BO8BcSzNLTXLFkHRwMYdZQNAbpdsKoYAoKvr9B
         yThxQaRM6ssDNjZC+RJ3ZsWeMgLD93Uo3tjJioxETJuqQApFpvnCoSGskzkH8pVIw5Uk
         cMgMEql5J8ri6SrmzLWGIUgOaqFgvttPFUdh4=
X-Received: by 2002:a17:90b:4fcb:b0:340:68ee:ae5e with SMTP id 98e67ed59e1d1-3407f4f4f2dmr15875606a91.4.1762167463588;
        Mon, 03 Nov 2025 02:57:43 -0800 (PST)
X-Received: by 2002:a17:90b:4fcb:b0:340:68ee:ae5e with SMTP id 98e67ed59e1d1-3407f4f4f2dmr15875581a91.4.1762167463162;
        Mon, 03 Nov 2025 02:57:43 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159fc0e19sm602263a91.4.2025.11.03.02.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:57:42 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next 3/4] RDMA/bnxt_re: Direct Verbs: Support DBR and UMEM verbs
Date: Mon,  3 Nov 2025 16:20:32 +0530
Message-ID: <20251103105033.205586-4-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20251103105033.205586-1-sriharsha.basavapatna@broadcom.com>
References: <20251103105033.205586-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

The following Direct Verb (DV) methods have been implemented in
this patch.

Doorbell Region Direct Verbs:
-----------------------------
- BNXT_RE_METHOD_DBR_ALLOC:
  This will allow the appliation to create extra doorbell regions
  and use the associated doorbell page index in DV_CREATE_QP and
  use the associated DB address while ringing the doorbell.

- BNXT_RE_METHOD_DBR_FREE:
  Free the allocated doorbell region.

- BNXT_RE_METHOD_DBR_QUERY:
  Return the default doorbell page index and doorbell page address
  associated with the ucontext.

Umem Registration Direct Verbs:
-------------------------------
- BNXT_RE_METHOD_UMEM_REG:
  Register the user memory to be used by the application with
  the driver. Application can register a large chunk of memory and
  use it during subsequent resource creation DV APIs.

  Note that the driver doesn't really map/pin the user memory
  during dv_umem_reg(). The app specified memory params (addr, len)
  are saved and a corresponding umem-handle is returned.

  This memory is mapped/pinned when the application subsequently
  creates the required resources (CQ/QP) using respective direct
  verbs. This is implemented in the next patch in this series.

- BNXT_RE_METHOD_UMEM_DEREG:
  Deregister the user memory specified by the umem-handle.

Co-developed-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/dv.c        | 255 ++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |   8 +
 drivers/infiniband/hw/bnxt_re/qplib_res.c |  43 ++++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |   4 +
 include/uapi/rdma/bnxt_re-abi.h           |  49 +++++
 5 files changed, 359 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/dv.c b/drivers/infiniband/hw/bnxt_re/dv.c
index 2b3e34b940b3..4ce5824a0a10 100644
--- a/drivers/infiniband/hw/bnxt_re/dv.c
+++ b/drivers/infiniband/hw/bnxt_re/dv.c
@@ -42,6 +42,7 @@
 #include <rdma/ib_user_ioctl_cmds.h>
 #define UVERBS_MODULE_NAME bnxt_re
 #include <rdma/uverbs_named_ioctl.h>
+#include <rdma/ib_umem.h>
 #include <rdma/bnxt_re-abi.h>
 
 #include "roce_hsi.h"
@@ -52,6 +53,15 @@
 #include "bnxt_re.h"
 #include "ib_verbs.h"
 
+struct bnxt_re_dv_umem {
+	struct bnxt_re_dev *rdev;
+	struct ib_umem *umem;
+	__u64 addr;
+	size_t size;
+	__u32 access;
+	int dmabuf_fd;
+};
+
 static struct bnxt_re_cq *bnxt_re_search_for_cq(struct bnxt_re_dev *rdev, u32 cq_id)
 {
 	struct bnxt_re_cq *cq = NULL, *tmp_cq;
@@ -348,9 +358,254 @@ DECLARE_UVERBS_NAMED_OBJECT(BNXT_RE_OBJECT_GET_TOGGLE_MEM,
 			    &UVERBS_METHOD(BNXT_RE_METHOD_GET_TOGGLE_MEM),
 			    &UVERBS_METHOD(BNXT_RE_METHOD_RELEASE_TOGGLE_MEM));
 
+static int bnxt_re_dv_validate_umem_attr(struct bnxt_re_dev *rdev,
+					 struct uverbs_attr_bundle *attrs,
+					 struct bnxt_re_dv_umem *obj)
+{
+	int dmabuf_fd = 0;
+	u32 access_flags;
+	size_t size;
+	u64 addr;
+	int err;
+
+	err = uverbs_get_flags32(&access_flags, attrs,
+				 BNXT_RE_UMEM_OBJ_REG_ACCESS,
+				 IB_ACCESS_LOCAL_WRITE |
+				 IB_ACCESS_REMOTE_WRITE |
+				 IB_ACCESS_REMOTE_READ);
+	if (err)
+		return err;
+
+	err = ib_check_mr_access(&rdev->ibdev, access_flags);
+	if (err)
+		return err;
+
+	if (uverbs_copy_from(&addr, attrs, BNXT_RE_UMEM_OBJ_REG_ADDR) ||
+	    uverbs_copy_from(&size, attrs, BNXT_RE_UMEM_OBJ_REG_LEN))
+		return -EFAULT;
+	if (uverbs_attr_is_valid(attrs, BNXT_RE_UMEM_OBJ_REG_DMABUF_FD)) {
+		if (uverbs_get_raw_fd(&dmabuf_fd, attrs,
+				      BNXT_RE_UMEM_OBJ_REG_DMABUF_FD))
+			return -EFAULT;
+	}
+	obj->addr = addr;
+	obj->size = size;
+	obj->access = access_flags;
+	obj->dmabuf_fd = dmabuf_fd;
+
+	return 0;
+}
+
+static int bnxt_re_dv_umem_cleanup(struct ib_uobject *uobject,
+				   enum rdma_remove_reason why,
+				   struct uverbs_attr_bundle *attrs)
+{
+	kfree(uobject->object);
+	return 0;
+}
+
+static int UVERBS_HANDLER(BNXT_RE_METHOD_UMEM_REG)(struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uobject *uobj =
+		uverbs_attr_get_uobject(attrs, BNXT_RE_UMEM_OBJ_REG_HANDLE);
+	struct bnxt_re_ucontext *uctx;
+	struct ib_ucontext *ib_uctx;
+	struct bnxt_re_dv_umem *obj;
+	struct bnxt_re_dev *rdev;
+	int err;
+
+	ib_uctx = ib_uverbs_get_ucontext(attrs);
+	if (IS_ERR(ib_uctx))
+		return PTR_ERR(ib_uctx);
+
+	uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
+	rdev = uctx->rdev;
+
+	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
+	if (!obj)
+		return -ENOMEM;
+
+	obj->rdev = rdev;
+	err = bnxt_re_dv_validate_umem_attr(rdev, attrs, obj);
+	if (err)
+		goto free_mem;
+
+	obj->umem = NULL;
+	uobj->object = obj;
+	uverbs_finalize_uobj_create(attrs, BNXT_RE_UMEM_OBJ_REG_HANDLE);
+
+	return 0;
+free_mem:
+	kfree(obj);
+	return err;
+}
+
+DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_UMEM_REG,
+			    UVERBS_ATTR_IDR(BNXT_RE_UMEM_OBJ_REG_HANDLE,
+					    BNXT_RE_OBJECT_UMEM,
+					    UVERBS_ACCESS_NEW,
+					    UA_MANDATORY),
+			    UVERBS_ATTR_PTR_IN(BNXT_RE_UMEM_OBJ_REG_ADDR,
+					       UVERBS_ATTR_TYPE(u64),
+					       UA_MANDATORY),
+			    UVERBS_ATTR_PTR_IN(BNXT_RE_UMEM_OBJ_REG_LEN,
+					       UVERBS_ATTR_TYPE(u64),
+					       UA_MANDATORY),
+			    UVERBS_ATTR_FLAGS_IN(BNXT_RE_UMEM_OBJ_REG_ACCESS,
+						 enum ib_access_flags),
+			    UVERBS_ATTR_RAW_FD(BNXT_RE_UMEM_OBJ_REG_DMABUF_FD,
+					       UA_OPTIONAL),
+			    UVERBS_ATTR_CONST_IN(BNXT_RE_UMEM_OBJ_REG_PGSZ_BITMAP,
+						 u64));
+
+DECLARE_UVERBS_NAMED_METHOD_DESTROY(BNXT_RE_METHOD_UMEM_DEREG,
+				    UVERBS_ATTR_IDR(BNXT_RE_UMEM_OBJ_DEREG_HANDLE,
+						    BNXT_RE_OBJECT_UMEM,
+						    UVERBS_ACCESS_DESTROY,
+						    UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_OBJECT(BNXT_RE_OBJECT_UMEM,
+			    UVERBS_TYPE_ALLOC_IDR(bnxt_re_dv_umem_cleanup),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_UMEM_REG),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_UMEM_DEREG));
+
+static int UVERBS_HANDLER(BNXT_RE_METHOD_DBR_ALLOC)(struct uverbs_attr_bundle *attrs)
+{
+	struct bnxt_re_dv_db_region dbr = {};
+	struct bnxt_re_alloc_dbr_obj *obj;
+	struct bnxt_re_ucontext *uctx;
+	struct ib_ucontext *ib_uctx;
+	struct bnxt_qplib_dpi *dpi;
+	struct bnxt_re_dev *rdev;
+	struct ib_uobject *uobj;
+	u64 mmap_offset;
+	int ret;
+
+	ib_uctx = ib_uverbs_get_ucontext(attrs);
+	if (IS_ERR(ib_uctx))
+		return PTR_ERR(ib_uctx);
+
+	uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
+	rdev = uctx->rdev;
+	uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_DV_ALLOC_DBR_HANDLE);
+
+	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
+	if (!obj)
+		return -ENOMEM;
+
+	dpi = &obj->dpi;
+	ret = bnxt_qplib_alloc_uc_dpi(&rdev->qplib_res, dpi);
+	if (ret)
+		goto free_mem;
+
+	obj->entry = bnxt_re_mmap_entry_insert(uctx, 0, BNXT_RE_MMAP_UC_DB,
+					       &mmap_offset);
+	if (!obj->entry) {
+		ret = -ENOMEM;
+		goto free_dpi;
+	}
+
+	obj->rdev = rdev;
+	dbr.umdbr = dpi->umdbr;
+	dbr.dpi = dpi->dpi;
+
+	ret = uverbs_copy_to_struct_or_zero(attrs, BNXT_RE_DV_ALLOC_DBR_ATTR,
+					    &dbr, sizeof(dbr));
+	if (ret)
+		goto free_entry;
+
+	ret = uverbs_copy_to(attrs, BNXT_RE_DV_ALLOC_DBR_OFFSET,
+			     &mmap_offset, sizeof(mmap_offset));
+	if (ret)
+		goto free_entry;
+
+	uobj->object = obj;
+	uverbs_finalize_uobj_create(attrs, BNXT_RE_DV_ALLOC_DBR_HANDLE);
+	return 0;
+free_entry:
+	rdma_user_mmap_entry_remove(&obj->entry->rdma_entry);
+free_dpi:
+	bnxt_qplib_free_uc_dpi(&rdev->qplib_res, dpi);
+free_mem:
+	kfree(obj);
+	return ret;
+}
+
+static int bnxt_re_dv_dbr_cleanup(struct ib_uobject *uobject,
+				  enum rdma_remove_reason why,
+				  struct uverbs_attr_bundle *attrs)
+{
+	struct bnxt_re_alloc_dbr_obj *obj = uobject->object;
+	struct bnxt_re_dev *rdev = obj->rdev;
+
+	rdma_user_mmap_entry_remove(&obj->entry->rdma_entry);
+	bnxt_qplib_free_uc_dpi(&rdev->qplib_res, &obj->dpi);
+	kfree(obj);
+	return 0;
+}
+
+static int UVERBS_HANDLER(BNXT_RE_METHOD_DBR_QUERY)(struct uverbs_attr_bundle *attrs)
+{
+	struct bnxt_re_dv_db_region dpi = {};
+	struct bnxt_re_ucontext *uctx;
+	struct ib_ucontext *ib_uctx;
+	struct bnxt_re_dev *rdev;
+	int ret;
+
+	ib_uctx = ib_uverbs_get_ucontext(attrs);
+	if (IS_ERR(ib_uctx))
+		return PTR_ERR(ib_uctx);
+
+	uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
+	rdev = uctx->rdev;
+
+	dpi.umdbr = uctx->dpi.umdbr;
+	dpi.dpi = uctx->dpi.dpi;
+
+	ret = uverbs_copy_to_struct_or_zero(attrs, BNXT_RE_DV_QUERY_DBR_ATTR,
+					    &dpi, sizeof(dpi));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_DBR_ALLOC,
+			    UVERBS_ATTR_IDR(BNXT_RE_DV_ALLOC_DBR_HANDLE,
+					    BNXT_RE_OBJECT_DBR,
+					    UVERBS_ACCESS_NEW,
+					    UA_MANDATORY),
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_DV_ALLOC_DBR_ATTR,
+						UVERBS_ATTR_STRUCT(struct bnxt_re_dv_db_region,
+								   dbr),
+								   UA_MANDATORY),
+			    UVERBS_ATTR_PTR_IN(BNXT_RE_DV_ALLOC_DBR_OFFSET,
+					       UVERBS_ATTR_TYPE(u64),
+					       UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_DBR_QUERY,
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_DV_QUERY_DBR_ATTR,
+						UVERBS_ATTR_STRUCT(struct bnxt_re_dv_db_region,
+								   dbr),
+						UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_METHOD_DESTROY(BNXT_RE_METHOD_DBR_FREE,
+				    UVERBS_ATTR_IDR(BNXT_RE_DV_FREE_DBR_HANDLE,
+						    BNXT_RE_OBJECT_DBR,
+						    UVERBS_ACCESS_DESTROY,
+						    UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_OBJECT(BNXT_RE_OBJECT_DBR,
+			    UVERBS_TYPE_ALLOC_IDR(bnxt_re_dv_dbr_cleanup),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_DBR_ALLOC),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_DBR_FREE),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_DBR_QUERY));
+
 const struct uapi_definition bnxt_re_uapi_defs[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_ALLOC_PAGE),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_NOTIFY_DRV),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_GET_TOGGLE_MEM),
+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_DBR),
+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_UMEM),
 	{}
 };
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index a11f56730a31..1ff89192a728 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -113,6 +113,7 @@ struct bnxt_re_cq {
 	int			resize_cqe;
 	void			*uctx_cq_page;
 	struct hlist_node	hash_entry;
+	struct bnxt_re_ucontext *uctx;
 };
 
 struct bnxt_re_mr {
@@ -164,6 +165,13 @@ struct bnxt_re_user_mmap_entry {
 	u8 mmap_flag;
 };
 
+struct bnxt_re_alloc_dbr_obj {
+	struct bnxt_re_dev *rdev;
+	struct bnxt_re_dv_db_region attr;
+	struct bnxt_qplib_dpi dpi;
+	struct bnxt_re_user_mmap_entry *entry;
+};
+
 struct bnxt_re_flow {
 	struct ib_flow		ib_flow;
 	struct bnxt_re_dev	*rdev;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 875d7b52c06a..30cc2d64a9ae 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -685,6 +685,49 @@ static int bnxt_qplib_alloc_pd_tbl(struct bnxt_qplib_res *res,
 }
 
 /* DPIs */
+int bnxt_qplib_alloc_uc_dpi(struct bnxt_qplib_res *res, struct bnxt_qplib_dpi *dpi)
+{
+	struct bnxt_qplib_dpi_tbl *dpit = &res->dpi_tbl;
+	struct bnxt_qplib_reg_desc *reg;
+	u32 bit_num;
+	int rc = 0;
+
+	reg = &dpit->wcreg;
+	mutex_lock(&res->dpi_tbl_lock);
+	bit_num = find_first_bit(dpit->tbl, dpit->max);
+	if (bit_num >= dpit->max) {
+		rc = -ENOMEM;
+		goto unlock;
+	}
+	/* Found unused DPI */
+	clear_bit(bit_num, dpit->tbl);
+	dpi->bit = bit_num;
+	dpi->dpi = bit_num + (reg->offset - dpit->ucreg.offset) / PAGE_SIZE;
+	dpi->umdbr = reg->bar_base + reg->offset + bit_num * PAGE_SIZE;
+unlock:
+	mutex_unlock(&res->dpi_tbl_lock);
+	return rc;
+}
+
+int bnxt_qplib_free_uc_dpi(struct bnxt_qplib_res *res, struct bnxt_qplib_dpi *dpi)
+{
+	struct bnxt_qplib_dpi_tbl *dpit = &res->dpi_tbl;
+	int rc = 0;
+
+	mutex_lock(&res->dpi_tbl_lock);
+	if (dpi->bit >= dpit->max) {
+		rc = -EINVAL;
+		goto unlock;
+	}
+
+	if (test_and_set_bit(dpi->bit, dpit->tbl))
+		rc = -EINVAL;
+	memset(dpi, 0, sizeof(*dpi));
+unlock:
+	mutex_unlock(&res->dpi_tbl_lock);
+	return rc;
+}
+
 int bnxt_qplib_alloc_dpi(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_dpi *dpi,
 			 void *app, u8 type)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index ccdab938d707..3a8162ef4c33 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -436,6 +436,10 @@ int bnxt_qplib_alloc_dpi(struct bnxt_qplib_res *res,
 			 void *app, u8 type);
 int bnxt_qplib_dealloc_dpi(struct bnxt_qplib_res *res,
 			   struct bnxt_qplib_dpi *dpi);
+int bnxt_qplib_alloc_uc_dpi(struct bnxt_qplib_res *res,
+			    struct bnxt_qplib_dpi *dpi);
+int bnxt_qplib_free_uc_dpi(struct bnxt_qplib_res *res,
+			   struct bnxt_qplib_dpi *dpi);
 void bnxt_qplib_cleanup_res(struct bnxt_qplib_res *res);
 int bnxt_qplib_init_res(struct bnxt_qplib_res *res);
 void bnxt_qplib_free_res(struct bnxt_qplib_res *res);
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index faa9d62b3b30..59a0b030de04 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -162,6 +162,8 @@ enum bnxt_re_objects {
 	BNXT_RE_OBJECT_ALLOC_PAGE = (1U << UVERBS_ID_NS_SHIFT),
 	BNXT_RE_OBJECT_NOTIFY_DRV,
 	BNXT_RE_OBJECT_GET_TOGGLE_MEM,
+	BNXT_RE_OBJECT_DBR,
+	BNXT_RE_OBJECT_UMEM,
 };
 
 enum bnxt_re_alloc_page_type {
@@ -215,4 +217,51 @@ enum bnxt_re_toggle_mem_methods {
 	BNXT_RE_METHOD_GET_TOGGLE_MEM = (1U << UVERBS_ID_NS_SHIFT),
 	BNXT_RE_METHOD_RELEASE_TOGGLE_MEM,
 };
+
+struct bnxt_re_dv_db_region {
+	__u32 dbr_handle;
+	__u32 dpi;
+	__u64 umdbr;
+	void *dbr;
+	__aligned_u64 comp_mask;
+};
+
+enum bnxt_re_obj_dbr_alloc_attrs {
+	BNXT_RE_DV_ALLOC_DBR_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+	BNXT_RE_DV_ALLOC_DBR_ATTR,
+	BNXT_RE_DV_ALLOC_DBR_OFFSET,
+};
+
+enum bnxt_re_obj_dbr_free_attrs {
+	BNXT_RE_DV_FREE_DBR_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+};
+
+enum bnxt_re_obj_dbr_query_attrs {
+	BNXT_RE_DV_QUERY_DBR_ATTR = (1U << UVERBS_ID_NS_SHIFT),
+};
+
+enum bnxt_re_obj_dpi_methods {
+	BNXT_RE_METHOD_DBR_ALLOC = (1U << UVERBS_ID_NS_SHIFT),
+	BNXT_RE_METHOD_DBR_FREE,
+	BNXT_RE_METHOD_DBR_QUERY,
+};
+
+enum bnxt_re_dv_umem_reg_attrs {
+	BNXT_RE_UMEM_OBJ_REG_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+	BNXT_RE_UMEM_OBJ_REG_ADDR,
+	BNXT_RE_UMEM_OBJ_REG_LEN,
+	BNXT_RE_UMEM_OBJ_REG_ACCESS,
+	BNXT_RE_UMEM_OBJ_REG_DMABUF_FD,
+	BNXT_RE_UMEM_OBJ_REG_PGSZ_BITMAP,
+};
+
+enum bnxt_re_dv_umem_dereg_attrs {
+	BNXT_RE_UMEM_OBJ_DEREG_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+};
+
+enum bnxt_re_dv_umem_methods {
+	BNXT_RE_METHOD_UMEM_REG = (1U << UVERBS_ID_NS_SHIFT),
+	BNXT_RE_METHOD_UMEM_DEREG,
+};
+
 #endif /* __BNXT_RE_UVERBS_ABI_H__*/
-- 
2.51.2.636.ga99f379adf


