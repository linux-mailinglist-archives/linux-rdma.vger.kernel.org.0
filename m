Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D05469E55
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 16:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357812AbhLFPiK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 10:38:10 -0500
Received: from mail-dm6nam08on2084.outbound.protection.outlook.com ([40.107.102.84]:43042
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1376946AbhLFPeC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Dec 2021 10:34:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTCl5qk6F9KvCis2G75hNCzkwd3ZPo7iiHX4s52R0AA19FDAGkiNyXY3IAhojABuphQngbC8kitqFf/Xtvc4LUtTSAZ6TDxgBHtErRsNWGV/FAJ4ZLDH3LkIn9QtUxdDB8Ra17TnIGjlYnRdENzfc7kwaFBRF7U4+k/s3f5DxUF3KxU2+tpSThVWX71+InvlU0LUVaOVB6K4PWLKmduot6P9Qgfv73mc2I1CZZtlts+GbY4Fr4gmhf+GaM/NIwyrJ2sAxUXlrWOSrA+4I7CbsElgtrOddnwcOkd2Nc+7a8opJT5mhyygzxXUj/m12omY4NcyWBIVEplsXtwiwA0EQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0tuwSJwlq9TGkCcM72yPmy8h7q/aGMzcRLeQOzH/DE=;
 b=Mk8VLK4HjjWBMxxCekGXCDbG7cP60vUx8kAVBPdO2dRGJrPGocv3mI7ddP1Fczm+Y1fnh5vskhia/VOWvNyRxzTRxQQHLPDkc6m5UgnqeagRankwSDQe7IyPH8/RnsgcSht5f6piPtqRhuw3h8/rHf5K5/oO9mlKVyp+AlEf1kUpkzMTMTd4JrUfRl4owX9P/nSsgHbc++DC0y4N8nqnUhKZJE1VgfVxvSoJBuXS0QcPfUzQVL/n+vtEBxcfKgsLdsB1gDrSXZuC+C+gUusR5KPRZQgIUBRcLGrj3YsSPb4HzPuVBGJGAX9ae3lH3nT6adatF4UjPBFu5FZv9zX5Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0tuwSJwlq9TGkCcM72yPmy8h7q/aGMzcRLeQOzH/DE=;
 b=Pno5CENEB7IJ99DE6gP4ng74SgEQO6Zm8SW1HII5DMi1uhBGcTMorOXrENh6YJ0UZ45epq4O7SwbAZIIQmQGSkA/z+p+u3iGqxnfSlkcoc+gPyLy8e2bIwrshbpoweRdlGGC0Rozd7NJv72/SXzJM7I3y+jo1cF+BjgYFHZew4CfCCMqWwdNSnbBcOctHGLzkOtJxGimvaBRv/O8ppJNwdYJDENuwPcC8CaSTF/EnzR3vTNf1a3mcDuZNe3hWthNIUls/YM15JOZlnnPdW+0Y4rdV1XUqvgx01vESSGtoDIpKgtJ29A1WJ/wRrSoi9Hqmj1H/Zy9ttb2cEdhUYlZxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5158.namprd12.prod.outlook.com (2603:10b6:208:31c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 15:30:26 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 15:30:26 +0000
Date:   Mon, 6 Dec 2021 11:30:24 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Barry Song <21cnbao@gmail.com>
Cc:     liangwenpeng@huawei.com, leon@kernel.org,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v5 for-next 1/1] RDMA/hns: Support direct wqe of
 userspace'
Message-ID: <20211206153024.GG4670@nvidia.com>
References: <20211130135740.4559-2-liangwenpeng@huawei.com>
 <20211203101855.12598-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203101855.12598-1-21cnbao@gmail.com>
X-ClientProxiedBy: MN2PR01CA0059.prod.exchangelabs.com (2603:10b6:208:23f::28)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR01CA0059.prod.exchangelabs.com (2603:10b6:208:23f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Mon, 6 Dec 2021 15:30:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1muFwe-008xfi-TB; Mon, 06 Dec 2021 11:30:24 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1002d93-0a4d-497c-f48b-08d9b8cd538e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5158:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5158E2DC354CFA97EE6B0EFFC26D9@BL1PR12MB5158.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eYG1JbzG+iJqYK1OFuyJdeh3daP2n8VQYpMtbeLVMMuPC+QlCxdRo92li8LaQ3kbTuEzFj5WrR2RkBgYS6+PGMdVanr3V3JxAB9xhUVX5O2Z6VjUQwN5QjKYwQHrK6uvoIkVpGqIagMpiMMCecoO9TWf5TamjQPyWiZW5dQD9t/rY6qgZIeggnySeaYxmSoVn48LiHas6vcPg6ll2fCeRufLZduoAsl1BaJQe1WyVrzNB+nZSKbGoar3k2XjKXVjoGYqXD7wry99QolpK03XCuye1wW7dxcFV98MvUtcp3LMxg+GHvXl9WxwPh2jkXPSBVYqwEL0c2h4JwMkIO0A+qlHGWDGrvjKr36mEVwr/I3h46HLXDGUTJjRHTdq+soscp9apw3DFyhSamsxLN3jLnQS7oqFd9tQXpdAqoZTEDtxgKHz0MwPVSfBfdCV7EGSBbn6/1TDjreEDISLFNFemBdj9wInAENzLmfPtsIXJMKzEyDg4kcPjwh3O6AcCYgYu65t3qLRpcHAline6RZ9iVK6qiPzaCfDFyJFApk+UKI449c/d+n/X/9euBDXQy3oF50UPCu5LlYZyxdy7JJcAGcJc7TJgqnozr+lfEcrvFU5oqNP4B6IpLJPjFqZIwvXY5IcfHHJwCl+Dp7OB0WbhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(9746002)(83380400001)(33656002)(38100700002)(1076003)(86362001)(8676002)(4744005)(66476007)(66556008)(26005)(2906002)(4326008)(6916009)(36756003)(8936002)(186003)(9786002)(316002)(426003)(508600001)(2616005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l14K12AFinFsjgkBMvGEcBlZMU1lpWYIfpxWtKUvUditSyhO1FFyh/1iUh4V?=
 =?us-ascii?Q?Ul4pDfnhAzln/0XU3j2PQ73KxyyLDgNv7ZbMgfWyAVP1mCLFD6+Uund2NAsN?=
 =?us-ascii?Q?0RhJw2XJPaQCfwvHuzz1SQjQGux6vN7r6TsJxA4UOeWrQN/6BMBYUStxp53+?=
 =?us-ascii?Q?0narn+R7FJXC8VmVJ6avIfZqfTL6EE/7psy+oIy1xFFyxUhLrMnQf7C/ViwG?=
 =?us-ascii?Q?DrxYmpqAo7amE9zXpBdca1dw5qpGpnXr7KtMNxgYTXcQEyi/Rz/R7K36IijR?=
 =?us-ascii?Q?NPmSseyW80jtpaVXfRvPtXkphnPbRzr2KF06UU0dMnaT+mNSigi7cVBJ0YXS?=
 =?us-ascii?Q?0LqtLj3GSeuxvYyJywOQ6kCz+n9qj2jXvEYyNwj0mOqeVa29FdfVRnDkuvpU?=
 =?us-ascii?Q?XXokQT1CMaR9KH0ancsUZaP172Mo6Ts5bdSK9E8ukB5kVUEpoiNb7B4L9MFy?=
 =?us-ascii?Q?3NCc8/FHNywBWMb4c3WH4946prSxbKRjJJEr7fbsAzeefqx3GKTc+fKir7Po?=
 =?us-ascii?Q?sB1ny0RKp8vsnfpfLKEQuENVr0eE8rf8c0vjRd/WN9dErYBHLmln1UYzNMHq?=
 =?us-ascii?Q?mMQraedNR6pMxP5speTYBL5wAfK5IMOqw4AoGAwnjO40JmIoC3eaZcDYBXC8?=
 =?us-ascii?Q?qDwNkbJimwFkZfkwSosza3YbrMP5EHIkD0flNs4Vj1vOl5CG/61wPCerFPrW?=
 =?us-ascii?Q?V3lYw4LKKX9GnAzpL62g9fUuy2+N9Gi+x4AlFzL7d+MOJmYO7zooJDjr5mdg?=
 =?us-ascii?Q?kE76iGUifRNtZ0AxUpRqfAjo4uiDQ52TQ3S+MK2j5/QtFEzLB71gNBIU5a2k?=
 =?us-ascii?Q?q/zO9HAx346y2jVNnaM4kPZ1jUr1aVG7Y+NTKyMX3tOtK0Nz5KGQ0u74rXXa?=
 =?us-ascii?Q?sUCOi55XCyw29F3eXl5hIRxsyg1fNAXIG9siSOV5ZDYJJQBUaAdtsNW28Xsv?=
 =?us-ascii?Q?oASU2q82mPrgWxhokPFIuWk2pBEhjsW2NZnrbyN/L9o6cqFHZJWXvYvq8Ij2?=
 =?us-ascii?Q?rG4yPH1hH8P+Y3LjQ3pJ/KMfdxsoTcSjZcHC00CWvn7CzAMtAyDxTc0/vkqz?=
 =?us-ascii?Q?3yh/2CebYkXmoEI4kYwtMJUYjfllqqUo7+yxQ/2SoqQog7IbFWOlUwHwwTBE?=
 =?us-ascii?Q?7fZIRrEHw8jgnXFcbTkfda4/2kgaULeLQBFzqAIsYENrXD1WFZaTf3wMDTsC?=
 =?us-ascii?Q?+nq2RpjHdVWB1SXvd0EEYxQ5bh0DoiU5N1pLpuaSBu1oRxXFS9le4SHzMZwt?=
 =?us-ascii?Q?uNEvKob7eEeZhLVxGEJGWA7kvytUixlStKD4a8ZUhm0RyApMv0mea0QQbVgT?=
 =?us-ascii?Q?2u/mkVRvohy5NGk4eR1sdRSBkXHwNMj67jgB0ydBE1MyOzxtYfcTlPNFUAl0?=
 =?us-ascii?Q?bCEYAeQCNZ1uvkycwORUXaBi+lOnuuxWToi7zlO4eLUKm+E6lJsm0GiKDz6w?=
 =?us-ascii?Q?GCAwTYh4gvFOPl5c3zZKEvCBqDfUQYQ4zRS19hmHVKmA2QGbqVJKWZvzbIF/?=
 =?us-ascii?Q?XMhmlJxuKqRKD+nPu+tnNbkl4L4twyjnl5rPozZhVWtb7EQyn8jlGS4HK5y6?=
 =?us-ascii?Q?ZyYu0ICN3xHGJSPxXgs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1002d93-0a4d-497c-f48b-08d9b8cd538e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 15:30:26.0413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIa57fGhHThJt+TLZTukKPWjRmEz31Bv+jDgfKvc9S3UoGdbaBVBexgigJTqBR+T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5158
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 03, 2021 at 06:18:55PM +0800, Barry Song wrote:
> > +	switch (entry->mmap_type) {
> > +	case HNS_ROCE_MMAP_TYPE_DB:
> > +		prot = pgprot_noncached(vma->vm_page_prot);
> > +		break;
> > +	case HNS_ROCE_MMAP_TYPE_TPTR:
> > +		prot = vma->vm_page_prot;
> > +		break;
> > +	/*
> > +	 * The BAR region of direct WQE supports Early Write Ack,
> > +	 * so pgprot_device is used to improve performance.
> > +	 */
> > +	case HNS_ROCE_MMAP_TYPE_DWQE:
> > +		prot = pgprot_device(vma->vm_page_prot);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> 
> i am still not convinced why HNS_ROCE_MMAP_TYPE_DB needs nocache and
> HNS_ROCE_MMAP_TYPE_DWQE needs device. generally people use ioremap()
> to map pci bar spaces in pci device drivers, and ioremap() is pretty
> much nGnRE:

Me too, please confirm with your HW that the device really cannot
handle device for the DB, and it is better to put the comment on the
noncached case as that is the obnormal thing here.

Jason
