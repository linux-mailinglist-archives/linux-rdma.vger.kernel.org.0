Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20ECB8310E
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2019 13:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfHFL6t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 6 Aug 2019 07:58:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726092AbfHFL6s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Aug 2019 07:58:48 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x76Bwb01083237
        for <linux-rdma@vger.kernel.org>; Tue, 6 Aug 2019 07:58:47 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u763cf9km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 06 Aug 2019 07:58:47 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 6 Aug 2019 11:58:46 -0000
Received: from us1a3-smtp02.a3.dal06.isc4sb.com (10.106.154.159)
        by smtp.notes.na.collabserv.com (10.106.227.158) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 6 Aug 2019 11:58:41 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp02.a3.dal06.isc4sb.com
          with ESMTP id 2019080611583995-450817 ;
          Tue, 6 Aug 2019 11:58:39 +0000 
In-Reply-To: <20190805170903.GO4832@mtr-leonro.mtl.com>
Subject: Re: Re: [PATCH 1/1] Make user mmapped CQ arming flags field 32 bit size to
 remove 64 bit architecture dependency of siw.
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, jgg@ziepe.ca
Date:   Tue, 6 Aug 2019 11:58:40 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190805170903.GO4832@mtr-leonro.mtl.com>,<20190805141708.9004-1-bmt@zurich.ibm.com>
 <20190805141708.9004-2-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 1131
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19080611-1335-0000-0000-000000E944F1
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.388783; ST=0; TS=0; UL=0; ISC=; MB=0.085847
X-IBM-SpamModules-Versions: BY=3.00011559; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01242881; UDB=6.00655607; IPR=6.01024345;
 MB=3.00028064; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-06 11:58:44
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-06 08:08:16 - 6.00010253
x-cbparentid: 19080611-1336-0000-0000-000001C64903
Message-Id: <OF52404FA1.272BB250-ON0025844E.0040F116-0025844E.0041CBE0@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-06_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 08/05/2019 07:09PM
>Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca
>Subject: [EXTERNAL] Re: [PATCH 1/1] Make user mmapped CQ arming flags
>field 32 bit size to remove 64 bit architecture dependency of siw.
>
>On Mon, Aug 05, 2019 at 04:17:08PM +0200, Bernard Metzler wrote:
>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> ---
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
>>
>>  	if (flags & IB_CQ_REPORT_MISSED_EVENTS)
>>  		return cq->cq_put - cq->cq_get;
>> diff --git a/include/uapi/rdma/siw-abi.h
>b/include/uapi/rdma/siw-abi.h
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
>You can't do it, it will break backward compatibility with rdma-core.
>https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_linux
>-2Drdma_rdma-2Dcore_blob_2066065574554229f5e4ef1a37abf637938b71e3_pro
>viders_siw_siw.c-23L175&d=DwIBAg&c=jf_iaSHvJObTbx-siA1ZOg&r=2TaYXQ0T-
>r8ZO1PP1alNwU_QJcRRLfmYTAgd3QCvqSc&m=7tPE1DK3hqqKmVY0xAMOdRXzQJYsxDwj
>RVAlCUxMcVo&s=kdWgjm1Qah8ux50emKGomnnwyScBHDivqUSyVkjnNbw&e= 
>

We would still mmap the 64bits of a notifications
field of the CQ, which is now (see siw-abi.h):

struct siw_cq_ctrl {
        __u32 flags;
        __u32 pad;
};

I changed the variable name to 'flags' though, which shall improve
readability. The only change in siw user lib would be as below.
Would that be acceptable?

Many thanks!
Bernard.

From 2456a7fb4bb4c55a34087b40486a30c06a67654e Mon Sep 17 00:00:00 2001
From: Bernard Metzler <bmt@zurich.ibm.com>
Date: Tue, 6 Aug 2019 13:48:42 +0200
Subject: [PATCH] Change user mmapped siw CQ notifications flags to 32bit.

Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 providers/siw/siw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/providers/siw/siw.c b/providers/siw/siw.c
index c1acf398..b4b491b4 100644
--- a/providers/siw/siw.c
+++ b/providers/siw/siw.c
@@ -173,7 +173,7 @@ static struct ibv_cq *siw_create_cq(struct ibv_context *ctx, int num_cqe,
 		goto fail;
 	}
 	cq->ctrl = (struct siw_cq_ctrl *)&cq->queue[cq->num_cqe];
-	cq->ctrl->notify = SIW_NOTIFY_NOT;
+	cq->ctrl->flags = SIW_NOTIFY_NOT;
 
 	return &cq->base_cq;
 fail:
@@ -482,7 +482,7 @@ static void siw_async_event(struct ibv_context *ctx,
 static int siw_notify_cq(struct ibv_cq *ibcq, int solicited)
 {
 	struct siw_cq *cq = cq_base2siw(ibcq);
-	atomic_ulong *notifyp = (atomic_ulong *)&cq->ctrl->notify;
+	atomic_uint *notifyp = (atomic_uint *)&cq->ctrl->flags;
 	int rv = 0;
 
 	if (solicited)
-- 
2.17.2



>Thanks
>
>>  };
>>  #endif
>> --
>> 2.17.2
>>
>
>

