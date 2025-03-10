Return-Path: <linux-rdma+bounces-8537-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA78FA5A2E9
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 19:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DACC3ADD40
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 18:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAFA234978;
	Mon, 10 Mar 2025 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eo51pVEE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4214622DFAA;
	Mon, 10 Mar 2025 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631308; cv=none; b=BAJx7/NYF9NJQbMtgxcpQ+/jwS/7Lr7qyOgcfDSNM9BMMfUTWSEBpm7qzC9dCbU/lh/muX5mHUlF4YXygjWEy0J8rHo5nLNrRLb36EliMruZHeNBti948NTkOZX1LRkgltRMmk7R7bJlIZL0otXYECHmW8wdN5rb8j9OH/eVxKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631308; c=relaxed/simple;
	bh=WN9gP5Aw/arF+ZuJdWRA+y8xB6kB6OmkY3uMuaop8Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWLNhdjevIdMf9QCp6ns+X2O67hQ1r/4n0St2XvVQ3BXlR9rV5xnCm65eTVLSH7Zn4mUj4ogO67/ThcXLLNPc7h+vNURHOffMX/DiMZmouzJUvGYAhOQW+43eHejqrXu2sUkJN2V7PHRFkQRuos0B7AsY7D4A0VxM77MpR4kl+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eo51pVEE; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741631306; x=1773167306;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WN9gP5Aw/arF+ZuJdWRA+y8xB6kB6OmkY3uMuaop8Xk=;
  b=eo51pVEEWszyUO2dnMGfX7+OCG+JDs6d3UM3+1/n7PpkWwJpC3SbUsHJ
   MYLtvfXt4Ul/NrAxfowZ2do93rHDtiLaWBBSHNyIwBroiPnFrrXUR5WjE
   EES5ajEkMmZ059gci6KEn62ZShu60mzvpdUZE7bI8rLU5qCat4V7Gm8tN
   9NtbrlyXX078YTaWrWaKgY5wOZfC4WTePFg8SAb4gVqKjI3fBvLO6DRaa
   hxuRONl3lPIGot1yXRs7+kXk467TNZySGkBx6AzLNVazy9u8khq4UWC8i
   PUbWQiO0V7dIIqMwF76ra/3jxTz5ssmrQz3DphVaClqsNIG+2u+f6G6kZ
   g==;
X-CSE-ConnectionGUID: IIOp3qL/Qp2qtn0b8Xf13Q==
X-CSE-MsgGUID: he7DC3AqSqaAKLYfPbB5mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42775203"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="42775203"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 11:28:25 -0700
X-CSE-ConnectionGUID: 7wgKKWYRTC693PR9ydLnIw==
X-CSE-MsgGUID: kdZHiZVuTlWzzikodWuqPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="150870063"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.111.63]) ([10.125.111.63])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 11:28:24 -0700
Message-ID: <d1c78d12-854f-48e7-a588-4e6cf0991156@intel.com>
Date: Mon, 10 Mar 2025 11:28:23 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] pds_fwctl: initial driver framework
To: Shannon Nelson <shannon.nelson@amd.com>, jgg@nvidia.com,
 andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
 dan.j.williams@intel.com, daniel.vetter@ffwll.ch, dsahern@kernel.org,
 gregkh@linuxfoundation.org, hch@infradead.org, itayavr@nvidia.com,
 jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
 lbloch@nvidia.com, leonro@nvidia.com, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, saeedm@nvidia.com
Cc: brett.creeley@amd.com
References: <20250307185329.35034-1-shannon.nelson@amd.com>
 <20250307185329.35034-5-shannon.nelson@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250307185329.35034-5-shannon.nelson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/7/25 11:53 AM, Shannon Nelson wrote:
> Initial files for adding a new fwctl driver for the AMD/Pensando PDS
> devices.  This sets up a simple auxiliary_bus driver that registers
> with fwctl subsystem.  It expects that a pds_core device has set up
> the auxiliary_device pds_core.fwctl
> 
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

