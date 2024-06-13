Return-Path: <linux-rdma+bounces-3144-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E645B907F85
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2024 01:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636F31F21646
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 23:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEF2156644;
	Thu, 13 Jun 2024 23:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Etfs7nim"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2F9155CBE;
	Thu, 13 Jun 2024 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718321571; cv=none; b=JfW6bK/6rtEg0cM/NWpXnshrHj87sKyC1lW4AOMkxFnjEpjMmBU2IbWI4jIBTttMngZaPeHsBg4N3WUWT5EUuxL+0X1YoPet2kLxOS6e5czKKNXFFxCCA++R6JnMZsrT+B/jdfH4CSVPegDskhS0BPfcXQi0hmcRNKnHLe4LEeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718321571; c=relaxed/simple;
	bh=M8o41hq2y/cLCRJOH2p4sk/4nnWqpAlctqY1GvPsGqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fd0LfhURlDfZja/ljsIhBiqBcItZ9M1xonSsuvdW4L8aJVgDMYzzAVv76Np7ptM7Clq5a5WN+26E4st+cf7xJ09lsUXSEtnppOaPIt0pSY/fYGaKdU9UFHeiW7wt/nRgi+5n5onaPXv7KlQQpBuscpALCzZwD5WfwM4VwlgV3Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Etfs7nim; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718321568; x=1749857568;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M8o41hq2y/cLCRJOH2p4sk/4nnWqpAlctqY1GvPsGqQ=;
  b=Etfs7nimWfOGysal62eGhEH0YtXUotXHp+gUX+L7ICKiUsyACEQ/1EnO
   kOwixTLEQ6P4tkffa/XrD0PgukV7yiMeWSVfzC4e4CeWVmo1B0znJHSGi
   juqjU2DCokNSUB00AfMU/RSQIgRZgCVHqi8F5hb1pgofFZch/RKs7LvPr
   pnr7/Ca7AejvWMITNaYZARNQpmm2KVL41M4kJfmizeY7X6Dn8bHwFjVdY
   OXkDFEEmm9hh6iLKuAasIaC151VqH5pAk4tLTu5fC6QPjxb5W1/2ucMJb
   pIEJ+jFEAp+46G/tGdTvbbtUO/qcN4stsw8HdFNkUwewogI5v5gmVRMXH
   A==;
X-CSE-ConnectionGUID: iBSSWmzHQTKXbrJd7/6I3w==
X-CSE-MsgGUID: 3FCla71jQRaNzMQpQ5s+Cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="40600287"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40600287"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 16:32:47 -0700
X-CSE-ConnectionGUID: 6CCGTarnRZGv3VPNn1kTfg==
X-CSE-MsgGUID: euhTvjf/Q9iUmBVZzwfelg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40272567"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.111.43]) ([10.125.111.43])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 16:32:45 -0700
Message-ID: <358d2e11-59e2-46eb-a7f4-3c69e6befe02@intel.com>
Date: Thu, 13 Jun 2024 16:32:44 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] fwctl: FWCTL_INFO to return basic information about
 the device
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Itay Avraham <itayavr@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>, David Ahern <dsahern@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
 Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-cxl@vger.kernel.org, patches@lists.linux.dev
