Return-Path: <linux-rdma+bounces-13244-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9893B51415
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 12:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C8337BD94F
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 10:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B173168FB;
	Wed, 10 Sep 2025 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDV3wOaN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BE53168E8;
	Wed, 10 Sep 2025 10:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757500054; cv=none; b=TG2QqLLyDUysJxHbie1o2tSi28aIJ8ZE5MEmE4fxdJ3P1J/pbZOITirRrbKrdUvbVUPRGfByj8jQziz6QjGZ/ikW2Wq9dJv9B5DZYCd85o1cBiFLr0zBiamnv+XzdW78VQK+EPzl2tgZSpisrNdwRI1d/7A/mgPoJwSHjMdXUb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757500054; c=relaxed/simple;
	bh=KhEMuvVrOJ6kfh3E7NEPQFw2W+J72hOgAE/qSgliAVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6Eg0Kt9XCZ9wauhRewL81EWIo9PfriaybIDCxLu7WcAblcmyFVPPwWQe+nBRRPYGAUCIGxFOpljZhheMb2sjYJoGK13sUG71uQ8/BIqWYyTwm30b2pK4Yl+YIYkknLY9CRZ4htFdYw+eoSk5W7knhG1sWt8iltt2i8kEdT5vDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDV3wOaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA29C4CEF0;
	Wed, 10 Sep 2025 10:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757500053;
	bh=KhEMuvVrOJ6kfh3E7NEPQFw2W+J72hOgAE/qSgliAVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gDV3wOaNIHd8MA/PqYOrPRUxvir9KKCe08yzJLmqABNXKWjjMSv7WxnYzwVeRSPIm
	 d2rLANlD6lL1Cj0mbBfOPOb0jNcIpxcQxGvICBR8VsYWdLU3CUvytjhXcyK8Nt0oE3
	 L7JhjIzKD4LNpZbjobOEJ6y716IclJn+aRCDG4Z7OJ6UzWo8i3qph0dJuDwjG1Eq9+
	 9T+IXY6B6iVjnUx8ElwmpyemD2X8x9hNWNOTYHhbKq+OBySel9pCM+g0NtxfRH5Jea
	 tmAOhr5LYoBZfH3+UPPv9ngBvYXso0g/agfREMhrQdrJSQ97hG+Q9qCceoij5Z9y3f
	 Y5pcSAGpSBqIw==
Date: Wed, 10 Sep 2025 13:27:29 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <yanjun.zhu@linux.dev>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] rdma_rxe: call comp_handler without holding
 cq->cq_lock
Message-ID: <20250910102729.GP341237@unreal>
References: <20250822081941.989520-1-philipp.reisner@linbit.com>
 <20250908142457.GA341237@unreal>
 <CADGDV=XNrmNo5gNZ1cX4eGUi+0xgAcQzra+pNHNGuQbc0DrpKA@mail.gmail.com>
 <20250909153133.GA882933@ziepe.ca>
 <CADGDV=VZK4oXM=h4PzYOm_PJihMKdQUkrADOiw6EaC4kCssAcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADGDV=VZK4oXM=h4PzYOm_PJihMKdQUkrADOiw6EaC4kCssAcQ@mail.gmail.com>

On Tue, Sep 09, 2025 at 06:00:36PM +0200, Philipp Reisner wrote:
> On Tue, Sep 9, 2025 at 5:31 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Sep 09, 2025 at 04:48:19PM +0200, Philipp Reisner wrote:
> > > On Mon, Sep 8, 2025 at 4:25 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Fri, Aug 22, 2025 at 10:19:41AM +0200, Philipp Reisner wrote:
> > > > > Allow the comp_handler callback implementation to call ib_poll_cq().
> > > > > A call to ib_poll_cq() calls rxe_poll_cq() with the rdma_rxe driver.
> > > > > And rxe_poll_cq() locks cq->cq_lock. That leads to a spinlock deadlock.
> > > >
> > > > Can you please be more specific about the deadlock?
> > > > Please write call stack to describe it.
> > > >
> > > Instead of a call stack, I write it from top to bottom:
> > >
> > > The line numbers in the .c files are valid for Linux-6.16:
> > >
> > > 1  rxe_cq_post()                      [rxe_cq.c:85]
> > > 2   spin_lock_irqsave()               [rxe_cq.c:93]
> > > 3   cq->ibcq.comp_handler()           [rxe_cq.c:116]
> > > 4    some_comp_handler()
> > > 5     ib_poll_cq()
> > > 6      cq->device->ops.poll_cq()      [ib_verbs.h:4037]
> > > 7       rxe_poll_cq()                 [rxe_verbs.c:1165]
> > > 8        spin_lock_irqsave()          [rxe_verbs.c:1172]
> > >
> > > In line 8 of this call graph, it deadlocks because the spinlock
> > > was already acquired in line 2 of the call graph.
> >
> > Is this even legal in verbs? I'm not sure you can do pull cq from a
> > interrupt driven comp handler.. Is something already doing this intree?
> >
> 
> The file drivers/infiniband/sw/rdmavt/cq.c has this comment:
> /*
> * The completion handler will most likely rearm the notification
> * and poll for all pending entries.  If a new completion entry
> * is added while we are in this routine, queue_work()
> * won't call us again until we return so we check triggered to
> * see if we need to call the handler again.
> */
> 
> Also, Intel and Mellanox cards and drivers allow calling ib_poll_cq()
> from the completion handler.

And do these drivers drop CQ lock like you are proposing here?

> 
> The problem exists only with the RXE driver.

