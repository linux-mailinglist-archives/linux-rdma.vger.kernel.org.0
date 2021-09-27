Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B3D41A3C0
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Sep 2021 01:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbhI0XRT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 19:17:19 -0400
Received: from mail-bn1nam07on2064.outbound.protection.outlook.com ([40.107.212.64]:37710
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229901AbhI0XRS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Sep 2021 19:17:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldibBT0J5r+F2s/OiyNxGUqSRdTJc6a3NkSdNJGjmHLZ63SqOyLOaMz08uYMlPrVmimQbiPxkOgicgd/oyfAmuBr1A/u4KmXJ8wHIBsM7E0lhZJtTfK4GOGZOtzJmr8CgSNQk40onKvy47sJYUX+L1ADdLajZ+ptBhkx6QZbETKfFNdPGGV3wGAuWBmJh4ju1v/jh1LXfToVR9/JQuUgrKmaeBdSJYycZTtdQg2lh1dRohX4KCEap6+6QjPPZALb8MfYXm2JwYtMh4mjHEXc3J+ib5BX1LMLaudGoaoCNmgWJO6x8UrJR09bl+Iq+sYIruW1kMIGxr1BVrabUJ6DcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vKP4zHVRpzOwZRd2x9XRMQMLh9koLe/vGkPlTTUEAPY=;
 b=MhB4zXn06lTdcRSfph9ff/nPMhNGTuaL6i7RqppklSxRyfV9LVk2di0Fo14x283cJ0JJscqft6OlnLTQgR2TmSdBSGnDjxv90lLvC0mvUekGF3kCQfgeTcyF3ZKDFqhx/Ja0nqJ4h6vLl5NwXJ2dsGlEoNmZvxrJfpG3/4B1ijOfyrX+zZrTatlNGr/XP7X/OudOlRn6+NqxUK89a2jDJf2GCv61ZfWj/OYjdnMyPorf1JjGboE5Ur5jIm+MVpPNPClUU60qoZLtMykImzUTIIMUlCx8IVQvQv1y7TPXLowEOL1Zh4J5BRWTQSl+y1wnAILceh6AlaDcTTJR7F7aBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKP4zHVRpzOwZRd2x9XRMQMLh9koLe/vGkPlTTUEAPY=;
 b=GIce1AWB+//y5Sbbrgi3S9DH1K1GM2Vp09+JdLRY02QBjrWJiCHIP19c0HDF+TdqUHU+mPY1kz7qTlppCLqJAY+WkNy960PQOgObb+me70CYS7zu+AicFvXK5fu4c6mmrcgLLPlgzYpE/G2edUjE4HHozdPkR76nfl6ETRYc0KFhnrTx0qrRuUrUhLTgGr4MUQTT0GQLgNyJq/gUbUtD2y8Kn6ytFQaJIq+MPtdN+BDhDGhAb5+kKFnfPmDLwGypS5U1ijk+0DuW1uJ77nG418lwwjCH/S8bbiZbEv2mR0j+mQmj318DYRMePz5zCRVuknVkQflaCGPb1hWUJFcFcQ==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.21; Mon, 27 Sep
 2021 23:15:39 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.022; Mon, 27 Sep 2021
 23:15:39 +0000
Date:   Mon, 27 Sep 2021 20:15:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/6] Perf and debug fixes for hfi
Message-ID: <20210927231537.GA1621884@nvidia.com>
References: <20210913132317.131370.54825.stgit@awfm-01.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913132317.131370.54825.stgit@awfm-01.cornelisnetworks.com>
X-ClientProxiedBy: MN2PR20CA0045.namprd20.prod.outlook.com
 (2603:10b6:208:235::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR20CA0045.namprd20.prod.outlook.com (2603:10b6:208:235::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Mon, 27 Sep 2021 23:15:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mUzqT-006nwB-VR; Mon, 27 Sep 2021 20:15:37 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47371147-0806-4785-2b7f-08d9820cb81f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5031:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5031472A95317E8BF98164DCC2A79@BL1PR12MB5031.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ad8theFlteHeL7byt7jl76ivBlMpSYrcXzE/cChMhkHZ0ROLQl/mYWEqgKWbvhgbhVUjcdgn4Hx4aQ/tNvLdjmTK4XskswEP7pbc3RC6+6csSWJu8gSFbOj9fhAoUiQIz7r38dQKVLKt2icVs6W+FEFavujeY5+QACjWhnmZHoTYxsShze1uQcZxy/BtFTzWxW7BCXGs+o1KItlCdKUPJfD6PJD4P2yQDhekaMFg2LtBSaHlmxGdeDHYIrYrmOf9IVL2L500CBAvDYeXU0Mq3naU58FO+FmbI8LA/Wtr42jOBb5uEolSym6DvW8DjEg4+dLfElMS1NjtWo0CL7Pnme+24frmLYdCcXuX4WNC1Y2MgI5ESJCG1auEHxTi0fbrnGvUjznwjFMQ5A3JehJuMP/c4A/4yQkbMRCzIaYaOIkKjeyfsj4qcnSrtqvyVPpDcSb6sdrKtkl0fhoQzLxI9Jd26ZnE01Uw/UqWsmF1yv39Gb/iap+XvIRem9qVYP6NzjdrgzMdNvrCbTKeiRZnwcqjQh6KXct7adz7GRkH3cBQV+YkvvT2O+TDpTaFSdZFpoqD/m/o93+Qnta6isY7BOBbpWOw8xdvuIY+5puvCk6G6Pf002RHhdb75/C/DkN/4hlzFmWU6bQMLMVqFqolwsp56bG4gODCXakmEEDD2OryeQiaz2RvDMX/2SOeKy/ubc+sXuMo0Bb4MbGuDSgJR0GG9J81jmC04cFFy+CT22M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(966005)(9786002)(8936002)(86362001)(426003)(1076003)(8676002)(508600001)(38100700002)(9746002)(5660300002)(33656002)(66946007)(26005)(36756003)(83380400001)(316002)(6916009)(2906002)(186003)(66476007)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yj+EnEKlC5OUU6YQ/HNo/9xARZsPQC6LGVxqUxu8KQajl4ydBj0U3mtV+B6B?=
 =?us-ascii?Q?HaGBe+ERO41JdnI9RclZL+UTEkk/FNFwJXlXPYYuuBqcdT8EvGaeyvVmy628?=
 =?us-ascii?Q?lisKzF9+zDLLcexOxD67MheoyeZkRTgfGqFuvRYJYN4cSf2YPiIaj8MOmnsY?=
 =?us-ascii?Q?xXep3008FU0p1XBYEh7AOUXxUbxL6HNNdQuJ/5Kdg7rGzciGUOH4Qdgc5eZj?=
 =?us-ascii?Q?0XzpSO3e7qZyjPe3qnU5pY7k+qN2lufTQdyT6m1FEjEbdxD2opRB3qcyZC+5?=
 =?us-ascii?Q?P/r7xm1Or+SS+eRwzPQ76Z/CJvaVU35UtZVimUgeIIGnqROKT2a07uEt2d66?=
 =?us-ascii?Q?BTodkVkc2EqaRRjA4LBWVS9eEKxhAF7AwmL5SDLGwDSdiV1gSfSL/+V0Qz59?=
 =?us-ascii?Q?kNugO40cKTziKm8igZxKFfCZVRqn8DMHYrVzUUf7lY1meC4ZUUHomY6AxQVh?=
 =?us-ascii?Q?Ij3le2z3iqmDNJOVNVhInqN0FlBRMoBZfROmUMUQ3XTuNXNpkSCFcCgC/wIY?=
 =?us-ascii?Q?t5BZNPvWwR7SbTRgQ+XTGK4E3Jx1MBKQteHlU0TELoGewWLV07BsUH4qz+1n?=
 =?us-ascii?Q?EmhBjiAHXFC1u0mty/e0Yuloluky5mSqjDvcx766nW8OlcQWtlh5wIvZLkVu?=
 =?us-ascii?Q?CgtUFiXqaUPdl1WlrqSrbevDJEpz/eR3FVxoroihUaRJ/XluFfpYhR3ZLU00?=
 =?us-ascii?Q?MvLSTAMgBw54xqD/tK+uUjanSfJglXoi50euLd3MwTeoE5vwz7tihvvE1K8q?=
 =?us-ascii?Q?Xhq6N+FkPCHX8KAp15b6g+cvlFfBZFtAWUPXeUhU/FMbcy3u2lq7U+S+rqBd?=
 =?us-ascii?Q?PYuTTVURh4mvT5yZkk4U+yqNAg3OUpLiIqgWrNv40gY302icSNWz1xRps+F/?=
 =?us-ascii?Q?ItpOwX/Qidq7MOUWVsUWJCKUIlk9wxUqFHYtIiX7l4zsdJy93v2i5SHvBo6l?=
 =?us-ascii?Q?OUA1wT1M74HuRtIq0NQqn5OV+j68gRzTbJYZkmEtQpNvQyS1mdjCCq4nuvhd?=
 =?us-ascii?Q?y6gxoGXjwzPtILh+/gxhe6/Y1PL0A3mqmRypT4KNCH4Kt+d62wfIZ5FzSXaP?=
 =?us-ascii?Q?TDayvhlH6FU7Mj1AzIr1lVyoTxMm61Hir4Vdixs71ZpZoU1GjU1bks7mI46T?=
 =?us-ascii?Q?cjwvW98dBDMCnj+Ugy1c33HYnWslxIWnfmsgwFxnf/K3V8Wj/9xZDnVlTbdA?=
 =?us-ascii?Q?UBXzz8pNNjOicDvp1j7P3qHsNyqMIkvnielkolOBsVUiOw944UDEtnXQErfC?=
 =?us-ascii?Q?oe3lvTp5RG3yFIsdGrRWs+2cQ2v7HNiA0W5E1xV6SE1dbEuW2mywXjdE2cv9?=
 =?us-ascii?Q?Ln61pBRPk02+XR73RZAZ5HAm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47371147-0806-4785-2b7f-08d9820cb81f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 23:15:39.2622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhs55LBAGGEgK3RqDbmX9NYQ8LAl8qDKadWq9qTlOk7P6KHQ4MyG1xFhgbnl2A2l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 13, 2021 at 09:28:20AM -0400, Dennis Dalessandro wrote:
> Here is a series of perf improvements and debug/trace fixes from Mike,
> who has this to say about the patches...
> 
> The AIP SDMA interrupt handling is inefficient:
> 
> - A slab entry is allocated for each sent packet
> 
>   This is despite the fact that there is a ring for each possible send slot
>   that could be occupied by a tx descriptor
> 
> - The interrupt handling/NAPI is lock happy has a mixed up notion of
>   producer and consumer
> 
>   The ring should be a ring of tx descriptors vs. a ring of pointers
> 
>   The consumer of descriptors should be the xmit side of the TX
> 
>   The producer of the descriptors is the SDMA interrupt handling and NAPI
>   tx completion
> 
>   There is certainly no locking required in the interrupt/TX napi tx queue
> 
>   There is no locking required in the xmit side since that is held off by NAPI
>   code
> 
> Note that these patches are also staged publicly on our GitHub site for easy
> browsing in context.
> 
> https://github.com/cornelisnetworks/linux
> 
> ---
> 
> Mike Marciniszyn (6):
>       IB/hfi1: Remove cache and embed txreq in ring
>       IB/hfi1: Get rid of hot path divide
>       IB/hfi1: Get rid of tx priv backpointer
>       IB/hfi1: Tune netdev xmit cachelines
>       IB/hfi1: Remove atomic completion count
>       IB/hfi1: Add ring consumer and producers traces

Applied to for-next, thanks

Jason
