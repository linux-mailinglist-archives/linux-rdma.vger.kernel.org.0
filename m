Return-Path: <linux-rdma+bounces-4335-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CBA94ED95
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 15:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4842C1F2279C
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 13:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68A617BB34;
	Mon, 12 Aug 2024 13:02:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65D6170A1C;
	Mon, 12 Aug 2024 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467742; cv=none; b=eRp1uCPMGRXd851CCU27KLxiy9htLcjGXcigIOHRJjbzs5AJl16VpNoGgc5PGYW9eL0fZzMB1xmFxfmAMa8sOYrDNC4vuja1bBPf424nqGu6u28C9bhtaS0UsJvsmQOetCfUnEITnqtQdX54a8a22zF6/cP0ZX/gG4GRek4JTs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467742; c=relaxed/simple;
	bh=fi6l+3SXmEBtkczNoivvcmUhubjjU4fln3xRAoQGTIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gz8bKF/SfYAarcr4MaGhgeX0IzECkBmRl0QLqcs3Bmkk9yBXl2spV16CgOeC++n8pjh5FgNS21jd6w2l9aMVlysQNZgvLPNNwVl04rO4T6pNIf3vVIWFBJ7lBKLLrJzDJv2dzDmA6sAwbMZ9VDMQo4lx8QtgB+lk4vQdGABdjRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WjF5n3TvgzyPDd;
	Mon, 12 Aug 2024 21:01:49 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 02440180101;
	Mon, 12 Aug 2024 21:02:17 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 12 Aug 2024 21:02:16 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-next 1/3] RDMA/core: Provide rdma_user_mmap_disassociate() to disassociate mmap pages
Date: Mon, 12 Aug 2024 20:56:38 +0800
Message-ID: <20240812125640.1003948-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240812125640.1003948-1-huangjunxian6@hisilicon.com>
References: <20240812125640.1003948-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: Chengchang Tang <tangchengchang@huawei.com>

Provide a new api rdma_user_mmap_disassociate() for drivers to
disassociate mmap pages for ucontext.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/core/uverbs_main.c | 21 +++++++++++++++++++++
 include/rdma/ib_verbs.h               |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index bc099287de9a..00dab5bfb78c 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -880,6 +880,27 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
 	}
 }
 
+/**
+ * rdma_user_mmap_disassociate() - disassociate the mmap from the ucontext.
+ *
+ * @ucontext: associated user context.
+ *
+ * This function should be called by drivers that need to disable mmap for
+ * some ucontexts.
+ */
+void rdma_user_mmap_disassociate(struct ib_ucontext *ucontext)
+{
+	struct ib_uverbs_file *ufile = ucontext->ufile;
+
+	/* Racing with uverbs_destroy_ufile_hw */
+	if (!down_read_trylock(&ufile->hw_destroy_rwsem))
+		return;
+
+	uverbs_user_mmap_disassociate(ufile);
+	up_read(&ufile->hw_destroy_rwsem);
+}
+EXPORT_SYMBOL(rdma_user_mmap_disassociate);
+
 /*
  * ib_uverbs_open() does not need the BKL:
  *
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index a1dcf812d787..d6e34ca5c727 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2947,6 +2947,7 @@ int rdma_user_mmap_entry_insert_range(struct ib_ucontext *ucontext,
 				      struct rdma_user_mmap_entry *entry,
 				      size_t length, u32 min_pgoff,
 				      u32 max_pgoff);
+void rdma_user_mmap_disassociate(struct ib_ucontext *ucontext);
 
 static inline int
 rdma_user_mmap_entry_insert_exact(struct ib_ucontext *ucontext,
-- 
2.33.0


