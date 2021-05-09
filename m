Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BC63776F1
	for <lists+linux-rdma@lfdr.de>; Sun,  9 May 2021 16:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhEIOQR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 May 2021 10:16:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229635AbhEIOQQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 9 May 2021 10:16:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D968C61263;
        Sun,  9 May 2021 14:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620569713;
        bh=WlxZ9Qpp57zutjIZP254kS7EOHYPZOtXBJKniOAadOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uQjzd3Soj9mPCwXtzeAOkyv31csT0dOyBpPikWJgQZQuU6e67xTrmkyWBo76XIhsX
         YfGMzjYLzIn5SPQlzicvYC6FPSQP/kZTbBYXre187m8jTqkyhu8raNQ25MJqNpeOe1
         kr4c3e5/eE1/Q4pvdAYQbUBrtau0E5rz6d3kU6bafpHS5D4QklCA6+wbDqhlNRvIPN
         qE5qIc+uwCwx5vLje2Rbc0g0ggB5K/lJrYXdoSxyNMoHbzzlVBy7+D8URK8bumJn15
         gIh+6vpxEAJRf7mVue7Fu3Qc3wzvFnuzQKf7rNgbGsoPolosQJ45sl0gQhJXEskl9z
         E+pg5waaCrxyg==
Date:   Sun, 9 May 2021 17:15:09 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     =?utf-8?B?6Zmz5YGJ6YqY?= <jj251510319013@gmail.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] i40iw: Use fallthrough pseudo-keyword
Message-ID: <YJfubeqo49bF7qgH@unreal>
References: <20210509083135.14575-1-jj251510319013@gmail.com>
 <YJe+XDO5PEr4SF0l@unreal>
 <CAJwFiGLyH5aOY=MGvCawWBm7fXuPkndBO83jkT9dWhPpnrd+cw@mail.gmail.com>
 <YJfT66KM189Y8PcN@unreal>
 <CAJwFiGK-ABAuNGcFbXAr6d6bn10_t8O+3h09Xt15WGh-7G1W3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJwFiGK-ABAuNGcFbXAr6d6bn10_t8O+3h09Xt15WGh-7G1W3A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 09, 2021 at 09:55:57PM +0800, 陳偉銘 wrote:
> >Leon Romanovsky <leon@kernel.org> 於 2021年5月9日 週日 下午8:22寫道：
> > Please don't top-post, use HTML emails and always CC mailing list.
> 
> > I'm saying that there is a difference between two following snippets:
> > switch (value) {
> > case STATE_ONE:
> >         do_something();
> > case STATE_TWO:
> >         do_other();
> >         break;
> > default:
> >         WARN("unknown state");
> > }
> > and
> >
> > switch (value) {
> > case STATE_ONE:
> > case STATE_TWO:
> >         do_other();
> >         break;
> > default:
> >         WARN("unknown state");
> > }
> >
> > While the first one needs "fallthrough" keyword, the second one doesn't.
> 
> > Thanks
> 
> Hi,
> 
> Sorry for making trouble, hope that I make it right this time.
> 
> Thanks for the detailed explanation, since that it is not needed to use
> "fallthrough" if no code in "case", maybe we should clarify for this
> condition in the documentataion? Otherwise, I guess there might be someone
> else like me making this mistake again in the future.

I don't think that it is necessary.

Thanks.

> 
> Thanks!
> 
> Wei Ming Chen
