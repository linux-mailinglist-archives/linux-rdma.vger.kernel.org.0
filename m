Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6047336B3CE
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Apr 2021 15:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhDZNJf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Apr 2021 09:09:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233520AbhDZNJ1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Apr 2021 09:09:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A934760FD7;
        Mon, 26 Apr 2021 13:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619442526;
        bh=MU0aFU3zlYr413zVQKdUnFU0fFFsWSHrKca5Yt4V6nM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GfgQujnPk211txLgplkPgm+VICuYKy89oPYMHCo8Tz07o/QTLKp1/WPN7jyl/qVi4
         pCJrZf1cQrFuP12rsnhaeS37ny/bGJGcRa7vWL/f8WZf3P7dr61FMYq8EpYoUICZpY
         6sBQigGcORd/Ll2ShaT//NruhdWV00Ue6pM/Z1fBFrQkfnXM/Qy4Wvf19WF1z5VlsG
         PCabzTpm8mDOo6BVtjbRPYpybG05nFnbb0KeFAqC+6Qf8Z4rlxvTGDGfzXjfjyQYME
         E06ACPEqqJo8cDf1ZmX9e/q9xnJC/Pbnp/apNxJgGvpkzmIx7zD/37pbaZsu82CvRj
         FSI1PXqSuO72g==
Date:   Mon, 26 Apr 2021 16:08:42 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, Shay Drory <shayd@nvidia.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/restrack: Delay QP deletion till all
 users are gone
Message-ID: <YIa7WtlYono4wP5T@unreal>
References: <YH7Ru5ZSr1kWGZoa@unreal>
 <20210420152541.GC1370958@nvidia.com>
 <YH+yGj3cLuA5ga8s@unreal>
 <20210422142939.GA2407382@nvidia.com>
 <YIVosxurbZGlmCOw@unreal>
 <20210425130857.GN1370958@nvidia.com>
 <YIVyV2A0QhUXF+rw@unreal>
 <20210425172254.GO1370958@nvidia.com>
 <YIWpMbUg3VlT3uJy@unreal>
 <20210426120349.GP1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426120349.GP1370958@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 26, 2021 at 09:03:49AM -0300, Jason Gunthorpe wrote:
> On Sun, Apr 25, 2021 at 08:38:57PM +0300, Leon Romanovsky wrote:
> > On Sun, Apr 25, 2021 at 02:22:54PM -0300, Jason Gunthorpe wrote:
> > > On Sun, Apr 25, 2021 at 04:44:55PM +0300, Leon Romanovsky wrote:
> > > > > > The proposed prepare/abort/finish flow is much harder to implement correctly.
> > > > > > Let's take as an example ib_destroy_qp_user(), we called to rdma_rw_cleanup_mrs(),
> > > > > > but didn't restore them after .destroy_qp() failure.
> > > > > 
> > > > > I think it is a bug we call rdma_rw code in a a user path.
> > > > 
> > > > It was an example of a flow that wasn't restored properly. 
> > > > The same goes for ib_dealloc_pd_user(), release of __internal_mr.
> > > > 
> > > > Of course, these flows shouldn't fail because of being kernel flows, but it is not clear
> > > > from the code.
> > > 
> > > Well, exactly, user flows are not allowed to do extra stuff before
> > > calling the driver destroy
> > > 
> > > So the arrangement I gave is reasonable and make sense, it is
> > > certainly better than the hodge podge of ordering that we have today
> > 
> > I thought about simpler solution - move rdma_restrack_del() before .destroy() 
> > callbacks together with attempt to readd res object if destroy fails.
> 
> Is isn't simpler, now add can fail and can't be recovered

It is not different from failure during first call to rdma_restrack_add().
You didn't like the idea to be strict with addition of restrack, but
want to be strict in reinsert.

Thanks

> 
> Jason
