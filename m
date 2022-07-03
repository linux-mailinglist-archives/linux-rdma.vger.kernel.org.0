Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D48564881
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Jul 2022 17:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiGCP4c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 3 Jul 2022 11:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiGCP4c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 3 Jul 2022 11:56:32 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B232BBBF
        for <linux-rdma@vger.kernel.org>; Sun,  3 Jul 2022 08:56:30 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3A/OVbWa6FA3ux+o5QyY7RVwxRtNjFchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS3jcHmjdKDG7XMqzfYmT2eN4gYN628kpQv8OHnNYyQVc5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9YtANkVEmjfvSHuCkUba?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hgwdNCpdqyW?=
 =?us-ascii?q?C8nI6/NhP8AFRJfFkmSOIUfouCefCfg75D7I0ruNiGEL+9VJFsuMIQC4eFxAXl?=
 =?us-ascii?q?D3fMdITEJKBuEgoqe0qO5WPhu3Jx7dOHkOYoevjdryjSxJfIrRpbrQKjQ49Jcm?=
 =?us-ascii?q?jAqiahmGffYetpcczZqZTzebBBVfFQaEpQzmKGvnHaXWz9Xp3qHpKcv7i7YxWR?=
 =?us-ascii?q?MPBLFWDbOUoXSA5wLwQDD/SSbl1kVyyoybLS3oQdpOFr17gMXoR7GZQ=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AgJByWaNG1ziAtcBcTv2jsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TEUdfUxSKGlfq+V8sjzqiWftN98YhAdcLO7Scy9qBHnhP1ICOAqVN/MYOCMgh?=
 =?us-ascii?q?rLEGgN1+vf6gylMyj/28oY7q14bpV5YeeaMXFKyer8/ym0euxN/OW6?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="127157764"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Jul 2022 23:56:29 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 21E704D1719E;
        Sun,  3 Jul 2022 23:56:28 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 3 Jul 2022 23:56:30 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 3 Jul 2022 23:56:29 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <leon@kernel.org>, <jgg@ziepe.ca>, <rpearsonhpe@gmail.com>,
        <zyjzyj2000@gmail.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH] RDMA/rxe: Process received packets in time
Date:   Sun, 3 Jul 2022 23:56:25 +0800
Message-ID: <20220703155625.14497-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 21E704D1719E.A92C8
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If received packets (i.e. skb) stored in qp->resp_pkts
cannot be processed in time, they may be ovewritten/reused
and then lead to abnormal behavior.