minor comment below.
> ---
>  MAINTAINERS                    |   7 ++
>  drivers/fwctl/Kconfig          |  10 ++
>  drivers/fwctl/Makefile         |   1 +
>  drivers/fwctl/pds/Makefile     |   4 +
>  drivers/fwctl/pds/main.c       | 169 +++++++++++++++++++++++++++++++++
>  include/linux/pds/pds_adminq.h |  83 ++++++++++++++++
>  include/uapi/fwctl/fwctl.h     |   1 +
>  include/uapi/fwctl/pds.h       |  26 +++++
>  8 files changed, 301 insertions(+)
>  create mode 100644 drivers/fwctl/pds/Makefile
>  create mode 100644 drivers/fwctl/pds/main.c
>  create mode 100644 include/uapi/fwctl/pds.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3381e41dcf37..c63fd76a3684 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9576,6 +9576,13 @@ L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	drivers/fwctl/mlx5/
>  
> +FWCTL PDS DRIVER
> +M:	Brett Creeley <brett.creeley@amd.com>
> +R:	Shannon Nelson <shannon.nelson@amd.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	drivers/fwctl/pds/
> +
>  GALAXYCORE GC0308 CAMERA SENSOR DRIVER
>  M:	Sebastian Reichel <sre@kernel.org>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
> index f802cf5d4951..b5583b12a011 100644
> --- a/drivers/fwctl/Kconfig
> +++ b/drivers/fwctl/Kconfig
> @@ -19,5 +19,15 @@ config FWCTL_MLX5
>  	  This will allow configuration and debug tools to work out of the box on
>  	  mainstream kernel.
>  
> +	  If you don't know what to do here, say N.
> +
> +config FWCTL_PDS
> +	tristate "AMD/Pensando pds fwctl driver"
> +	depends on PDS_CORE
> +	help
> +	  The pds_fwctl driver provides an fwctl interface for a user process
> +	  to access the debug and configuration information of the AMD/Pensando
> +	  DSC hardware family.
> +
>  	  If you don't know what to do here, say N.
>  endif
> diff --git a/drivers/fwctl/Makefile b/drivers/fwctl/Makefile
> index 1c535f694d7f..c093b5f661d6 100644
> --- a/drivers/fwctl/Makefile
> +++ b/drivers/fwctl/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_FWCTL) += fwctl.o
>  obj-$(CONFIG_FWCTL_MLX5) += mlx5/
> +obj-$(CONFIG_FWCTL_PDS) += pds/
>  
>  fwctl-y += main.o
> diff --git a/drivers/fwctl/pds/Makefile b/drivers/fwctl/pds/Makefile
> new file mode 100644
> index 000000000000..cc2317c07be1
> --- /dev/null
> +++ b/drivers/fwctl/pds/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_FWCTL_PDS) += pds_fwctl.o
> +
> +pds_fwctl-y += main.o
> diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
> new file mode 100644
> index 000000000000..27942315a602
> --- /dev/null
> +++ b/drivers/fwctl/pds/main.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) Advanced Micro Devices, Inc */
> +
> +#include <linux/module.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/pci.h>
> +#include <linux/vmalloc.h>
> +
> +#include <uapi/fwctl/fwctl.h>
> +#include <uapi/fwctl/pds.h>
> +#include <linux/fwctl.h>
> +
> +#include <linux/pds/pds_common.h>
> +#include <linux/pds/pds_core_if.h>
> +#include <linux/pds/pds_adminq.h>
> +#include <linux/pds/pds_auxbus.h>
> +
> +struct pdsfc_uctx {
> +	struct fwctl_uctx uctx;
> +	u32 uctx_caps;
> +};
> +
> +struct pdsfc_dev {
> +	struct fwctl_device fwctl;
> +	struct pds_auxiliary_dev *padev;
> +	u32 caps;
> +	struct pds_fwctl_ident ident;
> +};
> +
> +static int pdsfc_open_uctx(struct fwctl_uctx *uctx)
> +{
> +	struct pdsfc_dev *pdsfc = container_of(uctx->fwctl, struct pdsfc_dev, fwctl);
> +	struct pdsfc_uctx *pdsfc_uctx = container_of(uctx, struct pdsfc_uctx, uctx);
> +
> +	pdsfc_uctx->uctx_caps = pdsfc->caps;
> +
> +	return 0;
> +}
> +
> +static void pdsfc_close_uctx(struct fwctl_uctx *uctx)
> +{
> +}
> +
> +static void *pdsfc_info(struct fwctl_uctx *uctx, size_t *length)
> +{
> +	struct pdsfc_uctx *pdsfc_uctx = container_of(uctx, struct pdsfc_uctx, uctx);
> +	struct fwctl_info_pds *info;
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return ERR_PTR(-ENOMEM);
> +
> +	info->uctx_caps = pdsfc_uctx->uctx_caps;
> +
> +	return info;
> +}
> +
> +static int pdsfc_identify(struct pdsfc_dev *pdsfc)
> +{
> +	struct device *dev = &pdsfc->fwctl.dev;
> +	union pds_core_adminq_comp comp = {0};
> +	union pds_core_adminq_cmd cmd;
> +	struct pds_fwctl_ident *ident;
> +	dma_addr_t ident_pa;
> +	int err;
> +
> +	ident = dma_alloc_coherent(dev->parent, sizeof(*ident), &ident_pa, GFP_KERNEL);
> +	err = dma_mapping_error(dev->parent, ident_pa);
> +	if (err) {
> +		dev_err(dev, "Failed to map ident buffer\n");
> +		return err;
> +	}
> +
> +	cmd = (union pds_core_adminq_cmd) {
> +		.fwctl_ident = {
> +			.opcode = PDS_FWCTL_CMD_IDENT,
> +			.version = 0,
> +			.len = cpu_to_le32(sizeof(*ident)),
> +			.ident_pa = cpu_to_le64(ident_pa),
> +		}
> +	};
> +
> +	err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
> +	if (err)
> +		dev_err(dev, "Failed to send adminq cmd opcode: %u err: %d\n",
> +			cmd.fwctl_ident.opcode, err);
> +	else
> +		pdsfc->ident = *ident;
> +
> +	dma_free_coherent(dev->parent, sizeof(*ident), ident, ident_pa);
> +
> +	return err;
> +}
> +
> +static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
> +			  void *in, size_t in_len, size_t *out_len)
> +{
> +	return NULL;
> +}
> +
> +static const struct fwctl_ops pdsfc_ops = {
> +	.device_type = FWCTL_DEVICE_TYPE_PDS,
> +	.uctx_size = sizeof(struct pdsfc_uctx),
> +	.open_uctx = pdsfc_open_uctx,
> +	.close_uctx = pdsfc_close_uctx,
> +	.info = pdsfc_info,
> +	.fw_rpc = pdsfc_fw_rpc,
> +};
> +
> +static int pdsfc_probe(struct auxiliary_device *adev,
> +		       const struct auxiliary_device_id *id)
> +{
> +	struct pds_auxiliary_dev *padev =
> +			container_of(adev, struct pds_auxiliary_dev, aux_dev);
> +	struct device *dev = &adev->dev;
> +	struct pdsfc_dev *pdsfc;
> +	int err;
> +
> +	pdsfc = fwctl_alloc_device(&padev->vf_pdev->dev, &pdsfc_ops,
> +				   struct pdsfc_dev, fwctl);
> +	if (!pdsfc)
> +		return dev_err_probe(dev, -ENOMEM, "Failed to allocate fwctl device struct\n");
> +	pdsfc->padev = padev;
> +
> +	err = pdsfc_identify(pdsfc);
> +	if (err) {
> +		fwctl_put(&pdsfc->fwctl);
> +		return dev_err_probe(dev, err, "Failed to identify device\n");
> +	}
> +
> +	err = fwctl_register(&pdsfc->fwctl);
> +	if (err) {
> +		fwctl_put(&pdsfc->fwctl);
> +		return dev_err_probe(dev, err, "Failed to register device\n");
> +	}
> +
> +	auxiliary_set_drvdata(adev, pdsfc);
> +
> +	return 0;
> +}
> +
> +static void pdsfc_remove(struct auxiliary_device *adev)
> +{
> +	struct pdsfc_dev *pdsfc = auxiliary_get_drvdata(adev);
> +
> +	fwctl_unregister(&pdsfc->fwctl);
> +	fwctl_put(&pdsfc->fwctl);
> +}
> +
> +static const struct auxiliary_device_id pdsfc_id_table[] = {
> +	{.name = PDS_CORE_DRV_NAME "." PDS_DEV_TYPE_FWCTL_STR },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(auxiliary, pdsfc_id_table);
> +
> +static struct auxiliary_driver pdsfc_driver = {
> +	.name = "pds_fwctl",
> +	.probe = pdsfc_probe,
> +	.remove = pdsfc_remove,
> +	.id_table = pdsfc_id_table,
> +};
> +
> +module_auxiliary_driver(pdsfc_driver);
> +
> +MODULE_IMPORT_NS("FWCTL");
> +MODULE_DESCRIPTION("pds fwctl driver");
> +MODULE_AUTHOR("Shannon Nelson <shannon.nelson@amd.com>");
> +MODULE_AUTHOR("Brett Creeley <brett.creeley@amd.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
> index 4b4e9a98b37b..22c6d77b3dcb 100644
> --- a/include/linux/pds/pds_adminq.h
> +++ b/include/linux/pds/pds_adminq.h
> @@ -1179,6 +1179,84 @@ struct pds_lm_host_vf_status_cmd {
>  	u8     status;
>  };
>  
> +enum pds_fwctl_cmd_opcode {
> +	PDS_FWCTL_CMD_IDENT = 70,
> +};
> +
> +/**
> + * struct pds_fwctl_cmd - Firmware control command structure
> + * @opcode: Opcode
> + * @rsvd:   Reserved
> + * @ep:     Endpoint identifier
> + * @op:     Operation identifier
> + */
> +struct pds_fwctl_cmd {
> +	u8     opcode;
> +	u8     rsvd[3];
> +	__le32 ep;
> +	__le32 op;
> +} __packed;
> +
> +/**
> + * struct pds_fwctl_comp - Firmware control completion structure
> + * @status:     Status of the firmware control operation
> + * @rsvd:       Reserved
> + * @comp_index: Completion index in little-endian format
> + * @rsvd2:      Reserved
> + * @color:      Color bit indicating the state of the completion
> + */
> +struct pds_fwctl_comp {
> +	u8     status;
> +	u8     rsvd;
> +	__le16 comp_index;
> +	u8     rsvd2[11];
> +	u8     color;
> +} __packed;
> +
> +/**
> + * struct pds_fwctl_ident_cmd - Firmware control identification command structure
> + * @opcode:   Operation code for the command
> + * @rsvd:     Reserved
> + * @version:  Interface version
> + * @rsvd2:    Reserved
> + * @len:      Length of the identification data
> + * @ident_pa: Physical address of the identification data
> + */
> +struct pds_fwctl_ident_cmd {
> +	u8     opcode;
> +	u8     rsvd;
> +	u8     version;
> +	u8     rsvd2;
> +	__le32 len;
> +	__le64 ident_pa;
> +} __packed;
> +
> +/* future feature bits here
> + * enum pds_fwctl_features {
> + * };
> + * (compilers don't like empty enums)
> + */
> +
> +/**
> + * struct pds_fwctl_ident - Firmware control identification structure
> + * @features:    Supported features (enum pds_fwctl_features)
> + * @version:     Interface version
> + * @rsvd:        Reserved
> + * @max_req_sz:  Maximum request size
> + * @max_resp_sz: Maximum response size
> + * @max_req_sg_elems:  Maximum number of request SGs
> + * @max_resp_sg_elems: Maximum number of response SGs
> + */
> +struct pds_fwctl_ident {
> +	__le64 features;
> +	u8     version;
> +	u8     rsvd[3];
> +	__le32 max_req_sz;
> +	__le32 max_resp_sz;
> +	u8     max_req_sg_elems;
> +	u8     max_resp_sg_elems;
> +} __packed;
> +
>  union pds_core_adminq_cmd {
>  	u8     opcode;
>  	u8     bytes[64];
> @@ -1216,6 +1294,9 @@ union pds_core_adminq_cmd {
>  	struct pds_lm_dirty_enable_cmd	  lm_dirty_enable;
>  	struct pds_lm_dirty_disable_cmd	  lm_dirty_disable;
>  	struct pds_lm_dirty_seq_ack_cmd	  lm_dirty_seq_ack;
> +
> +	struct pds_fwctl_cmd		  fwctl;
> +	struct pds_fwctl_ident_cmd	  fwctl_ident;
>  };
>  
>  union pds_core_adminq_comp {
> @@ -1243,6 +1324,8 @@ union pds_core_adminq_comp {
>  
>  	struct pds_lm_state_size_comp	  lm_state_size;
>  	struct pds_lm_dirty_status_comp	  lm_dirty_status;
> +
> +	struct pds_fwctl_comp		  fwctl;
>  };
>  
>  #ifndef __CHECKER__
> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> index c2d5abc5a726..716ac0eee42d 100644
> --- a/include/uapi/fwctl/fwctl.h
> +++ b/include/uapi/fwctl/fwctl.h
> @@ -44,6 +44,7 @@ enum fwctl_device_type {
>  	FWCTL_DEVICE_TYPE_ERROR = 0,
>  	FWCTL_DEVICE_TYPE_MLX5 = 1,
>  	FWCTL_DEVICE_TYPE_CXL = 2,
> +	FWCTL_DEVICE_TYPE_PDS = 4,
>  };
>  
>  /**
> diff --git a/include/uapi/fwctl/pds.h b/include/uapi/fwctl/pds.h
> new file mode 100644
> index 000000000000..558e030b7583
> --- /dev/null
> +++ b/include/uapi/fwctl/pds.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* Copyright(c) Advanced Micro Devices, Inc */
> +
> +/*
> + * fwctl interface info for pds_fwctl
> + */
> +
> +#ifndef _UAPI_FWCTL_PDS_H_
> +#define _UAPI_FWCTL_PDS_H_
> +
> +#include <linux/types.h>
> +
> +/*
> + * struct fwctl_info_pds
> + *
> + * Return basic information about the FW interface available.
> + */

Please use proper kdoc formatting for the comment block.

> +struct fwctl_info_pds {
> +	__u32 uctx_caps;
> +};
> +
> +enum pds_fwctl_capabilities {
> +	PDS_FWCTL_QUERY_CAP = 0,
> +	PDS_FWCTL_SEND_CAP,
> +};
> +#endif /* _UAPI_FWCTL_PDS_H_ */


