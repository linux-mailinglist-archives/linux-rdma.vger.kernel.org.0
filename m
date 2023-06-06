Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0F87236F4
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 07:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjFFFuX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jun 2023 01:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbjFFFuP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jun 2023 01:50:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F15E5F
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 22:50:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C817462D2D
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 05:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A970AC433D2;
        Tue,  6 Jun 2023 05:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686030609;
        bh=Muu6ADIC0JRGip1QeBJMpIv2LMnERS7Mx8kvMIynmHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=omohNUtv1PpQHFmXG5v5XtKbHRENZTH1GkpsLVgMgtX3pjbks6/Z6f0N6VEqfnq4F
         pfw2pW7ALJi2Fxp2DBVcZB4zfmiC5FooM0jqzfnO4Dntymto5jLpbShKTODc2loLf+
         aegXHgpgYpvuAU0j0ekRiH+/e+EWoodnbtdXp6evkzee5Bfv28Cxw8Q1BJZT8XgmMy
         /L83ePxQp8afzCsuu1eKGGaebpdlLTJRoQ2mVNBAmj7EOj9zkiTtnD2g4oQm/+xXUi
         FRa16/jpc9k/UPECzRp4ZG7d00W+j3gV2pL9xafzk6wPBbbQe59dLEpPhAzJcKOXVA
         AoZ4cytmttLig==
Date:   Tue, 6 Jun 2023 08:50:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Michael Guralnik <michaelgur@nvidia.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-rc 06/10] RDMA/mlx5: Fix mkey cache possible
 deadlock on cleanup
Message-ID: <20230606055004.GA6830@unreal>
References: <cover.1685960567.git.leon@kernel.org>
 <babba5ce5a995ced9ea35133dbc938d2a19510d2.1685960567.git.leon@kernel.org>
 <ZH4TTgqmYi0/A/bj@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH4TTgqmYi0/A/bj@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 05, 2023 at 01:54:38PM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 05, 2023 at 01:33:22PM +0300, Leon Romanovsky wrote:
> 
> > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> > index 1ce48e485c5b..f113656e4027 100644
> > --- a/drivers/infiniband/hw/mlx5/mr.c
> > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > @@ -1033,7 +1033,15 @@ void mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
> >  		xa_lock_irq(&ent->mkeys);
> >  		ent->disabled = true;
> >  		xa_unlock_irq(&ent->mkeys);
> > -		cancel_delayed_work_sync(&ent->dwork);
> > +	}
> > +
> > +	/* Run the canceling of delayed works on the cache in a separate loop after
> > +	 * disabling all entries to ensure someone_adding() will not try taking the
> > +	 * rb_lock while flushing the workqueue.
> > +	 */
> > +	for (node = rb_first(root); node; node = rb_next(node)) {
> > +		ent = rb_entry(node, struct mlx5_cache_ent, node);
> > +		cancel_delayed_work(&ent->dwork);
> >  	}
> >
> This goes on to kfree end, so this can't drop the sync.

with _sync, we will get same code as it was before.
Let's put this patch aside.

Thanks

> 
> Jason
