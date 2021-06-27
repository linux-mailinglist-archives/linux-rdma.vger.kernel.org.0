Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B603B5286
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Jun 2021 10:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhF0IKB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Jun 2021 04:10:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhF0IKB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Jun 2021 04:10:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C629561C32;
        Sun, 27 Jun 2021 08:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624781257;
        bh=h5CSvzy0V/l1v+zE/fkgAeIjDT3aAzc6SsRS7UQrEGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ITuI43vEbCgFPcmqnZa8ft1RNZp8DSHbx4VKWUIibtpNjEscGGcKtK3Ni5NtDaCGr
         8eamPL++/5jaBg/chP0aQnu+EDm6CcD4KOdOr0ukjbi9ysgJVfmB054H2f3gvsVJXb
         LrjLDv20H6dss3U3Zt3Z0s5LqE4+99SgA3tLeZwOvWbIsDIp5rHiw96lf5jKslmFoE
         B099bJEmJG9Lfuae1/ODmwmxQCGtz1CNtt5Tn93OqPUXIcLsMKgki2wmcK0/xBzPmO
         zxwMGfmUkN05/ijxERpHc0YqZ1d2fpBzDR1jJ4P8b32sScL99HhP4ScuSlkajmMIQp
         WqPqfQ7N+5QFA==
Date:   Sun, 27 Jun 2021 11:07:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Pavel Skripkin <paskripkin@gmail.com>,
        Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH rdma-rc v2] RDMA/core: Simplify addition of restrack
 object
Message-ID: <YNgxxTQ4NW0yGHq1@unreal>
References: <e2eed941f912b2068e371fd37f43b8cf5082a0e6.1623129597.git.leonro@nvidia.com>
 <20210624174841.GA2906108@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624174841.GA2906108@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 24, 2021 at 02:48:41PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 08, 2021 at 08:23:48AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Change location of rdma_restrack_add() callers to be near attachment
> > to device logic. Such improvement fixes the bug where task_struct was
> > acquired but not released, causing to resource leak.
> > 
> >   ucma_create_id() {
> >     ucma_alloc_ctx();
> >     rdma_create_user_id() {
> >       rdma_restrack_new();
> >       rdma_restrack_set_name() {
> >         rdma_restrack_attach_task.part.0(); <--- task_struct was gotten
> >       }
> >     }
> >     ucma_destroy_private_ctx() {
> >       ucma_put_ctx();
> >       rdma_destroy_id() {
> >         _destroy_id()                       <--- id_priv was freed
> >       }
> >     }
> >   }
> 
> I still don't understand this patch
> 
> > @@ -1852,6 +1849,7 @@ static void _destroy_id(struct rdma_id_private *id_priv,
> >  {
> >  	cma_cancel_operation(id_priv, state);
> >  
> > +	rdma_restrack_del(&id_priv->res);
> >  	if (id_priv->cma_dev) {
> >  		if (rdma_cap_ib_cm(id_priv->id.device, 1)) {
> >  			if (id_priv->cm_id.ib)
> > @@ -1861,7 +1859,6 @@ static void _destroy_id(struct rdma_id_private *id_priv,
> >  				iw_destroy_cm_id(id_priv->cm_id.iw);
> >  		}
> >  		cma_leave_mc_groups(id_priv);
> > -		rdma_restrack_del(&id_priv->res);
> >  		cma_release_dev(id_priv);
> 
> This seems to be the only hunk that is actually necessary, ensuring a
> non-added ID is always cleaned up is the necessary step to fixing the
> trace above.
> 
> What is the rest of this doing?? It looks wrong:
> 
> int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
> {
> [..]
> 	ret = cma_get_port(id_priv);
> 	if (ret)
> 		goto err2;
> err2:
> [..]
> 	if (!cma_any_addr(addr))
> 		rdma_restrack_del(&id_priv->res);
> 
> Which means if rdma_bind_addr() fails then restrack will discard the
> task, even though the cm_id is still valid! The ucma is free to try
> bind again and keep using the ID.

"Failure to bind" means that cma_attach_to_dev() needs to be unwind.

It is the same if rdma_restrack_add() inside that function like in this
patch or in the line before rdma_bind_addr() returns as it was in
previous code.

Thanks

> 
> Jason
