Return-Path: <linux-rdma+bounces-4227-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A01094A1F3
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2024 09:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3271B23144
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2024 07:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127BC1C7B84;
	Wed,  7 Aug 2024 07:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mu6zHR4L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA2322EE5;
	Wed,  7 Aug 2024 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723016673; cv=none; b=q058bTgLiIYHhPurnnQL3EBeP+KJd7ThiOpTdmIQvtncXNPJAf+hLdHOO7gKDE7lJqOydoanOMWkdwPm4/edxNtm4xPAzFkXHE3Bq+fqFumnsQqtROIZATTgi94TS9FV5P4bnB6ZkRPzYKv+OxNB/2c24lwygqVBCSfUPW0zuYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723016673; c=relaxed/simple;
	bh=+pIWFznFFBdtsY4jys5bAc3rIq9i0mVsC5Uci68Jjpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snF20xBD4e8AHK2rQ/Xu0TbnvdbPyLJa4MkftXvaQ962yvljbpvPTBguTyNDMpxJQSzxCfsuNQQx9uN+v57/4EmLx+m2z8IY0RaedNGJiZIEQv/55vHROAl3xqsD4LSRQ2mGzBlcQRQJx3ip0x2cAQ+WQoPtQlTUQGIsetfzGSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mu6zHR4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BBFC32782;
	Wed,  7 Aug 2024 07:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723016671;
	bh=+pIWFznFFBdtsY4jys5bAc3rIq9i0mVsC5Uci68Jjpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mu6zHR4LkxW7exTjoDAKLD8glCoTDeurk8lBsAFNP9psRxCLQmdYOl1lkDLbaF9Fl
	 2YsjxHJN2xgKY1/HkHi/DtybaZC0k2QNhgm2dYg/3UALnaTi2tVaa1Y8IYR9blYK1d
	 Bw+TZUPnmRw9P0JkH328vgAuOu4JZDHxaduLF7mrHi/h/NQSNNILvl59V2z4/BVCk1
	 0VocsdeAm/KEG6b9pLADWzwDetFoLSqHXg5LGnHHib02h9/n+TTHXedOCbYDQtVo37
	 wVZzbkttn5rF+q6tJq3PxRoD3G8eAy4tH2rKL7iDqqj6iA7xaIS8dVfW+BVv9TYJmc
	 M2AsBUEcHqFpQ==
Date: Wed, 7 Aug 2024 10:44:21 +0300
From: Oded Gabbay <ogabbay@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 5/8] fwctl: FWCTL_RPC to execute a Remote Procedure
 Call to device firmware
Message-ID: <ZrMl1bkPP-3G9B4N@T14sgabbay.>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <5-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>

On Mon, Jun 24, 2024 at 07:47:29PM -0300, Jason Gunthorpe wrote:
> Add the FWCTL_RPC ioctl which allows a request/response RPC call to device
> firmware. Drivers implementing this call must follow the security
> guidelines under Documentation/userspace-api/fwctl.rst
>
> The core code provides some memory management helpers to get the messages
> copied from and back to userspace. The driver is responsible for
> allocating the output message memory and delivering the message to the
> device.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/fwctl/main.c       | 62 +++++++++++++++++++++++++++++++++++
>  include/linux/fwctl.h      |  5 +++
>  include/uapi/fwctl/fwctl.h | 66 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 133 insertions(+)
>
> diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
> index f1dec0b590aee4..9506b993a1a56d 100644
> --- a/drivers/fwctl/main.c
> +++ b/drivers/fwctl/main.c
> @@ -8,16 +8,20 @@
>  #include <linux/slab.h>
>  #include <linux/container_of.h>
>  #include <linux/fs.h>
> +#include <linux/sizes.h>
>
>  #include <uapi/fwctl/fwctl.h>
>
>  enum {
>  	FWCTL_MAX_DEVICES = 256,
> +	MAX_RPC_LEN = SZ_2M,
>  };
>  static dev_t fwctl_dev;
>  static DEFINE_IDA(fwctl_ida);
> +static unsigned long fwctl_tainted;
>
>  DEFINE_FREE(kfree_errptr, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T));
> +DEFINE_FREE(kvfree_errptr, void *, if (!IS_ERR_OR_NULL(_T)) kvfree(_T));
>
>  struct fwctl_ucmd {
>  	struct fwctl_uctx *uctx;
> @@ -75,9 +79,66 @@ static int fwctl_cmd_info(struct fwctl_ucmd *ucmd)
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
> +	};
> +
> +	void *inbuf __free(kvfree) =
> +		kvzalloc(cmd->in_len, GFP_KERNEL | GFP_KERNEL_ACCOUNT);
> +	if (!inbuf)
> +		return -ENOMEM;
> +	if (copy_from_user(inbuf, u64_to_user_ptr(cmd->in), cmd->in_len))
> +		return -EFAULT;
> +
> +	out_len = cmd->out_len;
> +	void *outbuf __free(kvfree_errptr) = fwctl->ops->fw_rpc(
> +		ucmd->uctx, cmd->scope, inbuf, cmd->in_len, &out_len);
Hi Jason,
First of all, great work. I fully support this direction. Although I'm not
working anymore in Habana, I would have definitely moved to this interface
instead of the custom one we implemented in our driver. I believe this can
be of use for other accel drivers as well.

