Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E41C257C43
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Aug 2020 17:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgHaP1E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Aug 2020 11:27:04 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19450 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgHaP1D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Aug 2020 11:27:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4d16b80005>; Mon, 31 Aug 2020 08:26:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 31 Aug 2020 08:27:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 31 Aug 2020 08:27:02 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 15:27:02 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 31 Aug 2020 15:27:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlgMxQkk5vfeWKl3UG8BqBzdXLFD+RLnC7KwSgBvkXjW0wh4UaK4ltbVylt2CtK0NXBlOBFp1D2JM3DHDZFAkEUzQgpNLfoXO/6k0XxL4sTKYDbap9ECPeOZ0kzauRa6Miu5WD6IO1OVikt+VqBINdO8Rx06b4+0sNKE+k3ODfTUXBr2ISTaKvKFogLjcAV78CatSOhyzFUbLqnBB8aMM6JyBB2Laf425mC3kYc7rkDLRUU9YI/nMxKmqbL7H+dA6u31S3lthlitM/OVPgb9UkZN7/t/4MLn9rgVMWxV940830wymtmrLweAlw9BVnXIBPqC4fX/Ewqx21tYSuQvIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkNtccOG/ZDe6NEzJbQVWFya4aNNKmS+VeeQaaMSApo=;
 b=He7z2JKUAgxS3/539zOgINVDUhswWW3lejZKsYt+pcUAcxUEh6BPBCImNXXfb6ShQFyW6ZkshO5/BjjJIMCWiEUcbDXwecktMwQQ/HIsMOXemfRypXUGJTDrgrssIurN+6wm9XWsgBHKYWvriZ2ufKo2yn3XV/eQ6nnDCwjPetuyg6BFcde+ikjZcyVTHz2dovf1hd9IK269U0MCJOexsrPCUCTGLGd2g91K1RxCT+A/AEeNVFp43hGCSRX7l1hxRu/nS9DegwXo/TkTVkGcqrtTVOKrL7xPfXH4CoHHqr6mKQ54d+8JacKeF3rSwx9kPBSlgudf43CkShDNEXmYMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2940.namprd12.prod.outlook.com (2603:10b6:5:15f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 31 Aug
 2020 15:27:01 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 15:27:01 +0000
Date:   Mon, 31 Aug 2020 12:27:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH v2 for-next] rdma_rxe: address an issue with hardened
 user copy
Message-ID: <20200831152700.GE628533@nvidia.com>
References: <20200827163535.2632-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200827163535.2632-1-rpearson@hpe.com>
X-ClientProxiedBy: MN2PR15CA0037.namprd15.prod.outlook.com
 (2603:10b6:208:237::6) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR15CA0037.namprd15.prod.outlook.com (2603:10b6:208:237::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 15:27:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kCli0-002dYH-0Q; Mon, 31 Aug 2020 12:27:00 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06a4f2b2-7d5a-410f-4fc7-08d84dc24e9a
X-MS-TrafficTypeDiagnostic: DM6PR12MB2940:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2940EA9B7D0FD099F1976D1CC2510@DM6PR12MB2940.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tHQjhoXeH0y97PqU+UUlrCoqYyBGaMfbVIGTdjcaTQNalWIIL+U1TKGaomVvHkeDhOt/2xCRlKzxMSM+vko3wUfqYYXsM2JuZQxfi/SrXjYAcKe3+xwVqZ71ibqebSnOX2W4iKrShG3hNSJ7U2gOMZhWlu5Uqi4d+VQGwwk0SYb4s/u7Uyg0HT1lIdiYSy4nXZQHpKtJqNkRZ8GZmfFdwP6ZUVwy/Vq1Cwp8hcbYEebMYQ6KUdAhnwOu8YdBLk/demHXt3Ii/9eskbBZcfiw6azLTMVtBhzSQDGj0ET89o/plmCCGJFOBm7JQeqe4Oe3aPwnSkxlkJiD161wxLaE6VF6qJXdXBXccaViNhNQgaBf1vdk+oIxwPqTYSlCba8Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(26005)(2906002)(5660300002)(36756003)(86362001)(478600001)(6916009)(8676002)(1076003)(33656002)(4326008)(2616005)(426003)(316002)(8936002)(66556008)(66476007)(66946007)(4744005)(83380400001)(186003)(9746002)(9786002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YNrjQInQzSNNF2ZY+bxZKlsoVOforY4tq0a78KoqJH4VhvJsqpZ043xWiY/n5lMOCARCCCtisPYzQf8E/f4r6SrpYDXcfUzWd/VaTjVLPnmBTq6l2Q4vof/ka5SfokdCSMZz4Vo726P3rcZIh27vM6lN9hNOn80PPN6UrLtpRZTI5HVNV7CxuWzUriiK9tfVo6sKXuc5HrFqjtne30Dls+g/v3VmQc1yD0a82WkOhAi/T100euHLNV1VkipY9wd8XSBkKzyG+oLLictKqDlQejjfy8H1kM4lEK7iQpHxNDexBkRPM43Ajj4FosNt0uxCek8o7XB2y4JzE+Cj23I69RZcoNZbfx/2YkOAen3P3/5CKQ5k/IKZxUGvd0AkefXx3/3wpe/CcfRNSePjgzdhH2eDmq9bo4d9CdTV6WVJzU1ZvWaV2EpggHjaZOx3HNQJjSO1A7StRHKjVs0TPipXZXUHs2r5GJ7cJX69W8ll9mMAvU+7ouWyWqhXOHI3ypQw5RBvkaUJvfLegNUsTdXvrY42P+PlJJBb6JTKYCHepdKDNAsZ5TanLYLyakMEPN/oLblqo+JeGcRI0ndRhYb9FEBmSeDQ2Vypt3PXm1Of/95h2vp77NmIrUJ30HqJW2KI0i4X1cQBmRTf7ydhhzlSgQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a4f2b2-7d5a-410f-4fc7-08d84dc24e9a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 15:27:01.2614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwhUckhxN1DwxdtQdGj4ItuoqD1YxKiDyJ0OSUDDqmEzmEQrtLa3fK4zZ124RNdv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2940
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598887609; bh=wkNtccOG/ZDe6NEzJbQVWFya4aNNKmS+VeeQaaMSApo=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=RVdOrX8WIxIjYJYZIQjYrab1evO9KmUtnPmA8EaDnlMnXzg7TV5/SDhnNVXTkkJBU
         FkYw+0eAZXtrtr5/ZMCX/F/SKys8dSeHineiXQckN+Ibc7EuxokmmBMiHU46i+IbDb
         PGto/u9jnvrEwR6HRbxggfpjFf5F1XtzoK6cK7QFIQgHWD4WT4AdJPiF0w1sGQwLLS
         TIOAiDZehgyFFr3v60lv7nDc9+zlVUw+u2TALUMeB71TNG02pPU6Uy/yovJ93aodmg
         tZsmWI3qJGYyQNZY6nbIo6Uc6jC7wt6AIzBEC5CjFQ8Y6VaBen+2ykJJnJRzQnhFgU
         duE0iExVA6BvQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 27, 2020 at 11:35:36AM -0500, Bob Pearson wrote:
> Change rxe pools to use kzalloc instead of kmem_cache to allocate
> memory for rxe objects.
> 
> difference v1-v2:
> 	ported patch to current for-next branch
> 
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c      |  8 ----
>  drivers/infiniband/sw/rxe/rxe_pool.c | 60 +---------------------------
>  drivers/infiniband/sw/rxe/rxe_pool.h |  7 ----
>  3 files changed, 2 insertions(+), 73 deletions(-)

Applied to for-next, thanks

Jason
