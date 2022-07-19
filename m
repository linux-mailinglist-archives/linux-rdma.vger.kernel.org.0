Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58586579270
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jul 2022 07:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbiGSF1O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jul 2022 01:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbiGSF0p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jul 2022 01:26:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB1324BF1;
        Mon, 18 Jul 2022 22:26:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C092661591;
        Tue, 19 Jul 2022 05:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772D4C341C6;
        Tue, 19 Jul 2022 05:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658208404;
        bh=bkOVs9bpZgSJNv5tbjkfFp659Okff01K/tFuY0jID1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nIYNUuc/R/Z+xsQEKAo39MfAzQ6+WyipoaD8wCW7zOgWZF1Ljh6IiOs5VtjKMeHUT
         ci1yg205y+mZIOK2phhu6a4T+5xtCWNb4pAQkJQNQhIT6cQxYXa3pzOxlk6kLbejYC
         o9DPyPc2htsQ5x6EPep0OLJWgcNfKYBk1pYvgAi4MJvEBmMqQ41zHciqd5KSJKCnQy
         rNH/6RRMJGxM1TgcTKN4JfUkKYhssnSszIuhkNaUlPikDyQZiwALSOKLhE3NmohQQT
         OYQuGHyyncAGHQV+2eIn7r01M8aMTifIq90B1RYzyRRJyr4ROr+VKTjyH8kwCShZfw
         CqVIslXwZt7Jg==
Date:   Tue, 19 Jul 2022 08:26:39 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Jianglei Nie <niejianglei2021@163.com>, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/hfi1: fix potential memory leak in setup_base_ctxt()
Message-ID: <YtZAjwpqc0VjzlPw@unreal>
References: <20220711070718.2318320-1-niejianglei2021@163.com>
 <1038e814-5f0d-17a3-1331-8ed24a64d597@cornelisnetworks.com>
 <YtU4eXQCVEPGnh9b@unreal>
 <be437471-0080-8e9c-978a-6029c7826335@cornelisnetworks.com>
 <YtVSc7aazgxVFHRa@unreal>
 <62c8d684-6587-e560-6029-18fbe76ad8c4@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62c8d684-6587-e560-6029-18fbe76ad8c4@cornelisnetworks.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 18, 2022 at 09:56:48AM -0400, Dennis Dalessandro wrote:
> On 7/18/22 8:30 AM, Leon Romanovsky wrote:
> > On Mon, Jul 18, 2022 at 08:11:59AM -0400, Dennis Dalessandro wrote:
> >> On 7/18/22 6:39 AM, Leon Romanovsky wrote:
> >>> On Mon, Jul 11, 2022 at 07:52:25AM -0400, Dennis Dalessandro wrote:
> >>>> On 7/11/22 3:07 AM, Jianglei Nie wrote:
> >>>>> setup_base_ctxt() allocates a memory chunk for uctxt->groups with
> >>>>> hfi1_alloc_ctxt_rcv_groups(). When init_user_ctxt() fails, uctxt->groups
> >>>>> is not released, which will lead to a memory leak.
> >>>>>
> >>>>> We should release the uctxt->groups with hfi1_free_ctxt_rcv_groups()
> >>>>> when init_user_ctxt() fails.
> >>>>>
> >>>>> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> >>>>> ---
> >>>>>  drivers/infiniband/hw/hfi1/file_ops.c | 4 +++-
> >>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
> >>>>> index 2e4cf2b11653..629beff053ad 100644
> >>>>> --- a/drivers/infiniband/hw/hfi1/file_ops.c
> >>>>> +++ b/drivers/infiniband/hw/hfi1/file_ops.c
> >>>>> @@ -1179,8 +1179,10 @@ static int setup_base_ctxt(struct hfi1_filedata *fd,
> >>>>>  		goto done;
> >>>>>  
> >>>>>  	ret = init_user_ctxt(fd, uctxt);
> >>>>> -	if (ret)
> >>>>> +	if (ret) {
> >>>>> +		hfi1_free_ctxt_rcv_groups(uctxt);
> >>>>>  		goto done;
> >>>>> +	}
> >>>>>  
> >>>>>  	user_init(uctxt);
> >>>>>  
> >>>>
> >>>> Doesn't seem like this patch is correct. The free is done when the file is
> >>>> closed, along with other clean up stuff. See hfi1_file_close().
> >>>
> >>> Can setup_base_ctxt() be called twice for same uctxt?
> >>> You are allocating rcd->groups and not releasing.
> >>
> >> The first thing assign_ctxt() does is a check of the fd->uctxt and it bails with
> >> -EINVAL. So effectively only once.
> > 
> > I'm slightly confused. How will you release rcd->groups?
> > 
> > assign_ctxt()
> >  -> setup_base_ctxt()
> >    -> hfi1_alloc_ctxt_rcv_groups()
> >       ,,,
> >       rcd->groups = kzalloc...
> >       ...
> >    -> init_user_ctxt() <-- fails and leaves fd->uctx == NULL
> > 
> > 
> > ...
> > hfi1_file_close()
> >   struct hfi1_ctxtdata *uctxt = fdata->uctxt;
> >   ...
> >   if (!uctxt)             <-- This is our case
> >      goto done; 
> >   ...
> > 
> > done:
> >   if (refcount_dec_and_test(&dd->user_refcount))
> >      complete(&dd->user_comp);
> > 
> >   cleanup_srcu_struct(&fdata->pq_srcu);
> >   kfree(fdata);
> >   return 0;
> > 
> 
> Looks like this may have been broken with:
> 
> e87473bc1b6c ("IB/hfi1: Only set fd pointer when base context is completely
> initialized")
> 
> The question is does it make more sense to just move the fd->uctxt assignment
> up, or call the free directly. I think that might be opening a bigger can of
> worms though, as this was part of a larger patch set. Maybe it is best after all
> to go with this patch.
> 
> Let's add the above as a fixes line and tack on:
> 
> Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> 
> It's been like this since 4.14, so no rush to get it in for the ultra late RC.
> I'll get it tested as part of the next cycle.
> 

Thanks, applied.
