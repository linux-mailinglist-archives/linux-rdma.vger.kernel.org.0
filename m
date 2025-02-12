Return-Path: <linux-rdma+bounces-7691-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFF6A33355
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 00:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F3C188B50F
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 23:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5271020AF66;
	Wed, 12 Feb 2025 23:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gqgaaFDu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCEC1ACEA7;
	Wed, 12 Feb 2025 23:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739402779; cv=none; b=q+yMfXVRTNXo7XK3+n714Jaluxo/XQAnzIdl3Hv9cLdCDsxKLxDpV0ms8Y6Qfy7ssDTpsEFVzbnvVJuYYeVgJ/v2CwwZ049oLgKMkH7Oo81wYpGeVLEi5wo1/Xba+brP38GeKh/NpEgNhnkDjkl4S+a/9uF4Toozd75TsSBqPUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739402779; c=relaxed/simple;
	bh=9O7Gk5TrP+PUUwLBe4CMD4+9NGJOxkwZXTPoQvTD1IQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MnVl6cwh1ZBH5wYqpI/NTJEWND8xJFFkIGmHQ9QVQ59lA1pfqgXnsPP4N6xB1LziPPlnfE4TWOPZ+481l5DGoVFeUC++fz0Wow4cM+iK3k0CjteHbcFkY7NkgucvqqsYSr538jk0XZF2vGcfC2OVce8Ott0G9J68bafZJiW15jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gqgaaFDu; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739402777; x=1770938777;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9O7Gk5TrP+PUUwLBe4CMD4+9NGJOxkwZXTPoQvTD1IQ=;
  b=gqgaaFDurv1mRGJIcQP0AYwydOLSScxGsufmg7pxmwhLBZBuyoOzXE3j
   a25WKyRHg3/cW+ROfpe+IQKTL1mQF5M69C4beuWboVY6+DPbNXOOzLitN
   XuExBHYW7PI4wkgv7M2kwv2BKhkPLI+k7NMSeJ2lVW+p69SW6gi/BGQyI
   e/7OFvED8dMvHnLToObQRsSq/xsD2eS6eaGBtorwHI0eWHCPcMVyMhTDY
   Pza084gAdX7U8YYYZEGjuKrWKReoSx1MC0FmXbxyrTkrb334PCwWekDoP
   Y9tK3zfA+3PUMcMMm003sd/u1d8RNx1N1y4adayvCSI3ZDvXQYOLRQBxB
   g==;
