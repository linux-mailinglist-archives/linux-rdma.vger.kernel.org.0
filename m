Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7260B42A973
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Oct 2021 18:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbhJLQdC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Oct 2021 12:33:02 -0400
Received: from mail-dm6nam12on2042.outbound.protection.outlook.com ([40.107.243.42]:37408
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231186AbhJLQdB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 Oct 2021 12:33:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QP2jHZWO0A5ymvrGjC29dC3ZGWVI8jXus4JIPb4pP/jxO3kinnue1Q+/BSSR35d+J6/H4TBdk1xA0wqGvyJRf6g/CITVB9PZw6B2FA2iwtU7IdEdF/O131eB3FhIvNWxTX/6NpP8w4nGBksh6bUv3ntSQNts/nprPeflE3r+wkhxu8JUYCF3WORVL57iLRapDxdv/7OF+7MDFuw0aei2FQgS/szV5EYRM5a394Wwt32irOHlJA0sFvlGMXN0gvH4teJ3IdygPw80ZiDk4eBSFontX/IjU6yEyc9DuwtOB5X8ZxzAD6UJ+jpthEQaqPSo77+AJk4sAx9u2rdQvTwxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUKRH9OR8ctSvylp9Spdfak74Awq6ZrURsrqPMtcYeY=;
 b=Aeg/G06wkotlGId2Nj3sDG6ygqAsMiKIusMhbfKandjYMSSAGzXKXdmSoipseP0D+uKCIiKskEpon/7t54x8RCcelXXWETC41gFjCt23MYvHWQmSzc3WyBa2759e3Iq34egG3Awq4l/Dm0FenaunkDOOkI+bWSfhFUXkyXICKr8ugDjda6HF01+lptbrOUErZj2lrB+Nr/JPy/uJarvYeFCa8rss6qiCXe1aSpO35iFe1GDskTcZaXDjvLD/+Gur2h5FcaLD4nPaY4vRdnEbYixPoUv5wqLS5Q8vPndhqen56tEj6tGOwnUnl8Xybt6Zp3r+GzmSCDKhyamogYmiNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUKRH9OR8ctSvylp9Spdfak74Awq6ZrURsrqPMtcYeY=;
 b=SenQ3hptxj7LNsQgfIQLh7GQMVcrlopq4siOTv7rCDe40Ct1ZPDSX4uqdustxYc9HDNB8hZ5xu/GZZU9KN3GXWJImVTaFWVmrD0ERVzbGYAJqLCTnv8lJ09FfEgNfh2OJ2IQg4H2rVGn6teikCNWYyOKwayC/rd0owpccAjpHHiIfKKbSnPjzEkxcPP6h1BQE7KSkeF70UG74cHy8DLaIP7nXPXBWNXdhHq24MVQNDM9DeVWnlZ9JHNbfaucIxRSJHKYRcgDuLw7P9CNFnDoQ4sZFSS68uwSHn6Pw2zSpucIxlCCDg95V3ijtB83FccDnphPDrhpA2KYEnCrYC/hjw==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Tue, 12 Oct
 2021 16:30:58 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%6]) with mapi id 15.20.4608.014; Tue, 12 Oct 2021
 16:30:58 +0000
