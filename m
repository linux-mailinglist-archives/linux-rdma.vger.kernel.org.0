Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4525A30EF3
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2019 15:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfEaNhA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 May 2019 09:37:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58076 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaNg7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 May 2019 09:36:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4VDXaO4050299;
        Fri, 31 May 2019 13:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=p509kLFnrHmsCccTWRNRuzux/8p7YyjOhiRPWCZfPvk=;
 b=VkFMFdujwyjvzbbRZYk46C7Y0gYTaleSHW7MKWNj92xnqOMl7mrC8Hd1QFo+6rQ2U7p4
 zidtwI1J3eVNJN8z8bGA6GaC+QVg4Dl9bhNCQsglevAWk3UgPDSQZlttD6By7qVx/aX3
 achU5VKKpBIPXQWxdZ74J+FvnL8F5zq+j9fvLb/NUHVpMHoPmYV+lz7ajx+dyxCz44oB
 p6e9+GZQCgkp5uKBVu3Rl6G+QHQ9WzMVz2MsgS9JZoaUsGIQOmmXfQHv4chHmOGgBVEJ
 yDvZStU7xSe2V/X0nyka22CI4tL/AGJbIXixaXVnt19DehGrPy+NQw1h0CKAkznN/Lyb Rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2spw4tx9ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 13:36:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4VDZSE0074195;
        Fri, 31 May 2019 13:36:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2ss1fpmp5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 13:36:55 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4VDasvC022956;
        Fri, 31 May 2019 13:36:54 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 May 2019 06:36:54 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFC 05/12] xprtrdma: Remove fr_state
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <9b9e663e68aa5d3aff8e621603186af286ce7f45.camel@gmail.com>
Date:   Fri, 31 May 2019 09:36:53 -0400
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <635F6490-7635-4E17-8967-3766FA03D613@oracle.com>
References: <20190528181018.19012.61210.stgit@manet.1015granger.net>
 <20190528182116.19012.50268.stgit@manet.1015granger.net>
 <9b9e663e68aa5d3aff8e621603186af286ce7f45.camel@gmail.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905310087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905310087
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On May 30, 2019, at 10:05 AM, Anna Schumaker =
<schumaker.anna@gmail.com> wrote:
>=20
> Hi Chuck,
>=20
> On Tue, 2019-05-28 at 14:21 -0400, Chuck Lever wrote:
>> Since both the Send and Receive completion queues are processed in
>> a workqueue context, it should be safe to DMA unmap and return MRs
>> to the free or recycle lists directly in the completion handlers.
>>=20
>> Doing this means rpcrdma_frwr no longer needs to track the state
>> of each MR... a VALID or FLUSHED MR can no longer appear on an
>> xprt's MR free list.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> include/trace/events/rpcrdma.h  |   19 ----
>> net/sunrpc/xprtrdma/frwr_ops.c  |  202 =
++++++++++++++++++------------------
>> ---
>> net/sunrpc/xprtrdma/rpc_rdma.c  |    2=20
>> net/sunrpc/xprtrdma/xprt_rdma.h |   11 --
>> 4 files changed, 95 insertions(+), 139 deletions(-)
>>=20
>> diff --git a/include/trace/events/rpcrdma.h =
b/include/trace/events/rpcrdma.h
>> index a4ab3a2..7fe21ba 100644
>> --- a/include/trace/events/rpcrdma.h
>> +++ b/include/trace/events/rpcrdma.h
>> @@ -181,18 +181,6 @@
>> 				),					=
\
>> 				TP_ARGS(task, mr, nsegs))
>>=20
>> -TRACE_DEFINE_ENUM(FRWR_IS_INVALID);
>> -TRACE_DEFINE_ENUM(FRWR_IS_VALID);
>> -TRACE_DEFINE_ENUM(FRWR_FLUSHED_FR);
>> -TRACE_DEFINE_ENUM(FRWR_FLUSHED_LI);
>> -
>> -#define xprtrdma_show_frwr_state(x)					=
\
>> -		__print_symbolic(x,					=
\
>> -				{ FRWR_IS_INVALID, "INVALID" },		=
\
>> -				{ FRWR_IS_VALID, "VALID" },		=
\
>> -				{ FRWR_FLUSHED_FR, "FLUSHED_FR" },	=
\
>> -				{ FRWR_FLUSHED_LI, "FLUSHED_LI" })
>> -
>> DECLARE_EVENT_CLASS(xprtrdma_frwr_done,
>> 	TP_PROTO(
>> 		const struct ib_wc *wc,
>> @@ -203,22 +191,19 @@
>>=20
>> 	TP_STRUCT__entry(
>> 		__field(const void *, mr)
>> -		__field(unsigned int, state)
>> 		__field(unsigned int, status)
>> 		__field(unsigned int, vendor_err)
>> 	),
>>=20
>> 	TP_fast_assign(
>> 		__entry->mr =3D container_of(frwr, struct rpcrdma_mr, =
frwr);
>> -		__entry->state =3D frwr->fr_state;
>> 		__entry->status =3D wc->status;
>> 		__entry->vendor_err =3D __entry->status ? wc->vendor_err =
: 0;
>> 	),
>>=20
>> 	TP_printk(
>> -		"mr=3D%p state=3D%s: %s (%u/0x%x)",
>> -		__entry->mr, xprtrdma_show_frwr_state(__entry->state),
>> -		rdma_show_wc_status(__entry->status),
>> +		"mr=3D%p: %s (%u/0x%x)",
>> +		__entry->mr, rdma_show_wc_status(__entry->status),
>> 		__entry->status, __entry->vendor_err
>> 	)
>> );
>> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c =
b/net/sunrpc/xprtrdma/frwr_ops.c
>> index ac47314..99871fbf 100644
>> --- a/net/sunrpc/xprtrdma/frwr_ops.c
>> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
>> @@ -168,7 +168,6 @@ int frwr_init_mr(struct rpcrdma_ia *ia, struct =
rpcrdma_mr
>> *mr)
>> 		goto out_list_err;
>>=20
>> 	mr->frwr.fr_mr =3D frmr;
>> -	mr->frwr.fr_state =3D FRWR_IS_INVALID;
>> 	mr->mr_dir =3D DMA_NONE;
>> 	INIT_LIST_HEAD(&mr->mr_list);
>> 	INIT_WORK(&mr->mr_recycle, frwr_mr_recycle_worker);
>> @@ -298,65 +297,6 @@ size_t frwr_maxpages(struct rpcrdma_xprt =
*r_xprt)
>> }
>>=20
>> /**
>> - * frwr_wc_fastreg - Invoked by RDMA provider for a flushed FastReg =
WC
>> - * @cq:	completion queue (ignored)
>> - * @wc:	completed WR
>> - *
>> - */
>> -static void
>> -frwr_wc_fastreg(struct ib_cq *cq, struct ib_wc *wc)
>> -{
>> -	struct ib_cqe *cqe =3D wc->wr_cqe;
>> -	struct rpcrdma_frwr *frwr =3D
>> -			container_of(cqe, struct rpcrdma_frwr, fr_cqe);
>> -
>> -	/* WARNING: Only wr_cqe and status are reliable at this point */
>> -	if (wc->status !=3D IB_WC_SUCCESS)
>> -		frwr->fr_state =3D FRWR_FLUSHED_FR;
>> -	trace_xprtrdma_wc_fastreg(wc, frwr);
>> -}
>> -
>> -/**
>> - * frwr_wc_localinv - Invoked by RDMA provider for a flushed =
LocalInv WC
>> - * @cq:	completion queue (ignored)
>> - * @wc:	completed WR
>> - *
>> - */
>> -static void
>> -frwr_wc_localinv(struct ib_cq *cq, struct ib_wc *wc)
>> -{
>> -	struct ib_cqe *cqe =3D wc->wr_cqe;
>> -	struct rpcrdma_frwr *frwr =3D container_of(cqe, struct =
rpcrdma_frwr,
>> -						 fr_cqe);
>> -
>> -	/* WARNING: Only wr_cqe and status are reliable at this point */
>> -	if (wc->status !=3D IB_WC_SUCCESS)
>> -		frwr->fr_state =3D FRWR_FLUSHED_LI;
>> -	trace_xprtrdma_wc_li(wc, frwr);
>> -}
>> -
>> -/**
>> - * frwr_wc_localinv_wake - Invoked by RDMA provider for a signaled =
LocalInv
>> WC
>> - * @cq:	completion queue (ignored)
>> - * @wc:	completed WR
>> - *
>> - * Awaken anyone waiting for an MR to finish being fenced.
>> - */
>> -static void
>> -frwr_wc_localinv_wake(struct ib_cq *cq, struct ib_wc *wc)
>> -{
>> -	struct ib_cqe *cqe =3D wc->wr_cqe;
>> -	struct rpcrdma_frwr *frwr =3D container_of(cqe, struct =
rpcrdma_frwr,
>> -						 fr_cqe);
>> -
>> -	/* WARNING: Only wr_cqe and status are reliable at this point */
>> -	if (wc->status !=3D IB_WC_SUCCESS)
>> -		frwr->fr_state =3D FRWR_FLUSHED_LI;
>> -	trace_xprtrdma_wc_li_wake(wc, frwr);
>> -	complete(&frwr->fr_linv_done);
>> -}
>> -
>> -/**
>>  * frwr_map - Register a memory region
>>  * @r_xprt: controlling transport
>>  * @seg: memory region co-ordinates
>> @@ -378,23 +318,15 @@ struct rpcrdma_mr_seg *frwr_map(struct =
rpcrdma_xprt
>> *r_xprt,
>> {
>> 	struct rpcrdma_ia *ia =3D &r_xprt->rx_ia;
>> 	bool holes_ok =3D ia->ri_mrtype =3D=3D IB_MR_TYPE_SG_GAPS;
>> -	struct rpcrdma_frwr *frwr;
>> 	struct rpcrdma_mr *mr;
>> 	struct ib_mr *ibmr;
>> 	struct ib_reg_wr *reg_wr;
>> 	int i, n;
>> 	u8 key;
>>=20
>> -	mr =3D NULL;
>> -	do {
>> -		if (mr)
>> -			rpcrdma_mr_recycle(mr);
>> -		mr =3D rpcrdma_mr_get(r_xprt);
>> -		if (!mr)
>> -			goto out_getmr_err;
>> -	} while (mr->frwr.fr_state !=3D FRWR_IS_INVALID);
>> -	frwr =3D &mr->frwr;
>> -	frwr->fr_state =3D FRWR_IS_VALID;
>> +	mr =3D rpcrdma_mr_get(r_xprt);
>> +	if (!mr)
>> +		goto out_getmr_err;
>>=20
>> 	if (nsegs > ia->ri_max_frwr_depth)
>> 		nsegs =3D ia->ri_max_frwr_depth;
>> @@ -423,7 +355,7 @@ struct rpcrdma_mr_seg *frwr_map(struct =
rpcrdma_xprt
>> *r_xprt,
>> 	if (!mr->mr_nents)
>> 		goto out_dmamap_err;
>>=20
>> -	ibmr =3D frwr->fr_mr;
>> +	ibmr =3D mr->frwr.fr_mr;
>> 	n =3D ib_map_mr_sg(ibmr, mr->mr_sg, mr->mr_nents, NULL, =
PAGE_SIZE);
>> 	if (unlikely(n !=3D mr->mr_nents))
>> 		goto out_mapmr_err;
>> @@ -433,7 +365,7 @@ struct rpcrdma_mr_seg *frwr_map(struct =
rpcrdma_xprt
>> *r_xprt,
>> 	key =3D (u8)(ibmr->rkey & 0x000000FF);
>> 	ib_update_fast_reg_key(ibmr, ++key);
>>=20
>> -	reg_wr =3D &frwr->fr_regwr;
>> +	reg_wr =3D &mr->frwr.fr_regwr;
>> 	reg_wr->mr =3D ibmr;
>> 	reg_wr->key =3D ibmr->rkey;
>> 	reg_wr->access =3D writing ?
>> @@ -465,6 +397,23 @@ struct rpcrdma_mr_seg *frwr_map(struct =
rpcrdma_xprt
>> *r_xprt,
>> }
>>=20
>> /**
>> + * frwr_wc_fastreg - Invoked by RDMA provider for a flushed FastReg =
WC
>> + * @cq:	completion queue (ignored)
>> + * @wc:	completed WR
>> + *
>> + */
>> +static void frwr_wc_fastreg(struct ib_cq *cq, struct ib_wc *wc)
>> +{
>> +	struct ib_cqe *cqe =3D wc->wr_cqe;
>> +	struct rpcrdma_frwr *frwr =3D
>> +		container_of(cqe, struct rpcrdma_frwr, fr_cqe);
>> +
>> +	/* WARNING: Only wr_cqe and status are reliable at this point */
>> +	trace_xprtrdma_wc_fastreg(wc, frwr);
>> +	/* The MR will get recycled when the associated req is =
retransmitted */
>> +}
>> +
>> +/**
>>  * frwr_send - post Send WR containing the RPC Call message
>>  * @ia: interface adapter
>>  * @req: Prepared RPC Call
>> @@ -516,65 +465,104 @@ void frwr_reminv(struct rpcrdma_rep *rep, =
struct
>> list_head *mrs)
>> 		if (mr->mr_handle =3D=3D rep->rr_inv_rkey) {
>> 			list_del_init(&mr->mr_list);
>> 			trace_xprtrdma_mr_remoteinv(mr);
>> -			mr->frwr.fr_state =3D FRWR_IS_INVALID;
>> 			rpcrdma_mr_unmap_and_put(mr);
>> 			break;	/* only one invalidated MR per RPC */
>> 		}
>> }
>>=20
>> +static void __frwr_release_mr(struct ib_wc *wc, struct rpcrdma_mr =
*mr)
>> +{
>> +	if (wc->status !=3D IB_WC_SUCCESS)
>> +		rpcrdma_mr_recycle(mr);
>> +	else
>> +		rpcrdma_mr_unmap_and_put(mr);
>> +}
>> +
>> /**
>> - * frwr_unmap_sync - invalidate memory regions that were registered =
for @req
>> - * @r_xprt: controlling transport
>> - * @mrs: list of MRs to process
>> + * frwr_wc_localinv - Invoked by RDMA provider for a LOCAL_INV WC
>> + * @cq:	completion queue (ignored)
>> + * @wc:	completed WR
>>  *
>> - * Sleeps until it is safe for the host CPU to access the
>> - * previously mapped memory regions.
>> + */
>> +static void frwr_wc_localinv(struct ib_cq *cq, struct ib_wc *wc)
>> +{
>> +	struct ib_cqe *cqe =3D wc->wr_cqe;
>> +	struct rpcrdma_frwr *frwr =3D
>> +		container_of(cqe, struct rpcrdma_frwr, fr_cqe);
>> +	struct rpcrdma_mr *mr =3D container_of(frwr, struct rpcrdma_mr, =
frwr);
>> +
>> +	/* WARNING: Only wr_cqe and status are reliable at this point */
>> +	__frwr_release_mr(wc, mr);
>> +	trace_xprtrdma_wc_li(wc, frwr);
>> +}
>> +
>> +/**
>> + * frwr_wc_localinv_wake - Invoked by RDMA provider for a LOCAL_INV =
WC
>> + * @cq:	completion queue (ignored)
>> + * @wc:	completed WR
>>  *
>> - * Caller ensures that @mrs is not empty before the call. This
>> - * function empties the list.
>> + * Awaken anyone waiting for an MR to finish being fenced.
>>  */
>> -void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct list_head =
*mrs)
>> +static void frwr_wc_localinv_wake(struct ib_cq *cq, struct ib_wc =
*wc)
>> +{
>> +	struct ib_cqe *cqe =3D wc->wr_cqe;
>> +	struct rpcrdma_frwr *frwr =3D
>> +		container_of(cqe, struct rpcrdma_frwr, fr_cqe);
>> +	struct rpcrdma_mr *mr =3D container_of(frwr, struct rpcrdma_mr, =
frwr);
>> +
>> +	/* WARNING: Only wr_cqe and status are reliable at this point */
>> +	__frwr_release_mr(wc, mr);
>> +	trace_xprtrdma_wc_li_wake(wc, frwr);
>> +	complete(&frwr->fr_linv_done);
>> +}
>> +
>> +/**
>> + * frwr_unmap_sync - invalidate memory regions that were registered =
for @req
>> + * @r_xprt: controlling transport instance
>> + * @req: rpcrdma_req with a non-empty list of MRs to process
>> + *
>> + * Sleeps until it is safe for the host CPU to access the previously =
mapped
>> + * memory regions.
>> + */
>> +void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req =
*req)
>> {
>> 	struct ib_send_wr *first, **prev, *last;
>> 	const struct ib_send_wr *bad_wr;
>> -	struct rpcrdma_ia *ia =3D &r_xprt->rx_ia;
>> 	struct rpcrdma_frwr *frwr;
>> 	struct rpcrdma_mr *mr;
>> -	int count, rc;
>> +	int rc;
>>=20
>> 	/* ORDER: Invalidate all of the MRs first
>> 	 *
>> 	 * Chain the LOCAL_INV Work Requests and post them with
>> 	 * a single ib_post_send() call.
>> 	 */
>> -	frwr =3D NULL;
>> -	count =3D 0;
>> 	prev =3D &first;
>> -	list_for_each_entry(mr, mrs, mr_list) {
>> -		mr->frwr.fr_state =3D FRWR_IS_INVALID;
>> +	while (!list_empty(&req->rl_registered)) {
>=20
> Is this list guaranteed to always start full? Because we could =
potentially use
> frwr uninitialized a few lines down if it's not.

The only frwr_unmap_async looks like this:

1353         if (!list_empty(&req->rl_registered))
1354                 frwr_unmap_async(r_xprt, req);

The warning is a false positive. I'll see about rearranging the logic.


> net/sunrpc/xprtrdma/frwr_ops.c: In function =E2=80=98frwr_unmap_sync=E2=80=
=99:
> net/sunrpc/xprtrdma/frwr_ops.c:582:3: error: =E2=80=98frwr=E2=80=99 =
may be used uninitialized in
> this function [-Werror=3Dmaybe-uninitialized]
>   wait_for_completion(&frwr->fr_linv_done);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Thanks,
> Anna
>> +		mr =3D rpcrdma_mr_pop(&req->rl_registered);
>>=20
>> -		frwr =3D &mr->frwr;
>> 		trace_xprtrdma_mr_localinv(mr);
>> +		r_xprt->rx_stats.local_inv_needed++;
>>=20
>> +		frwr =3D &mr->frwr;
>> 		frwr->fr_cqe.done =3D frwr_wc_localinv;
>> 		last =3D &frwr->fr_invwr;
>> -		memset(last, 0, sizeof(*last));
>> +		last->next =3D NULL;
>> 		last->wr_cqe =3D &frwr->fr_cqe;
>> +		last->sg_list =3D NULL;
>> +		last->num_sge =3D 0;
>> 		last->opcode =3D IB_WR_LOCAL_INV;
>> +		last->send_flags =3D IB_SEND_SIGNALED;
>> 		last->ex.invalidate_rkey =3D mr->mr_handle;
>> -		count++;
>>=20
>> 		*prev =3D last;
>> 		prev =3D &last->next;
>> 	}
>> -	if (!frwr)
>> -		goto unmap;
>>=20
>> 	/* Strong send queue ordering guarantees that when the
>> 	 * last WR in the chain completes, all WRs in the chain
>> 	 * are complete.
>> 	 */
>> -	last->send_flags =3D IB_SEND_SIGNALED;
>> 	frwr->fr_cqe.done =3D frwr_wc_localinv_wake;
>> 	reinit_completion(&frwr->fr_linv_done);
>>=20
>> @@ -582,26 +570,18 @@ void frwr_unmap_sync(struct rpcrdma_xprt =
*r_xprt, struct
>> list_head *mrs)
>> 	 * replaces the QP. The RPC reply handler won't call us
>> 	 * unless ri_id->qp is a valid pointer.
>> 	 */
>> -	r_xprt->rx_stats.local_inv_needed++;
>> 	bad_wr =3D NULL;
>> -	rc =3D ib_post_send(ia->ri_id->qp, first, &bad_wr);
>> -	if (bad_wr !=3D first)
>> -		wait_for_completion(&frwr->fr_linv_done);
>> -	if (rc)
>> -		goto out_release;
>> +	rc =3D ib_post_send(r_xprt->rx_ia.ri_id->qp, first, &bad_wr);
>> +	trace_xprtrdma_post_send(req, rc);
>>=20
>> -	/* ORDER: Now DMA unmap all of the MRs, and return
>> -	 * them to the free MR list.
>> +	/* The final LOCAL_INV WR in the chain is supposed to
>> +	 * do the wake. If it never gets posted, the wake will
>> +	 * not happen, so don't wait in that case.
>> 	 */
>> -unmap:
>> -	while (!list_empty(mrs)) {
>> -		mr =3D rpcrdma_mr_pop(mrs);
>> -		rpcrdma_mr_unmap_and_put(mr);
>> -	}
>> -	return;
>> -
>> -out_release:
>> -	pr_err("rpcrdma: FRWR invalidate ib_post_send returned %i\n", =
rc);
>> +	if (bad_wr !=3D first)
>> +		wait_for_completion(&frwr->fr_linv_done);
>> +	if (!rc)
>> +		return;
>>=20
>> 	/* Unmap and release the MRs in the LOCAL_INV WRs that did not
>> 	 * get posted.
>> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c =
b/net/sunrpc/xprtrdma/rpc_rdma.c
>> index 77fc1e4..6c049fd 100644
>> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
>> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
>> @@ -1277,7 +1277,7 @@ void rpcrdma_release_rqst(struct rpcrdma_xprt =
*r_xprt,
>> struct rpcrdma_req *req)
>> 	 * RPC has relinquished all its Send Queue entries.
>> 	 */
>> 	if (!list_empty(&req->rl_registered))
>> -		frwr_unmap_sync(r_xprt, &req->rl_registered);
>> +		frwr_unmap_sync(r_xprt, req);
>>=20
>> 	/* Ensure that any DMA mapped pages associated with
>> 	 * the Send of the RPC Call have been unmapped before
>> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h =
b/net/sunrpc/xprtrdma/xprt_rdma.h
>> index 3c39aa3..a9de116 100644
>> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
>> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
>> @@ -240,17 +240,9 @@ struct rpcrdma_sendctx {
>>  * An external memory region is any buffer or page that is registered
>>  * on the fly (ie, not pre-registered).
>>  */
>> -enum rpcrdma_frwr_state {
>> -	FRWR_IS_INVALID,	/* ready to be used */
>> -	FRWR_IS_VALID,		/* in use */
>> -	FRWR_FLUSHED_FR,	/* flushed FASTREG WR */
>> -	FRWR_FLUSHED_LI,	/* flushed LOCALINV WR */
>> -};
>> -
>> struct rpcrdma_frwr {
>> 	struct ib_mr			*fr_mr;
>> 	struct ib_cqe			fr_cqe;
>> -	enum rpcrdma_frwr_state		fr_state;
>> 	struct completion		fr_linv_done;
>> 	union {
>> 		struct ib_reg_wr	fr_regwr;
>> @@ -567,8 +559,7 @@ struct rpcrdma_mr_seg *frwr_map(struct =
rpcrdma_xprt
>> *r_xprt,
>> 				struct rpcrdma_mr **mr);
>> int frwr_send(struct rpcrdma_ia *ia, struct rpcrdma_req *req);
>> void frwr_reminv(struct rpcrdma_rep *rep, struct list_head *mrs);
>> -void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt,
>> -		     struct list_head *mrs);
>> +void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req =
*req);
>>=20
>> /*
>>  * RPC/RDMA protocol calls - xprtrdma/rpc_rdma.c

--
Chuck Lever



