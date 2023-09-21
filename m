Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7567A98A8
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Sep 2023 19:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjIURvS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 13:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjIURvF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 13:51:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129006E9A
        for <linux-rdma@vger.kernel.org>; Thu, 21 Sep 2023 10:22:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C913C116C8;
        Thu, 21 Sep 2023 08:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695284840;
        bh=2xZRFmVWrIywrtLAEU7pZV4pVep3cLRyvYJEyK3qHfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QdDJUeibAz5k+E7pPQjOGh3Psi1MHywN6ivbQtAN509pDLI+2XXCKs9q4QhgyOvua
         Xb7D5XGr9iraUSGqx61fE+GkXJnklFhVC/4HoQUmxiZi3j8SHugNX4zjBSKBOWuMEH
         aTUrUkOElNoRG4yNwy7tB42DyaPRtZ9hONvxOl8JEjtVSCsl8NB7CVdVHfzFO5+Erb
         dlZwxOMVebQHujp1nip+++5lFX3nb4BwZ694Ih+9IU7VZy5FdWONTc/4Rk6ulF2aXr
         F/HreZwa7kquwBhqvfKlZJHkH19GYfQS2sxJude47b89UqDriVz+os9bcV+1EF0hzy
         bzLBT+RhAcckw==
Date:   Thu, 21 Sep 2023 11:27:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shay Drory <shayd@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix mkey cache possible deadlock on
 cleanup
Message-ID: <20230921082716.GC1642130@unreal>
References: <2c0452d944a865b060709af71940dafc4aad8b89.1695203715.git.leon@kernel.org>
 <20230920140112.GB13733@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920140112.GB13733@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 20, 2023 at 11:01:12AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 20, 2023 at 12:56:18PM +0300, Leon Romanovsky wrote:
> > @@ -1796,6 +1804,10 @@ static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
> >  	}
> >  
> >  	mutex_lock(&cache->rb_lock);
> > +	if (cache->disable) {
> > +		mutex_unlock(&cache->rb_lock);
> > +		return 0;
> > +	}
> 
> 
> I don't get this.
> 
> Shouldn't we just initialize the ent->disabled to cache->disabled if
> we happen to be creating a new ent?

I'm convinced that new entries can't be created when we are calling to
mlx5_mkey_cache_cleanup().

Thanks

> 
> Jason
> 
