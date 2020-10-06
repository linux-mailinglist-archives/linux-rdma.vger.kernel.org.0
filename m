Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB06E2847FC
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 09:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgJFH63 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 03:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgJFH63 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Oct 2020 03:58:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE127C061755
        for <linux-rdma@vger.kernel.org>; Tue,  6 Oct 2020 00:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jzq1alRf+nyVVe8SyobmrG6+1ql85+G54Z5ImBYRgNw=; b=S19GV5AdQDqMGY1EtX3jN4SpKU
        +CAwcufzzkG8BqQFPTI7JaPwBKFoB22ydAcYNeW5vQW9S4OEFTmKYmxrUkrJYfnGmfRITE+WFvjHZ
        klL4VjS7Y0TLjEBvBYWf2zq35D92j+J7xq/N92BIU6SP6qrWEFEz68+SZkW56tChI89LFpjhjiME+
        V5bcMHVLXkc6O3SRQsk3RWy/r6onOYIK/w+PKsd+Y4ywcH0EPhbIyqNEhy99LEZ0NFYjH6lzAec96
        /iYDpn9wVy9GZbbO5AVBjTCk7SVdW6QLkzNRB1MVLlmzah9Y3xR9Hwv4A1oEm+EdX6J7F1s3TT/Xk
        GF67gBYw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPhr3-00065t-Ly; Tue, 06 Oct 2020 07:57:49 +0000
Date:   Tue, 6 Oct 2020 08:57:49 +0100
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
Subject: Re: [PATCH rdma-next v2] RDMA: Explicitly pass in the dma_device to
 ib_register_device
Message-ID: <20201006075749.GA23345@infradead.org>
References: <20201006073229.2347811-1-leon@kernel.org>
 <20201006073554.GA16894@infradead.org>
 <20201006075345.GK1874917@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006075345.GK1874917@unreal>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 06, 2020 at 10:53:45AM +0300, Leon Romanovsky wrote:
> On Tue, Oct 06, 2020 at 08:35:54AM +0100, Christoph Hellwig wrote:
> > > +	WARN_ON(!IS_ENABLED(CONFIG_DMA_VIRT_OPS) && !dma_device);
> > > +	if (!dma_device) {
> > >  		/*
> > > -		 * The caller did not provide custom DMA operations. Use the
> > > -		 * DMA mapping operations of the parent device.
> > > +		 * If the caller does not provide a DMA capable device then the
> > > +		 * IB device will be used. In this case the caller should fully
> > > +		 * setup the ibdev for DMA. This usually means using
> > > +		 * dma_virt_ops.
> > >  		 */
> > > +		device->dev.dma_ops = &dma_virt_ops;
> > > +		dma_device = &device->dev;
> >
> > The lack of the if probably means this will fail to link now when
> > CONFIG_DMA_VIRT_OPS is not set.  This also seems to not remove the
> > dma_virt_ops assignment in the callers.
> 
> I expect to see this during driver development/testing. It is not worth
> to make if() case id device won't be operable.

Then you'll need an ifdef or whatever your preferred method is to
avoid the dma_virt_ops symbol reference for the !CONFIG_DMA_VIRT_OPS
case.
