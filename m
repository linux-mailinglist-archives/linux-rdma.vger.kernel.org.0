Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D501C28682E
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Oct 2020 21:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgJGTV0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Oct 2020 15:21:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbgJGTV0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Oct 2020 15:21:26 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E98242076B;
        Wed,  7 Oct 2020 19:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602098485;
        bh=E7HYtuhsNcwH6BoWLJ6tOLwvY6dKtez8PlvA2r0MWAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x8/20F2JRvbDXM6tXU8ljZJlaO0Bz/WJTZqx43nhc4b0xHtw1XPA5BlMkMeHIg+7k
         wHZ+teZKMmwtC8XDdSCFVuPCrDvba4D5fuWIVKkkl2TPGmSoMmLx3xZ2Dc2xEifxo5
         B+k8B8PwnCjIqOn2hEEOBPsKP598MO/fMRFEBrEQ=
Date:   Wed, 7 Oct 2020 22:21:21 +0300
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
Subject: Re: [PATCH rdma-next v3] RDMA: Explicitly pass in the dma_device to
 ib_register_device
Message-ID: <20201007192121.GC3964015@unreal>
References: <20201007070641.3552647-1-leon@kernel.org>
 <20201007120450.GA4792@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007120450.GA4792@infradead.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 07, 2020 at 01:04:50PM +0100, Christoph Hellwig wrote:
> > -static void setup_dma_device(struct ib_device *device)
> > +static void setup_dma_device(struct ib_device *device,
> > +			     struct device *dma_device)
> >  {
> > +	WARN_ON(!IS_ENABLED(CONFIG_DMA_VIRT_OPS) && !dma_device);
> > +	if (IS_ENABLED(CONFIG_DMA_VIRT_OPS) && !dma_device) {
> >  		/*
> > +		 * If the caller does not provide a DMA capable device then the
> > +		 * IB device will be used. In this case the caller should fully
> > +		 * setup the ibdev for DMA. This usually means using
> > +		 * dma_virt_ops.
> >  		 */
> > +		device->dev.dma_ops = &dma_virt_ops;
>
>
> > +	rdi->ibdev.dev.dma_ops = &dma_virt_ops;
> > +	rdi->ibdev.dev.dma_parms = rdi->ibdev.dev.parent->dma_parms;
> > +	rdi->ibdev.dev.coherent_dma_mask =
> > +		rdi->ibdev.dev.parent->coherent_dma_mask;
>
>
> >  	dev->dev.dma_ops = &dma_virt_ops;
>
>
> > @@ -384,8 +384,9 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
> >  	base_dev->dev.parent = parent;
> >  	base_dev->dev.dma_ops = &dma_virt_ops;
> >  	base_dev->dev.dma_parms = &sdev->dma_parms;
> > -	sdev->dma_parms = (struct device_dma_parameters)
> > -		{ .max_segment_size = SZ_2G };
> > +	dma_set_max_seg_size(&base_dev->dev, UINT_MAX);
> > +	dma_coerce_mask_and_coherent(&base_dev->dev,
> > +				     dma_get_required_mask(&base_dev->dev));
>
> This still keeps the duplicate dma_virt_ops assignments in the driver.
>
> The dma_coerce_mask_and_coherent in siw also doesn't make any sense to
> me.

Sorry for this.
