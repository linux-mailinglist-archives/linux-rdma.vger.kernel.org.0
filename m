Return-Path: <linux-rdma+bounces-7574-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA55A2D21C
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 01:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261CA3AA3F1
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 00:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1561ADDC1;
	Sat,  8 Feb 2025 00:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZVRcoIm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8037DDBE;
	Sat,  8 Feb 2025 00:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974521; cv=none; b=iOkGwJQbefAfKOb+QsgCqctZ5E4CnY39vdaUhiSapBcFP3WzuhJLBHwQTvPMoqDT8YeGLGwaZV2VIkLk+Dq7vQMBBXiHlVXRGynJDouXZI7fZ903PoprcpojjbxnNyFEl3pRQIo6ULsEkKVEtiD0eQaPGyK0dBdw+/OThegdf7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974521; c=relaxed/simple;
	bh=8KpJIyELBLM0Zm/ekc+xVLqtmZ624tseAAI/DgbWJ7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ucVVOnBHPU21IB0FNjwWc5VI/O45UgbCcB0N8YJsAm0wwiIXO7BfU7qS4CFGGpPYxXQXQ+Ft/IQEDt3gbYn2fj27TCfD70ht1/ZQ4zJ4alBLaSuVweu6vSVI/rQE0W+3PlIfLTp8qemJXvyEr1f08qHdCufIWR53NAfxx9XvUCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZVRcoIm; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738974520; x=1770510520;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8KpJIyELBLM0Zm/ekc+xVLqtmZ624tseAAI/DgbWJ7o=;
  b=hZVRcoImJIKRomu2HW9fhR0quar3fr8Qifjp8YS8mOwRMKE1Vard9KFn
   quwRZB4xkX8evCYB1xMM5sJp6y6m0UTEjHiVkOkSRHTGEdurMvHhuNFMP
   adh5WDy8qC/P97RdWp53QZLZOs6OKA+j3Yl5z9mvq1luYCiBFbKlOVNWe
   oQzrbo0Baj+MJjitnurTdVErkaAL+sB0qi6BSgLBKgT1oRDosbyrCTHGQ
   KiWhQI9YIKfkbh8gYXL8vk2J0vFYgTbeeKX9ba7eFtMu1Djml2+2fT+rG
   7ssZtFcuRHTdXBLjI6vmfXr/SdCT2f3MeFlLNJKdeB+UPLQo9L7An7FS8
   g==;
