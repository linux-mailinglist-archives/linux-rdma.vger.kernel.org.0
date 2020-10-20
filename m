Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F53293D5C
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Oct 2020 15:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407474AbgJTNc0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Oct 2020 09:32:26 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:60039 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407304AbgJTNc0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Oct 2020 09:32:26 -0400
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8ee6e80001>; Tue, 20 Oct 2020 21:32:24 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Oct
 2020 13:32:19 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.50) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 20 Oct 2020 13:32:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alvKB3xZ1016OZAMcax76pqQ59NphoBT+a2zraaOiuKxDnFjK8Fq78NKQtS/jzGKh5Pg8cxYG3ZjDgn+1vmUJmIKQ38N2gsBwri/VTdhuylnh9QTcamaSvl4f1n0DEdvqfozXdy6bgNRs+y8CDGl/TwtS2wr2YZPmimMQF0n8DV5OUKgpcBvKsv/KAQC0u9/VvtfQyke30ld9VFk5xAmzZTCPjm+HHHS4GpZpQfEsp47UsUDF2CVL+lADlZGe8RdfqowdfQy2QryuYWP7BNW9g4mnzcZbIm4zPAuLB+5dmhFsx8wsQg3td+XlGnk/WMJXRayXXXaF5ZR8fuTNcmUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGn/kjOvdjBgxFrycW/9Ps2RG7qrbToRxp0O3HyqtjA=;
 b=gINenzCN689Us1ouzwjQdGtlKS7J4KheoH7SjSP2xd7nN6GUthlMsutHrfeqF7otDkHxs6tdMKYkI6nQ9Fgn0ObjQ193+Z3fmEkgAnm7tDbIKBfrtQWHpl89VkjwJeqebFZQG5GbOp545XNW1TCyVVnapbequolwAhYwnZRn3oH3jOHnqFytpbrduEk2EXTSmMk00cFgxkpiKNp6dNNFfuBm9EsE7/pREzzz5/cNttqGcJ931b5osoYJcyrcKvb/KX89lN8Pc0L1NwquSMEOrqxINhLUnf+K7ziAJE9LMqilPUsTR3nVG146UtqtkCB5r7E4ZfA0E2AVcSuv1z0UIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Tue, 20 Oct
 2020 13:32:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 13:32:08 +0000
Date:   Tue, 20 Oct 2020 10:32:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
CC:     Maor Gottlieb <maorg@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        "Gal Pressman" <galpress@amazon.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "Leon Romanovsky" <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: dynamic-sg patch has broken rdma_rxe
Message-ID: <20201020133207.GF6219@nvidia.com>
References: <20201016115831.GI6219@nvidia.com>
 <9fa38ed1-605e-f0f6-6cb6-70b800a1831a@linux.intel.com>
 <20201019121211.GC6219@nvidia.com>
 <29ab34c2-0ca3-b3c0-6196-829e31d507c8@linux.intel.com>
 <20201019124822.GD6219@nvidia.com>
 <03541c89-92d0-2dc8-5e40-03f3fe527fef@linux.intel.com>
 <20201020114710.GC6219@nvidia.com>
 <c64bc07a-ed95-f462-a394-4191605c05b9@linux.intel.com>
 <20201020125659.GD6219@nvidia.com>
 <3eb34c54-1d19-8a4e-f391-e422fbca587d@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3eb34c54-1d19-8a4e-f391-e422fbca587d@linux.intel.com>
X-ClientProxiedBy: BL0PR02CA0092.namprd02.prod.outlook.com
 (2603:10b6:208:51::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0092.namprd02.prod.outlook.com (2603:10b6:208:51::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23 via Frontend Transport; Tue, 20 Oct 2020 13:32:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kUrkF-002w57-I7; Tue, 20 Oct 2020 10:32:07 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603200744; bh=LGn/kjOvdjBgxFrycW/9Ps2RG7qrbToRxp0O3HyqtjA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Bax+94yVfg4OE6v1KGA3dYaIsQQV1+BrEs37/I3bukF71YsHpyuemU0J2OtUkMaTd
         mXFyH37rESb4z2pGfzeu/16ZHuvyI3uo6jsEuoBe0DcKG69nUkZhvX8XNHIJCrjr5h
         1/CONQ9MR2jU+GBbhbKhLnGvmjLVpSxpiaLIYWf4XhVKWldHk1F1eMXP9ERNHA4OVd
         xh5aDe2z9bpt0+5PewSXwxKSjeijJVM2gMxdDzKPuiKLNDzQI/KlZrC5A1Cg0ynM4q
         RHXJ05tn+ZBUKLNt7thxeIpqd1fAOZhTMm/YY2VvrjcP2kJDL/9kALUEhVxcJEY1ov
         zXiaHt8IzsJbg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 20, 2020 at 02:09:23PM +0100, Tvrtko Ursulin wrote:

> Not just the max, but the granularity as well. If byte granularity (well
> less than PAGE_SIZE/4k) exists in some hw then I agree the API change makes
> sense.

scatter/gather lists are byte granular in HW, this is basically the
norm.

Page lists are something a little different.

At least in RDMA we use scatterlist for both types of objects, but
their treatement is quite different. For page lists the
max_segment_size is just something that gets in the way, we really
want the SGLs to be as large, and as highly aligned as possible.

Fewer SGE's means less work and less memory everywhere that processes
them.

When it comes times to progam the HW the SGL is analyzed and the HW
specific page size selected, then the SGL is broken up into a page
list. Each SGE may be split into many HW DMA blocks.

Again, this has nothing to do with PAGE_SIZE, the HW DMA block size
selection is HW specific and handled when splitting the SGL.

Jason
