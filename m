Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CFD1CCBEA
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2020 17:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgEJPQ1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 May 2020 11:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbgEJPQ1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 10 May 2020 11:16:27 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82C7420725;
        Sun, 10 May 2020 15:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589123786;
        bh=Os2GSKZHNtCvIsE4S8qdrCB9m1A667secrvbzrNUwz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1ZMc9UjonZbIGTHVnRHMFzWrl8SSsl83SVPcYmrwBSJealQ4zK4rSi6H0KWc7jtVR
         g8L9+bN+PgaELQEUrfyLy76DKENxewf26dYOGgGG3vFp0dT3WfjbB3slkXxqrDJ3Oz
         JmnKGV4VbVTfV/AroEdoIZ+nMHL3jo+wXkfzRY14=
Date:   Sun, 10 May 2020 18:16:22 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Guy Tzalik <gtzalik@amazon.com>
Subject: Re: [PATCH for-next 2/2] RDMA/efa: Report host information to the
 device
Message-ID: <20200510151622.GD199306@unreal>
References: <20200510115918.46246-1-galpress@amazon.com>
 <20200510115918.46246-3-galpress@amazon.com>
 <20200510122949.GB199306@unreal>
 <5612e79f-76e5-7f87-8321-5114d414015e@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5612e79f-76e5-7f87-8321-5114d414015e@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 10, 2020 at 04:05:45PM +0300, Gal Pressman wrote:
> On 10/05/2020 15:29, Leon Romanovsky wrote:
> > On Sun, May 10, 2020 at 02:59:18PM +0300, Gal Pressman wrote:
> >> diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> >> index 96b104ab5415..efdeebc9ea9b 100644
> >> --- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> >> +++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> >> @@ -37,7 +37,7 @@ enum efa_admin_aq_feature_id {
> >>  	EFA_ADMIN_NETWORK_ATTR                      = 3,
> >>  	EFA_ADMIN_QUEUE_ATTR                        = 4,
> >>  	EFA_ADMIN_HW_HINTS                          = 5,
> >> -	EFA_ADMIN_FEATURES_OPCODE_NUM               = 8,
> >> +	EFA_ADMIN_HOST_INFO                         = 6,
> >>  };
> >>
> >>  /* QP transport type */
> >> @@ -799,6 +799,55 @@ struct efa_admin_mmio_req_read_less_resp {
> >>  	u32 reg_val;
> >>  };
> >>
> >> +enum efa_admin_os_type {
> >> +	EFA_ADMIN_OS_LINUX                          = 0,
> >> +	EFA_ADMIN_OS_WINDOWS                        = 1,
> >
> > Not used.
>
> That's the device interface..

It doesn't matter, we don't add code/defines that are not in use.

>
> >
> >> +};
> >> +
> >> +struct efa_admin_host_info {
> >> +	/* OS distribution string format */
> >> +	u8 os_dist_str[128];
> >> +
> >> +	/* Defined in enum efa_admin_os_type */
> >> +	u32 os_type;
> >> +
> >> +	/* Kernel version string format */
> >> +	u8 kernel_ver_str[32];
> >> +
> >> +	/* Kernel version numeric format */
> >> +	u32 kernel_ver;
> >> +
> >> +	/*
> >> +	 * 7:0 : driver_module_type
> >> +	 * 15:8 : driver_sub_minor
> >> +	 * 23:16 : driver_minor
> >> +	 * 31:24 : driver_major
> >> +	 */
> >> +	u32 driver_ver;
> >
> > No to this.
>
> Same, this is the device interface.
> And obviously it's not used as we don't have a driver version.
>
> >
> >> +
> >> +	/*
> >> +	 * Device's Bus, Device and Function
> >> +	 * 2:0 : function
> >> +	 * 7:3 : device
> >> +	 * 15:8 : bus
> >> +	 */
> >> +	u16 bdf;
> >> +
> >> +	/*
> >> +	 * Spec version
> >> +	 * 7:0 : spec_minor
> >> +	 * 15:8 : spec_major
> >> +	 */
> >> +	u16 spec_ver;
> >> +
> >> +	/*
> >> +	 * 0 : intree - Intree driver
> >> +	 * 1 : gdr - GPUDirect RDMA supported
> >> +	 * 31:2 : reserved2
> >> +	 */
> >> +	u32 flags;
> >> +};
> >> +
> >>  /* create_qp_cmd */
> >>  #define EFA_ADMIN_CREATE_QP_CMD_SQ_VIRT_MASK                BIT(0)
> >>  #define EFA_ADMIN_CREATE_QP_CMD_RQ_VIRT_MASK                BIT(1)
> >> @@ -820,4 +869,17 @@ struct efa_admin_mmio_req_read_less_resp {
> >>  /* feature_device_attr_desc */
> >>  #define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_READ_MASK   BIT(0)
> >>
> >> +/* host_info */
> >> +#define EFA_ADMIN_HOST_INFO_DRIVER_MODULE_TYPE_MASK         GENMASK(7, 0)
> >> +#define EFA_ADMIN_HOST_INFO_DRIVER_SUB_MINOR_MASK           GENMASK(15, 8)
> >> +#define EFA_ADMIN_HOST_INFO_DRIVER_MINOR_MASK               GENMASK(23, 16)
> >> +#define EFA_ADMIN_HOST_INFO_DRIVER_MAJOR_MASK               GENMASK(31, 24)
> >
> > Not in use.
>
> Same.

Same :)

