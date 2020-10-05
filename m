Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDAA2836EF
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Oct 2020 15:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgJENwD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Oct 2020 09:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgJENwC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Oct 2020 09:52:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF4AC0613CE
        for <linux-rdma@vger.kernel.org>; Mon,  5 Oct 2020 06:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hSjDZ4vIZkFNgWo/NalXLYGy7S4psNjes1q3E5igyFA=; b=DE3Jv+hSsXAtPrjZ7HHSBvs2Mk
        EAE4VLAd3mM2lcdAP37knqqu1/eLXBRcc/tEYEvdbT3UQ2YTfa87BIgCKWRZzla1lPWxSiSU/rr13
        l0K4vFWg8QO86PtDhp8RHtcSSGSZylP7O1CL5wRGFd2UYS5/Decaar1Tk7QlcM/K2EwWS3Wg3z+o+
        1Bp1WkpDRQfaQxx1YFiYeooRPAkQxjs23pW8AwuUvX2fYVGhiqRqsN//TI3Q82vsVipIMlsNMnr0l
        1jGdGV1wvG2zSSs2zGyU0My6ZWtDR/27TIwwMK2ZmMWG65B0Ru4joCgdohBzhTcIubOzKZHGyc6Mx
        EqPRFjSQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPQtS-0003Uv-Hw; Mon, 05 Oct 2020 13:51:10 +0000
Date:   Mon, 5 Oct 2020 14:51:10 +0100
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
Subject: Re: [PATCH rdma-next v1] RDMA: Explicitly pass in the dma_device to
 ib_register_device
Message-ID: <20201005135110.GA12620@infradead.org>
References: <20201005110050.1703618-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005110050.1703618-1-leon@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> 
> -static void setup_dma_device(struct ib_device *device)
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

Per the discussion last round I think this needs to warn if the ops
is not dma_virt_ops, or even better force dma_virt_ops here.

Something like:

	if (!dma_device) {
		if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_VIRT_OPS)))
			return -EINVAL;
		device->dev.dma_ops = &dma_virt_ops;

> +		if (WARN_ON(!device->dev.dma_parms))
> +			return;

I think you either want this check to operate on the dma_device and be
called for both branches, or removed entirely now that the callers setup
the dma params.
