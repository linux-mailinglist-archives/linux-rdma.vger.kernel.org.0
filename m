Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50DF27DD79
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Sep 2020 02:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgI3Ahu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 20:37:50 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:5651 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728799AbgI3Ahu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Sep 2020 20:37:50 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f73d35c0000>; Wed, 30 Sep 2020 08:37:48 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 30 Sep
 2020 00:37:47 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.50) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 30 Sep 2020 00:37:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcRqCzNHDgkAPpCJMNEbR6N1cxzm0aY38S3QvYBe1UNS8fzmIhdh1AIMSCzRD/QEYl0CgC/+7on1sdrd8mCqz1iRfpuhYq8xL8RaK6d/RXLRJfQR4jLamgIrKLMMf3UOdUKdD4LOQ5v7CtpY5qLWefryM+2cx1N2BXFY8pp6yjf3OF0oKQZsou5nTyjINNdxvgxuiJ+Ket/SLUEsQochHuY7mZc172BsH8S3QjL6i+b8xxyVHsOmKm04a2i81Z+vjCaMSZKRIZ3oFGCafJ5c9X7OZ+V6CuVt16MwqWOU2WBFxxWP5f2iTpSlG6VqvKcvNGcpa3VCkxwyQry4h6V/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJnwHU2GrEWqRFYUvOoesQRpNnpDboCcRz7feo54yMk=;
 b=DaW6PEMUwGPitXDonplF+IvyCoIgrqN0qDk+N2exVUjwtVMLJFvrmLjicV2uXdSaz675K7rh7JMx4AuugDvj0hUMCLpMEv+62fFY57R7KLcYgHTFSxeTJbV2bE+SMPLRPuqXXhvmg0zgjeKiXRknRZz8owuOaVmP6Qz+p+OR+QnWLMKQGVNe0qzRTtVnem5IoyxzgPzT0lRTQAwYHzRN9HJTmEdi46V3LaaidctLDSYVL8JTn/YmDdMdo9iiQItZiZEgSX5XeNDqvwu9Ki7l9uYlTlKM2h/QAGKZCkxJRVJMkw4IJsai9wzfeuPQeCDcCW+cfJn82+jk9ZatFoYXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Wed, 30 Sep
 2020 00:37:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 00:37:45 +0000
Date:   Tue, 29 Sep 2020 21:37:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yishai Hadas <yishaih@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH rdma-next v2 1/4] IB/core: Improve ODP to use
 hmm_range_fault()
Message-ID: <20200930003744.GB816047@nvidia.com>
References: <20200922082104.2148873-1-leon@kernel.org>
 <20200922082104.2148873-2-leon@kernel.org>
 <20200929192730.GB767138@nvidia.com>
 <089ce58a-a439-79b5-72ac-128d56002878@nvidia.com>
 <20200929201303.GG9475@nvidia.com>
 <ec93e0f2-22c5-ac93-3a3a-8874ab7d8aa6@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ec93e0f2-22c5-ac93-3a3a-8874ab7d8aa6@nvidia.com>
X-ClientProxiedBy: MN2PR14CA0023.namprd14.prod.outlook.com
 (2603:10b6:208:23e::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR14CA0023.namprd14.prod.outlook.com (2603:10b6:208:23e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Wed, 30 Sep 2020 00:37:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kNQ7s-003lV7-1X; Tue, 29 Sep 2020 21:37:44 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601426268; bh=pJnwHU2GrEWqRFYUvOoesQRpNnpDboCcRz7feo54yMk=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Rwp5I94F2yAP0WoqTg6VcZ+jxe92mlvPRvKt+JypkfgJfutBWplpJ+5rELumgxIEJ
         nHBe97UoM4HJ0wjZ0pAejXE3dhzoRoxkD40lWjepZ6wfSiXmhOrCU+qjGl1EatxMVC
         0+L9379naVWwk95gmq5Tq7vvAKpqvgEAtP4uXUYyNnB3c1UXD9N3aQXBdPlKGi5h2m
         uygT7ZJ81vxDli3MbGV5+iGX13nyLuLgGjDJzvSg8Ftozkw0FlgI7V54FcrB4aO+ZH
         UCyZdVq4YzWkn5NwuCEt2V1BZ7q7VaA8kv3ZrQKAVXI9qb8KnXFCxA0D9ry3V2uUw8
         PsE5muhmrm+Aw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 29, 2020 at 11:30:24PM +0300, Yishai Hadas wrote:

> > > flags. (see ODP_DMA_ADDR_MASK).  Also, if we went through a
> > > read->write access without invalidation why do we need to mask at
> > > all ? the new access_mask should have the write access.
> > Feels like a good idea to be safe here
> It followed your note from V1 that the extra mask was really redundant, the
> original code also didn't have it, but up-to-you.

It wasn't hard to read from the diff that this was being done in all
cases, not just as the result of ib_dma_map_page(). This is why I
think it would be clearer with the control flow I suggested

> > > > And all the pr_debugs around this code being touched should become
> > > > mlx5_ib_dbg
> > > We are in IB core, why mlx5_ib_debug ?
> > oops, dev_dbg
> Can it can done locally ?

As long as the ib_device is avaiable the print function should be used

Actually it is ibdev_dbg() these days

Jason
