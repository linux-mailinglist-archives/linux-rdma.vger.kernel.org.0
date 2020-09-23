Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44ADA275228
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 09:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgIWHKk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Sep 2020 03:10:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbgIWHKk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Sep 2020 03:10:40 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6D9D21924;
        Wed, 23 Sep 2020 07:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600845039;
        bh=KhcwfQTmu2g4zjQ8h2RcGrI48hDz6URibD+nLYTZwcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nFcbauL+5KJP0qniJFARzbfUEx/aoY2nYNfCp15UaLCd4Diyl5ddv3ZJ3bqzH2Ixw
         ZzrQLeSA3KiG07T2UX+TRkXJA1lU7+A6J68aIevE6aVoor0ZLYZ+/sq3aHMXOwLQDR
         d+2fzZ442POkv2woSlDvdZaqcBWQ5w1E2ZcrGYw0=
Date:   Wed, 23 Sep 2020 10:10:35 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Doug Ledford <dledford@redhat.com>,
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
Message-ID: <20200923071035.GH1223944@unreal>
References: <20200922082745.2149973-1-leon@kernel.org>
 <20200923053840.GA4809@infradead.org>
 <20200923064552.GG1223944@unreal>
 <20200923065416.GA25440@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923065416.GA25440@infradead.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 23, 2020 at 07:54:16AM +0100, Christoph Hellwig wrote:
> On Wed, Sep 23, 2020 at 09:45:52AM +0300, Leon Romanovsky wrote:
> > On Wed, Sep 23, 2020 at 06:38:40AM +0100, Christoph Hellwig wrote:
> > > > +static void setup_dma_device(struct ib_device *device,
> > > > +			     struct device *dma_device)
> > > >  {
> > > > +	if (!dma_device) {
> > > >  		/*
> > > > +		 * If the caller does not provide a DMA capable device then the
> > > > +		 * IB device will be used. In this case the caller should fully
> > > > +		 * setup the ibdev for DMA. This usually means using
> > > > +		 * dma_virt_ops.
> > > >  		 */
> > > > +#ifdef CONFIG_DMA_OPS
> > > > +		if (WARN_ON(!device->dev.dma_ops))
> > > > +			return;
> > > > +#endif
> > >
> > > dma ops are entirely optiona and NULL for the most common case
> > > (direct mapping without an IOMMU).
> >
> > IMHO we don't support such mode (without IOMMU).
>
> This seems weird.  Of course I can pass in the PCI dev here at least
> in theory.  Maybe it doesn't actually happen in practice, but the check
> seems totally bogus.

No problem, I will check what can be done.

>
> > > > +	} else {
> > > > +		device->dev.dma_parms = dma_device->dma_parms;
> > > >  		/*
> > > > +		 * Auto setup the segment size if a DMA device was passed in.
> > > > +		 * The PCI core sets the maximum segment size to 64 KB. Increase
> > > > +		 * this parameter to 2 GB.
> > > >  		 */
> > > > +		dma_set_max_seg_size(dma_device, SZ_2G);
> > >
> > > You can't just inherity DMA properties like this this.  Please
> > > fix all code that looks at the seg size to look at the DMA device.
> > >
> > > Btw, where does the magic 2G come from?
> >
> > It comes from patch d10bcf947a3e ("RDMA/umem: Combine contiguous
> > PAGE_SIZE regions in SGEs"), I can't say about all devices, but this is
> > the limit for mlx5, rxe and SIW devices.
>
> If you touch this anyway I think you absolutely should move this setting
> into the drivers, and not apply a random one in the core code.

I have no idea what will be the value for other drivers, because it was
"global 2G size" before and no one complained.

Thanks
