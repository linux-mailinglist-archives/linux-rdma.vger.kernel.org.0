Return-Path: <linux-rdma+bounces-7572-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286E0A2D1ED
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 01:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BBE816C3E1
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 00:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC781D52B;
	Sat,  8 Feb 2025 00:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cYOq0tZn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449161BC2A;
	Sat,  8 Feb 2025 00:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974073; cv=none; b=sDn1CpFNxDE6b02qOnbMX9YmGYh13f+oCdKnG+9iKwiGcwNocFGZR/TMrjWEgzQx5rzLIYpRIwy2vI7ZLZcsE8cMw6SefBhzCCVne2OYM71ajUZAVue+0mGdSkG7gaNY2UhgUrLWQqk0rw8+E74I/2WE9ydC/6aEVCt1GldCaRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974073; c=relaxed/simple;
	bh=Rf6R9uh+1CDW2CokosuWnLg4K+BLwN3DJHH2QKDIoMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCHXYlZFrLsEsv5cH+1pcp9n+LVqekJ73jh2hOmL9TPP5w9V8cAcD2IfomoaB8BoouepFtWeuU/GHO6dZQ/QOC8BjODrVKvyAW9o9izWBtw9QE7I+ZRrr/qa4pdop+PmUrzrM13reOhkdsLUUFcYBRw66J/N9/SkocKNPvUeECQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cYOq0tZn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738974071; x=1770510071;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Rf6R9uh+1CDW2CokosuWnLg4K+BLwN3DJHH2QKDIoMo=;
  b=cYOq0tZn5tmtBgNAwsizlxZrWx284bGlRj4dVZZNdEzz9b452PNCSj3z
   lfhxO1tWVjvbPXvX1zT7VPWawrebxfP//z+KADbdxOxdL58kF2plNj+sb
   eTtVjmBV/YtmBurxOEKb9YfWJ6lLklwnUuS9asdt2YPbbJtf92YZYsc+j
   ePDuhXN5Xwav/bd+Lu2WEBcJ56cVp7HmJNPuYEPlBuYjKQuAONt/SHUqD
   H9LjsCrLsykgj3QCbx0ih9c5gZ4ZC+Io7qsY5ppJ8yJOMHAekNAlBvvsn
   iUohbYSm9E3LaQNw0EfsTLQi+EvitOQB/ozHwttPwcH7bsqlmS+qS+vhz
   w==;
X-CSE-ConnectionGUID: fto1vZuHQuSzTAlVh+8VHQ==
X-CSE-MsgGUID: FkvxrM7fRS+MheBl4bJwZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39891830"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="39891830"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 16:21:10 -0800
X-CSE-ConnectionGUID: TdFv3LnmROyLO4ty9JMVOA==
X-CSE-MsgGUID: H6oPM+CAQcy2pUpsYPVs6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112554409"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.111.68]) ([10.125.111.68])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 16:21:09 -0800
Message-ID: <761f0f12-417e-400d-b8f1-ccb9c8766c09@intel.com>
Date: Fri, 7 Feb 2025 17:21:08 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] fwctl: FWCTL_INFO to return basic information
 about the device
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, David Ahern <dsahern@kernel.org>,
 Andy Gospodarek <gospo@broadcom.com>, Christoph Hellwig <hch@infradead.org>,
 Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, "Nelson, Shannon"
 <shannon.nelson@amd.com>
References: <3-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <3-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/6/25 5:13 PM, Jason Gunthorpe wrote:
> Userspace will need to know some details about the fwctl interface being
> used to locate the correct userspace code to communicate with the
> kernel. Provide a simple device_type enum indicating what the kernel
> driver is.
> 
> Allow the device to provide a device specific info struct that contains
> any additional information that the driver may need to provide to
> userspace.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/fwctl/main.c       | 51 ++++++++++++++++++++++++++++++++++++++
>  include/linux/fwctl.h      | 12 +++++++++
>  include/uapi/fwctl/fwctl.h | 32 ++++++++++++++++++++++++
>  3 files changed, 95 insertions(+)
> 
> diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
> index d561deaf2b86d8..4b6792f2031e86 100644
> --- a/drivers/fwctl/main.c
> +++ b/drivers/fwctl/main.c
> @@ -27,8 +27,58 @@ struct fwctl_ucmd {
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
> +		void *driver_info __free(kfree) =
> +			fwctl->ops->info(ucmd->uctx, &driver_info_len);
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
> @@ -48,6 +98,7 @@ struct fwctl_ioctl_op {
>  		.execute = _fn,                                       \
>  	}
>  static const struct fwctl_ioctl_op fwctl_ioctl_ops[] = {
> +	IOCTL_OP(FWCTL_INFO, fwctl_cmd_info, struct fwctl_info, out_device_data),
>  };
>  
>  static long fwctl_fops_ioctl(struct file *filp, unsigned int cmd,
> diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
> index 93b470efb9dbc3..9b6cc8ae1aa0ca 100644
> --- a/include/linux/fwctl.h
> +++ b/include/linux/fwctl.h
> @@ -7,6 +7,7 @@
>  #include <linux/device.h>
>  #include <linux/cdev.h>
>  #include <linux/cleanup.h>
> +#include <uapi/fwctl/fwctl.h>
>  
>  struct fwctl_device;
>  struct fwctl_uctx;
> @@ -19,6 +20,10 @@ struct fwctl_uctx;
>   * it will block device hot unplug and module unloading.
>   */
>  struct fwctl_ops {
> +	/**
> +	 * @device_type: The drivers assigned device_type number. This is uABI.
> +	 */
> +	enum fwctl_device_type device_type;
>  	/**
>  	 * @uctx_size: The size of the fwctl_uctx struct to allocate. The first
>  	 * bytes of this memory will be a fwctl_uctx. The driver can use the
> @@ -35,6 +40,13 @@ struct fwctl_ops {
>  	 * is closed.
>  	 */
>  	void (*close_uctx)(struct fwctl_uctx *uctx);
> +	/**
> +	 * @info: Implement FWCTL_INFO. Return a kmalloc() memory that is copied
> +	 * to out_device_data. On input length indicates the size of the user
> +	 * buffer on output it indicates the size of the memory. The driver can
> +	 * ignore length on input, the core code will handle everything.
> +	 */
> +	void *(*info)(struct fwctl_uctx *uctx, size_t *length);
>  };
>  
>  /**
> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> index f4718a6240f281..ac66853200a5a8 100644
> --- a/include/uapi/fwctl/fwctl.h
> +++ b/include/uapi/fwctl/fwctl.h
> @@ -4,6 +4,9 @@
>  #ifndef _UAPI_FWCTL_H
>  #define _UAPI_FWCTL_H
>  
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
>  #define FWCTL_TYPE 0x9A
>  
>  /**
> @@ -33,6 +36,35 @@
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


