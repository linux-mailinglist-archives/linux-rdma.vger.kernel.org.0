Return-Path: <linux-rdma+bounces-17791-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIjoGwzjrmmoJgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17791-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 16:11:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F9323B5C1
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 16:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C83230172F9
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 15:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF89E3D75C3;
	Mon,  9 Mar 2026 15:10:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5717C2472A5;
	Mon,  9 Mar 2026 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069058; cv=none; b=PrSxRb9GhcfRK9Hb0VJnF3uQ8upB/qUwIRM1Q/DIJUkbSh3gVlI5mfm8ZZGIU/21vFPSd0e8+RKURGndzX/2S8J/vWkfzMdfJHdotVEeDAYaGYtjli7GwJ3J6tSd4LsgM41Dm5aa//tA9kN2wypxpoxFDhckhiJ0Cn83n5ga4Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069058; c=relaxed/simple;
	bh=hVJIYEdwt5LDpEpxkIKeoZWkRKsc7wckhCg1shSZqbo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLhxEEXFg5SvjMHScE45IDZv50epAPGP3v1s3CDUT5uViNdbHbCCMUyXZ845Lno2O9ZWeYq3b2GyoUUI6u0d2RHJT9aAHCyjvM6GZvdInTbFl0wd3BF6XsbivuimZ53iaGTVR3kAFcDluOV+jTsYnCPje3O3LnoVY/JXFP/tgzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fV0nk46GJzHnGj5;
	Mon,  9 Mar 2026 23:10:50 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 7EE6A40572;
	Mon,  9 Mar 2026 23:10:54 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 15:10:53 +0000
Date: Mon, 9 Mar 2026 15:10:51 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, Dave Jiang
	<dave.jiang@intel.com>, <linux-security-module@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Chiara Meiohas
	<cmeiohas@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>
Subject: Re: [PATCH 2/3] RDMA/mlx5: Invoke fw_validate_cmd LSM hook for DEVX
 commands
Message-ID: <20260309151051.000059af@huawei.com>
In-Reply-To: <20260309-fw-lsm-hook-v1-2-4a6422e63725@nvidia.com>
References: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
	<20260309-fw-lsm-hook-v1-2-4a6422e63725@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)
X-Rspamd-Queue-Id: 59F9323B5C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-17791-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.558];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,huawei.com:mid,huawei.com:email,nvidia.com:email]
X-Rspamd-Action: no action

On Mon,  9 Mar 2026 13:15:19 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> From: Chiara Meiohas <cmeiohas@nvidia.com>
> 
> DEVX is an RDMA uverbs extension that allows userspace to submit
> firmware command buffers. The driver inspects the command and then
> passes the buffer through for firmware execution.
> 
> Call security_fw_validate_cmd() before dispatching firmware commands
> through DEVX.
> 
> This allows security modules to implement custom policies and
> enforce per-command security policy on user-triggered firmware
> commands. For example, a BPF LSM program could restrict specific
> firmware operations to privileged users.
> 
> Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
> Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
> Signed-off-by: Edward Srouji <edwards@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
A few formatting inconsistencies.  Actual code is fine as far as I can tell.
So given I don't know the driver, take this as vague at best...

