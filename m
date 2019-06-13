Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E84343B45
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 17:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfFMP1i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 11:27:38 -0400
Received: from p3plsmtpa11-05.prod.phx3.secureserver.net ([68.178.252.106]:46138
        "EHLO p3plsmtpa11-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729026AbfFMLfc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Jun 2019 07:35:32 -0400
Received: from [192.168.0.56] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id bO0xhIm2Z7f7HbO0xh8WxE; Thu, 13 Jun 2019 04:35:31 -0700
Subject: Re: receive side CRC computation in siw.
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>, linux-rdma@vger.kernel.org
References: <OFBD80408B.8C25683E-ON00258416.0047A63B-00258416.00495B83@notes.na.collabserv.com>
 <a84cd017-fe4c-fecf-6414-db6a3f98c09c@talpey.com>
 <20190612152116.GI3876@ziepe.ca>
 <ea1e140d-f1a7-5d63-8b6e-e99d57264178@talpey.com>
 <20190612201345.GP3876@ziepe.ca>
 <20bd1d9d-5ca7-abb0-2d66-ea765b03550e@talpey.com>
 <20190612205917.GQ3876@ziepe.ca>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <ca2b4441-f98f-46f8-a8e8-37013205dc0b@talpey.com>
Date:   Thu, 13 Jun 2019 07:35:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612205917.GQ3876@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPcAQ1fT8KmKrZF5CLNhIf/989fg33DP+iykczobpHSsl0jreov7wlXroGUHfUr/MJuazZB9WBTYNzAMzy9j0aet1lIZvDf+bL34h9NJIatWa1O+ZHdN
 N7idma2B4ytkbKvpOxdBnO5JoqLZJm998INxR4xdP+jGEiMN1R5s4447L3wyGuS5rP9+FrFq+GOh+YAS6v5S6+SMB+GXZoLP07/61fkX6k0nAEFBce87q55m
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/12/2019 4:59 PM, Jason Gunthorpe wrote:
> On Wed, Jun 12, 2019 at 04:34:21PM -0400, Tom Talpey wrote:
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
>>>>> May be so, but a kernel driver must not make any assumptions about the
>>>>> content of memory controlled by user. So it is clearly wrong to write
>>>>> data to a user buffer and then read it again to compute a CRC.
>>>>
>>>> But it's not a user buffer. It's been mapped into the kernel for the
>>>> purpose of registering and performing data transfer This is standard
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
> 
> Yes.
> 
> HW placing/reading data in user controlled memory and requiring it not
> to change dynamically is a security flaw.

By that measure, SIW is better than hardware providers since it
doesn't expose CQs and doorbells!

> It may not be expressly specified as part of the IBA, but it is
> certainly wrong from a system design perspective.

I disagree, because the RDMA design specifically addresses this by
exposing only objects which are connection-specific. Meaning, the
application can only harm its own RDMA state, and cannot impact
other connections or the RNIC itself.

In this case, the application's misbehavior is impacting its own
receive queue, and causing the provider to disconnect. I don't see
how this is a security issue. With a properly coded provider, it is
not a vulnerbility in any way. And I repeat the assertion that the
RDMA paradigm considers it.

Tom.
