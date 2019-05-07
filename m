Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98D9516689
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 17:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfEGPVg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 7 May 2019 11:21:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40108 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726386AbfEGPVg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 11:21:36 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x47FGeNw017051
        for <linux-rdma@vger.kernel.org>; Tue, 7 May 2019 11:21:33 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.91])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sbbp22xu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 07 May 2019 11:21:32 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 7 May 2019 15:21:31 -0000
Received: from us1a3-smtp03.a3.dal06.isc4sb.com (10.106.154.98)
        by smtp.notes.na.collabserv.com (10.106.227.143) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 7 May 2019 15:21:28 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp03.a3.dal06.isc4sb.com
          with ESMTP id 2019050715212818-775564 ;
          Tue, 7 May 2019 15:21:28 +0000 
In-Reply-To: <20190428164954.GP6705@mtr-leonro.mtl.com>
Subject: Re: [PATCH v8 04/12] SIW connection management
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 7 May 2019 15:21:28 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190428164954.GP6705@mtr-leonro.mtl.com>,<20190426131852.30142-1-bmt@zurich.ibm.com>
 <20190426131852.30142-5-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1048) | IBM Domino Build
 SCN1812108_20180501T0841_FP38 April 10, 2019 at 11:56
X-LLNOutbound: False
X-Disclaimed: 17123
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19050715-9951-0000-0000-00000C5FC3C6
X-IBM-SpamModules-Scores: BY=0.020703; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.003726
X-IBM-SpamModules-Versions: BY=3.00011066; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01199925; UDB=6.00629554; IPR=6.00980807;
 BA=6.00006300; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00026770; XFM=3.00000015;
 UTC=2019-05-07 15:21:31
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-05-07 14:59:34 - 6.00009896
x-cbparentid: 19050715-9952-0000-0000-00003C57DE42
Message-Id: <OF63ED2654.B14EF197-ON002583F3.00529A34-002583F3.00545CFD@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-07_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 04/28/2019 06:50PM
>Cc: linux-rdma@vger.kernel.org, "Bernard Metzler"
><bmt@rims.zurich.ibm.com>
>Subject: Re: [PATCH v8 04/12] SIW connection management
>
>On Fri, Apr 26, 2019 at 03:18:44PM +0200, Bernard Metzler wrote:
>> From: Bernard Metzler <bmt@rims.zurich.ibm.com>
>>
>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> ---
>>  drivers/infiniband/sw/siw/siw_cm.c | 2107
>++++++++++++++++++++++++++++
>>  drivers/infiniband/sw/siw/siw_cm.h |  121 ++
>>  2 files changed, 2228 insertions(+)
>>  create mode 100644 drivers/infiniband/sw/siw/siw_cm.c
>>  create mode 100644 drivers/infiniband/sw/siw/siw_cm.h
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>b/drivers/infiniband/sw/siw/siw_cm.c
>> new file mode 100644
>> index 000000000000..29c843906267
>> --- /dev/null
>> +++ b/drivers/infiniband/sw/siw/siw_cm.c
>> @@ -0,0 +1,2107 @@
>> +// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
>> +
>> +/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
>> +/*          Fredy Neeser */
>> +/*          Greg Joyce <greg@opengridcomputing.com> */
>> +/* Copyright (c) 2008-2019, IBM Corporation */
>> +/* Copyright (c) 2017, Open Grid Computing, Inc. */
>> +
>> +#include <linux/errno.h>
>> +#include <linux/types.h>
>> +#include <linux/net.h>
>> +#include <linux/inetdevice.h>
>> +#include <linux/workqueue.h>
>> +#include <net/sock.h>
>> +#include <net/tcp.h>
>> +#include <linux/tcp.h>
>> +
>> +#include <rdma/iw_cm.h>
>> +#include <rdma/ib_verbs.h>
>> +#include <rdma/ib_smi.h>
>> +#include <rdma/ib_user_verbs.h>
>> +
>> +#include "siw.h"
>> +#include "siw_cm.h"
>> +#include "siw_debug.h"
>> +
>> +/*
>> + * Set to any combination of
>> + * MPA_V2_RDMA_NO_RTR, MPA_V2_RDMA_READ_RTR, MPA_V2_RDMA_WRITE_RTR
>> + */
>> +static __be16 rtr_type = MPA_V2_RDMA_READ_RTR |
>MPA_V2_RDMA_WRITE_RTR;
>> +static const bool relaxed_ird_negotiation = 1;
>> +
>> +static void siw_cm_llp_state_change(struct sock *s);
>> +static void siw_cm_llp_data_ready(struct sock *s);
>> +static void siw_cm_llp_write_space(struct sock *s);
>> +static void siw_cm_llp_error_report(struct sock *s);
>> +static int siw_cm_upcall(struct siw_cep *cep, enum
>iw_cm_event_type reson,
>> +			 int status);
>> +
>> +static void siw_sk_assign_cm_upcalls(struct sock *sk)
>> +{
>> +	write_lock_bh(&sk->sk_callback_lock);
>> +	sk->sk_state_change = siw_cm_llp_state_change;
>> +	sk->sk_data_ready = siw_cm_llp_data_ready;
>> +	sk->sk_write_space = siw_cm_llp_write_space;
>> +	sk->sk_error_report = siw_cm_llp_error_report;
>> +	write_unlock_bh(&sk->sk_callback_lock);
>> +}
>> +
>> +static void siw_sk_save_upcalls(struct sock *sk)
>> +{
>> +	struct siw_cep *cep = sk_to_cep(sk);
>> +
>> +	write_lock_bh(&sk->sk_callback_lock);
>> +	cep->sk_state_change = sk->sk_state_change;
>> +	cep->sk_data_ready = sk->sk_data_ready;
>> +	cep->sk_write_space = sk->sk_write_space;
>> +	cep->sk_error_report = sk->sk_error_report;
>> +	write_unlock_bh(&sk->sk_callback_lock);
>> +}
>> +
>> +static void siw_sk_restore_upcalls(struct sock *sk, struct siw_cep
>*cep)
>> +{
>> +	sk->sk_state_change = cep->sk_state_change;
>> +	sk->sk_data_ready = cep->sk_data_ready;
>> +	sk->sk_write_space = cep->sk_write_space;
>> +	sk->sk_error_report = cep->sk_error_report;
>> +	sk->sk_user_data = NULL;
>> +}
>> +
>> +static void siw_qp_socket_assoc(struct siw_cep *cep, struct siw_qp
>*qp)
>> +{
>> +	struct socket *s = cep->llp.sock;
>> +	struct sock *sk = s->sk;
>> +
>> +	write_lock_bh(&sk->sk_callback_lock);
>> +
>> +	qp->attrs.sk = s;
>> +	sk->sk_data_ready = siw_qp_llp_data_ready;
>> +	sk->sk_write_space = siw_qp_llp_write_space;
>> +
>> +	write_unlock_bh(&sk->sk_callback_lock);
>> +}
>> +
>> +static void siw_socket_disassoc(struct socket *s)
>> +{
>> +	struct sock *sk = s->sk;
>> +	struct siw_cep *cep;
>> +
>> +	if (sk) {
>> +		write_lock_bh(&sk->sk_callback_lock);
>> +		cep = sk_to_cep(sk);
>> +		if (cep) {
>> +			siw_sk_restore_upcalls(sk, cep);
>> +			siw_cep_put(cep);
>> +		} else
>> +			pr_warn("siw: cannot restore sk callbacks: no ep\n");
>> +		write_unlock_bh(&sk->sk_callback_lock);
>> +	} else {
>> +		pr_warn("siw: cannot restore sk callbacks: no sk\n");
>> +	}
>> +}
>> +
>> +static void siw_rtr_data_ready(struct sock *sk)
>> +{
>> +	struct siw_cep *cep;
>> +	struct siw_qp *qp = NULL;
>> +	read_descriptor_t rd_desc;
>> +
>> +	read_lock(&sk->sk_callback_lock);
>> +
>> +	cep = sk_to_cep(sk);
>> +	if (!cep) {
>> +		WARN(1, "No connection endpoint\n");
>> +		goto out;
>> +	}
>> +	qp = sk_to_qp(sk);
>> +
>> +	memset(&rd_desc, 0, sizeof(rd_desc));
>> +	rd_desc.arg.data = qp;
>> +	rd_desc.count = 1;
>> +
>> +	tcp_read_sock(sk, &rd_desc, siw_tcp_rx_data);
>> +	/*
>> +	 * Check if first frame was successfully processed.
>> +	 * Signal connection full establishment if yes.
>> +	 * Failed data processing would have already scheduled
>> +	 * connection drop.
>> +	 */
>> +	if (!qp->rx_ctx.rx_suspend)
>> +		siw_cm_upcall(cep, IW_CM_EVENT_ESTABLISHED, 0);
>> +out:
>> +	read_unlock(&sk->sk_callback_lock);
>> +	if (qp)
>> +		siw_qp_socket_assoc(cep, qp);
>> +}
>> +
>> +static void siw_sk_assign_rtr_upcalls(struct siw_cep *cep)
>> +{
>> +	struct sock *sk = cep->llp.sock->sk;
>> +
>> +	write_lock_bh(&sk->sk_callback_lock);
>> +	sk->sk_data_ready = siw_rtr_data_ready;
>> +	sk->sk_write_space = siw_qp_llp_write_space;
>> +	write_unlock_bh(&sk->sk_callback_lock);
>> +}
>> +
>> +static inline int kernel_peername(struct socket *s, struct
>sockaddr_in *addr)
>> +{
>> +	return s->ops->getname(s, (struct sockaddr *)addr, 1);
>> +}
>> +
>> +static inline int kernel_localname(struct socket *s, struct
>sockaddr_in *addr)
>> +{
>> +	return s->ops->getname(s, (struct sockaddr *)addr, 0);
>> +}
>> +
>> +static void siw_cep_socket_assoc(struct siw_cep *cep, struct
>socket *s)
>> +{
>> +	cep->llp.sock = s;
>> +	siw_cep_get(cep);
>> +	s->sk->sk_user_data = cep;
>> +
>> +	siw_sk_save_upcalls(s->sk);
>> +	siw_sk_assign_cm_upcalls(s->sk);
>> +}
>> +
>> +static struct siw_cep *siw_cep_alloc(struct siw_device *sdev)
>> +{
>> +	struct siw_cep *cep = kzalloc(sizeof(*cep), GFP_KERNEL);
>> +
>> +	if (cep) {
>
>It is not preferred coding style.

OK I better put 'if (!cep) return NULL;'

>
>> +		unsigned long flags;
>> +
>> +		INIT_LIST_HEAD(&cep->listenq);
>> +		INIT_LIST_HEAD(&cep->devq);
>> +		INIT_LIST_HEAD(&cep->work_freelist);
>> +
>> +		kref_init(&cep->ref);
>> +		cep->state = SIW_EPSTATE_IDLE;
>> +		init_waitqueue_head(&cep->waitq);
>> +		spin_lock_init(&cep->lock);
>> +		cep->sdev = sdev;
>> +		cep->enhanced_rdma_conn_est = false;
>> +
>> +		spin_lock_irqsave(&sdev->lock, flags);
>> +		list_add_tail(&cep->devq, &sdev->cep_list);
>> +		spin_unlock_irqrestore(&sdev->lock, flags);
>> +		atomic_inc(&sdev->num_cep);
>> +
>> +		siw_dbg_cep(cep, "new object\n");
>> +	}
>> +	return cep;
>> +}
>> +
>> +static void siw_cm_free_work(struct siw_cep *cep)
>> +{
>> +	struct list_head *w, *tmp;
>> +	struct siw_cm_work *work;
>> +
>> +	list_for_each_safe(w, tmp, &cep->work_freelist) {
>> +		work = list_entry(w, struct siw_cm_work, list);
>> +		list_del(&work->list);
>> +		kfree(work);
>> +	}
>> +}
>> +
>> +static void siw_cancel_mpatimer(struct siw_cep *cep)
>> +{
>> +	spin_lock_bh(&cep->lock);
>> +	if (cep->mpa_timer) {
>> +		if (cancel_delayed_work(&cep->mpa_timer->work)) {
>> +			siw_cep_put(cep);
>> +			kfree(cep->mpa_timer); /* not needed again */
>> +		}
>> +		cep->mpa_timer = NULL;
>> +	}
>> +	spin_unlock_bh(&cep->lock);
>> +}
>> +
>> +static void siw_put_work(struct siw_cm_work *work)
>> +{
>> +	INIT_LIST_HEAD(&work->list);
>> +	spin_lock_bh(&work->cep->lock);
>> +	list_add(&work->list, &work->cep->work_freelist);
>> +	spin_unlock_bh(&work->cep->lock);
>> +}
>> +
>> +static void siw_cep_set_inuse(struct siw_cep *cep)
>> +{
>> +	unsigned long flags;
>> +	int rv;
>> +retry:
>> +	siw_dbg_cep(cep, "current in_use %d\n", cep->in_use);
>> +
>> +	spin_lock_irqsave(&cep->lock, flags);
>> +
>> +	if (cep->in_use) {
>> +		spin_unlock_irqrestore(&cep->lock, flags);
>> +		rv = wait_event_interruptible(cep->waitq, !cep->in_use);
>> +		if (signal_pending(current))
>> +			flush_signals(current);
>> +		goto retry;
>> +	} else {
>> +		cep->in_use = 1;
>> +		spin_unlock_irqrestore(&cep->lock, flags);
>> +	}
>> +}
>> +
>> +static void siw_cep_set_free(struct siw_cep *cep)
>> +{
>> +	unsigned long flags;
>> +
>> +	siw_dbg_cep(cep, "current in_use %d\n", cep->in_use);
>> +
>> +	spin_lock_irqsave(&cep->lock, flags);
>> +	cep->in_use = 0;
>> +	spin_unlock_irqrestore(&cep->lock, flags);
>> +
>> +	wake_up(&cep->waitq);
>> +}
>> +
>> +static void __siw_cep_dealloc(struct kref *ref)
>> +{
>> +	struct siw_cep *cep = container_of(ref, struct siw_cep, ref);
>> +	struct siw_device *sdev = cep->sdev;
>> +	unsigned long flags;
>> +
>> +	siw_dbg_cep(cep, "free object\n");
>> +
>> +	WARN_ON(cep->listen_cep);
>> +
>> +	/* kfree(NULL) is safe */
>> +	kfree(cep->mpa.pdata);
>> +	spin_lock_bh(&cep->lock);
>> +	if (!list_empty(&cep->work_freelist))
>> +		siw_cm_free_work(cep);
>> +	spin_unlock_bh(&cep->lock);
>> +
>> +	spin_lock_irqsave(&sdev->lock, flags);
>> +	list_del(&cep->devq);
>> +	spin_unlock_irqrestore(&sdev->lock, flags);
>> +	atomic_dec(&sdev->num_cep);
>> +	kfree(cep);
>> +}
>> +
>> +static struct siw_cm_work *siw_get_work(struct siw_cep *cep)
>> +{
>> +	struct siw_cm_work *work = NULL;
>> +
>> +	spin_lock_bh(&cep->lock);
>> +	if (!list_empty(&cep->work_freelist)) {
>> +		work = list_entry(cep->work_freelist.next, struct siw_cm_work,
>> +				  list);
>> +		list_del_init(&work->list);
>> +	}
>> +	spin_unlock_bh(&cep->lock);
>> +	return work;
>> +}
>> +
>> +static int siw_cm_alloc_work(struct siw_cep *cep, int num)
>> +{
>> +	struct siw_cm_work *work;
>> +
>> +	while (num--) {
>> +		work = kmalloc(sizeof(*work), GFP_KERNEL);
>> +		if (!work) {
>> +			if (!(list_empty(&cep->work_freelist)))
>> +				siw_cm_free_work(cep);
>> +			return -ENOMEM;
>> +		}
>> +		work->cep = cep;
>> +		INIT_LIST_HEAD(&work->list);
>> +		list_add(&work->list, &cep->work_freelist);
>> +	}
>> +	return 0;
>> +}
>> +
>> +/*
>> + * siw_cm_upcall()
>> + *
>> + * Upcall to IWCM to inform about async connection events
>> + */
>> +static int siw_cm_upcall(struct siw_cep *cep, enum
>iw_cm_event_type reason,
>> +			 int status)
>> +{
>> +	struct iw_cm_event event;
>> +	struct iw_cm_id *cm_id;
>> +
>> +	memset(&event, 0, sizeof(event));
>> +	event.status = status;
>> +	event.event = reason;
>> +
>> +	if (reason == IW_CM_EVENT_CONNECT_REQUEST) {
>> +		event.provider_data = cep;
>> +		cm_id = cep->listen_cep->cm_id;
>> +	} else {
>> +		cm_id = cep->cm_id;
>> +	}
>> +	/* Signal private data and address information */
>> +	if (reason == IW_CM_EVENT_CONNECT_REQUEST ||
>> +	    reason == IW_CM_EVENT_CONNECT_REPLY) {
>> +		u16 pd_len = be16_to_cpu(cep->mpa.hdr.params.pd_len);
>> +
>> +		if (pd_len) {
>> +			/*
>> +			 * hand over MPA private data
>> +			 */
>> +			event.private_data_len = pd_len;
>> +			event.private_data = cep->mpa.pdata;
>> +
>> +			/* Hide MPA V2 IRD/ORD control */
>> +			if (cep->enhanced_rdma_conn_est) {
>> +				event.private_data_len -=
>> +					sizeof(struct mpa_v2_data);
>> +				event.private_data +=
>> +					sizeof(struct mpa_v2_data);
>> +			}
>> +		}
>> +		to_sockaddr_in(event.local_addr) = cep->llp.laddr;
>> +		to_sockaddr_in(event.remote_addr) = cep->llp.raddr;
>> +	}
>> +	/* Signal IRD and ORD */
>> +	if (reason == IW_CM_EVENT_ESTABLISHED ||
>> +	    reason == IW_CM_EVENT_CONNECT_REPLY) {
>> +		/* Signal negotiated IRD/ORD values we will use */
>> +		event.ird = cep->ird;
>> +		event.ord = cep->ord;
>> +	} else if (reason == IW_CM_EVENT_CONNECT_REQUEST) {
>> +		event.ird = cep->ord;
>> +		event.ord = cep->ird;
>> +	}
>> +	siw_dbg_cep(cep, "[QP %u]: id 0x%p, reason=%d, status=%d\n",
>> +		    cep->qp ? cep->qp->id : -1, cm_id, reason, status);
>> +
>> +	return cm_id->event_handler(cm_id, &event);
>> +}
>> +
>> +/*
>> + * siw_qp_cm_drop()
>> + *
>> + * Drops established LLP connection if present and not already
>> + * scheduled for dropping. Called from user context, SQ workqueue
>> + * or receive IRQ. Caller signals if socket can be immediately
>> + * closed (basically, if not in IRQ).
>> + */
>> +void siw_qp_cm_drop(struct siw_qp *qp, int schedule)
>> +{
>> +	struct siw_cep *cep = qp->cep;
>> +
>> +	qp->rx_ctx.rx_suspend = 1;
>> +	qp->tx_ctx.tx_suspend = 1;
>> +
>> +	if (!qp->cep)
>> +		return;
>> +
>> +	if (schedule) {
>> +		siw_cm_queue_work(cep, SIW_CM_WORK_CLOSE_LLP);
>> +	} else {
>> +		siw_cep_set_inuse(cep);
>> +
>> +		if (cep->state == SIW_EPSTATE_CLOSED) {
>> +			siw_dbg_cep(cep, "already closed\n");
>> +			goto out;
>> +		}
>> +		siw_dbg_cep(cep, "immediate close, state %d\n", cep->state);
>> +
>> +		if (qp->term_info.valid)
>> +			siw_send_terminate(qp);
>> +
>> +		if (cep->cm_id) {
>> +			switch (cep->state) {
>> +			case SIW_EPSTATE_AWAIT_MPAREP:
>> +				siw_cm_upcall(cep, IW_CM_EVENT_CONNECT_REPLY,
>> +					      -EINVAL);
>> +				break;
>> +
>> +			case SIW_EPSTATE_RDMA_MODE:
>> +				siw_cm_upcall(cep, IW_CM_EVENT_CLOSE, 0);
>> +				break;
>> +
>> +			case SIW_EPSTATE_IDLE:
>> +			case SIW_EPSTATE_LISTENING:
>> +			case SIW_EPSTATE_CONNECTING:
>> +			case SIW_EPSTATE_AWAIT_MPAREQ:
>> +			case SIW_EPSTATE_RECVD_MPAREQ:
>> +			case SIW_EPSTATE_CLOSED:
>> +			default:
>> +				break;
>> +			}
>> +			cep->cm_id->rem_ref(cep->cm_id);
>> +			cep->cm_id = NULL;
>> +			siw_cep_put(cep);
>> +		}
>> +		cep->state = SIW_EPSTATE_CLOSED;
>> +
>> +		if (cep->llp.sock) {
>> +			siw_socket_disassoc(cep->llp.sock);
>> +			/*
>> +			 * Immediately close socket
>> +			 */
>> +			sock_release(cep->llp.sock);
>> +			cep->llp.sock = NULL;
>> +		}
>> +		if (cep->qp) {
>> +			cep->qp = NULL;
>> +			siw_qp_put(qp);
>> +		}
>> +out:
>> +		siw_cep_set_free(cep);
>> +	}
>> +}
>> +
>> +void siw_cep_put(struct siw_cep *cep)
>> +{
>> +	siw_dbg_cep(cep, "new refcount: %d\n", kref_read(&cep->ref) - 1);
>> +
>> +	WARN_ON(kref_read(&cep->ref) < 1);
>> +	kref_put(&cep->ref, __siw_cep_dealloc);
>> +}
>> +
>> +void siw_cep_get(struct siw_cep *cep)
>> +{
>> +	kref_get(&cep->ref);
>> +	siw_dbg_cep(cep, "new refcount: %d\n", kref_read(&cep->ref));
>> +}
>
>Another kref_get/put wrappers, unlikely needed.
>
It just avoids writing down the free routine in each
put call, and I used it to add some debug info for
tracking status. So I would remove it if it you tell me it's
bad style...

