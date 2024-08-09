Return-Path: <linux-rdma+bounces-4265-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB0494CC48
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 10:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04F21C227C8
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 08:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF21190059;
	Fri,  9 Aug 2024 08:34:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C28D18FDB4;
	Fri,  9 Aug 2024 08:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192447; cv=none; b=jw5I76rBsXAgdBn/mFCqv/vXoCuvlTeoBc2YLVWojOpM3JFkgpdElaZHCo25Vor7d7AkEqMvINhyE8k+mNEq9NAiGomA44AOsqirqhSJEl9QlaN8gwq6TBzpjfgn9uZPXCD2ACbVk8RqanEQWPmH4XI6+EpcAhILhK0xFRMLuHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192447; c=relaxed/simple;
	bh=o7zdzIMEvYJzAUMY8b9aGmbbDq1Bj6B6JV3A0LMKWTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d16th4fZUqal1jP1GfAGxdOBDM5LWNDsHFYHQOpP510nlWVvnv61wwkilEEE6xpIAzVtATpy1+mnJV3vuqlvZCqZICm/Y9O2RXtL79VeXdJ8OOMGnyvtAwElg7oK7mwJMRcWHdBoAP7eWcJEy0hp9fJsbUkOtDJlt4vPUtHDxiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WgHC14zQgz20lHB;
	Fri,  9 Aug 2024 16:29:33 +0800 (CST)
Received: from kwepemg200003.china.huawei.com (unknown [7.202.181.30])
	by mail.maildlp.com (Postfix) with ESMTPS id 113DF1400F4;
	Fri,  9 Aug 2024 16:34:02 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200003.china.huawei.com
 (7.202.181.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 9 Aug
 2024 16:34:00 +0800
From: Liu Jian <liujian56@huawei.com>
To: <linux-rdma@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <jgg@ziepe.ca>, <leon@kernel.org>, <zyjzyj2000@gmail.com>,
	<wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<liujian56@huawei.com>
Subject: [PATCH net-next 3/4] net/smc: fix one NULL pointer dereference in smc_ib_is_sg_need_sync()
Date: Fri, 9 Aug 2024 16:31:47 +0800
Message-ID: <20240809083148.1989912-4-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809083148.1989912-1-liujian56@huawei.com>
References: <20240809083148.1989912-1-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200003.china.huawei.com (7.202.181.30)

BUG: kernel NULL pointer dereference, address: 0000000000000238
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 3 PID: 289 Comm: kworker/3:1 Kdump: loaded Tainted: G           OE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
Workqueue: smc_hs_wq smc_listen_work [smc]
RIP: 0010:dma_need_sync+0x5/0x60
...
Call Trace:
 <TASK>
 ? dma_need_sync+0x5/0x60
 ? smc_ib_is_sg_need_sync+0x61/0xf0 [smc]
 smcr_buf_map_link+0x24a/0x380 [smc]
 __smc_buf_create+0x483/0xb10 [smc]
 smc_buf_create+0x21/0xe0 [smc]
 smc_listen_work+0xf11/0x14f0 [smc]
 ? smc_tcp_listen_work+0x364/0x520 [smc]
 process_one_work+0x18d/0x3f0
 worker_thread+0x304/0x440
 kthread+0xe4/0x110
 ret_from_fork+0x47/0x70
 ret_from_fork_asm+0x1a/0x30
 </TASK>

If the software RoCE device is used, ibdev->dma_device is a null pointer.
As a result, the problem occurs. Null pointer detection is added to
prevent problems.

Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 net/smc/smc_ib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 382351ac9434..059822cc3fde 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -748,6 +748,8 @@ bool smc_ib_is_sg_need_sync(struct smc_link *lnk,
 		    buf_slot->sgt[lnk->link_idx].nents, i) {
 		if (!sg_dma_len(sg))
 			break;
+		if (!lnk->smcibdev->ibdev->dma_device)
+			break;
 		if (dma_need_sync(lnk->smcibdev->ibdev->dma_device,
 				  sg_dma_address(sg))) {
 			ret = true;
-- 
2.34.1


