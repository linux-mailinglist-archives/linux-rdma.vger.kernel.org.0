Return-Path: <linux-rdma+bounces-8263-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75253A4CA7C
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 18:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A052E3A6CED
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 17:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB421F2369;
	Mon,  3 Mar 2025 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDB/HNyu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5F28489;
	Mon,  3 Mar 2025 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024020; cv=none; b=RHrJwp2n/IjCUCPEPjhP70jEaHoJ6XY8Iysp4ECC52sIa4pnZIJm2zvVksJ0FqsaQk9F0QoCeo14xQaed9CTaaf2j0CIhg3G2v2+ANAi5NvXxuteX1y906oYkqxQD8bYf+Ns0sdzb+VpIIzPaZQOqae+q6Qh3f1pgq7dMBAWtTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024020; c=relaxed/simple;
	bh=Hbpa0SvCOuZehDK3B564zw859E/B8GVZsJLcDMx7Lgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=apVLbtEW7Br4BJ1uMyaABST1HbMWQ+s06lwtShyX/k1UZBp1hChI9KYoCArVmKnX5/J/+Cdbvc9gxlqkzx3obVGZEdmBCZZ+V7+cNBL59PKl+2/rPXpAtXVSmrMuTpFiml7GFbrCISuTeJz7sLHlbEe0RkNiS9+yhidZf9hqcbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WDB/HNyu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741024018; x=1772560018;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hbpa0SvCOuZehDK3B564zw859E/B8GVZsJLcDMx7Lgk=;
  b=WDB/HNyuxvBS9V02lHkKTw6Tc3f4/jpnMfha7wyFAhWcqv8K2g657ssY
   fuwZmJRlzG9h+TSBzqWDQauCKy9pKxq5FNfv6/9Xc9qIX6dgdMOe/fZDg
   rNrIIzRnjC/c2MScF+fu2tO6KzD0oKbwldtOOlURWkpXIsPCcbW3qj9JG
   yI+VADP1luT6Enpc5WlwTCVjZyuI8vshqPbAMO6ntE2tAYRE0/gEcs6FH
   WCt+U1UxHG2H6zKbX/8VsYzj7i2BXkjBuyvFjZ7iH0viGthHHOXCER1p/
   usyI/SvnSlEGnRXQu2hidNKbdDV2HyhYtDwcAdBLZyEpPZB7tmroA6MMQ
   A==;
X-CSE-ConnectionGUID: Mal5KlU1TlWoGyMSTXBevg==
X-CSE-MsgGUID: 3QUEqmrgSCyp3dXGSq40AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="45837852"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="45837852"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 09:46:57 -0800
X-CSE-ConnectionGUID: ecC5lZ+YQJGAQkgGuOxYsQ==
X-CSE-MsgGUID: jlYGq1+6SKOFlPdLrHaX2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118649468"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.109.29]) ([10.125.109.29])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 09:46:55 -0800
Message-ID: <b07342ea-2dd6-41ed-a2d2-d29c9e17b40f@intel.com>
Date: Mon, 3 Mar 2025 10:46:54 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] pds_fwctl: initial driver framework
To: "Nelson, Shannon" <shannon.nelson@amd.com>, jgg@nvidia.com,
 andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
 dan.j.williams@intel.com, daniel.vetter@ffwll.ch, dsahern@kernel.org,
 gregkh@linuxfoundation.org, hch@infradead.org, itayavr@nvidia.com,
 jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
 lbloch@nvidia.com, leonro@nvidia.com, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, saeedm@nvidia.com
Cc: brett.creeley@amd.com
References: <20250301013554.49511-1-shannon.nelson@amd.com>
 <20250301013554.49511-5-shannon.nelson@amd.com>
 <01e4b8ad-82dd-43ac-92b9-3b3a030f86bc@intel.com>
 <3a77a28e-6d66-4315-90c5-d6802c256700@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <3a77a28e-6d66-4315-90c5-d6802c256700@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/3/25 10:31 AM, Nelson, Shannon wrote:
