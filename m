Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9247A7CA8A3
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Oct 2023 14:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjJPM5R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Oct 2023 08:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjJPM5Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Oct 2023 08:57:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674ABAD;
        Mon, 16 Oct 2023 05:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697461034; x=1728997034;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=33VN831uWAKG7f4eIn44PpDJgWUV0McuEtJM+oSWIh4=;
  b=Xf/12PbHv7oGM5zCun8OHZP2oOMZxmhEH6ZJ5/lUhqXfYAqUQEckGFxg
   uhBxh6kGxA949FC6FN2zZBWyvKJUifUexGABTLbcEAf1OWjx7mkTVa8Th
   xcjaHeb44AZsDmv4pcw7gCTgvOCLukytu2kdP8klIQpb52JMIVDCQIG4w
   L1wXdn9S2w13DghDuKXdK3k7ITNbCmmBqcE7MLPz8phNpEUDr+k3GznJW
   WWb2zBxOO8yfgVXUiNz7waOrIXsq+sVisX6XfG9x/jLpM0Arh3YOUHPEd
   Uq4Y8ewK7wuy0L394EulosARaZq0Chiyy9OV9IB39oKpZLPVvwycCESLJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="4130579"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="4130579"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 05:57:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="1087063948"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="1087063948"
Received: from rhaeussl-mobl.ger.corp.intel.com (HELO bhoerz-mobl1.ger.corp.intel.com) ([10.252.59.103])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 05:57:07 -0700
Date:   Mon, 16 Oct 2023 15:57:05 +0300 (EEST)
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
In-Reply-To: <20231013164850.GA1118214@bhelgaas>
Message-ID: <9da430a3-9336-8e75-7385-3d5ddcb6cb7@linux.intel.com>
References: <20231013164850.GA1118214@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1750157713-1697461032=:1986"
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

--8323329-1750157713-1697461032=:1986
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 13 Oct 2023, Bjorn Helgaas wrote:

> On Thu, Oct 12, 2023 at 03:53:39PM +0300, Ilpo Järvinen wrote:
> > On Wed, 11 Oct 2023, Bjorn Helgaas wrote:
> > > On Mon, Sep 18, 2023 at 04:10:55PM +0300, Ilpo Järvinen wrote:
> > > > pci_disable_link_state() lacks a symmetric pair. Some drivers want to
> > > > disable ASPM during certain phases of their operation but then
> > > > re-enable it later on. If pci_disable_link_state() is made for the
> > > > device, there is currently no way to re-enable the states that were
> > > > disabled.
> > > 
> > > pci_disable_link_state() gives drivers a way to disable specified ASPM
> > > states using a bitmask (PCIE_LINK_STATE_L0S, PCIE_LINK_STATE_L1,
> > > PCIE_LINK_STATE_L1_1, etc), but IIUC the driver can't tell exactly
> > > what changed and can't directly restore the original state, e.g.,
> > > 
> > >   - PCIE_LINK_STATE_L1 enabled initially
> > >   - driver calls pci_disable_link_state(PCIE_LINK_STATE_L0S)
> > >   - driver calls pci_enable_link_state(PCIE_LINK_STATE_L0S)
> > >   - PCIE_LINK_STATE_L0S and PCIE_LINK_STATE_L1 are enabled now
> > > 
> > > Now PCIE_LINK_STATE_L0S is enabled even though it was not initially
> > > enabled.  Maybe that's what we want; I dunno.
> > > 
> > > pci_disable_link_state() currently returns success/failure, but only
> > > r8169 and mt76 even check, and only rtl_init_one() (r8169) has a
> > > non-trivial reason, so it's conceivable that it could return a bitmask
> > > instead.
> > 
> > It's great that you suggested this since it's actually what also I've been 
> > started to think should be done instead of this straightforward approach
> > I used in V2. 
> > 
> > That is, don't have the drivers to get anything directly from LNKCTL
> > but they should get everything through the API provided by the 
> > disable/enable calls which makes it easy for the driver to pass the same
> > value back into the enable call.
> > 
> > > > Add pci_enable_link_state() to remove ASPM states from the state
> > > > disable mask.
> > > > 
> > > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > ---
> > > >  drivers/pci/pcie/aspm.c | 42 +++++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/pci.h     |  2 ++
> > > >  2 files changed, 44 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > > index 91dc95aca90f..f45d18d47c20 100644
> > > > --- a/drivers/pci/pcie/aspm.c
> > > > +++ b/drivers/pci/pcie/aspm.c
> > > > @@ -1117,6 +1117,48 @@ int pci_disable_link_state(struct pci_dev *pdev, int state)
> > > >  }
> > > >  EXPORT_SYMBOL(pci_disable_link_state);
> > > >  
> > > > +/**
> > > > + * pci_enable_link_state - Re-enable device's link state
> > > > + * @pdev: PCI device
> > > > + * @state: ASPM link states to re-enable
> > > > + *
> > > > + * Enable device's link state that were previously disable so the link is
> > > 
> > > "state[s] that were previously disable[d]" alludes to the use case you
> > > have in mind, but I don't think it describes how this function
> > > actually works.  This function just makes it possible to enable the
> > > specified states.  The @state parameter may have nothing to do with
> > > any previously disabled states.
> > 
> > Yes, it's what I've been thinking between the lines. But I see your point 
> > that this API didn't make it easy/obvious as is.
> > 
> > Would you want me to enforce it too besides altering the API such that the 
> > states are actually returned from disable call? (I don't personally find
> > that necessary as long as the API pair itself makes it obvious what the 
> > driver is expect to pass there.)
> 
> This was just a comment about the doc not matching the function
> behavior.
> 
> I think we have to support pci_enable_link_state() even if the driver
> hasn't previously called pci_disable_link_state(), so drivers have to
> be able to specify the pci_enable_link_state() @state from scratch.
> 
> Does that answer the enforcement question?

Yes.

-- 
 i.

> I don't think we can
> really enforce anything other than that @state specifies valid ASPM
> states.
> 
> Bjorn
> 

--8323329-1750157713-1697461032=:1986--
