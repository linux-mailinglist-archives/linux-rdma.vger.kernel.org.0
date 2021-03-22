Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1FB3440EE
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 13:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhCVM1p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 08:27:45 -0400
Received: from mail-dm6nam11on2062.outbound.protection.outlook.com ([40.107.223.62]:44897
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229547AbhCVM11 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 08:27:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNYrsFhz9QkOCYpUGn3JwOTMIyz3stErGBMIgeOb8tenHGG/6Z8z9GQ6VdbbiJL3XzFPPxQxnYCIq3z4Nddj+2+YoPXxOMcB+yXGtrw99+Jm+HomtsWdLcZRP6hIkwSG7b5tDrx2V2CRCtLd66gaDQ59Eb0ZIcGzpZW/qGgehrbKZ/XrYBpPAj6yhCvpLAQ0weOSUsRmuci0PeSnlvIbeV6uoYgTxiBwCQI90oQ+odHoUzZABL4tvGwx4b+HSJcbd6vvND5rDtCbjBFYlBahYV1U9py6EgXL8rleU2ifBF0QIYslXCfFMMBcxtN5PuaY27z7FTqTkT0Rp0XVmtpLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74XuqODGP3NuImsvvg0eIoEi39NIGJs4/MGtADtkfo0=;
 b=ZUT59Q7aevC6Ufzd345GmBJmwdjkzXWhnR9YgUpYZWmSFEwyNHU/E6uItSoLwpgu0uxprT6GX6hExupRwpYsd9QAfm+f+5BEUiG6Z2tQnPDILv0NTRjJRaOzs6BkXNgliHzH5pfsjy9FUmoNoN1tbrPgPTQGvPsOPfUUQt84lUHAr/6nQucpApPeEPqJThhIuIUjEV3r2j0M+dp/Bu9XjVfv7uQnJdFHIQC90TVGG46EL5xi6K66uJ3g+MGY9/N5KrWCsb/cEwMBUAPelzo8cyEVnnxq/hXWMm3BIufG2+6RfdW69RjsASWyFcYZljjFFHdTsrBesJlP7tj395H3uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74XuqODGP3NuImsvvg0eIoEi39NIGJs4/MGtADtkfo0=;
 b=hHZEmVYO/aROjigzRCzvtCQYtF7ECfc7So2wGqNSQLqVZwmIIEBDM0pbimCwF5TMAu4O8mU6q42qWoE886dmAkwBMUMC+N8f/JoH10yiICTLsErahxI1tbYVzRFBpI1Nr6GUaT+nq7+6k7uw5dFIAwLNQMv7oROJam9W0x0h+cZwXLWfmbf2C7ZHhuvvwHKrVq9fl5TpcqN+0vCguKtOqYGkNoH0G0jUGNy6hSF8579ssDpQ24zfAcuLK/1FUzoH1anA+T1cTVuKpF/cLsYvirFr4H1l0spifuQyURUuFEIhsNQlCJzrPoVYO8gSuClRVIglFOif4rnaaIjchqUpRw==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2489.namprd12.prod.outlook.com (2603:10b6:3:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 12:27:26 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 12:27:26 +0000
Date:   Mon, 22 Mar 2021 09:27:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH v2 for-rc] RDMA/hns: Fix bug during CMDQ initialization
Message-ID: <20210322122724.GA227944@nvidia.com>
References: <1615602611-7963-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615602611-7963-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:208:160::49) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR13CA0036.namprd13.prod.outlook.com (2603:10b6:208:160::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Mon, 22 Mar 2021 12:27:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lOJeW-000xJM-OM; Mon, 22 Mar 2021 09:27:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e46a220b-987b-4612-8d35-08d8ed2dd9f6
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2489:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB24892F57540D2A49F02D97AFC2659@DM5PR1201MB2489.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vbvJ9OJOrQvBekk9CkPKHi8ilDJfkYwlVZAbX0NqVL/avq32MjSzvCxdF6cXOsrYvgpWailo24Kze5If1UBukSZoiJSSTRnAse6w4ExK1J1Gj8eafiLMTTzmcrxpaDm81Lq+izmn76BCO8SiTTGLX8vjq7sHK0vUZiHo4Q8VQuDfmTbSzKHSCmiSirOSs9YovuiSyClUDbGNf1epUkdvsMHTauwUMLptj2oPgmQuAamN1SSkqHE0qvSJ99heYQC2IMlxzaJ9iSNu8KyCGPaESBCYcS+oSnjvxxz5OD58qJAITWQv35tAhINtX4V/rGICU/QMm3Vr9j0Sh9XOPb2HYoiYucGu450rtAO/Z3/7DptRIkHoLfQJ5mREtP6HIZSxx5fGlbonRuXA9LLFVfV+5ltExSxTo0k77IDF3v+IQuzhQGBnQEyiagNu5/LoGq0ka1BjDlltqVBUiz47paQzQMvaLQcqIxZxO+2/4U+8T24CBqyjJTfAWTqdgRcve1QRZrxnz6Fisq/iU+5aAcosaDsLWcdWKHBlnCk6JWHx9urDYAEvtFLODkmQ9sSwoQkOaf7W2jImLjKPjAOm4O49NBk1LeezFO7TY9wfy5WEON08wUanDjD436ck1q3AQ2dtd2Ekvt3uciyWxm6H1Qu/sN3Pl9Kc701eS2w+N3lBVKwjFEpu4snuex+WJyTky56wiUSs/nI/JkhRuvUBXF7JzwethsI8B9DOfKzfUO+Y8NEEiYeq2Kl0oWDGdPHlMK7d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(6916009)(426003)(8936002)(36756003)(83380400001)(966005)(38100700001)(478600001)(4326008)(5660300002)(1076003)(9786002)(9746002)(66556008)(66476007)(316002)(66946007)(186003)(26005)(33656002)(2906002)(86362001)(8676002)(2616005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jNwi17JVCC9gVQWwKXbE4S19U99tYB7RYxTXCCMV1grr+VcF91/0xt8IBmK3?=
 =?us-ascii?Q?9ekVr97DKxXZ7IHumazDjRqMzJppBJiLzUMcTwYbCDQUQVq0n+UTWH43wUt6?=
 =?us-ascii?Q?M03wQZXW8F/ZdJ+EYY1vbGUNS66Jk1oavmLH9ywMx2zWqA6NWkP6zhoojkZY?=
 =?us-ascii?Q?tNCp5E1R1ypHud4cJb2V2Xz4xqp0L1Jpc8rY+y/mTcQFpHlK8w9XVaKE1ZH7?=
 =?us-ascii?Q?aYDJGF7ayq8mNHcwFX/Xz1D3PdtOAg9R4XXxlSyA/Xod2LhIoyNydqfAfjj9?=
 =?us-ascii?Q?7x1ZJFp1y212C1LWYBeCWat+0VznGQ15BYUUbmSYq7HZvoVbda3oHJxh4pUy?=
 =?us-ascii?Q?5nvAIQOjC3B6U09eOrd9lmPm03Ju2hufvp99ydEJ6PyBm6iq0PuxZ2SAJ+1X?=
 =?us-ascii?Q?uckZ1kmD/Kr/IsPq9fkTBWxAfrZJrlR0REmCgkdqGGJDUzukEbH2K3k9jPqY?=
 =?us-ascii?Q?/0By4Qu8mEK+tdRXEA62iHn0VKhsCjbwnKfcqTUMQ9GhrcKgVYN6THn8/Ljm?=
 =?us-ascii?Q?wkARE10U+tmvOnsuFtcWnKZlZQmKbSLSTWWsb4UW6f48bEwpDmohe6cr9ES8?=
 =?us-ascii?Q?8Jw+E7fdr+Qu0p3ISLxbR2fM9Bt9vGRSUx4D+6/OYW3TcTsTzUN+xxF0/xiX?=
 =?us-ascii?Q?1UY6xHIfvCa9q/yiWPHSgV92DoLQQaMd76bBK45wCHTr1VoYI5fKrmJLVBfK?=
 =?us-ascii?Q?YhuaftpH0uTA6qVUm+XnCdTgMN3nGSWAsqZeobfpgtZ9i7hQZNls5IUobcRt?=
 =?us-ascii?Q?pE4Y6w+vUx+fnFLajP3XCJN55EoFaAL0aph/hfEiDcRAcH/wxuHU14J+slTD?=
 =?us-ascii?Q?f8yW05acLNYIV0qFRvGKm6beRoegDtLgd8QIiNsPtQWurw5B3KIJ8VanJ73b?=
 =?us-ascii?Q?m2T7RtD1qUv6quImA6ZLHoTuKD8cCefXiUD4YQc6LXM63FKtQOk1Of7PhlbC?=
 =?us-ascii?Q?Ic3E/8i1c4jxKFt3n5IcMs0pr/ikh0nn3vh8/i74aygNdybEzB60LuBHQIgu?=
 =?us-ascii?Q?p+Thp+BC7NanXc8EYs+cWY/+ehFQyrxKEUsJBhAZp+bI9qQSY93dOou4G+Em?=
 =?us-ascii?Q?mTjewV2yEWonZHNxmfeKPUU6Q1yHi2K+5daDWJuYEziGk4/OeDdgaTkv5FI+?=
 =?us-ascii?Q?wiUxPgyJsBrUpGCe9i4YJED+6Y+Y83b29fmxs+L/pZWAPUQVrKrA6iGyn3CR?=
 =?us-ascii?Q?veR8gVhe5dh9BNwzbD0Ncc39v0kUkQ4KYYWgjuempQutqTe7jCr1G3vr6H3K?=
 =?us-ascii?Q?S59Y2g8cvN10h5agflEH7ibNuZ6YW4T9wBAkv8cghEFIar19M2CR4WT1hia8?=
 =?us-ascii?Q?ohk+Rx2D95bjmFeZ3abxgZMkm4n6Bdp27pWYKW5pK2euUQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46a220b-987b-4612-8d35-08d8ed2dd9f6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 12:27:26.0449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WI79EDDrYjQqtZtSSryplHXgaGKpMa52iUgs/oIAOQIfOXOuVXvCQ4adQo5xdqHE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2489
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 13, 2021 at 10:30:11AM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> When reloading driver, the head/tail pointer of CMDQ may be not at position
> 0. Then during initialization of CMDQ, if head is reset first, the firmware
> will start to handle CMDQ because the head is not equal to the tail. The
> driver can reset tail first since the firmware will be triggerred only by
> head. This bug is introduced by changing macros of head/tail register
> without changing the order of initialization.
> 
> Fixes: 292b3352bd5b ("RDMA/hns: Adjust fields and variables about CMDQ tail/head")
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
> Changes since v1:
> - Only retain the bugfix part for -rc branch.
> - Link: https://patchwork.kernel.org/project/linux-rdma/patch/1615541933-35798-1-git-send-email-liweihang@huawei.com/
> 
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
