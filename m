Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EEC36A792
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Apr 2021 15:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhDYNpn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Apr 2021 09:45:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhDYNpn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 25 Apr 2021 09:45:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAC7861363;
        Sun, 25 Apr 2021 13:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619358299;
        bh=XageWK2n07rFxAqTLC3yIjX5aFfH+wkdp1SE9R1+oVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XC7Xa6xuAy7+IZDYoCa7vMx8axc3v8RUuumRxyVSE+zj6h7yBUSNuK0hf03sYf/KS
         bZ6SPsA3EE+87qWaaSlVj0lxr0BTzR+Z4/47VW0Eco+5fs8ZiGJCIAGMMRU3dBOFOt
         aab4QUGK4mTD0x2+y7+peYHIpJL//yi4eMQsCpeOaERCrtbEnf3fs2WDp8u9PDeZdD
         KEzBCJw7xvazBoyuy1krzVgEUSyZ4i1IUfH5zLite2C47O8N/JbVevNvhb0XjMAeXj
         R5qfFY1ifAV1iGMp/7XJ3BCvYCnOsNuB/ICYB9iRO4GIvIJUTJ+sQvkBC6PJ6JxZc0
         tTRDeSdvMUQyg==
Date:   Sun, 25 Apr 2021 16:44:55 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, Shay Drory <shayd@nvidia.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/restrack: Delay QP deletion till all
 users are gone
Message-ID: <YIVyV2A0QhUXF+rw@unreal>
References: <9ba5a611ceac86774d3d0fda12704cecc30606f9.1618753038.git.leonro@nvidia.com>
 <20210420123950.GA2138447@nvidia.com>
 <YH7Ru5ZSr1kWGZoa@unreal>
 <20210420152541.GC1370958@nvidia.com>
 <YH+yGj3cLuA5ga8s@unreal>
 <20210422142939.GA2407382@nvidia.com>
 <YIVosxurbZGlmCOw@unreal>
 <20210425130857.GN1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210425130857.GN1370958@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 25, 2021 at 10:08:57AM -0300, Jason Gunthorpe wrote:
> On Sun, Apr 25, 2021 at 04:03:47PM +0300, Leon Romanovsky wrote:
> > On Thu, Apr 22, 2021 at 11:29:39AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Apr 21, 2021 at 08:03:22AM +0300, Leon Romanovsky wrote:
> > > 
> > > > I didn't understand when reviewed either, but decided to post it anyway
> > > > to get possible explanation for this RDMA_RESTRACK_MR || RDMA_RESTRACK_QP
> > > > check.
> > > 
> > > I think the whole thing should look more like this and we delete the
> > > if entirely.
> > 
> > I have mixed feelings about this approach. Before "destroy can fail disaster",
> > the restrack goal was to provide the following flow:
> > 1. create new memory object - rdma_restrack_new()
> > 2. create new HW object - .create_XXX() callback in the driver
> > 3. add HW object to the DB - rdma_restrack_del()
> > ....
> > 4. wait for any work on this HW object to complete - rdma_restrack_del()
> > 5. safely destroy HW object - .destroy_XXX()
> > 
> > I really would like to stay with this flow and block any access to the
> > object that failed to destruct - maybe add to some zombie list.
> 
> That isn't the semantic we now have for destroy.

I would say that it is my mistake introduced when changed destroy to
return an error.

>  
> > The proposed prepare/abort/finish flow is much harder to implement correctly.
> > Let's take as an example ib_destroy_qp_user(), we called to rdma_rw_cleanup_mrs(),
> > but didn't restore them after .destroy_qp() failure.
> 
> I think it is a bug we call rdma_rw code in a a user path.

It was an example of a flow that wasn't restored properly. 
The same goes for ib_dealloc_pd_user(), release of __internal_mr.

Of course, these flows shouldn't fail because of being kernel flows, but it is not clear
from the code.

Thanks


> 
> Jason
