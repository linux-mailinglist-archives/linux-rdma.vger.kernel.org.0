Return-Path: <linux-rdma+bounces-17802-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +K7ELwz+rmkxLQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17802-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 18:06:20 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B102923D558
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 18:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0085F304B076
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 17:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DE53CD8B5;
	Mon,  9 Mar 2026 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="meQEx7oW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11693CD8AF;
	Mon,  9 Mar 2026 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075610; cv=none; b=tJcbmervEHw6dIrJBvJedye3GUI7F8UfNUMHWbJznYha+6uMdY43ideNnNxL0jlm4ySFhnRYMTT3VOT5Vzv7xzrO02QVHGGuCEjOt3zU5Wa2VZlPvoGb5EyUzoCQZoBj8kjDUyOmHujY+fcax8yj8bUDmPULhN01Ile6GyrYK1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075610; c=relaxed/simple;
	bh=j0mnp/PMNkOZ2R+g+hxot9obaXusml6Kmx0B/uVeea0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1D3uDIpvKCuRHuMtx+oj7r1LCSIrbmztZsib9FM46lBNBULoER43GupSKoxW9URxMIIxyzGYCrmx1mASBFUzyp5xW8lfqdGga8mdaumgduq/3mMAAtKiwXTyqlsL+QrJlrY2gDpy3OPUpmZcYAf6rDkjr4GNPRHXk9lRVAQHsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=meQEx7oW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773075608; x=1804611608;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j0mnp/PMNkOZ2R+g+hxot9obaXusml6Kmx0B/uVeea0=;
  b=meQEx7oWoMo0AcnyHb2XVD4FQYadLXPLJVDp/n8QVbzpBCCf2R4RdR8h
   05BR2kbcK0qWBjnTvy0w0sVH5toIud7CqVPKF4cCDHn5YEpaw1wyG7S8p
   oLkLRCA980nS31GW2RM1OLXPbYx7k5FSP5fXOl+9sYJEvj2S/oibn55wL
   vMxKObyiMum6z3CfobX34bojxcSoFzB2uGJ7W49LuCCpQyn/NeQO0Dj9F
   RrL9reTGXfPNu6mxLywGztyhUCg/yiga2GVjat7ogWD3kN4n4vnG8vJ7F
   ZtFnJbLscwOHC1dnyUvHAbgniUF6iPfSWxJevz4d4JwIAVMFZYpNSQYp1
   g==;
X-CSE-ConnectionGUID: DnhhoqjrRSKE4NcP7/MJMQ==
X-CSE-MsgGUID: Brted+83QbK10gw/GtbDfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="77986255"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="77986255"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 10:00:08 -0700
X-CSE-ConnectionGUID: XZayLEE+Q8eKxVv457kkcQ==
X-CSE-MsgGUID: lKa7YV9SSKSGVTiMd8kCJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="224750150"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.109.205]) ([10.125.109.205])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 10:00:07 -0700
Message-ID: <d2788a2a-dd1c-479e-980d-42e6c2e9facb@intel.com>
Date: Mon, 9 Mar 2026 10:00:05 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] lsm: add hook for firmware command validation
To: Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
 Itay Avraham <itayavr@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>,
 Maher Sanalla <msanalla@nvidia.com>, Edward Srouji <edwards@nvidia.com>
References: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
 <20260309-fw-lsm-hook-v1-1-4a6422e63725@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260309-fw-lsm-hook-v1-1-4a6422e63725@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B102923D558
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-17802-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.950];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action



On 3/9/26 4:15 AM, Leon Romanovsky wrote:
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      | 25 +++++++++++++++++++++++++
>  security/security.c           | 26 ++++++++++++++++++++++++++
>  3 files changed, 53 insertions(+)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 8c42b4bde09c0..93da090384ea1 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -445,6 +445,8 @@ LSM_HOOK(int, 0, bpf_token_capable, const struct bpf_token *token, int cap)
>  #endif /* CONFIG_BPF_SYSCALL */
>  
>  LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
> +LSM_HOOK(int, 0, fw_validate_cmd, const void *in, size_t in_len,
> +	 const struct device *dev, enum fw_cmd_class class_id, u32 id)
>  
>  #ifdef CONFIG_PERF_EVENTS
>  LSM_HOOK(int, 0, perf_event_open, int type)
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
> +{
> +	if (class_id >= FW_CMD_CLASS_MAX)
> +		return -EINVAL;
> +
> +	return call_int_hook(fw_validate_cmd, in, in_len,
> +			     dev, class_id, id);
> +}
> +EXPORT_SYMBOL_GPL(security_fw_validate_cmd);
> +
>  /**
>   * security_bdev_alloc() - Allocate a block device LSM blob
>   * @bdev: block device
> 


