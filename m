Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B3637AF8F
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 21:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhEKTvT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 15:51:19 -0400
Received: from mail-bn7nam10on2076.outbound.protection.outlook.com ([40.107.92.76]:21217
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230408AbhEKTvS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 15:51:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfcCf0QHMsza8qMcKLUmYFmuRmDzogEtJIrDLCPQJCKXPjCMt9Unv+WUjWeC9JXInFJrItNjTD1ZDzqO6uUFYxSFYnTYkczKc7XE5ddFcTOQlOfBsJVhU+WxA4PZeMn3lKuvtzuERRkn3CjC90QgfFLOEzcmp8ODr+v4oSJPblz48AXAKJPeTDSFCRz02v3fEsJBTCRlnBJMiOXY4kGLRpI27xStHMTAtAMXGP5JBvt02SRvRx9/fx9r7rPkVdbTnGjHwkRGgGyIC9a67Byy9LyJHPf/QJmiEztCHvn+KcULu/8W5p5BvmqWygXaMHZmW1Wkku4h7UdHLe7kf/KAng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NA88WYmfcSaG9exuwrJvtgVeZt5X5Ts9paPzWsn6ss0=;
 b=lPZozNdyQdH8cnvCfB4M5g/v8yQFmwTPqh0Eh9K5Fo06FgGZaYNc2MuOrE/OMbjUBXsyA5XfQnZUrbmhIbwpN1nzc/BV2KOXcExLgJNWouGraXWwAo+QYJHQdwUz7MTYSq9t/uoOMBSdGjCbcxkRkVTezQuenSR9/gjhzo6i2qYVFnY1rYr0C1orHo+aCWssUwB3l1FgZEjfoiDY1ZNqAcUzg0CyO+RrZDOJLhHkjcCgGkRfn47DJ1bRjdAW4N5diTiaWfAy65ymy+PE0iGh2+0lrQy5kRAZG+a/hIK+Ggc5m0wacM+xfbyCHosjTqy/2JIJSK1owkwO/nkEoICfGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NA88WYmfcSaG9exuwrJvtgVeZt5X5Ts9paPzWsn6ss0=;
 b=ExXKvJC/NLmXPwB4TxOvL8HdcsrVhbSWR8odOFGYG+N6IiT6uUvtX3pulcXwc8juotPezY1kZdTP3ab5yY7dDPgamyWZShzLZhKM2t5QrEaOm0hKGyqO7LGFtFcWmfOeqhI0rr7cd0+lvIVJbX2iyw4zB0HbggHJ5gsZL2afFf64+D1I+IvbB+TLOAZWAHBmyuNu4nvk9jTD5R+n5zHbWjHJzAsQqkE3Pefis/cl9Z9AA3M20YjtLYw884e0bK/X+d+UkDxCTWJNrE3H3aAqvQHOJEK5+GNbnx8MIVUrGxnWJCQP5yiTPSjlTbCxW1gY06CnAIvvnThovjUoeeedaw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3403.namprd12.prod.outlook.com (2603:10b6:5:11d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 11 May
 2021 19:50:10 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 19:50:10 +0000
Date:   Tue, 11 May 2021 16:50:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/core: Remove never used ib_modify_wq
 function call
Message-ID: <20210511195008.GE1316147@nvidia.com>
References: <c5e48d517b9163fe4f9ffd224050b83fdb3571c6.1620552935.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5e48d517b9163fe4f9ffd224050b83fdb3571c6.1620552935.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR15CA0015.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR15CA0015.namprd15.prod.outlook.com (2603:10b6:208:1b4::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 19:50:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lgYOO-005Wej-O9; Tue, 11 May 2021 16:50:08 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8eafa6a-3c14-426b-67e3-08d914b5fbe8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3403:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB34034956F8C42E5A89DCFA04C2539@DM6PR12MB3403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OcG3jecyWvh6zqFjrLvEUJsV6887Bg/X8s3naKATquPe24Eb6PWnj4EyRfm1r8NUEE4zNYmL6l/3kXkjecEdICIHvUERKqOmMXStrPPRdxaUTPsSTqYDS3e+vQQnzmoQj1yBoGdpvJD8x2hWzQZq4VT0DHCPzj+BP2kL4Mng5T/LjGBtkxxoELli/EPJXp5uBRWt5b/VBZVqpWiKrHLdvAihm5SADHcS4QF+lWmrjJmDgLPz4gfHeVWQartIZU+4qVB7MuPV6mfq5raU/q85V8FdaI79MRKU0EbJMZ+xm6kGOtVrjOItEMU7PjFFenAdj4toHuUiqOlPrqUe9735eHWmIl4ZRxRr81sJw4HCE4OcxCVgn004W6X5mjRfO8O4WPehGEC/ALPxSYSKu8LreZbIBac9eyLR6UrJDA7s2Ajz4HgQtrgCTXi08Rv0N5fTpT2pfLyLDspzViD4UhIBsW1IVHGt8YO/6K73tsq381zYjVuPQ+meGEsMHvs8qj6z9vrGVyFqybBzYMAZli5y4dkRegVzdDnCDtXZHkgW5i1vBVxvl3MOYoppUdLEgvdJeffo/a9ATIXmbnrUWFWJg4GHYCUOgE+5tM2WluDxEzs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(38100700002)(4326008)(6916009)(2616005)(33656002)(36756003)(9746002)(9786002)(66946007)(26005)(2906002)(8676002)(186003)(5660300002)(4744005)(83380400001)(86362001)(1076003)(478600001)(8936002)(54906003)(426003)(316002)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CbMH25YPiYxW2J5nohsl8+gTb2WKU3fVHTvhhaoED7Xg/1Wfejy9HYUI/yId?=
 =?us-ascii?Q?1g+l5fQr/ElzAYb9RYLiTTd6cIojX6JBUejeJL/u6+ZK1sAV/iDTMPtFk/cA?=
 =?us-ascii?Q?vqH/NQ4eRqqa4YeOG7NDbG3szHDo8zQ+Y/blnlJLZtjo4Zq8YH9PydVJdll0?=
 =?us-ascii?Q?NfUlQ4NFHt7b1v+n6mKlHNU5Vbojo+YXnU/ivZt4vyrnGCs+XlzORi6bWsgA?=
 =?us-ascii?Q?OqBnTmIS/ZRiHpO+tT43+K1e8+UEgvr+4xlK71k2ZV7WUOi3gmtq57RB4shM?=
 =?us-ascii?Q?SOLV8HEoA7VheSeTNGWAAan93RkucaBGcboyf1JMRK6AcZDczJ+dD4qzJLv5?=
 =?us-ascii?Q?Wmx/fXgWttxf7EIDNHtL37WP54jIra1ti06IB4tJmdzyHCDCfi26RzHtwHJP?=
 =?us-ascii?Q?oKZLf6zBUKE7To8NBRUeCyF0tmwMi9RvJTvW9GlscbYb/s7lZL6i7rIWUkKo?=
 =?us-ascii?Q?vWrtO73QIRwj0fdX/crTrphgOJJFEoWXZ+zSrNuldLQWr7vZuZniN1zvJia3?=
 =?us-ascii?Q?4WoKjgPBOEhqLc4p2YsnxrfhuWKz8zARs0KlOCOzcHVnTiT2hh/WZ0+nxRWX?=
 =?us-ascii?Q?JGAiKlrs4f50SuhE6TiDJMLsl+u0/WPmbKEVeiRtF3ymSb7ALRsZ6/g6+0Hg?=
 =?us-ascii?Q?o93SH2+MAoIWX2Xkde7ugkgvAzLWAAs00G+02eiWGFVn0XiMt/PkGY+ecatR?=
 =?us-ascii?Q?CszPsOigika/pUq+bLBSjfJ6u0sUe+V0UF7spP71aDxWySIpEPepcfaUoe2t?=
 =?us-ascii?Q?5xLthC6M7EScAVr9Lmo+Mw4eiIFJrn0isx9JBzVB1Uim/ckZAkEySeZFWq08?=
 =?us-ascii?Q?4RF3yctzzntBV6EQClhu1kiMnZP9GxwTMj0e9rNB/ns8HXQQ59nfhc+K95ca?=
 =?us-ascii?Q?dZhgYeSYQ+jZbAnZL1KbuY3lIvCh+Cn9bGB94x7WXnByRrg4z1kL+vfIe1bQ?=
 =?us-ascii?Q?MmZYKp0Y619+hfdXdDNPJiua5oytsa2QxDP/8g/eI7D9bHbsX3S6ys+cPm15?=
 =?us-ascii?Q?ZHgagvuPyAPcK97HxBvm/SiL5kCUheE70uF+wTqYFQd5Y7a8tuLlrk/LOM5D?=
 =?us-ascii?Q?cZlg9jfy9F533syT1a0qNq1tODzO3XlAP5SnLoTCxdsff24RfR9hWkJQnXE0?=
 =?us-ascii?Q?jSph6ouQWWY71fEsIUNsNUNwqqdpxk9YgR8I5LOAZ12O8bp5mblxtY+j3mrw?=
 =?us-ascii?Q?iLh6JXuYaOfg2JgTmQUGJCealJ9/u8+6Ni/PYfyv/NQE0zGYqC2oTrFjrAUC?=
 =?us-ascii?Q?9Fac5cx54z3ORTQ7CQnu/6P8wpXbIqMI95/kbVW8U1yBKELmPsOeSpN8ftPs?=
 =?us-ascii?Q?Myj9XdCTtnR3B8pM1PlbE51V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8eafa6a-3c14-426b-67e3-08d914b5fbe8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 19:50:09.9243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiyWeZSQQe7/f7CiHExZxnZEgHaNUyVlpKt/SUVipLiwQleo2x9XS6EZ8uNqtnqE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3403
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 09, 2021 at 12:36:06PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The function ib_modify_wq() is not used, so remove it.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/verbs.c | 21 ---------------------
>  include/rdma/ib_verbs.h         |  2 --
>  2 files changed, 23 deletions(-)

Applied to for-next, thanks

Jason
