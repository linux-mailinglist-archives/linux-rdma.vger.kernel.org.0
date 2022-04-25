Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E7350E776
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Apr 2022 19:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbiDYRq7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Apr 2022 13:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbiDYRq6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Apr 2022 13:46:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37964124D87
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 10:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPTzbZFHX2s3NT3LBbXMl+4nuW4eWM0x/Fl/GiNJxhRg2Et3jWKWx5aeeffTSlulq5lSwJpgdWSZi70Sp6dXT3aZ4JpynGe4HMwWue6FEf7uWcPw0owC9B1CTPYQExj/kwPTcM/bjronLfgctMoBQZeCXFOcColAaxNNdGNWkNAv2+o7vvfzp6Gs8VSlZCyZnSdxCyhfA/qxVG+J7BSPoHwDEn+fZt0MxPNJV2I78t7KzWFYvqa6VtebAV22kfgHbwZfiNeG8ONV9QkNUOPyPKX87LUnDqS5k1mNhTq3QThXQo+bkqpzSkZaKziK84KidzVAO36yjYUK2WGAmeuyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5wK9LTp49MUvygK0Msac1/VdFZVCTc/NceLfTz6j1k=;
 b=bpQYL1Dkn5J0LAoQAR6HijOLw3xNXzbw3cyU4GKI7ayMLVOtN5JLG2a66YyTvR0KxYibzhhCmqLwvQk5nu7BfkRTm/m0ekyLJRr+EZ3+9cNwHA/he/6+l7xxRkAlw4OSSC7d5BNP/Y3orrY6SyQE7H9QVMaAKQbkyyDB6Ztdvpc+EtfJs8wJXPZSp2rr4YEvfGYHUbIV8opiY+v/6QZFe8c8L4i+UiRywyH37eARgfj4Bj12KmCI8EeHi1JmD4PyNIhXYkfc92dchdLmieqE0IuO3ShVnsLJkpMJvkivbUipA0s70gangTcLdeNNsQLb8KLWvGmcu49oQ1KJI1KYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5wK9LTp49MUvygK0Msac1/VdFZVCTc/NceLfTz6j1k=;
 b=fYk4x2x/V4kNvJj7qpRyWZaxoYRKNZDNtVCcAeeW2w7whWChH0RzRRwveqNN4jjrTYg7t6KKTrb1Pj6dQd1FsuUCfbm7pxstkrn7eAW3fH63UNNJLvB9NacpWW85RVjxUg3HMPNLaLIHz74iEXRATI0VlqMF40WcsNWjTHYvmyH+A2nNLRvVlMY73M8XSCf8UegbbNq39t7bDCB3Vl6imYROfEWthXUyfk/6fj22Vm45yngAwwBXjgLXrquG2TmmWlVjXGqAuD5a7QhofYhMTKKgsQtRJOdkeOrTWebUekWBvsJjQQmu7n2Hl+cz/dpPwCsE/pdWMRcVg10t9YEnqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1440.namprd12.prod.outlook.com (2603:10b6:300:13::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Mon, 25 Apr
 2022 17:43:51 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 17:43:51 +0000
Date:   Mon, 25 Apr 2022 14:43:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next 10/12] RDMA/mlx5: Use mlx5_umr_post_send_wait()
 to update MR pas
Message-ID: <20220425174350.GA2224482@nvidia.com>
References: <cover.1649747695.git.leonro@nvidia.com>
 <ed8f2ee6c64804072155d727149abf7105f92536.1649747695.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed8f2ee6c64804072155d727149abf7105f92536.1649747695.git.leonro@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:208:32b::23) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eb34916-d9c1-41df-388a-08da26e32911
