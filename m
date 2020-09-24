Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E3127689B
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Sep 2020 07:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgIXFyI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Sep 2020 01:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgIXFyI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Sep 2020 01:54:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A81EC0613CE
        for <linux-rdma@vger.kernel.org>; Wed, 23 Sep 2020 22:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dFk9AQMIvHhB8mw1QK2wpwWSJ2Wjc9DPsayPq+F5kWA=; b=IYDNyuJZi+q56Hp+/sSP47zljI
        UzUwyvAX1D5TAHfukMFS3PYSVoAhqEvOCQCkTLevi0m2GMS9WDhU5n0ljbrMazK0RIFVjgb3jxrvZ
        YrCquJoWDFna/xmxwFzuxgit3cqLl8zEVEQXaTHhbuRloLP7gbc/dDzvaEzYpZVyAuQvx+HMnj2DA
        bpgaz6VnsXA9wkXM99gIbcx/N/DWRX+0026kNWfa0j/sh7hSj9nzNrvnfa76JYe1t+E3cxxM8Pm2U
        oEQ1MFFyOTnkUYxJOq1WU2sSpIA56DVXfMUpCzQhtG88eAiuJzJPzVwEMtdrALqEPJBE89at6h+Kk
        w1mQ98tA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLKCP-00066s-9J; Thu, 24 Sep 2020 05:53:45 +0000
Date:   Thu, 24 Sep 2020 06:53:45 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parav Pandit <parav@nvidia.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA: Explicitly pass in the dma_device to
 ib_register_device
Message-ID: <20200924055345.GB22045@infradead.org>
References: <20200922101429.GF1223944@unreal>
 <20200922082745.2149973-1-leon@kernel.org>
 <OFA7334E75.E0306A27-ON002585EB.003059A0-002585EB.0031440E@notes.na.collabserv.com>
 <OFE5279622.4F47648E-ON002585EB.004EEBC0-002585EB.004EEBDA@notes.na.collabserv.com>
 <20200922162206.GD3699@nvidia.com>
 <20200923053955.GB4809@infradead.org>
 <20200923183556.GB9475@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923183556.GB9475@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 23, 2020 at 03:35:56PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 23, 2020 at 06:39:55AM +0100, Christoph Hellwig wrote:
> > > I wonder if dma_virt_ops ignores the masking.. Still seems best to set
> > > it consistently when using dma_virt_ops.
> > 
> > dma_virt_ops doesn't look at the mask.  But in retrospective
> > dma_virt_ops has been a really bad idea.  I'd much rather move the
> > handling of non-physical devices back into the RDMA core in the long
> > run.
> 
> Doesn't that mean we need to put all the ugly IB DMA ops wrappers back
> though?

All the wrappers still exists, and as far a I can tell are used by the
core and ULPs properly.

> Why was dma_virt_ops such a bad idea?

Because it isn't DMA, and not we need crappy workarounds like the one
in the PCIe P2P code.  It also enforces the same size for dma_addr_t
and a pointer, which is not true in various cases.  More importantly
it forces a very strange design in the IB APIs (actually it seems the
other way around - the weird IB Verbs APIs forced this decision, but
it cements it in).  For example most modern Mellanox cards can include
immediate data in the command capsule (sorry NVMe terms, I'm pretty
sure you guys use something else) that is just copied into the BAR
using MMIO.  But the IB API design still forces the ULP to dma map
it, which is idiotic.
