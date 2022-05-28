Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9B6536E22
	for <lists+linux-rdma@lfdr.de>; Sat, 28 May 2022 21:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiE1TH7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 May 2022 15:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiE1TH6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 28 May 2022 15:07:58 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82952180
        for <linux-rdma@vger.kernel.org>; Sat, 28 May 2022 12:07:54 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id q18so6922300pln.12
        for <linux-rdma@vger.kernel.org>; Sat, 28 May 2022 12:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B9GIccXQ3NoEdoL+6p/0Pu0IeKbfV0Y1AR2ygTcEouQ=;
        b=weEDJGnmS4MuQcs+R0CbjchrEIqWu0YnXm6VRyEWW35ZivS08XCDdDDUgbrUkLlHze
         oxvCi/ucQQlqAGTLw2pjsJaKaFxkhAWnbuj3C9cz7Fu1LQAW8YpfaMpFY2mJWMtxU9/8
         A+m/RNZ1YUXdBGW3laOFYfZMA/3+k+JeP73lzXTt6/dluy3zcp5n5egr+bIRnyftWFX9
         wXgTsU9WiTcqRmIZ6e7TX685ZVou60TffRDAo4QhIZsEohIRHSeylXrclquDT9QUHQo7
         aaBz3ASxisARRB9bRm/0jsHDu9y5dw8VNybmWcMe7NqIA9nwhKo6VD3j6t4xP47Wr+IO
         YlHg==
X-Gm-Message-State: AOAM532f6FQfTihbxVCltLDpolkDP1cBhIfuyOs7o2vElELP1kkoyuis
        6wZjyaXyexpZRRoJsmtVlu8ItC8y24HCDz6X
X-Google-Smtp-Source: ABdhPJwXJzyj98WMQZaBVyD+ZcuJ4zRI8MI/I1iLRqaCQGUqcYYWmvKFaCN/xFK5A4Ii5l8f8C/FCA==
X-Received: by 2002:a05:6a00:24cc:b0:50d:58bf:5104 with SMTP id d12-20020a056a0024cc00b0050d58bf5104mr49566653pfv.36.1653764446126;
        Sat, 28 May 2022 12:00:46 -0700 (PDT)
Received: from [172.19.249.174] ([205.220.129.27])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902e88900b0016362da9a03sm5934765plg.245.2022.05.28.12.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 12:00:45 -0700 (PDT)
Message-ID: <4d65a168-c701-6ffa-45b9-858ddcabbbda@acm.org>
Date:   Sat, 28 May 2022 21:00:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
 <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
 <4f15039a-eae1-ff69-791c-1aeda1d693df@acm.org>
 <20220527125229.GC2960187@ziepe.ca>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220527125229.GC2960187@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/27/22 14:52, Jason Gunthorpe wrote:
> On Wed, May 25, 2022 at 08:50:52PM +0200, Bart Van Assche wrote:
>> On 5/25/22 13:01, Sagi Grimberg wrote:
>>> iirc this was reported before, based on my analysis lockdep is giving
>>> a false alarm here. The reason is that the id_priv->handler_mutex cannot
>>> be the same for both cm_id that is handling the connect and the cm_id
>>> that is handling the rdma_destroy_id because rdma_destroy_id call
>>> is always called on a already disconnected cm_id, so this deadlock
>>> lockdep is complaining about cannot happen.
>>>
>>> I'm not sure how to settle this.
>>
>> If the above is correct, using lockdep_register_key() for
>> id_priv->handler_mutex instead of a static key should make the lockdep false
>> positive disappear.
> 
> That only works if you can detect actual different lock classes during
> lock creation. It doesn't seem applicable in this case.

Why doesn't it seem applicable in this case? The default behavior of 
mutex_init() and related initialization functions is to create one lock 
class per synchronization object initialization caller. 
lockdep_register_key() can be used to create one lock class per 
synchronization object instance. I introduced lockdep_register_key() 
myself a few years ago.

After having taken a closer look at the RDMA/CM code, I decided not yet 
to implement what I proposed above. I noticed that handler_mutex is held 
around callback invocations. An example:

static int cma_cm_event_handler(struct rdma_id_private *id_priv,
				struct rdma_cm_event *event)
{
	int ret;

	lockdep_assert_held(&id_priv->handler_mutex);

	trace_cm_event_handler(id_priv, event);
	ret = id_priv->id.event_handler(&id_priv->id, event);
	trace_cm_event_done(id_priv, event, ret);
	return ret;
}

My opinion is that holding *any* lock around the invocation of a 
callback function is an antipattern, in other words, something that 
never should be done. John Ousterhout already described this in 1996 in 
his presentation [1]. Patches like 071ba4cc559d ("RDMA: Add 
rdma_connect_locked()") work around this problem but do not solve it.

Has it been considered to rework the RDMA/CM such that no locks are held 
around the invocation of callback functions like the event_handler 
callback? There are other mechanisms to report events from one software 
layer (RDMA/CM) to a higher software layer (ULP), e.g. a linked list 
with event information. The RDMA/CM could queue events onto that list 
and the ULP can dequeue events from that list.

Thanks,

Bart.

[1] Ousterhout, John. "Why threads are a bad idea (for most purposes)." 
In Presentation given at the 1996 Usenix Annual Technical Conference, 
vol. 5. 1996.
