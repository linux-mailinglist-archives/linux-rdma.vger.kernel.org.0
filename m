Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C9F732024
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jun 2023 20:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjFOSh7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Jun 2023 14:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjFOSh6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Jun 2023 14:37:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929C110F6;
        Thu, 15 Jun 2023 11:37:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB8C662154;
        Thu, 15 Jun 2023 18:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB540C433C0;
        Thu, 15 Jun 2023 18:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686854276;
        bh=GrZU4Bzfm1Xqzo5EgU4CnnNwyScGSBZsQwfpSFcUTy4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BODNwPZatG3b2JqhSWG5D/9wG7DxCwcU0n+OVYJJsEK8PJtcktivpxxL/Ml2BRlgr
         AsmVfkubwqS1mWQi6oj5pwJFFfffaG2LN8l4gjYmn8D3F6/64Vz2nmwAfm/xpcWrKz
         AI+zE2z1Ze9jLJ8o1OkjbkXOCTr7nu4ALkWKZBTRBuxvU2XmCxtJtSdU3CYXREzKcr
         usrwH7iDCLZiPtl7TnZKHoKfA7qMDvSSyhqA6EjiV1ayFEvty4vb2Amh7S/WzbZ+vD
         UJBUnhU2ZYt1DFC1JnGNmAdFb8cNNG9wr+5Tin6sZhpKNdwR3ocy9vj/ANs6CxYGL+
         BeCL+54TSTW9Q==
Date:   Thu, 15 Jun 2023 13:37:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Stefan Roese <sr@denx.de>, Leon Romanovsky <leon@kernel.org>,
        linux-rdma@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jim Wilson <wilson@tuliptree.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Lukas Wunner <lukas@wunner.de>, netdev@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH v9 00/14] pci: Work around ASMedia ASM2824 PCIe link
 training failures
Message-ID: <20230615183754.GA1483387@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2306150124010.64925@angie.orcam.me.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 15, 2023 at 01:41:10AM +0100, Maciej W. Rozycki wrote:
> On Wed, 14 Jun 2023, Bjorn Helgaas wrote:
> 
> > >  This is v9 of the change to work around a PCIe link training phenomenon 
> > > where a pair of devices both capable of operating at a link speed above 
> > > 2.5GT/s seems unable to negotiate the link speed and continues training 
> > > indefinitely with the Link Training bit switching on and off repeatedly 
> > > and the data link layer never reaching the active state.
> > > 
> > >  With several requests addressed and a few extra issues spotted this
> > > version has now grown to 14 patches.  It has been verified for device 
> > > enumeration with and without PCI_QUIRKS enabled, using the same piece of 
> > > RISC-V hardware as previously.  Hot plug or reset events have not been 
> > > verified, as this is difficult if at all feasible with hardware in 
> > > question.

> >  static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
> >  {
> > -	bool retrain = true;
> >  	int delay = 1;
> > +	bool retrain = false;
> > +	struct pci_dev *bridge;
> > +
> > +	if (pci_is_pcie(dev)) {
> > +		retrain = true;
> > +		bridge = pci_upstream_bridge(dev);
> > +	}
> 
>  If doing it this way, which I actually like, I think it would be a little 
> bit better performance- and style-wise if this was written as:
> 
> 	if (pci_is_pcie(dev)) {
> 		bridge = pci_upstream_bridge(dev);
> 		retrain = !!bridge;
> 	}
> 
> (or "retrain = bridge != NULL" if you prefer this style), and then we 
> don't have to repeatedly check two variables iff (pcie && !bridge) in the 
> loop below:

Done, thanks, I do like that better.  I did:

  bridge = pci_upstream_bridge(dev);
  if (bridge)
    retrain = true;

because it seems like it flows more naturally when reading.

Bjorn
