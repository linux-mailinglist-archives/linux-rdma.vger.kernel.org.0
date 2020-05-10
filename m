Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E2E1CCB12
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2020 14:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgEJM3y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 May 2020 08:29:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbgEJM3y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 10 May 2020 08:29:54 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3A952080C;
        Sun, 10 May 2020 12:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589113793;
        bh=/Lh4ZDkMvLiJqGDFTcL6sRpj82y/ZDfX3FE6SwbZWho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iMcg8ArYY/skp35CEQVkMaKQ+zT+hWNgUGqpQf484kzTFfjmSrhTelUuKv400uCsW
         LpSENeEk6xoI245ZgzsIZhLqDtzkQQNjWQ+I8tKPlFZEE3wQdaWQt3d3q8WZcn7z/t
         khN0FvV8he9Thcut3MWyPwk+9t7rphWqJcrfNoI8=
Date:   Sun, 10 May 2020 15:29:49 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Guy Tzalik <gtzalik@amazon.com>
Subject: Re: [PATCH for-next 2/2] RDMA/efa: Report host information to the
 device
Message-ID: <20200510122949.GB199306@unreal>
References: <20200510115918.46246-1-galpress@amazon.com>
 <20200510115918.46246-3-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510115918.46246-3-galpress@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 10, 2020 at 02:59:18PM +0300, Gal Pressman wrote:
> The host info feature allows the driver to infrom the EFA device
> firmware with system configuration for debugging and troubleshooting
> purposes.
>
> The host info buffer is passed as an admin command DMA mapped control
> buffer, and is unmapped and freed once the command CQE is consumed.
>
> Currently, the setting of host info is done for each device on its
> probe. Failing to set the host info for the device shall not disturb the
> probe flow, any errors will be discarded.
>
> Reviewed-by: Firas JahJah <firasj@amazon.com>
> Reviewed-by: Guy Tzalik <gtzalik@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 64 ++++++++++++++++++-
>  drivers/infiniband/hw/efa/efa_com_cmd.c       | 14 ++--
>  drivers/infiniband/hw/efa/efa_com_cmd.h       | 11 +++-
>  drivers/infiniband/hw/efa/efa_main.c          | 46 ++++++++++++-
>  4 files changed, 125 insertions(+), 10 deletions(-)

I'm aware that you took the code from ENA which already has this logic
and it makes me sad to think about how much private data is leaked from
my personal VM in Amazon cloud to other parties.

