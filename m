Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D4946068E
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Nov 2021 14:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhK1NlH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Nov 2021 08:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbhK1NjG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Nov 2021 08:39:06 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84039C061757
        for <linux-rdma@vger.kernel.org>; Sun, 28 Nov 2021 05:35:50 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638106547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6L6G74dV7Aj9Zzs29cPaXwQHqjtomNihY5daHvQU0+Y=;
        b=ARenOvxOHspig6TkEJRxAn+JFRQRGoKCdFKam40GDgTmVGkIoQG4aSPiMI19q5c4CwApBJ
        kqaVfz6FoqgzXHeZ/Wze9FckdT/g+hWPc9Y4wxedaf7pLf0i/WxpOvj62wzpzsLl9S2el+
        UrxvrUjmC6to0dvnLKny3R+yeQOp5CA=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     jinpu.wang@ionos.com, haris.iqbal@ionos.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V2] RDMA/rtrs: Call {get,put}_cpu_ptr to silence a debug kernel warning
Date:   Sun, 28 Nov 2021 21:35:01 +0800
Message-Id: <20211128133501.38710-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

With preemption enabled (CONFIG_DEBUG_PREEMPT=y), the following appeared
when rnbd client tries to map remote block device.

[ 2123.221071] BUG: using smp_processor_id() in preemptible [00000000] code: bash/1733
[ 2123.221175] caller is debug_smp_processor_id+0x17/0x20
[ 2123.221214] CPU: 0 PID: 1733 Comm: bash Not tainted 5.16.0-rc1 #5
[ 2123.221218] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
[ 2123.221229] Call Trace:
[ 2123.221231]  <TASK>
[ 2123.221235]  dump_stack_lvl+0x5d/0x78
[ 2123.221252]  dump_stack+0x10/0x12
[ 2123.221257]  check_preemption_disabled+0xe4/0xf0
[ 2123.221266]  debug_smp_processor_id+0x17/0x20
[ 2123.221271]  rtrs_clt_update_all_stats+0x3b/0x70 [rtrs_client]
[ 2123.221285]  rtrs_clt_read_req+0xc3/0x380 [rtrs_client]
[ 2123.221298]  ? rtrs_clt_init_req+0xe3/0x120 [rtrs_client]
[ 2123.221321]  rtrs_clt_request+0x1a7/0x320 [rtrs_client]
[ 2123.221340]  ? 0xffffffffc0ab1000
[ 2123.221357]  send_usr_msg+0xbf/0x160 [rnbd_client]
[ 2123.221370]  ? rnbd_clt_put_sess+0x60/0x60 [rnbd_client]
[ 2123.221377]  ? send_usr_msg+0x160/0x160 [rnbd_client]
[ 2123.221386]  ? sg_alloc_table+0x27/0xb0
[ 2123.221395]  ? sg_zero_buffer+0xd0/0xd0
[ 2123.221407]  send_msg_sess_info+0xe9/0x180 [rnbd_client]
[ 2123.221413]  ? rnbd_clt_put_sess+0x60/0x60 [rnbd_client]
[ 2123.221429]  ? blk_mq_alloc_tag_set+0x2ef/0x370
[ 2123.221447]  rnbd_clt_map_device+0xba8/0xcd0 [rnbd_client]
[ 2123.221462]  ? send_msg_open+0x200/0x200 [rnbd_client]
[ 2123.221479]  rnbd_clt_map_device_store+0x3e5/0x620 [rnbd_client

To supress the calltrace, let's call get_cpu_ptr/put_cpu_ptr pair in
rtrs_clt_update_rdma_stats to disable preemption when accessing per-cpu
variable.

While at it, let's make the similar change in rtrs_clt_update_wc_stats.
And for rtrs_clt_inc_failover_cnt, though it was only called inside rcu
section, but it still can be preempted in case CONFIG_PREEMPT_RCU is
enabled, so change it to {get,put}_cpu_ptr pair either.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
V2: also make the change in rtrs_clt_update_wc_stats and rtrs_clt_inc_failover_cnt

 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
index f7e459fe68be..76e4352fe3f6 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
@@ -19,7 +19,7 @@ void rtrs_clt_update_wc_stats(struct rtrs_clt_con *con)
 	int cpu;
 
 	cpu = raw_smp_processor_id();
-	s = this_cpu_ptr(stats->pcpu_stats);
+	s = get_cpu_ptr(stats->pcpu_stats);
 	if (con->cpu != cpu) {
 		s->cpu_migr.to++;
 
@@ -27,14 +27,16 @@ void rtrs_clt_update_wc_stats(struct rtrs_clt_con *con)
 		s = per_cpu_ptr(stats->pcpu_stats, con->cpu);
 		atomic_inc(&s->cpu_migr.from);
 	}
+	put_cpu_ptr(stats->pcpu_stats);
 }
 
 void rtrs_clt_inc_failover_cnt(struct rtrs_clt_stats *stats)
 {
 	struct rtrs_clt_stats_pcpu *s;
 
-	s = this_cpu_ptr(stats->pcpu_stats);
+	s = get_cpu_ptr(stats->pcpu_stats);
 	s->rdma.failover_cnt++;
+	put_cpu_ptr(stats->pcpu_stats);
 }
 
 int rtrs_clt_stats_migration_from_cnt_to_str(struct rtrs_clt_stats *stats, char *buf)
@@ -169,9 +171,10 @@ static inline void rtrs_clt_update_rdma_stats(struct rtrs_clt_stats *stats,
 {
 	struct rtrs_clt_stats_pcpu *s;
 
-	s = this_cpu_ptr(stats->pcpu_stats);
+	s = get_cpu_ptr(stats->pcpu_stats);
 	s->rdma.dir[d].cnt++;
 	s->rdma.dir[d].size_total += size;
+	put_cpu_ptr(stats->pcpu_stats);
 }
 
 void rtrs_clt_update_all_stats(struct rtrs_clt_io_req *req, int dir)
-- 
2.31.1

