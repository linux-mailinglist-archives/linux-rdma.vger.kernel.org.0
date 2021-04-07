Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9263D357849
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 01:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbhDGXNV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 19:13:21 -0400
Received: from mail-bn7nam10on2061.outbound.protection.outlook.com ([40.107.92.61]:23877
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229460AbhDGXNV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Apr 2021 19:13:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EG3ZfeWUhIuCOJjrO4cAEIeliBihoGcBZHuyOlo2zrk0G8K0Ga1Pm3dQZhu3xjXqOGdAUj1Q0le7ht+ZimXnBieVIjFre6vCwjP1MO50rfTGwy4MX0lw0jdxQ5nkJ/j+5ileBTZmYdvX5a1A5ZWg8LUL1Ix/cQkuOMai6ukUFvFAe26iKI8voZGXf8cvSWiGp3JVvhZRw9hHucOJT1KLWQlsTazcvaRY3BqX8r5chIOY7DgGTdzqUBngMpnIpOIme43I+9lu0jJXL8QJPn1+zI/cMvwfcbFP/74bQF1GGXa9k5mjCwKNBH5FgiSaJoz4YPQn+W7+eDEHYRBGduYCqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NMadVppzoOAzMYn4kYPrDPN5vKkpSzR2/h2aUwWu7g=;
 b=axoyK6Mm+V58Nfw/JcnH3fWm+3z3E1YzKP59v06sMKSdUSlo5pmaasU1YdLCJSttebH9GX/E+C6g2Zx5H/jegMfBvXOELpszJx0fiwSzEw9NShNSashTCesPyBOHiQtDTK3/hdWjvH3+nvfoDSx2rUEwnZEoLxRFUxX/MDcgEysmrCe+sIYDe0twkITWToVwu5KaqI3/+0fsNfzn4kINcCU+C6YLVJGH/C02OH1Djex03io8UYNSBpBjvmf1Vcc43N9XYHhH//zaMfGIEqi4i9jMJ1IeQEuocBb3BsAPpAmgkMYZcOyMUA7uIWLbBi1inbcx445U/rpLA8YHAYLeaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NMadVppzoOAzMYn4kYPrDPN5vKkpSzR2/h2aUwWu7g=;
 b=hSgvGyuSQGatetSfobTNkpA67AWxNnGQro2RIKZFn6w0R/surBwiaTbto5jmdJNDNbdUKS0nQ8HQ/lpzlOfh/43I5kZsBN9FLXrdd26FgyIDqPzhGuZ6Wnjyi58dSJlA0sgmY1ASRG2m+maHNyi3vjJp3HuoouVjMv5xPXwpegE3rZEq/FRze4de29SzAU3eHFjZdj3QjaixANX9zRfglEZXJJYmH4iErFXR3//6VN8qv/sGa/PEaapuE2juxujxLVZfTjrIsFx0/AyylDgTCQlV4KSkL+CtwUk26o050GE7IDlYnF9k2uOZ3Vi3DKd0W63qs4f4RmiERQs634RPEg==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4578.namprd12.prod.outlook.com (2603:10b6:5:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Wed, 7 Apr
 2021 23:13:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 23:13:09 +0000
Date:   Wed, 7 Apr 2021 20:13:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, Kaike Wan <kaike.wan@intel.com>
Subject: Re: [PATCH for-next 06/10] rdma: Set physical MTU for query_port
 function
Message-ID: <20210407231307.GA576786@nvidia.com>
References: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <1617026056-50483-7-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <YGWHga9RMan2uioD@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGWHga9RMan2uioD@unreal>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0177.namprd13.prod.outlook.com (2603:10b6:208:2bd::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend Transport; Wed, 7 Apr 2021 23:13:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUHMB-002Q3p-Mc; Wed, 07 Apr 2021 20:13:07 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 992579ad-a79c-4134-9bc5-08d8fa1ab53b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4578:
X-Microsoft-Antispam-PRVS: <DM6PR12MB45785A81A6369968751DDE49C2759@DM6PR12MB4578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:119;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ivH4nm2RJQeY4Z7YxJYMqyrINpWOfcoIBvsklbratXWkCjB1aGnqbH+/08ZvAXMnQgdlZ08YBJp7qJPepFSMl9S7w3DUPMXw0SezlH96bHroCSNKVXIUo89/POX4CLxYW1RWjn6gMom7w+EMLDZ0Z+HyP1oIGSSuMAzm5q0w/vG/IEbxuAkbo+wgZjX1KvuwUInM7bcHqCZtoU2EM0SEXWqRx5uZtr/wF2TCLXTey3Y4qtVY7pGNAY5BmZKpMZbt4hhGqI9g1jbFLP2zVUppJFTSX1hS9QEe3dJ5fjq7nkdfc3Be7T0F7ZxfN92CpT7EhuRaOb1kvE+9vFeKfAYP/P/IhL1YedjDLuE0D+wEu1pjKLEmTJTCNgulD88DqodxMAY30sBm+HX5BfKwsCYbnG0H26i21LFDCeo7l8jcNrBsyZLUPU9McX0tufp//atChklUQe8rykqXIlyczFjZ7AmNznqJ1mMwbRdLu7GmFWAh4uVfCd+n3lwBFmo8Pu9wL71f9N0K49Fx/ENmf5RkoLPBC7ItEL6MLBdbdkFOTsocbC8uAy79qNOBCL78UQ8mMle/7qk31ndWnbn5NPoBnOqo0o3lm42WutiH9j3pTRyFRR0e222T37mKdFii0zTlsbNyTN3BZKHoqlbMVW7h+ap7cE7ndGeKgCMKFlgyRuH93Sy60TJDKS3T1TfeLUpa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(26005)(4326008)(66946007)(5660300002)(426003)(316002)(36756003)(8676002)(66476007)(66556008)(2616005)(186003)(33656002)(9746002)(9786002)(1076003)(6916009)(478600001)(86362001)(83380400001)(38100700001)(2906002)(8936002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Hd1HBjKpvNr/xiBrPAJ83ulUhH4zjXal8X7yfwMwQlXpIIjrv703v2DDvofB?=
 =?us-ascii?Q?Fj+LRLnXh0aSMyYJuKOi5lkBHsuSKnlIo2U40xMyVj36Z156Ghp2yM/0gsea?=
 =?us-ascii?Q?gmiD1TAwF5T2z4wob4ZxGsbrkAHuMAtL0d3hMr8L13SSRj6+FaGF0CAq0/Gi?=
 =?us-ascii?Q?DK1WqqGHFtYeAhkjQG2kO+hkmRh9ycrknYFBhsVJjvuxuRUM91arn0SyNyu4?=
 =?us-ascii?Q?bbKhxt1nNxKQrWpaWCDpmhB1eyOV3TrjnNuO54RfvXwiKYM15KDL0k1/NLFR?=
 =?us-ascii?Q?wQCye3T5mnKl/DEE+ULzD67/7mKHsvMPeFXo+itJ78FDYfRl8K8/OLln2FbC?=
 =?us-ascii?Q?h6ntzxMI3dvPu5I4PLOgKdu2czmGDS3cRlVaKBwUkMG51ShdZqaj8z1s6zGH?=
 =?us-ascii?Q?I1ogsSDLVhMqBLxThXEtcXZdVni20AgJr9ioIu7on2pORE6dd7k/GodyfVu/?=
 =?us-ascii?Q?wI13U6uDaY5G2PfrkronoBq+S6fzfufj4WTCB8F6E2yBvYMAZ8TWhuD4O2Lz?=
 =?us-ascii?Q?G5Nl6/JsnZ+O5qc4aOgMDiBukiD6nrewCMXdaB22DCHisvoK3PtO0D0Fpysi?=
 =?us-ascii?Q?lrBDF/Ksw18SI4ieEYCXMX36YrV/Gp8mmcnnAQhDnrwcx8Dkbqy1PqiK+0uS?=
 =?us-ascii?Q?Dzk4yf2WecMa/FY4cRtK3ahb5ykNK27HP3jdrK+uzsQqQN5/qI20xxgLJp/t?=
 =?us-ascii?Q?c1ibH5JgdxLLT0KxR3qLTJ/bDoM4Mq4n6lwdPuA0zXneuiWvLm3loLoT/BdR?=
 =?us-ascii?Q?lqUWflFEmMRVhacW1nO7hDqIeGpb+W9U4Wk3obAAqj9g5u3FURMGrAGhQ0GE?=
 =?us-ascii?Q?P6cNbUAN56kIxLaYxGu7pTCjWFSJNFHu6Kp8rZZBqDF3peUBqiTjcvVai43Y?=
 =?us-ascii?Q?WT12vMUV/Piv3CsFV0WYLcMYFSSJef95w9nYll9BEmEXJJcXy3uIJ6BHwmRV?=
 =?us-ascii?Q?2hR50jlz7ADXHiC8HhslJCGZI0YVMryyFrr6osa1Vgi5v1fsFcBIkygpflF5?=
 =?us-ascii?Q?Qrb73MRagcnmx5+zCzrXqGf0dZ/Qakrgy2xaMsP/n+h0d1HBDMjpyVnWbNAJ?=
 =?us-ascii?Q?gGwpF3rZolFw9r9tPs0dk2x1yayNCE1swv9iG4CkmzPesrv61AUjyDffnm0z?=
 =?us-ascii?Q?Zh3N61va08Wm0XQoSj/eVsTz+Qr6sf47ARZ1D0GYWlsstBOZf07qMLOxl0Nh?=
 =?us-ascii?Q?S/ug/Du73VmB4GB9wlSOBm9bTjBFY6XeaQg9m1TR3Ez8NHGwrCHB6x+d9jCg?=
 =?us-ascii?Q?ilAo5J3fOK7Ohh0WB3vCBKk4nIlGGlPifSqzPPOTdWB04O+olpwv+HWZUUYg?=
 =?us-ascii?Q?pp7QmypcGLFSQW+c2P7qdSy2jNz/wcYdcyl4nKtdKWGGAQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992579ad-a79c-4134-9bc5-08d8fa1ab53b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 23:13:09.3199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YRSx10gt1SEBkWv2QLAVjbiTd5VzMnuqYGmiUQSwJkyr+z9q02H/bl9OWiJZYKd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4578
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 01, 2021 at 11:42:41AM +0300, Leon Romanovsky wrote:
> On Mon, Mar 29, 2021 at 09:54:12AM -0400, dennis.dalessandro@cornelisnetworks.com wrote:
> > From: Kaike Wan <kaike.wan@intel.com>
> > 
> > This is a follow on patch to add a phys_mtu field to the
> > ib_port_attr structure to indicate the maximum physical MTU
> > the underlying device supports.
> > 
> > Extends the following:
> > commit 6d72344cf6c4 ("IB/ipoib: Increase ipoib Datagram mode MTU's upper limit")
> > 
> > Reviewed-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> > Signed-off-by: Kaike Wan <kaike.wan@intel.com>
> > Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c        |  1 +
> >  drivers/infiniband/hw/cxgb4/provider.c          |  1 +
> >  drivers/infiniband/hw/efa/efa_verbs.c           |  1 +
> >  drivers/infiniband/hw/hns/hns_roce_main.c       |  1 +
> >  drivers/infiniband/hw/i40iw/i40iw_verbs.c       |  1 +
> >  drivers/infiniband/hw/mlx4/main.c               |  1 +
> >  drivers/infiniband/hw/mlx5/mad.c                |  1 +
> >  drivers/infiniband/hw/mlx5/main.c               |  2 ++
> >  drivers/infiniband/hw/mthca/mthca_provider.c    |  1 +
> >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     |  1 +
> >  drivers/infiniband/hw/qib/qib_verbs.c           |  1 +
> >  drivers/infiniband/hw/usnic/usnic_ib_verbs.c    |  1 +
> >  drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c |  1 +
> >  drivers/infiniband/sw/siw/siw_verbs.c           |  1 +
> >  drivers/infiniband/ulp/ipoib/ipoib_main.c       |  2 +-
> >  include/rdma/ib_verbs.h                         | 17 -----------------
> >  16 files changed, 16 insertions(+), 18 deletions(-)
> 
> But why? What will it give us that almost all drivers have same 
> props->phys_mtu = ib_mtu_enum_to_int(props->max_mtu); line?

Dennis?

Jason
