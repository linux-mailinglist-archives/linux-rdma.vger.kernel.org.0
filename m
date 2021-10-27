Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5746A43CED6
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Oct 2021 18:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbhJ0Qmq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Oct 2021 12:42:46 -0400
Received: from mail-bn8nam11on2057.outbound.protection.outlook.com ([40.107.236.57]:47456
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233805AbhJ0Qmp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Oct 2021 12:42:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWEPnE0OxTAaSksA0UrSztky/jeZoZE9XtRH9azw8OMGV89Dqhgcvnw2N4kANMEGtCA/0LubaQM8PRvyqXVuomlAYJmJks/lZas+0ghdrIZGxgtPVpA5nqCNkLDDpa8ky12GInjEQgvmXMgJ6VhfGWGQwLl/NClTXmQg5xFOQnorG9ZDyLtY7jAzGBo4J9WJqpcGkpU01tFRT8/Wclr/BMCjqAyrmqZCzK1OTn6T95aYC6jZtsIQITVdfpkzjyxxSrwHhXpzQzSYSdXRtAOd5lwxunwKvt+yVxfc6qDSBqCSOrWTcn2YzcCC45FCkX9wto0aC+kT+g79Wnxa0oF6fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4jBulMRnu0ZL2o/HknZCP+l7+WZVeA1ljr4N+5fkp8=;
 b=YM0yVH7pwBOS+Lnss2AvbI5HbjBQzeTaZJRpSn7gGMWVd3A2PukG4Q/e2OaIVs/6e/HYLGB3OgStjyrVaE2eV8LzzMFU+1sm3rh+WhU7vwPOfjEy8mvMV55WvrpqfjMce9K+sA4zeMXhaozS9X1DTThD3iJIeYeKYUK96MmJHb2ebVKhufnPwTH9sfToyeJ6kgnMrS+gZEeIV6Z/EdtoDSQxk1ibiWd4FxHe3tQhIGvJlkL7pROGfnvs9LyRs3wyaKEXJuDBmx62q1peO3T5GVpkJ7oUz4ZoXOxYxLRO90bxQIhFRY2Akp8FnHHJmpyyo+UcNGpF84qNYWqOLh9ZVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4jBulMRnu0ZL2o/HknZCP+l7+WZVeA1ljr4N+5fkp8=;
 b=QIixG0tLJ1hMfGJY417OW805ZY2tX0Vh/bMP7qwv+LPsm7A7l1dw/9yDI8svJCnmOEw+RdF6vbo8FcQ6/BTF6TmmCrs5/NCrZL6towo+5yM5AB9OsM0ABr0HpwEwFvroPuS5UFy5HYrmtDy1OQWrWSoI87U3R+V/0ILe19Uj0JsJKAa/bZf+I+EPjUFzsUhKpzQyMx9g9AChSz+WoZhfJWd4JymOqomLhQxKunexXytyGJSV52JMzF1oVc9LZ9CGgcTCUP0cvIpkI9UzmC4PV7zCi05UZ6MfpXeDKiw7PIVLN/A6Lzgvg/Pi05YkrapJP+uekWlV9nI0GLJqfOfugA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 16:40:18 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 16:40:18 +0000
Date:   Wed, 27 Oct 2021 13:40:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markzhang@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-next v1] RDMA/core: Initialize lock when allocate a
 rdma_hw_stats structure