For example, running test_qp_ex_rc_atomic_cmp_swp always
reproduced a panic on my slow vm:
--------------------------------------------------------
[39867.797693] rdma_rxe: qp#17 state = GET ACK
[39867.800667] rdma_rxe: qp#17 state = GET WQE
[39867.800722] rdma_rxe: qp#17 state = CHECK PSN
[39867.800739] rdma_rxe: qp#17 state = CHECK ACK
[39867.800776] rdma_rxe: unexpected opcode
[39867.800790] rdma_rxe: qp#17 state = ERROR
...
[39867.822361] BUG: kernel NULL pointer dereference, address: 0000000000000000
[39867.822361] #PF: supervisor read access in kernel mode
[39867.822361] #PF: error_code(0x0000) - not-present page
[39867.822361] PGD 0 P4D 0
[39867.822361] Oops: 0000 [#1] PREEMPT SMP NOPTI
[39867.822361] CPU: 3 PID: 19605 Comm: python3 Kdump: loaded Tainted: G        W         5.19.0-rc2+ #33
[39867.822361] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-29-g6a62e0cb0dfe-prebuilt.qemu.org 04/01/2014
[39867.822361] RIP: 0010:rxe_completer+0x41f/0xd10 [rdma_rxe]
[39867.822361] Code: 41 83 ff 0d 0f 84 a7 02 00 00 41 83 ff 0e 0f 85 da 00 00 00 48 85 db 0f 84 74 fe ff ff 48 8b 6b 08 48 8d 7b d8 be 01 00 00 00 <4c> 8b 75 00 e8 68 65 56 dd 48 8d bd a0 01 00 00 e8 8c 47 00 00 4c
[39867.822361] RSP: 0000:ffff9eab813c7e18 EFLAGS: 00000286
[39867.822361] RAX: 0000000000022b5a RBX: ffff8adb07efeb28 RCX: 0000000000000006
[39867.822361] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8adb07efeb00
[39867.822361] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
[39867.822361] R10: 0000000000000000 R11: 0000000000011fac R12: ffff8adb06ae11a0
[39867.822361] R13: 00000000fffffff5 R14: ffff9eab81803e80 R15: 000000000000000c
[39867.822361] FS:  00007f87f99eb6c0(0000) GS:ffff8adb3dd00000(0000) knlGS:0000000000000000
[39867.822361] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[39867.822361] CR2: 0000000000000000 CR3: 0000000106c3e000 CR4: 00000000000006e0
[39867.822361] Call Trace:
[39867.822361]  <TASK>
[39867.822361]  ? __local_bh_enable_ip+0x83/0xf0
[39867.822361]  rxe_do_task+0x67/0xc0 [rdma_rxe]
[39867.822361]  tasklet_action_common.isra.0+0xe2/0x110
[39867.822361]  __do_softirq+0xf0/0x4b5
[39867.822361]  irq_exit_rcu+0xef/0x130
[39867.822361]  sysvec_apic_timer_interrupt+0x40/0xc0
[39867.822361]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
[39867.822361] RIP: 0033:0x7f87f96fcce5
...
--------------------------------------------------------

The root cause is that a received skb stored in qp->resp_pkts
has been ovewritten by another QP. Like the following logic:
--------------------------------------------------------
                    /* Trigger timeout */
Requester(QP#17) -> retransmit_timer()
                    -> rxe_completer()
                          /* No skb (Atomic ACK) is added
                           * to qp->resp_pkts */
                          qp->req.need_retry = 1;
                          rxe_run_task(&qp->req.task, 0);

                    /* First skb (Atomic ACK) arrived &&
                     * rxe_requester() is not called yet */
Requester(QP#17) -> rxe_rcv()
                       /* Add the skb (Atomic ACK) into qp->resp_pkts */
                    -> rxe_comp_queue_pkt()
                       -> rxe_completer()
                             /* qp->req.need_retry == 1 */
                             if (qp->req.need_retry) {
		                ret = -EAGAIN;
                                goto done;
		             }

Responder(QP#18) -> rxe_rcv()
                       /* The skb (Atomic ACK) has been reused
                        * to store the Atomic Comapre_Swap request */
                    -> rxe_responder()

                    /* rxe_requester() is called */
Requester(QP#17) -> rxe_requester()
                       if (unlikely(qp->req.need_retry)) {
		          req_retry(qp);
		          qp->req.need_retry = 0;
                       }

	            /* Trigger timeout again */
Requester(QP#17) -> retransmit_timer()
                    -> rxe_completer()
                          /* qp->req.need_retry == 0 */
                          if (qp->req.need_retry) {
		             ret = -EAGAIN;
                             goto done;
		          }
                          /* check_ack() throws "unexpected opcode" */
                       -> check_ack()
                          return COMPST_ERROR;
--------------------------------------------------------

If qp->req.need_retry is set and qp->resp_pkts is not empty,
Process received packets in time to fix the issue.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index da3a398053b8..8ffc874a25af 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -580,7 +580,7 @@ int rxe_completer(void *arg)
 		qp->comp.timeout_retry = 0;
 	}
 
-	if (qp->req.need_retry) {
+	if (qp->req.need_retry && !skb_queue_len(&qp->resp_pkts)) {
 		ret = -EAGAIN;
 		goto done;
 	}
-- 
2.34.1



