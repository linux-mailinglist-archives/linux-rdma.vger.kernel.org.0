Return-Path: <linux-rdma+bounces-7-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9837F29F0
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 11:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE68B20EAF
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 10:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B163D38E;
	Tue, 21 Nov 2023 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="HDGFJub0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3CE9114;
	Tue, 21 Nov 2023 02:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ovQAt
	sQI9l5UyjC1/OJ9at0KgrMCeX296IrfvFS0X/g=; b=HDGFJub0GNmQXCCKSGMx5
	weiQj8gIlj5HeIYc5W9+1tTzV+qDteBb23U6SnrJ/dQ3SPelyD7G7atnSAhPpxAf
	ZZvLKHDw/NvSZZzRjjHVqlke77AUQpu2DteHuL8tdj/Q911VtpqvhzZNZoSM4EfO
	nwA/rHVlJtag2L4RYKyYbQ=
Received: from ubuntu.localdomain (unknown [111.222.250.119])
	by zwqz-smtp-mta-g3-1 (Coremail) with SMTP id _____wD3X_ybglxlh7GhCw--.38475S2;
	Tue, 21 Nov 2023 18:12:53 +0800 (CST)
From: Shifeng Li <lishifeng1992@126.com>
To: mustafa.ismail@intel.com,
	shiraz.saleem@intel.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	gustavoars@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dinghui@sangfor.com.cn,
	Shifeng Li <lishifeng1992@126.com>
Subject: [PATCH v3] RDMA/irdma: Fix UAF in irdma_sc_ccq_get_cqe_info()
Date: Tue, 21 Nov 2023 02:12:36 -0800
Message-Id: <20231121101236.581694-1-lishifeng1992@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X_ybglxlh7GhCw--.38475S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFy5tF1kCFy7GFyrJF4kXrb_yoW5WFyxpa
	45Gw1jvrZrJw42qayFy3WUKF98JFs8tF9F9a4Sk34fCr43Z3WFvF47KrW09FW5ua43Jr17
	JF1jgFn3ur45GrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_38nUUUUUU=
X-Originating-IP: [111.222.250.119]
X-CM-SenderInfo: xolvxx5ihqwiqzzsqiyswou0bp/1tbi1wYvr153c2EsXgAAsY

When removing the irdma driver or unplugging its aux device, the ccq
queue is released before destorying the cqp_cmpl_wq queue.
But in the window, there may still be completion events for wqes. That
will cause a UAF in irdma_sc_ccq_get_cqe_info().

[34693.333191] BUG: KASAN: use-after-free in irdma_sc_ccq_get_cqe_info+0x82f/0x8c0 [irdma]
[34693.333194] Read of size 8 at addr ffff889097f80818 by task kworker/u67:1/26327
[34693.333194]
[34693.333199] CPU: 9 PID: 26327 Comm: kworker/u67:1 Kdump: loaded Tainted: G           O     --------- -t - 4.18.0 #1
[34693.333200] Hardware name: SANGFOR Inspur/NULL, BIOS 4.1.13 08/01/2016
[34693.333211] Workqueue: cqp_cmpl_wq cqp_compl_worker [irdma]
[34693.333213] Call Trace:
[34693.333220]  dump_stack+0x71/0xab
[34693.333226]  print_address_description+0x6b/0x290
[34693.333238]  ? irdma_sc_ccq_get_cqe_info+0x82f/0x8c0 [irdma]
[34693.333240]  kasan_report+0x14a/0x2b0
[34693.333251]  irdma_sc_ccq_get_cqe_info+0x82f/0x8c0 [irdma]
[34693.333264]  ? irdma_free_cqp_request+0x151/0x1e0 [irdma]
[34693.333274]  irdma_cqp_ce_handler+0x1fb/0x3b0 [irdma]
[34693.333285]  ? irdma_ctrl_init_hw+0x2c20/0x2c20 [irdma]
[34693.333290]  ? __schedule+0x836/0x1570
[34693.333293]  ? strscpy+0x83/0x180
[34693.333296]  process_one_work+0x56a/0x11f0
[34693.333298]  worker_thread+0x8f/0xf40
[34693.333301]  ? __kthread_parkme+0x78/0xf0
[34693.333303]  ? rescuer_thread+0xc50/0xc50
[34693.333305]  kthread+0x2a0/0x390
[34693.333308]  ? kthread_destroy_worker+0x90/0x90
[34693.333310]  ret_from_fork+0x1f/0x40

Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitions")
Signed-off-by: Shifeng Li <lishifeng1992@126.com>
Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/hw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---
v1->v2: add Fixes line.
---
v2->v3: fix code conflicts.

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 8fa7e4a18e73..6b950926949e 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -581,9 +581,6 @@ static void irdma_destroy_cqp(struct irdma_pci_f *rf)
 	struct irdma_cqp *cqp = &rf->cqp;
 	int status = 0;
 
-	if (rf->cqp_cmpl_wq)
-		destroy_workqueue(rf->cqp_cmpl_wq);
-
 	status = irdma_sc_cqp_destroy(dev->cqp);
 	if (status)
 		ibdev_dbg(to_ibdev(dev), "ERR: Destroy CQP failed %d\n", status);
@@ -748,6 +745,9 @@ static void irdma_destroy_ccq(struct irdma_pci_f *rf)
 	struct irdma_ccq *ccq = &rf->ccq;
 	int status = 0;
 
+	if (rf->cqp_cmpl_wq)
+		destroy_workqueue(rf->cqp_cmpl_wq);
+
 	if (!rf->reset)
 		status = irdma_sc_ccq_destroy(dev->ccq, 0, true);
 	if (status)
-- 
2.25.1


