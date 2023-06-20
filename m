Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40B573687F
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 11:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjFTJ5M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 05:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjFTJ4e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 05:56:34 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE3E42115;
        Tue, 20 Jun 2023 02:54:05 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id BC22792009C; Tue, 20 Jun 2023 11:54:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B4F1492009B;
        Tue, 20 Jun 2023 10:54:04 +0100 (BST)
Date:   Tue, 20 Jun 2023 10:54:04 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
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
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH v9 00/14] pci: Work around ASMedia ASM2824 PCIe link
 training failures
In-Reply-To: <20230616202900.GA1540115@bhelgaas>
Message-ID: <alpine.DEB.2.21.2306201040200.14084@angie.orcam.me.uk>
References: <20230616202900.GA1540115@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 16 Jun 2023, Bjorn Helgaas wrote:

> I agree that as I rearranged it, the workaround doesn't apply in all
> cases simultaneously.  Maybe not ideal, but maybe not terrible either.
> Looking at it again, maybe it would have made more sense to move the
> pcie_wait_for_link_delay() change to the last patch along with the
> pci_dev_wait() change.  I dunno.

 I think the order of the changes is not important enough to justify 
spending a lot of time and mental effort on it.  You decided, so be it.  
Thank you for your effort made with this review.

 With this series out of the way I have now posted a small clean-up for 
SBR code duplication between PCI core and an InfiniBand driver I came 
across in the course of working on this series.  See 
<https://lore.kernel.org/r/alpine.DEB.2.21.2306200153110.14084@angie.orcam.me.uk/>.

 Please have a look at your convenience.

  Maciej
