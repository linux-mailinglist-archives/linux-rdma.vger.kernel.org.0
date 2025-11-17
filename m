Return-Path: <linux-rdma+bounces-14524-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E215C6280E
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 07:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F63E3A9913
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 06:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F5F313E16;
	Mon, 17 Nov 2025 06:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G3pFSa3q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6028F314D04
	for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 06:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763360702; cv=none; b=DHZ8WfYY49n/Ic0AFS52jQTu8Y70WhgFEsGYeT0zFZpC702eTLCJPW23QdYp5Dzk+SBgE9oPmy0MbOpff1dCJlXjTon/0MQZRkfd8HU1FfcEZyUWkpEPNCBRbMsmL2w9Kx2BcHT7TLl+0jDgTX1rHSmsaRfjYfaiHsNB4x4cCo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763360702; c=relaxed/simple;
	bh=yJgyfnrW5har6Za1WQPN142d8KqQ6E5rt3aeiw4A+5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+gRRUHlQzD2USv1gR4FO2IjwUyDuaqfztgn228IKysaTtYMjs4dXmxBpLsSpqqbBg42KDvFHIU9G/XU+CMLbSzSbhjfYmtC1AARmg8xiGMno2l0+vlndNDzPOOdelluECqCdjbLMuNJPS6WSHdcVPk55ouCkjcYJQPwIyEWjbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G3pFSa3q; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2953ad5517dso43295875ad.0
        for <linux-rdma@vger.kernel.org>; Sun, 16 Nov 2025 22:25:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763360700; x=1763965500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0QrH5hMLXxXsCq/5NqyoFkbOw3RVm/0AhdGQGhzYTM=;
        b=gq5Ua31jNwc5OouSqPK3uoxkwnHARkH9ya6a9oaHRU6WICcb7CEq1OYKwpzwQ5J13P
         PECerWNK7JvPPzeioYYOOo4sWK2yUSZXE74ZOIZzEh3qP1ttPSJFI5C0WNMFi4owAsm2
         W0Ps23PlGwt5bXC98jgzgF0yCVKJmEvKfxiguKiyhV5dEMmAJLUBEMKWkZDfhbsdFdD3
         PxIvuSijMEDJpb7MOznMPDu4dne0JV03gtf3XMBShOXeNX+xvaiVcAajeRPfpN1sFPE9
         qHn7XgoTGHZ1mMnC7kryiqAgtz7o6WAUKycliodmX4q4s/VIGLyn0vFH+J22Md/1LNcI
         lMZg==
X-Gm-Message-State: AOJu0YxYClgdbZnmkdcAA32osF6udpNJk/RiKmbnkZcZHh1Rgm1BYZ8z
	yUC07X9ecXMG7BTOCs2e1J3hbROD6nVp5uZFivYAVtUJkgYZMTbD5V7XSsEEDYkVfC9Pd8joVTP
	vW361R4R8nop/Y1AbOP4e/SxxvYOahyCgDfYMZsnDpm1q3ddxEc728vOJHeqSy3yoJKwlPWfFTD
	6/BhQkqaOpAJwEWbCEtW/AtiePmsdnrPawbRz+NHT5bHcia7v9ciVq5hUIqdF2gE+8ER1AEhrKH
	WqriLot3+gqbeo8eqikaRxZqBtl
X-Gm-Gg: ASbGncslA9cNHCgjIUWBk1930oVTISjdmpH4ihIN2iufQ5oeuuvQMcH8tHykHcf8psI
	hdHg9LADPWA9VUB6ptQStC9C/mzRg4HiZ1jjyFfWhAy0ygkypjoLmLG8ApBFaEFSCDX3JcI/UuH
	gKk2wBq6mYXfdJyzikipqc+QogfAg2MiMN8NqPZrmXLODfDTeMdBletL154ncu/C/SJerSsq7gZ
	BKl3K2IGON7TSYgWFk9gDoLl58+0C46/9U/Icy11gZzEVUpHqT8dW4aSIiugOt1gX9jmQuN1BFn
	XPqPDHf9hSZtoEnA192SrReFT1QewCD0X53nHt1MmkYKrti8vvv6fXs8A6PtiZ7js71Iki55uYW
	h/el3B9zdpW0IJyJq9usV/JhOt4G5GtDGR+hHreVHJQw9jDCfi4jo7JEw/Bo9OP5NzXYVWvKjEl
	ALdn08T0pk5Jri+9FiAILHqJaaONVMb4LioxHuc2LVyb5BlMYuhIF2nrNd
