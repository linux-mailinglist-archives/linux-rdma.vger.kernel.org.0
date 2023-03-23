Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632F46C6BEB
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Mar 2023 16:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjCWPJj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Mar 2023 11:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjCWPJi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Mar 2023 11:09:38 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD6E1F919;
        Thu, 23 Mar 2023 08:08:27 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id r29so20848312wra.13;
        Thu, 23 Mar 2023 08:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679584046; x=1682176046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W5eaU9UI5gNRoVJmBelB0AByjFrGD8ImlIIGOOSTiYM=;
        b=CQCmQg7mNgSHFDgqBLVxv2em2v5cHz8aeXWTZvhJWJzVyRpGRBTfTpHr3o0yhBD02i
         cAZ0cuj+ufd0cyAAs4Xs/aPE7cHZ8o01GCGHhzgR5sCR9nn5WM6Ha5KL3y7jGl7Pbumw
         OHSlxQh+Ubc+CGiADsMRoE4bQt9is0LgyfdbN8Bal//sOhOSPDAyFRuIqQPGeR/54Mla
         1gtiDwp+TXrfetk3IBDpRerHEJ0EdaEOmPV212iGgax9vaZNDm/s0KJ2neUbVzMK5xPf
         8FaGxmABzNLJuhtGgU7pCdYGSculHlFcZ5pTjPpFTWFv75QPKSqZ8mEtYKeIFr3VucZd
         Ynxw==
X-Gm-Message-State: AO0yUKU9ddFcX8zapRfkuBPqLj7k7jkmX1u4f9Bz9WH6x4QlLKRtNyqp
        le5UyQtrsjmJxmFgvCT9C9SARNtFhmU=
X-Google-Smtp-Source: AK7set+e4miZKSYP825PLpvWVYToMLQ9zWrZumdjz4czNzXkEklOqiRp4QzdYZS+q2IQIUtyJryFSA==
X-Received: by 2002:adf:f681:0:b0:2ca:ab68:eff9 with SMTP id v1-20020adff681000000b002caab68eff9mr6178292wrp.7.1679584046480;
        Thu, 23 Mar 2023 08:07:26 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y16-20020a056000109000b002c56013c07fsm16215088wrw.109.2023.03.23.08.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 08:07:26 -0700 (PDT)
Message-ID: <e1b00740-3c75-8b90-4d68-76a5f341a117@grimberg.me>
Date:   Thu, 23 Mar 2023 17:07:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma devices
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-rdma@vger.kernel.org
References: <20230322123703.485544-1-sagi@grimberg.me>
 <ZBr6kNVoa5RbNzSa@ziepe.ca>
 <c51d3d99-5bc9-cb47-6efa-5371ef3cc0f4@grimberg.me>
 <ZBsHnq6FlpO0p10A@ziepe.ca> <20230323120515.GE36557@unreal>
 <ZBxOHZwre3x8DkWN@ziepe.ca>
Content-Language: en-US
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZBxOHZwre3x8DkWN@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>>>>> No rdma device exposes its irq vectors affinity today. So the only
>>>>>> mapping that we have left, is the default blk_mq_map_queues, which
>>>>>> we fallback to anyways. Also fixup the only consumer of this helper
>>>>>> (nvme-rdma).
>>>>>
>>>>> This was the only caller of ib_get_vector_affinity() so please delete
>>>>> op get_vector_affinity and ib_get_vector_affinity() from verbs as well
>>>>
>>>> Yep, no problem.
>>>>
>>>> Given that nvme-rdma was the only consumer, do you prefer this goes from
>>>> the nvme tree?
>>>
>>> Sure, it is probably fine
>>
>> I tried to do it two+ years ago:
>> https://lore.kernel.org/all/20200929091358.421086-1-leon@kernel.org
> 
> Christoph's points make sense, but I think we should still purge this
> code.
> 
> If we want to do proper managed affinity the right RDMA API is to
> directly ask for the desired CPU binding when creating the CQ, and
> optionally a way to change the CPU binding of the CQ at runtime.

I think the affinity management is referring to IRQD_AFFINITY_MANAGED
which IIRC is the case when the device passes `struct irq_affinity` to
pci_alloc_irq_vectors_affinity.

Not sure what that has to do with passing a cpu to create_cq.

> This obfuscated 'comp vector number' thing is nonsensical for a kAPI -
> creating a CQ on a random CPU then trying to backwards figure out what
> CPU it was created on is silly.

I don't remember if the comp_vector maps 1x1 to an irq vector, and if it
isn't then it is indeed obfuscated. But a similar model is heavily used
by the network stack with cpu_rmap, where this was derived from.

But regardless, its been two years, it is effectively dead code, and not
a single user complained about missing it. So we can safely purge them
and if someone cares about it, we can debate adding it back.
