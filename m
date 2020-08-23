Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0DE24ED3A
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Aug 2020 14:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgHWMdr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Aug 2020 08:33:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbgHWMdq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 23 Aug 2020 08:33:46 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45B2F2074D;
        Sun, 23 Aug 2020 12:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598186026;
        bh=2FZWewom4CC1BIdqLa5RiWLiOdm2EAymasSHJr3WVB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ddbiRS4niF1LindwGxxDw5dBxZy/PhpKPWSQOmYnIkmF6O9YWOdqqcQDd0giWag1c
         SeOfSBfudXGR8aRTNmW6VdFTJ/ww+Upe9GCHR7C+DzFBeBjiwbqJMF6v+5Mz/twNSx
         UF8JMPxBipVeW2qHyfn0xaGHxBOxoUXRkCb+T+r8=
Date:   Sun, 23 Aug 2020 15:33:42 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     jackm <jackm@dev.mellanox.co.il>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mark Bloch <markb@mellanox.com>,
        Eli Cohen <eli@mellanox.co.il>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Roland Dreier <rolandd@cisco.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx4: Read pkey table length instead of
 hardcoded value
Message-ID: <20200823123342.GC571722@unreal>
References: <20200823061754.573919-1-leon@kernel.org>
 <20200823142739.0000447e@dev.mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823142739.0000447e@dev.mellanox.co.il>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 23, 2020 at 02:27:39PM +0300, jackm wrote:
> On Sun, 23 Aug 2020 09:17:54 +0300
> Leon Romanovsky <leon@kernel.org> wrote:
>
> > From: Mark Bloch <markb@mellanox.com>
> >
> > The driver shouldn't assume that a pkey table is available, this
> > can happen if RoCE isn't supported by the device.
> >
> > Use the pkey table length reported by the device. This together with
> > the cited commit from Jack caused a regression where mlx4 devices
> > without RoCE aren't created.
>
> I don't understand. Do you mean that WITH this patch there is a
> regression, or do you mean that this patch FIXES the regression?

This specific patch fixes regression.

>
> If this patch fixes the regression, I suggest the following replacement
> text for the last paragraph:
>
> If the pkey_table is not available (which is the case when RoCE is not
> supported), the cited commit caused a regression where mlx4_devices
> without RoCE are not created.
>
> Fix this by returning a pkey table length of zero in procedure
> eth_link_query_port() if the pkey-table length reported by the device
> is zero.

I'll change, thanks.

>
> >
> > Cc: <stable@vger.kernel.org>
> > Cc: Long Li <longli@microsoft.com>
> > Fixes: 1901b91f9982 ("IB/core: Fix potential NULL pointer dereference
> > in pkey cache") Fixes: fa417f7b520e ("IB/mlx4: Add support for IBoE")
> > Signed-off-by: Mark Bloch <markb@mellanox.com>
> > Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/infiniband/hw/mlx4/main.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx4/main.c
> > b/drivers/infiniband/hw/mlx4/main.c index 5e7910a517da..bd4f975e7f9a
> > 100644 --- a/drivers/infiniband/hw/mlx4/main.c
> > +++ b/drivers/infiniband/hw/mlx4/main.c
> > @@ -784,7 +784,8 @@ static int eth_link_query_port(struct ib_device
> > *ibdev, u8 port, props->ip_gids = true;
> >  	props->gid_tbl_len	=
> > mdev->dev->caps.gid_table_len[port]; props->max_msg_sz	=
> > mdev->dev->caps.max_msg_sz;
> > -	props->pkey_tbl_len	= 1;
>
> I don't like depending on the caller to provide a zeroed-out props
> structure.
> I think it is better to do:
>    props->pkey_tbl_len = mdev->dev->caps.pkey_table_len[port] ? 1 : 0 ;
> so that the pkey_table_len value is set no matter what.

"props" are cleared by definition of IB/core to make sure that drivers
doesn't return junk in ->query_port() for the fields that are not assigned.
This is why I removed redundant assignment to 0.

Thanks

>
> > +	if (mdev->dev->caps.pkey_table_len[port])
> > +		props->pkey_tbl_len = 1;
> >  	props->max_mtu		= IB_MTU_4096;
> >  	props->max_vl_num	= 2;
> >  	props->state		= IB_PORT_DOWN;
>
> -Jack
>
