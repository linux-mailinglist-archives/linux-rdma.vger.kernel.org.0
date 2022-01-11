Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBAB48A8EB
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jan 2022 08:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbiAKHws (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jan 2022 02:52:48 -0500
Received: from mail-dm3nam07on2059.outbound.protection.outlook.com ([40.107.95.59]:59719
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348727AbiAKHwr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jan 2022 02:52:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MreSaTq0xo9UHv87v5f5L9nVl6kSV+9Ch7OyVEACaHPNm0jdThWwxm5cxM0wDgczGktijOgWDzpfG2NCW7JzMqCW4xSoV/B38hCUoDNSU83zMQWG3Z0bkzGqBSYpp3IRYaLLn9zRRF7NrqYs/VvR+O3vZQal125EyuPcMkBXU4CbhDoGBKnzU70eYZgWTfAqvF5/P8Xb1N4xpu5qxM0nZb1gyEqusnHstvQfwyoMCzaP+tn1yNdykndoCD0jVUJK4Lfp3VLrz27mpgU/AjK8Osq429B6Cw+6SIOSZyi1PsPm34kq9wfCU4xbETOLIwdeozlbsh7sAoGYDdTZK57dhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EK/SoxBY0vikqNdQUzdxBBNkLHH1vFiAC8Em8ZMC4Us=;
 b=iLuk3oz8AYW5ML4Mnt27KL6NjHd8FzU/37XJxEHVveUeY0PsWdItsIQDyzI7mJA11cWupZl+zdSQ0jFGPSEOH4Qpu033BgWmJ+oEYuJzqexr+vYc86TzTsW97FXHTLN9WcDr8qE7bq1JOv/BpCXM+1N4xQfA9xDKx+s+iuSq0sIbyYry4AWFFXNwFBnjtBcjlXx0XqWif22Nl5qsr6oKNLK8+Nzsjra+LXo6CpYRXIaNXzqZsG7P07SobR1hFqrw29e+jb+qa2xmqpgh9+IK3GEdWWxzOlHAgYWmo6zMj0br3ZKt+2g9TIBg3Yz3ggttHDwp7Bq9W+s142Vg6WNekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EK/SoxBY0vikqNdQUzdxBBNkLHH1vFiAC8Em8ZMC4Us=;
 b=XxbKfMraQdvTQB3hQYdj8XHoNBSGklrFDb/V+Cx8bX1XNJKTVlyZ/fsv3xPqxlzgOgLd8j12HugpeWzDmzoLXm983SOxnD/HsrQ0vUfOko2NT+XDQpN564n+VLnkLhEUxFl9BbuohXYWeNlH7htj1kkBaHUh+W2SyGb/LFwHWEAiV07YQRdjRjP1SYpB1713KuP+gOPuWkzLjBQGVHqur/UhWx6CC0GAEh5Ahkcqi7C4qLCUcCrs71I/QH14zfglg/g1nEqI0tTky28o38CUfqDQD4nrf4WvBYH7HPTDsfzGHlK5lES7Tcu3HZdNz0Jz0MT3Tke1tRqYJ54ylBqJOw==
Received: from DM5PR1101CA0013.namprd11.prod.outlook.com (2603:10b6:4:4c::23)
 by BN8PR12MB3394.namprd12.prod.outlook.com (2603:10b6:408:49::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 07:52:46 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::c5) by DM5PR1101CA0013.outlook.office365.com
 (2603:10b6:4:4c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Tue, 11 Jan 2022 07:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.9 via Frontend Transport; Tue, 11 Jan 2022 07:52:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 11 Jan
 2022 07:52:45 +0000
Received: from [172.27.14.142] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Mon, 10 Jan 2022
 23:52:42 -0800
Message-ID: <5f273a18-ab25-08d8-fc40-3934b5b3da16@nvidia.com>
Date:   Tue, 11 Jan 2022 09:52:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH rdma-core 0/3] Add NDR support
Content-Language: en-US
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <maorg@nvidia.com>, <msanalla@nvidia.com>,
        <edwards@nvidia.com>
References: <20211229085502.167651-1-yishaih@nvidia.com>
From:   Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <20211229085502.167651-1-yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12f8383a-f962-4548-422b-08d9d4d75b0d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3394:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB33944F908E7C3656E77E6470C3519@BN8PR12MB3394.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cZnGEp/ULUtcheZG/cHCH+Nbdjec2Qb94Ugfr0oJRZ3MP8sFX5B/uGx2xkRaz45VQ+IM/uq6GEPaYfFdEzqqvVdUHPjwss0uomGz0MDAd/1KpBdqvxsvP0nh6YdG5i62ZrX6uBrO8Lf1UGkecLjemqlFKvw4UhdeQhm59932k8tcao2YuJhVM5dYpAkNJKwfV1KUdkcyAQZcdRWtMRrCCNnSoKXG/JYjfruEudBK2WE3mnu1EnfFg1wWwLvWPfzy5I1b23bXEVmkde84cQoqY9w5lhyCwu2Ihf587xpGHhFXHj55wU2FWZv+M0xVib0bpo8j7sohYDYNX1nhLp77dPOtRg2fcuhT1KKnFpuI+VTv8Q6lxwaTa3kSU9CjpF2Cy/MT3tN7vG4JavdKaHg/JCNKlZc+YDRv6JdBYGZ9YuwPYquFaxz4AA+ZRzqa9/9tq461Ft9+jhmV0s61nejHkc9XtfWF8OBErI/RSQgs8o++Udco4fjd2YTFU2qV51drDM6YA18lceQ4iytGi1Crk3jibipc8B7lIhY4vNCUHIzMhatgRm/2l6PXlw8uen6RtScJck4z+Wem1QeiQdS5fsYYwA2La71yNFkMY8s8y+/7Yc5Br4VvGsCSPsNkq7P5ItOA3MyAwttzUk+SieEJpbvz8ldWFqShII/oiUfseI4oc2HTintKN716Z3M+qHxnxGl02Tv/0osWTTUIDstFnhMC/TfIyRbeQtIMKe2IWsN+rgXRLlPy4+OQs4RCTkUk3xNrafWRPuvrAhQDEwtRd5FAT+sQCeqaY0JVPTEYwJgmQ7dr5tRErLL8LKsC1kskt2WvC0Q4X3d1vNvDuM8jGrD10vC6u8viyUg8G1eApsp8Rq+i8aqZ7yHIpng44YwPxYk49XBrlmgD+3RIClLkMi/Qb5qUOJT7FNc9rd32kko=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(53546011)(36756003)(8676002)(83380400001)(26005)(47076005)(8936002)(54906003)(107886003)(4326008)(31696002)(508600001)(2906002)(82310400004)(6666004)(5660300002)(31686004)(966005)(16526019)(2616005)(336012)(86362001)(70586007)(16576012)(70206006)(6916009)(426003)(36860700001)(316002)(356005)(19627235002)(40460700001)(186003)(81166007)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:52:45.9038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f8383a-f962-4548-422b-08d9d4d75b0d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3394
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/29/2021 10:54 AM, Yishai Hadas wrote:
> This series extends verbs and diags to include the NDR support.
>
> It includes the NDR support bit from PortInfo.CapabilityMask2 and the new rates
> as were defined in IB Spec Release 1.5.
>
> The matching utilities inside verbs to print and convert to/from the new rates
> were updated as well.
>
> In addition, the series includes some pyverbs extension to support the new NDR
> definitions.
>
> PR was sent:
> https://github.com/linux-rdma/rdma-core/pull/1114
>
> Yishai
>
> Edward Srouji (1):
>    pyverbs: Extend support of NDR rates
>
> Maher Sanalla (2):
>    verbs: Extend support of NDR rates
>    ibdiags: Extend support of NDR rates
>
>   infiniband-diags/ibportstate.c | 8 +++++++-
>   libibmad/iba_types.h           | 3 +++
>   libibverbs/examples/devinfo.c  | 1 +
>   libibverbs/verbs.c             | 8 ++++++++
>   libibverbs/verbs.h             | 3 +++
>   pyverbs/device.pyx             | 3 ++-
>   pyverbs/libibverbs_enums.pxd   | 1 +
>   7 files changed, 25 insertions(+), 2 deletions(-)
>
The series was merged.

Yishai