>
> >
> >> +#define EFA_ADMIN_HOST_INFO_FUNCTION_MASK                   GENMASK(2, 0)
> >> +#define EFA_ADMIN_HOST_INFO_DEVICE_MASK                     GENMASK(7, 3)
> >> +#define EFA_ADMIN_HOST_INFO_BUS_MASK                        GENMASK(15, 8)
> >> +#define EFA_ADMIN_HOST_INFO_SPEC_MINOR_MASK                 GENMASK(7, 0)
> >> +#define EFA_ADMIN_HOST_INFO_SPEC_MAJOR_MASK                 GENMASK(15, 8)
> >> +#define EFA_ADMIN_HOST_INFO_INTREE_MASK                     BIT(0)
> >> +#define EFA_ADMIN_HOST_INFO_GDR_MASK                        BIT(1)
> >> +
> >>  #endif /* _EFA_ADMIN_CMDS_H_ */
> >> +static void efa_set_host_info(struct efa_dev *dev)
> >> +{
> >> +	struct efa_admin_set_feature_resp resp = {};
> >> +	struct efa_admin_set_feature_cmd cmd = {};
> >> +	struct efa_admin_host_info *hinf;
> >> +	u32 bufsz = sizeof(*hinf);
> >> +	dma_addr_t hinf_dma;
> >> +
> >> +	if (!efa_com_check_supported_feature_id(&dev->edev,
> >> +						EFA_ADMIN_HOST_INFO))
> >> +		return;
> >> +
> >> +	/* Failures in host info set shall not disturb probe */
> >> +	hinf = dma_alloc_coherent(&dev->pdev->dev, bufsz, &hinf_dma,
> >> +				  GFP_KERNEL);
> >> +	if (!hinf)
> >> +		return;
> >> +
> >> +	strlcpy(hinf->os_dist_str, utsname()->release,
> >> +		min(sizeof(hinf->os_dist_str), sizeof(utsname()->release)));
> >> +	hinf->os_type = EFA_ADMIN_OS_LINUX;
> >> +	strlcpy(hinf->kernel_ver_str, utsname()->version,
> >> +		min(sizeof(hinf->kernel_ver_str), sizeof(utsname()->version)));
> >> +	hinf->kernel_ver = LINUX_VERSION_CODE;
> >> +	EFA_SET(&hinf->bdf, EFA_ADMIN_HOST_INFO_BUS, dev->pdev->bus->number);
> >> +	EFA_SET(&hinf->bdf, EFA_ADMIN_HOST_INFO_DEVICE,
> >> +		PCI_SLOT(dev->pdev->devfn));
> >> +	EFA_SET(&hinf->bdf, EFA_ADMIN_HOST_INFO_FUNCTION,
> >> +		PCI_FUNC(dev->pdev->devfn));
> >> +	EFA_SET(&hinf->spec_ver, EFA_ADMIN_HOST_INFO_SPEC_MAJOR,
> >> +		EFA_COMMON_SPEC_VERSION_MAJOR);
> >> +	EFA_SET(&hinf->spec_ver, EFA_ADMIN_HOST_INFO_SPEC_MINOR,
> >> +		EFA_COMMON_SPEC_VERSION_MINOR);
> >> +	EFA_SET(&hinf->flags, EFA_ADMIN_HOST_INFO_INTREE, 1);
> >
> > Ohhh, so users will change this line voluntarily?
>
> Are you worried with out of tree users?

Should I? I'm not worried, but excited to see such naive debug approach.

Thanks
