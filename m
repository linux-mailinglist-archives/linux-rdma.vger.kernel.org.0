Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EEE7745C7
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Aug 2023 20:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjHHSqQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Aug 2023 14:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjHHSpv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Aug 2023 14:45:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC5C114C80;
        Tue,  8 Aug 2023 09:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691513262; x=1723049262;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZGQhFZrF5RIdE2djNSnL4b7aQ9MR+Cp9ivABVtqJuY4=;
  b=YSq3jPRWQzJqTajAFSNohNGdpaHmHf+fl8G90GJq4VKrEK9gMn87aP0P
   SDJaaC6JX2YfGaTVlXKtYEHgrD1AyuIUpqN9sg5S+NzAtyUUAZktM1gRc
   l2HIim+P2EU8x9EZguYA5HElD+zOaeQ3etv0pEIt2ysZPd5BDyylafGtX
   iLEwYTlPWqlZkx4Berh+wO6Ow9/hRB7ZyKOZZ9KvfYkZlqAeDOsLUJjIL
   xQGAU2V1eF+AMEm59oZgoIAvertq9s3lQoHp4kuTvqcxOXiYsnfe0roLQ
   zmgccg/YhJHYGcBNosUaoGEDYCLDMCkgWy5V/LVrQJxdnqJ0HjsSEqOI/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="369780472"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="369780472"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 09:47:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="734628378"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="734628378"
Received: from mtofeni-mobl.ger.corp.intel.com ([10.252.48.21])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 09:47:10 -0700
Date:   Tue, 8 Aug 2023 19:47:08 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Export pci_parent_bus_reset() for drivers to
 use
In-Reply-To: <alpine.DEB.2.21.2306200231020.14084@angie.orcam.me.uk>
Message-ID: <6ddfb7a-2a83-cb84-ad73-9bd985652858@linux.intel.com>
References: <alpine.DEB.2.21.2306200153110.14084@angie.orcam.me.uk> <alpine.DEB.2.21.2306200231020.14084@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 20 Jun 2023, Maciej W. Rozycki wrote:

> Export pci_parent_bus_reset() so that drivers do not duplicate it.  
> Document the interface.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
>  drivers/pci/pci.c   |   15 ++++++++++++++-
>  include/linux/pci.h |    1 +
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> linux-pci-parent-bus-reset-export.diff
> Index: linux-macro/drivers/pci/pci.c
> ===================================================================
> --- linux-macro.orig/drivers/pci/pci.c
> +++ linux-macro/drivers/pci/pci.c
> @@ -5149,7 +5149,19 @@ int pci_bridge_secondary_bus_reset(struc
>  }
>  EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
>  
> -static int pci_parent_bus_reset(struct pci_dev *dev, bool probe)
> +/**
> + * pci_parent_bus_reset - Reset a device via its upstream PCI bridge
> + * @dev: Device to reset.
> + * @probe: Only check if reset is possible if TRUE, actually reset if FALSE.
> + *
> + * Perform a device reset by requesting a secondary bus reset via the
> + * device's immediate upstream PCI bridge.

>  Return 0 if successful or

Kernel doc has Return: section for return values.

> + * -ENOTTY if the reset failed or it could not have been issued in the
> + * first place because the device is not on a secondary bus of any PCI
> + * bridge or it wouldn't be the only device reset.  If probing, then
> + * only verify whether it would be possible to issue a reset.

I guess most of the in-depth explanation about reasons why reset 
might not me issuable could go into the longer description block.

-- 
 i.

> + */
> +int pci_parent_bus_reset(struct pci_dev *dev, bool probe)
>  {
>  	struct pci_dev *pdev;
>  
> @@ -5166,6 +5178,7 @@ static int pci_parent_bus_reset(struct p
>  
>  	return pci_bridge_secondary_bus_reset(dev->bus->self);
>  }
> +EXPORT_SYMBOL_GPL(pci_parent_bus_reset);
>  
>  static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, bool probe)
>  {
> Index: linux-macro/include/linux/pci.h
> ===================================================================
> --- linux-macro.orig/include/linux/pci.h
> +++ linux-macro/include/linux/pci.h
> @@ -1447,6 +1447,7 @@ int devm_request_pci_bus_resources(struc
>  
>  /* Temporary until new and working PCI SBR API in place */
>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
> +int pci_parent_bus_reset(struct pci_dev *dev, bool probe);
>  
>  #define __pci_bus_for_each_res0(bus, res, ...)				\
>  	for (unsigned int __b = 0;					\
> 
