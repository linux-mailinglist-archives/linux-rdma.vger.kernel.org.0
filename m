Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD037D46C6
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2019 19:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfJKRip (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Oct 2019 13:38:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53002 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbfJKRip (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Oct 2019 13:38:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9BHENni177843;
        Fri, 11 Oct 2019 17:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=joRr+GDGX80OpBnOl09p7tRf9QLiYPrUEzXNRYQCbq4=;
 b=bd1a+8bVDikinUkh8uZA/iUpukG0X90tPJsYxZU5dLFSLU4lpygMVoh68Uvtqe6kfdPF
 gNOxVkrGQaVoESYLhXZZZJx2vG2I4tHaW9lwkbflweRwW9qFgjLWm8yh5BVaLgDCn2/Q
 QH6MgR4By1GLtIqtmBU5jJblH5WFS6VpR9cxnKeYr5+xMZt3od8j7qklx6FJ6sdLYOH/
 5SUZ88rpo8UnSDsMCe8ClGWaOj2iZPraOh0phgLBqH9Ane3G1kJeok+u1qdtkqrImlqu
 aat+REYMdQZaz3Sa6N6MHtDkhpXOlL5aP66mING5LeBSA02GRpU4rmKO9QCiS/XPF/mJ MA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vekts2vmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 17:38:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9BHExsf161918;
        Fri, 11 Oct 2019 17:38:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vjdyme359-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 17:38:36 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9BHca1S007918;
        Fri, 11 Oct 2019 17:38:36 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Oct 2019 10:38:35 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3] IB/core: Trace points for diagnosing completion queue
 issues
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <AM0PR05MB48665D73CD796FC65A29C356D1970@AM0PR05MB4866.eurprd05.prod.outlook.com>
Date:   Fri, 11 Oct 2019 13:38:34 -0400
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <54FEAA5A-AF8D-4604-9AEE-3B61DB26325B@oracle.com>
References: <20191009165219.2202.56785.stgit@manet.1015granger.net>
 <AM0PR05MB48665D73CD796FC65A29C356D1970@AM0PR05MB4866.eurprd05.prod.outlook.com>
To:     Parav Pandit <parav@mellanox.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9407 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910110150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9407 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910110150
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Oct 11, 2019, at 1:26 PM, Parav Pandit <parav@mellanox.com> wrote:
>=20
>=20
>=20
>> -----Original Message-----
>> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
>> owner@vger.kernel.org> On Behalf Of Chuck Lever
>> Sent: Wednesday, October 9, 2019 11:55 AM
>> To: linux-rdma@vger.kernel.org
>> Subject: [PATCH v3] IB/core: Trace points for diagnosing completion =
queue
>> issues
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> drivers/infiniband/core/Makefile |    2
>> drivers/infiniband/core/cq.c     |   29 +++--
>> drivers/infiniband/core/trace.c  |   14 ++
>> include/rdma/ib_verbs.h          |    2
>> include/trace/events/rdma_core.h |  218
>> ++++++++++++++++++++++++++++++++++++++
>> 5 files changed, 255 insertions(+), 10 deletions(-)  create mode =
100644
>> drivers/infiniband/core/trace.c  create mode 100644
>> include/trace/events/rdma_core.h
>>=20
>> Changes since v2:
>> - Removed extraneous changes to include/trace/events/rdma.h
>>=20
>> Changes since RFC:
>> - Addressed comments from Parav Pandit <parav@mellanox.com>
>>=20
>>=20
>> diff --git a/drivers/infiniband/core/Makefile =
b/drivers/infiniband/core/Makefile
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
mad_rmpp.o \
>> -				nldev.o restrack.o counters.o
>> +				nldev.o restrack.o counters.o trace.o
>>=20
>> ib_core-$(CONFIG_SECURITY_INFINIBAND) +=3D security.o
>> ib_core-$(CONFIG_CGROUP_RDMA) +=3D cgroup.o diff --git
>> a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c index
>> bbfded6..bcde992 100644
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
>> @@ -41,6 +43,7 @@ static void ib_cq_rdma_dim_work(struct work_struct =
*w)
>>=20
>> 	dim->state =3D DIM_START_MEASURE;
>>=20
>> +	trace_cq_modify(cq, comps, usec);
>> 	cq->device->ops.modify_cq(cq, comps, usec);  }
>>=20
>> @@ -70,13 +73,9 @@ static int __ib_process_cq(struct ib_cq *cq, int =
budget,
>> struct ib_wc *wcs,  {
>> 	int i, n, completed =3D 0;
>>=20
>> -	/*
>> -	 * budget might be (-1) if the caller does not
>> -	 * want to bound this call, thus we need unsigned
>> -	 * minimum here.
>> -	 */
>> -	while ((n =3D ib_poll_cq(cq, min_t(u32, batch,
>> -					 budget - completed), wcs)) > 0) =
{
>> +	trace_cq_process(cq);
>> +	while ((n =3D ib_poll_cq(cq, batch, wcs)) > 0) {
> Before this change, on first attempt to poll the cq, it will poll for =
min(batch, budget).
> With this change, it will poll for batch.
> This is functional change than just adding the trace points.
> I am not sure if this has any effect on the overall polling.
> But it may be worth to keep such functional change in pre-patch which =
consist of this change, moving comment section, batch recalculation.

Or find a way to add the trace point without the functional change.


>> +		trace_cq_poll(cq, batch, n);
>> 		for (i =3D 0; i < n; i++) {
>> 			struct ib_wc *wc =3D &wcs[i];
>>=20
>> @@ -87,9 +86,15 @@ static int __ib_process_cq(struct ib_cq *cq, int =
budget,
>> struct ib_wc *wcs,
>> 		}
>>=20
>> 		completed +=3D n;
>> -
>> 		if (n !=3D batch || (budget !=3D -1 && completed >=3D =
budget))
>> 			break;
>> +
>> +		/*
>> +		 * budget might be (-1) if the caller does not
>> +		 * want to bound this call, thus we need unsigned
>> +		 * minimum here.
>> +		 */
>> +		batch =3D min_t(u32, batch, budget - completed);
>> 	}
>>=20
>> 	return completed;
>> @@ -131,8 +136,10 @@ static int ib_poll_handler(struct irq_poll *iop, =
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
>> @@ -143,6 +150,7 @@ static int ib_poll_handler(struct irq_poll *iop, =
int
>> budget)
>>=20
>> static void ib_cq_completion_softirq(struct ib_cq *cq, void *private) =
 {
>> +	trace_cq_schedule(cq);
>> 	irq_poll_sched(&cq->iop);
>> }
>>=20
>> @@ -162,6 +170,7 @@ static void ib_cq_poll_work(struct work_struct =
*work)
>>=20
>> static void ib_cq_completion_workqueue(struct ib_cq *cq, void =
*private)  {
>> +	trace_cq_schedule(cq);
>> 	queue_work(cq->comp_wq, &cq->work);
>> }
>>=20
>> @@ -239,6 +248,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device =
*dev,
>> void *private,
>> 		goto out_destroy_cq;
>> 	}
>>=20
>> +	trace_cq_alloc(cq, comp_vector, poll_ctx);
>> 	return cq;
>>=20
>> out_destroy_cq:
>> @@ -304,6 +314,7 @@ void ib_free_cq_user(struct ib_cq *cq, struct =
ib_udata
>> *udata)
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
>> 6a47ba8..95a6bce 100644
>> --- a/include/rdma/ib_verbs.h
>> +++ b/include/rdma/ib_verbs.h
>> @@ -1555,6 +1555,8 @@ struct ib_cq {
>> 	};
>> 	struct workqueue_struct *comp_wq;
>> 	struct dim *dim;
>> +	ktime_t timestamp;
>> +	bool interrupt;
> Its unclear when to update timestamp and interrupt. Comment will help.

These are both updated only in the new trace points. Is more than
that needed in a comment?


>> 	/*
>> 	 * Implementation details of the RDMA core, don't use in =
drivers:
>> 	 */
>> diff --git a/include/trace/events/rdma_core.h
>> b/include/trace/events/rdma_core.h
>> new file mode 100644
>> index 0000000..c1397a3
>> --- /dev/null
>> +++ b/include/trace/events/rdma_core.h
>> @@ -0,0 +1,218 @@
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
>> +	TP_printk("id %u", __entry->id)
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
>> +	TP_printk("id %u", __entry->id)
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
>> +	TP_printk("id %u wake-up took %lld [us] from %s",
> It might be better to prefix 'id' with 'cq', so that in future rdma =
wide trace points, we can have multiple resource id's printed =
consistently as qpid, cqid, mrid etc; and don't have to rely on the =
function where it is used to decode what that id means.

I left out the "cq" here because the trace point names are prefixed
with "cq_". However, now that you bring it up, I can imagine cases
where a trace point might report information about two different
resources that both have a restrack ID.

How about "cq.id=3D%u" ?


> I had mixed thoughts on whether to pass ib_cq* or =
rdma_restrack_entry*.
> I was thinking of rdma_restrack_entry*, as it makes future code for =
other resources also anchored on the resource id.

On the other hand, a trace point might someday want to report the
value of a field in struct ib_cq.


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
>> +	TP_printk("id %u requested %d, returned %d",
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
>> +	TP_printk("id %u comps=3D%u usec=3D%u",
>> +		__entry->id, __entry->comps, __entry->usec
>> +	)
>> +);
>> +
>> +TRACE_EVENT(cq_alloc,
>> +	TP_PROTO(
>> +		const struct ib_cq *cq,
>> +		int comp_vector,
>> +		enum ib_poll_context poll_ctx
>> +	),
>> +
>> +	TP_ARGS(cq, comp_vector, poll_ctx),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(u32, id)
>> +		__field(int, comp_vector)
>> +		__field(unsigned long, poll_ctx)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->id =3D cq->res.id;
>> +		__entry->comp_vector =3D comp_vector;
>> +		__entry->poll_ctx =3D poll_ctx;
>> +	),
>> +
>> +	TP_printk("id %u comp_vector=3D%d poll_ctx=3D%s",
>> +		__entry->id, __entry->comp_vector,
>> +		rdma_show_ib_poll_ctx(__entry->poll_ctx)
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
>> +	TP_printk("id %u", __entry->id)
>> +);
>> +
>> +#endif /* _TRACE_RDMA_CORE_H */
>> +
>> +#include <trace/define_trace.h>

--
Chuck Lever



