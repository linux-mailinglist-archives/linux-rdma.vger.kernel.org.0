Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F58B7CAB73
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Oct 2023 16:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjJPO1v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Oct 2023 10:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjJPO1v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Oct 2023 10:27:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA8683;
        Mon, 16 Oct 2023 07:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697466468; x=1729002468;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=WAHtEU+QRIIV0hjjctV4dFUOMA87lFSZZckv/e6FmbI=;
  b=MLdYaMUrX5YccmQcg2hEP63YIkH+x1b3KeRgjLxsRYMcuSx99wFnnN6R
   IzN66rHPFhvJKLQ5WOEcR5hT9yNZ5cybG6UUjUvmz6wtAPXVToW0V62OQ
   KWIsNyrR/rnjiWcpfFHWYHYRzurXPtROJnnmoOY/gJUYmC/SAREcjIa8G
   dr+7jGx5XGCIU974YKCV8goveF9t0DYWMxLia3zr31EIN2VMir1eVyQXc
   ghvlcbrHLr8zwmKLE1HtgSvqd+Mc+eQ/s0YnbLieqOoVgsSWB/76qp6TV
   AS10mjor5216OwX7Lpd9ZCG58YtCpoikRazXWSM0i+nYQqeeyZuCo2kwW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="388396812"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="388396812"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 07:27:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="759416190"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="759416190"
Received: from rhaeussl-mobl.ger.corp.intel.com ([10.252.59.103])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 07:27:40 -0700
Date:   Mon, 16 Oct 2023 17:27:37 +0300 (EEST)
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
In-Reply-To: <20231013164228.GA1117889@bhelgaas>
Message-ID: <a434d9f-48ec-cfe5-900-8923361798a9@linux.intel.com>
References: <20231013164228.GA1117889@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-158890400-1697462044=:1986"
Content-ID: <58c8d854-b57c-582-1ba0-efeb857febe@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-158890400-1697462044=:1986
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <a321263b-cac2-11d0-6cb1-43cc78d1c6d1@linux.intel.com>

On Fri, 13 Oct 2023, Bjorn Helgaas wrote:
> On Thu, Oct 12, 2023 at 01:56:16PM +0300, Ilpo Järvinen wrote:
> > On Wed, 11 Oct 2023, Bjorn Helgaas wrote:
> > > On Mon, Sep 18, 2023 at 04:10:53PM +0300, Ilpo Järvinen wrote:
> > > > PCI core/ASPM service driver allows controlling ASPM state through
> > > > pci_disable_link_state() and pci_enable_link_state() API. It was
> > > > decided earlier (see the Link below), to not allow ASPM changes when OS
> > > > does not have control over it but only log a warning about the problem
> > > > (commit 2add0ec14c25 ("PCI/ASPM: Warn when driver asks to disable ASPM,
> > > > but we can't do it")). Similarly, if ASPM is not enabled through
> > > > config, ASPM cannot be disabled.
> > ...
> 
> > > This disables *all* ASPM states, unlike the version when
> > > CONFIG_PCIEASPM is enabled.  I suppose there's a reason, and maybe a
> > > comment could elaborate on it?
> > >
> > > When CONFIG_PCIEASPM is not enabled, I don't think we actively
> > > *disable* ASPM in the hardware; we just leave it as-is, so firmware
> > > might have left it enabled.
> > 
> > This whole trickery is intended for drivers that do not want to have ASPM 
> > because the devices are broken with it. So leaving it as-is is not really 
> > an option (as demonstrated by the custom workarounds).
> 
> Right.
> 
> > > Conceptually it seems like the LNKCTL updates here should be the same
> > > whether CONFIG_PCIEASPM is enabled or not (subject to the question
> > > above).
> > > 
> > > When CONFIG_PCIEASPM is enabled, we might need to do more stuff, but
> > > it seems like the core should be the same.
> > 
> > So you think it's safer to partially disable ASPM (as per driver's 
> > request) rather than disable it completely? I got the impression that the 
> > latter might be safer from what Rafael said earlier but I suppose I might 
> > have misinterpreted him since he didn't exactly say that it might be safer 
> > to _completely_ disable it.
> 
> My question is whether the state of the device should depend on
> CONFIG_PCIEASPM.  If the driver does this:
> 
>   pci_disable_link_state(PCIE_LINK_STATE_L0S)
> 
> do we want to leave L1 enabled when CONFIG_PCIEASPM=y but disable L1
> when CONFIG_PCIEASPM is unset?
> 
> I can see arguments both ways.  My thought was that it would be nice
> to end up with a single implementation of pci_disable_link_state()
> with an #ifdef around the CONFIG_PCIEASPM-enabled stuff because it
> makes the code easier to read.

Hi Bjorn,

Thanks a lot for all your feedback so far, it has been very helpful.

I think there's still one important thing to discuss and none of the 
comments have covered that area so far.

The drivers that have workaround are not going to turn more dangerous than 
they're already without this change, so we're mostly within charted waters 
there even with what you propose. However, I think the bigger catch and 
potential source of problems, with both this v2 and your alternative, are 
the drivers that do not have the workarounds around CONFIG_PCIEASPM=n 
and/or _OSC permissions. Those code paths just call 
pci_disable_link_state() and do nothing else.

Do you think it's okay to alter the behavior for those drivers too 
(disable ASPM where it previously was a no-op)?

I'm okay with going the direction you indicated but I just wanted to ask
this in advance before reworking the behavior so I can take that detail 
also into account.


-- 
 i.
--8323329-158890400-1697462044=:1986--
