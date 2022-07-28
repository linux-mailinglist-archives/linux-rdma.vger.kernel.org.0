Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218D1584481
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jul 2022 18:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiG1Q6L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jul 2022 12:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiG1Q6K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jul 2022 12:58:10 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E011460517
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jul 2022 09:58:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glux9JHT3c6igEyauy/v6gTj/BjpYcQkXBRSg3aBO4eCVTLZGiNmBHJiTF62amYswAxYYH06M2N7oF9N4Uq3bDPzXTgF8jrUfTVbNVpZgstf0TQu1Bk62HmeatRivsTaFlYrpczbmny/A8253jhSok6GRHgdN0HE6FQLWu3FBKnf7vWSFeVymVbZo0UY8z+87aXsMJ9SwoCULeZu5pB0FFpCHFpmkLWsDSFj344dBSCv2raQE2Q1A8x7ySSIAfMFN9yze3H1GXZfPe/OJa9xGeoPzNWtXasZXU5IYzND7exvmNoYS+RNZrMVBaKfbqQhqMTB3adhUz7Q2Hx8pmkD6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AoFthh52qlGaJMe+z49/IgG8262PUQK+ejrfhYOlEE=;
 b=QlcDNfORYO+v5HZoyuqu0bxnb02WrAtA43yIQT9XvE5J6dWwevO9UVAGh046MyY0QoAvibigwXfLQa9q+kl/PD7ganModGdqSr9K5bKGIfyyI/Ew0PM8AzHmBmZOGeHVfUwvtEb6PrBtoBlggf2e59HQacDetVx2esLstotndodXU/tbj1+cthrfn8L/91n3wFVb0k/s1foEwbaRwP4ULU59muooFGpkQuKePlYdQFFrSK9cRBuDqtTp5hETMCWhele9BqXoLVBXuCdbYfVcyJvWW8Iemw13h9MYLoJo3XA+KbJPnoUWHFAyP7pTsIi9m8JhMsdT4vGZ6dpbPV6OJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AoFthh52qlGaJMe+z49/IgG8262PUQK+ejrfhYOlEE=;
 b=MuJB/BljdXsoxBmfrt90bKTs0Nm7sqHdUNfn6anv3ICfjrrWlIxN9OzMDE7E0bvd0roNlVUvT1yuatSMTxSkB7SYR6cNw2cLeR4qKy0/FCQbPyM/mprxz54GT3qGM+28cFTMWkcbtCh5ygfbOcSbegmgJb1EraSs/mUjR9T/etOtQ+ESzBm5Nn6wGCUHThWx7HvNqGil7MhdqSLQEkqBlMvo+/jqac2KoikqcmKw6td6d4r7Q2QzVgHtOjWrOCOkssVo5d/UVum4CBklLSq9H0ZSnqMswVVqVpFICuphBwCQgUi+zdbrsfVEW1aI5kFOwOx25OQIIXddPGu68v0Cug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Thu, 28 Jul
 2022 16:58:08 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58%8]) with mapi id 15.20.5482.006; Thu, 28 Jul 2022
 16:58:08 +0000
Date:   Wed, 27 Jul 2022 22:03:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
Subject: Re: [PATCH v14 10/11] RDMA/erdma: Add the ABI definitions
Message-ID: <YuHgRkOkuU5itoIe@nvidia.com>
References: <20220727014927.76564-1-chengyou@linux.alibaba.com>
 <20220727014927.76564-11-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727014927.76564-11-chengyou@linux.alibaba.com>
