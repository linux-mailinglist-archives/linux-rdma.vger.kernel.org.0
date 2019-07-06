Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC9F61231
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Jul 2019 18:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfGFQfs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 6 Jul 2019 12:35:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfGFQfr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 6 Jul 2019 12:35:47 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8023820659;
        Sat,  6 Jul 2019 16:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562430946;
        bh=jskFX0Dbol/S3QOZhJl9/jt9RHE56eX0jCokgo1eLkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O2y+Zy1tqBYCDTGhj1gPWah8nfChosGWPh0y3vMAJv1sVZCti7XbrfQI3p4zz+jOP
         h+qOmkzBzMdH/m6xWKeN55NO84c6reHWBZMH4DgR+HPAPWIL16286psp/3dn8rkRjK
         UBIjM9ZYBKjQQgsN2M8wlHN60dtxSvrilbHXvbts=
Date:   Sat, 6 Jul 2019 19:35:23 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Danit Goldberg <danitg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/mlx5: Report correctly tag matching
 rendezvous capability
Message-ID: <20190706163523.GA18182@mtr-leonro.mtl.com>
References: <20190705162157.17336-1-leon@kernel.org>
 <20190705171555.GH31525@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705171555.GH31525@mellanox.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 05, 2019 at 05:15:59PM +0000, Jason Gunthorpe wrote:
> On Fri, Jul 05, 2019 at 07:21:57PM +0300, Leon Romanovsky wrote:
> > From: Danit Goldberg <danitg@mellanox.com>
> >
> > Tag matching with rendezvous offload for RC transport is controlled
> > by FW and before this change, it was advertised to user as supported
> > without any relation to FW.
> >
> > Separate tag matching for rendezvous and eager protocols, so users
> > will see real capabilities.
> >
> > Cc: <stable@vger.kernel.org> # 4.13
> > Fixes: eb761894351d ("IB/mlx5: Fill XRQ capabilities")
> > Signed-off-by: Danit Goldberg <danitg@mellanox.com>
> > Reviewed-by: Yishai Hadas <yishaih@mellanox.com>
> > Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/hw/mlx5/main.c | 8 ++++++--
> >  include/rdma/ib_verbs.h           | 4 ++--
> >  2 files changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> > index 07a05b0b9e42..c2a5780cb394 100644
> > +++ b/drivers/infiniband/hw/mlx5/main.c
> > @@ -1046,15 +1046,19 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
> >  	}
> >
> >  	if (MLX5_CAP_GEN(mdev, tag_matching)) {
> > -		props->tm_caps.max_rndv_hdr_size = MLX5_TM_MAX_RNDV_MSG_SIZE;
> >  		props->tm_caps.max_num_tags =
> >  			(1 << MLX5_CAP_GEN(mdev, log_tag_matching_list_sz)) - 1;
> > -		props->tm_caps.flags = IB_TM_CAP_RC;
> >  		props->tm_caps.max_ops =
> >  			1 << MLX5_CAP_GEN(mdev, log_max_qp_sz);
> >  		props->tm_caps.max_sge = MLX5_TM_MAX_SGE;
> >  	}
> >
> > +	if (MLX5_CAP_GEN(mdev, tag_matching) &&
> > +	    MLX5_CAP_GEN(mdev, rndv_offload_rc)) {
> > +		props->tm_caps.flags = IB_TM_CAP_RNDV_RC;
> > +		props->tm_caps.max_rndv_hdr_size = MLX5_TM_MAX_RNDV_MSG_SIZE;
> > +	}
> > +
> >  	if (MLX5_CAP_GEN(dev->mdev, cq_moderation)) {
> >  		props->cq_caps.max_cq_moderation_count =
> >  						MLX5_MAX_CQ_COUNT;
> > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> > index 30eb68f36109..c5f8a9f17063 100644
> > +++ b/include/rdma/ib_verbs.h
> > @@ -308,8 +308,8 @@ struct ib_rss_caps {
> >  };
> >
> >  enum ib_tm_cap_flags {
> > -	/*  Support tag matching on RC transport */
> > -	IB_TM_CAP_RC		    = 1 << 0,
> > +	/*  Support tag matching with rendezvous offload for RC transport */
> > +	IB_TM_CAP_RNDV_RC = 1 << 0,
> >  };
>
> This is in the wrong header, right?

It predates our all-to-uapi headers approach and moving to UAPI this struct
is definitely too much for a fix which should go to stable@.

Thanks

>
> Jason
