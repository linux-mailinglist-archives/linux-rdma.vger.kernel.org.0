Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D596ED982
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Apr 2023 03:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjDYBEr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Apr 2023 21:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjDYBEo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Apr 2023 21:04:44 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F311AB466;
        Mon, 24 Apr 2023 18:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1682384668; i=@fujitsu.com;
        bh=XiPmUIcnpC67EW2xDlvmyVNqcX5XwDgK3HHE7LKvKWQ=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=IfWKvI+U9PCZre//3RrFN8sJEfp+rOwVpD+zPQV2f64UZpS83FaeEHoFgWYW/nneF
         rY/OPw8LbJeKG9PCSrlYh/9rsRAKo+mVU57XrU9Ihvzga1Ttc92xxY0fYarNXLz11v
         oZsF/LT8HCg/7zmuTNqNq2Hc45Yqf1ZblhyZtbUj70BQYm65eARetH63NnZg101ZT5
         0mLEbb4BzGQen9Qx6wR5giQBG/69Smt2XA0YPvgErm8BrPbY8bjkEjl43q9d8V44aw
         EoWtWkcS3bU/S/lg/jsQ4sFnp2bSUVFMMIqFF+Srm+t6k2j3STqEfnvUCHL1LWO2+g
         0bkj8l0uE4seg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleJIrShJLcpLzFFi42Kxs+GYpCut7p5
  i8HSRtsWNaXIW205vYLeYOeMEo8XbTVNYLKb8WspscXnXHDaLZ4d6WRzYPU6/ucPksWlVJ5vH
  woapzB6fN8l5bP18myWANYo1My8pvyKBNePO2fnMBVuMKxr2dDA1MB7X7mLk4hAS2MIo0X70O
  2MXIyeQs4JJov+FHYR9kFHixdtEEJtNQEPiXstNsBoRgSCJpWteM4E0Mwu0MkocaZrEDJIQFn
  CT2HtuLWsXIwcHi4CqxKFdfCBhXgFHidc7b7KB2BICChJTHr4HK+cUcJLY9LaTDWKXo8SUzTd
  YIOoFJU7OfAJmMwtISBx88YIZoldJ4uLXO6wQdqVE64dfLBC2msTVc5uYJzAKzkLSPgtJ+wJG
  plWMpsWpRWWpRbrGeklFmekZJbmJmTl6iVW6iXqppbrlqcUlukZ6ieXFeqnFxXrFlbnJOSl6e
  aklmxiBkZFSrCy3g/H0zr96hxglOZiURHm5wtxShPiS8lMqMxKLM+KLSnNSiw8xynBwKEnwXl
  B1TxESLEpNT61Iy8wBRilMWoKDR0mEd6kSUJq3uCAxtzgzHSJ1ilGXY8ODA3uZhVjy8vNSpcR
  5ZUFmCIAUZZTmwY2AJYxLjLJSwryMDAwMQjwFqUW5mSWo8q8YxTkYlYR5I9WApvBk5pXAbXoF
  dAQT0BG7uF1AjihJREhJNTDJq381edb179q86ZpvIv9d6pErNbE78FlF4rlfTsqN9Xabe3fdP
  yWSOSHxdIm//qnDByYt6EzW0v539W2UpF3o56yP71VOsTh7OBoJhEfmt/xw5dwvLnCJ/4yzKg
  /vsvOr3q+d+shq/tplXVfWzeSvvPvPMYX7r9Lf+edUeOe2ycy14u97U6NQ8eQQg4FgcU8cq3O
  McMSu6uti7x4wiXqs6tCYUDFp05aJkp8sSics+ipi+sFyma1x9PcyEb70E4qpmgrenw64nvpb
  keAr+c9xz5JVyZz6HSoOnkYmlTNyo7OOKB8J4LxyS2j6gufyV82OqxVpT+tlr32/ddPBrz3LT
  f5o1i4XOVIb6Bf3mUeJpTgj0VCLuag4EQDHlm86kwMAAA==
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-6.tower-571.messagelabs.com!1682384667!30602!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8624 invoked from network); 25 Apr 2023 01:04:27 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-6.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Apr 2023 01:04:27 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 602E41000DB;
        Tue, 25 Apr 2023 02:04:27 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 534CC100349;
        Tue, 25 Apr 2023 02:04:27 +0100 (BST)
