Return-Path: <linux-rdma+bounces-17801-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOaQGzz+rmkxLQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17801-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 18:07:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D307B23D58C
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 18:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E839A30A54E4
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 16:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6EC3C3BE1;
	Mon,  9 Mar 2026 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxLAB8tn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8561D3B52FB;
	Mon,  9 Mar 2026 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075550; cv=none; b=nU7WlZLkPgghkTS72u8OwAJKGry44Ss3Dv2VYQNs7pHSU+d/lCGvon6p158tO0GpIP0O2palnlQw/U7uyiiBsafReZu21TrVYhBs1rFi1OP5RZHGPzWiSD6eCw9qCy/hUUU/ObpUfsyIDyj7Ompf1x2XRH6SOLPVRMOjsjLE5yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075550; c=relaxed/simple;
	bh=vcuAphdZ1OazII6o5jfDG2O5NYvfJafAVm1UhP9/5LM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQLDTsE6HTVCnl2ayxdRqhMeaHb7uHBbsewXLQiQH/JmX7EjiRqmS3lpllxEtvaWO0XmcJoEumTuN9XJQwWf/jBWyu8fQRj1Dboikibiqz+EurV2+IDJAdbCb6nkvrbAyHr86qX9XoeuSTszuB8woHwyahwQSLtVyjg+8R+fxWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxLAB8tn; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773075549; x=1804611549;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vcuAphdZ1OazII6o5jfDG2O5NYvfJafAVm1UhP9/5LM=;
  b=UxLAB8tnUfiuBlOFvMKDXqlbeVm+TVmuoKFai9WWa2e1OVuYPMKJamY8
   N8oYCJ645ohURzf0VWGmVjxb+CWY112rDtnzISVV01VZbvnrJKD9bql+A
   f4+aFjyUJZlnDnHQH5qPosV42+sYO+k/VXSZCDXbnMyx0iumzyFg9NTdN
   JKDmcJEsis5HYEDo2KNWZ8t0irTJBLjeaZ8eDMFRO0bCi3FHt2WYtZu34
   lZCQUeGeSK+0GlYACHQFAae8DUCq2q9wM8SXHkbaIKRxm9REEjlNka3/+
   Yd0vgZQNV7ppdPNY0mh7zg6FS8bOpdkcBMhcCWNAwpiQELgru7fTJ1fSi
   g==;
X-CSE-ConnectionGUID: tx/+drYYSuqzCzp5ijm2QA==
X-CSE-MsgGUID: uJxh0DXNTbW+40K54u1RWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="73305269"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="73305269"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 09:59:08 -0700
X-CSE-ConnectionGUID: 3bGa1LLESx6mAGp03FlcFg==
X-CSE-MsgGUID: MF+N1OUaRPK3VFUm80OsCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="224261945"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.109.205]) ([10.125.109.205])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 09:59:07 -0700
Message-ID: <b3f6ce2d-c200-4bfd-8130-f7be5d4c54e7@intel.com>
Date: Mon, 9 Mar 2026 09:59:05 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] RDMA/mlx5: Invoke fw_validate_cmd LSM hook for DEVX
 commands
To: Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
 Itay Avraham <itayavr@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>,
 Maher Sanalla <msanalla@nvidia.com>, Edward Srouji <edwards@nvidia.com>
References: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
 <20260309-fw-lsm-hook-v1-2-4a6422e63725@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260309-fw-lsm-hook-v1-2-4a6422e63725@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D307B23D58C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-17801-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.952];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action



On 3/9/26 4:15 AM, Leon Romanovsky wrote:
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

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