X-ClientProxiedBy: BL1PR13CA0126.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::11) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 092e3334-4ee4-4ed6-d944-08da70ba588f
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRE4Ym/IJTcOeMPUXsc1lQH+ZjQ0HjQWEVcFN0DuTjP5eVicH5pTGkocVVZ7hxZNV3GMFn4oTCBAnTAMIwSdRKxEY4/3t5y/z5bwLbvrXJqxIQ++9W/i1fUZ9tbzaYI7emUJkUbKgcxLRQlLuTo+kZ/JM31+EC/Z9L8Gq9X5epnFQZ3vqWs1eQpHckuM0vuwteOWLW8lakNAeV021m/B9pqo2LxtP5UMjCC+k0JhSPdEVLQ5wZTgBQS4UdeEQJxaMw+nG0e2WHKM8eDEZHj39hsfByzPmGnpZwL4ZxX7mkoHlmFbLdG1crtQ7n3bqHtrBURX6AZh3rYVaSsdT8QjJCQWWrikIqmycvvbG72fzWWqfadc0j+x2msXO8pBgfaJYH2MHjd7C8wVAAOPlmc4jDTtmJu2IgVvLRF6lfm0F7BqZK7K6GYW1+fRVF5La8/B2/8B8MGz5TknuiKq0OhBMv1CfPjHXxFSAqlqBPERAuH4NuWsXrkjJ8ypyl15qDazDCDJDACqZCwtBHr/qiiCs0ymJIit+vVeMk3p/xyJmneh+I2fDNQmOqNS+jy0tbI5k8GKSpZFs8r1IUrOcXYH/3cFu1EoHbHJfA0uUyyA7A6zEaLxi++/LqfeZWQ6MLoAuND1Z1HQw0JIpLH9Ha7vUpgERmX6qHQZ3Wh5GXWTai+lqsfruRfwaNA8q2f5CI9Een+zgBcLT1Czt4/GgiUZtQruwpKHIGTCutmjhKW1G5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(86362001)(478600001)(6486002)(8676002)(66556008)(4326008)(6916009)(66476007)(316002)(66946007)(186003)(2616005)(26005)(6506007)(41300700001)(38100700002)(6666004)(36756003)(8936002)(6512007)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6+8QBuz0soa5jaMZ6ANjfmJbo9zI7mwE/whH93D2Qx8+xxEWvQMJd+thuxka?=
 =?us-ascii?Q?IFWUoxBB+482emcrTa5lgtt5cPYuCl4iY1YJ/1lgAFQWPdNR02vICUyYcgmI?=
 =?us-ascii?Q?lTSsaGaKZ1q/t3ybkfEVyd7OvjJ2g3qk/9SO3h/QaTXttjwQoBx0Bs2uS/Mf?=
 =?us-ascii?Q?Uj5NEG2I8VIHaZFwSd+bvqGsWr36NUrtKSvaePHUkMNxrf/N/HEJVoH+e6EY?=
 =?us-ascii?Q?hF6gY0ps8cx/4m7E3hjsiX38To7kUUkgSjxBmx2MzYHCpHJ5rkWsnK0aTHu3?=
 =?us-ascii?Q?REjpOzt7bd6PiVdqzAD2Ru7PQTocQnHGX+ROoHe7/55F+uBw5s6vgl/wKWmc?=
 =?us-ascii?Q?ypMV0cONiXPqta7r5R3cxck4UCQrzo2QwOZJRKpbfuqdQl+6Diz6CDE+wfKS?=
 =?us-ascii?Q?V8Zf29mWvtCL/lvz8w/25UtGQ3lPWGr38nh4ZmXwEKRUedplXVE1Efjqmcep?=
 =?us-ascii?Q?i1IsVw34uzqqJgu3tbtdDQSsj5mU/2RDTQNBSLB1aAX1qPryNMFfp7YfBemI?=
 =?us-ascii?Q?taR9DJWr7lrt1fjINinAQR+xd9OE8mVp91gPjGEHgzT2V7/yOsSEwneJZ8OY?=
 =?us-ascii?Q?Y8KxfyYnM98BiJYpuhnbJEzl+epMo2r+n4pUuIl45E3ZD8CELWZIwc7Nk+SP?=
 =?us-ascii?Q?wBBEUe1EEZwvQssoV06Lgyg28KBWQs9CCLMFuskflbygOTHuvDl6kOho2ICR?=
 =?us-ascii?Q?szCwydtVBjHxzgd7nQL6nqKpZFCQAq8dZYjHpT5pJegdn6+09+ZWyyGxDUY9?=
 =?us-ascii?Q?oXC/rGy1fINPan/Mhb/NZY88f6G/BSC04ruqupFNGMa+e5Idx3aJpWDauiaj?=
 =?us-ascii?Q?8eAX2eeX6dxe4CsJ8DZIziAZtdbemJCwd6h2vsI0ZhD2uqdQH0RHmTCJYj3s?=
 =?us-ascii?Q?dOs+QN/8z+GJW5JWDiuYWwexBZUSP8BQc4UVcbGIZG1o357Xple5GoJsL2N+?=
 =?us-ascii?Q?5lDyqLc3F0RHklOlRc5K3Hjrjz0KLqxc0Gx/0PyUEL9VySUrdX4sh3Q3fhGf?=
 =?us-ascii?Q?lLYK2zUPcycshEmJjdsU1xVy8gqrGjQHePr4UwAXOuAawGFPzNHKdalUGABX?=
 =?us-ascii?Q?lMLSuZnmgfU9Yydjps3wgCQWUO2cKq1Tjdtim2107QkF1utEVV97Lb+GTB+g?=
 =?us-ascii?Q?/pAADtw8b8Mo83zz1R1j5wcmh678/t9Ee1vc6xdkzj9N/UrewVCz5/VIyvtF?=
 =?us-ascii?Q?TnG4N/FZ6LSwYm3Jrc0Sxu+/sEr/0+peqSB2xDJtJjxfwb2OTaZrIWFQYuaw?=
 =?us-ascii?Q?8UHMo96KePny2ZyJeJ2gbROWZgijETRsdtg0YciZZ0dhrVucNE2J9fT4uK3I?=
 =?us-ascii?Q?eEoK2Kxw7FRFrn/wdboRCz+k2sjolfRcaFMCxVWTVy9t/RGtjlOEcNGJBO00?=
 =?us-ascii?Q?MsesUbk6AZh77fHc9H6M+ishTlERyPN9zC6y607KlQq1e12foYsYmDar+SoQ?=
 =?us-ascii?Q?E00GJcHhPdeDiNBKphYf1Lg3bWv4ERmjlfrOLeYd+nRKN6l5SYLdYaxVOt1+?=
 =?us-ascii?Q?TZngDD6LM4cBauIMdiKTqImBVxt9CmxmKvKmPbYOumxspH8I/wa6SrfxxFj8?=
 =?us-ascii?Q?i6F3CNA9TNbGCW3Drn7iP3aQldflL4oZCnDryb7V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092e3334-4ee4-4ed6-d944-08da70ba588f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 16:58:08.2458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdH2y1D/AGmkriLuxtw3QqjNAJK8qJB3W0Plw5lJ9PpAocO+X5W/WXnZCmjw3+eg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 27, 2022 at 09:49:26AM +0800, Cheng Xu wrote:
> Add erdma ABI definitions which will be shared between kernel and
> userspace. This commit also fix compile issues reported by lkp.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  include/uapi/rdma/erdma-abi.h | 49 +++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 include/uapi/rdma/erdma-abi.h
> 
> diff --git a/include/uapi/rdma/erdma-abi.h b/include/uapi/rdma/erdma-abi.h
> new file mode 100644
> index 000000000000..fcbaff1d84c3
> --- /dev/null
> +++ b/include/uapi/rdma/erdma-abi.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> +/*
> + * Copyright (c) 2020-2022, Alibaba Group.
> + */
> +
> +#ifndef __ERDMA_USER_H__
> +#define __ERDMA_USER_H__
> +
> +#include <linux/types.h>
> +
> +#define ERDMA_ABI_VERSION       1
> +
> +struct erdma_ureq_create_cq {
> +	__u64 db_record_va;
> +	__u64 qbuf_va;

These should all be __aligned_u64, I fixed it

Jason
