Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B13F675AD1
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jan 2023 18:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjATRKC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Jan 2023 12:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjATRJw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Jan 2023 12:09:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FAB5E531
        for <linux-rdma@vger.kernel.org>; Fri, 20 Jan 2023 09:09:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1423C62007
        for <linux-rdma@vger.kernel.org>; Fri, 20 Jan 2023 17:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1751C4339B;
        Fri, 20 Jan 2023 17:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674234587;
        bh=koFzSA+1tZjACNZl41NctzpC2FbTUIRtfCWCle8NoFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MyvFSt8+ap9ioWqRe23qdrsscF8zad4ilrPTpt9ISzeciVEnFU2pbA/pz1dBd/44E
         VUE3VUJR2TAN3ihpj8IyJ/FKwH5C9cwy8s3RmSNR3yQSxXU6+EXOKCurj7vXkdZuNj
         v5382qWUE1gla/f9jt0eaMUIFU4gsnutr5F526czjwuC9c0T7mYtVXoBnzIb5o+J7v
         7ZgT6AuzmpgEpZLEUE05ohcGyE8M1A7T7C9FQ7WmGIO5GuamR4x0hH0IjnHjCQMZEp
         tfNEjJPiltbWzUMPaFqp1w/Tx1q+j41dF6xi1O2casnBJB2nhspnc2nnJdRs2Pm73e
         74EbXmJ4l9G6Q==
Date:   Fri, 20 Jan 2023 19:09:43 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/7] FIXME and other fixes
Message-ID: <Y8rK16KNpj0lzQ2a@unreal>
References: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
 <Y718/h2uSTYq5PTa@nvidia.com>
 <3cf880fa-3374-541f-1996-d30d635db594@cornelisnetworks.com>
 <bce1ab36-66e4-465c-e051-94e397d108ba@cornelisnetworks.com>
 <Y8Pnn8NokWNsKQO/@unreal>
 <472565cb-e99d-95a6-4d20-6a34f77c8cf1@cornelisnetworks.com>
 <Y8T5602bNhscGixb@unreal>
 <a1efafe0-1c8e-60ae-cc77-b3592ea5b989@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1efafe0-1c8e-60ae-cc77-b3592ea5b989@cornelisnetworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 18, 2023 at 08:04:52AM -0500, Dennis Dalessandro wrote:
> On 1/16/23 2:16 AM, Leon Romanovsky wrote:
> > On Mon, Jan 16, 2023 at 12:36:51AM -0500, Dennis Dalessandro wrote:
> >> On 1/15/23 6:46 AM, Leon Romanovsky wrote:
> >>> On Fri, Jan 13, 2023 at 12:21:50PM -0500, Dennis Dalessandro wrote:
> >>>> On 1/10/23 4:03 PM, Dennis Dalessandro wrote:
> >>>>> On 1/10/23 9:58 AM, Jason Gunthorpe wrote:
> >>>>>> On Mon, Jan 09, 2023 at 02:03:58PM -0500, Dennis Dalessandro wrote:
> >>>>>>> Dean fixes the FIXME that was left by Jason in the code to use the interval
> >>>>>>> notifier.
> >>>>>>
> >>>>>> ? Which patch did that?
> >>>>>
> >>>>> My fault. The last patch in the previous series [1] was meant to go first here.
> >>>>> I got off by 1 when I was splitting the patches out for submit.
> >>>>>
> >>>>> [1]
> >>>>> https://lore.kernel.org/linux-rdma/167328549178.1472310.9867497376936699488.stgit@awfm-02.cornelisnetworks.com/T/#u
> >>>>
> >>>> As a side effect of this, can we pull patch 2/7 from this series into the RC?
> >>>
> >>> No, everything is in for-rc/for-next now.
> >>
> >> Without that patch there will be a regression in 6.2. 
> > 
> > I'm lost here. You are saying above that you wanted patch from -rc to be
> > in -next series. However, you wrote about regression in 6.2, which is -rc.
> 
> Originally I did not mean to send:
> [PATCH for-rc 6/6] IB/hfi1: Remove user expected buffer invalidate race
> for -rc.
> 
> I didn't realize, it has a functional dependency on:
> [PATCH for-next 2/7] IB/hfi1: Assign npages earlier
> 
> Ideally either they both go to -rc or they both go to -next.
> 
> >> Is there a reason it can't merge into -rc?
> > 
> > Here you are asking to bring -next patches to -rc.
> 
> One patch.
> 
> > So please help me, what do you want to do with these branches?
> > 1. -rc
> > 2. -next
> > 
> > Options are:
> > 1. keep as is
> > 2. revert
> 
> Let me do some build testing. If we revert the -rc patch and then reapply to
> -next we may encounter conflicts and/or build issues and just make things worse.
> 
> > 3. anything else?Will get back to you if I come up with something else.
> 
> > What we won't do:
> > 1. backmerge -next to -rc
> 
> So why is this not an option? Well ok so I don't mean we should merge. I guess
> I'm more looking to cherry-pick.

Backmerge will cause to the situation where features are brought to -rc.
The cherry-pick will be:
1. Revert [PATCH for-next 2/7] IB/hfi1: Assign npages earlier] from -next
2. Apply [PATCH for-next 2/7] IB/hfi1: Assign npages earlier] to -rc

Thanks
