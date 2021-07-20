Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134183CF995
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 14:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbhGTLr6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 07:47:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237862AbhGTLqf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 07:46:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90BDE6120E;
        Tue, 20 Jul 2021 12:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626784027;
        bh=mokaf2LVIYqygkaCSEgReilDLtYW6WNIT/Ly6lIKO9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HXXti2gUH5esfJd2uPvlQMJgN0Q+WHD6ZROCAHaTn0LrIEsu1Gk1+F/Y9QGK3dy0P
         nRI5qZm/ww7KNYS8X+kcpOv/N2aDZyAYhj7Ph3BuJVt11LB0uZNiuwjFUnpC15dh5z
         uNIHbH0+4xVIMLEVqm4AQn3I4V9IeXCuisExRLuJ7yH/z/iKzG0PYr3ZDL6PEAgRri
         JX33Snw1p1oyiyx6VbIQVq2+0/R+VH6ulqhOdzmhL7HBSA4i5yYpvs0rmYPOYO65o7
         W2CO+XGSsbQnbz++koK1kIuE48QcQImbak6f/FxiR8w9jG6gpmzFWlM28VdPYAbrgN
         KO2FTEwcckoBA==
Date:   Tue, 20 Jul 2021 15:27:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, jgg@nvidia.com, maorg@nvidia.com,
        markzhang@nvidia.com, edwards@nvidia.com
Subject: Re: [PATCH rdma-core 03/27] mlx5: Enable debug functionality for vfio
Message-ID: <YPbBFAgEOjfLcYrI@unreal>
References: <20210720081647.1980-1-yishaih@nvidia.com>
 <20210720081647.1980-4-yishaih@nvidia.com>
 <YPaOlTDrV877Jgnt@unreal>
 <2054ad99-254f-4e46-d193-4b1183000d87@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2054ad99-254f-4e46-d193-4b1183000d87@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 20, 2021 at 12:27:46PM +0300, Yishai Hadas wrote:
> On 7/20/2021 11:51 AM, Leon Romanovsky wrote:
> > On Tue, Jul 20, 2021 at 11:16:23AM +0300, Yishai Hadas wrote:
> > > From: Maor Gottlieb <maorg@nvidia.com>
> > > 
> > > Usage will be in next patches.
> > > 
> > > Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> > > Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> > > ---
> > >   providers/mlx5/mlx5.c | 28 ++++++++++++++--------------
> > >   providers/mlx5/mlx5.h |  4 ++++
> > >   2 files changed, 18 insertions(+), 14 deletions(-)
> > Probably, this patch will be needed to be changed after
> > "Verbs logging API" PR https://github.com/linux-rdma/rdma-core/pull/1030
> > 
> > Thanks
> 
> Well, not really, this patch just reorganizes things inside mlx5 for code
> sharing.

After Gal's PR, I expect to see all mlx5 file/debug logic gone except
some minimal conversion logic to support old legacy variables.

All that get_env_... code will go.

Thanks

> 
> Yishai
> 
