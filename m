Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00112398130
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jun 2021 08:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhFBGin (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Jun 2021 02:38:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:32830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229711AbhFBGin (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Jun 2021 02:38:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 022C861359;
        Wed,  2 Jun 2021 06:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622615820;
        bh=kUqUgG6C8+a40iGLJ9kW7ES34IUCUtI1Uv5WYdUJ13g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BVDsB1FLg0VZzJ0KA9H/WAXrbvFPFv0p2AbL7LYlkTXwYcoFHhmZwIuGmxTJ/aK+k
         iFZFUbg5FSjKxq/fyb7fysjGpi1mIsaduifMRorvwA3jJsgFhjo+j05npY6ZPasJCK
         S7D9iQnWO0Xv5yZaat8jo51BgJVYF1xo1C7hsGC/13d/tFpXgc56A/Q9zQzu1FujSU
         dziA8o5Ti40wjrYtBxuBQ7ndaSZdzPiPWvxSTpLGp+byJN+pMG+/Ny35Ehbmvfn7in
         1lSXLSQSpNPxxn+8k+MuWqyNDuX2rtUn4/YS9L/SLFNWfFweoWXEmnAJfi99vL66pg
         39oSNrbp6ZbqA==
Date:   Wed, 2 Jun 2021 09:36:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
        Shay Drory <shayd@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-rc 4/5] RDMA/core: Simplify addition of restrack
 object
Message-ID: <YLcnCLYqP+vbeUnR@unreal>
References: <cover.1620711734.git.leonro@nvidia.com>
 <36cde3a62adc5d6aeb895456574c988cff7e42ac.1620711734.git.leonro@nvidia.com>
 <20210525134253.GA3388071@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525134253.GA3388071@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 25, 2021 at 10:42:53AM -0300, Jason Gunthorpe wrote:
> On Tue, May 11, 2021 at 08:48:30AM +0300, Leon Romanovsky wrote:
> 
> > @@ -3853,12 +3848,12 @@ int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
> >  	if (ret)
> >  		goto err2;
> >  
> > -	if (!cma_any_addr(addr))
> > -		rdma_restrack_add(&id_priv->res);
> >  	return 0;
> >  err2:
> >  	if (id_priv->cma_dev)
> >  		cma_release_dev(id_priv);
> > +	if (!cma_any_addr(addr))
> > +		rdma_restrack_del(&id_priv->res);
> 
> But this whole thing is reverting an earlier patch - the whole point
> was to avoid the restrack_del().

Not really, we are calling to rdma_restrack_add() only in "if (!cma_any_addr(addr))"
flow, so the patch does the same as the earlier one, but in more compact way.

> 
> Plus this is out of order the del has to be before the release, due to
> the other recent patch.

Shay pointed it to me too, I will fix.

Thanks

> 
> Jason
