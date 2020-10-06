Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB2F284768
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 09:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgJFHgo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 03:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgJFHgo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Oct 2020 03:36:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A18C061755
        for <linux-rdma@vger.kernel.org>; Tue,  6 Oct 2020 00:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B029RG/YNsgvEaapjIP2d4GEVdtPWFgRtwTLsuPlcSM=; b=HEPj5Lr7J8XyEkR14st2FM3BFH
        mf264dlsVEfYK5jfGDOpC8YVGYEH/2N16N0zSnZj/oVAPEpTHuc5idLvZJGotH0jm+uvScUskcedE
        7vvAYm/0kj7S8THLp0JM3c4rmL3pUkSRfQpkwBffP1LIIy+/9dRuqN5qr5k3maksrM262O1SyZM2x
        lvFO5Eh+Ao9CVN33E48or0d38YbEav5S+JvGufwdxg9rndqbjdnLgeC7wcJgXTbNhKR4SOpgf6fov
        MEZNnSowj5pATLNwVnhQGBjROxXyaLqnfYiVOxGYaVxCVzCzuUU7J4AfonJGvCOI17QaYo96wwxZc
        ttD8dPcw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPhVq-0004gK-SY; Tue, 06 Oct 2020 07:35:54 +0000
Date:   Tue, 6 Oct 2020 08:35:54 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
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
Message-ID: <20201006073554.GA16894@infradead.org>
References: <20201006073229.2347811-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006073229.2347811-1-leon@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> +	WARN_ON(!IS_ENABLED(CONFIG_DMA_VIRT_OPS) && !dma_device);
> +	if (!dma_device) {
>  		/*
> -		 * The caller did not provide custom DMA operations. Use the
> -		 * DMA mapping operations of the parent device.
> +		 * If the caller does not provide a DMA capable device then the
> +		 * IB device will be used. In this case the caller should fully
> +		 * setup the ibdev for DMA. This usually means using
> +		 * dma_virt_ops.
>  		 */
> +		device->dev.dma_ops = &dma_virt_ops;
> +		dma_device = &device->dev;

The lack of the if probably means this will fail to link now when
CONFIG_DMA_VIRT_OPS is not set.  This also seems to not remove the
dma_virt_ops assignment in the callers.

> index f904bb34477a..2f117ac11c8b 100644
> --- a/drivers/infiniband/sw/rdmavt/vt.c
> +++ b/drivers/infiniband/sw/rdmavt/vt.c
> @@ -581,7 +581,11 @@ int rvt_register_device(struct rvt_dev_info *rdi)
>  	spin_lock_init(&rdi->n_cqs_lock);
> 
>  	/* DMA Operations */
> -	rdi->ibdev.dev.dma_ops = rdi->ibdev.dev.dma_ops ? : &dma_virt_ops;
> +	rdi->ibdev.dev.dma_ops = &dma_virt_ops;
> +	rdi->ibdev.dev.dma_parms = rdi->ibdev.dev.parent->dma_parms;
> +	rdi->ibdev.dev.dma_mask = rdi->ibdev.dev.parent->dma_mask;

This copies the dma_mask pointer, which seems completely bogus.
