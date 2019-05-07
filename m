Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1C816619
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 16:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfEGO5g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 7 May 2019 10:57:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726322AbfEGO5g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 10:57:36 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x47EvPIY067264
        for <linux-rdma@vger.kernel.org>; Tue, 7 May 2019 10:57:34 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.91])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sbbj5t61q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 07 May 2019 10:57:34 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 7 May 2019 14:57:33 -0000
Received: from us1a3-smtp04.a3.dal06.isc4sb.com (10.106.154.237)
        by smtp.notes.na.collabserv.com (10.106.227.143) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 7 May 2019 14:57:29 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp04.a3.dal06.isc4sb.com
          with ESMTP id 2019050714572816-729856 ;
          Tue, 7 May 2019 14:57:28 +0000 
In-Reply-To: <20190427053931.GD6705@mtr-leonro.mtl.com>
Subject: Re: [PATCH v8 11/12] SIW debugging
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org,
        "Bernard Metzler" <bmt@rims.zurich.ibm.com>
Date:   Tue, 7 May 2019 14:57:27 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190427053931.GD6705@mtr-leonro.mtl.com>,<20190426131852.30142-1-bmt@zurich.ibm.com>
 <20190426131852.30142-12-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1048) | IBM Domino Build
 SCN1812108_20180501T0841_FP38 April 10, 2019 at 11:56
