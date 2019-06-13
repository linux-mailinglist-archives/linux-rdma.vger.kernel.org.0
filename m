Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 675F443AC9
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 17:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbfFMPXl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 11:23:41 -0400
Received: from p3plsmtpa09-02.prod.phx3.secureserver.net ([173.201.193.231]:36166
        "EHLO p3plsmtpa09-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731815AbfFMMZA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Jun 2019 08:25:00 -0400
Received: from [192.168.0.56] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id bOmphFUaHKa0JbOmphaSGb; Thu, 13 Jun 2019 05:25:00 -0700
Subject: Re: receive side CRC computation in siw.
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
References: <20bd1d9d-5ca7-abb0-2d66-ea765b03550e@talpey.com>
 <OFBD80408B.8C25683E-ON00258416.0047A63B-00258416.00495B83@notes.na.collabserv.com>
 <a84cd017-fe4c-fecf-6414-db6a3f98c09c@talpey.com>
 <20190612152116.GI3876@ziepe.ca>
 <ea1e140d-f1a7-5d63-8b6e-e99d57264178@talpey.com>
 <20190612201345.GP3876@ziepe.ca>
 <OFD69319F2.02960EC9-ON00258418.003DD0C1-00258418.003FC788@notes.na.collabserv.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <74190aa2-ff6a-67d4-51d1-05fa61442ebc@talpey.com>
Date:   Thu, 13 Jun 2019 08:24:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <OFD69319F2.02960EC9-ON00258418.003DD0C1-00258418.003FC788@notes.na.collabserv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfF0MKsgiB67o+n5surl8cLJHXqdWJcNhXOeU/5YTH7joFBAEaNu8knVUBymHDaZ4DPvWeAnyIHVcSbLqlQvQGMQzlG99p28P7qMr4IScNKKNKB36v/39
 kPUB+7a+nZv4mBIETcy+e7Qdp2/SmCgIGoF5WBfb4YZ0Q45glOIPCRGUIrcqN7cSuyCyzyFM12dtyud00RAqUQLmZjlXiujyGi5zwN8ro0RMb1UVZKsz18nF
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/13/2019 7:36 AM, Bernard Metzler wrote:
> -----"Tom Talpey" <tom@talpey.com> wrote: -----
> 
>> To: "Jason Gunthorpe" <jgg@ziepe.ca>
>> From: "Tom Talpey" <tom@talpey.com>
>> Date: 06/12/2019 10:34PM
>> Cc: "Bernard Metzler" <BMT@zurich.ibm.com>,
>> linux-rdma@vger.kernel.org
>> Subject: [EXTERNAL] Re: receive side CRC computation in siw.
>>
>> On 6/12/2019 4:13 PM, Jason Gunthorpe wrote:
>>> On Wed, Jun 12, 2019 at 04:07:53PM -0400, Tom Talpey wrote:
>>>> On 6/12/2019 11:21 AM, Jason Gunthorpe wrote:
>>>>> On Tue, Jun 11, 2019 at 11:11:08AM -0400, Tom Talpey wrote:
>>>>>> On 6/11/2019 9:21 AM, Bernard Metzler wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> If enabled for siw, during receive operation, a crc32c over
>>>>>>> header and data is being generated and checked. So far, siw
>>>>>>> was generating that CRC from the content of the just written
>>>>>>> target buffer. What kept me busy last weekend were spurious
>>>>>>> CRC errors, if running qperf. I finally found the application
>>>>>>> is constantly writing the target buffer while data are placed
>>>>>>> concurrently, which sometimes races with the CRC computation
>>>>>>> for that buffer, and yields a broken CRC.
>>>>>>
>>>>>> Well, that's a clear bug in the application, assuming siw has
>>>>>> not yet delivered a send completion for the operation using
>>>>>> the buffer. This is a basic Verbs API contract.
>>>>>
>>>>> May be so, but a kernel driver must not make any assumptions
>> about the
>>>>> content of memory controlled by user. So it is clearly wrong to
>> write
>>>>> data to a user buffer and then read it again to compute a CRC.
>>>>
>>>> But it's not a user buffer. It's been mapped into the kernel for
>> the
>>>> purpose of registering and performing data transfer This is
>> standard
>>>> i/o processing. Both kernel and user have access.
>>>
>>> It is a user buffer because the user has access. In fact it may not
>>> even be mapped into the kernel address space.
>>
>> Belaboring this point a bit, but SIW certainly maps it, in order to
>> copy. An adapter maps it, via dma_map, in order to do the same. My
>> point is simply that if the kernel tried to prevent that, the whole
>> i/o model would break down.
>>
>> In other words, if a hardware adapter were doing this same thing,
>> would you consider it out of spec? If so, why?
>>
>> Tom.
>>
>>>> Furthermore, an RDMA hardware adapter has zero notion of user
>> buffers.
>>>> All it gets is a registration, with memory described by dma
>> addresses.
>>>> It can perform whatever memory operations are required on them,
>> and the
>>>> kernel isn't even in the loop.
>>>
>>> Adapters cannot make assumptions about data they place in memory
>>> buffers - ie they cannot write something and then read it back on
>> the
>>> assumption it has not changed. They cannot read something twice on
>> the
>>> assumption it has not changed, etc. It is a security requirement.
>>>
>>>>> All the applications touching buffers without waiting for a
>> completion
>>>>> are relying on some extended behavior outside the specification,
>> but
>>>>> they cannot cause the kernel to malfunction and report bogus data
>>>>> integrity errors.
>>>>
>>>> Ok, this I agree with, but the RDMA specifications were quite
>> careful
>>>> about it. And we *definitely* don't want to require that the
>> providers
>>>> all start double-buffering incoming data, in order to shield an
>>>> uncomplying application from itself. To double buffer RDMA Writes
>> (and
>>>> Sends) would undo the entire direct data placement design!
>>>>
>>>> Bernard, I'd still welcome your thoughts on whether you can
>> compute
>>>> the MPA CRC inline in SIW during the copy_to_user. Avoiding the
>> overhead
>>>> of reading back the data after copying could be a speedup for you?
> 
> It would have to be integrated into skb_copy_bits(). Best
> allowing the caller to provide a variable digets which gets
> updated on the go. So we might propose that to the right people?
> 
> In the mean time, I may have to accept a substantial
> throughput breakdown if the CRC is switched on. For large data
> chunks, perf is close to cut to half, compared to what I had
> before with CRC.
> 
> Interestingly, the penalty mainly comes from walking
> the skb again, and not from touching the data twice:
> If I would provide an intermediate scratch buffer where I
> copy into the skb content first, checksum it, and then
> memcpy it to the target, I would almost maintain current
> perf.
> 
> That obviously contradicts the RDMA concept ;) And it is
> not really nice. At the other hand, since we would need
> only one page size buffer per core (since siw RX runs in
> softirq), it might not be a big waste of memory though...
> What do others think?

I hate the idea of forcing data through a bounce buffer. And I think
that the performance hit will increase in a realworld workload, since
in single-flow tests the CPU cache basically stays warm after your
skb_copy_bits(). Once the processor gets more busy, cache eviction
will change things for the worse - just when you least want it to.

Tom.

> 
> 
>>>
>>> Copy and CRC is obviously the right thing to do.
>>>
>>> Jason
>>>
> I think you mean CRC first and copy then.
> 
> Many thanks for that fruitful discussion.
> Bernard.
> 
> 
> 
