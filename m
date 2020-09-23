Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697552751C9
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 08:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgIWGp4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Sep 2020 02:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgIWGp4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Sep 2020 02:45:56 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C15420739;
        Wed, 23 Sep 2020 06:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600843555;
        bh=c968/uCf9Hc4m2zdFJ08br/c/wIR3JoXxVg14G9kHS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tyke1hkXbjdCO/I4kWJmpnz4HzGsEbdyDYLtZ0CE0XdCQ4OnjFihMt/a52FkWhSE4
         q++xgQLgCeAxiMJEjYkNiQTf/QcRrMikhm/NEVpErFhXzuCugNWYAvVH981wDKAOan
         vaXNAC4hnW9kGEjB5iWKdqs1dBV+Ct4KTtbd+yYQ=
Date:   Wed, 23 Sep 2020 09:45:52 +0300
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
Message-ID: <20200923064552.GG1223944@unreal>
References: <20200922082745.2149973-1-leon@kernel.org>
 <20200923053840.GA4809@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923053840.GA4809@infradead.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 23, 2020 at 06:38:40AM +0100, Christoph Hellwig wrote:
> > +static void setup_dma_device(struct ib_device *device,
> > +			     struct device *dma_device)
> >  {
> > +	if (!dma_device) {
> >  		/*
> > +		 * If the caller does not provide a DMA capable device then the
> > +		 * IB device will be used. In this case the caller should fully
> > +		 * setup the ibdev for DMA. This usually means using
> > +		 * dma_virt_ops.
> >  		 */
> > +#ifdef CONFIG_DMA_OPS
> > +		if (WARN_ON(!device->dev.dma_ops))
> > +			return;
> > +#endif
>
> dma ops are entirely optiona and NULL for the most common case
> (direct mapping without an IOMMU).

IMHO we don't support such mode (without IOMMU).

>
> > +		if (WARN_ON(!device->dev.dma_parms))
> > +			return;
> > +
> > +		dma_device = &device->dev;
> > +	} else {
> > +		device->dev.dma_parms = dma_device->dma_parms;
> >  		/*
> > +		 * Auto setup the segment size if a DMA device was passed in.
> > +		 * The PCI core sets the maximum segment size to 64 KB. Increase
> > +		 * this parameter to 2 GB.
> >  		 */
> > +		dma_set_max_seg_size(dma_device, SZ_2G);
>
> You can't just inherity DMA properties like this this.  Please
> fix all code that looks at the seg size to look at the DMA device.
>
> Btw, where does the magic 2G come from?

It comes from patch d10bcf947a3e ("RDMA/umem: Combine contiguous
PAGE_SIZE regions in SGEs"), I can't say about all devices, but this is
the limit for mlx5, rxe and SIW devices.

Thanks
