Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A6B3F23CD
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 01:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbhHSXoO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 19:44:14 -0400
Received: from mail-dm6nam10on2073.outbound.protection.outlook.com ([40.107.93.73]:55105
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236930AbhHSXoJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 19:44:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6FIMyM8cVgURkspbruz3O/WnBEQwsMJrzzTpU9oFXbWTl82Lqkmn49meLGDEuNE8RztkdLw8C1VdIRk1c8liklV6X/cp00VZHhPT6DmiADvXyAeqYvUfW/bmPD/bgl+khRusEBZ3CgfFE5hdI14y5Y3DKc+Y25GkT03hS6T2QVocUn4i8wB/4bjAQHacoKhw886xD/TPfHJ2vcWKU0chhMR+dgI/bHEreA0xLCTJmscwSttbM2hU1ve7u8eJt+3nQ2kVq8Wpf1zffF+txlZpMUJ6uOXvCEhffLIKmzZV0KNGX1LDG8JhfmP6jEdyg4eroRC+fiFw8W7uoRDwHK79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anzNqwt7B3ls/t4bB9KZ+mhNHLIN2593Rk/mAE2snBE=;
 b=mRDyUAguLeQB00ZyxwizBQl1aaMy21SZeUsf2tRYmj1CCkEoKvBoi4hCnOFqtZWkhl/2En63fMsHZrSwTWw+1mwF9dBYVG9K1AwQ0kZs+kkqmd1aBY2I7kFLzHMbWExiDIRv7tlTQtYJXf9EOX/caRnrQcLfbbbpE8451xczrV4R5eeRZ1/MVDJuvzrbReLf2y+rinzH7PKIh/xw2z5HF30Qd3X6NRYuvVS4e0UJVUo3BsrOUMcuMAZQfd2Mq6DowaH1mmEDeRse8qz1ya8bI/lLr31bymQTeNjGmHO6BMRWJDRb0TGhjjL+vyWWpyOM2xVxkDwY8wL5Xmy3u8uXKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anzNqwt7B3ls/t4bB9KZ+mhNHLIN2593Rk/mAE2snBE=;
 b=NYgO1/pewo216mnpD79P3b/wy9c1UbiHb+mLx0KbqX24J/k7u6cM2kIheT/l0jo/AgbYmJWK9SHJpSU5xN7EoJJYackFWtGLupyu5/zcyjFLCKIQ49EQ2mGQlUPs7Z7O2Em0fg2vREJGk2ksoCAY1gJjMTHTMzcV77JEhKm1tg9ywRX4gosa7CmuR4MTslThsu3t8EdcebdrNK8j9QJoRsOTBOQRdE8fDGmVQeUKwbcmntqr5OVIfXQ16IsDICKSEjH+ICa+t72yD97NE6KYuTNpQja++19nlTfTFhvAoLkPi1asJQgsPO46lk6TNWNYK9rqxNXSZddzr6drhcq/KQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 23:43:32 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 23:43:32 +0000
Date:   Thu, 19 Aug 2021 20:43:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, leon@kernel.org, Xi Wang <wangxi11@huawei.com>
Subject: Re: [PATCH v4 for-next 09/12] RDMA/hns: Add a shared memory to sync
 DCA status
Message-ID: <20210819234330.GA398239@nvidia.com>
References: <1627525163-1683-1-git-send-email-liangwenpeng@huawei.com>
 <1627525163-1683-10-git-send-email-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627525163-1683-10-git-send-email-liangwenpeng@huawei.com>
X-ClientProxiedBy: BLAPR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:208:32a::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0100.namprd03.prod.outlook.com (2603:10b6:208:32a::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 23:43:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mGrh4-001fck-VY; Thu, 19 Aug 2021 20:43:30 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53ef940c-4e68-44aa-04fc-08d9636b2721
X-MS-TrafficTypeDiagnostic: BL1PR12MB5173:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5173EC48CFDEF6F01B374882C2C09@BL1PR12MB5173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VrNmZRv5nnzBV7GtM0qaoE/ZWq+8dkBVrwi4dYBTs4ONoSkomuSJQXwDDQ8DCyRroEAp9rEPtVnMT1LXf8mt+TO9a+1AkWhUWWSPGh+c4Hd86M3NfkatmjZJOq86f7dtOxjWV1Kg4838FJw1YaMLSrwF9Pgp26MTdZ7GxVy6bsD0LJwqBQWHKA8LTy2BygHeotTlfnOHnpAw/oH57fPtobWxjMuhUM/oABoiZeWICBus40fRbvBiR8cSiVT/NvWrVl4W2dCXO3hC5kiXi59lGX9LjwoVL4w6P1qokkpXUGFGBg+BmLUSiGqzKlUv5BmJRQo+hF1uZAVHj2r5V7t6hWqxhpuk81toIgpopkDUZrijlXEIiJ0yaTnXaBeqNk+u2aSWl3GNUDDqER0GsUWajJUvVvAgY72FfOBpBB/DPIv+qHQgQCU5gBtaU/ftq8Vp5lCQqx3Cs3dKcUMlx/MZy8VG9hcTcc2aAue+cknl7gFVM1neccGZmQIoE5NJ6utKgOzSRPJehA/+iJU37Fh/jyrT8gnq3AkgW6DdCaoLlAO6dH/Zqzfqn0QxFZmMdqvzL3bwjMEcIeeU88Gox1ojHjZrT1RFdq0znvBkNWCUSE99AJw925mjTxegZ4yeqIF32qNbdlBYXV2wd74wDpr7oyW4tonnOJUZNhsbzoqF9rkzXfv8yKo0eaneX5uXWgvd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(2616005)(478600001)(6916009)(86362001)(36756003)(8676002)(186003)(38100700002)(66946007)(426003)(8936002)(2906002)(66556008)(316002)(1076003)(66476007)(5660300002)(26005)(4326008)(9786002)(9746002)(33656002)(4744005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f9IbTWnSTdFgrUjX4AEWoSOSXQkARaHBZZKH1CK6rGbkGY4CnF5CxNtLapQL?=
 =?us-ascii?Q?j90ol2jvYu75f+qJzhFXc2lK2sLUJ2qorX4TcHEzEfOTA9N/09s5RKNug9zx?=
 =?us-ascii?Q?/wtqJPQ8VtV2N+2Cp9IZyKn1g1iuJ8sAGlTlZaicf/JvWJE4j0akcQGz8ugo?=
 =?us-ascii?Q?v7tfFbgtLrBcLRNeAMB82/YdHTYLluw89gT0CxVc8uqqYFvGKjbQ1khZqli+?=
 =?us-ascii?Q?gV9ZdAZn9e+jQ38bBiCJwD2Cm1H5nTUbmObac6knedAVDr5qfLi8LLN40s0I?=
 =?us-ascii?Q?D4Ib0RI6zgMt56cujuUV2wc5b561+EH6r45rJLJFZMFhxk8tfE5JmzWSI8SK?=
 =?us-ascii?Q?LzX7/v0Hm9n+EX2jdHqGc1zIosqdXtLPE3aO0y0Hmp9or++dz3Q7k+Sr+xP5?=
 =?us-ascii?Q?syL3k5TCr4pJOZgFnp6dDS2cTkql7WGNf7NL7tOd8MLnfojE6KDZO9CyayQb?=
 =?us-ascii?Q?lgqDvp/pqPQDVvzSAfQMRaNi9BNxmSicdCPW6OV3Vxh28GTozo5kXQ8EbHXG?=
 =?us-ascii?Q?Uao6L97FoFjaA9NtWNUHleFV/4KXUSEXHMOtFgqhbdFWf6nmeuq6m8I8UYdD?=
 =?us-ascii?Q?T2aRChzEo0uffan5+YnNl+8hy3kLdDmyWX4QuF1QTSbyDEbxeL97ioJthcRK?=
 =?us-ascii?Q?xOnLcGg+nDjnkDwGHSUU1+HpeJeULi9AYcC5Z7pii3PpFsLG1zBsW1JHCnvp?=
 =?us-ascii?Q?6SKGRxxIq2XQRHfl1cIB1aah0AYrwaoQbus6xFCy7YO6ezac/QbRogHpsHCB?=
 =?us-ascii?Q?85aBQbChXlSxmTk8eC9taJnoMmxCLZp470hQqzRv9og69imLwwpfNOi+aUUX?=
 =?us-ascii?Q?A4yS9kHvO/fSIpkovw6JZynFUBPWgYHxfxhM4arTfwo3NzkL7yqnAclbl5aj?=
 =?us-ascii?Q?hgOIOZWGIQvuru/xziVdrbI8ENVE8GR3fVeytw7vgBhH9wh4YTnIeYiTmT9k?=
 =?us-ascii?Q?Ui1Q8TLXl7PtShLg7ZF+2StpdYQRtMhaRJL2SusEutifPCsKYK7XdAB7G4+h?=
 =?us-ascii?Q?FcolwRV2nyfJz+glOm0QAatWx5CoY3z/wIXRPlq0MFyPrK4N3m+deR4DzpSn?=
 =?us-ascii?Q?Wd5s4UovM0Sl7hYxnIUFBqPaNxfURfY6oBxilqtMQjH35tLdCaF/jEUCIs/j?=
 =?us-ascii?Q?ekx+iKbH/mlY+iP5XxBEcI3nI0i9OyTv2qjwNReuCu6QknByX7Pj/GKN80Hw?=
 =?us-ascii?Q?mmkDUUTY2OFGkVH9dtnZQQwuDDmhKe0ND16OA9gMOjQGD/ZpIBv2MVsp0y4C?=
 =?us-ascii?Q?b6vm3RyPEAY9VUdnCtxzmCPcyLbdflxegwJChLuDjQswFvzS1wDuOXSaJuCJ?=
 =?us-ascii?Q?LQmgsDG1NiwZl8qRH727boZJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ef940c-4e68-44aa-04fc-08d9636b2721
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 23:43:31.9896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dN4WSBxR8Vd83E8kGij9YfgY5hIkwYy9/9npmSZgcEyZugLmyplZtgi3bFSMBuya
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 29, 2021 at 10:19:20AM +0800, Wenpeng Liang wrote:

> +static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
> +{
> +	switch (hns_roce_mmap_get_command(vma->vm_pgoff)) {
> +	case HNS_ROCE_MMAP_REGULAR_PAGE:
> +		return mmap_uar(uctx, vma);
> +	case HNS_ROCE_MMAP_DCA_PAGE:
> +		return mmap_dca(uctx, vma);
> +	default:
> +		return -EINVAL;
> +	}
> +}

New code should not copy the vm_pgoff stuff from old mlx5.

New code needs to use the mmap infrastructure and new APIs with proper
mmap cookies for the things it is exporting.

See the newer stuff added to mlx5, the efa driver, etc.

Jason
