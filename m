Return-Path: <linux-rdma+bounces-1476-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CD987E626
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Mar 2024 10:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28AA91F21E59
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Mar 2024 09:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132912C692;
	Mon, 18 Mar 2024 09:42:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C4C28DAE;
	Mon, 18 Mar 2024 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754948; cv=none; b=ahEYq8yK4jXPO9upYAhPVfkg3a/Z+cIUC6mlP3OfpOR2dBB63b9q5WNL7MCrfVQwPiOuZ7+2hjJWUWc1dYPFC43fIujJIMZTYtXj4XvcgdiQLbNAdscd6bqiC+3Jq7KOCB/yR3RyzAkSh/SMCqSAgiiRKbvuIBSdPhAYPPzcLo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754948; c=relaxed/simple;
	bh=3oso5PLbImGkfoKsWCngxnTBzg9vtA8Zgmipm9DvaWs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X3HVibUfL/v5COoisogdNKrrdSf2REaMfTjpsqUGmTiv3iGtFECHbSjenKoa/S2zcwxkrqhKM0OxfEWn1k/e04EtcwYJu+5pE+vXC0VBTH3ljujUVdE8hbl0w7pzVHdOz+Fm7KrCbHo2VWYsmj3SK1MueLgzQbB1ktsJ4srzE8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TyqFP72W2z1vx2t;
	Mon, 18 Mar 2024 17:24:57 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (unknown [7.193.23.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 59E0F1A0172;
	Mon, 18 Mar 2024 17:25:43 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 17:25:42 +0800
From: Wenchao Hao <haowenchao2@huawei.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Wenchao Hao <haowenchao2@huawei.com>, <louhongxiang@huawei.com>
Subject: [PATCH v2] RDMA/restrack: Fix potential invalid address access
Date: Mon, 18 Mar 2024 17:23:20 +0800
Message-ID: <20240318092320.1215235-1-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600012.china.huawei.com (7.193.23.74)

struct rdma_restrack_entry's kern_name was set to KBUILD_MODNAME
in ib_create_cq(), while if the module exited but forgot del this
rdma_restrack_entry, it would cause a invalid address access in
rdma_restrack_clean() when print the owner of this rdma_restrack_entry.

These code is used to help find one forgotten PD release in one of the
ULPs. But it is not needed anymore, so delete them.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/infiniband/core/restrack.c | 51 +-----------------------------
 1 file changed, 1 insertion(+), 50 deletions(-)

diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index 01a499a8b88d..438ed3588175 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -37,22 +37,6 @@ int rdma_restrack_init(struct ib_device *dev)
 	return 0;
 }
 
-static const char *type2str(enum rdma_restrack_type type)
-{
-	static const char * const names[RDMA_RESTRACK_MAX] = {
-		[RDMA_RESTRACK_PD] = "PD",
-		[RDMA_RESTRACK_CQ] = "CQ",
-		[RDMA_RESTRACK_QP] = "QP",
-		[RDMA_RESTRACK_CM_ID] = "CM_ID",
-		[RDMA_RESTRACK_MR] = "MR",
-		[RDMA_RESTRACK_CTX] = "CTX",
-		[RDMA_RESTRACK_COUNTER] = "COUNTER",
-		[RDMA_RESTRACK_SRQ] = "SRQ",
-	};
-
-	return names[type];
-};
-
 /**
  * rdma_restrack_clean() - clean resource tracking
  * @dev:  IB device
@@ -60,47 +44,14 @@ static const char *type2str(enum rdma_restrack_type type)
 void rdma_restrack_clean(struct ib_device *dev)
 {
 	struct rdma_restrack_root *rt = dev->res;
-	struct rdma_restrack_entry *e;
-	char buf[TASK_COMM_LEN];
-	bool found = false;
-	const char *owner;
 	int i;
 
 	for (i = 0 ; i < RDMA_RESTRACK_MAX; i++) {
 		struct xarray *xa = &dev->res[i].xa;
 
-		if (!xa_empty(xa)) {
-			unsigned long index;
-
-			if (!found) {
-				pr_err("restrack: %s", CUT_HERE);
-				dev_err(&dev->dev, "BUG: RESTRACK detected leak of resources\n");
-			}
-			xa_for_each(xa, index, e) {
-				if (rdma_is_kernel_res(e)) {
-					owner = e->kern_name;
-				} else {
-					/*
-					 * There is no need to call get_task_struct here,
-					 * because we can be here only if there are more
-					 * get_task_struct() call than put_task_struct().
-					 */
-					get_task_comm(buf, e->task);
-					owner = buf;
-				}
-
-				pr_err("restrack: %s %s object allocated by %s is not freed\n",
-				       rdma_is_kernel_res(e) ? "Kernel" :
-							       "User",
-				       type2str(e->type), owner);
-			}
-			found = true;
-		}
+		WARN_ON(!xa_empty(xa));
 		xa_destroy(xa);
 	}
-	if (found)
-		pr_err("restrack: %s", CUT_HERE);
-
 	kfree(rt);
 }
 
-- 
2.32.0


