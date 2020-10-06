Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F005D285032
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 18:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJFQyN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 12:54:13 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4500 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgJFQyN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Oct 2020 12:54:13 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7ca0c90000>; Tue, 06 Oct 2020 09:52:25 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 6 Oct
 2020 16:53:50 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 6 Oct 2020 16:53:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HW0ASTe8RdQeEBPSxKhT+Wrou5xS0y+22zEcEOjzW6TwPWkJW6sWnMJBv8FM9PGvr3b91G7t6xxMR/cpSshcp3d/wy41JJr0ZvVgVejcU+zzTwmZuHcVI/k27XewwCRd3VmTeMOxkEHA7/yDZRqQLJjdR53YInbz8j+BlH2lf5A5DS5sf1CljnBGfxk6qzkCRJlF+6Ai0fXcrlnu56A4VkBs/p7NZELkvzWooEGxsJSMjdZEa+a4y4MXIzBIM1SjbGMoO/hZLoyXjNtqJaXGlvJvjEe0BiZaoNsdWrzYc0JOALnu09VGY+8/r9j8cqWD+HPkIDGJpxx0Rsc4yl6YAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3gWf/vUiyto7B5yHqS50PXTMF5mW2Yc2Hdq8Bfjeb4=;
 b=Ht697lJcxb03xikCEULjpkBKG6yKUn2cxO63elyTRmUAOeePJBR4cMGjgvyb3jHnUTcqgkQ0VV8CCuCmRr74nwxX9VajLjasc4k4bLEf3QHbdnVPRrTO8U+JfPMEpGnklYY1FjuMaqrL7CZn++J7GYXw6E+MfPr/DM9QR6BQGdQGcOAwuMM0Nt37wqojGkYN2lSommZBxecaPeK9/fvYU2R14LAhojwDi5P+0TOkPzGjksqC4rQoUETsIzgsE92VypwllnAcR38vi8zU+jE5zHqbL+Zmacfe61QqrZIq7/06izZAWyCyGwF9Lw5Q/lY50TVkamtKfvRVU37rpndB8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1435.namprd12.prod.outlook.com (2603:10b6:3:7a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Tue, 6 Oct
 2020 16:53:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.044; Tue, 6 Oct 2020
 16:53:48 +0000
Date:   Tue, 6 Oct 2020 13:53:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        "Ariel Elior" <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "Christian Benvenuti" <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Lijun Ou <oulijun@huawei.com>, <linux-rdma@vger.kernel.org>,
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
Message-ID: <20201006165346.GK4734@nvidia.com>
References: <20200922082745.2149973-1-leon@kernel.org>
 <20200923053840.GA4809@infradead.org> <20200923183409.GA9475@nvidia.com>
 <20200924054907.GA22045@infradead.org> <20200924114940.GE9475@nvidia.com>
 <f20a4639-7674-8d2c-66dc-ebc028b14ef0@acm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f20a4639-7674-8d2c-66dc-ebc028b14ef0@acm.org>
X-ClientProxiedBy: BL0PR02CA0099.namprd02.prod.outlook.com
 (2603:10b6:208:51::40) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0099.namprd02.prod.outlook.com (2603:10b6:208:51::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36 via Frontend Transport; Tue, 6 Oct 2020 16:53:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kPqDi-000bI2-It; Tue, 06 Oct 2020 13:53:46 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602003145; bh=Q3gWf/vUiyto7B5yHqS50PXTMF5mW2Yc2Hdq8Bfjeb4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=ZuZkrt2JWz36EQ5+dY5g4GpPRRodwgas12LFamFm5BgPBgufT5lruBE5rL2duOybl
         HchkfWC8hAf3z9S/GsM8bK9ZXrn9STmjer3dhoLcfcFcudaJprSR+bBV1U1QohFAbl
         CLSv8n2jL4kGCyXLqJeN7OPVz0ROhuh4QZS+MzDpuNz/B7PxegwJvo0V3UALbBoZSk
         VoScNfwkaiQsN8BNt0NZ28ShhG4QnQ8pZwPTvuIMzTt86bkudJ/wrMQz0ZOHII18ED
         VsW7OuhzKOQIXyeG4JgT0BW+UH3AXtO8ucG8w8wxWjZAa6WHyLGjwPXk2W/sJhwErH
         3rkpOgTspXaCw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 06, 2020 at 07:29:16AM -0700, Bart Van Assche wrote:
> On 9/24/20 4:49 AM, Jason Gunthorpe wrote:
> > On Thu, Sep 24, 2020 at 06:49:07AM +0100, Christoph Hellwig wrote:
> > > > > > +	} else {
> > > > > > +		device->dev.dma_parms = dma_device->dma_parms;
> > > > > >   		/*
> > > > > > +		 * Auto setup the segment size if a DMA device was passed in.
> > > > > > +		 * The PCI core sets the maximum segment size to 64 KB. Increase
> > > > > > +		 * this parameter to 2 GB.
> > > > > >   		 */
> > > > > > +		dma_set_max_seg_size(dma_device, SZ_2G);
> > > > > 
> > > > > You can't just inherity DMA properties like this this.  Please
> > > > > fix all code that looks at the seg size to look at the DMA device.
> > > > 
> > > > Inherit? This is overriding the PCI default of 64K to be 2G for RDMA
> > > > devices.
> > > 
> > > With inherit I mean the
> > > 
> > > 		device->dev.dma_parms = dma_device->dma_parms;
> > > 
> > > line, which is completely bogus.  All DMA mapping is done on the
> > > dma_device in the RDMA core and ULPs, so it also can't have an effect.
> > 
> > Oh. Yes, no idea why that is there..
> > 
> > commit c9121262d57b8a3be4f08073546436ba0128ca6a
> > Author: Bart Van Assche <bvanassche@acm.org>
> > Date:   Fri Oct 25 15:58:30 2019 -0700
> > 
> >      RDMA/core: Set DMA parameters correctly
> >      The dma_set_max_seg_size() call in setup_dma_device() does not have any
> >      effect since device->dev.dma_parms is NULL. Fix this by initializing
> >      device->dev.dma_parms first.
> > 
> > Bart?
> 
> (just noticed this email)
> 
> Hi Jason,
>
> That code may be a leftover from when the ib_dma_*() functions used &dev->dev as
> their first argument instead of dev->dma_device. 

Hmm the above was two years after the commit that added dma_device? I
assumed you added this because you were doing testing with rxe?

Jason
