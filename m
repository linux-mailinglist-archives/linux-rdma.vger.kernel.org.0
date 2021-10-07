Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBE2425C9C
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Oct 2021 21:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbhJGTxH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Oct 2021 15:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbhJGTxG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Oct 2021 15:53:06 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEACDC061755
        for <linux-rdma@vger.kernel.org>; Thu,  7 Oct 2021 12:51:12 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so8876908otv.4
        for <linux-rdma@vger.kernel.org>; Thu, 07 Oct 2021 12:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=80SJeeylH9P1sOHbyxfwtJWzpc0kVJXGOr1sqyw5DU4=;
        b=czvBNLQqzh1SRvMwy0qyHY5I0KK2JMWTutrFeXYx7csE9EN5G3EX9xk4uNMa0WU8V4
         JK/mJcnMNI25fqI1KorDiKqOtzkwy5vEbI8qjI+8asF4QE+ztE8zAizqrlvhD3hufvG5
         U7BxC5OlxU6DD6vM2kwORqH7qKTTi4IGgkaL7VjwEIpd0VzOqO/4/D8NK3fQ/Txan67O
         ulVjZIVsEHykUiG8zTaoIYjFUpqMEHBaBuoQwEdooqEepkgv1sinz1TCkiXHYHPeP6Wf
         X0wAX81D3yKAne5np00qwsEZAvQJqkfHB8k95a6a63PVDvPkuldwi2QtXzWWoVB/J+k8
         f5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=80SJeeylH9P1sOHbyxfwtJWzpc0kVJXGOr1sqyw5DU4=;
        b=O1qGVjD7gpwYY16+1apwXmyl3UD5DbDiH+XlMCoiQgzWmIykwsDqICjCnRqbmZQnmi
         8ouJzuQjYTfGriTxPAHcLfg/kMRfvF7SA5mFEmj9Vhr5Wjb0uoLZv4IJPliRM73Px/xv
         VN0FrEGRRIxPAQSjF1hTH6aKe6sWPcClc1HTAb9ArT9N+pJEbRU7LzVYk9s8UGM+ZsfE
         Q9ZRzutGhkL5MQqa+p/ZdNQhhLuAQEm6AWMFIvdlT9RTwvbqmgVtEwShbqHhRByGPiLs
         QsznSzpTS63aS1jfni9Opx65ZyOc5GqAw0mQ7iFADjddDWgPHodGa9y6Y2773asnvtl4
         idCQ==
X-Gm-Message-State: AOAM531SIYmeCls9Sy+12T33aaETTtzTxAfOEvY43ii1NVKR8KdUa8gD
        hYAz4PNll3TvY9WKyRCZ35uV7oQC33A=
X-Google-Smtp-Source: ABdhPJzLsiK00ukk32jjSKgX085CZHkBtgqC69jKLdicSk/RNbc8zlIZ9DnCcCVgQK5yqeD0i2CLEA==
X-Received: by 2002:a05:6830:30bd:: with SMTP id g29mr5513233ots.69.1633636272086;
        Thu, 07 Oct 2021 12:51:12 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:28eb:c206:8f9f:7a9d? (2603-8081-140c-1a00-28eb-c206-8f9f-7a9d.res6.spectrum.com. [2603:8081:140c:1a00:28eb:c206:8f9f:7a9d])
        by smtp.gmail.com with ESMTPSA id w17sm61919otu.53.2021.10.07.12.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 12:51:11 -0700 (PDT)
Subject: Re: [PATCH for-next v5 0/6] Replace AV by AH in UD sends
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Rao Shoaib <Rao.Shoaib@oracle.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20211006015815.28350-1-rpearsonhpe@gmail.com>
 <20211006193714.GA2760599@nvidia.com>
 <8fb347bb-81b2-2ba6-a97c-16a5db86541d@gmail.com>
 <20211006224906.GE2744544@nvidia.com>
 <086698cc-9e50-49be-aea8-7a4426f2e502@gmail.com>
 <20211007190543.GM2744544@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <5e8ff897-ca98-4dcc-a731-2bf150011fe9@gmail.com>
Date:   Thu, 7 Oct 2021 14:51:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211007190543.GM2744544@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/7/21 2:05 PM, Jason Gunthorpe wrote:
> On Thu, Oct 07, 2021 at 01:53:27PM -0500, Bob Pearson wrote:
> 
>> On looking, Rao's patch is not in for-next. Last one was
>> January. Which branch are you looking at?
> 
> Oh, it is still in the wip branch, try now
> 
> Jason
> 

I see the issue. Rao is asking for 2^20 objects max by default which will
require 128KiB of memory in the index reservation bit mask for each of them.
There are 4 indexed objects QP by qpn, SRQ by srqn, MR by rkey and MW by rkey.
That's 512KiB of memory which seems excessive to me for many use cases where the
number of objects is fairly small.

The bit mask is used to allocate and free the indices and there is also a red black
tree that is used to look up objects by their index (or key if they use keys instead.)

If there is a usual way to address these kinds of issues in Linux maybe we should
consider that. If not there are a couple of approaches we could take. First would
be to get rid of the index bit mask and just hand out randomly selected indices in
(a bigger range) and detect collisions when we insert the object into the red black
tree and retry. This is basically what happens with 'keys' for example mgids for
multicast group elements. Alternatively we could leave the max big but limit the
allocated indices to a smaller amount until the total number of allocated indices
reached some threshold and then extend the bit mask table. Then only the use cases
that really needed the big index range would pay the price for the memory.

Random indices would slightly reduce some of the security issues that have been
pointed out about the InfiniBand transport.

I am looking for suggestions on how to go forward here.

Bob