X-Google-Smtp-Source: AGHT+IEFmQxk2VSYAu05jeYT3ZjtbhCwKy6cn5K8LQ0TKEn/N9X97x9rD18sR67JbGIwUKamei7NPkKs5JQJ
X-Received: by 2002:a17:903:3d05:b0:296:4d61:6cd3 with SMTP id d9443c01a7336-2986a752581mr140126145ad.40.1763360699695;
        Sun, 16 Nov 2025 22:24:59 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29861b38139sm12547445ad.44.2025.11.16.22.24.59
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Nov 2025 22:24:59 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7aa148105a2so3358588b3a.1
        for <linux-rdma@vger.kernel.org>; Sun, 16 Nov 2025 22:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763360697; x=1763965497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0QrH5hMLXxXsCq/5NqyoFkbOw3RVm/0AhdGQGhzYTM=;
        b=G3pFSa3q6yeCCuqR8fw9p8wAiNScx2T7aGhzxUKmXuKt64Riz361K0h+PRCmGCzqzt
         KpPvYcIbze02MA/7YlTjj904Lifg2fC1QCKmsmUlERYA9A54F4oRNTH1s2dIB/7ikeLV
         zsiYu3gST14AeIQ8kOG45imFc5wva5SfHiD1A=
X-Received: by 2002:a05:6a00:3e1b:b0:7b8:9da6:146c with SMTP id d2e1a72fcca58-7ba39b60adamr12299160b3a.4.1763360697443;
        Sun, 16 Nov 2025 22:24:57 -0800 (PST)
X-Received: by 2002:a05:6a00:3e1b:b0:7b8:9da6:146c with SMTP id d2e1a72fcca58-7ba39b60adamr12299140b3a.4.1763360696947;
        Sun, 16 Nov 2025 22:24:56 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927151d38sm11897785b3a.40.2025.11.16.22.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 22:24:56 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v4 2/5] RDMA/bnxt_re: Move the UAPI methods to a dedicated file
Date: Mon, 17 Nov 2025 11:47:38 +0530
Message-ID: <20251117061741.15752-3-sriharsha.basavapatna@broadcom.com>
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

This is in preparation for upcoming patches in the series.
Driver has to support additional UAPIs for Direct verbs.
Moving current UAPI implementation to a new file, dv.c.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/Makefile   |   2 +-
 drivers/infiniband/hw/bnxt_re/dv.c       | 339 +++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 305 +-------------------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |   3 +
 4 files changed, 344 insertions(+), 305 deletions(-)
 create mode 100644 drivers/infiniband/hw/bnxt_re/dv.c

diff --git a/drivers/infiniband/hw/bnxt_re/Makefile b/drivers/infiniband/hw/bnxt_re/Makefile
index f63417d2ccc6..b82d12df6269 100644
--- a/drivers/infiniband/hw/bnxt_re/Makefile
+++ b/drivers/infiniband/hw/bnxt_re/Makefile
@@ -5,4 +5,4 @@ obj-$(CONFIG_INFINIBAND_BNXT_RE) += bnxt_re.o
 bnxt_re-y := main.o ib_verbs.o \
 	     qplib_res.o qplib_rcfw.o	\
 	     qplib_sp.o qplib_fp.o  hw_counters.o	\
