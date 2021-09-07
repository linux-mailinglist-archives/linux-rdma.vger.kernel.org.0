Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA11402CE4
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Sep 2021 18:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbhIGQg0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Sep 2021 12:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhIGQg0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Sep 2021 12:36:26 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6445C061575
        for <linux-rdma@vger.kernel.org>; Tue,  7 Sep 2021 09:35:19 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso13524010otp.1
        for <linux-rdma@vger.kernel.org>; Tue, 07 Sep 2021 09:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PxAOXNyXGvc6GA+L4efBnKL4YAk6IfQVk17G78O+RRE=;
        b=JUfM8gmSzMETVCKch6P+Kv3IFIlwYQ469xIKfGof4zAAeeJHLu580va9pUocH5bR4k
         LBNIHWln0+uXhIghTMCuzTqFvm2lOx2sBzc4LF+1QBaMPxusnuw1aEil+YtAasnYqioe
         1pGsLUyBJjxxW50IcGpzJWeZHekKsbRXTO1MDVSOQQIPR1JFZqWzV5hydETHlBulmYKk
         wVUWh2eyqTEAKTI1GDXUjSVFXWnIZddIuMq380RJrGDZe1pTU0JO9cuXS0Dbby5LF6gq
         kB6C5RHTmFEOyun6LLm8ykQ/2VG9ter6Fimwp0e5aHuX0fE5vJtO/e03GpjgoOWY7qG7
         Q88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PxAOXNyXGvc6GA+L4efBnKL4YAk6IfQVk17G78O+RRE=;
        b=rfh2WMNRofQfBxMtf0TbDcGFpneyV94RL3BoBZiXBk97n1rZPechQg/qwXLpcsfUsP
         GBONkcYD/JZmkClC1Evn8BZ0Epg5ZMSn5R+HLTQaIvma4pZ2dnkuR7O8m4fhaqa/9RT6
         EhZPyh0MgdicyoMJvuCquPaeuqrKOgLaCd5TEXxmDpUK9ABPPCvJjaSlpts2UUsTmTQC
         XPtpNtkIC5CAri5WfVFNKyzUDqQYCty7xxHyKf9Xe81PV+WGIjZHcJOGbzwq8dH0vUM0
         xErrUM4HLgUFU0moaAJ2E6kZbC/AaGT6eQLP66+rfH9i5NagFxT+MMVY16vXKU7w9Z2C
         wL5g==
X-Gm-Message-State: AOAM530NQiwWWzd1EycXKKmfz3NWYaizpZP0kvJC9NamZx8G+EfzRZOO
        fLFuLbhvCsijqxFjAFXhV2k0bhJp9eA=
X-Google-Smtp-Source: ABdhPJya3uBPjfBJd9lGrQJqqWz8pKMWzUOfjRcRAtec54j9E5les9jjm6dUJCCtWmubG1k5hfCKjw==
X-Received: by 2002:a9d:450b:: with SMTP id w11mr16753297ote.254.1631032518673;
        Tue, 07 Sep 2021 09:35:18 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:bc73:7f2:84bb:9731? (2603-8081-140c-1a00-bc73-07f2-84bb-9731.res6.spectrum.com. [2603:8081:140c:1a00:bc73:7f2:84bb:9731])
        by smtp.gmail.com with ESMTPSA id o126sm2180786oig.21.2021.09.07.09.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 09:35:18 -0700 (PDT)
Subject: Re: blktest/rxe almost working
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <c7557529-d07d-3e35-0f03-2bbe867af4a1@gmail.com>
 <20210902233853.GB2505917@nvidia.com>
 <1610313b-e5d0-a687-a409-d1275baf7f95@gmail.com>
 <711c089d-ce66-63e8-4d80-0bd19f22607c@acm.org>
 <20210904223056.GC2505917@nvidia.com>
 <fcf6f57e-972b-f88e-84bf-d1618fd3e23e@gmail.com>
 <20210907120156.GV1200268@ziepe.ca>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <9e6783d0-554c-17de-c72f-fae766099480@gmail.com>
