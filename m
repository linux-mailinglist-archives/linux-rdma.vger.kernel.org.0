Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1A1EA5A70
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2019 17:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731930AbfIBPWE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 2 Sep 2019 11:22:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729902AbfIBPWE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Sep 2019 11:22:04 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x82FCFg8091140
        for <linux-rdma@vger.kernel.org>; Mon, 2 Sep 2019 11:22:03 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2us45033r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 02 Sep 2019 11:22:03 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 2 Sep 2019 15:22:03 -0000
Received: from us1b3-smtp06.a3dr.sjc01.isc4sb.com (10.122.203.184)
        by smtp.notes.na.collabserv.com (10.122.47.50) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 2 Sep 2019 15:22:01 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp06.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019090215220064-448394 ;
          Mon, 2 Sep 2019 15:22:00 +0000 
In-Reply-To: <MN2PR18MB31826FBE561D7D75CDEFB859A1BE0@MN2PR18MB3182.namprd18.prod.outlook.com>
Subject: Re: RE: [EXT] [RFC] RDMA/siw: Fix xa_mmap helper patch
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Michal Kalderon" <mkalderon@marvell.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Date:   Mon, 2 Sep 2019 15:22:00 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <MN2PR18MB31826FBE561D7D75CDEFB859A1BE0@MN2PR18MB3182.namprd18.prod.outlook.com>,<20190902141854.19822-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-KeepSent: F8D98A6D:4876B5D8-00258469:0054699C;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 1515
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19090215-1059-0000-0000-000000336A5A
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.411265; ST=0; TS=0; UL=0; ISC=; MB=0.000013
X-IBM-SpamModules-Versions: BY=3.00011704; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01255687; UDB=6.00663397; IPR=6.01037347;
 MB=3.00028435; MTD=3.00000008; XFM=3.00000015; UTC=2019-09-02 15:22:03
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-09-02 11:07:02 - 6.00010360
x-cbparentid: 19090215-1060-0000-0000-00000065781D
Message-Id: <OFF8D98A6D.4876B5D8-ON00258469.0054699C-00258469.005469A0@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-02_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Michal Kalderon" <mkalderon@marvell.com> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>,
>"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
>From: "Michal Kalderon" <mkalderon@marvell.com>
>Date: 09/02/2019 04:56PM
>Subject: [EXTERNAL] RE: [EXT] [RFC] RDMA/siw: Fix xa_mmap helper
>patch
>
>> From: Bernard Metzler <bmt@zurich.ibm.com>
>> Sent: Monday, September 2, 2019 5:19 PM
>> External Email
>> 
>>
>---------------------------------------------------------------------
>-
>> - make the siw_user_mmap_entry.address a void *, which
>>   naturally fits with remap_vmalloc_range. also avoids
>>   other casting during resource address assignment.
>> 
>> - do not kfree SQ/RQ/CQ/SRQ in preparation of mmap.
>>   Those resources are always further needed ;)
>> 
>> - Fix check for correct mmap range in siw_mmap().
>>   - entry->length is the object length. We have to
>>     expand to PAGE_ALIGN(entry->length), since mmap
>>     comes with complete page(s) containing the
>>     object.
>>   - put mmap_entry if that check fails. Otherwise
>>     entry object ref counting screws up, and later
>>     crashes during context close.
>> 
>> - simplify siw_mmap_free() - it must just free
>>   the entry.
>Thanks Bernard, I will incorporate this patch into the series, with
>some minor changes
>please see 
>Some comments below
>Do your tests pass with this patch below ? 
>
>- I also added back the places that free the memory no longer freed
>in mmap_free
>And also added checks on the key on places that remove them to be
>closer to original
>Code. I have changed the length to size_t
>
>Will send the v9 later on today. 
>

Sounds good!

The patch I sent worked on top of yours for
me. Even better if you fixed a new memory leak! ;)

Thanks!
Bernard.

