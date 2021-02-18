Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E58431F244
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Feb 2021 23:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhBRWX2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Feb 2021 17:23:28 -0500
Received: from p3plsmtpa08-06.prod.phx3.secureserver.net ([173.201.193.107]:54048
        "EHLO p3plsmtpa08-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230202AbhBRWXU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Feb 2021 17:23:20 -0500
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id CrgtlGfcJptLUCrgtlt2IQ; Thu, 18 Feb 2021 15:22:31 -0700
X-CMAE-Analysis: v=2.4 cv=KN+fsHJo c=1 sm=1 tr=0 ts=602ee8a7
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=WttkYfkD_ZwrVRebQhwA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: ibv_req_notify_cq clarification
To:     Jason Gunthorpe <jgg@ziepe.ca>, Gal Pressman <galpress@amazon.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
References: <bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
 <20210218125339.GY4718@ziepe.ca>
 <5287c059-3d8c-93f4-6be4-a6da07ccdb8a@amazon.com>
 <20210218162329.GZ4718@ziepe.ca>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <e0153a6f-b9d9-4cb1-a2f2-a7f1865f3719@talpey.com>
Date:   Thu, 18 Feb 2021 17:22:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210218162329.GZ4718@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfC75ad0vWCM6E3NL8nuGWYoraKGnHUhV0zkvtMzzWISiTcu5XzlpX6bqxdc+H7FZk0a6S2n8ELVCygBuPK1Ko/eNfZqVssXyWygpGoczULRVYlSZ3MjO
 c051Y7FCqhCnfuBPpC2xs/6alSSNwKxFueEChAwmZKCXmJ1Ivy2I0UYIlTIZCH4bHwGkyY0juApayVCYFBd2hxh6bF3I1YSRqLS7yShe0Owl/kAdTpGA9977
 RPrM6yTqhyb8EOxvv+u7vg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/18/2021 11:23 AM, Jason Gunthorpe wrote:
> On Thu, Feb 18, 2021 at 05:52:16PM +0200, Gal Pressman wrote:
>> On 18/02/2021 14:53, Jason Gunthorpe wrote:
>>> On Thu, Feb 18, 2021 at 11:13:43AM +0200, Gal Pressman wrote:
>>>> I'm a bit confused about the meaning of the ibv_req_notify_cq() verb:
>>>> "Upon the addition of a new CQ entry (CQE) to cq, a completion event will be
>>>> added to the completion channel associated with the CQ."
>>>>
>>>> What is considered a new CQE in this case?
>>>> The next CQE from the user's perspective, i.e. any new CQE that wasn't consumed
>>>> by the user's poll cq?
>>>> Or any new CQE from the device's perspective?
>>>
>>> new CQE from the device perspective.
>>>
>>>> For example, if at the time of ibv_req_notify_cq() call the CQ has received 100
>>>> completions, but the user hasn't polled his CQ yet, when should he be notified?
>>>> On the 101 completion or immediately (since there are completions waiting on the
>>>> CQ)?
>>>
>>> 101 completion
>>>
>>> It is only meaningful to call it when the CQ is empty.
>>
>> Thanks, so there's an inherent race between the user's CQ poll and the next arm?
> 
> I think the specs or man pages talk about this, the application has to
> observe empty, do arm, then poll again then sleep on the cq if empty.
> 
>> Do you know what's the purpose of the consumer index in the arm doorbell that's
>> implemented by many providers?
> 
> The consumer index is needed by HW to prevent CQ overflow, presumably
> the drivers push to reduce the cases where the HW has to read it from
> PCI

Prevent CQ overflow? There's no such requirement that I'm aware of.
If the consumer doesn't provide a large-enough CQ, then it reaps the
consequences. Same thing for WQ depth, although I am aware that some
verbs implementations attempt to return a kind of EAGAIN when posting
to a send WQ.

What can the provider do if the CQ is "full" anyway? Buffer the CQE
and go into some type of polling loop attempting to redeliver? Ouch!

Tom.
