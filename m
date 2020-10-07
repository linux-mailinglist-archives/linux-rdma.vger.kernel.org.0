Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD01285EB4
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Oct 2020 14:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgJGMFc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Oct 2020 08:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgJGMFa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Oct 2020 08:05:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1038C061755
        for <linux-rdma@vger.kernel.org>; Wed,  7 Oct 2020 05:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ASWvVbJNVpcOFoXv5xxpyo3Wp8goC02GXLrim2UumGY=; b=WR7Si3LI/TKnObX8FTSae5HLGT
        P6IOHW2oQ1j52IE4fYwN71QtiP1vy/LSikdgeTsNP1kAbmLBZA5PTX3Muxiqv8VIrHRX2t4WtMrXu
        YgAHZke7xSxBgc/9QjZ6Xkf7PyNub2o4437yyXgCrCHGkuVBOD8YzkB16QCKqNyK3gGxkDJL7uCuf
        dPbZK6FFKjqUys+5OotXQ0sHV+kDiz2prYfz6j7+/rgBmZBLfhPgh0WZi96S9nb4LObgGBRZIBosM
        UI9MGJSeW3nKzzMheUpbxFPCJIIpjcaNDlPrsh/KM83+V1yKkSqNTVoWvND9OGET3AFGszWWQpBFk
        KdyirZoA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQ8Be-0001cr-AV; Wed, 07 Oct 2020 12:04:50 +0000
Date:   Wed, 7 Oct 2020 13:04:50 +0100
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
Subject: Re: [PATCH rdma-next v3] RDMA: Explicitly pass in the dma_device to
 ib_register_device
Message-ID: <20201007120450.GA4792@infradead.org>
References: <20201007070641.3552647-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007070641.3552647-1-leon@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> -static void setup_dma_device(struct ib_device *device)
> +static void setup_dma_device(struct ib_device *device,
> +			     struct device *dma_device)
>  {
> +	WARN_ON(!IS_ENABLED(CONFIG_DMA_VIRT_OPS) && !dma_device);
> +	if (IS_ENABLED(CONFIG_DMA_VIRT_OPS) && !dma_device) {
>  		/*
> +		 * If the caller does not provide a DMA capable device then the
> +		 * IB device will be used. In this case the caller should fully
> +		 * setup the ibdev for DMA. This usually means using
> +		 * dma_virt_ops.
>  		 */
> +		device->dev.dma_ops = &dma_virt_ops;


> +	rdi->ibdev.dev.dma_ops = &dma_virt_ops;
> +	rdi->ibdev.dev.dma_parms = rdi->ibdev.dev.parent->dma_parms;
> +	rdi->ibdev.dev.coherent_dma_mask =
> +		rdi->ibdev.dev.parent->coherent_dma_mask;


>  	dev->dev.dma_ops = &dma_virt_ops;


> @@ -384,8 +384,9 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
>  	base_dev->dev.parent = parent;
>  	base_dev->dev.dma_ops = &dma_virt_ops;
>  	base_dev->dev.dma_parms = &sdev->dma_parms;
> -	sdev->dma_parms = (struct device_dma_parameters)
> -		{ .max_segment_size = SZ_2G };
> +	dma_set_max_seg_size(&base_dev->dev, UINT_MAX);
> +	dma_coerce_mask_and_coherent(&base_dev->dev,
> +				     dma_get_required_mask(&base_dev->dev));

This still keeps the duplicate dma_virt_ops assignments in the driver.

The dma_coerce_mask_and_coherent in siw also doesn't make any sense to
me.
