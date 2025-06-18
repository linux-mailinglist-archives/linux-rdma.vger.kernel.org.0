Return-Path: <linux-rdma+bounces-11425-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40662ADE847
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 12:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1DDA189B51B
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 10:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F77285050;
	Wed, 18 Jun 2025 10:16:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4388C27FD7F;
	Wed, 18 Jun 2025 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750241766; cv=none; b=WnBWXYrKsOAzmAaJRmKTSKRtfqrztDVBOdHDRzKB6C1AuzYt5RZA7KxjmwXMoxNx4hox9iqCml908KuN+MLsdF72ZkgOqUtDgl0rhZStWfsXi6SQXdTwxt4Egr5IIbls/EkwAbwaqrSagvX7VGzmLj6+/IcmZfvF975ehdz5gfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750241766; c=relaxed/simple;
	bh=63P/YM6AlzgZ9xMkMXKv9TnQwwkHN8E+6brIEKb3snA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W+f0DSoNXmMwRcmWDBgMLt3hJl795fhbQYkPU8itLklwf9zAFxayXPP9cTLhGt+bhiw7VMwZFDBZ/FFd3yeTfk/bUr4diTGxYsp63Zsv20p5xJna/JsxjcSPYjpvbnYoTsH2ZDA8gTWU5CVdZNa6IdDqbRKAV6kFd7K/iXmyXX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bMfhb5DjNz28fQ1;
	Wed, 18 Jun 2025 18:13:35 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A02718005F;
	Wed, 18 Jun 2025 18:16:00 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 18 Jun
 2025 18:15:59 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<linux-rdma@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net/smc: remove unused input parameters in smc_buf_get_slot
Date: Wed, 18 Jun 2025 18:33:42 +0800
Message-ID: <20250618103342.1423913-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500016.china.huawei.com (7.185.36.197)

The input parameter "compressed_bufsize" of smc_buf_get_slot is unused,
remove it.

Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/smc/smc_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index ac07b963aede..262746e304dd 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -2100,8 +2100,7 @@ int smc_uncompress_bufsize(u8 compressed)
 /* try to reuse a sndbuf or rmb description slot for a certain
  * buffer size; if not available, return NULL
  */
-static struct smc_buf_desc *smc_buf_get_slot(int compressed_bufsize,
-					     struct rw_semaphore *lock,
+static struct smc_buf_desc *smc_buf_get_slot(struct rw_semaphore *lock,
 					     struct list_head *buf_list)
 {
 	struct smc_buf_desc *buf_slot;
@@ -2442,7 +2441,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 		bufsize = smc_uncompress_bufsize(bufsize_comp);
 
 		/* check for reusable slot in the link group */
-		buf_desc = smc_buf_get_slot(bufsize_comp, lock, buf_list);
+		buf_desc = smc_buf_get_slot(lock, buf_list);
 		if (buf_desc) {
 			buf_desc->is_dma_need_sync = 0;
 			SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, true, bufsize);
-- 
2.34.1


