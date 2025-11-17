Return-Path: <linux-rdma+bounces-14526-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8CFC62814
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 07:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C2BE35E795
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 06:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61588314D2E;
	Mon, 17 Nov 2025 06:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Hn2+Ylzp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468C23148A0
	for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 06:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763360709; cv=none; b=L2VkWDMjsF/o3B6EaHK2IJ23UbloFFlNmmw6uGg70COj9oXLkETc1TSh1vcshfHLaEPUoKpzc6lf1lXbhMygRd2uSakpo7+wgJvtdD2GQRL0FZJ5MXEzgpcRMMlZETLTzfe+6xa0IihiRnG7a7YqA4yhKIjuyOS+nahgHnrQWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763360709; c=relaxed/simple;
	bh=2KuAR/pWlYthA4Shp4xE7vsaIZOYzZ/bI93Y2GtPB4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQ47LHvgxtSIHG7fxqVPZAHK1v/1wirtHg9A0XBq5F25KA3bnZsUOqaF3++f5XM73qLPCicq5jGda9mGHRP75ikbkqrp4YuntVGddxvSEE5AMgaPUrqlROXMA7qCX87RRrws/KLVz+to6YeIbkfemg+iCnS8wrjQSK68sd7rXyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Hn2+Ylzp; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-882399d60baso37268816d6.0
        for <linux-rdma@vger.kernel.org>; Sun, 16 Nov 2025 22:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763360705; x=1763965505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6C/0BXHQbHnLNchIXNujI8MRptatJaFtSqqyqrnCS04=;
        b=Up6ORFFnVrozu5opQMKUPNVRbVEzdNQMTGcEkfLpwleLyAqIvFxL3r8hEYjJzIdRxm
         9JWpwQJ7PILrlZ6/KfrV/3zf3pAQdILrVdOE4UXfqLg+CMEDVIzSm4JIdA8u/fCcQdSg
         9+hYDL+Sh92HOXSVABBX6oWZ0ezWIqV1uVRHGOnMDuC7prTAGLA2wN1m7rbwqi7IsKJG
         I/Uk2nJeQImobopFTkBflIyBgTylpWiTQKvaKa1gAj8iH08VhL2JEwlNgqgzTV2rsk1J
         cG6fgCvm6m3Tlj14Zx5y26OM8TuIFyGC2rsLuTmNdePdzNdSMBiswaHIT0R8kaWTHVkQ
         vHaw==
X-Gm-Message-State: AOJu0YwqoxQ7yv1YMEdSjESEJDd9bdxwSjsIZH+cJJuu3wiZm5MyIr5v
	+Zvya3TRk2qOUOMKP99ZT1NTSh7kXvK+2rRwq9tlWE1IM8nRzH+x5WoEjDZ6v/Jm74VhGUTfdvT
	hHCgLamrpjY8Knh9iVGH7AbTrPdrBqw9SLQLhMcAoHSCOm8bjyLTEtBhqhpxcgqQph1RoIChI0i
	RHJ4Sl4J9ARLxSOtpuLaMBjFqVKObxkwPWHkazXezNKbpxwJJmgmVMG8wKpJuxQGb4tI/tScfC2
	Ziy1/+LOEYEHFcnNB9xylqwnFud
X-Gm-Gg: ASbGnct5I0R45cec5cjjzrLIcZ86Dq9JnHHwO+tJfucqjuzThtLQmWbDHEfK8TIFCit
	TPBgv/mDrpjXQGJu1x0PwEXIoJeUzUXghNkKVOh+DlxKFgNmB7o2UOczM7cwkfF2ZVHG0j8EylI
	+kcCOIjkyEPa7FKebQoiF7SgBocHMMmjkDaXSFfNj/WC00tpUcRLdIhAQEFOU1H3qrbrgbp7nnk
	yW7g8eKqgmUiSXIfuRI5RE1Uuoz2KCq7jUHw5NEWkYyiwcqHzeVVmpZVJjZP3CsGJ/f2Wbef1Y2
	U064q3xaGgLpMbU6Q5KxlX9/fuN081Ndwmfme5MnSBhIFK23XbkdTblY2lMiTDOUdwkmBnYkKgY
	h7IG11LxqBRxuQHOcrYPLEpRpidCNkaszGTGXSAN0OzYAcnu5qp+T19I4d5ZJfU28ofrXmI1Kzf
	ovm9LlBdYMcKzHCVpLF3vU6bvxrjfVPXMMcB/PjdA0UuJBQqeAdTFM0KFB
