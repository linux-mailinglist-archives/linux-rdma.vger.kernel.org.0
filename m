Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B1E32201D
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 20:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhBVT2e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 14:28:34 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:20634 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbhBVTZ2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Feb 2021 14:25:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1614021927; x=1645557927;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4AyJaJSGrfKe3PgirUBzJ7ws93qSUHDxncUnquJTXC4=;
  b=UHDXN0w0oGt/FQ6sH/WT7RQMbtluIF0EEVJU5btjO6senDoFTp/u0fsG
   rmQBZWynW7FtuUGWw8DFLV6YLDxhjTBLvww3CiR6iN9EWuaJ3joCR9kmj
   QhK5IWjBkfVU8xBmUHn7EFzHlpcGlbi92+ycdZI9YW4GqHs4QDzCCqFJv
   Q=;
X-IronPort-AV: E=Sophos;i="5.81,198,1610409600"; 
   d="scan'208";a="89368324"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 22 Feb 2021 19:24:27 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix) with ESMTPS id 5F74FA201E;
        Mon, 22 Feb 2021 19:24:26 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.228) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 22 Feb 2021 19:24:23 +0000
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
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <8277bebb-8994-af0f-52fc-972c7f8260dd@amazon.com>
Date:   Mon, 22 Feb 2021 21:24:18 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210222155559.GH2643399@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.228]
X-ClientProxiedBy: EX13D41UWC003.ant.amazon.com (10.43.162.30) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 22/02/2021 17:55, Jason Gunthorpe wrote:
> On Mon, Feb 22, 2021 at 05:36:17PM +0200, Gal Pressman wrote:
> 
>> "Mellanox HCAs keep track of the last index for which the user received an
>> event. Using this index, it is guaranteed that an event is generated immediately
>> when a request completion notification is performed and a CQE has already been
>> reported."
> 
> I don't think verbs exposes this behavior.

So in theory this hardware could generate events that the user app doesn't expect?

>> This also sounds weird, why is an event generated for a completion that has
>> already been reported?
> 
> It eleminates races, if the consumer says 'I read up to X send me an
> interrupt if X+1 exists' when X+1 already exists if there is a race
> producer has already written it. So send an interrupt.

Right, that's what I was getting at in my first question, this isn't the next
completion from the device's perspective.
So in such case the consumer index in the arm doorbell is used to indicate what
should be considered a "new" completion? This is new from the app perspective.

But looking at ibv_ud_pingpong for example, I don't understand how that could
even work.
The test arms the CQ on creation (consumder index 0), calls ibv_get_cq_event(),
wakes up and immediately arms the CQ again (before polling, consumer index is
still 0).
This means that the next ibv_get_cq_event() will wake up immediately, as the CQ
was armed twice with the same consumer index and the first completion already
exists. Surely that's not what's meant to happen?

>> So from my understanding of how this should work, the following code in perftest
>> (ib_send_bw test) is buggy?:
>> https://github.com/linux-rdma/perftest/blob/master/src/perftest_resources.c#L2955
>>
>> Running this with 32 iterations, the client does something like:
>> - arm cq
>> - post send x 32
>> - wait for cq event
>> - arm cq
>> - poll cq (once, with batch size of 16)
>> - no more post send (reached tot_iters)
>> - wait for cq event (but an event has already been generated?)
> 
> I don't know much about perf-test, but in verbs arming a non-empty CQ
> is asking for trouble

Do you have a way to verify whether this test gets stuck? Maybe I am missing
something?

What do you mean by arming a non-empty CQ?
The man pages suggest a scheme where the app should call ibv_get_cq_event()
followed by an ibv_req_notify_cq(), the CQ polling/emptying comes after these,
so at the time of arm the CQ isn't empty.
