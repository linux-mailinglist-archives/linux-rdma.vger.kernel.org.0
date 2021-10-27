Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D96B43CF14
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Oct 2021 18:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239523AbhJ0Q5r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Oct 2021 12:57:47 -0400
Received: from mail-dm6nam08on2059.outbound.protection.outlook.com ([40.107.102.59]:64673
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233200AbhJ0Q5p (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Oct 2021 12:57:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nge0bHYna7/qu5oJdSSH1rm6qVvKLLKKYIyN6Zn7riQQ6Rbkzh+kMmZMamRpRoJy4kHtt51Jg7QiHQmjRSArwNDaueJjgwJ58NCy26JnmglWBYpPeegWzr61JvT2pZefObzyJFBBoW6JyIuu2GnzqHXdAuCauQLVzlr+bWxcFIXDXSKz4ufVhGeTqlzBIIOlcQuWGfJxVR9UdQAfVUWVH4/VOlK64nwBRj4PVL9Q7/egeQIgOw1nUOCdWzJHmUjIFxVFCTpCI5LyAlPiGTHqlL6CY8ROGwgqOk0pSsTRoCLn9unpuy/iObDJm9MINSioQ6AzDrDubDMTH4K19Va9RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1JEgOALoU/Qgx7XLheYsgX7/lqoLPriioXg3HAOaFs=;
 b=GBGgCg6+5Jxw4A6QNsHLzjQxzWLYkNvS2eJ/oLgDPsy/QYX53WgiCxuUAmQ6rCRj3TRN3DZPHFP7aQ/u0XRywufIUBFVUJHZ10HCYYPgLEWB4E7h02fu1P5AafEIBeFHX8bnv/TWj8nhEdyQgYmLMZ+E1OqwMOT46Xi1YzOdR1JGLKogiLuomVmiCL/s/oWK/PmLxCVuRirmkCyUdPoOz07jplduvMRr02+cLSoIQ/xCa61MdWhDYklpiDuqAdEdE7QsZE0rKwvHz+QSfxS17TtelwoxmJ4WQq+EVvC7DTkkaK+CMh3s78y8exz+BWw9dwsMelQjjkRoOXjxBTafaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1JEgOALoU/Qgx7XLheYsgX7/lqoLPriioXg3HAOaFs=;
 b=gQseneqk/2tODG5W/C8iSfZBsJ92sI9WzxdAZ5QcAwo4JirJieuBz1BVbRuh9DPT24lybkYDIPQ7237kRhiuijeRNPK0BogeaVuIPPdRp71PGmprc0zDgm9xwhNvTWuTwlADdkIwhuCDHviZZ2mUHbNJBW7wSMLnHUYgZzAjqf/2sBLSui15cRw32vuPJkduX3geSIUtvLCim884Zuq+eTJ+GZhXPJ5rYfXt0bI+VY8CQX/5LRIvc+ZkPEoYiRInR3tyB2ZFtYWoNLF+R0lcRFWnjK0oGav6mQKIuZ7Xl5duRbYeyMd7Y5tFwoGdDvmVIosco7ihG0/C7e0lupJT4A==
Authentication-Results: wanadoo.fr; dkim=none (message not signed)
 header.d=none;wanadoo.fr; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5253.namprd12.prod.outlook.com (2603:10b6:208:30b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 27 Oct
 2021 16:55:18 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 16:55:18 +0000
Date:   Wed, 27 Oct 2021 13:55:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     zyjzyj2000@gmail.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] RDMA/rxe: Save a few bytes from struct rxe_pool
Message-ID: <20211027165516.GA644080@nvidia.com>
References: <2c42065049bb2b99bededdc423a9babf4a98adee.1635093628.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c42065049bb2b99bededdc423a9babf4a98adee.1635093628.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: YT3PR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::34) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YT3PR01CA0086.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Wed, 27 Oct 2021 16:55:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mfmCq-002hZ8-Bx; Wed, 27 Oct 2021 13:55:16 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4620593-10ed-492e-98f2-08d9996a8df9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5253:
X-Microsoft-Antispam-PRVS: <BL1PR12MB525313E0396925DCA1F7C0D0C2859@BL1PR12MB5253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vB6swu9/aixsVRMTk5izlc7voaERQmXYZQtD+PNe2xbHN5kwIEFP3hzV4qSr6HvAX6fgVDEQaHM8Cnvday+yK1MrvIZFBlvHPFFtgbgp/NhT8d5akjQOA4I6z2BVaKOdj4zkmxRjn6eqPFiv6fS6pZ0196dwhcPwJFdb2ifcrkjcFyri+zGYI535yMtaeuvPeCIKAC99SIq/qQVDzVNucivMtrE59xR0Pex8e/AY/sCI7ptZ6Q7+E5a6sfoX2UguEscWb9ezg2gVbSpNmxDuVtq/8jqTGKVme4nTYgfxkDy0hLqNZKhp24D1bv9g2gYpn7huJw10H69wMS8Rayd/if4fS7fBi2dTUOESgRPuk6LEv3NFNVx8X5+75f/nh4G03hv7bzdTCppMYn22LhWF2c47NxqiwsSOTLhuOL4u0HZYftmzmK5J7//svdFW3xXRIxzSWhyfI5reEqEbYleHa9u0P1hfoqxsJsQOHQqUqZVOobz3xiEvTIZAJ1FoM8yNneHYVQaOyZG8JkW/U/H8uY+VKKpPkmr2i+odSERJpFKGEOY0xVLk8dPUlbYMYJeXMjCj3s9nbLVid8kTGJM3OZACjSHv4isc6JxWWIk7tNYIiZavpQuCindR8x9F22iNgL8NLsAF7SIEmtccy6nQ8tddiaNj5g/zanG37W/dZ8zXl5zatgn1e7FqtQuk8UwcGJv5DamRuHzViF6UFgS6mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(33656002)(8936002)(9786002)(5660300002)(508600001)(9746002)(8676002)(2906002)(83380400001)(1076003)(4326008)(426003)(36756003)(66556008)(66476007)(316002)(186003)(66946007)(38100700002)(26005)(2616005)(4744005)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JF42+Lr2+mC+w5FTljnpOD6aJFxURDDkpDG7qo3sPiRK9lg6jY8tce4NRDs0?=
 =?us-ascii?Q?sxKwXMaziTJrFYvY9Obp2RAEfHG1kvzf5RGeb2ywQoCg1dydja9aTYt0hx/a?=
 =?us-ascii?Q?uTyNwlLbiXGynI4FPqFS6dwnetBO2r6vFepmUOxLmPhBmzTWFfJqbaUKc9vP?=
 =?us-ascii?Q?QyqDm2pwgme6hSh95H3pFVtggOX3/fGEMm/su1UcK0+3CzvIaWXv/lXXi58U?=
 =?us-ascii?Q?4Z6viRI+vp737rqIw8F1o5bQy/BbXQODiRwx27uRSo/kBsEpO7TdHyJGX8rG?=
 =?us-ascii?Q?i4rp1IRn8aL3b9F3PXHLvv7jK2KnydmIQjF5rUC/OjqQU7bB+vlhWZ2p8zVZ?=
 =?us-ascii?Q?2bid3peSyr9mZN94AbUliQ82WQ3+bOPdJxOimv0vDKPgDIoEKk53cIJSXuZt?=
 =?us-ascii?Q?7pQX9H3vcLsSR5MTqbKfgkSG59pS4A6hjvEella8sdFJpB0jk94JFJEyYuql?=
 =?us-ascii?Q?TbKZKTZU2h1uxBHuQfbj1ecvazDTdZ0gaz15hYSKb+0gmm1SNiHPi9C8Jlbj?=
 =?us-ascii?Q?B3cuuILUUHzWmFHsJQ4StXUxIuc3Tg1xV5w6AcH4dv0BrS36bb50hTsdP91b?=
 =?us-ascii?Q?UW1DNxf6Vhfp0X1ICGTbzefsP7P/IGeTYhBT953Bkv+iCcQG/vlSqGAa12mE?=
 =?us-ascii?Q?7coZi3tkwz1VEG2t0OsSRZo1wR9gHW+8s9ujXsRyzI+N/FZs572klqeX+tU4?=
 =?us-ascii?Q?2UTYxQnTAv3pIwfp//S9fJS/fuVMvShjtp+Yomu/XvZwxp8sm3JhqgvhM8uA?=
 =?us-ascii?Q?uZzRky3j4ZSJdcOK4HZrc/bvJjXj7weR+LQXq1xG9oKDFW2LKkmaJHbKHn+G?=
 =?us-ascii?Q?WpRGXS7/qrUmtOJyap3yLYsgk2/Tnoo0uq7ZO9EyX2gDdGb5dKyEAq3LALFZ?=
 =?us-ascii?Q?wXETEG8zO5xwBZdxM4ClyDSZP7tcGqJSswDPvRg3GTTMnYtuFgHCKsgqYixf?=
 =?us-ascii?Q?ui65j5wQhJSS0q4qipTp0uYnVTc5vacK9jMIPGFqgl5xO5C50LbXrovg7oNS?=
 =?us-ascii?Q?zbGmBbwuYfgT667GhiEUvUvy/ZPgdj2birmj+dp+ox2KnKnmVm8GCAvqMFNv?=
 =?us-ascii?Q?fZFrnPy352avdP1l9LsH5wlRTzOsjRlZV4GjOa4NDaY+/lh2fSH0irNZiUVj?=
 =?us-ascii?Q?KArUEjA05Ninzl6Bclo7Ykdc3AelEHOemTvoPNZGDOH8lqaZy4RkJQx58AuN?=
 =?us-ascii?Q?3teOoGcMnlYZluAGpzdydzWyB3JQhJvzdbjWJ0+pnT4Oi+JW6Ps0bba+O3rD?=
 =?us-ascii?Q?X4pm1037nvVs0p9ts5jNXzAq+P4AGii3XucEnOHoo3bNU5UnGWHnldrkMhD5?=
 =?us-ascii?Q?lRPApIdzBmnGAVhanSPF9JjCGafmEluvk+tMT5U+B5WjJ9isiXCH27owEzgV?=
 =?us-ascii?Q?k3ds6hslkx3Ek0jCflBxh55MQP5x7+DiIfLoi12ofkpyE1z420gsR5Ygpa+Y?=
 =?us-ascii?Q?ydwKZi0DfECJxjeX+kBdtu1o/vwcIGsNaDRPBPXRAmUOfNnazNL2ydZpALSB?=
 =?us-ascii?Q?BQgvOwysBswPjGyw9RF56cVlVHzX9rSoH+br2aXN8D9FcrluTDTMoCEwob7f?=
 =?us-ascii?Q?NcPoLZCJoycx37tTH0w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4620593-10ed-492e-98f2-08d9996a8df9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 16:55:18.0101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4moGao6HUSwMIIN9UsuJtPM+47CVUENurvNPNlFafbZrvpfwishbRnS/rq2Sf/be
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5253
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 24, 2021 at 06:43:30PM +0200, Christophe JAILLET wrote:
> 'table_size' is never read, it can be removed.
> 
> In fact, the only place that uses something that could be 'table_size' is
> 'alloc_index()'. In this function, it is re-computed from 'min_index' and
> 'max_index'.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/sw/rxe/rxe_pool.c | 1 -
>  drivers/infiniband/sw/rxe/rxe_pool.h | 1 -
>  2 files changed, 2 deletions(-)

This and the next applied to for-next, thanks

Jason
