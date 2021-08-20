Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396573F3644
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Aug 2021 00:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhHTWKd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Aug 2021 18:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHTWKd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Aug 2021 18:10:33 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A58C061575
        for <linux-rdma@vger.kernel.org>; Fri, 20 Aug 2021 15:09:54 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id x10-20020a056830408a00b004f26cead745so17330955ott.10
        for <linux-rdma@vger.kernel.org>; Fri, 20 Aug 2021 15:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SKvaWTeSf0iJmzrrA11E3wsXfxZnFCm+ifk3rCI+6YE=;
        b=qPfWCjwtCwr3DZaZTLiK/Atd5t1Vk7Fh0TleqMony1dEu1/S0j3iouDnsROlImfEI8
         kBymWmUAcx3UebAQIA/kpz91U0x2vIBO2ff2CvAz6Lik4kQBeb0kY0n9Kr+DGcwbNMcZ
         JLinCD7jUDoUwRNREgb/1l5MxxpQw8CdHZD1gT2FKA7wuh23fJU8rcjEpSMBvvsjom3z
         owhds0XPRDry3IAY+NSzcix5S/pMaliobmvhGYMBCNEc46CPNoPS5br73Dhtn5/IUM37
         ETulUxoOq1S75tpsr0LZ9iBZZBOjXMGWnsOwCKOB6cGIALjXwoNtKRFQjCXoggm7f2Bj
         2EwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SKvaWTeSf0iJmzrrA11E3wsXfxZnFCm+ifk3rCI+6YE=;
        b=Klx2LontajZX0N7QbpuS6lG10qPTNs0reyVkLEP6s6mYDuxoFRPPYgGUKdJGTB23EB
         9T7lvMur1ewDYAl8av5JjFtHKNg2gMxBroXNv5NOzsELr41ijsUK50QCocGDy/Sk5AlD
         GfOCDhrMRHVINy3WHl034dWkiDH95bFQ6bQ0OrK5wyz4HLSbMiFAlEsIh2gVdZzJWQai
         qdrxVUk4gHfFf4qzz0jq3FcKVWr9O6izSYrKfgaV02iPPXgKbzz6gX16djYeJPyeEczM
         DRhFxO5VL+sV4t8pTmInvIrh4vTRURjbKP6kchK6VRA8k9bDNNnRAafP9DP4/ubwZaUN
         2R/A==
X-Gm-Message-State: AOAM533jiUsXw0gLs+UlAJ3/ms4z9ZG+mwprt1JPhfQcujhz6Y2/MGMk
        /ApVsuLsl154t+ZvEYAmNw7ecXdnIZk=
X-Google-Smtp-Source: ABdhPJygNVVvbZv3RCaDP832ETq2Ks8E9GjevffBb5irgn1whMVHfNHxr9iOV3u7ggvRxyktGPDxjw==
X-Received: by 2002:aca:1914:: with SMTP id l20mr4551010oii.19.1629497394147;
        Fri, 20 Aug 2021 15:09:54 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:18a5:8e2a:9f3f:746c? (2603-8081-140c-1a00-18a5-8e2a-9f3f-746c.res6.spectrum.com. [2603:8081:140c:1a00:18a5:8e2a:9f3f:746c])
        by smtp.gmail.com with ESMTPSA id p4sm1573458ooa.35.2021.08.20.15.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 15:09:53 -0700 (PDT)
Subject: Re: RXE status in the upstream rping using rxe
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <YQmF9506lsmeaOBZ@unreal>
 <CAD=hENeBAG=eHZN05gvq1P9o4=TauL3tToj2Y9S7UW+WLwiA9A@mail.gmail.com>
 <CAD=hENfua2UXH6rVuhMPXYsNSavqG==T3h=z4f=huf+Fj+xiHA@mail.gmail.com>
 <YQoogK7uWCLHUzcs@unreal>
 <CAD=hENcnUd-rTHGPq2DjyF7tDHVzCebDO2gtwZa9pw0M_QvaPA@mail.gmail.com>
 <CAN-5tyG4kBYBEaCDPGr=gUTNGkcoznMUy8e4BwCzWZkSPG-=+Q@mail.gmail.com>
 <CAD=hENdqho3mRy=gUSE-vuXzLvZPkwJ7kEFrjRN-AxLwvQP18Q@mail.gmail.com>
 <611CABE6.3010700@fujitsu.com>
 <CAD=hENezpPKyGFVB121fjhhniE02fwspULi5vaScU1dWcbY7gA@mail.gmail.com>
 <611CBA42.9020002@fujitsu.com>
 <CAD=hENcE12nKdRn04K9Zbd1CyOQureYb44fp9occ=R4P6XrgZQ@mail.gmail.com>
 <611D1A3E.20701@fujitsu.com>
 <CAD=hENeYiTrfxDTAS9UkF8tn7=wa49H0DQuCBKeHpd+L6qM4SQ@mail.gmail.com>
 <611F5CD8.2020504@fujitsu.com>
 <3ef95380-ea42-562a-975d-d767d76ee2ca@gmail.com>
