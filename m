Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7991C321BAA
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 16:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhBVPiQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 10:38:16 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:49648 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhBVPhT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Feb 2021 10:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1614008235; x=1645544235;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8JGQJVCn4gIw8Z/mSauicdOcSvePxvF7OvKf/igT0Xs=;
  b=mqZtKZ8rp9WTK5IwX/shh3MT5kqer7LPVc2s+Hf1mQj2LqsHJfT1hCR6
   LYnWMl1sD/wRIL+N+W2rgN4NCCSFmx4tXcs+wcmE0E8WVSLIUxOdmOxVE
   xxYr6UgG5v3WmI1rHgQgmAtNY34eCLipPoBlvnidAvBfqmhbbGt3Dedk8
   g=;
X-IronPort-AV: E=Sophos;i="5.81,197,1610409600"; 
   d="scan'208";a="86478123"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 22 Feb 2021 15:36:26 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id 73576A18E4;
        Mon, 22 Feb 2021 15:36:25 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.13) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 22 Feb 2021 15:36:22 +0000
Subject: Re: ibv_req_notify_cq clarification
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>
References: <bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
 <20210218125339.GY4718@ziepe.ca>
 <5287c059-3d8c-93f4-6be4-a6da07ccdb8a@amazon.com>
 <20210218162329.GZ4718@ziepe.ca>
 <51a8fa8c-7529-9ef9-bb52-eccaaef3a666@amazon.com>
 <20210222134642.GG2643399@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <e26a3e90-cc8b-d681-5d6b-4e363aa1933c@amazon.com>
Date:   Mon, 22 Feb 2021 17:36:17 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210222134642.GG2643399@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.13]
X-ClientProxiedBy: EX13D36UWB002.ant.amazon.com (10.43.161.149) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 22/02/2021 15:46, Jason Gunthorpe wrote:
> On Sun, Feb 21, 2021 at 11:25:02AM +0200, Gal Pressman wrote:
>> On 18/02/2021 18:23, Jason Gunthorpe wrote:
>>> On Thu, Feb 18, 2021 at 05:52:16PM +0200, Gal Pressman wrote:
>>>> On 18/02/2021 14:53, Jason Gunthorpe wrote:
>>>>> On Thu, Feb 18, 2021 at 11:13:43AM +0200, Gal Pressman wrote:
>>>>>> I'm a bit confused about the meaning of the ibv_req_notify_cq() verb:
>>>>>> "Upon the addition of a new CQ entry (CQE) to cq, a completion event will be
>>>>>> added to the completion channel associated with the CQ."
>>>>>>
>>>>>> What is considered a new CQE in this case?
>>>>>> The next CQE from the user's perspective, i.e. any new CQE that wasn't consumed
>>>>>> by the user's poll cq?
>>>>>> Or any new CQE from the device's perspective?
>>>>>
>>>>> new CQE from the device perspective.
>>>>>
>>>>>> For example, if at the time of ibv_req_notify_cq() call the CQ has received 100
>>>>>> completions, but the user hasn't polled his CQ yet, when should he be notified?
>>>>>> On the 101 completion or immediately (since there are completions waiting on the
>>>>>> CQ)?
>>>>>
>>>>> 101 completion
>>>>>
>>>>> It is only meaningful to call it when the CQ is empty.
>>>>
>>>> Thanks, so there's an inherent race between the user's CQ poll and the next arm?
>>>
>>> I think the specs or man pages talk about this, the application has to
>>> observe empty, do arm, then poll again then sleep on the cq if empty.
>>>
>>>> Do you know what's the purpose of the consumer index in the arm doorbell that's
>>>> implemented by many providers?
>>>
>>> The consumer index is needed by HW to prevent CQ overflow, presumably
>>> the drivers push to reduce the cases where the HW has to read it from
>>> PCI
>>
>> Thanks, that makes sense.
>>
>> I found the following sentence in CX PRM:
>> "If new CQEs are posted to the CQ after the reporting of a completion event and
>> these CQEs are not yet consumed, then an event will be generated immediately
>> after the request for notification is executed."
>>
>> Doesn't that contradict the expected behavior?
> 
> I read it as confirming it?
> 
> Only *new* CQEs trigger an event, and new CQE's always trigger an
> event regardless of the full/empty state of the queue.
> 
> This paragraph is an obtuse way of warning of the race I described.

Hmm, yea this sentence is a bit confusing :)..

"Mellanox HCAs keep track of the last index for which the user received an
event. Using this index, it is guaranteed that an event is generated immediately
when a request completion notification is performed and a CQE has already been
reported."

This also sounds weird, why is an event generated for a completion that has
already been reported?

So from my understanding of how this should work, the following code in perftest
(ib_send_bw test) is buggy?:
https://github.com/linux-rdma/perftest/blob/master/src/perftest_resources.c#L2955

Running this with 32 iterations, the client does something like:
- arm cq
- post send x 32
- wait for cq event
- arm cq
- poll cq (once, with batch size of 16)
- no more post send (reached tot_iters)
- wait for cq event (but an event has already been generated?)

And gets stuck?