>
> diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> index 96b104ab5415..efdeebc9ea9b 100644
> --- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> +++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> @@ -37,7 +37,7 @@ enum efa_admin_aq_feature_id {
>  	EFA_ADMIN_NETWORK_ATTR                      = 3,
>  	EFA_ADMIN_QUEUE_ATTR                        = 4,
>  	EFA_ADMIN_HW_HINTS                          = 5,
> -	EFA_ADMIN_FEATURES_OPCODE_NUM               = 8,
> +	EFA_ADMIN_HOST_INFO                         = 6,
>  };
>
>  /* QP transport type */
> @@ -799,6 +799,55 @@ struct efa_admin_mmio_req_read_less_resp {
>  	u32 reg_val;
>  };
>
> +enum efa_admin_os_type {
> +	EFA_ADMIN_OS_LINUX                          = 0,
> +	EFA_ADMIN_OS_WINDOWS                        = 1,

Not used.

> +};
> +
> +struct efa_admin_host_info {
> +	/* OS distribution string format */
> +	u8 os_dist_str[128];
> +
> +	/* Defined in enum efa_admin_os_type */
> +	u32 os_type;
> +
> +	/* Kernel version string format */
> +	u8 kernel_ver_str[32];
> +
> +	/* Kernel version numeric format */
> +	u32 kernel_ver;
> +
> +	/*
> +	 * 7:0 : driver_module_type
> +	 * 15:8 : driver_sub_minor
> +	 * 23:16 : driver_minor
> +	 * 31:24 : driver_major
> +	 */
> +	u32 driver_ver;

No to this.

> +
> +	/*
> +	 * Device's Bus, Device and Function
> +	 * 2:0 : function
> +	 * 7:3 : device
> +	 * 15:8 : bus
> +	 */
> +	u16 bdf;
> +
> +	/*
> +	 * Spec version
> +	 * 7:0 : spec_minor
> +	 * 15:8 : spec_major
> +	 */
> +	u16 spec_ver;
> +
> +	/*
> +	 * 0 : intree - Intree driver
> +	 * 1 : gdr - GPUDirect RDMA supported
> +	 * 31:2 : reserved2
> +	 */
> +	u32 flags;
> +};
> +
>  /* create_qp_cmd */
>  #define EFA_ADMIN_CREATE_QP_CMD_SQ_VIRT_MASK                BIT(0)
>  #define EFA_ADMIN_CREATE_QP_CMD_RQ_VIRT_MASK                BIT(1)
> @@ -820,4 +869,17 @@ struct efa_admin_mmio_req_read_less_resp {
>  /* feature_device_attr_desc */
>  #define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_READ_MASK   BIT(0)
>
> +/* host_info */
> +#define EFA_ADMIN_HOST_INFO_DRIVER_MODULE_TYPE_MASK         GENMASK(7, 0)
> +#define EFA_ADMIN_HOST_INFO_DRIVER_SUB_MINOR_MASK           GENMASK(15, 8)
> +#define EFA_ADMIN_HOST_INFO_DRIVER_MINOR_MASK               GENMASK(23, 16)
> +#define EFA_ADMIN_HOST_INFO_DRIVER_MAJOR_MASK               GENMASK(31, 24)

Not in use.

> +#define EFA_ADMIN_HOST_INFO_FUNCTION_MASK                   GENMASK(2, 0)
> +#define EFA_ADMIN_HOST_INFO_DEVICE_MASK                     GENMASK(7, 3)
> +#define EFA_ADMIN_HOST_INFO_BUS_MASK                        GENMASK(15, 8)
> +#define EFA_ADMIN_HOST_INFO_SPEC_MINOR_MASK                 GENMASK(7, 0)
> +#define EFA_ADMIN_HOST_INFO_SPEC_MAJOR_MASK                 GENMASK(15, 8)
> +#define EFA_ADMIN_HOST_INFO_INTREE_MASK                     BIT(0)
> +#define EFA_ADMIN_HOST_INFO_GDR_MASK                        BIT(1)
> +
>  #endif /* _EFA_ADMIN_CMDS_H_ */
> diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
> index 69f842c92ff6..fabd8df2e78f 100644
> --- a/drivers/infiniband/hw/efa/efa_com_cmd.c
> +++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
> @@ -351,7 +351,7 @@ int efa_com_destroy_ah(struct efa_com_dev *edev,
>  	return 0;
>  }
>
> -static bool
> +bool
>  efa_com_check_supported_feature_id(struct efa_com_dev *edev,
>  				   enum efa_admin_aq_feature_id feature_id)
>  {
> @@ -517,12 +517,12 @@ int efa_com_get_hw_hints(struct efa_com_dev *edev,
>  	return 0;
>  }
>
> -static int efa_com_set_feature_ex(struct efa_com_dev *edev,
> -				  struct efa_admin_set_feature_resp *set_resp,
> -				  struct efa_admin_set_feature_cmd *set_cmd,
> -				  enum efa_admin_aq_feature_id feature_id,
> -				  dma_addr_t control_buf_dma_addr,
> -				  u32 control_buff_size)
> +int efa_com_set_feature_ex(struct efa_com_dev *edev,
> +			   struct efa_admin_set_feature_resp *set_resp,
> +			   struct efa_admin_set_feature_cmd *set_cmd,
> +			   enum efa_admin_aq_feature_id feature_id,
> +			   dma_addr_t control_buf_dma_addr,
> +			   u32 control_buff_size)
>  {
>  	struct efa_com_admin_queue *aq;
>  	int err;
> diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
> index 31db5a0cbd5b..41ce4a476ee6 100644
> --- a/drivers/infiniband/hw/efa/efa_com_cmd.h
> +++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
>  /*
> - * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
> + * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
>   */
>
>  #ifndef _EFA_COM_CMD_H_
> @@ -270,6 +270,15 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
>  			    struct efa_com_get_device_attr_result *result);
>  int efa_com_get_hw_hints(struct efa_com_dev *edev,
>  			 struct efa_com_get_hw_hints_result *result);
> +bool
> +efa_com_check_supported_feature_id(struct efa_com_dev *edev,
> +				   enum efa_admin_aq_feature_id feature_id);
> +int efa_com_set_feature_ex(struct efa_com_dev *edev,
> +			   struct efa_admin_set_feature_resp *set_resp,
> +			   struct efa_admin_set_feature_cmd *set_cmd,
> +			   enum efa_admin_aq_feature_id feature_id,
> +			   dma_addr_t control_buf_dma_addr,
> +			   u32 control_buff_size);
>  int efa_com_set_aenq_config(struct efa_com_dev *edev, u32 groups);
>  int efa_com_alloc_pd(struct efa_com_dev *edev,
>  		     struct efa_com_alloc_pd_result *result);
> diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
> index faf3ff1bca2a..f5ef7262683d 100644
> --- a/drivers/infiniband/hw/efa/efa_main.c
> +++ b/drivers/infiniband/hw/efa/efa_main.c
> @@ -1,10 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>  /*
> - * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
> + * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
>   */
>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/utsname.h>
>
>  #include <rdma/ib_user_verbs.h>
>
> @@ -187,6 +188,47 @@ static void efa_stats_init(struct efa_dev *dev)
>  		atomic64_set(s, 0);
>  }
>
> +static void efa_set_host_info(struct efa_dev *dev)
> +{
> +	struct efa_admin_set_feature_resp resp = {};
> +	struct efa_admin_set_feature_cmd cmd = {};
> +	struct efa_admin_host_info *hinf;
> +	u32 bufsz = sizeof(*hinf);
> +	dma_addr_t hinf_dma;
> +
> +	if (!efa_com_check_supported_feature_id(&dev->edev,
> +						EFA_ADMIN_HOST_INFO))
> +		return;
> +
> +	/* Failures in host info set shall not disturb probe */
> +	hinf = dma_alloc_coherent(&dev->pdev->dev, bufsz, &hinf_dma,
> +				  GFP_KERNEL);
> +	if (!hinf)
> +		return;
> +
> +	strlcpy(hinf->os_dist_str, utsname()->release,
> +		min(sizeof(hinf->os_dist_str), sizeof(utsname()->release)));
> +	hinf->os_type = EFA_ADMIN_OS_LINUX;
> +	strlcpy(hinf->kernel_ver_str, utsname()->version,
> +		min(sizeof(hinf->kernel_ver_str), sizeof(utsname()->version)));
> +	hinf->kernel_ver = LINUX_VERSION_CODE;
> +	EFA_SET(&hinf->bdf, EFA_ADMIN_HOST_INFO_BUS, dev->pdev->bus->number);
> +	EFA_SET(&hinf->bdf, EFA_ADMIN_HOST_INFO_DEVICE,
> +		PCI_SLOT(dev->pdev->devfn));
> +	EFA_SET(&hinf->bdf, EFA_ADMIN_HOST_INFO_FUNCTION,
> +		PCI_FUNC(dev->pdev->devfn));
> +	EFA_SET(&hinf->spec_ver, EFA_ADMIN_HOST_INFO_SPEC_MAJOR,
> +		EFA_COMMON_SPEC_VERSION_MAJOR);
> +	EFA_SET(&hinf->spec_ver, EFA_ADMIN_HOST_INFO_SPEC_MINOR,
> +		EFA_COMMON_SPEC_VERSION_MINOR);
> +	EFA_SET(&hinf->flags, EFA_ADMIN_HOST_INFO_INTREE, 1);

Ohhh, so users will change this line voluntarily?

Thanks
