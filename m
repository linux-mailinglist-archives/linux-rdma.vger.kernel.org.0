Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3E6D67EAC
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jul 2019 12:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfGNKzG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Jul 2019 06:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728147AbfGNKzG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 14 Jul 2019 06:55:06 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E81E20838;
        Sun, 14 Jul 2019 10:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563101705;
        bh=EXJQZgam0LEAocgtIeq/WkHtVsBngW5wNCftgVQqY4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nc2oObtiObhxm3oRNed0B7+ZKgjiAcR9DQIYOZXKRkIEpyzWfhap824N0JzcTNGU1
         42fGTqOj+Tvqevm0JW8fjORoX8Ow6BmZ2YtuqACP2BwsB00rJMgUP4bMNKzJ0lI/ow
         xhWxLyjL+wZVgQxRoc8h9S1lDanI5EP38FYs0dz8=
Date:   Sun, 14 Jul 2019 13:54:59 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yamin Friedman <yaminf@mellanox.com>
Subject: Re: [PATCH rdma-next] lib/dim: Prevent overflow in calculation of
 ratio statistics
Message-ID: <20190714105459.GA6039@mtr-leonro.mtl.com>
References: <20190711153118.14635-1-leon@kernel.org>
 <20190711154324.GK25821@mellanox.com>
 <20190711154734.GI23598@mtr-leonro.mtl.com>
 <20190711161103.GL25821@mellanox.com>
 <20190711171922.GJ23598@mtr-leonro.mtl.com>
 <20190711173110.GN25821@mellanox.com>
 <20190712060309.GM23598@mtr-leonro.mtl.com>
 <20190712152315.GD27526@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712152315.GD27526@mellanox.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 12, 2019 at 03:23:20PM +0000, Jason Gunthorpe wrote:
> On Fri, Jul 12, 2019 at 09:03:09AM +0300, Leon Romanovsky wrote:
> > On Thu, Jul 11, 2019 at 05:31:14PM +0000, Jason Gunthorpe wrote:
> > > On Thu, Jul 11, 2019 at 08:19:22PM +0300, Leon Romanovsky wrote:
> > > > On Thu, Jul 11, 2019 at 04:11:07PM +0000, Jason Gunthorpe wrote:
> > > > > On Thu, Jul 11, 2019 at 06:47:34PM +0300, Leon Romanovsky wrote:
> > > > > > > > diff --git a/lib/dim/dim.c b/lib/dim/dim.c
> > > > > > > > index 439d641ec796..38045d6d0538 100644
> > > > > > > > +++ b/lib/dim/dim.c
> > > > > > > > @@ -74,8 +74,8 @@ void dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
> > > > > > > >  					delta_us);
> > > > > > > >  	curr_stats->cpms = DIV_ROUND_UP(ncomps * USEC_PER_MSEC, delta_us);
> > > > > > > >  	if (curr_stats->epms != 0)
> > > > > > > > -		curr_stats->cpe_ratio =
> > > > > > > > -				(curr_stats->cpms * 100) / curr_stats->epms;
> > > > > > > > +		curr_stats->cpe_ratio = DIV_ROUND_DOWN_ULL(
> > > > > > > > +			curr_stats->cpms * 100, curr_stats->epms);
> > > > > > >
> > > > > > > This will still potentially overfow the 'int' for cpe_ratio if epms <
> > > > > > > 100 ?
> > > > > >
> > > > > > I assumed that assignment to "unsigned long long" will do the trick.
> > > > > > https://elixir.bootlin.com/linux/latest/source/include/linux/kernel.h#L94
> > > > >
> > > > > That only protects the multiply, the result of DIV_ROUND_DOWN_ULL is
> > > > > casted to int.
> > > >
> > > > It is ok, the result is "int" and it will be small, 100 in multiply
> > > > represents percentage.
> > >
> > > Percentage would be divide by 100..
> > >
> > > Like I said it will overflow if epms < 100 ...
> >
> > It is unlikely to happen because cpe_ratio is between 0 to 100 and cpms
> > * 100 is not large at all.
> >
> > UBSAN error is "theoretical" overflow.
>
> ? UBSAN is not theoretical, it only triggers if something actually
> happens. So in this case cpms*100 was very large and overflowed.
>
> Maybe it shouldn't be and that is the actual bug, but if we overflowed
> with cpms*100, then epms must be > 100 or we still overflow the
> divide.

I think that the real bug is cpms became too big.

Thanks

>
> Jason
