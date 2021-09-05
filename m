Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A9A401119
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Sep 2021 20:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbhIESDv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Sep 2021 14:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbhIESDu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Sep 2021 14:03:50 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D99DC061575
        for <linux-rdma@vger.kernel.org>; Sun,  5 Sep 2021 11:02:47 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id i3-20020a056830210300b0051af5666070so5819368otc.4
        for <linux-rdma@vger.kernel.org>; Sun, 05 Sep 2021 11:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WUK+TN4e7ClR3tGxA2YIGGi/kNwHTSYwcwhhOVpLQCg=;
        b=aHuaFj9Xxt34z/dto52XpGr7n7cUYsV2645aKypfk5q+h/nZuKOyXDrv9eqxNpphfJ
         3B5dLI9WtvuNUUGKlXY0L7Ks0UzvQV4VjxYfQOeCfSpb6ErxuSsGHPHtvhNZ+TECEvJL
         obVmUCQpunVftiqRgTAU8YdNk7rL4IoniBNG5g5dm2wsFcXKqR3Xv4JH7lzwx3OrgqmE
         I8W1Sxj793FTCj7nDZx9vgK1tXCCSXfZkNLyA0qrKfd5coh9KwHEw736G66XwICddE84
         Kcdd2IUkVPvtGG8xecXYxRwI8GEC7W/V44TdUin89tSrEjyeO24EKsMnTI5D5iRvskpE
         qP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WUK+TN4e7ClR3tGxA2YIGGi/kNwHTSYwcwhhOVpLQCg=;
        b=uWopgPPngpuZ60qqkS8fAeDOnMafWwVNNMg+q6EGLs0JvnRtVDs/Javxusg04zrFer
         D5TZJRVzARjgYQe87WLdgis/JcS7+RkwxrMHGVHbWrVtNoNldYRXO/J4MNV5zHaLCGTD
         8ayaNEl+JEkpU4EcScUPEmywihe217ALZLNsEOcLoyCFMBr2M0r9LpIKRZ7ELsxSMkFh
         478+rQcwxY9r4QiicCNfNtny43m0CMpnhQ1RRFaOliJwb/5kZKM55mD05306sbvK5CcV
         DIv1AEl7zyvodtkrXVsAHcV/l1N6CZbtLvR9YBKC5sfBjemgJmYA8ZvTNy/UUgMkhvp8
         u+YQ==
X-Gm-Message-State: AOAM532xfjGtnMeGxS5qz08lK9wkEohTwz9sHQ/DzqIj2wZzc1Bfzjvi
        9li9geUhtAA8FCvmWjUlTxutNGsfmfI=
X-Google-Smtp-Source: ABdhPJze1zgm8tCWVmuGvpniFAbr96x+o5dm7gnSyMOTk5+B3cKGqfVOBchZ8K6+kosCdtHDZU/W7w==
X-Received: by 2002:a9d:75d5:: with SMTP id c21mr7684322otl.118.1630864966516;
        Sun, 05 Sep 2021 11:02:46 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:a82a:d18a:52f2:c19a? (2603-8081-140c-1a00-a82a-d18a-52f2-c19a.res6.spectrum.com. [2603:8081:140c:1a00:a82a:d18a:52f2:c19a])
        by smtp.gmail.com with ESMTPSA id r31sm1286579otv.45.2021.09.05.11.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 11:02:46 -0700 (PDT)
Subject: Re: blktest/rxe almost working
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <c7557529-d07d-3e35-0f03-2bbe867af4a1@gmail.com>
 <20210902233853.GB2505917@nvidia.com>
 <1610313b-e5d0-a687-a409-d1275baf7f95@gmail.com>
 <711c089d-ce66-63e8-4d80-0bd19f22607c@acm.org>
 <20210904223056.GC2505917@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <fcf6f57e-972b-f88e-84bf-d1618fd3e23e@gmail.com>