X-LLNOutbound: False
X-Disclaimed: 44571
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19050714-9951-0000-0000-00000C5FB00C
X-IBM-SpamModules-Scores: BY=0.020958; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.077016
X-IBM-SpamModules-Versions: BY=3.00011066; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01199916; UDB=6.00629549; IPR=6.00980799;
 BA=6.00006300; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00026770; XFM=3.00000015;
 UTC=2019-05-07 14:57:31
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-05-07 06:19:41 - 6.00009895
x-cbparentid: 19050714-9952-0000-0000-00003C57C82C
Message-Id: <OF7C942C02.82621E0C-ON002583F3.0051E3A9-002583F3.00522A5E@notes.na.collabserv.com>
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
>Date: 04/27/2019 07:39AM
>Cc: linux-rdma@vger.kernel.org, "Bernard Metzler"
><bmt@rims.zurich.ibm.com>
>Subject: Re: [PATCH v8 11/12] SIW debugging
>
>On Fri, Apr 26, 2019 at 03:18:51PM +0200, Bernard Metzler wrote:
>> From: Bernard Metzler <bmt@rims.zurich.ibm.com>
>>
>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> ---
>>  drivers/infiniband/sw/siw/siw_debug.c | 91
>+++++++++++++++++++++++++++
>>  drivers/infiniband/sw/siw/siw_debug.h | 40 ++++++++++++
>>  2 files changed, 131 insertions(+)
>>  create mode 100644 drivers/infiniband/sw/siw/siw_debug.c
>>  create mode 100644 drivers/infiniband/sw/siw/siw_debug.h
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_debug.c
>b/drivers/infiniband/sw/siw/siw_debug.c
>> new file mode 100644
>> index 000000000000..86460d370333
>> --- /dev/null
>> +++ b/drivers/infiniband/sw/siw/siw_debug.c
>> @@ -0,0 +1,91 @@
>> +// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
>> +
>> +/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
>> +/* Copyright (c) 2008-2019, IBM Corporation */
>> +
>> +#include <linux/types.h>
>> +#include <linux/printk.h>
>> +
>> +#include "siw.h"
>> +
>> +#define ddp_data_len(op, mpa_len)
>            \
>> +	(mpa_len - (iwarp_pktinfo[op].hdr_len - MPA_HDR_SIZE))
>> +
>> +void siw_print_hdr(union iwarp_hdr *hdr, int qp_id, char *string)
>> +{
>> +	enum rdma_opcode op = __rdmap_get_opcode(&hdr->ctrl);
>> +	u16 mpa_len = be16_to_cpu(hdr->ctrl.mpa_len);
>> +
>> +	switch (op) {
>> +	case RDMAP_RDMA_WRITE:
>> +		pr_info("siw: [QP %u]: %s(WRITE, DDP len %d): %08x %016llx\n",
>> +			qp_id, string, ddp_data_len(op, mpa_len),
>> +			hdr->rwrite.sink_stag, hdr->rwrite.sink_to);
>> +		break;
>> +
>> +	case RDMAP_RDMA_READ_REQ:
>> +		pr_info("siw: [QP %u]: %s(RREQ, DDP len %d): %08x %08x %08x %08x
>%016llx %08x %08x %016llx\n",
>> +			qp_id, string, ddp_data_len(op, mpa_len),
>> +			be32_to_cpu(hdr->rreq.ddp_qn),
>> +			be32_to_cpu(hdr->rreq.ddp_msn),
>> +			be32_to_cpu(hdr->rreq.ddp_mo),
>> +			be32_to_cpu(hdr->rreq.sink_stag),
>> +			be64_to_cpu(hdr->rreq.sink_to),
>> +			be32_to_cpu(hdr->rreq.read_size),
>> +			be32_to_cpu(hdr->rreq.source_stag),
>> +			be64_to_cpu(hdr->rreq.source_to));
>> +
>> +		break;
>> +
>> +	case RDMAP_RDMA_READ_RESP:
>> +		pr_info("siw: [QP %u]: %s(RRESP, DDP len %d): %08x %016llx\n",
>> +			qp_id, string, ddp_data_len(op, mpa_len),
>> +			be32_to_cpu(hdr->rresp.sink_stag),
>> +			be64_to_cpu(hdr->rresp.sink_to));
>> +		break;
>> +
>> +	case RDMAP_SEND:
>> +		pr_info("siw: [QP %u]: %s(SEND, DDP len %d): %08x %08x %08x\n",
>> +			qp_id, string, ddp_data_len(op, mpa_len),
>> +			be32_to_cpu(hdr->send.ddp_qn),
>> +			be32_to_cpu(hdr->send.ddp_msn),
>> +			be32_to_cpu(hdr->send.ddp_mo));
>> +		break;
>> +
>> +	case RDMAP_SEND_INVAL:
>> +		pr_info("siw: [QP %u]: %s(S_INV, DDP len %d): %08x %08x %08x
>%08x\n",
>> +			qp_id, string, ddp_data_len(op, mpa_len),
>> +			be32_to_cpu(hdr->send_inv.inval_stag),
>> +			be32_to_cpu(hdr->send_inv.ddp_qn),
>> +			be32_to_cpu(hdr->send_inv.ddp_msn),
>> +			be32_to_cpu(hdr->send_inv.ddp_mo));
>> +		break;
>> +
>> +	case RDMAP_SEND_SE:
>> +		pr_info("siw: [QP %u]: %s(S_SE, DDP len %d): %08x %08x %08x\n",
>> +			qp_id, string, ddp_data_len(op, mpa_len),
>> +			be32_to_cpu(hdr->send.ddp_qn),
>> +			be32_to_cpu(hdr->send.ddp_msn),
>> +			be32_to_cpu(hdr->send.ddp_mo));
>> +		break;
>> +
>> +	case RDMAP_SEND_SE_INVAL:
>> +		pr_info("siw: [QP %u]: %s(S_SE_INV, DDP len %d): %08x %08x %08x
>%08x\n",
>> +			qp_id, string, ddp_data_len(op, mpa_len),
>> +			be32_to_cpu(hdr->send_inv.inval_stag),
>> +			be32_to_cpu(hdr->send_inv.ddp_qn),
>> +			be32_to_cpu(hdr->send_inv.ddp_msn),
>> +			be32_to_cpu(hdr->send_inv.ddp_mo));
>> +		break;
>> +
>> +	case RDMAP_TERMINATE:
>> +		pr_info("siw: [QP %u]: %s(TERM, DDP len %d):\n", qp_id, string,
>> +			ddp_data_len(op, mpa_len));
>> +		break;
>> +
>> +	default:
>> +		pr_info("siw: [QP %u]: %s (undefined opcode %d)", qp_id, string,
>> +			op);
>> +		break;
>> +	}
>> +}
>> diff --git a/drivers/infiniband/sw/siw/siw_debug.h
>b/drivers/infiniband/sw/siw/siw_debug.h
>> new file mode 100644
>> index 000000000000..2cfe7ce68428
>> --- /dev/null
>> +++ b/drivers/infiniband/sw/siw/siw_debug.h
>> @@ -0,0 +1,40 @@
>> +/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
>> +
>> +/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
>> +/* Copyright (c) 2008-2019, IBM Corporation */
>> +
>> +#ifndef _SIW_DEBUG_H
>> +#define _SIW_DEBUG_H
>> +
>> +#define siw_dbg(ddev, fmt, ...)
>            \
>> +	dev_dbg(&(ddev)->base_dev.dev, "cpu%2d %s: " fmt,
>smp_processor_id(),  \
>> +		__func__, ##__VA_ARGS__)
>> +
>> +#define siw_dbg_qp(qp, fmt, ...)
>            \
>> +	siw_dbg(qp->sdev, "[QP %u]: " fmt, qp->id, ##__VA_ARGS__)
>> +
>> +#define siw_dbg_cq(cq, fmt, ...)
>            \
>> +	siw_dbg(cq->sdev, "[CQ %u]: " fmt, cq->id, ##__VA_ARGS__)
>> +
>> +#define siw_dbg_pd(pd, fmt, ...)
>            \
>> +	siw_dbg(pd->sdev, "[PD %u]: " fmt, pd->base_pd.res.id,
>##__VA_ARGS__)
>> +
>> +#define siw_dbg_mem(mem, fmt, ...)
>            \
>> +	siw_dbg(mem->sdev, "[MEM 0x%08x]: " fmt, mem->stag,
>##__VA_ARGS__)
>> +
>> +#define siw_dbg_cep(cep, fmt, ...)
>            \
>> +	siw_dbg(cep->sdev, "[CEP 0x%p]: " fmt, cep, ##__VA_ARGS__)
>> +
>> +#ifdef DEBUG_HDR
>
>We already talked about it, this DEBUG_HDR is not set and
>siw_dprint_hdr() is unreachable.

I agree. That code gets only compiled in if DEBUG_HDR is #defined.
Any better idea than this ugly thing for a compile time switch is
highly appreciated...


>
>> +
>> +#define siw_dprint_hdr(hdr, qpn, msg) siw_print_hdr(hdr, qpn, msg)
>> +
>> +#else
>> +
>> +#define siw_dprint_hdr(hdr, qpn, msg)
>            \
>> +	do {
>     \
>> +	} while (0)
>> +
>> +#endif
>> +
>> +#endif
>> --
>> 2.17.2
>>
>
>

