Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B93D4DEF0F
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 16:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbfJUONr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 10:13:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37868 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbfJUONk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 10:13:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9LE4gfr033644;
        Mon, 21 Oct 2019 14:13:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=+29ncgnpyh/qMHWMstLHBkOjDQUwq0rIWinNiZlFlEs=;
 b=jqqz8BQsIbFEjY3x8f/NKuXZOIBtV83sWyo3zqcg8leVred8xHqdqwi8tk5asrVUreko
 G4sbUB29A66rJjFV4n5l9EBRACTVZ9DxmLiF8XZFZniNsvfyn0Cx+ttfZ0C6X6SCrJyQ
 q8dtQv/HIXN3j5hpJvPG3tRTL2812BPVgewrsYpNQ/p/IdldsucX3MFTpTpwjN4xDE0X
 PeCiwsSoElDdciWPNezuA2wkJ3GxciFS2rT48qi4X6FXUoab8p/ggObFDdaVn8Vl3saN
 FT6J/sqqvDoDiKuG7JBqr/yeVNIGRoL1Fkkzgo4NZ44WyqU8L9g/2nD0xSibzpi42fSv Yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vqswt81hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Oct 2019 14:13:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9LEDLrR174075;
        Mon, 21 Oct 2019 14:13:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vrcna9j21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Oct 2019 14:13:30 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9LEDUsP008087;
        Mon, 21 Oct 2019 14:13:30 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Oct 2019 07:13:29 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v4] IB/core: Trace points for diagnosing completion queue
 issues
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <AM0PR05MB48660334D7B9A57EB994D535D1690@AM0PR05MB4866.eurprd05.prod.outlook.com>
Date:   Mon, 21 Oct 2019 10:13:28 -0400
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <41BF3059-1A87-4184-A429-82EFE1DBD49D@oracle.com>
References: <20191012193714.3336.53797.stgit@manet.1015granger.net>
 <AM0PR05MB48660334D7B9A57EB994D535D1690@AM0PR05MB4866.eurprd05.prod.outlook.com>
