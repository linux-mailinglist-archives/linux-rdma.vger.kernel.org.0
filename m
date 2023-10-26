Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FE47D8B4C
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 00:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjJZWCW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 18:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJZWCV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 18:02:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF647AB;
        Thu, 26 Oct 2023 15:02:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA825C433C8;
        Thu, 26 Oct 2023 22:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698357739;
        bh=v+OwCPCkufkei1OkZ0IK7OBnZIyQ/k2CAv18GMp5ECU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n78Q8MakmY6S/n69Ux03t5U9WUOopOaUt6nDKsoVSQ7EwfcRn4luVSqYv4gLpBVda
         DrKIa1h7StitkkRiy4EE1uZV9ATfMIOdG1LH7fry+wsdgg7K0o8FZyDL0K8lk1O1cV
         t8tCIDdZoIwRLbl3rrSWnJxwraxqaVw/Gir1EFKFtZzjPUiogtA2KbpA/GPnWVFE75
         vFVT+iMPgWVgs1VDlgs/RGVAxhV9lLfl6E7IGtKj2DkZ2fYHoCBfSJQ4yR5Uj+vsRQ
         d1R5iC/0IUud8PHKgG7cpchJEmznQsL2QPpfVhJQJ4HgyUhDYk2WkITTtzPLdgWmQ9
         XkdZf2GExUM1w==
Date:   Thu, 26 Oct 2023 17:02:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
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
Subject: Re: [PATCH v2 03/13] PCI/ASPM: Disable ASPM when driver requests it
Message-ID: <20231026220216.GA1752508@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a434d9f-48ec-cfe5-900-8923361798a9@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 16, 2023 at 05:27:37PM +0300, Ilpo Järvinen wrote:
> On Fri, 13 Oct 2023, Bjorn Helgaas wrote:
> > On Thu, Oct 12, 2023 at 01:56:16PM +0300, Ilpo Järvinen wrote:
> > > On Wed, 11 Oct 2023, Bjorn Helgaas wrote:
> > > > On Mon, Sep 18, 2023 at 04:10:53PM +0300, Ilpo Järvinen wrote:
> > > > > PCI core/ASPM service driver allows controlling ASPM state
> > > > > through pci_disable_link_state() and pci_enable_link_state()
> > > > > API. It was decided earlier (see the Link below), to not
> > > > > allow ASPM changes when OS does not have control over it but
> > > > > only log a warning about the problem (commit 2add0ec14c25
> > > > > ("PCI/ASPM: Warn when driver asks to disable ASPM, but we
> > > > > can't do it")). Similarly, if ASPM is not enabled through
> > > > > config, ASPM cannot be disabled.
> > > ...
> > 
> > > > This disables *all* ASPM states, unlike the version when
> > > > CONFIG_PCIEASPM is enabled.  I suppose there's a reason, and
> > > > maybe a comment could elaborate on it?
> > > >
> > > > When CONFIG_PCIEASPM is not enabled, I don't think we actively
> > > > *disable* ASPM in the hardware; we just leave it as-is, so
> > > > firmware might have left it enabled.
> > > 
> > > This whole trickery is intended for drivers that do not want to
> > > have ASPM because the devices are broken with it. So leaving it
> > > as-is is not really an option (as demonstrated by the custom
> > > workarounds).
> > 
> > Right.
> > 
> > > > Conceptually it seems like the LNKCTL updates here should be
> > > > the same whether CONFIG_PCIEASPM is enabled or not (subject to
> > > > the question above).
> > > > 
> > > > When CONFIG_PCIEASPM is enabled, we might need to do more
> > > > stuff, but it seems like the core should be the same.
> > > 
> > > So you think it's safer to partially disable ASPM (as per
> > > driver's request) rather than disable it completely? I got the
> > > impression that the latter might be safer from what Rafael said
> > > earlier but I suppose I might have misinterpreted him since he
> > > didn't exactly say that it might be safer to _completely_
> > > disable it.
> > 
> > My question is whether the state of the device should depend on
> > CONFIG_PCIEASPM.  If the driver does this:
> > 
> >   pci_disable_link_state(PCIE_LINK_STATE_L0S)
> > 
> > do we want to leave L1 enabled when CONFIG_PCIEASPM=y but disable L1
> > when CONFIG_PCIEASPM is unset?
> > 
> > I can see arguments both ways.  My thought was that it would be nice
> > to end up with a single implementation of pci_disable_link_state()
> > with an #ifdef around the CONFIG_PCIEASPM-enabled stuff because it
> > makes the code easier to read.

Responding to myself here, I think we should do the partial disables
because it matches what the drivers did previously by hand, we can
reduce the number of code paths, and the resulting device state will
be the same regardless of CONFIG_PCIEASPM.

> I think there's still one important thing to discuss and none of the
> comments have covered that area so far.
> 
> The drivers that have workaround are not going to turn more
> dangerous than they're already without this change, so we're mostly
> within charted waters there even with what you propose. However, I
> think the bigger catch and potential source of problems, with both
> this v2 and your alternative, are the drivers that do not have the
> workarounds around CONFIG_PCIEASPM=n and/or _OSC permissions. Those
> code paths just call pci_disable_link_state() and do nothing else.
> 
> Do you think it's okay to alter the behavior for those drivers too
> (disable ASPM where it previously was a no-op)?

Yes.  I assume the reason those drivers call pci_disable_link_state()
is because some hardware defect means ASPM doesn't work correctly.

This change means pci_disable_link_state() will disable ASPM even when
the OS doesn't own ASPM or CONFIG_PCIEASPM is unset.  I think those
cases are unusual and probably not well tested, and I suspect that if
we *did* test them, we'd find that ASPM doesn't work with the current
kernel.

So I think this is more likely to *fix* something than to break it.

Bjorn
