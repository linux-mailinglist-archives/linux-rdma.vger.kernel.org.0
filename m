Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A382DBACC
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Dec 2020 06:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbgLPFhQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Dec 2020 00:37:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725274AbgLPFhQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Dec 2020 00:37:16 -0500
Date:   Wed, 16 Dec 2020 07:36:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608096995;
        bh=CjMjVWTYxgyh6A2SZJx2Qyu808tu54VGUIKmyU4/b9E=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=tU6umlPGBUUcbA63m26SlwHFLSWT7jqzcaGsuMiNKurid4NB+ya4dKFAk4gQzZt0S
         Lu6QwsAwVCLp1/E950rOKZGZJguBANlVN+7ojpSDnxsRgE9r+77n1fkvZkMwjeeLQA
         X0eF8rT+J3lh05YFUM7EocjCFtCBvrZBVQIcDkFpzNtbY55Ykdylx13n8ohP9sdt3R
         biJewms2TQvEJ5ulDDIj+uFpBxEQZPMOVzjKVF8MXMe/efvpmPJVUh4i/lWejBWg63
         RkOb8u2oTEN21Jx/akeYhYmfjZn9Ftlim/uGjsn1wMuMDiJwUpms0h+CCUaQ3hP5Po
         vLa/f7ExuBO+g==
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, jgg@nvidia.com,
        linux-nvme@lists.infradead.org, Kamal Heib <kamalheib1@gmail.com>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH v2] RDMA/siw: Fix handling of zero-sized Read and Receive
 Queues.
Message-ID: <20201216053631.GP5005@unreal>
References: <20201215201918.4050-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215201918.4050-1-bmt@zurich.ibm.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 15, 2020 at 09:19:18PM +0100, Bernard Metzler wrote:
> During connection setup, the application may choose to zero-size
> inbound and outbound READ queues, as well as the Receive queue.
> This patch fixes handling of zero-sized queues, but not prevents
> it.
>
> v2 changes:
> - Fix uninitialized variable introduced in siw_qp_rx.c, as
>   Reported-by: kernel test robot <lkp@intel.com>
> - Add initial error report as
>   Reported-by: Kamal Heib <kamalheib1@gmail.com>

Changelog shouldn't be in the commit message and needs to appear after "---",
because only this version will be applied to the kernel.

