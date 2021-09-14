Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FFF40B424
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 18:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbhINQGr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 12:06:47 -0400
Received: from mail-bn7nam10on2069.outbound.protection.outlook.com ([40.107.92.69]:59198
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235291AbhINQGp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Sep 2021 12:06:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBIK+cxktKAZkiqHYTYxilxx9AJPrvxF6EOVXadALbXxme5QEalP+KduaSGKdhi8JJzoqFYzTIYfI3ZjKdNIpq/r8tjBC11dzn0lyha9K8FiDz1n50ocKW5her8KqD4TqZkHxRXCIZPyqlzUTO2zBoLK3MG4UIkd/BcIRA3kBG8FlQ2GFB98dCoMbcL+ywvjbZ3Gpw8P6Vo5VOt5bUvCL7iTcQTEIbnWPrt7nH8pyu3Equ64F7ECrsFdA9JyPwKpOxL8TxfuuEw1qTUdiR9+ieircxYRzgHD0pblvt0i7JVm8i8Vp8lpi+LiP9JXcX7ySryi6zBqJ9/6ZwpbqoiULA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3KyQQfZzYWyrMby4xZzcXD7Et85SBccRE6Ol9EQteEw=;
 b=YPThURObVFWESjH9PQ2hsbZzGQnb9Ra9ZdfwmsABQZrUNQsqN4rAlN8Qscu7+BbeJXOyNtdpPT3L79ffbJJutTM2+1dn/SBxByCk1/yRf+evZVqGNp7XtitnztXxmw7d5nN5QqK7PPzKikxA3uj7apn+mgtpGyimlW9cg+EIGQrWghwnQrC8x1PpEMIh8EItf5I6p/l4eSLYZsTDwfU0sbwEbO2Nn/8V5fWl9A9PtNGxlZfcVWuF9tthuTf2cQ+RPb6CfdXCgeeRiMsoYMOasafLi/Ei2peHDeRbRGTT2pC1WZx2T2PyFWxXA+tH/p+su8IrFhPz9HQBdk/zyqA3Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KyQQfZzYWyrMby4xZzcXD7Et85SBccRE6Ol9EQteEw=;
 b=ECaFXVG+wX25dKM6UfD6GmlOumG1oQ5GTJi7iVUkqyvYDE4fqe1hW272P2V3niZqn+vAOdtVk991R0B0M2HG8R/KZzKwphj29mgiUFhzcKp95D67iTAynZgWZ1GFSWO7uX4T2CUoT026o0jS11tBFj4aRyZwaacRzSVzbGlPRltuzn4P9tSOvy+QaZn/9ox+kgG/RftALxN7C6uVADE2DqFn7IqMyjP/ds2BIH3qpQRaxRrbt1geTaqNAosp5Pj0MxxumJU+nA0gCqN3ZKJ1QqBxeaATq6ywPDo0rAWoh9pCm7tU4Fxq8Lk6QIev3NiU9Ybys1yb1zi82V5ZCZkaKQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5555.namprd12.prod.outlook.com (2603:10b6:208:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 14 Sep
 2021 16:05:27 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 16:05:27 +0000
Date:   Tue, 14 Sep 2021 13:05:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: _printk not defined???
Message-ID: <20210914160525.GE4065468@nvidia.com>
References: <82f49163-ef76-ce35-16f5-d0a985ecc3e3@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82f49163-ef76-ce35-16f5-d0a985ecc3e3@gmail.com>
X-ClientProxiedBy: MN2PR14CA0024.namprd14.prod.outlook.com
 (2603:10b6:208:23e::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR14CA0024.namprd14.prod.outlook.com (2603:10b6:208:23e::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 16:05:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mQAw1-000UaJ-P2; Tue, 14 Sep 2021 13:05:25 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 616ad4f5-bf2c-4ff9-a45f-08d9779977a0
X-MS-TrafficTypeDiagnostic: BL0PR12MB5555:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5555E2E8ED2A249A4DD6E8EAC2DA9@BL0PR12MB5555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O8VVv0c2QplLy/PawPv97LaxeCJxTHjyi0Lose22PIqJrKDxWVAe+zUkAQJkdOc+JzNSgkFdzaFTF7rot1/hAOYlOp2KcfZy/LVggs+w5XR5wkMkjXs6Zbu2LMLLHFtJfbGGIZVcsXZpEo0vNdL9B/1+sjnMMOE/qoNNCZGnZ0nn+boqR20tF2ySfQn+K/Ae4/6YIz2mI70vfZL5MffA3Nrkg8sycNCG1zuXbs3Fq9y6w+bqX2spXePQlx3hsH2VAdI3nwlh3ZV5AJoDPV7tHsoUA1F23oh8sFeKqa6VrNzRuSCeZcp8wDFV/4CTYLLi8vWGIEfdUrhXCP+22M3fUzR7brx7vJYLpBNrzdNwx4mTIQCJ7bNTziEi9nqRodEmEUOMDJLOXUAtSj7L1RJDRV3LX/Q9Iir5psmJVxOKpb8ZTOE7XzByR+F5zo9j6mFPWvb2vsPQklIziL6Y+2s9y82d/ORKapXCr8eAZSUO7We86E/tWVrjsXgQwcQoFzQU0Src+L/fpbkwM94qIj5LJB9jmhXhizjalsban+FT4R6cRKfJIEYd/RgA4bikD49m/WbQEf5lau8hLObE72mr7Gn6sbuLnl0hGhLVoYHsJCf1qOBWwh6qsDFv3SuV+ahznJuM0oOl+KfJ9NpEm5W1oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(1076003)(2616005)(316002)(4326008)(2906002)(66556008)(66476007)(8676002)(26005)(9746002)(558084003)(5660300002)(38100700002)(86362001)(9786002)(6916009)(426003)(66946007)(186003)(478600001)(33656002)(36756003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BIHaLKd1Q926OEOPbsTKuCgWFefUwtINrJfUoKfdgcHeeMLzOsSvFjDwRUzJ?=
 =?us-ascii?Q?ZbygcEt9CP0/LuQvb1zZ04oBdOJvWC7rn1LIM46xxCh1gR/7cnVCd6fMCBSV?=
 =?us-ascii?Q?4u1bYp8wXojwSSrTWEHGqNmPJ8MqEfCJGpMMz+7j7lzB/4Qe0AAVI26HslOr?=
 =?us-ascii?Q?wjLQNTWPluyg9V3eDMYPkHrKwGS4c82daN3jlvhFiFkGPGuZ6+NlfzU5NxLC?=
 =?us-ascii?Q?si8hem3HpEp6RL4wMEtEt4WD41XOost/JZYN4ghKI/UelVU0GyEqA5qdlj1i?=
 =?us-ascii?Q?/FVnSdNvGP4nJIqWIoGpICuL9dz6IcOFAd/FH/ZE3iBMIYAKvdk4HW3FhB8A?=
 =?us-ascii?Q?Wc+OP1ZHo9ECXeiNJTiSHCe5naA+wChGnz7FzA/+7vCtUu+Ha8ZsZz2AIV+O?=
 =?us-ascii?Q?zGRz4d110QvfqgNinOChgaZtlNqimIj/BBi2/YKXJn89GQCaItjAL8/mQY9A?=
 =?us-ascii?Q?+SnQ0ddp0ghjETxS3h/2u35urjoVlc37u3j6m7U+UfextKqimm3HyT5jT1U5?=
 =?us-ascii?Q?1mcEqe/7XiWT3wnAafxP05GvORUXPdIthq6UN+v+v+2cIBRcB63kPV7+oMTA?=
 =?us-ascii?Q?/zLiIsOiRFCtG6Nlr7pWp8IRDukY5O0+C0/2mIMXXpJABsHLtJfdma4OLH+Q?=
 =?us-ascii?Q?n3jFOg0edGlN6/w/lTc96UdRBGJPKkxtUc0uHIjVkLqZ0Gyo3/Jkbxuo2mGD?=
 =?us-ascii?Q?LJrEsdNfsjRhnWlVHZ4beBl53vsmDWNnLKK+rERdQBlH3rUYOZjynr9G/SDg?=
 =?us-ascii?Q?2wm0NI1/4PxaHWsY2K18qr99pt0hsov3iSa9JvYgUspEDfuZ6JR2yVIIQkfi?=
 =?us-ascii?Q?BcdYWtTyFyGDPwbNFgYk5tlC2qAXOqpfesUoZ0EmDFkYTMalqEr0FKZzom3H?=
 =?us-ascii?Q?N4ygHDd6xaezLYRpoRZzWRCii3vmtbDzQVdobR5d2kkpLHgVAD4wZY1ARIyM?=
 =?us-ascii?Q?bpBcEs+tGWpbtVVhAcqR76g6fTMjJ4cBnPUNlh26KsVXRAaSzJOW0PylPGX8?=
 =?us-ascii?Q?uyLJJCQgaJj5CAe2AkfhBHUmhTLt/UCs1NyEqyiCWMPA4fH9BRodmZd8jgcu?=
 =?us-ascii?Q?JyoMb7U58jA2AkXcd2Ou9di8nykkuUPB9tj7lC01yQxBeuZtAfb1oABN0vh3?=
 =?us-ascii?Q?jcA3vntqc3WhdL1UTZtiINYCLPqP3Gk05IF404E/ZboqZduBVIPbHkjSuwm2?=
 =?us-ascii?Q?YSRSP/NH4jslXIld0gxbGe0PZLvwt7mXivwlpC8NYXjvPd4E8cG2lQg2zcsQ?=
 =?us-ascii?Q?Z8Sen/Ia/dSqDXnIWspx0ZM3xTEAqGOGODS+vcIt6L6/fXiRhinMddbWrzt/?=
 =?us-ascii?Q?zM3NRvBVr5gx5i2MmKhxijgT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616ad4f5-bf2c-4ff9-a45f-08d9779977a0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 16:05:27.1737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otMBQVgtpH+vRCQ5lbWRPIDBTs3jTBTuWzrzYttgBHmwXxFeF08LMr/5pSC/JYmY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5555
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 13, 2021 at 11:21:43PM -0500, Bob Pearson wrote:
> With 5.15.0-rc1 I am unable to build for-rc because moddep can't find _printk.
> Has anyone seen this? I don't use it directly. Just through pr_info, etc.

I'd assume your build tree has become corrupted, start from scratch

Jason
