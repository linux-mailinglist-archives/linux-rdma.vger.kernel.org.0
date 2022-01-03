Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFBC04830ED
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jan 2022 13:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiACMRi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 07:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiACMRi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 07:17:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB5AC061761;
        Mon,  3 Jan 2022 04:17:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8B7AB80DB8;
        Mon,  3 Jan 2022 12:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BBDC36AED;
        Mon,  3 Jan 2022 12:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641212255;
        bh=dc2unh4GlJ8vViNO3Gnk9VSP1cp5kJt5wPpCByT/E7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Esba8fxSxOj6CAm5kCtuWucqmvY2MkTzFsFURtwQ1DZleUMpEpo5aFLarlJ0aT1WS
         CSm5W7KIFjBOL/A7wDLFI3GnJwHoLiNE10bkcqyKdaPvkmp41heYkKc2dqUmM0gGhl
         y5w8FhRTpko2RHgeMKEPy1TlJqhpqgfyqmBIPhL5W9kpnSFXECN++mwcnBMMaPyJkv
         uuPQ2pHJGnxHiewu18+Pufz7dLDI7W71cPHA+ZScP17L4gpjZjDlF8zIjnGhrYtA41
         3gbcoytK2PiZZiILlqE/A+OZ+qh2Htbm9pakkIEg6odK7i/EBugfl2v0NmF3B6T8xx
         GULikp4FNwWLQ==
Date:   Mon, 3 Jan 2022 14:17:31 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 6/7] RDMA/mlx5: Delay the deregistration of
 a non-cache mkey
Message-ID: <YdLpWxwn7WPdvEno@unreal>
References: <cover.1640862842.git.leonro@nvidia.com>
 <20220102030310.2452-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220102030310.2452-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 02, 2022 at 11:03:10AM +0800, Hillf Danton wrote:
> On Thu, 30 Dec 2021 13:23:23 +0200
> > From: Aharon Landau <aharonl@nvidia.com>
> > 
> > When restarting an application with many non-cached mkeys, all the mkeys
> > will be destroyed and then recreated.
> > 
> > This process takes a long time (about 20 seconds for deregistration and
> > 28 seconds for registration of 100,000 MRs).
> > 
> > To shorten the restart runtime, insert the mkeys temporarily into the
> > cache and schedule a delayed work to destroy them later. If there is no
> > fitting entry to these mkeys, create a temporary entry that fits them.
> > 
> > If 30 seconds have passed and no user reclaimed the temporarily cached
> > mkeys, the scheduled work will destroy the mkeys and the temporary
> > entries.
> > 
> > When restarting an application, the mkeys will still be in the cache
> > when trying to reg them again, therefore, the registration will be
> > faster (4 seconds for deregistration and 5 seconds or registration of
> > 100,000 MRs).
> > 
> > Signed-off-by: Aharon Landau <aharonl@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/infiniband/hw/mlx5/mlx5_ib.h |   3 +
> >  drivers/infiniband/hw/mlx5/mr.c      | 131 ++++++++++++++++++++++++++-
> >  2 files changed, 132 insertions(+), 2 deletions(-)

<...>

> > +	if (!ent->is_tmp)
> > +		mr->mmkey.cache_ent = ent;
> > +	else {
> > +		ent->total_mrs--;
> > +		cancel_delayed_work(&ent->dev->cache.remove_ent_dwork);
> > +		queue_delayed_work(ent->dev->cache.wq,
> > +				   &ent->dev->cache.remove_ent_dwork,
> > +				   msecs_to_jiffies(30 * 1000));
> > +	}
> 
> Nit: collapse cancel and queue into mod_delayed_work().
> 
> >  }

<...>

> > +	INIT_WORK(&ent->work, cache_work_func);
> > +	INIT_DELAYED_WORK(&ent->dwork, delayed_cache_work_func);
> 
> More important IMHO is to cut work in a seperate patch given that dwork can
> be queued with zero delay and both work callbacks are simple wrappers of
> __cache_work_func(). 

Thanks, I'll collect more feedback and resubmit.

> 
> Hillf