Assuming formatting stuff tidied up.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> ---
>  drivers/infiniband/hw/mlx5/devx.c | 52 ++++++++++++++++++++++++++++++---------
>  1 file changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
> index 0066b2738ac89..48a2c4b4ad4eb 100644
> --- a/drivers/infiniband/hw/mlx5/devx.c
> +++ b/drivers/infiniband/hw/mlx5/devx.c
> @@ -18,6 +18,7 @@
>  #include "devx.h"
>  #include "qp.h"
>  #include <linux/xarray.h>
> +#include <linux/security.h>
>  
>  #define UVERBS_MODULE_NAME mlx5_ib
>  #include <rdma/uverbs_named_ioctl.h>
> @@ -1111,6 +1112,8 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OTHER)(
>  	struct mlx5_ib_dev *dev;
>  	void *cmd_in = uverbs_attr_get_alloced_ptr(
>  		attrs, MLX5_IB_ATTR_DEVX_OTHER_CMD_IN);
> +	int cmd_in_len = uverbs_attr_get_len(attrs,
> +					MLX5_IB_ATTR_DEVX_OTHER_CMD_IN);
>  	int cmd_out_len = uverbs_attr_get_len(attrs,
>  					MLX5_IB_ATTR_DEVX_OTHER_CMD_OUT);
>  	void *cmd_out;
> @@ -1135,9 +1138,12 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OTHER)(
>  		return PTR_ERR(cmd_out);
>  
>  	MLX5_SET(general_obj_in_cmd_hdr, cmd_in, uid, uid);
> -	err = mlx5_cmd_do(dev->mdev, cmd_in,
> -			  uverbs_attr_get_len(attrs, MLX5_IB_ATTR_DEVX_OTHER_CMD_IN),
> -			  cmd_out, cmd_out_len);
> +	err = security_fw_validate_cmd(cmd_in, cmd_in_len, &dev->ib_dev.dev,
> +				       FW_CMD_CLASS_UVERBS, RDMA_DRIVER_MLX5);
> +	if (err)
> +		return err;
> +
> +	err = mlx5_cmd_do(dev->mdev, cmd_in, cmd_in_len, cmd_out, cmd_out_len);

See below for inconsistency on how the changes have been done.

>  	if (err && err != -EREMOTEIO)
>  		return err;
>  
> @@ -1570,6 +1576,12 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_CREATE)(
>  		devx_set_umem_valid(cmd_in);
>  	}
>  
> +	err = security_fw_validate_cmd(cmd_in, cmd_in_len,
> +				       &dev->ib_dev.dev,
> +				       FW_CMD_CLASS_UVERBS, RDMA_DRIVER_MLX5);
> +	if (err)
> +		goto obj_free;
> +
>  	if (opcode == MLX5_CMD_OP_CREATE_DCT) {
>  		obj->flags |= DEVX_OBJ_FLAGS_DCT;
>  		err = mlx5_core_create_dct(dev, &obj->core_dct, cmd_in,
> @@ -1582,8 +1594,8 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_CREATE)(
>  				     cmd_in, cmd_in_len, cmd_out,
>  				     cmd_out_len);
>  	} else {
> -		err = mlx5_cmd_do(dev->mdev, cmd_in, cmd_in_len,
> -				  cmd_out, cmd_out_len);
> +		err = mlx5_cmd_do(dev->mdev, cmd_in, cmd_in_len, cmd_out,
> +				  cmd_out_len);

Unrelated bit of reformatting. Shouldn't be in this patch.,


>  	}
>  
>  	if (err == -EREMOTEIO)
> @@ -1646,6 +1658,8 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_MODIFY)(
>  	struct uverbs_attr_bundle *attrs)
>  {
>  	void *cmd_in = uverbs_attr_get_alloced_ptr(attrs, MLX5_IB_ATTR_DEVX_OBJ_MODIFY_CMD_IN);
> +	int cmd_in_len = uverbs_attr_get_len(attrs,
> +					MLX5_IB_ATTR_DEVX_OBJ_MODIFY_CMD_IN);
>  	int cmd_out_len = uverbs_attr_get_len(attrs,
>  					MLX5_IB_ATTR_DEVX_OBJ_MODIFY_CMD_OUT);
>  	struct ib_uobject *uobj = uverbs_attr_get_uobject(attrs,
> @@ -1676,9 +1690,12 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_MODIFY)(
>  
>  	MLX5_SET(general_obj_in_cmd_hdr, cmd_in, uid, uid);
>  	devx_set_umem_valid(cmd_in);
> +	err = security_fw_validate_cmd(cmd_in, cmd_in_len, &mdev->ib_dev.dev,
> +				       FW_CMD_CLASS_UVERBS, RDMA_DRIVER_MLX5);
> +	if (err)
> +		return err;
>  
> -	err = mlx5_cmd_do(mdev->mdev, cmd_in,
> -			  uverbs_attr_get_len(attrs, MLX5_IB_ATTR_DEVX_OBJ_MODIFY_CMD_IN),
> +	err = mlx5_cmd_do(mdev->mdev, cmd_in, cmd_in_len,
>  			  cmd_out, cmd_out_len);

Similar to case above, this not fits on one line.

>  	if (err && err != -EREMOTEIO)
>  		return err;
> @@ -1693,6 +1710,8 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_QUERY)(
>  	struct uverbs_attr_bundle *attrs)
>  {
>  	void *cmd_in = uverbs_attr_get_alloced_ptr(attrs, MLX5_IB_ATTR_DEVX_OBJ_QUERY_CMD_IN);
> +	int cmd_in_len = uverbs_attr_get_len(attrs,
> +					     MLX5_IB_ATTR_DEVX_OBJ_QUERY_CMD_IN);
>  	int cmd_out_len = uverbs_attr_get_len(attrs,
>  					      MLX5_IB_ATTR_DEVX_OBJ_QUERY_CMD_OUT);
>  	struct ib_uobject *uobj = uverbs_attr_get_uobject(attrs,
> @@ -1722,8 +1741,12 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_QUERY)(
>  		return PTR_ERR(cmd_out);
>  
>  	MLX5_SET(general_obj_in_cmd_hdr, cmd_in, uid, uid);
> -	err = mlx5_cmd_do(mdev->mdev, cmd_in,
> -			  uverbs_attr_get_len(attrs, MLX5_IB_ATTR_DEVX_OBJ_QUERY_CMD_IN),
> +	err = security_fw_validate_cmd(cmd_in, cmd_in_len, &mdev->ib_dev.dev,
> +				       FW_CMD_CLASS_UVERBS, RDMA_DRIVER_MLX5);
> +	if (err)
> +		return err;
> +
> +	err = mlx5_cmd_do(mdev->mdev, cmd_in, cmd_in_len,
>  			  cmd_out, cmd_out_len);

As above.

>  	if (err && err != -EREMOTEIO)
>  		return err;
> @@ -1832,6 +1855,8 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_ASYNC_QUERY)(
>  {
>  	void *cmd_in = uverbs_attr_get_alloced_ptr(attrs,
>  				MLX5_IB_ATTR_DEVX_OBJ_QUERY_ASYNC_CMD_IN);
> +	int cmd_in_len = uverbs_attr_get_len(attrs,
> +				MLX5_IB_ATTR_DEVX_OBJ_QUERY_ASYNC_CMD_IN);
>  	struct ib_uobject *uobj = uverbs_attr_get_uobject(
>  				attrs,
>  				MLX5_IB_ATTR_DEVX_OBJ_QUERY_ASYNC_HANDLE);
> @@ -1894,9 +1919,12 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_ASYNC_QUERY)(
>  	async_data->ev_file = ev_file;
>  
>  	MLX5_SET(general_obj_in_cmd_hdr, cmd_in, uid, uid);
> -	err = mlx5_cmd_exec_cb(&ev_file->async_ctx, cmd_in,
> -		    uverbs_attr_get_len(attrs,
> -				MLX5_IB_ATTR_DEVX_OBJ_QUERY_ASYNC_CMD_IN),
> +	err = security_fw_validate_cmd(cmd_in, cmd_in_len, &mdev->ib_dev.dev,
> +				       FW_CMD_CLASS_UVERBS, RDMA_DRIVER_MLX5);
> +	if (err)
> +		goto free_async;
> +
> +	err = mlx5_cmd_exec_cb(&ev_file->async_ctx, cmd_in, cmd_in_len,
>  		    async_data->hdr.out_data,
>  		    async_data->cmd_out_len,
>  		    devx_query_callback, &async_data->cb_work);
> 


