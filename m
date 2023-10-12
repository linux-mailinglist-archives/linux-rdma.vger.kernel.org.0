Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAEB7C6BA7
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Oct 2023 12:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbjJLK4a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 06:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbjJLK40 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 06:56:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E182CF;
        Thu, 12 Oct 2023 03:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697108185; x=1728644185;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ncUYHUPUudbeDBu1X+DbOYSPV06JH2dv47rcK32PQ+0=;
  b=CYclsOvOPtH3Q8m1wMMmDYUHx/L6vQrIQRlGlDiTpobaSJ/SD8nZa1yQ
   lmY9YqnctCNWpDlmbqOQfO8u3cwjxe1sBLbcfgWfX7nJ+ZrNDZ4y23gAX
   HbkMANv6j4C80UF4fY2QznF81/dmYLkDw/KG2IiTPs7jbdaRuZ4TdQFxh
   wlLZwCWV8LmydShMWfIj8HsKLUGGxyKHhIL2h8Yd4USZuVsQsWxWUShau
   izP+1118O9PObYimo3ulINXAXq9pIBJWoqzKEwS/rGrv3vJAdEgdjHiSQ
   VeVAmvpuDHBN7XAu6gEJd7JD4Cb/HMGDGmdPiPIXwKpyDJUTvWKLeg2qw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="3483256"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="3483256"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 03:56:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="789349717"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="789349717"
Received: from asroczyn-mobl.ger.corp.intel.com ([10.249.36.107])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 03:56:18 -0700
Date:   Thu, 12 Oct 2023 13:56:16 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, intel-wired-lan@lists.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-wireless@vger.kernel.org, Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 03/13] PCI/ASPM: Disable ASPM when driver requests
 it
In-Reply-To: <20231011212206.GA1043224@bhelgaas>
Message-ID: <aa3386a4-c22d-6d5d-112d-f36b22cda6d3@linux.intel.com>
References: <20231011212206.GA1043224@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1326969328-1697108183=:1692"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1326969328-1697108183=:1692
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 11 Oct 2023, Bjorn Helgaas wrote:

> On Mon, Sep 18, 2023 at 04:10:53PM +0300, Ilpo Järvinen wrote:
> > PCI core/ASPM service driver allows controlling ASPM state through
> > pci_disable_link_state() and pci_enable_link_state() API. It was
> > decided earlier (see the Link below), to not allow ASPM changes when OS
> > does not have control over it but only log a warning about the problem
> > (commit 2add0ec14c25 ("PCI/ASPM: Warn when driver asks to disable ASPM,
> > but we can't do it")). Similarly, if ASPM is not enabled through
> > config, ASPM cannot be disabled.
> > ...
> 
> > +#ifndef CONFIG_PCIEASPM
> > +/*
> > + * Always disable ASPM when requested, even when CONFIG_PCIEASPM is
> > + * not build to avoid drivers adding code to do it on their own
> > + * which caused issues when core does not know about the out-of-band
> > + * ASPM state changes.
> > + */
> > +int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
> > +{
> > +	struct pci_dev *parent = pdev->bus->self;
> > +	struct pci_bus *linkbus = pdev->bus;
> > +	struct pci_dev *child;
> > +	u16 aspm_enabled, linkctl;
> > +	int ret;
> > +
> > +	if (!parent)
> > +		return -ENODEV;
> 
> P.S. I think this should look the same to the user (same dmesg log and
> same taint, if we do that) as the CONFIG_PCIEASPM=y case.

Okay.

> > +	ret = pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &linkctl);
> > +	if (ret != PCIBIOS_SUCCESSFUL)
> > +		return pcibios_err_to_errno(ret);
> > +	aspm_enabled = linkctl & PCI_EXP_LNKCTL_ASPMC;
> > +
> > +	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &linkctl);
> > +	if (ret != PCIBIOS_SUCCESSFUL)
> > +		return pcibios_err_to_errno(ret);
> > +	aspm_enabled |= linkctl & PCI_EXP_LNKCTL_ASPMC;
> > +
> > +	/* If no states need to be disabled, don't touch LNKCTL */
> > +	if (state & aspm_enabled)
> > +		return 0;
> > +
> > +	ret = pcie_capability_clear_word(parent, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_ASPMC);
> > +	if (ret != PCIBIOS_SUCCESSFUL)
> > +		return pcibios_err_to_errno(ret);
> > +	list_for_each_entry(child, &linkbus->devices, bus_list)
> > +		pcie_capability_clear_word(child, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_ASPMC);
> 
> This disables *all* ASPM states, unlike the version when
> CONFIG_PCIEASPM is enabled.  I suppose there's a reason, and maybe a
> comment could elaborate on it?
>
> When CONFIG_PCIEASPM is not enabled, I don't think we actively
> *disable* ASPM in the hardware; we just leave it as-is, so firmware
> might have left it enabled.

This whole trickery is intended for drivers that do not want to have ASPM 
because the devices are broken with it. So leaving it as-is is not really 
an option (as demonstrated by the custom workarounds).

> > +
> > +	return 0;
> > +}
> 
> Conceptually it seems like the LNKCTL updates here should be the same
> whether CONFIG_PCIEASPM is enabled or not (subject to the question
> above).
> 
> When CONFIG_PCIEASPM is enabled, we might need to do more stuff, but
> it seems like the core should be the same.

So you think it's safer to partially disable ASPM (as per driver's 
request) rather than disable it completely? I got the impression that the 
latter might be safer from what Rafael said earlier but I suppose I might 
have misinterpreted him since he didn't exactly say that it might be safer 
to _completely_ disable it.

-- 
 i.

--8323329-1326969328-1697108183=:1692--
