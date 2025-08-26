Return-Path: <linux-rdma+bounces-12931-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BC2B356AD
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 10:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9C81B6664B
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 08:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56D81F4191;
	Tue, 26 Aug 2025 08:22:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5672F746F;
	Tue, 26 Aug 2025 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196552; cv=none; b=NAUHI/cfSRrMbjNd2tbwaw/mhn5njiJZwLAyaZkOcC/kIwRpDaawEZurxlen/d3KZ2n2/fq1qFyzsBd5qIyDfEMAUNGRetx8+gk1N3ojvPO8qmGmHm0NlIKYY6iWlEjVrb1eNRhvOKn6KPITQTZhHMnm/jWOjRZJ0XGSWzNTrGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196552; c=relaxed/simple;
	bh=paTBoj9DCUhl33v0IoUbRwFxDjdcIXIy94zu1Z1jVGg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ccd7sRZPPTwDXyzmLdsY+wBuinhm10z445l7t26tWd9WAaYpD4Z0K0dsKeOOBUEhFqCfxxC4eASwSJ2LV7Igq+ezWvfxOICwFYYabPGxx5WyMw8oaQ3YofnDUsaTQ901OvQUratky6c0ksP5KigeWQigMpim4jn7Fbks2+GJ1Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cB0v60bh9z1R96x;
	Tue, 26 Aug 2025 16:19:30 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id D36CE1402CA;
	Tue, 26 Aug 2025 16:22:25 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemf500015.china.huawei.com
 (7.185.36.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 Aug
 2025 16:22:24 +0800
From: Liu Jian <liujian56@huawei.com>
To: <alibuda@linux.alibaba.com>, <dust.li@linux.alibaba.com>,
	<sidraya@linux.ibm.com>, <wenjia@linux.ibm.com>, <mjambigi@linux.ibm.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <guangguan.wang@linux.alibaba.com>
CC: <linux-rdma@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: [PATCH net] net/smc: fix one NULL pointer dereference in smc_ib_is_sg_need_sync()
Date: Tue, 26 Aug 2025 16:44:42 +0800
Message-ID: <20250826084442.322587-1-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500015.china.huawei.com (7.185.36.143)

BUG: kernel NULL pointer dereference, address: 00000000000002ec
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP PTI
CPU: 28 UID: 0 PID: 343 Comm: kworker/28:1 Kdump: loaded Tainted: G        OE       6.17.0-rc2+ #9 NONE
Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
Workqueue: smc_hs_wq smc_listen_work [smc]
RIP: 0010:smc_ib_is_sg_need_sync+0x9e/0xd0 [smc]
...
Call Trace:
 <TASK>
 smcr_buf_map_link+0x211/0x2a0 [smc]
 __smc_buf_create+0x522/0x970 [smc]
 smc_buf_create+0x3a/0x110 [smc]
 smc_find_rdma_v2_device_serv+0x18f/0x240 [smc]
 ? smc_vlan_by_tcpsk+0x7e/0xe0 [smc]
 smc_listen_find_device+0x1dd/0x2b0 [smc]
 smc_listen_work+0x30f/0x580 [smc]
 process_one_work+0x18c/0x340
 worker_thread+0x242/0x360
 kthread+0xe7/0x220
 ret_from_fork+0x13a/0x160
 ret_from_fork_asm+0x1a/0x30
 </TASK>

If the software RoCE device is used, ibdev->dma_device is a null pointer.
As a result, the problem occurs. Null pointer detection is added to
prevent problems.

Fixes: 0ef69e788411c ("net/smc: optimize for smc_sndbuf_sync_sg_for_device and smc_rmb_sync_sg_for_cpu")
Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 net/smc/smc_ib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 53828833a3f7..85501d2c1f1b 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -747,6 +747,8 @@ bool smc_ib_is_sg_need_sync(struct smc_link *lnk,
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


