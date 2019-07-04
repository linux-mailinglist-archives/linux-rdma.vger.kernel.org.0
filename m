Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 212D65F19C
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2019 04:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfGDCvk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jul 2019 22:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfGDCvk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 3 Jul 2019 22:51:40 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D26962187F;
        Thu,  4 Jul 2019 02:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562208699;
        bh=jGhk6MtvBCeLFveN8/6kXa1ri4KxUPeZQ0ZdpfHRamI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UFi8s5naJs4CfiqrSmEspUJRTNjqwBTEb+uS9Zx6exY52EZBgQuxSFxQ9xyE7QkU5
         4BtDvdKZEdrsnTX5h2SykQla7CqTGF9ZWs7shsqyFBrtVtifYWTEnAx+vlQO/5LcIH
         ZgEg2yoqn0ytiBtcb9MJXRhrhknizjGgDmAuEW8w=
Date:   Thu, 4 Jul 2019 05:51:25 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Yamin Friedman <yaminf@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>
Subject: Re: [PATCH rdma-next v3 1/3] linux/dim: Implement RDMA adaptive
 moderation (DIM)
Message-ID: <20190704025125.GF4727@mtr-leonro.mtl.com>
References: <20190630091057.11507-1-leon@kernel.org>
 <20190630091057.11507-2-leon@kernel.org>
 <2b8e1c1c-a80a-bf02-0ca7-5124bcef2419@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b8e1c1c-a80a-bf02-0ca7-5124bcef2419@grimberg.me>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 03, 2019 at 01:51:51PM -0700, Sagi Grimberg wrote:
>
> > From: Yamin Friedman <yaminf@mellanox.com>
> >
> > RDMA DIM implements a different algorithm from net DIM and is based on
> > completions which is how we can implement interrupt moderation in RDMA.
> >
> > The algorithm optimizes for number of completions and ratio between
> > completions and events. In order to avoid long latencies, the
> > implementation performs fast reduction of moderation level when the
> > traffic changes.
> >
> > Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
> > Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
> > Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >   include/linux/dim.h |  36 +++++++++++++++
> >   lib/dim/Makefile    |   6 +--
> >   lib/dim/rdma_dim.c  | 108 ++++++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 146 insertions(+), 4 deletions(-)
> >   create mode 100644 lib/dim/rdma_dim.c
> >
> > diff --git a/include/linux/dim.h b/include/linux/dim.h
> > index aa9bdd47a648..1ae32835723a 100644
> > --- a/include/linux/dim.h
> > +++ b/include/linux/dim.h
> > @@ -82,6 +82,7 @@ struct dim_stats {
> >    * @prev_stats: Measured rates from previous iteration (for comparison)
> >    * @start_sample: Sampled data at start of current iteration
> >    * @work: Work to perform on action required
> > + * @dim_owner: A pointer to the struct that points to dim
> >    * @profile_ix: Current moderation profile
> >    * @mode: CQ period count mode
> >    * @tune_state: Algorithm tuning state (see below)
> > @@ -95,6 +96,7 @@ struct dim {
> >   	struct dim_sample start_sample;
> >   	struct dim_sample measuring_sample;
> >   	struct work_struct work;
> > +	void *dim_owner;
>
> This is different than the net consumers that init an embedded dim
> struct. I imagine that the reason is to not have this dim space in every
> ib_cq struct?

Yes, it was changed based on my review inputs.

>
> Would suggest to name it to 'priv' or 'dim_priv'
>
> Otherwise,
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Thanks a lot.
