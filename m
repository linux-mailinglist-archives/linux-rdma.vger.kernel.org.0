Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5428E45761E
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 18:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhKSSCS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 13:02:18 -0500
Received: from mail-co1nam11on2084.outbound.protection.outlook.com ([40.107.220.84]:54112
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230405AbhKSSCR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Nov 2021 13:02:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfATp0pKT1lZmEvGDfLlp58UDxVxX6PGjlQIoHbYhg/I2T+GEwFKN8nHkJtSpTw8aUyLhDekIJJVcXlwSacOVvPYprk6vh+3yTQftYOPI2J0a1vPjppGKAIGJKBNVRKsx+Xc8o0+BZrsZ8I+JuhUjiYE9YZvyZj/aZq3ExT7P9ejRsX54zkUd9QekISlYHFykp4vYlzOIow6CVSNioZid9+8ktckeoBz4TGJdozblIljROE0QTLtOGqPFORS5BCRPCNs8ei8XFgACB/pILHld5nP8olIgSW2Z1wJOFgqjdLgC9t7+XHT8/1QOFuvR+iH7rUWxkikUfbxChQ73eN09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5c0O0OaHtppgAMzqxOOlUCsiDtj+e9do7b6/gP8UMKg=;
 b=krwu2JsWz2tSEOzZW5mMMSRD9a5cSV0TAU02ERQf/AHW8K0YQ0nmI3StysQZsmJWHfG1J/yeGQXLx5f5GfPxF6pJRg3BNpKTAo4eFpnhBIpUf52gGAjULeknpUCxCrWkL6HbgPGeEah41FUnEFWicaWq6CtPWydk6/0S6FoIGXWK/IQRAsfJR4zJsnwFME+Tk5M+FmYxAdJ4Zpewo+2JKFAj06EhwizUepBgPWWtkNflG/2knDNVAj41bC+zkszaboegh9aNTGpxnJYTunc4/3TJNEDPQDWDM5efuqaXSfnivMXUlyn7Lt3+X/VdFTU8cSMsrz5gLHI+L1YBZuU/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5c0O0OaHtppgAMzqxOOlUCsiDtj+e9do7b6/gP8UMKg=;
 b=AGa+Z9iRxdalOybXiJIOrMKz4gycKP3xfKRijDkKJMuhUidRarJNGTr+Sotm5OlBoQ7t+VM9rgT1wcGkV4Uk5oVJIRzjmnRp7DJy6nzLnimF7WD+x2j07RgyG8+U1a1yq5lZv6krxxHvd9XmUipP+qc5BaIt8au3Fz8mhyhhGzxvxDFxCt32b7KwYzkBI7Ob3ROmN8eNKjhY+x0BjC0RiJFTJjVlsEJ/nSERo+yL2odFqDmLQOVIpL0cC6MwMx9UobuDsY1XlKtvzCM3LqnxJR6gg+Ngoac9WWtrlYjw8My0j3quTpQ4L5zXbFr0wZEe8Lmolx23eC8vioxZh1xWDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5141.namprd12.prod.outlook.com (2603:10b6:208:309::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 17:59:14 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 17:59:14 +0000
Date:   Fri, 19 Nov 2021 13:59:13 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v4 00/13] Correct race conditions in rdma_rxe
Message-ID: <20211119175913.GA2994898@nvidia.com>
References: <20211103050241.61293-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103050241.61293-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:208:239::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR08CA0019.namprd08.prod.outlook.com (2603:10b6:208:239::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Fri, 19 Nov 2021 17:59:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mo8AL-00CZ87-4K; Fri, 19 Nov 2021 13:59:13 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d64219e-79db-4acd-8eb5-08d9ab864c17
X-MS-TrafficTypeDiagnostic: BL1PR12MB5141:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5141791FBD46FDFB3C442B5AC29C9@BL1PR12MB5141.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3JypBA645God87JKADepeiOPcvmwlbCxMVURoTcLmFMyAKEf7cJwRfFKuIyV+IJj/AjM8Kg2foSg+Bu+m7SdA+hA1BiGiPzWECgRY1bbKtWZZEx+Oznhn8RnAeMCQWIypo4AqwPAl4r/ZtYgBoENIunntn8xCOQjK1h+v2zvacIngLdo3wOKYDwkfdRDmPycZVeqP+rJRfWmLZVjAygCNRMlpjxISLw1pVv2dOU8GrF1cHB6oeYT+mugQ6/Zse7mlk7UJd/Giu4RmzyqR1WTh1w4b6usUTvI6MyWxU5xuLV/eLJdqnZ677LWBTwvPgq9yvA6WJtCbGg4Qa42V362H8FyC6ElFKNu4XnmqaesX7C9ti6T6YdgF/IwmlVmXZeQOFncjtA9C6k8rqulSlBOp435ySb9c1QaILmt61AXeYqnkgH+kD2mJNeYPHxckR4vdUpSXGg0x0E+yPzDs3r71RjefklfiBbI2sl6CS/lwVi/N2qnHyzc1xZJoE5UM8I5NuewQR2r3K9M9WsMegOCSBgk714zgLsVr6M2GCBAmKUZYEd3/cYauc1eaPjQvj+X8NzxjrQq/GIdQgVq3DRqnVX8B0S8jKsa1xRjjbH4efs1fY5prMnwDYMP7f6jtXr1H0M+SKmwT8S0OdLN7EVYVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(426003)(1076003)(4326008)(86362001)(9746002)(9786002)(33656002)(5660300002)(66556008)(2616005)(66476007)(8676002)(6916009)(38100700002)(316002)(2906002)(36756003)(66946007)(186003)(8936002)(83380400001)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jr3A24FmO3671y4RI9swzCbcyNYbyy6dN/EkV7ZqOXSd/1qco5BCDN5Baztj?=
 =?us-ascii?Q?FYyY/ME9PbTHlDV63XU5BljTiewNY1l0QHuU1PTHxAr0uvZUNSvn4lnZBhCY?=
 =?us-ascii?Q?cVRDQWC0xegCNibFFjXKgtP0v8/mwKhbC99xniNWPH8bu9NFDnMOhlpDdUr2?=
 =?us-ascii?Q?6KjYU7pXixecdc10yWV+E+Sq7JjzIYLvE/Xz25nYjem/RXdv3iZCrJWkCxw/?=
 =?us-ascii?Q?C6fJrwPWnQPab4F6qzx1CFTAUdwf3Quhd7XRIsQg9aT9PtS2l/AIKejz9KBv?=
 =?us-ascii?Q?FTwtpNh/qdxZl6Z15T0vGhds2hwpQE0h7QWMTbc3TxXxABQbPCXdQDLv5tv+?=
 =?us-ascii?Q?7jxNn9giv/QSFsWySik2qiqzPAFW6RFU2pgz9ei1zMN8bUonhAf4pzYSGObS?=
 =?us-ascii?Q?Y8VrEa+qNkVt7DkVoI8zR3fZnyHJsODVuVZMdHjH8F/P+scrZUWVfJYx8sRc?=
 =?us-ascii?Q?Fg9++Gvx5jC8wD1Cx7skPjB3Tbe4qgIsbihlErE364OO1Ln/wYr9womVhWoW?=
 =?us-ascii?Q?0lICKAIFha4LUJvxZiizumyjmtmrMFh7HkVxuryqcknOox0VVqfnJZQ0Lckz?=
 =?us-ascii?Q?rBDqackIyTyUDVIZTGLg2yCpp6Q/f4IJq2Vej6AoKusrFKsc7IYO+nWu/Y7R?=
 =?us-ascii?Q?LSUIxNfsJO46/B2XYwNXOq/kf10oiIutWqL8/oxIUbRwlFMSA19ioiS8nrHP?=
 =?us-ascii?Q?vN1rzyR/Nr5gdLlcM62JgGOmXI7llwL/9GW6G52J5qIpExctAYXcEroJUwbJ?=
 =?us-ascii?Q?D3IbJ2ly1xLlb0+lpa7VKpoPTb4LK2qGYAoU1B5rRBDp2s1fM9MyV/yS/Puu?=
 =?us-ascii?Q?KGLU6V89tULaeV3Hj8F8zKEBficZzM8AMzjlu8pbrpSpFJ44NqpoWwMabGgl?=
 =?us-ascii?Q?e8PAEmG0W9S6gGawqbm9G9nddd/uCw5T5Hb9fKsJrS+1Rs9eMjCKnyeH+rz/?=
 =?us-ascii?Q?T/7u7H9i6RQco0zBqvCByaw4Qqh0lv/pm5beWP3WAXMv5G701cMoJrh/ozqT?=
 =?us-ascii?Q?zFusIsqlQo8JUzPnysGVqmWJp4RColYtb7Au+mipqxOdwND3Rzj6Clm+KU6s?=
 =?us-ascii?Q?J2m9cvWBu3Iot08pWmQ+oNYFXNoAAJCVWlTAczVMKMd1GwI+6T/sYz0A3FY4?=
 =?us-ascii?Q?cv7Y+aD5CedPtgf0Bb5Mg/EQLPHBn8VZ8jJ1gdYFifBMphqOb4UGVik1TPpU?=
 =?us-ascii?Q?CfXtBXmYWuc52kl08H7KCuO2v7SsGCiW4Igvq5YKw5X5A2RJkM9fhO6B0rVM?=
 =?us-ascii?Q?3lTIq4tCblXS7IRocPfDHFNN5qN4ZNamv5fgypJmkMjvEL+NASkX9EEB/yQE?=
 =?us-ascii?Q?zqLEHo4VhoSDaFCJHYVq9SoZDb2HEPJ6O+RK3brLKl1NzodItz50m+lZBwv8?=
 =?us-ascii?Q?NAdtqPDd1Igb5pmEv0IW7pYy3WT3MWeLrSfK1D726zgVFH/qRzG5tbizsCrk?=
 =?us-ascii?Q?ekn6P+njLq18Hz5i26yUak+tD3gw4UDCl2D0GnyYEYWdDgHgkI8Cubnxmi22?=
 =?us-ascii?Q?aN5XW6xBqtlUPnfGSRlzzzSbbZoSPm0bHx8liEXUpwDckCsGeczq6NIBjUc+?=
 =?us-ascii?Q?XKrcfx812y4TGKXujVI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d64219e-79db-4acd-8eb5-08d9ab864c17
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 17:59:14.2376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAurY1SuSJ7m5LA720ivkjs+Y8aIYP9rnKqnGQ/7MLWul8Vu5zRRHNMd0lUr037J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5141
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 03, 2021 at 12:02:29AM -0500, Bob Pearson wrote:
> There are several race conditions discovered in the current rdma_rxe
> driver.  They mostly relate to races between normal operations and
> destroying objects.  This patch series makes several minor cleanups in
> rxe_pool.[ch] and replaces the red-black trees currently used by xarrays
> which have better atomic behavior.
> 
> This patch series applies cleanly to current for-next.
> commit 6a463bc9d999 ("Merge branch 'for-rc' into rdma.git for-next")
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> v4
>   Restructured patch series to change to xarray earlier which
>   greatly simplified the changes.
>   Rebased to current for-next
> v3
>   Changed rxe_alloc to use GFP_KERNEL
>   Addressed other comments by Jason Gunthorp
>   Merged the previous 06/10 and 07/10 patches into one since they overlapped
>   Added some minor cleanups as 10/10
> v2
>   Rebased to current for-next.
>   Added 4 additional patches
> 
> Bob Pearson (13):
>   RDMA/rxe: Replace irqsave locks with bh locks
>   RDMA/rxe: Cleanup rxe_pool_entry
>   RDMA/rxe: Copy setup parameters into rxe_pool
>   RDMA/rxe: Save object pointer in pool element
>   RDMA/rxe: Remove #include "rxe_loc.h" from rxe_pool.c

I took these patches

>   RDMA/rxe: Replace RB tree by xarray for indexes
>   RDMA/rxe: Remove some #defines from rxe_pool.h
>   RDMA/rxe: Reverse the sense of RXE_POOL_NO_ALLOC
>   RDMA/rxe: Replaced keyed rxe objects by indexed objects
>   RDMA/rxe: Prevent taking references to dead objects
>   RDMA/rxe: Fix ref error in rxe_av.c
>   RDMA/rxe: Replace mr by rkey in responder resources
>   RDMA/rxe: Protect against race between get_index and drop_ref

These need some fixing

Thanks,
Jason