-	     debugfs.o
+	     debugfs.o dv.o
diff --git a/drivers/infiniband/hw/bnxt_re/dv.c b/drivers/infiniband/hw/bnxt_re/dv.c
new file mode 100644
index 000000000000..5655c6176af4
--- /dev/null
+++ b/drivers/infiniband/hw/bnxt_re/dv.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * Copyright (c) 2025, Broadcom. All rights reserved.  The term
+ * Broadcom refers to Broadcom Limited and/or its subsidiaries.
+ *
+ * Description: Direct Verbs interpreter
+ */
+
+#include <rdma/ib_addr.h>
+#include <rdma/uverbs_types.h>
+#include <rdma/uverbs_std_types.h>
+#include <rdma/ib_user_ioctl_cmds.h>
+#define UVERBS_MODULE_NAME bnxt_re
+#include <rdma/uverbs_named_ioctl.h>
+#include <rdma/bnxt_re-abi.h>
+
+#include "roce_hsi.h"
+#include "qplib_res.h"
+#include "qplib_sp.h"
+#include "qplib_fp.h"
+#include "qplib_rcfw.h"
+#include "bnxt_re.h"
+#include "ib_verbs.h"
+
+static struct bnxt_re_cq *bnxt_re_search_for_cq(struct bnxt_re_dev *rdev, u32 cq_id)
+{
+	struct bnxt_re_cq *cq = NULL, *tmp_cq;
+
+	hash_for_each_possible(rdev->cq_hash, tmp_cq, hash_entry, cq_id) {
+		if (tmp_cq->qplib_cq.id == cq_id) {
+			cq = tmp_cq;
+			break;
+		}
+	}
+	return cq;
+}
+
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
+static int UVERBS_HANDLER(BNXT_RE_METHOD_NOTIFY_DRV)(struct uverbs_attr_bundle *attrs)
+{
+	struct bnxt_re_ucontext *uctx;
+	struct ib_ucontext *ib_uctx;
+
+	ib_uctx = ib_uverbs_get_ucontext(attrs);
+	if (IS_ERR(ib_uctx))
+		return PTR_ERR(ib_uctx);
+
+	uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
+	if (IS_ERR(uctx))
+		return PTR_ERR(uctx);
+
+	bnxt_re_pacing_alert(uctx->rdev);
+	return 0;
+}
+
+static int UVERBS_HANDLER(BNXT_RE_METHOD_ALLOC_PAGE)(struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uobject *uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_ALLOC_PAGE_HANDLE);
+	enum bnxt_re_alloc_page_type alloc_type;
+	struct bnxt_re_user_mmap_entry *entry;
+	enum bnxt_re_mmap_flag mmap_flag;
+	struct bnxt_qplib_chip_ctx *cctx;
+	struct bnxt_re_ucontext *uctx;
+	struct ib_ucontext *ib_uctx;
+	struct bnxt_re_dev *rdev;
+	u64 mmap_offset;
+	u32 length;
+	u32 dpi;
+	u64 addr;
+	int err;
+
+	ib_uctx = ib_uverbs_get_ucontext(attrs);
+	if (IS_ERR(ib_uctx))
+		return PTR_ERR(ib_uctx);
+
+	uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
+	if (IS_ERR(uctx))
+		return PTR_ERR(uctx);
+
+	err = uverbs_get_const(&alloc_type, attrs, BNXT_RE_ALLOC_PAGE_TYPE);
+	if (err)
+		return err;
+
+	rdev = uctx->rdev;
+	cctx = rdev->chip_ctx;
+
+	switch (alloc_type) {
+	case BNXT_RE_ALLOC_WC_PAGE:
+		if (cctx->modes.db_push)  {
+			if (bnxt_qplib_alloc_dpi(&rdev->qplib_res, &uctx->wcdpi,
+						 uctx, BNXT_QPLIB_DPI_TYPE_WC))
+				return -ENOMEM;
+			length = PAGE_SIZE;
+			dpi = uctx->wcdpi.dpi;
+			addr = (u64)uctx->wcdpi.umdbr;
+			mmap_flag = BNXT_RE_MMAP_WC_DB;
+		} else {
+			return -EINVAL;
+		}
+
+		break;
+	case BNXT_RE_ALLOC_DBR_BAR_PAGE:
+		length = PAGE_SIZE;
+		addr = (u64)rdev->pacing.dbr_bar_addr;
+		mmap_flag = BNXT_RE_MMAP_DBR_BAR;
+		break;
+
+	case BNXT_RE_ALLOC_DBR_PAGE:
+		length = PAGE_SIZE;
+		addr = (u64)rdev->pacing.dbr_page;
+		mmap_flag = BNXT_RE_MMAP_DBR_PAGE;
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	entry = bnxt_re_mmap_entry_insert(uctx, addr, mmap_flag, &mmap_offset);
+	if (!entry)
+		return -ENOMEM;
+
+	uobj->object = entry;
+	uverbs_finalize_uobj_create(attrs, BNXT_RE_ALLOC_PAGE_HANDLE);
+	err = uverbs_copy_to(attrs, BNXT_RE_ALLOC_PAGE_MMAP_OFFSET,
+			     &mmap_offset, sizeof(mmap_offset));
+	if (err)
+		return err;
+
+	err = uverbs_copy_to(attrs, BNXT_RE_ALLOC_PAGE_MMAP_LENGTH,
+			     &length, sizeof(length));
+	if (err)
+		return err;
+
+	err = uverbs_copy_to(attrs, BNXT_RE_ALLOC_PAGE_DPI,
+			     &dpi, sizeof(dpi));
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int alloc_page_obj_cleanup(struct ib_uobject *uobject,
+				  enum rdma_remove_reason why,
+			    struct uverbs_attr_bundle *attrs)
+{
+	struct  bnxt_re_user_mmap_entry *entry = uobject->object;
+	struct bnxt_re_ucontext *uctx = entry->uctx;
+
+	switch (entry->mmap_flag) {
+	case BNXT_RE_MMAP_WC_DB:
+		if (uctx && uctx->wcdpi.dbr) {
+			struct bnxt_re_dev *rdev = uctx->rdev;
+
+			bnxt_qplib_dealloc_dpi(&rdev->qplib_res, &uctx->wcdpi);
+			uctx->wcdpi.dbr = NULL;
+		}
+		break;
+	case BNXT_RE_MMAP_DBR_BAR:
+	case BNXT_RE_MMAP_DBR_PAGE:
+		break;
+	default:
+		goto exit;
+	}
+	rdma_user_mmap_entry_remove(&entry->rdma_entry);
+exit:
+	return 0;
+}
+
+DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_ALLOC_PAGE,
+			    UVERBS_ATTR_IDR(BNXT_RE_ALLOC_PAGE_HANDLE,
+					    BNXT_RE_OBJECT_ALLOC_PAGE,
+					    UVERBS_ACCESS_NEW,
+					    UA_MANDATORY),
+			    UVERBS_ATTR_CONST_IN(BNXT_RE_ALLOC_PAGE_TYPE,
+						 enum bnxt_re_alloc_page_type,
+						 UA_MANDATORY),
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_ALLOC_PAGE_MMAP_OFFSET,
+						UVERBS_ATTR_TYPE(u64),
+						UA_MANDATORY),
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_ALLOC_PAGE_MMAP_LENGTH,
+						UVERBS_ATTR_TYPE(u32),
+						UA_MANDATORY),
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_ALLOC_PAGE_DPI,
+						UVERBS_ATTR_TYPE(u32),
+						UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_METHOD_DESTROY(BNXT_RE_METHOD_DESTROY_PAGE,
+				    UVERBS_ATTR_IDR(BNXT_RE_DESTROY_PAGE_HANDLE,
+						    BNXT_RE_OBJECT_ALLOC_PAGE,
+						    UVERBS_ACCESS_DESTROY,
+						    UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_OBJECT(BNXT_RE_OBJECT_ALLOC_PAGE,
+			    UVERBS_TYPE_ALLOC_IDR(alloc_page_obj_cleanup),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_ALLOC_PAGE),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_DESTROY_PAGE));
+
+DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_NOTIFY_DRV);
+
+DECLARE_UVERBS_GLOBAL_METHODS(BNXT_RE_OBJECT_NOTIFY_DRV,
+			      &UVERBS_METHOD(BNXT_RE_METHOD_NOTIFY_DRV));
+
+/* Toggle MEM */
+static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uobject *uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_TOGGLE_MEM_HANDLE);
+	enum bnxt_re_mmap_flag mmap_flag = BNXT_RE_MMAP_TOGGLE_PAGE;
+	enum bnxt_re_get_toggle_mem_type res_type;
+	struct bnxt_re_user_mmap_entry *entry;
+	struct bnxt_re_ucontext *uctx;
+	struct ib_ucontext *ib_uctx;
+	struct bnxt_re_dev *rdev;
+	struct bnxt_re_srq *srq;
+	u32 length = PAGE_SIZE;
+	struct bnxt_re_cq *cq;
+	u64 mem_offset;
+	u32 offset = 0;
+	u64 addr = 0;
+	u32 res_id;
+	int err;
+
+	ib_uctx = ib_uverbs_get_ucontext(attrs);
+	if (IS_ERR(ib_uctx))
+		return PTR_ERR(ib_uctx);
+
+	err = uverbs_get_const(&res_type, attrs, BNXT_RE_TOGGLE_MEM_TYPE);
+	if (err)
+		return err;
+
+	uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
+	rdev = uctx->rdev;
+	err = uverbs_copy_from(&res_id, attrs, BNXT_RE_TOGGLE_MEM_RES_ID);
+	if (err)
+		return err;
+
+	switch (res_type) {
+	case BNXT_RE_CQ_TOGGLE_MEM:
+		cq = bnxt_re_search_for_cq(rdev, res_id);
+		if (!cq)
+			return -EINVAL;
+
+		addr = (u64)cq->uctx_cq_page;
+		break;
+	case BNXT_RE_SRQ_TOGGLE_MEM:
+		srq = bnxt_re_search_for_srq(rdev, res_id);
+		if (!srq)
+			return -EINVAL;
+
+		addr = (u64)srq->uctx_srq_page;
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	entry = bnxt_re_mmap_entry_insert(uctx, addr, mmap_flag, &mem_offset);
+	if (!entry)
+		return -ENOMEM;
+
+	uobj->object = entry;
+	uverbs_finalize_uobj_create(attrs, BNXT_RE_TOGGLE_MEM_HANDLE);
+	err = uverbs_copy_to(attrs, BNXT_RE_TOGGLE_MEM_MMAP_PAGE,
+			     &mem_offset, sizeof(mem_offset));
+	if (err)
+		return err;
+
+	err = uverbs_copy_to(attrs, BNXT_RE_TOGGLE_MEM_MMAP_LENGTH,
+			     &length, sizeof(length));
+	if (err)
+		return err;
+
+	err = uverbs_copy_to(attrs, BNXT_RE_TOGGLE_MEM_MMAP_OFFSET,
+			     &offset, sizeof(offset));
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int get_toggle_mem_obj_cleanup(struct ib_uobject *uobject,
+				      enum rdma_remove_reason why,
+				      struct uverbs_attr_bundle *attrs)
+{
+	struct  bnxt_re_user_mmap_entry *entry = uobject->object;
+
+	rdma_user_mmap_entry_remove(&entry->rdma_entry);
+	return 0;
+}
+
+DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_GET_TOGGLE_MEM,
+			    UVERBS_ATTR_IDR(BNXT_RE_TOGGLE_MEM_HANDLE,
+					    BNXT_RE_OBJECT_GET_TOGGLE_MEM,
+					    UVERBS_ACCESS_NEW,
+					    UA_MANDATORY),
+			    UVERBS_ATTR_CONST_IN(BNXT_RE_TOGGLE_MEM_TYPE,
+						 enum bnxt_re_get_toggle_mem_type,
+						 UA_MANDATORY),
+			    UVERBS_ATTR_PTR_IN(BNXT_RE_TOGGLE_MEM_RES_ID,
+					       UVERBS_ATTR_TYPE(u32),
+					       UA_MANDATORY),
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_TOGGLE_MEM_MMAP_PAGE,
+						UVERBS_ATTR_TYPE(u64),
+						UA_MANDATORY),
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_TOGGLE_MEM_MMAP_OFFSET,
+						UVERBS_ATTR_TYPE(u32),
+						UA_MANDATORY),
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_TOGGLE_MEM_MMAP_LENGTH,
+						UVERBS_ATTR_TYPE(u32),
+						UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_METHOD_DESTROY(BNXT_RE_METHOD_RELEASE_TOGGLE_MEM,
+				    UVERBS_ATTR_IDR(BNXT_RE_RELEASE_TOGGLE_MEM_HANDLE,
+						    BNXT_RE_OBJECT_GET_TOGGLE_MEM,
+						    UVERBS_ACCESS_DESTROY,
+						    UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_OBJECT(BNXT_RE_OBJECT_GET_TOGGLE_MEM,
+			    UVERBS_TYPE_ALLOC_IDR(get_toggle_mem_obj_cleanup),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_GET_TOGGLE_MEM),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_RELEASE_TOGGLE_MEM));
+
+const struct uapi_definition bnxt_re_uapi_defs[] = {
+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_ALLOC_PAGE),
+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_NOTIFY_DRV),
+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_GET_TOGGLE_MEM),
+	{}
+};
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 4dab5ca7362b..034f5744127f 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -626,7 +626,7 @@ static int bnxt_re_create_fence_mr(struct bnxt_re_pd *pd)
 	return rc;
 }
 
