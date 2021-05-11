Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EA037AF6A
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 21:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhEKTiM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 15:38:12 -0400
Received: from mail-dm6nam11on2089.outbound.protection.outlook.com ([40.107.223.89]:37993
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232058AbhEKTiM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 15:38:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCj4MyjaXqs9E4KLc85ygICkh0KzKFF+eipEeaSOssTtCve05LrmUxkQn8BZ2VKVJ8sfWyJkz0f8o6n7BsidrqW6WbjyZEQhZA/r6YyI62Yz3N68tixDI2owA0aq7o+ZnaHsBWEZx/OG8ZdWxwfM5PcxJDGpC1W5F+fszCkToTgmbc615gHjJ5nO2IbprmImXjphgKOtyzUzAIuPPPPneLlj57aQPTerGnoJb3gTcLqwUu6fSxKvn25I/Bet2Qml8m1S3Zw+LIEWc4Z4sTxyY3Nhm6hcR7TzdmPgqSZnWx2JrRl07WW9UhBPmMw+TtS7G1cDToLOti3h3E9UeEDCcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9cZomJgZR6e0xizmDsndQDHhNstHj9l3cxbvOlFB/A=;
 b=Zzmw9y5EgoHm7WXL+qgiUycMMM3uCwKm/yGZjRw2CCNHQzOVaiSsnX1Ohr/BG+bO+iuRBo0KXTK9FhzpuIcVHreHPWuayXSG9hDR1iZH/tLpKTbVE0hMX7oqbQAn57tLCOc7XDYFLEmN6IKZrJY6JlLB0MsIsAvLKPbj5+SAh+72cBw1HaNvgtFqnB9C+fOQKva/MHxmD5O8mTYNBv6J1xeBu2hHjFiYiagcbgmQ0dygQut5Hk1PhsHJoDiB5Q9dGsRCWjAg+CynhoLl9lcjKNxvCFtXSpaIelJNN60tn8hA9JzdcwGEyi02TojgOFyGzy2GgTsjeTvdTw4iai4xQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9cZomJgZR6e0xizmDsndQDHhNstHj9l3cxbvOlFB/A=;
 b=TaqWRzuLOsXRL/hl0KAz0yZWLRK6CDB8veB+KocqhrQJnMpCbsfXMz178QBSsvycNYzMDek+o7MD87KKjlnU/16A9nT21g9w4q70dYZUrdPL78ijVg7h4mXIdjLWcF7bEPNntz12/PGZ/dAXev4nmQlNKeb7bIpHyV980Pdm3j0nKQS9Bfj6MxGJ1DFBsd65rGcodveFUgWHyfeS3gnZKiP5ZkbaZbEOQCMZw/KjpurhVx9E6TSlsg6Bm4t6p0EVNPjzO4ppH/r5pmDKpvz7zJYsgw7Ww0hJwTZ+/3bfutjylO9V0L6MaTXL0gzp86O/aAd3gStK1yrGZGCwdXkuEA==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 11 May
 2021 19:37:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 19:37:04 +0000
Date:   Tue, 11 May 2021 16:37:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Yixian Liu <liuyixian@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Remove the condition of light load
 for posting DWQE
Message-ID: <20210511193702.GA1316147@nvidia.com>
References: <1619593950-29414-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619593950-29414-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0444.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0444.namprd13.prod.outlook.com (2603:10b6:208:2c3::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.9 via Frontend Transport; Tue, 11 May 2021 19:37:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lgYBi-005WOl-UN; Tue, 11 May 2021 16:37:02 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af140b42-3f22-423f-78bf-08d914b427b7
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2491:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2491FDE7AEFBABCA62F9F7A4C2539@DM5PR1201MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M92F/jUBoiy7pW7QdpK/tFxrpWdJtA5K8NWyATdEj2jjKBnIJBaoAQ1gROuVbJjVXZeKvzL4YQX58IVuHz+k5i29IrXeeTyHVqNKbI/xnRTETGbU7a37wHF36xR9YdG66oqOo0pj/39GBQ7YCZxQI+RX8gsQfXCs8cOqArN4chaI5XNBzJTpiyU/OHzIl/EpD100pln4wxfGT42R7E7ggx1UxlTGvaqqsBl0Sjbi9zCqnpeW/axN+Xpff0pZPBmyfb5yogSQrSAeJj7lw2WUdxm9hoDWF9bHD9z5WOu+Mp11FycSZertjitkdOboH6Tolec5jV6c6Ykzwi8lANAUHEToGxUAxg6mVpPvvx/JjaCdXOzJdxbve/INln6nCxgHebYbd9cc/UY2zwXogwnPQHLkHpK4U4Vy87D3+LnUbzswG0Bv6mlYz35No/vXztTjybqBy7FlmYu0azX3NziiArvvdkv+SfXnWjXp0ULtdAZ5CJZU59gA6LY53/i7mSe7525nVL/7Z2c1n3YR9mY1ynPW3GNnAhTWBSDYbKObJCpmZsWJJRRFpwqx0qstFFGy/giUiOpMDJxEoJV2HW/hoLcqV3cSvRWrN6jaSp9Cufw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(83380400001)(86362001)(1076003)(478600001)(4744005)(2906002)(8676002)(26005)(186003)(5660300002)(426003)(8936002)(66556008)(66476007)(316002)(6916009)(4326008)(38100700002)(2616005)(33656002)(9746002)(9786002)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nVMCReHwW2ov8UAGjfS05JFB+cM78eSChYaA92j7Thdn6GIYOltACsmMA8BE?=
 =?us-ascii?Q?MLhnJRtogSMAJeec/xSMO+L0DxEBi6xN1GLznP7lf0XaRRveLicg0HXmuvKK?=
 =?us-ascii?Q?Vf6Vqryuv2SewKo3OpZNXULNp5BypKT0w7lvi7xWWS33+yhM8HQPOHSnGYTZ?=
 =?us-ascii?Q?iK/nMoLpgw6RrFhWwYQmQL+LdGO2RN6Rklzx3OSCb6Z8vKD69/UhyRSiaf/g?=
 =?us-ascii?Q?v6FNeuFccACMwENUpvDVna84U04uxorejuTZB22FycuqA7rIrAOAVXtRYP1A?=
 =?us-ascii?Q?bRpLsGLbjhe/M1whCuMBonjpuLrINRDf6UgCNCgK5sMf28tgrgpT5SE8QDog?=
 =?us-ascii?Q?6nIiMBDVHuzPuuSws6OwxKaMyKJ3TGCBPUKm4XAEwAHtgOe+9GZHTrovoQ+O?=
 =?us-ascii?Q?RCGJ2zzD/iahkeAa639bJ1z5rY0MO5B7tW7HXUNlcuhqyckLsK+18DItmdWX?=
 =?us-ascii?Q?iUCh5x4XbOBTkZ8dPG3VR3QJxpq6xjNJSYGF4SEywrSffh+/51Ljj4nSIJqO?=
 =?us-ascii?Q?Acs9vdwHTcUBsZVrmhlaMUNF89z77ZvBxoVgif5Z9sOVBCsTTEcobjM/jA8c?=
 =?us-ascii?Q?GgtwF5H/thcwnnkCu1oPdjtFhrLf2G2Z+6UWNNeFd/5bV4Q0aY2L5fDTzvil?=
 =?us-ascii?Q?eYq7h4WPJuEIkQ35sOd1GktGuoUlnc3oqUWH6Hv/pXI00IsEIGdFNr9JR7py?=
 =?us-ascii?Q?tCsGM4N/cJCTZpwmPa5LGf9s24q4uHjY7mDs6WxSw7iFLyJeCl68oBgL+Kr0?=
 =?us-ascii?Q?48GiWLPb22jlid2z9PzNUadlzuxq8E2ghSdA+ELa0/ulJhTuuJyd1Kfl9JOK?=
 =?us-ascii?Q?k6ttI0gScV+ZhDxuXVej1HixHfjgAOAyXZlg3X0BK/mt26MpHcZacweGh2fR?=
 =?us-ascii?Q?Gdp/eoC/mLPtlANDaVvCENPQ91mP5XQYkzJQIq2WyfcsIfiHwA78qS63Qs/8?=
 =?us-ascii?Q?8dT/844aFJfTg0ss36DjDJUiX+uRYttwvAfW3HgmtRL0opZPefwRlzg7eNLg?=
 =?us-ascii?Q?HRdcwoVV6/UIrdRarPLQLifON7d6zNUXxrqO2FEMJxjYOHPYBh0QV1ElnYjD?=
 =?us-ascii?Q?VM+gkeP35jgG48qM2IiXwhc6Ox/GENxaBPEpJ72Y4yd4qMjVm9jGs9QqUxXn?=
 =?us-ascii?Q?luKXAll0ShwQtrFY+rYHMinhzATQYUFnRfPtQzehG9E/0mVyTN2cB+nttgl1?=
 =?us-ascii?Q?jX0r+FnS0lhvRuoAGt8CPz1TkMHoGok3Qg6WzoOYvlz0C8Lgs0EhPuXwKOv1?=
 =?us-ascii?Q?ix3MSoM4WSbLVF8VK93jBwX6HUYlHHD/iEDbFiej5szoTK22FyhfzXF52mbz?=
 =?us-ascii?Q?2ZSfNT7Hmybv6G+EhV5zO0ls?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af140b42-3f22-423f-78bf-08d914b427b7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 19:37:04.4558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0Sp1A/R2ikRGjHZO3t2oIruNLye7HN3yqV2jNiCcSNNZbLrBP7ZGB17BWutq/DL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2491
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 28, 2021 at 03:12:30PM +0800, Weihang Li wrote:
> From: Yixian Liu <liuyixian@huawei.com>
> 
> Even in the case of heavy load, direct WQE can still be posted. The
> hardware will decide whether to drop the DWQE or not. Thus, the limit needs
> to be removed.
> 
> Fixes: 01584a5edcc4 ("RDMA/hns: Add support of direct wqe")
> Signed-off-by: Yixian Liu <liuyixian@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next, thanks

Jason
