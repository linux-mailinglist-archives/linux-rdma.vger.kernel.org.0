Return-Path: <linux-rdma+bounces-4524-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CC695D05D
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 16:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1781F21893
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 14:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40FF186E5E;
	Fri, 23 Aug 2024 14:48:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B921DA5E;
	Fri, 23 Aug 2024 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724424519; cv=none; b=cfmLLCnYI9x8aOKZSmF4VSpaRv1vdBIgEvZl7/6FFLfbG6bJ6DYCYo+aSpHMSlPIS8349uEijsx0NDErFT940qpNd1SZVmEUbW7rGrLRkLo/w720uSnjXtr77SO/FzHogAVokQwELS9VXa0t/vdIynn6FicdRJjPQquoO2zjh44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724424519; c=relaxed/simple;
	bh=RVXPaYO3UXSo7pTFeTWVlCKiEP1KLsVMQyXyA0iVN/o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPRBouoK+BxcpuoIAfR/U8RIBRWGk9BP5cnjiNRVroPifKCTuD5oFJx8O3QeMtq4E7iT+1N0lbTCPu2qKbQkYyhJPcro7rBT4hUIQ0JGHqkuBR0fmpIfHluo+6BtKyIA3aSpv6PvXin1gylBlfaqqOBNLxIZswyXcb+TK1IBaX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wr2sW1STZz6GBpb;
	Fri, 23 Aug 2024 22:44:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8AC1D140B2A;
	Fri, 23 Aug 2024 22:48:32 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 15:48:32 +0100
Date: Fri, 23 Aug 2024 15:48:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron Silverton
	<aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Daniel
 Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>, David
 Ahern <dsahern@kernel.org>, "Greg Kroah-Hartman"
	<gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Itay
 Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jakub Kicinski
	<kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH v3 07/10] fwctl/mlx5: Support for communicating with
 mlx5 fw
Message-ID: <20240823154830.00007d8c@Huawei.com>
In-Reply-To: <7-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
References: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
	<7-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 21 Aug 2024 15:10:59 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> mlx5's fw has long provided a User Context concept. This has a long
> history in RDMA as part of the devx extended verbs programming
> interface. A User Context is a security envelope that contains objects and
> controls access. It contains the Protection Domain object from the
> InfiniBand Architecture and both togther provide the OS with the necessary
> tools to bind a security context like a process to the device.
> 
> The security context is restricted to not be able to touch the kernel or
> other processes. In the RDMA verbs case it is also restricted to not touch
> global device resources.
> 
> The fwctl_mlx5 takes this approach and builds a User Context per fwctl
> file descriptor and uses a FW security capability on the User Context to
> enable access to global device resources. This makes the context useful
> for provisioning and debugging the global device state.
> 
> mlx5 already has a robust infrastructure for delivering RPC messages to
> fw. Trivially connect fwctl's RPC mechanism to mlx5_cmd_do(). Enforce the
> User Context ID in every RPC header so the FW knows the security context
> of the issuing ID.
> 
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Trivial stuff only. Feel free to ignore if you really like the code
the way it is.  I don't know the MLX5 parts, but based on just what
is visible here and in this series.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/drivers/fwctl/mlx5/main.c b/drivers/fwctl/mlx5/main.c
> new file mode 100644
> index 00000000000000..8839770fbe7ba5
> --- /dev/null
> +++ b/drivers/fwctl/mlx5/main.c


> +
> +static void *mlx5ctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
> +			    void *rpc_in, size_t in_len, size_t *out_len)
> +{
> +	struct mlx5ctl_dev *mcdev =
> +		container_of(uctx->fwctl, struct mlx5ctl_dev, fwctl);
> +	struct mlx5ctl_uctx *mfd =
> +		container_of(uctx, struct mlx5ctl_uctx, uctx);
> +	void *rpc_alloc __free(kvfree) = NULL;

Whilst you can't completely pair this with destructor, I'd still
move this as locally as possible.

> +	void *rpc_out;
> +	int ret;
> +
> +	if (in_len < MLX5_ST_SZ_BYTES(mbox_in_hdr) ||
> +	    *out_len < MLX5_ST_SZ_BYTES(mbox_out_hdr))
> +		return ERR_PTR(-EMSGSIZE);
> +
> +	/* FIXME: Requires device support for more scopes */
> +	if (scope != FWCTL_RPC_CONFIGURATION &&
> +	    scope != FWCTL_RPC_DEBUG_READ_ONLY)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	mlx5ctl_dbg(mcdev, "[UID %d] cmdif: opcode 0x%x inlen %zu outlen %zu\n",
> +		    mfd->uctx_uid, MLX5_GET(mbox_in_hdr, rpc_in, opcode),
> +		    in_len, *out_len);
> +
> +	if (!mlx5ctl_validate_rpc(rpc_in, scope))
> +		return ERR_PTR(-EBADMSG);
> +
> +	/*
> +	 * mlx5_cmd_do() copies the input message to its own buffer before
> +	 * executing it, so we can reuse the allocation for the output.
> +	 */
> +	if (*out_len <= in_len) {
> +		rpc_out = rpc_in;
> +	} else {
> +		rpc_out = rpc_alloc = kvzalloc(*out_len, GFP_KERNEL);
> +		if (!rpc_alloc)
> +			return ERR_PTR(-ENOMEM);
> +	}
> +
> +	/* Enforce the user context for the command */
> +	MLX5_SET(mbox_in_hdr, rpc_in, uid, mfd->uctx_uid);
> +	ret = mlx5_cmd_do(mcdev->mdev, rpc_in, in_len, rpc_out, *out_len);
> +
> +	mlx5ctl_dbg(mcdev,
> +		    "[UID %d] cmdif: opcode 0x%x status 0x%x retval %pe\n",
> +		    mfd->uctx_uid, MLX5_GET(mbox_in_hdr, rpc_in, opcode),
> +		    MLX5_GET(mbox_out_hdr, rpc_out, status), ERR_PTR(ret));
> +
> +	/*
> +	 * -EREMOTEIO means execution succeeded and the out is valid,
> +	 * but an error code was returned inside out. Everything else
> +	 * means the RPC did not make it to the device.
> +	 */
> +	if (ret && ret != -EREMOTEIO)
> +		return ERR_PTR(ret);
> +	if (rpc_out == rpc_in)
> +		return rpc_in;
> +	return_ptr(rpc_alloc);
> +}
> +

> +static void mlx5ctl_remove(struct auxiliary_device *adev)
> +{
> +	struct mlx5ctl_dev *mcdev __free(mlx5ctl) = auxiliary_get_drvdata(adev);

I'm not keen on the non constructor being paired with destructor
but it's your code so you get keep the confusion if you really
like it.

I'd just have an explicit put.

> +
> +	fwctl_unregister(&mcdev->fwctl);
> +}


