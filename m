Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C5A27505A
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 07:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgIWFjQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Sep 2020 01:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgIWFjQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Sep 2020 01:39:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C57C061755
        for <linux-rdma@vger.kernel.org>; Tue, 22 Sep 2020 22:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dwq87KEZKSxWmSODRZyST2bzNnhHUhXNkYuSzh0bwak=; b=dwaDj3yV2ocQwBm0AK5MLgIjc3
        L/hkJk4QnJYkcatRFnH7TX7Gu6KdEigFQlNtSvVdIdcCztSulmAkGZeJsoWmkMG+f9HRdE0exraXo
        isKU6Ttzhzx+ZaqG2PkSf3/L4QViuyge7v9FnOrx9Hhs1Vt/KOkZ1hRuhTMWXz3Cjk/qXyoWW+r5u
        m7k/v07vVBSxbeHjYJ4DLuD4fZzIrQpdi1lZdvf0Kgh+XGQeIsbeUpoFLCIoO1AnVNsmYyYR+4hxX
        7LwMGrg8qnlmxJ13s+XJOoNpFY8CcYkesur4lDsULaR6XBoamUEaPEFLJFKGU1bTyy0rO6l3i3Gtg
        Cnx8vGEg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKxUG-0001UU-U7; Wed, 23 Sep 2020 05:38:41 +0000
Date:   Wed, 23 Sep 2020 06:38:40 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
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
Message-ID: <20200923053840.GA4809@infradead.org>
References: <20200922082745.2149973-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922082745.2149973-1-leon@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> +static void setup_dma_device(struct ib_device *device,
> +			     struct device *dma_device)
>  {
> +	if (!dma_device) {
>  		/*
> +		 * If the caller does not provide a DMA capable device then the
> +		 * IB device will be used. In this case the caller should fully
> +		 * setup the ibdev for DMA. This usually means using
> +		 * dma_virt_ops.
>  		 */
> +#ifdef CONFIG_DMA_OPS
> +		if (WARN_ON(!device->dev.dma_ops))
> +			return;
> +#endif

dma ops are entirely optiona and NULL for the most common case
(direct mapping without an IOMMU).

> +		if (WARN_ON(!device->dev.dma_parms))
> +			return;
> +
> +		dma_device = &device->dev;
> +	} else {
> +		device->dev.dma_parms = dma_device->dma_parms;
>  		/*
> +		 * Auto setup the segment size if a DMA device was passed in.
> +		 * The PCI core sets the maximum segment size to 64 KB. Increase
> +		 * this parameter to 2 GB.
>  		 */
> +		dma_set_max_seg_size(dma_device, SZ_2G);

You can't just inherity DMA properties like this this.  Please
fix all code that looks at the seg size to look at the DMA device.

Btw, where does the magic 2G come from?