Date:   Tue, 12 Oct 2021 13:30:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v6 0/6] Replace AV by AH in UD sends
Message-ID: <20211012163056.GA3390660@nvidia.com>
References: <20211007204051.10086-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007204051.10086-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:208:23a::30) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR03CA0025.namprd03.prod.outlook.com (2603:10b6:208:23a::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend Transport; Tue, 12 Oct 2021 16:30:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1maKg4-00EE4q-Nn; Tue, 12 Oct 2021 13:30:56 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed7fdbcb-2bf2-426a-2583-08d98d9dabe8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5254:
X-Microsoft-Antispam-PRVS: <BL1PR12MB525450FB9E372E9F5A62AB2BC2B69@BL1PR12MB5254.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KOzids/RNegMNWfJhssXJutC7LlSFympJWwubSMN20+RzpNRv43X5fx8KOjgXUfu0jfhEpcMgtHG7ZdRB3IdTORtaHJis2hMja9E3B0FPv6LQJuMAd+jIvtblEyaY8tsYcwIzkm3Hd71Qd9XAPtlgSNFPXES0E3drh1c7p9tMYJ6aFHFliZbYpyV84SY38aWaJJ0kHDTsMwwQ7iPwODb9zFpwXG3PQ9vZzk4Ktoo8fIkPQMCN5zoGZ2JaJj0Jp5Oxb6v2rP4Ado4oioQDx15j4D58WWqw2Zn5B1Xwwbl3jQfnrmAmAKlVt3JlU9BYUitYOrdwtPNq764p9ekLO4G7yQDs/EkaYbzS6Rk44c6S2AHy6egRnRC77qT/eKJQ9MYawRHYAiB5NGxEYeJOOIiGbNNPWFKa9zRKuUMQinODQkxi/PFF3XW8JfWPErBcC8nIB/zlzPDkKDeyiGpVa9Wu2nRIj0GTYk1YfEzV4rr+BehwzM2n4fd8Wm6EtgUbmZKw8C8vzyEYjtl0gxzs3vhiwhUaZO4yT/jBIyCSpzXBcm1/tt+rOosDPy1tGAGFzqfiWU4wstBrV7ZG2r/Po8sbJQlg4/T2LRrJCOyoYYHc1x7ecqEsLwUdK/vHWHbDjSgJ1VpCnmHEnkB8sICZ+BS1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(9746002)(426003)(8676002)(38100700002)(5660300002)(8936002)(4326008)(2616005)(9786002)(86362001)(36756003)(66476007)(66946007)(508600001)(83380400001)(66556008)(26005)(33656002)(186003)(2906002)(1076003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JO/4g9oZJiGdKbJ2ReZYHZBKu8DindqYcsnsPe554N6CbQLapiDjkKazufLA?=
 =?us-ascii?Q?qSK71nkFSTQvXJuIKsGiG3/bNMCrwrlLFwDb40dHiTt0E4hR04dBywDz3VBi?=
 =?us-ascii?Q?ag/G0347EK2yAn0XuNy+gy5hczq4T6N9/kRtm36F5unP3siPXYZX3cUY6TDn?=
 =?us-ascii?Q?wHgpvAEVM9YEZyXfoCURZbjjKEQ97pRn2GD/pChF3qQ73j5FyXJCiBLUELRD?=
 =?us-ascii?Q?2JPO1JZxkFuzfOcs3dMM+MIMiLRn+TL+bNHPxv+rT25IO+EByHp7DEOO3UQ1?=
 =?us-ascii?Q?EZfCANoIMr0hAIcJmQmrTF/yGi0Ldd8NE6Zh8mi3Oe7s+m4L7dk8qPIAHHbo?=
 =?us-ascii?Q?8KHiyREjdMFb8bPU/k297tdj+7qKNYlZgz9DKUEoh0INGckTLc8RLAA2E4XA?=
 =?us-ascii?Q?53Td/0OvSrip8ZYICiIyuumMZtJpSjLoh5+v2phS3AEkVLdBsRGU5Y1/v3zP?=
 =?us-ascii?Q?KJOgFy4xhdt1kTYDMlTxivOB6Wv578tTsQmbTjRMWEJE8DVf3ZrT6r5yJcaj?=
 =?us-ascii?Q?M2LDj0xWjCq5Yt+brp2pr/W3o9JcVO32i+wCCjNQ08xHCRE46mgHLd/Aj/pW?=
 =?us-ascii?Q?diqn79UuiSrl/Zd/0XvvYdntcLd3aa6jPDZG0uX9xHOtvou3HCMMxisRP62q?=
 =?us-ascii?Q?gfeWzIyxx7M/wbYcd09yu62Biy7nTjRKCYU1FcCIuno3CNx8fDRIVTnj/RYV?=
 =?us-ascii?Q?0zZaQUMfgPb3IoFeXEX5EWbVFTgfjDTmrKvPp670dWZB16Sd4w1oQzC+TWR4?=
 =?us-ascii?Q?XtMDYa1FFTTF/4hGRVg9YIDLBk+APDElAV1AB8oTFTnMeD78/9OHdBUUguWZ?=
 =?us-ascii?Q?bFtOu4rg5ITRChCCcz/zT7k4nnOfvNeOMDv5bCtYx0mHnTwQGI07c9Jd4sUH?=
 =?us-ascii?Q?QGDqB76vszErMAZNZIdaVgOOWVLpTzAHrY1EcFf7o6akDs3LwJ+/z5rd0MAm?=
 =?us-ascii?Q?mwRT2GotR1IajKTXF8vg8MtHdKrnIETtNpKMzdi75rK+OVFQeXfWS7MCustI?=
 =?us-ascii?Q?JZJchfyWiPrWHOpFwVFvp5frsr5ko9VPT3i8koFkDsljJfa4P4Sfl9an+2va?=
 =?us-ascii?Q?RIjBpTU+pOn5opTRXdH2C4ofl/NoCVCOZqftOfAZSTtHcFsHP2XRk4kupyGf?=
 =?us-ascii?Q?gQ4WBDhpuONaD4G+WLw9zgPdq2SilEN/8LBS163QJaxTyHXH/f+urZZXLgnQ?=
 =?us-ascii?Q?+qMf9CuO+KQM6XoTsu3IyQokv5dlISK13tZ3pJPcy0+zLazcYkH0xGhTre89?=
 =?us-ascii?Q?Zl6GSGraQUQM+e2ioXm3+bdaNg1+4gwMX3K1Pcln8o0YJjDn3ZvNKX8R3ZwL?=
 =?us-ascii?Q?aKF14CJidadzAL+7iZgFr1UX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7fdbcb-2bf2-426a-2583-08d98d9dabe8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 16:30:58.4479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEuJxaFY8TObfGAo4JdXntz+tJgtxZ+lWaqpnuXfvqWj5FzfD7+douqiU+xgljYp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5254
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 07, 2021 at 03:40:46PM -0500, Bob Pearson wrote:
> Currently the rdma_rxe driver and its user space provider exchange
> addressing information for UD sends by having the provider compute an
> address vector (AV) and send it with each WQE. This is not the way
> that the RDMA verbs API was intended to operate.
> 
> This series of patches modifies the way UD send WQEs work by exchanging
> an index identifying the AH replacing the 88 byte AV by a 4 byte AH
> index. In order to not break compatibility with the existing API the
> rdma_rxe driver will recognise when an older version of the provider
> is not sending an index (i.e. it is 0) and will use the AV instead.
> 
> This series of patches is rebased to
>     commit: 286dba65a4a65a6d5de011767061f6ffa6e10389 (for-next)
> 
> v6:
>   Rebase to 5.15.0-rc4
>   Reduced the max number of AH objects from 1M to 32K.
> 
> v5:
>   Rebase to 5.15.0-rc2+
> 
> v4:
>   Rebase to 5.15.0-rc1+
> 
> v3:
>   Split up commits into smaller steps.
> 
> v2:
>   Rearranged AV in rxe_send_wqe to be in the ud struct but padded to the
>   same offset as the original preserving ABI compatibility.
> 
> Bob Pearson (6):
>   RDMA/rxe: Move AV from rxe_send_wqe to rxe_send_wr
>   RDMA/rxe: Change AH objects to indexed
>   RDMA/rxe: Create AH index and return to user space
>   RDMA/rxe: Replace ah->pd by ah->ibah.pd
>   RDMA/rxe: Lookup kernel AH from ah index in UD WQEs
>   RDMA/rxe: Convert kernel UD post send to use ah_num

Applied to for-next, thanks

Jason
