Return-Path: <linux-rdma+bounces-6683-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D129F8FEF
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 11:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640F4161DDA
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 10:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0A41C07DB;
	Fri, 20 Dec 2024 10:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="EMgjzYdk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9CE1BEF97;
	Fri, 20 Dec 2024 10:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734689480; cv=none; b=BJKi3TWuLvkrzMdkwPdI5FwOExC8gy75V1+L1UOtbTnoXWxP2zWLVDcxbNrTbL/mvdrrbFN/MGhj8fFl3wx19X7TXi5EazwpXdqCHszJ1fD0hke7Ri2TrDGvavAmKnTJunlKiJ33QaeBpELLZKpDxT5XpP9E1pi+b3BRB4vzlPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734689480; c=relaxed/simple;
	bh=mSZ7eLr71izJsPwRWEk4puVUA0moz4RtvPiJiYq/0k8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LzLuc/DT+qO6Txu7p2qV+2+ZkGJiuZfg4VK+LbsFEWAxzBDFCHQL273JUUevJeWCed3tlHa0D24SLW07bMjrQwGBDv/6ql4ewVgrvt0ZwmAOb1zdAKTmG5aXwhthnNUfXTIQyLCcaP2eLLhKsD+zQjvmzLixJam2GSQ8nvaoLws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=EMgjzYdk; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1734689479; x=1766225479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mSZ7eLr71izJsPwRWEk4puVUA0moz4RtvPiJiYq/0k8=;
  b=EMgjzYdkr27TKhJ90Gm2lSLLe1LlrACM108Yk8XuTeiGBhzZ3AI7p7dF
   sZgTILbH8Y+/PsNvz/15ov1Hse9LkOLgYT+rOi+WLRV1ea3WxJjMNtcxx
   67DtLUHzwSO/2yI4dG4RvDWfZqjc9+oSAINFz6d0DLPJ8qcgc7AxgSTWM
   WpaB7uLxTYN6rztcP+VtUKH6GX2XQiukiLlnIgu3QnrPCGBtxlJo55oSB
   im4lLfZuLMOUYvFOS+d6mNZd/wPphxvCIKkG3QmeuTFGb3sI1vRmVEwhk
   OYW/1aJ2wFxXiP5H1OO6zt5jtpJj3f1CFbCCbMrCZg/9gUEBXDkpf/ItN
   w==;
X-CSE-ConnectionGUID: PrwbV6wFRsG4o6vPOpulZw==
X-CSE-MsgGUID: LQBQ2Rf1R8O78U6RiXHzFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="163883306"
X-IronPort-AV: E=Sophos;i="6.12,250,1728918000"; 
   d="scan'208";a="163883306"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 19:10:07 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 29525D4807;
	Fri, 20 Dec 2024 19:10:05 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id F2FA7BF3E6;
	Fri, 20 Dec 2024 19:10:04 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id B3FB0200597B;
	Fri, 20 Dec 2024 19:10:04 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: linux-kernel@vger.kernel.org,
	rpearsonhpe@gmail.com,
	lizhijian@fujitsu.com,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v9 2/5] RDMA/rxe: Add page invalidation support
Date: Fri, 20 Dec 2024 19:09:33 +0900
Message-Id: <20241220100936.2193541-3-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20241220100936.2193541-1-matsuda-daisuke@fujitsu.com>
References: <20241220100936.2193541-1-matsuda-daisuke@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On page invalidation, an MMU notifier callback is invoked to unmap DMA
addresses and update the driver page table(umem_odp->dma_list). The
callback is registered when an ODP-enabled MR is created.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/Makefile  |  2 ++
 drivers/infiniband/sw/rxe/rxe_loc.h |  3 +++
 drivers/infiniband/sw/rxe/rxe_odp.c | 38 +++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)
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
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 1c78b9d36da4..0162ac9431c1 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -182,4 +182,7 @@ static inline unsigned int wr_opcode_mask(int opcode, struct rxe_qp *qp)
 	return rxe_wr_opcode_info[opcode].mask[qp->ibqp.qp_type];
 }
 
+/* rxe_odp.c */
+extern const struct mmu_interval_notifier_ops rxe_mn_ops;
+
 #endif /* RXE_LOC_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
new file mode 100644
index 000000000000..2be8066db012
--- /dev/null
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -0,0 +1,38 @@
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
+static bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
+				    const struct mmu_notifier_range *range,
+				    unsigned long cur_seq)
+{
+	struct ib_umem_odp *umem_odp =
+		container_of(mni, struct ib_umem_odp, notifier);
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


