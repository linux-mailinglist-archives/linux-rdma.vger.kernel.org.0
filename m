Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E70A03CE8A
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 16:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391397AbfFKOUW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 11 Jun 2019 10:20:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388956AbfFKOUV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jun 2019 10:20:21 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BEE3ND055048
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2019 10:20:20 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.114])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2cvacahn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2019 10:20:19 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 Jun 2019 14:20:18 -0000
Received: from us1b3-smtp07.a3dr.sjc01.isc4sb.com (10.122.203.198)
        by smtp.notes.na.collabserv.com (10.122.47.58) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 Jun 2019 14:20:16 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp07.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019061114201580-569414 ;
          Tue, 11 Jun 2019 14:20:15 +0000 
In-Reply-To: <20190610054601.GC6369@mtr-leonro.mtl.com>
Subject: Re: [PATCH for-next v1 04/12] SIW connection management
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 11 Jun 2019 14:20:16 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190610054601.GC6369@mtr-leonro.mtl.com>,<20190526114156.6827-1-bmt@zurich.ibm.com>
 <20190526114156.6827-5-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: 5626C334:23F4407B-00258416:004EA6AB;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 24863
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19061114-9695-0000-0000-0000067C56BC
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.411265; ST=0; TS=0; UL=0; ISC=; MB=0.006710
X-IBM-SpamModules-Versions: BY=3.00011246; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01216459; UDB=6.00639603; IPR=6.00997558;
 BA=6.00006331; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027261; XFM=3.00000015;
 UTC=2019-06-11 14:20:18
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-06-11 11:40:24 - 6.00010036
x-cbparentid: 19061114-9696-0000-0000-000067C1654F
Message-Id: <OF5626C334.23F4407B-ON00258416.004EA6AB-00258416.004EC2A8@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 06/10/2019 07:46AM
>Cc: linux-rdma@vger.kernel.org
>Subject: [EXTERNAL] Re: [PATCH for-next v1 04/12] SIW connection
>management
>
>On Sun, May 26, 2019 at 01:41:48PM +0200, Bernard Metzler wrote:
>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> ---
>>  drivers/infiniband/sw/siw/siw_cm.c | 2109
>++++++++++++++++++++++++++++
>>  drivers/infiniband/sw/siw/siw_cm.h |  133 ++
>>  2 files changed, 2242 insertions(+)
>>  create mode 100644 drivers/infiniband/sw/siw/siw_cm.c
>>  create mode 100644 drivers/infiniband/sw/siw/siw_cm.h
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>b/drivers/infiniband/sw/siw/siw_cm.c
>> new file mode 100644
>> index 000000000000..831f8ca356c7
>> --- /dev/null
>> +++ b/drivers/infiniband/sw/siw/siw_cm.c
>> @@ -0,0 +1,2109 @@
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
>> +#include <net/addrconf.h>
>> +#include <linux/workqueue.h>
>> +#include <net/sock.h>
>> +#include <net/tcp.h>
>> +#include <linux/inet.h>
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
>iw_cm_event_type reason,
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
>> +	struct socket *s = cep->sock;
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
>> +	if (!qp->rx_stream.rx_suspend)
>> +		siw_cm_upcall(cep, IW_CM_EVENT_ESTABLISHED, 0);
>> +out:
>> +	read_unlock(&sk->sk_callback_lock);
>> +	if (qp)
>> +		siw_qp_socket_assoc(cep, qp);
>> +}
>> +
>> +static void siw_sk_assign_rtr_upcalls(struct siw_cep *cep)
>> +{
>> +	struct sock *sk = cep->sock->sk;
>> +
>> +	write_lock_bh(&sk->sk_callback_lock);
>> +	sk->sk_data_ready = siw_rtr_data_ready;
>> +	sk->sk_write_space = siw_qp_llp_write_space;
>> +	write_unlock_bh(&sk->sk_callback_lock);
>> +}
>> +
>> +static void siw_cep_socket_assoc(struct siw_cep *cep, struct
>socket *s)
>> +{
>> +	cep->sock = s;
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
>> +	unsigned long flags;
>> +
>> +	if (!cep)
>> +		return NULL;
>> +
>> +	INIT_LIST_HEAD(&cep->listenq);
>> +	INIT_LIST_HEAD(&cep->devq);
>> +	INIT_LIST_HEAD(&cep->work_freelist);
>> +
>> +	kref_init(&cep->ref);
>> +	cep->state = SIW_EPSTATE_IDLE;
>> +	init_waitqueue_head(&cep->waitq);
>> +	spin_lock_init(&cep->lock);
>> +	cep->sdev = sdev;
>> +	cep->enhanced_rdma_conn_est = false;
>> +
>> +	spin_lock_irqsave(&sdev->lock, flags);
>> +	list_add_tail(&cep->devq, &sdev->cep_list);
>> +	spin_unlock_irqrestore(&sdev->lock, flags);
>> +	atomic_inc(&sdev->num_cep);
>> +
>> +	siw_dbg_cep(cep, "new object\n");
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
>
>All this code that tries to implement memory pools should gone.
>

I maintain that memory only to schedule work for the connection
management, see 'enum siw_work_type' for possible work.

Thanks,
Bernard.

