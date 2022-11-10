Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F9A623EAE
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Nov 2022 10:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiKJJfs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Nov 2022 04:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKJJfr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Nov 2022 04:35:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8DB682A7
        for <linux-rdma@vger.kernel.org>; Thu, 10 Nov 2022 01:35:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 683C3B82130
        for <linux-rdma@vger.kernel.org>; Thu, 10 Nov 2022 09:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FEAC433C1;
        Thu, 10 Nov 2022 09:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668072944;
        bh=xzR7PfxUPk3ddA9IfpCFIFkxXyQBm/i1hySilZiMr8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qgu+IbWOeG1rbRYlB37kzynyMnFmKJYghkOQmEuPJ0jNLL09lab/LfaQMIVvJk0qI
         36WLcJ49kd1scvzDm1tF/QhhH9BHzp8tN2RHvU9yDXIzkQYaS24JnrIR3h2MeAP0Zi
         3Bzw5ornJGM1pOkzva7DMk+telvAjlZ9GqFtcbTdqISr7bcHUpFNBlMVOjtZCe8SMA
         95R0kRS4CKhiLvR6IxtW7MNjQUqg33rH2CSiX38LoXrJC2u7UE1/XE5R3M5R4W8eeE
         dTqzDxBPzkzT5kLGoQtO5+dufdC58q3FFGOjJMjYgRPQEqmAZ9E/evZWlNzu4CRYve
         cChDYZgi1NlvQ==
Date:   Thu, 10 Nov 2022 11:35:37 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>,
        Or Har-Toov <ohartoov@nvidia.com>
Subject: Re: [PATCH rdma-next 2/4] RDMA/restrack: Release MR restrack when
 delete
Message-ID: <Y2zF6c5gs8KObRK0@unreal>
References: <cover.1667810736.git.leonro@nvidia.com>
 <703db18e8d4ef628691fb93980a709be673e62e3.1667810736.git.leonro@nvidia.com>
 <Y2v6sTD8docw5bjK@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2v6sTD8docw5bjK@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 09, 2022 at 03:08:33PM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 07, 2022 at 10:51:34AM +0200, Leon Romanovsky wrote:
> > From: Mark Zhang <markzhang@nvidia.com>
> > 
> > The MR restrack also needs to be released when delete it, otherwise it
> > cause memory leak as the task struct won't be released.
> > 
> > Fixes: 13ef5539def7 ("RDMA/restrack: Count references to the verbs objects")
> > Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> > Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/infiniband/core/restrack.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> > index 1f935d9f6178..01a499a8b88d 100644
> > --- a/drivers/infiniband/core/restrack.c
> > +++ b/drivers/infiniband/core/restrack.c
> > @@ -343,8 +343,6 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
> >  	rt = &dev->res[res->type];
> >  
> >  	old = xa_erase(&rt->xa, res->id);
> > -	if (res->type == RDMA_RESTRACK_MR)
> > -		return;
> 
> This needs more explanation, there was some good reason we needed to
> avoid the wait_for_completion() for the driver allocated objects, but I
> can't remember it anymore.
> 
> You added this code in the v2 of the original series, maybe it had
> something to do with mlx4?

I failed to remember either, but if you want even more magic in your life,
see this hilarious thread:
https://lore.kernel.org/linux-rdma/9ba5a611ceac86774d3d0fda12704cecc30606f9.1618753038.git.leonro@nvidia.com/

I kept this patch in my queue ~1 month and didn't get any complains.

Thanks

> 
> Jason
