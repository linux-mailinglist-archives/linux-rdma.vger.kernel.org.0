Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB672EE641
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Jan 2021 20:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbhAGTj0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jan 2021 14:39:26 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:29927 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbhAGTj0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 Jan 2021 14:39:26 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ff763430000>; Fri, 08 Jan 2021 03:38:43 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 Jan
 2021 19:38:43 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 7 Jan 2021 19:38:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X34YTlMgxcC9ejn5lH/D7Dsz4HlLE85UmoR+p9msOaQ8JA5I7JEkJsSA4TBNBTNCUfQUoztJs6BGj7J6dF1Vp1odMm+/h8j0Gw67kCvGsxNyKghMbKkepj/0HLtG8WeL17kmVhe3Zv0VpHLExZ4Z92ZOHkTfHzAQFZGaG/p0H8Vs/Ja/5OcCLspDvqHfEICvfP+0o2iHeuBqkBT5xl88QC7DFZ8kqc+9mQPcPOMFUDNbkOYzdp35d1Ph3APEy6nuWNv0fHVcw2km/IX1BVMFw/bO7FH0C7nQ3+eJFrlZ9Dl4tVaAcHrnePQZpLgETsLlqfCIWkmyircNs0jSFxWlzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d19fFuf1Whs+B6ehzCnOa+YJgXMJPQ73bI+xC5dodVY=;
 b=hxCIEvwijkvxCkTKgAN7xH3Z2UHssvAc0y/AgVTleqrQWJ05mJI3RZJdn7MKiQHWaeCTTeFXV/U6o3tTLgLQP/Aw7I9B1yQE2yKZj3/ITPwo8fDNPWH6mILI/KMxcfC05DEzRih0DAS/vu10N3QFzyUCcYPRar+P6oDjRov0GI7Hv7dgRxgkdTo0Ke1p9yWLrFk5gLxuIZ+Du61qS0rIjtBIANpVCe83eAlt6hVkemtX4ijDOZQGwKM2Gr5B0S4DvvvmHRl2jgyPyd1XCCRLZiY3Akt0oWR9xGrYR7Gjn7ZHXMWlKvJ7j2dFN0o5X6a3iH5Kw4qzpjiKSp7wns16LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1755.namprd12.prod.outlook.com (2603:10b6:3:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19; Thu, 7 Jan
 2021 19:38:40 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.008; Thu, 7 Jan 2021
 19:38:40 +0000
Date:   Thu, 7 Jan 2021 15:38:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <leon@kernel.org>, Kamal Heib <kamalheib1@gmail.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3] RDMA/siw: Fix handling of zero-sized Read and Receive
 Queues.
Message-ID: <20210107193838.GA921419@nvidia.com>
References: <20201216110000.611-1-bmt@zurich.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201216110000.611-1-bmt@zurich.ibm.com>
X-ClientProxiedBy: BLAPR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:208:329::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0080.namprd03.prod.outlook.com (2603:10b6:208:329::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 19:38:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kxb7G-003ris-UQ; Thu, 07 Jan 2021 15:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610048323; bh=d19fFuf1Whs+B6ehzCnOa+YJgXMJPQ73bI+xC5dodVY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=l0mXKImGvTQn2GJMlLiQO7Wn9anV9L89MoYNGKBzZOIE1uF8voe5PKtbpCbpVEs4X
         GJlynBtnbMfLNWsVEnohcYXIo0ZLQz/MSk3TETRhihfKSkzD7nrxxCeFrB1Ag0jJjK
         RxMxRCJlaNLUdc7ONYwHUTUK2nW6wiTDxwhDXHndUej/0LRh4qtpUBg7PzVb6xaWr5
         SIDOFLPGL8QV2Kb2TAQH2DoNpISwzmBHaq0YuXCsA5RaLGhT2H0iUna/cYSJf7H3az
         dWXeqbRsV3CjKjyOudjoQFdSKB3nFLVmmNt6zlp0vNbeVvH6CaOb4dv2C8EHo9r7Y4
         eQURz7+WwSqLA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 16, 2020 at 12:00:00PM +0100, Bernard Metzler wrote:
> @@ -933,6 +937,7 @@ int siw_activate_tx(struct siw_qp *qp)
>  
>  		goto out;
>  	}
> +no_irq:
>  	sqe = sq_get_next(qp);
>  	if (sqe) {

Can you please arrange this without the spaghetti goto's? goto is ok
for error unwind at the tail of the function, but should not be used
willy nilly. Move some of this into functions, use normal if
statements, etc.

Jason
