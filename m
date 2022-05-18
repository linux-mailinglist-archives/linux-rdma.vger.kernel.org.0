Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE83A52B17B
	for <lists+linux-rdma@lfdr.de>; Wed, 18 May 2022 06:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiEREa0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 May 2022 00:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiEREaZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 May 2022 00:30:25 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE839558D;
        Tue, 17 May 2022 21:30:22 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AO6z1KaLevf6DZOUoFE+RJ5clxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHCx0msihTFVm2YbCmuCOPiLZmWnedx0bd/g8xkHvcWGx4NqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+MzvuRGuK59yMkj/nRHuOU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatTozGIjdBwytREs7S+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZ/EdoOCXeSjXXcu7iheun2HX6+92AUgsJooe+v56KW5?=
 =?us-ascii?q?L/P0cbjsKa3irlfO00qO5ELE03uwsKcDqOMUUvXQI5TXYC+s2BJPOWaPH4fdG0?=
 =?us-ascii?q?zoqwMNDB/DTY4weczUHRBDBZQBff00bDZsWguilnD/8fidepVbTorA4i0DRwwN?=
 =?us-ascii?q?ZwrngKNeTcdXieCn/ti50vUqfpyKgXE5cb4fZlFK4HruXrrentUvGtEg6TtVUL?=
 =?us-ascii?q?sJXvWA=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A0aC19q+o2NpiEQTsIR9uk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124307808"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 May 2022 12:30:21 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 1AF364D16FDF;
        Wed, 18 May 2022 12:30:20 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 18 May 2022 12:30:19 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 18 May 2022 12:30:19 +0800
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>, Bob Pearson <rpearsonhpe@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] RDMA/rxe: Use kzalloc() to alloc map_set
Date:   Wed, 18 May 2022 12:37:25 +0800
Message-ID: <20220518043725.771549-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 1AF364D16FDF.A0BF9
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Below call chains will alloc map_set without fully initializing map_set.
rxe_mr_init_fast()
 -> rxe_mr_alloc()
    -> rxe_mr_alloc_map_set()

Uninitialized values inside struct rxe_map_set are possible to cause
kernel panic.

It's noticed that crashes were caused by rnbd user cases, it can be
easily reproduced by:
$ while true; do echo "sessname=bla path=ip:<ip> device_path=<device>" > /sys/devices/virtual/rnbd-client/ctl/map_device; done

The backtraces are not always identical.
[1st]----------
[   80.158930] CPU: 0 PID: 11 Comm: ksoftirqd/0 Not tainted 5.18.0-rc1-roce-flush+ #60                                                                                                                                         [0/9090]
[   80.160736] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-27-g64f37cc530f1-prebuilt.qemu.org 04/01/2014
[   80.163579] RIP: 0010:lookup_iova+0x66/0xa0 [rdma_rxe]
[   80.164825] Code: 00 00 00 48 d3 ee 89 32 c3 4c 8b 18 49 8b 3b 48 8b 47 08 48 39 c6 72 38 48 29 c6 45 31 d2 b8 01 00 00 00 48 63 c8 48 c1 e1 04 <48> 8b 4c 0f 08 48 39 f1 77 21 83 c0 01 48 29 ce 3d 00 01 00 00 75
[   80.168935] RSP: 0018:ffffb7ff80063bf0 EFLAGS: 00010246
[   80.170333] RAX: 0000000000000000 RBX: ffff9b9949d86800 RCX: 0000000000000000
[   80.171976] RDX: ffffb7ff80063c00 RSI: 0000000049f6b378 RDI: 002818da00000004
[   80.173606] RBP: 0000000000000120 R08: ffffb7ff80063c08 R09: ffffb7ff80063c04
[   80.176933] R10: 0000000000000002 R11: ffff9b9916f7eef8 R12: ffff9b99488a0038
[   80.178526] R13: ffff9b99488a0038 R14: ffff9b9914fb346a R15: ffff9b990ab27000
[   80.180378] FS:  0000000000000000(0000) GS:ffff9b997dc00000(0000) knlGS:0000000000000000
[   80.182257] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   80.183577] CR2: 00007efc33a98ed0 CR3: 0000000014f32004 CR4: 00000000001706f0
[   80.185210] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   80.186890] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   80.188517] Call Trace:
[   80.189269]  <TASK>
[   80.189949]  rxe_mr_copy.part.0+0x6f/0x140 [rdma_rxe]
[   80.191173]  rxe_responder+0x12ee/0x1b60 [rdma_rxe]
[   80.192409]  ? rxe_icrc_check+0x7e/0x100 [rdma_rxe]
[   80.193576]  ? rxe_rcv+0x1d0/0x780 [rdma_rxe]
[   80.194668]  ? rxe_icrc_hdr.isra.0+0xf6/0x160 [rdma_rxe]
[   80.195952]  rxe_do_task+0x67/0xb0 [rdma_rxe]
[   80.197081]  rxe_xmit_packet+0xc7/0x210 [rdma_rxe]
[   80.198253]  rxe_requester+0x680/0xee0 [rdma_rxe]
[   80.199439]  ? update_load_avg+0x5f/0x690
[   80.200530]  ? update_load_avg+0x5f/0x690
[   80.213968]  ? rtrs_clt_recv_done+0x1b/0x30 [rtrs_client]