> On 3/3/2025 8:45 AM, Dave Jiang wrote:
>>
>> On 2/28/25 6:35 PM, Shannon Nelson wrote:
>>> Initial files for adding a new fwctl driver for the AMD/Pensando PDS
>>> devices.  This sets up a simple auxiliary_bus driver that registers
>>> with fwctl subsystem.  It expects that a pds_core device has set up
>>> the auxiliary_device pds_core.fwctl
>>>
>>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>>> ---
>>>   MAINTAINERS                    |   7 ++
>>>   drivers/fwctl/Kconfig          |  10 ++
>>>   drivers/fwctl/Makefile         |   1 +
>>>   drivers/fwctl/pds/Makefile     |   4 +
>>>   drivers/fwctl/pds/main.c       | 169 +++++++++++++++++++++++++++++++++
>>>   include/linux/pds/pds_adminq.h |  77 +++++++++++++++
>>>   include/uapi/fwctl/fwctl.h     |   1 +
>>>   include/uapi/fwctl/pds.h       |  27 ++++++
>>>   8 files changed, 296 insertions(+)
>>>   create mode 100644 drivers/fwctl/pds/Makefile
>>>   create mode 100644 drivers/fwctl/pds/main.c
>>>   create mode 100644 include/uapi/fwctl/pds.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 7d2700d1ba0f..a396726feb6f 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -9601,6 +9601,13 @@ T:     git git://linuxtv.org/media.git
>>>   F:   Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
>>>   F:   drivers/media/i2c/gc2145.c
>>>
>>> +FWCTL PDS DRIVER
>>> +M:   Brett Creeley <brett.creeley@amd.com>
>>> +R:   Shannon Nelson <shannon.nelson@amd.com>
>>> +L:   linux-kernel@vger.kernel.org
>>> +S:   Maintained
>>> +F:   drivers/fwctl/pds/
>>> +
>>>   GATEWORKS SYSTEM CONTROLLER (GSC) DRIVER
>>>   M:   Tim Harvey <tharvey@gateworks.com>
>>>   S:   Maintained
>>> diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
>>> index 0a542a247303..df87ce5bd8aa 100644
>>> --- a/drivers/fwctl/Kconfig
>>> +++ b/drivers/fwctl/Kconfig
>>> @@ -28,5 +28,15 @@ config FWCTL_MLX5
>>>          This will allow configuration and debug tools to work out of the box on
>>>          mainstream kernel.
>>>
>>> +       If you don't know what to do here, say N.
>>> +
>>> +config FWCTL_PDS
>>> +     tristate "AMD/Pensando pds fwctl driver"
>>> +     depends on PDS_CORE
>>> +     help
>>> +       The pds_fwctl driver provides an fwctl interface for a user process
>>> +       to access the debug and configuration information of the AMD/Pensando
>>> +       DSC hardware family.
>>> +
>>>          If you don't know what to do here, say N.
>>>   endif
>>> diff --git a/drivers/fwctl/Makefile b/drivers/fwctl/Makefile
>>> index 5fb289243286..692e4b8d7beb 100644
>>> --- a/drivers/fwctl/Makefile
>>> +++ b/drivers/fwctl/Makefile
>>> @@ -2,4 +2,5 @@
>>>   obj-$(CONFIG_FWCTL) += fwctl.o
>>>   obj-$(CONFIG_FWCTL_MLX5) += mlx5/
>>> +obj-$(CONFIG_FWCTL_PDS) += pds/
>>>
>>>   fwctl-y += main.o
>>> diff --git a/drivers/fwctl/pds/Makefile b/drivers/fwctl/pds/Makefile
>>> new file mode 100644
>>> index 000000000000..c14cba128e3b
>>> --- /dev/null
>>> +++ b/drivers/fwctl/pds/Makefile
>>> @@ -0,0 +1,4 @@
>>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>>> +obj-$(CONFIG_FWCTL_PDS) += pds_fwctl.o
>>> +
>>> +pds_fwctl-y += main.o
>>> diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
>>> new file mode 100644
>>> index 000000000000..afc7dc283ad5
>>> --- /dev/null
>>> +++ b/drivers/fwctl/pds/main.c
>>> @@ -0,0 +1,169 @@
>>> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>>> +/* Copyright(c) Advanced Micro Devices, Inc */
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/auxiliary_bus.h>
>>> +#include <linux/pci.h>
>>> +#include <linux/vmalloc.h>
>>> +
>>> +#include <uapi/fwctl/fwctl.h>
>>> +#include <uapi/fwctl/pds.h>
>>> +#include <linux/fwctl.h>
>>> +
>>> +#include <linux/pds/pds_common.h>
>>> +#include <linux/pds/pds_core_if.h>
>>> +#include <linux/pds/pds_adminq.h>
>>> +#include <linux/pds/pds_auxbus.h>
>>> +
>>> +struct pdsfc_uctx {
>>> +     struct fwctl_uctx uctx;
>>> +     u32 uctx_caps;
>>> +     u32 uctx_uid;
>>> +};
>>> +
>>> +struct pdsfc_dev {
>>> +     struct fwctl_device fwctl;
>>> +     struct pds_auxiliary_dev *padev;
>>> +     struct pdsc *pdsc;
>>> +     u32 caps;
>>> +     struct pds_fwctl_ident ident;
>>> +};
>>> +DEFINE_FREE(pdsfc_dev, struct pdsfc_dev *, if (_T) fwctl_put(&_T->fwctl));
>>> +
>>> +static int pdsfc_open_uctx(struct fwctl_uctx *uctx)
>>> +{
>>> +     struct pdsfc_dev *pdsfc = container_of(uctx->fwctl, struct pdsfc_dev, fwctl);
>>> +     struct pdsfc_uctx *pdsfc_uctx = container_of(uctx, struct pdsfc_uctx, uctx);
>>> +
>>> +     pdsfc_uctx->uctx_caps = pdsfc->caps;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static void pdsfc_close_uctx(struct fwctl_uctx *uctx)
>>> +{
>>> +}
>>> +
>>> +static void *pdsfc_info(struct fwctl_uctx *uctx, size_t *length)
>>> +{
>>> +     struct pdsfc_uctx *pdsfc_uctx = container_of(uctx, struct pdsfc_uctx, uctx);
>>> +     struct fwctl_info_pds *info;
>>> +
>>> +     info = kzalloc(sizeof(*info), GFP_KERNEL);
>>> +     if (!info)
>>> +             return ERR_PTR(-ENOMEM);
>>> +
>>> +     info->uctx_caps = pdsfc_uctx->uctx_caps;
>>> +
>>> +     return info;
>>> +}
>>> +
>>> +static int pdsfc_identify(struct pdsfc_dev *pdsfc)
>>> +{
>>> +     struct device *dev = &pdsfc->fwctl.dev;
>>> +     union pds_core_adminq_comp comp = {0};
>>> +     union pds_core_adminq_cmd cmd;
>>> +     struct pds_fwctl_ident *ident;
>>> +     dma_addr_t ident_pa;
>>> +     int err = 0;
>>> +
>>> +     ident = dma_alloc_coherent(dev->parent, sizeof(*ident), &ident_pa, GFP_KERNEL);
>>> +     err = dma_mapping_error(dev->parent, ident_pa);
>>> +     if (err) {
>>> +             dev_err(dev, "Failed to map ident buffer\n");
>>> +             return err;
>>> +     }
>>> +
>>> +     cmd = (union pds_core_adminq_cmd) {
>>> +             .fwctl_ident = {
>>> +                     .opcode = PDS_FWCTL_CMD_IDENT,
>>> +                     .version = 0,
>>> +                     .len = cpu_to_le32(sizeof(*ident)),
>>> +                     .ident_pa = cpu_to_le64(ident_pa),
>>> +             }
>>> +     };
>>> +
>>> +     err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
>>> +     if (err)
>>> +             dev_err(dev, "Failed to send adminq cmd opcode: %u err: %d\n",
>>> +                     cmd.fwctl_ident.opcode, err);
>>> +     else
>>> +             pdsfc->ident = *ident;
>>> +
>>> +     dma_free_coherent(dev->parent, sizeof(*ident), ident, ident_pa);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>>> +                       void *in, size_t in_len, size_t *out_len)
>>> +{
>>> +     return NULL;
>>> +}
>>> +
>>> +static const struct fwctl_ops pdsfc_ops = {
>>> +     .device_type = FWCTL_DEVICE_TYPE_PDS,
>>> +     .uctx_size = sizeof(struct pdsfc_uctx),
>>> +     .open_uctx = pdsfc_open_uctx,
>>> +     .close_uctx = pdsfc_close_uctx,
>>> +     .info = pdsfc_info,
>>> +     .fw_rpc = pdsfc_fw_rpc,
>>> +};
>>> +
>>> +static int pdsfc_probe(struct auxiliary_device *adev,
>>> +                    const struct auxiliary_device_id *id)
>>> +{
>>> +     struct pds_auxiliary_dev *padev =
>>> +                     container_of(adev, struct pds_auxiliary_dev, aux_dev);
>>> +     struct pdsfc_dev *pdsfc __free(pdsfc_dev) =
>>> +                     fwctl_alloc_device(&padev->vf_pdev->dev, &pdsfc_ops,
>>> +                                        struct pdsfc_dev, fwctl);
>>> +     struct device *dev = &adev->dev;
>>> +     int err;
>>> +
>>
>> It's ok to move the pdsfc declaration inline right before this check below. That would help prevent any accidental usages of pdsfc before the check. This is an exception to the coding style guidelines with the introduction of cleanup mechanisms.
> 
> 
> 
> 
>>> +     if (!pdsfc) {
>>> +             dev_err(dev, "Failed to allocate fwctl device struct\n");
>>> +             return -ENOMEM;
>>> +     }
>>> +     pdsfc->padev = padev;
>>> +
>>> +     err = pdsfc_identify(pdsfc);
>>> +     if (err)
>>> +             return dev_err_probe(dev, err, "Failed to identify device\n");
>>> +
>>> +     err = fwctl_register(&pdsfc->fwctl);
>>> +     if (err)
>>> +             return dev_err_probe(dev, err, "Failed to register device\n");
>>> +
>>> +     auxiliary_set_drvdata(adev, no_free_ptr(pdsfc));
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static void pdsfc_remove(struct auxiliary_device *adev)
>>> +{
>>> +     struct pdsfc_dev *pdsfc __free(pdsfc_dev) = auxiliary_get_drvdata(adev);
>>> +
>>> +     fwctl_unregister(&pdsfc->fwctl);
>>
>> Missing fwctl_put(). See fwctl_unregister() header comments. Caller must still call fwctl_put() to free the fwctl after calling fwctl_unregister().
> 
> Is this not covered by the pdsfc_dev cleanup we defined earlier?

Yup. I missed the __free(). Sorry about the noise. 

> sln
> 
>>
>> DJ
>>
>>> +}
>>> +
>>> +static const struct auxiliary_device_id pdsfc_id_table[] = {
>>> +     {.name = PDS_CORE_DRV_NAME "." PDS_DEV_TYPE_FWCTL_STR },
>>> +     {}
>>> +};
>>> +MODULE_DEVICE_TABLE(auxiliary, pdsfc_id_table);
>>> +
>>> +static struct auxiliary_driver pdsfc_driver = {
>>> +     .name = "pds_fwctl",
>>> +     .probe = pdsfc_probe,
>>> +     .remove = pdsfc_remove,
>>> +     .id_table = pdsfc_id_table,
>>> +};
>>> +
>>> +module_auxiliary_driver(pdsfc_driver);
>>> +
>>> +MODULE_IMPORT_NS("FWCTL");
>>> +MODULE_DESCRIPTION("pds fwctl driver");
>>> +MODULE_AUTHOR("Shannon Nelson <shannon.nelson@amd.com>");
>>> +MODULE_AUTHOR("Brett Creeley <brett.creeley@amd.com>");
>>> +MODULE_LICENSE("Dual BSD/GPL");
>>> diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
>>> index 4b4e9a98b37b..ae6886ebc841 100644
>>> --- a/include/linux/pds/pds_adminq.h
>>> +++ b/include/linux/pds/pds_adminq.h
>>> @@ -1179,6 +1179,78 @@ struct pds_lm_host_vf_status_cmd {
>>>        u8     status;
>>>   };
>>>
>>> +enum pds_fwctl_cmd_opcode {
>>> +     PDS_FWCTL_CMD_IDENT = 70,
>>> +};
>>> +
>>> +/**
>>> + * struct pds_fwctl_cmd - Firmware control command structure
>>> + * @opcode: Opcode
>>> + * @rsvd:   Word boundary padding
>>> + * @ep:     Endpoint identifier.
>>> + * @op:     Operation identifier.
>>> + */
>>> +struct pds_fwctl_cmd {
>>> +     u8     opcode;
>>> +     u8     rsvd[3];
>>> +     __le32 ep;
>>> +     __le32 op;
>>> +} __packed;
>>> +
>>> +/**
>>> + * struct pds_fwctl_comp - Firmware control completion structure
>>> + * @status:     Status of the firmware control operation
>>> + * @rsvd:       Word boundary padding
>>> + * @comp_index: Completion index in little-endian format
>>> + * @rsvd2:      Word boundary padding
>>> + * @color:      Color bit indicating the state of the completion
>>> + */
>>> +struct pds_fwctl_comp {
>>> +     u8     status;
>>> +     u8     rsvd;
>>> +     __le16 comp_index;
>>> +     u8     rsvd2[11];
>>> +     u8     color;
>>> +} __packed;
>>> +
>>> +/**
>>> + * struct pds_fwctl_ident_cmd - Firmware control identification command structure
>>> + * @opcode:   Operation code for the command
>>> + * @rsvd:     Word boundary padding
>>> + * @version:  Interface version
>>> + * @rsvd2:    Word boundary padding
>>> + * @len:      Length of the identification data
>>> + * @ident_pa: Physical address of the identification data
>>> + */
>>> +struct pds_fwctl_ident_cmd {
>>> +     u8     opcode;
>>> +     u8     rsvd;
>>> +     u8     version;
>>> +     u8     rsvd2;
>>> +     __le32 len;
>>> +     __le64 ident_pa;
>>> +} __packed;
>>> +
>>> +/**
>>> + * struct pds_fwctl_ident - Firmware control identification structure
>>> + * @features:    Supported features
>>> + * @version:     Interface version
>>> + * @rsvd:        Word boundary padding
>>> + * @max_req_sz:  Maximum request size
>>> + * @max_resp_sz: Maximum response size
>>> + * @max_req_sg_elems:  Maximum number of request SGs
>>> + * @max_resp_sg_elems: Maximum number of response SGs
>>> + */
>>> +struct pds_fwctl_ident {
>>> +     __le64 features;
>>> +     u8     version;
>>> +     u8     rsvd[3];
>>> +     __le32 max_req_sz;
>>> +     __le32 max_resp_sz;
>>> +     u8     max_req_sg_elems;
>>> +     u8     max_resp_sg_elems;
>>> +} __packed;
>>> +
>>>   union pds_core_adminq_cmd {
>>>        u8     opcode;
>>>        u8     bytes[64];
>>> @@ -1216,6 +1288,9 @@ union pds_core_adminq_cmd {
>>>        struct pds_lm_dirty_enable_cmd    lm_dirty_enable;
>>>        struct pds_lm_dirty_disable_cmd   lm_dirty_disable;
>>>        struct pds_lm_dirty_seq_ack_cmd   lm_dirty_seq_ack;
>>> +
>>> +     struct pds_fwctl_cmd              fwctl;
>>> +     struct pds_fwctl_ident_cmd        fwctl_ident;
>>>   };
>>>
>>>   union pds_core_adminq_comp {
>>> @@ -1243,6 +1318,8 @@ union pds_core_adminq_comp {
>>>
>>>        struct pds_lm_state_size_comp     lm_state_size;
>>>        struct pds_lm_dirty_status_comp   lm_dirty_status;
>>> +
>>> +     struct pds_fwctl_comp             fwctl;
>>>   };
>>>
>>>   #ifndef __CHECKER__
>>> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
>>> index 518f054f02d2..a884e9f6dc2c 100644
>>> --- a/include/uapi/fwctl/fwctl.h
>>> +++ b/include/uapi/fwctl/fwctl.h
>>> @@ -44,5 +44,6 @@ enum fwctl_device_type {
>>>        FWCTL_DEVICE_TYPE_ERROR = 0,
>>>        FWCTL_DEVICE_TYPE_MLX5 = 1,
>>> +     FWCTL_DEVICE_TYPE_PDS = 4,
>>>   };
>>>
>>>   /**
>>> diff --git a/include/uapi/fwctl/pds.h b/include/uapi/fwctl/pds.h
>>> new file mode 100644
>>> index 000000000000..a01b032cbdb1
>>> --- /dev/null
>>> +++ b/include/uapi/fwctl/pds.h
>>> @@ -0,0 +1,27 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>>> +/* Copyright(c) Advanced Micro Devices, Inc */
>>> +
>>> +/*
>>> + * fwctl interface info for pds_fwctl
>>> + */
>>> +
>>> +#ifndef _UAPI_FWCTL_PDS_H_
>>> +#define _UAPI_FWCTL_PDS_H_
>>> +
>>> +#include <linux/types.h>
>>> +
>>> +/*
>>> + * struct fwctl_info_pds
>>> + *
>>> + * Return basic information about the FW interface available.
>>> + */
>>> +struct fwctl_info_pds {
>>> +     __u32 uid;
>>> +     __u32 uctx_caps;
>>> +};
>>> +
>>> +enum pds_fwctl_capabilities {
>>> +     PDS_FWCTL_QUERY_CAP = 0,
>>> +     PDS_FWCTL_SEND_CAP,
>>> +};
>>> +#endif /* _UAPI_FWCTL_PDS_H_ */
>>
> 


