Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2859252C
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 15:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfHSNgT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 19 Aug 2019 09:36:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727172AbfHSNgS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 09:36:18 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JDXqxW011635
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 09:36:17 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.93])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ufuf1bmaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 09:36:17 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 19 Aug 2019 13:36:16 -0000
Received: from us1a3-smtp07.a3.dal06.isc4sb.com (10.146.103.14)
        by smtp.notes.na.collabserv.com (10.106.227.39) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 19 Aug 2019 13:36:11 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp07.a3.dal06.isc4sb.com
          with ESMTP id 2019081913361102-501300 ;
          Mon, 19 Aug 2019 13:36:11 +0000 
In-Reply-To: <20190819122456.GB5058@ziepe.ca>
Subject: Re:  Re: [PATCH] RDMA/siw: Fix compiler warnings on 32-bit due to u64/pointer
 abuse
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Doug Ledford" <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 19 Aug 2019 13:36:11 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190819122456.GB5058@ziepe.ca>,<20190819100526.13788-1-geert@linux-m68k.org>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 51891
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19081913-8889-0000-0000-000000285E23
X-IBM-SpamModules-Scores: BY=0.002624; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.080357
X-IBM-SpamModules-Versions: BY=3.00011617; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01249081; UDB=6.00659356; IPR=6.01030608;
 MB=3.00028231; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-19 13:36:16
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-19 08:09:42 - 6.00010303
x-cbparentid: 19081913-8890-0000-0000-0000003A673D
Message-Id: <OF7DB4AD51.C58B8A8B-ON0025845B.004A0CF6-0025845B.004AB95C@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Geert Uytterhoeven" <geert@linux-m68k.org>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 08/19/2019 02:25PM
>Cc: "Bernard Metzler" <bmt@zurich.ibm.com>, "Doug Ledford"
><dledford@redhat.com>, linux-rdma@vger.kernel.org,
>linux-kernel@vger.kernel.org
>Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Fix compiler warnings on
>32-bit due to u64/pointer abuse
>
>On Mon, Aug 19, 2019 at 12:05:26PM +0200, Geert Uytterhoeven wrote:
>> When compiling on 32-bit:
>> 
>>     drivers/infiniband/sw/siw/siw_cq.c:76:20: warning: cast to
>pointer from integer of different size [-Wint-to-pointer-cast]
>>     drivers/infiniband/sw/siw/siw_qp.c:952:28: warning: cast from
>pointer to integer of different size [-Wpointer-to-int-cast]
>>     drivers/infiniband/sw/siw/siw_qp_tx.c:53:10: warning: cast to
>pointer from integer of different size [-Wint-to-pointer-cast]
>>     drivers/infiniband/sw/siw/siw_qp_tx.c:59:11: warning: cast to
>pointer from integer of different size [-Wint-to-pointer-cast]
>>     drivers/infiniband/sw/siw/siw_qp_tx.c:59:26: warning: cast to
>pointer from integer of different size [-Wint-to-pointer-cast]
>>     drivers/infiniband/sw/siw/siw_qp_tx.c:61:23: warning: cast to
>pointer from integer of different size [-Wint-to-pointer-cast]
>>     drivers/infiniband/sw/siw/siw_qp_tx.c:62:9: warning: cast to
>pointer from integer of different size [-Wint-to-pointer-cast]
>>     drivers/infiniband/sw/siw/siw_qp_tx.c:82:12: warning: cast to
>pointer from integer of different size [-Wint-to-pointer-cast]
>>     drivers/infiniband/sw/siw/siw_qp_tx.c:87:12: warning: cast to
>pointer from integer of different size [-Wint-to-pointer-cast]
>>     drivers/infiniband/sw/siw/siw_qp_tx.c:101:12: warning: cast to
>pointer from integer of different size [-Wint-to-pointer-cast]
>>     drivers/infiniband/sw/siw/siw_qp_tx.c:169:29: warning: cast
>from pointer to integer of different size [-Wpointer-to-int-cast]
>>     drivers/infiniband/sw/siw/siw_qp_tx.c:192:29: warning: cast
>from pointer to integer of different size [-Wpointer-to-int-cast]
>>     drivers/infiniband/sw/siw/siw_qp_tx.c:204:29: warning: cast
>from pointer to integer of different size [-Wpointer-to-int-cast]
>>     drivers/infiniband/sw/siw/siw_qp_tx.c:219:29: warning: cast
>from pointer to integer of different size [-Wpointer-to-int-cast]
>>     drivers/infiniband/sw/siw/siw_qp_tx.c:476:24: warning: cast to
>pointer from integer of different size [-Wint-to-pointer-cast]
>>     drivers/infiniband/sw/siw/siw_qp_tx.c:535:7: warning: cast to
>pointer from integer of different size [-Wint-to-pointer-cast]
>>     drivers/infiniband/sw/siw/siw_qp_tx.c:832:29: warning: cast
>from pointer to integer of different size [-Wpointer-to-int-cast]
>>     drivers/infiniband/sw/siw/siw_qp_tx.c:927:26: warning: cast to
>pointer from integer of different size [-Wint-to-pointer-cast]
>>     drivers/infiniband/sw/siw/siw_qp_rx.c:43:5: warning: cast to
>pointer from integer of different size [-Wint-to-pointer-cast]
>>     drivers/infiniband/sw/siw/siw_qp_rx.c:43:24: warning: cast to
>pointer from integer of different size [-Wint-to-pointer-cast]
>>     drivers/infiniband/sw/siw/siw_qp_rx.c:141:23: warning: cast to
>pointer from integer of different size [-Wint-to-pointer-cast]
>>     drivers/infiniband/sw/siw/siw_qp_rx.c:488:6: warning: cast to
>pointer from integer of different size [-Wint-to-pointer-cast]
>>     drivers/infiniband/sw/siw/siw_qp_rx.c:601:5: warning: cast to
>pointer from integer of different size [-Wint-to-pointer-cast]
>>     drivers/infiniband/sw/siw/siw_qp_rx.c:844:24: warning: cast to
>pointer from integer of different size [-Wint-to-pointer-cast]
>>     drivers/infiniband/sw/siw/siw_verbs.c:665:22: warning: cast
>from pointer to integer of different size [-Wpointer-to-int-cast]
>>     drivers/infiniband/sw/siw/siw_verbs.c:828:19: warning: cast
>from pointer to integer of different size [-Wpointer-to-int-cast]
>>     drivers/infiniband/sw/siw/siw_verbs.c:846:32: warning: cast to
>pointer from integer of different size [-Wint-to-pointer-cast]
>> 
>> Fix this by applying the following rules:
>>   1. When printing a u64, the %llx format specififer should be
>used,
>>      instead of casting to a pointer, and printing the latter.
>>   2. When assigning a pointer to a u64, the pointer should be cast
>to
>>      uintptr_t, not u64,
>>   3. When casting from u64 to pointer, an intermediate cast to
>uintptr_t
>>      should be added,
>> 
>> Fixes: 2c8ccb37b08fe364 ("RDMA/siw: Change CQ flags from 64->32
>bits")
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> The issues predate the commit mentioned above, but didn't become
>visible
>> before.
>> 
>> The Right Thing(TM) would be to get rid of all this casting, and
>use
>> proper types instead.
>> This would involve teaching the siw people that a kernel virtual
>address
>> is not called a physical address, and should not use u64.
>>  drivers/infiniband/sw/siw/siw_cq.c    |  5 ++--
>>  drivers/infiniband/sw/siw/siw_qp.c    |  2 +-
>>  drivers/infiniband/sw/siw/siw_qp_rx.c | 16 +++++++------
>>  drivers/infiniband/sw/siw/siw_qp_tx.c | 34
>++++++++++++++-------------
>>  drivers/infiniband/sw/siw/siw_verbs.c |  8 +++----
>>  5 files changed, 35 insertions(+), 30 deletions(-)
>> 
>> diff --git a/drivers/infiniband/sw/siw/siw_cq.c
>b/drivers/infiniband/sw/siw/siw_cq.c
>> index e381ae9b7d62498e..f4ec26eeb9df62bf 100644
>> +++ b/drivers/infiniband/sw/siw/siw_cq.c
>> @@ -71,9 +71,10 @@ int siw_reap_cqe(struct siw_cq *cq, struct ib_wc
>*wc)
>>  				wc->wc_flags = IB_WC_WITH_INVALIDATE;
>>  			}
>>  			wc->qp = cqe->base_qp;
>> -			siw_dbg_cq(cq, "idx %u, type %d, flags %2x, id 0x%p\n",
>> +			siw_dbg_cq(cq,
>> +				   "idx %u, type %d, flags %2x, id 0x%llx\n",
>>  				   cq->cq_get % cq->num_cqe, cqe->opcode,
>> -				   cqe->flags, (void *)cqe->id);
>> +				   cqe->flags, cqe->id);
>
>If the value is really a kernel pointer, then it ought to be printed
>with %p. We have been getting demanding on this point lately in RDMA
>to enforce the ability to keep kernel pointers secret.
>
>> -			wqe->sqe.sge[0].laddr = (u64)&wqe->sqe.sge[1];
>> +			wqe->sqe.sge[0].laddr = (uintptr_t)&wqe->sqe.sge[1];
>
>[..]
>
>>  			rv = siw_rx_kva(srx,
>> -					(void *)(sge->laddr + frx->sge_off),
>> +					(void *)(uintptr_t)(sge->laddr + frx->sge_off),
>>  					sge_bytes);
>
>Bernard, this is nonsense, what is going on here with sge->laddr that
>it can't be a void *?
>
siw_sge is defined in siw-abi.h. We make the address u64 to keep the ABI
arch independent.

Thanks and best regards,
Bernard.


