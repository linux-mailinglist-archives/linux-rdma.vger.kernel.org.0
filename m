Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE77416516
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Sep 2021 20:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhIWSRV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Sep 2021 14:17:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233874AbhIWSRU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Sep 2021 14:17:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EE0560F43;
        Thu, 23 Sep 2021 18:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632420948;
        bh=eHZ0Cbk7iNNHak/Wq1cvrWpHj+xX3bTkp+AeQIatl5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gIqOiH0J9GiaN8NfdvE+AHIUG+XQtHAJvJOse5a4TigaIOlhQLKBsj266Uy4xG3sV
         owOp5PkfznRYL7C+pM9oxxBA6JCpR7cLtCRR8uXyhyn4l1uWgJMia0/z9PvVydU0Pq
         SBzOi8Yax6iT4ebQ4KQTPBaRjLyKgbekGjfSJIWHe9fbE4fa424X4bmpiJxX1aaF4F
         5injKi2utEBqVB6e4DB/PLfLgCHN4gtzPzikswWh14racwSjfJJBtX3pEo0TIAaESd
         FSy1hnJf3QRRXr+qpsr/JLHkv1Kv/Xyh1HqIR40LAlJsbmoEQQ0f/qLDwaBHe1sjxJ
         0Gf0Rt1NPvMsw==
Date:   Thu, 23 Sep 2021 21:15:44 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, linux-rdma@vger.kernel.org,
        syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com
Subject: Re: [PATCH rc] RDMA/cma: Ensure rdma_addr_cancel() happens before
 issuing more requests
Message-ID: <YUzEUM8RPlFZSbJx@unreal>
References: <0-v1-3bc675b8006d+22-syz_cancel_uaf_jgg@nvidia.com>
 <YUri44sX8Lp3muc4@unreal>
 <20210922144119.GV327412@nvidia.com>
 <YUwVUjrqT2PyVEO7@unreal>
 <20210923114557.GI964074@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923114557.GI964074@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 23, 2021 at 08:45:57AM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 23, 2021 at 08:49:06AM +0300, Leon Romanovsky wrote:
> > On Wed, Sep 22, 2021 at 11:41:19AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Sep 22, 2021 at 11:01:39AM +0300, Leon Romanovsky wrote:
> > > 
> > > > > +			/* The FSM can return back to RDMA_CM_ADDR_BOUND after
> > > > > +			 * rdma_resolve_ip() is called, eg through the error
> > > > > +			 * path in addr_handler. If this happens the existing
> > > > > +			 * request must be canceled before issuing a new one.
> > > > > +			 */
> > > > > +			if (id_priv->used_resolve_ip)
> > > > > +				rdma_addr_cancel(&id->route.addr.dev_addr);
> > > > > +			else
> > > > > +				id_priv->used_resolve_ip = 1;
> > > > 
> > > > Why don't you never clear this field?
> > > 
> > > The only case where it can be cleared is if we have called
> > > rdma_addr_cancel(), and since this is the only place that does it and
> > > immediately calls rdma_resolve_ip() again, there is no reason to ever
> > > clear it.
> > 
> > IMHO, it is better to clear instead to rely on "the only place" semantic.
> 
> Then the code looks really silly:
> 
> 	if (id_priv->used_resolve_ip) {
> 		rdma_addr_cancel(&id->route.addr.dev_addr);
>                 id_priv->used_resolve_ip = 0;
>         }
>         id_priv->used_resolve_ip = 1;

So write comment why you don't need to clear used_resolve_ip, but don't
leave it as it is now, where readers need to guess.

Thanks

> 
> Jason
