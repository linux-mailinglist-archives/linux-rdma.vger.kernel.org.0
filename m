Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2394B280BAC
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 02:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgJBAcY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 20:32:24 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14184 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgJBAcY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Oct 2020 20:32:24 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f76750b0001>; Thu, 01 Oct 2020 17:32:11 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 2 Oct
 2020 00:32:20 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 2 Oct 2020 00:32:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nzs4CC/qH5xgnP/K2O2+YJWnqGgFtYqJpJ/EbTflYvBF1L5Em8RIucw3twxWPqFV9kX2nMe1aLPxWW47Viqt8lR/Kjh73lhd0q+wX1D7HstoQE/wYpjmEYHusBO+CWJi4CtHIPOs4AEE++H1r78kxf873PuCEP5SHIuItSrcHclyxhwOvj4Y3S+gF6Mh8dc9DLmh6/uaciaAl1Ilmc/lI2U5Sbaj/muPAN19uI1OrVMskiUxKQRWs8vBoTapTdvMYFfUCADX96nU3B0+p4QAyaNSdWN1gfE+Plxx0+snKEd06WPPsXC5uNCy1LQhxF+BGJ8mba+isdTr1hrhSK8YZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14XtM+KY2sPrerOwS5cckWzQsS8YTdrpHZ0ilRVRB5o=;
 b=WvVbQxfjoR8SanaJCXZvUmrV1IGTCvT64D5tZrgJfFVP9suWBZVBH4UXmv5tVUuZHleZ2m/C3aBDWQVtS//hGOv+JdnJPbHxlvST1xM5rvnvmRQzFWiibH6u2hwuryxS9bO34sJjOUVvWdkzUU54ScSByizpthYapeDARGogweLxx1Our1tXII57Rp305f4BJZfJ1Qx2/CoNcj0N7Z4uuwdht1hvDEe7SCIHIIPL9vbHsaqaFtFoSSOCc3CuAiHbbUU5ULUXv0gA9kQNGsz+0JCOjFDkKTjed0Rw3bj7nO2OJ25d7Yt/eq6NoxAhZwA0IWmmjTAAHePB3T831GEigQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1433.namprd12.prod.outlook.com (2603:10b6:3:73::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Fri, 2 Oct
 2020 00:32:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Fri, 2 Oct 2020
 00:32:19 +0000
Date:   Thu, 1 Oct 2020 21:32:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Ariel Elior <aelior@marvell.com>,
        Avihai Horon <avihaih@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>
Subject: Re: [PATCH rdma-next v3 0/4] Query GID table API
Message-ID: <20201002003218.GB1286456@nvidia.com>
References: <20200923165015.2491894-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200923165015.2491894-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR02CA0129.namprd02.prod.outlook.com
 (2603:10b6:208:35::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0129.namprd02.prod.outlook.com (2603:10b6:208:35::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36 via Frontend Transport; Fri, 2 Oct 2020 00:32:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kO8zi-005OgV-3L; Thu, 01 Oct 2020 21:32:18 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601598731; bh=14XtM+KY2sPrerOwS5cckWzQsS8YTdrpHZ0ilRVRB5o=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=lZMFov+H43OpFvgCab0iLaZWz+bBuG6RW3Grye5AQYMS9xjW0Ri6wcAHkxmQKu+v/
         Levz/81TzqjPXiXIEMoZVzozH37sFlcGMhdQpYvl6C11nXzYMeYaXdxR+ADgWUBVVk
         jhSzC2enLgOmrtiRBv+OPEyBp64M8kUXD9x3wvgsufS7bHNIh50JVjxu6h4VTuOmgc
         pyjymbJXD+7rgzqEKEK0nIaYXRqa8avReANJyfv6+ra6Z7f8EfqHMXg3meZx0V06t+
         vMTfHBwBpisWGZio42aMg7W9QrxnoQMx7tNBdGfYFTqR3WaZf0Vt7W4iRuYRTIR7xS
         11HZyL7OY/YUg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 23, 2020 at 07:50:11PM +0300, Leon Romanovsky wrote:
> When an application is not using RDMA CM and if it is using multiple RDMA
> devices with one or more RoCE ports, finding the right GID table entry is
> a long process.
> 
> For example, with two RoCE dual-port devices in a system, when IP
> failover is used between two RoCE ports, searching a suitable GID
> entry for a given source IP, matching netdevice of given RoCEv1/v2 type
> requires iterating over all 4 ports * 256 entry GID table.
> 
> Even though the best first match GID table for given criteria is used,
> when the matching entry is on the 4th port, it requires reading
> 3 ports * 256 entries * 3 files (GID, netdev, type) = 2304 files.
> 
> The GID table needs to be referred on every QP creation during IP
> failover on other netdevice of an RDMA device.
> 
> In an alternative approach, a GID cache may be maintained and updated on
> GID change event was reported by the kernel. However, it comes with below
> two limitations:
> (a) Maintain a thread per application process instance to listen and update
>  the cache.
> (b) Without the thread, on cache miss event, query the GID table. Even in
>  this approach, if multiple processes are used, a GID cache needs to be
>  maintained on a per-process basis. With a large number of processes,
>  this method doesn't scale.
> 
> Hence, we introduce this series of patches, which introduces an API to
> query the complete GID tables of an RDMA device, that returns all valid
> GID table entries.
> 
> This is done through single ioctl, eliminating 2304 read, 2304 open and
> 2304 close system calls to just a total of 2 calls (one for each device).
> 
> While at it, we also introduce an API to query an individual GID entry
> over ioctl interface, which provides all GID attributes information.
> 
> Thanks
> 
> Avihai Horon (4):
>   RDMA/core: Change rdma_get_gid_attr returned error code
>   RDMA/core: Modify enum ib_gid_type and enum rdma_network_type
>   RDMA/core: Introduce new GID table query API
>   RDMA/uverbs: Expose the new GID query API to user space

I made the edit to fix the locking, please check it

Applied to for-next

Thanks,
Jason
