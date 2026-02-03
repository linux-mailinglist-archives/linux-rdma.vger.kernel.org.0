Return-Path: <linux-rdma+bounces-16392-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOs4CAmDgWlNGwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16392-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 06:09:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9FFD492C
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 06:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FCA2302AE07
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 05:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9712F39B1;
	Tue,  3 Feb 2026 05:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EYkxqyFj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3AE192B7D
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 05:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770095363; cv=none; b=gBZtDmBDXA3Lo8QUDSvC1n6hMNuuduuCFhWjjqg3y5Smd4Z8J7PpaWahk59oKyPmcIWPur1s+CSNebdd6cSSzKWBzVlz4Phf2m5IG3SpiX/N0DohFiIaw4NLfB3ipPTFuhFLSyY/7X/TXqJMwgSZ501q0BW647HK52irPXe3nsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770095363; c=relaxed/simple;
	bh=D9v+esLvE/cYr/Dxgwq6jO6Vqe/qGmvz6DmEvPCOjAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQsuCLfIqSebZTr0gCi8jTzKrRUoJeYuXp5PGb/xld460+FHskPDdGSgxCb1MNIOqvGDu4AHjiz3WcuHF9a26xuJSdgElOlDOq4Q1oo9BwUcNw3aFZTv0WEa6VJFCu4/WMQhrwbvQido1L22Ur7CCis+UGK8BBvdEhraGzMeM0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EYkxqyFj; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a7b23dd036so25422375ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 21:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770095361; x=1770700161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hup/wCpgj/4GrVIoJHj1DNUmZ7StJh6ZGLjCnWlZHJs=;
        b=MRmhus2Ez9FYKtijip6C54m24AEh8NAJEQuDD4iBwFvDcp361vOH1RK8SlNdGI0yTU
         9SBqHmYwV6rJRgwbAhGI+Q1TbWoPm4MYUUupM+cAoMctn6EEyhgspKmiM3Xh9fCVLwQf
         6l+Yyhvi8g3joJ/v6eGl75KamQQSicFn4MOqkTY536gHV/Yh8aQ1I9ufOu1/vqzMKnip
         Kwinmx7HP3aaG/JqNOf+mqlJg1Q8FfUWLiWBAEQccsopNcdsQYdCChW7bqep7pIhSLy+
         phPykSEupEe7hEYtw9MACok5f4gPg/wFcnOMPFIgI2d+EGwtQ9hX5uUm613kQEQt+70g
         TCoQ==
X-Gm-Message-State: AOJu0Yybsza4ZWKdu3T640oZjP00WFxGvgXtDagcWj3jhJ8kIEnAZl2/
	COAm2ct/zH3CM5UxHbmNoF+Oebw9YZlMRLtVVmJI3ji+fPU+U/JtZZhNfXlAeZqtCe8ztisWtQL
	wUGqEFEBbdKKCeiXXEUBQvXE1vBeKqwsh8jCMxND3C6Z7RCbmJTUa7kaG0AvtmL9mZ2FsU9/Dyn
	3zGclweqkYxI9zon0pTNTnGOT6F/AIqf63qjDSdaHEyOAuc2RsAm+TqcqEqWd3pGXyEWzLxFEPy
	pzy/Qm1GZZmuT61H0TzGThwOiQ2
X-Gm-Gg: AZuq6aLKPJc6lcMzP/nSrzn7UQh4sPyIr9AzWtgmY9sdxqZ7wRID+Ztg0vk/7trUpBE
	Ns9hLVxQ7/s8kYDxIeFmcoNA4wq9L/Mo6qCF0o4uebdtbHkqyAg5rVYLXyY6O8W1PQayYlVa3GK
	bPfskJsRWWlPjU22MjgpvolFjw3sz9j7Ii0q5/J0E9TLGHX7F6SPTEsv6K4Z58Mj2L2asJXIZzk
	MBvTP9p7+pM5MGlWMEcBYeUIhLUCbF7ZnxpAh4Yog8QK4gACr4sWWnhnQni8ooa+uKhueoKLxvp
	OL/ixW3OFb6+KyEk6v8VWcjGJv80geYs23XFNzI1tohCNmuDxKiNKaCOzj5vhkoP0YCSDDDOfI0
	NFdDWnjil9hyqTi5FxunACbDOWdUxrlmzZLPUYy30Q2PoFN9eFHymBMWDg9UUzjIsWtOEjeOfgc
	fXWJz9MUkMXPNJX05ZSKkEaDTaLIpc5J8SxtcDb2N4WGEZ02P8/hQhoeQH/qk=
X-Received: by 2002:a17:903:1590:b0:2a8:fc56:a3e6 with SMTP id d9443c01a7336-2a8fc56aa0fmr76328945ad.24.1770095361290;
        Mon, 02 Feb 2026 21:09:21 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a88b7f7c76sm24659145ad.50.2026.02.02.21.09.20
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Feb 2026 21:09:21 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-352c7924ebcso5397926a91.3
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 21:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770095359; x=1770700159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hup/wCpgj/4GrVIoJHj1DNUmZ7StJh6ZGLjCnWlZHJs=;
        b=EYkxqyFju/9gjp+APeyxI4HPutKmxAk2mx+V6AZxxSCTaY7uQrLrknndkGn43jfexX
         aAjGlER8995cQdGV0AFoiN5/KrITnnyphpF059EKZIKzS8NlhvREnjsquyy14dsS6Nsn
         9iXMI/Je8yxRSy/jTBKvgEnwxa5ntOQ/KLkYI=
X-Received: by 2002:a17:90b:3dcb:b0:340:b912:536 with SMTP id 98e67ed59e1d1-3543b3ad361mr12386200a91.31.1770095359196;
        Mon, 02 Feb 2026 21:09:19 -0800 (PST)
X-Received: by 2002:a17:90b:3dcb:b0:340:b912:536 with SMTP id 98e67ed59e1d1-3543b3ad361mr12386186a91.31.1770095358745;
        Mon, 02 Feb 2026 21:09:18 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3547b1306c5sm621948a91.15.2026.02.02.21.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 21:09:17 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v10 2/6] RDMA/bnxt_re: Move the UAPI methods to a dedicated file
Date: Tue,  3 Feb 2026 10:30:45 +0530
Message-ID: <20260203050049.171026-3-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
References: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16392-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BA9FFD492C
X-Rspamd-Action: no action

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
index f19b55c13d58..f758f92ba72b 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -627,7 +627,7 @@ static int bnxt_re_create_fence_mr(struct bnxt_re_pd *pd)
 	return rc;
 }
 
-static struct bnxt_re_user_mmap_entry*
+struct bnxt_re_user_mmap_entry*
 bnxt_re_mmap_entry_insert(struct bnxt_re_ucontext *uctx, u64 mem_offset,
 			  enum bnxt_re_mmap_flag mmap_flag, u64 *offset)
 {
@@ -4531,32 +4531,6 @@ int bnxt_re_destroy_flow(struct ib_flow *flow_id)
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
@@ -4659,280 +4633,3 @@ int bnxt_re_process_mad(struct ib_device *ibdev, int mad_flags,
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


