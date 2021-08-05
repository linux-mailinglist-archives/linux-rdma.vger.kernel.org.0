Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4633E0E85
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Aug 2021 08:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbhHEGnv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 02:43:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231418AbhHEGnu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Aug 2021 02:43:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62BF460462;
        Thu,  5 Aug 2021 06:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628145817;
        bh=VJd3dRzsYJ2FfUYxQrivjngv0CEl6bodWlWAEugcJRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j7neluQDnMex0X+f/p2QgZB9pQ2LdnmtHPm+ah+7iwczNeN6J6CHL5OnKc1ACL6Vc
         VePonkSTqVdV9E43syKf7CnntbdUKWj55yYWhbBpDG46T+aW83j/uA64vYeIcS9UaU
         1YgaU83ji2vNK/je2adaGu3py7flEw8sDIyyOWP/ISIVz0jE+WgYS1GxGojsyRqWNS
         43A/QGJug0Pf82JAON30YLwFqBMbfqPNlGUsxbeEM8U4ksTseyZwV2xqBbpz5aguW1
         fvJWRxEQ1XHxtmNSkqZYggxojUffq2VHGBPbWnh350o9A9+MfH2KrOFTqdLG6My3Qb
         NQE5trcKuB7Cw==
Date:   Thu, 5 Aug 2021 09:43:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: return the EFAULT per ibv_advise_mr(3)
Message-ID: <YQuIlUT9jZLeFPNH@unreal>
References: <20210801092050.6322-1-lizhijian@cn.fujitsu.com>
 <20210803162507.GA2892108@nvidia.com>
 <YQmDZpbCy3uTS5jv@unreal>
 <20210803181341.GE1721383@nvidia.com>
 <YQonIu3VMTlGj0TJ@unreal>
 <20210804185022.GM1721383@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804185022.GM1721383@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 04, 2021 at 03:50:22PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 04, 2021 at 08:35:30AM +0300, Leon Romanovsky wrote:
> > On Tue, Aug 03, 2021 at 03:13:41PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Aug 03, 2021 at 08:56:54PM +0300, Leon Romanovsky wrote:
> > > > On Tue, Aug 03, 2021 at 01:25:07PM -0300, Jason Gunthorpe wrote:
> > > > > On Sun, Aug 01, 2021 at 05:20:50PM +0800, Li Zhijian wrote:
> > > > > > ibv_advise_mr(3) says:
> > > > > > EFAULT In one of the following: o When the range requested is out of the  MR  bounds,
> > > > > >        or  when  parts of it are not part of the process address space. o One of the
> > > > > >        lkeys provided in the scatter gather list is invalid or with wrong write access
> > > > > > 
> > > > > > Actually get_prefetchable_mr() will return NULL if it see above conditions
> > > > > 
> > > > > No, get_prefetchable_mr() returns NULL if the mkey is invalid
> > > > 
> > > > And what is this?
> > > >   1701 static struct mlx5_ib_mr *                         
> > > >   1702 get_prefetchable_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
> > > >   1703                     u32 lkey)
> > > > 
> > > > ...
> > > > 
> > > >   1721         /* prefetch with write-access must be supported by the MR */
> > > >   1722         if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
> > > >   1723             !mr->umem->writable) {
> > > >   1724                 mr = NULL;
> > > >   1725                 goto end;
> > > >   1726         }
> > > 
> > > I would say that is an invalid mkey
> > 
> > I see it is as wrong write access.
> 
> It just means the man page is wrong

ok, it can be a solution too.

Thanks

> 
> Jason
