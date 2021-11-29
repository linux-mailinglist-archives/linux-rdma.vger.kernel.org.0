Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AA1461EF0
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Nov 2021 19:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379752AbhK2Sl5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Nov 2021 13:41:57 -0500
Received: from mail-bn8nam11on2088.outbound.protection.outlook.com ([40.107.236.88]:18336
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1379360AbhK2Sj4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Nov 2021 13:39:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ox1orA81V1Z7mWyMl7t1VRqG7HOJ/EIg2g1oIoQQTZpCFjcbzd5Ggb5GzT7RAOkH+8oeTQhoLf+53fZvcaoF294EcjE/zUeR+GBAIGAFLG8iIsXH7daOdS9tf6vYVYzHjZAWj9bYefbNcNhWkZNHBYN5qAzU4bvE6Avq1spbeO+sGPLu6okwY8+PstVmRm71plvwKOiKhKRaRsHoxzEKhcLNsZfoiwECB1xxAf1EJgEECz/RPxaLFTUQSBYBoCWFRbYFM+IuP2Kcnzt7N4v+eqbdAkI3ZOtE1sWm9wZNbLejbqpTF7rejT7qj2AY2m7oWo5JDmSzFhR3HD2cJyyRMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHYPza2eWx8chJIr1p2CHJDhnpBccagRoxHRAEovpO4=;
 b=ZCwK/3WAWJ4tUT8Xb6Do8axbBv40miCr8SSaQCblsODLnV43N6XmbqPGVdjN9vN88l0wPP5ebIQOLUd8BM43qe1oGGeyEDYN0X2/9JDaR0uQdqFKemZ07s8C7XjohqvRYd0fr9oPTUSs1OdSIvjHVZO8I2fLwBBFS1BwFOiGl7Axj0VEY4k1/of7Cuy8siOYRYJ81DDeC0VyKMGgOojh/7fDmQsKGFqT5AH1tbh4CEeeoybVl5lIaIJNs3J/bAd1iKuuRvAvpJ+0cNJfvb1QvVh6QbGrUDA2AYPQnguHq60hn+tiKtsb8JgW1nfCZH2er7XLymFrF0aH9QjOJ7f6xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHYPza2eWx8chJIr1p2CHJDhnpBccagRoxHRAEovpO4=;
 b=gQBWTpr8nPE3aJ7ZYXJZ4IpBoQ+VZTR3FoATBv6ITacqKK4sVx9ngxcqnjPVCFUjeK80UcB5hwjRmQx76+567MwTwx/3IlTfL147X9WPlcwR2wGELmpuwbOBCsIVEKE7fNKkk51+ZwsHmVk5s2F3Ckf0vyqZszTiWtwtXl3+wbbb9wyErB26Ev+MqThEJzEqyjISCoK/ue9a5KL43qO+0ujSE/J/vX3ulWVO8J+EON1G+SWIhnzLR0uyDQhkA348/4t8Jua+zRGnLc3iylUtsViTLR4yzixqpjMnzcLv564I4Ht/SeM9tyyXgJLNDeR2/ubjxXHYpiZiXblvi9RVvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5109.namprd12.prod.outlook.com (2603:10b6:208:309::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Mon, 29 Nov
 2021 18:36:37 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 18:36:37 +0000
Date:   Mon, 29 Nov 2021 14:36:35 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     yishaih@nvidia.com, selvin.xavier@broadcom.com,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx4: Use bitmap_alloc() when applicable
Message-ID: <20211129183635.GB1065466@nvidia.com>
References: <4c93b4e02f5d784ddfd3efd4af9e673b9117d641.1637869328.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c93b4e02f5d784ddfd3efd4af9e673b9117d641.1637869328.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: BL1PR13CA0275.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::10) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0275.namprd13.prod.outlook.com (2603:10b6:208:2bc::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.7 via Frontend Transport; Mon, 29 Nov 2021 18:36:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mrlVz-004TCJ-TO; Mon, 29 Nov 2021 14:36:35 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 099019c3-4519-4df5-50fd-08d9b3672d03
X-MS-TrafficTypeDiagnostic: BL1PR12MB5109:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51097C6CD26B4B651C859745C2669@BL1PR12MB5109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFZOsi9Zk8adqcXNR3afpCsQFqLZ5g+QHEVh9SukayzVVexXkBEyTriZwGWnVBFCO5tV+yzI5ypmjvGHCvMAzUwrMBo7KPMDYv/MNzSH9Lpxv2wCEzBU3ZlPy3Vweiue+1bp2ZuF5N8y8Mz1bRHS+TnOYqT2rNDU5+1rYfGxIiYTKtcXTJIU+pdVybEmQH55xyL8AZMhXrVHPdXcN5gk+0XOopQJxx+w9o2LprToR6Avw8WGyIzMvJ8rk9ERQJoqH78ZsVkz05ir0rx4rMPngi8PpJO/uBHCUR+vD+d/jZVZf03xA0FY59PujvCC6jsoJBlOve997U3AjNbp1RO0TW/qaGZspe0NgiPFbcsyLAiKZ7T1SCnnhJheonbVEkmQndwELfFrfoZPZ64eWTX0Wg2MLVcnMtDY/uFjnD7HAYIwD0qmI/8t9Dvgevzw0ihS9kCElEQROK1o8WECUYuGyQLJXX03odQ9b6hHTbMWil28tQGsR6orAHNNdWLo+3uE7bPfjm5By7gIZ+8PStGFfaxI50xMnJxNYVTmabrIkJp5ySytzqDIBNgHKESylcmQNQmhVx/yWXTJkFZ2FpD8b8+ospC1MjL99SF4ZYv64Hfhgw14kd8zTIlJeymLzDAR6LJ7T0428Ad1rLSswDb7Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(66476007)(66556008)(5660300002)(8936002)(4326008)(316002)(66946007)(9746002)(4744005)(6916009)(36756003)(26005)(86362001)(426003)(1076003)(9786002)(508600001)(83380400001)(8676002)(2616005)(38100700002)(2906002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4s5OICAxSrCv2ni0BI3hNDRZV6OdCVhtpJOC2yjTET15mO8AswFmeAF9yC9K?=
 =?us-ascii?Q?72TflQwQwyGbWXVXDMwz/jwdEZPr+gCg2a9+mOVD2s3MorXvC0CxAZT7LIbM?=
 =?us-ascii?Q?Opu2LoHpdDt7H1zSluWQYHLqAs5+fxVY9MuSa++xnd3XVrmurZOV4N8Hq8zW?=
 =?us-ascii?Q?yf638RwGITHe6Aqb0961m9VQX/ja1Zaa65GZvQzuiHirDKYfIMtMHxYVpNgm?=
 =?us-ascii?Q?4xKmb0T+uNQNkGC7Q6skuSnnR3w2E76S4t/wN6kd3rE3G3XA3PritZcTu8h5?=
 =?us-ascii?Q?ndC+MRbyP1jQZDubfPMJ/mgi8lDxLCJTWHJkH039CTftg7ItlPvWGquiFerz?=
 =?us-ascii?Q?P4J1W4nMSnnUm0pGhqooy6MF2EbcXcYmT/m001GZPkCzt7xzEoRbifE0RTv4?=
 =?us-ascii?Q?v9wNEpc2z8CNkAlDbTCwUDJb6J7oVcriKQMz8kGbp5VwwtDzVByE322iqC6o?=
 =?us-ascii?Q?wWvLzJc9x3ZrwRQ32Z15Os7f/YrF7ncQzQFidFfGXa5tmvYU4FRHdPgEw6pV?=
 =?us-ascii?Q?iJj6LoE+yoNYEpfSdE8sZTBXBzHQdxJtMCSTzzIm6BqIrT3MnCdwfmEvjZI4?=
 =?us-ascii?Q?iLTDRBsJHX4h/79Kr0v3jcPuoSCsmZk1f7R5O7pATYvhPEoesAp97X3DFJvl?=
 =?us-ascii?Q?IiBrC2LPj9fWCYszyLXcApvJXMuAoMfwsgCC1fDqBamBexVm1CXoV5dhu0Hz?=
 =?us-ascii?Q?uNYS51qSEJmBcdHPkGEsUtKhQeT7s+AUN0gR+YrkHhkJNBrUvvQw4uXkNhXy?=
 =?us-ascii?Q?U4GY7J27LYSjPhALy1o27El5uhbpvlVk2+HTzFZ6z+UfGPBstyHToqUsmmkk?=
 =?us-ascii?Q?DrPSGG/T9/8NfeWCPUJ7FXOq1rAQcsz75cLuu302jOgjOa1uBlRcxwxOrluD?=
 =?us-ascii?Q?a+l4Uo93MUacmSF8xhw8qC4/kcK8yJz292Kj/m0CzcK5KWIkuS30/vvZi1l2?=
 =?us-ascii?Q?l3BAT9hMg+2BqWmIq/895WM9o7pmCZ/hYpizCn/LmPV1ZxniCOyQlsHkwCX3?=
 =?us-ascii?Q?/HXGP0P+h7CMZ1EMbOb0m1AmK5OWDcu35p+PFl7mUtgS0xm0IIl8CU5a4IoX?=
 =?us-ascii?Q?vW5CN9SrAzVR5NgSwSXpzsYAnc5AgrW2AuvR9YFm7EUe1QrMnWk3HTI0usxO?=
 =?us-ascii?Q?Y1y1YL3EXVwH4d8pp7t7bh5xhtjP7viP9Ky2A0b17mckW+9+6QvUDTkKQvwb?=
 =?us-ascii?Q?9zRevXriwB2+x+YqZt6V29UuqAbU4lIfNDE//zER6icuJzwX4O8yn/qwmZsp?=
 =?us-ascii?Q?by0+NDR5WLjFsAX9Q+FhNiPonElll13r/hAjMkGyBTkwMRDsL/sncrxmo8Vw?=
 =?us-ascii?Q?NPnDEsMZ+Q/qiR3nSxjdOLVt3LM60LMXzNs0TRtrnD8/GYWeaWf5znbjcvyt?=
 =?us-ascii?Q?Ms9MFJIkAHZq+TygSLMB2bch9yzR9E4hUqcDvQp/P9eabHcf1r42Xf6Xv+3Z?=
 =?us-ascii?Q?6CxlAao51vLzgTNJJbWOS/NBQGL1eZkQLjiAUVcSJPV+ViN8hVvQLbWhjJgP?=
 =?us-ascii?Q?IQh94e4jx+dF2hka5IKoFTnvvFZBDe2Ch9kCC3Sx+xSDszHt1ImBvh7rKKmT?=
 =?us-ascii?Q?LEQkGR4Esy1APbgmo5M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099019c3-4519-4df5-50fd-08d9b3672d03
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 18:36:37.0151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5brNNmaXwC9s5AkjZX06I9qfli1oyzClDReWjH6XBXkkkVz+TLGtPcRE9SLf5s8k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5109
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 25, 2021 at 08:42:51PM +0100, Christophe JAILLET wrote:
> Use 'bitmap_alloc()' to simplify code, improve the semantic and avoid some
> open-coded arithmetic in allocator arguments.
> 
> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
> consistency.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/hw/mlx4/main.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Applied to for-next, thanks

Jason
