Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB3A423065
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Oct 2021 20:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhJESw7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Oct 2021 14:52:59 -0400
Received: from mail-dm3nam07on2043.outbound.protection.outlook.com ([40.107.95.43]:14752
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229626AbhJESw6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Oct 2021 14:52:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlvhDn2bwM8O9BXXw7gUSX5UTJFvmn5MyXhVK24Yi7aKemku5Y1uwsyKAQbZqBN03HAaa5aInEZe4kW+peHRi2amAaGEhRV0a9nZwGjuB9I1+U7nhLuM69cqRX/6Q/sCAfemjbRwcE+yKr+vp9jI1YolSEcRsOg9we9bFwcfkMMzThF9DH2Uy9/mVlJOfeR8/Ga+QvUavsfLMB95wQuv7jkYBxWBrBSMSiVW0js4NZc+tJ9EW9212aVC1Y7DglEAZroqzPWdQ20XStKQ459U/r4OErS8tjyMfAUoodyTl21LW4OQ1ZO7HhZtgxtE/zVgN4/2lJJXOe8Y0ErZp+MXWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHjhG1FY1yZXJ3pADOSdqSTAG7NiLYprgtb4K94hSe0=;
 b=W9yFnjUo6A/NiMQYTnsT+sq5Mw+EDyZVFg+37FIjgNQ4Jz12QlVMkGhTHrn1Haz6V8ceM9GlycyFAD7vQaASpSdAiKh/9H32nHGqEPjcVZryQLnS/OWfx0RCKidseeXblO38A/Y216A9suKCa9BBa8/prp2+IrpMab48msUHEYuemt+teZqnWUOa9jOtGq/+3zVBp+qqPobMDhMZmUhPhVvMsA69uA0UyGJzCqGLHlxd7Q7/9JA34th0eDSZxykwLTevB8i8dDssVJG0lSCs0L7ASG2Nc9ppA6vQcYef1mf2yCfkIfAWU5Maq2jp8A2LsMYFj6/kNg7xawrHKu7RZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHjhG1FY1yZXJ3pADOSdqSTAG7NiLYprgtb4K94hSe0=;
 b=HdoKig1emBwG5yUxYuJJkOyh84XUYHIG2EF2bElPNKOUIBTM8jQMAkkJm46N5m2K2s5NEHSJ+hVdo6YDH/JGXrvbgDspbRc/5YUeRUyt2q3T1ovdCvILWGiH0MyyECSt2xDWXRXR1p1aqS0Oi4GbR/cfUtQ9z6/FQHKxxhU4/lTzqgAREcmD6prflnvvC0uvcCMWK9Wm5ogMFEkOni6QA2jL21hygrH9IFuV8/b55JzjGFkEdXUl3IYLfel/sDB7254wu7jARZOlHro3fFRkdxxFbzqQsFBNC9HhpPS5w7bw7i/qb2GsqCQNmfNMeYKiKbFOb2ON0sGdj9FT/ZYbcw==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5539.namprd12.prod.outlook.com (2603:10b6:208:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 5 Oct
 2021 18:51:06 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%7]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 18:51:06 +0000
Date:   Tue, 5 Oct 2021 15:51:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Ilja Van Sprundel <ivansprundel@ioactive.com>
Subject: Re: [PATCH for-rc] IB/qib: Fix issues noted by fuzzing on the iovecs
Message-ID: <20211005185105.GA2682823@nvidia.com>
References: <20211004115625.118981.81200.stgit@awfm-01.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004115625.118981.81200.stgit@awfm-01.cornelisnetworks.com>
X-ClientProxiedBy: MN2PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:c0::42) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:c0::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.7 via Frontend Transport; Tue, 5 Oct 2021 18:51:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mXpWr-00BHSc-Lk; Tue, 05 Oct 2021 15:51:05 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56b7df8c-309d-4cbc-dbb7-08d98831169b
X-MS-TrafficTypeDiagnostic: BL0PR12MB5539:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5539E4599618399C8A24A904C2AF9@BL0PR12MB5539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x+9mhp85EEM9uElb/n0XlrCdtPI7EipZah5fw7dHEib0MzW1XG5NcxMA/0gHbIU8m1YXSoMHricGfW/jtsZl9ua0fgjEZ7KG++eSyENMJdIZecCVsir4Om8aQ36LBsrgI2KkmiAD0KftHeUuwUkwHe+XiDWyly9DuiPst4A2htNJCjM86D6OjcL5crLfs2/Jn/U1M+rSew9p/X4cfOfLzBsiiiW5BYuPFbHTFzfgkraeK8Fy29JGIliaevoglMq2KEQwjnHhr1HvxEADyKIJ92fQ7mXbA93u8hDJVqm52GjVjq+6yTO+Dw657E0DVLM084xF9cy5+yi8gL4dT7mrGpC6bVKUoPsvDS0k3r+Cr3pjymvHNuODUt4zJDgVjNh7cJ+vt/44nALtZNoaqxF6o5X2SlvkPdlVsY1yDCQDSU/VSudv49/NOfZZYrZAN6kLxCrY2wVT2FKF24d8/XP97ec63oQPXyi/0kQlaUi8cNkhAcNkc0j90CmMMg3ARA7lCPPGOpIO6xs4pgdnOpvmbUNWGI6j/3Qavk6myGiTDeAjHU0XuHRMDN5tAXM30kCNsKvmEf6nYVXrdeJW9hLKhbMJBCiPcXXtqRa2QVWs6C2nyTH774wYy0E/N6HBEqSGggLd6Qx0F5Mt0SLnkxIVOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66556008)(2616005)(83380400001)(186003)(426003)(66946007)(33656002)(4326008)(86362001)(2906002)(9746002)(9786002)(36756003)(8936002)(8676002)(26005)(5660300002)(316002)(508600001)(6916009)(54906003)(1076003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vSEJRsq/svaSr3aecAizFaPZocjqrg3oagGLXyJ3ZE/Qz17quDvuPeHjBTmR?=
 =?us-ascii?Q?fIxQwV/hkML3WgCI54r8GUUyfOxwaqfdfMjkyfWPjzGpy6JMDIUJW+Jj85Wl?=
 =?us-ascii?Q?B++XVSo0IkuhlX5uErdyftsR5T33Js49Se3stgbEL++dyNVnvtNXgzHXO87I?=
 =?us-ascii?Q?XEiOMSUofEeNU3J0dTBgeo+1F+7CEppbetn3Qh9vVRs1lFVhr/8DsKKDzNYV?=
 =?us-ascii?Q?px7oX04pyFurrOqeqNjXhMKQ2ItQnZVg5zZTIEB5GMRPIyCPEENtQyIQ1Lqd?=
 =?us-ascii?Q?mNb9GKLrUomEPzcrncLKXzoCuqx1xNouos/2q8KQSpWxMs3S991qqqBmLxn0?=
 =?us-ascii?Q?Ha56KtaCwTtwXSFjWRRQ3teb6PraCkGXvZfNl2i1bcm9NGqtpoEpjq4iduz9?=
 =?us-ascii?Q?SBHhwAxUGjX6JHsK2pxp6FdcRdxtU2EzVNIGfiNW2p19Wi8Dcf7U1zMBcIjn?=
 =?us-ascii?Q?4hanUMHGHlTTHJOn8syjandA62AeVVeF5u3ujxxI7mWKsfM3UXEAwBCBr0Lk?=
 =?us-ascii?Q?F0hJlOzBVvqKX5uwXaS7UifACYVTCJMW5mBKPBmdtU8ymRSdrj7rR36sKKlZ?=
 =?us-ascii?Q?7xAK240YiS7vHgMPRaRxoD3816liyvJhTmPRf5dbC9sr9lI2wDWP4wdtlXyo?=
 =?us-ascii?Q?S9+XOZLv9Xl120naaDvy8ct0j1YVo7UnOgyJilSRBi/mzTWg26cwYPVnfSFq?=
 =?us-ascii?Q?Kpae6D0MU3YHPI/8Mdnq8aKkWzwRpy/T0Cx2NDz05ltlOAMa5fp0W7EOkV4E?=
 =?us-ascii?Q?w6nBrVplx4PsgtSi3sF4lQ2il72Kk5TWt9zJwCrTpkCAXw28Mf7pdUu15ORH?=
 =?us-ascii?Q?mgPj/vkdS9gXgO3rNbsUMvVA5w96ig2RiHL9dZ9cw7lE3fxXOpcOy1icRNsE?=
 =?us-ascii?Q?4+X9b+CfUA09PonxHwn/1jcugUcWbpVUg3GergvD+wNdUXyUJNyqqjj1AT3n?=
 =?us-ascii?Q?p6M4Q9+EGn9RtXZLwfFEuGR1dlQuy0ITvBK6Kd4EgHgTubsnk2ZRavUpllaE?=
 =?us-ascii?Q?Js6tZlOPFYZrOp1HNtBvulK2cBK8PokUaalIuiwpsblnxW6n4UeEzlWFI967?=
 =?us-ascii?Q?DBMh9CQ0MgAUonnnA0KrQD6AevSc6YOQuTxKWS/KtnZp1VSreIhFSAhkvjgE?=
 =?us-ascii?Q?rpo6Nty9Nj3Ll7MdbHQs9CzmvNt2VU51Fg3A0aPcKUCgUoR9estBvHiQ/5nf?=
 =?us-ascii?Q?0SuwV9f7KQg7ndjz+9E2hJBMBK+1veW1mAM6Zh0XUUAHIYUZddvnq9vcCw9y?=
 =?us-ascii?Q?pwjwuuFOoZ0azvoWES7HqUgfTkOJTO9RiKGwzRco+KQ6+Shk7246rfJ6kU2C?=
 =?us-ascii?Q?cYRlUXjV9+k8U3Q3OEu54m9HqyA9gKHhjNjXtg4JiS63cg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b7df8c-309d-4cbc-dbb7-08d98831169b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 18:51:06.5685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlHUwX51VOf+FeNQVS0AdAhUzB3bBE/hTyUTmp5mR5o+iNMY3BwfD4l7Vza2jEFv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5539
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 04, 2021 at 07:56:25AM -0400, Dennis Dalessandro wrote:
> From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> 
> Add protection for bytes_togo and n to avoid going beyond variables
> in PSM pkt structure.
> 
> Reported-by: Ilja Van Sprundel <ivansprundel@ioactive.com>
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
>  drivers/infiniband/hw/qib/qib_user_sdma.c |   20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)

