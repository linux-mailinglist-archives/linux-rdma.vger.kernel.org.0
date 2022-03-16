Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010194DA92A
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 05:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiCPEHE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Mar 2022 00:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiCPEHD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Mar 2022 00:07:03 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168C95DA73
        for <linux-rdma@vger.kernel.org>; Tue, 15 Mar 2022 21:05:50 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id b188so1358454oia.13
        for <linux-rdma@vger.kernel.org>; Tue, 15 Mar 2022 21:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nFSdYpivINo9SxTPpleyjnt/+J76RFp8E7ULJ5As7rc=;
        b=MTOevueEjx2/TCC1pnKHDND/kBE9jS9eA0JCGRiXmJLkxfWOeAscpdad2d+WA7xXBO
         EEY1kkZxDtpbrEn2gvfrC7gfG1plOhFPH0zWuCs1bdCjlHOPw/BvK5Xzkzl2CMrQsjex
         zJGfUDcQttCa9gTzhg4verM+C+W2YbB93JUsEH7mlXcphvNlFtBjrQqByZjR6mVm+yY9
         dlUwu+Z8qRk0ka/dh+NOvLqyVBiTKSBLPZmEDeTfDqJF3AoUQd1oIJKX7w7A5Zl0l/yP
         9P8dw6od7QcENhIk4sPSnuqXdi4K+np8twhKsdLX0/V9atas8RcuL1ezk6QFtTh/57x1
         RzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nFSdYpivINo9SxTPpleyjnt/+J76RFp8E7ULJ5As7rc=;
        b=dg+NG/zS+I9JK+hBetQ8OiZyMNbG7lYw08Q7gqo9fjJzfQ9UFYGJTb5Md78Nx7VUjF
         9lGOOYvbcz6SrXwdysCDzxsIK0GLTreDtPv9DGd1+nWSmslNkIyeeadyKG4+/+dDt+1f
         EFq/4XrdFiiH9Oo6SJ8AlegXqal947D0iOtSje/YFYFcygmxf/+PQ40dC1CZlS1vDy1I
         6M/vNTPCJxz8l9z18TfEn5+jPppYnwHowVLaqG0h8uSXLubRAipm5pi9AmUD7JTfW/+3
         b8l0ihDTAdLacUEQY7CCEct/prlxQWt5bHCWspaybE0G7XYdfmG+xPRb57RxcolfA0wo
         XPNQ==
X-Gm-Message-State: AOAM5338JeNUDShYVS+ZdDLUMEApnPqVojoz7U2KJqXHgVaA0SUZ87dc
        3vT5M4IaMxhfPOAAnDOACbGhiRSDwDs=
X-Google-Smtp-Source: ABdhPJzc60EM8dqI4qIGYon2l77Ze0UlSSkdTEP7AUW4ew6wZeN7oxUTdzT9Zu6U+y6B4ecroFlMpA==
X-Received: by 2002:aca:3587:0:b0:2ec:a23c:e197 with SMTP id c129-20020aca3587000000b002eca23ce197mr3062590oia.47.1647403549469;
        Tue, 15 Mar 2022 21:05:49 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:744:9605:b0bf:1b15? (2603-8081-140c-1a00-0744-9605-b0bf-1b15.res6.spectrum.com. [2603:8081:140c:1a00:744:9605:b0bf:1b15])
        by smtp.gmail.com with ESMTPSA id q16-20020a9d4b10000000b005b22b93d468sm387556otf.74.2022.03.15.21.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 21:05:49 -0700 (PDT)
Message-ID: <883b72de-850c-7b4d-fdaf-457f23d309ea@gmail.com>
Date:   Tue, 15 Mar 2022 23:05:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH for-next v11 00/13] Fix race conditions in rxe_pool
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
 <20220316002515.GZ11336@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220316002515.GZ11336@nvidia.com>
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

On 3/15/22 19:25, Jason Gunthorpe wrote:
> On Thu, Mar 03, 2022 at 06:07:56PM -0600, Bob Pearson wrote:
>> There are several race conditions discovered in the current rdma_rxe
>> driver.  They mostly relate to races between normal operations and
>> destroying objects.  This patch series
>>  - Makes several minor cleanups in rxe_pool.[ch]
>>  - Replaces the red-black trees currently used by xarrays for indices
>>  - Corrects several reference counting errors
>>  - Adds wait for completions to the paths in verbs APIs which destroy
>>    objects.
>>  - Changes read side locking to rcu.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> v11
>>   Rebased to current for-next.
>>   Reordered patches and made other changes to respond to issues
>>   reported by Jason Gunthorpe.
>> v10
>>   Rebased to current wip/jgg-for-next.
>>   Split some patches into smaller ones.
>> v9
>>   Corrected issues reported by Jason Gunthorpe,
>>   Converted locking in rxe_mcast.c and rxe_pool.c to use RCU
>>   Split up the patches into smaller changes
>> v8
>>   Fixed an additional race in 3/8 which was not handled correctly.
>> v7
>>   Corrected issues reported by Jason Gunthorpe
>> Link: https://lore.kernel.org/linux-rdma/20211207190947.GH6385@nvidia.com/
>> Link: https://lore.kernel.org/linux-rdma/20211207191857.GI6385@nvidia.com/
>> Link: https://lore.kernel.org/linux-rdma/20211207192824.GJ6385@nvidia.com/
>> v6
>>   Fixed a kzalloc flags bug.
>>   Fixed comment bug reported by 'Kernel Test Robot'.
>>   Changed type of rxe_pool.c in __rxe_fini().
>> v5
>>   Removed patches already accepted into for-next and addressed comments
>>   from Jason Gunthorpe.
>> v4
>>   Restructured patch series to change to xarray earlier which
>>   greatly simplified the changes.
>>   Rebased to current for-next
>> v3
>>   Changed rxe_alloc to use GFP_KERNEL
>>   Addressed other comments by Jason Gunthorp
>>   Merged the previous 06/10 and 07/10 patches into one since they overlapped
>>   Added some minor cleanups as 10/10
>> v2
>>   Rebased to current for-next.
>>   Added 4 additional patches
>>
>> Bob Pearson (13):
>>   RDMA/rxe: Fix ref error in rxe_av.c
>>   RDMA/rxe: Replace mr by rkey in responder resources
>>   RDMA/rxe: Reverse the sense of RXE_POOL_NO_ALLOC
>>   RDMA/rxe: Delete _locked() APIs for pool objects
>>   RDMA/rxe: Replace obj by elem in declaration
>>   RDMA/rxe: Move max_elem into rxe_type_info
>>   RDMA/rxe: Shorten pool names in rxe_pool.c
>>   RDMA/rxe: Replace red-black trees by xarrays
>>   RDMA/rxe: Use standard names for ref counting
> 
> If you let me know about the WARN_ON I think up to here is good
> 
> Thanks,
> Jason

I agreed to the change.