[2nd]----------
[ 5213.049494] RIP: 0010:rxe_mr_copy.part.0+0xa8/0x140 [rdma_rxe]
[ 5213.050978] Code: 00 00 49 c1 e7 04 48 8b 00 4c 8d 2c d0 48 8b 44 24 10 4d 03 7d 00 85 ed 7f 10 eb 6c 89 54 24 0c 49 83 c7 10 31 c0 85 ed 7e 5e <49> 8b 3f 8b 14 24 4c 89 f6 48 01 c7 85 d2 74 06 48 89 fe 4c 89 f7
[ 5213.056463] RSP: 0018:ffffae3580063bf8 EFLAGS: 00010202
[ 5213.057986] RAX: 0000000000018978 RBX: ffff9d7ef7a03600 RCX: 0000000000000008
[ 5213.059797] RDX: 000000000000007c RSI: 000000000000007c RDI: ffff9d7ef7a03600
[ 5213.061720] RBP: 0000000000000120 R08: ffffae3580063c08 R09: ffffae3580063c04
[ 5213.063532] R10: ffff9d7efece0038 R11: ffff9d7ec4b1db00 R12: ffff9d7efece0038
[ 5213.065445] R13: ffff9d7ef4098260 R14: ffff9d7f11e23c6a R15: 4c79500065708144
[ 5213.067264] FS:  0000000000000000(0000) GS:ffff9d7f3dc00000(0000) knlGS:0000000000000000
[ 5213.069442] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5213.071004] CR2: 00007fce47276c60 CR3: 0000000003f66004 CR4: 00000000001706f0
[ 5213.072827] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 5213.074484] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 5213.076292] Call Trace:
[ 5213.077027]  <TASK>
[ 5213.077718]  rxe_responder+0x12ee/0x1b60 [rdma_rxe]
[ 5213.079019]  ? rxe_icrc_check+0x7e/0x100 [rdma_rxe]
[ 5213.080380]  ? rxe_rcv+0x1d0/0x780 [rdma_rxe]
[ 5213.081708]  ? rxe_icrc_hdr.isra.0+0xf6/0x160 [rdma_rxe]
[ 5213.082990]  rxe_do_task+0x67/0xb0 [rdma_rxe]
[ 5213.084030]  rxe_xmit_packet+0xc7/0x210 [rdma_rxe]
[ 5213.085156]  rxe_requester+0x680/0xee0 [rdma_rxe]
[ 5213.088258]  ? update_load_avg+0x5f/0x690
[ 5213.089381]  ? update_load_avg+0x5f/0x690
[ 5213.090446]  ? rtrs_clt_recv_done+0x1b/0x30 [rtrs_client]
[ 5213.092087]  rxe_do_task+0x67/0xb0 [rdma_rxe]
[ 5213.093125]  tasklet_action_common.constprop.0+0x92/0xc0
[ 5213.094366]  __do_softirq+0xe1/0x2d8
[ 5213.095287]  run_ksoftirqd+0x21/0x30
[ 5213.096456]  smpboot_thread_fn+0x183/0x220
[ 5213.097519]  ? sort_range+0x20/0x20
[ 5213.098761]  kthread+0xe2/0x110
[ 5213.099638]  ? kthread_complete_and_exit+0x20/0x20
[ 5213.100948]  ret_from_fork+0x22/0x30

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 60a31b718774..bfd2d9db3deb 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -81,7 +81,7 @@ static int rxe_mr_alloc_map_set(int num_map, struct rxe_map_set **setp)
 	int i;
 	struct rxe_map_set *set;
 
-	set = kmalloc(sizeof(*set), GFP_KERNEL);
+	set = kzalloc(sizeof(*set), GFP_KERNEL);
 	if (!set)
 		goto err_out;
 
@@ -90,7 +90,7 @@ static int rxe_mr_alloc_map_set(int num_map, struct rxe_map_set **setp)
 		goto err_free_set;
 
 	for (i = 0; i < num_map; i++) {
-		set->map[i] = kmalloc(sizeof(struct rxe_map), GFP_KERNEL);
+		set->map[i] = kzalloc(sizeof(struct rxe_map), GFP_KERNEL);
 		if (!set->map[i])
 			goto err_free_map;
 	}
-- 
2.31.1



