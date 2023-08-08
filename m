Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE667745D7
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Aug 2023 20:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjHHSrP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Aug 2023 14:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbjHHSql (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Aug 2023 14:46:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1614B8EF;
        Tue,  8 Aug 2023 09:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691513532; x=1723049532;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Tbh/ctA20NaTil9W5pSKrR3yHLRxmmuIH7RURQ9YCzs=;
  b=lNoKbF+Mgr26r3e0BCr7OV2OdHm6Bi+Ka9q7oLzA806PY+ekB00rNCB5
   jiA+Ih67gaJoOGX8IrsOk8hPqpBGbZbDRWqwGLq9D9lsAI9+nvBiBOHq9
   pMbbEfxz2KX1sBcg6E3mYIgVkGhttDx4OAVgVvTPwyoFrpA9HtY6Wa9mN
   Bvm2hspSJomMUgp3f9IQktyb9Vj2mqIrAeMjKv6Md31SJw/gPumFhJws2
   yVPmGLl7Q+v1+aYIyL/ahVF5ojcuGpU2htnR+fkFi2vOn3c1ObwzcgtP2
   4MitnncfMT50PXESHZGbBSTcdU6jgB+GQhFrJaay5rIL5VQy2m0qnBivR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="369782157"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="369782157"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 09:51:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="796795565"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="796795565"
Received: from mtofeni-mobl.ger.corp.intel.com ([10.252.48.21])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 09:51:43 -0700
Date:   Tue, 8 Aug 2023 19:51:40 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] IB/hfi1: Remove pci_parent_bus_reset() duplication
In-Reply-To: <alpine.DEB.2.21.2306200235510.14084@angie.orcam.me.uk>
Message-ID: <07d51c9-e651-2e8e-bf3c-8a3966d5eb@linux.intel.com>
References: <alpine.DEB.2.21.2306200153110.14084@angie.orcam.me.uk> <alpine.DEB.2.21.2306200235510.14084@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-738198269-1691513504=:2047"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-738198269-1691513504=:2047
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 20 Jun 2023, Maciej W. Rozycki wrote:

> Call pci_parent_bus_reset() rather than duplicating it in trigger_sbr().
> There are extra preparatory checks made by the former function, but they 
> are supposed to be neutral to the HFI1 device.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
>  drivers/infiniband/hw/hfi1/pcie.c |   30 ++++--------------------------
>  1 file changed, 4 insertions(+), 26 deletions(-)
> 
> linux-ib-hfi1-pcie-sbr-parent-bus-reset.diff
> Index: linux-macro/drivers/infiniband/hw/hfi1/pcie.c
> ===================================================================
> --- linux-macro.orig/drivers/infiniband/hw/hfi1/pcie.c
> +++ linux-macro/drivers/infiniband/hw/hfi1/pcie.c
> @@ -796,35 +796,13 @@ static void pcie_post_steps(struct hfi1_
>  /*
>   * Trigger a secondary bus reset (SBR) on ourselves using our parent.
>   *
> - * Based on pci_parent_bus_reset() which is not exported by the
> - * kernel core.
> + * This is an end around to do an SBR during probe time.  A new API
> + * needs to be implemented to have cleaner interface but this fixes
> + * the current brokenness.
>   */
>  static int trigger_sbr(struct hfi1_devdata *dd)
>  {
> -	struct pci_dev *dev = dd->pcidev;
> -	struct pci_dev *pdev;
> -
> -	/* need a parent */
> -	if (!dev->bus->self) {
> -		dd_dev_err(dd, "%s: no parent device\n", __func__);
> -		return -ENOTTY;
> -	}
> -
> -	/* should not be anyone else on the bus */
> -	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
> -		if (pdev != dev) {
> -			dd_dev_err(dd,
> -				   "%s: another device is on the same bus\n",
> -				   __func__);
> -			return -ENOTTY;
> -		}
> -
> -	/*
> -	 * This is an end around to do an SBR during probe time. A new API needs
> -	 * to be implemented to have cleaner interface but this fixes the
> -	 * current brokenness
> -	 */
> -	return pci_bridge_secondary_bus_reset(dev->bus->self);
> +	return pci_parent_bus_reset(dd->pcidev, PCI_RESET_DO_RESET);
>  }

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-738198269-1691513504=:2047--