This commit message isn't good enough for a rc patch

    IB/qib: Protect from buffer overflow in struct qib_user_sdma_pkt::addr

    Overflowing either n or bytes_togo can allow userspace to trigger a buffer
    overflow of kernel memory. Check for overflows in all the places
    doing math on user controlled buffers

Don't forget the Fixes line.

  
> @@ -878,7 +878,7 @@ static int qib_user_sdma_queue_pkts(const struct qib_devdata *dd,
>  			const unsigned long faddr =
>  				(unsigned long) iov[idx].iov_base;
>  
> -			if (slen & 3 || faddr & 3 || !slen) {
> +			if (slen & 3 || faddr & 3 || !slen || bytes_togo >= (U32_MAX-slen)) {
>  				ret = -EINVAL;
>  				goto free_pbc;
>  			}

This is not the expected way to write overflow checks these days, like this:

-                       bytes_togo += slen;
+                       if (check_add_overflow(bytes_togo, slen, &bytes_togo)) {
+                               ret = -EINVAL;
+                               goto free_pbc;
+                       }


> @@ -904,10 +904,14 @@ static int qib_user_sdma_queue_pkts(const struct qib_devdata *dd,
>  		}
>  
>  		if (frag_size) {
> -			int tidsmsize, n;
> -			size_t pktsize;
> +			size_t tidsmsize, n, pktsize;
>  
>  			n = npages*((2*PAGE_SIZE/frag_size)+1);
> +			if (n >= (U16_MAX - ARRAY_SIZE(pkt->addr))) {
> +				ret = -EINVAL;
> +				goto free_pbc;
> +			}
> +
>  			pktsize = struct_size(pkt, addr, n);

And I think this is supposed to be more like this:

-                       if (n >= (U16_MAX - ARRAY_SIZE(pkt->addr))) {
+                       if (check_add_overflow(n, ARRAY_SIZE(pkt->addr),
+                                              &addrlimit) ||
+                           addrlimit > type_max(typeof(pkt->addrlimit))) {
                                ret = -EINVAL;
-                               goto free_pbc;
+                               goto free pbc;
                        }

And this is probably missing too:

-                       pkt = kmalloc(pktsize+tidsmsize, GFP_KERNEL);
+                       pktsize = struct_size(pkt, addr, n);
+                       if (check_add_overflow(pktsize, tidsmsize,
+                                              &allocsize)) {
+                               ret = -EINVAL;
+                               goto free_pbc;
+                       }
+                       pkt = kmalloc(allocsize, GFP_KERNEL);

The struct_size() of this:

struct qib_user_sdma_pkt {
	struct {
	} addr[4];   /* max pages, any more and we coalesce */
};

Is also super weird, that addr[4] should typically be [0]

Jason
