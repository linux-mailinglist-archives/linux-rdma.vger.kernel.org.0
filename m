Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3BD1AA9B0
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 16:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502470AbgDOORJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 15 Apr 2020 10:17:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2636539AbgDOORE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Apr 2020 10:17:04 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03FE4lRr136841
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 10:17:03 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.91])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30dnmsfd3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 10:17:03 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Wed, 15 Apr 2020 14:17:02 -0000
Received: from us1a3-smtp07.a3.dal06.isc4sb.com (10.146.103.14)
        by smtp.notes.na.collabserv.com (10.106.227.143) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 15 Apr 2020 14:16:54 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp07.a3.dal06.isc4sb.com
          with ESMTP id 2020041514165453-501119 ;
          Wed, 15 Apr 2020 14:16:54 +0000 
In-Reply-To: <20200415140910.GN5100@ziepe.ca>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "Xiyu Yang" <xiyuyang19@fudan.edu.cn>,
        "Doug Ledford" <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        kjlu@umn.edu, "Xin Tan" <tanxin.ctf@gmail.com>
Date:   Wed, 15 Apr 2020 14:16:54 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200415140910.GN5100@ziepe.ca>,<1586939949-69856-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP64 March 05, 2020 at 12:58
X-LLNOutbound: False
X-Disclaimed: 5299
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20041514-2475-0000-0000-000002CE4EFB
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.067133
X-IBM-SpamModules-Versions: BY=3.00012915; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000293; SDB=6.01362816; UDB=6.00727642; IPR=6.01145183;
 MB=3.00031713; MTD=3.00000008; XFM=3.00000015; UTC=2020-04-15 14:17:00
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-04-15 14:00:33 - 6.00011245
x-cbparentid: 20041514-2476-0000-0000-0000BE8985D0
Message-Id: <OFF7AE12D1.38AFBC66-ON0025854B.004E30DB-0025854B.004E73A2@notes.na.collabserv.com>
Subject: RE: [PATCH] RDMA/siw: Fix potential siw_mem refcnt leak in nr_add_node
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-15_04:2020-04-14,2020-04-15 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Xiyu Yang" <xiyuyang19@fudan.edu.cn>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 04/15/2020 04:09PM
>Cc: "Bernard Metzler" <bmt@zurich.ibm.com>, "Doug Ledford"
><dledford@redhat.com>, linux-rdma@vger.kernel.org,
>linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
>"Xin Tan" <tanxin.ctf@gmail.com>
>Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Fix potential siw_mem
>refcnt leak in nr_add_node
>
>On Wed, Apr 15, 2020 at 04:39:08PM +0800, Xiyu Yang wrote:
>> siw_fastreg_mr() invokes siw_mem_id2obj(), which returns a local
>> reference of the siw_mem object to "mem" with increased refcnt.
>> When siw_fastreg_mr() returns, "mem" becomes invalid, so the
>refcount
>> should be decreased to keep refcount balanced.
>> 
>> The issue happens in one error path of siw_fastreg_mr(). When
>"base_mr"
>> equals to NULL but "mem" is not NULL, the function forgets to
>decrease
>> the refcnt increased by siw_mem_id2obj() and causes a refcnt leak.
>> 
>> Fix this issue by calling siw_mem_put() on this error path when mem
>is
>> not NULL.
>> 
>> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
>> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
>>  drivers/infiniband/sw/siw/siw_qp_tx.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c
>b/drivers/infiniband/sw/siw/siw_qp_tx.c
>> index ae92c8080967..86044a44b83b 100644
>> +++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
>> @@ -926,6 +926,8 @@ static int siw_fastreg_mr(struct ib_pd *pd,
>struct siw_sqe *sqe)
>>  	siw_dbg_pd(pd, "STag 0x%08x\n", sqe->rkey);
>>  
>>  	if (unlikely(!mem || !base_mr)) {
>> +		if (mem)
>> +			siw_mem_put(mem);
>>  		pr_warn("siw: fastreg: STag 0x%08x unknown\n", sqe->rkey);
>>  		return -EINVAL;
>>  	}
>
>I think I prefer this version, which is what I'll use if nobody has
>concerns:
>
>diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c
>b/drivers/infiniband/sw/siw/siw_qp_tx.c
>index ae92c8080967c5..0580bbf535ceb7 100644
>--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
>+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
>@@ -920,20 +920,28 @@ static int siw_fastreg_mr(struct ib_pd *pd,
>struct siw_sqe *sqe)
> {
> 	struct ib_mr *base_mr = (struct ib_mr *)(uintptr_t)sqe->base_mr;
> 	struct siw_device *sdev = to_siw_dev(pd->device);
>-	struct siw_mem *mem = siw_mem_id2obj(sdev, sqe->rkey  >> 8);
>+	struct siw_mem *mem;
> 	int rv = 0;
> 
> 	siw_dbg_pd(pd, "STag 0x%08x\n", sqe->rkey);
> 
>-	if (unlikely(!mem || !base_mr)) {
>+	if (unlikely(!base_mr)) {
> 		pr_warn("siw: fastreg: STag 0x%08x unknown\n", sqe->rkey);
> 		return -EINVAL;
> 	}
>+
> 	if (unlikely(base_mr->rkey >> 8 != sqe->rkey  >> 8)) {
> 		pr_warn("siw: fastreg: STag 0x%08x: bad MR\n", sqe->rkey);
>+		return -EINVAL;
>+	}
>+
>+	mem = siw_mem_id2obj(sdev, sqe->rkey  >> 8);
>+	if (unlikely(!mem)) {
>+		pr_warn("siw: fastreg: STag 0x%08x unknown\n", sqe->rkey);
> 		rv = -EINVAL;
> 		goto out;
> 	}
>+

Fine with me in principle, but we would have to return
directly here as well - since we do not have a valid mem
to be put back.

Thanks
Bernard.