X-MS-TrafficTypeDiagnostic: MWHPR12MB1440:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB14406BB3F7B93EE178F908D0C2F89@MWHPR12MB1440.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Way22aNjz2Gj8WoyWFRjrpQ1xPJ4qMtOP3v1uYjj9STmcQzS37hXEyWra6wr/f+3CjMOE+QIXjkv2Wk68pR0S9vQwxyn2gQpDkLV/dE1roCgZFDS0CTIF0vR4S/tffe/GihZKJXXt7S5iyOkApxvkdyWpGCleW1sYaVeoLQqClzstSXkLr3+FuZvqoXV1Mrp08z0dgH4QrmAgmV59iuAi3PeXzP1qYfGm+CZ4xvSQekIN/cSHqupD3YMem/Cun5tWlkDazkjvocRu8Yk3L8N4eY/o+POco+QlkKEYK6QweqVynNEK/Sw6FtkuXRRUmluSxQQv8o4O0mNZpDVLZdq3qpiSm5w8y5Mi3ITc+3oaqkvlRMSjyNvHsUYMBYe7RWQNn8MasWwqn1yPSv6WNsx79ymAvG1xTygQR5EL1UK5YvRBYivAURWl3owj//h14jZf5HOetbIHwswkGYt0VgGB8cmHbxrCCBYnSULKAoif5eiIg146eP/mVI/MypiOCoeHvqRYQT1fLk3r/Kwxb/BldqRYVZeKwlShvnLnOJz6Y7mQTDr/Y4leC3B3wpnbVJ4GrDZLYwLTCo6ztJGClds5ZF2/TcqgCgiwohZra8Q8Uz25CICEuLOO/hNJeVK8e15z0B1t8O+DGlw3qEC5XQOjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66946007)(66556008)(54906003)(33656002)(6916009)(2906002)(38100700002)(6506007)(8676002)(4326008)(6512007)(86362001)(26005)(8936002)(508600001)(5660300002)(186003)(316002)(83380400001)(107886003)(2616005)(1076003)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oYkdZmNnx1pMA2kikTHo7lznC90JPLfYrFLzudsd/2bTKmLQvGf9XKFoz1X8?=
 =?us-ascii?Q?ZM927I5lo6e/Njb6//wj3EUL5FLeBHDmU/5hkxYjO1gPFZCjP7LZH0BMQmZ4?=
 =?us-ascii?Q?tHiACCxEBB7cgPbfWTxnfDlfykFh3N7Lx2rP4lgMG3oSs4sdq/I2ukyLT8kn?=
 =?us-ascii?Q?MYmvLf7aV0/sMvTS4Xx0mk2vUBdcZAuRm6fs6Z+ofq2z3+Y9WnCsVqsHoDHJ?=
 =?us-ascii?Q?BFuSP2NuEDQi2Iz0GaSlr2YRqlvCRXX7hRiHMcr4hEIJuDigWr2MAbjTuyjp?=
 =?us-ascii?Q?IUMKjwi2EeoVS3/R+72f0TA8YMVHPu2U/4YN0f15PY7pLymswURoU1FzXnIR?=
 =?us-ascii?Q?3bPSpLw5iI0X2Nr7CKM5ZllVd3/0uA0d3r2pI6bxBQKKrdBCc4OYnRD68HZc?=
 =?us-ascii?Q?SBeABYBO/ZYph5tF/CXX8zzFZrdZeOLXVBM5x6bl9OmIabYoXoizuYMrvsMX?=
 =?us-ascii?Q?+YmYLXwlio6NRPiyrEW/Dfi6xNtXAJrTBoemQSIphhgYsaCLGl/B5yZk5wc9?=
 =?us-ascii?Q?xs8RQlGTY30Xp8usPoBBxOxPSmiUTGEPEbq4rogIKpouNxX1G2VFVo33YVzB?=
 =?us-ascii?Q?UNJ6QeQctaqgAKNqaZePSuTg2IvdQlwZky1KmzumObuLCFRHvUoZCpnXN1Ph?=
 =?us-ascii?Q?14EVt6bDdp1vhYikUtgOAk6uX29LOw5NaQVWX3RslUjsCGAJP4TkzhbFOdXi?=
 =?us-ascii?Q?v3qfl2+rOYPSJH0KjAl3l+HFyaqokT+kTNNv9tt0jWYqeM2NVwaMwgX3PrBl?=
 =?us-ascii?Q?/iom9r5y83NWYKiGoGNmcKaBj/7zgEVS35MvqDIdONbnXefP0SqdBYrfLoU9?=
 =?us-ascii?Q?J+uJl9onNqM7Tkz5cU1TXFmzQBV9IfFccXRFViPT2eVOo+N55uMO0ur2JuGq?=
 =?us-ascii?Q?mGPekEEVbUllRv3QaVJj3IkXCQjv9VZ4hg9KcQ7IH62JsZmBKLOZ01gIkWom?=
 =?us-ascii?Q?O4Aqlv2PcKjH1z0ldLoO7Wjj6X8QJkobihB8+5POauXmfgokPD1Z4JKcbzBf?=
 =?us-ascii?Q?fFHpfmBclDTGz//MXuhyyiTjfTv3RmrTMJhboCxXgafc2AA94xMTnb5OGNhm?=
 =?us-ascii?Q?p41pqKxA72ti/17esinCvREMPXrkU0qRH+DBy8fAonox0Z5UVQIpzGFsvg3X?=
 =?us-ascii?Q?d1p7pxLvueFbYgcJdbDfKoRjCRFxo1sF51ptlE4YTsACzs2BBkiaagVZ40rb?=
 =?us-ascii?Q?J9mv5N+PTok/eR0gBw4+ZK05HRWk/jixVAikXBVgyi0dMGa6ctIS8JX7C4lh?=
 =?us-ascii?Q?a3QnCG6carJtFlZlyD+fppRiN8TjRY8WJ5erWBU//ufFtp1J6S3zQ9Vp3hId?=
 =?us-ascii?Q?pfL5+G7TprobWLMn6dFlhkqV/v/4rbxY9Kp3i6rpHmgucKS4O54KbKeZHAbm?=
 =?us-ascii?Q?/8AuFVwrb+goTSBfLyVbKxvVenMmfAN64HNUIyKFleHkL1m1mzs1VtvNGR/4?=
 =?us-ascii?Q?XY/ByGTqdKqe9QvPXgtNOsFMwVMi3iMtOCzOaRd/8whkS4CzLOU4oexIUlLR?=
 =?us-ascii?Q?7lfSaeGdT3+jsBkvi5vihCEmi/ZZqvfr7FXHho4VpmC+SRvew0gM5l3YmPrx?=
 =?us-ascii?Q?v7gYIdkDyOpWzjYpe3krAQSt3+G5Nc9FYRlEH7GCgx9MXi/Ett7zCCWk1lSo?=
 =?us-ascii?Q?DhLbRHGBU99j11DsK/zlLKkQDD8fo/60yKS+eqhXRobYe1Qv43KyaurflGZZ?=
 =?us-ascii?Q?cWF0VPT36DoUgaM9kAr3HCpU2RUeDG5omqEJWCCDfq1vROkPBBDbXZA4m7Es?=
 =?us-ascii?Q?nZubU1KMFA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb34916-d9c1-41df-388a-08da26e32911
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 17:43:51.5876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2aNTIo/IXj19fkfO3R3VbC4BaYQDEZDuiOucHgGNwzYod3abNDXgqkApxOd2YMJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1440
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 12, 2022 at 10:24:05AM +0300, Leon Romanovsky wrote:

