Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E093DF3DA
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Aug 2021 19:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbhHCRWp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 13:22:45 -0400
Received: from mail-bn7nam10on2086.outbound.protection.outlook.com ([40.107.92.86]:25953
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232054AbhHCRWo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Aug 2021 13:22:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5Av4KQCfxWmI2U3JKZLAEi3BcugPCPOf/S+SlRINVo6MF4KDaTZlQFVv7MD63MtQzKvZ5IIcfwe7gkV6Fhx3kez9f2XuyXhWt4fwYWD8qMYmAWrQ25ZTdtWdr1EaVubzzlUn90HVq2Oeb+nt3iFzP2IoVbGlRqlAkaI07LlYs10ekyVlNiyzf93mS6KkgZF+akba7rGT6iyDh1C/aiW5zQy60aZHmHSV73np11swXWyzbtvFR3g4cQxvcZTZrhXw0RiWLnjI+/Aw6SOyGDfaKtBiTHqMfedNdeoDH2bZcVFX5cUNea5gTpUOza7xyCUSykk175t5hBNk8Cyu31HbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WwQb9p++wL0N0aZYAR2bHaalYWy/IWh/vm/ULGIzSM=;
 b=PwAj/fIAXu4/sc7L3pJwB+ZApbRgW6mxlmolFNmPeZq9Hg3AyaAoI47saPBCDUymA0DXBRitp6tN6PgetD+sKtbl3kRJVA8pgLMg8OBhox1KyPJunYUNjjAP7EkbGfMskWrgI8Iv0yPDxGkFaEbY3zwAKZ+WXP7PN1Fv2yO3EE31SLoYPf0ZbV0U/n8595uvJtjb7h9UEPD8pKK62Muz3tP05KBiWuz9kB1mGITRUfF61Ldg6rN+HO3vdv9kaaAB4bC0OmD6p6hw6NHgJrLuQxWm6Jd27yDAQveXI8SDsCxJLeDhJgSStyIYgNm2P2FRoGBmaME6MGaa68zqJQVj0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WwQb9p++wL0N0aZYAR2bHaalYWy/IWh/vm/ULGIzSM=;
 b=uHTC9DBOmZtor5eeEP/lX/yaFObxC1vuIZeS1QExO4JPTHMXBeMuulk20StkAWzLMiBc9fG6rZumX5QzZBfL3RmqKFfDH1CYzKW0dSBdtTyh10DJ6zgZk255vWL+hpWs/5zIkhmlGWIK9pDW/N7K0gKATAgV7yABaW2kW0CXD85SsqY7tvS2oEZg8E9B6Tt7B/cFR3R75UKoteJHxUh6gYUEsfrL+OSzHaCNxjrXhAmLWSYWPjZKZda0eNZm12l6XDDRVq22dj03wKI+R18wadt38T11c+ZX2aW8UIafzS84LAz3vv+Dj+0Rjba2LjStZHGuHBGgirVSLWAGHpSPAA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5272.namprd12.prod.outlook.com (2603:10b6:208:319::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Tue, 3 Aug
 2021 17:22:32 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 17:22:32 +0000
Date:   Tue, 3 Aug 2021 14:22:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next v1 0/9] QP allocation changes
Message-ID: <20210803172230.GA2912315@nvidia.com>
References: <cover.1627040189.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1627040189.git.leonro@nvidia.com>
X-ClientProxiedBy: MN2PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:208:c0::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:c0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.10 via Frontend Transport; Tue, 3 Aug 2021 17:22:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mAy7a-00CDe6-JG; Tue, 03 Aug 2021 14:22:30 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39e95fb8-ee6e-420e-eee4-08d956a346f6
X-MS-TrafficTypeDiagnostic: BL1PR12MB5272:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB52727DBA1F003F5103063481C2F09@BL1PR12MB5272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tY004pt2KVZjT4rnURHL6a+3ACgD0PcjkNa7sYhlY+G+SEDEGlLyRvHOPz2TNcNN80htIzMzJ03ZVEJekFMK5LVjvI3oHrYtvICJujlK3qHb8muqeRrEeGGVBinrTEC70yc3SatysAO44ZO0d9VXyfXzwsSBBrT1yGhCkl2p/4hYNpuGKsv0nheGFQYScQQb4L8oU3VgS+ez87Fg7F9++qgYWuPtwod6Jyh/xaYH+6xJ/mqn2gdfkhQ4NYfpB5NLZ0jQuoFMpycfZvgCUvQVoEAbh3KwmXCFZujCqzHzJaTMtBHrwyXMqfOtpljHKmzv4x3M4qTcLkj9V/ENR46RjZ4waB4q67Rj7w94mNRSKrK/njFVenUc9SfRhm6rzdmRRWe4fFqXDftghfS982uoEQ1GSyfjgq+KY2Rp085mqyMMpl92b3xV8M2i7ePdrNFSdCTKyMToDgHYPbjIB28Na7IEr14aOBaGtgvelrOTm8lefuU3dPfKon73Y56K+Vq1XcjQGF1tMnWHPn21Pp9s8xhkCQ8VWO9TseG8WUJJuV3VpW1ZMYrp+iT2HC1cjyZKN0/YR2Aq01VxxloMFI3efVveqdY3NvxzXN/xpROzr+zPuiFEW0LByvce7UtOa2ReBwoOjk+a70w9Z2FmvxyQ4uiHG6yUbHz6lHW/MzxUTF+S/+D97mLmnyxzpPayBGUMUovO2n2wlbKE1nec8cq77rF1qMxNmy4UgfOkdNr2n/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(66946007)(186003)(8936002)(1076003)(8676002)(66556008)(66476007)(26005)(36756003)(83380400001)(6916009)(2906002)(426003)(2616005)(316002)(7416002)(966005)(9786002)(38100700002)(9746002)(508600001)(5660300002)(33656002)(54906003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w/ARyhN7yaGrOtfwL+dDZCWfbgrxzB7r3frUxKCFizuQL0CimrHSuWx2oerB?=
 =?us-ascii?Q?w5XJcjrohHKGQlp2KwmPuL9+q54wXTw5CGpOVcXEqljcmcou3sWe4sjvCE+E?=
 =?us-ascii?Q?6T6m0/TssTrptZz5sG20qlSIvm2hZdCLgaj9m4DobFyHpU9Kyna9EoMTMBre?=
 =?us-ascii?Q?iOvlVRBW3h9KhPPHj4KGseru4a15F+GSxmY64gdv9yCquPjGEpW8lnZhEy+E?=
 =?us-ascii?Q?Y6sWCSoppSuF7r8FABVwUg8vCAVe63S7GTl+pkKvqWqaS4GpLET4DYcSJWGJ?=
 =?us-ascii?Q?ahWssNFdtzSc1+UuQ1izPwg63z/fbfyt4/r9oVy3ozALw85pfGuLTq1KCRLI?=
 =?us-ascii?Q?67FENh8S66S855nbf5yOyttIAqb2MtFJseYw8tCvTe4k1B1eSO3i/jvm2jnh?=
 =?us-ascii?Q?JSS+ln7WD7+NG8ThlhOgpO6OwQE70ahB0mwBKpCgJWMoWwzTNv8i6PeGkBpe?=
 =?us-ascii?Q?zy8R4GqdWEr6eOyfcc5xFdiXcpg0M72BQpANvcHSr5p7/VmRkRJa7j0o2J1l?=
 =?us-ascii?Q?Lt2GK8XKha4K58Em9gJz1kEBWoTYCKCt1/bVqVOcjMwxcGd9RAgnj6LVXi2Q?=
 =?us-ascii?Q?CZRAvvGycw2q8/qHxXlcHJEgv+ltqWjZFUjpWE4X7k9c6pc+C4AnRdb/79bI?=
 =?us-ascii?Q?vwe7Pv9FIOUskEjkTXvdfmBB01hPSuUZzJf2nIFkkJ31wvDkZKMy8UZXkRXg?=
 =?us-ascii?Q?bWFyEDSQzAWUMk9hvdw/sjnWGlHkWIsJLHn7KBibYxg6HGmD+yzcP1ThLQIF?=
 =?us-ascii?Q?EP6RGVUURsnlVagw6RfxjWGutDyqYv/BnkJkP/3uUUqYkYJNZE999zd0FAWG?=
 =?us-ascii?Q?PbpqA/GyN15TqKRLH9rczOcSH8IM2wZ37+Y0hmUgFihHQ4KGt2onAjwUrBAS?=
 =?us-ascii?Q?44mljDYrpcOsiLNzIB4Z7P9HdVI4zIMBMB4/fFSO9msgqkwRDjyHYMbjf2l5?=
 =?us-ascii?Q?lNnmgl01Cv/eEEeNtxsyNZFRGPwjqBXeNdnA9zVYVq5zJzsRroS3k/u0r61y?=
 =?us-ascii?Q?Uj2OQvXrCJm0EofLV1Jt3mCrHIkv0YlZv1jQ7qZRAfxbYbgzHKpfsnanPtVv?=
 =?us-ascii?Q?Xa9sdhVAYBbSONPPFT2yCvjefmOYqOyLsOu4w/WqLoAENOkxwna0Bz1UHi+s?=
 =?us-ascii?Q?PFSc+Wcvb7odP4QleA4UB+ehm3fXI/PXQbQ0K8HkgMf4w22RSws9InHub/iP?=
 =?us-ascii?Q?dkm8jRwAILO3wobSDtiThjpzE8g2B+gRPs3s+8EMwJxkHnAY4xV54HA6Fxm3?=
 =?us-ascii?Q?WEePTaCEmOaXPxwpG/ribvAcYa4yzFlaKpXfFudj54j4JMrU9inAQ154edAd?=
 =?us-ascii?Q?sx/ZGoDdWlK9CC/syYQEIiZO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e95fb8-ee6e-420e-eee4-08d956a346f6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 17:22:32.3446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juv42kLmgVQRA+rhSkWBXo/RncK+gNfQjuoxTMB9E31k5lreZ29Bmby6FINRw6zO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5272
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 23, 2021 at 02:39:42PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Changelog:
> v1:
>  * Added ROB tags
>  * Deleted already existed double rwq_ind_tbl assignment
>  * Deleted hr_qp->ibqp.qp_type assignment
> v0: https://lore.kernel.org/lkml/cover.1626609283.git.leonro@nvidia.com
> 
> -----------------------------------------------------------------------------
> Hi,
> 
> This series convert IB/core to use core allocation scheme for the QP
> objects.
> 
> Thanks
> 
> Leon Romanovsky (9):
>   RDMA/hns: Don't skip IB creation flow for regular RC QP
>   RDMA/hns: Don't overwrite supplied QP attributes
>   RDMA/efa: Remove double QP type assignment
>   RDMA/mlx5: Cancel pkey work before destroying device resources
>   RDMA/mlx5: Delete device resource mutex that didn't protect anything
>   RDMA/mlx5: Rework custom driver QP type creation
>   RDMA/rdmavt: Decouple QP and SGE lists allocations
>   RDMA: Globally allocate and release QP memory
>   RDMA/mlx5: Drop in-driver verbs object creations

Applied to for-next, thanks

Jason