References: <3-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <3-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/24 8:53 AM, Jason Gunthorpe wrote:
> Userspace will need to know some details about the fwctl interface being
> used to locate the correct userspace code to communicate with the
> kernel. Provide a simple device_type enum indicating what the kernel
> driver is.
> 
> Allow the device to provide a device specific info struct that contains
> any additional information that the driver may need to provide to
> userspace.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/fwctl/main.c       | 54 ++++++++++++++++++++++++++++++++++++++
>  include/linux/fwctl.h      |  8 ++++++
>  include/uapi/fwctl/fwctl.h | 29 ++++++++++++++++++++
>  3 files changed, 91 insertions(+)
> 
> diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
> index 7ecdabdd9dcb1e..10e3f504893892 100644
> --- a/drivers/fwctl/main.c
> +++ b/drivers/fwctl/main.c
> @@ -17,6 +17,8 @@ enum {
>  static dev_t fwctl_dev;
>  static DEFINE_IDA(fwctl_ida);
>  
> +DEFINE_FREE(kfree_errptr, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T));
> +
>  struct fwctl_ucmd {
>  	struct fwctl_uctx *uctx;
>  	void __user *ubuffer;
> @@ -24,8 +26,59 @@ struct fwctl_ucmd {
>  	u32 user_size;
>  };
>  
> +static int ucmd_respond(struct fwctl_ucmd *ucmd, size_t cmd_len)
> +{
> +	if (copy_to_user(ucmd->ubuffer, ucmd->cmd,
> +			 min_t(size_t, ucmd->user_size, cmd_len)))
> +		return -EFAULT;
> +	return 0;
> +}
> +
> +static int copy_to_user_zero_pad(void __user *to, const void *from,
> +				 size_t from_len, size_t user_len)
> +{
> +	size_t copy_len;
> +
> +	copy_len = min(from_len, user_len);
> +	if (copy_to_user(to, from, copy_len))
> +		return -EFAULT;
> +	if (copy_len < user_len) {
> +		if (clear_user(to + copy_len, user_len - copy_len))
> +			return -EFAULT;
> +	}
> +	return 0;
> +}
> +
> +static int fwctl_cmd_info(struct fwctl_ucmd *ucmd)
> +{
> +	struct fwctl_device *fwctl = ucmd->uctx->fwctl;
> +	struct fwctl_info *cmd = ucmd->cmd;
> +	size_t driver_info_len = 0;
> +
> +	if (cmd->flags)
> +		return -EOPNOTSUPP;
> +
> +	if (cmd->device_data_len) {
> +		void *driver_info __free(kfree_errptr) = NULL;
> +
> +		driver_info = fwctl->ops->info(ucmd->uctx, &driver_info_len);

Hi Jason,
Are you open to pass in potential user input for the info query? I'm working on plumbing fwctl for CXL. The current CXL query command [1] takes a number of commands as input for its ioctl. For fwctl_cmd_info(), the current implementation is when ->info() is called no information about the user buffer length or an input buffer is provided. To make things work I can just return everything each ioctl call and user can sort it out by calling the ioctl twice and provide a u32 size buffer first to figure out the total number of commands and then provide a larger buffer for all the command info. Just trying to see if you are open to something a bit more cleaner than depending on a side effect of the ioctl to retrieve all the information.  

[1] https://elixir.bootlin.com/linux/v6.10-rc3/source/drivers/cxl/core/mbox.c#L526

DJ

> +		if (IS_ERR(driver_info))
> +			return PTR_ERR(driver_info);
> +
> +		if (copy_to_user_zero_pad(u64_to_user_ptr(cmd->out_device_data),
> +					  driver_info, driver_info_len,
> +					  cmd->device_data_len))
> +			return -EFAULT;
> +	}
> +
> +	cmd->out_device_type = fwctl->ops->device_type;
> +	cmd->device_data_len = driver_info_len;
> +	return ucmd_respond(ucmd, sizeof(*cmd));
> +}
> +
>  /* On stack memory for the ioctl structs */
>  union ucmd_buffer {
> +	struct fwctl_info info;
>  };
>  
>  struct fwctl_ioctl_op {
> @@ -45,6 +98,7 @@ struct fwctl_ioctl_op {
>  		.execute = _fn,                                       \
>  	}
>  static const struct fwctl_ioctl_op fwctl_ioctl_ops[] = {
> +	IOCTL_OP(FWCTL_INFO, fwctl_cmd_info, struct fwctl_info, out_device_data),
>  };
>  
>  static long fwctl_fops_ioctl(struct file *filp, unsigned int cmd,
> diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
> index 1d9651de92fc19..9a906b861acf3a 100644
> --- a/include/linux/fwctl.h
> +++ b/include/linux/fwctl.h
> @@ -7,12 +7,14 @@
>  #include <linux/device.h>
>  #include <linux/cdev.h>
>  #include <linux/cleanup.h>
> +#include <uapi/fwctl/fwctl.h>
>  
>  struct fwctl_device;
>  struct fwctl_uctx;
>  
>  /**
>   * struct fwctl_ops - Driver provided operations
> + * @device_type: The drivers assigned device_type number. This is uABI
>   * @uctx_size: The size of the fwctl_uctx struct to allocate. The first
>   *	bytes of this memory will be a fwctl_uctx. The driver can use the
>   *	remaining bytes as its private memory.
> @@ -20,11 +22,17 @@ struct fwctl_uctx;
>   *	used.
>   * @close_uctx: Called when the uctx is destroyed, usually when the FD is
>   *	closed.
> + * @info: Implement FWCTL_INFO. Return a kmalloc() memory that is copied to
> + *	out_device_data. On input length indicates the size of the user buffer
> + *	on output it indicates the size of the memory. The driver can ignore
> + *	length on input, the core code will handle everything.
>   */
>  struct fwctl_ops {
> +	enum fwctl_device_type device_type;
>  	size_t uctx_size;
>  	int (*open_uctx)(struct fwctl_uctx *uctx);
>  	void (*close_uctx)(struct fwctl_uctx *uctx);
> +	void *(*info)(struct fwctl_uctx *uctx, size_t *length);
>  };
>  
>  /**
> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> index 0bdce95b6d69d9..39db9f09f8068e 100644
> --- a/include/uapi/fwctl/fwctl.h
> +++ b/include/uapi/fwctl/fwctl.h
> @@ -36,6 +36,35 @@
>   */
>  enum {
>  	FWCTL_CMD_BASE = 0,
> +	FWCTL_CMD_INFO = 0,
> +	FWCTL_CMD_RPC = 1,
>  };
>  
> +enum fwctl_device_type {
> +	FWCTL_DEVICE_TYPE_ERROR = 0,
> +};
> +
> +/**
> + * struct fwctl_info - ioctl(FWCTL_INFO)
> + * @size: sizeof(struct fwctl_info)
> + * @flags: Must be 0
> + * @out_device_type: Returns the type of the device from enum fwctl_device_type
> + * @device_data_len: On input the length of the out_device_data memory. On
> + *	output the size of the kernel's device_data which may be larger or
> + *	smaller than the input. Maybe 0 on input.
> + * @out_device_data: Pointer to a memory of device_data_len bytes. Kernel will
> + *	fill the entire memory, zeroing as required.
> + *
> + * Returns basic information about this fwctl instance, particularly what driver
> + * is being used to define the device_data format.
> + */
> +struct fwctl_info {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 out_device_type;
> +	__u32 device_data_len;
> +	__aligned_u64 out_device_data;
> +};
> +#define FWCTL_INFO _IO(FWCTL_TYPE, FWCTL_CMD_INFO)
> +
>  #endif

