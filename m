Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D960E322A6F
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Feb 2021 13:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhBWMYM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Feb 2021 07:24:12 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:31723 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbhBWMYL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Feb 2021 07:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1614083051; x=1645619051;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=K7xCjKIhCGbhcAGA7PiD+PRgRJWGh0zE4KlXOet09kY=;
  b=ZYitz0IGQ8KCJjew/S2FRMH4YQzlZzo+dWj1Hk+DiaoeyuwnvDCsHDD5
   PILLbcJNVWzjSLc9uQFnpBOwiPganfmgfxxAgGrGxAflh+f7H5BtqPQiF
   BdR/e3/lPmPUsIKR1BitAy0YqRIsGCitE7a3b/QkNLAMZjbdke9U2l5lK
   0=;
X-IronPort-AV: E=Sophos;i="5.81,200,1610409600"; 
   d="scan'208";a="89691279"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 23 Feb 2021 12:23:23 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id 37402A0464;
        Tue, 23 Feb 2021 12:23:22 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.131) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Feb 2021 12:23:18 +0000
Subject: Re: ibv_req_notify_cq clarification
To:     "Hefty, Sean" <sean.hefty@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>
References: <bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
 <20210218125339.GY4718@ziepe.ca>
 <5287c059-3d8c-93f4-6be4-a6da07ccdb8a@amazon.com>
 <20210218162329.GZ4718@ziepe.ca>
 <51a8fa8c-7529-9ef9-bb52-eccaaef3a666@amazon.com>
 <20210222134642.GG2643399@ziepe.ca>
 <e26a3e90-cc8b-d681-5d6b-4e363aa1933c@amazon.com>
 <20210222155559.GH2643399@ziepe.ca>
 <8277bebb-8994-af0f-52fc-972c7f8260dd@amazon.com>
 <MW3PR11MB46519518F772EAFA758C45229E819@MW3PR11MB4651.namprd11.prod.outlook.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <47a7c3a3-ebe1-7fa1-b47e-650ad4d6e736@amazon.com>
Date:   Tue, 23 Feb 2021 14:23:13 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <MW3PR11MB46519518F772EAFA758C45229E819@MW3PR11MB4651.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.131]
X-ClientProxiedBy: EX13D16UWC002.ant.amazon.com (10.43.162.161) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 23/02/2021 0:41, Hefty, Sean wrote:
>>> It eliminates races, if the consumer says 'I read up to X send me an
>>> interrupt if X+1 exists' when X+1 already exists if there is a race
>>> producer has already written it. So send an interrupt.
>>
>> Right, that's what I was getting at in my first question, this isn't the next
>> completion from the device's perspective.
> 
> From the spec:
> 
> Requests the CQ event handler be called when the next completion
> entry of the specified type is added to the specified CQ. The handler
> is called at most once per Request Completion Notification call for a
> particular CQ. Any CQ entries that existed before the notify is enabled
> will not result in a call to the handler.
> 
> It may help to think of it in terms of edge versus level triggered.  The IB spec defines the CQ as behaving similar to an edge triggered object.  I would guess that 99% of developers would successfully write an edge-triggered based application that hangs.  A level triggered wait is much easier to get correct.

Agree, but a level triggered wait contradicts the
"Any CQ entries that existed before the notify is enabled will not result in a
call to the handler."

>> So in such case the consumer index in the arm doorbell is used to indicate what
>> should be considered a "new" completion? This is new from the app perspective.
> 
> The verbs API only guarantees that the CQ will be signaled when a new completion relative to the HW has been written.  If there's a driver that converts the behavior into a level triggered operation, props to them!  That implementation is far more likely to make incorrectly written applications work than ever break a correctly written one.

I agree that this behavior is most likely better, but it contradicts the api
agreement.
It seems like you should write your app according to the provider you're using
in order to get it right.

>> But looking at ibv_ud_pingpong for example, I don't understand how that could
>> even work.
>> The test arms the CQ on creation (consumder index 0), calls ibv_get_cq_event(),
>> wakes up and immediately arms the CQ again (before polling, consumer index is
>> still 0).
> 
> In the worst case, arming the CQ just results in select/poll/epoll returning immediately the next time it is called.  The thread finds the CQ empty, rearms the CQ again, and select/poll/epoll finally block.
> 
>>>> Running this with 32 iterations, the client does something like:
>>>> - arm cq
>>>> - post send x 32
>>>> - wait for cq event
>>>> - arm cq
>>>> - poll cq (once, with batch size of 16)
>>>> - no more post send (reached tot_iters)
>>>> - wait for cq event (but an event has already been generated?)
>>>
>>> I don't know much about perf-test, but in verbs arming a non-empty CQ
>>> is asking for trouble
>>
>> Do you have a way to verify whether this test gets stuck? Maybe I am missing
>> something?
> 
> Looking at the code, I agree that it looks racy in a way that could cause it to hang.  My guess is most people running perftests are looking for the best performance numbers, so blocking completions are rarely enabled.  And even if they were, it's still a race condition as to whether the test would hang.
> 
>> What do you mean by arming a non-empty CQ?
>> The man pages suggest a scheme where the app should call ibv_get_cq_event()
>> followed by an ibv_req_notify_cq(), the CQ polling/emptying comes after these,
>> so at the time of arm the CQ isn't empty.
> 
> The app can do:
> 
> Wakeup
> While read cqe succeeds
> 	Process cqe
> Read cq event
> Arm cq
> /* cqe's may have been written between the last read and arming */
> While read cqe succeeds
> 	Process cqe
> Sleep
> 
> Or shorten this to:
> 
> Wakeup
> Read cq event
> Arm cq
> While read cqe succeeds
> 	Process cqe
> Sleep
> 
> In both cases, all cqe's must be processed after calling arm, and it's possible to read a cq event only to find the cq empty.  One could argue which is more efficient, but we're talking about a sleeping thread in either case.

Yea, this seems correct.
But as I said in my reply to Jason, libibverbs examples, pyverbs tests and
perftest all go from "Read cq event" to "Arm cq" immediately.
