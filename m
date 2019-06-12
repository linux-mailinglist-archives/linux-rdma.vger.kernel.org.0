Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8BFA430CF
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 22:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfFLUHz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 16:07:55 -0400
Received: from p3plsmtpa06-06.prod.phx3.secureserver.net ([173.201.192.107]:55826
        "EHLO p3plsmtpa06-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728064AbfFLUHy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Jun 2019 16:07:54 -0400
Received: from [192.168.0.56] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id b9XFhIaViwmHdb9XFhikVd; Wed, 12 Jun 2019 13:07:54 -0700
Subject: Re: receive side CRC computation in siw.
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>, linux-rdma@vger.kernel.org
References: <OFBD80408B.8C25683E-ON00258416.0047A63B-00258416.00495B83@notes.na.collabserv.com>
 <a84cd017-fe4c-fecf-6414-db6a3f98c09c@talpey.com>
 <20190612152116.GI3876@ziepe.ca>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <ea1e140d-f1a7-5d63-8b6e-e99d57264178@talpey.com>
Date:   Wed, 12 Jun 2019 16:07:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612152116.GI3876@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPSYQWD+v72VBoUHG0W2PK0swAikXoALdjhm9pkcvDiSVFhNiiKwRMtMcDOZt1jMq5kFOSCiti4DiNDRqwWA7PTFPCPJgzMdlbmRrq8zfeBurO8xGGYe
 joGAfX2HnYKIoL5yaeeB+SAdRm0xqKfPtMs1JK5udRSTm21jnbL89W1f+5AubFbg1aY7rsZqYs54N7AvZwtIa/Nng5SiG8Of3O/kFJMktqJCTSYjXknVZbZ5
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/12/2019 11:21 AM, Jason Gunthorpe wrote:
> On Tue, Jun 11, 2019 at 11:11:08AM -0400, Tom Talpey wrote:
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
> 
> May be so, but a kernel driver must not make any assumptions about the
> content of memory controlled by user. So it is clearly wrong to write
> data to a user buffer and then read it again to compute a CRC.

But it's not a user buffer. It's been mapped into the kernel for the
purpose of registering and performing data transfer This is standard
i/o processing. Both kernel and user have access.

Furthermore, an RDMA hardware adapter has zero notion of user buffers.
All it gets is a registration, with memory described by dma addresses.
It can perform whatever memory operations are required on them, and the
kernel isn't even in the loop.


> All the applications touching buffers without waiting for a completion
> are relying on some extended behavior outside the specification, but
> they cannot cause the kernel to malfunction and report bogus data
> integrity errors.

Ok, this I agree with, but the RDMA specifications were quite careful
about it. And we *definitely* don't want to require that the providers
all start double-buffering incoming data, in order to shield an
uncomplying application from itself. To double buffer RDMA Writes (and
Sends) would undo the entire direct data placement design!

Bernard, I'd still welcome your thoughts on whether you can compute
the MPA CRC inline in SIW during the copy_to_user. Avoiding the overhead
of reading back the data after copying could be a speedup for you?

Tom.