X-CSE-ConnectionGUID: un99pE71TwiMzD0GxrV1og==
X-CSE-MsgGUID: GjqvgdR2Rp6lWc2UiBbwVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="39269620"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="39269620"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 15:26:15 -0800
X-CSE-ConnectionGUID: Msn8SwC2ROaid7HGnIyobw==
X-CSE-MsgGUID: nm1IjSVATnKpoqMLUjj8gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113453224"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.128]) ([10.125.108.128])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 15:26:13 -0800
Message-ID: <4a862ed3-0959-42f6-8ae8-cf6176ff1742@intel.com>
Date: Wed, 12 Feb 2025 16:26:12 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH fwctl 3/5] pds_fwctl: initial driver framework
To: Shannon Nelson <shannon.nelson@amd.com>, jgg@nvidia.com,
 andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
 dan.j.williams@intel.com, daniel.vetter@ffwll.ch, dsahern@kernel.org,
 gospo@broadcom.com, hch@infradead.org, itayavr@nvidia.com, jiri@nvidia.com,
 Jonathan.Cameron@huawei.com, kuba@kernel.org, lbloch@nvidia.com,
 leonro@nvidia.com, saeedm@nvidia.com, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Cc: brett.creeley@amd.com
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <20250211234854.52277-4-shannon.nelson@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211234854.52277-4-shannon.nelson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 4:48 PM, Shannon Nelson wrote:
> Initial files for adding a new fwctl driver for the AMD/Pensando PDS
> devices.  This sets up a simple auxiliary_bus driver that registers
> with fwctl subsystem.  It expects that a pds_core device has set up
> the auxiliary_device pds_core.fwctl
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  MAINTAINERS                    |   7 ++
>  drivers/fwctl/Kconfig          |  10 ++
>  drivers/fwctl/Makefile         |   1 +
>  drivers/fwctl/pds/Makefile     |   4 +
>  drivers/fwctl/pds/main.c       | 195 +++++++++++++++++++++++++++++++++
>  include/linux/pds/pds_adminq.h |  77 +++++++++++++
>  include/uapi/fwctl/fwctl.h     |   1 +
>  include/uapi/fwctl/pds.h       |  27 +++++
>  8 files changed, 322 insertions(+)
>  create mode 100644 drivers/fwctl/pds/Makefile
>  create mode 100644 drivers/fwctl/pds/main.c
>  create mode 100644 include/uapi/fwctl/pds.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 413ab79bf2f4..123f8a9c0b26 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9602,6 +9602,13 @@ T:	git git://linuxtv.org/media.git
>  F:	Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
>  F:	drivers/media/i2c/gc2145.c
>  
> +FWCTL PDS DRIVER
> +M:	Brett Creeley <brett.creeley@amd.com>
> +R:	Shannon Nelson <shannon.nelson@amd.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	drivers/fwctl/pds/
> +
>  GATEWORKS SYSTEM CONTROLLER (GSC) DRIVER
>  M:	Tim Harvey <tharvey@gateworks.com>
>  S:	Maintained
> diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
> index 0a542a247303..df87ce5bd8aa 100644
> --- a/drivers/fwctl/Kconfig
> +++ b/drivers/fwctl/Kconfig
> @@ -28,5 +28,15 @@ config FWCTL_MLX5
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
> index 5fb289243286..692e4b8d7beb 100644
> --- a/drivers/fwctl/Makefile
> +++ b/drivers/fwctl/Makefile
> @@ -2,5 +2,6 @@
>  obj-$(CONFIG_FWCTL) += fwctl.o
>  obj-$(CONFIG_FWCTL_BNXT) += bnxt/
>  obj-$(CONFIG_FWCTL_MLX5) += mlx5/
> +obj-$(CONFIG_FWCTL_PDS) += pds/
>  
>  fwctl-y += main.o
> diff --git a/drivers/fwctl/pds/Makefile b/drivers/fwctl/pds/Makefile
> new file mode 100644
> index 000000000000..c14cba128e3b
> --- /dev/null
> +++ b/drivers/fwctl/pds/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +obj-$(CONFIG_FWCTL_PDS) += pds_fwctl.o
> +
> +pds_fwctl-y += main.o
> diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
> new file mode 100644
> index 000000000000..24979fe0deea
> --- /dev/null
> +++ b/drivers/fwctl/pds/main.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
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
> +	u32 uctx_uid;
> +};
> +
> +struct pdsfc_dev {
> +	struct fwctl_device fwctl;
> +	struct pds_auxiliary_dev *padev;
> +	struct pdsc *pdsc;
> +	u32 caps;
> +	dma_addr_t ident_pa;
> +	struct pds_fwctl_ident *ident;
> +};
> +DEFINE_FREE(pdsfc_dev, struct pdsfc_dev *, if (_T) fwctl_put(&_T->fwctl));
> +
> +static int pdsfc_open_uctx(struct fwctl_uctx *uctx)
> +{
> +	struct pdsfc_dev *pdsfc = container_of(uctx->fwctl, struct pdsfc_dev, fwctl);
> +	struct pdsfc_uctx *pdsfc_uctx = container_of(uctx, struct pdsfc_uctx, uctx);
> +	struct device *dev = &uctx->fwctl->dev;
> +
> +	dev_dbg(dev, "%s: caps = 0x%04x\n", __func__, pdsfc->caps);
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
> +static void pdsfc_free_ident(struct pdsfc_dev *pdsfc)
> +{
> +	struct device *dev = &pdsfc->fwctl.dev;
> +
> +	if (pdsfc->ident) {
> +		dma_free_coherent(dev, sizeof(*pdsfc->ident),
> +				  pdsfc->ident, pdsfc->ident_pa);
> +		pdsfc->ident = NULL;
> +		pdsfc->ident_pa = DMA_MAPPING_ERROR;
> +	}
> +}
> +
> +static int pdsfc_identify(struct pdsfc_dev *pdsfc)
> +{
> +	struct device *dev = &pdsfc->fwctl.dev;
> +	union pds_core_adminq_comp comp = {0};
> +	union pds_core_adminq_cmd cmd = {0};
> +	struct pds_fwctl_ident *ident;
> +	dma_addr_t ident_pa;
> +	int err = 0;
> +
> +	ident = dma_alloc_coherent(dev->parent, sizeof(*ident), &ident_pa, GFP_KERNEL);
> +	err = dma_mapping_error(dev->parent, ident_pa);
> +	if (err) {
> +		dev_err(dev, "Failed to map ident\n");
> +		return err;
> +	}
> +
> +	cmd.fwctl_ident.opcode = PDS_FWCTL_CMD_IDENT;
> +	cmd.fwctl_ident.version = 0;
> +	cmd.fwctl_ident.len = cpu_to_le32(sizeof(*ident));
> +	cmd.fwctl_ident.ident_pa = cpu_to_le64(ident_pa);
> +
> +	err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
> +	if (err) {
> +		dma_free_coherent(dev->parent, PAGE_SIZE, ident, ident_pa);
> +		dev_err(dev, "Failed to send adminq cmd opcode: %u entity: %u err: %d\n",
> +			cmd.fwctl_query.opcode, cmd.fwctl_query.entity, err);
> +		return err;
> +	}
> +
> +	pdsfc->ident = ident;
> +	pdsfc->ident_pa = ident_pa;
> +
> +	dev_dbg(dev, "ident: version %u max_req_sz %u max_resp_sz %u max_req_sg_elems %u max_resp_sg_elems %u\n",
> +		ident->version, ident->max_req_sz, ident->max_resp_sz,
> +		ident->max_req_sg_elems, ident->max_resp_sg_elems);
> +
> +	return 0;
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
> +	struct pdsfc_dev *pdsfc __free(pdsfc_dev);
> +	struct pds_auxiliary_dev *padev;
> +	struct device *dev = &adev->dev;
> +	int err = 0;
> +
> +	padev = container_of(adev, struct pds_auxiliary_dev, aux_dev);
> +	pdsfc = fwctl_alloc_device(&padev->vf_pdev->dev, &pdsfc_ops,
> +				   struct pdsfc_dev, fwctl);

The suggested formatting of using scope-based cleanup is to just declare the variable inline as you need it rather than split the cleanup vs the allocation.

	struct pdsfc_dev *pdsfc __free(pdsfc_dev) =
			fwctl_alloc_device(...); 

> +	if (!pdsfc) {
> +		dev_err(dev, "Failed to allocate fwctl device struct\n");
> +		return -ENOMEM;
> +	}
> +	pdsfc->padev = padev;
> +
> +	err = pdsfc_identify(pdsfc);
> +	if (err) {
> +		dev_err(dev, "Failed to identify device, err %d\n", err);> +		return err;
> +	}
> +
> +	err = fwctl_register(&pdsfc->fwctl);
> +	if (err) {
> +		dev_err(dev, "Failed to register device, err %d\n", err);

Missing freeing of the 'ident' from dma_alloc_coherent. Although mixing gotos and __free() would get really messy in a hurry. I suggest you setup pdsfc_identify() like an allocation function with returning 'struct pds_fwctl_ident *' so you can utilize a custom __free() to free up the dma memory. and then you can do:
pdsfc->ident = no_free_ptr(ident);
pdsfc->ident_pa = ident_pa; /* ident_pa passed in as a ptr to pdsfc_identify() for write back */

> +		return err;
> +	}
> +
> +	auxiliary_set_drvdata(adev, no_free_ptr(pdsfc));
> +
> +	return 0;
> +
> +free_ident:

nothing goes here.

DJ

> +	pdsfc_free_ident(pdsfc);
> +	return err;
> +}
> +
> +static void pdsfc_remove(struct auxiliary_device *adev)
> +{
> +	struct pdsfc_dev *pdsfc  __free(pdsfc_dev) = auxiliary_get_drvdata(adev);
> +
> +	fwctl_unregister(&pdsfc->fwctl);
> +	pdsfc_free_ident(pdsfc);
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
> +MODULE_IMPORT_NS(FWCTL);
> +MODULE_DESCRIPTION("pds fwctl driver");
> +MODULE_AUTHOR("Shannon Nelson <shannon.nelson@amd.com>");
> +MODULE_AUTHOR("Brett Creeley <brett.creeley@amd.com>");
> +MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
> index 4b4e9a98b37b..7fc353b63353 100644
> --- a/include/linux/pds/pds_adminq.h
> +++ b/include/linux/pds/pds_adminq.h
> @@ -1179,6 +1179,78 @@ struct pds_lm_host_vf_status_cmd {
>  	u8     status;
>  };
>  
> +enum pds_fwctl_cmd_opcode {
> +	PDS_FWCTL_CMD_IDENT		= 70,
> +};
> +
> +/**
> + * struct pds_fwctl_cmd - Firmware control command structure
> + * @opcode: Opcode
> + * @rsvd:   Word boundary padding
> + * @ep:     Endpoint identifier.
> + * @op:     Operation identifier.
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
> + * @rsvd:       Word boundary padding
> + * @comp_index: Completion index in little-endian format
> + * @rsvd2:      Word boundary padding
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
> + * @rsvd:     Word boundary padding
> + * @version:  Interface version
> + * @rsvd2:    Word boundary padding
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
> +/**
> + * struct pds_fwctl_ident - Firmware control identification structure
> + * @features:    Supported features
> + * @version:     Interface version
> + * @rsvd:        Word boundary padding
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
> @@ -1216,6 +1288,9 @@ union pds_core_adminq_cmd {
>  	struct pds_lm_dirty_enable_cmd	  lm_dirty_enable;
>  	struct pds_lm_dirty_disable_cmd	  lm_dirty_disable;
>  	struct pds_lm_dirty_seq_ack_cmd	  lm_dirty_seq_ack;
> +
> +	struct pds_fwctl_cmd		  fwctl;
> +	struct pds_fwctl_ident_cmd	  fwctl_ident;
>  };
>  
>  union pds_core_adminq_comp {
> @@ -1243,6 +1318,8 @@ union pds_core_adminq_comp {
>  
>  	struct pds_lm_state_size_comp	  lm_state_size;
>  	struct pds_lm_dirty_status_comp	  lm_dirty_status;
> +
> +	struct pds_fwctl_comp		  fwctl;
>  };
>  
>  #ifndef __CHECKER__
> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> index 518f054f02d2..a884e9f6dc2c 100644
> --- a/include/uapi/fwctl/fwctl.h
> +++ b/include/uapi/fwctl/fwctl.h
> @@ -44,6 +44,7 @@ enum fwctl_device_type {
>  	FWCTL_DEVICE_TYPE_ERROR = 0,
>  	FWCTL_DEVICE_TYPE_MLX5 = 1,
>  	FWCTL_DEVICE_TYPE_BNXT = 3,
> +	FWCTL_DEVICE_TYPE_PDS = 4,
>  };
>  
>  /**
> diff --git a/include/uapi/fwctl/pds.h b/include/uapi/fwctl/pds.h
> new file mode 100644
> index 000000000000..a01b032cbdb1
> --- /dev/null
> +++ b/include/uapi/fwctl/pds.h
> @@ -0,0 +1,27 @@
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
> +struct fwctl_info_pds {
> +	__u32 uid;
> +	__u32 uctx_caps;
> +};
> +
> +enum pds_fwctl_capabilities {
> +	PDS_FWCTL_QUERY_CAP = 0,
> +	PDS_FWCTL_SEND_CAP,
> +};
> +#endif /* _UAPI_FWCTL_PDS_H_ */


