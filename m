Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 515FBD00A9
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2019 20:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfJHSXu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Oct 2019 14:23:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45188 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfJHSXu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Oct 2019 14:23:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98IJVnk094834
        for <linux-rdma@vger.kernel.org>; Tue, 8 Oct 2019 18:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : date : references :
 to : in-reply-to : message-id; s=corp-2019-08-05;
 bh=mcu288oQ4IVYE2YWrEvfznyzUnN3ut1R+m0fECErofw=;
 b=T6ro02S+LliBv8PC2/dZQRLRiuXaalMcCI48x3gTqCyqkBlFSHDAlr62/S651CUVzENQ
 br4V6wJGPUUy2xAP36LCOk6Qkb79nDR467XsXXPG97EoZXdNB7CJb5f3svRFSIZR8rA4
 rH86GfEC2C3px9btIpqCNJaZOsWRtkvINlk85WSdHqEZQfswQBK78V0YuKcwrHQt1Le1
 YREu48WFVZCojpIEI7qlHPDoAZ5XK6wqLgPPwsiQdITbkmzrVXLmT3PnHDEylkDqwrQz
 F5tnWMoNwrR6uCpZBvKg8helOA91hczCN1OalHTGNO9H84nxHMYBLibzXyZSNAbVV1W2 Tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vejkuf4p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2019 18:23:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98IIWVD092236
        for <linux-rdma@vger.kernel.org>; Tue, 8 Oct 2019 18:21:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vgeuyewx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2019 18:21:46 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x98ILk0I027554
        for <linux-rdma@vger.kernel.org>; Tue, 8 Oct 2019 18:21:46 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Oct 2019 11:21:46 -0700
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] IB/core: Trace points for diagnosing completion queue
 issues
