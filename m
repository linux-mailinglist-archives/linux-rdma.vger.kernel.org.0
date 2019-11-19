Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5976101FF9
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 10:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfKSJSd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 19 Nov 2019 04:18:33 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2088 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725784AbfKSJSd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Nov 2019 04:18:33 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 9CE51FC5626347C4C1ED;
        Tue, 19 Nov 2019 17:18:28 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.127]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0439.000;
 Tue, 19 Nov 2019 17:18:27 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v6 2/2] RDMA/cma: Add trace points in RDMA Connection
 Manager
Thread-Topic: [PATCH v6 2/2] RDMA/cma: Add trace points in RDMA Connection
 Manager
Thread-Index: AQHVnloJdrUlMhRtgEuilW9Cp7qD16eRl8AAgACekUA=
Date:   Tue, 19 Nov 2019 09:18:26 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED300C5619@dggemm526-mbx.china.huawei.com>
References: <20191118214447.27891.58814.stgit@manet.1015granger.net>
 <20191118214915.27891.61202.stgit@manet.1015granger.net>
 <20191119074516.GG52766@unreal>
In-Reply-To: <20191119074516.GG52766@unreal>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.74.221.187]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> -----Original Message-----
> From: linux-rdma-owner@vger.kernel.org
> [mailto:linux-rdma-owner@vger.kernel.org] On Behalf Of Leon Romanovsky
> Sent: Tuesday, November 19, 2019 3:45 PM
> To: Chuck Lever
> Cc: linux-rdma@vger.kernel.org
> Subject: Re: [PATCH v6 2/2] RDMA/cma: Add trace points in RDMA Connection
> Manager
> 
> On Mon, Nov 18, 2019 at 04:49:15PM -0500, Chuck Lever wrote:
> > Record state transitions as each connection is established. The IP
> > address of both peers and the Type of Service is reported. These
> > new trace points are not in performance hot paths.
> >
> > Also, record each cm_event_handler call to ULPs. This eliminates the
> > need for each ULP to add its own similar trace point in its CM event
> > handler function.
> >
> > These new trace points appear in a new trace subsystem called
> > "rdma_cma".
> >
> > This patch is based on previous work by:
> >
> > Saeed Mahameed <saeedm@mellanox.com>
> > Mukesh Kacker <mukesh.kacker@oracle.com>
> > Ajaykumar Hotchandani <ajaykumar.hotchandani@oracle.com>
> > Aron Silverton <aron.silverton@oracle.com>
> > Avinash Repaka <avinash.repaka@oracle.com>
> > Somasundaram Krishnasamy <somasundaram.krishnasamy@oracle.com>
> >
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  drivers/infiniband/core/Makefile    |    2
> >  drivers/infiniband/core/cma.c       |   60 +++++++---
> >  drivers/infiniband/core/cma_trace.c |   16 +++
> >  include/trace/events/rdma_cma.h     |  218
> +++++++++++++++++++++++++++++++++++
> >  4 files changed, 279 insertions(+), 17 deletions(-)
> >  create mode 100644 drivers/infiniband/core/cma_trace.c
> >  create mode 100644 include/trace/events/rdma_cma.h
> >
> > diff --git a/drivers/infiniband/core/Makefile
> b/drivers/infiniband/core/Makefile
> > index 68d9e27c3c61..bab7b6f01982 100644
> > --- a/drivers/infiniband/core/Makefile
> > +++ b/drivers/infiniband/core/Makefile
> > @@ -20,7 +20,7 @@ ib_cm-y :=			cm.o
> >
> >  iw_cm-y :=			iwcm.o iwpm_util.o iwpm_msg.o
> >
> > -rdma_cm-y :=			cma.o
> > +rdma_cm-y :=			cma.o cma_trace.o
> >
> >  rdma_cm-$(CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS) +=
> cma_configfs.o
> >
> > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > index d78f67623f24..5d5e63336954 100644
> > --- a/drivers/infiniband/core/cma.c
> > +++ b/drivers/infiniband/core/cma.c
> > @@ -64,6 +64,8 @@
> >  #include "core_priv.h"
> >  #include "cma_priv.h"
> >
> > +#include <trace/events/rdma_cma.h>
> > +
> >  MODULE_AUTHOR("Sean Hefty");
> >  MODULE_DESCRIPTION("Generic RDMA CM Agent");
> >  MODULE_LICENSE("Dual BSD/GPL");
> > @@ -1890,6 +1892,7 @@ static int cma_rep_recv(struct rdma_id_private
> *id_priv)
> >  	if (ret)
> >  		goto reject;
> >
> > +	trace_cm_send_rtu(id_priv);
> >  	ret = ib_send_cm_rtu(id_priv->cm_id.ib, NULL, 0);
> >  	if (ret)
> >  		goto reject;
> > @@ -1898,6 +1901,7 @@ static int cma_rep_recv(struct rdma_id_private
> *id_priv)
> >  reject:
> >  	pr_debug_ratelimited("RDMA CM: CONNECT_ERROR: failed to handle
> reply. status %d\n", ret);
> >  	cma_modify_qp_err(id_priv);
> > +	trace_cm_send_rej(id_priv);
> >  	ib_send_cm_rej(id_priv->cm_id.ib, IB_CM_REJ_CONSUMER_DEFINED,
> >  		       NULL, 0, NULL, 0);
> >  	return ret;
> > @@ -1917,6 +1921,13 @@ static void cma_set_rep_event_data(struct
> rdma_cm_event *event,
> >  	event->param.conn.qp_num = rep_data->remote_qpn;
> >  }
> >
> > +static int cma_cm_event_handler(struct rdma_id_private *id_priv,
> > +				struct rdma_cm_event *event)
> > +{
> > +	trace_cm_event_handler(id_priv, event);
> > +	return id_priv->id.event_handler(&id_priv->id, event);
> > +}
> > +
> >  static int cma_ib_handler(struct ib_cm_id *cm_id,
> >  			  const struct ib_cm_event *ib_event)
> >  {
> > @@ -1939,8 +1950,10 @@ static int cma_ib_handler(struct ib_cm_id
> *cm_id,
> >  		break;
> >  	case IB_CM_REP_RECEIVED:
> >  		if (cma_comp(id_priv, RDMA_CM_CONNECT) &&
> > -		    (id_priv->id.qp_type != IB_QPT_UD))
> > +		    (id_priv->id.qp_type != IB_QPT_UD)) {
> > +			trace_cm_send_mra(id_priv);
> >  			ib_send_cm_mra(cm_id, CMA_CM_MRA_SETTING, NULL, 0);
> > +		}
> >  		if (id_priv->id.qp) {
> >  			event.status = cma_rep_recv(id_priv);
> >  			event.event = event.status ?
> RDMA_CM_EVENT_CONNECT_ERROR :
> > @@ -1985,7 +1998,7 @@ static int cma_ib_handler(struct ib_cm_id *cm_id,
> >  		goto out;
> >  	}
> >
> > -	ret = id_priv->id.event_handler(&id_priv->id, &event);
> > +	ret = cma_cm_event_handler(id_priv, &event);
> >  	if (ret) {
> >  		/* Destroy the CM ID by returning a non-zero value. */
> >  		id_priv->cm_id.ib = NULL;
> > @@ -2146,6 +2159,7 @@ static int cma_ib_req_handler(struct ib_cm_id
> *cm_id,
> >  	if (IS_ERR(listen_id))
> >  		return PTR_ERR(listen_id);
> >
> > +	trace_cm_req_handler(listen_id, ib_event->event);
> >  	if (!cma_ib_check_req_qp_type(&listen_id->id, ib_event)) {
> >  		ret = -EINVAL;
> >  		goto net_dev_put;
> > @@ -2188,7 +2202,7 @@ static int cma_ib_req_handler(struct ib_cm_id
> *cm_id,
> >  	 * until we're done accessing it.
> >  	 */
> >  	atomic_inc(&conn_id->refcount);
> > -	ret = conn_id->id.event_handler(&conn_id->id, &event);
> > +	ret = cma_cm_event_handler(conn_id, &event);
> >  	if (ret)
> >  		goto err3;
> >  	/*
> > @@ -2197,8 +2211,10 @@ static int cma_ib_req_handler(struct ib_cm_id
> *cm_id,
> >  	 */
> >  	mutex_lock(&lock);
> >  	if (cma_comp(conn_id, RDMA_CM_CONNECT) &&
> > -	    (conn_id->id.qp_type != IB_QPT_UD))
> > +	    (conn_id->id.qp_type != IB_QPT_UD)) {
> > +		trace_cm_send_mra(cm_id->context);
> >  		ib_send_cm_mra(cm_id, CMA_CM_MRA_SETTING, NULL, 0);
> > +	}
> >  	mutex_unlock(&lock);
> >  	mutex_unlock(&conn_id->handler_mutex);
> >  	mutex_unlock(&listen_id->handler_mutex);
> > @@ -2313,7 +2329,7 @@ static int cma_iw_handler(struct iw_cm_id *iw_id,
> struct iw_cm_event *iw_event)
> >  	event.status = iw_event->status;
> >  	event.param.conn.private_data = iw_event->private_data;
> >  	event.param.conn.private_data_len = iw_event->private_data_len;
> > -	ret = id_priv->id.event_handler(&id_priv->id, &event);
> > +	ret = cma_cm_event_handler(id_priv, &event);
> >  	if (ret) {
> >  		/* Destroy the CM ID by returning a non-zero value. */
> >  		id_priv->cm_id.iw = NULL;
> > @@ -2390,7 +2406,7 @@ static int iw_conn_req_handler(struct iw_cm_id
> *cm_id,
> >  	 * until we're done accessing it.
> >  	 */
> >  	atomic_inc(&conn_id->refcount);
> > -	ret = conn_id->id.event_handler(&conn_id->id, &event);
> > +	ret = cma_cm_event_handler(conn_id, &event);
> >  	if (ret) {
> >  		/* User wants to destroy the CM ID */
> >  		conn_id->cm_id.iw = NULL;
> > @@ -2462,6 +2478,7 @@ static int cma_listen_handler(struct rdma_cm_id
> *id,
> >
> >  	id->context = id_priv->id.context;
> >  	id->event_handler = id_priv->id.event_handler;
> > +	trace_cm_event_handler(id_priv, event);
> >  	return id_priv->id.event_handler(id, event);
> >  }
> >
> > @@ -2636,7 +2653,7 @@ static void cma_work_handler(struct work_struct
> *_work)
> >  	if (!cma_comp_exch(id_priv, work->old_state, work->new_state))
> >  		goto out;
> >
> > -	if (id_priv->id.event_handler(&id_priv->id, &work->event)) {
> > +	if (cma_cm_event_handler(id_priv, &work->event)) {
> >  		cma_exch(id_priv, RDMA_CM_DESTROYING);
> >  		destroy = 1;
> >  	}
> > @@ -2659,7 +2676,7 @@ static void cma_ndev_work_handler(struct
> work_struct *_work)
> >  	    id_priv->state == RDMA_CM_DEVICE_REMOVAL)
> >  		goto out;
> >
> > -	if (id_priv->id.event_handler(&id_priv->id, &work->event)) {
> > +	if (cma_cm_event_handler(id_priv, &work->event)) {
> >  		cma_exch(id_priv, RDMA_CM_DESTROYING);
> >  		destroy = 1;
> >  	}
> > @@ -3062,7 +3079,7 @@ static void addr_handler(int status, struct
> sockaddr *src_addr,
> >  	} else
> >  		event.event = RDMA_CM_EVENT_ADDR_RESOLVED;
> >
> > -	if (id_priv->id.event_handler(&id_priv->id, &event)) {
> > +	if (cma_cm_event_handler(id_priv, &event)) {
> >  		cma_exch(id_priv, RDMA_CM_DESTROYING);
> >  		mutex_unlock(&id_priv->handler_mutex);
> >  		rdma_destroy_id(&id_priv->id);
> > @@ -3709,7 +3726,7 @@ static int cma_sidr_rep_handler(struct ib_cm_id
> *cm_id,
> >  		goto out;
> >  	}
> >
> > -	ret = id_priv->id.event_handler(&id_priv->id, &event);
> > +	ret = cma_cm_event_handler(id_priv, &event);
> >
> >  	rdma_destroy_ah_attr(&event.param.ud.ah_attr);
> >  	if (ret) {
> > @@ -3773,6 +3790,7 @@ static int cma_resolve_ib_udp(struct
> rdma_id_private *id_priv,
> >  	req.timeout_ms = 1 << (CMA_CM_RESPONSE_TIMEOUT - 8);
> >  	req.max_cm_retries = CMA_MAX_CM_RETRIES;
> >
> > +	trace_cm_send_sidr_req(id_priv);
> >  	ret = ib_send_cm_sidr_req(id_priv->cm_id.ib, &req);
> >  	if (ret) {
> >  		ib_destroy_cm_id(id_priv->cm_id.ib);
> > @@ -3846,6 +3864,7 @@ static int cma_connect_ib(struct rdma_id_private
> *id_priv,
> >  	req.max_cm_retries = CMA_MAX_CM_RETRIES;
> >  	req.srq = id_priv->srq ? 1 : 0;
> >
> > +	trace_cm_send_req(id_priv);
> >  	ret = ib_send_cm_req(id_priv->cm_id.ib, &req);
> >  out:
> >  	if (ret && !IS_ERR(id)) {
> > @@ -3959,6 +3978,7 @@ static int cma_accept_ib(struct rdma_id_private
> *id_priv,
> >  	rep.rnr_retry_count = min_t(u8, 7, conn_param->rnr_retry_count);
> >  	rep.srq = id_priv->srq ? 1 : 0;
> >
> > +	trace_cm_send_rep(id_priv);
> >  	ret = ib_send_cm_rep(id_priv->cm_id.ib, &rep);
> >  out:
> >  	return ret;
> > @@ -4008,6 +4028,7 @@ static int cma_send_sidr_rep(struct
> rdma_id_private *id_priv,
> >  	rep.private_data = private_data;
> >  	rep.private_data_len = private_data_len;
> >
> > +	trace_cm_send_sidr_rep(id_priv);
> >  	return ib_send_cm_sidr_rep(id_priv->cm_id.ib, &rep);
> >  }
> >
> > @@ -4093,13 +4114,15 @@ int rdma_reject(struct rdma_cm_id *id, const
> void *private_data,
> >  		return -EINVAL;
> >
> >  	if (rdma_cap_ib_cm(id->device, id->port_num)) {
> > -		if (id->qp_type == IB_QPT_UD)
> > +		if (id->qp_type == IB_QPT_UD) {
> >  			ret = cma_send_sidr_rep(id_priv, IB_SIDR_REJECT, 0,
> >  						private_data, private_data_len);
> > -		else
> > +		} else {
> > +			trace_cm_send_rej(id_priv);
> >  			ret = ib_send_cm_rej(id_priv->cm_id.ib,
> >  					     IB_CM_REJ_CONSUMER_DEFINED, NULL,
> >  					     0, private_data, private_data_len);
> > +		}
> >  	} else if (rdma_cap_iw_cm(id->device, id->port_num)) {
> >  		ret = iw_cm_reject(id_priv->cm_id.iw,
> >  				   private_data, private_data_len);
> > @@ -4124,8 +4147,13 @@ int rdma_disconnect(struct rdma_cm_id *id)
> >  		if (ret)
> >  			goto out;
> >  		/* Initiate or respond to a disconnect. */
> > -		if (ib_send_cm_dreq(id_priv->cm_id.ib, NULL, 0))
> > -			ib_send_cm_drep(id_priv->cm_id.ib, NULL, 0);
> > +		trace_cm_disconnect(id_priv);
> > +		if (ib_send_cm_dreq(id_priv->cm_id.ib, NULL, 0)) {
> > +			if (!ib_send_cm_drep(id_priv->cm_id.ib, NULL, 0))
> > +				trace_cm_sent_drep(id_priv);
> > +		} else {
> > +			trace_cm_sent_dreq(id_priv);
> > +		}
> >  	} else if (rdma_cap_iw_cm(id->device, id->port_num)) {
> >  		ret = iw_cm_disconnect(id_priv->cm_id.iw, 0);
> >  	} else
> > @@ -4191,7 +4219,7 @@ static int cma_ib_mc_handler(int status, struct
> ib_sa_multicast *multicast)
> >  	} else
> >  		event.event = RDMA_CM_EVENT_MULTICAST_ERROR;
> >
> > -	ret = id_priv->id.event_handler(&id_priv->id, &event);
> > +	ret = cma_cm_event_handler(id_priv, &event);
> >
> >  	rdma_destroy_ah_attr(&event.param.ud.ah_attr);
> >  	if (ret) {
> > @@ -4626,7 +4654,7 @@ static int cma_remove_id_dev(struct
> rdma_id_private *id_priv)
> >  		goto out;
> >
> >  	event.event = RDMA_CM_EVENT_DEVICE_REMOVAL;
> > -	ret = id_priv->id.event_handler(&id_priv->id, &event);
> > +	ret = cma_cm_event_handler(id_priv, &event);
> >  out:
> >  	mutex_unlock(&id_priv->handler_mutex);
> >  	return ret;
> > diff --git a/drivers/infiniband/core/cma_trace.c
> b/drivers/infiniband/core/cma_trace.c
> > new file mode 100644
> > index 000000000000..1093fa813bc1
> > --- /dev/null
> > +++ b/drivers/infiniband/core/cma_trace.c
> > @@ -0,0 +1,16 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Trace points for the RDMA Connection Manager.
> > + *
> > + * Author: Chuck Lever <chuck.lever@oracle.com>
> > + *
> > + * Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
> > + */
> > +
> > +#define CREATE_TRACE_POINTS
> > +
> > +#include <rdma/rdma_cm.h>
> > +#include <rdma/ib_cm.h>
> > +#include "cma_priv.h"
> > +
> > +#include <trace/events/rdma_cma.h>
> > diff --git a/include/trace/events/rdma_cma.h
> b/include/trace/events/rdma_cma.h
> > new file mode 100644
> > index 000000000000..b6ccdade651c
> > --- /dev/null
> > +++ b/include/trace/events/rdma_cma.h
> > @@ -0,0 +1,218 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Trace point definitions for the RDMA Connect Manager.
> > + *
> > + * Author: Chuck Lever <chuck.lever@oracle.com>
> > + *
> > + * Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
> > + */
> > +
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM rdma_cma
> > +
> > +#if !defined(_TRACE_RDMA_CMA_H) ||
> defined(TRACE_HEADER_MULTI_READ)
> > +
> > +#define _TRACE_RDMA_CMA_H
> > +
> > +#include <linux/tracepoint.h>
> > +#include <rdma/rdma_cm.h>
> > +#include "cma_priv.h"
> 
> Did it compile?
> cma_priv.h is located in drivers/infiniband/core/ and unlikely to be
> accessible from "include/trace/events/rdma_cma.h" file.
> 
Exactly , I have applied this patch and compile failed, and it seems
that just simply remove "#cma_priv.h" works.

> BTW, can you please add example of trace output to your commit message?
> It will help users to understand immediately what they are expected to
> see after this series is applied.
> 
> Thanks
