Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EA47A9944
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Sep 2023 20:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjIUSMi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 14:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjIUSM0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 14:12:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A516E8F
        for <linux-rdma@vger.kernel.org>; Thu, 21 Sep 2023 10:22:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168F0C43395;
        Thu, 21 Sep 2023 06:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695278605;
        bh=qq+kg2wA4MpE8AKJ//PCkSMEtTCJ+p09CErqp0/NIUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AIi+zFG36mc+9mpMuWIN1dLR+tbCiG/rHx09Ef5Uuyj05eCB2DYifA9dQjljKX7H7
         6EQ77jyMAZA8HB+O3bhR/t3FTT6uBc3tTJ7T5jdb8qcxF6sPvzsjnWcqIeHPqgheat
         jYe/aM+LBYPVwzYznPcOiDYl24qOOa15UJG+bzpWLfyUFJgdk3dAQHEtHTKfXByrX+
         8IqLYkPMJYyQEq43CAwdcCpsFpcDbVW8MIPgv3YW/rLaEk6GUSfwH+tieIEpGH7Hv+
         POliJmR2xEFG1yq6TYBdtLEUzU7bwE9tB6uDKfGUWVhyBEwOhQrM97IQ0Hxla30zeU
         EBhrpvdIT+utg==
Date:   Thu, 21 Sep 2023 09:43:21 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shay Drory <shayd@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Implement mkeys management via LIFO
 queue
Message-ID: <20230921064321.GA1642130@unreal>
References: <96049c4bd3346a98240483ed2d22c5b1c7155c8a.1695203535.git.leon@kernel.org>
 <20230920163637.GE13733@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920163637.GE13733@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 20, 2023 at 01:36:37PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 20, 2023 at 12:54:56PM +0300, Leon Romanovsky wrote:
> > From: Shay Drory <shayd@nvidia.com>
> > 
> > Currently, mkeys are managed via xarray. This implementation leads to
> > a degradation in cases many MRs are unregistered in parallel, due to xarray
> > internal implementation, for example: deregistration 1M MRs via 64 threads
> > is taking ~15% more time[1].
> > 
> > Hence, implement mkeys management via LIFO queue, which solved the
> > degradation.
> > 
> > [1]
> > 2.8us in kernel v5.19 compare to 3.2us in kernel v6.4
> > 
> > Signed-off-by: Shay Drory <shayd@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/infiniband/hw/mlx5/mlx5_ib.h |  19 +-
> >  drivers/infiniband/hw/mlx5/mr.c      | 324 ++++++++++++---------------
> >  drivers/infiniband/hw/mlx5/umr.c     |   4 +-
> >  3 files changed, 167 insertions(+), 180 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > index 16713baf0d06..261c86fe6433 100644
> > --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > @@ -753,10 +753,23 @@ struct umr_common {
> >  	unsigned int state;
> >  };
> >  
> > +#define NUM_MKEYS_PER_PAGE (PAGE_SIZE / sizeof(u32))
> > +
> > +struct mlx5_mkeys_page {
> > +	u32 mkeys[NUM_MKEYS_PER_PAGE];
> > +	struct list_head list;
> > +};
> 
> Er, isn't the point of this to be PAGE_SIZE big?

The more important part is preallocation of whole struct mlx5_mkeys_page
to hold multiple keys in one shot. The PAGE_SIZE alignment can
definitely help to make it even more efficient, but it is not culprit
of this patch.

I will change.

Thanks

> 
> Add an
> 
> static_assert(sizeof(struct mlx5_mkeys_page) == PAGE_SIZE)
> 
> And fix it so it is true..
> 
> Jason
