Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5273AF532
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 20:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFUSnL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 14:43:11 -0400
Received: from mail-mw2nam10on2085.outbound.protection.outlook.com ([40.107.94.85]:34680
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229876AbhFUSnL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 14:43:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IubRsjlK8rf16q/Ga4Y5xRYBS4RXvDrRuY+fiqHhfESRXQDQjFd2h1hv+Xrlzn+SObgF8DWiguF6j4iHDF11FTLHEp7tLsv9fpSzoJo7ux3qvB//w8azEgzr/Nq+PbEPl+v/DovTR6o7c2m+xd/Ntgrp5p0HP7qPkKfK6NIKGGY/pmMNcowVhhTm+guaPcsX/PDOtu/rwqiD5MfEosAElHqHmMKRaV3xZvdaYpIe7FUTHBnyCwYBi+v/X0mc/iWAYWiz87oKCc/hsFugTOyqmEX+mQbKKkei5nA1EKq8XyLzVxJr8HVtrZ81RvmSFPRdjRW/bI1OjkQ/CwMUMAuBfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ui7d5SDYx/HEwJhU2THYL8I2iK8MjmJRHZtf4VXe/7g=;
 b=dMrx8aGrjGehh6HBKvapGb9uu8RkLAZPkBSso7S1JdPekAsxPPs4DcB4NMMfQhGNt8AKGm2GmuYrqd8zAaD5F0JE7fNx9jecvwgTGMxKHolYD2gFErRtU2PG7kuDfQwwqcSjrZ6Wp09WsW/4dKuy/x9RtR5Hup9u9+XAw4aVXHo16hWAiV89Y/1Z2qkNE3c8u6Qi9WefgosIXnnktNEGfO3Y9yEhY6AjodtpTuYG17t6noIGDvjKo9hhBNO1PmsghR3jcok45KVQ5rIUtbQ/GiR08eu0qw1ztvB4M82lzzjYJEU+rwJ+eH+MR1zRiqYNynQe7qrE06G4kl0n2lqXWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ui7d5SDYx/HEwJhU2THYL8I2iK8MjmJRHZtf4VXe/7g=;
 b=JHdsGyQeJ9jmQ1N9PHPmVNCk/wsh+r8QdG9xcAfi8Os4yTz1Yjr1zsTRormfNRvD5tfYnRW37s1KiyElmpQb4srWh/Es3u4X7wCTK0o9YLmn5VPeV6NE4uiU/Y/N4gMhMifEn0wC/t1wVywWv4Wqzkusnmz9ND54C6WI1+JvIJP5aybprSdK7n1AVSmoDvIkH1SrWPlVE59G0y2YeiEPAMQQjZm44FXp8nJsRU+gRpQbEaO2RaWBS2xtJRdVNWgjREMxI3vxm+TgK1Vtrdzkk8nqdB3Yh9JN0xObzTpmmgKmps//LW9HTnh9RXjBrzYdwp7bAyRb0OtDD6fOn7moeQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 18:40:55 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 18:40:55 +0000
Date:   Mon, 21 Jun 2021 15:40:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Wenpeng Liang <liangwenpeng@huawei.com>
Subject: Re: [PATCH for-next] RDMA/core: Fix incorrect print format specifier
Message-ID: <20210621184054.GA2341530@nvidia.com>
References: <1623325232-30900-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623325232-30900-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR22CA0030.namprd22.prod.outlook.com
 (2603:10b6:208:238::35) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR22CA0030.namprd22.prod.outlook.com (2603:10b6:208:238::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 18:40:55 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvOqs-009p9C-IK; Mon, 21 Jun 2021 15:40:54 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eae7759-e58a-483a-213c-08d934e41ad6
X-MS-TrafficTypeDiagnostic: BL0PR12MB5506:
X-Microsoft-Antispam-PRVS: <BL0PR12MB550608517A26B374B9023202C20A9@BL0PR12MB5506.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /VpTqOVj+8jO2hXIXfuie+WA6ddbVCZN6TFtFdwt8dBGXpiKf7pUteBNCI0vcFFpXlfO7rYhHHOpAyZDYTEUMCdD1PpSfm+5rzV9+pR+T51LZedH3qOgpKe4fgl/795Gz8ftyklelWar0JerW48UU8UPQIWhGD1B8jHMFRc05AwTqEOYbFDT8mxTpSVjH4XKpiz3tWX/+u6UAKBw1hhYbMe9vS5UFCbJKXvy0LJndGvJxdXZ7KN6KJfLty494p7V5w9/mL3i3OQnR6/X9NpY6dyWEIjxablDY9iAaxXIG+i/tnxDiKjO8rr6rlXDiDM70049ezTByRoOc+ZbG19ZR6MRf2/+uh2DF2tHqr3YN0e9tP1kSuF0zimwCCefX2bCcs1cVPrs1D9wzdHP+HodjX6xZL3egZi+qysGrvRQg3Wb0EXq94d+TUIbRPFiZcjVuSYGJ+2OdeTrUuPaieF+8eAh1nl3+hvIbjcXwGI72gx27OxDQBd77jMNgLWgbsQLyeh/Hvh+LcwLg5bQBEhtRPDZraiuq5K67cWg/GD/qqFymHo4SqigqOuZDVdJMNmQQ9uA4b6gJbyUQ900ozk6COxD4AWrRP8uIMlOSWi9lJw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(2906002)(5660300002)(4326008)(66946007)(86362001)(426003)(36756003)(66476007)(2616005)(1076003)(478600001)(38100700002)(66556008)(26005)(9786002)(8936002)(8676002)(83380400001)(6916009)(316002)(33656002)(186003)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fd9fhCfyofhWkIV4UUdZI94pGbivAK9glMUflicn095HLHmdwJ6JvhGXg8bH?=
 =?us-ascii?Q?aK5KQn1ef/1yNen6N0Nkib98x2vQ2PZGwCFl57BM1qBq9lCrR+5xlL0h2KWb?=
 =?us-ascii?Q?CapbqZ6Y+B/QmipISp0aP7ev56km04nEiWpm9tdYR6ZAVVRCEMwU479Va+X+?=
 =?us-ascii?Q?fOkxLBthjhJkYIxvIIsHZBcM7dXf5XYqxE56Ye2ZQQQ1lo3MjdSr6jSK8eBp?=
 =?us-ascii?Q?5E6v5Nhp0IT6X7dqmtyOFnNda7mHEdGWcYEdY6V72Dgi4I5yGGmyzZsiO+Tr?=
 =?us-ascii?Q?/agQ1/wwBQk5G0C92fVUgRd0JKiEZsr3qwqK5K9HXq44xAZqR8pkFWb0SL9g?=
 =?us-ascii?Q?CFhofemxFhEVFyouAM+iladfzip/9d+ZRvvcHdRA3m2jnQku73EH/snKOyIX?=
 =?us-ascii?Q?nhRlL0Jow22ACFUlZzcaruSR1knXWID1KOSYS1EVaFKv8lDTZHNCpLRsC61q?=
 =?us-ascii?Q?W4GqDcFgAjScHDpkC2W1bOfUxzJsDeA5DyYUFHkY8bkgX8xO7iFvzpIVGB6+?=
 =?us-ascii?Q?HFG2DYb6DrwxhE/ms7PxXHQQvrD/uGYj5wiMMTamLQfFjLWcL6F5b/1g31R9?=
 =?us-ascii?Q?WpRoRciUZBkA0iE6BUBTfoYIzPIWWPlFaxCBGVuaTG8sT9tTHR4aZmCaBOut?=
 =?us-ascii?Q?ythljQkl8DUonFY9lq8xEfkHWREznVIkgExWeXgVN0FZbAgRKBBmMA13PS5i?=
 =?us-ascii?Q?bWowZ8Kcqnz2aYnHcIbQkbFqfhMHGZZUpet1oPctc8TSTQ941uU9bc810kTE?=
 =?us-ascii?Q?HZ18J+XkMXqdHd1rY21hA7YEZOr7m+8Pfd2w1FGhq1U2tckP6uV9Geal4ZUV?=
 =?us-ascii?Q?AyntUzPFAXWTHWInAwPb+Gi8nGUWo1MgggWElEXfhJbC9AFE5qd9UOCNNRfh?=
 =?us-ascii?Q?1BOaD6EqHy3oH4rtpEqfQM+zhXLzG29Y2HheBJMPrUI8G2Iu+i55EhDOMdJu?=
 =?us-ascii?Q?qcFAcHW7D3h0rQTSMcj1LiVA/zAI7b7AuAAYA6yGWGL4VV+ac4wcho/7Qlz/?=
 =?us-ascii?Q?36jUHbiTvRrqwSqZXvpHMjEo4mOsQwNLyFrLrqPTIRVqlL0c52QbGhX31lCL?=
 =?us-ascii?Q?Aw6acdY2zJnkH9L7SolthutniFMqcC44UI9YWnRYZpuDNBKlMDUmsbTT6ub0?=
 =?us-ascii?Q?+k4CQ76YpFbfHQsUOmzG8dbT84Z6rNk4LHpQ9M0FzYo7FvY6SVPrQLnem8+n?=
 =?us-ascii?Q?xnuOh3uXhNKBIXZL9BL9BcGrvg1LYUf5LwrYzpRGOcvSFhKOmT6eUaUk/Tp9?=
 =?us-ascii?Q?LxfDRXNkupJ8bwE2evH+4oruNR8WA0cr+DzPisxVx3JRfFFaaEbe3BraLRpy?=
 =?us-ascii?Q?J6EN3+CZ090qpGwsY70JjuOk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eae7759-e58a-483a-213c-08d934e41ad6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 18:40:55.8090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZoX3SyJsRePAlcFjCOK0jIORfQwhCfqyJl6tQsJELBV5K/XOqul9sMQbRmSgQ3J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5506
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 10, 2021 at 07:40:32PM +0800, Weihang Li wrote:
> From: Wenpeng Liang <liangwenpeng@huawei.com>
> 
> There are some '%u' for 'int' and '%d' for 'unsigend int', they should be
> fixed.

What tool found these? Mildly surprised normal gcc doesn't complain
 
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/core/cache.c       | 10 +++++-----
>  drivers/infiniband/core/cm.c          |  2 +-
>  drivers/infiniband/core/iwpm_msg.c    | 22 +++++++++++-----------
>  drivers/infiniband/core/iwpm_util.c   |  4 ++--
>  drivers/infiniband/core/mad.c         | 10 +++++-----
>  drivers/infiniband/core/netlink.c     |  2 +-
>  drivers/infiniband/core/rw.c          |  8 ++++----
>  drivers/infiniband/core/security.c    |  2 +-
>  drivers/infiniband/core/sysfs.c       | 10 +++++-----
>  drivers/infiniband/core/ud_header.c   |  8 ++++----
>  drivers/infiniband/core/umem_odp.c    |  2 +-
>  drivers/infiniband/core/user_mad.c    |  4 ++--
>  drivers/infiniband/core/uverbs_cmd.c  |  2 +-
>  drivers/infiniband/core/uverbs_uapi.c |  2 +-
>  drivers/infiniband/core/verbs.c       |  2 +-
>  15 files changed, 45 insertions(+), 45 deletions(-)

Applied to for-next, thanks

Jason
