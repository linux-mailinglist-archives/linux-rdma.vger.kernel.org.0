Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3583A55763B
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jun 2022 11:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiFWJE2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Jun 2022 05:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiFWJE1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Jun 2022 05:04:27 -0400
X-Greylist: delayed 319 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Jun 2022 02:04:22 PDT
Received: from mail-m2835.qiye.163.com (mail-m2835.qiye.163.com [103.74.28.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A912CDC3
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jun 2022 02:04:22 -0700 (PDT)
Received: from localhost.localdomain (unknown [117.48.120.186])
        by mail-m2835.qiye.163.com (Hmail) with ESMTPA id F414D8A024B;
        Thu, 23 Jun 2022 16:59:00 +0800 (CST)
From:   Tao Liu <thomas.liu@ucloud.cn>
To:     linux-rdma@vger.kernel.org
Cc:     saeedm@nvidia.com, talgi@nvidia.com, leonro@nvidia.com,
        mgurtovoy@nvidia.com, jgg@nvidia.com, yaminf@nvidia.com,
        thomas.liu@ucloud.cn
Subject: [PATCH RFC net] linux/dim: Fix divide 0 in RDMA DIM.
Date:   Thu, 23 Jun 2022 16:58:58 +0800
Message-Id: <20220623085858.42945-1-thomas.liu@ucloud.cn>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZH0pIVk8aSU1OQh0fT0tKGlUZERMWGhIXJBQOD1
        lXWRgSC1lBWUpKTFVPQ1VKSUtVSkNNWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ok06Agw6MzIJExcKLSE#Qj85
        FklPCS1VSlVKTU5OQkxPTE9KTUpKVTMWGhIXVQ8TFBYaCFUXEg47DhgXFA4fVRgVRVlXWRILWUFZ
        SkpMVU9DVUpJS1VKQ01ZV1kIAVlBT0lPTzcG
X-HM-Tid: 0a818fc94476841dkuqwf414d8a024b
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We hit a divide 0 error in ofed 5.1.2.3.7.1. But dim.c and
rdma_dim.c seem same as upstream.

CallTrace:
  Hardware name: H3C R4900 G3/RS33M2C9S, BIOS 2.00.37P21 03/12/2020
  task: ffff880194b78000 task.stack: ffffc90006714000
  RIP: 0010:backport_rdma_dim+0x10e/0x240 [mlx_compat]
  RSP: 0018:ffff880c10e83ec0 EFLAGS: 00010202
  RAX: 0000000000002710 RBX: ffff88096cd7f780 RCX: 0000000000000064
  RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
  RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000000 R12: 000000001d7c6c09
  R13: ffff88096cd7f780 R14: ffff880b174fe800 R15: 0000000000000000
  FS:  0000000000000000(0000) GS:ffff880c10e80000(0000)
  knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00000000a0965b00 CR3: 000000000200a003 CR4: 00000000007606e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  PKRU: 55555554
  Call Trace:
   <IRQ>
   ib_poll_handler+0x43/0x80 [ib_core]
   irq_poll_softirq+0xae/0x110
   __do_softirq+0xd1/0x28c
   irq_exit+0xde/0xf0
   do_IRQ+0x54/0xe0
   common_interrupt+0x8f/0x8f
   </IRQ>
   ? cpuidle_enter_state+0xd9/0x2a0
   ? cpuidle_enter_state+0xc7/0x2a0
   ? do_idle+0x170/0x1d0
   ? cpu_startup_entry+0x6f/0x80
   ? start_secondary+0x1b9/0x210
   ? secondary_startup_64+0xa5/0xb0
  Code: 0f 87 e1 00 00 00 8b 4c 24 14 44 8b 43 14 89 c8 4d 63 c8 44 29 c0 99 31 d0 29 d0 31 d2 48 98 48 8d 04 80 48 8d 04 80 48 c1 e0 02 <49> f7 f1 48 83 f8 0a 0f 86 c1 00 00 00 44 39 c1 7f 10 48 89 df
  RIP: backport_rdma_dim+0x10e/0x240 [mlx_compat] RSP: ffff880c10e83ec0

crash> struct dim ffff88096cd7f780
struct dim {
  state = 1 '\001',
  prev_stats = {
      ppms = 2142150514,
      bpms = 391112768,
      epms = -30709,
      cpms = 1,
      cpe_ratio = 0
    },
  start_sample = {
      time = 51174507127193614,
      pkt_ctr = 0,
      byte_ctr = 0,
      event_ctr = 1,
      comp_ctr = 494693321
    },
  measuring_sample = {
      time = 51174507266581985,
      pkt_ctr = 0,
      byte_ctr = 0,
      event_ctr = 65,
      comp_ctr = 494693385
    },
  work = {
      data = {
            counter = 128
          },
      entry = {
            next = 0xffff88096cd7f7d0,
            prev = 0xffff88096cd7f7d0
          },
      func = 0xffffffffa02b9f80
    },
  priv = 0xffff880b174fe800,
  profile_ix = 1 '\001',
  mode = 0 '\000',
  tune_state = 2 '\002',
  steps_right = 1 '\001',
  steps_left = 1 '\001',
  tired = 0 '\000'
}

Fixes: f4915455dcf0 ("linux/dim: Implement RDMA adaptive moderation (DIM)")
Signed-off-by: Tao Liu <thomas.liu@ucloud.cn>
---
 lib/dim/rdma_dim.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/dim/rdma_dim.c b/lib/dim/rdma_dim.c
index 15462d54758d..a657b106343c 100644
--- a/lib/dim/rdma_dim.c
+++ b/lib/dim/rdma_dim.c
@@ -34,6 +34,9 @@ static int rdma_dim_stats_compare(struct dim_stats *curr,
 		return (curr->cpms > prev->cpms) ? DIM_STATS_BETTER :
 						DIM_STATS_WORSE;
 
+	if (!prev->cpe_ratio)
+		return DIM_STATS_SAME;
+
 	if (IS_SIGNIFICANT_DIFF(curr->cpe_ratio, prev->cpe_ratio))
 		return (curr->cpe_ratio > prev->cpe_ratio) ? DIM_STATS_BETTER :
 						DIM_STATS_WORSE;
-- 
2.30.1 (Apple Git-130)

