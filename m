Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4737430A53B
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Feb 2021 11:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhBAKUl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Feb 2021 05:20:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:36452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232924AbhBAKUl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 1 Feb 2021 05:20:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2ABD864E11;
        Mon,  1 Feb 2021 10:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612174799;
        bh=lz2Eirzvhpvz/PiT5+Ilc+Q9BewHjBsJ5Hp4Lcc1bxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gcUZlIj8pxYEpz6VRK2ul662H2S9TY8NNwb8e4hlcvBb136n6hOO8k4Sa2R7594jj
         yw9X/JZR5mt6biPU2lLw2uwy55bVp6OiAlYlW1f9HvaucdGjfn6FcHPKC7vL8/OpNw
         ijG7n21rQ5r8YY6bs2HhdlRgXasZDJJT0eGgPinOW2ZPN0BRMpYOnR66XRhlqa19dY
         HKsiT4gAeVRPxqdniOKUhrLAZXD4qAfmjg+DBJO6M1uDQWoebGlW+/pDCD7dTCgEDs
         A/Wg9vbn2/W7ISvSH34zBTQewOJqTiwcJDSM4szwfz+eah6hyYFpXdU0JSvAlUQnw1
         wZPT1Hz+y6aYw==
Date:   Mon, 1 Feb 2021 12:19:56 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Parav Pandit <parav@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 02/10] IB/mlx5: Avoid calling query device for
 reading pkey table length
Message-ID: <20210201101956.GD4593@unreal>
References: <20210127150010.1876121-1-leon@kernel.org>
 <20210127150010.1876121-3-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127150010.1876121-3-leon@kernel.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 27, 2021 at 05:00:02PM +0200, Leon Romanovsky wrote:
