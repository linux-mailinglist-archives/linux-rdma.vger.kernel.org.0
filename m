Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A95442ADB3
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Oct 2021 22:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhJLUVu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Oct 2021 16:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhJLUVu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Oct 2021 16:21:50 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD5CC061570
        for <linux-rdma@vger.kernel.org>; Tue, 12 Oct 2021 13:19:48 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id l24-20020a9d1c98000000b00552a5c6b23cso810131ota.9
        for <linux-rdma@vger.kernel.org>; Tue, 12 Oct 2021 13:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yHznt9RNLvVaiHxz+XYmt8XlB6AXpFaSIDnqBvamPdg=;
        b=FBv9e26TMUj4mkKuoSDTRC/Ef9TcGmKlM78FiOWyIlLdMBr7x1ZHEHlmBGfuAZx2Di
         i5pO6zJeLot6Sg/6xSg4MYtxA89Ag18bGz9zD6WGQDsNrXVuZvNkAjkmSamQxkdmqTld
         nRIhHNKReKgpeerWvMo+BoOh71ke8QyhxawQ1B9dOBbh7TqlDDsZKI6xVUD+7xrP8Ht7
         BKrarBfB/ejefrF9u/JGou/V2PFPY9cctZqUPFurE+d8oakepsu0AAVAPgUWqbZ509Fd
         QDN7HbXFOVT+opNIN+HhFGL53tAia+zkMfxSlpzCw2xtMGxzxBzFeJFkMX613qvJDqcE
         hcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yHznt9RNLvVaiHxz+XYmt8XlB6AXpFaSIDnqBvamPdg=;
        b=vdgIrS0tfs1IoBeQ7kezcLZjr3sRPW8C1mLtHnzGn+VFdQqbtLyNSqAI+NCbfD5zIB
         S6uDGv0K3yc3MOXnyhDfzpc7YKjjxYzkHbuoIVoCIlnFO2SuI++ETLJVTuggYZK4sfFS
         Q3XZdePmQo1Zj5OMS9zAGQsGS1BV1B7GRnNKfOdnoy5D/Qiaqzse5adhuSlOxZb8cB5q
         Ht+99IQLPSmAClX+VhvT5lY1UVxKRWJVhLY5Z0oVlMqsfbFhNjsmaR6F8c0HOdkgHPfh
         rGUQNpCzUq7PcXM3jBHvTW/rc0lyeRJC/SXEVNFkx2cr8+F+GR+wqQAkACh31RGtwaMI
         Btbg==
X-Gm-Message-State: AOAM533XrSHqTYothvkDNUTQz3SJGhLiFYqk838xB2TSnUm5CnrJIdIg
        p41KmiMOH70wjtTYbh7cdOxu6YG/QAA=
X-Google-Smtp-Source: ABdhPJwKyByZRst7XC+GEKfPlaSod7cnq8Aw3ONs3JYzVOM43vs8K2Ebxvi5LFBqndgGcPKSKdEDuw==
X-Received: by 2002:a9d:12d1:: with SMTP id g75mr26389986otg.301.1634069987426;
        Tue, 12 Oct 2021 13:19:47 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:4dad:ef1c:5d8f:8030? (2603-8081-140c-1a00-4dad-ef1c-5d8f-8030.res6.spectrum.com. [2603:8081:140c:1a00:4dad:ef1c:5d8f:8030])
        by smtp.gmail.com with ESMTPSA id 103sm2603523otj.44.2021.10.12.13.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 13:19:47 -0700 (PDT)
Subject: Re: [PATCH for-next 0/6] RDMA/rxe: Fix potential races
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20211010235931.24042-1-rpearsonhpe@gmail.com>
 <YWUskJBU5ZHrIhhS@unreal>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <bfb21e28-2f92-e372-871e-32c5f72338f4@gmail.com>
Date:   Tue, 12 Oct 2021 15:19:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YWUskJBU5ZHrIhhS@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/12/21 1:34 AM, Leon Romanovsky wrote:
> On Sun, Oct 10, 2021 at 06:59:25PM -0500, Bob Pearson wrote:
>> There are possible race conditions related to attempting to access
>> rxe pool objects at the same time as the pools or elements are being
>> freed. This series of patches addresses these races.
> 
> Can we get rid of this pool?
> 
> Thanks
> 
>>
>> Bob Pearson (6):
>>   RDMA/rxe: Make rxe_alloc() take pool lock
>>   RDMA/rxe: Copy setup parameters into rxe_pool
>>   RDMA/rxe: Save object pointer in pool element
>>   RDMA/rxe: Combine rxe_add_index with rxe_alloc
>>   RDMA/rxe: Combine rxe_add_key with rxe_alloc
>>   RDMA/rxe: Fix potential race condition in rxe_pool
>>
>>  drivers/infiniband/sw/rxe/rxe_mcast.c |   5 +-
>>  drivers/infiniband/sw/rxe/rxe_mr.c    |   1 -
>>  drivers/infiniband/sw/rxe/rxe_mw.c    |   5 +-
>>  drivers/infiniband/sw/rxe/rxe_pool.c  | 235 +++++++++++++-------------
>>  drivers/infiniband/sw/rxe/rxe_pool.h  |  67 +++-----
>>  drivers/infiniband/sw/rxe/rxe_verbs.c |  10 --
>>  6 files changed, 140 insertions(+), 183 deletions(-)
>>
>> -- 
>> 2.30.2
>>

Not sure which 'this' you mean? This set of patches is motivated by someone at HPE
running into seg faults caused very infrequently by rdma packets causing seg faults
when trying to copy data to or from an MR. This can only happen (other than just dumb
bug which doesn't seem to be the case) by a late packet arriving after the MR is
de-registered. The root cause of that is the way rxe currently defers cleaning up
objects with krefs and potential races between cleanup and new packets looking up
rkeys. I found a lot of potential race conditions and tried to close them off. There
are another couple of patches coming as well.

This is an attempt to fix up the code the way it is now. Later I would like to use
xarrays to handle rkey indices and qpns etc which looks cleaner.

Pools is mostly a misnomer since you moved all the allocates into rdma-core except for
a couple. Really they are a way to add indices or keys to the objects that are already
there.

Bob
