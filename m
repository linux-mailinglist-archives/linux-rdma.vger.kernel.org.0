Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339082A7E64
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 13:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgKEMPu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 07:15:50 -0500
Received: from foss.arm.com ([217.140.110.172]:59086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgKEMPu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Nov 2020 07:15:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E529142F;
        Thu,  5 Nov 2020 04:15:49 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62E5D3F719;
        Thu,  5 Nov 2020 04:15:47 -0800 (PST)
Subject: Re: [PATCH 1/6] RMDA/sw: don't allow drivers using dma_virt_ops on
 highmem configs
To:     Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Zhu Yanjun <yanjunz@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>
References: <20201105074205.1690638-1-hch@lst.de>
 <20201105074205.1690638-2-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <40d0a990-0fca-6f12-16ff-3612a9847ab3@arm.com>
Date:   Thu, 5 Nov 2020 12:15:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201105074205.1690638-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-11-05 07:42, Christoph Hellwig wrote:
> dma_virt_ops requires that all pages have a kernel virtual address.
> Introduce a INFINIBAND_VIRT_DMA Kconfig symbol that depends on !HIGHMEM
> and a large enough dma_addr_t, and make all three driver depend on the
> new symbol.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/infiniband/Kconfig           | 6 ++++++
>   drivers/infiniband/sw/rdmavt/Kconfig | 3 ++-
>   drivers/infiniband/sw/rxe/Kconfig    | 2 +-
>   drivers/infiniband/sw/siw/Kconfig    | 1 +
>   4 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
> index 32a51432ec4f73..81acaf5fb5be67 100644
> --- a/drivers/infiniband/Kconfig
> +++ b/drivers/infiniband/Kconfig
> @@ -73,6 +73,12 @@ config INFINIBAND_ADDR_TRANS_CONFIGFS
>   	  This allows the user to config the default GID type that the CM
>   	  uses for each device, when initiaing new connections.
>   
> +config INFINIBAND_VIRT_DMA
> +	bool
> +	default y
> +	depends on !HIGHMEM
> +	depends on !64BIT || ARCH_DMA_ADDR_T_64BIT

Isn't that effectively always true now since 4965a68780c5? I had a quick 
try of manually overriding CONFIG_ARCH_DMA_ADDR_T_64BIT in my .config, 
and the build just forces it back to "=y".

Robin.

> +
>   if INFINIBAND_USER_ACCESS || !INFINIBAND_USER_ACCESS
>   source "drivers/infiniband/hw/mthca/Kconfig"
>   source "drivers/infiniband/hw/qib/Kconfig"
> diff --git a/drivers/infiniband/sw/rdmavt/Kconfig b/drivers/infiniband/sw/rdmavt/Kconfig
> index 9ef5f5ce1ff6b0..c8e268082952b0 100644
> --- a/drivers/infiniband/sw/rdmavt/Kconfig
> +++ b/drivers/infiniband/sw/rdmavt/Kconfig
> @@ -1,7 +1,8 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config INFINIBAND_RDMAVT
>   	tristate "RDMA verbs transport library"
> -	depends on X86_64 && ARCH_DMA_ADDR_T_64BIT
> +	depends on INFINIBAND_VIRT_DMA
> +	depends on X86_64
>   	depends on PCI
>   	select DMA_VIRT_OPS
>   	help
> diff --git a/drivers/infiniband/sw/rxe/Kconfig b/drivers/infiniband/sw/rxe/Kconfig
> index a0c6c7dfc1814f..8810bfa680495a 100644
> --- a/drivers/infiniband/sw/rxe/Kconfig
> +++ b/drivers/infiniband/sw/rxe/Kconfig
> @@ -2,7 +2,7 @@
>   config RDMA_RXE
>   	tristate "Software RDMA over Ethernet (RoCE) driver"
>   	depends on INET && PCI && INFINIBAND
> -	depends on !64BIT || ARCH_DMA_ADDR_T_64BIT
> +	depends on INFINIBAND_VIRT_DMA
>   	select NET_UDP_TUNNEL
>   	select CRYPTO_CRC32
>   	select DMA_VIRT_OPS
> diff --git a/drivers/infiniband/sw/siw/Kconfig b/drivers/infiniband/sw/siw/Kconfig
> index b622fc62f2cd6d..3450ba5081df51 100644
> --- a/drivers/infiniband/sw/siw/Kconfig
> +++ b/drivers/infiniband/sw/siw/Kconfig
> @@ -1,6 +1,7 @@
>   config RDMA_SIW
>   	tristate "Software RDMA over TCP/IP (iWARP) driver"
>   	depends on INET && INFINIBAND && LIBCRC32C
> +	depends on INFINIBAND_VIRT_DMA
>   	select DMA_VIRT_OPS
>   	help
>   	This driver implements the iWARP RDMA transport over
> 
