Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F41A533059
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 20:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237998AbiEXSWL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 14:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiEXSWJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 14:22:09 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD0373556
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 11:22:08 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id v9so17712465oie.5
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 11:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hZ88ifxAiIu/UnEOoQU3/ftkHbFs3vNTVqX0MZRnSTY=;
        b=VTg/tgXBFx0sqy7E8VQHRwVDILZfnRykGj6iM6j3THX3g+fQVGkP6v5jPUfQafCtOa
         bsScdhGpoWNu0XAAF5eItCrTHlFi+KAc0wOnE7TI40M13CUP7s+cqZsfsaNQkIy7lICJ
         /kXP15xeAgCXnzARLKaI6qyIw15JsxNQg7BLS6u4SurGdeqGU4XfJcjZQrhYyqfWKcq6
         Lv9ZjdSKmQILtu0JAVqAcbCpeSAj7o/ZvT0Q1ZmjyBJ+J6hh19631uDPENUTUXj1SvH0
         WxOOwSTeOghXxgbJWLjvOdD1tABpXNnN79JJZ3ybFNQOpC3zCEtv3RiUTkYheIBIEKNj
         kgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hZ88ifxAiIu/UnEOoQU3/ftkHbFs3vNTVqX0MZRnSTY=;
        b=wKHTnp+kg3PinrPaYzh3XIoinyVIdRYR55NMu+8DM8s0kZ88Y6l8D40h8gjrG2boNn
         3iE3DoohXIk56Jum9UtgvDga/sq8BWeNoM2A5G/FaJvUx/i+/qRhRkbvmzwAUM1y629L
         vmkEqjghj+TPzm1o3F1Jze87YcwRCygF+m4hq/ppPW73/dVUSgqrubp034M45kOnWg9b
         jF15OUEadBIslhHTbVB8j/gPK98wei4YQFNGa44K80tnPK3jmgaw7RQSEV5D1pzLV8K7
         G+4POVy843V22lCbfMAVCtiYSEcD5A/Nt4rjtCDq2d6PcUBrlCrnFbpIyuRv5NYwrucj
         cn7Q==
X-Gm-Message-State: AOAM531yOSlYdiC8A0SyJztnTfvHqh108+0hdduQt7Og6d9JTNmpOJnS
        z3uhfjL2V+X9/2qZV9Ny+hs=
X-Google-Smtp-Source: ABdhPJxGHyr0Asx/A6TdngWt15HIMsRwUFH+w+hUHDzuJNU6T/ovmrLc6jPfAXOMDZYqLIDf45iU0A==
X-Received: by 2002:a05:6808:1454:b0:328:82a9:cb08 with SMTP id x20-20020a056808145400b0032882a9cb08mr3074407oiv.106.1653416528322;
        Tue, 24 May 2022 11:22:08 -0700 (PDT)
Received: from [192.168.0.27] (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id 124-20020a4a1482000000b0040e5ecb377bsm5649437ood.32.2022.05.24.11.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 11:22:08 -0700 (PDT)
Message-ID: <ec2369b3-4dad-30bf-35c0-d45ee0a7ce92@gmail.com>
Date:   Tue, 24 May 2022 13:22:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH for-next v14 00/10] Fix race conditions in rxe_pool
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220421014042.26985-1-rpearsonhpe@gmail.com>
 <20220509182353.GA927104@nvidia.com>
 <6012bc26-a2f6-c05f-a056-36aac02797e8@fujitsu.com>
 <20220524115753.GO1343366@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220524115753.GO1343366@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/24/22 06:57, Jason Gunthorpe wrote:
> On Tue, May 24, 2022 at 03:53:30AM +0000, yangx.jy@fujitsu.com wrote:
>> On 2022/5/10 2:23, Jason Gunthorpe wrote:
>>> On Wed, Apr 20, 2022 at 08:40:33PM -0500, Bob Pearson wrote:
>>>
>>>> Bob Pearson (10):
>>>>    RDMA/rxe: Remove IB_SRQ_INIT_MASK
>>>>    RDMA/rxe: Add rxe_srq_cleanup()
>>>>    RDMA/rxe: Check rxe_get() return value
>>>>    RDMA/rxe: Move qp cleanup code to rxe_qp_do_cleanup()
>>>>    RDMA/rxe: Move mr cleanup code to rxe_mr_cleanup()
>>>>    RDMA/rxe: Move mw cleanup code to rxe_mw_cleanup()
>>>>    RDMA/rxe: Enforce IBA C11-17
>>>
>>> I took these patches with the small edits I noted
>>>
>>>>    RDMA/rxe: Stop lookup of partially built objects
>>>>    RDMA/rxe: Convert read side locking to rcu
>>>>    RDMA/rxe: Cleanup rxe_pool.c
>>>
>>> It seems OK, but we need to fix the AH problem at least in the destroy
>>> path first - lets try to fix it in alloc as well?
>> Hi Jason, Bob
>>
>> Could you tell me what the AH problem is? Thanks a lot.
> 
> rxe doesn't implement RDMA_CREATE_AH_SLEEPABLE /
> RDMA_DESTROY_AH_SLEEPABLE
> 
> Jason

First I have heard of those. Should we implement them?

Bob