Received: from 0819309620d6.localdomain (10.167.234.230) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 25 Apr 2023 02:04:24 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <haris.iqbal@ionos.com>, <jinpu.wang@ionos.com>,
        <linux-rdma@vger.kernel.org>
CC:     <jgg@ziepe.ca>, <leon@kernel.org>, <guoqing.jiang@linux.dev>,
        <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next v3 3/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Date:   Tue, 25 Apr 2023 01:02:43 +0000
Message-ID: <1682384563-2-4-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1682384563-2-1-git-send-email-lizhijian@fujitsu.com>
References: <1682384563-2-1-git-send-email-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.234.230]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In current design:
1. PD and clt_path->s.dev are shared among connections.
2. every con[n]'s cleanup phase will call destroy_con_cq_qp()
3. clt_path->s.dev will be always decreased in destroy_con_cq_qp(), and
   when clt_path->s.dev become zero, it will destroy PD.
4. when con[1] failed to create, con[1] will not take clt_path->s.dev,
   but it try to decreased clt_path->s.dev

So, in case create_cm(con[0]) succeeds but create_cm(con[1])
fails, destroy_con_cq_qp(con[1]) will be called first which will destory
the PD while this PD is still taken by con[0].

Here, we refactor the error path of create_cm() and init_conns(), so that
we do the cleanup in the order they are created.

The warning occurs when destroying RXE PD whose reference count is not
zero.
-----------------------------------------------
 rnbd_client L597: Mapping device /dev/nvme0n1 on session client, (access_mode: rw, nr_poll_queues: 0)
 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 26407 at drivers/infiniband/sw/rxe/rxe_pool.c:256 __rxe_cleanup+0x13a/0x170 [rdma_rxe]
 Modules linked in: rpcrdma rdma_ucm ib_iser rnbd_client libiscsi rtrs_client scsi_transport_iscsi rtrs_core rdma_cm iw_cm ib_cm crc32_generic rdma_rxe udp_tunnel ib_uverbs ib_core kmem device_dax nd_pmem dax_pmem nd_
vme crc32c_intel fuse nvme_core nfit libnvdimm dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_mirror dm_region_hash dm_log dm_mod
 CPU: 0 PID: 26407 Comm: rnbd-client.sh Kdump: loaded Not tainted 6.2.0-rc6-roce-flush+ #53
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
 RIP: 0010:__rxe_cleanup+0x13a/0x170 [rdma_rxe]
 Code: 45 84 e4 0f 84 5a ff ff ff 48 89 ef e8 5f 18 71 f9 84 c0 75 90 be c8 00 00 00 48 89 ef e8 be 89 1f fa 85 c0 0f 85 7b ff ff ff <0f> 0b 41 bc ea ff ff ff e9 71 ff ff ff e8 84 7f 1f fa e9 d0 fe ff
 RSP: 0018:ffffb09880b6f5f0 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ffff99401f15d6a8 RCX: 0000000000000000
 RDX: 0000000000000001 RSI: ffffffffbac8234b RDI: 00000000ffffffff
 RBP: ffff99401f15d6d0 R08: 0000000000000001 R09: 0000000000000001
 R10: 0000000000002d82 R11: 0000000000000000 R12: 0000000000000001
 R13: ffff994101eff208 R14: ffffb09880b6f6a0 R15: 00000000fffffe00
 FS:  00007fe113904740(0000) GS:ffff99413bc00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007ff6cde656c8 CR3: 000000001f108004 CR4: 00000000001706f0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  rxe_dealloc_pd+0x16/0x20 [rdma_rxe]
  ib_dealloc_pd_user+0x4b/0x80 [ib_core]
  rtrs_ib_dev_put+0x79/0xd0 [rtrs_core]
  destroy_con_cq_qp+0x8a/0xa0 [rtrs_client]
  init_path+0x1e7/0x9a0 [rtrs_client]
  ? __pfx_autoremove_wake_function+0x10/0x10
  ? lock_is_held_type+0xd7/0x130
  ? rcu_read_lock_sched_held+0x43/0x80
  ? pcpu_alloc+0x3dd/0x7d0
  ? rtrs_clt_init_stats+0x18/0x40 [rtrs_client]
  rtrs_clt_open+0x24f/0x5a0 [rtrs_client]
  ? __pfx_rnbd_clt_link_ev+0x10/0x10 [rnbd_client]
  rnbd_clt_map_device+0x6a5/0xe10 [rnbd_client]

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Tested-by: Jack Wang <jinpu.wang@ionos.com>
---
V3: comment minor fixes and add acked/tested tags
V2: refactor error path instead of introducing a new flag #Leon
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 55 +++++++++++---------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index c2065fc33a56..fe3507d29728 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2039,6 +2039,7 @@ static int rtrs_clt_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	return 0;
 }
 
