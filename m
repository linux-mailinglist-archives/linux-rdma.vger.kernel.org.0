Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8EC7C5F10
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Oct 2023 23:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjJKVWL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Oct 2023 17:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjJKVWK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Oct 2023 17:22:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007C490;
        Wed, 11 Oct 2023 14:22:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCE2C433C8;
        Wed, 11 Oct 2023 21:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697059328;
        bh=qpNUqw05PLc7b1md/614fr1Zk6arYszd1WK9gMvl0Os=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ghyoFWHuCUoYAQQVImwLJec5By6IY8ldZU+IpgLhM86gHWNMMGsDK4I3bZN3O9HN6
         DZ662abX5LzoV0AuEi9+5Ki6vZZQBQwOyiKdPRI4rA2aI7uLPzLKnygGYsAASzsGrz
         QKdQ9RXXuApQ6HirgahUGTdW+uLPDMBSzhJdQjS18i+uHHpiCtlwWFOhjYSCOugggW
         Duv0TMGaORQs/RXdvsCl/MbpQ76sczbG4Y1+Ext0ZSAafYpDZUgO9tYsFTZwJorZnI
         X29tvX4dE26f0/NdjlsksaHY7OVFRWeD2ft2MA6pgB+n+l9lv7LOpuKtJ8H4lcIsBg
         tvwjDEZAHbqog==
Date:   Wed, 11 Oct 2023 16:22:06 -0500
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
Subject: Re: [PATCH v2 03/13] PCI/ASPM: Disable ASPM when driver requests it
Message-ID: <20231011212206.GA1043224@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230918131103.24119-4-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 18, 2023 at 04:10:53PM +0300, Ilpo Järvinen wrote:
> PCI core/ASPM service driver allows controlling ASPM state through
> pci_disable_link_state() and pci_enable_link_state() API. It was
> decided earlier (see the Link below), to not allow ASPM changes when OS
> does not have control over it but only log a warning about the problem
> (commit 2add0ec14c25 ("PCI/ASPM: Warn when driver asks to disable ASPM,
> but we can't do it")). Similarly, if ASPM is not enabled through
> config, ASPM cannot be disabled.
> ...

> +#ifndef CONFIG_PCIEASPM
> +/*
> + * Always disable ASPM when requested, even when CONFIG_PCIEASPM is
> + * not build to avoid drivers adding code to do it on their own
> + * which caused issues when core does not know about the out-of-band
> + * ASPM state changes.
> + */
> +int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
> +{
> +	struct pci_dev *parent = pdev->bus->self;
> +	struct pci_bus *linkbus = pdev->bus;
> +	struct pci_dev *child;
> +	u16 aspm_enabled, linkctl;
> +	int ret;
> +
> +	if (!parent)
> +		return -ENODEV;

P.S. I think this should look the same to the user (same dmesg log and
same taint, if we do that) as the CONFIG_PCIEASPM=y case.

> +	ret = pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &linkctl);
> +	if (ret != PCIBIOS_SUCCESSFUL)
> +		return pcibios_err_to_errno(ret);
> +	aspm_enabled = linkctl & PCI_EXP_LNKCTL_ASPMC;
> +
> +	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &linkctl);
> +	if (ret != PCIBIOS_SUCCESSFUL)
> +		return pcibios_err_to_errno(ret);
> +	aspm_enabled |= linkctl & PCI_EXP_LNKCTL_ASPMC;
> +
> +	/* If no states need to be disabled, don't touch LNKCTL */
> +	if (state & aspm_enabled)
> +		return 0;
> +
> +	ret = pcie_capability_clear_word(parent, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_ASPMC);
> +	if (ret != PCIBIOS_SUCCESSFUL)
> +		return pcibios_err_to_errno(ret);
> +	list_for_each_entry(child, &linkbus->devices, bus_list)
> +		pcie_capability_clear_word(child, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_ASPMC);

This disables *all* ASPM states, unlike the version when
CONFIG_PCIEASPM is enabled.  I suppose there's a reason, and maybe a
comment could elaborate on it?

When CONFIG_PCIEASPM is not enabled, I don't think we actively
*disable* ASPM in the hardware; we just leave it as-is, so firmware
might have left it enabled.

> +
> +	return 0;
> +}

Conceptually it seems like the LNKCTL updates here should be the same
whether CONFIG_PCIEASPM is enabled or not (subject to the question
above).

When CONFIG_PCIEASPM is enabled, we might need to do more stuff, but
it seems like the core should be the same.

Bjorn
