Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E03416866
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Sep 2021 01:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243533AbhIWXTD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Sep 2021 19:19:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236363AbhIWXTD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Sep 2021 19:19:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BBB760E94;
        Thu, 23 Sep 2021 23:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632439048;
        bh=zWojNpcodUwXnDCo0cXDCL2hbC6x/VnA2xVqVzva5kQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lgqk8MDJL1AeZJLSIWxfWoaiWtrzKeBz5W7dCpVzGo7bpDYtYEqvoG6W5ImjIwzvO
         ubjqW6ZnTPa2haqBVpS6a5zV+EI/3sYPItN5+zLEocXbdwBQVGZJiJkxvOQskFlVqC
         SInbUrd1tMoui54CuW79tQd/TzcaNT4xrvDUH7uwObwu6qUSo/AbVkD1E9AztAl61K
         EQYU6eC1Jp5kFRfbeS0yNtDvsSfbVZGpp7wn9JLj9i/aYp4ZZgV/pdpeht8C3589r1
         rO8k4t5WuIcMzbpcBkDKBeUzG2gcSpsXmOIY+/pxKxHPqBonGsncL6JZgKexRf5Nzx
         khIoqwyra4S1Q==
Date:   Fri, 24 Sep 2021 02:17:24 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, linux-rdma@vger.kernel.org,
        syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com
Subject: Re: [PATCH rc] RDMA/cma: Ensure rdma_addr_cancel() happens before
 issuing more requests
Message-ID: <YU0LBKU81wm75dw4@unreal>
References: <0-v1-3bc675b8006d+22-syz_cancel_uaf_jgg@nvidia.com>
 <YUri44sX8Lp3muc4@unreal>
 <20210922144119.GV327412@nvidia.com>
 <YUwVUjrqT2PyVEO7@unreal>
 <20210923114557.GI964074@nvidia.com>
 <YUzEUM8RPlFZSbJx@unreal>
 <20210923200358.GR964074@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923200358.GR964074@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 23, 2021 at 05:03:58PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 23, 2021 at 09:15:44PM +0300, Leon Romanovsky wrote:
> > On Thu, Sep 23, 2021 at 08:45:57AM -0300, Jason Gunthorpe wrote:
> > > On Thu, Sep 23, 2021 at 08:49:06AM +0300, Leon Romanovsky wrote:
> > > > On Wed, Sep 22, 2021 at 11:41:19AM -0300, Jason Gunthorpe wrote:
> > > > > On Wed, Sep 22, 2021 at 11:01:39AM +0300, Leon Romanovsky wrote:
> > > > > 
> > > > > > > +			/* The FSM can return back to RDMA_CM_ADDR_BOUND after
> > > > > > > +			 * rdma_resolve_ip() is called, eg through the error
> > > > > > > +			 * path in addr_handler. If this happens the existing
> > > > > > > +			 * request must be canceled before issuing a new one.
> > > > > > > +			 */
> > > > > > > +			if (id_priv->used_resolve_ip)
> > > > > > > +				rdma_addr_cancel(&id->route.addr.dev_addr);
> > > > > > > +			else
> > > > > > > +				id_priv->used_resolve_ip = 1;
> > > > > > 
> > > > > > Why don't you never clear this field?
> > > > > 
> > > > > The only case where it can be cleared is if we have called
> > > > > rdma_addr_cancel(), and since this is the only place that does it and
> > > > > immediately calls rdma_resolve_ip() again, there is no reason to ever
> > > > > clear it.
> > > > 
> > > > IMHO, it is better to clear instead to rely on "the only place" semantic.
> > > 
> > > Then the code looks really silly:
> > > 
> > > 	if (id_priv->used_resolve_ip) {
> > > 		rdma_addr_cancel(&id->route.addr.dev_addr);
> > >                 id_priv->used_resolve_ip = 0;
> > >         }
> > >         id_priv->used_resolve_ip = 1;
> > 
> > So write comment why you don't need to clear used_resolve_ip, but don't
> > leave it as it is now, where readers need to guess.
> >
> 
> I think it is a bit wordy, but I put this:
> 
> 			/*
> 			 * The FSM can return back to RDMA_CM_ADDR_BOUND after
> 			 * rdma_resolve_ip() is called, eg through the error
> 			 * path in addr_handler(). If this happens the existing
> 			 * request must be canceled before issuing a new one.
> 			 * Since canceling a request is a bit slow and this
> 			 * oddball path is rare, keep track once a request has
> 			 * been issued. The track turns out to be a permanent
> 			 * state since this is the only cancel as it is
> 			 * immediately before rdma_resolve_ip().
> 			 */
> 
> And into for-rc

Thanks

> 
> Jason