To:     Parav Pandit <parav@mellanox.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9416 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910210135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9416 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910210134
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Oct 20, 2019, at 8:07 PM, Parav Pandit <parav@mellanox.com> wrote:
>=20
>=20
>=20
>> -----Original Message-----
>> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
>> owner@vger.kernel.org> On Behalf Of Chuck Lever
>> Sent: Saturday, October 12, 2019 2:43 PM
>> To: linux-rdma@vger.kernel.org
>> Subject: [PATCH v4] IB/core: Trace points for diagnosing completion =
queue
>> issues
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> drivers/infiniband/core/Makefile |    2
>> drivers/infiniband/core/cq.c     |   27 ++++
>> drivers/infiniband/core/trace.c  |   14 ++
>> include/rdma/ib_verbs.h          |    5 +
>> include/trace/events/rdma_core.h |  251
>> ++++++++++++++++++++++++++++++++++++++
>> 5 files changed, 295 insertions(+), 4 deletions(-)  create mode =
100644
>> drivers/infiniband/core/trace.c  create mode 100644
>> include/trace/events/rdma_core.h
>>=20
>> Changes since v3:
>> - Reverted unnecessary behavior change in __ib_process_cq
>> - Clarified what "id" is in trace point output
>> - Added comment before new fields in struct ib_cq
>> - New trace point that fires when there is a CQ allocation failure
>>=20
>> Changes since v2:
>> - Removed extraneous changes to include/trace/events/rdma.h
>>=20
>> Changes since RFC:
>> - Display CQ's global resource ID instead of it's pointer address
>>=20
>> diff --git a/drivers/infiniband/core/Makefile
>> b/drivers/infiniband/core/Makefile
>> index 09881bd..68d9e27 100644
>> --- a/drivers/infiniband/core/Makefile
>> +++ b/drivers/infiniband/core/Makefile
>> @@ -11,7 +11,7 @@ ib_core-y :=3D			packer.o =
ud_header.o
>> verbs.o cq.o rw.o sysfs.o \
>> 				device.o fmr_pool.o cache.o netlink.o \
>> 				roce_gid_mgmt.o mr_pool.o addr.o
>> sa_query.o \
>> 				multicast.o mad.o smi.o agent.o =
mad_rmpp.o
>> \
>> -				nldev.o restrack.o counters.o
>> +				nldev.o restrack.o counters.o trace.o
>>=20
>> ib_core-$(CONFIG_SECURITY_INFINIBAND) +=3D security.o
>> ib_core-$(CONFIG_CGROUP_RDMA) +=3D cgroup.o diff --git
>> a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c index
>> bbfded6..e035895 100644
>> --- a/drivers/infiniband/core/cq.c
>> +++ b/drivers/infiniband/core/cq.c
>> @@ -7,6 +7,8 @@
>> #include <linux/slab.h>
>> #include <rdma/ib_verbs.h>
>>=20
>> +#include <trace/events/rdma_core.h>
>> +
>> /* # of WCs to poll for with a single call to ib_poll_cq */
>> #define IB_POLL_BATCH			16
>> #define IB_POLL_BATCH_DIRECT		8
>> @@ -41,6 +43,7 @@ static void ib_cq_rdma_dim_work(struct work_struct
>> *w)
>>=20
>> 	dim->state =3D DIM_START_MEASURE;
>>=20
>> +	trace_cq_modify(cq, comps, usec);
>> 	cq->device->ops.modify_cq(cq, comps, usec);  }
>>=20
>> @@ -65,18 +68,29 @@ static void rdma_dim_init(struct ib_cq *cq)
>> 	INIT_WORK(&dim->work, ib_cq_rdma_dim_work);  }
>>=20
>> +static int __ib_poll_cq(struct ib_cq *cq, int num_entries, struct =
ib_wc
>> +*wc) {
>> +	int rc;
>> +
>> +	rc =3D ib_poll_cq(cq, num_entries, wc);
>> +	trace_cq_poll(cq, num_entries, rc);
>> +	return rc;
>> +}
>> +
>> static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc =
*wcs,
>> 			   int batch)
>> {
>> 	int i, n, completed =3D 0;
>>=20
>> +	trace_cq_process(cq);
>> +
>> 	/*
>> 	 * budget might be (-1) if the caller does not
>> 	 * want to bound this call, thus we need unsigned
>> 	 * minimum here.
>> 	 */
>> -	while ((n =3D ib_poll_cq(cq, min_t(u32, batch,
>> -					 budget - completed), wcs)) > 0) =
{
>> +	while ((n =3D __ib_poll_cq(cq, min_t(u32, batch,
>> +					   budget - completed), wcs)) > =
0) {
>> 		for (i =3D 0; i < n; i++) {
>> 			struct ib_wc *wc =3D &wcs[i];
>>=20
>> @@ -131,8 +145,10 @@ static int ib_poll_handler(struct irq_poll *iop, =
int
>> budget)
>> 	completed =3D __ib_process_cq(cq, budget, cq->wc, =
IB_POLL_BATCH);
>> 	if (completed < budget) {
>> 		irq_poll_complete(&cq->iop);
>> -		if (ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
>> +		if (ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0) {
>> +			trace_cq_reschedule(cq);
>> 			irq_poll_sched(&cq->iop);
>> +		}
>> 	}
>>=20
>> 	if (dim)
>> @@ -143,6 +159,7 @@ static int ib_poll_handler(struct irq_poll *iop, =
int
>> budget)
>>=20
>> static void ib_cq_completion_softirq(struct ib_cq *cq, void *private) =
 {
>> +	trace_cq_schedule(cq);
>> 	irq_poll_sched(&cq->iop);
>> }
>>=20
>> @@ -162,6 +179,7 @@ static void ib_cq_poll_work(struct work_struct
>> *work)
>>=20
>> static void ib_cq_completion_workqueue(struct ib_cq *cq, void =
*private)  {
>> +	trace_cq_schedule(cq);
>> 	queue_work(cq->comp_wq, &cq->work);
>> }
>>=20
>> @@ -239,6 +257,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device
>> *dev, void *private,
>> 		goto out_destroy_cq;
>> 	}
>>=20
>> +	trace_cq_alloc(cq, nr_cqe, comp_vector, poll_ctx);
>> 	return cq;
>>=20
>> out_destroy_cq:
>> @@ -248,6 +267,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device
>> *dev, void *private,
>> 	kfree(cq->wc);
>> out_free_cq:
>> 	kfree(cq);
>> +	trace_cq_alloc_error(nr_cqe, comp_vector, poll_ctx, ret);
>> 	return ERR_PTR(ret);
>> }
>> EXPORT_SYMBOL(__ib_alloc_cq_user);
>> @@ -304,6 +324,7 @@ void ib_free_cq_user(struct ib_cq *cq, struct
>> ib_udata *udata)
>> 		WARN_ON_ONCE(1);
>> 	}
>>=20
>> +	trace_cq_free(cq);
>> 	rdma_restrack_del(&cq->res);
>> 	cq->device->ops.destroy_cq(cq, udata);
>> 	if (cq->dim)
>> diff --git a/drivers/infiniband/core/trace.c =
b/drivers/infiniband/core/trace.c
>> new file mode 100644 index 0000000..6c3514b
>> --- /dev/null
>> +++ b/drivers/infiniband/core/trace.c
>> @@ -0,0 +1,14 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Trace points for core RDMA functions.
>> + *
>> + * Author: Chuck Lever <chuck.lever@oracle.com>
>> + *
>> + * Copyright (c) 2019, Oracle and/or its affiliates. All rights =
reserved.
>> + */
>> +
>> +#define CREATE_TRACE_POINTS
>> +
>> +#include <rdma/ib_verbs.h>
>> +
>> +#include <trace/events/rdma_core.h>
>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h index
>> 6a47ba8..43468a3 100644
>> --- a/include/rdma/ib_verbs.h
>> +++ b/include/rdma/ib_verbs.h
>> @@ -1555,6 +1555,11 @@ struct ib_cq {
>> 	};
>> 	struct workqueue_struct *comp_wq;
>> 	struct dim *dim;
>> +
>> +	/* updated only by trace points */
>> +	ktime_t timestamp;
>> +	bool interrupt;
>> +
>> 	/*
>> 	 * Implementation details of the RDMA core, don't use in =
drivers:
>> 	 */
>> diff --git a/include/trace/events/rdma_core.h
>> b/include/trace/events/rdma_core.h
>> new file mode 100644
>> index 0000000..0d56065
>> --- /dev/null
>> +++ b/include/trace/events/rdma_core.h
>> @@ -0,0 +1,251 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Trace point definitions for core RDMA functions.
>> + *
>> + * Author: Chuck Lever <chuck.lever@oracle.com>
>> + *
>> + * Copyright (c) 2019, Oracle and/or its affiliates. All rights =
reserved.
>> + */
>> +
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM rdma_core
>> +
>> +#if !defined(_TRACE_RDMA_CORE_H) ||
>> defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_RDMA_CORE_H
>> +
>> +#include <linux/tracepoint.h>
>> +#include <rdma/ib_verbs.h>
>> +#include <rdma/restrack.h>
>> +
>> +/*
>> + * enum ib_poll_context, from include/rdma/ib_verbs.h  */
>> +#define IB_POLL_CTX_LIST			\
>> +	ib_poll_ctx(DIRECT)			\
>> +	ib_poll_ctx(SOFTIRQ)			\
>> +	ib_poll_ctx(WORKQUEUE)			\
>> +	ib_poll_ctx_end(UNBOUND_WORKQUEUE)
>> +
>> +#undef ib_poll_ctx
>> +#undef ib_poll_ctx_end
>> +
>> +#define ib_poll_ctx(x)		TRACE_DEFINE_ENUM(IB_POLL_##x);
>> +#define ib_poll_ctx_end(x)	TRACE_DEFINE_ENUM(IB_POLL_##x);
>> +
>> +IB_POLL_CTX_LIST
>> +
>> +#undef ib_poll_ctx
>> +#undef ib_poll_ctx_end
>> +
>> +#define ib_poll_ctx(x)		{ IB_POLL_##x, #x },
>> +#define ib_poll_ctx_end(x)	{ IB_POLL_##x, #x }
>> +
>> +#define rdma_show_ib_poll_ctx(x) \
>> +		__print_symbolic(x, IB_POLL_CTX_LIST)
>> +
>> +/**
>> + ** Completion Queue events
>> + **/
>> +
>> +TRACE_EVENT(cq_schedule,
>> +	TP_PROTO(
>> +		struct ib_cq *cq
>> +	),
>> +
>> +	TP_ARGS(cq),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(u32, id)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		cq->timestamp =3D ktime_get();
>> +		cq->interrupt =3D true;
>> +
>> +		__entry->id =3D cq->res.id;
>> +	),
>> +
>> +	TP_printk("cq.id=3D%u", __entry->id)
>> +);
>> +
>> +TRACE_EVENT(cq_reschedule,
>> +	TP_PROTO(
>> +		struct ib_cq *cq
>> +	),
>> +
>> +	TP_ARGS(cq),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(u32, id)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		cq->timestamp =3D ktime_get();
>> +		cq->interrupt =3D false;
>> +
>> +		__entry->id =3D cq->res.id;
>> +	),
>> +
>> +	TP_printk("cq.id=3D%u", __entry->id)
>> +);
>> +
>> +TRACE_EVENT(cq_process,
>> +	TP_PROTO(
>> +		const struct ib_cq *cq
>> +	),
>> +
>> +	TP_ARGS(cq),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(s64, latency)
>> +		__field(u32, id)
>> +		__field(bool, interrupt)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		ktime_t latency =3D ktime_sub(ktime_get(), =
cq->timestamp);
>> +
>> +		__entry->id =3D cq->res.id;
>> +		__entry->latency =3D ktime_to_us(latency);
>> +		__entry->interrupt =3D cq->interrupt;
>> +	),
>> +
>> +	TP_printk("cq.id=3D%u wake-up took %lld [us] from %s",
>> +		__entry->id, __entry->latency,
>> +		__entry->interrupt ? "interrupt" : "reschedule"
>> +	)
>> +);
>> +
>> +TRACE_EVENT(cq_poll,
>> +	TP_PROTO(
>> +		const struct ib_cq *cq,
>> +		int requested,
>> +		int rc
>> +	),
>> +
>> +	TP_ARGS(cq, requested, rc),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(u32, id)
>> +		__field(int, requested)
>> +		__field(int, rc)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->id =3D cq->res.id;
>> +		__entry->requested =3D requested;
>> +		__entry->rc =3D rc;
>> +	),
>> +
>> +	TP_printk("cq.id=3D%u requested %d, returned %d",
>> +		__entry->id, __entry->requested, __entry->rc
>> +	)
>> +);
>> +
>> +TRACE_EVENT(cq_modify,
>> +	TP_PROTO(
>> +		const struct ib_cq *cq,
>> +		u16 comps,
>> +		u16 usec
>> +	),
>> +
>> +	TP_ARGS(cq, comps, usec),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(u32, id)
>> +		__field(unsigned int, comps)
>> +		__field(unsigned int, usec)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->id =3D cq->res.id;
>> +		__entry->comps =3D comps;
>> +		__entry->usec =3D usec;
>> +	),
>> +
>> +	TP_printk("cq.id=3D%u comps=3D%u usec=3D%u",
>> +		__entry->id, __entry->comps, __entry->usec
>> +	)
>> +);
>> +
>> +TRACE_EVENT(cq_alloc,
>> +	TP_PROTO(
>> +		const struct ib_cq *cq,
>> +		int nr_cqe,
>> +		int comp_vector,
>> +		enum ib_poll_context poll_ctx
>> +	),
>> +
>> +	TP_ARGS(cq, nr_cqe, comp_vector, poll_ctx),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(u32, id)
>> +		__field(int, nr_cqe)
>> +		__field(int, comp_vector)
>> +		__field(unsigned long, poll_ctx)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->id =3D cq->res.id;
>> +		__entry->nr_cqe =3D nr_cqe;
>> +		__entry->comp_vector =3D comp_vector;
>> +		__entry->poll_ctx =3D poll_ctx;
>> +	),
>> +
>> +	TP_printk("cq.id=3D%u nr_cqe=3D%d comp_vector=3D%d poll_ctx=3D%s",=

>> +		__entry->id, __entry->nr_cqe, __entry->comp_vector,
>> +		rdma_show_ib_poll_ctx(__entry->poll_ctx)
>> +	)
>> +);
>> +
>> +TRACE_EVENT(cq_alloc_error,
>> +	TP_PROTO(
>> +		int nr_cqe,
>> +		int comp_vector,
>> +		enum ib_poll_context poll_ctx,
>> +		int rc
>> +	),
>> +
>> +	TP_ARGS(nr_cqe, comp_vector, poll_ctx, rc),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(int, rc)
>> +		__field(int, nr_cqe)
>> +		__field(int, comp_vector)
>> +		__field(unsigned long, poll_ctx)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->rc =3D rc;
>> +		__entry->nr_cqe =3D nr_cqe;
>> +		__entry->comp_vector =3D comp_vector;
>> +		__entry->poll_ctx =3D poll_ctx;
>> +	),
>> +
>> +	TP_printk("nr_cqe=3D%d comp_vector=3D%d poll_ctx=3D%s rc=3D%d",
>> +		__entry->nr_cqe, __entry->comp_vector,
>> +		rdma_show_ib_poll_ctx(__entry->poll_ctx), __entry->rc
>> +	)
>> +);
>> +
>> +TRACE_EVENT(cq_free,
>> +	TP_PROTO(
>> +		const struct ib_cq *cq
>> +	),
>> +
>> +	TP_ARGS(cq),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(u32, id)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->id =3D cq->res.id;
>> +	),
>> +
>> +	TP_printk("cq.id=3D%u", __entry->id)
>> +);
>> +
>> +#endif /* _TRACE_RDMA_CORE_H */
>> +
>> +#include <trace/define_trace.h>
> Reviewed-by: Parav Pandit <parav@mellanox.com>

Thank you, Parav!


--
Chuck Lever



