Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4CA2844F2
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 06:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgJFEcL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 00:32:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:32878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbgJFEcL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Oct 2020 00:32:11 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37B722075A;
        Tue,  6 Oct 2020 04:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601958731;
        bh=xijHYrVizK0LARcsEQR9L2RFOjoZdVPTJmXmRyDE3Wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KszoDIS4fp1NS7s2ADVB3V5fFISop5lBK/zHlwYO5fL9XP6qQj2wHRZt0RFuhGSTg
         TqVH4h98suMnB13Atw03FFzMIqx0jXEN9LbK1kOqGJRF2b0t+ZwXYAtbQxk2CFww1n
         NPi79u+OdQbu/NZSheU/5AtOM2XpURcpFrKU+6a0=
Date:   Tue, 6 Oct 2020 07:32:07 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Parav Pandit <parav@nvidia.com>
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
        Lijun Ou <oulijun@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
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
        Yanjun Zhu <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next v1] RDMA: Explicitly pass in the dma_device to
 ib_register_device
Message-ID: <20201006043207.GC1874917@unreal>
References: <20201005110050.1703618-1-leon@kernel.org>
 <20201005135110.GA12620@infradead.org>
 <20201005145824.GB1874917@unreal>
 <BY5PR12MB43223BDE9E73B5E001B75E22DC0D0@BY5PR12MB4322.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR12MB43223BDE9E73B5E001B75E22DC0D0@BY5PR12MB4322.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 06, 2020 at 02:59:32AM +0000, Parav Pandit wrote:
>
>
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Monday, October 5, 2020 8:28 PM
> >
> > On Mon, Oct 05, 2020 at 02:51:10PM +0100, Christoph Hellwig wrote:
> > > >
> > > > -static void setup_dma_device(struct ib_device *device)
> > > > +static void setup_dma_device(struct ib_device *device,
> > > > +			     struct device *dma_device)
> > > >  {
> > > > +	if (!dma_device) {
> > > >  		/*
> > > > +		 * If the caller does not provide a DMA capable device then
> > the
> > > > +		 * IB device will be used. In this case the caller should fully
> > > > +		 * setup the ibdev for DMA. This usually means using
> > > > +		 * dma_virt_ops.
> > > >  		 */
> > > > +#ifdef CONFIG_DMA_OPS
> > > > +		if (WARN_ON(!device->dev.dma_ops))
> > > > +			return;
> > > > +#endif
> > >
> > > Per the discussion last round I think this needs to warn if the ops is
> > > not dma_virt_ops, or even better force dma_virt_ops here.
> > >
> > > Something like:
> > >
> > > 	if (!dma_device) {
> > > 		if
> > (WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_VIRT_OPS)))
> > > 			return -EINVAL;
> > > 		device->dev.dma_ops = &dma_virt_ops;
> > >
> > > > +		if (WARN_ON(!device->dev.dma_parms))
> > > > +			return;
> > >
> > > I think you either want this check to operate on the dma_device and be
> > > called for both branches, or removed entirely now that the callers
> > > setup the dma params.
> >
> > I would say that all those if(WARN_...) return are too zealous. They can't be
> > in our subsystem, so it is better to simply delete all if()s and left blank
> > WARN_ON(..).
> >
> > Something like that:
> > if (!dma_device) {
> >       WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_VIRT_OPS))
> >       device->dev.dma_ops = &dma_virt_ops;
> >       ....
> Looks good to me.
> Will you revise or I should?

I will change it now and resend.

Thanks
