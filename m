Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4F97C8BA1
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Oct 2023 18:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjJMQmd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Oct 2023 12:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMQmc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Oct 2023 12:42:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD657B7;
        Fri, 13 Oct 2023 09:42:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C518C433C8;
        Fri, 13 Oct 2023 16:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697215350;
        bh=MqC3yrRRj3UMGOPti8ERknVNqGEUu0oFiV03E0Vidv0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=b86OTm7/vWPz1lXdWBiZn7RcGveX1aFsvL5jmXTq2YbcyNGIbGhWA6q1/AnMGbd1N
         IFYYegR+vc8lMskeUk8lajThoc+bo1PlPWPhNqD2fwOG3AfKYpg90Eza/kNH0uSNPW
         Jky7Vj9783vlIkTQS3O7jJucPYVzjXAq/DJZUjUVY+A/BEROWzFLMN0GpWgbN/I8Vu
         ImQsRWZuesvRBHjxd0H3/8ZdxSWJjJnhbYb4F5CAQ1P15D5R2lTSA+hkWwJq0LpHAe
         Bn/6fD9G+fr9mHm/5sCM1EEe3TdFQCGEcv6U3ysqKGhpLI6CBcvRuzJ9zOUE+g+0U1
         YdquVEXDnza8g==
Date:   Fri, 13 Oct 2023 11:42:28 -0500
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
Message-ID: <20231013164228.GA1117889@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa3386a4-c22d-6d5d-112d-f36b22cda6d3@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 12, 2023 at 01:56:16PM +0300, Ilpo Järvinen wrote:
> On Wed, 11 Oct 2023, Bjorn Helgaas wrote:
> > On Mon, Sep 18, 2023 at 04:10:53PM +0300, Ilpo Järvinen wrote:
> > > PCI core/ASPM service driver allows controlling ASPM state through
> > > pci_disable_link_state() and pci_enable_link_state() API. It was
> > > decided earlier (see the Link below), to not allow ASPM changes when OS
> > > does not have control over it but only log a warning about the problem
> > > (commit 2add0ec14c25 ("PCI/ASPM: Warn when driver asks to disable ASPM,
> > > but we can't do it")). Similarly, if ASPM is not enabled through
> > > config, ASPM cannot be disabled.
> ...

> > This disables *all* ASPM states, unlike the version when
> > CONFIG_PCIEASPM is enabled.  I suppose there's a reason, and maybe a
> > comment could elaborate on it?
> >
> > When CONFIG_PCIEASPM is not enabled, I don't think we actively
> > *disable* ASPM in the hardware; we just leave it as-is, so firmware
> > might have left it enabled.
> 
> This whole trickery is intended for drivers that do not want to have ASPM 
> because the devices are broken with it. So leaving it as-is is not really 
> an option (as demonstrated by the custom workarounds).

Right.

> > Conceptually it seems like the LNKCTL updates here should be the same
> > whether CONFIG_PCIEASPM is enabled or not (subject to the question
> > above).
> > 
> > When CONFIG_PCIEASPM is enabled, we might need to do more stuff, but
> > it seems like the core should be the same.
> 
> So you think it's safer to partially disable ASPM (as per driver's 
> request) rather than disable it completely? I got the impression that the 
> latter might be safer from what Rafael said earlier but I suppose I might 
> have misinterpreted him since he didn't exactly say that it might be safer 
> to _completely_ disable it.

My question is whether the state of the device should depend on
CONFIG_PCIEASPM.  If the driver does this:

  pci_disable_link_state(PCIE_LINK_STATE_L0S)

do we want to leave L1 enabled when CONFIG_PCIEASPM=y but disable L1
when CONFIG_PCIEASPM is unset?

I can see arguments both ways.  My thought was that it would be nice
to end up with a single implementation of pci_disable_link_state()
with an #ifdef around the CONFIG_PCIEASPM-enabled stuff because it
makes the code easier to read.

Bjorn
