Return-Path: <linux-rdma+bounces-4241-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B8894B825
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2024 09:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DE31F24DB2
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2024 07:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E32D187FE7;
	Thu,  8 Aug 2024 07:46:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6018C18757F;
	Thu,  8 Aug 2024 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103166; cv=none; b=RsKcVnbtFMiOe86st4eO5+GiZyDmxXjhYD9AUputvo+bYpZMslMK7Axd+CY/taX+0yM77Mfkq8RM64Mh9BhHCZik09oDwlslSVmauSJKknX1WV2/ilgoyv2EHqAS3fnoOSrpqb2NXNeuCuc7mna4lqBoL2CTl9ypv58ENyC7tqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103166; c=relaxed/simple;
	bh=NJ/f9DdsOmhEH11ue37Swdj4i4LBflgYWEVWp+KJd8w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YJ/0wI9bAW88qPwATsy91nkxnpzCt06WSbx/PCCFttu2kZBLnZoEYSSDdxQn+Hk51F6E/MVr3x2NoTLndRIxO6oHqCrUyo54WxZwADWnFsYgKr/wMg0So9gcG1V3OsSXMOVprow2CQNgMSYBkAwP6vit9DVlS2RrT23gCHdcoQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WffGp0mCZz1T6rK;
	Thu,  8 Aug 2024 15:45:38 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id BCDF0140604;
	Thu,  8 Aug 2024 15:45:59 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Aug 2024 15:45:59 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next] RDMA/core: Fix ib_core building error when CONFIG_MMU=n
Date: Thu, 8 Aug 2024 15:40:26 +0800
Message-ID: <20240808074026.3535706-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100018.china.huawei.com (7.202.181.17)

zap_vma_ptes() depends on CONFIG_MMU. When CONFIG_MMU=n,
a building error occurs due to the zap_vma_ptes() call in
uverbs_user_mmap_disassociate():

ERROR: modpost: "zap_vma_ptes" [drivers/infiniband/core/ib_core.ko] undefined!

Add "#ifdef CONFIG_MMU" to fix this error.

Fixes: 577b3696166a ("RDMA/core: Provide rdma_user_mmap_disassociate() to disassociate mmap pages")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408072142.mVX227UI-lkp@intel.com/
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/core/ib_core_uverbs.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/ib_core_uverbs.c b/drivers/infiniband/core/ib_core_uverbs.c
index 4e27389a75ad..911aec0573cb 100644
--- a/drivers/infiniband/core/ib_core_uverbs.c
+++ b/drivers/infiniband/core/ib_core_uverbs.c
@@ -367,6 +367,7 @@ int rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
 }
 EXPORT_SYMBOL(rdma_user_mmap_entry_insert);
 
+#ifdef CONFIG_MMU
 void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
 {
 	struct rdma_umap_priv *priv, *next_priv;
@@ -428,7 +429,6 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
 		mmput(mm);
 	}
 }
-EXPORT_SYMBOL(uverbs_user_mmap_disassociate);
 
 /**
  * rdma_user_mmap_disassociate() - disassociate the mmap from the ucontext.
@@ -449,4 +449,14 @@ void rdma_user_mmap_disassociate(struct ib_ucontext *ucontext)
 	uverbs_user_mmap_disassociate(ufile);
 	up_read(&ufile->hw_destroy_rwsem);
 }
+#else
+void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
+{
+}
+
+void rdma_user_mmap_disassociate(struct ib_ucontext *ucontext)
+{
+}
+#endif
+EXPORT_SYMBOL(uverbs_user_mmap_disassociate);
 EXPORT_SYMBOL(rdma_user_mmap_disassociate);
-- 
2.33.0


