Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6538F7C6B36
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Oct 2023 12:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377995AbjJLKeI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 06:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbjJLKeI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 06:34:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960AC90;
        Thu, 12 Oct 2023 03:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697106846; x=1728642846;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ji8x2F8u0U0ggxefEbWPL9IJWQlQGGYyAuJIBploLj8=;
  b=bN3f4Qk6kxsqtiPEdc7hozzc/lHyjyLmT9hB1THfw7cBEeXlPkp2ydv4
   A5RWqQuNNWZM4AHxz7lFg/5vYZlLPnq3fbNSRje7q8fucWjt+5h6iHSUq
   lV2n0tt63s27D4mcreO06tcglJUm++kPYTWNkmUiUTT9Su1BNqB0btepP
   v2x/eCjoYn4Z/KmXkMXUfrnzCL0uqLlTPy7VYz2lRVcyCOX1YVtOgi8hz
   PXk3wjIBqd57RZhJI714m3FQ9sIPDHK0wEz4wFbNmHdxX/NDdcpf5ZU/a
   IrodtZrjUd3H3whvPsp1yjwKL187hu6QXV/0zKS3Pt5cD0Ws99XtR3TbB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="388748393"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="388748393"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 03:34:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="870527710"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="870527710"
Received: from asroczyn-mobl.ger.corp.intel.com ([10.249.36.107])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 03:34:00 -0700
Date:   Thu, 12 Oct 2023 13:29:49 +0300 (EEST)
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
Subject: Re: [PATCH v2 04/13] PCI/ASPM: Move L0S/L1/sub states mask calculation
 into a helper
In-Reply-To: <20231011193206.GA1039708@bhelgaas>
Message-ID: <bcecb577-bf69-e854-6f59-f4cb26c4b354@linux.intel.com>
References: <20231011193206.GA1039708@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1380828921-1697106845=:1692"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1380828921-1697106845=:1692
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 11 Oct 2023, Bjorn Helgaas wrote:

> On Mon, Sep 18, 2023 at 04:10:54PM +0300, Ilpo Järvinen wrote:
> > ASPM service driver does the same L0S / L1S / sub states allowed
> > calculation in __pci_disable_link_state() and
> > pci_set_default_link_state().
> 
> Is there a typo or something here?  This patch only adds a call to
> __pci_disable_link_state(), not to pci_set_default_link_state().

This was because one of the changes that got included in the meantime made 
the state handling in those two functions to differ so I removed the call 
from the code but forgot to update the changelog to match the code. I'll 
fix the changelog.

-- 
 i.


> > Create a helper to calculate the mask for the allowed states.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 33 +++++++++++++++++++++------------
> >  1 file changed, 21 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index ec6d7a092ac1..91dc95aca90f 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -1034,6 +1034,26 @@ static struct pcie_link_state *pcie_aspm_get_link(struct pci_dev *pdev)
> >  	return bridge->link_state;
> >  }
> >  
> > +static u8 pci_link_state_mask(int state)
> > +{
> > +	u8 result = 0;
> > +
> > +	if (state & PCIE_LINK_STATE_L0S)
> > +		result |= ASPM_STATE_L0S;
> > +	if (state & PCIE_LINK_STATE_L1)
> > +		result |= ASPM_STATE_L1;
> > +	if (state & PCIE_LINK_STATE_L1_1)
> > +		result |= ASPM_STATE_L1_1;
> > +	if (state & PCIE_LINK_STATE_L1_2)
> > +		result |= ASPM_STATE_L1_2;
> > +	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
> > +		result |= ASPM_STATE_L1_1_PCIPM;
> > +	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
> > +		result |= ASPM_STATE_L1_2_PCIPM;
> > +
> > +	return result;
> > +}
> > +
> >  static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
> >  {
> >  	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
> > @@ -1063,18 +1083,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
> >  	if (sem)
> >  		down_read(&pci_bus_sem);
> >  	mutex_lock(&aspm_lock);
> > -	if (state & PCIE_LINK_STATE_L0S)
> > -		link->aspm_disable |= ASPM_STATE_L0S;
> > -	if (state & PCIE_LINK_STATE_L1)
> > -		link->aspm_disable |= ASPM_STATE_L1;
> > -	if (state & PCIE_LINK_STATE_L1_1)
> > -		link->aspm_disable |= ASPM_STATE_L1_1;
> > -	if (state & PCIE_LINK_STATE_L1_2)
> > -		link->aspm_disable |= ASPM_STATE_L1_2;
> > -	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
> > -		link->aspm_disable |= ASPM_STATE_L1_1_PCIPM;
> > -	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
> > -		link->aspm_disable |= ASPM_STATE_L1_2_PCIPM;
> > +	link->aspm_disable |= pci_link_state_mask(state);
> >  	pcie_config_aspm_link(link, policy_to_aspm_state(link));
> >  
> >  	if (state & PCIE_LINK_STATE_CLKPM)


--8323329-1380828921-1697106845=:1692--
