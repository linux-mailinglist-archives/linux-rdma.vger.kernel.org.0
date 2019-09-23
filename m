Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F272BB1F6
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 12:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfIWKLW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 06:11:22 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:23447 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfIWKLW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 06:11:22 -0400
Received: from localhost (budha.blr.asicdesigners.com [10.193.185.4])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x8NABGT5010803;
        Mon, 23 Sep 2019 03:11:18 -0700
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     jgg@ziepe.ca, bmt@zurich.ibm.com
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com,
        Krishnamraju Eraparaju <krishna2@chelsio.com>
Subject: [PATCH for-next] RDMA/siw: fixes serialization issue in write_space
Date:   Mon, 23 Sep 2019 15:41:12 +0530
Message-Id: <20190923101112.32685-1-krishna2@chelsio.com>
X-Mailer: git-send-email 2.23.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In siw_qp_llp_write_space(), 'sock' members should be accessed
with sk_callback_lock held, otherwise, it could race with
siw_sk_restore_upcalls(). And this could cause "NULL deref" panic.
Below panic is due to the NULL cep returned from sk_to_cep(sk):
[14524.030863] Call Trace:
[14524.030868]  <IRQ>    siw_qp_llp_write_space+0x11/0x40 [siw]
[14524.030873]  tcp_check_space+0x4c/0xf0
[14524.030877]  tcp_rcv_established+0x52b/0x630
[14524.030880]  tcp_v4_do_rcv+0xf4/0x1e0
[14524.030882]  tcp_v4_rcv+0x9b8/0xab0
[14524.030886]  ip_protocol_deliver_rcu+0x2c/0x1c0
[14524.030889]  ip_local_deliver_finish+0x44/0x50
[14524.030891]  ip_local_deliver+0x6b/0xf0
[14524.030893]  ? ip_protocol_deliver_rcu+0x1c0/0x1c0
[14524.030896]  ip_rcv+0x52/0xd0
[14524.030898]  ? ip_rcv_finish_core.isra.14+0x390/0x390
[14524.030903]  __netif_receive_skb_one_core+0x83/0xa0
[14524.030906]  netif_receive_skb_internal+0x73/0xb0
[14524.030909]  napi_gro_frags+0x1ff/0x2b0
[14524.030922]  t4_ethrx_handler+0x4a7/0x740 [cxgb4]
[14524.030930]  process_responses+0x2c9/0x590 [cxgb4]
[14524.030937]  ? t4_sge_intr_msix+0x1d/0x30 [cxgb4]
[14524.030941]  ? handle_irq_event_percpu+0x51/0x70
[14524.030943]  ? handle_irq_event+0x41/0x60
[14524.030946]  ? handle_edge_irq+0x97/0x1a0
[14524.030952]  napi_rx_handler+0x14/0xe0 [cxgb4]
[14524.030955]  net_rx_action+0x2af/0x410
[14524.030962]  __do_softirq+0xda/0x2a8
[14524.030965]  do_softirq_own_stack+0x2a/0x40
[14524.030967]  </IRQ>
[14524.030969]  do_softirq+0x50/0x60
[14524.030972]  __local_bh_enable_ip+0x50/0x60
[14524.030974]  ip_finish_output2+0x18f/0x520
[14524.030977]  ip_output+0x6e/0xf0
[14524.030979]  ? __ip_finish_output+0x1f0/0x1f0
[14524.030982]  __ip_queue_xmit+0x14f/0x3d0
[14524.030986]  ? __slab_alloc+0x4b/0x58
[14524.030990]  __tcp_transmit_skb+0x57d/0xa60
[14524.030992]  tcp_write_xmit+0x23b/0xfd0
[14524.030995]  __tcp_push_pending_frames+0x2e/0xf0
[14524.030998]  tcp_sendmsg_locked+0x939/0xd50
[14524.031001]  tcp_sendmsg+0x27/0x40
[14524.031004]  sock_sendmsg+0x57/0x80
[14524.031009]  siw_tx_hdt+0x894/0xb20 [siw]
[14524.031015]  ? find_busiest_group+0x3e/0x5b0
[14524.031019]  ? common_interrupt+0xa/0xf
[14524.031021]  ? common_interrupt+0xa/0xf
[14524.031023]  ? common_interrupt+0xa/0xf
[14524.031028]  siw_qp_sq_process+0xf1/0xe60 [siw]
[14524.031031]  ? __wake_up_common_lock+0x87/0xc0
[14524.031035]  siw_sq_resume+0x33/0xe0 [siw]
[14524.031039]  siw_run_sq+0xac/0x190 [siw]
[14524.031041]  ? remove_wait_queue+0x60/0x60
[14524.031045]  kthread+0xf8/0x130
[14524.031049]  ? siw_sq_resume+0xe0/0xe0 [siw]
[14524.031051]  ? kthread_bind+0x10/0x10
[14524.031053]  ret_from_fork+0x35/0x40

Fixes: f29dd55b0236 (rdma/siw: queue pair methods)
Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
---
 drivers/infiniband/sw/siw/siw_qp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
index 430314c8abd9..52d402f39df9 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -182,12 +182,19 @@ void siw_qp_llp_close(struct siw_qp *qp)
  */
 void siw_qp_llp_write_space(struct sock *sk)
 {
-	struct siw_cep *cep = sk_to_cep(sk);
+	struct siw_cep *cep;
 
-	cep->sk_write_space(sk);
+	read_lock(&sk->sk_callback_lock);
+
+	cep  = sk_to_cep(sk);
+	if (cep) {
+		cep->sk_write_space(sk);
 
-	if (!test_bit(SOCK_NOSPACE, &sk->sk_socket->flags))
-		(void)siw_sq_start(cep->qp);
+		if (!test_bit(SOCK_NOSPACE, &sk->sk_socket->flags))
+			(void)siw_sq_start(cep->qp);
+	}
+
+	read_unlock(&sk->sk_callback_lock);
 }
 
 static int siw_qp_readq_init(struct siw_qp *qp, int irq_size, int orq_size)
-- 
2.23.0.rc0

