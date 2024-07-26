Return-Path: <linux-rdma+bounces-4020-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 862FB93D61D
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 17:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C931F23B8A
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 15:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC2417A5AC;
	Fri, 26 Jul 2024 15:30:26 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374A117578;
	Fri, 26 Jul 2024 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722007826; cv=none; b=nbugk25hRO1oNPFMeE/02q0qSR2qZZS3J/+U3Nw3P9y0V/X80IKqUnevsfrodYVYvmlmJH97lpCv3fecOWWksGZ5YgCOTB2WmV4C8OycU00na84UFyEdLyNEuHVgRdkxjUsg/+wov8uwLcROtFnP4Upd44S9EFjw9XUQ92HtSAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722007826; c=relaxed/simple;
	bh=2p6LBTrbD1s+nNSVnx31yRof9qHlQhhsoyYMBjGs0wY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ssefK/laIwQNJ6J6OZTVOAbjQf/NhF19CVkz4Ev+uQQ7s5z/Aw5urnkbMiX1i3kcQmWEJr74NEGDxahSQSXywT3L8F5JhVo1dgm+62iye5OCkkj2Ey/5Ov8KYtQJzKf3oWOSqhU2QaCs1tqszxsSv5hAnMJ5HwjbwgxPDbckHzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVs8z2bTBz67CtB;
	Fri, 26 Jul 2024 23:28:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 99CA6140C72;
	Fri, 26 Jul 2024 23:30:19 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 16:30:10 +0100
Date: Fri, 26 Jul 2024 16:30:09 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>, Jakub
 Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>, David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>, Leonid
 Bloch <lbloch@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v2 5/8] fwctl: FWCTL_RPC to execute a Remote Procedure
 Call to device firmware
Message-ID: <20240726163009.00005d1c@Huawei.com>
In-Reply-To: <5-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
	<5-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 24 Jun 2024 19:47:29 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

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
A few minor things inline.

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

In what way is that usefully handled as an enum?
I'd just use #defines

>  static dev_t fwctl_dev;
>  static DEFINE_IDA(fwctl_ida);
> +static unsigned long fwctl_tainted;
>  
>  DEFINE_FREE(kfree_errptr, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T));
> +DEFINE_FREE(kvfree_errptr, void *, if (!IS_ERR_OR_NULL(_T)) kvfree(_T));
kvfree define free already defined as this since 6.9


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

As before
#define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)
so don't need both.

> +	if (!inbuf)
> +		return -ENOMEM;
> +	if (copy_from_user(inbuf, u64_to_user_ptr(cmd->in), cmd->in_len))
> +		return -EFAULT;
> +
> +	out_len = cmd->out_len;
> +	void *outbuf __free(kvfree_errptr) = fwctl->ops->fw_rpc(

> +		ucmd->uctx, cmd->scope, inbuf, cmd->in_len, &out_len);
> +	if (IS_ERR(outbuf))
> +		return PTR_ERR(outbuf);
> +	if (outbuf == inbuf) {
> +		/* The driver can re-use inbuf as outbuf */
> +		inbuf = NULL;
I wish no_free_ptr() didn't have __must_check. Can do something ugly
like
		outbuf = no_free_ptr(inbuf);
probably but maybe just setting it NULL is simpler.

> +	}
> +
> +	if (copy_to_user(u64_to_user_ptr(cmd->out), outbuf,
> +			 min(cmd->out_len, out_len)))
> +		return -EFAULT;
> +
> +	cmd->out_len = out_len;
> +	return ucmd_respond(ucmd, sizeof(*cmd));
> +}

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
...

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

Write access
probably rather than writeable.

> +	 *
> +	 * Allows write access to data in the device which may leave a fully
> +	 * supported state. This is intended to permit intensive and possibly
> +	 * invasive debugging. This scope will taint the kernel.
> +	 */


> +};