>
> Kamal Heib says in an initial error report:
> When running the blktests over siw the following shift-out-of-bounds is
> reported, this is happening because the passed IRD or ORD from the ulp
> could be zero which will lead to unexpected behavior when calling
> roundup_pow_of_two(), fix that by blocking zero values of ORD or IRD.
>
> UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
> shift exponent 64 is too large for 64-bit type 'long unsigned int'
> CPU: 20 PID: 3957 Comm: kworker/u64:13 Tainted: G S     5.10.0-rc6 #2
> Hardware name: Dell Inc. PowerEdge R630/02C2CP, BIOS 2.1.5 04/11/2016
> Workqueue: iw_cm_wq cm_work_handler [iw_cm]
> Call Trace:
>  dump_stack+0x99/0xcb
>  ubsan_epilogue+0x5/0x40
>  __ubsan_handle_shift_out_of_bounds.cold.11+0xb4/0xf3
>  ? down_write+0x183/0x3d0
>  siw_qp_modify.cold.8+0x2d/0x32 [siw]
>  ? __local_bh_enable_ip+0xa5/0xf0
>  siw_accept+0x906/0x1b60 [siw]
>  ? xa_load+0x147/0x1f0
>  ? siw_connect+0x17a0/0x17a0 [siw]
>  ? lock_downgrade+0x700/0x700
>  ? siw_get_base_qp+0x1c2/0x340 [siw]
>  ? _raw_spin_unlock_irqrestore+0x39/0x40
>  iw_cm_accept+0x1f4/0x430 [iw_cm]
>  rdma_accept+0x3fa/0xb10 [rdma_cm]
>  ? check_flush_dependency+0x410/0x410
>  ? cma_rep_recv+0x570/0x570 [rdma_cm]
>  nvmet_rdma_queue_connect+0x1a62/0x2680 [nvmet_rdma]
>  ? nvmet_rdma_alloc_cmds+0xce0/0xce0 [nvmet_rdma]
>  ? lock_release+0x56e/0xcc0
>  ? lock_downgrade+0x700/0x700
>  ? lock_downgrade+0x700/0x700
>  ? __xa_alloc_cyclic+0xef/0x350
>  ? __xa_alloc+0x2d0/0x2d0
>  ? rdma_restrack_add+0xbe/0x2c0 [ib_core]
>  ? __ww_mutex_die+0x190/0x190
>  cma_cm_event_handler+0xf2/0x500 [rdma_cm]
>  iw_conn_req_handler+0x910/0xcb0 [rdma_cm]
>  ? _raw_spin_unlock_irqrestore+0x39/0x40
>  ? trace_hardirqs_on+0x1c/0x150
>  ? cma_ib_handler+0x8a0/0x8a0 [rdma_cm]
>  ? __kasan_kmalloc.constprop.7+0xc1/0xd0
>  cm_work_handler+0x121c/0x17a0 [iw_cm]
>  ? iw_cm_reject+0x190/0x190 [iw_cm]
>  ? trace_hardirqs_on+0x1c/0x150
>  process_one_work+0x8fb/0x16c0
>  ? pwq_dec_nr_in_flight+0x320/0x320
>  worker_thread+0x87/0xb40
>  ? __kthread_parkme+0xd1/0x1a0
>  ? process_one_work+0x16c0/0x16c0
>  kthread+0x35f/0x430
>  ? kthread_mod_delayed_work+0x180/0x180
>  ret_from_fork+0x22/0x30
>
> Fixes: a531975279f3 ("rdma/siw: main include file")
> Fixes: f29dd55b0236 ("rdma/siw: queue pair methods")
> Fixes: 8b6a361b8c48 ("rdma/siw: receive path")
> Fixes: b9be6f18cf9e ("rdma/siw: transmit path")
> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> Reported-by: Kamal Heib <kamalheib1@gmail.com>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw.h       |  2 +-
>  drivers/infiniband/sw/siw/siw_qp.c    | 54 ++++++++++++++++-----------
>  drivers/infiniband/sw/siw/siw_qp_rx.c | 26 +++++++++----
>  drivers/infiniband/sw/siw/siw_qp_tx.c |  4 +-
>  drivers/infiniband/sw/siw/siw_verbs.c | 18 +++++++--
>  5 files changed, 68 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
> index e9753831ac3f..6f17392f975a 100644
> --- a/drivers/infiniband/sw/siw/siw.h
> +++ b/drivers/infiniband/sw/siw/siw.h
> @@ -654,7 +654,7 @@ static inline struct siw_sqe *orq_get_free(struct siw_qp *qp)
>  {
>  	struct siw_sqe *orq_e = orq_get_tail(qp);
>
> -	if (orq_e && READ_ONCE(orq_e->flags) == 0)
> +	if (READ_ONCE(orq_e->flags) == 0)
>  		return orq_e;
>
>  	return NULL;
> diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
> index 875d36d4b1c6..b686a09a75ae 100644
> --- a/drivers/infiniband/sw/siw/siw_qp.c
> +++ b/drivers/infiniband/sw/siw/siw_qp.c
> @@ -199,26 +199,28 @@ void siw_qp_llp_write_space(struct sock *sk)
>
>  static int siw_qp_readq_init(struct siw_qp *qp, int irq_size, int orq_size)
>  {
> -	irq_size = roundup_pow_of_two(irq_size);
> -	orq_size = roundup_pow_of_two(orq_size);
> -
> -	qp->attrs.irq_size = irq_size;
> -	qp->attrs.orq_size = orq_size;
> -
> -	qp->irq = vzalloc(irq_size * sizeof(struct siw_sqe));
> -	if (!qp->irq) {
> -		siw_dbg_qp(qp, "irq malloc for %d failed\n", irq_size);
> -		qp->attrs.irq_size = 0;
> -		return -ENOMEM;
> +	if (irq_size) {
> +		irq_size = roundup_pow_of_two(irq_size);
> +		qp->irq = vzalloc(irq_size * sizeof(struct siw_sqe));
> +		if (!qp->irq) {
> +			siw_dbg_qp(qp, "irq malloc for %d failed\n", irq_size);

Please don't copy the prints.

Thanks