> From: Parav Pandit <parav@nvidia.com>
>
> Pkey table length for all the ports of the device is the same.
> Currently get_ports_cap() reads and stores it for each port by querying
> the device which reads more than just pkey table length.
>
> For representor device ports which can be in range of hundreds, it
> queries is for each such port and end up returning same value for all
> the ports.
>
> When in representor mode, modify QP accesses pkey port caps for a port
> index that can be outside of the port_caps table.
>
> Hence, simplify the logic to query the max pkey table length only once
> during device initialization sequence.
>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mad.c     |  2 +-
>  drivers/infiniband/hw/mlx5/main.c    | 24 ++++++------------------
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 +-
>  drivers/infiniband/hw/mlx5/qp.c      | 12 ++++--------
>  4 files changed, 12 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/infiniband/hw/mlx5/mad.c b/drivers/infiniband/hw/mlx5/mad.c
> index e9d0a5269582..cdb47a00e516 100644
> --- a/drivers/infiniband/hw/mlx5/mad.c
> +++ b/drivers/infiniband/hw/mlx5/mad.c
> @@ -549,7 +549,7 @@ int mlx5_query_mad_ifc_port(struct ib_device *ibdev, u8 port,
>  	props->port_cap_flags	= be32_to_cpup((__be32 *)(out_mad->data + 20));
>  	props->gid_tbl_len	= out_mad->data[50];
>  	props->max_msg_sz	= 1 << MLX5_CAP_GEN(mdev, log_max_msg);
> -	props->pkey_tbl_len	= dev->port_caps[port - 1].pkey_table_len;
> +	props->pkey_tbl_len	= dev->pkey_table_len;
>  	props->bad_pkey_cntr	= be16_to_cpup((__be16 *)(out_mad->data + 46));
>  	props->qkey_viol_cntr	= be16_to_cpup((__be16 *)(out_mad->data + 48));
>  	props->active_width	= out_mad->data[31] & 0xf;
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index 979f58ed1de2..5765f30f1788 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -816,9 +816,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
>  	if (err)
>  		return err;
>
> -	err = mlx5_query_max_pkeys(ibdev, &props->max_pkeys);
> -	if (err)
> -		return err;
> +	props->max_pkeys = dev->pkey_table_len;
>
>  	err = mlx5_query_vendor_id(ibdev, &props->vendor_id);
>  	if (err)
> @@ -2993,7 +2991,6 @@ static void get_ext_port_caps(struct mlx5_ib_dev *dev)
>
>  static int __get_port_caps(struct mlx5_ib_dev *dev, u8 port)
>  {
> -	struct ib_device_attr *dprops = NULL;
>  	struct ib_port_attr *pprops = NULL;
>  	int err = -ENOMEM;
>
> @@ -3001,16 +2998,6 @@ static int __get_port_caps(struct mlx5_ib_dev *dev, u8 port)
>  	if (!pprops)
>  		goto out;
>
> -	dprops = kmalloc(sizeof(*dprops), GFP_KERNEL);
> -	if (!dprops)
> -		goto out;
> -
> -	err = mlx5_ib_query_device(&dev->ib_dev, dprops, NULL);
> -	if (err) {
> -		mlx5_ib_warn(dev, "query_device failed %d\n", err);
> -		goto out;
> -	}
> -
>  	err = mlx5_ib_query_port(&dev->ib_dev, port, pprops);
>  	if (err) {
>  		mlx5_ib_warn(dev, "query_port %d failed %d\n",
> @@ -3018,15 +3005,12 @@ static int __get_port_caps(struct mlx5_ib_dev *dev, u8 port)
>  		goto out;
>  	}
>
> -	dev->port_caps[port - 1].pkey_table_len = dprops->max_pkeys;
>  	dev->port_caps[port - 1].gid_table_len = pprops->gid_tbl_len;
>  	mlx5_ib_dbg(dev, "port %d: pkey_table_len %d, gid_table_len %d\n",
> -		    port, dprops->max_pkeys, pprops->gid_tbl_len);
> +		    port, dev->pkey_table_len, pprops->gid_tbl_len);
>
>  out:
>  	kfree(pprops);
> -	kfree(dprops);
> -
>  	return err;
>  }
>
> @@ -3993,6 +3977,10 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
>  	if (err)
>  		goto err_mp;
>
> +	err = mlx5_query_max_pkeys(&dev->ib_dev, &dev->pkey_table_len);
> +	if (err)
> +		goto err_mp;
> +
>  	if (mlx5_use_mad_ifc(dev))
>  		get_ext_port_caps(dev);
>
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index 39ba8e1e9fee..c0c5e0043b3e 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -1035,7 +1035,6 @@ struct mlx5_var_table {
>
>  struct mlx5_port_caps {
>  	int gid_table_len;
> -	int pkey_table_len;
>  	bool has_smi;
>  	u8 ext_port_cap;
>  };
> @@ -1096,6 +1095,7 @@ struct mlx5_ib_dev {
>
>  	struct xarray sig_mrs;
>  	struct mlx5_port_caps port_caps[MLX5_MAX_PORTS];
> +	u16 pkey_table_len;
>  };
>
>  static inline struct mlx5_ib_cq *to_mibcq(struct mlx5_core_cq *mcq)
> diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
> index 5822655fe91e..b65720a05a18 100644
> --- a/drivers/infiniband/hw/mlx5/qp.c
> +++ b/drivers/infiniband/hw/mlx5/qp.c
> @@ -4310,14 +4310,10 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>  		goto out;
>  	}
>
> -	if (attr_mask & IB_QP_PKEY_INDEX) {
> -		port = attr_mask & IB_QP_PORT ? attr->port_num : qp->port;
> -		if (attr->pkey_index >=
> -		    dev->port_caps[port - 1].pkey_table_len) {
> -			mlx5_ib_dbg(dev, "invalid pkey index %d\n",
> -				    attr->pkey_index);
> -			goto out;
> -		}
> +	if ((attr_mask & IB_QP_PKEY_INDEX) &&
> +	    attr->pkey_index >= dev->pkey_table_len) {
> +		mlx5_ib_dbg(dev, "invalid pkey index %d\n", attr->pkey_index);
> +		goto out;
>  	}

This hunk made "int port;" in mlx5_ib_modify_qp() obsolete.

Thanks

>
>  	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC &&
> --
> 2.29.2
>
