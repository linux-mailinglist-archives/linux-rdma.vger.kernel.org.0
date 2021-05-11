Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C38437AF6B
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 21:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhEKTi1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 15:38:27 -0400
Received: from mail-bn8nam11on2048.outbound.protection.outlook.com ([40.107.236.48]:59114
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232058AbhEKTi1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 15:38:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNyzCMS/gjtwrGSY4tnAfUDvvZsOLZQuQcZACFaQH4SyqZhxi945JniIVH31SpXAoDPJocnL4Qs7U/T67sp87vd5a5ds5zIR0/UvUxBvagt4hucGKct4ax+zcXmOwDw8pe+K6v63nQj6XcTuT1MaREOVLWdZkR7SQQYZUMmKUFHwPwW/O4I5bkig10L0CoZJSpEsCW7INP51mQqRONe7vrm43Izs1SR1G1sCVj+gM4gG+8JajZATxKvsoahr2ut/2nOefcxJLYEGoNso05DW4CNmTamyBpE62waWk5FVpyVrTwCziA25SDlWT2wg7ruqVrA8tzpOXmYPpbEAaFZVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KmTvATioAwskqM+DXBwXUPKA3TcSomeZYoKplvN43A=;
 b=CiGxhPsFqAAUHk2nHcEfZpXqrr604KdfmuULc3ZuEiuLOyryHslnNPTBtl8GJXmMx05oz/j2g4HqWZSv7E9a5VUduSsIS7JelRGPeI4r27HPBmWv66FLE4qt0yIlZCVok/QPuu+m1VH8vLO+ucQjk0h7yLc6FNqmuqNCyUDgxM8YTGJkAR4UpJaxKj7qR1/NpqmAQIFyhjfWmUMwThfzmXyNRPm71vbv3syYurSK8/7IFwRjgRoW0UBtR085L009+LTvB48eB9a7UtgW312F1HPnuwTEMiT3qeKZDJst1iM9jM5SQ8yt+jy8s5sH6KBAsfyhiym0kci6csbM/zpDBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KmTvATioAwskqM+DXBwXUPKA3TcSomeZYoKplvN43A=;
 b=g51QMOGHgn1lFAiS7Lw5v8DE2gx6VMIfAaUg9Rco/86M4202GVnWe/oabbpUs6un8zRBGCcqWbn+ag/Bdb7bPz2wh34lYmdMjHcuQRQ9/6MBJQ2m/9Vhm/OsH3kHLF9kz2AE65qwaZLkRmwk+G5ngLXtOTuQyI+Xb5ikzgr+7U4bzoh6zO14LHMBIlNW4I2h1lDVLsl49KM9aLTPoZjPV3eYj8j6FuHMfL2PAiCL4n28aTQOm2/BRYJvRyJx65UW2iBthWtoRrTq93yXJm5tfhW71Dpc0GR4fP4ulK8io61mH+CHrCCo9gmlqqjUWMfCAdQf78yOqQJyrQD+12VFuQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Tue, 11 May
 2021 19:37:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 19:37:19 +0000
Date:   Tue, 11 May 2021 16:37:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     leon@kernel.org, liweihang@huawei.com, liangwenpeng@huawei.com,
        shiju.jose@huawei.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH] RDMA/ucma: Cleanup to reduce duplicate code
