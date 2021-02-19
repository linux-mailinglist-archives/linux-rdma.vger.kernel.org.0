Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D058D31FAE9
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Feb 2021 15:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhBSOeW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Feb 2021 09:34:22 -0500
Received: from p3plsmtpa08-08.prod.phx3.secureserver.net ([173.201.193.109]:48093
        "EHLO p3plsmtpa08-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230309AbhBSOcM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Feb 2021 09:32:12 -0500
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id D6oTlPvfooQmrD6oTl882w; Fri, 19 Feb 2021 07:31:22 -0700
X-CMAE-Analysis: v=2.4 cv=OPDiYQWB c=1 sm=1 tr=0 ts=602fcbba
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=CmyDqD1aZkL9LioChD8A:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: ibv_req_notify_cq clarification
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Gal Pressman <galpress@amazon.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
 <20210218125339.GY4718@ziepe.ca>
 <5287c059-3d8c-93f4-6be4-a6da07ccdb8a@amazon.com>
 <20210218162329.GZ4718@ziepe.ca>
 <e0153a6f-b9d9-4cb1-a2f2-a7f1865f3719@talpey.com>
 <20210218225131.GB2643399@ziepe.ca>
 <4b38c6fa-0a18-9f32-4dce-af8e3e39cb8e@talpey.com>
 <20210219004555.GC2643399@ziepe.ca>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <b31d6cdc-7304-d2fc-2e56-1f30f86f5dc4@talpey.com>
Date:   Fri, 19 Feb 2021 09:31:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210219004555.GC2643399@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFjf5K8pv7txpxnAA2hPI5yYGT5PhNdKwav7dxThU3LhlpiYARx8EVSS4yS/LyOyvlirt5Cf+i1giYJGWp78z6ZXEnBFb/44e+cI6dAYGuY3Q1ZGiWnJ
 gYGbF8kTlOIbAvkgTrJOLAVmbb0RZOB8O+CDZwVOPoX++o1MkhdeNBct/Dg5F+Ti4khkTchCqb3O+wstLOPphXIu8wrVvcOHY3hXqOBpIQhPW4xxwqQLMN3m
 QBfD6aDwlrT5RJb5qV7kmw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/18/2021 7:45 PM, Jason Gunthorpe wrote:
> On Thu, Feb 18, 2021 at 06:07:13PM -0500, Tom Talpey wrote:
>>>> If the consumer doesn't provide a large-enough CQ, then it reaps the
>>>> consequences. Same thing for WQ depth, although I am aware that some
>>>> verbs implementations attempt to return a kind of EAGAIN when posting
>>>> to a send WQ.
>>>>
>>>> What can the provider do if the CQ is "full" anyway? Buffer the CQE
>>>> and go into some type of polling loop attempting to redeliver? Ouch!
>>>
>>> QP goes to error, CQE is discarded, IIRC.
>>
>> What!? There might be many QP's all sharing the same CQ. Put them
>> *all* into error? And for what, because the CQ is trash anyway. This
>> sounds like optimizing the error case. Uselessly.
> 
> No, only the QPs that need to push a CQE and can't.

Hm. Ok, so QP's will drop unpredictably, and their outstanding WQEs
will probably be lost as well, but I can see cases where a CQ slot
might open up while the failed QP is flushing, and CQE's get delivered
out of order. That might be even worse. It would seem safer to stop
writing to the CQ altogether - all QPs.

>>> Wrapping and overflowing the CQ is not acceptable, it would mean
>>> reading CQEs could never be done reliably.
>>
>> But the provider never reads the CQ, only the consumer can read.
>> The provider writes to head, ignoring tail. Consumer reads from
>> tail, and it goes empty when tail == head. And if head overruns
>> tail, that was the consumer's fault for posting too many WQEs.
> 
> Yes, but if the app makes a mistake you don't want to trash the whole
> system. Resiliency says you contain the failure as much as possible
> and the app at least has some chance to pick up the pieces.
> 
> If the HW corrupts the CQEs while the CPU is reading them then the
> whole machine is toast, high chance the kernel will corrupt memory.

That would be a problem, but it's only true if the provider implements
the CQ as a circular buffer. That isn't imposed by the Verbs. The CQ
itself is opaque to the consumer, it's merely a queue with arm and
dequeue operations - no enqueue, no head/tail or other pointers, etc.

So yeah, a provider that made such a choice will need to be careful.
But there are other, possibly better, ways.

Tom.
