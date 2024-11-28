Return-Path: <linux-rdma+bounces-6143-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2B59DB747
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2024 13:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE7FB214BF
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2024 12:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3777A19C558;
	Thu, 28 Nov 2024 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OnkuTnvU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D16819ADBF;
	Thu, 28 Nov 2024 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796093; cv=none; b=u5+8CyobYa/N8pZFwF0QVzQDrP7+kVv8J0O1nGU2CB2IpEXlUTNLAHtwyBBaPv5SZZenPc4OKWOLDmlqQAuC2qKJUsj03CnhtqGw6bij6+bVOW6ZzFRskXa6gVTO+oRb5fOVO29eY/PwbZe/4zHqz+Hl90qGf8jPFOIklSXW+5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796093; c=relaxed/simple;
	bh=a2nBastnrCJ+Q8H/sRyw6AmS0iybgPTtu8YvzJdxEl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SyzRTJtotBMn1NWxggjHaohpBpiVdj28JCBQQJAEFkOMIv5U1+xIK+vUY9K2VlVRB1P96CoyPhsax/kR+VGjpyaQsJW8Orqie0IVMPWpUknmGm19U62diCp+VIget6mDUCaSCE/hC/bUyQFCoXWrEf8EYHiVhVtJKJZlnFLM1E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OnkuTnvU; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732796087; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=BTRNYGHrd82xYJL1vADKA/NPF30Dt6eN5hXvBItCJ9o=;
	b=OnkuTnvUsZ9ZzVWfcFw+ey97p85Xf+KQROX/5bMhmD5HrkmINW9x0rnkEf7ubEI5rTSRB18W5jmCuYr6QPdfO9H4Mwxwn1wv6TD9qZFR38I9HXuYaoXrwbV7R8OhniX5qSKkMlR0SRXiXmTY/WoRHzef3Iiz08lqT9cK0FbxrAw=
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WKQ-9TN_1732796086 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 20:14:46 +0800
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/6] net/smc: protect link down work from execute after lgr freed
Date: Thu, 28 Nov 2024 20:14:30 +0800
Message-Id: <20241128121435.73071-2-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20241128121435.73071-1-guangguan.wang@linux.alibaba.com>
References: <20241128121435.73071-1-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

link down work may be scheduled before lgr freed but execute
after lgr freed, which may result in crash. So it is need to
hold a reference before shedule link down work, and put the
reference after work executed or canceled.

The relevant crash call stack as follows:
 list_del corruption. prev->next should be ffffb638c9c0fe20,
    but was 0000000000000000
 ------------[ cut here ]------------
 kernel BUG at lib/list_debug.c:51!
 invalid opcode: 0000 [#1] SMP NOPTI
 CPU: 6 PID: 978112 Comm: kworker/6:119 Kdump: loaded Tainted: G #1
 Hardware name: Alibaba Cloud Alibaba Cloud ECS, BIOS 2221b89 04/01/2014
 Workqueue: events smc_link_down_work [smc]
 RIP: 0010:__list_del_entry_valid.cold+0x31/0x47
 RSP: 0018:ffffb638c9c0fdd8 EFLAGS: 00010086
 RAX: 0000000000000054 RBX: ffff942fb75e5128 RCX: 0000000000000000
 RDX: ffff943520930aa0 RSI: ffff94352091fc80 RDI: ffff94352091fc80
 RBP: 0000000000000000 R08: 0000000000000000 R09: ffffb638c9c0fc38
 R10: ffffb638c9c0fc30 R11: ffffffffa015eb28 R12: 0000000000000002
 R13: ffffb638c9c0fe20 R14: 0000000000000001 R15: ffff942f9cd051c0
 FS:  0000000000000000(0000) GS:ffff943520900000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f4f25214000 CR3: 000000025fbae004 CR4: 00000000007706e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  rwsem_down_write_slowpath+0x17e/0x470
  smc_link_down_work+0x3c/0x60 [smc]
  process_one_work+0x1ac/0x350
  worker_thread+0x49/0x2f0
  ? rescuer_thread+0x360/0x360
  kthread+0x118/0x140
  ? __kthread_bind_mask+0x60/0x60
  ret_from_fork+0x1f/0x30

Fixes: 541afa10c126 ("net/smc: add smcr_port_err() and smcr_link_down() processing")
Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
---
 net/smc/smc_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 500952c2e67b..3b125d348b4a 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1818,7 +1818,9 @@ void smcr_link_down_cond_sched(struct smc_link *lnk)
 {
 	if (smc_link_downing(&lnk->state)) {
 		trace_smcr_link_down(lnk, __builtin_return_address(0));
-		schedule_work(&lnk->link_down_wrk);
+		smcr_link_hold(lnk); /* smcr_link_put in link_down_wrk */
+		if (!schedule_work(&lnk->link_down_wrk))
+			smcr_link_put(lnk);
 	}
 }
 
@@ -1850,11 +1852,14 @@ static void smc_link_down_work(struct work_struct *work)
 	struct smc_link_group *lgr = link->lgr;
 
 	if (list_empty(&lgr->list))
-		return;
+		goto out;
 	wake_up_all(&lgr->llc_msg_waiter);
 	down_write(&lgr->llc_conf_mutex);
 	smcr_link_down(link);
 	up_write(&lgr->llc_conf_mutex);
+
+out:
+	smcr_link_put(link); /* smcr_link_hold by schedulers of link_down_work */
 }
 
 static int smc_vlan_by_tcpsk_walk(struct net_device *lower_dev,
-- 
2.24.3 (Apple Git-128)


