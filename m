Return-Path: <linux-rdma+bounces-4094-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15306940AA7
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 10:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93BFBB24169
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 08:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2242B194143;
	Tue, 30 Jul 2024 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQSEr+M7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66491922DD;
	Tue, 30 Jul 2024 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722326444; cv=none; b=JQvEcD8tnWZ5Us76vYuF7Ha2UybGhJv8sO4vSBQyq6NfPVvFq62DsG4Eyk4wRMdUyk0kZedwOyAovjN0ogGXfui0hwlif9cL0raxi2Peb/DQq4N1ZKG/S6qzRaJ1VCio07hnCPs5Xn09iC42WvNjPA62f2YnrgqdA5nLSX5MMGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722326444; c=relaxed/simple;
	bh=me2Vx0Tql7Lk7lB65nstEIzCxKFK2tRL4TMf2lYsypc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tT14eiHUU0rqQE9M9XjtkS8xFO5tG3A7VBCDH7frFgq7pDGlhnmpX5aH0vPCRTMKtbHtnSzGQndp9YJI0k49Nvg3N7ZsL8f00rsWyJTuAnFknig1E8NfK5IF1mgz/wcecFMhSAXij+tKmuI7+CsvNv8Vje7pUnGXpiooWoDcq7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQSEr+M7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D53C32782;
	Tue, 30 Jul 2024 08:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722326444;
	bh=me2Vx0Tql7Lk7lB65nstEIzCxKFK2tRL4TMf2lYsypc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mQSEr+M77vYU0z5icTDzOeeMVIPJ7yXJj/PEjntm162mYSpfECFJ7pr0CfnfmiDIO
	 REvodpJQ3WRokcYnzFKj7cjEMMUZxRemShSGIDzl9uuGKAYdcjNee/yFZq7uA2yQMd
	 6t0fH6vUWfhAD6PaEQ+GoMIzulP6yzxzsyAfcu43nPAbzf2rwX93Q6uGL+qP8LdpjX
	 afsmrdo2vRsIxrZHqJG4wlbGTmYkzBkV3qvckUH++kvhQ5a/dJe53wtFsDJ6GNPFZ6
	 EnIDgUn8hLUQEuscjYyytRCNcIEg73X2y4gKJHBdxI3OhXdtBiRvEH8CTgZGyilhq7
	 BaplhWs3YYcBw==
Date: Tue, 30 Jul 2024 11:00:38 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 5/8] fwctl: FWCTL_RPC to execute a Remote Procedure
 Call to device firmware
Message-ID: <20240730080038.GA4209@unreal>
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


<...>

> +	out_len = cmd->out_len;
> +	void *outbuf __free(kvfree_errptr) = fwctl->ops->fw_rpc(
> +		ucmd->uctx, cmd->scope, inbuf, cmd->in_len, &out_len);

I was under impression that declaration of variables in C should be at the beginning
of block. Was it changed for the kernel?

Thanks

