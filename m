Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECA5AE531
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2019 10:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbfIJIN5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 10 Sep 2019 04:13:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18264 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730510AbfIJIN5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Sep 2019 04:13:57 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8A87lMT038912
        for <linux-rdma@vger.kernel.org>; Tue, 10 Sep 2019 04:13:56 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.114])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ux5xxc88q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 10 Sep 2019 04:13:56 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 10 Sep 2019 08:13:55 -0000
Received: from us1b3-smtp07.a3dr.sjc01.isc4sb.com (10.122.203.198)
        by smtp.notes.na.collabserv.com (10.122.47.58) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 10 Sep 2019 08:13:51 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp07.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019091008135070-171275 ;
          Tue, 10 Sep 2019 08:13:50 +0000 
In-Reply-To: <20190909145427.GA12481@chelsio.com>
Subject: Re: Re: [PATCH v1 rdma-next] RDMA/siw: Relax from kmap_atomic() use in TX
 path
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Potnuri Bharat Teja" <bharat@chelsio.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Date:   Tue, 10 Sep 2019 08:13:50 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190909145427.GA12481@chelsio.com>,<20190909132945.30462-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-KeepSent: 267682A2:3B1DCDA4-00258471:002C498E;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 34295
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19091008-1639-0000-0000-0000005A4EAF
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.000399
X-IBM-SpamModules-Versions: BY=3.00011747; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01259286; UDB=6.00665614; IPR=6.01041041;
 MB=3.00028558; MTD=3.00000008; XFM=3.00000015; UTC=2019-09-10 08:13:53
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-09-10 03:41:26 - 6.00010389
x-cbparentid: 19091008-1640-0000-0000-0000008F7B77
Message-Id: <OF267682A2.3B1DCDA4-ON00258471.002C498E-00258471.002D3682@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-10_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Potnuri Bharat Teja" <bharat@chelsio.com> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Potnuri Bharat Teja" <bharat@chelsio.com>
>Date: 09/09/2019 04:54PM
>Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
>"dledford@redhat.com" <dledford@redhat.com>
>Subject: [EXTERNAL] Re: [PATCH v1 rdma-next] RDMA/siw: Relax from
>kmap_atomic() use in TX path
>
>On Monday, September 09/09/19, 2019 at 18:59:45 +0530, Bernard
>Metzler wrote:
>> Since the transmit path is never executed in an atomic
>> context, we do not need kmap_atomic() and can always
>> use less demanding kmap().
>> 
>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> ---
>>  drivers/infiniband/sw/siw/siw_qp_tx.c | 12 +++++-------
>>  1 file changed, 5 insertions(+), 7 deletions(-)
>> 
>> diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c
>b/drivers/infiniband/sw/siw/siw_qp_tx.c
>> index 8e72f955921d..5d97bba0ce6d 100644
>> --- a/drivers/infiniband/sw/siw/siw_qp_tx.c
>> +++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
>> @@ -76,16 +76,15 @@ static int siw_try_1seg(struct siw_iwarp_tx
>*c_tx, void *paddr)
>>  			if (unlikely(!p))
>>  				return -EFAULT;
>>  
>> -			buffer = kmap_atomic(p);
>> +			buffer = kmap(p);
>>  
>>  			if (likely(PAGE_SIZE - off >= bytes)) {
>>  				memcpy(paddr, buffer + off, bytes);
>> -				kunmap_atomic(buffer);
>missing kunmap()

No it's not missing. we are in the if-path,
and we unmap 'p' at the next line (skipping
the else-path).

>>  			} else {
>>  				unsigned long part = bytes - (PAGE_SIZE - off);
>>  
>>  				memcpy(paddr, buffer + off, part);
>> -				kunmap_atomic(buffer);
>> +				kunmap(p);
>kunmap(buffer)
>>  
>>  				if (!mem->is_pbl)
>>  					p = siw_get_upage(mem->umem,
>> @@ -97,11 +96,10 @@ static int siw_try_1seg(struct siw_iwarp_tx
>*c_tx, void *paddr)
>>  				if (unlikely(!p))
>>  					return -EFAULT;
>>  
>> -				buffer = kmap_atomic(p);
>> -				memcpy(paddr + part, buffer,
>> -				       bytes - part);
>> -				kunmap_atomic(buffer);
>> +				buffer = kmap(p);
>> +				memcpy(paddr + part, buffer, bytes - part);
>>  			}
>> +			kunmap(p);
>Can this be out of if()? the buffers seem to be different.

the page pointer gets reassigned since the data
span two pages. so we unmap the first page after
copying out of it what we need, get the second
page into 'p', and map it. at the end, the current
page p gets unmapped. if we do not have data spanning
two pages, we unmap the first page. If we do have,
we unmap the second page.

It should be all good.

Thanks & best regards,
Bernard.
>>  		}
>>  	}
>>  	return (int)bytes;
>> -- 
>> 2.17.2
>> 
>
>