Date:   Tue, 8 Oct 2019 14:21:45 -0400
References: <20191008165832.4721.31859.stgit@manet.1015granger.net>
To:     linux-rdma <linux-rdma@vger.kernel.org>
In-Reply-To: <20191008165832.4721.31859.stgit@manet.1015granger.net>
Message-Id: <FA386CF6-3B0F-43F5-8C06-F5869FBBB9B2@oracle.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080144
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Oct 8, 2019, at 12:58 PM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> drivers/infiniband/core/Makefile |    2=20
> drivers/infiniband/core/cq.c     |   29 ++++--
> drivers/infiniband/core/trace.c  |   14 +++
> include/rdma/ib_verbs.h          |    2=20
> include/trace/events/rdma.h      |   91 ++++++++++++++++++
> include/trace/events/rdma_core.h |  193 =
++++++++++++++++++++++++++++++++++++++
> 6 files changed, 321 insertions(+), 10 deletions(-)
> create mode 100644 drivers/infiniband/core/trace.c
> create mode 100644 include/trace/events/rdma_core.h
>=20
> diff --git a/drivers/infiniband/core/Makefile =
b/drivers/infiniband/core/Makefile
> index 09881bd..68d9e27 100644
> --- a/drivers/infiniband/core/Makefile
> +++ b/drivers/infiniband/core/Makefile
> @@ -11,7 +11,7 @@ ib_core-y :=3D			packer.o =
ud_header.o verbs.o cq.o rw.o sysfs.o \
> 				device.o fmr_pool.o cache.o netlink.o \
> 				roce_gid_mgmt.o mr_pool.o addr.o =
sa_query.o \
> 				multicast.o mad.o smi.o agent.o =
mad_rmpp.o \
> -				nldev.o restrack.o counters.o
> +				nldev.o restrack.o counters.o trace.o
>=20
> ib_core-$(CONFIG_SECURITY_INFINIBAND) +=3D security.o
> ib_core-$(CONFIG_CGROUP_RDMA) +=3D cgroup.o
> diff --git a/drivers/infiniband/core/cq.c =
b/drivers/infiniband/core/cq.c
> index bbfded6..bcde992 100644
> --- a/drivers/infiniband/core/cq.c
> +++ b/drivers/infiniband/core/cq.c
> @@ -7,6 +7,8 @@
> #include <linux/slab.h>
> #include <rdma/ib_verbs.h>
>=20
> +#include <trace/events/rdma_core.h>
> +
> /* # of WCs to poll for with a single call to ib_poll_cq */
> #define IB_POLL_BATCH			16
> #define IB_POLL_BATCH_DIRECT		8
> @@ -41,6 +43,7 @@ static void ib_cq_rdma_dim_work(struct work_struct =
*w)
>=20
> 	dim->state =3D DIM_START_MEASURE;
>=20
> +	trace_cq_modify(cq, comps, usec);
> 	cq->device->ops.modify_cq(cq, comps, usec);
> }
>=20
> @@ -70,13 +73,9 @@ static int __ib_process_cq(struct ib_cq *cq, int =
budget, struct ib_wc *wcs,
> {
> 	int i, n, completed =3D 0;
>=20
> -	/*
> -	 * budget might be (-1) if the caller does not
> -	 * want to bound this call, thus we need unsigned
> -	 * minimum here.
> -	 */
> -	while ((n =3D ib_poll_cq(cq, min_t(u32, batch,
> -					 budget - completed), wcs)) > 0) =
{
> +	trace_cq_process(cq);
> +	while ((n =3D ib_poll_cq(cq, batch, wcs)) > 0) {
> +		trace_cq_poll(cq, batch, n);
> 		for (i =3D 0; i < n; i++) {
> 			struct ib_wc *wc =3D &wcs[i];
>=20
> @@ -87,9 +86,15 @@ static int __ib_process_cq(struct ib_cq *cq, int =
budget, struct ib_wc *wcs,
> 		}
>=20
> 		completed +=3D n;
> -
> 		if (n !=3D batch || (budget !=3D -1 && completed >=3D =
budget))
> 			break;
> +
> +		/*
> +		 * budget might be (-1) if the caller does not
> +		 * want to bound this call, thus we need unsigned
> +		 * minimum here.
> +		 */
> +		batch =3D min_t(u32, batch, budget - completed);
> 	}
>=20
> 	return completed;
> @@ -131,8 +136,10 @@ static int ib_poll_handler(struct irq_poll *iop, =
int budget)
> 	completed =3D __ib_process_cq(cq, budget, cq->wc, =
IB_POLL_BATCH);
> 	if (completed < budget) {
> 		irq_poll_complete(&cq->iop);
> -		if (ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
> +		if (ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0) {
> +			trace_cq_reschedule(cq);
> 			irq_poll_sched(&cq->iop);
> +		}
> 	}
>=20
> 	if (dim)
> @@ -143,6 +150,7 @@ static int ib_poll_handler(struct irq_poll *iop, =
int budget)
>=20
> static void ib_cq_completion_softirq(struct ib_cq *cq, void *private)
> {
> +	trace_cq_schedule(cq);
> 	irq_poll_sched(&cq->iop);
> }
>=20
> @@ -162,6 +170,7 @@ static void ib_cq_poll_work(struct work_struct =
*work)
>=20
> static void ib_cq_completion_workqueue(struct ib_cq *cq, void =
*private)
> {
> +	trace_cq_schedule(cq);
> 	queue_work(cq->comp_wq, &cq->work);
> }
>=20
> @@ -239,6 +248,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device =
*dev, void *private,
> 		goto out_destroy_cq;
> 	}
>=20
> +	trace_cq_alloc(cq, comp_vector, poll_ctx);
> 	return cq;
>=20
> out_destroy_cq:
> @@ -304,6 +314,7 @@ void ib_free_cq_user(struct ib_cq *cq, struct =
ib_udata *udata)
> 		WARN_ON_ONCE(1);
> 	}
>=20
> +	trace_cq_free(cq);
> 	rdma_restrack_del(&cq->res);
> 	cq->device->ops.destroy_cq(cq, udata);
> 	if (cq->dim)
> diff --git a/drivers/infiniband/core/trace.c =
b/drivers/infiniband/core/trace.c
> new file mode 100644
> index 0000000..6c3514b
> --- /dev/null
> +++ b/drivers/infiniband/core/trace.c
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Trace points for core RDMA functions.
> + *
> + * Author: Chuck Lever <chuck.lever@oracle.com>
> + *
> + * Copyright (c) 2019, Oracle and/or its affiliates. All rights =
reserved.
> + */
> +
> +#define CREATE_TRACE_POINTS
> +
> +#include <rdma/ib_verbs.h>
> +
> +#include <trace/events/rdma_core.h>
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 6a47ba8..95a6bce 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -1555,6 +1555,8 @@ struct ib_cq {
> 	};
> 	struct workqueue_struct *comp_wq;
> 	struct dim *dim;
> +	ktime_t timestamp;
> +	bool interrupt;
> 	/*
> 	 * Implementation details of the RDMA core, don't use in =
drivers:
> 	 */
> diff --git a/include/trace/events/rdma.h b/include/trace/events/rdma.h
> index aa19afc..9a666f1 100644
> --- a/include/trace/events/rdma.h
> +++ b/include/trace/events/rdma.h

Actually I can get rid of all the changes to this header.
Stand-by for v3.


> @@ -7,6 +7,8 @@
>  * enum ib_event_type, from include/rdma/ib_verbs.h
>  */
>=20
> +#include <rdma/rdma_cm.h>
> +
> #define IB_EVENT_LIST				\
> 	ib_event(CQ_ERR)			\
> 	ib_event(QP_FATAL)			\
> @@ -127,3 +129,92 @@
>=20
> #define rdma_show_cm_event(x) \
> 		__print_symbolic(x, RDMA_CM_EVENT_LIST)
> +
> +/*
> + * enum ib_poll_context, from include/rdma/ib_verbs.h
> + */
> +#define IB_POLL_CTX_LIST			\
> +	ib_poll_ctx(DIRECT)			\
> +	ib_poll_ctx(SOFTIRQ)			\
> +	ib_poll_ctx(WORKQUEUE)			\
> +	ib_poll_ctx_end(UNBOUND_WORKQUEUE)
> +
> +#undef ib_poll_ctx
> +#undef ib_poll_ctx_end
> +
> +#define ib_poll_ctx(x)		TRACE_DEFINE_ENUM(IB_POLL_##x);
> +#define ib_poll_ctx_end(x)	TRACE_DEFINE_ENUM(IB_POLL_##x);
> +
> +IB_POLL_CTX_LIST
> +
> +#undef ib_poll_ctx
> +#undef ib_poll_ctx_end
> +
> +#define ib_poll_ctx(x)		{ IB_POLL_##x, #x },
> +#define ib_poll_ctx_end(x)	{ IB_POLL_##x, #x }
> +
> +#define rdma_show_ib_poll_ctx(x) \
> +		__print_symbolic(x, IB_POLL_CTX_LIST)
> +
> +/*
> + * enum ib_wc_opcode, from include/rdma/ib_verbs.h
> + */
> +#define IB_WC_OPCODE_LIST			\
> +	ib_wc_opcode(SEND)			\
> +	ib_wc_opcode(RDMA_WRITE)		\
> +	ib_wc_opcode(RDMA_READ)			\
> +	ib_wc_opcode(COMP_SWAP)			\
> +	ib_wc_opcode(FETCH_ADD)			\
> +	ib_wc_opcode(LSO)			\
> +	ib_wc_opcode(LOCAL_INV)			\
> +	ib_wc_opcode(REG_MR)			\
> +	ib_wc_opcode(MASKED_COMP_SWAP)		\
> +	ib_wc_opcode(MASKED_FETCH_ADD)		\
> +	ib_wc_opcode(RECV)			\
> +	ib_wc_opcode_end(RECV_RDMA_WITH_IMM)
> +
> +#undef ib_wc_opcode
> +#undef ib_wc_opcode_end
> +
> +#define ib_wc_opcode(x)		TRACE_DEFINE_ENUM(IB_WC_##x);
> +#define ib_wc_opcode_end(x)	TRACE_DEFINE_ENUM(IB_WC_##x);
> +
> +IB_WC_OPCODE_LIST
> +
> +#undef ib_wc_opcode
> +#undef ib_wc_opcode_end
> +
> +#define ib_wc_opcode(x)		{ IB_WC_##x, #x },
> +#define ib_wc_opcode_end(x)	{ IB_WC_##x, #x }
> +
> +#define rdma_show_wc_opcode(x) \
> +		__print_symbolic(x, IB_WC_OPCODE_LIST)
> +
> +/*
> + * enum ib_wc_flags, from include/rdma/ib_verbs.h
> + */
> +#define IB_WC_FLAGS_LIST			\
> +	ib_wc_flags(GRH)			\
> +	ib_wc_flags(WITH_IMM)			\
> +	ib_wc_flags(WITH_INVALIDATE)		\
> +	ib_wc_flags(IP_CSUM_OK)			\
> +	ib_wc_flags(WITH_SMAC)			\
> +	ib_wc_flags(WITH_VLAN)			\
> +	ib_wc_flags_end(WITH_NETWORK_HDR_TYPE)
> +
> +#undef ib_wc_flags
> +#undef ib_wc_flags_end
> +
> +#define ib_wc_flags(x)		TRACE_DEFINE_ENUM(IB_WC_##x);
> +#define ib_wc_flags_end(x)	TRACE_DEFINE_ENUM(IB_WC_##x);
> +
> +IB_WC_FLAGS_LIST
> +
> +#undef ib_wc_flags
> +#undef ib_wc_flags_end
> +
> +#define ib_wc_flags(x)		{ IB_WC_##x, #x },
> +#define ib_wc_flags_end(x)	{ IB_WC_##x, #x }
> +
> +#define rdma_show_wc_flags(x) \
> +		__print_symbolic(x, IB_WC_FLAGS_LIST)
> diff --git a/include/trace/events/rdma_core.h =
b/include/trace/events/rdma_core.h
> new file mode 100644
> index 0000000..af18ac7
> --- /dev/null
> +++ b/include/trace/events/rdma_core.h
> @@ -0,0 +1,193 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Trace point definitions for core RDMA functions.
> + *
> + * Author: Chuck Lever <chuck.lever@oracle.com>
> + *
> + * Copyright (c) 2019, Oracle and/or its affiliates. All rights =
reserved.
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM rdma_core
> +
> +#if !defined(_TRACE_RDMA_CORE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_RDMA_CORE_H
> +
> +#include <linux/tracepoint.h>
> +#include <trace/events/rdma.h>
> +#include <rdma/ib_verbs.h>
> +#include <rdma/restrack.h>
> +
> +/**
> + ** Completion Queue events
> + **/
> +
> +TRACE_EVENT(cq_schedule,
> +	TP_PROTO(
> +		struct ib_cq *cq
> +	),
> +
> +	TP_ARGS(cq),
> +
> +	TP_STRUCT__entry(
> +		__field(u32, id)
> +	),
> +
> +	TP_fast_assign(
> +		cq->timestamp =3D ktime_get();
> +		cq->interrupt =3D true;
> +
> +		__entry->id =3D cq->res.id;
> +	),
> +
> +	TP_printk("id %u", __entry->id)
> +);
> +
> +TRACE_EVENT(cq_reschedule,
> +	TP_PROTO(
> +		struct ib_cq *cq
> +	),
> +
> +	TP_ARGS(cq),
> +
> +	TP_STRUCT__entry(
> +		__field(u32, id)
> +	),
> +
> +	TP_fast_assign(
> +		cq->timestamp =3D ktime_get();
> +		cq->interrupt =3D false;
> +
> +		__entry->id =3D cq->res.id;
> +	),
> +
> +	TP_printk("id %u", __entry->id)
> +);
> +
> +TRACE_EVENT(cq_process,
> +	TP_PROTO(
> +		const struct ib_cq *cq
> +	),
> +
> +	TP_ARGS(cq),
> +
> +	TP_STRUCT__entry(
> +		__field(s64, latency)
> +		__field(u32, id)
> +		__field(bool, interrupt)
> +	),
> +
> +	TP_fast_assign(
> +		ktime_t latency =3D ktime_sub(ktime_get(), =
cq->timestamp);
> +
> +		__entry->id =3D cq->res.id;
> +		__entry->latency =3D ktime_to_us(latency);
> +		__entry->interrupt =3D cq->interrupt;
> +	),
> +
> +	TP_printk("id %u wake-up took %lld [us] from %s",
> +		__entry->id, __entry->latency,
> +		__entry->interrupt ? "interrupt" : "reschedule"
> +	)
> +);
> +
> +TRACE_EVENT(cq_poll,
> +	TP_PROTO(
> +		const struct ib_cq *cq,
> +		int requested,
> +		int rc
> +	),
> +
> +	TP_ARGS(cq, requested, rc),
> +
> +	TP_STRUCT__entry(
> +		__field(u32, id)
> +		__field(int, requested)
> +		__field(int, rc)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->id =3D cq->res.id;
> +		__entry->requested =3D requested;
> +		__entry->rc =3D rc;
> +	),
> +
> +	TP_printk("id %u requested %d, returned %d",
> +		__entry->id, __entry->requested, __entry->rc
> +	)
> +);
> +
> +TRACE_EVENT(cq_modify,
> +	TP_PROTO(
> +		const struct ib_cq *cq,
> +		u16 comps,
> +		u16 usec
> +	),
> +
> +	TP_ARGS(cq, comps, usec),
> +
> +	TP_STRUCT__entry(
> +		__field(u32, id)
> +		__field(unsigned int, comps)
> +		__field(unsigned int, usec)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->id =3D cq->res.id;
> +		__entry->comps =3D comps;
> +		__entry->usec =3D usec;
> +	),
> +
> +	TP_printk("id %u comps=3D%u usec=3D%u",
> +		__entry->id, __entry->comps, __entry->usec
> +	)
> +);
> +
> +TRACE_EVENT(cq_alloc,
> +	TP_PROTO(
> +		const struct ib_cq *cq,
> +		int comp_vector,
> +		enum ib_poll_context poll_ctx
> +	),
> +
> +	TP_ARGS(cq, comp_vector, poll_ctx),
> +
> +	TP_STRUCT__entry(
> +		__field(u32, id)
> +		__field(int, comp_vector)
> +		__field(unsigned long, poll_ctx)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->id =3D cq->res.id;
> +		__entry->comp_vector =3D comp_vector;
> +		__entry->poll_ctx =3D poll_ctx;
> +	),
> +
> +	TP_printk("id %u comp_vector=3D%d poll_ctx=3D%s",
> +		__entry->id, __entry->comp_vector,
> +		rdma_show_ib_poll_ctx(__entry->poll_ctx)
> +	)
> +);
> +
> +TRACE_EVENT(cq_free,
> +	TP_PROTO(
> +		const struct ib_cq *cq
> +	),
> +
> +	TP_ARGS(cq),
> +
> +	TP_STRUCT__entry(
> +		__field(u32, id)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->id =3D cq->res.id;
> +	),
> +
> +	TP_printk("id %u", __entry->id)
> +);
> +
> +#endif /* _TRACE_RDMA_CORE_H */
> +
> +#include <trace/define_trace.h>
>=20

--
Chuck Lever



