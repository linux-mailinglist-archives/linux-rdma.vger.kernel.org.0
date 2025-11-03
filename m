Return-Path: <linux-rdma+bounces-14193-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C8DC2B2EA
	for <lists+linux-rdma@lfdr.de>; Mon, 03 Nov 2025 11:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECEB44E825A
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Nov 2025 10:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479482FFF91;
	Mon,  3 Nov 2025 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AaV9TYAr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5E82FFFA9
	for <linux-rdma@vger.kernel.org>; Mon,  3 Nov 2025 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167462; cv=none; b=K2Kjny4Sckj4QFVdg8+wcAAEUcLg+ugWhi3hMr6Gn+1GaXEeIXGZ2HqkR+zyzl7q4A9zWNFGCTPFvOqWVsoEtDX7pQILys1zAk7Y7kCEo2C0FKEdKB4mKGwuFUnrAoFBeEZA3aSeOnWNxPyttEToQxu//KgRSZ3uikq3B50ZJgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167462; c=relaxed/simple;
	bh=WwxIJbvKU5vd2it60FIqzht0/Lj78FvcxHef6re1n7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUDa6RmpTFy3mjCXb0katCPeacnNRhBHHFMQOcwe2qfVEjpSwj73vE7R2bzjFNRIpBy/IMku4Dh5FXAvrOWItCFNmyhBGJwNzoGTgtZ55R5dDVFIdVewWEo6mb4e/YHRATgD1mt1eTk0pMBPYYep4QJBJggx85pAcwdjNKg37G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AaV9TYAr; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-b996c8db896so1236726a12.3
        for <linux-rdma@vger.kernel.org>; Mon, 03 Nov 2025 02:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762167459; x=1762772259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1ueSJhMTTy1+y+oxsJDsb01oHjzIf4uXRYO1bSnvxE=;
        b=b0WWz8hQPDuX1D4sjA8nzy1c57cD5N2VlhUcKZEsVQOSaLDiUHlmnu9VWyMfeSRZC8
         NhEvQhbRwk7Avlk3Hb7R/CYHCtV7heQuXBDykVFTzzop7Av8Ajr93GJy8vJwbVu7N+Ty
         bQIXoK9+V1n9jckLdRPWjrXj0/5EaE3YLhO2wwEKFuDfzJxtFA9lqf85SPBqy8W3mEMK
         oqlDYlYWDjuPMyXyUEefo2YOxmX8IrcGllz8RoHk/siHw2MyzHdHDa6GyLZq8hFyCiBX
         WTRpcLfI8dvm16i6JfMYzqar+WNOzkM4jRSKmRP+XYOqq927DSX6qwmUuc4QcQZv4zSN
         6DLw==
X-Gm-Message-State: AOJu0YzmMBp5lckpYRjxMt1rU+yAhrmK5MzYfZ0g3shmaYdnN3HkpR+k
	wFpf91b+BPLhnQdOqYLfCgSd0SrbGm+H2hxYlSLWFjLaxxx0sCdUQs8V4LAktz0c90OEHiWZqN8
	R8Lg2mNDfpJXSua7FtASi2SoEz+5PluoGW+ZiyT79Al5JPVlEvp1nsZa8LIq3IkBwgLmHXEiLZG
	wj40e4FAr/+52s59QqC4TMYk3NvfxIO0c56bMp4rLIk00CQCmdF0fFcRYH/XUmGMQVbP0zKoQwt
	5+Y74gRx3yTYppxJ6vIYM67Qfp6