Message-ID: <246e4cbf-5645-9552-58a4-ed1be0976fb4@gmail.com>
Date:   Fri, 20 Aug 2021 17:09:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3ef95380-ea42-562a-975d-d767d76ee2ca@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/20/21 4:40 PM, Bob Pearson wrote:
> On 8/20/21 2:42 AM, yangx.jy@fujitsu.com wrote:
>> On 2021/8/20 11:31, Zhu Yanjun wrote:
>>> Latest kernel + latest rdma-coOnre<  ------rping---->  5.10.y stable +
>>> latest rdma-core
>>> Latest kernel + latest rdma-core<  ------rping---->  5.11.y stable +
>>> latest rdma-core
>>> Latest kernel + latest rdma-core<  ------rping---->  5.12.y stable +
>>> latest rdma-core
>>> Latest kernel + latest rdma-core<  ------rping---->  5.13.y stable +
>>> latest rdma-core
>>>
>>> The above works well.
>> Hi Yanjun,
>>
>> Sorry, I don't know why you cannot reproduce the bug.
>>
>> Did you see the similar bug reported by Olga Kornievskaia?
>> https://www.spinics.net/lists/linux-rdma/msg104358.html
>> https://www.spinics.net/lists/linux-rdma/msg104359.html
>> https://www.spinics.net/lists/linux-rdma/msg104360.html
>>
>> Best Regards,
>> Xiao Yang
>>> Zhu Yanjun
>>>
> 
> There is some interest in the current status of rping on rxe.
> I have looked at several configurations and tested the following test cases:
> 
> 	1. The python test suite in rdma-core
> 	2. ib_xxx_bw and ib_xxx_bw -R for RC
> 	3. rping
> 
> Between the following node configurations.
> 
> 	A. 5.11.0 (ubuntu 21.04 OOB) + rdma-core 33.1 (ubuntu 21.04 OOB)
> 	B. 5.11.0 + current rdma-core
> 		+ "Provider/rxe:Set the correct value of resid for inline data" (a.k.a rdma-core+)
> 	C. 5.14.0-rc1+ (for-next current)
> 		+ 5 recent bug fixes (a.k.a. for-next+)
> 			RDMA/rxe:Fix bug in get srq wqe in rxe_resp.c.patch
> 
> 			RDMA/rxe:Fix bug in rxe_net.c.patch
> 
> 			RDMA/rxe:Add memory barriers to kernel queues.patch
> 
> 			RDMA/rxe:Fix memory allocation while locked.patch
> 
> 			RDMA/rxe:Zero out index member of struct rxe_queue.patch
> 		+ rdma-core+
> 	D. for-next+ + rdma-core (33.1)
> 
> Results:
> 	1.  A N/A
> 	1.  B no errors, some skips
> 	1.  C no errors, some skips
> 	1.  D N/A
> 	(n.b. requires adding IPV6 address == gid[0] by hand)
> 
> 	2. [A-D] -> [A-D] all pass
> 
> 	3.  A -> A, C -> C, D -> D all pass, all other combinations fail
> 
> 	(RDMA_resolve_route: No such device. Not yet sure cause of failures but looking into it.)
> 	In theory these should all work but rdmacm is more sensitive to configuration than verbs. 
> 
> Bob
> 

Found the problem (thank you google) If you run both

server$ rping -s -a nn.nn.nn.nn
client$ rping -c -a nn.nn.nn.nn

now all tests pass for rping as well.

Bob
