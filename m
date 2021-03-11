Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6FD337B62
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Mar 2021 18:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhCKRwO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Mar 2021 12:52:14 -0500
Received: from mail-dm6nam10on2056.outbound.protection.outlook.com ([40.107.93.56]:22100
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229814AbhCKRwL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Mar 2021 12:52:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xt7B+nWMNGR3iNXEM0XsyjBLZdeVZeaFmCl1GNN8cx5K8LuX94o7NNf/k6b/tJTtHKnwufbyvATdXNN3ofs7rCeeOWHT7WRU/7/dSJwXR5yNHW2QQPg4HsUwF0lD7bwgeXXdB/BzbnVU25MPTVsBAwcIUqDlIqPEAPIKa8G3KSqQ6XGu6HK3eDKW3UDjCZrlr4fhxuaKOo+0cXdrb4BmlFqpqEY6O6EjKSQ5f/ES+qiVGnhaUcQEg+UcsVDD5LSDXHV28QurxA8wN4rI9GtWsSDFEDlYnEtwfjSdfWPqRskonOUntQEP3jlDNDNP1HVdNAewpdUJknwEWfmSJ4u5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsqy0pgTuK4eh9GUDkR8ym6YjvcUBvf+CILetxaI6kA=;
 b=VL/DFX8KCNMs8+sH7C73FV/WeDlmH6d2t1t3jnRZKMzZ1q04AsuIDKsv0rM2o+XA9BodvfcetKe4XKpVRz0t56B8n2lVUu2ylk+DJUc0zgSVXv7x1enQnGJJWK1wcYYUVTHTCXG0wPmGZF6qUAX9ZsPJfvc8mzcjE23mO0vwutvfKA3EzZnq0v9FD0TLKlO0b7jJ0kZIuPcSuNyYFlwSqrFMZP9pVIzEDtMfLkGVHox0pveXPQPlAr44f0l6LgGMy+tnMkbqe9VAmP/atZGm4eVENdZDukCWi7g1Eze60UGL1ru1Kf7jeBrPHWeQEkktUx8loWlR5PghU9fbMKGJYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsqy0pgTuK4eh9GUDkR8ym6YjvcUBvf+CILetxaI6kA=;
 b=EM6WIdBe0iHL5z+c9sAZhLyNIMqmc0+0WVuYGXrJgW0PcQksruZEoTCT7wXHE9b/Kt7jXqH2OrHpbpkbI6wDF5H7i6mj1g1QJsyMmj1TMok/sM0jReKIB7O1cTTdSzpqdkLd0hh4iurhfI5J2HgVcFcNdMjNdXJPi+FSTZm4WAaMcFBz5TAvjZGApUh/V6P5t2A8w+kWeS8gbuC4uImIHEMR+bHSjdoBxp2eHN3q0uVWpJukLIsI1fRoQGHV6z970jADTizUKk2QrP25E3EndHhlfCWL2H/TbiHxKVPeOWZuNU0RJoEjIXrTLSyCOztrbmMK3pBpaoPSW+08MiPTsQ==
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 11 Mar
 2021 17:52:08 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3933.031; Thu, 11 Mar 2021
 17:52:09 +0000
Date:   Thu, 11 Mar 2021 13:52:07 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/core: Remove unused req_ncomp_notif device
 operation
Message-ID: <20210311175207.GA2731438@nvidia.com>
References: <20210311150921.23726-1-galpress@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311150921.23726-1-galpress@amazon.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR02CA0049.namprd02.prod.outlook.com
 (2603:10b6:207:3d::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0049.namprd02.prod.outlook.com (2603:10b6:207:3d::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 11 Mar 2021 17:52:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lKPTj-00BSas-B2; Thu, 11 Mar 2021 13:52:07 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 721d22b0-a60f-4b79-adf3-08d8e4b66421
X-MS-TrafficTypeDiagnostic: DM6PR12MB3835:
X-Microsoft-Antispam-PRVS: <DM6PR12MB38351416CC0E5B836A960586C2909@DM6PR12MB3835.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LmYFmKdRYQj/99/wON1/elIOhlyyp0gbGUV6VS8Co2AhdzfSSbK1bdCSOjNW0YuH3ixEIOErM6K5X/L4DysMCpQ2kAgogmxK6CA2EEaW9BB0JAcirXAsRnJLOlpcntwbEh29/QSdUuDxcmW4tVXsdFbbq4ZzbrwU87QwFWXqaO2Ps++cHrJ7DC/TLXcOuu/7+YKXw5tMRvlQt3yME3I4MounBbPIVbMKx1WfNcCAinNDREHdokT7LRnoAP2geHlU2n9Whj4OSHiXEDrF2uruSWtaLEjaM6Pho5w94esytfx3O594ppPfz9zhGq+RzcM1LpSdNtH1WqyX9Gd0rJllm8olm6BWQYpinT4LuXyDp+MAhkADFfL/KI0fH3dbOqmu3vHZIdY2tOtDYabW+bHY5oWURp3LrsxbRKynIHvnLWKN81ss+neS4FsDovdXAdxm+07HmXBQzyxv2gzs4qIjbQCTWag0KyQZopTqgbhlxYwZI7tX/H3S+IOG+sEo6XVGdR5qN+t2Wnvh76EHs0le5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(66946007)(4326008)(1076003)(9746002)(8936002)(9786002)(66476007)(2616005)(186003)(6916009)(66556008)(26005)(478600001)(83380400001)(4744005)(426003)(316002)(33656002)(8676002)(36756003)(86362001)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UYXQRdmA+IeNQuoV7kbSzeTkfbrCbW/Qwfq9HWkd7jKkQuI5fSTxf8o9AvpV?=
 =?us-ascii?Q?LoWhgcLU2AT+Yol/XAQcHeJLZbj5lrljwTZfW7FNERnOshchTKbz7ynvFniT?=
 =?us-ascii?Q?Rkir3KuRJeCVNZJfxYotIV2zuxecba+b3WjSBkOq8iOUyHvDzg4iULPnALLw?=
 =?us-ascii?Q?ufsKFnmzJrA8Qwz/QGFYneRHUrhUxLAw7AqYory3Vk5FBHSI/FxMt9waHH15?=
 =?us-ascii?Q?DZFACigBS8cr7JYaaAjHjM2aDxe41/VkczqL1qFODlXnOP/IZ2BPGJX8o04e?=
 =?us-ascii?Q?37j2Pf+J/90Ss8GMTwOc856fvd0/B+j706uS7kL9UudaDgwu4IP7vlx9E+SF?=
 =?us-ascii?Q?xQw67vSm0dt6u8rVhMAT4AQQQFZoxr1HkGMiI/ZI0SNqamxCUz+5F7otUHmt?=
 =?us-ascii?Q?B0Yni/E7gQq+T9ul12tYIa3Bv6TX1zp20NCCJNI2+dqDQMfkyrJ2MnUcqax1?=
 =?us-ascii?Q?xwWbTpGrngIr6OjuMhr/WE8Xh3SJwYkBPLGcs58TVT2tZURQElJgIkykvyxG?=
 =?us-ascii?Q?lRXWvNbCCRw5Ek+4KKlt2iSSlc2A4NP5ULCEUtCoj2G32+bHL31XjBKEpWi3?=
 =?us-ascii?Q?vcaY5Brufrgohigb/W4yhz2ybpHL+PjfrpRO3BEZH8WoElQl61vtGLrOORAf?=
 =?us-ascii?Q?AkCp4LwZlvMPPyYs7KZu0anKl+9dL8liFAYIxmLg+CEA63gDHME31jFBu3iQ?=
 =?us-ascii?Q?wtGcaDRUDsNXtJV6PluOx8C13oJ3WeRnxWxessttnnj5szhTzOqH/e+JaGdN?=
 =?us-ascii?Q?i2EyYWwT7v2glQYnDhObz/Vn0P2SApSXA+t21zk/CRYDDt8bbY2Z6UQkDzWB?=
 =?us-ascii?Q?/yq41BDPucpUMWLKiLidFkrOZQDzTnbdFCS2BhFD+RbqJGbGlzmfULONFqyR?=
 =?us-ascii?Q?tYdWd727kvObZulNNM5pFqzjDitaHMd/Y3zTFqRaCxAuNJW334MlpeLM4Lqv?=
 =?us-ascii?Q?Al8PjslKoM75mPYnHQWsWr5YFNywP7MAbQ1BCBGldMJr79DXB7WUppO5SPIn?=
 =?us-ascii?Q?4WaTPElfN0KQRZMI0YZgk6qQHDOv1EjYH8dJok60knF5rgimPRVK+n0qQPel?=
 =?us-ascii?Q?oRYCD1IzZoYyIuvop6vb1rBK44O87P2IXOsonSkp47FIsvN7qK+rbVS3HQTL?=
 =?us-ascii?Q?UPXto9MCVUWAXbzfIVPXcS4+KVZdRyGY91AMpVaxAcsjpJ4A54eKtPMgNiOT?=
 =?us-ascii?Q?XoECy+ViA0R55GGThpesLXEiZTiAs4Hx4OVdnYmQ0iJDNcCMwgYgeF8c1XFP?=
 =?us-ascii?Q?we6Z+i0PygvuguUCGHufu2ILBmLfR0b0g0+soTXoyuBqlaZLF8/2bRv884gf?=
 =?us-ascii?Q?VUWhpe7cje1UB2H3WAUHL8S6SN9Tm9FdcjrW0cloc6FJdA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 721d22b0-a60f-4b79-adf3-08d8e4b66421
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 17:52:09.0393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AJkPkGV6moApnEQp9L/Ft0yJyaZcIYyjIc3w6Ze5lU5naeebbihQFUQxoobcIjt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3835
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 11, 2021 at 05:09:21PM +0200, Gal Pressman wrote:
> The request_ncomp_notif device operation and function are unused, remove
> them.
> 
> Signed-off-by: Gal Pressman <galpress@amazon.com>
>  drivers/infiniband/core/device.c |  1 -
>  include/rdma/ib_verbs.h          | 15 ---------------
>  2 files changed, 16 deletions(-)

Wow this is all the way back to the beginning

Applied to for-next

Thanks,
Jason
