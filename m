Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B72402824
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Sep 2021 14:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236985AbhIGMDF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Sep 2021 08:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbhIGMDE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Sep 2021 08:03:04 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF2EC061575
        for <linux-rdma@vger.kernel.org>; Tue,  7 Sep 2021 05:01:58 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id p17so5598707qvo.8
        for <linux-rdma@vger.kernel.org>; Tue, 07 Sep 2021 05:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rb65xiM3+qNannYBt9/w71RublvsJvlJ/2ZzS7fc31U=;
        b=ORfJmEfqJsgOcoMwEBISUaRr47IazJi+jHBXFZUYYNUnSfSsjdw0ut95tscMWRHPy5
         T/IOVHeaaFAYRlgA6o1q3AyJ7XzjKnKlTzzZuZ8I6GiUChjl5cifgYcSnNNhNZrWtgZK
         sADPgiPlOT7+YseRyZpJlhEt6PvADqIQJMhVdBjxUcJS3XiNE5XVb0n5hOKRXbHxAhMc
         cyJNGTgAQkEXzM66mxIMMtF8zwTg87Zo7gZfE5pYBfjjU8YnBbweR4U7oEEmiX5UlrHZ
         /Kns1icaICh5XdMbxh1XKZJEGZ430UattTrQ+7+76UI/rfByXvD4a794rMf3ITjyHe0R
         3Pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rb65xiM3+qNannYBt9/w71RublvsJvlJ/2ZzS7fc31U=;
        b=C87MW9nuhQXdzKlbdX4PVGHofZ3vh6M+jbVTCB7Sxd+XFce3fjWdo0rxQsXlTyGnoH
         E6EisXg+/2gTRwfRxXgKdenpSfWIn2f7uwqTHu90eP5U2rnD88ud2nWJPaGMRj06wY7j
         vQrlPIQ5hck9GL0lJ+0TO9NFt5QPUVGe3QrmN560QON6gAuPoVEp7w14tX6UD5lt2E9N
         7uOfMgaPE04qbKz6JEN6GdbU0slvvbfHaQh3JZRPgTTWX5HJ2sedJEQylxhrdasl+W7x
         yRbemB6Leg2xW6KuKU/yEwdunACCNTHTuPM3u/wNWeUsQ7ve9KZkpzotsSsGPzoPZNvS
         FEdw==
X-Gm-Message-State: AOAM531sDJJvL99Goy+YNnH5hgdWDJnFYkbZYWPjC/Fvhvwi3b12tGdd
        HCob2o48EcFhcRdtzZI7YtOjDd2SaCWVnw==
X-Google-Smtp-Source: ABdhPJypcSnsBdXNF6ynIPy9POYs/FIacErXyVrdj53+RZ5noz4QjfWlSdzo04yDpZDy+LWMyVtc7Q==
X-Received: by 2002:a0c:e1cf:: with SMTP id v15mr16473658qvl.50.1631016117663;
        Tue, 07 Sep 2021 05:01:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id b7sm7090782qtt.12.2021.09.07.05.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:01:56 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mNZnY-00CDl5-8I; Tue, 07 Sep 2021 09:01:56 -0300
Date:   Tue, 7 Sep 2021 09:01:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: blktest/rxe almost working
Message-ID: <20210907120156.GV1200268@ziepe.ca>
References: <c7557529-d07d-3e35-0f03-2bbe867af4a1@gmail.com>
 <20210902233853.GB2505917@nvidia.com>
 <1610313b-e5d0-a687-a409-d1275baf7f95@gmail.com>
 <711c089d-ce66-63e8-4d80-0bd19f22607c@acm.org>
 <20210904223056.GC2505917@nvidia.com>
 <fcf6f57e-972b-f88e-84bf-d1618fd3e23e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcf6f57e-972b-f88e-84bf-d1618fd3e23e@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 05, 2021 at 01:02:45PM -0500, Bob Pearson wrote:
