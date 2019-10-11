Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3C26D46DC
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2019 19:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfJKRqV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Oct 2019 13:46:21 -0400
Received: from mail-eopbgr00048.outbound.protection.outlook.com ([40.107.0.48]:34266
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728470AbfJKRqU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 11 Oct 2019 13:46:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QN0j49x0I/4IuZXftkgI7kaHEQYh4rA9Ji1uVkNpdwpplWcGCm18GqQr9PtS4hbpD16PkYvK09EgZy1aRgSq7z42ws4hnP4I7f4Ejec1gvwLNpygHyf0bbZSsCf9W93XSNyMZKib1Trp6NSqjZbxcrUDnRKJ+Lmiw8FX+x0MgKDrVEGVBQD9fPJmuzgqdxCMnZzQBJ45u9CuAoSGj796fb8/V/JveYJRrckCxumAROac21+ixNNacksrIUQ15qCE+Q/N0GxK0viZn9PJlRDDE/Ceo4esUh/eLg/yPRw92LDwvhVh3Odp6js3+Ad7tlNbxVDoGbtT1Ybv4cy3ig73tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bYt2CGOyJ3Tam1TqxNaAt4SIc82Xn5MGg/h+akFo/0=;
 b=OyxN4OE+mbHRGnSqtbXYwmIH9FF9l8BiJ135qvBovcA+bGAr3M9rKfnon5vnO3b3pg5wAZ8qoLU15Zjesrh6mY6R4wg4aPSgCUzre5EoyhP0qp3Xh7mrd0TcaedoJPYFLR+YgGHCkcFyv/fXuTryhoRCLuZjbyz4mdqLB+rj5DURct43spqP+jP47Q5j2MUypjXpIicumeMC3Eh9+LbYwVWFIRDDHNatSLYV6Ot3NoCoegMLX1I1g+liZ3/HHLgKSy9MbityDsKo5XN9qYXdnPRglmCU4o9L3GULidSWh0p8sRGMK/eZ4gtSXO4scQwqEidG0M2umOxqa5zcEaOFwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bYt2CGOyJ3Tam1TqxNaAt4SIc82Xn5MGg/h+akFo/0=;
 b=Xtx4JRrKVmTUsftotbmqcKuZm3O405qLRP3nBv+g83EanjrdPTkJc0Dn2RjJi6bRa0MflOPgGc2cvkrmsHFHpZrQTcabzaXuHMc3BW05yxB/kqQ3NgB77jiTU9Jlur6QBRNLZJfWnYTCVFVs9l52042yjpEJind83hkTMiLgSas=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB6098.eurprd05.prod.outlook.com (20.178.119.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 11 Oct 2019 17:46:12 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432%7]) with mapi id 15.20.2347.021; Fri, 11 Oct 2019
 17:46:12 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v3] IB/core: Trace points for diagnosing completion queue
 issues
Thread-Topic: [PATCH v3] IB/core: Trace points for diagnosing completion queue
 issues
Thread-Index: AQHVfsJB2PsR9f5Z3kebveflJBbKRadVrD0ggAALpwCAAAGHcA==
Date:   Fri, 11 Oct 2019 17:46:12 +0000
Message-ID: <AM0PR05MB48668F96396D3317D1DC6A30D1970@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20191009165219.2202.56785.stgit@manet.1015granger.net>
 <AM0PR05MB48665D73CD796FC65A29C356D1970@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <54FEAA5A-AF8D-4604-9AEE-3B61DB26325B@oracle.com>
