Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23EAC4261C
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 14:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409116AbfFLMky (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 08:40:54 -0400
Received: from p3plsmtpa08-10.prod.phx3.secureserver.net ([173.201.193.111]:54657
        "EHLO p3plsmtpa08-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408385AbfFLMky (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Jun 2019 08:40:54 -0400
Received: from [192.168.0.56] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id b2YehpOvntiP8b2Yeh02RY; Wed, 12 Jun 2019 05:40:53 -0700
Subject: Re: receive side CRC computation in siw.
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org
References: <a84cd017-fe4c-fecf-6414-db6a3f98c09c@talpey.com>
 <OFBD80408B.8C25683E-ON00258416.0047A63B-00258416.00495B83@notes.na.collabserv.com>
 <OF33525C92.4FC26BD4-ON00258417.002E634C-00258417.00323CE4@notes.na.collabserv.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <a44f27d5-bd22-53cb-7c2d-513b3f1b0fd8@talpey.com>
Date:   Wed, 12 Jun 2019 08:40:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <OF33525C92.4FC26BD4-ON00258417.002E634C-00258417.00323CE4@notes.na.collabserv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPl6VAk01RVW82WXCbFEM3/y5AhB/vceEK1FM4TgNZgeHo4iMHDUoRw4dXgM+HUts+o1LTyDuD4Az9+dlmW/u4ovbDSTOJJZTEDTkUxRa+lnVSmgjf7G
 VhhMqR67jgfcLCWXVBRTfzX4ThprJKCXT1lcCmuTkLTm/pb1H7yvNQlanN3IRzKpsNZzNvOiXJd+26iA31E+DLsc7yffxm5O+5k=
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/12/2019 5:08 AM, Bernard Metzler wrote:
> -----"Tom Talpey" <tom@talpey.com> wrote: -----
> 
>> To: "Bernard Metzler" <BMT@zurich.ibm.com>,
>> linux-rdma@vger.kernel.org
>> From: "Tom Talpey" <tom@talpey.com>
>> Date: 06/11/2019 05:11PM
>> Subject: [EXTERNAL] Re: receive side CRC computation in siw.
>>
>> On 6/11/2019 9:21 AM, Bernard Metzler wrote:
>>> Hi all,
>>>
>>> If enabled for siw, during receive operation, a crc32c over
>>> header and data is being generated and checked. So far, siw
>>> was generating that CRC from the content of the just written
>>> target buffer. What kept me busy last weekend were spurious
>>> CRC errors, if running qperf. I finally found the application
>>> is constantly writing the target buffer while data are placed
>>> concurrently, which sometimes races with the CRC computation
>>> for that buffer, and yields a broken CRC.
>>
>> Well, that's a clear bug in the application, assuming siw has
>> not yet delivered a send completion for the operation using
>> the buffer. This is a basic Verbs API contract.
>>
> Well, it is receive side. And it might go non-signaled.

Same rule applies on both source and sink buffers, I mentioned
it later sorry for any ambiguity. When writing the spec we called
these "No peeking" (sink) and "No poking" (source).

Regarding non-signaled that's fine, but a *subsequent* completion
must be obtained. In this case the completion ordering rules
guarantee that earlier WRs have completed.

> The case I looked at was a RDMA Write which got placed
> into a buffer which is concurrently being written by
> the application. Yes, the Verbs API claims adapter's
> ownership for buffers referenced by posted, but not
> yet completed operations. At target side, there is no
> outstanding local operation being completed by an inbound
> WRITE (as a difference to an inbound READ response).
> That's why I am unsure.

Application bug. Semantically it's the same situation as sharing
a buffer between two unsynchronized threads. In this case, one
thread is the RDMA provider (siw, hardware...). When the WR
(a receive WR in this case) is posted, the buffer contents
must be considered as undefined until the provider completes.

>>> siw uses skb_copy_bits() to move the data. I now added an
>>> extra round of skb walking via __skb_checksum() in front of
>>> it, which resolves the issue. Unfortunately, performance
>>> significantly drops with that (some 30% or worse compared
>>> to generating the CRC from a linear buffer).
>>>
>>> To preserve performance for kernel clients, I propose
>>> checksumming the data before the copy only for user
>>> land applications, and leave it as is for kernel clients.
>>> I am not aware of kernel clients which are constantly
>>> reading/writing a target buffer to detect it has been written.
>>
>> This, too, is an invalid application. The RDMA provider is free
>> to write the target buffer at any time. Many implementations
>> take full advantage of this by placing received RDMA Writes
>> in memory prior to validating their packets' checksum(s). If
>> there is a mismatch, retries are initiated. The realtime
>> contents of the buffers, prior to a completion, are undefined.
>>
> Right, placing the data first and checksum those only thereafter
> adds another level of confidence the buffer contains the right
> data. Something a offloaded RDMA engine will typically not do
> though. And as a result, some applications out there (such as
> qperf) assume to have the right to write the buffer anytime.

I disagree that offloaded RDMA engines won't ever do this, and
it's still a fundamentql bug in the application.

> Furthermore, a SW implementation of iWarp, such as siw,
> is not fully integrated with the transport (TCP). While
> MPA detects the CRC error, the segment cannot silently be
> dropped and re-transmitted by the transport, since typically
> already acknowledged to the peer. With that, an invalid CRC
> will cause a connection loss. siw will just send an RDMAP
> TERMINATE frame with error code 'CRC mismatch' as defined
> per spec.

Which is totally fine and totally acceptable. Consider the case
where a large operation has been segmented into multiple messages,
which in turn may be delivered and placed out of order. When the
"bad" segment is detected, some bytes in the receive may have been
placed, later bytes never written, and the connection then breaks.
Since the receive WR never completed successfully, the buffer is
still junk. Which, in fact, it is.

In a datagram-based transport such as RoCE, the individual frames
are NAKed and the requester retransmits them. But the bytes of
the bad frame may well have reached memory - the NIC does not have
to buffer them internally. I think the reason you believe this
doesn't happen is that it's so hard to detect. That doesn't mean
it isn't a valid and compliant behavior.

Net-net, this is either a bug in siw completion logic or in the
application. If you can prove your completions are delivered
properly, you're good.

Tom.

> 
> Thanks,
> Bernard.
> 
>> Tom.
>>
>>> I also checked other kernel code using skb_copy_bits(),
>>> which also needs to checksum the received data. Those code
>>> (such as nvme tcp) also does the CRC on the linear buffer
>>> after data receive.
>>>
>>> The best solution might be to fold the CRC into the
>>> skb_copy_bits() function itself. That being something we
>>> might propose later?
>>>
>>> Thoughts?
>>>
>>>
>>> Many thanks,
>>> Bernard.
>>>
>>>
>>>
>>
>>
> 
> 
> 
