Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D99351D00
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 20:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbhDASXQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 14:23:16 -0400
Received: from p3plsmtpa06-10.prod.phx3.secureserver.net ([173.201.192.111]:41435
        "EHLO p3plsmtpa06-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239675AbhDASQq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Apr 2021 14:16:46 -0400
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id RyPQlBo7yyIwVRyPQljIg7; Thu, 01 Apr 2021 07:34:57 -0700
X-CMAE-Analysis: v=2.4 cv=NP4QR22g c=1 sm=1 tr=0 ts=6065da11
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=fgEhGd6aAAAA:8 a=5rLDPRsCQH2WcQzlyhYA:9 a=QEXdDO2ut3YA:10
 a=lTNmK5dgYt2SiR4ZQSdr:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: QP reset question
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <dec67c77-5870-12a9-3308-dd24ffbcfa8b@gmail.com>
 <6ac535d3-ce08-7e00-721e-63529d81c85d@talpey.com>
 <5ad738e9-a2cc-4fce-2279-76793afb0502@gmail.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <7cbe89a8-ed9e-c83c-9856-e709d6c161c7@talpey.com>
Date:   Thu, 1 Apr 2021 10:34:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <5ad738e9-a2cc-4fce-2279-76793afb0502@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMK5PKiPRo+uDjlgzowkuv+xcSGhYYSr0nWvTzn39WxY1zRCQLUND+T3i9tM25buviJ7AzCYvMCMmIywUtw2CyKlXutAmoYHxxGYs26kokFTtuXgqzpk
 AHVA8Q5dayWP7qUSOADNayZ+LPTHavs+EGqsu8c9ErTNG5/fYTgsZSVTpVECZbw02bJQzI/h4+unlCiaD0H1mBxL4AKml1sWC45W6UAKB6bfqmiUVZrr2zjq
 CcqNDn/QoDwF5f6I+LeZVg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/31/2021 10:18 PM, Bob Pearson wrote:
> On 3/31/21 1:23 PM, Tom Talpey wrote:
>> On 3/30/2021 5:01 PM, Bob Pearson wrote:
>>> Jason,
>>>
>>> Somewhere in Dotan's blog I saw him say that if you put a QP in the reset state that it
>>> - clears the SQ and RQ (if not SRQ) *AND*
>>> - also clears the completion queues
>>
>> I don't think that second bullet is correct, as you point out the
>> CQ may hold other entries, not from this QP.
>>
>> The volume 1 spec does say this around QP destroy in section 10.2.4.4:
>>
>>>> It is good programming practice to modify the QP into the Error
>>>> state and retrieve the relevant CQEs prior to destroying the QP.
>>>> Destroying a QP does not guarantee that CQEs of that QP are
>>>> deallocated from the CQ upon destruction. Even if the CQEs are
>>>> already on the CQ, it might not be possible to retrieve them. It is
>>>> good programming practice not to make any assumption on the number
>>>> of CQEs in the CQ when destroying a QP. In order to avoid CQ
>>>> overflow, it is recommended that all CQEs of the de-stroyed QP are
>>>> retrieved from the CQ associated with it before resizing the CQ,
>>>> attaching a new QP to the CQ or reopening the QP, if the CQ
>>>> ca-pacity is limited.
>>
>> There's additional supporting text in 10.3.1 around this. The
>> QP is always transitioned to Error, then CQEs drained, then QP
>> to Reset.
> 
> In https://www.rdmamojo.com/2012/05/05/qp-state-machine/ it says
> Reset state
> Description
> 
> A QP is being created in the Reset state. In this state, all the needed resources of the QP are already allocated.
> 
> In order to reuse a QP, it can be transitioned to Reset state from any state by calling to ibv_modify_qp(). If prior to this state transition, there were any Work Requests or completions in the send or receive queues of that QP, they will be cleared from the queues.

It's too bad he's not here to discuss, but I assert the text is wrong.
Completions are never present on work queues, so it's a contradiction.

I believe that some implementations, including the Mellanox one when
this text was written, basically "promote" a WR to become a CQE as
it moves from work to completion. But that is an implementation
choice. The spec is explicit in separating them, as it should.

Also, as we've pointed out, completion queues are not 1:1 with
send and receive queues. They are commonly shared. Erasing
entries from them is disastrous to the other QPs.

Finally, the state diagram in section 10.3.1 disagrees with the
assertion that a QP can transition to RESET from "any state".
The diagram is explicit in allowing only ERROR->RESET.

> Not that he is the final arbiter but it turns out that CX NICs pass these test cases AFAIK. So I am suspicious that
> someone is clearing out the CQs somehow. In fact I just found in mlx5: qp.c
> 
> if (new_state == IB_QPS_RESET && .... ) {
> 	mlx5_ib_cq_clean(recv_cq, ....)
> 	mlx5_ib_cq_clean(send_cq, ....)
> }
> 
> which seems to be the culprit.

Not the culprit, the instigator! This is a bug.

> So in order to be compatible with CX NICs it looks like I need to do the same thing for rxe.

I think the IB spec should be the reference, and it doesn't support
such a choice.