>Thanks for your help
>Michal
>
>> ---
>>  drivers/infiniband/sw/siw/siw.h       |  2 +-
>>  drivers/infiniband/sw/siw/siw_verbs.c | 59
>+++++++++------------------
>>  2 files changed, 20 insertions(+), 41 deletions(-)
>> 
>> diff --git a/drivers/infiniband/sw/siw/siw.h
>> b/drivers/infiniband/sw/siw/siw.h index d48cd42ae43e..d62f18f49ac5
>100644
>> --- a/drivers/infiniband/sw/siw/siw.h
>> +++ b/drivers/infiniband/sw/siw/siw.h
>> @@ -505,7 +505,7 @@ struct iwarp_msg_info {
>> 
>>  struct siw_user_mmap_entry {
>>  	struct rdma_user_mmap_entry rdma_entry;
>> -	u64 address;
>> +	void *address;
>>  	u64 length;
>>  };
>> 
>> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>> b/drivers/infiniband/sw/siw/siw_verbs.c
>> index 9e049241051e..24bdf5b508e6 100644
>> --- a/drivers/infiniband/sw/siw/siw_verbs.c
>> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
>> @@ -36,10 +36,7 @@ static char ib_qp_state_to_string[IB_QPS_ERR +
>> 1][sizeof("RESET")] = {
>> 
>>  void siw_mmap_free(struct rdma_user_mmap_entry *rdma_entry)  {
>> -	struct siw_user_mmap_entry *entry =
>> to_siw_mmap_entry(rdma_entry);
>> -
>> -	vfree((void *)entry->address);
>> -	kfree(entry);
>> +	kfree(rdma_entry);
>I think it is better practice to free the entry and not rdma_entry
>for the same reason
>We use container_of and not just cast. 
>>  }
>> 
>>  int siw_mmap(struct ib_ucontext *ctx, struct vm_area_struct *vma)
>@@ -
>> 56,29 +53,28 @@ int siw_mmap(struct ib_ucontext *ctx, struct
>> vm_area_struct *vma)
>>  	 */
>>  	if (vma->vm_start & (PAGE_SIZE - 1)) {
>>  		pr_warn("siw: mmap not page aligned\n");
>> -		goto out;
>> +		return -EINVAL;
>>  	}
>>  	rdma_entry = rdma_user_mmap_entry_get(&uctx->base_ucontext,
>> off,
>>  					      size, vma);
>>  	if (!rdma_entry) {
>>  		siw_dbg(&uctx->sdev->base_dev, "mmap lookup failed: %lu,
>> %u\n",
>>  			off, size);
>> -		goto out;
>> +		return -EINVAL;
>>  	}
>>  	entry = to_siw_mmap_entry(rdma_entry);
>> -	if (entry->length != size) {
>> +	if (PAGE_ALIGN(entry->length) != size) {
>>  		siw_dbg(&uctx->sdev->base_dev,
>>  			"key[%#lx] does not have valid length[%#x]
>> expected[%#llx]\n",
>>  			off, size, entry->length);
>> +		rdma_user_mmap_entry_put(&uctx->base_ucontext,
>> rdma_entry);
>>  		return -EINVAL;
>>  	}
>> -
>> -	rv = remap_vmalloc_range(vma, (void *)entry->address, 0);
>> +	rv = remap_vmalloc_range(vma, entry->address, 0);
>>  	if (rv) {
>>  		pr_warn("remap_vmalloc_range failed: %lu, %u\n", off,
>> size);
>>  		rdma_user_mmap_entry_put(&uctx->base_ucontext,
>> rdma_entry);
>>  	}
>> -out:
>>  	return rv;
>>  }
>> 
>> @@ -270,7 +266,7 @@ void siw_qp_put_ref(struct ib_qp *base_qp)  }
>> 
>>  static int siw_user_mmap_entry_insert(struct ib_ucontext
>*ucontext,
>> -				      u64 address, u64 length,
>> +				      void *address, u64 length,
>>  				      u64 *key)
>>  {
>>  	struct siw_user_mmap_entry *entry = kzalloc(sizeof(*entry),
>> GFP_KERNEL); @@ -461,30 +457,22 @@ struct ib_qp
>*siw_create_qp(struct
>> ib_pd *pd,
>>  		if (qp->sendq) {
>>  			length = num_sqe * sizeof(struct siw_sqe);
>>  			rv = siw_user_mmap_entry_insert(&uctx-
>> >base_ucontext,
>> -							(uintptr_t)qp-
>> >sendq,
>> -							length, &key);
>> -			if (!rv)
>> +							qp->sendq, length,
>> +							&key);
>> +			if (rv)
>>  				goto err_out_xa;
>> 
>> -			/* If entry was inserted successfully, qp->sendq
>> -			 * will be freed by siw_mmap_free
>> -			 */
>> -			qp->sendq = NULL;
>>  			qp->sq_key = key;
>>  		}
>> 
>>  		if (qp->recvq) {
>>  			length = num_rqe * sizeof(struct siw_rqe);
>>  			rv = siw_user_mmap_entry_insert(&uctx-
>> >base_ucontext,
>> -							(uintptr_t)qp->recvq,
>> -							length, &key);
>> -			if (!rv)
>> +							qp->recvq, length,
>> +							&key);
>> +			if (rv)
>>  				goto err_out_mmap_rem;
>> 
>> -			/* If entry was inserted successfully, qp->recvq will
>> -			 * be freed by siw_mmap_free
>> -			 */
>> -			qp->recvq = NULL;
>>  			qp->rq_key = key;
>>  		}
>> 
>> @@ -1078,16 +1066,11 @@ int siw_create_cq(struct ib_cq *base_cq,
>const
>> struct ib_cq_init_attr *attr,
>>  			     sizeof(struct siw_cq_ctrl);
>> 
>>  		rv = siw_user_mmap_entry_insert(&ctx->base_ucontext,
>> -						(uintptr_t)cq->queue,
>> -						length, &cq->cq_key);
>> -		if (!rv)
>> +						cq->queue, length,
>> +						&cq->cq_key);
>> +		if (rv)
>>  			goto err_out;
>> 
>> -		/* If entry was inserted successfully, cq->queue will be freed
>> -		 * by siw_mmap_free
>> -		 */
>> -		cq->queue = NULL;
>> -
>>  		uresp.cq_key = cq->cq_key;
>>  		uresp.cq_id = cq->id;
>>  		uresp.num_cqe = size;
>> @@ -1535,15 +1518,11 @@ int siw_create_srq(struct ib_srq *base_srq,
>>  		u64 length = srq->num_rqe * sizeof(struct siw_rqe);
>> 
>>  		rv = siw_user_mmap_entry_insert(&ctx->base_ucontext,
>> -						(uintptr_t)srq->recvq,
>> -						length, &srq->srq_key);
>> -		if (!rv)
>> +						srq->recvq, length,
>> +						&srq->srq_key);
>> +		if (rv)
>>  			goto err_out;
>> 
>> -		/* If entry was inserted successfully, srq->recvq will be freed
>> -		 * by siw_mmap_free
>> -		 */
>> -		srq->recvq = NULL;
>>  		uresp.srq_key = srq->srq_key;
>>  		uresp.num_rqe = srq->num_rqe;
>> 
>> --
>> 2.17.2
>
>

