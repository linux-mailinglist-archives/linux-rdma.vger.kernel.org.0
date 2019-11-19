Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC961023F2
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 13:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfKSMKL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 07:10:11 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34210 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfKSMKL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 07:10:11 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJC8u1Y067958;
        Tue, 19 Nov 2019 12:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 content-transfer-encoding : from : mime-version : subject : date :
 message-id : references : cc : in-reply-to : to; s=corp-2019-08-05;
 bh=S8CdA2fQdLGoQVWJEmsakdHJKcPUf3XVmW1zH0L4qyU=;
 b=mRRb56EBpJuwjpIwrcT4mAK+oQygCoEypc2EC5efsZPyPe8fsI5UxUzijYMT5WtawpF0
 6Jcsjot26+9Ih5hZ4OAio7khyKBWXs4DWegNflR4pxUzh1pqW4bKJoJIN6rd0++h1Qc/
 Hmp8Vue8RH6wqCE76k9LaeFLY5rbP9Eie0mYuejxOhpojPFo4V9G7fYVl2isak+3tEUh
 VYz2L1lqGyDTuVS+8OtAyQbpvY+t/yynqTdpkar2sKKjxORPZcxUx+IxGx6S13jYhfur
 XGIuT+k8ftI3IJvLcUsaGU7YHzrJzeyOkr8bmlcIPA6xIn/0JxLTLp5V3wAtPjUlUHYn XA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2wa8htpg47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 12:10:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJC8rBU169373;
        Tue, 19 Nov 2019 12:10:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2wbxm46anm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 12:10:06 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAJCA5GO015253;
        Tue, 19 Nov 2019 12:10:05 GMT
