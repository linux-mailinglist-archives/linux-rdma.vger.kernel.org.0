Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E942536A894
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Apr 2021 19:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhDYRjl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Apr 2021 13:39:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230329AbhDYRjl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 25 Apr 2021 13:39:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 769E961288;
        Sun, 25 Apr 2021 17:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619372341;
        bh=d6MDSL9o3y9Y5tpRPdTVl047BX5W9aobZR9hdrG04c4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JQyCyFozGNQ4ejfMnzCK5HGdf22Z1/45hLxHJq0MrRlEpbZHkj/SSlQ4rSBUmhWba
         +BwM3v05W7I5z92rNRpN3W1M98iHBa8ZCjl5mbb3TESn3fDC7f96GigrEuDqZh8Cnp
         pf/tbR1maHbhhOT21fky5oJC1fxzSzolgitNYtftXV5+VW3jI0ugIoUscPZahZ6vqC
         BsHkmQemiL44Wi21rYmFvifn1m9HJG6/y1/EW6nQ7k+8JRznh7A3TkgzNPxYEIEzF4
         Noa6dAvl1VOi6Fc8h2pUYYHhmRIdfFpSzEwefjJhoHFt192zvyw5d4V4shGZC1qYj1
         q2AyRkXMaXYpw==
Date:   Sun, 25 Apr 2021 20:38:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, Shay Drory <shayd@nvidia.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/restrack: Delay QP deletion till all
 users are gone
Message-ID: <YIWpMbUg3VlT3uJy@unreal>
References: <9ba5a611ceac86774d3d0fda12704cecc30606f9.1618753038.git.leonro@nvidia.com>
 <20210420123950.GA2138447@nvidia.com>
 <YH7Ru5ZSr1kWGZoa@unreal>
 <20210420152541.GC1370958@nvidia.com>
 <YH+yGj3cLuA5ga8s@unreal>
 <20210422142939.GA2407382@nvidia.com>
 <YIVosxurbZGlmCOw@unreal>
 <20210425130857.GN1370958@nvidia.com>
 <YIVyV2A0QhUXF+rw@unreal>
 <20210425172254.GO1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210425172254.GO1370958@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 25, 2021 at 02:22:54PM -0300, Jason Gunthorpe wrote:
> On Sun, Apr 25, 2021 at 04:44:55PM +0300, Leon Romanovsky wrote:
> > > > The proposed prepare/abort/finish flow is much harder to implement correctly.
> > > > Let's take as an example ib_destroy_qp_user(), we called to rdma_rw_cleanup_mrs(),
> > > > but didn't restore them after .destroy_qp() failure.
> > > 
> > > I think it is a bug we call rdma_rw code in a a user path.
> > 
> > It was an example of a flow that wasn't restored properly. 
> > The same goes for ib_dealloc_pd_user(), release of __internal_mr.
> > 
> > Of course, these flows shouldn't fail because of being kernel flows, but it is not clear
> > from the code.
> 
> Well, exactly, user flows are not allowed to do extra stuff before
> calling the driver destroy
> 
> So the arrangement I gave is reasonable and make sense, it is
> certainly better than the hodge podge of ordering that we have today

I thought about simpler solution - move rdma_restrack_del() before .destroy() 
callbacks together with attempt to readd res object if destroy fails.

Thanks

> 
> Jason
