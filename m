Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715023B5896
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jun 2021 07:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhF1FZN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Jun 2021 01:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbhF1FZN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Jun 2021 01:25:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C70536198A;
        Mon, 28 Jun 2021 05:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624857768;
        bh=+o7WGKvwDW+ueEpME8OSZh7rG0yScCEmn09xSWcHm2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zc3FVj5fUj2MY1o2VkOBhawT0rO1J1YO3COerIGmuJW6iYbeCgIEfiHWX3/W0jQBi
         SiJOfaiMgAOkz/ZsLLJlnhtyS31Np4jed+wO8VGh5NVa3l1a2xRG4EquKsZ3QjwmzP
         McLwEh8CPe992SPIDrzid0gQGJixFancyHKoC7UhmFaMb7jlXjhJ356GJSDYz6i7Z4
         DlRD4kBZgq4YQNHSlX296+ee1YV0s8eRMs7gmaCw+/G3vLH2WWo52WY1Sr1q5Hgfho
         anjddxwNu6mTwl7FxnLbfsuC+BaDoEXha5gdGDhlMxMNX2fApS2FDwyYYgV8rhMqpW
         lMHm/1Roxt0qQ==
Date:   Mon, 28 Jun 2021 08:22:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Pavel Skripkin <paskripkin@gmail.com>,
        Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH rdma-rc v2] RDMA/core: Simplify addition of restrack
 object
Message-ID: <YNlcpfdsdJdwMp5l@unreal>
References: <e2eed941f912b2068e371fd37f43b8cf5082a0e6.1623129597.git.leonro@nvidia.com>
 <20210624174841.GA2906108@nvidia.com>
 <YNgxxTQ4NW0yGHq1@unreal>
 <20210627231528.GA4459@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210627231528.GA4459@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 27, 2021 at 08:15:28PM -0300, Jason Gunthorpe wrote:
> On Sun, Jun 27, 2021 at 11:07:33AM +0300, Leon Romanovsky wrote:
> > On Thu, Jun 24, 2021 at 02:48:41PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jun 08, 2021 at 08:23:48AM +0300, Leon Romanovsky wrote:
> > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > 
> > > > Change location of rdma_restrack_add() callers to be near attachment
> > > > to device logic. Such improvement fixes the bug where task_struct was
> > > > acquired but not released, causing to resource leak.
> > > > 
> > > >   ucma_create_id() {
> > > >     ucma_alloc_ctx();
> > > >     rdma_create_user_id() {
> > > >       rdma_restrack_new();
> > > >       rdma_restrack_set_name() {
> > > >         rdma_restrack_attach_task.part.0(); <--- task_struct was gotten
> > > >       }
> > > >     }
> > > >     ucma_destroy_private_ctx() {
> > > >       ucma_put_ctx();
> > > >       rdma_destroy_id() {
> > > >         _destroy_id()                       <--- id_priv was freed
> > > >       }
> > > >     }
> > > >   }
> > > 
> > > I still don't understand this patch
> > > 
> > > > @@ -1852,6 +1849,7 @@ static void _destroy_id(struct rdma_id_private *id_priv,
> > > >  {
> > > >  	cma_cancel_operation(id_priv, state);
> > > >  
> > > > +	rdma_restrack_del(&id_priv->res);
> > > >  	if (id_priv->cma_dev) {
> > > >  		if (rdma_cap_ib_cm(id_priv->id.device, 1)) {
> > > >  			if (id_priv->cm_id.ib)
> > > > @@ -1861,7 +1859,6 @@ static void _destroy_id(struct rdma_id_private *id_priv,
> > > >  				iw_destroy_cm_id(id_prgtiv->cm_id.iw);
> > > >  		}
> > > >  		cma_leave_mc_groups(id_priv);
> > > > -		rdma_restrack_del(&id_priv->res);
> > > >  		cma_release_dev(id_priv);
> > > 
> > > This seems to be the only hunk that is actually necessary, ensuring a
> > > non-added ID is always cleaned up is the necessary step to fixing the
> > > trace above.
> > > 
> > > What is the rest of this doing?? It looks wrong:
> > > 
> > > int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
> > > {
> > > [..]
> > > 	ret = cma_get_port(id_priv);
> > > 	if (ret)
> > > 		goto err2;
> > > err2:
> > > [..]
> > > 	if (!cma_any_addr(addr))
> > > 		rdma_restrack_del(&id_priv->res);
> > > 
> > > Which means if rdma_bind_addr() fails then restrack will discard the
> > > task, even though the cm_id is still valid! The ucma is free to try
> > > bind again and keep using the ID.
> > 
> > "Failure to bind" means that cma_attach_to_dev() needs to be unwind.
> > 
> > It is the same if rdma_restrack_add() inside that function like in this
> > patch or in the line before rdma_bind_addr() returns as it was in
> > previous code.
> 
> The previous code didn't call restrack_del. restrack_del undoes the
> restrack_set_name stuff, not just add - so it does not leave things
> back the way it found them

The previous code didn't call to restrack_add and this is why it didn't
call to restrack_del later. In old and new code, we are still calling to
acquire and release dev (cma_acquire_dev_by_src_ip/cma_release_dev) and
this is where the CM_ID is actually attached.

Thanks

> 
> Jason
