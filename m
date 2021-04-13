Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8147835E40A
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 18:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345952AbhDMQeh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 12:34:37 -0400
Received: from mail-bn8nam11on2044.outbound.protection.outlook.com ([40.107.236.44]:51680
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346007AbhDMQeg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 12:34:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcGf85yVsKrgTuzVtZZJToNWnfdPjEP9NqDY1uEw6+ItdIvfHK3tsasTJCdRmc6XuEB1n6m4Nk0rwNk+K0Gcz046VkMAFZHVY8v2AuI+DwRYjjwOPNNTxQz1Fu+JIZ2i8t9uVIx/scWHLIju1RNqnlN4hNYqMENBTLVzZkTfFrjG3OQkcJOaKS7yAcAVYWxZoALNtnSltHgbZxWOTBqBuNd4I67FkMbF0RMy/n3rzldJLnBnRnmfHfmArO2m1hLlsJxFa8vBr+NsGg80+5OaM1YlkrMA4HLhL9OWzPMFtGpXxKw2iw9kgD+i2ketUAceNJU5s/uHYrCpWDThmsONGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jt7SGaKuTQg/lEhlBBgjpklFH0XCnmrUUw0eUkUGZs=;
 b=mhpyUnDmQppLni50owXUU8BRUDDbHAStxlEYkKM01fiBPDTIJFbmfNWq+9tqVrldLjKqJ66juNSGIXQRTTSDE7uKZBHSe7JWwlAT3pICdXhhR/TdXetm4hRiZ90rKFiH7UTQn5IeOw84W3juXtJN4VSov7ku2I4LpkiRMZPOyedOdw7d9yttYGxLaX2YkN/n9i7CSRlY+pGZkIJV9zCjt/5qrHOZeEczMDGs709BmrCFOTolWA4CslMPBWsbLKvgYBFyoOkFozPT2O4N1mKdVpftYVQmZLaT6HxKFKGRpQzSevcF2QFPcOGy2yumoeEGSRV3hHXg6QQaHPtrbIpyFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jt7SGaKuTQg/lEhlBBgjpklFH0XCnmrUUw0eUkUGZs=;
 b=InStdmH9Pg83mhRrFUaWyOIs7eGqLcZe+18LhkLhCt5efAGqR6IGI8tql0xQ++GgPGyLNRUwpDr7WIbJzJ698P9SlbZ6q977v0lgGJpd2VX3xz9gMqBIvgSN8qC8OguGu58kayVSvgMKGMf6tyi2EFBzMdbPHRHhXAL7gKszIR92htj5jrgi0vwUnyyKX+egXsqUvChXdgAvZbmWYcPY140dW2tdqNB0DLattyO/Yw9tVYLZG1snVJqHv4kVL+p5oXx3NBSWJKPF43bFPx8GZPd30X4qMiXAeH4fiJKfy/H69W1qmKP8BGb6K6P8+l17TKRMdk9S0Yrxtvq86JI9nA==
Authentication-Results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1515.namprd12.prod.outlook.com (2603:10b6:4:6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.18; Tue, 13 Apr 2021 16:34:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 16:34:15 +0000
Date:   Tue, 13 Apr 2021 13:34:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/hw/qib/qib_iba7322: remove useless function
Message-ID: <20210413163413.GB1318921@nvidia.com>
References: <1618305063-29007-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618305063-29007-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR14CA0012.namprd14.prod.outlook.com
 (2603:10b6:208:23e::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR14CA0012.namprd14.prod.outlook.com (2603:10b6:208:23e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 16:34:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lWLzR-005X8S-MI; Tue, 13 Apr 2021 13:34:13 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad585f3a-cf0f-4f90-a76c-08d8fe99f9e3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1515:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1515AD23EFF24CCECCF5933BC24F9@DM5PR12MB1515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qm9hVRAh0FfYAPRhaEW3lgNYBF4iw3ecoC3h3qJW/IAPZHZWk0FGa+9+Qun40/5AIlf61fFBrDX4cb1L2jRY8MXYhie8QIA6m14/hh/EeJd2a6h8fW8B3tocdc2tH5YOH4U3l5iDqCPKQghKg7WZzWOvS0jUwd49DCRdBKNkEwd/kc+Rorx/EKHQRorOW5J5Vwe4X5IITu+gdxXny8OjLY6U4yS3y+9GSEs0k127L2YOfiolgCO2ZlWvI7+4J7FZB5E6rc8poaXpY7//dhv16aJo8zS/cEYwrmULsv8kFhZCZ9UiEeppyJUSAAiOXiFujUxPBnBbfazUN+tPwmtBqXGGp7Ve3gnVtfA1wyQdUVr3bYkKV5qS2FwmY0/fy0JI/QqZBWnY3TtlWeSE3sZtXkEmFBxKysBvxASlW/nDfWVvSxa1EEdAVgLI0qr1W9g5qfBrQOWBc1cq7muSQc9P/nmc6weXtSV5oZulZ254qCcnQK4Zvr2Sv0ZCQ0V3nRc/QSOyqk1xdNDH9JmAQ8RcOmFNihUuO/7R2rsK5zEWiS4zan8xEEBz8GtULcFCS72YJRLOWr4t4QDZbIQbigZyPsO9RRk7Lvpy7p2qTqZ+Z/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(9786002)(6916009)(8936002)(316002)(2906002)(9746002)(83380400001)(86362001)(8676002)(26005)(5660300002)(66556008)(66476007)(36756003)(2616005)(4744005)(1076003)(33656002)(478600001)(66946007)(4326008)(426003)(38100700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Yd4rdnVDMCszy3uG2c2sL1IzMjuOnFvcBJ2JvzdEpTwJLlts0DH7Sqr8KPGx?=
 =?us-ascii?Q?mHuSdfQIP+P5MGU4cB58hlgcRipadwfcqgGYZzCzMKgQNTYnVv0wZTI00gA+?=
 =?us-ascii?Q?i7xNERfHI72lZIxJccycAmsZNZ4QaaUsXJbsaaWkqVskLjFJVdUGKooTnMT7?=
 =?us-ascii?Q?MYq8SUHIMnWtDnj1rKQs2CIfm8Ur44bz2yK05r4yTvY0cMDcfKfdoQfQ6ONR?=
 =?us-ascii?Q?XvYAdQnzZjTeQ5XngzZMlsriwIrP58Md/cIlzHHwawbawLAMCWV9zwBEIP01?=
 =?us-ascii?Q?2Q6nXunft/Gv6u3Q1QXIj4K8e8pnE9BzEFWue5g4P3OwxCuWxLjLc5JRrQkk?=
 =?us-ascii?Q?Aq/BdBBmsQe2vN7OqfDq6JzFHaTEKGqpNi3ytRCjm0kizUXKTWcP0BT60bSX?=
 =?us-ascii?Q?lsdnP2ysd0xxcWDcIFkKr6RRqYVUYzpLulRiUudY4NOAIGM1e/Tmimv8sUoQ?=
 =?us-ascii?Q?gSt5kYpCwLlcMGdJJkBjgxBHwjnV9VvvsQPHssdFVvgkZqXnHN28ntHx+3H8?=
 =?us-ascii?Q?/okEDoHHaIwzrzh4H9e6XfuzPkMeJSsrQn3PH4ihJJgz1YiRrxEqEUx/412a?=
 =?us-ascii?Q?Kl2FGY4jDSGgrnuMQUDHV9cUrq4UY5XHF4IeddfYczJVA8YgTdKRt9PXaOCw?=
 =?us-ascii?Q?kZhqiyHYjw7HpPDntVJTTf3ugS/g+R7ojF+SP9i0W0kMe3B0SFsB2EZ0cGGr?=
 =?us-ascii?Q?R/zMrp7hywyrM84dWiFGTsMKWSiOLg/clKXJu4yfmYVXggPDn6jHcTdODzb+?=
 =?us-ascii?Q?NYbzMGP3ZTxVtabcnrcHptitco7HsXygvGji3Elxs2g3BcZ+eb/kHWyGFj/Q?=
 =?us-ascii?Q?TYwVFXhqRfdctjiAb/dnE8OKDCgI6Xr9v5ij0cEMnEdKCWLnP/9fk5pSuAMA?=
 =?us-ascii?Q?OrCm+VI3a3E0NPwbBan7ZGHKBLDaWxsPa+xUmrvZYEUhj5RktvV06FJfc8aI?=
 =?us-ascii?Q?YMFrlxz0B989ukXT3WAJlLwjJFdOAeZAe0ni99gmhIztfX2e/ZhEzcKXDJ7H?=
 =?us-ascii?Q?nDRTsearYQ/vlx3U5YCmFgdwR4XZSoMZZJADjJwfHV2nyELpERftswj8RCct?=
 =?us-ascii?Q?On8G+isltKYr/dPJfDNDhs3GH6J6bbnurGUlXPEj1Fl45Nys9ChRXz5XrPbB?=
 =?us-ascii?Q?KNz+F2CFDQvauuAFoiRJJM/jeclZCggML//UijaQFuRrBpFF9h7z/kuVEPFq?=
 =?us-ascii?Q?oZq4QzEkiZqoP1F1bNyWNwotNV7FiBex4mwaYLhJy3bUaq+vsl0sKZ90JZQB?=
 =?us-ascii?Q?F7+PZ9FjiN2PM0oRkrJX2T5CFmFYj2g6nnTcCJDzXJejdVfST02NqMenFzQf?=
 =?us-ascii?Q?taHQMGHn684d03IhpJyQhLiwAoiwnYZras4W/Ei+S+5xhA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad585f3a-cf0f-4f90-a76c-08d8fe99f9e3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 16:34:15.2021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/4mm/x/158QwOqtE5bbarprGn6J1kLZ5YEmtJ453jvd4fnqxrVmrzTAm6zLKut3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1515
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 13, 2021 at 05:11:03PM +0800, Jiapeng Chong wrote:
> Fix the following clang warning:
> 
> drivers/infiniband/hw/qib/qib_iba7322.c:803:19: warning: unused function
> 'qib_read_ureg' [-Wunused-function].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/qib/qib_iba7322.c | 22 ----------------------
>  1 file changed, 22 deletions(-)

Applied to for-next, thanks

Jason
