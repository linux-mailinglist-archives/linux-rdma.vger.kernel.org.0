Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0535B400822
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Sep 2021 01:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350675AbhICXO0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Sep 2021 19:14:26 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:37857 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350660AbhICXO0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Sep 2021 19:14:26 -0400
Received: by mail-pj1-f44.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so519443pjw.2
        for <linux-rdma@vger.kernel.org>; Fri, 03 Sep 2021 16:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zv0TqNkoBTE058Wa1J+6FsWqsAwO9lOSsBuSnSXJEzU=;
        b=RHeB1THpPZGRx15zttUT95Pm6JH/WqMw0S1a9qe6ydxv70dozIsZSLS7IGIL62VGLS
         csAh9U7B20jrp/WdQOnF8dmtZ4V7SZrx+U7XdXl0zYSlIthyA+UROyB+zDyzrq5UQEe/
         4MuvRuFP9y1WOUSzW87IYZ5qzhtK9vHg3T2kO2pO8a6k319bDTSABJ/CQBUoxasnoki8
         O6lB0IVwmvV0GWsYei5MIylTb5VvNwgYc5mJ5nyBziM/IBxNcc2DtuNZiw9ByMwBd/rf
         z2rBNyx4623d+M1LTMwvvwLrEl9AZowDeqaJxY5cPGnLSrfRSDD1IWxOr5pqikzAHMsE
         SjpQ==
X-Gm-Message-State: AOAM531SNUrVPdGH8YK4lvcquz2JEeZvuiSpWfDHWM+EBc1SxQngEnJT
        Z8Ol6y7UWqLM9Fi7oos83VvtLsI2MeI=
X-Google-Smtp-Source: ABdhPJyZtgkkGgIC8mOuBb0XCTT427doC3QjLMp43MJCVl0X8IW43PF/JFlj8xOP0DQjal/hQWSXpg==
X-Received: by 2002:a17:90a:311:: with SMTP id 17mr1267888pje.121.1630710804730;
        Fri, 03 Sep 2021 16:13:24 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3f54:6487:f0e0:810e])
        by smtp.gmail.com with ESMTPSA id y2sm273329pjl.6.2021.09.03.16.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 16:13:23 -0700 (PDT)
Subject: Re: blktest/rxe almost working
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <c7557529-d07d-3e35-0f03-2bbe867af4a1@gmail.com>
 <20210902233853.GB2505917@nvidia.com>
 <1610313b-e5d0-a687-a409-d1275baf7f95@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <711c089d-ce66-63e8-4d80-0bd19f22607c@acm.org>
Date:   Fri, 3 Sep 2021 16:13:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1610313b-e5d0-a687-a409-d1275baf7f95@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/3/21 3:18 PM, Bob Pearson wrote:
> On 9/2/21 6:38 PM, Jason Gunthorpe wrote:
>> On Thu, Sep 02, 2021 at 04:41:15PM -0500, Bob Pearson wrote:
>>> Now that for-next is on 5.14.0-rc6+ blktest srp/002 is very close to
>>> working for rxe but there is still one error. After adding MW
>>> support I added a test to local invalidate to check and see if the
>>> l/rkey matched the key actually contained in the MR/MW when local
>>> invalidate is called. This is failing for srp/002 with the key
>>> portion of the rkey off by one. Looking at ib_srp.c I see code that
>>> does in fact increment the rkey by one and also has code that posts
>>> a local invalidate. This was never checked before and is now failing
>>> to match. If I mask off the key portion in the test the whole test
>>> case passes so the other problems appear to have been fixed. If the
>>> increment and invalidate are out of sync this could result in the
>>> error. I suspect this may be a bug in srp. Worst case I can remove
>>> this test but I would rather not.
>>
>> I didn't check the spec, but since SRP works with HW devices I wonder
>> if invalidation is supposed to ignore the variant bits in the mkey?
> 
> I am a little worried. srp is pretty complex but roughly it looks like it maintains a pool of
> MRs which it recycles. Each time it reuses the MR it increments the key portion of the rkey. Before
> that it uses local invalidate WRs to invalidate the MRs presumably to prevent stray accesses
> to the old version of the MR from e.g. replicated packets. It posts these WRs to a send queue but I
> don't see where it closes the loop by waiting for a WC so there may be a race between the invalidate
> and the subsequent map_sg call. The invalidate marks the MR as not usable so this must all happen
> before the MR is turned on again.

Hi Bob,

If there would be any code in the SRP driver that is not compliant with 
the IBTA specification then I can fix it.

Regarding the invalidate work requests submitted by the ib_srp driver: 
these are submitted before srp_fr_pool_put() is called. A new 
registration request is submitted after srp_fr_pool_get() succeeds. 
There is one MR pool per RDMA channel and there is one QP per RDMA 
channel. In other words, (re)registration requests are submitted to the 
same QP as unregistration requests after local invalidate requests. I 
think the IBTA requires does not allow to reorder a local invalidate 
followed by a fast registration request.

Bart.

