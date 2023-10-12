Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843717C6E86
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Oct 2023 14:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378433AbjJLMxt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 08:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343867AbjJLMxs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 08:53:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBA194;
        Thu, 12 Oct 2023 05:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697115227; x=1728651227;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gNLNaEec64/5yPf43OhzXjxJ+9f0AwPObPN0gw90rTk=;
  b=XkJ9DZi5gy3NgX1d7rCxq+rNL5s/H7mbScg9qZtZuE0o2ovQ6o1aTPfT
   RSkn6+wb8jlENZvCR1cjCzBDMsPR4EVEUqfMche/YjYjxViTWu4FfobjZ
   CUIaoL0Vn88ucROtDhnXUx8cGrpkNZlqzvBTl+tEYjfJXXv5HwINStMMu
   8zBmNOBuAp3ttOy2oERrV+cd3OPVAUXLpZtxRF48y1iThmGNEYQk/nnxp
   M5gc4C0aQJrhAithjm3hwCNljAEN+5WvwJjIgaNcaMlWVEUrwTo4vvUHc
   f6Aea66STp3AIMpiHaWybUqw4Q6mkcqqgbb1kzpYS7Qrk5evW4cL4CAl5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="471169655"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="471169655"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 05:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="783688889"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="783688889"
Received: from asroczyn-mobl.ger.corp.intel.com ([10.249.36.107])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 05:53:41 -0700
Date:   Thu, 12 Oct 2023 15:53:39 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
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
Subject: Re: [PATCH v2 05/13] PCI/ASPM: Add pci_enable_link_state()
In-Reply-To: <20231011215327.GA1043654@bhelgaas>
Message-ID: <afb4db5-5fe1-9f5d-a910-032adf195c@linux.intel.com>
References: <20231011215327.GA1043654@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1586418908-1697115226=:1692"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1586418908-1697115226=:1692
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 11 Oct 2023, Bjorn Helgaas wrote:

> On Mon, Sep 18, 2023 at 04:10:55PM +0300, Ilpo Järvinen wrote:
> > pci_disable_link_state() lacks a symmetric pair. Some drivers want to
> > disable ASPM during certain phases of their operation but then
> > re-enable it later on. If pci_disable_link_state() is made for the
> > device, there is currently no way to re-enable the states that were
> > disabled.
> 
> pci_disable_link_state() gives drivers a way to disable specified ASPM
> states using a bitmask (PCIE_LINK_STATE_L0S, PCIE_LINK_STATE_L1,
> PCIE_LINK_STATE_L1_1, etc), but IIUC the driver can't tell exactly
> what changed and can't directly restore the original state, e.g.,
> 
>   - PCIE_LINK_STATE_L1 enabled initially
>   - driver calls pci_disable_link_state(PCIE_LINK_STATE_L0S)
>   - driver calls pci_enable_link_state(PCIE_LINK_STATE_L0S)
>   - PCIE_LINK_STATE_L0S and PCIE_LINK_STATE_L1 are enabled now
> 
> Now PCIE_LINK_STATE_L0S is enabled even though it was not initially
> enabled.  Maybe that's what we want; I dunno.
> 
> pci_disable_link_state() currently returns success/failure, but only
> r8169 and mt76 even check, and only rtl_init_one() (r8169) has a
> non-trivial reason, so it's conceivable that it could return a bitmask
> instead.

It's great that you suggested this since it's actually what also I've been 
started to think should be done instead of this straightforward approach
I used in V2. 

That is, don't have the drivers to get anything directly from LNKCTL
but they should get everything through the API provided by the 
disable/enable calls which makes it easy for the driver to pass the same
value back into the enable call.

> > Add pci_enable_link_state() to remove ASPM states from the state
> > disable mask.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 42 +++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci.h     |  2 ++
> >  2 files changed, 44 insertions(+)
> > 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 91dc95aca90f..f45d18d47c20 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -1117,6 +1117,48 @@ int pci_disable_link_state(struct pci_dev *pdev, int state)
> >  }
> >  EXPORT_SYMBOL(pci_disable_link_state);
> >  
> > +/**
> > + * pci_enable_link_state - Re-enable device's link state
> > + * @pdev: PCI device
> > + * @state: ASPM link states to re-enable
> > + *
> > + * Enable device's link state that were previously disable so the link is
> 
> "state[s] that were previously disable[d]" alludes to the use case you
> have in mind, but I don't think it describes how this function
> actually works.  This function just makes it possible to enable the
> specified states.  The @state parameter may have nothing to do with
> any previously disabled states.

Yes, it's what I've been thinking between the lines. But I see your point 
that this API didn't make it easy/obvious as is.

Would you want me to enforce it too besides altering the API such that the 
states are actually returned from disable call? (I don't personally find
that necessary as long as the API pair itself makes it obvious what the 
driver is expect to pass there.)


-- 
 i.

--8323329-1586418908-1697115226=:1692--
