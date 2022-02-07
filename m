Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AB54AC95E
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Feb 2022 20:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbiBGTX2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Feb 2022 14:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240001AbiBGTUf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Feb 2022 14:20:35 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6481C0401DA
        for <linux-rdma@vger.kernel.org>; Mon,  7 Feb 2022 11:20:34 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id ay7so4174227oib.8
        for <linux-rdma@vger.kernel.org>; Mon, 07 Feb 2022 11:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cvmId1SclNToxcjI0t4bdNZx+exN4xo3cRwvVeG55Zs=;
        b=MQVRr9YuuZE7qC3DUAMHYStYxrj7XDsnJn6h432Np3OPGfB7PlohS5Ku9Sd04P01Ck
         ttyUFBVs7APUsBc9ga+mT6QSmTIvL/E7ER/vA8LUYPcPDMvYnERWUctKlduUBtrEeR+r
         oP++GCNLf7kO8OXoQvBNcqwmavRLq+alafit7ra0rBvDv74ROQifNvPu1Q5ND28IIjKQ
         mWpYy9F+x5m44h6yutxzO12c2vQcxhJNUWcJb8ZcQmdoLONq8B1+qTEJI0tEPEv/77Ae
         GcCWllSMBj5jDqnokyTg7+4Fb02PNdj8go6E5vv031QKhx+RCSDR4xRqjQ7jKMH744es
         ZIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cvmId1SclNToxcjI0t4bdNZx+exN4xo3cRwvVeG55Zs=;
        b=dmgTlvM65DhibqnbAaOEE9xtUlyyON6Y8+Wc094j1i2a6wWpe8Gg+9brKkjZI4Gzhy
         dmk9zk4zd70uFTJ3O9feuXe+yKkVBUJEerDs8I91gyuPkKV6npJgNjXUokBP4Bu9Zpcd
         waiXS1HSRIRYSHdzk+Iok0ZxLGXBMR1VbdpPRWBfzv9O8u9kJP56ApJ3PxCtbnslt0Re
         CMRW5y3Nv9j+wgg0AWmZSpip74OvGDDjbR3nl/ha3CS1tZCXZ6L0uptshgOtLhjaQFQk
         4m04xiR0EHw661kPWnYJRZt/8YBgTXNK/xTBJndhyQNfrLwjSFhEjpXjbxiyXGtaIqqq
         nhZQ==
X-Gm-Message-State: AOAM5317phZ6i35TiPYxGHWG3W8fJKW3UsHAfVGF2qhLwXKfz2roDx7U
        nrMXpDtQEynz2qU5aXiwvtM=
X-Google-Smtp-Source: ABdhPJydSoOltjralcwUhBJ7A3FALJKT+3B30OlSFMXDjjk/5NPRXiBCSSePHFYcwxDg5eLhKohVXg==
X-Received: by 2002:a05:6808:3:: with SMTP id u3mr206592oic.272.1644261634223;
        Mon, 07 Feb 2022 11:20:34 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:5a47:24e4:ef27:46cf? (2603-8081-140c-1a00-5a47-24e4-ef27-46cf.res6.spectrum.com. [2603:8081:140c:1a00:5a47:24e4:ef27:46cf])
        by smtp.gmail.com with ESMTPSA id b6sm4273347otl.0.2022.02.07.11.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 11:20:33 -0800 (PST)
Message-ID: <9080f698-3b72-36a7-0051-be12f4ce6e28@gmail.com>
Date:   Mon, 7 Feb 2022 13:20:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v9 00/26]
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
 <20220128184200.GH1786498@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220128184200.GH1786498@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/28/22 12:42, Jason Gunthorpe wrote:
> On Thu, Jan 27, 2022 at 03:37:29PM -0600, Bob Pearson wrote:
>> There are several race conditions discovered in the current rdma_rxe
>>
>> Bob Pearson (26):
>>   RDMA/rxe: Move rxe_mcast_add/delete to rxe_mcast.c
>>   RDMA/rxe: Move rxe_mcast_attach/detach to rxe_mcast.c
>>   RDMA/rxe: Rename rxe_mc_grp and rxe_mc_elem
>>   RDMA/rxe: Enforce IBA o10-2.2.3
>>   RDMA/rxe: Remove rxe_drop_all_macst_groups
>>   RDMA/rxe: Remove qp->grp_lock and qp->grp_list
> 
> I took these patches to for-next
> 
>>   RDMA/rxe: Use kzmalloc/kfree for mca
>>   RDMA/rxe: Rename grp to mcg and mce to mca
>>   RDMA/rxe: Introduce RXECB(skb)
>>   RDMA/rxe: Split rxe_rcv_mcast_pkt into two phases
>>   RDMA/rxe: Replace locks by rxe->mcg_lock
>>   RDMA/rxe: Replace pool key by rxe->mcg_tree
>>   RDMA/rxe: Remove key'ed object support
>>   RDMA/rxe: Remove mcg from rxe pools
>>   RDMA/rxe: Add code to cleanup mcast memory
>>   RDMA/rxe: Add comments to rxe_mcast.c
>>   RDMA/rxe: Separate code into subroutines
> 
> I think you should try to get up to here done in one series and
> merged, it looked OK

Jason,

I have these ready again. It is a little restructured but gets to the same place.
Last time I sent things in you had a complaint but it got mangled somehow so I
couldn't read it. Is there anything else I should be looking at before posting these
again?

Bob
> 
>>   RDMA/rxe: Convert mca read locking to RCU
> 
> Not sure this can ever work..
> 
>>   RDMA/rxe: Reverse the sense of RXE_POOL_NO_ALLOC
>>   RDMA/rxe: Delete _locked() APIs for pool objects
>>   RDMA/rxe: Replace obj by elem in declaration
>>   RDMA/rxe: Replace red-black trees by xarrays
>>   RDMA/rxe: Change pool locking to RCU
>>   RDMA/rxe: Add wait_for_completion to pool objects
>>   RDMA/rxe: Fix ref error in rxe_av.c
>>   RDMA/rxe: Replace mr by rkey in responder resources
> 
> These also seem reasonable, didn't follow why we needed the RCU patch?
> 
> Jason

