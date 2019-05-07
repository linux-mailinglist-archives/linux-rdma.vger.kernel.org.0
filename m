Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7EC416607
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 16:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfEGOvK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 7 May 2019 10:51:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726351AbfEGOvK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 10:51:10 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x47EljEs066922
        for <linux-rdma@vger.kernel.org>; Tue, 7 May 2019 10:51:08 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.90])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sb9tcpvf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 07 May 2019 10:51:08 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 7 May 2019 14:51:07 -0000
Received: from us1a3-smtp02.a3.dal06.isc4sb.com (10.106.154.159)
        by smtp.notes.na.collabserv.com (10.106.227.141) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 7 May 2019 14:51:03 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp02.a3.dal06.isc4sb.com
          with ESMTP id 2019050714510234-738163 ;
          Tue, 7 May 2019 14:51:02 +0000 
In-Reply-To: <20190426211157.GC6705@mtr-leonro.mtl.com>
Subject: Re: [PATCH v8 07/12] SIW queue pair methods
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org,
        "Bernard Metzler" <bmt@rims.zurich.ibm.com>
Date:   Tue, 7 May 2019 14:51:02 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190426211157.GC6705@mtr-leonro.mtl.com>,<20190426131852.30142-1-bmt@zurich.ibm.com>
 <20190426131852.30142-8-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1048) | IBM Domino Build
 SCN1812108_20180501T0841_FP38 April 10, 2019 at 11:56
