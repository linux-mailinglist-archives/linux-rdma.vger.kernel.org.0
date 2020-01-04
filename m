Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A181C1303C2
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Jan 2020 18:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgADR0y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sat, 4 Jan 2020 12:26:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42590 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726004AbgADR0y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Jan 2020 12:26:54 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 004HIkmF051554
        for <linux-rdma@vger.kernel.org>; Sat, 4 Jan 2020 12:26:53 -0500
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xapd3uj3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Sat, 04 Jan 2020 12:26:52 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Sat, 4 Jan 2020 17:26:51 -0000
Received: from us1b3-smtp05.a3dr.sjc01.isc4sb.com (10.122.203.183)
        by smtp.notes.na.collabserv.com (10.122.47.48) with smtp.notes.na.collabserv.com ESMTP;
        Sat, 4 Jan 2020 17:26:47 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp05.a3dr.sjc01.isc4sb.com
          with ESMTP id 2020010417264704-271089 ;
          Sat, 4 Jan 2020 17:26:47 +0000 
In-Reply-To: <20200103195547.GA27379@ziepe.ca>
Subject: Re: Re: [PATCH for-next v2] RDMA/siw: Simplify QP representation.
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, krishna2@chelsio.com, leon@kernel.org
Date:   Sat, 4 Jan 2020 17:26:46 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200103195547.GA27379@ziepe.ca>,<20191210161729.31598-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP62 November 04, 2019 at 09:47
X-KeepSent: 3A9B5234:ED8DBC50-002584E5:005FD59F;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 33219
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20010417-1429-0000-0000-000001202A8D
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.000431
X-IBM-SpamModules-Versions: BY=3.00012338; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01314319; UDB=6.00698788; IPR=6.01096643;
 MB=3.00030198; MTD=3.00000008; XFM=3.00000015; UTC=2020-01-04 17:26:50
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-01-04 15:14:06 - 6.00010845
x-cbparentid: 20010417-1430-0000-0000-0000180F2DC6
Message-Id: <OF3A9B5234.ED8DBC50-ON002584E5.005FD59F-002584E5.005FD5A4@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-04_04:2020-01-02,2020-01-04 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 01/03/2020 08:55PM
>Cc: linux-rdma@vger.kernel.org, krishna2@chelsio.com, leon@kernel.org
>Subject: [EXTERNAL] Re: [PATCH for-next v2] RDMA/siw: Simplify QP
>representation.
>
>On Tue, Dec 10, 2019 at 05:17:29PM +0100, Bernard Metzler wrote:
>> Change siw_qp to contain ib_qp. Use rdma_is_kernel_res()
>> on contained ib_qp to distinguish kernel level from user
>> level applications resources. Apply same mechanism for
>> kernel/user level application detection to completion queues.
>> 
>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> ---
>> Changelog:
>> v1 -> v2: Use rdma_is_kernel_res() to detect
>>           kernel level application.
>> 
>>  drivers/infiniband/sw/siw/siw.h       | 26 +++---------
>>  drivers/infiniband/sw/siw/siw_cq.c    |  2 +-
>>  drivers/infiniband/sw/siw/siw_main.c  |  2 +-
>>  drivers/infiniband/sw/siw/siw_qp.c    | 13 +++---
>>  drivers/infiniband/sw/siw/siw_qp_rx.c |  6 +--
>>  drivers/infiniband/sw/siw/siw_qp_tx.c |  2 +-
>>  drivers/infiniband/sw/siw/siw_verbs.c | 61
>+++++++++++----------------
>>  7 files changed, 42 insertions(+), 70 deletions(-)
>> 
>> diff --git a/drivers/infiniband/sw/siw/siw.h
>b/drivers/infiniband/sw/siw/siw.h
>> index b939f489cd46..2bf7a7300343 100644
>> --- a/drivers/infiniband/sw/siw/siw.h
>> +++ b/drivers/infiniband/sw/siw/siw.h
>> @@ -7,6 +7,7 @@
>>  #define _SIW_H
>>  
>>  #include <rdma/ib_verbs.h>
>> +#include <rdma/restrack.h>
>>  #include <linux/socket.h>
>>  #include <linux/skbuff.h>
>>  #include <crypto/hash.h>
>> @@ -209,7 +210,6 @@ struct siw_cq {
>>  	u32 cq_put;
>>  	u32 cq_get;
>>  	u32 num_cqe;
>> -	bool kernel_verbs;
>>  	struct rdma_user_mmap_entry *cq_entry; /* mmap info for CQE array
>*/
>>  	u32 id; /* For debugging only */
>>  };
>> @@ -254,8 +254,8 @@ struct siw_srq {
>>  	u32 rq_get;
>>  	u32 num_rqe; /* max # of wqe's allowed */
>>  	struct rdma_user_mmap_entry *srq_entry; /* mmap info for SRQ
>array */
>> -	char armed; /* inform user if limit hit */
>> -	char kernel_verbs; /* '1' if kernel client */
>> +	bool armed; /* inform user if limit hit */
>> +	bool is_kernel_res; /* true if kernel client */
>>  };
>
>I changed these bools into bool bitfields, and applied to for-next
>
>Thanks,
>Jason
>
>
Hi Jason,
thanks a lot!


Bernard.

