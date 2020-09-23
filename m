Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5E02751F6
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 08:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgIWGyt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Sep 2020 02:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgIWGyt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Sep 2020 02:54:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A78CC061755
        for <linux-rdma@vger.kernel.org>; Tue, 22 Sep 2020 23:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RQC5CBVfAyTEHotV4tu5a+1kItsYyFwiktg3GXY5Exk=; b=P0ylEqXJCzknTX3p7tUdZAg+M4
        u2trqC1W/FWmT0droBMkqydYObffYUr2/h6M9ZAIOEbN1e1F5DZWR9RX2FU6s8Ze1x1ikkSLm5S6G
        VcWnty0p7F37ukEN739xVZ/IcMnZH33GU93PF+uPD+xshqIzOoullciZKytNQNsmzWjJbyvZCYk7Z
        3fC74u/4LPBJvh3LBmNo+XkEznqaZFj6fJtw5EH/zvAN5s8OmsDEXXUBq7fUcnVDbJjOu25pE20Ya
        K6PQO7b6L049953bu9XVY21YBqXCCv850TVGbPHlX0CNDmKUFU1RLE6ULiXpIuh7OWVOWFg67JwGh
        FPu/hJqg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKyfQ-0006i2-UG; Wed, 23 Sep 2020 06:54:16 +0000
Date:   Wed, 23 Sep 2020 07:54:16 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
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
Message-ID: <20200923065416.GA25440@infradead.org>
References: <20200922082745.2149973-1-leon@kernel.org>
 <20200923053840.GA4809@infradead.org>
 <20200923064552.GG1223944@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923064552.GG1223944@unreal>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 23, 2020 at 09:45:52AM +0300, Leon Romanovsky wrote:
> On Wed, Sep 23, 2020 at 06:38:40AM +0100, Christoph Hellwig wrote:
> > > +static void setup_dma_device(struct ib_device *device,
> > > +			     struct device *dma_device)
> > >  {
> > > +	if (!dma_device) {
> > >  		/*
> > > +		 * If the caller does not provide a DMA capable device then the
> > > +		 * IB device will be used. In this case the caller should fully
> > > +		 * setup the ibdev for DMA. This usually means using
> > > +		 * dma_virt_ops.
> > >  		 */
> > > +#ifdef CONFIG_DMA_OPS
> > > +		if (WARN_ON(!device->dev.dma_ops))
> > > +			return;
> > > +#endif
> >
> > dma ops are entirely optiona and NULL for the most common case
> > (direct mapping without an IOMMU).
> 
> IMHO we don't support such mode (without IOMMU).

This seems weird.  Of course I can pass in the PCI dev here at least
in theory.  Maybe it doesn't actually happen in practice, but the check
seems totally bogus.

> > > +	} else {
> > > +		device->dev.dma_parms = dma_device->dma_parms;
> > >  		/*
> > > +		 * Auto setup the segment size if a DMA device was passed in.
> > > +		 * The PCI core sets the maximum segment size to 64 KB. Increase
> > > +		 * this parameter to 2 GB.
> > >  		 */
> > > +		dma_set_max_seg_size(dma_device, SZ_2G);
> >
> > You can't just inherity DMA properties like this this.  Please
> > fix all code that looks at the seg size to look at the DMA device.
> >
> > Btw, where does the magic 2G come from?
> 
> It comes from patch d10bcf947a3e ("RDMA/umem: Combine contiguous
> PAGE_SIZE regions in SGEs"), I can't say about all devices, but this is
> the limit for mlx5, rxe and SIW devices.

If you touch this anyway I think you absolutely should move this setting
into the drivers, and not apply a random one in the core code.
