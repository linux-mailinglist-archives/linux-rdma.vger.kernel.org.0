Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B997A43B24A
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Oct 2021 14:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhJZMYI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Oct 2021 08:24:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhJZMYH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 Oct 2021 08:24:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 352376054E;
        Tue, 26 Oct 2021 12:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635250903;
        bh=A2O4pV/5icpHxYWLULI5b6SECubKtQ+KChcGNrhjeX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nHT7mo5UnXvn/ERYWEC1AppsoxxaoZPQWLuDdFwiOq0kW9yPxVbrh3mcexEQAUa7/
         5ia3i+FTYTQJv8PikgYacKNUaU2M9HcfRKvNVkZRUMzUZbZEACAIDgz17ygbnK99tX
         jJW31WakVoZintkEAhkGkbG3VjvYmSDkQPJJ7mjXHz5gv8fBsfyyPD95+OC8hRRAij
         Ok8gjuqeYZ838eRnRSrlxCc8LLOS7cqfrqAMNJbp8ZBMmkNXvq4Kvp3klY4EvYTk2x
         FA7V/vERhuqM8Dt3Trm2H0GSWa5c6oYF5rwWxedYKMs91Qk8hCNCvHgbWEW5KoB+1Z
         m6tCOBMQVy54Q==
Date:   Tue, 26 Oct 2021 15:21:39 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        John Fleck <john.fleck@intel.com>,
        Kaike Wan <kaike.wan@intel.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
        Mark Bloch <markb@mellanox.com>, Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH rdma-rc 2/2] RDMA/core: Initialize lock when allocate a
 rdma_hw_stats structure
Message-ID: <YXfy06cMWfwK1oMF@unreal>
References: <cover.1635055496.git.leonro@nvidia.com>
 <89baeee29503df46dd28a6a5edbad9ec1a1d86f1.1635055496.git.leonro@nvidia.com>
 <20211025145043.GA357677@nvidia.com>
 <YXe8DaH6gSFvbEyu@unreal>
 <20211026120554.GO2744544@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026120554.GO2744544@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 26, 2021 at 09:05:54AM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 26, 2021 at 11:27:57AM +0300, Leon Romanovsky wrote:
> > On Mon, Oct 25, 2021 at 11:50:43AM -0300, Jason Gunthorpe wrote:
> > > On Sun, Oct 24, 2021 at 09:08:21AM +0300, Leon Romanovsky wrote:
> > > > From: Mark Zhang <markzhang@nvidia.com>
> > > > 
> > > > Initialize the rdma_hw_stats "lock" field when do allocation, to fix the
> > > > warning below. Then we don't need to initialize it in sysfs, remove it.
> > > 
> > > This is a fine cleanup, but this does not describe the bug properly,
> > > or have the right fixes line..
> > 
> > I think that this Fixes line should be instead.
> > Fixes: 0a0800ce2a6a ("RDMA/core: Add a helper API rdma_free_hw_stats_struct")
> 
> No, I don't think so, it should be the commit that added
> alloc_and_bind()

The alloc_and_bind() is a merge between other functions. The issue existed
even before. It is worth to stop at some point to dig and IMHO proposed Fixes
line is good enough (at least for me).

> 
> > > The issue is here:
> > > 
> > > static struct rdma_counter *alloc_and_bind(struct ib_device *dev, u32 port,
> > > 					   struct ib_qp *qp,
> > > 					   enum rdma_nl_counter_mode mode)
> > > {
> > > 	counter->stats = dev->ops.counter_alloc_stats(counter);
> > > 	if (!counter->stats)
> > > 		goto err_stats;
> > > 
> > > Which does not init counter->stat's mutex.
> > 
> > This is exactly what Mark is doing here.
> > 
> > alloc_and_bind()
> >  -> dev->ops.counter_alloc_stats
> >   -> mlx5_ib_counter_alloc_stats
> >    -> do_alloc_stats()
> >     -> rdma_alloc_hw_stats_struct()
> >      -> mutex_init(&stats->lock); <- Mark's change.
> 
> Yes, I know, the patch is fine, the commit message just needs to be
> accurate
>  
> > > And trim the oops reports, don't include the usless ? fns, timestamps
> > > or other junk.
> > 
> > I don't like when people "beatify" kernel reports, many times whey are
> > removing too much information.
> 
> There is too much junk in the raw oops messages

Right, but it is better to have more info than to much trimmed one.

Thanks

> 
> Jason
