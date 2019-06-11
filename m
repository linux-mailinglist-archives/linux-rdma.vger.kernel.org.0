Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAD7A3D0AF
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 17:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388810AbfFKPYS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 11 Jun 2019 11:24:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50086 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387864AbfFKPYS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jun 2019 11:24:18 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BFMZ88045174
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2019 11:24:17 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.81])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2ecpt27n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2019 11:24:17 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 Jun 2019 15:22:15 -0000
Received: from us1a3-smtp02.a3.dal06.isc4sb.com (10.106.154.159)
        by smtp.notes.na.collabserv.com (10.106.227.88) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 Jun 2019 15:19:43 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp02.a3.dal06.isc4sb.com
          with ESMTP id 2019061115194182-779627 ;
          Tue, 11 Jun 2019 15:19:41 +0000 
In-Reply-To: <20190610073047.GI6369@mtr-leonro.mtl.com>
Subject: Re: [PATCH for-next v1 10/12] SIW completion queue methods
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 11 Jun 2019 15:19:41 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190610073047.GI6369@mtr-leonro.mtl.com>,<20190526114156.6827-1-bmt@zurich.ibm.com>
 <20190526114156.6827-11-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 54319
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19061115-7093-0000-0000-00000BA6E4B8
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000001
X-IBM-SpamModules-Versions: BY=3.00011247; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01216480; UDB=6.00639615; IPR=6.00997579;
 BA=6.00006332; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027264; XFM=3.00000015;
 UTC=2019-06-11 15:22:13
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-06-11 11:41:34 - 6.00010036
x-cbparentid: 19061115-7094-0000-0000-000072CAFFEC
Message-Id: <OFB68D03D0.668C1F33-ON00258416.00543371-00258416.00543377@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 06/10/2019 09:31AM
>Cc: linux-rdma@vger.kernel.org
>Subject: [EXTERNAL] Re: [PATCH for-next v1 10/12] SIW completion
>queue methods
>
>On Sun, May 26, 2019 at 01:41:54PM +0200, Bernard Metzler wrote:
>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> ---
>>  drivers/infiniband/sw/siw/siw_cq.c | 109
>+++++++++++++++++++++++++++++
>>  1 file changed, 109 insertions(+)
>>  create mode 100644 drivers/infiniband/sw/siw/siw_cq.c
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_cq.c
>b/drivers/infiniband/sw/siw/siw_cq.c
>> new file mode 100644
>> index 000000000000..e776e1b9273c
>> --- /dev/null
>> +++ b/drivers/infiniband/sw/siw/siw_cq.c
>> @@ -0,0 +1,109 @@
>> +// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
>> +
>> +/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
>> +/* Copyright (c) 2008-2019, IBM Corporation */
>> +
>> +#include <linux/errno.h>
>> +#include <linux/types.h>
>> +#include <linux/list.h>
>> +
>> +#include <rdma/iw_cm.h>
>> +#include <rdma/ib_verbs.h>
>> +#include <rdma/ib_smi.h>
>> +#include <rdma/ib_user_verbs.h>
>> +
>> +#include "siw.h"
>> +#include "siw_cm.h"
>> +#include "siw_debug.h"
>> +
>> +static int map_wc_opcode[SIW_NUM_OPCODES] = {
>> +	[SIW_OP_WRITE] = IB_WC_RDMA_WRITE,
>> +	[SIW_OP_SEND] = IB_WC_SEND,
>> +	[SIW_OP_SEND_WITH_IMM] = IB_WC_SEND,
>> +	[SIW_OP_READ] = IB_WC_RDMA_READ,
>> +	[SIW_OP_READ_LOCAL_INV] = IB_WC_RDMA_READ,
>> +	[SIW_OP_COMP_AND_SWAP] = IB_WC_COMP_SWAP,
>> +	[SIW_OP_FETCH_AND_ADD] = IB_WC_FETCH_ADD,
>> +	[SIW_OP_INVAL_STAG] = IB_WC_LOCAL_INV,
>> +	[SIW_OP_REG_MR] = IB_WC_REG_MR,
>> +	[SIW_OP_RECEIVE] = IB_WC_RECV,
>> +	[SIW_OP_READ_RESPONSE] = -1 /* not used */
>> +};
>> +
>> +static struct {
>> +	enum siw_opcode siw;
>> +	enum ib_wc_status ib;
>> +} map_cqe_status[SIW_NUM_WC_STATUS] = {
>> +	{ SIW_WC_SUCCESS, IB_WC_SUCCESS },
>> +	{ SIW_WC_LOC_LEN_ERR, IB_WC_LOC_LEN_ERR },
>> +	{ SIW_WC_LOC_PROT_ERR, IB_WC_LOC_PROT_ERR },
>> +	{ SIW_WC_LOC_QP_OP_ERR, IB_WC_LOC_QP_OP_ERR },
>> +	{ SIW_WC_WR_FLUSH_ERR, IB_WC_WR_FLUSH_ERR },
>> +	{ SIW_WC_BAD_RESP_ERR, IB_WC_BAD_RESP_ERR },
>> +	{ SIW_WC_LOC_ACCESS_ERR, IB_WC_LOC_ACCESS_ERR },
>> +	{ SIW_WC_REM_ACCESS_ERR, IB_WC_REM_ACCESS_ERR },
>> +	{ SIW_WC_REM_INV_REQ_ERR, IB_WC_REM_INV_REQ_ERR },
>> +	{ SIW_WC_GENERAL_ERR, IB_WC_GENERAL_ERR }
>> +};
>> +
>> +/*
>> + * Reap one CQE from the CQ. Only used by kernel clients
>> + * during CQ normal operation. Might be called during CQ
>> + * flush for user mapped CQE array as well.
>> + */
>> +int siw_reap_cqe(struct siw_cq *cq, struct ib_wc *wc)
>> +{
>> +	struct siw_cqe *cqe;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&cq->lock, flags);
>> +
>> +	cqe = &cq->queue[cq->cq_get % cq->num_cqe];
>
>Safer to ensure that cq_get is always in range, instead of performing
>modulo for accesses.

