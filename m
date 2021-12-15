Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA17474EEA
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 01:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhLOAMV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Dec 2021 19:12:21 -0500
Received: from mail-bn8nam11on2049.outbound.protection.outlook.com ([40.107.236.49]:7265
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230230AbhLOAMU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Dec 2021 19:12:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXINTtBi6iliShHyx6oU1Lj1fm7+e73JFSxHNwv73ghIXIxG5TZNrv0Aljiw7gYTGB10s/WmunjBYARBP0mgPR9giduxGm4od6pKj+zYavXZ3yY8GQ8LicisiQBwjnRPCAJAcZt8Qic/KsZUEHBnzQVwCUjjXIy3qzvdtnvBTGaixNIHnh6kJM89CRupdHpZNR5pCYxGWxg7mKmyAfuCuwRek3TqodazyfFlnLBu3Iw5rBDFyGL8zMyulCMuGK6NJ9OkXLex2M1veuKzHXK9DldipoJorvdNHa+nrBxkkyd7PYHezi/p8cU3AqStzyY+pE9iT4/rp48M/jcMCw6mPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7ZAZzLzh6g8ldUztUxYNiq38pteKc5aZPCCWIkAJRw=;
 b=DOpLnbLTc7PqDTrN/mqsiJbHiojMxDn1X+0yYbETMKoH1ZTKQDvku6qIpB78DHdg1300QCyqisvwyaKlZEVAR5xfCC34hmxZBr1ZkaVxydNrxzSCoTmWDpgaE5wTRDtC4iB3EEDyYYfUVEoBxI6aM3AhSCPBKXs33dqzHkDRzYXir05w5KAt2DbhNR6dnsWuLtXxlm36SZVdVg50Gp3OeWw531Qnx9S4qRBpilLbePLxQol6dilTTnfQ+Y+DdYZuO6JR/ATaBEkBtgfRAggsLvLlJYQxjuhDTcXZ4LLknVP03E4+wcQ5Oxt5zZ8Ywr014tm96m/9qGEqNWqZeKVAhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7ZAZzLzh6g8ldUztUxYNiq38pteKc5aZPCCWIkAJRw=;
 b=ioCTkCQLpVXCjr6dktrx546GWYcFx/KKr8DFb+HTmHwjjgCI3L970PIJCqh0EO6KqPsiIfzSZZPhpSym8QKQz5WikIgPoQBmRvyahE1OjVX/lcJdCUQwhT0DOLhgJvw8CkGToFTxlv7D1git+Gme99DNVqHzHI11OAi/sfJS9i6NPCyUhSAuu4fAMxdR26cTQY1zHsfn6v+uz+PeBhqPkMklOXIRUVxjChvb2MDWjQ96S9tk1yCOPdmhiqNL0VjrxP2X85zTDGH6RMpoepu8MdbXsiARrD+srsZS4saZ4lLSjiJZmloG7LFvM9mQHdiWOs1z7y6IjDwwI6HvM8YQrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.15; Wed, 15 Dec 2021 00:12:19 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::218e:ede8:15a4:f00d]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::218e:ede8:15a4:f00d%4]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 00:12:19 +0000
Date:   Tue, 14 Dec 2021 20:12:17 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: Re: [PATCH rdma-next v1 0/3] Skip holes in GID table
Message-ID: <20211215001217.GA994561@nvidia.com>
References: <cover.1639055490.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1639055490.git.leonro@nvidia.com>
X-ClientProxiedBy: BYAPR02CA0042.namprd02.prod.outlook.com
 (2603:10b6:a03:54::19) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2786d654-d30e-4d62-6a6c-08d9bf5f8ef7
