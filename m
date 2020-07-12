Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B32021CACA
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2020 19:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgGLRkW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Jul 2020 13:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729365AbgGLRkV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 12 Jul 2020 13:40:21 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1F882063A;
        Sun, 12 Jul 2020 17:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594575621;
        bh=n0L0L6/ApR3QKbHijWxeL6f5uKpPoWVTkiWED8W1imM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mg88J7rxY8OEEf38gtog2X6yi6tJV7OPrTUy5vBACcfW9841D7a0XMAunyODGhFSz
         dXmf9TMcc8Ad44phYEK2DCrjdZTAo/SNe0QJf62hF5BMvlaxJCyK8e7tFmcnE5EamA
         8RfUiD0GzLSiBnKgpN3atLn7SXI5VpbYe24rnEHI=
Date:   Sun, 12 Jul 2020 20:40:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Daria Velikovsky <daria@mellanox.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Init dest_type when create flow
Message-ID: <20200712174016.GC7287@unreal>
References: <20200707110259.882276-1-leon@kernel.org>
 <20200710194644.GA2130282@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710194644.GA2130282@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 10, 2020 at 04:46:44PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 07, 2020 at 02:02:59PM +0300, Leon Romanovsky wrote:
> > From: Daria Velikovsky <daria@mellanox.com>
> >
> > When using action drop dest_type was never assigned to any value.
> > Add initialization of dest_type to -1 since 0 is valid.
> >
> > Fixes: f29de9eee782 ("RDMA/mlx5: Add support for drop action in DV steering")
> > Signed-off-by: Daria Velikovsky <daria@mellanox.com>
> > Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  Based on
> > https://lore.kernel.org/lkml/20200702081809.423482-1-leon@kernel.org
> >  drivers/infiniband/hw/mlx5/fs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
> > index 0d8abb7c3cdf..1a7e6226f11a 100644
> > +++ b/drivers/infiniband/hw/mlx5/fs.c
> > @@ -1903,7 +1903,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
> >  	struct mlx5_flow_context flow_context = {.flow_tag =
> >  		MLX5_FS_DEFAULT_FLOW_TAG};
> >  	u32 *offset_attr, offset = 0, counter_id = 0;
> > -	int dest_id, dest_type, inlen, len, ret, i;
> > +	int dest_id, dest_type = -1, inlen, len, ret, i;
>
> I think this should be done inside get_dests() - it is pretty ugly to
> have an function with an output pointer that is only filled sometimes
> on success.

This was original patch which I rewrote because don't like the approach
when function changes fields when it doesn't need to change. I prefer
the current approach where caller has explicitly decided which default
value he wants.

Thanks

>
> Jason
