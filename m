Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6081AC243
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 15:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895196AbgDPNYg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 09:24:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55606 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895107AbgDPNYY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Apr 2020 09:24:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03GDOHlD070720;
        Thu, 16 Apr 2020 13:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=6Q8Flh1csyY162JuulVR7TAL0uCvSQ9jqHWYdsZ5tms=;
 b=u1nUnNsQHUZBixTKGX7GzELPj7790e5H0mf4+H25NTLm8kuypCEQcgnVpNJP7SkCzS9t
 UKQlM3L+wlDPmfRiZFeLTXTuol7f4toCbKZEG+a2L14GR+dtcr5WJNJiIJajBj1unuxt
 zKiru91hPN50bE1Szjxc3CESb4/OkVDOuP10XSN2hyH+zeBO3uaPv8mAeNpzw0Cra3Z/
 jXrdQYlh5tFsUQSLAu4KMhm2js4u6Bty/fHBDuDYKJLqpsZrsyNCEpnt59cyVRMHjKwo
 x3iG/mud1h9on+HwDzoPFqvsvZ+FzfnxlRDrBuyK9CNFcTPJA+K1cTj25yOO0Xg52404 Vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30dn95sca6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 13:24:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03GDLsBK041874;
        Thu, 16 Apr 2020 13:24:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30dynyp7dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 13:24:20 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03GDOIKU012439;
        Thu, 16 Apr 2020 13:24:19 GMT
Received: from [192.168.10.144] (/51.175.204.144)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Apr 2020 06:24:18 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH for-rc] RDMA/cm: Do not send REJ when remote_id is unknown
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20200414204015.GA28572@ziepe.ca>
Date:   Thu, 16 Apr 2020 15:24:15 +0200
Cc:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        ted.h.kim@oracle.com, william.taylor@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <985C55AE-CD53-4C6D-8706-35D7F8170BB7@oracle.com>
References: <20200414111720.1789168-1-haakon.bugge@oracle.com>
 <20200414204015.GA28572@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=2
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0 suspectscore=2
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160095
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 14 Apr 2020, at 22:40, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> On Tue, Apr 14, 2020 at 01:17:20PM +0200, H=C3=A5kon Bugge wrote:
>> In cm_destroy_id(), when the cm_id state is IB_CM_REQ_SENT or
>> IB_CM_MRA_REQ_RCVD, an attempt is made to send a REJ with
>> IB_CM_REJ_TIMEOUT as the reject reason.
>=20
> Yes, this causes the remote to destroy the half completed connection,
> for instance if the path is unidirectional.
>=20
>> However, in said states, we have no remote_id. For the REQ_SENT case,
>> we simply haven't received anything from our peer,
>=20
> Which is correct, the spec covers this in Table 108 which describes
> the remote communication ID as '0 if REJecting due to REP timeout and
> no MRA was received'

Yes, the spec has the phrase for a REJ due toa timeout: "The recipient =
of a REJ message with this reason code must use this CA GUID to identify =
the sender, as it is possible that the Remote Communication ID in the =
REJ message may not be valid." [1]


> This is implemented in cm_acquire_rejected_id(), assuming it isn't
> buggy.
>=20
>> for the MRA_REQ_RCVD case, the cm_rma_handler() doesn't pick up the
>> remote_id.
>=20
> This seems like a bug. It would be appropriate to store the remote id
> when getting a MRA and set it in cm_format_rej() if a MRA has been =
rx'd
>=20
> It also seems like a bug that cm_acquire_rejected_id() does not check
> the remote_comm_id if it is not zero.
>=20
> And for this reason it also seems unwise that cm_alloc_id_priv() will
> allocate 0 cm_id's, as that value appears to have special meaning, oh
> and it is unwise to use 0 with cm_acquire_id(). Tsk.
>=20
> The CM_MSG_RESPONSE_REQ path looks kind of wrong too..
>=20
>> Therefore, it is no reason to send this REJ, since it simply will be
>> tossed at the peer's CM layer (if it reaches it). If running in CX-3
>> virtualized and having the pr_debug enabled in the mlx4_ib driver, we
>> will see:
>>=20
>> mlx4_ib_demux_cm_handler: Couldn't find an entry for pv_cm_id 0x0
>=20
> This seems to be a bug in mlx4. The pv layer should be duplicating how
> cm_acquire_rejected_id() works

