Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78796EBC44
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Apr 2023 03:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjDWB1x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 Apr 2023 21:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjDWB1r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 22 Apr 2023 21:27:47 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CA62D4A;
        Sat, 22 Apr 2023 18:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1682213258; i=@fujitsu.com;
        bh=ArEqZg01CIzD1/2GU0ybWAlHXF623y9oL1BtSuhWxkk=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=u4A5do4YdBmUpr436+OYAik66NbsYzYoC7fkOa8LBCazGjJUZJc2+2ltq4KgsMO2O
         3PryzU4yACoCi0VN0nzPcFerRg5e7CPyNVL1HNeaUvGVoynvbff/V2bgIPS6Yi8nlU
         ZfpYF+8VZIkXkYjadVYdpRVZiqY6FyzpBNlOvm2MqR4cVr4A8DJsvj8b4pi/gMqo1U
         vTdeVcSHak8DSSh50dy82rTqxdYmeKO0jWBP8FyyZsx8F7T3K7ZNzsBkz7dDX5cPS5
         BPaTf/GPV1O+infY1RF0SF0h1U1DtbGFch7zZypvy4gI8WdCKMy9nkd+cryu1zg6V4
         inoz5P04Ukn+g==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleJIrShJLcpLzFFi42Kxs+FI0m3vdEk
  xWPCb1+LGNDmLbac3sFvMnHGC0eLtpiksFlN+LWW2uLxrDpvFs0O9LA7sHqff3GHy2LSqk81j
  YcNUZo/Pm+Q8tn6+zRLAGsWamZeUX5HAmrHv6BOWgvVGFctuHGNuYLyo1cXIxSEksJFR4nL/f
  UYIZymTRN+be+xdjJxAzgFGiSe3pUFsNgENiXstNxlBbBGBUonDbfvAapgFkiTm3X7LDGILC7
  hJ/L4+ByzOIqAq8WBFA1g9r4CjxONPq9lAbAkBBYkpD9+D1XMKOEksv/6QCWKXo8SFaWug6gU
  lTs58wgIxX0Li4IsXzBC9ihJHOv+yQNiVEq0ffkHZahJXz21insAoOAtJ+ywk7QsYmVYxmhan
  FpWlFula6iUVZaZnlOQmZuboJVbpJuqlluqWpxaX6BrqJZYX66UWF+sVV+Ym56To5aWWbGIEx
  kZKMZvADsa5u/7qHWKU5GBSEuV9sdshRYgvKT+lMiOxOCO+qDQntfgQowwHh5IE78c2lxQhwa
  LU9NSKtMwcYJzCpCU4eJREeLeWAaV5iwsSc4sz0yFSpxh1OTY8OLCXWYglLz8vVUqcd0oHUJE
  ASFFGaR7cCFjKuMQoKyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmFcPZApPZl4J3KZXQEcwAR2x
  ixvsiJJEhJRUA9NmyYMPdQKXLf6ZJj09o9O87waz2I+OGmYZt5e3H0wWZfl8v2VWbvANjwOXb
  Uxcfq3Xv+TLGRv5Qvv2a/2wVxLbOtcLl8muuhMsL8Qb90E3bRLXr5NOj1Y4ORv39/d+c4yZz3
  egq+TCRDXdpQsUI8TfH3rudfHthvplK7gXd7ZFJS65aerjZ+srGVwZqfv595Jvs6/7Lxbi+ZX
  LsvjeLh/lW7tC3obelt/6k1v+75nZan5+cxuUBP4Ff52kvmWaie4FIYFVuTM/a78L/56//JbD
  td3JfeJF2knnWvxP2P71lpUxO5/AX9jTNIfxzz5mndcvLU42HXVPiXeOebLHaGFvmKk6exDT3
  gmy3A4hFkosxRmJhlrMRcWJAPrusouUAwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-9.tower-585.messagelabs.com!1682213254!65639!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5044 invoked from network); 23 Apr 2023 01:27:35 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-9.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 23 Apr 2023 01:27:35 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id BD2561D0;
        Sun, 23 Apr 2023 02:27:34 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id B06281B6;
        Sun, 23 Apr 2023 02:27:34 +0100 (BST)
Received: from d3e152dc4f88.localdomain (10.167.226.45) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Sun, 23 Apr 2023 02:27:31 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <haris.iqbal@ionos.com>, <jinpu.wang@ionos.com>, <jgg@ziepe.ca>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <guoqing.jiang@linux.dev>, <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next v2 3/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Date:   Sun, 23 Apr 2023 01:26:52 +0000
Message-ID: <1682213212-2-4-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1682213212-2-1-git-send-email-lizhijian@fujitsu.com>
References: <1682213212-2-1-git-send-email-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
---
V2: refactor error path instead of introducing a new flag #Leon
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 55 +++++++++++---------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index c2065fc33a56..5234be5c6bf8 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2039,6 +2039,7 @@ static int rtrs_clt_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	return 0;
 }
 
+/* The caller should the do the cleanup in case of error */
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

