Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E296FBF728
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 18:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfIZQwW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Sep 2019 12:52:22 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:2634 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfIZQwV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Sep 2019 12:52:21 -0400
Received: from localhost (budha.blr.asicdesigners.com [10.193.185.4])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x8QGqG3i004060;
        Thu, 26 Sep 2019 09:52:18 -0700
Date:   Thu, 26 Sep 2019 22:22:16 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>, jgg@ziepe.ca
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Subject: Re: Re: [PATCH for-next] RDMA/siw: fixes serialization issue in
 write_space
Message-ID: <20190926165214.GA5907@chelsio.com>
References: <20190923202629.GA24416@chelsio.com>
 <20190923101112.32685-1-krishna2@chelsio.com>
 <OFF07E93B6.E63D8785-ON0025847E.003DA8D0-0025847E.003EAD9D@notes.na.collabserv.com>
 <OF6DFD0CAC.490420E7-ON00258481.0041FCBB-00258481.004AF091@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF6DFD0CAC.490420E7-ON00258481.0041FCBB-00258481.004AF091@notes.na.collabserv.com>
User-Agent: Mutt/1.9.3 (20180206.02d571c2)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bernard,

Thanks for the detailed explanation.

Now it's clear to me. I was under impression that using
read_lock(instead of read_lock_bh) in process context could
cause a deadlock due to a write_lock in softirq, which is
clearly not as write_lock is always acquired in process
context.

Jason, please consider the current patch as final.

Thanks,
Krishna.

