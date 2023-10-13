Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA387C8BC0
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Oct 2023 18:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjJMQs6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Oct 2023 12:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjJMQsx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Oct 2023 12:48:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7BCB7;
        Fri, 13 Oct 2023 09:48:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61FEC433C9;
        Fri, 13 Oct 2023 16:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697215731;
        bh=szP7x2S0GYdm6BcJLpTOMMqgkvX4QE9nsVO22TS5i8o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iXecQ4KBb/XyryDRw48MJQ8eE5IZmTibbJWLMBT63ah7VMsNNhfRxsQRBnSxXVRz8
         ptzcbqS9ofaJyIOri3ZALVgpwCe+Rwg/lONB4QUFij9MtoErSRw7/rE4HfqKMRp9Ol
         1AuluwowvDK8NcbSOabPG4FxyRekhzTRLLTUCt9VlQsHG9fr69h7832PJfiQYCJtsC
         xvTbFlvGOVHUu8F9jtsNeee3XWb5EfGiJLqK4gNafwswJDcPCPTqjBh2AHAtqM1Mvf
         uNDeS2sjsSyZm50Zfb+V47XLjRkfe0MUfugLCniPVwGscnhdTvdZP2Opj4v6DC5oEv
         fj+erZKZvWbGg==
Date:   Fri, 13 Oct 2023 11:48:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
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
Message-ID: <20231013164850.GA1118214@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afb4db5-5fe1-9f5d-a910-032adf195c@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 12, 2023 at 03:53:39PM +0300, Ilpo Järvinen wrote:
> On Wed, 11 Oct 2023, Bjorn Helgaas wrote:
> > On Mon, Sep 18, 2023 at 04:10:55PM +0300, Ilpo Järvinen wrote:
> > > pci_disable_link_state() lacks a symmetric pair. Some drivers want to
> > > disable ASPM during certain phases of their operation but then
> > > re-enable it later on. If pci_disable_link_state() is made for the
> > > device, there is currently no way to re-enable the states that were
> > > disabled.
> > 
> > pci_disable_link_state() gives drivers a way to disable specified ASPM
> > states using a bitmask (PCIE_LINK_STATE_L0S, PCIE_LINK_STATE_L1,
> > PCIE_LINK_STATE_L1_1, etc), but IIUC the driver can't tell exactly
> > what changed and can't directly restore the original state, e.g.,
> > 
> >   - PCIE_LINK_STATE_L1 enabled initially
> >   - driver calls pci_disable_link_state(PCIE_LINK_STATE_L0S)
> >   - driver calls pci_enable_link_state(PCIE_LINK_STATE_L0S)
> >   - PCIE_LINK_STATE_L0S and PCIE_LINK_STATE_L1 are enabled now
> > 
> > Now PCIE_LINK_STATE_L0S is enabled even though it was not initially
> > enabled.  Maybe that's what we want; I dunno.
> > 
> > pci_disable_link_state() currently returns success/failure, but only
> > r8169 and mt76 even check, and only rtl_init_one() (r8169) has a
> > non-trivial reason, so it's conceivable that it could return a bitmask
> > instead.
> 
> It's great that you suggested this since it's actually what also I've been 
> started to think should be done instead of this straightforward approach
> I used in V2. 
> 
> That is, don't have the drivers to get anything directly from LNKCTL
> but they should get everything through the API provided by the 
> disable/enable calls which makes it easy for the driver to pass the same
> value back into the enable call.
> 
> > > Add pci_enable_link_state() to remove ASPM states from the state
> > > disable mask.
> > > 
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > >  drivers/pci/pcie/aspm.c | 42 +++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/pci.h     |  2 ++
> > >  2 files changed, 44 insertions(+)
> > > 
> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > index 91dc95aca90f..f45d18d47c20 100644
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -1117,6 +1117,48 @@ int pci_disable_link_state(struct pci_dev *pdev, int state)
> > >  }
> > >  EXPORT_SYMBOL(pci_disable_link_state);
> > >  
> > > +/**
> > > + * pci_enable_link_state - Re-enable device's link state
> > > + * @pdev: PCI device
> > > + * @state: ASPM link states to re-enable
> > > + *
> > > + * Enable device's link state that were previously disable so the link is
> > 
> > "state[s] that were previously disable[d]" alludes to the use case you
> > have in mind, but I don't think it describes how this function
> > actually works.  This function just makes it possible to enable the
> > specified states.  The @state parameter may have nothing to do with
> > any previously disabled states.
> 
> Yes, it's what I've been thinking between the lines. But I see your point 
> that this API didn't make it easy/obvious as is.
> 
> Would you want me to enforce it too besides altering the API such that the 
> states are actually returned from disable call? (I don't personally find
> that necessary as long as the API pair itself makes it obvious what the 
> driver is expect to pass there.)

This was just a comment about the doc not matching the function
behavior.

I think we have to support pci_enable_link_state() even if the driver
hasn't previously called pci_disable_link_state(), so drivers have to
be able to specify the pci_enable_link_state() @state from scratch.

Does that answer the enforcement question?  I don't think we can
really enforce anything other than that @state specifies valid ASPM
states.

Bjorn
