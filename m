Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F5027D548
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 19:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgI2R7t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 13:59:49 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6312 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgI2R7t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Sep 2020 13:59:49 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7375b00000>; Tue, 29 Sep 2020 10:58:08 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 17:59:48 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 29 Sep 2020 17:59:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PODvWgaVcKZSVfhDdOqMlIUpLZ4nKtijyt+QJTVbbMNnK6uzrZYpQo+LEPtzfZ2/Djia48LKcoSmVjrH5fOT3HsId/XgfroFSfpLgFA751go8QkQqfDI4JEm3j68qFAF/LaKGH3f3IR/fpca0eacabzOMhmP9nA38K5weieGEC4iThnpb5TcRQzdgnSpYuKFKL90Sb2zgXrLtQ9HlAvvrUORr4FXw6VA1CDcnQWUaI9XStXQ7cHQ7eQTKc/w3uItNBMLNC9IkO9C4B5EYNMCmtxHGiudk73v6UKoRPmkadVPBu2qd67Fo9upc/vzYK4Qwd8rjqfr3oWJWhgZaWSApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REVTr6Oxm0sJe6hwk3bt9jYwXkfwBbgGMwgvYZ3W+hQ=;
 b=kKxr4v8a7MRzmb0dXjWQQtcVhbOxCkS+eIpP7jxcyMQ21KS7UONCAmmBTJQFX9T10ooY8qZ2V+zvN0O3kWzba75XQ0tbXyhLKSjTsdbeGRc57VT/F/linHnOAmxry3Z0eWignvgAYfI2S0oAU7cjzQ1KiOAxsik642pxb9fTf29mFxU9uqQqxFB2Cj5Etda18CiAXcaJmgjl0CrCzComo1OSc3eSSi/yyl+cDlvmgqZ9U5WidIi6YzKbsppki+naPkDS41ZAolfCsDiw5us3/qoANO+Oyd2fUOYBF/Zs99RPyJixrVv7JGwM21FOzwS9i6FpJ7f0blA4XBQ6vW3RLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0202.namprd12.prod.outlook.com (2603:10b6:4:4d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 17:59:47 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 17:59:47 +0000
Date:   Tue, 29 Sep 2020 14:59:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        <linux-rdma@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH rdma-next v2 1/4] IB/core: Improve ODP to use
 hmm_range_fault()
Message-ID: <20200929175946.GA767138@nvidia.com>
References: <20200922082104.2148873-1-leon@kernel.org>
 <20200922082104.2148873-2-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200922082104.2148873-2-leon@kernel.org>
X-ClientProxiedBy: BL1PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:208:256::7) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0002.namprd13.prod.outlook.com (2603:10b6:208:256::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.18 via Frontend Transport; Tue, 29 Sep 2020 17:59:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kNJuk-003DbQ-3j; Tue, 29 Sep 2020 14:59:46 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601402288; bh=REVTr6Oxm0sJe6hwk3bt9jYwXkfwBbgGMwgvYZ3W+hQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=SfK4z5M3xJtHMK8caYDJlXJ6NejgTEjF/Gb+QiogH2XP63aN3C3BMOEEjXLhnbBOA
         AbGygBxozyD0s73WtEctImGPSGoPqTeGQ1mT5IuV8a95IYY0Uk/05oT7jUPP9VmJvB
         oR4v2TbwRmtdABMDpi77K9aBTAmMZPfm0kbToUkpfkRzoJL8K8kBX2oODu+c9w4nzG
         h6xVTilDGfcHm0AcQfre4l9txfYg0i7DI5xOLx+nSr60pyJYlzJaoRtq2hgHqAVDId
         rtrIv5iO8pTWUYydwplAbWnWABY1rQpImF3IePwwKlGFzwiwzHnWqSTliTaQmRvaAh
         tGsz2iSWL3I7w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 22, 2020 at 11:21:01AM +0300, Leon Romanovsky wrote:
> @@ -287,87 +289,48 @@ EXPORT_SYMBOL(ib_umem_odp_release);
>   * Map for DMA and insert a single page into the on-demand paging page tables.
>   *
>   * @umem: the umem to insert the page to.
> - * @page_index: index in the umem to add the page to.
> + * @dma_index: index in the umem to add the dma to.
>   * @page: the page struct to map and add.
>   * @access_mask: access permissions needed for this page.
>   * @current_seq: sequence number for synchronization with invalidations.
>   *               the sequence number is taken from
>   *               umem_odp->notifiers_seq.
>   *
> - * The function returns -EFAULT if the DMA mapping operation fails. It returns
> - * -EAGAIN if a concurrent invalidation prevents us from updating the page.
> + * The function returns -EFAULT if the DMA mapping operation fails.
>   *
> - * The page is released via put_page even if the operation failed. For on-demand
> - * pinning, the page is released whenever it isn't stored in the umem.
>   */
>  static int ib_umem_odp_map_dma_single_page(
>  		struct ib_umem_odp *umem_odp,
> -		unsigned int page_index,
> +		unsigned int dma_index,
>  		struct page *page,
> -		u64 access_mask,
> -		unsigned long current_seq)
> +		u64 access_mask)
>  {
>  	struct ib_device *dev = umem_odp->umem.ibdev;
> -	dma_addr_t dma_addr;
> -	int ret = 0;
> -
> -	if (mmu_interval_check_retry(&umem_odp->notifier, current_seq)) {
> -		ret = -EAGAIN;
> -		goto out;
> -	}
> -	if (!(umem_odp->dma_list[page_index])) {
> -		dma_addr =
> -			ib_dma_map_page(dev, page, 0, BIT(umem_odp->page_shift),
> -					DMA_BIDIRECTIONAL);
> -		if (ib_dma_mapping_error(dev, dma_addr)) {
> -			ret = -EFAULT;
> -			goto out;
> -		}
> -		umem_odp->dma_list[page_index] = dma_addr | access_mask;
> -		umem_odp->page_list[page_index] = page;
> +	dma_addr_t *dma_addr = &umem_odp->dma_list[dma_index];
> +
> +	if (!*dma_addr) {
> +		*dma_addr = ib_dma_map_page(dev, page, 0,
> +				1 << umem_odp->page_shift,
> +				DMA_BIDIRECTIONAL);
> +		if (ib_dma_mapping_error(dev, *dma_addr))
> +			return -EFAULT;

This leaves *dma_addr set to ib_dma_mapping_error, which means the
next try to map it will fail the if (!dma_addr) and produce a
corrupted dma address.

*dma_addr should be set to 0 here

Jason
