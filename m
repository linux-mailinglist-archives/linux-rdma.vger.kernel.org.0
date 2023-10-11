Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F28A7C5DAA
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Oct 2023 21:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjJKTcL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Oct 2023 15:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjJKTcK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Oct 2023 15:32:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4251C8F;
        Wed, 11 Oct 2023 12:32:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9236BC433C7;
        Wed, 11 Oct 2023 19:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697052728;
        bh=4k1m5qmcSDaP+SZOYD02LNDbpXJtj+6QzJq4iZ0fBT4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PkSkfYndzZuEdhim2WqdUnaFkJa6/ULgDeXVhLamNMtNqjpEjDLFAOpinVDtpOf9t
         AUQ8IuXuDRsbGSvvuJcBOkesPKE+B6LOW3w499tPS1H5C+DTTGZEpqDhTJv73Rngtf
         R8n/q+wpIprV9354P5kNeMO1/5OdiCJZC921zzltoOp4qhTV4cqy8e0kXbMRCaqp4/
         wgSGTdLCtZ0E1cvfJh/3oqFSKgGnYoWCp1qvbc5VbvIvmnclEI+2/Ls3QSTesrpdOn
         1i9kPgcJmtJ/9DGNbL1W+mb7/ZJBeiArthYq4x+V47gI24Zx4H0qwEfuzJhfUtgURt
         hjOYzB4aN6mlQ==
Date:   Wed, 11 Oct 2023 14:32:06 -0500
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
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, intel-wired-lan@lists.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 04/13] PCI/ASPM: Move L0S/L1/sub states mask
 calculation into a helper
Message-ID: <20231011193206.GA1039708@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230918131103.24119-5-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 18, 2023 at 04:10:54PM +0300, Ilpo Järvinen wrote:
> ASPM service driver does the same L0S / L1S / sub states allowed
> calculation in __pci_disable_link_state() and
> pci_set_default_link_state().

Is there a typo or something here?  This patch only adds a call to
__pci_disable_link_state(), not to pci_set_default_link_state().

> Create a helper to calculate the mask for the allowed states.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/pcie/aspm.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index ec6d7a092ac1..91dc95aca90f 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1034,6 +1034,26 @@ static struct pcie_link_state *pcie_aspm_get_link(struct pci_dev *pdev)
>  	return bridge->link_state;
>  }
>  
> +static u8 pci_link_state_mask(int state)
> +{
> +	u8 result = 0;
> +
> +	if (state & PCIE_LINK_STATE_L0S)
> +		result |= ASPM_STATE_L0S;
> +	if (state & PCIE_LINK_STATE_L1)
> +		result |= ASPM_STATE_L1;
> +	if (state & PCIE_LINK_STATE_L1_1)
> +		result |= ASPM_STATE_L1_1;
> +	if (state & PCIE_LINK_STATE_L1_2)
> +		result |= ASPM_STATE_L1_2;
> +	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
> +		result |= ASPM_STATE_L1_1_PCIPM;
> +	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
> +		result |= ASPM_STATE_L1_2_PCIPM;
> +
> +	return result;
> +}
> +
>  static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
>  {
>  	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
> @@ -1063,18 +1083,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
>  	if (sem)
>  		down_read(&pci_bus_sem);
>  	mutex_lock(&aspm_lock);
> -	if (state & PCIE_LINK_STATE_L0S)
> -		link->aspm_disable |= ASPM_STATE_L0S;
> -	if (state & PCIE_LINK_STATE_L1)
> -		link->aspm_disable |= ASPM_STATE_L1;
> -	if (state & PCIE_LINK_STATE_L1_1)
> -		link->aspm_disable |= ASPM_STATE_L1_1;
> -	if (state & PCIE_LINK_STATE_L1_2)
> -		link->aspm_disable |= ASPM_STATE_L1_2;
> -	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
> -		link->aspm_disable |= ASPM_STATE_L1_1_PCIPM;
> -	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
> -		link->aspm_disable |= ASPM_STATE_L1_2_PCIPM;
> +	link->aspm_disable |= pci_link_state_mask(state);
>  	pcie_config_aspm_link(link, policy_to_aspm_state(link));
>  
>  	if (state & PCIE_LINK_STATE_CLKPM)
> -- 
> 2.30.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
