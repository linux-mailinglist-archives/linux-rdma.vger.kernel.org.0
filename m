Return-Path: <linux-rdma+bounces-17789-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLb9NtbirmmoJgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17789-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 16:10:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BA223B541
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 16:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 787F33037F13
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 15:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D66B3D6695;
	Mon,  9 Mar 2026 15:03:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169A63D4100;
	Mon,  9 Mar 2026 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068581; cv=none; b=Kmp5pL6W8Y9rpQzaxPHNw+wfqm/WTXf14FmyOrIgqKF3p6h79whtGheThO5kwxbse+xDFnTge/A2HfRQOxdKl0rcqFJoN5CtQRPKpzEfcrJQF2RR69tD2jxqcKXr5T3d6s1F5/MfaB6tUug6e3gxBZPVgk48IrhowMhV3YM8M4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068581; c=relaxed/simple;
	bh=4k0q3HMVGWxliH2NAbp3+md6xy64qAKLeLd5PUR17FM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urQPLE8yk6PTm4qGb9NBlvxDOI7SZ24CoACMuqaKModQO/7whx49NNdiDLGbidAK8zQ7mfwG1yty7wMJmrOyfEOFita6i+470YisSpf6E0i91zRNyzJIoEffpD+Up3smYLAL7scenWMTCn2HyecLm/J3AiGXpbzN5pY1Mny1tto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fV0cW56jrzHnGkY;
	Mon,  9 Mar 2026 23:02:51 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id A0D164056E;
	Mon,  9 Mar 2026 23:02:55 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 15:02:54 +0000
Date: Mon, 9 Mar 2026 15:02:53 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, Dave Jiang
	<dave.jiang@intel.com>, <linux-security-module@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Chiara Meiohas
	<cmeiohas@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>
Subject: Re: [PATCH 1/3] lsm: add hook for firmware command validation
Message-ID: <20260309150253.00001ec7@huawei.com>
In-Reply-To: <20260309-fw-lsm-hook-v1-1-4a6422e63725@nvidia.com>
References: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
	<20260309-fw-lsm-hook-v1-1-4a6422e63725@nvidia.com>
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
X-Rspamd-Queue-Id: 62BA223B541
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-17789-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.558];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:email,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon,  9 Mar 2026 13:15:18 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> From: Chiara Meiohas <cmeiohas@nvidia.com>
> 
> Drivers typically communicate with device firmware either via
> register-based commands (writing parameters into device registers)
> or by passing a command buffer using shared-memory mechanisms.
> 
> This hook targets the command buffer mechanism, which is commonly
> used on modern, complex devices.
> 
> Add the LSM hook fw_validate_cmd. This hook allows inspecting
> firmware command buffers before they are sent to the device.
> The hook receives the command buffer, device, command class, and a
> class-specific id:
>   - class_id (enum fw_cmd_class) allows security modules to
>     differentiate between classes of firmware commands.
>     In this series, class_id distinguishes between commands from the
>     RDMA uverbs interface and from fwctl.
>   - id is a class-specific device identifier. For uverbs, id is the
>     RDMA driver identifier (enum rdma_driver_id). For fwctl, id is the
>     device type (enum fwctl_device_type).
> 
> Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
> Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
> Signed-off-by: Edward Srouji <edwards@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Hi Leon,

To me this seems sensible, but LSM isn't an area I know that much about.

With that in mind:
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

A few formatting related comments inline.

> diff --git a/include/linux/security.h b/include/linux/security.h
> index 83a646d72f6f8..64786d013207a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -67,6 +67,7 @@ enum fs_value_type;
>  struct watch;
>  struct watch_notification;
>  struct lsm_ctx;
> +struct device;
>  
>  /* Default (no) options for the capable function */
>  #define CAP_OPT_NONE 0x0
> @@ -157,6 +158,21 @@ enum lockdown_reason {
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
>  
> +/*
Could add the MAX entry and making this /**
The file is a bit inconsistent on that.

> + * enum fw_cmd_class - Class of the firmware command passed to
> + * security_fw_validate_cmd.
> + * This allows security modules to distinguish between different command
> + * classes.
> + *
> + * @FW_CMD_CLASS_UVERBS: Command originated from the RDMA uverbs interface
> + * @FW_CMD_CLASS_FWCTL: Command originated from the fwctl interface
> + */
> +enum fw_cmd_class {
> +	FW_CMD_CLASS_UVERBS,
> +	FW_CMD_CLASS_FWCTL,
> +	FW_CMD_CLASS_MAX,
Nitpick. Drop the trailing comma to make it a tiny bit more obvious if
someone accidentally adds anything after this counting entry.

> +};
> +
>  /*
>   * Data exported by the security modules
>   */
> @@ -575,6 +591,9 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
>  int security_inode_getsecctx(struct inode *inode, struct lsm_context *cp);
>  int security_locked_down(enum lockdown_reason what);
> +int security_fw_validate_cmd(const void *in, size_t in_len,
> +			     const struct device *dev,
> +			     enum fw_cmd_class class_id, u32 id);
>  int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
>  		      void *val, size_t val_len, u64 id, u64 flags);
>  int security_bdev_alloc(struct block_device *bdev);
> @@ -1589,6 +1608,12 @@ static inline int security_locked_down(enum lockdown_reason what)
>  {
>  	return 0;
>  }
> +static inline int security_fw_validate_cmd(const void *in, size_t in_len,
> +					   const struct device *dev,
> +					   enum fw_cmd_class class_id, u32 id)
> +{
> +	return 0;
> +}
>  static inline int lsm_fill_user_ctx(struct lsm_ctx __user *uctx,
>  				    u32 *uctx_len, void *val, size_t val_len,
>  				    u64 id, u64 flags)
> diff --git a/security/security.c b/security/security.c
> index 67af9228c4e94..d05941fe89a48 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5373,6 +5373,32 @@ int security_locked_down(enum lockdown_reason what)
>  }
>  EXPORT_SYMBOL(security_locked_down);
>  
> +/**
> + * security_fw_validate_cmd() - Validate a firmware command
> + * @in: pointer to the firmware command input buffer
> + * @in_len: length of the firmware command input buffer
> + * @dev: device associated with the command
> + * @class_id: class of the firmware command
> + * @id: device identifier, specific to the command @class_id
> + *
> + * Check permissions before sending a firmware command generated by
> + * userspace to the device.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_fw_validate_cmd(const void *in, size_t in_len,
> +			     const struct device *dev,
> +			     enum fw_cmd_class class_id,
> +			     u32 id)

I'd follow the wrapping you have in the header and have id on the line
above.

> +{
> +	if (class_id >= FW_CMD_CLASS_MAX)
> +		return -EINVAL;
> +
> +	return call_int_hook(fw_validate_cmd, in, in_len,
> +			     dev, class_id, id);

Fits on one line < 80 chars.

> +}
> +EXPORT_SYMBOL_GPL(security_fw_validate_cmd);
> +
>  /**
>   * security_bdev_alloc() - Allocate a block device LSM blob
>   * @bdev: block device
> 


