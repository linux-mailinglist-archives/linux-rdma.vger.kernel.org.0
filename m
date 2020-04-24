Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694191B8074
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 22:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgDXUXg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Apr 2020 16:23:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDXUXg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Apr 2020 16:23:36 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87664214AF;
        Fri, 24 Apr 2020 20:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587759815;
        bh=imcGJDNl4KGhWyPbfTPIPbmT/2fx2oUz4PpGdBxZ73w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hZmsFqt/+8pQEqAPXlS0kV94m6zKNwbFpowR+E/hBUeTPmLHFhJBtzDIncwHvmqCx
         0Q/8/B6UnazbnWjfbtdFn/mmzffLfb2wFEM0sBIIo6uOvLUng8kokWHU+DbVupFcRm
         56u/wf0CLO/XYIhKjibPCqTU2qMqbTJ4nMCTOIVI=
Date:   Fri, 24 Apr 2020 23:23:31 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next 14/18] RDMA/mlx5: Process create QP flags in
 one place
Message-ID: <20200424202331.GC15990@unreal>
References: <20200420151105.282848-1-leon@kernel.org>
 <20200420151105.282848-15-leon@kernel.org>
 <20200424195127.GA28751@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424195127.GA28751@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 24, 2020 at 04:51:27PM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 20, 2020 at 06:11:01PM +0300, Leon Romanovsky wrote:
> > +	process_create_flag(dev, &create_flags,
> > +			    IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK,
> > +			    MLX5_CAP_GEN(mdev, block_lb_mc), qp);
>
> This only applies to datagram QP types

We didn't really check it before, should I check it now?

>
> > +	process_create_flag(dev, &create_flags, IB_QP_CREATE_CROSS_CHANNEL,
> > +			    MLX5_CAP_GEN(mdev, cd), qp);
> > +	process_create_flag(dev, &create_flags, IB_QP_CREATE_MANAGED_SEND,
> > +			    MLX5_CAP_GEN(mdev, cd), qp);
> > +	process_create_flag(dev, &create_flags, IB_QP_CREATE_MANAGED_RECV,
> > +			    MLX5_CAP_GEN(mdev, cd), qp);
> > +
> > +	if (qp_type == IB_QPT_UD) {
> > +		process_create_flag(dev, &create_flags,
> > +				    IB_QP_CREATE_IPOIB_UD_LSO,
> > +				    MLX5_CAP_GEN(mdev, ipoib_basic_offloads),
> > +				    qp);
> > +		cond = MLX5_CAP_GEN(mdev, port_type) == MLX5_CAP_PORT_TYPE_IB;
> > +		process_create_flag(dev, &create_flags, IB_QP_CREATE_SOURCE_QPN,
> > +				    cond, qp);
> > +	}
> > +
> > +	if (qp_type == IB_QPT_RAW_PACKET) {
> > +		cond = MLX5_CAP_GEN(mdev, eth_net_offloads) &&
> > +		       MLX5_CAP_ETH(mdev, scatter_fcs);
> > +		process_create_flag(dev, &create_flags,
> > +				    IB_QP_CREATE_SCATTER_FCS, cond, qp);
> > +
> > +		cond = MLX5_CAP_GEN(mdev, eth_net_offloads) &&
> > +		       MLX5_CAP_ETH(mdev, vlan_cap);
> > +		process_create_flag(dev, &create_flags,
> > +				    IB_QP_CREATE_CVLAN_STRIPPING, cond, qp);
> > +	}
> > +
> > +	process_create_flag(dev, &create_flags,
> > +			    IB_QP_CREATE_PCI_WRITE_END_PADDING,
> > +			    MLX5_CAP_GEN(mdev, end_pad), qp);
>
> This one is datagram only toos

Same

>
> > +
> > +	process_create_flag(dev, &create_flags, MLX5_IB_QP_CREATE_WC_TEST,
> > +			    qp_type != MLX5_IB_QPT_REG_UMR, qp);
> > +	process_create_flag(dev, &create_flags, MLX5_IB_QP_CREATE_SQPN_QP1,
> > +			    true, qp);
>
> I wonder if these are excluded from userspace someplace, seems like it
> is worth a udata test here just to be clear

We are excluding them in create_qp():drivers/infiniband/core/uverbs_cmd.c

1411         if (attr.create_flags & ~(IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK |
1412                                 IB_QP_CREATE_CROSS_CHANNEL |
1413                                 IB_QP_CREATE_MANAGED_SEND |
1414                                 IB_QP_CREATE_MANAGED_RECV |
1415                                 IB_QP_CREATE_SCATTER_FCS |
1416                                 IB_QP_CREATE_CVLAN_STRIPPING |
1417                                 IB_QP_CREATE_SOURCE_QPN |
1418                                 IB_QP_CREATE_PCI_WRITE_END_PADDING)) {
1419                 ret = -EINVAL;
1420                 goto err_put;
1421         }

>
> > +
> > +	if (create_flags)
> > +		mlx5_ib_dbg(dev, "Create QP has unsupported flags 0x%X\n",
> > +			    create_flags);
> > +
> > +	return (create_flags) ? -EINVAL : 0;
>
> Since there is already an if, avoid ternary expression

No problem

>
> Jason
