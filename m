Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95523280830
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 22:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgJAUBs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 16:01:48 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:40064 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbgJAUBs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Oct 2020 16:01:48 -0400
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7635a90000>; Fri, 02 Oct 2020 04:01:45 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 1 Oct
 2020 20:01:45 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 1 Oct 2020 20:01:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJl8OVpl+tQL2YJUrB9qNnozOlsBf/UndDe9z0CSa8vxNJGCE1erovmZ4L92qZnF7n1DpDhG2SDx0kKMiLdvqolOd/nLfQ/MWtP+myXH4lxV3iNwQhbpbHkVf4J2cYqdIQq8hNZRZCI0i84EO3gVnayWk4FCO9BwYBL/ctaRyUYbKbdtUOPJUrQyTY2MS3O1f0eoLWJV3Gizv2XohSDP8D4ZzZp0P/5ttzgV6ixkdE+Kmgj4duadBJdBZvCQSIOulPDP1xMZXw1sI9eKa442IfcMPM9KS2pGVEBtd1ljZO67oqYJ79uymJgMfvvJk2k5QWgspky++maRdhQ6VSWK7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2urjXtS0r5DGIh1JfHdeb6M0Vh9Y3pT6Xl+YnaOer6c=;
 b=ofHAH0EQ4g8iJx95p1KcjJfzC/YEAf7Ow5dXJNkX9wORdziFSFIosuylQlX+AB0T3lG/sLE7PvbnBhsepPdJ6nl4q4KliXpCZnb/0mkcT5hdEIcCbdktDZ6KKRixVgNNtYgvTr6PuRmVGC55o3ucdo+mdEohAWYgKjlP6Hkje8P8212WJJd8zjdqWTDfGxLXldg4Xr4G0VOww0r68cMLdjNPY4ANYZSgS4OvE0PsR21iw8oD3ghgo1AyA48JEDtUrTptcL9Ow5bzBPJIWkRUmXIilvZolkquTD0vE9JPORf1pQT2u36vLWKF6O6fhjr0tZ3Nr1kny8Wn1zmQD8RP5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3019.namprd12.prod.outlook.com (2603:10b6:5:3d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Thu, 1 Oct
 2020 20:01:43 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 20:01:43 +0000
Date:   Thu, 1 Oct 2020 17:01:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-rdma@vger.kernel.org>, Yishai Hadas <yishaih@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH rdma-next v3 0/4] Improve ODP by using HMM API
Message-ID: <20201001200142.GA1185894@nvidia.com>
References: <20200930163828.1336747-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200930163828.1336747-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:208:2d::48) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:208:2d::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36 via Frontend Transport; Thu, 1 Oct 2020 20:01:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kO4lq-004yYA-4P; Thu, 01 Oct 2020 17:01:42 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601582506; bh=2urjXtS0r5DGIh1JfHdeb6M0Vh9Y3pT6Xl+YnaOer6c=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=rBp7Yk87LAW83ulA4HM8H3USPwcdxhsX4SoN8TruzB2dcGMs9e959kyftVoJK4qXS
         i7X4FBkuInRKqQdmRaXa7djl8phj3BNwEB98PLE1qa+g1bMKkV7M5MkvWqbIYfrnAW
         tSZb93c42db2o241WwEEeIhMhriOPztT7Dgxvz7qPOCvpv1QI0CjMkEZvPpPanhNb8
         qV8GbIhIkSL1npiI6MmI+GhajlFtqlmlkF0Q/N9K3F/DSe1MwlP5OYwmmiCcKpMKVh
         ZAFEAM/rgZuYBZp5S4hki8CMwgq9SKaPAuP+u2nFmxhfqqZhUw7dPhNH1z5cCBzjWV
         GDufEiBLoJUuQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 30, 2020 at 07:38:24PM +0300, Leon Romanovsky wrote:

> This series improves ODP performance by moving to use the HMM API as of below.
> 
> The get_user_pages_remote() functionality was replaced by HMM:
> - No need anymore to allocate and free memory to hold its output per call.
> - No need anymore to use the put_page() to unpin the pages.
> - The logic to detect contiguous pages is done based on the returned order
>   from HMM, no need to run per page, and evaluate.
> 
> Moving to use the HMM enables to reduce page faults in the system by using the
> snapshot mode. This mode allows existing pages in the CPU to become presented
> to the device without faulting.
> 
> This non-faulting mode may be used explicitly by an application with some new
> option of advice MR (i.e. PREFETCH_NO_FAULT) and is used upon ODP MR
> registration internally as part of initiating the device page table.
> 
> To achieve the above, internal changes in the ODP data structures were done
> and some flows were cleaned-up/adapted accordingly.
>
> Thanks
> 
> Yishai Hadas (4):
>   IB/core: Improve ODP to use hmm_range_fault()
>   IB/core: Enable ODP sync without faulting
>   RDMA/mlx5: Extend advice MR to support non faulting mode
>   RDMA/mlx5: Sync device with CPU pages upon ODP MR registration

Applied to for-next, thanks

Jason
