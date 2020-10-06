Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658C62847E1
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 09:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgJFHxv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 03:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgJFHxv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Oct 2020 03:53:51 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 425BC20760;
        Tue,  6 Oct 2020 07:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601970830;
        bh=/LkdZ2nk205rG/aXlex3QVzJL5fCTWMjJajxqBqPClk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xfsxDYQuU+MqjKgc4sCu0vaV2/iK+1G6P+wnTdjcWSyrhSRtABvybMDkf8w8pFa7o
         586pMp6BQgAP0lVoK9Yn9ag917KsV+uK3v6jpL2qyc0fE/1A9Lie1ZtnZPL9NA/rN0
         5LXR05yw4gsf16lGeu80qkXLH7ogrKw0ukGGbQS8=
Date:   Tue, 6 Oct 2020 10:53:45 +0300
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
Message-ID: <20201006075345.GK1874917@unreal>
References: <20201006073229.2347811-1-leon@kernel.org>
 <20201006073554.GA16894@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006073554.GA16894@infradead.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 06, 2020 at 08:35:54AM +0100, Christoph Hellwig wrote:
> > +	WARN_ON(!IS_ENABLED(CONFIG_DMA_VIRT_OPS) && !dma_device);
> > +	if (!dma_device) {
> >  		/*
> > -		 * The caller did not provide custom DMA operations. Use the
> > -		 * DMA mapping operations of the parent device.
> > +		 * If the caller does not provide a DMA capable device then the
> > +		 * IB device will be used. In this case the caller should fully
> > +		 * setup the ibdev for DMA. This usually means using
> > +		 * dma_virt_ops.
> >  		 */
> > +		device->dev.dma_ops = &dma_virt_ops;
> > +		dma_device = &device->dev;
>
> The lack of the if probably means this will fail to link now when
> CONFIG_DMA_VIRT_OPS is not set.  This also seems to not remove the
> dma_virt_ops assignment in the callers.

I expect to see this during driver development/testing. It is not worth
to make if() case id device won't be operable.

Thanks