> +/*
> + * Send the DMA list to the HW for a normal MR using UMR.
> + * Dmabuf MR is handled in a similar way, except that the MLX5_IB_UPD_XLT_ZAP
> + * flag may be used.
> + */
> +int mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags)
> +{

I would prefer to see zap split into its own function, it shouldn't
call rdma_for_each_block at all - the only reason it was structured
this way in the first place was because everything had to be squeezed
into a WR struct.

Then all the places calling

mlx5r_umr_update_xlt(.. MLX5_IB_UPD_XLT_ZAP) 

should call this new function instead as well.

Zapping an ODP or zapping an normal mkey should just be the same
logic.

Also, looking at it, it would be futher nice if the duplication
between mlx5r_umr_update_xlt() and mlx5r_umr_update_mr_pas() could be
removed and perhaps organized into a way to make it logical to
eliminate the mlx5_odp_populate_xlt() "callback"

Which would give four entry points:

'umr fill xlt from sgl' (mlx5r_umr_update_mr_pas)
'umr fill xlt from dma_list' (populate_mtt)
'umr fill klm from xarray' (populate_klm)
'umr fill xlt/klm with zero' (zap)

I'd imagine a general construction to consolidate more stuff into
mlx5r_umr_create_xlt(), probably having it return a struct, including
setting up the initial wqe so the above are slimmer.

Maybe in a followup series though

Jason