X-Google-Smtp-Source: AGHT+IEmSDOefm9qdsIOh+qiZTkKkhxhyFwZEDH8/86fmF46MM43FEtNB/bEU8LtYFSUWbr+M7kjGsFUZhj1
X-Received: by 2002:a05:6214:f6a:b0:87d:9d5a:b092 with SMTP id 6a1803df08f44-88292658c42mr155379486d6.32.1763360704996;
        Sun, 16 Nov 2025 22:25:04 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-882862f836fsm15206046d6.10.2025.11.16.22.25.04
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Nov 2025 22:25:04 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-343daf0f488so5019833a91.1
        for <linux-rdma@vger.kernel.org>; Sun, 16 Nov 2025 22:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763360704; x=1763965504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6C/0BXHQbHnLNchIXNujI8MRptatJaFtSqqyqrnCS04=;
        b=Hn2+Ylzp8nZQaB0gbXzwqNyOQBxdOiBRocG514DXQvjhWqtGvAYwZuZBaW+rE+B6dJ
         5vKWP1mzumGj2qi9CtK3RobYg+HBZpUYjZvWTWRIShtyRe/0jgtrcbWaz7iyYml+rMQE
         r/rTaVAw3+azYXMDbNpXUTGN54PvfmbUw7JTU=
X-Received: by 2002:a17:90b:1b4d:b0:32e:c6b6:956b with SMTP id 98e67ed59e1d1-343f9d907bbmr13484875a91.4.1763360703610;
        Sun, 16 Nov 2025 22:25:03 -0800 (PST)
X-Received: by 2002:a17:90b:1b4d:b0:32e:c6b6:956b with SMTP id 98e67ed59e1d1-343f9d907bbmr13484845a91.4.1763360703016;
        Sun, 16 Nov 2025 22:25:03 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927151d38sm11897785b3a.40.2025.11.16.22.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 22:25:02 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v4 4/5] RDMA/bnxt_re: Direct Verbs: Support DBR and UMEM verbs
Date: Mon, 17 Nov 2025 11:47:40 +0530
Message-ID: <20251117061741.15752-5-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20251117061741.15752-1-sriharsha.basavapatna@broadcom.com>
References: <20251117061741.15752-1-sriharsha.basavapatna@broadcom.com>
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
Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/dv.c        | 252 ++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |   8 +
 drivers/infiniband/hw/bnxt_re/qplib_res.c |  43 ++++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |   4 +
 include/uapi/rdma/bnxt_re-abi.h           |  49 +++++
 5 files changed, 356 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/dv.c b/drivers/infiniband/hw/bnxt_re/dv.c
index 5655c6176af4..1485aa0a6818 100644
--- a/drivers/infiniband/hw/bnxt_re/dv.c
+++ b/drivers/infiniband/hw/bnxt_re/dv.c
@@ -12,6 +12,7 @@
 #include <rdma/ib_user_ioctl_cmds.h>
 #define UVERBS_MODULE_NAME bnxt_re
 #include <rdma/uverbs_named_ioctl.h>
+#include <rdma/ib_umem.h>
 #include <rdma/bnxt_re-abi.h>
 
 #include "roce_hsi.h"
@@ -22,6 +23,15 @@
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
@@ -331,9 +341,251 @@ DECLARE_UVERBS_NAMED_OBJECT(BNXT_RE_OBJECT_GET_TOGGLE_MEM,
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
+	int ret;
+
+	ib_uctx = ib_uverbs_get_ucontext(attrs);
+	if (IS_ERR(ib_uctx))
+		return PTR_ERR(ib_uctx);
+
+	uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
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


