Return-Path: <linux-rdma+bounces-5327-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A24995D93
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 04:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94272872C9
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 02:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E06C13B59B;
	Wed,  9 Oct 2024 02:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="oaiq4ZLK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24182126C17;
	Wed,  9 Oct 2024 02:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728439241; cv=none; b=Tog9zBn3reMiIz1s14PuBNqg3lWFGfffbjGkX8Lv0P1JBjx+J+fE6m3sO6n+bbfxKLg4D28+wpecXQdjsYXB3+h64Kg79uKdN3x9ZxSL/RiW4tt85EvXh9TN75IecMA3NYpnnlOW9FXQtYwegUqhCrEgBFi/fzZoZFH8yIHu0zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728439241; c=relaxed/simple;
	bh=d0wwcVJ2wiPfzLAZioHXqTxaImSi1jy8sKgRPRWuclY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N50P+EpZx7sk+NEvfrc4TeahX2nXFOXcyx4X523gVBMK3xqFv7iO9ci08K3uaIeoeZpG6MaVUeZCQKLM2P5NwnmgLmJ4mOeFKV0YmD/paMm7Wa1KGuJVypieIuTC4s23C4AP3yyQlGmZ/ipP0ZGRYtOkpUVBnWJ9VwPooxBHbOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=oaiq4ZLK; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1728439238; x=1759975238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d0wwcVJ2wiPfzLAZioHXqTxaImSi1jy8sKgRPRWuclY=;
  b=oaiq4ZLKrpkAWXWSLoOSd0eI7OT6VQqCkDXCY50PgFlkULRUUQWqxJpC
   szu7wXPW5kjdwvzaXb/p/j6uJ12nGqEb/mPDqGXjAHehbuGcOcXVCDI4z
   YBtSxW6BxxtBojBwcpjk+DmuqJPSCdOGORTjc/u+bzxvXoEWflVhpDSlG
   KBNuV7uU16Uah0DtnzV1OVW9MiB5BjZvNH52psRf6s6oe+GsALwz77HfN
   Bvd2Ljn+GHDZ9WfUShzAzTXPbsALmOKdjU5LsljRCVGla8GRmOOYRCG/Z
   hgmylq7bRT/t1a6QYj3YHq5hXKtuXz7qABaVHt6Odh5V0iL6wQ4u6ffjF
   A==;
X-CSE-ConnectionGUID: tu7FTvsjSBGF4MG66nxw8g==
X-CSE-MsgGUID: XN1ZiY4kSW6xi6NdDxMEDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="155099735"
X-IronPort-AV: E=Sophos;i="6.11,188,1725289200"; 
   d="scan'208";a="155099735"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 10:59:27 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 997C5D424D;
	Wed,  9 Oct 2024 10:59:26 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id E1CCDD772F;
	Wed,  9 Oct 2024 10:59:25 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id A38F22005379;
	Wed,  9 Oct 2024 10:59:25 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: linux-kernel@vger.kernel.org,
	rpearsonhpe@gmail.com,
	lizhijian@fujitsu.com,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v8 3/6] RDMA/rxe: Add page invalidation support
Date: Wed,  9 Oct 2024 10:59:00 +0900
Message-Id: <20241009015903.801987-4-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
References: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

On page invalidation, an MMU notifier callback is invoked to unmap DMA
addresses and update the driver page table(umem_odp->dma_list). It also
sets the corresponding entries in MR xarray to NULL to prevent any access.
The callback is registered when an ODP-enabled MR is created.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/Makefile  |  2 +
 drivers/infiniband/sw/rxe/rxe_odp.c | 57 +++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_odp.c

diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
index 5395a581f4bb..93134f1d1d0c 100644
--- a/drivers/infiniband/sw/rxe/Makefile
+++ b/drivers/infiniband/sw/rxe/Makefile
@@ -23,3 +23,5 @@ rdma_rxe-y := \
 	rxe_task.o \
 	rxe_net.o \
 	rxe_hw_counters.o
+
+rdma_rxe-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += rxe_odp.o
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
new file mode 100644
index 000000000000..ea55b79be0c6
--- /dev/null
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2022-2023 Fujitsu Ltd. All rights reserved.
+ */
+
+#include <linux/hmm.h>
+
+#include <rdma/ib_umem_odp.h>
+
+#include "rxe.h"
+
+static void rxe_mr_unset_xarray(struct rxe_mr *mr, unsigned long start,
+				unsigned long end)
+{
+	unsigned long upper = rxe_mr_iova_to_index(mr, end - 1);
+	unsigned long lower = rxe_mr_iova_to_index(mr, start);
+	void *entry;
+
+	XA_STATE(xas, &mr->page_list, lower);
+
+	/* make elements in xarray NULL */
+	xas_lock(&xas);
+	xas_for_each(&xas, entry, upper)
+		xas_store(&xas, NULL);
+	xas_unlock(&xas);
+}
+
+static bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
+				    const struct mmu_notifier_range *range,
+				    unsigned long cur_seq)
+{
+	struct ib_umem_odp *umem_odp =
+		container_of(mni, struct ib_umem_odp, notifier);
+	struct rxe_mr *mr = umem_odp->private;
+	unsigned long start, end;
+
+	if (!mmu_notifier_range_blockable(range))
+		return false;
+
+	mutex_lock(&umem_odp->umem_mutex);
+	mmu_interval_set_seq(mni, cur_seq);
+
+	start = max_t(u64, ib_umem_start(umem_odp), range->start);
+	end = min_t(u64, ib_umem_end(umem_odp), range->end);
+
+	rxe_mr_unset_xarray(mr, start, end);
+
+	/* update umem_odp->dma_list */
+	ib_umem_odp_unmap_dma_pages(umem_odp, start, end);
+
+	mutex_unlock(&umem_odp->umem_mutex);
+	return true;
+}
+
+const struct mmu_interval_notifier_ops rxe_mn_ops = {
+	.invalidate = rxe_ib_invalidate_range,
+};
-- 
2.43.0


