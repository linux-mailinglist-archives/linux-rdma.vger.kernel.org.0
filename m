Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD32322A6A
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Feb 2021 13:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhBWMTb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Feb 2021 07:19:31 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:61247 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhBWMT3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Feb 2021 07:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1614082767; x=1645618767;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=NJNEHlo/5zghuR2jV3MEDG4VQ1wre4aCNf2wTe2McFo=;
  b=jCemgg8rDh/TfKxoTfokplJakpYV4v1ZHw2IvQaDdC4D6xyGQtnK+sHP
   uVT+IM3Av2n0ByxcjDCzH9jLFk9dqs/UAErnDHauS8Uny0O2WQdNkbShO
   DBWC0r1APAuSYhFh/QR4doJEyQ/308J/HJGpfay/tWh8l1HAJN7DnnSkq
   4=;
X-IronPort-AV: E=Sophos;i="5.81,200,1610409600"; 
   d="scan'208";a="91134682"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 23 Feb 2021 12:18:40 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id 0729BA1FBE;
        Tue, 23 Feb 2021 12:18:39 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.239) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Feb 2021 12:18:36 +0000
Subject: Re: ibv_req_notify_cq clarification
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
 <20210222193746.GM2643399@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <2fa24ddf-1add-a306-003d-0737b2b9cbba@amazon.com>
Date:   Tue, 23 Feb 2021 14:18:31 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210222193746.GM2643399@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.239]
X-ClientProxiedBy: EX13D02UWC002.ant.amazon.com (10.43.162.6) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 22/02/2021 21:37, Jason Gunthorpe wrote:
> On Mon, Feb 22, 2021 at 09:24:18PM +0200, Gal Pressman wrote:
>> On 22/02/2021 17:55, Jason Gunthorpe wrote:
>>> On Mon, Feb 22, 2021 at 05:36:17PM +0200, Gal Pressman wrote:
>>>
>>>> "Mellanox HCAs keep track of the last index for which the user received an
>>>> event. Using this index, it is guaranteed that an event is generated immediately
>>>> when a request completion notification is performed and a CQE has already been
>>>> reported."
>>>
>>> I don't think verbs exposes this behavior.
>>
>> So in theory this hardware could generate events that the user app
>> doesn't expect?
> 
> Not really, it shuffles around how race conditions are resolved.
> 
>> But looking at ibv_ud_pingpong for example, I don't understand how
>> that could even work.  The test arms the CQ on creation (consumder
>> index 0), calls ibv_get_cq_event(), wakes up and immediately arms
>> the CQ again (before polling, consumer index is still 0).
> 
> By IBTA spec this is wrong and racey.

Where does it say that?

>> This means that the next ibv_get_cq_event() will wake up immediately, as the CQ
>> was armed twice with the same consumer index and the first completion already
>> exists. Surely that's not what's meant to happen?
> 
> If the driver for this HW stuffs the consumer index then yes, you'd
> get a wakeup as though the new entries were delivered instantly after
> the arm. If it stuffs the current producer index then you get behavior
> like IBTA describes.
> 
> I'd say they are both compatible ways to approach this, the app can't
> tell the state of the CQ, so it can't know if the new CQEs were
> delievered before or after it ARM'd it.

That's not accurate though.
A simple ping app that sends one packet at a time knows the CQ state when it
arms it. The CQ event is for that single sent packet, and the arm should notify
about the next packet it's about to send.

In this case, notifying twice for the same completion is not compatible with the
spec - there are no races in this case.

>> Do you have a way to verify whether this test gets stuck? Maybe I am
>> missing something?
> 
> If the mlx5 implementation is doing like you say then it will not get
> stuck on that HW, but it is not to spec
> 
>> What do you mean by arming a non-empty CQ?
> 
> The arm only has meaning if you know the CQ is empty because then you
> can reliably catch the empty->!empty transition, which is the whole
> point.

Well, you never really know the CQ is empty though. A completion can always
arrive just after you finish polling.

> If the CQ is non-empty then, by spec, if no new events arrive it will
> never be signaled - the app must re-poll it on its own so why arm it?
> 
>> The man pages suggest a scheme where the app should call ibv_get_cq_event()
>> followed by an ibv_req_notify_cq(), the CQ polling/emptying comes after these,
>> so at the time of arm the CQ isn't empty.
> 
> It doesn't show how to re-arm it seems
> 
> I'm repeating from memory here, I haven't checked the specs, but that
> Sean agrees seems like I'm remembering it right :)
> 
> The question you seem to be asking is what happens if you re-arm a
> non-empty CQ, do you immediately get an event or not? It should be
> easy enough to test on siw, rxe and mlx5 and see

rxe seems to get stuck, had some issues running siw and don't have an mlx5 nic
at hand.

> I expect by spec arming a non-empty CQ will not generate an event. The
> spec was written to support very simple hardware that would simply
> generate an event the next time it writes a CQE then atomically clear
> the arm.
> 
> Does look like a documentation update is in-order though!

Looking at libibverbs examples, pyverbs tests and perftest, they all act roughly
the same:

1. arm CQ
2. post send/recv
3. get event
4. arm CQ
5. poll
6. goto step 2

All of these apps always use the same construct of get event followed by an
immediate arm. Did all of these apps get it wrong?

Do you have an example of where it's done right :)?
