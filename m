Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CF34368F2
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 19:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhJURXd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 13:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhJURXc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Oct 2021 13:23:32 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9E2C061764
        for <linux-rdma@vger.kernel.org>; Thu, 21 Oct 2021 10:21:16 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id l24-20020a9d1c98000000b00552a5c6b23cso1252807ota.9
        for <linux-rdma@vger.kernel.org>; Thu, 21 Oct 2021 10:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=QmXkcDHYmHMjMiLNip9P8jlz1FFNJ26CdQurv+++pFo=;
        b=WVC0SDI0zkkVLsu7vYbVtGSy1S3X4kGR/tBLpzIAsWNBEmcPQuHfZqAfr2eG9yLB9B
         1PEa1OPFj2dUqCUw5A+4hna6+iwBJJ9qv/SflLyQpeysaJGgXswtwigiIVXADHSPV0qa
         YWE+ZrNixBd8iNxjSj4LsJZSSYX7P0VCSr/2m14kHPwOccdqbMH/rpryN355nXGiXk15
         ckaESGsLZsRPd6ihpoe5Fc+IgpkUX6AcJmcxTCHKMLNCma2kvX55OkbLNCBAmwjLPkJZ
         6P0udG891IRGSLUSa9pLRz4Q8qbdw5wJNdy7rbb/UA1lWuUhw9Hsgas/PU95FxFrNWSj
         0f0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QmXkcDHYmHMjMiLNip9P8jlz1FFNJ26CdQurv+++pFo=;
        b=oQIqgyazIAlMzzrSNMtRB0eiZviwHv5J162NTSJRbmBbjWneANQgONxYetHVMBNChA
         WVzcU8LPUMg8EXg6Vfew7ZlCCKgVBjm4mna3fZI3ZcbfA3vY/vTnVzSJN3gsiYduilvn
         X3pd6HgNbI9haDS0KFMlek46mainnZ+GqExInTo4Zd2DQOpjNNjZ+3FcYMZKe92eoReG
         516eUlr5e4Y5AABUKOtAlCBkamKcB1QyMD76naCMJqrD5pIn84fXjxn0Vp1e0bNiY5YB
         2bFXk8H1OjorECOgpdQS54RIrB0EdYxks2zDmEMIRxruRfQbmAeB9fPQweZ2o8WUk4dB
         aKoQ==
X-Gm-Message-State: AOAM5320ur7+WZx2PxRzoizvi4nQkHm98naV05XThuZne1wW++Dsgbq7
        WQYCtQggymB0JyqWiowklCUjwkxNMf4=
X-Google-Smtp-Source: ABdhPJxivfkS4lAeG/WqooVExeWenLDm6uC25Shoariw4RjsiD2JVRq78M9bVbiQlUOq291frCHbRg==
X-Received: by 2002:a05:6830:1482:: with SMTP id s2mr5952933otq.382.1634836876134;
        Thu, 21 Oct 2021 10:21:16 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:604c:7dbe:eb8:ab92? (2603-8081-140c-1a00-604c-7dbe-0eb8-ab92.res6.spectrum.com. [2603:8081:140c:1a00:604c:7dbe:eb8:ab92])
        by smtp.gmail.com with ESMTPSA id l19sm1303462otu.11.2021.10.21.10.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 10:21:15 -0700 (PDT)
Subject: Re: [PATCH for-next 3/6] RDMA/rxe: Save object pointer in pool
 element
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20211010235931.24042-1-rpearsonhpe@gmail.com>
 <20211010235931.24042-4-rpearsonhpe@gmail.com>
 <20211020232051.GA28606@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <394c9270-77bb-1195-9422-bd2d5715e2bd@gmail.com>
Date:   Thu, 21 Oct 2021 12:21:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211020232051.GA28606@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/20/21 6:20 PM, Jason Gunthorpe wrote:
> On Sun, Oct 10, 2021 at 06:59:28PM -0500, Bob Pearson wrote:
>> In rxe_pool.c currently there are many cases where it is necessary to
>> compute the offset from a pool element struct to the object containing
>> the pool element in a type independent way. By saving a pointer to the
>> object when they are created extra work can be saved.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_pool.c | 16 +++++++++-------
>>  drivers/infiniband/sw/rxe/rxe_pool.h |  1 +
>>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> This would be better to just add a static_assert or build_bug_on that
> the offsetof() the rxe_pool_entry == 0. There is no reason for these
> to be sprinkled at every offset
> 
> Then you don't need to do anything at all
> 
> Jason
> 
I think you missed something. Once upon a time all the rxe objects had the local
pool entry struct followed by the ib_xx struct and then anything else needed locally.
As Leon has been moving the allocations to rdma-core he had to make the ib_xx struct 
first followed by the pool element. So there is a mish mash of offsets. Some
are/were 0, and the rest are all different depending on the size of the struct from
rdma-core. E.g. sizeof(struct ib_mr) != sizeof(struct ib_qp), etc. In order to make
the API simple and consistent I use a macro to convert from object to pool elem. e.g.

	#define some_function(void *obj) __some_function(&obj->elem)

but to convert back from elem to obj we need to subtract some random offset e.g.

	obj = elem->obj;

without knowing the type of obj which is simpler than what we had before, roughly

	struct rxe_pool_info *info = &pool_info[elem->pool->type];

	obj = (u8 *)(elem - info->elem_offset);
