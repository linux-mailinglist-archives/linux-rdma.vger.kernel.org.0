Return-Path: <linux-rdma+bounces-1182-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 093CD86DEB3
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Mar 2024 10:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34111F230BA
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Mar 2024 09:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12E16A8B9;
	Fri,  1 Mar 2024 09:57:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCBA42A8B;
	Fri,  1 Mar 2024 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709287069; cv=none; b=neqBLCdd73td6B5eikHPE1szN7QP8F4+q4BMO0SlN++Qq0yDBNbcVsmMelhJ/CuU5YiuUd+74HwOcXrOmj1XdCeqOgR0yg9x3/uaE4RAmNM6zvmscSqaPUNTd/roc4bYRoZav+C0GZs6XvX/cU96gWwSNeEUzR7RkXF4swXLZdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709287069; c=relaxed/simple;
	bh=7i7qkNtRTTPOCju0zKhcOsfkVU1pD4TeLBCBwyMYrNc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MUuEddCE1+ZEUQb5Ilp6nRPzSmfIlOF9y3y9ECNn4oV9wjsENgNRvOhES0BOgVv/6aP+TSY1QmG9ICaTRN2FwAsobCl29Tv4VULZJNShoBOldavKdJ0YaPFc7CuBOwSIfssWvEtC0/kcvk14jS/4AKAznQ+q9NftsH5jBGYTXpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TmNm86Gd3zNp35;
	Fri,  1 Mar 2024 17:56:56 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (unknown [7.193.23.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 0259418007D;
	Fri,  1 Mar 2024 17:57:37 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 17:57:36 +0800
From: Wenchao Hao <haowenchao2@huawei.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Wenchao
 Hao <haowenchao2@huawei.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] RDMA/restrack: Fix potential invalid address access
Date: Fri, 1 Mar 2024 17:55:15 +0800
Message-ID: <20240301095514.3598280-1-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600012.china.huawei.com (7.193.23.74)

struct rdma_restrack_entry's kern_name was set to KBUILD_MODNAME
in ib_create_cq(), while if the module exited but forgot del this
rdma_restrack_entry, it would cause a invalid address access in
rdma_restrack_clean() when print the owner of this rdma_restrack_entry.

Fix this issue by using kstrdup() to set rdma_restrack_entry's
kern_name.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/infiniband/core/restrack.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index 01a499a8b88d..6605011c4edc 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -177,7 +177,8 @@ static void rdma_restrack_attach_task(struct rdma_restrack_entry *res,
 void rdma_restrack_set_name(struct rdma_restrack_entry *res, const char *caller)
 {
 	if (caller) {
-		res->kern_name = caller;
+		kfree(res->kern_name);
+		res->kern_name = kstrdup(caller, GFP_KERNEL);
 		return;
 	}
 
@@ -195,7 +196,7 @@ void rdma_restrack_parent_name(struct rdma_restrack_entry *dst,
 			       const struct rdma_restrack_entry *parent)
 {
 	if (rdma_is_kernel_res(parent))
-		dst->kern_name = parent->kern_name;
+		dst->kern_name = kstrdup(parent->kern_name, GFP_KERNEL);
 	else
 		rdma_restrack_attach_task(dst, parent->task);
 }
@@ -306,6 +307,7 @@ static void restrack_release(struct kref *kref)
 		put_task_struct(res->task);
 		res->task = NULL;
 	}
+	kfree(res->kern_name);
 	complete(&res->comp);
 }
 
-- 
2.32.0