Message-ID: <20211027164016.GA631278@nvidia.com>
References: <4a22986c4685058d2c735d91703ee7d865815bb9.1635237668.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a22986c4685058d2c735d91703ee7d865815bb9.1635237668.git.leonro@nvidia.com>
X-ClientProxiedBy: YT2PR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::17) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YT2PR01CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 16:40:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mflyK-002eIE-VE; Wed, 27 Oct 2021 13:40:16 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9013908-2959-4c2e-bda5-08d9996875d1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5191:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51910415367EEF5D23CDDF96C2859@BL1PR12MB5191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /5W67mdoXIJB6rs+JomwakQu0NljcOcSNLdqkEgO9dNFvZv+uMZ9v9eeJB/rRTmbUkmTd6wrP0MIUtZmhfO2A0RjS9PkR3Hp1qLX8hr81bWL5E2XZFFjhdmK0rby+Jbf/6dqQc/QFaS5z0Fq10VanCOW+YhytrYAUhr77VOppIS9/Ey/q1wKD1q0QNVT5beuwCGw8WoUJ7KGNDuWdVcsrWSZU44HzncomtYJQPtFhMwx0jgs6vsxOWODr+GlluWBPv7LlC/Yb+UhaaMCoVD8XoKg6T46fLzfX/UKxMntRRpfNJxd87eIHrQnj82dnwqyzmgLBCuYQrU8dk5h8mIQDyFhsc/cy0Qgehkad8sIyY8nTCuJjbBOojqSSsp3ADfmhHHYfNEZtsiYSR1XvWp6h0NXbuAvThOR0koF5S/khjVCqHuA63oPTHA/7F/syiYibLOeecLLBdHKuf2ijkIr/jSZwuNMbnJ39LYWjcSJ3WUh7BGdrGCFZJTTi/UArEBrrtMkxwJZTZ+jrKA8YjRM1OBb/EcTz5d3jRXrxEom4GW7ogCgTS3NIDZSYj07xq1Q7dSWDJh/fICvWP7XK5DPx2vT7qGwg6vXD0JRbKKB/0/Gei+T4czIna97aePp5oekOFTbimZ1eVlpy/JUTqfket1/Hg6nkf7SgwmKRDZ2NVYL6ncGRWRBHA1AqxcG/Vu/wJplCp0rmTaMRrKm0zBz6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(186003)(38100700002)(316002)(107886003)(33656002)(83380400001)(9746002)(1076003)(5660300002)(9786002)(4744005)(4326008)(2616005)(8936002)(426003)(2906002)(66476007)(66556008)(54906003)(86362001)(66946007)(508600001)(8676002)(26005)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YMBtVsVlOYDN9lI2eyqKpMoPb+MpVN5exvaoF2tDfvDzhPY0isn9r10cvbmC?=
 =?us-ascii?Q?Tk7wbAJH6WtvfI1bHK39+v0dV3QHjQ31XgEMdTmapxzUfAhzOnP+L+ThB+gg?=
 =?us-ascii?Q?6naPvM6SqyamcQmIo7ZsEa2E4ryvqp2UrwNlDKxyInbbwTXjmX+SSzdtj0IR?=
 =?us-ascii?Q?MOgEkTDUXpV0i+WNx0+PHmkdXigwA6Y3IaQdVOIYlg0x0ri9oTEb1RPw268W?=
 =?us-ascii?Q?9KCTSGHJRpSKAp41Kj68OZ+qwRf9vq+j7HXu6nCMOoQb98dxlcDD0xL80Ad4?=
 =?us-ascii?Q?9w9KwLF7FtzYrOARfNQ3N1xFARTUEjfju7nG2bPYVysuTxbSc+4ek2A6LA4X?=
 =?us-ascii?Q?c92t5ji64TljBxFTjO+eG2nGqTnftBH3Dz9Tze7SGoRnnCtILuPKUDoZQzut?=
 =?us-ascii?Q?fD4YlvSd181DuZ8KnbFC4zxx8iHnFux4lEf4sjskIuZMcgkK6j+pUEmcKCui?=
 =?us-ascii?Q?vTR/bQifMqKqhubhKdnA7SwVsVULo6zCnxg3hkGLT9xA3dXpLv82fifx3/zn?=
 =?us-ascii?Q?F0Y0Rri7BBZZRr0B/jCnfZ+oCExc86kcuO64Qs/2O3XEUa2BkabdZ6kN5Q+M?=
 =?us-ascii?Q?N4sNbHllUtAv8/kdYXC+GEaciJzGxVC3vDg+1R+eg2jhArrW383KexRve4gs?=
 =?us-ascii?Q?oD/iRVnn1NCYGZUcG/Eh12fN+nSZOUCTVimYTZ5P5p6uyaqviQIXtSwjvl7d?=
 =?us-ascii?Q?Y5QTR00b8GXVfY0Y3QLPAVRBzQWW8Zuh8XWEp3x2cnnYwK9DS0sCGLxZmduO?=
 =?us-ascii?Q?aNLM0Hsui9M4mbeqZNWSJCoDzHJyZegEDDVEflieMyuMIfy6IoEHz31bVlsD?=
 =?us-ascii?Q?NQmGwXne5AcOqQ4pBE6hyC0ieZSD+/7BPN2mE6dyMWK6ZCzS8dY0OttdOLk5?=
 =?us-ascii?Q?86L6rVmhv4eTJag0i0DluPXSTkWot6CtxxmMosUs8f9b3W07mswFmU8fCTIb?=
 =?us-ascii?Q?K4ArdkEBFRpRv983i4s/ql/4Ce71jZmGejfPIB3t+utOjbDbSWdY/Op09hO4?=
 =?us-ascii?Q?FZG3rGkWhUHPPLJnasL2PCVFgb/dQ0zNMAN9FTlIJi7t2SyRJU2MgmZqYg8N?=
 =?us-ascii?Q?Zd63pSsgqfBDWes7tYl3Ckqtz4s05dqYC/337oU0YQ++L3xjiP1ABFVFv3xt?=
 =?us-ascii?Q?fueKg93sK+m05oSe7ZnxC2EarRRtWh7TK7fIswGoQ4H7zoTWSINUApGgbiwp?=
 =?us-ascii?Q?8Wq9f/bznoSLMjfu9/uep6X6lx854U9FED84MCAo97hQ7eifousSd2cDAm8R?=
 =?us-ascii?Q?OaFrIOD4FKArsRhlNFbpYpYMR01icRxszbW5aJGrB2gadxc75JkWntcqp1bj?=
 =?us-ascii?Q?y2KIbVYgCV1vApw8F7puc2HrlAKJNeWtuTslWD6venZrwgV2cCtvIUn4pT9U?=
 =?us-ascii?Q?nHmsgWv8qdehM+P4M9OuYqKPIK8yVy5DnlZ2BMgfvufkPN3v9hO11/KvNVz5?=
 =?us-ascii?Q?3v33cMz4wMKgg7oWdd1/zDxsOiqe7S1i7fowCT/zz66LbkRof+L2HICoXQmt?=
 =?us-ascii?Q?OqSfWUW0eRd8b5cqWlzTI4f2Q6I/dyLhUxUJzSvSYZB6jw9RmvPwEN1P+8iZ?=
 =?us-ascii?Q?SLbBzndNAwGa1Trr1Ek=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9013908-2959-4c2e-bda5-08d9996875d1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 16:40:18.3606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7OGMijIfqknvvEay+cyQCsHRIA4usx5xltajvncTq7vQ12Lehxd2ENM8iRJsEiY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 26, 2021 at 11:43:03AM +0300, Leon Romanovsky wrote:
> From: Mark Zhang <markzhang@nvidia.com>
> 
> Initialize the rdma_hw_stats "lock" field when do allocation, to fix the
> warning below. Then we don't need to initialize it in sysfs, remove it.

>  drivers/infiniband/core/sysfs.c | 2 --
>  drivers/infiniband/core/verbs.c | 1 +
>  2 files changed, 1 insertion(+), 2 deletions(-)

Applied to for-next

Jason
