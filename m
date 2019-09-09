Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3000EAD8F5
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 14:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfIIMZ5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 9 Sep 2019 08:25:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28850 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725937AbfIIMZ5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Sep 2019 08:25:57 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x89COhvq008387
        for <linux-rdma@vger.kernel.org>; Mon, 9 Sep 2019 08:25:55 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.82])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uwma8y6f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 09 Sep 2019 08:25:55 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 9 Sep 2019 12:25:35 -0000
Received: from us1a3-smtp06.a3.dal06.isc4sb.com (10.146.103.243)
        by smtp.notes.na.collabserv.com (10.106.227.105) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 9 Sep 2019 12:25:31 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp06.a3.dal06.isc4sb.com
          with ESMTP id 2019090912253066-428012 ;
          Mon, 9 Sep 2019 12:25:30 +0000 
In-Reply-To: <08C73A86-3362-4F73-8A40-836DA575236F@gmail.com>
Subject: Re: Re: [PATCH] RDMA/siw: Relax from kmap_atomic() use in TX path
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Steve Wise" <larrystevenwise@gmail.com>
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com
Date:   Mon, 9 Sep 2019 12:25:30 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <08C73A86-3362-4F73-8A40-836DA575236F@gmail.com>,<20190906111807.14978-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-LLNOutbound: False
X-Disclaimed: 13791
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19090912-9463-0000-0000-000000C23AB0
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.257046
X-IBM-SpamModules-Versions: BY=3.00011742; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01258902; UDB=6.00665376; IPR=6.01040645;
 MB=3.00028542; MTD=3.00000008; XFM=3.00000015; UTC=2019-09-09 12:25:33
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-09-09 06:38:34 - 6.00010386
x-cbparentid: 19090912-9464-0000-0000-00002879416F
Message-Id: <OF5FD03EF2.56740274-ON00258470.0041D866-00258470.004440AA@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-09_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Steve Wise" <larrystevenwise@gmail.com> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Steve Wise" <larrystevenwise@gmail.com>
>Date: 09/07/2019 12:31AM
>Cc: linux-rdma@vger.kernel.org, dledford@redhat.com
>Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Relax from kmap_atomic()
>use in TX path
>
>Hey Bernard,  is the code below called directly from the driver’s
>post_send function?  If so it must use atomic...I think.
>

Hey Steve,

Only a kernel TX thread executes the TX path. It is not
executed directly from the drivers post_send() method,
which only queues work for TX processing and wakes up
the TX thread if it currently does not run.
The single exception is TX processing
out of a user space application context, if no TX
thread is currently running, but only for a small
burst. In any case, all TX processing is done out of
a non-atomic context.

Best,
Bernard.

>Stevo
>
>> On Sep 6, 2019, at 6:18 AM, Bernard Metzler <bmt@zurich.ibm.com>
>wrote:
>> 
>> Since the transmit path is never executed in an atomic
>> context, we do not need kmap_atomic() and can always
>> use less demanding kmap().
>> 
>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> ---
>> drivers/infiniband/sw/siw/siw_qp_tx.c | 12 +++++-------
>> 1 file changed, 5 insertions(+), 7 deletions(-)
>> 
>> diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c
>b/drivers/infiniband/sw/siw/siw_qp_tx.c
>> index 8e72f955921d..5d97bba0ce6d 100644
>> --- a/drivers/infiniband/sw/siw/siw_qp_tx.c
>> +++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
>> @@ -76,16 +76,15 @@ static int siw_try_1seg(struct siw_iwarp_tx
>*c_tx, void *paddr)
>>            if (unlikely(!p))
>>                return -EFAULT;
>> 
>> -            buffer = kmap_atomic(p);
>> +            buffer = kmap(p);
>> 
>>            if (likely(PAGE_SIZE - off >= bytes)) {
>>                memcpy(paddr, buffer + off, bytes);
>> -                kunmap_atomic(buffer);
>>            } else {
>>                unsigned long part = bytes - (PAGE_SIZE - off);
>> 
>>                memcpy(paddr, buffer + off, part);
>> -                kunmap_atomic(buffer);
>> +                kunmap(p);
>> 
>>                if (!mem->is_pbl)
>>                    p = siw_get_upage(mem->umem,
>> @@ -97,11 +96,10 @@ static int siw_try_1seg(struct siw_iwarp_tx
>*c_tx, void *paddr)
>>                if (unlikely(!p))
>>                    return -EFAULT;
>> 
>> -                buffer = kmap_atomic(p);
>> -                memcpy(paddr + part, buffer,
>> -                       bytes - part);
>> -                kunmap_atomic(buffer);
>> +                buffer = kmap(p);
>> +                memcpy(paddr + part, buffer, bytes - part);
>>            }
>> +            kunmap(p);
>>        }
>>    }
>>    return (int)bytes;
>> -- 
>> 2.17.2
>> 
>
>