+/* The caller should do the cleanup in case of error */
 static int create_cm(struct rtrs_clt_con *con)
 {
 	struct rtrs_path *s = con->c.path;
@@ -2061,14 +2062,14 @@ static int create_cm(struct rtrs_clt_con *con)
 	err = rdma_set_reuseaddr(cm_id, 1);
 	if (err != 0) {
 		rtrs_err(s, "Set address reuse failed, err: %d\n", err);
-		goto destroy_cm;
+		return err;
 	}
 	err = rdma_resolve_addr(cm_id, (struct sockaddr *)&clt_path->s.src_addr,
 				(struct sockaddr *)&clt_path->s.dst_addr,
 				RTRS_CONNECT_TIMEOUT_MS);
 	if (err) {
 		rtrs_err(s, "Failed to resolve address, err: %d\n", err);
-		goto destroy_cm;
+		return err;
 	}
 	/*
 	 * Combine connection status and session events. This is needed
@@ -2083,29 +2084,15 @@ static int create_cm(struct rtrs_clt_con *con)
 		if (err == 0)
 			err = -ETIMEDOUT;
 		/* Timedout or interrupted */
-		goto errr;
-	}
-	if (con->cm_err < 0) {
-		err = con->cm_err;
-		goto errr;
+		return err;
 	}
-	if (READ_ONCE(clt_path->state) != RTRS_CLT_CONNECTING) {
+	if (con->cm_err < 0)
+		return con->cm_err;
+	if (READ_ONCE(clt_path->state) != RTRS_CLT_CONNECTING)
 		/* Device removal */
-		err = -ECONNABORTED;
-		goto errr;
-	}
+		return -ECONNABORTED;
 
 	return 0;
-
-errr:
-	stop_cm(con);
-	mutex_lock(&con->con_mutex);
-	destroy_con_cq_qp(con);
-	mutex_unlock(&con->con_mutex);
-destroy_cm:
-	destroy_cm(con);
-
-	return err;
 }
 
 static void rtrs_clt_path_up(struct rtrs_clt_path *clt_path)
@@ -2333,7 +2320,7 @@ static void rtrs_clt_close_work(struct work_struct *work)
 static int init_conns(struct rtrs_clt_path *clt_path)
 {
 	unsigned int cid;
-	int err;
+	int err, i;
 
 	/*
 	 * On every new session connections increase reconnect counter
@@ -2349,10 +2336,8 @@ static int init_conns(struct rtrs_clt_path *clt_path)
 			goto destroy;
 
 		err = create_cm(to_clt_con(clt_path->s.con[cid]));
-		if (err) {
-			destroy_con(to_clt_con(clt_path->s.con[cid]));
+		if (err)
 			goto destroy;
-		}
 	}
 	err = alloc_path_reqs(clt_path);
 	if (err)
@@ -2363,15 +2348,21 @@ static int init_conns(struct rtrs_clt_path *clt_path)
 	return 0;
 
 destroy:
-	while (cid--) {
-		struct rtrs_clt_con *con = to_clt_con(clt_path->s.con[cid]);
+	/* Make sure we do the cleanup in the order they are created */
+	for (i = 0; i <= cid; i++) {
+		struct rtrs_clt_con *con;
 
-		stop_cm(con);
+		if (!clt_path->s.con[i])
+			break;
 
-		mutex_lock(&con->con_mutex);
-		destroy_con_cq_qp(con);
-		mutex_unlock(&con->con_mutex);
-		destroy_cm(con);
+		con = to_clt_con(clt_path->s.con[i]);
+		if (con->c.cm_id) {
+			stop_cm(con);
+			mutex_lock(&con->con_mutex);
+			destroy_con_cq_qp(con);
+			mutex_unlock(&con->con_mutex);
+			destroy_cm(con);
+		}
 		destroy_con(con);
 	}
 	/*
-- 
2.29.2