X-Gm-Gg: ASbGncuCaVzueF4C9xeMmn6LUEz6xvIiJ8csJhSJoq+H1TuzpLcGLMmNHf7HZ7bnJjc
	dgaAy5dgDvaKYDeI/rNeuHoheIlwaIN+eml9sYlvnCnut7Z1hjsKI3+AsFrqdtV6SfXLuCq6NG+
	BVHWDBZfB3CGP3g4i/pNK/P+6e8qI9O92U6pNvrGb9y6b5yfdV5TvcRFHlhrBR6kXI1n097E0al
	eIop+QTNyJBIYgPS7GcbcsJrBbhFjehtkQq84Iq1qWMBfFdKan1qFwFPY9hE9/Xkj8k2O4qcc0q
	wFyzUTFdihgx/HC21a+Lfxr693F+yvVaSoyJVeY6DKUfEUVwZ2k381mEmfOFxRyOJ6sqFK8uxjW
	b0/RyznvDDn+n1jRgKSYyVKQi2OB7XLMnG+kjMBHIslH/F7Pi+wDwhg86h7LJIUSlaI1Kd7Ucav
	zdI6hIXnsgg6nJJRUpIhFO6cvN8dDClh/5gTVfXKv1eKRe5A==
X-Google-Smtp-Source: AGHT+IF5uxjrPvzvq+aCr7hx4bpgQ0Z3VW5ktWXDgPF9pXwSerA04Er60+EkGr7w4TwdvjWdvqqxBNPdchoF
X-Received: by 2002:a17:903:18c:b0:295:8da5:c634 with SMTP id d9443c01a7336-2958da5c9c0mr61147895ad.9.1762167458973;
        Mon, 03 Nov 2025 02:57:38 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2952689bcc2sm9495285ad.22.2025.11.03.02.57.38
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2025 02:57:38 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b99f6516262so2860181a12.3
        for <linux-rdma@vger.kernel.org>; Mon, 03 Nov 2025 02:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762167457; x=1762772257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1ueSJhMTTy1+y+oxsJDsb01oHjzIf4uXRYO1bSnvxE=;
        b=AaV9TYArYScJqnqv6ed6lL4qJTGjNXG8mmSxSs3XWQM1mrCO3G5xKsq19RRPlq5H8S
         oGRwJKD2xVosGQXjUtc+L3esVtfMstGOcK6Awpvs5kRFlrj3oDPz0f27FwHZf4rirwoQ
         h7EVc3DsI0xmuxU92rW48k6LJtLtOvxkBEG7k=
X-Received: by 2002:a17:902:da82:b0:295:3ad7:9485 with SMTP id d9443c01a7336-2953ad7955amr115647165ad.14.1762167456854;
        Mon, 03 Nov 2025 02:57:36 -0800 (PST)
X-Received: by 2002:a17:902:da82:b0:295:3ad7:9485 with SMTP id d9443c01a7336-2953ad7955amr115646905ad.14.1762167456377;
        Mon, 03 Nov 2025 02:57:36 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159fc0e19sm602263a91.4.2025.11.03.02.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:57:35 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next 1/4] RDMA/bnxt_re: Move the UAPI methods to a dedicated file
Date: Mon,  3 Nov 2025 16:20:30 +0530
Message-ID: <20251103105033.205586-2-sriharsha.basavapatna@broadcom.com>
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

This is in preparation for upcoming patches in the series.
Driver has to support additional UAPIs for Direct verbs.
Moving current UAPI implementation to a new file, dv.c.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/Makefile   |   2 +-
 drivers/infiniband/hw/bnxt_re/dv.c       | 356 +++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 305 +------------------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |   3 +
 4 files changed, 361 insertions(+), 305 deletions(-)
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
index 000000000000..2b3e34b940b3
--- /dev/null
+++ b/drivers/infiniband/hw/bnxt_re/dv.c
@@ -0,0 +1,356 @@
+/*
+ * Broadcom NetXtreme-E RoCE driver.
+ *
+ * Copyright (c) 2025, Broadcom. All rights reserved.  The term
+ * Broadcom refers to Broadcom Inc. and/or its subsidiaries.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * BSD license below:
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS''
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
+ * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS
+ * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
+
+	uctx = container_of(ib_uverbs_get_ucontext(attrs), struct bnxt_re_ucontext, ib_uctx);
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
+	struct bnxt_re_dev *rdev;
+	u64 mmap_offset;
+	u32 length;
+	u32 dpi;
+	u64 addr;
+	int err;
+
+	uctx = container_of(ib_uverbs_get_ucontext(attrs), struct bnxt_re_ucontext, ib_uctx);
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