X-MS-TrafficTypeDiagnostic: DM4PR12MB5374:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB53741E1C8799D807085EFF71C2769@DM4PR12MB5374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YMdomVsKbroOHYpnQd8HiouxNtk1/zHIT8eEJpt9mzG9/FJwRA6CMvRQf0WSrzwmZ3NBHch+YKVbLzxEWMdN86giCna9D5o7VBDxWmgPBryiliqwRX/fgbzV1c7Snud0AtTLpOIHrpUi4VhsiyM6kMKD6I+L72C+jZbAOBrD9NIlC7Vr8niXPZYd9gEaqME/DQcXpHyPgl9FeIKPauz7lDwSeA1mn3m4k+pTn+lWJS69eObbHFrh+ieGo4YSx6jejXal88YFnuyXDJ32gunhtcBdkkSFF3z7faL2wXZhmsDkvxW67qIhiEcopiZ5y31TrCKBQbnhVqc+uTzyiNC4EuKde2Lqni/Iq+uWHqfX6nKYDXKF/h6/4RbwKVcDwOxAqYxJvcmW2RwCv1a1bKyusYHN0U+ZldpXOGydaPD6QH1AT4G6CYaKBQiw440njYiAiO3DIxMrZ1IkkmUq26kTw5/AXRnGRXx6NgNNROdqTjSOrDfZF3bTEd3QMBLIQ/KNIUPAA41QY2YrMJZ7aV1CQLGRIAwaxeleV9P5KebnWBY2Dc+7WL0s0/4HEXOipG7Fvp/6pka5O7KuMok7cnMZHSEs7YvvOgyJWawjdr2bEYgDHuUOBFPgJzC58SXr0lzAWrpbyp0koS9+XIP2qDD+q91yt5QfuES8eA9CoTjwr827XI5yOE/JXxR6TprOmgVcjoLCe6ai0K4DWmQm8NuYrGMkQLTICsVr7ApqNpf2VIBh5MmQrle6pbLO+qjLRwIxqHymvaQZqgUpBL//X3iP8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(316002)(6512007)(66556008)(66946007)(8676002)(2616005)(8936002)(6486002)(38100700002)(4326008)(4744005)(86362001)(33656002)(54906003)(966005)(66476007)(6506007)(36756003)(6916009)(508600001)(1076003)(26005)(107886003)(186003)(5660300002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G7NPgwSSkdB6IZv0f4IAQf13Gu16vJmzJqtSF8fiLtag3o0xyz7iAauLetqW?=
 =?us-ascii?Q?LZERKJi+icNGIWVp/9PQb9u91fa6TJKu8S6uK2o0n1Z75z+Wf2j3e+uxTR0g?=
 =?us-ascii?Q?rvI131Wfl3nj+WuI+UTGyJ+dTwksaIQMMNvK2LLQ98713rzbIBctlMtNIt8l?=
 =?us-ascii?Q?MyNNu4T2H/wge9qS00nJ1wH2mDvJI1DeRMOdy2UGN1DqncsiBS4rRl3HP77S?=
 =?us-ascii?Q?F2D6KO31acEGt2Tc3OZURmvaN9g5PHC4HiP4J+ALBXu8mxj8YBfqyu4+oFFj?=
 =?us-ascii?Q?j8vB2WBjuiVaZxg9Y2I2w6QDjjXBTDfcSX0QhpoolQyxXg76R7l4a3dZ9obI?=
 =?us-ascii?Q?hwQk57jQ4ES3U4g4WnSJiRLcCH2mLbbBXqyM3AIFZRFYKsPDbme/wKO98G5W?=
 =?us-ascii?Q?obby/ai9m7SqRZMry3dD7Yvpno9HCGdiISj8vI/gBC5FT8MehUYwEr+dNSQu?=
 =?us-ascii?Q?Kuj5FIkxyFjH90jz1zyGRzMmBGtJFVzGegpzLLyhqQdnlXe90KKVI1WfIfYo?=
 =?us-ascii?Q?9Yn8h5B/BF38/qzaBj8W0ACB4RV1q8fHQ4J/ioXsGtG6y4++F1BpfD1R6xKG?=
 =?us-ascii?Q?wmZ9Z/pyOZm1BJpJEYsUeHD6Dql7LijFeWlyD8HTo9UC2GjBPJfdoYCQ+jUV?=
 =?us-ascii?Q?Rm6/U2g8ALsw0P5hZsXcmUJBBuPu5GG7/NZ4AX6QDD6pv0pceR+CsNq6gHDS?=
 =?us-ascii?Q?zXbXkcm3nCfKNjZgwvliNQHhr0xhSiWa+58qricuAroPlcCUar9sqyC61Cko?=
 =?us-ascii?Q?ElXN8LJg72+bFbpdi95jN6GAe+UU/lep6mFogwsNDMAwZ6tznxMnu6CVGiqe?=
 =?us-ascii?Q?RkFYRlbljloXeuVUL7Be81DYDFKIT2/+ZR1rbr0Gg23I4wL/OLZgFBKAxgwP?=
 =?us-ascii?Q?dY3IrZIOpaMLMkisoNvBuD3SWma8FfunhNZAvStg2M482clHt2he5YcvcHfV?=
 =?us-ascii?Q?uuKCcR2gNXYVociUKfmpINBju1EXTK1P7ReDULO88tGLlJwV0VnWkPAaMhdf?=
 =?us-ascii?Q?1gqRxy8GWqR/ZTpU2zV5MK422fgI5lgzuD6/7q0ODzQhLltfBjMpKMTsazOh?=
 =?us-ascii?Q?XGb6yUlyAu7cfQokPFnHxpOA1aiK+yYM/J7cYgS20m4iypNw7vlrJHoyh6fy?=
 =?us-ascii?Q?SlW9rcPEy7rP6+PQR8HQjoabWJd9eh2IXxlGfuCdzHJaLRD6gI7RJ0p1ry/0?=
 =?us-ascii?Q?/PCt0YC/lqUBQS3az+aQ8uN5IApaKVtGw425ikmJ+CJEqtr8Tqaa7EBuvPP2?=
 =?us-ascii?Q?DEta8gbFhEptFS9OSXSaVEV2n0pCfIWCjgVcwyaFG64aJogAQy8cTUaceWJ7?=
 =?us-ascii?Q?BH3259ODAcG6laXf7iAvp9doCdI7ylH3Zlta9BCoqMfU4PQMWcl6J6LDVqwb?=
 =?us-ascii?Q?KDQ6pmyhs5zj90QBq1WOMruiiJxkVL+FZtOdzO+bFWHECtK1tiRtecTpxYqa?=
 =?us-ascii?Q?v6nOPGgcoihAq4rj36qA20lJO6xyz0ixScLb1POlVasmPZzxOZvyxbZQeoyE?=
 =?us-ascii?Q?CrQiXuwXrHOdw8es4vs8KgwPzYayDL3I1tZwVEvfmIN9TL+akYCV0/N3b6cZ?=
 =?us-ascii?Q?j89zxwfoWe84IB5kBGY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2786d654-d30e-4d62-6a6c-08d9bf5f8ef7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 00:12:19.2263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyJJ6CYQe0rsbdIOtMijR8DMMUo0s6zAliK2pj9rlbwD2NoCSUe1+DOoUglWeaht
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5374
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 09, 2021 at 03:16:04PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Changelog:
> v1:
>  * Removed variable assignment in rdma_query_gid
>  * Changed special error code handling of return value from
>    rdma_query_gid to continue search.
> v0: https://lore.kernel.org/all/cover.1637581778.git.leonro@nvidia.com
> 
> ---------------------------------------------------------------------
> 
> Hi,
> 
> This short series extends rdma_query_gid() callers to skip holes
> in GID tables.
> 
> Thanks
> 
> Avihai Horon (3):
>   RDMA/core: Modify rdma_query_gid() to return accurate error codes
>   RDMA/core: Let ib_find_gid() continue search even after empty entry
>   RDMA/cma: Let cma_resolve_ib_dev() continue search even after empty
>     entry

Applied to for-next, thanks

Jason