> On 9/4/21 5:30 PM, Jason Gunthorpe wrote:
> > On Fri, Sep 03, 2021 at 04:13:22PM -0700, Bart Van Assche wrote:
> >> On 9/3/21 3:18 PM, Bob Pearson wrote:
> >>> On 9/2/21 6:38 PM, Jason Gunthorpe wrote:
> >>>> On Thu, Sep 02, 2021 at 04:41:15PM -0500, Bob Pearson wrote:
> >>>>> Now that for-next is on 5.14.0-rc6+ blktest srp/002 is very close to
> >>>>> working for rxe but there is still one error. After adding MW
> >>>>> support I added a test to local invalidate to check and see if the
> >>>>> l/rkey matched the key actually contained in the MR/MW when local
> >>>>> invalidate is called. This is failing for srp/002 with the key
> >>>>> portion of the rkey off by one. Looking at ib_srp.c I see code that
> >>>>> does in fact increment the rkey by one and also has code that posts
> >>>>> a local invalidate. This was never checked before and is now failing
> >>>>> to match. If I mask off the key portion in the test the whole test
> >>>>> case passes so the other problems appear to have been fixed. If the
> >>>>> increment and invalidate are out of sync this could result in the
> >>>>> error. I suspect this may be a bug in srp. Worst case I can remove
> >>>>> this test but I would rather not.
> >>>>
> >>>> I didn't check the spec, but since SRP works with HW devices I wonder
> >>>> if invalidation is supposed to ignore the variant bits in the mkey?
> >>>
> >>> I am a little worried. srp is pretty complex but roughly it looks like it maintains a pool of
> >>> MRs which it recycles. Each time it reuses the MR it increments the key portion of the rkey. Before
> >>> that it uses local invalidate WRs to invalidate the MRs presumably to prevent stray accesses
> >>> to the old version of the MR from e.g. replicated packets. It posts these WRs to a send queue but I
> >>> don't see where it closes the loop by waiting for a WC so there may be a race between the invalidate
> >>> and the subsequent map_sg call. The invalidate marks the MR as not usable so this must all happen
> >>> before the MR is turned on again.
> >>
> >> Hi Bob,
> >>
> >> If there would be any code in the SRP driver that is not compliant with the
> >> IBTA specification then I can fix it.
> >>
> >> Regarding the invalidate work requests submitted by the ib_srp driver: these
> >> are submitted before srp_fr_pool_put() is called. A new registration request
> >> is submitted after srp_fr_pool_get() succeeds. There is one MR pool per RDMA
> >> channel and there is one QP per RDMA channel. In other words,
> >> (re)registration requests are submitted to the same QP as unregistration
> >> requests after local invalidate requests. I think the IBTA requires does not
> >> allow to reorder a local invalidate followed by a fast registration request.
> > 
> > Right
> > 
> > Jason
> > 
> 
> srp_inv_rkey()
> 	wr = ...			builds local invalidate WR
> 	wr.send_flags = 0		i.e. not signaled
> 	ib_post_send()			posts the WR for delayed execution
> 
> srp_unmap_data()
> 	srp_inv_rkey()			schedules invalidate of each rkey in req
> 	srp_fr_pool_put()		puts each desc entry on free list
> 
> srp_map_finish_fr()
> 	...				misc checks not relevant
> 	desc = srp_fr_pool_get()	returns desc from free list
> 	rkey = ib_inc_rkey()		gets a new rkey one larger than the last one
> 	ib_update_fast_reg_key()	immediately changes mr->rkey to new value
> 	ib_map_mr_sg()			immediately updates buffer list in MR to new values
> 	wr = ...			set WR to REG_MR work request not signaled
> 	wr.key = new rkey
> 	ib_post_send()			wr is posted for delayed execution
> 
> So as soon as the MR has had a WR posted to invalidate it the code goes ahead and adds it to the
> free list and then as soon as a new MR is gotten from the free list the rkey and mappings are
> changed and then a WR is posted to 'register' the MR which marks it as valid again. The register
> WR *also* resets the rkey which is redundant with the ib_update_fast_reg_key() call.
> 
> All the work except for setting the state valid is done immediately regardless of the status of the
> completion of the previous invalidate and can complete before the MR is marked FREE. Because the WR
> is not signaled no one is checking the WC for these operations unless there is an error.

"HW" is not supposed to look at mr->rkey.

"HW" has a hidden cache of mr->rkey which is manipulated through
WQEs, and is then synchronous with the WQE stream as Bart said.

So it sounds like the problem is rxe is crossing the HW and SW layers
and checking the mr->rkey from HW logic instead of holding a 2nd HW
specific value for HW to use.

Jason