cg_get is a free running uint32_t, num_cqe is rounded up
to the next power of two. So I never have to check the range.
I should make a comment to make it readable.


>
>> +	if (READ_ONCE(cqe->flags) & SIW_WQE_VALID) {
>> +		memset(wc, 0, sizeof(*wc));
>> +		wc->wr_id = cqe->id;
>> +		wc->status = map_cqe_status[cqe->status].ib;
>> +		wc->opcode = map_wc_opcode[cqe->opcode];
>> +		wc->byte_len = cqe->bytes;
>> +
>> +		/*
>> +		 * During CQ flush, also user land CQE's may get
>> +		 * reaped here, which do not hold a QP reference
>> +		 * and do not qualify for memory extension verbs.
>> +		 */
>> +		if (likely(cq->kernel_verbs)) {
>
>Let's try to find a way without "kernel_verbs" variable.
>
>> +			if (cqe->flags & SIW_WQE_REM_INVAL) {
>> +				wc->ex.invalidate_rkey = cqe->inval_stag;
>> +				wc->wc_flags = IB_WC_WITH_INVALIDATE;
>> +			}
>> +			wc->qp = cqe->base_qp;
>> +			siw_dbg_cq(cq, "idx %u, type %d, flags %2x, id 0x%p\n",
>> +				   cq->cq_get % cq->num_cqe, cqe->opcode,
>> +				   cqe->flags, (void *)cqe->id);
>> +		}
>> +		WRITE_ONCE(cqe->flags, 0);
>> +		cq->cq_get++;
>> +
>> +		spin_unlock_irqrestore(&cq->lock, flags);
>> +
>> +		return 1;
>> +	}
>> +	spin_unlock_irqrestore(&cq->lock, flags);
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * siw_cq_flush()
>> + *
>> + * Flush all CQ elements.
>> + */
>> +void siw_cq_flush(struct siw_cq *cq)
>> +{
>> +	struct ib_wc wc;
>> +
>> +	siw_dbg_cq(cq, "enter\n");
>
>No "enter" prints, please.

All gone ;)

>
>> +
>> +	while (siw_reap_cqe(cq, &wc))
>> +		;
>> +}
>> --
>> 2.17.2
>>
>
>