Date:   Tue, 7 Sep 2021 11:35:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907120156.GV1200268@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/7/21 7:01 AM, Jason Gunthorpe wrote:
> On Sun, Sep 05, 2021 at 01:02:45PM -0500, Bob Pearson wrote:
>> On 9/4/21 5:30 PM, Jason Gunthorpe wrote:
>>> On Fri, Sep 03, 2021 at 04:13:22PM -0700, Bart Van Assche wrote:
>>>> On 9/3/21 3:18 PM, Bob Pearson wrote:
>>>>> On 9/2/21 6:38 PM, Jason Gunthorpe wrote:
>>>>>> On Thu, Sep 02, 2021 at 04:41:15PM -0500, Bob Pearson wrote:
>>>>>>> Now that for-next is on 5.14.0-rc6+ blktest srp/002 is very close to
>>>>>>> working for rxe but there is still one error. After adding MW
>>>>>>> support I added a test to local invalidate to check and see if the
>>>>>>> l/rkey matched the key actually contained in the MR/MW when local
>>>>>>> invalidate is called. This is failing for srp/002 with the key
>>>>>>> portion of the rkey off by one. Looking at ib_srp.c I see code that
>>>>>>> does in fact increment the rkey by one and also has code that posts
>>>>>>> a local invalidate. This was never checked before and is now failing
>>>>>>> to match. If I mask off the key portion in the test the whole test
>>>>>>> case passes so the other problems appear to have been fixed. If the
>>>>>>> increment and invalidate are out of sync this could result in the
>>>>>>> error. I suspect this may be a bug in srp. Worst case I can remove
>>>>>>> this test but I would rather not.
>>>>>>
>>>>>> I didn't check the spec, but since SRP works with HW devices I wonder
>>>>>> if invalidation is supposed to ignore the variant bits in the mkey?
>>>>>
>>>>> I am a little worried. srp is pretty complex but roughly it looks like it maintains a pool of
>>>>> MRs which it recycles. Each time it reuses the MR it increments the key portion of the rkey. Before
>>>>> that it uses local invalidate WRs to invalidate the MRs presumably to prevent stray accesses
>>>>> to the old version of the MR from e.g. replicated packets. It posts these WRs to a send queue but I
>>>>> don't see where it closes the loop by waiting for a WC so there may be a race between the invalidate
>>>>> and the subsequent map_sg call. The invalidate marks the MR as not usable so this must all happen
>>>>> before the MR is turned on again.
>>>>
>>>> Hi Bob,
>>>>
>>>> If there would be any code in the SRP driver that is not compliant with the
>>>> IBTA specification then I can fix it.
>>>>
>>>> Regarding the invalidate work requests submitted by the ib_srp driver: these
>>>> are submitted before srp_fr_pool_put() is called. A new registration request
>>>> is submitted after srp_fr_pool_get() succeeds. There is one MR pool per RDMA
>>>> channel and there is one QP per RDMA channel. In other words,
>>>> (re)registration requests are submitted to the same QP as unregistration
>>>> requests after local invalidate requests. I think the IBTA requires does not
>>>> allow to reorder a local invalidate followed by a fast registration request.
>>>
>>> Right
>>>
>>> Jason
>>>
>>
>> srp_inv_rkey()
>> 	wr = ...			builds local invalidate WR
>> 	wr.send_flags = 0		i.e. not signaled
>> 	ib_post_send()			posts the WR for delayed execution
>>
>> srp_unmap_data()
>> 	srp_inv_rkey()			schedules invalidate of each rkey in req
>> 	srp_fr_pool_put()		puts each desc entry on free list
>>
>> srp_map_finish_fr()
>> 	...				misc checks not relevant
>> 	desc = srp_fr_pool_get()	returns desc from free list
>> 	rkey = ib_inc_rkey()		gets a new rkey one larger than the last one
>> 	ib_update_fast_reg_key()	immediately changes mr->rkey to new value
>> 	ib_map_mr_sg()			immediately updates buffer list in MR to new values
>> 	wr = ...			set WR to REG_MR work request not signaled
>> 	wr.key = new rkey
>> 	ib_post_send()			wr is posted for delayed execution
>>
>> So as soon as the MR has had a WR posted to invalidate it the code goes ahead and adds it to the
>> free list and then as soon as a new MR is gotten from the free list the rkey and mappings are
>> changed and then a WR is posted to 'register' the MR which marks it as valid again. The register
>> WR *also* resets the rkey which is redundant with the ib_update_fast_reg_key() call.
>>
>> All the work except for setting the state valid is done immediately regardless of the status of the
>> completion of the previous invalidate and can complete before the MR is marked FREE. Because the WR
>> is not signaled no one is checking the WC for these operations unless there is an error.
> 
> "HW" is not supposed to look at mr->rkey.
> 
> "HW" has a hidden cache of mr->rkey which is manipulated through
> WQEs, and is then synchronous with the WQE stream as Bart said.
> 
> So it sounds like the problem is rxe is crossing the HW and SW layers
> and checking the mr->rkey from HW logic instead of holding a 2nd HW
> specific value for HW to use.
> 
> Jason
> 

Interesting. But if that is the case the bigger problem is the ib_map_mr_sg() call which updates the
mapping. rxe definitely does look at the mr->rkey value but we could fix that. It also looks at the
mapping which is updated by ib_map_mr_sg(). My impression is that HW also uses this mapping or does
HW also copy all the FMRs into SRAM? By not closing the loop on the invalidate by looking at the CQE
the srp driver exposes the MR with changing mappings to the new values through either the old or new
rkey depending on whether you cache the rkey.

There is a suggestive comment in ib_verbs.h
        /*

         * Kernel users should universally support relaxed ordering (RO), as

         * they are designed to read data only after observing the CQE and use

         * the DMA API correctly.

         *

         * Some drivers implicitly enable RO if platform supports it.

         */

        int (*map_mr_sg)(struct ib_mr *mr, struct scatterlist *sg, int sg_nents,

                         unsigned int *sg_offset);

There seems to be an assumption that users will be looking at CQE.

Bob




