Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A03627D6DE
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 21:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbgI2T1h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 15:27:37 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:58791 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbgI2T1h (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Sep 2020 15:27:37 -0400
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f738aa60000>; Wed, 30 Sep 2020 03:27:34 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 19:27:34 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 29 Sep 2020 19:27:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffKV5WiaJC3GPuetYEgp6msWoook54RBjMwxe9pgzhxLCmI18FNwIJw1TcRgA0D/h/Xn81pDhaiIvuOQrP1AR80bmZ8tOCE3ZgfVn4te0/389//t+l8u787R4QZ+L0KsNhUvp1fhO53ivHcAI61BMP9enQwhBlMFfbYnxkwlcX3EO/wWzZl5tRK7KPoKA8K5HjO2VVDowMFh6o4LzarmLj+Tdda8VIqqP68vcHvJVWJggmk4DJZSVbaxEBp4hV7//ppMHyvfo4VNw+4O9hOh7cl8cvHsyGXxOumOxBw/XngeKkEzyPyM2UuMFQz5weMKOgwBpg9YZYYVR9EFO3NU3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rW2PgIdeIUlbcF4NXqYaVpcdlNG63RS06dkSOhwmmqo=;
 b=AE0Qi3j2HUgepJcuymSjC4NbMnZyBTya37xIo6tIfQjtk48PCvckOvOifk20yv1mN77lBDTysm2sAChHCx6ifMIGhBV7HM5I+THLKNagQOGQFcB7fg9pR6jQqvwFskT9/XP5q3ITvi5HVly9nWZivAD4HFOiPdhfFgauB4OlC1v6CC18IA8yj4RYQ9wmyumskOtanchzNaCErL0/ObSYdoLuTJnR5zyYjvy8T8ZXxjIgNrLpMobRj8i1oUCycSOTekSsjJcTa3p6uMubhzacPu+Gq7+oafeWrkM8Y0BnBpX/WWpT3VdUPSoflNdFCWXngJF10oo94eLEv+y/UKhVTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1436.namprd12.prod.outlook.com (2603:10b6:3:78::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20; Tue, 29 Sep 2020 19:27:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 19:27:32 +0000
Date:   Tue, 29 Sep 2020 16:27:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        <linux-rdma@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH rdma-next v2 1/4] IB/core: Improve ODP to use
 hmm_range_fault()
Message-ID: <20200929192730.GB767138@nvidia.com>
References: <20200922082104.2148873-1-leon@kernel.org>
 <20200922082104.2148873-2-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200922082104.2148873-2-leon@kernel.org>
X-ClientProxiedBy: MN2PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:208:fc::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR02CA0011.namprd02.prod.outlook.com (2603:10b6:208:fc::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Tue, 29 Sep 2020 19:27:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kNLHe-003FPy-H1; Tue, 29 Sep 2020 16:27:30 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601407654; bh=rW2PgIdeIUlbcF4NXqYaVpcdlNG63RS06dkSOhwmmqo=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Kd7DsdzwuhpNmGbfy6mThMEH1epse+O6zaUvxSAzucPLURAcw/Q4fKWzYqeqJRpEP
         hw4HeDZvjqozxOwMqeHavDPjQYi2VWVGR/xwLyZ+Ex+D9Zg5TFIKVEi46VwqNxo5O9
         nYAYuIvXrdL3AIE6JsX0qT0wND/lShCM6M2z2YRtrEW3jLycOkpspk2YO4I6OrXxzq
         tOcuUt/YDmIGht7nBq3lnsK/6TDw1aDGucMfcrNux51iXoLNFBIqF6W6o8vttdju4e
         VPgKx7YKvvwHoh5acwqmIdKPVCYmeKbsDuehNW6cnueo5t0nbEakVLnOP9ITgygewi
         4Uf5AUhn+ag8A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 22, 2020 at 11:21:01AM +0300, Leon Romanovsky wrote:

> +	if (!*dma_addr) {
> +		*dma_addr = ib_dma_map_page(dev, page, 0,
> +				1 << umem_odp->page_shift,
> +				DMA_BIDIRECTIONAL);
> +		if (ib_dma_mapping_error(dev, *dma_addr)) {
> +			*dma_addr = 0;
> +			return -EFAULT;
> +		}
> +		umem_odp->npages++;
> +	}
> +
> +	*dma_addr |= access_mask;

This does need some masking, the purpose of this is to update the
access flags in the case we hit a fault on a dma mapped thing. Looks
like this can happen on a read-only page becoming writable again
(wp_page_reuse() doesn't trigger notifiers)

It should also have a comment to that effect.

something like:

if (*dma_addr) {
    /*
     * If the page is already dma mapped it means it went through a
     * non-invalidating trasition, like read-only to writable. Resync the
     * flags.
     */
    *dma_addr = (*dma_addr & (~ODP_DMA_ADDR_MASK)) | access_mask;
    return;
}

new_dma_addr = ib_dma_map_page()
[..]
*dma_addr = new_dma_addr | access_mask

> +		WARN_ON(range.hmm_pfns[pfn_index] & HMM_PFN_ERROR);
> +		WARN_ON(!(range.hmm_pfns[pfn_index] & HMM_PFN_VALID));
> +		hmm_order = hmm_pfn_to_map_order(range.hmm_pfns[pfn_index]);
> +		/* If a hugepage was detected and ODP wasn't set for, the umem
> +		 * page_shift will be used, the opposite case is an error.
> +		 */
> +		if (hmm_order + PAGE_SHIFT < page_shift) {
> +			ret = -EINVAL;
> +			pr_debug("%s: un-expected hmm_order %d, page_shift %d\n",
> +				 __func__, hmm_order, page_shift);
>  			break;
>  		}

I think this break should be a continue here. There is no reason not
to go to the next aligned PFN and try to sync as much as possible.

This should also

  WARN_ON(umem_odp->dma_list[dma_index]);

And all the pr_debugs around this code being touched should become
mlx5_ib_dbg

Jason
