Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037552927A0
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Oct 2020 14:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgJSMs3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Oct 2020 08:48:29 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10015 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgJSMs3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Oct 2020 08:48:29 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8d8b100000>; Mon, 19 Oct 2020 05:48:16 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Oct
 2020 12:48:25 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 19 Oct 2020 12:48:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hF7H+jjQcIC+On4awhe88ABEydw3iE9+cLllNG1e4Bzqn4qMLtJMTHTj5RpsjFSdS7t0HsvFjbhGZg0xYUmTHsxn8GPncKEOX5WAdIdJfbcHsIvrASasEpC61Bsvp6IlX2mIRfGNis3DPnkIKvO4GBc8NfeJ435aD9igfHN9lGq+hEKi03/FrVzDj9cl4+NQJzxT1LdBtUt4DkKrRDkq2icTY+oNnhOb+p6n5xjRQ5H9RInIqND5y16EoAAbQiE3qwRSSliRiBevYfvSnVUZVRcMCC1kzc9kKZTF3/jFotDlz9PW56AMs+5qZ1l6dr4Q4jGNAkmk6rrgMS7SRJms0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/7WLQqvHv1CWNTJdrw67VFanbPup419Pg7LCGtNHDE=;
 b=dCURY8PxDA5a1heOGW9UvaOyguRtYOgeeqGXtPCrMRgFLybqgLTU5dorIeF06skLX4A3aDm7gQ1v71hwqTyUrojeqpa3R4yALhQH15As2DNZwfLTmEoaU05Pw+R7SbbdAktZt4fudBp/UE/+5CZ3JpCFhuQEWu7biO+usXkIUWfh+dnmVF3hr64TsMus+RAb7lyyY3g79obFtUxaWi5wqG7ChM33igIBaEgn/7ORoaReQD1qecL/How2VDui6X8pcjUcqjqOHFcmr+CjTBBjc1UGtK9f7jrLBxiQmgHpGTNfWC6z0xrrGsPzkwP4e20X4lwaxkBEMa2v6llIGihtxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Mon, 19 Oct
 2020 12:48:24 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 12:48:24 +0000
Date:   Mon, 19 Oct 2020 09:48:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
CC:     "Ursulin, Tvrtko" <tvrtko.ursulin@intel.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Gal Pressman <galpress@amazon.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: dynamic-sg patch has broken rdma_rxe
Message-ID: <20201019124822.GD6219@nvidia.com>
References: <20201014225125.GC5316@nvidia.com>
 <e2763434-2f4f-9971-ae9d-62bab62b2e93@nvidia.com>
 <63997d02-827c-5a0d-c6a1-427cbeb4ef27@amazon.com>
 <8cf4796d-4dcb-ef5a-83ac-e11134eac99b@nvidia.com>
 <20201016003127.GD6219@nvidia.com>
 <796ca31aed8f469c957cb850385b9d09@intel.com>
 <20201016115831.GI6219@nvidia.com>
 <9fa38ed1-605e-f0f6-6cb6-70b800a1831a@linux.intel.com>
 <20201019121211.GC6219@nvidia.com>
 <29ab34c2-0ca3-b3c0-6196-829e31d507c8@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <29ab34c2-0ca3-b3c0-6196-829e31d507c8@linux.intel.com>
X-ClientProxiedBy: MN2PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:208:120::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR10CA0004.namprd10.prod.outlook.com (2603:10b6:208:120::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Mon, 19 Oct 2020 12:48:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kUUaM-002Ies-Tm; Mon, 19 Oct 2020 09:48:22 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603111696; bh=O/7WLQqvHv1CWNTJdrw67VFanbPup419Pg7LCGtNHDE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=dy7QDfnrxO8iHDh6z6zo6wlwDXzDmGXSdX3iiBwOGAIJo5mkkHxmBTgI+uYlGzHlS
         kDfCkrJwm+ic6d+RTxIFmL6eS3M7i5QvUGrg/q2gcxtArJRAEkQK6QExA1u5viT8Bn
         RuqAu2HA1pEL13p2BEKxPvnPjtZUmTjx+YNGX4B33jl+9ipKTZURayk4WQx+ZNl6xj
         X60iMaWHmb5yZlxGe9ScfpHck+9CLjE1C6AdWeooByh6TXiH9I678kgFXb4IQCjnLB
         ect0zNFf0Vwj9X1hwSh6tBXgOWVKvQ8ihKwKJAY+jM5tzEjUIeo+iecaJoku7eGi9G
         w3OblT99NBXSw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 19, 2020 at 01:29:42PM +0100, Tvrtko Ursulin wrote:
> 
> On 19/10/2020 13:12, Jason Gunthorpe wrote:
> > On Mon, Oct 19, 2020 at 10:50:14AM +0100, Tvrtko Ursulin wrote:
> > > > overshoot the max_segment if it is not a multiple of PAGE_SIZE. Simply fix
> > > > the alignment before starting and don't expose this implementation detail
> > > > to the callers.
> > > 
> > > What does not make complete sense to me is the statement that input
> > > alignment requirement makes it impossible to connect to DMA layer, but then
> > > the patch goes to align behind the covers anyway.
> > > 
> > > At minimum the kerneldoc should explain that max_segment will still be
> > > rounded down. But wouldn't it be better for the API to be more explicit and
> > > just require aligned anyway?
> > 
> > Why?
> > 
> > The API is to not produce sge's with a length longer than max_segment,
> > it isn't to produce sge's of exactly max_segment.
> > 
> > Everything else is an internal detail
> 
> (Half-)pretending it is disconnected from PAGE_SIZE, when it really isn't,
> isn't the most obvious API design in my view.

It is not information the callers need to care about

> In other words, if you let users pass in 4097 and it just works by rounding
> down to 4096, but you don't let them pass 4095, I just find this odd.

That is also an implementation detail, there is nothing preventing
smaller than page size other than complexity of implementing the
algorithm. If something ever needed it, it could be done.
 
> My question was why not have callers pass in page aligned max segment like
> today which makes it completely transparent.

Why put this confusing code in every caller? Especially for something
a driver is supposed to call. Will just make bugs

Jason
