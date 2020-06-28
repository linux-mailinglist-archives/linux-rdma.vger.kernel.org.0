Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974F120C757
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2020 11:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgF1Jzh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Jun 2020 05:55:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgF1Jzh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 28 Jun 2020 05:55:37 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44030206D7;
        Sun, 28 Jun 2020 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593338137;
        bh=zRbqWBO/UcV+zZBjjJFuS13XuVh55FRMWoysROo3sFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X2U5cZOKCfsvybMwlDCSvOMi2YPhPUSllbumExoylXGR597uUqxM6sWkd/Ujx9xFE
         sj8cF6ddVCVnIpyDpBkvzZKYLdnkVd3/L/UF+8lMp94EcAzzXP2hafrKVlZdZygX4S
         wdFTIICUrY4k5sfB+WtRyCCSWHAGmBdnQZ2S9RRQ=
Date:   Sun, 28 Jun 2020 12:55:32 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yishai Hadas <yishaih@dev.mellanox.co.il>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next 2/5] RDMA: Clean MW allocation and free flows
Message-ID: <20200628095532.GD6281@unreal>
References: <20200624105422.1452290-1-leon@kernel.org>
 <20200624105422.1452290-3-leon@kernel.org>
 <f5ffa1d5-d665-4913-ec40-1e6ad42685fc@dev.mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5ffa1d5-d665-4913-ec40-1e6ad42685fc@dev.mellanox.co.il>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 28, 2020 at 12:18:38PM +0300, Yishai Hadas wrote:
> On 6/24/2020 1:54 PM, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Move allocation and destruction of memory windows under ib_core
> > responsibility and clean drivers to ensure that no updates to MW
> > ib_core structures are done in driver layer.
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---

<...>

> > +void mlx5_ib_dealloc_mw(struct ib_mw *mw)
> >   {
> >   	struct mlx5_ib_dev *dev = to_mdev(mw->device);
> >   	struct mlx5_ib_mw *mmw = to_mmw(mw);
> > -	int err;
> >   	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
> >   		xa_erase(&dev->odp_mkeys, mlx5_base_mkey(mmw->mmkey.key));
> > @@ -2073,11 +2067,7 @@ int mlx5_ib_dealloc_mw(struct ib_mw *mw)
> >   		synchronize_srcu(&dev->odp_srcu);
> >   	}
> > -	err = mlx5_core_destroy_mkey(dev->mdev, &mmw->mmkey);
> > -	if (err)
> > -		return err;
> > -	kfree(mmw);
> > -	return 0;
> > +	mlx5_core_destroy_mkey(dev->mdev, &mmw->mmkey);
>
> Are we fully sure that this can never be triggered by user space to fail as
> of the property of the MW that can be binded with bypassing kernel ? the new
> code just ignored the err.

Why is it different from any other HW object?
The failure to destroy will leave leaked kernel resources.

We already removed this mmkey from xarray above and if we don't finish,
the MW will be leaked.

Thanks
