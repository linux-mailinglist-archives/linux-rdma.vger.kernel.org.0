Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB9383459
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2019 16:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733024AbfHFOy3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 6 Aug 2019 10:54:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732024AbfHFOy3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Aug 2019 10:54:29 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x76EqqWi011742
        for <linux-rdma@vger.kernel.org>; Tue, 6 Aug 2019 10:54:27 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.67])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u7auc2qe0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 06 Aug 2019 10:54:27 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 6 Aug 2019 14:54:26 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
        by smtp.notes.na.collabserv.com (10.106.227.16) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 6 Aug 2019 14:53:51 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp05.a3.dal06.isc4sb.com
          with ESMTP id 2019080614534956-649875 ;
          Tue, 6 Aug 2019 14:53:49 +0000 
In-Reply-To: <20190806121006.GC11627@ziepe.ca>
Subject: Re: Re: [PATCH 1/1] Make user mmapped CQ arming flags field 32 bit size to
 remove 64 bit architecture dependency of siw.
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 6 Aug 2019 14:53:49 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190806121006.GC11627@ziepe.ca>,<20190805141708.9004-1-bmt@zurich.ibm.com>
 <20190805141708.9004-2-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 14531
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19080614-7279-0000-0000-00000020C7A8
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.095898
X-IBM-SpamModules-Versions: BY=3.00011561; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01242939; UDB=6.00655641; IPR=6.01024403;
 MB=3.00028068; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-06 14:54:24
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-06 07:51:30 - 6.00010253
x-cbparentid: 19080614-7280-0000-0000-00000032E2AA
Message-Id: <OFCF70B144.E0186C06-ON0025844E.0050E500-0025844E.0051D4FA@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-06_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 08/06/2019 02:10PM
>Cc: linux-rdma@vger.kernel.org
>Subject: [EXTERNAL] Re: [PATCH 1/1] Make user mmapped CQ arming flags
>field 32 bit size to remove 64 bit architecture dependency of siw.
>
>On Mon, Aug 05, 2019 at 04:17:08PM +0200, Bernard Metzler wrote:
>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> ---
>
>Don't send patches with empty commit messages. Every patch must have
>a
>comprehensive commit message from now on.

Sorry about this. As Doug pointed out - I sent an extra
cover letter.