-static struct bnxt_re_user_mmap_entry*
+struct bnxt_re_user_mmap_entry*
 bnxt_re_mmap_entry_insert(struct bnxt_re_ucontext *uctx, u64 mem_offset,
 			  enum bnxt_re_mmap_flag mmap_flag, u64 *offset)
 {
@@ -4534,32 +4534,6 @@ int bnxt_re_destroy_flow(struct ib_flow *flow_id)
 	return rc;
 }
 
-static struct bnxt_re_cq *bnxt_re_search_for_cq(struct bnxt_re_dev *rdev, u32 cq_id)
-{
-	struct bnxt_re_cq *cq = NULL, *tmp_cq;
-
-	hash_for_each_possible(rdev->cq_hash, tmp_cq, hash_entry, cq_id) {
-		if (tmp_cq->qplib_cq.id == cq_id) {
-			cq = tmp_cq;
-			break;
-		}
-	}
-	return cq;
-}
-
-static struct bnxt_re_srq *bnxt_re_search_for_srq(struct bnxt_re_dev *rdev, u32 srq_id)
-{
-	struct bnxt_re_srq *srq = NULL, *tmp_srq;
-
-	hash_for_each_possible(rdev->srq_hash, tmp_srq, hash_entry, srq_id) {
-		if (tmp_srq->qplib_srq.id == srq_id) {
-			srq = tmp_srq;
-			break;
-		}
-	}
-	return srq;
-}
-
 /* Helper function to mmap the virtual memory from user app */
 int bnxt_re_mmap(struct ib_ucontext *ib_uctx, struct vm_area_struct *vma)
 {
@@ -4662,280 +4636,3 @@ int bnxt_re_process_mad(struct ib_device *ibdev, int mad_flags,
 	ret |= IB_MAD_RESULT_REPLY;
 	return ret;
 }
-
-static int UVERBS_HANDLER(BNXT_RE_METHOD_NOTIFY_DRV)(struct uverbs_attr_bundle *attrs)
-{
-	struct bnxt_re_ucontext *uctx;
-
-	uctx = container_of(ib_uverbs_get_ucontext(attrs), struct bnxt_re_ucontext, ib_uctx);
-	bnxt_re_pacing_alert(uctx->rdev);
-	return 0;
-}
-
-static int UVERBS_HANDLER(BNXT_RE_METHOD_ALLOC_PAGE)(struct uverbs_attr_bundle *attrs)
-{
-	struct ib_uobject *uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_ALLOC_PAGE_HANDLE);
-	enum bnxt_re_alloc_page_type alloc_type;
-	struct bnxt_re_user_mmap_entry *entry;
-	enum bnxt_re_mmap_flag mmap_flag;
-	struct bnxt_qplib_chip_ctx *cctx;
-	struct bnxt_re_ucontext *uctx;
-	struct bnxt_re_dev *rdev;
-	u64 mmap_offset;
-	u32 length;
-	u32 dpi;
-	u64 addr;
-	int err;
-
-	uctx = container_of(ib_uverbs_get_ucontext(attrs), struct bnxt_re_ucontext, ib_uctx);
-	if (IS_ERR(uctx))
-		return PTR_ERR(uctx);
-
-	err = uverbs_get_const(&alloc_type, attrs, BNXT_RE_ALLOC_PAGE_TYPE);
-	if (err)
-		return err;
-
-	rdev = uctx->rdev;
-	cctx = rdev->chip_ctx;
-
-	switch (alloc_type) {
-	case BNXT_RE_ALLOC_WC_PAGE:
-		if (cctx->modes.db_push)  {
-			if (bnxt_qplib_alloc_dpi(&rdev->qplib_res, &uctx->wcdpi,
-						 uctx, BNXT_QPLIB_DPI_TYPE_WC))
-				return -ENOMEM;
-			length = PAGE_SIZE;
-			dpi = uctx->wcdpi.dpi;
-			addr = (u64)uctx->wcdpi.umdbr;
-			mmap_flag = BNXT_RE_MMAP_WC_DB;
-		} else {
-			return -EINVAL;
-		}
-
-		break;
-	case BNXT_RE_ALLOC_DBR_BAR_PAGE:
-		length = PAGE_SIZE;
-		addr = (u64)rdev->pacing.dbr_bar_addr;
-		mmap_flag = BNXT_RE_MMAP_DBR_BAR;
-		break;
-
-	case BNXT_RE_ALLOC_DBR_PAGE:
-		length = PAGE_SIZE;
-		addr = (u64)rdev->pacing.dbr_page;
-		mmap_flag = BNXT_RE_MMAP_DBR_PAGE;
-		break;
-
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	entry = bnxt_re_mmap_entry_insert(uctx, addr, mmap_flag, &mmap_offset);
-	if (!entry)
-		return -ENOMEM;
-
-	uobj->object = entry;
-	uverbs_finalize_uobj_create(attrs, BNXT_RE_ALLOC_PAGE_HANDLE);
-	err = uverbs_copy_to(attrs, BNXT_RE_ALLOC_PAGE_MMAP_OFFSET,
-			     &mmap_offset, sizeof(mmap_offset));
-	if (err)
-		return err;
-
-	err = uverbs_copy_to(attrs, BNXT_RE_ALLOC_PAGE_MMAP_LENGTH,
-			     &length, sizeof(length));
-	if (err)
-		return err;
-
-	err = uverbs_copy_to(attrs, BNXT_RE_ALLOC_PAGE_DPI,
-			     &dpi, sizeof(dpi));
-	if (err)
-		return err;
-
-	return 0;
-}
-
-static int alloc_page_obj_cleanup(struct ib_uobject *uobject,
-				  enum rdma_remove_reason why,
-			    struct uverbs_attr_bundle *attrs)
-{
-	struct  bnxt_re_user_mmap_entry *entry = uobject->object;
-	struct bnxt_re_ucontext *uctx = entry->uctx;
-
-	switch (entry->mmap_flag) {
-	case BNXT_RE_MMAP_WC_DB:
-		if (uctx && uctx->wcdpi.dbr) {
-			struct bnxt_re_dev *rdev = uctx->rdev;
-
-			bnxt_qplib_dealloc_dpi(&rdev->qplib_res, &uctx->wcdpi);
-			uctx->wcdpi.dbr = NULL;
-		}
-		break;
-	case BNXT_RE_MMAP_DBR_BAR:
-	case BNXT_RE_MMAP_DBR_PAGE:
-		break;
-	default:
-		goto exit;
-	}
-	rdma_user_mmap_entry_remove(&entry->rdma_entry);
-exit:
-	return 0;
-}
-
-DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_ALLOC_PAGE,
-			    UVERBS_ATTR_IDR(BNXT_RE_ALLOC_PAGE_HANDLE,
-					    BNXT_RE_OBJECT_ALLOC_PAGE,
-					    UVERBS_ACCESS_NEW,
-					    UA_MANDATORY),
-			    UVERBS_ATTR_CONST_IN(BNXT_RE_ALLOC_PAGE_TYPE,
-						 enum bnxt_re_alloc_page_type,
-						 UA_MANDATORY),
-			    UVERBS_ATTR_PTR_OUT(BNXT_RE_ALLOC_PAGE_MMAP_OFFSET,
-						UVERBS_ATTR_TYPE(u64),
-						UA_MANDATORY),
-			    UVERBS_ATTR_PTR_OUT(BNXT_RE_ALLOC_PAGE_MMAP_LENGTH,
-						UVERBS_ATTR_TYPE(u32),
-						UA_MANDATORY),
-			    UVERBS_ATTR_PTR_OUT(BNXT_RE_ALLOC_PAGE_DPI,
-						UVERBS_ATTR_TYPE(u32),
-						UA_MANDATORY));
-
-DECLARE_UVERBS_NAMED_METHOD_DESTROY(BNXT_RE_METHOD_DESTROY_PAGE,
-				    UVERBS_ATTR_IDR(BNXT_RE_DESTROY_PAGE_HANDLE,
-						    BNXT_RE_OBJECT_ALLOC_PAGE,
-						    UVERBS_ACCESS_DESTROY,
-						    UA_MANDATORY));
-
-DECLARE_UVERBS_NAMED_OBJECT(BNXT_RE_OBJECT_ALLOC_PAGE,
-			    UVERBS_TYPE_ALLOC_IDR(alloc_page_obj_cleanup),
-			    &UVERBS_METHOD(BNXT_RE_METHOD_ALLOC_PAGE),
-			    &UVERBS_METHOD(BNXT_RE_METHOD_DESTROY_PAGE));
-
-DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_NOTIFY_DRV);
-
-DECLARE_UVERBS_GLOBAL_METHODS(BNXT_RE_OBJECT_NOTIFY_DRV,
-			      &UVERBS_METHOD(BNXT_RE_METHOD_NOTIFY_DRV));
-
-/* Toggle MEM */
-static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bundle *attrs)
-{
-	struct ib_uobject *uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_TOGGLE_MEM_HANDLE);
-	enum bnxt_re_mmap_flag mmap_flag = BNXT_RE_MMAP_TOGGLE_PAGE;
-	enum bnxt_re_get_toggle_mem_type res_type;
-	struct bnxt_re_user_mmap_entry *entry;
-	struct bnxt_re_ucontext *uctx;
-	struct ib_ucontext *ib_uctx;
-	struct bnxt_re_dev *rdev;
-	struct bnxt_re_srq *srq;
-	u32 length = PAGE_SIZE;
-	struct bnxt_re_cq *cq;
-	u64 mem_offset;
-	u32 offset = 0;
-	u64 addr = 0;
-	u32 res_id;
-	int err;
-
-	ib_uctx = ib_uverbs_get_ucontext(attrs);
-	if (IS_ERR(ib_uctx))
-		return PTR_ERR(ib_uctx);
-
-	err = uverbs_get_const(&res_type, attrs, BNXT_RE_TOGGLE_MEM_TYPE);
-	if (err)
-		return err;
-
-	uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
-	rdev = uctx->rdev;
-	err = uverbs_copy_from(&res_id, attrs, BNXT_RE_TOGGLE_MEM_RES_ID);
-	if (err)
-		return err;
-
-	switch (res_type) {
-	case BNXT_RE_CQ_TOGGLE_MEM:
-		cq = bnxt_re_search_for_cq(rdev, res_id);
-		if (!cq)
-			return -EINVAL;
-
-		addr = (u64)cq->uctx_cq_page;
-		break;
-	case BNXT_RE_SRQ_TOGGLE_MEM:
-		srq = bnxt_re_search_for_srq(rdev, res_id);
-		if (!srq)
-			return -EINVAL;
-
-		addr = (u64)srq->uctx_srq_page;
-		break;
-
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	entry = bnxt_re_mmap_entry_insert(uctx, addr, mmap_flag, &mem_offset);
-	if (!entry)
-		return -ENOMEM;
-
-	uobj->object = entry;
-	uverbs_finalize_uobj_create(attrs, BNXT_RE_TOGGLE_MEM_HANDLE);
-	err = uverbs_copy_to(attrs, BNXT_RE_TOGGLE_MEM_MMAP_PAGE,
-			     &mem_offset, sizeof(mem_offset));
-	if (err)
-		return err;
-
-	err = uverbs_copy_to(attrs, BNXT_RE_TOGGLE_MEM_MMAP_LENGTH,
-			     &length, sizeof(length));
-	if (err)
-		return err;
-
-	err = uverbs_copy_to(attrs, BNXT_RE_TOGGLE_MEM_MMAP_OFFSET,
-			     &offset, sizeof(offset));
-	if (err)
-		return err;
-
-	return 0;
-}
-
-static int get_toggle_mem_obj_cleanup(struct ib_uobject *uobject,
-				      enum rdma_remove_reason why,
-				      struct uverbs_attr_bundle *attrs)
-{
-	struct  bnxt_re_user_mmap_entry *entry = uobject->object;
-
-	rdma_user_mmap_entry_remove(&entry->rdma_entry);
-	return 0;
-}
-
-DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_GET_TOGGLE_MEM,
-			    UVERBS_ATTR_IDR(BNXT_RE_TOGGLE_MEM_HANDLE,
-					    BNXT_RE_OBJECT_GET_TOGGLE_MEM,
-					    UVERBS_ACCESS_NEW,
-					    UA_MANDATORY),
-			    UVERBS_ATTR_CONST_IN(BNXT_RE_TOGGLE_MEM_TYPE,
-						 enum bnxt_re_get_toggle_mem_type,
-						 UA_MANDATORY),
-			    UVERBS_ATTR_PTR_IN(BNXT_RE_TOGGLE_MEM_RES_ID,
-					       UVERBS_ATTR_TYPE(u32),
-					       UA_MANDATORY),
-			    UVERBS_ATTR_PTR_OUT(BNXT_RE_TOGGLE_MEM_MMAP_PAGE,
-						UVERBS_ATTR_TYPE(u64),
-						UA_MANDATORY),
-			    UVERBS_ATTR_PTR_OUT(BNXT_RE_TOGGLE_MEM_MMAP_OFFSET,
-						UVERBS_ATTR_TYPE(u32),
-						UA_MANDATORY),
-			    UVERBS_ATTR_PTR_OUT(BNXT_RE_TOGGLE_MEM_MMAP_LENGTH,
-						UVERBS_ATTR_TYPE(u32),
-						UA_MANDATORY));
-
-DECLARE_UVERBS_NAMED_METHOD_DESTROY(BNXT_RE_METHOD_RELEASE_TOGGLE_MEM,
-				    UVERBS_ATTR_IDR(BNXT_RE_RELEASE_TOGGLE_MEM_HANDLE,
-						    BNXT_RE_OBJECT_GET_TOGGLE_MEM,
-						    UVERBS_ACCESS_DESTROY,
-						    UA_MANDATORY));
-
-DECLARE_UVERBS_NAMED_OBJECT(BNXT_RE_OBJECT_GET_TOGGLE_MEM,
-			    UVERBS_TYPE_ALLOC_IDR(get_toggle_mem_obj_cleanup),
-			    &UVERBS_METHOD(BNXT_RE_METHOD_GET_TOGGLE_MEM),
-			    &UVERBS_METHOD(BNXT_RE_METHOD_RELEASE_TOGGLE_MEM));
-
-const struct uapi_definition bnxt_re_uapi_defs[] = {
-	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_ALLOC_PAGE),
-	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_NOTIFY_DRV),
-	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_GET_TOGGLE_MEM),
-	{}
-};
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 76ba9ab04d5c..a11f56730a31 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -293,4 +293,7 @@ static inline u32 __to_ib_port_num(u16 port_id)
 
 unsigned long bnxt_re_lock_cqs(struct bnxt_re_qp *qp);
 void bnxt_re_unlock_cqs(struct bnxt_re_qp *qp, unsigned long flags);
+struct bnxt_re_user_mmap_entry*
+bnxt_re_mmap_entry_insert(struct bnxt_re_ucontext *uctx, u64 mem_offset,
+			  enum bnxt_re_mmap_flag mmap_flag, u64 *offset);
 #endif /* __BNXT_RE_IB_VERBS_H__ */
-- 
2.51.2.636.ga99f379adf