X-CSE-ConnectionGUID: lwSBadX6QZi/SfVh9tkRhg==
X-CSE-MsgGUID: GyEEnRCyTlKkVqhXLs6xyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="50267024"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="50267024"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 16:28:39 -0800
X-CSE-ConnectionGUID: 92Ri3RWuSGiiX23OmfuVSQ==
X-CSE-MsgGUID: +iUnNY97SeGa74brNARD9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116269116"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.111.68]) ([10.125.111.68])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 16:28:37 -0800
Message-ID: <10a9bd55-c7fb-4acc-9d85-f972d1d22fbe@intel.com>
Date: Fri, 7 Feb 2025 17:28:36 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] fwctl: FWCTL_RPC to execute a Remote Procedure
 Call to device firmware
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
References: <5-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <5-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/6/25 5:13 PM, Jason Gunthorpe wrote:
> Add the FWCTL_RPC ioctl which allows a request/response RPC call to device
> firmware. Drivers implementing this call must follow the security
> guidelines under Documentation/userspace-api/fwctl.rst
> 
> The core code provides some memory management helpers to get the messages
> copied from and back to userspace. The driver is responsible for
> allocating the output message memory and delivering the message to the
> device.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/fwctl/main.c       | 60 +++++++++++++++++++++++++++++++++
>  include/linux/fwctl.h      |  8 +++++
>  include/uapi/fwctl/fwctl.h | 68 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 136 insertions(+)
> 
> diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
> index 4b6792f2031e86..a5e26944b830b5 100644
> --- a/drivers/fwctl/main.c
> +++ b/drivers/fwctl/main.c
> @@ -8,17 +8,20 @@
>  #include <linux/container_of.h>
>  #include <linux/fs.h>
>  #include <linux/module.h>
> +#include <linux/sizes.h>
>  #include <linux/slab.h>
>  
>  #include <uapi/fwctl/fwctl.h>
>  
>  enum {
>  	FWCTL_MAX_DEVICES = 4096,
> +	MAX_RPC_LEN = SZ_2M,
>  };
>  static_assert(FWCTL_MAX_DEVICES < (1U << MINORBITS));
>  
>  static dev_t fwctl_dev;
>  static DEFINE_IDA(fwctl_ida);
> +static unsigned long fwctl_tainted;
>  
>  struct fwctl_ucmd {
>  	struct fwctl_uctx *uctx;
> @@ -76,9 +79,65 @@ static int fwctl_cmd_info(struct fwctl_ucmd *ucmd)
>  	return ucmd_respond(ucmd, sizeof(*cmd));
>  }
>  
> +static int fwctl_cmd_rpc(struct fwctl_ucmd *ucmd)
> +{
> +	struct fwctl_device *fwctl = ucmd->uctx->fwctl;
> +	struct fwctl_rpc *cmd = ucmd->cmd;
> +	size_t out_len;
> +
> +	if (cmd->in_len > MAX_RPC_LEN || cmd->out_len > MAX_RPC_LEN)
> +		return -EMSGSIZE;
> +
> +	switch (cmd->scope) {
> +	case FWCTL_RPC_CONFIGURATION:
> +	case FWCTL_RPC_DEBUG_READ_ONLY:
> +		break;
> +
> +	case FWCTL_RPC_DEBUG_WRITE_FULL:
> +		if (!capable(CAP_SYS_RAWIO))
> +			return -EPERM;
> +		fallthrough;
> +	case FWCTL_RPC_DEBUG_WRITE:
> +		if (!test_and_set_bit(0, &fwctl_tainted)) {
> +			dev_warn(
> +				&fwctl->dev,
> +				"%s(%d): has requested full access to the physical device device",
> +				current->comm, task_pid_nr(current));
> +			add_taint(TAINT_FWCTL, LOCKDEP_STILL_OK);
> +		}
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	void *inbuf __free(kvfree) = kvzalloc(cmd->in_len, GFP_KERNEL_ACCOUNT);
> +	if (!inbuf)
> +		return -ENOMEM;
> +	if (copy_from_user(inbuf, u64_to_user_ptr(cmd->in), cmd->in_len))
> +		return -EFAULT;
> +
> +	out_len = cmd->out_len;
> +	void *outbuf __free(kvfree) = fwctl->ops->fw_rpc(
> +		ucmd->uctx, cmd->scope, inbuf, cmd->in_len, &out_len);
> +	if (IS_ERR(outbuf))
> +		return PTR_ERR(outbuf);
> +	if (outbuf == inbuf) {
> +		/* The driver can re-use inbuf as outbuf */
> +		inbuf = NULL;
> +	}
> +
> +	if (copy_to_user(u64_to_user_ptr(cmd->out), outbuf,
> +			 min(cmd->out_len, out_len)))
> +		return -EFAULT;
> +
> +	cmd->out_len = out_len;
> +	return ucmd_respond(ucmd, sizeof(*cmd));
> +}
> +
>  /* On stack memory for the ioctl structs */
>  union ucmd_buffer {
>  	struct fwctl_info info;
> +	struct fwctl_rpc rpc;
>  };
>  
>  struct fwctl_ioctl_op {
> @@ -99,6 +158,7 @@ struct fwctl_ioctl_op {
>  	}
>  static const struct fwctl_ioctl_op fwctl_ioctl_ops[] = {
>  	IOCTL_OP(FWCTL_INFO, fwctl_cmd_info, struct fwctl_info, out_device_data),
> +	IOCTL_OP(FWCTL_RPC, fwctl_cmd_rpc, struct fwctl_rpc, out),
>  };
>  
>  static long fwctl_fops_ioctl(struct file *filp, unsigned int cmd,
> diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
> index 9b6cc8ae1aa0ca..c2fcaa17a2bcd5 100644
> --- a/include/linux/fwctl.h
> +++ b/include/linux/fwctl.h
> @@ -47,6 +47,14 @@ struct fwctl_ops {
>  	 * ignore length on input, the core code will handle everything.
>  	 */
>  	void *(*info)(struct fwctl_uctx *uctx, size_t *length);
> +	/**
> +	 * @fw_rpc: Implement FWCTL_RPC. Deliver rpc_in/in_len to the FW and
> +	 * return the response and set out_len. rpc_in can be returned as the
> +	 * response pointer. Otherwise the returned pointer is freed with
> +	 * kvfree().
> +	 */
> +	void *(*fw_rpc)(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
> +			void *rpc_in, size_t in_len, size_t *out_len);
>  };
>  
>  /**
> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> index ac66853200a5a8..7a21f2f011917a 100644
> --- a/include/uapi/fwctl/fwctl.h
> +++ b/include/uapi/fwctl/fwctl.h
> @@ -67,4 +67,72 @@ struct fwctl_info {
>  };
>  #define FWCTL_INFO _IO(FWCTL_TYPE, FWCTL_CMD_INFO)
>  
> +/**
> + * enum fwctl_rpc_scope - Scope of access for the RPC
> + *
> + * Refer to fwctl.rst for a more detailed discussion of these scopes.
> + */
> +enum fwctl_rpc_scope {
> +	/**
> +	 * @FWCTL_RPC_CONFIGURATION: Device configuration access scope
> +	 *
> +	 * Read/write access to device configuration. When configuration
> +	 * is written to the device it remains in a fully supported state.
> +	 */
> +	FWCTL_RPC_CONFIGURATION = 0,
> +	/**
> +	 * @FWCTL_RPC_DEBUG_READ_ONLY: Read only access to debug information
> +	 *
> +	 * Readable debug information. Debug information is compatible with
> +	 * kernel lockdown, and does not disclose any sensitive information. For
> +	 * instance exposing any encryption secrets from this information is
> +	 * forbidden.
> +	 */
> +	FWCTL_RPC_DEBUG_READ_ONLY = 1,
> +	/**
> +	 * @FWCTL_RPC_DEBUG_WRITE: Writable access to lockdown compatible debug information
> +	 *
> +	 * Allows write access to data in the device which may leave a fully
> +	 * supported state. This is intended to permit intensive and possibly
> +	 * invasive debugging. This scope will taint the kernel.
> +	 */
> +	FWCTL_RPC_DEBUG_WRITE = 2,
> +	/**
> +	 * @FWCTL_RPC_DEBUG_WRITE_FULL: Write access to all debug information
> +	 *
> +	 * Allows read/write access to everything. Requires CAP_SYS_RAW_IO, so
> +	 * it is not required to follow lockdown principals. If in doubt
> +	 * debugging should be placed in this scope. This scope will taint the
> +	 * kernel.
> +	 */
> +	FWCTL_RPC_DEBUG_WRITE_FULL = 3,
> +};
> +
> +/**
> + * struct fwctl_rpc - ioctl(FWCTL_RPC)
> + * @size: sizeof(struct fwctl_rpc)
> + * @scope: One of enum fwctl_rpc_scope, required scope for the RPC
> + * @in_len: Length of the in memory
> + * @out_len: Length of the out memory
> + * @in: Request message in device specific format
> + * @out: Response message in device specific format
> + *
> + * Deliver a Remote Procedure Call to the device FW and return the response. The
> + * call's parameters and return are marshaled into linear buffers of memory. Any
> + * errno indicates that delivery of the RPC to the device failed. Return status
> + * originating in the device during a successful delivery must be encoded into
> + * out.
> + *
> + * The format of the buffers matches the out_device_type from FWCTL_INFO.
> + */
> +struct fwctl_rpc {
> +	__u32 size;
> +	__u32 scope;
> +	__u32 in_len;
> +	__u32 out_len;
> +	__aligned_u64 in;
> +	__aligned_u64 out;
> +};
> +#define FWCTL_RPC _IO(FWCTL_TYPE, FWCTL_CMD_RPC)
> +
>  #endif