>
>>  drivers/infiniband/sw/siw/Kconfig     |  2 +-
>>  drivers/infiniband/sw/siw/siw.h       |  2 +-
>>  drivers/infiniband/sw/siw/siw_qp.c    | 14 ++++++++++----
>>  drivers/infiniband/sw/siw/siw_verbs.c | 16 +++++++++++-----
>>  include/uapi/rdma/siw-abi.h           |  3 ++-
>>  5 files changed, 25 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/infiniband/sw/siw/Kconfig
>b/drivers/infiniband/sw/siw/Kconfig
>> index dace276aea14..b622fc62f2cd 100644
>> --- a/drivers/infiniband/sw/siw/Kconfig
>> +++ b/drivers/infiniband/sw/siw/Kconfig
>> @@ -1,6 +1,6 @@
>>  config RDMA_SIW
>>  	tristate "Software RDMA over TCP/IP (iWARP) driver"
>> -	depends on INET && INFINIBAND && LIBCRC32C && 64BIT
>> +	depends on INET && INFINIBAND && LIBCRC32C
>>  	select DMA_VIRT_OPS
>>  	help
>>  	This driver implements the iWARP RDMA transport over
>> diff --git a/drivers/infiniband/sw/siw/siw.h
>b/drivers/infiniband/sw/siw/siw.h
>> index 03fd7b2f595f..77b1aabf6ff3 100644
>> --- a/drivers/infiniband/sw/siw/siw.h
>> +++ b/drivers/infiniband/sw/siw/siw.h
>> @@ -214,7 +214,7 @@ struct siw_wqe {
>>  struct siw_cq {
>>  	struct ib_cq base_cq;
>>  	spinlock_t lock;
>> -	u64 *notify;
>> +	struct siw_cq_ctrl *notify;
>>  	struct siw_cqe *queue;
>>  	u32 cq_put;
>>  	u32 cq_get;
>> diff --git a/drivers/infiniband/sw/siw/siw_qp.c
>b/drivers/infiniband/sw/siw/siw_qp.c
>> index e27bd5b35b96..0990307c5d2c 100644
>> --- a/drivers/infiniband/sw/siw/siw_qp.c
>> +++ b/drivers/infiniband/sw/siw/siw_qp.c
>> @@ -1013,18 +1013,24 @@ int siw_activate_tx(struct siw_qp *qp)
>>   */
>>  static bool siw_cq_notify_now(struct siw_cq *cq, u32 flags)
>>  {
>> -	u64 cq_notify;
>> +	u32 cq_notify;
>>  
>>  	if (!cq->base_cq.comp_handler)
>>  		return false;
>>  
>> -	cq_notify = READ_ONCE(*cq->notify);
>> +	/* Read application shared notification state */
>> +	cq_notify = READ_ONCE(cq->notify->flags);
>>  
>>  	if ((cq_notify & SIW_NOTIFY_NEXT_COMPLETION) ||
>>  	    ((cq_notify & SIW_NOTIFY_SOLICITED) &&
>>  	     (flags & SIW_WQE_SOLICITED))) {
>> -		/* dis-arm CQ */
>> -		smp_store_mb(*cq->notify, SIW_NOTIFY_NOT);
>> +		/*
>> +		 * CQ notification is one-shot: Since the
>> +		 * current CQE causes user notification,
>> +		 * the CQ gets dis-aremd and must be re-aremd
>> +		 * by the user for a new notification.
>> +		 */
>> +		WRITE_ONCE(cq->notify->flags, SIW_NOTIFY_NOT);
>>  
>>  		return true;
>>  	}
>> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>b/drivers/infiniband/sw/siw/siw_verbs.c
>> index 32dc79d0e898..e7f3a2379d9d 100644
>> --- a/drivers/infiniband/sw/siw/siw_verbs.c
>> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
>> @@ -1049,7 +1049,7 @@ int siw_create_cq(struct ib_cq *base_cq,
>const struct ib_cq_init_attr *attr,
>>  
>>  	spin_lock_init(&cq->lock);
>>  
>> -	cq->notify = &((struct siw_cq_ctrl *)&cq->queue[size])->notify;
>> +	cq->notify = (struct siw_cq_ctrl *)&cq->queue[size];
>>  
>>  	if (udata) {
>>  		struct siw_uresp_create_cq uresp = {};
>> @@ -1141,11 +1141,17 @@ int siw_req_notify_cq(struct ib_cq
>*base_cq, enum ib_cq_notify_flags flags)
>>  	siw_dbg_cq(cq, "flags: 0x%02x\n", flags);
>>  
>>  	if ((flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED)
>> -		/* CQ event for next solicited completion */
>> -		smp_store_mb(*cq->notify, SIW_NOTIFY_SOLICITED);
>> +		/*
>> +		 * Enable CQ event for next solicited completion.
>> +		 * and make it visible to all associated producers.
>> +		 */
>> +		smp_store_mb(cq->notify->flags, SIW_NOTIFY_SOLICITED);
>>  	else
>> -		/* CQ event for any signalled completion */
>> -		smp_store_mb(*cq->notify, SIW_NOTIFY_ALL);
>> +		/*
>> +		 * Enable CQ event for any signalled completion.
>> +		 * and make it visible to all associated producers.
>> +		 */
>> +		smp_store_mb(cq->notify->flags, SIW_NOTIFY_ALL);
>
>this isn't what we talked about, is it?

I actually abandoned the test_and_clear_bit() thing, since it
requires an unsigned long as the bitfield. This would make the
abi-file arch dependent with the hassle of #ifdef 64 or 32 bit
stuff in there.

>
>> index 7de68f1dc707..af735f55b291 100644
>> --- a/include/uapi/rdma/siw-abi.h
>> +++ b/include/uapi/rdma/siw-abi.h
>> @@ -180,6 +180,7 @@ struct siw_cqe {
>>   * to control CQ arming.
>>   */
>>  struct siw_cq_ctrl {
>> -	__aligned_u64 notify;
>> +	__u32 flags;
>> +	__u32 pad;
>
>The commit message needs to explain why this is compatible with
>existing user space, if it is even is safe..
>
Old libsiw would remain compatible with the new layout, since it
simply reads the 32bit 'flags' and zeroed 32bit 'pad' into a 64bit
'notify', ending with reading the same bits.

Thanks
Bernard.

