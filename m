Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57610440048
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Oct 2021 18:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhJ2Q3f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Oct 2021 12:29:35 -0400
Received: from mail-mw2nam08on2082.outbound.protection.outlook.com ([40.107.101.82]:65377
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229623AbhJ2Q3f (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 29 Oct 2021 12:29:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ysz7vbo9xslcnqfSfagt3jd62BznjZHSe7znLqDh449k9aYS9jMeP+4Al5XA3iZNNSQsrPq+NeZ74YIFnVwLAlzcSr/jlUVy83y3bPNfoU4NeyL1a2H2VpS0zyOTYSbAemqkPL5MtkYNiXyQ6pEm4hA5I50Nga1rHj2NbPwkAEUxmjAU+5COH/3pi+4J7d1PRxeldAofpadw8Tqy8ti1b2rm/aME4BbT5t3saasyrG9ApNT5nJpt7TJuPUYIjQTwktuOpA5XmCW75Lt5V59wm+9BJrANfmuRyfSGoP6fxDAbnFiVq3VxcNEM8XT671O1ceCaytJbQeMnDYWPTFI4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxOa9rREYTNbbaygyQsy7J3tSm6upVnuIKI8K/ZvYHo=;
 b=AzMZb1Q5oaTdedvT8av1sHl5qH5tMOa0m1KcvhbAWyxRxtTGa0UkYnx+ebSyko+zQrDY1uNUZK5mHNUIsOVbDHKtO2bcUZw2sAw432MhRGlMxhvuuJ1jXTKUZTRH7yKG2P7CANbqCzTafgawEcLJZirO8SKOyFKMWdP1hnTruuafIC+EhnjMbTgwbITXmiN1Qc8aRqTSRbtkifzHQMsBrGmsLSP69xIRlPDInLyFK4mXbmRdsjHr1Z30qr9Q4JwCZluubtpVV16Tj99Mzv+avSOfAaw4aV4pJurF/VTkAJiQ8lwnCanJFhD0hQNsKbmLr5ViS+6M7zTYyI6sIvczKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxOa9rREYTNbbaygyQsy7J3tSm6upVnuIKI8K/ZvYHo=;
 b=GBNGUuhBplnz4ET/rOw6vMZpTZC14EQNL9AtjTpkNc2MEm2QMg5ASpUJWhRZCeTpl1wW6UWThuSbJsYjoGvxuH2JC7yXVGgqw67BjsZrdRkNnzGEngaNDiw19RnyjRbvCrrCIvG4nvS6sBPgRSwHPQKBM4zjtfJOFmOEP5iwvx0E5tyZCupWHtr8xVOKxZ9bqSiRxV8XoL0SkceaHDrnEjYiwM7WIIebCyo2u54HtftQfySMeWcd5Au6rHi8s6yui2Q1yAHoy/QsCc7YjpkR8du8+p8y9i27xTLJz+/EvmEybr23QLCDSSNQ2mj1HHD/RXfWdYrMyZOgH+uCWXd7Lg==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5537.namprd12.prod.outlook.com (2603:10b6:208:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 16:27:03 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 16:27:03 +0000
Date:   Fri, 29 Oct 2021 13:27:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Aharon Landau <aharonl@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/core: Rely on vendors to set right IOVA
Message-ID: <20211029162702.GA846504@nvidia.com>
References: <4b0a31bbc372842613286a10d7a8cbb0ee6069c7.1635400472.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b0a31bbc372842613286a10d7a8cbb0ee6069c7.1635400472.git.leonro@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:208:2be::30) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0205.namprd13.prod.outlook.com (2603:10b6:208:2be::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend Transport; Fri, 29 Oct 2021 16:27:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mgUic-003YEv-3S; Fri, 29 Oct 2021 13:27:02 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbfdcaa5-cd26-46d9-a645-08d99af8f0b4
X-MS-TrafficTypeDiagnostic: BL0PR12MB5537:
X-Microsoft-Antispam-PRVS: <BL0PR12MB553730114112C947DD152B8DC2879@BL0PR12MB5537.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IuFqHezOM2HN7ye282v+VPQmk4iHg28v7rR1GvvKOIWiryhUfi5hD0NRXEGzWow040Gl7SbMcQ0sXrYtE1teWz4MHUJ6VG9OfyZJYYurRHw8s7rLV9Xe7h1c1rwCLpvvYdFZ5RHZDqzsoXShFPb79eDq/5gQeM/jQijBbuylzyXRrX2I2uJzjHHylbSWRMToY0an+G26hygjwIChCNYjdgGxjOtS2a/UQr7x/WWKjpm7mEG4Obaka/f1DxCFiWi9XEygidYn06UGMFIUX9/w4lgucnL1TCHEYP/sbAW3OUVF/Fl/zq8HEzjvETN7wMJ6kL+9In2EPLJBsWzOKAZ0+XjK6eBVgVFjdgAHNKToY3odgRj8t/rDxMO0IhsEMmZdNN48CO1G71sBdzkx/t4dC8jjoxso/F44eCEGW/ZRXGpto8JLe9jug0oPCoWiipV4Aa06dXM5zID1Si083KVJfuMhrw3CeUDzO4dFF9tvJX1UMoXeiJzVl553q9lUrms3E3HEA7vqtxgkDT8BgDQQ1+XkG+Wmz1PH5M1U+MZ+y9WxlQJGiMqDGAntEhmETUwzfzDvacr4zrjPUslHNPrHX/yY6vJVF2SVnDJICR3RRYz/itdzxJIkQvn/KnNKAM4ANYpZk6GDfpgtezWoCavTP9mtNNf9P5QDbULCm1YaBDLYmiCPbgdEjmjmqaicm8Ra4RZrFKWQ0V0I5o9DVH8kqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(66556008)(66476007)(2906002)(26005)(186003)(9746002)(9786002)(8936002)(426003)(83380400001)(36756003)(2616005)(66946007)(8676002)(316002)(5660300002)(38100700002)(54906003)(4326008)(508600001)(33656002)(86362001)(1076003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mdGpsN37WmWUxs1JFXhkqTmFLFziAgOzIas+gEkP58kVCjaFpxrEmptOFu4V?=
 =?us-ascii?Q?kKmkVLUme+BuMpk7XYZqxoBv046QwiExfqk82/CbPzndDvmYza4Gchck5nlE?=
 =?us-ascii?Q?giACsZtP4vpDV5lghCiO5ENQyHmEGi5RKrzGNGTQKx37SitJ6J2jl3mer2kh?=
 =?us-ascii?Q?LCAKYSn7Q2HXm0lUM3APR80C0JCxFd8WFH4EZ6F11CvojJ0uPkgUNEcCV6ca?=
 =?us-ascii?Q?PWPcki96er1aPT8oHsSqODPBabJSuXa81yalHDi7YzTlVf0AwR2PqxpCATIM?=
 =?us-ascii?Q?/bSjwX2nTBReMbX0D3hlOfsuCDHJxPX0ULiRv96GWSjxGzPtUgLqBDjEDH6N?=
 =?us-ascii?Q?hcXCBboK0DqydsemTU4e7SLgGyxEn74RvUyJAZGDBl41sEpPjUVbTBymupyl?=
 =?us-ascii?Q?49CYAspaZd1HBBkjS9/pAL/XPag59ttvZ+1HB+r1uG0Tyij015OktUmaN0OT?=
 =?us-ascii?Q?taP88bDMRUvFufsaWkBV+4rOxMRBQgvRQdRyAEs3KecZJZZuawHoPUOdeqfr?=
 =?us-ascii?Q?Kl6YFQeucUWzovaZDA3r3+iSnAMkf4dwzAl3eXhBYs+DQDltVPZg7gFl0sW4?=
 =?us-ascii?Q?SkfALZThFV4ecuHmyPj8Q0L29PCwXBLpCN1NcxDHJt3tBhfaBoEl4pOV2osQ?=
 =?us-ascii?Q?1wfh6dWzbny/XPMpN3qZqPSl70YWqZ8UL0uqdDc8cCQAXxTXnvwqmVpd43MZ?=
 =?us-ascii?Q?5A+0sw3iolcATbEYCOMRqtDzqKKeEd0XVN6mGhOQjLx4ECOI6TMKp7WTO5Q9?=
 =?us-ascii?Q?SZoq1wT8uRVRM0Tl5T529uq5XutVzmEXbCBeGoXStyP+wcKxgcvJliqSq5b3?=
 =?us-ascii?Q?kO67WB8sJ5FqVWxxyDkPaOH/tP+0LiX0yuTgnPe2i2QL26kcwDFQZG62+j5G?=
 =?us-ascii?Q?uwK4K8rQwCcFBjoEHHW8hAARJlOMfeXVH2j4vWbrNWb6XubxfLRDkuBtZVP2?=
 =?us-ascii?Q?mNNRYFHOb67gRanO9VKyc9NhU5oxhBJFSYL5/4F70COu2L2d9o2RaIrDBuxT?=
 =?us-ascii?Q?zVIcE+ITWA5WmFFt8YyjHPtjsS/5QLzvgDVbv8GMstXUNvuaj2PtWA7rc5MK?=
 =?us-ascii?Q?f/k+TgpSRIb+bpHG2/1awU2ytAs8PYzjYOHh6QkwKp/uYJUcnTvIVJt/1NkN?=
 =?us-ascii?Q?E4Wp/oVb2YSTpaBxTujyVlgTW9nv1/N3u8mXnSsUoxolz/leYkc8dOOvj1vt?=
 =?us-ascii?Q?oFvPlmHCGCRldS9JtGdDb5mYYrt4zBy+OgP2wdpwWy8Lg/HCFFZlVW1BK2fE?=
 =?us-ascii?Q?9PvuyEjM6QiPdpxPnYJ0D+tg+IgQ/fvSLXywB2FlU2O3N5iLZb8qTfY/W3XX?=
 =?us-ascii?Q?MQrhUWPrHQRIy+q5m0TTYFIcR7j2w1fxsAXU7gnlN52asw+E92KJ416wPjAZ?=
 =?us-ascii?Q?3cK4XEvFIUJDdhL8y+CT+TSyUHEXbJb/r46MTu9Glb7pxjqtzdvRnMV/Sf56?=
 =?us-ascii?Q?Odruo/OuhDsogAv85A1A0Ujk/ugWGef8GzZyeJC15B3mzmBJPxF0sBdBFBHV?=
 =?us-ascii?Q?AeK1q0Eqtd+wacfHHF4L+QmeCDvbUIBL7OyFvDQ8C+eXDf173JthAAjrw7gB?=
 =?us-ascii?Q?Qmm12POGa7fPXhbYoTQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbfdcaa5-cd26-46d9-a645-08d99af8f0b4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 16:27:03.1887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzIZFIKUvg0i0KNGRA+XYYuSCrtcXti0hJ6Bvyl8rN5+ucqVtTwWdqZfNNv9axs/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5537
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 28, 2021 at 08:55:22AM +0300, Leon Romanovsky wrote:
> From: Aharon Landau <aharonl@nvidia.com>
> 
> The vendors set the IOVA of newly created MRs in rereg_user_mr, so don't
> overwrite it. That ensures that this field is set only if IB_MR_REREG_TRANS
> flag is provided.
> 
> Fixes: 6e0954b11c05 ("RDMA/uverbs: Allow drivers to create a new HW object during rereg_mr")

This isn't really a fixes type patch..

> Signed-off-by: Aharon Landau <aharonl@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>  drivers/infiniband/core/uverbs_cmd.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 740e6b2efe0e..d1345d76d9b1 100644
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -837,11 +837,8 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
>  		new_mr->device = new_pd->device;
>  		new_mr->pd = new_pd;
>  		new_mr->type = IB_MR_TYPE_USER;
> -		new_mr->dm = NULL;
> -		new_mr->sig_attrs = NULL;
>  		new_mr->uobject = uobj;
>  		atomic_inc(&new_pd->usecnt);
> -		new_mr->iova = cmd.hca_va;
>  		new_uobj->object = new_mr;

It is like this because the reg_mr path does it this way, if you want
to change it here then change reg_mr as well, but that needs auditing
all the drivers..

And I'd also suggest removing the other set a few lines below

Jason
