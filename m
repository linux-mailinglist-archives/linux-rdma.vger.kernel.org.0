Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06D521B7E4
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2020 16:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgGJOKo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jul 2020 10:10:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43066 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgGJOKn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Jul 2020 10:10:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06AE2fOa141085
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2020 14:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=3U6RR6n5JV7jUKoM81Puocfadu2u+53TzIb17a64WpY=;
 b=yAMbxl4eZufBBwbX6QK1wd1Y+PEq4h68NGGgz9YyNUFVw6EyYgBTk6ux1QEypPu1MjrY
 W7jRIwzw/jdLrWTEkrNsc5oyigwpbL74Aj9MnKAiuGVI4sKVMAtcYASD3iStVYwdNXsF
 LEGKJqP4UhCaELXP4pSU+O0sbpdbZkLOTbsg1kieYlMoHJfl8uB5uU2ulAG6h/g+2/P5
 Gz9I3vgPxQU5jOxd+Ex2Hdom4ErfF0uv/aV0fFIcIvMtqK6QrcMwiyZ0ifdV4ciA/H4R
 s+5BARIh95VTXFK2xKIHveGtySX0RJapaM51sczurrS/Kecj7uMfVNYteD3jMWbNhpGM AA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 325y0aqndj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2020 14:10:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06AE8Ph5022421
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2020 14:10:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 325k42gt94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2020 14:10:41 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06AEAevF012481
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2020 14:10:40 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 Jul 2020 07:10:40 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH RFC 2/3] RDMA/cm: Replace pr_debug() call sites with
 tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200710140612.14749.47766.stgit@klimt.1015granger.net>
Date:   Fri, 10 Jul 2020 10:10:39 -0400
Cc:     aron.silverton@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <6812710C-0709-4F47-BC46-830AFA078DE4@oracle.com>
References: <20200710135812.14749.4630.stgit@klimt.1015granger.net>
 <20200710140612.14749.47766.stgit@klimt.1015granger.net>
To:     linux-rdma <linux-rdma@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100098
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jul 10, 2020, at 10:06 AM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
> In the interest of converging on a common instrumentation
> infrastructure, modernize the pr_debug() call sites added by commit
> 119bf81793ea ("IB/cm: Add debug prints to ib_cm"). The new
> tracepoints appear in a new "ib_cma" subsystem.
>=20
> The conversion is somewhat mechanical. Someone more familiar with
> the semantics of the recorded information might suggest additional
> data capture.
>=20
> Some benefits include:
> - Tracepoints enable "always on" reporting of these errors
> - The error records are structured and compact
> - Tracepoints provide hooks for eBPF scripts
>=20
> Sample output:
>=20
>            nfsd-1954  [003]    62.017901: cm_send_dreq_err:     =
local_id=3D1998890974 remote_id=3D1129750393 state=3DDREQ_RCVD =
lap_state=3DLAP_UNINIT

Oops. I renamed this trace point cm_dreq_skipped and neglected
to update the patch description.


> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> drivers/infiniband/core/Makefile   |    2=20
> drivers/infiniband/core/cm.c       |   80 +++------
> drivers/infiniband/core/cm_trace.c |   15 ++
> drivers/infiniband/core/cm_trace.h |  309 =
++++++++++++++++++++++++++++++++++++
> 4 files changed, 351 insertions(+), 55 deletions(-)
> create mode 100644 drivers/infiniband/core/cm_trace.c
> create mode 100644 drivers/infiniband/core/cm_trace.h
>=20
> diff --git a/drivers/infiniband/core/Makefile =
b/drivers/infiniband/core/Makefile
> index 24cb71a16a28..ccf2670ef45e 100644
> --- a/drivers/infiniband/core/Makefile
> +++ b/drivers/infiniband/core/Makefile
> @@ -17,7 +17,7 @@ ib_core-y :=3D			packer.o =
ud_header.o verbs.o cq.o rw.o sysfs.o \
> ib_core-$(CONFIG_SECURITY_INFINIBAND) +=3D security.o
> ib_core-$(CONFIG_CGROUP_RDMA) +=3D cgroup.o
>=20
> -ib_cm-y :=3D			cm.o
> +ib_cm-y :=3D			cm.o cm_trace.o
>=20
> iw_cm-y :=3D			iwcm.o iwpm_util.o iwpm_msg.o
>=20
> diff --git a/drivers/infiniband/core/cm.c =
b/drivers/infiniband/core/cm.c
> index 0d1377232933..8dd8039e1a02 100644
> --- a/drivers/infiniband/core/cm.c
> +++ b/drivers/infiniband/core/cm.c
> @@ -27,6 +27,7 @@
> #include <rdma/ib_cm.h>
> #include "cm_msgs.h"
> #include "core_priv.h"
> +#include "cm_trace.h"
>=20
> MODULE_AUTHOR("Sean Hefty");
> MODULE_DESCRIPTION("InfiniBand CM");
> @@ -2124,8 +2125,7 @@ static int cm_req_handler(struct cm_work *work)
>=20
> 	listen_cm_id_priv =3D cm_match_req(work, cm_id_priv);
> 	if (!listen_cm_id_priv) {
> -		pr_debug("%s: local_id %d, no listen_cm_id_priv\n", =
__func__,
> -			 be32_to_cpu(cm_id_priv->id.local_id));
> +		trace_cm_no_listener_err(&cm_id_priv->id);
> 		cm_id_priv->id.state =3D IB_CM_IDLE;
> 		ret =3D -EINVAL;
> 		goto destroy;
> @@ -2274,8 +2274,7 @@ int ib_send_cm_rep(struct ib_cm_id *cm_id,
> 	spin_lock_irqsave(&cm_id_priv->lock, flags);
> 	if (cm_id->state !=3D IB_CM_REQ_RCVD &&
> 	    cm_id->state !=3D IB_CM_MRA_REQ_SENT) {
> -		pr_debug("%s: local_comm_id %d, cm_id->state: %d\n", =
__func__,
> -			 be32_to_cpu(cm_id_priv->id.local_id), =
cm_id->state);
> +		trace_cm_send_rep_err(cm_id_priv->id.local_id, =
cm_id->state);
> 		ret =3D -EINVAL;
> 		goto out;
> 	}
> @@ -2348,8 +2347,7 @@ int ib_send_cm_rtu(struct ib_cm_id *cm_id,
> 	spin_lock_irqsave(&cm_id_priv->lock, flags);
> 	if (cm_id->state !=3D IB_CM_REP_RCVD &&
> 	    cm_id->state !=3D IB_CM_MRA_REP_SENT) {
> -		pr_debug("%s: local_id %d, cm_id->state %d\n", __func__,
> -			 be32_to_cpu(cm_id->local_id), cm_id->state);
> +		trace_cm_send_cm_rtu_err(cm_id);
> 		ret =3D -EINVAL;
> 		goto error;
> 	}
> @@ -2465,7 +2463,7 @@ static int cm_rep_handler(struct cm_work *work)
> 		cpu_to_be32(IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg)), =
0);
> 	if (!cm_id_priv) {
> 		cm_dup_rep_handler(work);
> -		pr_debug("%s: remote_comm_id %d, no cm_id_priv\n", =
__func__,
> +		trace_cm_remote_no_priv_err(
> 			 IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg));
> 		return -EINVAL;
> 	}
> @@ -2479,11 +2477,10 @@ static int cm_rep_handler(struct cm_work =
*work)
> 		break;
> 	default:
> 		ret =3D -EINVAL;
> -		pr_debug(
> -			"%s: cm_id_priv->id.state: %d, local_comm_id %d, =
remote_comm_id %d\n",
> -			__func__, cm_id_priv->id.state,
> +		trace_cm_rep_unknown_err(
> 			IBA_GET(CM_REP_LOCAL_COMM_ID, rep_msg),
> -			IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg));
> +			IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg),
> +			cm_id_priv->id.state);
> 		spin_unlock_irq(&cm_id_priv->lock);
> 		goto error;
> 	}
> @@ -2500,7 +2497,7 @@ static int cm_rep_handler(struct cm_work *work)
> 		spin_unlock(&cm.lock);
> 		spin_unlock_irq(&cm_id_priv->lock);
> 		ret =3D -EINVAL;
> -		pr_debug("%s: Failed to insert remote id %d\n", =
__func__,
> +		trace_cm_insert_failed_err(
> 			 IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg));
> 		goto error;
> 	}
> @@ -2517,9 +2514,8 @@ static int cm_rep_handler(struct cm_work *work)
> 			     IB_CM_REJ_STALE_CONN, CM_MSG_RESPONSE_REP,
> 			     NULL, 0);
> 		ret =3D -EINVAL;
> -		pr_debug(
> -			"%s: Stale connection. local_comm_id %d, =
remote_comm_id %d\n",
> -			__func__, IBA_GET(CM_REP_LOCAL_COMM_ID, =
rep_msg),
> +		trace_cm_staleconn_err(
> +			IBA_GET(CM_REP_LOCAL_COMM_ID, rep_msg),
> 			IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg));
>=20
> 		if (cur_cm_id_priv) {
> @@ -2646,9 +2642,7 @@ static int cm_send_dreq_locked(struct =
cm_id_private *cm_id_priv,
> 		return -EINVAL;
>=20
> 	if (cm_id_priv->id.state !=3D IB_CM_ESTABLISHED) {
> -		pr_debug("%s: local_id %d, cm_id->state: %d\n", =
__func__,
> -			 be32_to_cpu(cm_id_priv->id.local_id),
> -			 cm_id_priv->id.state);
> +		trace_cm_dreq_skipped(&cm_id_priv->id);
> 		return -EINVAL;
> 	}
>=20
> @@ -2722,10 +2716,7 @@ static int cm_send_drep_locked(struct =
cm_id_private *cm_id_priv,
> 		return -EINVAL;
>=20
> 	if (cm_id_priv->id.state !=3D IB_CM_DREQ_RCVD) {
> -		pr_debug(
> -			"%s: local_id %d, cm_idcm_id->state(%d) !=3D =
IB_CM_DREQ_RCVD\n",
> -			__func__, be32_to_cpu(cm_id_priv->id.local_id),
> -			cm_id_priv->id.state);
> +		trace_cm_send_drep_err(&cm_id_priv->id);
> 		kfree(private_data);
> 		return -EINVAL;
> 	}
> @@ -2810,9 +2801,8 @@ static int cm_dreq_handler(struct cm_work *work)
> 		=
atomic_long_inc(&work->port->counter_group[CM_RECV_DUPLICATES].
> 				counter[CM_DREQ_COUNTER]);
> 		cm_issue_drep(work->port, work->mad_recv_wc);
> -		pr_debug(
> -			"%s: no cm_id_priv, local_comm_id %d, =
remote_comm_id %d\n",
> -			__func__, IBA_GET(CM_DREQ_LOCAL_COMM_ID, =
dreq_msg),
> +		trace_cm_no_priv_err(
> +			IBA_GET(CM_DREQ_LOCAL_COMM_ID, dreq_msg),
> 			IBA_GET(CM_DREQ_REMOTE_COMM_ID, dreq_msg));
> 		return -EINVAL;
> 	}
> @@ -2858,9 +2848,7 @@ static int cm_dreq_handler(struct cm_work *work)
> 				counter[CM_DREQ_COUNTER]);
> 		goto unlock;
> 	default:
> -		pr_debug("%s: local_id %d, cm_id_priv->id.state: %d\n",
> -			 __func__, be32_to_cpu(cm_id_priv->id.local_id),
> -			 cm_id_priv->id.state);
> +		trace_cm_dreq_unknown_err(&cm_id_priv->id);
> 		goto unlock;
> 	}
> 	cm_id_priv->id.state =3D IB_CM_DREQ_RCVD;
> @@ -2945,9 +2933,7 @@ static int cm_send_rej_locked(struct =
cm_id_private *cm_id_priv,
> 			      state);
> 		break;
> 	default:
> -		pr_debug("%s: local_id %d, cm_id->state: %d\n", =
__func__,
> -			 be32_to_cpu(cm_id_priv->id.local_id),
> -			 cm_id_priv->id.state);
> +		trace_cm_send_unknown_rej_err(&cm_id_priv->id);
> 		return -EINVAL;
> 	}
>=20
> @@ -3060,9 +3046,7 @@ static int cm_rej_handler(struct cm_work *work)
> 		}
> 		/* fall through */
> 	default:
> -		pr_debug("%s: local_id %d, cm_id_priv->id.state: %d\n",
> -			 __func__, be32_to_cpu(cm_id_priv->id.local_id),
> -			 cm_id_priv->id.state);
> +		trace_cm_rej_unknown_err(&cm_id_priv->id);
> 		spin_unlock_irq(&cm_id_priv->lock);
> 		goto out;
> 	}
> @@ -3118,9 +3102,7 @@ int ib_send_cm_mra(struct ib_cm_id *cm_id,
> 		}
> 		/* fall through */
> 	default:
> -		pr_debug("%s: local_id %d, cm_id_priv->id.state: %d\n",
> -			 __func__, be32_to_cpu(cm_id_priv->id.local_id),
> -			 cm_id_priv->id.state);
> +		trace_cm_send_mra_unknown_err(&cm_id_priv->id);
> 		ret =3D -EINVAL;
> 		goto error1;
> 	}
> @@ -3229,9 +3211,7 @@ static int cm_mra_handler(struct cm_work *work)
> 				counter[CM_MRA_COUNTER]);
> 		/* fall through */
> 	default:
> -		pr_debug("%s local_id %d, cm_id_priv->id.state: %d\n",
> -			 __func__, be32_to_cpu(cm_id_priv->id.local_id),
> -			 cm_id_priv->id.state);
> +		trace_cm_mra_unknown_err(&cm_id_priv->id);
> 		goto out;
> 	}
>=20
> @@ -3765,8 +3745,7 @@ static void cm_process_send_error(struct =
ib_mad_send_buf *msg,
> 	if (msg !=3D cm_id_priv->msg || state !=3D cm_id_priv->id.state)
> 		goto discard;
>=20
> -	pr_debug_ratelimited("CM: failed sending MAD in state %d. =
(%s)\n",
> -			     state, ib_wc_status_msg(wc_status));
> +	trace_cm_mad_send_err(state, wc_status);
> 	switch (state) {
> 	case IB_CM_REQ_SENT:
> 	case IB_CM_MRA_REQ_RCVD:
> @@ -3889,7 +3868,7 @@ static void cm_work_handler(struct work_struct =
*_work)
> 		ret =3D cm_timewait_handler(work);
> 		break;
> 	default:
> -		pr_debug("cm_event.event: 0x%x\n", =
work->cm_event.event);
> +		trace_cm_handler_err(work->cm_event.event);
> 		ret =3D -EINVAL;
> 		break;
> 	}
> @@ -3925,8 +3904,7 @@ static int cm_establish(struct ib_cm_id *cm_id)
> 		ret =3D -EISCONN;
> 		break;
> 	default:
> -		pr_debug("%s: local_id %d, cm_id->state: %d\n", =
__func__,
> -			 be32_to_cpu(cm_id->local_id), cm_id->state);
> +		trace_cm_establish_err(cm_id);
> 		ret =3D -EINVAL;
> 		break;
> 	}
> @@ -4123,9 +4101,7 @@ static int cm_init_qp_init_attr(struct =
cm_id_private *cm_id_priv,
> 		ret =3D 0;
> 		break;
> 	default:
> -		pr_debug("%s: local_id %d, cm_id_priv->id.state: %d\n",
> -			 __func__, be32_to_cpu(cm_id_priv->id.local_id),
> -			 cm_id_priv->id.state);
> +		trace_cm_qp_init_err(&cm_id_priv->id);
> 		ret =3D -EINVAL;
> 		break;
> 	}
> @@ -4173,9 +4149,7 @@ static int cm_init_qp_rtr_attr(struct =
cm_id_private *cm_id_priv,
> 		ret =3D 0;
> 		break;
> 	default:
> -		pr_debug("%s: local_id %d, cm_id_priv->id.state: %d\n",
> -			 __func__, be32_to_cpu(cm_id_priv->id.local_id),
> -			 cm_id_priv->id.state);
> +		trace_cm_qp_rtr_err(&cm_id_priv->id);
> 		ret =3D -EINVAL;
> 		break;
> 	}
> @@ -4235,9 +4209,7 @@ static int cm_init_qp_rts_attr(struct =
cm_id_private *cm_id_priv,
> 		ret =3D 0;
> 		break;
> 	default:
> -		pr_debug("%s: local_id %d, cm_id_priv->id.state: %d\n",
> -			 __func__, be32_to_cpu(cm_id_priv->id.local_id),
> -			 cm_id_priv->id.state);
> +		trace_cm_qp_rts_err(&cm_id_priv->id);
> 		ret =3D -EINVAL;
> 		break;
> 	}
> diff --git a/drivers/infiniband/core/cm_trace.c =
b/drivers/infiniband/core/cm_trace.c
> new file mode 100644
> index 000000000000..8f3482f66338
> --- /dev/null
> +++ b/drivers/infiniband/core/cm_trace.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Trace points for the IB Connection Manager.
> + *
> + * Author: Chuck Lever <chuck.lever@oracle.com>
> + *
> + * Copyright (c) 2020, Oracle and/or its affiliates.
> + */
> +
> +#include <rdma/rdma_cm.h>
> +#include "cma_priv.h"
> +
> +#define CREATE_TRACE_POINTS
> +
> +#include "cm_trace.h"
> diff --git a/drivers/infiniband/core/cm_trace.h =
b/drivers/infiniband/core/cm_trace.h
> new file mode 100644
> index 000000000000..84f65f597e34
> --- /dev/null
> +++ b/drivers/infiniband/core/cm_trace.h
> @@ -0,0 +1,309 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Trace point definitions for the RDMA Connect Manager.
> + *
> + * Author: Chuck Lever <chuck.lever@oracle.com>
> + *
> + * Copyright (c) 2020 Oracle and/or its affiliates.
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM ib_cma
> +
> +#if !defined(_TRACE_IB_CMA_H) || defined(TRACE_HEADER_MULTI_READ)
> +
> +#define _TRACE_IB_CMA_H
> +
> +#include <linux/tracepoint.h>
> +#include <rdma/ib_cm.h>
> +#include <trace/events/rdma.h>
> +
> +/*
> + * enum ib_cm_state, from include/rdma/ib_cm.h
> + */
> +#define IB_CM_STATE_LIST					\
> +	ib_cm_state(IDLE)					\
> +	ib_cm_state(LISTEN)					\
> +	ib_cm_state(REQ_SENT)					\
> +	ib_cm_state(REQ_RCVD)					\
> +	ib_cm_state(MRA_REQ_SENT)				\
> +	ib_cm_state(MRA_REQ_RCVD)				\
> +	ib_cm_state(REP_SENT)					\
> +	ib_cm_state(REP_RCVD)					\
> +	ib_cm_state(MRA_REP_SENT)				\
> +	ib_cm_state(MRA_REP_RCVD)				\
> +	ib_cm_state(ESTABLISHED)				\
> +	ib_cm_state(DREQ_SENT)					\
> +	ib_cm_state(DREQ_RCVD)					\
> +	ib_cm_state(TIMEWAIT)					\
> +	ib_cm_state(SIDR_REQ_SENT)				\
> +	ib_cm_state_end(SIDR_REQ_RCVD)
> +
> +#undef  ib_cm_state
> +#undef  ib_cm_state_end
> +#define ib_cm_state(x)		TRACE_DEFINE_ENUM(IB_CM_##x);
> +#define ib_cm_state_end(x)	TRACE_DEFINE_ENUM(IB_CM_##x);
> +
> +IB_CM_STATE_LIST
> +
> +#undef  ib_cm_state
> +#undef  ib_cm_state_end
> +#define ib_cm_state(x)		{ IB_CM_##x, #x },
> +#define ib_cm_state_end(x)	{ IB_CM_##x, #x }
> +
> +#define show_ib_cm_state(x) \
> +		__print_symbolic(x, IB_CM_STATE_LIST)
> +
> +/*
> + * enum ib_cm_lap_state, from include/rdma/ib_cm.h
> + */
> +#define IB_CM_LAP_STATE_LIST					\
> +	ib_cm_lap_state(LAP_UNINIT)				\
> +	ib_cm_lap_state(LAP_IDLE)				\
> +	ib_cm_lap_state(LAP_SENT)				\
> +	ib_cm_lap_state(LAP_RCVD)				\
> +	ib_cm_lap_state(MRA_LAP_SENT)				\
> +	ib_cm_lap_state_end(MRA_LAP_RCVD)
> +
> +#undef  ib_cm_lap_state
> +#undef  ib_cm_lap_state_end
> +#define ib_cm_lap_state(x)	TRACE_DEFINE_ENUM(IB_CM_##x);
> +#define ib_cm_lap_state_end(x)	TRACE_DEFINE_ENUM(IB_CM_##x);
> +
> +IB_CM_LAP_STATE_LIST
> +
> +#undef  ib_cm_lap_state
> +#undef  ib_cm_lap_state_end
> +#define ib_cm_lap_state(x)	{ IB_CM_##x, #x },
> +#define ib_cm_lap_state_end(x)	{ IB_CM_##x, #x }
> +
> +#define show_ib_cm_lap_state(x) \
> +		__print_symbolic(x, IB_CM_LAP_STATE_LIST)
> +
> +
> +DECLARE_EVENT_CLASS(cm_id_class,
> +	TP_PROTO(
> +		const struct ib_cm_id *cm_id
> +	),
> +
> +	TP_ARGS(cm_id),
> +
> +	TP_STRUCT__entry(
> +		__field(const void *, cm_id)	/* for eBPF scripts */
> +		__field(unsigned int, local_id)
> +		__field(unsigned int, remote_id)
> +		__field(unsigned long, state)
> +		__field(unsigned long, lap_state)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cm_id =3D cm_id;
> +		__entry->local_id =3D be32_to_cpu(cm_id->local_id);
> +		__entry->remote_id =3D be32_to_cpu(cm_id->remote_id);
> +		__entry->state =3D cm_id->state;
> +		__entry->lap_state =3D cm_id->lap_state;
> +	),
> +
> +	TP_printk("local_id=3D%u remote_id=3D%u state=3D%s =
lap_state=3D%s",
> +		__entry->local_id, __entry->remote_id,
> +		show_ib_cm_state(__entry->state),
> +		show_ib_cm_lap_state(__entry->lap_state)
> +	)
> +);
> +
> +#define DEFINE_CM_ERR_EVENT(name)					=
\
> +		DEFINE_EVENT(cm_id_class,				=
\
> +				cm_##name##_err,			=
\
> +				TP_PROTO(				=
\
> +					const struct ib_cm_id *cm_id	=
\
> +				),					=
\
> +				TP_ARGS(cm_id))
> +
> +DEFINE_CM_ERR_EVENT(send_cm_rtu);
> +DEFINE_CM_ERR_EVENT(establish);
> +DEFINE_CM_ERR_EVENT(no_listener);
> +DEFINE_CM_ERR_EVENT(send_drep);
> +DEFINE_CM_ERR_EVENT(dreq_unknown);
> +DEFINE_CM_ERR_EVENT(send_unknown_rej);
> +DEFINE_CM_ERR_EVENT(rej_unknown);
> +DEFINE_CM_ERR_EVENT(send_mra_unknown);
> +DEFINE_CM_ERR_EVENT(mra_unknown);
> +DEFINE_CM_ERR_EVENT(qp_init);
> +DEFINE_CM_ERR_EVENT(qp_rtr);
> +DEFINE_CM_ERR_EVENT(qp_rts);
> +
> +DEFINE_EVENT(cm_id_class,						=
\
> +	cm_dreq_skipped,						=
\
> +	TP_PROTO(							=
\
> +		const struct ib_cm_id *cm_id				=
\
> +	),								=
\
> +	TP_ARGS(cm_id)							=
\
> +);
> +
> +DECLARE_EVENT_CLASS(cm_local_class,
> +	TP_PROTO(
> +		unsigned int local_id,
> +		unsigned int remote_id
> +	),
> +
> +	TP_ARGS(local_id, remote_id),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, local_id)
> +		__field(unsigned int, remote_id)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->local_id =3D local_id;
> +		__entry->remote_id =3D remote_id;
> +	),
> +
> +	TP_printk("local_id=3D%u remote_id=3D%u",
> +		__entry->local_id, __entry->remote_id
> +	)
> +);
> +
> +#define DEFINE_CM_LOCAL_EVENT(name)					=
\
> +		DEFINE_EVENT(cm_local_class,				=
\
> +				cm_##name,				=
\
> +				TP_PROTO(				=
\
> +					unsigned int local_id,			=
\
> +					unsigned int remote_id			=
\
> +				),					=
\
> +				TP_ARGS(local_id, remote_id))
> +
> +DEFINE_CM_LOCAL_EVENT(staleconn_err);
> +DEFINE_CM_LOCAL_EVENT(no_priv_err);
> +
> +DECLARE_EVENT_CLASS(cm_remote_class,
> +	TP_PROTO(
> +		u32 remote_id
> +	),
> +
> +	TP_ARGS(remote_id),
> +
> +	TP_STRUCT__entry(
> +		__field(u32, remote_id)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->remote_id =3D remote_id;
> +	),
> +
> +	TP_printk("remote_id=3D%u",
> +		__entry->remote_id
> +	)
> +);
> +
> +#define DEFINE_CM_REMOTE_EVENT(name)					=
\
> +		DEFINE_EVENT(cm_remote_class,				=
\
> +				cm_##name,				=
\
> +				TP_PROTO(				=
\
> +					u32 remote_id			=
\
> +				),					=
\
> +				TP_ARGS(remote_id))
> +
> +DEFINE_CM_REMOTE_EVENT(remote_no_priv_err);
> +DEFINE_CM_REMOTE_EVENT(insert_failed_err);
> +
> +TRACE_EVENT(cm_send_rep_err,
> +	TP_PROTO(
> +		__be32 local_id,
> +		enum ib_cm_state state
> +	),
> +
> +	TP_ARGS(local_id, state),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, local_id)
> +		__field(unsigned long, state)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->local_id =3D be32_to_cpu(local_id);
> +		__entry->state =3D state;
> +	),
> +
> +	TP_printk("local_id=3D%u state=3D%s",
> +		__entry->local_id, show_ib_cm_state(__entry->state)
> +	)
> +);
> +
> +TRACE_EVENT(cm_rep_unknown_err,
> +	TP_PROTO(
> +		unsigned int local_id,
> +		unsigned int remote_id,
> +		enum ib_cm_state state
> +	),
> +
> +	TP_ARGS(local_id, remote_id, state),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, local_id)
> +		__field(unsigned int, remote_id)
> +		__field(unsigned long, state)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->local_id =3D local_id;
> +		__entry->remote_id =3D remote_id;
> +		__entry->state =3D state;
> +	),
> +
> +	TP_printk("local_id=3D%u remote_id=3D%u state=3D%s",
> +		__entry->local_id, __entry->remote_id,
> +		show_ib_cm_state(__entry->state)
> +	)
> +);
> +
> +TRACE_EVENT(cm_handler_err,
> +	TP_PROTO(
> +		enum ib_event_type event
> +	),
> +
> +	TP_ARGS(event),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, event)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->event =3D event;
> +	),
> +
> +	TP_printk("unhandled event=3D%s",
> +		rdma_show_ib_event(__entry->event)
> +	)
> +);
> +
> +TRACE_EVENT(cm_mad_send_err,
> +	TP_PROTO(
> +		enum ib_cm_state state,
> +		enum ib_wc_status wc_status
> +	),
> +
> +	TP_ARGS(state, wc_status),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, state)
> +		__field(unsigned long, wc_status)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->state =3D state;
> +		__entry->wc_status =3D wc_status;
> +	),
> +
> +	TP_printk("state=3D%s completion status=3D%s",
> +		show_ib_cm_state(__entry->state),
> +		rdma_show_wc_status(__entry->wc_status)
> +	)
> +);
> +
> +#endif /* _TRACE_IB_CMA_H */
> +
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +#define TRACE_INCLUDE_FILE cm_trace
> +
> +#include <trace/define_trace.h>
>=20

--
Chuck Lever



