Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B27027094B
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 01:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgIRXvZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 19:51:25 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:62561 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgIRXvZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Sep 2020 19:51:25 -0400
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6547f90000>; Sat, 19 Sep 2020 07:51:22 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep
 2020 23:51:20 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 18 Sep 2020 23:51:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMaWZdvbn5b+YwdMrjh3PY0vb3pkpnYVF84g8XO2ltkx8X/fB5LZpyS89lPqETjdGYkzyArMnFVY+h/gtcP1rfNnt1d6TlB/gjzs9e0bNLELSmW4jy6zhxxsQo+LmoYxx5xjKewHOtSL1xkt4VPcm7ibFcQ6VWiGNa+5Ai7BSpnfYWtwRreqgNT3PqE+7w5v/vwQfusZsuPvWvOEzWxaLOh6EpkMDN/KEjJMiLfpUx3zFKZbQzToAifFP8izqGt9qmDU93cnU72qQkuanQWo5iBUZxQczdMZi3QHdQrsWdR55REw72yaRA10qNwuABJzV9bMWwydOGxs27EcHN/C0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myK0CUoDtgR/5JahAC/aZLdPpDsyaFneI9d4ol+bijM=;
 b=hlBMPQODt/zMV2MNAlII4XkDuPVDqlQHdmmC2nnHcWTFZCWyQbjWAKaCaKYL3Kog4pQhHu0WzUB0WpLtN2+tq3B0OK1g8Sw1wY10419vbm1FqMVELTdyYH0v7S/RaBbtfdWzMG+TOHGFihSApS8aeRk+I9iuu7wV04aT2mIlqrkwcfVD/Q1kTYBrB1f8zFIUOohhZiWIrb3pAB2cbMTuBjH2NMWV9uWgLx3ahO78TfOzvAaJk6xnza8Gj52nXLRFagQt31ZYoA22WlTMszeUhaKld37u1vfXj1DAjxPY5tMeN4nW4XS4F73POzN/QYvCy4hVQwcgJkFcqYss36J8Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3594.namprd12.prod.outlook.com (2603:10b6:5:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Fri, 18 Sep
 2020 23:51:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 23:51:18 +0000
Date:   Fri, 18 Sep 2020 20:51:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next v5 00/12] rdma_rxe: API extensions
Message-ID: <20200918235117.GK3699@nvidia.com>
References: <20200918211517.5295-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200918211517.5295-1-rpearson@hpe.com>
X-ClientProxiedBy: BL0PR1501CA0036.namprd15.prod.outlook.com
 (2603:10b6:207:17::49) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR1501CA0036.namprd15.prod.outlook.com (2603:10b6:207:17::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Fri, 18 Sep 2020 23:51:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kJQ9t-001tl7-FA; Fri, 18 Sep 2020 20:51:17 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ad0909e-8a28-43e0-49de-08d85c2dbceb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3594:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3594CF217195BEFB07CCC8B9C23F0@DM6PR12MB3594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: odwQLBocM+5sUZtr7CAfGJj1PjC9+q2JIyhGDlk7xbs1e5cRzrErr8MDWsFV+gu5uUwYIXuHpSPrZfjG9tuDrV7gA6vNhuGI+8EUo+heNQxhHJ29/FSepo+db5X93mAvqSU/apLjoZWIDIeNHb87zZE7IHMXXcaIbadjEm/12zkK9M3a8Qa1Uc23muegh1O6P8DNr5HYgRLTBqjimgNZTqW6F+97erMAEACs1sr8RUfrG6Zh4vYgqe8BmDqItX1QEefLjrX2eK7Ql0Wfmh1VBPL8WtW+45jh1N4SUUYdoK0vjXCKAaLnmO6kLHO41zNq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(8936002)(9746002)(9786002)(6636002)(478600001)(33656002)(26005)(186003)(2906002)(5660300002)(36756003)(86362001)(2616005)(316002)(426003)(4326008)(8676002)(66556008)(66476007)(66946007)(1076003)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8DJMkjjx2A+PqGgI7bO9NvQeaw3ZEHkSsJdxgoQ3ytjI8JgPUa03y4lewZpHTj2PGIkhLbJfgy9Toc97mkltDgLt6vVyeEvSceeRpwgCVpimj7O3zRcpo5REbEWmrqsw4wTjKT9D7sgX97BE3TffZxldvZ1SQffuXiC0vjxf4cPsb7yb7PKLOetw5UTBTvYkDIqax0obt2iTZYZauagrv3+3zXraO/stP52gT21dCd34SzupZj0Czrw2qGP2rGzI7ptCquIbkhQHsI6my2n/klwdgDbC6fbSVjamWyaUaWHPSu9PBV6XrZa9uv0Y1A9cGEbZmGrdwRF+OPg0Mw05WV4LBI1t6mlHtqHI9zlMYCxg/Wp/6r06pQB8TXNMYpebfBQGlLNECJYxghoBHzTWX5clDSJY4BbBiNLiLMd2bORbXkqJ0ztePDQ+icapKtHnhis0Ua0HEC5QV2E9wnov/aiGzuysFw/8OqAerMFFg/Jh8DI3sUIG3rmWmcPWO25m0fPnhlMeFVtk/n21LjEAgjUJEdDhWkWOe05B0J8slx5q411OuXhsRvJzawhxpQw5sHSbxkNW3GY038PkQmqmez0tmjP1z2Hs3fcQGpe6CSOympAndeaC3CjdISqhhZTD0OhMPrNmae0f1/qX1pq6aw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad0909e-8a28-43e0-49de-08d85c2dbceb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 23:51:18.7454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5AOCmNXSPHZZtDGWBH5N7mtI7bu3OsmLax+tS4ZVm28Q9mhQDN2jTIAJuP1f+K3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3594
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600473082; bh=myK0CUoDtgR/5JahAC/aZLdPpDsyaFneI9d4ol+bijM=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=n5euZpnRTJfffFsu+JW9i4LxnijSMhMnv3vbiHjC6B7HRAeyS7YP3K6YDS/ls7tyY
         yEfVzIqS/p99Ysm0KpEn7hA89Cr4Xj1d7qvv1l/LB+ruz/7zE9ugmVWxuAfYri8ue6
         FQB/1AMi09tabTuDw0T36+U9EwN98DyOw1GyXMgHRpPyFE6qaVea3ifI6oz/mUSjS3
         CmnU3I8MLkxCSHwJMlzGbKncV05LVkUfM3k1qUrf2GIgkbVtMEmZihUssLPY8KA2Ku
         reDXQQuCIpsGPlqRQO03fBTY1gf8+VKwokH9LkaNv7WQXBiaFDiM2YKfF8gR/EaSoT
         gRu5q7UT7HkqQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 18, 2020 at 04:15:05PM -0500, Bob Pearson wrote:
> This patch series is a collection of API extensions for the rdma_rxe driver.
> With this patch set installed there are no errors in pyverbs run-tests and
> 31 tests are skipped down from 56. The remaining skipped test cases include
> 	- XRC tests
> 	- ODP tests
> 	- Parent device tests
> 	- Import tests
> 	- Device memory
> 	- MLX5 specific tests
> 	- EFA tests

It seems like a big improvement! Thanks!

Zhu, can you look through this too?

Jason

> It continues from the previous (v4) set which implemented memory windows and
> has had a number of individual patches picked up in for-next.
> 
> This set (v5) includes:
> 	Ported to current head of tree
> 	Memory windows patches not yet picked up
> 	kernel support for the extended user space APIs:
> 	  - ibv_query_device_ex
> 	  - ibv_create_cq_ex
> 	  - ibv_create_qp_ex
> 	Fixes for multicast which is not currently working

I would like to progress the simple independent obviously OK bits,
could you split them out?

Jason
