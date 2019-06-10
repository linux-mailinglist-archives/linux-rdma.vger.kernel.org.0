Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19B193AEB3
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 07:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387642AbfFJFqG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 01:46:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387541AbfFJFqG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 01:46:06 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A880F20820;
        Mon, 10 Jun 2019 05:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560145565;
        bh=e637fZ2sse5unSx+hI+sHHU20NlL8NJU8q4mSgBowNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aWGm0imnDocZNFe1JHw/AG45vna2DzLZ11PqdjPeNl7T/T1Fce6pwhVtHwIhtcR+o
         nOxL1t6nxfXB4732jAt9ef1GArFE8xc6ulOcXtId5DCBbzE38vkgWrBPX7kssJXX6s
         b3v7rkxa/3vZF/n/oheOEd0Fzd2ejA8pUUcqEe0k=
Date:   Mon, 10 Jun 2019 08:46:01 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v1 04/12] SIW connection management
Message-ID: <20190610054601.GC6369@mtr-leonro.mtl.com>
References: <20190526114156.6827-1-bmt@zurich.ibm.com>
 <20190526114156.6827-5-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526114156.6827-5-bmt@zurich.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 26, 2019 at 01:41:48PM +0200, Bernard Metzler wrote:
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_cm.c | 2109 ++++++++++++++++++++++++++++
>  drivers/infiniband/sw/siw/siw_cm.h |  133 ++
>  2 files changed, 2242 insertions(+)
>  create mode 100644 drivers/infiniband/sw/siw/siw_cm.c
>  create mode 100644 drivers/infiniband/sw/siw/siw_cm.h
>
> diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
> new file mode 100644
> index 000000000000..831f8ca356c7
> --- /dev/null
> +++ b/drivers/infiniband/sw/siw/siw_cm.c
> @@ -0,0 +1,2109 @@
> +// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
> +
> +/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
> +/*          Fredy Neeser */
> +/*          Greg Joyce <greg@opengridcomputing.com> */
> +/* Copyright (c) 2008-2019, IBM Corporation */
> +/* Copyright (c) 2017, Open Grid Computing, Inc. */
> +
> +#include <linux/errno.h>
> +#include <linux/types.h>
> +#include <linux/net.h>
> +#include <linux/inetdevice.h>
> +#include <net/addrconf.h>
> +#include <linux/workqueue.h>
> +#include <net/sock.h>
> +#include <net/tcp.h>
> +#include <linux/inet.h>
> +#include <linux/tcp.h>
> +
> +#include <rdma/iw_cm.h>
> +#include <rdma/ib_verbs.h>
> +#include <rdma/ib_smi.h>
> +#include <rdma/ib_user_verbs.h>
> +
> +#include "siw.h"
> +#include "siw_cm.h"
> +#include "siw_debug.h"
> +
> +/*
> + * Set to any combination of
> + * MPA_V2_RDMA_NO_RTR, MPA_V2_RDMA_READ_RTR, MPA_V2_RDMA_WRITE_RTR
> + */
> +static __be16 rtr_type = MPA_V2_RDMA_READ_RTR | MPA_V2_RDMA_WRITE_RTR;
> +static const bool relaxed_ird_negotiation = 1;
> +
> +static void siw_cm_llp_state_change(struct sock *s);
> +static void siw_cm_llp_data_ready(struct sock *s);
> +static void siw_cm_llp_write_space(struct sock *s);
> +static void siw_cm_llp_error_report(struct sock *s);
> +static int siw_cm_upcall(struct siw_cep *cep, enum iw_cm_event_type reason,
> +			 int status);
> +
> +static void siw_sk_assign_cm_upcalls(struct sock *sk)
> +{
> +	write_lock_bh(&sk->sk_callback_lock);
> +	sk->sk_state_change = siw_cm_llp_state_change;
> +	sk->sk_data_ready = siw_cm_llp_data_ready;
> +	sk->sk_write_space = siw_cm_llp_write_space;
> +	sk->sk_error_report = siw_cm_llp_error_report;
> +	write_unlock_bh(&sk->sk_callback_lock);
> +}
> +
> +static void siw_sk_save_upcalls(struct sock *sk)
> +{
> +	struct siw_cep *cep = sk_to_cep(sk);
> +
> +	write_lock_bh(&sk->sk_callback_lock);
> +	cep->sk_state_change = sk->sk_state_change;
> +	cep->sk_data_ready = sk->sk_data_ready;
> +	cep->sk_write_space = sk->sk_write_space;
> +	cep->sk_error_report = sk->sk_error_report;
> +	write_unlock_bh(&sk->sk_callback_lock);
> +}
> +
> +static void siw_sk_restore_upcalls(struct sock *sk, struct siw_cep *cep)
> +{
> +	sk->sk_state_change = cep->sk_state_change;
> +	sk->sk_data_ready = cep->sk_data_ready;
> +	sk->sk_write_space = cep->sk_write_space;
> +	sk->sk_error_report = cep->sk_error_report;
> +	sk->sk_user_data = NULL;
> +}
> +
> +static void siw_qp_socket_assoc(struct siw_cep *cep, struct siw_qp *qp)
> +{
> +	struct socket *s = cep->sock;
> +	struct sock *sk = s->sk;
> +
> +	write_lock_bh(&sk->sk_callback_lock);
> +
> +	qp->attrs.sk = s;
> +	sk->sk_data_ready = siw_qp_llp_data_ready;
> +	sk->sk_write_space = siw_qp_llp_write_space;
> +
> +	write_unlock_bh(&sk->sk_callback_lock);
> +}
> +
> +static void siw_socket_disassoc(struct socket *s)
> +{
> +	struct sock *sk = s->sk;
> +	struct siw_cep *cep;
> +
> +	if (sk) {
> +		write_lock_bh(&sk->sk_callback_lock);
> +		cep = sk_to_cep(sk);
> +		if (cep) {
> +			siw_sk_restore_upcalls(sk, cep);
> +			siw_cep_put(cep);
> +		} else
> +			pr_warn("siw: cannot restore sk callbacks: no ep\n");
> +		write_unlock_bh(&sk->sk_callback_lock);
> +	} else {
> +		pr_warn("siw: cannot restore sk callbacks: no sk\n");
> +	}
> +}
> +
> +static void siw_rtr_data_ready(struct sock *sk)
> +{
> +	struct siw_cep *cep;
> +	struct siw_qp *qp = NULL;
> +	read_descriptor_t rd_desc;
> +
> +	read_lock(&sk->sk_callback_lock);
> +
> +	cep = sk_to_cep(sk);
> +	if (!cep) {
> +		WARN(1, "No connection endpoint\n");
> +		goto out;
> +	}
> +	qp = sk_to_qp(sk);
> +
> +	memset(&rd_desc, 0, sizeof(rd_desc));
> +	rd_desc.arg.data = qp;
> +	rd_desc.count = 1;
> +
> +	tcp_read_sock(sk, &rd_desc, siw_tcp_rx_data);
> +	/*
> +	 * Check if first frame was successfully processed.
> +	 * Signal connection full establishment if yes.
> +	 * Failed data processing would have already scheduled
> +	 * connection drop.
> +	 */
> +	if (!qp->rx_stream.rx_suspend)
> +		siw_cm_upcall(cep, IW_CM_EVENT_ESTABLISHED, 0);
> +out:
> +	read_unlock(&sk->sk_callback_lock);
> +	if (qp)
> +		siw_qp_socket_assoc(cep, qp);
> +}
> +
> +static void siw_sk_assign_rtr_upcalls(struct siw_cep *cep)
> +{
> +	struct sock *sk = cep->sock->sk;
> +
> +	write_lock_bh(&sk->sk_callback_lock);
> +	sk->sk_data_ready = siw_rtr_data_ready;
> +	sk->sk_write_space = siw_qp_llp_write_space;
> +	write_unlock_bh(&sk->sk_callback_lock);
> +}
> +
> +static void siw_cep_socket_assoc(struct siw_cep *cep, struct socket *s)
> +{
> +	cep->sock = s;
> +	siw_cep_get(cep);
> +	s->sk->sk_user_data = cep;
> +
> +	siw_sk_save_upcalls(s->sk);
> +	siw_sk_assign_cm_upcalls(s->sk);
> +}
> +
> +static struct siw_cep *siw_cep_alloc(struct siw_device *sdev)
> +{
> +	struct siw_cep *cep = kzalloc(sizeof(*cep), GFP_KERNEL);
> +	unsigned long flags;
> +
> +	if (!cep)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&cep->listenq);
> +	INIT_LIST_HEAD(&cep->devq);
> +	INIT_LIST_HEAD(&cep->work_freelist);
> +
> +	kref_init(&cep->ref);
> +	cep->state = SIW_EPSTATE_IDLE;
> +	init_waitqueue_head(&cep->waitq);
> +	spin_lock_init(&cep->lock);
> +	cep->sdev = sdev;
> +	cep->enhanced_rdma_conn_est = false;
> +
> +	spin_lock_irqsave(&sdev->lock, flags);
> +	list_add_tail(&cep->devq, &sdev->cep_list);
> +	spin_unlock_irqrestore(&sdev->lock, flags);
> +	atomic_inc(&sdev->num_cep);
> +
> +	siw_dbg_cep(cep, "new object\n");
> +	return cep;
> +}
> +
> +static void siw_cm_free_work(struct siw_cep *cep)
> +{
> +	struct list_head *w, *tmp;
> +	struct siw_cm_work *work;
> +
> +	list_for_each_safe(w, tmp, &cep->work_freelist) {
> +		work = list_entry(w, struct siw_cm_work, list);
> +		list_del(&work->list);
> +		kfree(work);
> +	}
> +}
> +
> +static void siw_cancel_mpatimer(struct siw_cep *cep)
> +{
> +	spin_lock_bh(&cep->lock);
> +	if (cep->mpa_timer) {
> +		if (cancel_delayed_work(&cep->mpa_timer->work)) {
> +			siw_cep_put(cep);
> +			kfree(cep->mpa_timer); /* not needed again */
> +		}
> +		cep->mpa_timer = NULL;
> +	}
> +	spin_unlock_bh(&cep->lock);
> +}
> +
> +static void siw_put_work(struct siw_cm_work *work)
> +{
> +	INIT_LIST_HEAD(&work->list);
> +	spin_lock_bh(&work->cep->lock);
> +	list_add(&work->list, &work->cep->work_freelist);
> +	spin_unlock_bh(&work->cep->lock);
> +}
> +
> +static void siw_cep_set_inuse(struct siw_cep *cep)
> +{
> +	unsigned long flags;
> +	int rv;
> +retry:
> +	siw_dbg_cep(cep, "current in_use %d\n", cep->in_use);
> +
> +	spin_lock_irqsave(&cep->lock, flags);
> +
> +	if (cep->in_use) {
> +		spin_unlock_irqrestore(&cep->lock, flags);
> +		rv = wait_event_interruptible(cep->waitq, !cep->in_use);
> +		if (signal_pending(current))
> +			flush_signals(current);
> +		goto retry;
> +	} else {
> +		cep->in_use = 1;
> +		spin_unlock_irqrestore(&cep->lock, flags);
> +	}
> +}
> +
> +static void siw_cep_set_free(struct siw_cep *cep)
> +{
> +	unsigned long flags;
> +
> +	siw_dbg_cep(cep, "current in_use %d\n", cep->in_use);
> +
> +	spin_lock_irqsave(&cep->lock, flags);
> +	cep->in_use = 0;
> +	spin_unlock_irqrestore(&cep->lock, flags);
> +
> +	wake_up(&cep->waitq);
> +}
> +
> +static void __siw_cep_dealloc(struct kref *ref)
> +{
> +	struct siw_cep *cep = container_of(ref, struct siw_cep, ref);
> +	struct siw_device *sdev = cep->sdev;
> +	unsigned long flags;
> +
> +	siw_dbg_cep(cep, "free object\n");
> +
> +	WARN_ON(cep->listen_cep);
> +
> +	/* kfree(NULL) is safe */
> +	kfree(cep->mpa.pdata);
> +	spin_lock_bh(&cep->lock);
> +	if (!list_empty(&cep->work_freelist))
> +		siw_cm_free_work(cep);
> +	spin_unlock_bh(&cep->lock);
> +
> +	spin_lock_irqsave(&sdev->lock, flags);
> +	list_del(&cep->devq);
> +	spin_unlock_irqrestore(&sdev->lock, flags);
> +	atomic_dec(&sdev->num_cep);
> +	kfree(cep);
> +}
> +
> +static struct siw_cm_work *siw_get_work(struct siw_cep *cep)
> +{
> +	struct siw_cm_work *work = NULL;
> +
> +	spin_lock_bh(&cep->lock);
> +	if (!list_empty(&cep->work_freelist)) {
> +		work = list_entry(cep->work_freelist.next, struct siw_cm_work,
> +				  list);
> +		list_del_init(&work->list);
> +	}
> +	spin_unlock_bh(&cep->lock);
> +	return work;
> +}
> +
> +static int siw_cm_alloc_work(struct siw_cep *cep, int num)
> +{
> +	struct siw_cm_work *work;
> +
> +	while (num--) {
> +		work = kmalloc(sizeof(*work), GFP_KERNEL);
> +		if (!work) {
> +			if (!(list_empty(&cep->work_freelist)))
> +				siw_cm_free_work(cep);
> +			return -ENOMEM;
> +		}
> +		work->cep = cep;
> +		INIT_LIST_HEAD(&work->list);
> +		list_add(&work->list, &cep->work_freelist);
> +	}
> +	return 0;
> +}

All this code that tries to implement memory pools should gone.

Thanks
