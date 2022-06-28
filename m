Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF0755CA3B
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 14:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245382AbiF1GKL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jun 2022 02:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245380AbiF1GKK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jun 2022 02:10:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF2D60DB;
        Mon, 27 Jun 2022 23:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cWTx7PINDz3qrfvrgx0IhWSEM1DCqLWtUdDXr1e69z4=; b=TjZz3KtjB/7fWIyslR8RRUlKxf
        xQfFOTQgIo7a7z79wl4inK+vmvst9+VyRoNVkUKUbcD+ZEhs2RP780eErLQLVsgG5DUZxmM0frTNU
        oRMmZm+R3y1wIBs+6yyLAzLhADOFBZE+OcQ2eu4nsjTsaIx9BIOExIgrRVK3a6h63IidUsSS/PbdX
        wtQgqfqJOFpol4/dj2DVDopVgaOWrRWMJLagCZnTIMweW8e8I7nGgQcb4P9l0WC/YBiacImz2GXCI
        0RDeh1AZuMmh4xByl6K+V6EQMHZkp6q/Sz2iuAwSFGmkw6L2pz6OED/KIh73gYMvpdtLxAXws1sCJ
        Cetoedrg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o64Q9-004b4e-NJ; Tue, 28 Jun 2022 06:09:57 +0000
Date:   Mon, 27 Jun 2022 23:09:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [bug report from blktests nvme/032] WARNING: possible circular
 locking dependency detected
Message-ID: <YrqbNfF9uYMSwZ4V@infradead.org>
References: <4ed3028b-2d2f-8755-fec2-0b9cb5ad42d2@fujitsu.com>
 <YrqauCHdcieF5+C7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrqauCHdcieF5+C7@kroah.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 28, 2022 at 08:07:52AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 28, 2022 at 04:03:55AM +0000, yangx.jy@fujitsu.com wrote:
> > Hi everyone,
> > 
> > Running blktests nvme/032 on kernel v5.19-rc2+ which enables 
> > CONFIG_LOCKDEP and CONFIG_PROVE_LOCKING triggered the below WARNING.
> 
> What was happening when this trace was created?  It looks like you were
> manually removing a PCI device from the system through sysfs?  Why would
> blktests do that?

To test how the block layer copes with the fact that the underlying
device goes away.
