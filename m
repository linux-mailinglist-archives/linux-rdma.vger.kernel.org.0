Return-Path: <linux-rdma+bounces-17800-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOISGS/+rmkxLQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17800-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 18:06:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF16423D57D
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 18:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B470C3049447
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBFF396D2B;
	Mon,  9 Mar 2026 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IsdZLno/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AD83E9F7D;
	Mon,  9 Mar 2026 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075474; cv=none; b=O0WMVPcwhmMgWumO2kzKCYO3ypUu5NXOFTnwMZXj34DWvvWe0GVRerhVRAl9DXrH4UCrpTV6QztZWMhedlbTjyU3I+M2x+9tcDFV81pMqo8U7YNsKZQQaxHQlOK3dxaz0nB3A6Sgd5+Gpl9sF017cAKGkwmre9Q7Sc8JRYWNK7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075474; c=relaxed/simple;
	bh=ps3y+kUNP2JF2i84nV4uDamQeGpDbEKzAbhSVqOfT3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6eCaGZcPelIjXXHxTP2LAVbqxDJfLCtMgnKvvAd88lo4sRhnPS84JM4JrYWdRW3kid5eWNAw3BnEhcGGe4PubGO2Vxm42hnBniE6uC8boL6bWK06cymzD7/9feaMVgIkmFvmjrNsgiFokE8bAAX0s9WaQuzOkt085ouCiA4rmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IsdZLno/; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773075471; x=1804611471;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ps3y+kUNP2JF2i84nV4uDamQeGpDbEKzAbhSVqOfT3A=;
  b=IsdZLno/up02DCbAgGV30tczdrH+G/iha+VN+MABHENJsEeVE3TE0f2O
   BtVZ+t3hGcFcUd6Z8yqNYNsMi1iaOytvcbqmZiE/bhE2C3lsm/y2WgzAa
   IyA1mmgy4hGWiAubVixyOmMVKz4Fs7RCQ5EVdDH4+cS+3BoAmoi5gr7yu
   GzUYag+I7juWbnozGjqK7/hLalhcPb5J1Fm/31xUQVC5e/BUd1jwRoA7T
   UID2aBc4BCunom8+VQUO5ACDgIsW0Tk9/qWoVqbxu3ibHJsQDla2iEHmW
   9ql7ImhlUyD4V/RMWD2mWCUMawydFfKKaJs1mv5KV2DR+ihZR3apeAvkz
   g==;
X-CSE-ConnectionGUID: ukKc/rJ8RfysrGAVCkas2w==
X-CSE-MsgGUID: FQMQM+NbTfC719BvhtzGFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="73305177"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="73305177"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 09:57:51 -0700
X-CSE-ConnectionGUID: sBvzkeA2TFyAJTVL8Kau8Q==
X-CSE-MsgGUID: 2Lu0ykwsTtaIfsHP2vI/ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="224261367"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.109.205]) ([10.125.109.205])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 09:57:50 -0700
Message-ID: <48980e31-bbde-463e-a7d2-e2faa983b5a1@intel.com>
Date: Mon, 9 Mar 2026 09:57:47 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] fwctl/mlx5: Invoke fw_validate_cmd LSM hook for fwctl
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
 <20260309-fw-lsm-hook-v1-3-4a6422e63725@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260309-fw-lsm-hook-v1-3-4a6422e63725@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EF16423D57D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-17800-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.946];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action



On 3/9/26 4:15 AM, Leon Romanovsky wrote:
> From: Chiara Meiohas <cmeiohas@nvidia.com>
> 
> fwctl is subsystem which exposes a firmware interface directly to
> userspace: it allows userspace to send device specific command
> buffers to firmware.
> 
> Call security_fw_validate_cmd() before dispatching the user-provided
> firmware command.
> 
> This allows security modules to implement custom policies and
> enforce per-command security policy on user-triggered firmware
> commands. For example, a BPF LSM program could filter firmware
> commands based on their opcode.
> 
> Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
> Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
> Signed-off-by: Edward Srouji <edwards@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/fwctl/mlx5/main.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fwctl/mlx5/main.c b/drivers/fwctl/mlx5/main.c
> index e86ab703c767a..8ed17aaf48f1f 100644
> --- a/drivers/fwctl/mlx5/main.c
> +++ b/drivers/fwctl/mlx5/main.c
> @@ -7,6 +7,7 @@
>  #include <linux/mlx5/device.h>
>  #include <linux/mlx5/driver.h>
>  #include <uapi/fwctl/mlx5.h>
> +#include <linux/security.h>
>  
>  #define mlx5ctl_err(mcdev, format, ...) \
>  	dev_err(&mcdev->fwctl.dev, format, ##__VA_ARGS__)
> @@ -324,6 +325,15 @@ static void *mlx5ctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>  	if (!mlx5ctl_validate_rpc(rpc_in, scope))
>  		return ERR_PTR(-EBADMSG);
>  
> +	/* Enforce the user context for the command */
> +	MLX5_SET(mbox_in_hdr, rpc_in, uid, mfd->uctx_uid);
> +
> +	ret = security_fw_validate_cmd(rpc_in, in_len, &mcdev->fwctl.dev,
> +				       FW_CMD_CLASS_FWCTL,
> +				       FWCTL_DEVICE_TYPE_MLX5);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
>  	/*
>  	 * mlx5_cmd_do() copies the input message to its own buffer before
>  	 * executing it, so we can reuse the allocation for the output.
> @@ -336,8 +346,6 @@ static void *mlx5ctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>  			return ERR_PTR(-ENOMEM);
>  	}
>  
> -	/* Enforce the user context for the command */
> -	MLX5_SET(mbox_in_hdr, rpc_in, uid, mfd->uctx_uid);
>  	ret = mlx5_cmd_do(mcdev->mdev, rpc_in, in_len, rpc_out, *out_len);
>  
>  	mlx5ctl_dbg(mcdev,
> 


