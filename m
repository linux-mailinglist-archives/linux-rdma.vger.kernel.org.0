Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5A026C0A9
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 11:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgIPJdn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 05:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgIPJdf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Sep 2020 05:33:35 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67AD022226;
        Wed, 16 Sep 2020 09:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600248815;
        bh=ZWpeF9p4qeXWo7wxZRlGAGiUowcTIkJr/OueO3kHVJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aO0o3tVoUaEqRfWkA/h2pEuS6QNKT1gVdDficiauQPZxKvlTQGrVknd2wbddliF+V
         iHslxedDhVxbxyaZuy8/rrh5+7WP3j6gDVKvgHwvemhOdaWgF023hLUDpKVMaXlmCv
         kTrN3vys/TMqJRcYuEr+HngV2lFQIj7TxluEdCjQ=
Date:   Wed, 16 Sep 2020 12:33:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, Alex Vesker <valex@nvidia.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 2/3] RDMA/mlx5: Allow DM allocation for
 sw_owner_v2 enabled devices
Message-ID: <20200916093330.GF486552@unreal>
References: <20200903073857.1129166-1-leon@kernel.org>
 <20200903073857.1129166-3-leon@kernel.org>
 <20200915200447.GA1592810@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915200447.GA1592810@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 15, 2020 at 05:04:47PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 03, 2020 at 10:38:56AM +0300, Leon Romanovsky wrote:
> > From: Alex Vesker <valex@nvidia.com>
> >
> > sw_owner_v2 will replace sw_owner for future devices, this means
> > that if sw_owner_v2 is set sw_owner should be ignored and DM
> > allocation is required for sw_owner_v2 devices to function.
> >
> > Signed-off-by: Alex Vesker <valex@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >  drivers/infiniband/hw/mlx5/main.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> > index 99dbef0bccbc..8963b806ad19 100644
> > +++ b/drivers/infiniband/hw/mlx5/main.c
> > @@ -2343,7 +2343,9 @@ static inline int check_dm_type_support(struct mlx5_ib_dev *dev,
> >  			return -EPERM;
> >
> >  		if (!(MLX5_CAP_FLOWTABLE_NIC_RX(dev->mdev, sw_owner) ||
> > -		      MLX5_CAP_FLOWTABLE_NIC_TX(dev->mdev, sw_owner)))
> > +		      MLX5_CAP_FLOWTABLE_NIC_TX(dev->mdev, sw_owner) ||
> > +		      MLX5_CAP_FLOWTABLE_NIC_RX(dev->mdev, sw_owner_v2) ||
> > +		      MLX5_CAP_FLOWTABLE_NIC_TX(dev->mdev, sw_owner_v2)))
> >  			return -EOPNOTSUPP;
>
> Shouldn't user space ask for MLX5_IB_UAPI_DM_TYPE_STEERING_SW_V2_ICM
> types too?

For sw_owner_v2 devices, we will return exactly same type of DM,
so there is no need for a new one. The change is to allow creation
of such DM in addition to existing sw_owner devices.


>
> What happens if old user space runs on a new device?

Old userspace will have sw_owner_v2 cap enabled and will get DM as before.
The patch diff is hard to read but the end result will be.
	if (!(MLX5_CAP_FLOWTABLE_NIC_RX(dev->mdev, sw_owner) ||
	      MLX5_CAP_FLOWTABLE_NIC_TX(dev->mdev, sw_owner) ||
	      MLX5_CAP_FLOWTABLE_NIC_RX(dev->mdev, sw_owner_v2) ||
	      MLX5_CAP_FLOWTABLE_NIC_TX(dev->mdev, sw_owner_v2)))
		return -EOPNOTSUPP;

DevX users are expected to check capabilities and be ready to work with missing ones.

Thanks

>
> Jason