Complex devices which contains multiple IPs and FWs, like Habana's Gaudi,
have some RPCs to the firmware which are not related to the funcationality
of the IP drivers (the compute and networking drivers in our case).

Spreading the RPCs between the drivers required to separate it also among
the different user-spaces libraries, as each subsystem has its own user-space.

Disconnecting the RPCs from the drivers and providing a generic interface will
allow to have a single user-space library which will be able to communicate
with the firmware for all the IPs in the device. In Habana's case, it was
mainly for monitoring and debugging purposes.

I do have one question about the rpc ioctl. Are you assuming that the rpc
is synchronous (we send a message to the firmware and block until we get the
reply)? If so, what happen if we have an async RPC implementation
inside the driver? How would you recommend to handle it?

Thanks,
Oded

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
> @@ -98,6 +159,7 @@ struct fwctl_ioctl_op {
>  	}
>  static const struct fwctl_ioctl_op fwctl_ioctl_ops[] = {
>  	IOCTL_OP(FWCTL_INFO, fwctl_cmd_info, struct fwctl_info, out_device_data),
> +	IOCTL_OP(FWCTL_RPC, fwctl_cmd_rpc, struct fwctl_rpc, out),
>  };
>
>  static long fwctl_fops_ioctl(struct file *filp, unsigned int cmd,
> diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
> index 9a906b861acf3a..294cfbf63306a2 100644
> --- a/include/linux/fwctl.h
> +++ b/include/linux/fwctl.h
> @@ -26,6 +26,9 @@ struct fwctl_uctx;
>   *	out_device_data. On input length indicates the size of the user buffer
>   *	on output it indicates the size of the memory. The driver can ignore
>   *	length on input, the core code will handle everything.
> + * @fw_rpc: Implement FWCTL_RPC. Deliver rpc_in/in_len to the FW and return
> + *	the response and set out_len. rpc_in can be returned as the response
> + *	pointer. Otherwise the returned pointer is freed with kvfree().
>   */
>  struct fwctl_ops {
>  	enum fwctl_device_type device_type;
> @@ -33,6 +36,8 @@ struct fwctl_ops {
>  	int (*open_uctx)(struct fwctl_uctx *uctx);
>  	void (*close_uctx)(struct fwctl_uctx *uctx);
>  	void *(*info)(struct fwctl_uctx *uctx, size_t *length);
> +	void *(*fw_rpc)(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
> +			void *rpc_in, size_t in_len, size_t *out_len);
>  };
>
>  /**
> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> index 39db9f09f8068e..8bde0d4416fd55 100644
> --- a/include/uapi/fwctl/fwctl.h
> +++ b/include/uapi/fwctl/fwctl.h
> @@ -67,4 +67,70 @@ struct fwctl_info {
>  };
>  #define FWCTL_INFO _IO(FWCTL_TYPE, FWCTL_CMD_INFO)
>
> +/**
> + * enum fwctl_rpc_scope - Scope of access for the RPC
> + */
> +enum fwctl_rpc_scope {
> +	/**
> +	 * @FWCTL_RPC_CONFIGURATION: Device configuration access scope
> +	 *
> +	 * Read/write access to device configuration. When configuration
> +	 * is written to the device remains in a fully supported state.
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
> +	 * @FWCTL_RPC_DEBUG_WRITE_FULL: Writable access to all debug information
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
> --
> 2.45.2
>
>

