Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8C8283891
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Oct 2020 16:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgJEO63 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Oct 2020 10:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgJEO63 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 5 Oct 2020 10:58:29 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1B342076E;
        Mon,  5 Oct 2020 14:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601909908;
        bh=/Ix7SJHll/6ucbAoabarDsMVxASfxUYLy+wCU38Ss5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lm+stInYeqi0N/UleXC0Ly61759aNURZJTwOgYnrYq9m+m6SPL0pvEyr9umuO3647
         kWQQ0ofpomtWORDtWH+2MHUzF6JNUvB4f2HtdPdx89TG0scp+ICiYu8DiK6XqZpAEm
         MgecoJ7vcYGR9t7v9H056ltgUQyR23bMbqCoNyYs=
Date:   Mon, 5 Oct 2020 17:58:24 +0300
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
Subject: Re: [PATCH rdma-next v1] RDMA: Explicitly pass in the dma_device to
 ib_register_device
Message-ID: <20201005145824.GB1874917@unreal>
References: <20201005110050.1703618-1-leon@kernel.org>
 <20201005135110.GA12620@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005135110.GA12620@infradead.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 05, 2020 at 02:51:10PM +0100, Christoph Hellwig wrote:
> >
> > -static void setup_dma_device(struct ib_device *device)
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
> Per the discussion last round I think this needs to warn if the ops
> is not dma_virt_ops, or even better force dma_virt_ops here.
>
> Something like:
>
> 	if (!dma_device) {
> 		if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_VIRT_OPS)))
> 			return -EINVAL;
> 		device->dev.dma_ops = &dma_virt_ops;
>
> > +		if (WARN_ON(!device->dev.dma_parms))
> > +			return;
>
> I think you either want this check to operate on the dma_device and be
> called for both branches, or removed entirely now that the callers setup
> the dma params.

I would say that all those if(WARN_...) return are too zealous. They
can't be in our subsystem, so it is better to simply delete all if()s
and left blank WARN_ON(..).

Something like that:
if (!dma_device) {
      WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_VIRT_OPS))
      device->dev.dma_ops = &dma_virt_ops;
      ....