Looks like this pv layer missed (as I did ;-)) [1] above.

> Something like this for the cm parts - what do you think?
>=20
> diff --git a/drivers/infiniband/core/cm.c =
b/drivers/infiniband/core/cm.c
> index 4794113ecd596c..fb384bf60b6f02 100644
> --- a/drivers/infiniband/core/cm.c
> +++ b/drivers/infiniband/core/cm.c
> @@ -592,20 +592,35 @@ static void cm_free_id(__be32 local_id)
> 	xa_erase_irq(&cm.local_id_table, cm_local_id(local_id));
> }
>=20
> -static struct cm_id_private *cm_acquire_id(__be32 local_id, __be32 =
remote_id)
> +/*
> + * If we know the message is related to a REQ then there is no =
remote_id set, so
> + * it should not be checked. The state should be in IB_CM_REQ_SENT,
> + * IB_CM_SIDR_REQ_SENT or IB_CM_MRA_REQ_RCVD and the caller should =
check this.
> + */
> +static struct cm_id_private *cm_acquire_req(__be32 local_id)
> {
> 	struct cm_id_private *cm_id_priv;
>=20
> 	rcu_read_lock();
> 	cm_id_priv =3D xa_load(&cm.local_id_table, =
cm_local_id(local_id));
> -	if (!cm_id_priv || cm_id_priv->id.remote_id !=3D remote_id ||
> -	    !refcount_inc_not_zero(&cm_id_priv->refcount))
> +	if (!cm_id_priv || =
!refcount_inc_not_zero(&cm_id_priv->refcount))
> 		cm_id_priv =3D NULL;
> 	rcu_read_unlock();
>=20
> 	return cm_id_priv;
> }
>=20
> +static struct cm_id_private *cm_acquire_id(__be32 local_id, __be32 =
remote_id)
> +{
> +	struct cm_id_private *cm_id_priv =3D cm_acquire_req(local_id);
> +
> +	if (READ_ONCE(cm_id_priv->id.remote_id) !=3D remote_id) {

Hmm, what if cm_id_priv is NULL?

The rest looks good to me, but I would like to backport it to the =
version I am familiar with and test it.


Thxs, H=C3=A5kon


> +		cm_deref_id(cm_id_priv);

> +		return NULL;
> +	}
> +	return cm_id_priv;
> +}
> +
> /*
>  * Trivial helpers to strip endian annotation and compare; the
>  * endianness doesn't actually matter since we just need a stable
> @@ -1856,6 +1871,10 @@ static void cm_format_rej(struct cm_rej_msg =
*rej_msg,
> 			be32_to_cpu(cm_id_priv->id.local_id));
> 		IBA_SET(CM_REJ_MESSAGE_REJECTED, rej_msg, =
CM_MSG_RESPONSE_REP);
> 		break;
> +	case IB_CM_MRA_REQ_RCVD:
> +		IBA_SET(CM_REJ_REMOTE_COMM_ID, rej_msg,
> +			be32_to_cpu(cm_id_priv->id.remote_id));
> +		fallthrough;
> 	default:
> 		IBA_SET(CM_REJ_LOCAL_COMM_ID, rej_msg,
> 			be32_to_cpu(cm_id_priv->id.local_id));
> @@ -2409,8 +2428,8 @@ static int cm_rep_handler(struct cm_work *work)
> 	struct cm_timewait_info *timewait_info;
>=20
> 	rep_msg =3D (struct cm_rep_msg =
*)work->mad_recv_wc->recv_buf.mad;
> -	cm_id_priv =3D cm_acquire_id(
> -		cpu_to_be32(IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg)), =
0);
> +	cm_id_priv =3D cm_acquire_req(
> +		cpu_to_be32(IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg)));
> 	if (!cm_id_priv) {
> 		cm_dup_rep_handler(work);
> 		pr_debug("%s: remote_comm_id %d, no cm_id_priv\n", =
__func__,
> @@ -2991,7 +3010,8 @@ static struct cm_id_private * =
cm_acquire_rejected_id(struct cm_rej_msg *rej_msg)
>=20
> 	remote_id =3D cpu_to_be32(IBA_GET(CM_REJ_LOCAL_COMM_ID, =
rej_msg));
>=20
> -	if (IBA_GET(CM_REJ_REASON, rej_msg) =3D=3D IB_CM_REJ_TIMEOUT) {
> +	if (IBA_GET(CM_REJ_REASON, rej_msg) =3D=3D IB_CM_REJ_TIMEOUT &&
> +	    IBA_GET(CM_REJ_REMOTE_COMM_ID, rej_msg) =3D=3D 0) {
> 		spin_lock_irq(&cm.lock);
> 		timewait_info =3D cm_find_remote_id(
> 			*((__be64 *)IBA_GET_MEM_PTR(CM_REJ_ARI, =
rej_msg)),
> @@ -3005,9 +3025,8 @@ static struct cm_id_private * =
cm_acquire_rejected_id(struct cm_rej_msg *rej_msg)
> 		spin_unlock_irq(&cm.lock);
> 	} else if (IBA_GET(CM_REJ_MESSAGE_REJECTED, rej_msg) =3D=3D
> 		   CM_MSG_RESPONSE_REQ)
> -		cm_id_priv =3D cm_acquire_id(
> -			cpu_to_be32(IBA_GET(CM_REJ_REMOTE_COMM_ID, =
rej_msg)),
> -			0);
> +		cm_id_priv =3D cm_acquire_req(
> +			cpu_to_be32(IBA_GET(CM_REJ_REMOTE_COMM_ID, =
rej_msg)));
> 	else
> 		cm_id_priv =3D cm_acquire_id(
> 			cpu_to_be32(IBA_GET(CM_REJ_REMOTE_COMM_ID, =
rej_msg)),
> @@ -3171,9 +3190,8 @@ static struct cm_id_private * =
cm_acquire_mraed_id(struct cm_mra_msg *mra_msg)
> {
> 	switch (IBA_GET(CM_MRA_MESSAGE_MRAED, mra_msg)) {
> 	case CM_MSG_RESPONSE_REQ:
> -		return cm_acquire_id(
> -			cpu_to_be32(IBA_GET(CM_MRA_REMOTE_COMM_ID, =
mra_msg)),
> -			0);
> +		return cm_acquire_req(
> +			cpu_to_be32(IBA_GET(CM_MRA_REMOTE_COMM_ID, =
mra_msg)));
> 	case CM_MSG_RESPONSE_REP:
> 	case CM_MSG_RESPONSE_OTHER:
> 		return cm_acquire_id(
> @@ -3211,6 +3229,8 @@ static int cm_mra_handler(struct cm_work *work)
> 				  cm_id_priv->msg, timeout))
> 			goto out;
> 		cm_id_priv->id.state =3D IB_CM_MRA_REQ_RCVD;
> +		cm_id_priv->id.remote_id =3D
> +			IBA_GET(CM_MRA_LOCAL_COMM_ID, mra_msg);
> 		break;
> 	case IB_CM_REP_SENT:
> 		if (IBA_GET(CM_MRA_MESSAGE_MRAED, mra_msg) !=3D
> @@ -3769,8 +3789,8 @@ static int cm_sidr_rep_handler(struct cm_work =
*work)
>=20
> 	sidr_rep_msg =3D (struct cm_sidr_rep_msg *)
> 				work->mad_recv_wc->recv_buf.mad;
> -	cm_id_priv =3D cm_acquire_id(
> -		cpu_to_be32(IBA_GET(CM_SIDR_REP_REQUESTID, =
sidr_rep_msg)), 0);
> +	cm_id_priv =3D cm_acquire_req(
> +		cpu_to_be32(IBA_GET(CM_SIDR_REP_REQUESTID, =
sidr_rep_msg)));
> 	if (!cm_id_priv)
> 		return -EINVAL; /* Unmatched reply. */
>=20

