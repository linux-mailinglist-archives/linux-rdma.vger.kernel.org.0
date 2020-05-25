Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C371E144F
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 20:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389891AbgEYS1Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 14:27:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389888AbgEYS1Q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 May 2020 14:27:16 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D50E20776;
        Mon, 25 May 2020 18:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590431236;
        bh=oGaMXr03Q9VC/id/XYHpLpYdWY8tSrKWAQbRLYjNqTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ug6ERx4NTwI417+Z2XA34iAMbwnHdLCBCpRxaGxgLUDxybnllhKL5URWiGh/4Nbdi
         G8eX3DzxaQkdud6bsPZW4qxyXYN+v8poQ5LOGF1pDD9+GiCNIBJVT21RPJRQ0jQxY1
         jTwM9JwhgaNSZTszCieZ9s+S8OxXW802MNoU0Tlk=
Date:   Mon, 25 May 2020 21:27:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH rdma-next v1 2/9] RDMA/mlx5: Get ECE options from FW
 during create QP
Message-ID: <20200525182712.GM10591@unreal>
References: <20200523132243.817936-1-leon@kernel.org>
 <20200523132243.817936-3-leon@kernel.org>
 <20200525181737.GD24366@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525181737.GD24366@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 25, 2020 at 03:17:37PM -0300, Jason Gunthorpe wrote:
> On Sat, May 23, 2020 at 04:22:36PM +0300, Leon Romanovsky wrote:
> > -int mlx5_core_create_qp(struct mlx5_ib_dev *dev, struct mlx5_core_qp *qp,
> > -			u32 *in, int inlen)
> > +int mlx5_qpc_create_qp(struct mlx5_ib_dev *dev, struct mlx5_core_qp *qp,
> > +		       u32 *in, int inlen, u32 *out)
> >  {
> > -	u32 out[MLX5_ST_SZ_DW(create_qp_out)] = {};
> >  	u32 din[MLX5_ST_SZ_DW(destroy_qp_in)] = {};
> >  	int err;
> >
> >  	MLX5_SET(create_qp_in, in, opcode, MLX5_CMD_OP_CREATE_QP);
> >
> > -	err = mlx5_cmd_exec(dev->mdev, in, inlen, out, sizeof(out));
> > +	err = mlx5_cmd_exec(dev->mdev, in, inlen, out,
> > +			    MLX5_ST_SZ_BYTES(create_qp_out));
> >  	if (err)
> >  		return err;
>
> This hunk is unrelated right? Was missed in that other series?

Not really, in this hunk, I changed mlx5_qpc_create_qp() signature too,
it now receives "u32 *out", which is known size.

Thanks

>
> Jason