On Thursday, September 09/26/19, 2019 at 13:38:32 +0000, Bernard Metzler wrote:
> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----
> 
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
> >Date: 09/23/2019 10:26PM
> >Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
> >nirranjan@chelsio.com
> >Subject: [EXTERNAL] Re: [PATCH for-next] RDMA/siw: fixes
> >serialization issue in write_space
> >
> >Hi Bernard,
> >
> >write_space callback may not always be called from softirq/tasklet
> >context, it may be called from process context.
> >Hence, read_lock_bh() is safer than read_lock().
> >
> >I will resubmit the patch.
> >
> 
> Hi Krishna,
> 
> siw takes a write_lock on the sockets sk_callback_lock
> only when it is in a process context, and never from
> within an socket upcall. It only takes the write_lock when
> changing the assignment of the socket upcalls.
> write_lock is always taken using the _bh variant,
> which prevents us from an otherwise potentially
> concurrently running softirq to spinlock on the same
> socket.
> 
> During socket upcall, siw always only takes a read lock
> (one was missing, your current patch thankfully fixes that).
> If now the upcall may happen from a process context,
> it would not be prevented by write_lock_bh, but it
> also does not have to. It then just does what it
> is supposed to do - the process spins until the
> lock becomes available. That's what spinlock's
> are for...
> 
> So I don't see a reason to change read_lock()'s to
> read_lock_bh()'s: All critical write lock's are
> write_lock_bh(), which either prevents the softirq
> upcall from running, or lets the up-calling process
> context correctly spinning.
> 
> I think your current patch is just fine.
> 
> 
> I am not sure about the iscsi_tcp code change. Maybe
> it is needed since it may take a write_lock from within
> softirq.
> 
> 
> Many thanks,
> Bernard.
> 
> 
> >Also, after looking at the below commit, I feel all other read_lock()
> >in SIW driver should be replaced with BH variants.
> >
> >https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_torva
> >lds_linux_commit_7cb001d4c4fa7e1cc1a55388a9544e160dddc610&d=DwIBAg&c=
> >jf_iaSHvJObTbx-siA1ZOg&r=2TaYXQ0T-r8ZO1PP1alNwU_QJcRRLfmYTAgd3QCvqSc&
> >m=QHDqv1KcjDv-pXFNN-vF1j8b_JkQdzRXbebBg24Mf0U&s=LQmC1X40Q1CFelQASrwaI
> >25kLAzhrTdPj28m4x3sxUs&e= 
> >
> >
> >
> >Shall I also change all other occurances of read_lock() to
> >read_lock_bh()?
> >
> >
> >Thanks,
> >Krishna.
> >
> >On Monday, September 09/23/19, 2019 at 11:24:36 +0000, Bernard
> >Metzler wrote:
> >> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----
> >> 
> >> >To: jgg@ziepe.ca, bmt@zurich.ibm.com
> >> >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
> >> >Date: 09/23/2019 12:11PM
> >> >Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com,
> >> >nirranjan@chelsio.com, "Krishnamraju Eraparaju"
> >> ><krishna2@chelsio.com>
> >> >Subject: [EXTERNAL] [PATCH for-next] RDMA/siw: fixes serialization
> >> >issue in write_space
> >> >
> >> >In siw_qp_llp_write_space(), 'sock' members should be accessed
> >> >with sk_callback_lock held, otherwise, it could race with
> >> >siw_sk_restore_upcalls(). And this could cause "NULL deref" panic.
> >> >Below panic is due to the NULL cep returned from sk_to_cep(sk):
> >> >[14524.030863] Call Trace:
> >> >[14524.030868]  <IRQ>    siw_qp_llp_write_space+0x11/0x40 [siw]
> >> >[14524.030873]  tcp_check_space+0x4c/0xf0
> >> >[14524.030877]  tcp_rcv_established+0x52b/0x630
> >> >[14524.030880]  tcp_v4_do_rcv+0xf4/0x1e0
> >> >[14524.030882]  tcp_v4_rcv+0x9b8/0xab0
> >> >[14524.030886]  ip_protocol_deliver_rcu+0x2c/0x1c0
> >> >[14524.030889]  ip_local_deliver_finish+0x44/0x50
> >> >[14524.030891]  ip_local_deliver+0x6b/0xf0
> >> >[14524.030893]  ? ip_protocol_deliver_rcu+0x1c0/0x1c0
> >> >[14524.030896]  ip_rcv+0x52/0xd0
> >> >[14524.030898]  ? ip_rcv_finish_core.isra.14+0x390/0x390
> >> >[14524.030903]  __netif_receive_skb_one_core+0x83/0xa0
> >> >[14524.030906]  netif_receive_skb_internal+0x73/0xb0
> >> >[14524.030909]  napi_gro_frags+0x1ff/0x2b0
> >> >[14524.030922]  t4_ethrx_handler+0x4a7/0x740 [cxgb4]
> >> >[14524.030930]  process_responses+0x2c9/0x590 [cxgb4]
> >> >[14524.030937]  ? t4_sge_intr_msix+0x1d/0x30 [cxgb4]
> >> >[14524.030941]  ? handle_irq_event_percpu+0x51/0x70
> >> >[14524.030943]  ? handle_irq_event+0x41/0x60
> >> >[14524.030946]  ? handle_edge_irq+0x97/0x1a0
> >> >[14524.030952]  napi_rx_handler+0x14/0xe0 [cxgb4]
> >> >[14524.030955]  net_rx_action+0x2af/0x410
> >> >[14524.030962]  __do_softirq+0xda/0x2a8
> >> >[14524.030965]  do_softirq_own_stack+0x2a/0x40
> >> >[14524.030967]  </IRQ>
> >> >[14524.030969]  do_softirq+0x50/0x60
> >> >[14524.030972]  __local_bh_enable_ip+0x50/0x60
> >> >[14524.030974]  ip_finish_output2+0x18f/0x520
> >> >[14524.030977]  ip_output+0x6e/0xf0
> >> >[14524.030979]  ? __ip_finish_output+0x1f0/0x1f0
> >> >[14524.030982]  __ip_queue_xmit+0x14f/0x3d0
> >> >[14524.030986]  ? __slab_alloc+0x4b/0x58
> >> >[14524.030990]  __tcp_transmit_skb+0x57d/0xa60
> >> >[14524.030992]  tcp_write_xmit+0x23b/0xfd0
> >> >[14524.030995]  __tcp_push_pending_frames+0x2e/0xf0
> >> >[14524.030998]  tcp_sendmsg_locked+0x939/0xd50
> >> >[14524.031001]  tcp_sendmsg+0x27/0x40
> >> >[14524.031004]  sock_sendmsg+0x57/0x80
> >> >[14524.031009]  siw_tx_hdt+0x894/0xb20 [siw]
> >> >[14524.031015]  ? find_busiest_group+0x3e/0x5b0
> >> >[14524.031019]  ? common_interrupt+0xa/0xf
> >> >[14524.031021]  ? common_interrupt+0xa/0xf
> >> >[14524.031023]  ? common_interrupt+0xa/0xf
> >> >[14524.031028]  siw_qp_sq_process+0xf1/0xe60 [siw]
> >> >[14524.031031]  ? __wake_up_common_lock+0x87/0xc0
> >> >[14524.031035]  siw_sq_resume+0x33/0xe0 [siw]
> >> >[14524.031039]  siw_run_sq+0xac/0x190 [siw]
> >> >[14524.031041]  ? remove_wait_queue+0x60/0x60
> >> >[14524.031045]  kthread+0xf8/0x130
> >> >[14524.031049]  ? siw_sq_resume+0xe0/0xe0 [siw]
> >> >[14524.031051]  ? kthread_bind+0x10/0x10
> >> >[14524.031053]  ret_from_fork+0x35/0x40
> >> >
> >> >Fixes: f29dd55b0236 (rdma/siw: queue pair methods)
> >> >Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> >> >---
> >> > drivers/infiniband/sw/siw/siw_qp.c | 15 +++++++++++----
> >> > 1 file changed, 11 insertions(+), 4 deletions(-)
> >> >
> >> >diff --git a/drivers/infiniband/sw/siw/siw_qp.c
> >> >b/drivers/infiniband/sw/siw/siw_qp.c
> >> >index 430314c8abd9..52d402f39df9 100644
> >> >--- a/drivers/infiniband/sw/siw/siw_qp.c
> >> >+++ b/drivers/infiniband/sw/siw/siw_qp.c
> >> >@@ -182,12 +182,19 @@ void siw_qp_llp_close(struct siw_qp *qp)
> >> >  */
> >> > void siw_qp_llp_write_space(struct sock *sk)
> >> > {
> >> >-	struct siw_cep *cep = sk_to_cep(sk);
> >> >+	struct siw_cep *cep;
> >> > 
> >> >-	cep->sk_write_space(sk);
> >> >+	read_lock(&sk->sk_callback_lock);
> >> >+
> >> >+	cep  = sk_to_cep(sk);
> >> >+	if (cep) {
> >> >+		cep->sk_write_space(sk);
> >> > 
> >> >-	if (!test_bit(SOCK_NOSPACE, &sk->sk_socket->flags))
> >> >-		(void)siw_sq_start(cep->qp);
> >> >+		if (!test_bit(SOCK_NOSPACE, &sk->sk_socket->flags))
> >> >+			(void)siw_sq_start(cep->qp);
> >> >+	}
> >> >+
> >> >+	read_unlock(&sk->sk_callback_lock);
> >> > }
> >> > 
> >> > static int siw_qp_readq_init(struct siw_qp *qp, int irq_size, int
> >> >orq_size)
> >> >-- 
> >> >2.23.0.rc0
> >> >
> >> >
> >> 
> >> Hi Krishna,
> >> 
> >> Many thanks! I completely agree. This fixes a potential race.
> >> I was under the impression the socket layer itself would hold
> >> the sk_callback_lock during the writespace upcall, which is
> >> obviously not true.
> >> 
> >> Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
> >> 
> >
> >
> 
