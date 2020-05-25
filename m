Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEA21E1454
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 20:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388729AbgEYS3R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 14:29:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388720AbgEYS3R (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 May 2020 14:29:17 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A46D820776;
        Mon, 25 May 2020 18:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590431356;
        bh=WvKNypReC1DgksAqvn0e+Ig/s18u3idS0vNt6JlD6GQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=beILgvLWhnFcrpzcxTxTPdeZx6Jvh5GOb+qeLWK/Ee8ctAuJjiLojWUD6kosm3wY4
         aHdf4PawgTSgziFgvK2PmodmaUtmKRb4oFZ/N8m7YSvBH/gPEs6dk6fKMQ2YErXk0c
         veRZO/Yc8w/6/vbWPooH1rys7nbJetDuyNEYGB+Y=
Date:   Mon, 25 May 2020 21:29:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 7/9] RDMA/mlx5: Advertise ECE support
Message-ID: <20200525182912.GN10591@unreal>
References: <20200523132243.817936-1-leon@kernel.org>
 <20200523132243.817936-8-leon@kernel.org>
 <20200525181845.GE24366@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525181845.GE24366@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 25, 2020 at 03:18:45PM -0300, Jason Gunthorpe wrote:
> On Sat, May 23, 2020 at 04:22:41PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > The ECE bits are configured through create_qp and modify_qp commands.
> > While the create_qp() can be easily extended, it is not an easy task
> > for the modify_qp().
> >
> > The new bit in the comp_mask is needed to mark that kernel supports
> > ECE and can receive data instead of "reserved" field in the
> > struct mlx5_ib_modify_qp.
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/hw/mlx5/main.c | 3 +++
> >  include/uapi/rdma/mlx5-abi.h      | 1 +
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> > index 6094ab2f4cd7..570c519ca530 100644
> > +++ b/drivers/infiniband/hw/mlx5/main.c
> > @@ -1971,6 +1971,9 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
> >  		resp.response_length += sizeof(resp.dump_fill_mkey);
> >  	}
> >
> > +	if (MLX5_CAP_GEN(dev->mdev, ece_support))
> > +		resp.comp_mask |= MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_ECE;
> > +
> >  	err = ib_copy_to_udata(udata, &resp, resp.response_length);
> >  	if (err)
> >  		goto out_mdev;
> > diff --git a/include/uapi/rdma/mlx5-abi.h b/include/uapi/rdma/mlx5-abi.h
> > index bc9d9e3cb369..90ea1e5aa291 100644
> > +++ b/include/uapi/rdma/mlx5-abi.h
> > @@ -100,6 +100,7 @@ struct mlx5_ib_alloc_ucontext_req_v2 {
> >  enum mlx5_ib_alloc_ucontext_resp_mask {
> >  	MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_CORE_CLOCK_OFFSET = 1UL << 0,
> >  	MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_DUMP_FILL_MKEY    = 1UL << 1,
> > +	MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_ECE               = 1UL << 2,
> >  };
>
> This should be squashed into the patch overriding the reserved field

ok

>
> Jason