Message-ID: <20210511193717.GB1316147@nvidia.com>
References: <1620291106-3675-1-git-send-email-tanxiaofei@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620291106-3675-1-git-send-email-tanxiaofei@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::7) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0212.namprd13.prod.outlook.com (2603:10b6:208:2bf::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.9 via Frontend Transport; Tue, 11 May 2021 19:37:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lgYBx-005WP8-UG; Tue, 11 May 2021 16:37:17 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 155308fd-7c90-4a51-6488-08d914b4308b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3835:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3835FA813901DD6DD5D32C99C2539@DM6PR12MB3835.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xTLgULiBWKLCqPCusqKDmf45FtJQRskhyR/cby2Juifu/L7cgb7lH8kZMfJyuJblmp95gIfVsg3G8zuSv2i4gWjTNneMaeYQj1ertJSdxBOw++bOD09X/gYIoJhaIK4HQ4Wu9RVD1SJtAIOKM4Fknk3cHwovfMWa6b/GvHLPuQQ72DJ1FkTOFJEL8l9rPW1wUu8MjRI4/MoHFPeh8GuWd/kwMuRCGx9dMGQAEn7n8qsaDKQ/tgcaDHWfiOGEanKHt67UsPDDYpB2vxH3DnQ0XiJDF8Q9qARUz0v4vAtcm4rrkeWwSJ8M7IerXv/P+rmqVi8sMCfQ0j8ZdUE1wpiy2+KgH+M+/gUWeXsAttcFzr1CYMnC/Sk3XPlHXbrT7HPiBPRwxqPbjK61Lw/FxiJchCyFwL8EkI05rZOQno7DLC08kVPw6Eedaqp35J9tSfHgatceSMTZ359KIT6RS0WCZQrrqS0J9Hr8AeURVq/0bnBpBccJMBWe/I5O8LXkmOMhZdjEam41FiGtKmG6d9CVp7kz/Wccu0T0bX9F4D01lpGIxCOErl0vtC9ShOWikjPw5J1TzzhJO8+qoVWywpG2iSMwGw+fF23LcaYq5ezwTSo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(9746002)(9786002)(4326008)(66476007)(5660300002)(4744005)(86362001)(66556008)(66946007)(33656002)(8936002)(83380400001)(316002)(426003)(1076003)(6916009)(2906002)(8676002)(38100700002)(36756003)(186003)(26005)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+qwWH4D1kHxeqbl80qVH2cyd4iDEmrEoNp5nEI/lMQbh4LmUSuby4CH2JBJw?=
 =?us-ascii?Q?NmbXdHSgdVEuidyWBFS5BW9OVoTCdbB/TjXaNexv3gMrsxJrv/1ZQYE1ig9T?=
 =?us-ascii?Q?ufTd1dpWNKo3h7k0CN/fEmgjF/qQNtats1OVf246GZSzAaGCcCtOtkOH63ec?=
 =?us-ascii?Q?QV+lWumDM47a+vAZ7frEsPelYxCJq3OfcpNJM02qgKhGmYKuKElzjBTK8sft?=
 =?us-ascii?Q?JFPChfRb/YNcFpLvUdUdbb6mDCD6/ZGRIL7ZZiOL//BISbUO1BBkF8d6V8BF?=
 =?us-ascii?Q?0pSKE3UFmdLMBa30fAm6pLxYnmtbgPujZeOAQ4uirXd7xF9FVc55qQ+kZk2t?=
 =?us-ascii?Q?mllk9WpEOI/NSXQPN0kXBHcFkkusVcQoWZM6W4Rivr8WBi8gPgsNDCpqKE27?=
 =?us-ascii?Q?6ZOkBPSaBwOUg0tpTUpwU+n0hSd2Xi6l3E78BZ7i7eECslvHcRnn3n86OC2i?=
 =?us-ascii?Q?IvtriLDDX2RfF6i9SZ3A58Eysv2AOmADzdTR2XDzBLcArmbcXLCFmGnUbGfx?=
 =?us-ascii?Q?zbM0VP/UB2wDG9POz085OYA2bdPXNWKOqrIX5kiYUMh7ggqJjWpkq1uMxLa4?=
 =?us-ascii?Q?7NXbUKBnNvElcAcW5aNuAQevcj6CAt3tUV3f+KEN/dG7LlJdYcqdx3ke7EiF?=
 =?us-ascii?Q?48iLzHwvMOO45LfjO/KvhmmDP7YYewIjinDYdaFhIB9GUu/hAS0X/oJSu6nf?=
 =?us-ascii?Q?osqEK+6CUOjf1zRm0Onoyzh/2aKLY4s7jPOnHVXHk2Sss/cTEnlFqLVaHv4F?=
 =?us-ascii?Q?VyBfTQxAheZ7RsFcZBjGZj2nQ2JR1Fk7IYydVQ9XLTLu5M0yhD5nuYAiPwVZ?=
 =?us-ascii?Q?RUhpz1QRDvdbsB4ApFBHBwHlz7fHTDtFQikBY0wujzRN6eZ2V7swjfQvFcB2?=
 =?us-ascii?Q?r0p6f32s67Ap7BWYRRSoJ9MprMYwsHGlzrIGhty63m4A5Yjxrf0UwmvIXaf8?=
 =?us-ascii?Q?Qu/sCNRzDxxK0rMwip4K5l/OF+uAxGVD4GFrr6/X3ZV/NN40T+8L5LQ9FGSC?=
 =?us-ascii?Q?UVI+i3cpUhz0gG32Qpjsy0E/W75D0q78Bg9Db7BRQweRv6DJrN0CzvDh4s4a?=
 =?us-ascii?Q?Aaiwo2JsBus1bzlGeTlA+quTwx1+KyjrGZpbxvwg0xZdy90fbsstNYTGymj9?=
 =?us-ascii?Q?uz6JFC19Reibgs8vwtv/PkwUzbYg+N8CJMWy0toqflWJ6Zzj0AQpTBFILDTk?=
 =?us-ascii?Q?PevC3+oxfmcIY7V+9xsQVpAdLjq/9PsS0LQUk6YORNKCcPbG6vDvzorYpyvD?=
 =?us-ascii?Q?r7RhR0EMmq38K9woc9ainITap0EyTKrYqr1bT+46oc/vp6HfwPVhD87mzEwz?=
 =?us-ascii?Q?7eeNtJ3Atv1pZUkdIStI/0fN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 155308fd-7c90-4a51-6488-08d914b4308b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 19:37:19.3194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52uMGZIrXNDVXkIX0Kg8lqIN91iyytPwPjrtO86VW7QlwVkEiRVwxNJEFHOf3LP7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3835
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 06, 2021 at 04:51:46PM +0800, Xiaofei Tan wrote:
> The lable "err1" does the same thing as the branch of copy_to_user()
> failed in the function ucma_create_id(). Just jump to the label directly
> to reduce duplicate code.
> 
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/ucma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