Received: from [192.168.1.139] (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Nov 2019 04:10:05 -0800
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Chuck Lever <chuck.lever@oracle.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 2/2] RDMA/cma: Add trace points in RDMA Connection Manager
Date:   Tue, 19 Nov 2019 07:10:03 -0500
Message-Id: <6F70DF6D-B73A-490D-B344-1F216D1B222F@oracle.com>
References: <20191119074516.GG52766@unreal>
Cc:     linux-rdma@vger.kernel.org
In-Reply-To: <20191119074516.GG52766@unreal>
To:     Leon Romanovsky <leon@kernel.org>
X-Mailer: iPhone Mail (17B102)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190113
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> On Nov 19, 2019, at 2:45 AM, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> =EF=BB=BFOn Mon, Nov 18, 2019 at 04:49:15PM -0500, Chuck Lever wrote:
>> Record state transitions as each connection is established. The IP
>> address of both peers and the Type of Service is reported. These
>> new trace points are not in performance hot paths.
>>=20
>> Also, record each cm_event_handler call to ULPs. This eliminates the
>> need for each ULP to add its own similar trace point in its CM event
>> handler function.
>>=20
>> These new trace points appear in a new trace subsystem called
>> "rdma_cma".
>>=20
>> This patch is based on previous work by:
>>=20
>> Saeed Mahameed <saeedm@mellanox.com>
>> Mukesh Kacker <mukesh.kacker@oracle.com>
>> Ajaykumar Hotchandani <ajaykumar.hotchandani@oracle.com>
>> Aron Silverton <aron.silverton@oracle.com>
>> Avinash Repaka <avinash.repaka@oracle.com>
>> Somasundaram Krishnasamy <somasundaram.krishnasamy@oracle.com>
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> drivers/infiniband/core/Makefile    |    2
>> drivers/infiniband/core/cma.c       |   60 +++++++---
>> drivers/infiniband/core/cma_trace.c |   16 +++
>> include/trace/events/rdma_cma.h     |  218 ++++++++++++++++++++++++++++++=
+++++
>> 4 files changed, 279 insertions(+), 17 deletions(-)
>> create mode 100644 drivers/infiniband/core/cma_trace.c
>> create mode 100644 include/trace/events/rdma_cma.h
>>=20
>> diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/M=
akefile
>> index 68d9e27c3c61..bab7b6f01982 100644
>> --- a/drivers/infiniband/core/Makefile
>> +++ b/drivers/infiniband/core/Makefile
>> @@ -20,7 +20,7 @@ ib_cm-y :=3D            cm.o
>>=20
>> iw_cm-y :=3D            iwcm.o iwpm_util.o iwpm_msg.o
>>=20
>> -rdma_cm-y :=3D            cma.o
>> +rdma_cm-y :=3D            cma.o cma_trace.o
>>=20
>> rdma_cm-$(CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS) +=3D cma_configfs.o
>>=20
>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.=
c
>> index d78f67623f24..5d5e63336954 100644
>> --- a/drivers/infiniband/core/cma.c
>> +++ b/drivers/infiniband/core/cma.c
>> @@ -64,6 +64,8 @@
>> #include "core_priv.h"
>> #include "cma_priv.h"
>>=20
>> +#include <trace/events/rdma_cma.h>
>> +
>> MODULE_AUTHOR("Sean Hefty");
>> MODULE_DESCRIPTION("Generic RDMA CM Agent");
>> MODULE_LICENSE("Dual BSD/GPL");
>> @@ -1890,6 +1892,7 @@ static int cma_rep_recv(struct rdma_id_private *id_=
priv)
>>    if (ret)
>>        goto reject;
>>=20
>> +    trace_cm_send_rtu(id_priv);
>>    ret =3D ib_send_cm_rtu(id_priv->cm_id.ib, NULL, 0);
>>    if (ret)
>>        goto reject;
>> @@ -1898,6 +1901,7 @@ static int cma_rep_recv(struct rdma_id_private *id_=
priv)
>> reject:
>>    pr_debug_ratelimited("RDMA CM: CONNECT_ERROR: failed to handle reply. s=
tatus %d\n", ret);
>>    cma_modify_qp_err(id_priv);
>> +    trace_cm_send_rej(id_priv);
>>    ib_send_cm_rej(id_priv->cm_id.ib, IB_CM_REJ_CONSUMER_DEFINED,
>>               NULL, 0, NULL, 0);
>>    return ret;
>> @@ -1917,6 +1921,13 @@ static void cma_set_rep_event_data(struct rdma_cm_=
event *event,
>>    event->param.conn.qp_num =3D rep_data->remote_qpn;
>> }
>>=20
>> +static int cma_cm_event_handler(struct rdma_id_private *id_priv,
>> +                struct rdma_cm_event *event)
>> +{
>> +    trace_cm_event_handler(id_priv, event);
>> +    return id_priv->id.event_handler(&id_priv->id, event);
>> +}
>> +
>> static int cma_ib_handler(struct ib_cm_id *cm_id,
>>              const struct ib_cm_event *ib_event)
>> {
>> @@ -1939,8 +1950,10 @@ static int cma_ib_handler(struct ib_cm_id *cm_id,
>>        break;
>>    case IB_CM_REP_RECEIVED:
>>        if (cma_comp(id_priv, RDMA_CM_CONNECT) &&
>> -            (id_priv->id.qp_type !=3D IB_QPT_UD))
>> +            (id_priv->id.qp_type !=3D IB_QPT_UD)) {
>> +            trace_cm_send_mra(id_priv);
>>            ib_send_cm_mra(cm_id, CMA_CM_MRA_SETTING, NULL, 0);
>> +        }
>>        if (id_priv->id.qp) {
>>            event.status =3D cma_rep_recv(id_priv);
>>            event.event =3D event.status ? RDMA_CM_EVENT_CONNECT_ERROR :
>> @@ -1985,7 +1998,7 @@ static int cma_ib_handler(struct ib_cm_id *cm_id,
>>        goto out;
>>    }
>>=20
>> -    ret =3D id_priv->id.event_handler(&id_priv->id, &event);
>> +    ret =3D cma_cm_event_handler(id_priv, &event);
>>    if (ret) {
>>        /* Destroy the CM ID by returning a non-zero value. */
>>        id_priv->cm_id.ib =3D NULL;
>> @@ -2146,6 +2159,7 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_i=
d,
>>    if (IS_ERR(listen_id))
>>        return PTR_ERR(listen_id);
>>=20
>> +    trace_cm_req_handler(listen_id, ib_event->event);
>>    if (!cma_ib_check_req_qp_type(&listen_id->id, ib_event)) {
>>        ret =3D -EINVAL;
>>        goto net_dev_put;
>> @@ -2188,7 +2202,7 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_i=
d,
>>     * until we're done accessing it.
>>     */
>>    atomic_inc(&conn_id->refcount);
>> -    ret =3D conn_id->id.event_handler(&conn_id->id, &event);
>> +    ret =3D cma_cm_event_handler(conn_id, &event);
>>    if (ret)
>>        goto err3;
>>    /*
>> @@ -2197,8 +2211,10 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_=
id,
>>     */
>>    mutex_lock(&lock);
>>    if (cma_comp(conn_id, RDMA_CM_CONNECT) &&
>> -        (conn_id->id.qp_type !=3D IB_QPT_UD))
>> +        (conn_id->id.qp_type !=3D IB_QPT_UD)) {
>> +        trace_cm_send_mra(cm_id->context);
>>        ib_send_cm_mra(cm_id, CMA_CM_MRA_SETTING, NULL, 0);
>> +    }
>>    mutex_unlock(&lock);
>>    mutex_unlock(&conn_id->handler_mutex);
>>    mutex_unlock(&listen_id->handler_mutex);
>> @@ -2313,7 +2329,7 @@ static int cma_iw_handler(struct iw_cm_id *iw_id, s=
truct iw_cm_event *iw_event)
>>    event.status =3D iw_event->status;
>>    event.param.conn.private_data =3D iw_event->private_data;
>>    event.param.conn.private_data_len =3D iw_event->private_data_len;
>> -    ret =3D id_priv->id.event_handler(&id_priv->id, &event);
>> +    ret =3D cma_cm_event_handler(id_priv, &event);
>>    if (ret) {
>>        /* Destroy the CM ID by returning a non-zero value. */
>>        id_priv->cm_id.iw =3D NULL;
>> @@ -2390,7 +2406,7 @@ static int iw_conn_req_handler(struct iw_cm_id *cm_=
id,
>>     * until we're done accessing it.
>>     */
>>    atomic_inc(&conn_id->refcount);
>> -    ret =3D conn_id->id.event_handler(&conn_id->id, &event);
>> +    ret =3D cma_cm_event_handler(conn_id, &event);
>>    if (ret) {
>>        /* User wants to destroy the CM ID */
>>        conn_id->cm_id.iw =3D NULL;
>> @@ -2462,6 +2478,7 @@ static int cma_listen_handler(struct rdma_cm_id *id=
,
>>=20
>>    id->context =3D id_priv->id.context;
>>    id->event_handler =3D id_priv->id.event_handler;
>> +    trace_cm_event_handler(id_priv, event);
>>    return id_priv->id.event_handler(id, event);
>> }
>>=20
>> @@ -2636,7 +2653,7 @@ static void cma_work_handler(struct work_struct *_w=
ork)
>>    if (!cma_comp_exch(id_priv, work->old_state, work->new_state))
>>        goto out;
>>=20
>> -    if (id_priv->id.event_handler(&id_priv->id, &work->event)) {
>> +    if (cma_cm_event_handler(id_priv, &work->event)) {
>>        cma_exch(id_priv, RDMA_CM_DESTROYING);
>>        destroy =3D 1;
>>    }
>> @@ -2659,7 +2676,7 @@ static void cma_ndev_work_handler(struct work_struc=
t *_work)
>>        id_priv->state =3D=3D RDMA_CM_DEVICE_REMOVAL)
>>        goto out;
>>=20
>> -    if (id_priv->id.event_handler(&id_priv->id, &work->event)) {
>> +    if (cma_cm_event_handler(id_priv, &work->event)) {
>>        cma_exch(id_priv, RDMA_CM_DESTROYING);
>>        destroy =3D 1;
>>    }
>> @@ -3062,7 +3079,7 @@ static void addr_handler(int status, struct sockadd=
r *src_addr,
>>    } else
>>        event.event =3D RDMA_CM_EVENT_ADDR_RESOLVED;
>>=20
>> -    if (id_priv->id.event_handler(&id_priv->id, &event)) {
>> +    if (cma_cm_event_handler(id_priv, &event)) {
>>        cma_exch(id_priv, RDMA_CM_DESTROYING);
>>        mutex_unlock(&id_priv->handler_mutex);
>>        rdma_destroy_id(&id_priv->id);
>> @@ -3709,7 +3726,7 @@ static int cma_sidr_rep_handler(struct ib_cm_id *cm=
_id,
>>        goto out;
>>    }
>>=20
>> -    ret =3D id_priv->id.event_handler(&id_priv->id, &event);
>> +    ret =3D cma_cm_event_handler(id_priv, &event);
>>=20
>>    rdma_destroy_ah_attr(&event.param.ud.ah_attr);
>>    if (ret) {
>> @@ -3773,6 +3790,7 @@ static int cma_resolve_ib_udp(struct rdma_id_privat=
e *id_priv,
>>    req.timeout_ms =3D 1 << (CMA_CM_RESPONSE_TIMEOUT - 8);
>>    req.max_cm_retries =3D CMA_MAX_CM_RETRIES;
>>=20
>> +    trace_cm_send_sidr_req(id_priv);
>>    ret =3D ib_send_cm_sidr_req(id_priv->cm_id.ib, &req);
>>    if (ret) {
>>        ib_destroy_cm_id(id_priv->cm_id.ib);
>> @@ -3846,6 +3864,7 @@ static int cma_connect_ib(struct rdma_id_private *i=
d_priv,
>>    req.max_cm_retries =3D CMA_MAX_CM_RETRIES;
>>    req.srq =3D id_priv->srq ? 1 : 0;
>>=20
>> +    trace_cm_send_req(id_priv);
>>    ret =3D ib_send_cm_req(id_priv->cm_id.ib, &req);
>> out:
>>    if (ret && !IS_ERR(id)) {
>> @@ -3959,6 +3978,7 @@ static int cma_accept_ib(struct rdma_id_private *id=
_priv,
>>    rep.rnr_retry_count =3D min_t(u8, 7, conn_param->rnr_retry_count);
>>    rep.srq =3D id_priv->srq ? 1 : 0;
>>=20
>> +    trace_cm_send_rep(id_priv);
>>    ret =3D ib_send_cm_rep(id_priv->cm_id.ib, &rep);
>> out:
>>    return ret;
>> @@ -4008,6 +4028,7 @@ static int cma_send_sidr_rep(struct rdma_id_private=
 *id_priv,
>>    rep.private_data =3D private_data;
>>    rep.private_data_len =3D private_data_len;
>>=20
>> +    trace_cm_send_sidr_rep(id_priv);
>>    return ib_send_cm_sidr_rep(id_priv->cm_id.ib, &rep);
>> }
>>=20
>> @@ -4093,13 +4114,15 @@ int rdma_reject(struct rdma_cm_id *id, const void=
 *private_data,
>>        return -EINVAL;
>>=20
>>    if (rdma_cap_ib_cm(id->device, id->port_num)) {
>> -        if (id->qp_type =3D=3D IB_QPT_UD)
>> +        if (id->qp_type =3D=3D IB_QPT_UD) {
>>            ret =3D cma_send_sidr_rep(id_priv, IB_SIDR_REJECT, 0,
>>                        private_data, private_data_len);
>> -        else
>> +        } else {
>> +            trace_cm_send_rej(id_priv);
>>            ret =3D ib_send_cm_rej(id_priv->cm_id.ib,
>>                         IB_CM_REJ_CONSUMER_DEFINED, NULL,
>>                         0, private_data, private_data_len);
>> +        }
>>    } else if (rdma_cap_iw_cm(id->device, id->port_num)) {
>>        ret =3D iw_cm_reject(id_priv->cm_id.iw,
>>                   private_data, private_data_len);
>> @@ -4124,8 +4147,13 @@ int rdma_disconnect(struct rdma_cm_id *id)
>>        if (ret)
>>            goto out;
>>        /* Initiate or respond to a disconnect. */
>> -        if (ib_send_cm_dreq(id_priv->cm_id.ib, NULL, 0))
>> -            ib_send_cm_drep(id_priv->cm_id.ib, NULL, 0);
>> +        trace_cm_disconnect(id_priv);
>> +        if (ib_send_cm_dreq(id_priv->cm_id.ib, NULL, 0)) {
>> +            if (!ib_send_cm_drep(id_priv->cm_id.ib, NULL, 0))
>> +                trace_cm_sent_drep(id_priv);
>> +        } else {
>> +            trace_cm_sent_dreq(id_priv);
>> +        }
>>    } else if (rdma_cap_iw_cm(id->device, id->port_num)) {
>>        ret =3D iw_cm_disconnect(id_priv->cm_id.iw, 0);
>>    } else
>> @@ -4191,7 +4219,7 @@ static int cma_ib_mc_handler(int status, struct ib_=
sa_multicast *multicast)
>>    } else
>>        event.event =3D RDMA_CM_EVENT_MULTICAST_ERROR;
>>=20
>> -    ret =3D id_priv->id.event_handler(&id_priv->id, &event);
>> +    ret =3D cma_cm_event_handler(id_priv, &event);
>>=20
>>    rdma_destroy_ah_attr(&event.param.ud.ah_attr);
>>    if (ret) {
>> @@ -4626,7 +4654,7 @@ static int cma_remove_id_dev(struct rdma_id_private=
 *id_priv)
>>        goto out;
>>=20
>>    event.event =3D RDMA_CM_EVENT_DEVICE_REMOVAL;
>> -    ret =3D id_priv->id.event_handler(&id_priv->id, &event);
>> +    ret =3D cma_cm_event_handler(id_priv, &event);
>> out:
>>    mutex_unlock(&id_priv->handler_mutex);
>>    return ret;
>> diff --git a/drivers/infiniband/core/cma_trace.c b/drivers/infiniband/cor=
e/cma_trace.c
>> new file mode 100644
>> index 000000000000..1093fa813bc1
>> --- /dev/null
>> +++ b/drivers/infiniband/core/cma_trace.c
>> @@ -0,0 +1,16 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Trace points for the RDMA Connection Manager.
>> + *
>> + * Author: Chuck Lever <chuck.lever@oracle.com>
>> + *
>> + * Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved=
.
>> + */
>> +
>> +#define CREATE_TRACE_POINTS
>> +
>> +#include <rdma/rdma_cm.h>
>> +#include <rdma/ib_cm.h>
>> +#include "cma_priv.h"
>> +
>> +#include <trace/events/rdma_cma.h>
>> diff --git a/include/trace/events/rdma_cma.h b/include/trace/events/rdma_=
cma.h
>> new file mode 100644
>> index 000000000000..b6ccdade651c
>> --- /dev/null
>> +++ b/include/trace/events/rdma_cma.h
>> @@ -0,0 +1,218 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Trace point definitions for the RDMA Connect Manager.
>> + *
>> + * Author: Chuck Lever <chuck.lever@oracle.com>
>> + *
>> + * Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved=
.
>> + */
>> +
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM rdma_cma
>> +
>> +#if !defined(_TRACE_RDMA_CMA_H) || defined(TRACE_HEADER_MULTI_READ)
>> +
>> +#define _TRACE_RDMA_CMA_H
>> +
>> +#include <linux/tracepoint.h>
>> +#include <rdma/rdma_cm.h>
>> +#include "cma_priv.h"
>=20
> Did it compile?

Yes, it compiles for me, and passes lkp as well.

 I admit though that it seems like a brittle arrangement. Might be better of=
f moving rdma_cma.h to drivers/infiniband/core/ .


> cma_priv.h is located in drivers/infiniband/core/ and unlikely to be
> accessible from "include/trace/events/rdma_cma.h" file.
>=20
> BTW, can you please add example of trace output to your commit message?

Will do.

> It will help users to understand immediately what they are expected to
> see after this series is applied.
>=20
> Thanks