X-LLNOutbound: False
X-Disclaimed: 39071
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19050714-9717-0000-0000-00000C0CA2DE
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.003726
X-IBM-SpamModules-Versions: BY=3.00011066; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01199914; UDB=6.00629548; IPR=6.00980797;
 BA=6.00006300; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00026770; XFM=3.00000015;
 UTC=2019-05-07 14:51:07
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-05-07 06:28:05 - 6.00009895
x-cbparentid: 19050714-9718-0000-0000-00005588B8A7
Message-Id: <OF8CFF7AF7.677DBEC0-ON002583F3.0050608F-002583F3.005193DA@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-07_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 04/26/2019 11:12PM
>Cc: linux-rdma@vger.kernel.org, "Bernard Metzler"
><bmt@rims.zurich.ibm.com>
>Subject: Re: [PATCH v8 07/12] SIW queue pair methods
>
>On Fri, Apr 26, 2019 at 03:18:47PM +0200, Bernard Metzler wrote:
>> From: Bernard Metzler <bmt@rims.zurich.ibm.com>
>>
>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> ---
>>  drivers/infiniband/sw/siw/siw_qp.c | 1354
>++++++++++++++++++++++++++++
>>  1 file changed, 1354 insertions(+)
>>  create mode 100644 drivers/infiniband/sw/siw/siw_qp.c
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_qp.c
>b/drivers/infiniband/sw/siw/siw_qp.c
>> new file mode 100644
>> index 000000000000..9c94a406288c
>> --- /dev/null
>> +++ b/drivers/infiniband/sw/siw/siw_qp.c
>> @@ -0,0 +1,1354 @@
>
>...
>
>> +int siw_qp_modify(struct siw_qp *qp, struct siw_qp_attrs *attrs,
>> +		  enum siw_qp_attr_mask mask)
>> +{
>> +	int drop_conn = 0, rv = 0;
>> +
>> +	if (!mask)
>> +		return 0;
>> +
>> +	siw_dbg_qp(qp, "state: %s => %s\n",
>> +		   siw_qp_state_to_string[qp->attrs.state],
>> +		   siw_qp_state_to_string[attrs->state]);
>> +
>> +	if (mask != SIW_QP_ATTR_STATE)
>> +		siw_qp_modify_nonstate(qp, attrs, mask);
>> +
>> +	if (!(mask & SIW_QP_ATTR_STATE))
>> +		return 0;
>> +
>> +	switch (qp->attrs.state) {
>> +	case SIW_QP_STATE_IDLE:
>> +	case SIW_QP_STATE_RTR:
>> +		switch (attrs->state) {
>> +		case SIW_QP_STATE_RTS:
>> +
>> +			if (attrs->flags & SIW_MPA_CRC) {
>> +				rv = siw_qp_enable_crc(qp);
>> +				if (rv)
>> +					break;
>> +			}
>> +			if (!(mask & SIW_QP_ATTR_LLP_HANDLE)) {
>> +				siw_dbg_qp(qp, "no socket\n");
>> +				rv = -EINVAL;
>> +				break;
>> +			}
>> +			if (!(mask & SIW_QP_ATTR_MPA)) {
>> +				siw_dbg_qp(qp, "no MPA\n");
>> +				rv = -EINVAL;
>> +				break;
>> +			}
>> +			siw_dbg_qp(qp, "enter rts, peer 0x%08x, loc 0x%08x\n",
>> +				   qp->cep->llp.raddr.sin_addr.s_addr,
>> +				   qp->cep->llp.laddr.sin_addr.s_addr);
>> +			/*
>> +			 * Initialize iWARP TX state
>> +			 */
>> +			qp->tx_ctx.ddp_msn[RDMAP_UNTAGGED_QN_SEND] = 0;
>> +			qp->tx_ctx.ddp_msn[RDMAP_UNTAGGED_QN_RDMA_READ] = 0;
>> +			qp->tx_ctx.ddp_msn[RDMAP_UNTAGGED_QN_TERMINATE] = 0;
>> +
>> +			/*
>> +			 * Initialize iWARP RX state
>> +			 */
>> +			qp->rx_ctx.ddp_msn[RDMAP_UNTAGGED_QN_SEND] = 1;
>> +			qp->rx_ctx.ddp_msn[RDMAP_UNTAGGED_QN_RDMA_READ] = 1;
>> +			qp->rx_ctx.ddp_msn[RDMAP_UNTAGGED_QN_TERMINATE] = 1;
>> +
>> +			/*
>> +			 * init IRD free queue, caller has already checked
>> +			 * limits.
>> +			 */
>> +			rv = siw_qp_readq_init(qp, attrs->irq_size,
>> +					       attrs->orq_size);
>> +			if (rv)
>> +				break;
>> +
>> +			qp->attrs.sk = attrs->sk;
>> +			qp->attrs.state = SIW_QP_STATE_RTS;
>> +			break;
>> +
>> +		case SIW_QP_STATE_ERROR:
>> +			siw_rq_flush(qp);
>> +			qp->attrs.state = SIW_QP_STATE_ERROR;
>> +			if (qp->cep) {
>> +				siw_cep_put(qp->cep);
>> +				qp->cep = NULL;
>> +			}
>> +			break;
>> +
>> +		case SIW_QP_STATE_RTR:
>> +			/* ignore */
>> +			break;
>> +
>> +		default:
>> +			siw_dbg_qp(qp, "state transition undefined: %s => %s\n",
>> +				   siw_qp_state_to_string[qp->attrs.state],
>> +				   siw_qp_state_to_string[attrs->state]);
>> +			break;
>> +		}
>> +		break;
>> +
>> +	case SIW_QP_STATE_RTS:
>> +		switch (attrs->state) {
>> +		case SIW_QP_STATE_CLOSING:
>> +			/*
>> +			 * Verbs: move to IDLE if SQ and ORQ are empty.
>> +			 * Move to ERROR otherwise. But first of all we must
>> +			 * close the connection. So we keep CLOSING or ERROR
>> +			 * as a transient state, schedule connection drop work
>> +			 * and wait for the socket state change upcall to
>> +			 * come back closed.
>> +			 */
>> +			if (tx_wqe(qp)->wr_status == SIW_WR_IDLE) {
>> +				qp->attrs.state = SIW_QP_STATE_CLOSING;
>> +			} else {
>> +				qp->attrs.state = SIW_QP_STATE_ERROR;
>> +				siw_sq_flush(qp);
>> +			}
>> +			siw_rq_flush(qp);
>> +
>> +			drop_conn = 1;
>> +			break;
>> +
>> +		case SIW_QP_STATE_TERMINATE:
>> +			qp->attrs.state = SIW_QP_STATE_TERMINATE;
>> +
>> +			siw_init_terminate(qp, TERM_ERROR_LAYER_RDMAP,
>> +					   RDMAP_ETYPE_CATASTROPHIC,
>> +					   RDMAP_ECODE_UNSPECIFIED, 1);
>> +			drop_conn = 1;
>> +			break;
>> +
>> +		case SIW_QP_STATE_ERROR:
>> +			/*
>> +			 * This is an emergency close.
>> +			 *
>> +			 * Any in progress transmit operation will get
>> +			 * cancelled.
>> +			 * This will likely result in a protocol failure,
>> +			 * if a TX operation is in transit. The caller
>> +			 * could unconditional wait to give the current
>> +			 * operation a chance to complete.
>> +			 * Esp., how to handle the non-empty IRQ case?
>> +			 * The peer was asking for data transfer at a valid
>> +			 * point in time.
>> +			 */
>> +			siw_sq_flush(qp);
>> +			siw_rq_flush(qp);
>> +			qp->attrs.state = SIW_QP_STATE_ERROR;
>> +			drop_conn = 1;
>> +			break;
>> +
>> +		default:
>> +			siw_dbg_qp(qp, "state transition undefined: %s => %s\n",
>> +				   siw_qp_state_to_string[qp->attrs.state],
>> +				   siw_qp_state_to_string[attrs->state]);
>> +			break;
>> +		}
>> +		break;
>> +
>> +	case SIW_QP_STATE_TERMINATE:
>> +		switch (attrs->state) {
>> +		case SIW_QP_STATE_ERROR:
>> +			siw_rq_flush(qp);
>> +			qp->attrs.state = SIW_QP_STATE_ERROR;
>> +
>> +			if (tx_wqe(qp)->wr_status != SIW_WR_IDLE)
>> +				siw_sq_flush(qp);
>> +			break;
>> +
>> +		default:
>> +			siw_dbg_qp(qp, "state transition undefined: %s => %s\n",
>> +				   siw_qp_state_to_string[qp->attrs.state],
>> +				   siw_qp_state_to_string[attrs->state]);
>> +		}
>> +		break;
>> +
>> +	case SIW_QP_STATE_CLOSING:
>> +		switch (attrs->state) {
>> +		case SIW_QP_STATE_IDLE:
>> +			WARN_ON(tx_wqe(qp)->wr_status != SIW_WR_IDLE);
>> +			qp->attrs.state = SIW_QP_STATE_IDLE;
>> +			break;
>> +
>> +		case SIW_QP_STATE_CLOSING:
>> +			/*
>> +			 * The LLP may already moved the QP to closing
>> +			 * due to graceful peer close init
>> +			 */
>> +			break;
>> +
>> +		case SIW_QP_STATE_ERROR:
>> +			/*
>> +			 * QP was moved to CLOSING by LLP event
>> +			 * not yet seen by user.
>> +			 */
>> +			qp->attrs.state = SIW_QP_STATE_ERROR;
>> +
>> +			if (tx_wqe(qp)->wr_status != SIW_WR_IDLE)
>> +				siw_sq_flush(qp);
>> +
>> +			siw_rq_flush(qp);
>> +			break;
>> +
>> +		default:
>> +			siw_dbg_qp(qp, "state transition undefined: %s => %s\n",
>> +				   siw_qp_state_to_string[qp->attrs.state],
>> +				   siw_qp_state_to_string[attrs->state]);
>> +
>> +			return -ECONNABORTED;
>> +		}
>> +		break;
>> +
>> +	default:
>> +		siw_dbg_qp(qp, " noop: state %s\n",
>> +			   siw_qp_state_to_string[qp->attrs.state]);
>> +		break;
>> +	}
>> +	if (drop_conn)
>> +		siw_qp_cm_drop(qp, 0);
>
>I wonder if it is just a bad name, but why modify QP should handle
>connections?

Some QP state changes result in a forced TCP disconnect.
So, siw_qp_modify() modifies the state of the QP, and per
iWarp spec, some state transitions request a TCP close.
This is why I have it within the QP modify function itself,
at the very end.
Otherwise, the caller would have to deduct from current
QP state and the success of a requested QP state change if
it must now do the TCP close. I did'n want to replicate
that QP state change logic for all possible callers.

>
>Thanks
>
>