Date:   Sun, 5 Sep 2021 13:02:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210904223056.GC2505917@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/4/21 5:30 PM, Jason Gunthorpe wrote:
> On Fri, Sep 03, 2021 at 04:13:22PM -0700, Bart Van Assche wrote:
>> On 9/3/21 3:18 PM, Bob Pearson wrote:
>>> On 9/2/21 6:38 PM, Jason Gunthorpe wrote:
>>>> On Thu, Sep 02, 2021 at 04:41:15PM -0500, Bob Pearson wrote:
>>>>> Now that for-next is on 5.14.0-rc6+ blktest srp/002 is very close to
>>>>> working for rxe but there is still one error. After adding MW
>>>>> support I added a test to local invalidate to check and see if the
>>>>> l/rkey matched the key actually contained in the MR/MW when local
>>>>> invalidate is called. This is failing for srp/002 with the key
>>>>> portion of the rkey off by one. Looking at ib_srp.c I see code that
>>>>> does in fact increment the rkey by one and also has code that posts
>>>>> a local invalidate. This was never checked before and is now failing
>>>>> to match. If I mask off the key portion in the test the whole test
>>>>> case passes so the other problems appear to have been fixed. If the
>>>>> increment and invalidate are out of sync this could result in the
>>>>> error. I suspect this may be a bug in srp. Worst case I can remove
>>>>> this test but I would rather not.
>>>>
>>>> I didn't check the spec, but since SRP works with HW devices I wonder
>>>> if invalidation is supposed to ignore the variant bits in the mkey?
>>>
>>> I am a little worried. srp is pretty complex but roughly it looks like it maintains a pool of
>>> MRs which it recycles. Each time it reuses the MR it increments the key portion of the rkey. Before
>>> that it uses local invalidate WRs to invalidate the MRs presumably to prevent stray accesses
>>> to the old version of the MR from e.g. replicated packets. It posts these WRs to a send queue but I
>>> don't see where it closes the loop by waiting for a WC so there may be a race between the invalidate
>>> and the subsequent map_sg call. The invalidate marks the MR as not usable so this must all happen
>>> before the MR is turned on again.
>>
>> Hi Bob,
>>
>> If there would be any code in the SRP driver that is not compliant with the
>> IBTA specification then I can fix it.
>>
>> Regarding the invalidate work requests submitted by the ib_srp driver: these
>> are submitted before srp_fr_pool_put() is called. A new registration request
>> is submitted after srp_fr_pool_get() succeeds. There is one MR pool per RDMA
>> channel and there is one QP per RDMA channel. In other words,
>> (re)registration requests are submitted to the same QP as unregistration
>> requests after local invalidate requests. I think the IBTA requires does not
>> allow to reorder a local invalidate followed by a fast registration request.
> 
> Right
> 
> Jason
> 

srp_inv_rkey()
	wr = ...			builds local invalidate WR
	wr.send_flags = 0		i.e. not signaled
	ib_post_send()			posts the WR for delayed execution

srp_unmap_data()
	srp_inv_rkey()			schedules invalidate of each rkey in req
	srp_fr_pool_put()		puts each desc entry on free list

srp_map_finish_fr()
	...				misc checks not relevant
	desc = srp_fr_pool_get()	returns desc from free list
	rkey = ib_inc_rkey()		gets a new rkey one larger than the last one
	ib_update_fast_reg_key()	immediately changes mr->rkey to new value
	ib_map_mr_sg()			immediately updates buffer list in MR to new values
	wr = ...			set WR to REG_MR work request not signaled
	wr.key = new rkey
	ib_post_send()			wr is posted for delayed execution

So as soon as the MR has had a WR posted to invalidate it the code goes ahead and adds it to the
free list and then as soon as a new MR is gotten from the free list the rkey and mappings are
changed and then a WR is posted to 'register' the MR which marks it as valid again. The register
WR *also* resets the rkey which is redundant with the ib_update_fast_reg_key() call.

All the work except for setting the state valid is done immediately regardless of the status of the
completion of the previous invalidate and can complete before the MR is marked FREE. Because the WR
is not signaled no one is checking the WC for these operations unless there is an error.

The old code worked because the key part of the rkey wasn't checked for the invalidate. By changing
the rkey before the mappings random stray old RDMA operations will fail because the rkey is not
matching and not because the MR is not VALID. There is a theoretical risk here because the MR could
be accessed through the new rkey with either the new or old mappings or a mixture while the MR is
still VALID on the old mapping before the invalidate succeeds.

Many years ago when I first learned IB verbs, the fast registration was actually done as a WR which
posted an IO operation to update the mappings. The new API changed all that but still has little bit
left in the WRs.

Bob
