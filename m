Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5B94858DD
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 20:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243317AbiAETGZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 14:06:25 -0500
Received: from mail-bn8nam08on2066.outbound.protection.outlook.com ([40.107.100.66]:37637
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243276AbiAETGZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 14:06:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z94uEn0QNSkg0KNZ8lnOFMOLfB1sG7gf+7wqDr7ZkByOV2UZWo+ghQeMoExmNA3e4PUr3En7TVma569mJKanT9fMZR64udUpgLphJMfoBkK0UE9eLKpFXNgWjQSmjlXZX/Nk2zjY0D0KnCI0pTHTkv8oqaNEzpeeMBmAqXkRE4jl1Jx/hcjcUG4Ay1QvsQ8H9ophxYxWXkUET8xs/xZuJR9kNO4eT5v2jkQkHzLMmU6B8qS/GKmMF4Z54kgdNtY20zkDFmlyaAy5Abki9vtsapbDQ1+wKom6bKnxUcR0K63b7GZzuVZWFXmyHvC08Oq3UuaT+5iIA7XUbXwtxJNLtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzHsNxBPCl5zEDBDc8optwV4HWnm5ZRnoXWCYjgfxF8=;
 b=S9QpTH/58e8R3CE/79/9C2lfrfJRDqqzIOyNSTRFoAKkcwcLTqkES9Qukfa0YPAdfpELfDcp9rIsXmSsytVGhG9LzoKMHXPRHM9FoAtDG6ymd4YXScStjGrquCe/sxC8FOi36WijFGBZT1ca+zGIGzUrG74Bo6hezCVYP+Q8WbLPg/w8+38bFZlMA4FhnN6CiKfQODP95RCKjUKA4MdkTYKJO3lanqV/gjKattUhSD8d8EGXybQ0nbLYt/d3/KRt15RqB0b5TH28XLnxDbvWpPDlEuuqTonSXlU0Qll6HyzsFuNKVnMbr2AVDJGXt2ZvUwsHFwf+4ANbmibw2oAvTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzHsNxBPCl5zEDBDc8optwV4HWnm5ZRnoXWCYjgfxF8=;
 b=gCcqObohUjxASKTpsLn0BWOZlrQGQPhScfQWOxSsOxTCJPTQFHJAiQbe9N9+FawWsL9yZ/ME2YbaPY3nAbzDyABEekOK/hTI/V9Ui7GIUbdOw87wFyVYgI0kytU1CGob8NGVWLjSxm9LRmN0TWofY1PbpenBPzTkKvD7w6XZ/aemsnqCF+/RWQ+C35Gs7KCz8q3EoKtn64gM85rcyf7sZDvwKbNg07dzORYF0EOLxYZ/wk84t0PioF6zPeAEu0Sz0cug693LmNtM2ccmXtl91FffvXIBt+wARmF1JZaFZgzDsM6g53VYFH/8XOQXHVhecOPsEeg4KMGwc0RTmf4J8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5272.namprd12.prod.outlook.com (2603:10b6:208:319::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 19:06:23 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 19:06:23 +0000
Date:   Wed, 5 Jan 2022 15:06:21 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: fix a typo in opcode name
Message-ID: <20220105190621.GB2861973@nvidia.com>
References: <20211218112320.3558770-1-cgxu519@mykernel.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218112320.3558770-1-cgxu519@mykernel.net>
X-ClientProxiedBy: BYAPR07CA0082.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2679f600-d0ff-4853-1bdf-08d9d07e7742
X-MS-TrafficTypeDiagnostic: BL1PR12MB5272:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5272F33DD72B85E8D5985792C24B9@BL1PR12MB5272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TNkaEFO3cu1iyqJOGWyxhe+ukgyvsjZamFEb4fpEHInFLSLsbxc0dhpNlZ2y+mut1h6gaNHml3+7x9DGGDaLb8t1F66b3313oWFat1OOB5KhEE1mfs/SVFKZK3W0Q4dBUcLsSEeekLTDu8R8zHmN+UDEgr4BPCFJv2AehmfSL6ypAnJI/xiu2cybXNdNrJwj2XPTD2ujBPlhhkTeO+poSZyw1khRFRYF+6TlHZAVzfneO3WO5h0XZMB/gaMIc8pKiynBUr+NUQ1yjMQcmBb4TC5lPcCbLeSpYCuUBoiusQtDr3l+nsstXzLaPdLncBgV5MQMPR3PK5dhBG11XS7elL0zyPxONbtqcrGcK7z08SD0YqaWVjvbE12JI9AWNN8cJoJTXauiyEe3lflHKGZB7ekPIYs5IeSWkoQwqVqoM4fPd1+zJv9lUN8ANuNzMtTikYvs+gbEvVYKrErfzEdD7zv0OudJOdF/gctisTwoKFsgfxeEJ7M9LyIBfiuAEZMantCZdkwgg2xbKhbCmh/wESE5MEAZndAuoxZEvd7IDMlimT/nGzzasS6iHg3UufdXBUdwKQEQPjkKCHodDAkS9E+/qZLSMlQ87fconGTEcXRIOF2LEIJF5LBIFJjt3odetqVHbn6x/s9zIK2HYWiT+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66946007)(26005)(4744005)(186003)(66556008)(38100700002)(83380400001)(2906002)(5660300002)(4326008)(6486002)(2616005)(86362001)(6512007)(316002)(6506007)(36756003)(8936002)(8676002)(33656002)(508600001)(6916009)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?puZa/Tpxp4fBGoARpcp9TrpXVuhZq7jDQpbvOovCHUdkvQAkWiFb3xJsnwjU?=
 =?us-ascii?Q?cfRzY1Q6O2MRQ2jjVkt/SVvWeSaHuN9rCbkylVRDPrGjg+434uFLmpEk75qZ?=
 =?us-ascii?Q?g8LIOjMEjgmyJeJU0AxpFFKD/i+VD3o0g5RqMVNj9LEnPJq2DPKqgkuFpIBP?=
 =?us-ascii?Q?ufu8WdxEjibkZiKQQGgiTv/jHy59wocpDFrZBFN8ZvUfS3A+YAgXpMlXfU5k?=
 =?us-ascii?Q?mwmXSRjmDeV1K2MdhboEcKF9+UkE/kiVjf9hLY24LYrH3BgDbB7iB/az/6GU?=
 =?us-ascii?Q?53WdfHH1LIEUfkcN793oaq86z6uu3GZTdbbEZncv7XXh9HzkD0AFny5DSGaM?=
 =?us-ascii?Q?6SH2kNqyEKeDCtH0zM+COdI61tblyMJyb5DpG9jPbxqMN10bdK+QkS2xciq0?=
 =?us-ascii?Q?j3cKXgsuZ2fZj6QOtvVK3BMVmFj6C4pU9G9674NdFmcf143g2xeIPwfVkPkO?=
 =?us-ascii?Q?4/+JWE3fBoqyao5fYpmX9jLiOOlZnHMjJUhQJAB4shirfScSkQTBHRxXewLa?=
 =?us-ascii?Q?OEuthsXhFX0+AQXuVuqbDNeXbSSdDlOQOU0aA8QLA9kN/G6cqh0lCNFCJRXG?=
 =?us-ascii?Q?HQBlZlGuKkTXMjDlTL6Eem/68MYgauU8Q511cayE6vMp60LC7iKJh7jTpPZf?=
 =?us-ascii?Q?zhs5fjV22Su+ZYKfbcDQ36LN3asOqaaA1g9/5gpgOKEAcmoz1BxsbmhgMfyj?=
 =?us-ascii?Q?ZZkCi/7zKv9Dt+PsRI4Qu2x+WjGCu2z7/jkLml4MaR5LWrxW7d0DhSZHQ4qu?=
 =?us-ascii?Q?6Onq46/K3cMjowKcnFiFrOyptVtS0I/ZAPNF85uheZwb8p0gK4H/kZ2znvZ8?=
 =?us-ascii?Q?xPcfK9Z20LYmkVS7q5Xyw8hVbU63ov4W/quYNyyYoxVFqsFRDOyITjPnCmb2?=
 =?us-ascii?Q?9RAM/gzbZc6rwkvE0P+/Lui5cUFQHaIk6Nc3B+D1Hqtdqg13cYc8hI7cGd1t?=
 =?us-ascii?Q?ZhNycq19t0L3fumfSVK8eCjSm4RByJg/jKMP4PEa6N+pwKRQEtOiXL8kdaTP?=
 =?us-ascii?Q?59vF8lYhuqxXLgB3YHhRvJErTyaZlZ8CqUvebJoPPMQSRZ4bxctxKlbgt9HH?=
 =?us-ascii?Q?JnTrhn/4OsX5Oq8u8JSJS2MhBD3kxMdTx+/8wlO3CP47Q7RZFy9wLSk5J83b?=
 =?us-ascii?Q?GVaUZgY0CGnc4zyr7c9jCaKN/bcCU3gmg2FXGH1B2o39lc7raxHoeLw6yc8P?=
 =?us-ascii?Q?Ho+QBMWK93hPpoWU1YsSTlzxYj02p04zfLFqOQhV83yn6UAmQJzP3BURCYRk?=
 =?us-ascii?Q?PfXjSaRrdMmUxeUcOeMBTpIwP1KPOxcaH3Xj8aEuXscxo4fz35uw/AjbwS/J?=
 =?us-ascii?Q?CvCeN1zF6uAXNYIbOAP4sFO3gnz4WYpjqFAvPUoiTS+9B+5h1k0HSZDeW5pt?=
 =?us-ascii?Q?gSfe01lpk633fyksgG1NqHGb588RKiLrgiiMwTuZucrpGbaOLQj+XP6NNUgE?=
 =?us-ascii?Q?U4fndqkbXI/RdwUm+R35uDbY+qonFz0klBQ2DoIBzGszrIr5gqb320s7iR1y?=
 =?us-ascii?Q?+bGQvKl8E1ea3i1hBRSTPQLqs59X1eaZZcqKpaI4WC6jLyt5sjddad95umCc?=
 =?us-ascii?Q?TKIgVADjBib1Si++MAE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2679f600-d0ff-4853-1bdf-08d9d07e7742
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 19:06:23.6632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYaAklyJ0OsLj4Pf+2TfT9Pk7hy7poQWUzzUi1O5PTsFZjJw37NlYZOXFEC1m1UT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5272
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Dec 18, 2021 at 07:23:20PM +0800, Chengguang Xu wrote:
> There is a redundant ']' in the name of opcode IB_OPCODE_RC_SEND_MIDDLE,
> so just fix it.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_opcode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

I added a fixes line

Jason
