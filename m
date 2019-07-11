Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3440565E60
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 19:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfGKRT3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 13:19:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbfGKRT3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Jul 2019 13:19:29 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B29D20863;
        Thu, 11 Jul 2019 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562865568;
        bh=cfGwtCgFYXuc/G/uPXo6y9PwKJja4bwjO41HTbLMF20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N0bwNm0m2LjHeXBSNu2GXD9Bfu8I/5ejXNGi6Tt3uN8haPGefjtBeIvdLVgcLzyiH
         Ee//Lj52pbUQYqgrsSb9qaYAEuyoG2iv9OkmR2HyAALsJAY2syLtNp7zAtE+G177Th
         l3lAPVlw96ZqqbPdHnEOd+jrZ0xGpby3f+XNSpeQ=
Date:   Thu, 11 Jul 2019 20:19:22 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yamin Friedman <yaminf@mellanox.com>
Subject: Re: [PATCH rdma-next] lib/dim: Prevent overflow in calculation of
 ratio statistics
Message-ID: <20190711171922.GJ23598@mtr-leonro.mtl.com>
References: <20190711153118.14635-1-leon@kernel.org>
 <20190711154324.GK25821@mellanox.com>
 <20190711154734.GI23598@mtr-leonro.mtl.com>
 <20190711161103.GL25821@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711161103.GL25821@mellanox.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 11, 2019 at 04:11:07PM +0000, Jason Gunthorpe wrote:
> On Thu, Jul 11, 2019 at 06:47:34PM +0300, Leon Romanovsky wrote:
> > > > diff --git a/lib/dim/dim.c b/lib/dim/dim.c
> > > > index 439d641ec796..38045d6d0538 100644
> > > > +++ b/lib/dim/dim.c
> > > > @@ -74,8 +74,8 @@ void dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
> > > >  					delta_us);
> > > >  	curr_stats->cpms = DIV_ROUND_UP(ncomps * USEC_PER_MSEC, delta_us);
> > > >  	if (curr_stats->epms != 0)
> > > > -		curr_stats->cpe_ratio =
> > > > -				(curr_stats->cpms * 100) / curr_stats->epms;
> > > > +		curr_stats->cpe_ratio = DIV_ROUND_DOWN_ULL(
> > > > +			curr_stats->cpms * 100, curr_stats->epms);
> > >
> > > This will still potentially overfow the 'int' for cpe_ratio if epms <
> > > 100 ?
> >
> > I assumed that assignment to "unsigned long long" will do the trick.
> > https://elixir.bootlin.com/linux/latest/source/include/linux/kernel.h#L94
>
> That only protects the multiply, the result of DIV_ROUND_DOWN_ULL is
> casted to int.

It is ok, the result is "int" and it will be small, 100 in multiply
represents percentage.

Thanks

>
> Jason
