Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D90128482B
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 10:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgJFINk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 04:13:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJFINk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Oct 2020 04:13:40 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52AC9206F7;
        Tue,  6 Oct 2020 08:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601972019;
        bh=LvzCbB0u7EWJxbO5tO/ifPKXIHNjm4ftrTis3L8nbZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xIRPRFSxiK4nC/qpnnvjhRtdGl/J+seiE36psbef8l8Ewd96nw6pPCTHTud6fn53U
         4gKF2C/BgUPAlaQF7SWdloxkeZUPBMsWVLFOXeFWxjboDfm69skavJGOeP+gxqw7ML
         oS6uekkCp0pgnlSG2tnOORPM9aPR+uRNlyaazvfI=
Date:   Tue, 6 Oct 2020 11:13:34 +0300
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
Subject: Re: [PATCH rdma-next v2] RDMA: Explicitly pass in the dma_device to
 ib_register_device
Message-ID: <20201006081334.GL1874917@unreal>
References: <20201006073229.2347811-1-leon@kernel.org>
 <20201006073554.GA16894@infradead.org>
 <20201006075345.GK1874917@unreal>
 <20201006075749.GA23345@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006075749.GA23345@infradead.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 06, 2020 at 08:57:49AM +0100, Christoph Hellwig wrote:
> On Tue, Oct 06, 2020 at 10:53:45AM +0300, Leon Romanovsky wrote:
> > On Tue, Oct 06, 2020 at 08:35:54AM +0100, Christoph Hellwig wrote:
> > > > +	WARN_ON(!IS_ENABLED(CONFIG_DMA_VIRT_OPS) && !dma_device);
> > > > +	if (!dma_device) {
> > > >  		/*
> > > > -		 * The caller did not provide custom DMA operations. Use the
> > > > -		 * DMA mapping operations of the parent device.
> > > > +		 * If the caller does not provide a DMA capable device then the
> > > > +		 * IB device will be used. In this case the caller should fully
> > > > +		 * setup the ibdev for DMA. This usually means using
> > > > +		 * dma_virt_ops.
> > > >  		 */
> > > > +		device->dev.dma_ops = &dma_virt_ops;
> > > > +		dma_device = &device->dev;
> > >
> > > The lack of the if probably means this will fail to link now when
> > > CONFIG_DMA_VIRT_OPS is not set.  This also seems to not remove the
> > > dma_virt_ops assignment in the callers.
> >
> > I expect to see this during driver development/testing. It is not worth
> > to make if() case id device won't be operable.
>
> Then you'll need an ifdef or whatever your preferred method is to
> avoid the dma_virt_ops symbol reference for the !CONFIG_DMA_VIRT_OPS
> case.

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 882a7b389dc3..49d095f45216 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1181,7 +1181,7 @@ static void setup_dma_device(struct ib_device *device,
                             struct device *dma_device)
 {
        WARN_ON(!IS_ENABLED(CONFIG_DMA_VIRT_OPS) && !dma_device);
-       if (!dma_device) {
+       if (IS_ENABLED(CONFIG_DMA_VIRT_OPS) && !dma_device) {
                /*
                 * If the caller does not provide a DMA capable device then the
                 * IB device will be used. In this case the caller should fully

