Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B651134AD49
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Mar 2021 18:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCZR0M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Mar 2021 13:26:12 -0400
Received: from mail-bn8nam11on2070.outbound.protection.outlook.com ([40.107.236.70]:57633
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230142AbhCZRZt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 26 Mar 2021 13:25:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bThrbR0pp2veZOeLA/H/h83Q6hao70SIAIjKxalL0nZLIO4npMWus4dl9WvXEaezxU1t1yOOwNZTK0AhqzJvhNAIomNhLe9mVJB31H/JaP8amF7nYOxh3iqr2+Ea27+d4vDnnyepKLHEu6p3yUXI8WjsYsj7BQDL5RedioO3nBdKwvMpcbwOZx4Hc8cYJoBQXezWo/FMoWcAEbeY06lxcIRyQRrMkO4nr0jiEgbHU4T3vnjl9g58dUGHm1tSNlDI3qbn3M09nf/L4n8/6yBgzrxr5BgNXiUi4OgbOCfaFDj1ijM6FIsDGJemx4rH4w+xQEphEl60/zXizwKOb7fMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrkmA089Kft3jXb1stJ43nfMVKSDjhh18Y9141VLC54=;
 b=jppkd/K+h3S1mcQrmJM5BxjwjJthOIj6wwclDVWieB5ErGpmAZdHDcfRNd0K6Q/yryjIjKj2+y5bjQKN6B+OJN7EH8c/pXYJzxHx6ga3AoiRAhBAv0PVqO0OeHQp/NgXSMy/JPA+5UFxpPddGthgzEWlGon4zjMal2cEmINpuo7Z1G03vyT0vc+JakaAVgInYYYQtZiKjzfc9u6AWwQB/dhC1TYK+vabFi4z6ri9bFyR7iAAj9A4J9O5ZuU1R2wvHV4Vp9w3dKbecXTMMnnJWMzNr9SrCXEY5OSJKPRTJpbuFcj8BFUAooSP6H/Lqb2K3fxOX2qZss/QI/b3b1c+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrkmA089Kft3jXb1stJ43nfMVKSDjhh18Y9141VLC54=;
 b=Bqf9sKgoPVnVqEsB7soyRoLhIySsAOLZIQU+UvqXL+NYCt60KQA2UB+FY2aT6BptNxpTu9z0vHFLOh3AsX2YWCJ3PLVv+7CrN6h3zaKh34HcyUUpSxT0T9TdXVY74BHhfhoOgr3BQWMtJIzPZXd77Zd4r7N1P0Urjknjd+1phpIph3AB8CQEWHKEOZC35LuZeQ7y3zv62Hv9XurQoNMwKf9jfInyLbVFegnzFyj4z05u7+Zez+smbEN7I2v3doMVdmMOAeSJTmDlvy2963gJsMfviJKV3fGeSU7bSRFfsWorsgFJv+VQC/OcYb15tbC4P7YSWAXF7iVzCt35XlakkA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Fri, 26 Mar
 2021 17:25:47 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 17:25:47 +0000
Date:   Fri, 26 Mar 2021 14:25:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] RDMA: Fix a typo
Message-ID: <20210326172545.GA874948@nvidia.com>
References: <20210322064322.3933985-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322064322.3933985-1-unixbhaskar@gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR20CA0047.namprd20.prod.outlook.com
 (2603:10b6:208:235::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR20CA0047.namprd20.prod.outlook.com (2603:10b6:208:235::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Fri, 26 Mar 2021 17:25:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPqDR-003fcm-NN; Fri, 26 Mar 2021 14:25:45 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20b69129-30ba-42fe-cc37-08d8f07c317f
X-MS-TrafficTypeDiagnostic: DM5PR12MB2582:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2582D2E00E339930DD13286CC2619@DM5PR12MB2582.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4e+AhluVYXBOSzQMBqo3wuGaWteks33XMPApB60O/pb2TxEHCBh4/TT0npmypBekPzVSES2/3zqT3muh8NjKaV+wBxhKQuBaaG0Odyunwxn3S0nHX0zkIavZEdVDYv6e1Nr57HeejZGg4SpjJuseGxpII7ZuWQ9Wju82ndYVvhXdenZkeKKJX0Clxn3xgHrOPp3bFKYl8dmx49/DlLm5hCiqYQMZPI/8h4Fs065Lh7C9qfeGdM8FlCy9rFleYRhl4ZyjGUm3zgYodqZZpB0b/GaWZNULxIhRLzEDONLRIN31gn9AeM/uJ8NT9x6+/821BtEmiR5g8eoIPHP0JsnX+KE/+NbLN4HF0il/HIo7huy+CsFOjnJcJ9FLLLfkONJsLGiggYCsgdkFjTAfxgvB9pSDzmQvb62/SgivclBlOwcfIcCdmh9vwCaz7PVSGmptNrV/EAiuTLJnzlvE8zTUh+ohJBDIy/e/yP7qMM/0Gts7cGchSnMpdmEwAn6YMg29gdzqW+Pp1ZNbhg2IwSK1G8YlikbwueR+55MyoptNWZzxgTjld0Cry3bm4BaMyus6nXKp/nsSQPsgkjadxl8e5NzvojmR4xDNeBnE7yvsSmFO9na1E5CFIT7JRkBiqPQaWu5BHBhZmlz9wHYdc4ssS7pb7a3Anc9JaZ/xa5D5wAJrCUs40+NPHK9A9+nRjN9e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(83380400001)(4744005)(38100700001)(33656002)(66946007)(66556008)(2906002)(66476007)(186003)(86362001)(9746002)(9786002)(26005)(5660300002)(8676002)(6916009)(1076003)(4326008)(2616005)(36756003)(478600001)(426003)(8936002)(316002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tsAGOPzVnjlxXDaew2C97SMnzPO7LrkniGZbuIFtSQTyLdAzEjm+WhhizTVl?=
 =?us-ascii?Q?PGupdpB/C1Nevs6EFkj2ccF8GIel8H78TuqsjDlFmDDqL2UonTRsT2QaFH6B?=
 =?us-ascii?Q?crKb77LtsLJ0NifirIntGfmrt4QPotdrkzvgOftKcU4F0DE4cTGrCIRouhbG?=
 =?us-ascii?Q?uWSSbYXLPXcv4ybqgYK+Y/lsgB7ah9vqUbHmBd+tqhG2Zz63ojp/I17mIjKk?=
 =?us-ascii?Q?VBW9Bvha29RmuYwxxBxjDC0qakmbPwb1d8U2MaJqLK6SwJ7f7gsd0lhsiRZM?=
 =?us-ascii?Q?p+tHsYmvEQx7VXCoZddZZrzR1s59z0St88zb7PhIdAzeGxltVpjQOaxx2feR?=
 =?us-ascii?Q?ZFKC5ASYsrzUYPI5rXaRE+2G8SNkZKgla//o6MYlLAqBha/sJ+erdctm5AlU?=
 =?us-ascii?Q?OfB3mThP2vUJ7Mt+QTETDG+Leon5Z+DmunZY7ZaNPtIrJi1Lm5mLgxyf2gSv?=
 =?us-ascii?Q?mPsmT3mvT07WpLOatWpllYCKKbfZs+3eEiXHjXr4zBwt9bVNqC/7T1odFNk9?=
 =?us-ascii?Q?KvYjg2gQBj9Roo2EUzCMrM2l12UHsVJaeiCzG4NT8t7TCNsdCM8OzfIYpQ/V?=
 =?us-ascii?Q?q+PGgNuj8G7YFVBZcsq4T0DtohvOdZQ45C/Ub/jrDkL0kWjOz8weQSTU41r4?=
 =?us-ascii?Q?5tpDEdqqOjKbkRhTJ82EmTkaBrVmMF1xJp06GuAzwnkWymu/zX+NE2zM99YL?=
 =?us-ascii?Q?PITTP9wZwEC8ZTTxujRUfPXcK05SnYpK0lUcwbYLv0xNvi68uVE7MkjPHZlw?=
 =?us-ascii?Q?YCHLtjV3O6UQSgioqBtwLfy2fTTbixgM0aogsX3sQDIrYaLxomcVtJxINddm?=
 =?us-ascii?Q?ZiJ25NwXx7HqTbsUisUdMfpKzcw75T4TBWorFM9Zu8k5f3zLuO9/1VJ48Bcs?=
 =?us-ascii?Q?PsXdjDmXVS7+m4v3GvyRhmW8CF3h/Ga0pClHVAwzk/YT/NFBKSyU3cbQBL4+?=
 =?us-ascii?Q?tKSbIOpg4oX7S1FIC6lcYcrLoKvuAY1sIDzXmiL/fGuaaxGktEw4fBLmh3iV?=
 =?us-ascii?Q?JdtNznqMueBxQVHVkg3wtaECv/y0RHO+FltdN/mk9fmw1Zvo6gT7aIKvisXB?=
 =?us-ascii?Q?bZQuW9e3aDfuJTCvfXvBjPqyD77mR5rxnu6RTaS4NmaUizs3PUg46qOy09uG?=
 =?us-ascii?Q?8m2Ri47QLl63d2VOmInIYM9CSCCq657JKN48cDh3OmgmYJNoy6dPBad0bW2/?=
 =?us-ascii?Q?NcDIgulZmdkS38JhdudwexAnCnO+E1eilZGdmFHChC6e3DgGHlloej6n/MFt?=
 =?us-ascii?Q?0Pc7rxt0C18VGVXKriJSur+CqPz0i/KIjaYjgiZ7YL/TqWyYDfynmWFST9AJ?=
 =?us-ascii?Q?JoRGk1otB8xGqAWS/d06YtXWjn5gOuDYaEsxcqPouDTi2A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b69129-30ba-42fe-cc37-08d8f07c317f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 17:25:47.1754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G75XcShqsEHzdqHN7rB4+H77jvfWul+tbnzP7W+D8lH7GXWfKm9YsE9ernuGupwl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2582
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 22, 2021 at 12:13:22PM +0530, Bhaskar Chowdhury wrote:
> s/struture/structure/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  include/rdma/rdma_vt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