In-Reply-To: <54FEAA5A-AF8D-4604-9AEE-3B61DB26325B@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1500dc8-9ad0-4e8d-9870-08d74e72e7ff
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM0PR05MB6098:
x-microsoft-antispam-prvs: <AM0PR05MB6098CA7F75C7B46B92904AAAD1970@AM0PR05MB6098.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(346002)(39850400004)(13464003)(189003)(199004)(76116006)(64756008)(66066001)(76176011)(7736002)(53546011)(486006)(6506007)(6916009)(8936002)(81156014)(81166006)(74316002)(8676002)(102836004)(66946007)(305945005)(7696005)(26005)(6436002)(71200400001)(6116002)(3846002)(66556008)(71190400001)(14444005)(66476007)(186003)(2906002)(256004)(55016002)(476003)(11346002)(66446008)(9686003)(446003)(99286004)(229853002)(25786009)(14454004)(33656002)(316002)(6246003)(30864003)(4326008)(5660300002)(86362001)(52536014)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6098;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QsQZrHVGtg5Xm1yE574JXuv5al1DhFJKEOrgUdCzsTHIPqpz1g/7xafjyjvyymyuCkXac8rnHgHocgSvIfDeJlnZKLcL0ZZfTzuBJvOdJRMWKSz+Bn0gzc/qcEV/Dvo51JG6pOjdQ1C0m3vlsn+ThJsszOh7FBacvJtiEltSlmNEN6iujXv5xIDD+7ghlECZHbsy6O03YVVU7/hkyu/eBvp+G5x3VM88B3GwPN+K8vYvD2EuY0E2uSVRZu+CQn44ep6RS4WqfMlT+GPRc4kWu0be4RP2HPgOkOu9KkzUk+tGjr0t5/n1+Dah7k8VY3NlFvNz7PJ+YWjzJI6KElacwmKkNpNP3h5sKaXLo8BaaAGpZJMj5LJcIuT+5He3lvoo7nXYK+OIB/88U4yEkWEJjT5k2ifCDlN7MaiuEKjipnw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1500dc8-9ad0-4e8d-9870-08d74e72e7ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 17:46:12.0181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dv+a5g91lFXcmkUXN6gYsLWbwrFT9cG/7BKsbUYPwqqsvSwbh+trokL+b+FEnTWrfs23F+XhAHWfzTI+BIXDpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6098
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Chuck Lever <chuck.lever@oracle.com>
> Sent: Friday, October 11, 2019 12:39 PM
> To: Parav Pandit <parav@mellanox.com>
> Cc: linux-rdma@vger.kernel.org
> Subject: Re: [PATCH v3] IB/core: Trace points for diagnosing completion q=
ueue
> issues
>=20
>=20
>=20
> > On Oct 11, 2019, at 1:26 PM, Parav Pandit <parav@mellanox.com> wrote:
> >
> >
> >
> >> -----Original Message-----
> >> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> >> owner@vger.kernel.org> On Behalf Of Chuck Lever
> >> Sent: Wednesday, October 9, 2019 11:55 AM
> >> To: linux-rdma@vger.kernel.org
> >> Subject: [PATCH v3] IB/core: Trace points for diagnosing completion
> >> queue issues
> >>
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >> drivers/infiniband/core/Makefile |    2
> >> drivers/infiniband/core/cq.c     |   29 +++--
> >> drivers/infiniband/core/trace.c  |   14 ++
> >> include/rdma/ib_verbs.h          |    2
> >> include/trace/events/rdma_core.h |  218
> >> ++++++++++++++++++++++++++++++++++++++
> >> 5 files changed, 255 insertions(+), 10 deletions(-)  create mode
> >> 100644 drivers/infiniband/core/trace.c  create mode 100644
> >> include/trace/events/rdma_core.h
> >>
> >> Changes since v2:
> >> - Removed extraneous changes to include/trace/events/rdma.h
> >>
> >> Changes since RFC:
> >> - Addressed comments from Parav Pandit <parav@mellanox.com>
> >>
> >>
> >> diff --git a/drivers/infiniband/core/Makefile
> >> b/drivers/infiniband/core/Makefile
> >> index 09881bd..68d9e27 100644
> >> --- a/drivers/infiniband/core/Makefile
> >> +++ b/drivers/infiniband/core/Makefile
> >> @@ -11,7 +11,7 @@ ib_core-y :=3D			packer.o ud_header.o
> >> verbs.o cq.o rw.o sysfs.o \
> >> 				device.o fmr_pool.o cache.o netlink.o \
> >> 				roce_gid_mgmt.o mr_pool.o addr.o
> >> sa_query.o \
> >> 				multicast.o mad.o smi.o agent.o mad_rmpp.o \
> >> -				nldev.o restrack.o counters.o
> >> +				nldev.o restrack.o counters.o trace.o
> >>
> >> ib_core-$(CONFIG_SECURITY_INFINIBAND) +=3D security.o
> >> ib_core-$(CONFIG_CGROUP_RDMA) +=3D cgroup.o diff --git
> >> a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c index
> >> bbfded6..bcde992 100644
> >> --- a/drivers/infiniband/core/cq.c
> >> +++ b/drivers/infiniband/core/cq.c
> >> @@ -7,6 +7,8 @@
> >> #include <linux/slab.h>
> >> #include <rdma/ib_verbs.h>
> >>
> >> +#include <trace/events/rdma_core.h>
> >> +
> >> /* # of WCs to poll for with a single call to ib_poll_cq */
> >> #define IB_POLL_BATCH			16
> >> #define IB_POLL_BATCH_DIRECT		8
> >> @@ -41,6 +43,7 @@ static void ib_cq_rdma_dim_work(struct work_struct
> >> *w)
> >>
> >> 	dim->state =3D DIM_START_MEASURE;
> >>
> >> +	trace_cq_modify(cq, comps, usec);
> >> 	cq->device->ops.modify_cq(cq, comps, usec);  }
> >>
> >> @@ -70,13 +73,9 @@ static int __ib_process_cq(struct ib_cq *cq, int
> >> budget, struct ib_wc *wcs,  {
> >> 	int i, n, completed =3D 0;
> >>
> >> -	/*
> >> -	 * budget might be (-1) if the caller does not
> >> -	 * want to bound this call, thus we need unsigned
> >> -	 * minimum here.
> >> -	 */
> >> -	while ((n =3D ib_poll_cq(cq, min_t(u32, batch,
> >> -					 budget - completed), wcs)) > 0) {
> >> +	trace_cq_process(cq);
> >> +	while ((n =3D ib_poll_cq(cq, batch, wcs)) > 0) {
> > Before this change, on first attempt to poll the cq, it will poll for m=
in(batch,
> budget).
> > With this change, it will poll for batch.
> > This is functional change than just adding the trace points.
> > I am not sure if this has any effect on the overall polling.
> > But it may be worth to keep such functional change in pre-patch which c=
onsist
> of this change, moving comment section, batch recalculation.
>=20
> Or find a way to add the trace point without the functional change.
>=20
>=20
:-) yes.

> >> +		trace_cq_poll(cq, batch, n);
> >> 		for (i =3D 0; i < n; i++) {
> >> 			struct ib_wc *wc =3D &wcs[i];
> >>
> >> @@ -87,9 +86,15 @@ static int __ib_process_cq(struct ib_cq *cq, int
> >> budget, struct ib_wc *wcs,
> >> 		}
> >>
> >> 		completed +=3D n;
> >> -
> >> 		if (n !=3D batch || (budget !=3D -1 && completed >=3D budget))
> >> 			break;
> >> +
> >> +		/*
> >> +		 * budget might be (-1) if the caller does not
> >> +		 * want to bound this call, thus we need unsigned
> >> +		 * minimum here.
> >> +		 */
> >> +		batch =3D min_t(u32, batch, budget - completed);
> >> 	}
> >>
> >> 	return completed;
> >> @@ -131,8 +136,10 @@ static int ib_poll_handler(struct irq_poll *iop,
> >> int
> >> budget)
> >> 	completed =3D __ib_process_cq(cq, budget, cq->wc, IB_POLL_BATCH);
> >> 	if (completed < budget) {
> >> 		irq_poll_complete(&cq->iop);
> >> -		if (ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
> >> +		if (ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0) {
> >> +			trace_cq_reschedule(cq);
> >> 			irq_poll_sched(&cq->iop);
> >> +		}
> >> 	}
> >>
> >> 	if (dim)
> >> @@ -143,6 +150,7 @@ static int ib_poll_handler(struct irq_poll *iop,
> >> int
> >> budget)
> >>
> >> static void ib_cq_completion_softirq(struct ib_cq *cq, void *private)
> >> {
> >> +	trace_cq_schedule(cq);
> >> 	irq_poll_sched(&cq->iop);
> >> }
> >>
> >> @@ -162,6 +170,7 @@ static void ib_cq_poll_work(struct work_struct
> >> *work)
> >>
> >> static void ib_cq_completion_workqueue(struct ib_cq *cq, void
> >> *private)  {
> >> +	trace_cq_schedule(cq);
> >> 	queue_work(cq->comp_wq, &cq->work);
> >> }
> >>
> >> @@ -239,6 +248,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device
> >> *dev, void *private,
> >> 		goto out_destroy_cq;
> >> 	}
> >>
> >> +	trace_cq_alloc(cq, comp_vector, poll_ctx);
> >> 	return cq;
> >>
> >> out_destroy_cq:
> >> @@ -304,6 +314,7 @@ void ib_free_cq_user(struct ib_cq *cq, struct
> >> ib_udata
> >> *udata)
> >> 		WARN_ON_ONCE(1);
> >> 	}
> >>
> >> +	trace_cq_free(cq);
> >> 	rdma_restrack_del(&cq->res);
> >> 	cq->device->ops.destroy_cq(cq, udata);
> >> 	if (cq->dim)
> >> diff --git a/drivers/infiniband/core/trace.c
> >> b/drivers/infiniband/core/trace.c new file mode 100644 index
> >> 0000000..6c3514b
> >> --- /dev/null
> >> +++ b/drivers/infiniband/core/trace.c
> >> @@ -0,0 +1,14 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Trace points for core RDMA functions.
> >> + *
> >> + * Author: Chuck Lever <chuck.lever@oracle.com>
> >> + *
> >> + * Copyright (c) 2019, Oracle and/or its affiliates. All rights reser=
ved.
> >> + */
> >> +
> >> +#define CREATE_TRACE_POINTS
> >> +
> >> +#include <rdma/ib_verbs.h>
> >> +
> >> +#include <trace/events/rdma_core.h>
> >> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h index
> >> 6a47ba8..95a6bce 100644
> >> --- a/include/rdma/ib_verbs.h
> >> +++ b/include/rdma/ib_verbs.h
> >> @@ -1555,6 +1555,8 @@ struct ib_cq {
> >> 	};
> >> 	struct workqueue_struct *comp_wq;
> >> 	struct dim *dim;
> >> +	ktime_t timestamp;
> >> +	bool interrupt;
> > Its unclear when to update timestamp and interrupt. Comment will help.
>=20
> These are both updated only in the new trace points. Is more than that ne=
eded
> in a comment?
>=20
No. It wasn't clear to me that when to update the timestamp.
But I guess its obvious..

>=20
> >> 	/*
> >> 	 * Implementation details of the RDMA core, don't use in drivers:
> >> 	 */
> >> diff --git a/include/trace/events/rdma_core.h
> >> b/include/trace/events/rdma_core.h
> >> new file mode 100644
> >> index 0000000..c1397a3
> >> --- /dev/null
> >> +++ b/include/trace/events/rdma_core.h
> >> @@ -0,0 +1,218 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only */
> >> +/*
> >> + * Trace point definitions for core RDMA functions.
> >> + *
> >> + * Author: Chuck Lever <chuck.lever@oracle.com>
> >> + *
> >> + * Copyright (c) 2019, Oracle and/or its affiliates. All rights reser=
ved.
> >> + */
> >> +
> >> +#undef TRACE_SYSTEM
> >> +#define TRACE_SYSTEM rdma_core
> >> +
> >> +#if !defined(_TRACE_RDMA_CORE_H) ||
> >> defined(TRACE_HEADER_MULTI_READ)
> >> +#define _TRACE_RDMA_CORE_H
> >> +
> >> +#include <linux/tracepoint.h>
> >> +#include <rdma/ib_verbs.h>
> >> +#include <rdma/restrack.h>
> >> +
> >> +/*
> >> + * enum ib_poll_context, from include/rdma/ib_verbs.h  */
> >> +#define IB_POLL_CTX_LIST			\
> >> +	ib_poll_ctx(DIRECT)			\
> >> +	ib_poll_ctx(SOFTIRQ)			\
> >> +	ib_poll_ctx(WORKQUEUE)			\
> >> +	ib_poll_ctx_end(UNBOUND_WORKQUEUE)
> >> +
> >> +#undef ib_poll_ctx
> >> +#undef ib_poll_ctx_end
> >> +
> >> +#define ib_poll_ctx(x)		TRACE_DEFINE_ENUM(IB_POLL_##x);
> >> +#define ib_poll_ctx_end(x)	TRACE_DEFINE_ENUM(IB_POLL_##x);
> >> +
> >> +IB_POLL_CTX_LIST
> >> +
> >> +#undef ib_poll_ctx
> >> +#undef ib_poll_ctx_end
> >> +
> >> +#define ib_poll_ctx(x)		{ IB_POLL_##x, #x },
> >> +#define ib_poll_ctx_end(x)	{ IB_POLL_##x, #x }
> >> +
> >> +#define rdma_show_ib_poll_ctx(x) \
> >> +		__print_symbolic(x, IB_POLL_CTX_LIST)
> >> +
> >> +/**
> >> + ** Completion Queue events
> >> + **/
> >> +
> >> +TRACE_EVENT(cq_schedule,
> >> +	TP_PROTO(
> >> +		struct ib_cq *cq
> >> +	),
> >> +
> >> +	TP_ARGS(cq),
> >> +
> >> +	TP_STRUCT__entry(
> >> +		__field(u32, id)
> >> +	),
> >> +
> >> +	TP_fast_assign(
> >> +		cq->timestamp =3D ktime_get();
> >> +		cq->interrupt =3D true;
> >> +
> >> +		__entry->id =3D cq->res.id;
> >> +	),
> >> +
> >> +	TP_printk("id %u", __entry->id)
> >> +);
> >> +
> >> +TRACE_EVENT(cq_reschedule,
> >> +	TP_PROTO(
> >> +		struct ib_cq *cq
> >> +	),
> >> +
> >> +	TP_ARGS(cq),
> >> +
> >> +	TP_STRUCT__entry(
> >> +		__field(u32, id)
> >> +	),
> >> +
> >> +	TP_fast_assign(
> >> +		cq->timestamp =3D ktime_get();
> >> +		cq->interrupt =3D false;
> >> +
> >> +		__entry->id =3D cq->res.id;
> >> +	),
> >> +
> >> +	TP_printk("id %u", __entry->id)
> >> +);
> >> +
> >> +TRACE_EVENT(cq_process,
> >> +	TP_PROTO(
> >> +		const struct ib_cq *cq
> >> +	),
> >> +
> >> +	TP_ARGS(cq),
> >> +
> >> +	TP_STRUCT__entry(
> >> +		__field(s64, latency)
> >> +		__field(u32, id)
> >> +		__field(bool, interrupt)
> >> +	),
> >> +
> >> +	TP_fast_assign(
> >> +		ktime_t latency =3D ktime_sub(ktime_get(), cq->timestamp);
> >> +
> >> +		__entry->id =3D cq->res.id;
> >> +		__entry->latency =3D ktime_to_us(latency);
> >> +		__entry->interrupt =3D cq->interrupt;
> >> +	),
> >> +
> >> +	TP_printk("id %u wake-up took %lld [us] from %s",
> > It might be better to prefix 'id' with 'cq', so that in future rdma wid=
e trace
> points, we can have multiple resource id's printed consistently as qpid, =
cqid,
> mrid etc; and don't have to rely on the function where it is used to deco=
de what
> that id means.
>=20
> I left out the "cq" here because the trace point names are prefixed with =
"cq_".
> However, now that you bring it up, I can imagine cases where a trace poin=
t
> might report information about two different resources that both have a
> restrack ID.
>=20
> How about "cq.id=3D%u" ?
>=20
Looks good.

>=20
> > I had mixed thoughts on whether to pass ib_cq* or rdma_restrack_entry*.
> > I was thinking of rdma_restrack_entry*, as it makes future code for oth=
er
> resources also anchored on the resource id.
>=20
> On the other hand, a trace point might someday want to report the value o=
f a
> field in struct ib_cq.
>=20
Yes. that is exactly why I had mix thoughts. So I think ib_cq is ok.

>=20
> >> +		__entry->id, __entry->latency,
> >> +		__entry->interrupt ? "interrupt" : "reschedule"
> >> +	)
> >> +);
> >> +
> >> +TRACE_EVENT(cq_poll,
> >> +	TP_PROTO(
> >> +		const struct ib_cq *cq,
> >> +		int requested,
> >> +		int rc
> >> +	),
> >> +
> >> +	TP_ARGS(cq, requested, rc),
> >> +
> >> +	TP_STRUCT__entry(
> >> +		__field(u32, id)
> >> +		__field(int, requested)
> >> +		__field(int, rc)
> >> +	),
> >> +
> >> +	TP_fast_assign(
> >> +		__entry->id =3D cq->res.id;
> >> +		__entry->requested =3D requested;
> >> +		__entry->rc =3D rc;
> >> +	),
> >> +
> >> +	TP_printk("id %u requested %d, returned %d",
> >> +		__entry->id, __entry->requested, __entry->rc
> >> +	)
> >> +);
> >> +
> >> +TRACE_EVENT(cq_modify,
> >> +	TP_PROTO(
> >> +		const struct ib_cq *cq,
> >> +		u16 comps,
> >> +		u16 usec
> >> +	),
> >> +
> >> +	TP_ARGS(cq, comps, usec),
> >> +
> >> +	TP_STRUCT__entry(
> >> +		__field(u32, id)
> >> +		__field(unsigned int, comps)
> >> +		__field(unsigned int, usec)
> >> +	),
> >> +
> >> +	TP_fast_assign(
> >> +		__entry->id =3D cq->res.id;
> >> +		__entry->comps =3D comps;
> >> +		__entry->usec =3D usec;
> >> +	),
> >> +
> >> +	TP_printk("id %u comps=3D%u usec=3D%u",
> >> +		__entry->id, __entry->comps, __entry->usec
> >> +	)
> >> +);
> >> +
> >> +TRACE_EVENT(cq_alloc,
> >> +	TP_PROTO(
> >> +		const struct ib_cq *cq,
> >> +		int comp_vector,
> >> +		enum ib_poll_context poll_ctx
> >> +	),
> >> +
> >> +	TP_ARGS(cq, comp_vector, poll_ctx),
> >> +
> >> +	TP_STRUCT__entry(
> >> +		__field(u32, id)
> >> +		__field(int, comp_vector)
> >> +		__field(unsigned long, poll_ctx)
> >> +	),
> >> +
> >> +	TP_fast_assign(
> >> +		__entry->id =3D cq->res.id;
> >> +		__entry->comp_vector =3D comp_vector;
> >> +		__entry->poll_ctx =3D poll_ctx;
> >> +	),
> >> +
> >> +	TP_printk("id %u comp_vector=3D%d poll_ctx=3D%s",
> >> +		__entry->id, __entry->comp_vector,
> >> +		rdma_show_ib_poll_ctx(__entry->poll_ctx)
> >> +	)
> >> +);
> >> +
> >> +TRACE_EVENT(cq_free,
> >> +	TP_PROTO(
> >> +		const struct ib_cq *cq
> >> +	),
> >> +
> >> +	TP_ARGS(cq),
> >> +
> >> +	TP_STRUCT__entry(
> >> +		__field(u32, id)
> >> +	),
> >> +
> >> +	TP_fast_assign(
> >> +		__entry->id =3D cq->res.id;
> >> +	),
> >> +
> >> +	TP_printk("id %u", __entry->id)
> >> +);
> >> +
> >> +#endif /* _TRACE_RDMA_CORE_H */
> >> +
> >> +#include <trace/define_trace.h>
>=20
> --
> Chuck Lever
>=20
>=20

