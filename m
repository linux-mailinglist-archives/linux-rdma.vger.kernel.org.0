Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8538A3557C7
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 17:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhDFP3B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 11:29:01 -0400
Received: from mail-eopbgr770058.outbound.protection.outlook.com ([40.107.77.58]:3086
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229648AbhDFP3A (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Apr 2021 11:29:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhhXz6GFcZ6K18FdeKm7fdgXsdIYSdrQghwQ3s8ls7S5MMU53IB8jCXwhpW9zhmRlKe0nupuxMd5Wzph6pRICUeDRtcGvIsaVLHAYwdBGOUyeQMb+vcaG8QXRim2Zp8M3oefGS4HGzyDPL0dj63flPPJ5L/xMaNm7hVt6NFWqh1YBD3wCwDib2mEgN9/rND3vPKDf/KiV123cegEHA4EmYjKHQ0LLQ+UO2svkpuTkeq6+BHnfzFJLnrV0vIB4Tq8JMLmoGMhi9rIctShE2NoM+ODmGAP4ENL8sGLpzWQBaB+1uugNP8RyYyh0qmOs300h/Ud8N496McCpPSkD+aTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClllnRkkGgwniGJEWdCvsNNUQeBXJFkh4a1zTbL9iHE=;
 b=XaR+pGUl7Jrx0OEZHlGofCO9fy+dWkKx1tR46ZNsjlBR/btyGzVikLWsCW6Cp9ybui3kVFka+wX4C/IZarMoUVCuOiH/GaRQpPwRwSljOj/LjTwgyWqS3MBJs66R67aE/PK7ClB0cFVTzLtVV3fn3M1u+UTGxJc2AQS/tmhKpCrBk+EpEaJ4xHt573WdOXh3EgsjP+mCQaPuQKi8exUYyZR6b5nJieFZONViacDs0QzFUrb5y0p53Sb0Ph29av8NnBrW878Q4Wa9zForjzaoPepNt1ButrWix3Fr10LqfCJUbFY8iJD/VP/E35NnvgTM8XRRZhAjRNfoU7OPp0jA2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClllnRkkGgwniGJEWdCvsNNUQeBXJFkh4a1zTbL9iHE=;
 b=kNDnInCyzvWSjFZLJTbn4K/X42H4FSNY/Kfq33g9maM0kQ+TQH7cZ/kh2TegZJZkXdev1iVbsMLo5FuWPdOyZWgof2+301W0SBKaH5WynMcKp9n+hkca4S6ZDgKRqW5Vs/XXd5H+sbU4Yo93QgOIXEXoyONnEO2cc61zkkRFMwEw8qlwHYxS5jBmfgzpvHu2UicJWqKvn/JcQFT2wM+FjjkC+N1YMrGJI5zTDm11Frj1y8kdYNZ09rRDVkiuKSIhNOzyw5KqVGF2jn3FinI1Akb77QgVtLo+Dc8obkg9mP+Jpc/gxjzFnvPRbskrU+O30dwwGbHCu3o/OBmAtROwaQ==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3019.namprd12.prod.outlook.com (2603:10b6:5:3d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 15:28:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 15:28:51 +0000
Date:   Tue, 6 Apr 2021 12:28:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Mark Haywood <mark.haywood@oracle.com>
Subject: Re: Double RESET -> INIT transitions
Message-ID: <20210406152849.GU7405@nvidia.com>
References: <F6F7D0C5-ECA6-43C5-91C5-818076C5619A@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F6F7D0C5-ECA6-43C5-91C5-818076C5619A@oracle.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR10CA0031.namprd10.prod.outlook.com
 (2603:10b6:208:120::44) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR10CA0031.namprd10.prod.outlook.com (2603:10b6:208:120::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Tue, 6 Apr 2021 15:28:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lTndJ-001AOg-QW; Tue, 06 Apr 2021 12:28:49 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ec2f8cf-89d8-4ebd-9d7e-08d8f910ae43
X-MS-TrafficTypeDiagnostic: DM6PR12MB3019:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3019D585397C1505E0AAA206C2769@DM6PR12MB3019.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QqGXRmwBq6VEJpIveVfRVH9QfbRBGGBYl2gmBiWrLQiku1JBA20xS9XYcANpgY1oG9pHdRvF3P0yedOSkUUCHMUdhY5JObewxJJbr3o+AJ3nPRI8YodKGCRa0RlWd9X+jbaJORIpcMY6BOF6tX8iOTCYu4lGRQPSi5jNJdSCaqhWfOdfAQq3szmr3tts1xDf+9IiuPCiIP2lPNhG01uoLNdUdjwM+YCArES4WGL2AMAva2sMYgxiETVWwxcP4vgLQFORG74OmdKPT/ilbBvGf8x6apBU1K8sPINg9c84E3x0gSAY0WGzWl0GCG2UZwGSS1BU6AGRe8dsxhAa1Pq18Nr4TpGomAIdk+emSIGVU39wCoyrETbCQOqc914GU+kfxsCtrJZs4JQFCdb4tI6NCUWp/aLDEIoKPCgx6OjpQTIJI6AQBruNZuSw6a15eqP/ZYARBjKL2VNtwCrp5S7oMh6rJC7qyehtU3e3FbLL7d1gqrzoCJfCdriO4YPS1j8mYf3o0Drve5ZCaKELyysLNTr3lg/R2O7a5if5ZkHGm3SCcT8b6Mfyay6EA8KQQg0hFyaOsa6/6iVtaOhNs31p1z2Uatbla3gUKyi33PhrACZMuTC5aHKnuLSZaXtQrNfJr+OLJoEHAqrJr5O92NxKlhXCUDinTzlOhm24PbP2dec=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(36756003)(38100700001)(2616005)(6916009)(83380400001)(186003)(8676002)(26005)(86362001)(426003)(2906002)(66946007)(66476007)(4326008)(9786002)(9746002)(1076003)(54906003)(4744005)(316002)(478600001)(66556008)(8936002)(5660300002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Jpbn2C1UTPQmGuAOSboatWKqe4hVX7CakMj9urDzBbu0MuWwoZ0cUEOOjRQc?=
 =?us-ascii?Q?m7Qci/Vq2rFejrVlKCb3AeUcu8QRBFtt/8gkvdOucOFgaokrRsyF6uExXzMz?=
 =?us-ascii?Q?rbuUW7Uwp2DIOD9hJ65SF6uvrXqkCEK/SCmg75otwqpySWC7x2DJH03TAiPL?=
 =?us-ascii?Q?0L6MHH0BGfGUQnXUeQ8Y408to8Ng0CVTVQJhUpKUDIS5h15MpmU/iQdpKL/k?=
 =?us-ascii?Q?N/Xhy9QTzD6XrgV8xz2ZOmYGtAhRqa48yRznKXpEotmOBzMFcPw1DEOEx30l?=
 =?us-ascii?Q?ofNpfZp/YtcOj2E9v9GzMM1rFH+zSVQQG/88UU0+T/rb9jrLD+saWyDZ67dZ?=
 =?us-ascii?Q?eHqqJBbKs5jPqNNu3bXgFqeTjIF6xrxGRnUoxPuQIXfdRr2Z8a3gFPYCPUOG?=
 =?us-ascii?Q?IMPvOXLyAR1ivwDaAFDrIufOAV+kBFAfloqVywDICTX1Da8BdinJQhxrJyXF?=
 =?us-ascii?Q?ZHys8HpHpaSwxM3lMGafXX29eZEZjLbGWlsnbuOGzryXFu3w6WNyJTR6xpwi?=
 =?us-ascii?Q?1WwKyoloA75+5JIiaxa6iK03zS/zdI/dwp3Ie4+wuXSsKNdix0r9fMPT6A43?=
 =?us-ascii?Q?3G30vdRMsa3VALpgi3L4ZxhyiuGeIwQaThnZ6KEMa8kJROHYokhnuFquGShT?=
 =?us-ascii?Q?KwdB+21rvnUtkPfD3QcO1/sEtyMQtF8wVi5FX1Ipvwt50civ98Yx1kLuQuFa?=
 =?us-ascii?Q?YPsrKmqtqPMcM+l+xrs2toLhamrdK/6RFeIFgZWBn52No0bJbuq1+ClqYlg9?=
 =?us-ascii?Q?dCNlGq+S8VrRih2CpG5DCjI1MPrQ7qcoqx32wScxF+d7KWMX9+u5UYy3UPZq?=
 =?us-ascii?Q?4mz+Cgdv4cEGZVb2KHXtcwPkbH8AGy0QsNYZLfPRgr4PmtUyNk0JtntuvavU?=
 =?us-ascii?Q?5He2O60HR40hkCFUQv9OZOwiJ0Ayagf1VtmbaMmTo2kdsAOrchCNLGh8exRE?=
 =?us-ascii?Q?oa63z7T8KAMwmqjb2wRh3+g7XDvXU2TFXUETEy1Z/9lR0LgFYbWhAqK8ykCn?=
 =?us-ascii?Q?Iu2bmou3zZIo4DU0xR4hFk7NG5Ci/kHMcQoJpdVvMXSSXGdGNkUyeyjzo4+u?=
 =?us-ascii?Q?mC8HxzeXZYrsPeI5PoRGJebJBytUisJAQXzVR9akTw2NgeVj7vHRgrOMObpA?=
 =?us-ascii?Q?Hzkh70T77jjSkaeqcfO2V0DRlOeqBPbhLEAJPJ21U0vP5nyZ3E8Xf4lGRJDL?=
 =?us-ascii?Q?zaV/FCJijnryX91BaTBKkCFrIiiG9t9yrJB1rZMYBqvsKb5ri8la9c42G6hu?=
 =?us-ascii?Q?G2iLlD2WiV5kxEqZq1SsveQHoeqlGAHuZ+DCZdfAZ+awlDG8pLBmKP3wdZqV?=
 =?us-ascii?Q?YR0ccKvOIMQ9kAZTg0x9JoG+6Wi0ozw3Y/uooS2oCh5DNg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec2f8cf-89d8-4ebd-9d7e-08d8f910ae43
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 15:28:51.3123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNR4Xk0Bf0rhaFZ/BFGQBp0sHC+5Cc49A+eqSF04m1zYU3XEAHXdi6mh2YcheIUd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3019
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 06, 2021 at 03:01:41PM +0000, Haakon Bugge wrote:

> Running rdma_server (RC transport) on an IB device that supports
> abi_ver 4, I see two ib_modify_qp() calls to the INIT state with
> mask 0x39 (STATE, ACCESS_FLAGS, PKEY_INDEX, and PORT) and of course,
> state == 1 (IB_QPS_INIT).
>
> Presumable, from ucma_init_conn_qp(), then again in ucma_modify_qp_rtr().
> 
> Slip of the keyboard?
 
The control flow is complicated here and I worry parts of this are ABI
now. Would it be OK to return from rdma_create_qp_ex() with an
incompletely initialized QP? I don't know.

Jason
