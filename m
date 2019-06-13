Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5E3443EEF
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 17:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbfFMPx6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 13 Jun 2019 11:53:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41074 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbfFMPx5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Jun 2019 11:53:57 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DFrpYW123289
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 11:53:55 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.82])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t3sdq09wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 11:53:52 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 13 Jun 2019 15:52:22 -0000
Received: from us1a3-smtp02.a3.dal06.isc4sb.com (10.106.154.159)
        by smtp.notes.na.collabserv.com (10.106.227.105) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 13 Jun 2019 15:52:19 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp02.a3.dal06.isc4sb.com
          with ESMTP id 2019061315521883-745083 ;
          Thu, 13 Jun 2019 15:52:18 +0000 
In-Reply-To: <74190aa2-ff6a-67d4-51d1-05fa61442ebc@talpey.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Tom Talpey" <tom@talpey.com>
Cc:     "Jason Gunthorpe" <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Date:   Thu, 13 Jun 2019 15:52:18 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <74190aa2-ff6a-67d4-51d1-05fa61442ebc@talpey.com>,<20bd1d9d-5ca7-abb0-2d66-ea765b03550e@talpey.com>
 <OFBD80408B.8C25683E-ON00258416.0047A63B-00258416.00495B83@notes.na.collabserv.com>
 <a84cd017-fe4c-fecf-6414-db6a3f98c09c@talpey.com>
 <20190612152116.GI3876@ziepe.ca>
 <ea1e140d-f1a7-5d63-8b6e-e99d57264178@talpey.com>
 <20190612201345.GP3876@ziepe.ca>
 <OFD69319F2.02960EC9-ON00258418.003DD0C1-00258418.003FC788@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 24551
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19061315-5101-0000-0000-00000FFB066E
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.425523; ST=0; TS=0; UL=0; ISC=; MB=0.378676
X-IBM-SpamModules-Versions: BY=3.00011255; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01217433; UDB=6.00640196; IPR=6.00998545;
 BA=6.00006334; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027295; XFM=3.00000015;
 UTC=2019-06-13 15:52:21
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-06-13 07:59:48 - 6.00010043
x-cbparentid: 19061315-5102-0000-0000-0000722905EE
Message-Id: <OFB20EF091.5D7C2301-ON00258418.0056DA60-00258418.00572FDD@notes.na.collabserv.com>
Subject: Re:  Re: receive side CRC computation in siw.
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Tom Talpey" <tom@talpey.com> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Tom Talpey" <tom@talpey.com>
>Date: 06/13/2019 02:25PM
>Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
>Subject: [EXTERNAL] Re: receive side CRC computation in siw.
>
>On 6/13/2019 7:36 AM, Bernard Metzler wrote:
>> -----"Tom Talpey" <tom@talpey.com> wrote: -----
>> 
>>> To: "Jason Gunthorpe" <jgg@ziepe.ca>
>>> From: "Tom Talpey" <tom@talpey.com>
>>> Date: 06/12/2019 10:34PM
>>> Cc: "Bernard Metzler" <BMT@zurich.ibm.com>,
>>> linux-rdma@vger.kernel.org
>>> Subject: [EXTERNAL] Re: receive side CRC computation in siw.
>>>
>>> On 6/12/2019 4:13 PM, Jason Gunthorpe wrote:
>>>> On Wed, Jun 12, 2019 at 04:07:53PM -0400, Tom Talpey wrote:
>>>>> On 6/12/2019 11:21 AM, Jason Gunthorpe wrote:
>>>>>> On Tue, Jun 11, 2019 at 11:11:08AM -0400, Tom Talpey wrote:
>>>>>>> On 6/11/2019 9:21 AM, Bernard Metzler wrote:
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> If enabled for siw, during receive operation, a crc32c over
>>>>>>>> header and data is being generated and checked. So far, siw
>>>>>>>> was generating that CRC from the content of the just written
>>>>>>>> target buffer. What kept me busy last weekend were spurious
>>>>>>>> CRC errors, if running qperf. I finally found the application
>>>>>>>> is constantly writing the target buffer while data are placed
>>>>>>>> concurrently, which sometimes races with the CRC computation
>>>>>>>> for that buffer, and yields a broken CRC.
>>>>>>>
>>>>>>> Well, that's a clear bug in the application, assuming siw has
>>>>>>> not yet delivered a send completion for the operation using
>>>>>>> the buffer. This is a basic Verbs API contract.
>>>>>>
>>>>>> May be so, but a kernel driver must not make any assumptions
>>> about the
>>>>>> content of memory controlled by user. So it is clearly wrong to
>>> write
>>>>>> data to a user buffer and then read it again to compute a CRC.
>>>>>
>>>>> But it's not a user buffer. It's been mapped into the kernel for
>>> the
>>>>> purpose of registering and performing data transfer This is
>>> standard
>>>>> i/o processing. Both kernel and user have access.
>>>>
>>>> It is a user buffer because the user has access. In fact it may
>not
>>>> even be mapped into the kernel address space.
>>>
>>> Belaboring this point a bit, but SIW certainly maps it, in order
>to
>>> copy. An adapter maps it, via dma_map, in order to do the same. My
>>> point is simply that if the kernel tried to prevent that, the
>whole
>>> i/o model would break down.
>>>
>>> In other words, if a hardware adapter were doing this same thing,
>>> would you consider it out of spec? If so, why?
>>>
>>> Tom.
>>>
>>>>> Furthermore, an RDMA hardware adapter has zero notion of user
>>> buffers.
>>>>> All it gets is a registration, with memory described by dma
>>> addresses.
>>>>> It can perform whatever memory operations are required on them,
>>> and the
>>>>> kernel isn't even in the loop.
>>>>
>>>> Adapters cannot make assumptions about data they place in memory
>>>> buffers - ie they cannot write something and then read it back on
>>> the
>>>> assumption it has not changed. They cannot read something twice
>on
>>> the
>>>> assumption it has not changed, etc. It is a security requirement.
>>>>
>>>>>> All the applications touching buffers without waiting for a
>>> completion
>>>>>> are relying on some extended behavior outside the
>specification,
>>> but
>>>>>> they cannot cause the kernel to malfunction and report bogus
>data
>>>>>> integrity errors.
>>>>>
>>>>> Ok, this I agree with, but the RDMA specifications were quite
>>> careful
>>>>> about it. And we *definitely* don't want to require that the
>>> providers
>>>>> all start double-buffering incoming data, in order to shield an
>>>>> uncomplying application from itself. To double buffer RDMA
>Writes
>>> (and
>>>>> Sends) would undo the entire direct data placement design!
>>>>>
>>>>> Bernard, I'd still welcome your thoughts on whether you can
>>> compute
>>>>> the MPA CRC inline in SIW during the copy_to_user. Avoiding the
>>> overhead
>>>>> of reading back the data after copying could be a speedup for
>you?
>> 
>> It would have to be integrated into skb_copy_bits(). Best
>> allowing the caller to provide a variable digets which gets
>> updated on the go. So we might propose that to the right people?
>> 
>> In the mean time, I may have to accept a substantial
>> throughput breakdown if the CRC is switched on. For large data
>> chunks, perf is close to cut to half, compared to what I had
>> before with CRC.
>> 
>> Interestingly, the penalty mainly comes from walking
>> the skb again, and not from touching the data twice:
>> If I would provide an intermediate scratch buffer where I
>> copy into the skb content first, checksum it, and then
>> memcpy it to the target, I would almost maintain current
>> perf.
>> 
>> That obviously contradicts the RDMA concept ;) And it is
>> not really nice. At the other hand, since we would need
>> only one page size buffer per core (since siw RX runs in
>> softirq), it might not be a big waste of memory though...
>> What do others think?
>
>I hate the idea of forcing data through a bounce buffer. And I think
>that the performance hit will increase in a realworld workload, since
>in single-flow tests the CPU cache basically stays warm after your
>skb_copy_bits(). Once the processor gets more busy, cache eviction
>will change things for the worse - just when you least want it to.
>
>Tom.
>
Right. Sounds ugly. But I am not sure though about the
bad caching effects. It would be a per-CPU buffer, not
per-QP. Only one QP at a time would have access to that
buffer and do skb_copy_bits() into it and memcpy()
out of it back to back. siw rx path runs in softirq and
does not get interrupted by RX of another QP on the same
CPU.

Thanks
Bernard.
>> 
>> 
>>>>
>>>> Copy and CRC is obviously the right thing to do.
>>>>
>>>> Jason
>>>>
>> I think you mean CRC first and copy then.
>> 
>> Many thanks for that fruitful discussion.
>> Bernard.
>> 
>> 
>> 
>
>

