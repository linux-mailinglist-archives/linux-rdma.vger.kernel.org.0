Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4AD27D7C6
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 22:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgI2UNM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 16:13:12 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:61051 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgI2UNL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Sep 2020 16:13:11 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7395550000>; Wed, 30 Sep 2020 04:13:09 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 20:13:09 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 29 Sep 2020 20:13:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kx0Q2C8qyq1s46rnMD7I3JytY+WLI48nq0TmBRh9uoYLHYGkJ8a6OUtpo2vInQjFLaYPJsVTit2kjObxt1msPqoQC1TvaUSUCr8tDLt6Ua0hvLMQbAM+ZLB0foKC99Vdtg/ooAymXhNHYVgg2zQFtveViMH+t2N+As42XBTZxmnSS+Wxqm92h/7b1nxMWgmGKKveWsBQ6rjmB5XgFe6HshKD1RNW4fIUaCMPgPZAG69KtmF4evi281xU7eZDSjxrkiZlJSXRcynzIPVJtexd9NPjhKqHi3XlePnPdKgoostt4IurMNwjNPRv4hmt1BM90MQjJ5cw1zK5un6ngp/0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6pjCV333BffiwR+fWYwvCE6INEK2bFwfZtYaB4v6aQ=;
 b=jBhO17zDQX1Buu3wtZ4TIEANvwBU7cTzvzudqhal7NqKVEg5BLe3/9aOZg4BaXKzSMbK1tdZkLlcsyDpLAsZtzcMWVsdbyvwkevO0856o9tDrD8QeQzdSMIvE42MdOHKOl2HpTvS8nOs/T5NBgduC/XPxxhmlfIqn5PPGCKwuCQKU+A7iq7NG26AW0gq6vlc6l1mDfQUeJpJvOkbl/t/JEnP+hd00sBs4cR5Fa7RTbmWGVqpNDJVvjeSdeWjTqM/JbOueTcPAZQ6WrGm4toSni9Bu+YomBZVCz7wq1hiKyQYSTroXy4h+vicdEHnj3XVDGS8mbGUAV/9As/ct9GP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1146.namprd12.prod.outlook.com (2603:10b6:3:73::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 20:13:06 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 20:13:06 +0000
Date:   Tue, 29 Sep 2020 17:13:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yishai Hadas <yishaih@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH rdma-next v2 1/4] IB/core: Improve ODP to use
 hmm_range_fault()
Message-ID: <20200929201303.GG9475@nvidia.com>
References: <20200922082104.2148873-1-leon@kernel.org>
 <20200922082104.2148873-2-leon@kernel.org>
 <20200929192730.GB767138@nvidia.com>
 <089ce58a-a439-79b5-72ac-128d56002878@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <089ce58a-a439-79b5-72ac-128d56002878@nvidia.com>
X-ClientProxiedBy: MN2PR15CA0014.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0014.namprd15.prod.outlook.com (2603:10b6:208:1b4::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Tue, 29 Sep 2020 20:13:05 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kNLzj-003QHs-Ub; Tue, 29 Sep 2020 17:13:03 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601410389; bh=d6pjCV333BffiwR+fWYwvCE6INEK2bFwfZtYaB4v6aQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=RVZlsO07JUM7h1YyLy084hmGq/1NDCdvBvtHB/kDILRJe3Pvugd5s6vsZ4d8iTlrH
         IGJTJJHjPfrzHIH0RAvcHP5Shotl4NFFy89aMVgNub59XIlsdSFEvyDb8l4sLZ9WwU
         zCK6KWQyQFS4i7rlANI87X80tVt0mVJxAKWFteAI9Ql4zgJRsXayyKJrgPWw+FIcLJ
         /vwakp1XpyXakZQ6Sj/XrG7PVy5E+zNd3ZKWaSHWFcL6VYwaxCjw+lRRe7xnu1u8Hj
         3PNZX8rBHDio2fFFVVaFQC98vGHJ3urnUxsT1UciUIA+TILygskp8oPbYGJ+p8dMLs
         jACWLkurLFdxQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 29, 2020 at 11:09:43PM +0300, Yishai Hadas wrote:
> On 9/29/2020 10:27 PM, Jason Gunthorpe wrote:
> > On Tue, Sep 22, 2020 at 11:21:01AM +0300, Leon Romanovsky wrote:
> > 
> > > +	if (!*dma_addr) {
> > > +		*dma_addr = ib_dma_map_page(dev, page, 0,
> > > +				1 << umem_odp->page_shift,
> > > +				DMA_BIDIRECTIONAL);
> > > +		if (ib_dma_mapping_error(dev, *dma_addr)) {
> > > +			*dma_addr = 0;
> > > +			return -EFAULT;
> > > +		}
> > > +		umem_odp->npages++;
> > > +	}
> > > +
> > > +	*dma_addr |= access_mask;
> > This does need some masking, the purpose of this is to update the
> > access flags in the case we hit a fault on a dma mapped thing. Looks
> > like this can happen on a read-only page becoming writable again
> > (wp_page_reuse() doesn't trigger notifiers)
> > 
> > It should also have a comment to that effect.
> > 
> > something like:
> > 
> > if (*dma_addr) {
> >      /*
> >       * If the page is already dma mapped it means it went through a
> >       * non-invalidating trasition, like read-only to writable. Resync the
> >       * flags.
> >       */
> >      *dma_addr = (*dma_addr & (~ODP_DMA_ADDR_MASK)) | access_mask;
> Did you mean
> 
> *dma_addr = (*dma_addr & (ODP_DMA_ADDR_MASK)) | access_mask;

Probably

> flags. (see ODP_DMA_ADDR_MASK).  Also, if we went through a
> read->write access without invalidation why do we need to mask at
> all ? the new access_mask should have the write access.

Feels like a good idea to be safe here
 
> > > +		WARN_ON(range.hmm_pfns[pfn_index] & HMM_PFN_ERROR);
> > > +		WARN_ON(!(range.hmm_pfns[pfn_index] & HMM_PFN_VALID));
> > > +		hmm_order = hmm_pfn_to_map_order(range.hmm_pfns[pfn_index]);
> > > +		/* If a hugepage was detected and ODP wasn't set for, the umem
> > > +		 * page_shift will be used, the opposite case is an error.
> > > +		 */
> > > +		if (hmm_order + PAGE_SHIFT < page_shift) {
> > > +			ret = -EINVAL;
> > > +			pr_debug("%s: un-expected hmm_order %d, page_shift %d\n",
> > > +				 __func__, hmm_order, page_shift);
> > >   			break;
> > >   		}
> > I think this break should be a continue here. There is no reason not
> > to go to the next aligned PFN and try to sync as much as possible.
> 
> This might happen if the application didn't honor the contract to use
> hugepages for the full range despite that it sets IB_ACCESS_HUGETLB, right ?

Yes

> Do we still need to sync as much as possible in that case ? I
> believe that we may consider return an error in this case to let
> application be aware of as was before this series.

We might be prefetching or something weird where it could make sense.

> > This should also
> > 
> >    WARN_ON(umem_odp->dma_list[dma_index]);
> > 
> > And all the pr_debugs around this code being touched should become
> > mlx5_ib_dbg
> We are in IB core, why mlx5_ib_debug ?

oops, dev_dbg

Jason
