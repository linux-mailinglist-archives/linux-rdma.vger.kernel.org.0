Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3015C3C6274
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jul 2021 20:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbhGLSOU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jul 2021 14:14:20 -0400
Received: from mail-co1nam11on2040.outbound.protection.outlook.com ([40.107.220.40]:38511
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230477AbhGLSOU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Jul 2021 14:14:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fug6tr81EKFxS7Ko5DUMPasX3mHbX1CbcaVe69SvvXGRygGiR0QwlLptplyvXfm3NLEkw1v/1feJ0hoQeDXbXEJLpi5bXEiEF4cK96+QWrT18Yhc38fLQ2EIFVVoTTy4pv3mlfWLodd4PO9h2oa0fNkAq761pVl/9KrSwU80B+AU4GrJ1ve5WFpl4cGhwHJEQZThTI+PCJ8jHZ9XEpmgHawrZQCd4qGlqvPzZEgS5FXWPNnMYtEsSoGffRvInoncsfKMwfTJufqsqXrlXJHcUZLSrXD3R/2obkAzZOoJZ0o8ilqUfoK1lm35MGrug1/oNiZ7qAdSCijlV8nI32T6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6varr3Sy++0hXd7hl8APBR6s+KnjwxubblQ93OS6j8=;
 b=IEamkm6bVVwmm9AqCsZPxjvzPpZy3K5XsoC5UNCijinokW6v6el9AG8vpODDVJfvKMKchkd0LzyUa2WX0ajDSnYOXfU3D6XTn7uTtIXZMzu8Mdtg+2nSvF0s+SOpvqovBZC4kunrKSfkaJ05og/MRUJ9bxiY6oGczk3kMKHURy+fq6EDwWPq+UshBjV959z4WhPrXyynT+eRZgzi6kxqbuArus4mTrtRXuzLov6aqQC0mDXd36+TRObs6YdOr1EA/rrLjl4bqPLaNorxC0VHqc7qsmQoxbEcs0WhQO5lInGelFwSD6rPJoP/riz0KujoplH+Mn65Jlf05Ky7uok4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6varr3Sy++0hXd7hl8APBR6s+KnjwxubblQ93OS6j8=;
 b=fA0UGjl1f4QWib9vzTODVcTHlhDW0uCZLl+X3LuafVfSDzJelF/D69pnMGW854OUAjCFVZi68KksXUBiLXMj0D8DyoTQ00aMmwwhHzvQ61rVdv+huamrABkzarRXa0oBtS69LqNq/L5Mk5R8yDhH4LvoAIn+sb7Q6odpIn3fekNFbdRkucDDkr2v5GBpyNl2YdS8Ke0KAC/FaAbHCfY664iyXGv1OFvS/O8sjK9UfqrIye1Yq5Kal1ixhf1smA+zxK82c9A6mGfi7+NQHcKQEzVQ+UeBWbLFWdZypUVArPzznRtxCUK+yGaxoAUhVyaZ5TKCO1mgJVBU2Q7gnNRTHQ==
Authentication-Results: linux.dev; dkim=none (message not signed)
 header.d=none;linux.dev; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Mon, 12 Jul
 2021 18:11:30 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 18:11:30 +0000
Date:   Mon, 12 Jul 2021 15:11:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     yanjun.zhu@linux.dev
Cc:     zyjzyj2000@gmail.com, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/irdma: change the returned type to void
Message-ID: <20210712181128.GC266283@nvidia.com>
References: <20210708064752.797520-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708064752.797520-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: YTXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Mon, 12 Jul 2021 18:11:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m30Ou-0017OV-VS; Mon, 12 Jul 2021 15:11:28 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 473bf8ae-d078-4f13-de17-08d94560796b
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:
X-Microsoft-Antispam-PRVS: <BL0PR12MB553820879EE52AF3A3D250B2C2159@BL0PR12MB5538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Grv3rdlPnwRuoTmaCxtsEqRGxWAX7l/OQMIEmXpsxygF6pxn4EJ5VLJ19c1oF4phHU+5oVe8h9vTnUur1DnD719D9kN4a59grhu9ifp9hzYFPo2S0m+bbiAyiMJjANKMsZlaZW9Z/h8xQluJyyOTj7hGbcgg+olyapnVIQyyvsd4uXRc24h63tIP3KOuaMcrXL7Ptwj4KRPbpiAPgHwRWWxSEZY8kUcoJByfyNPgFUC2iTNcW6LZwEYGHIAq4aetZWtPSg9iKjp6DEI0FAeeKDq1mhwvZtKF7v5LUJqKN4YPet4fRqRYrDctzquWSAuk5cWYkVy9SoUK/L+R8LELp2p83VZa+SU0SAX+ZJkoDAkNc23fscprrEdZudcOQF1yguALudGJjPm1DT0J4KpeTlw5yg4JFAvWQYI67SAjsDWUnu0/LbLqhL8voAY9FzraBMp3Pzxu89d10YjIYRwJx999v5xQHiltoZRw9RH1NUWiS8Cqm2bOvTK15CmoJ0EdXQ173wgUC06E5sNpdyeCIfHJN7NEWc1zePbZwhDB2GaszP+q5GAcTkcJ+CFY1/SROzrnnQiXCiD50EqOlmNdpuzjl31cXCQlsaAoiRa6aZS4qxE+6U4YjCMVTCjNmKfs5/I3jqtQKCekM82K7OxGFJuxTCzWaPtIXvdmFDYblENqnujdjIGEgCQLcTX6b2me2FIlAq2sz6Kw0yyhumPpAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(86362001)(83380400001)(26005)(66946007)(66556008)(66476007)(4744005)(426003)(186003)(2906002)(2616005)(4326008)(1076003)(5660300002)(8676002)(9746002)(6916009)(9786002)(478600001)(36756003)(33656002)(8936002)(316002)(38100700002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3umc4xgL6/OKvjpBc/oaOO1EWg4rYFvyO7IOBKqUeCJ7YtlKDZefkQ4GE6gK?=
 =?us-ascii?Q?M4ExDe7eJ+N+q93GJBZ2kRse5Jz42LOEAhFsxhzmhWu4tn9clRyjHQqcHMHp?=
 =?us-ascii?Q?G9hUSbsrNSm78zixhct8XWRVCG0KtHZsC0yPOpkh7xvR69mMzAQeTlzZ8V1a?=
 =?us-ascii?Q?hgZpYbPY4U0gXbaeCGZ7476MvoAU6r97dXBCXz8DMLJDLbb/v/4m7VvMsOpt?=
 =?us-ascii?Q?GMs+IXQ+8/v7VQ1PDO63uysRqzkd1g4etryE+OV/7wLCNb29x06A9RgOjQLN?=
 =?us-ascii?Q?T9TX7j8BqBAQWvMzm5L4PgDHiPcpabElodpYduroijCc3jCSirxA+RztyIvG?=
 =?us-ascii?Q?qiJoVlPaO1t1mB3P618hL6SQSI4gynne8ZN2c7iBFMlAxUZHMkOs2Eww4zVC?=
 =?us-ascii?Q?67IX7Yk0pRxOlbuL8dYrJ1iHFgYASh08kqca6HX7xWNwBrRRU1H+n15OuLIY?=
 =?us-ascii?Q?Jho+qrKL6PZVM6wAjYQbwj2DIMOfAaIaUUTeLtQxrLgeO0UJ8O/IpNgWCP/1?=
 =?us-ascii?Q?BaT2L3uTn4N8KOWeJRhTjZ9WoiO/TtH1vWzf1nOHXOkLY/LQji9DkJ8HuXLx?=
 =?us-ascii?Q?Mw37Ow8KVa76+pfFbg7457WSBYHks6cGn0KmrKtcLk4H7X/qZYuKlVLkWGj8?=
 =?us-ascii?Q?wuh4KBtq8qe/ZIvl7crCcPoSTQiswjgUZ6xZkOPPX4/ha/nzYM7BbxoqMu0W?=
 =?us-ascii?Q?qZdvzUFs6OLMoplnjsGck7tVtPQKN27gTBvmlNn8rtg7T0evTswT3ZP5A8fy?=
 =?us-ascii?Q?YstnGNa9Ycc9VpXJXgYZjLvSDh9+AlpJLBRAZORlSdn93NNNX4h7kA6mzgwu?=
 =?us-ascii?Q?JN7UxYuTFPP4C1x3Zl63Tn4EMz1cnUAEzUGGsEUOZ2hIX+3QE/Zc/5fJn6wJ?=
 =?us-ascii?Q?rLfC7psE3D32P4k6s1/4yxVuGWeb/hbqHWhCMkAzabC2dvKS/IexTnKUS0iM?=
 =?us-ascii?Q?uAhOER2xA+GzIB9gXWaIBX00BVKmxo11nHQHmD+5jZ9EThWwBSFz8K9ARyER?=
 =?us-ascii?Q?2NFpphFmuH4wRgGNyrtM5mBOCMKoFwG6Usi2/37sRBz2qJ0kqnTDZiiApu4/?=
 =?us-ascii?Q?yg4Cx9O+gGv2LdDQS1shJSWoOy7WDOw2OH+XOy8Yqu0fWUxB5eRmNNMLNzJe?=
 =?us-ascii?Q?tSw+x+6dIHVDNNOIbXsN21iX1X2DFtEbLP7uQKI9XaUOauKjjOiP125Ddm7n?=
 =?us-ascii?Q?FFrZ1+bs8oeOWNS+w1wYWaKQc+wIK0ozNKYzM/PjzqF9sm5LeExJ1JNTNq3T?=
 =?us-ascii?Q?WzeW9bt9ycvIUmrxRjt5HJUlyRrc7N2ve2NJ5DKIMiDEmVqiROuwQF76nr/E?=
 =?us-ascii?Q?QevltLx+i+V2PFg80NL+zNk+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 473bf8ae-d078-4f13-de17-08d94560796b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 18:11:30.8324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pHDrDBIS+SeI/U/mRmH1U4oPZ59AmrH3CrvYHqnKL/WpLjFv4ZE8+AU6+ndx/Om
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5538
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 08, 2021 at 02:47:52AM -0400, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Since the function irdma_sc_parse_fpm_commit_buf always returns 0,
> remove the returned value check and change the returned type to void.
> 
> Fixes: 3f49d6842569 ("RDMA/irdma: Implement HW Admin Queue OPs")
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Reviewed-by: Majd Dibbiny <majd@nvidia.com>
> Acked-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> ---
>  drivers/infiniband/hw/irdma/ctrl.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Applied to for-rc, thanks

Jason
