Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621583B6B4A
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 01:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbhF1XWF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Jun 2021 19:22:05 -0400
Received: from mail-mw2nam12on2059.outbound.protection.outlook.com ([40.107.244.59]:38080
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234600AbhF1XWD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Jun 2021 19:22:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0/V2mzTfWh0e3tJG1oSDi1ntGRY/aWPc4ABr+JuPEcDq8N8IZlicg5DqMdyhu+9f/lYyco2KLUalv6UmHMg+f6qzrlNzQRBSP7vgUNr0qUYwq+w9yqCrQJnKClYxJJIAcRX173hDiOg32MDcke13phbJa2i02lGuVrqxPCv3qv8168BQnbPvtmXJKX3jnPEAUYA+RvVvW3BqlzwQswHAqZUI582wWIIYuF6QVg+vkcvt8dFu23MnslsMoee8OhLhb2zIg89x6gUs/MkWRksrUj3tBvhkfCtozUKprAiGWqJBTo/rlaFIOvnNKLWFEss49PtRskMu4WOQaHaMWsHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wK7jb+hj3NF7KYZUimCwRvuh3NR1oQkM10Wsudnd32g=;
 b=OY+69aQA3QuRci431nP0If6HE/l36zujV1j8U5LJIMt+gR4LuaDmt4M7SnoBfNWwieQb0D7kM5bqBReX5TyIsvOiJLjFSPoorAXbVbeMWp55Hr3iHZP4cFlI1YpuNTb81/JwUGEWP1H7tHIwyVxmSSSr5JYdOwXHy2p2uMFbcZfB97tz7KqDxPh1KIfpJsRYmECZEtKjByTNWtrFJSlg4KcugcVEkseJg7Efn8/pFZyYz6RKgP2LkHDvmsJotwtOfLuH0cttZEcshfXvbTMHgUQE+8zh+XaQwn3Pa1s1zz29KzrIIsDMPHzlV5357EYBADI72sUtqLAt7Y4f1hBkfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wK7jb+hj3NF7KYZUimCwRvuh3NR1oQkM10Wsudnd32g=;
 b=HF5vNnuu7u3IubLJtjJTF6o9d1SxkG4FQZstv4jvrpdY+L4SnndNQQpRbArLakuV9avuslt06rJYhoPag+XEqcM9XC0Yzzfp9XRwwZYk8++Nv8QwYmyojTo5I8UK/F1Y7BGpidCBLlUpylvs3RtHEe2Fm50E1QgUpkcWcX/gVnihrNBiZxqbsO9NxNDEmPch6Hr8bj9hljYJDzoXpoIm4QI0PJlcXPJHFVsx5bGZckNvNjeKZVqO7XTFf0TOzq+zENwOXPrzBAawYPipACk1fDDlIC3DbZ8OmrsgU/8NkFiB8JVaHoD44l14zNf5p2N1+vrZ+CHyev081RlHwmPGBA==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5523.namprd12.prod.outlook.com (2603:10b6:208:1ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Mon, 28 Jun
 2021 23:19:35 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 23:19:35 +0000
Date:   Mon, 28 Jun 2021 20:19:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
Cc:     "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Pine, Kevin" <kevin.pine@cornelisnetworks.com>
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Message-ID: <20210628231934.GL4459@nvidia.com>
References: <YKTDPm6j29jziSxT@unreal>
 <0b3cc247-b67b-6151-2a32-e4682ff9af22@cornelisnetworks.com>
 <20210519182941.GQ1002214@nvidia.com>
 <1ceb34ec-eafb-697e-672c-17f9febb2e82@cornelisnetworks.com>
 <20210519202623.GU1002214@nvidia.com>
 <983802a6-0fa2-e181-832e-13a2d5f0fa82@cornelisnetworks.com>
 <20210525131358.GU1002214@nvidia.com>
 <4e4df8bd-4e3a-fe35-041d-ed3ed95be1cb@cornelisnetworks.com>
 <20210525142048.GZ1002214@nvidia.com>
 <CH0PR01MB7153F90EA5FAD6C18D361CC4F2039@CH0PR01MB7153.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR01MB7153F90EA5FAD6C18D361CC4F2039@CH0PR01MB7153.prod.exchangelabs.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:208:257::21) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0046.namprd13.prod.outlook.com (2603:10b6:208:257::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.16 via Frontend Transport; Mon, 28 Jun 2021 23:19:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ly0XO-000m5s-0a; Mon, 28 Jun 2021 20:19:34 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52ceb627-026e-408f-c767-08d93a8b3116
X-MS-TrafficTypeDiagnostic: BL0PR12MB5523:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5523ECB86938BC350AE212FAC2039@BL0PR12MB5523.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1476v/mB4ksG+rSa0qr0CJo13gVoOJjcr0LQpaEZ3hSo9BNLj+fScEXAYaLGIUSdPiYuRxrD70NJmO09U20SmWgmeTHtBxJYtlya5Yz4VCgHiQ4GIePPwWVstCWbIWYSCy1UqQ//F6jJ7Cc2dDpg1KFx1W4RScjxoFFhrXRyU6NIRHJ2xnGuUUmIW901Nno5GMkSqhZWNrkLE0NBSMV4J0cwc47vV/xqQlxyNzzmvjFFmRb+POziD9i9LT5n/Qu5gcEa+UssCqD/u736zN9LRSFIuqkfFF/MmvhgoF47JP79nDR0UE1L7t/CMHqBO+INiVFDSBL86gVM+kXXqOZckdghU4HmDpdDyaENrI9utuScFbq1t9b4h4uclzeQ/GkFiM40lRUTFFWGcGIcONcrJ8Ak2NVaoUQSH418ZQaEQeN7wQDACBr+ZBnbb4kkp+DjrkKnCkLlQV1whXIuc3mrfx0NgQiwPhfRALe4Vhy4XijBaIkqGfffwBi0fRnpDaAwCU5g4r3ZJaBAHFV/GlLCvGFvHemyZwdj9rT7sQ3yeRrNBhqZDmoR61GWGk9qIsk3RFeqsiQrkAPa0d4MtKajub3pt/Zf/1/OSnS8cyMoxiu3QCFdDimZbfLPp3Xt72wCu+bb/3a1lo9FGYlZOFrOTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(33656002)(8936002)(38100700002)(186003)(8676002)(26005)(5660300002)(36756003)(2616005)(1076003)(4326008)(316002)(66476007)(54906003)(426003)(86362001)(9786002)(9746002)(66556008)(66946007)(2906002)(6916009)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PaYJh24NpCw9OMyjj3v8xeOATpzML0DJ26Fr6orqVwu7u0SN6yYrpQ6s1Qeq?=
 =?us-ascii?Q?l7r6tbpF3ikG3gty3mFZlUsv6ydk5JaT/nl48vgI+IUw3GKBqjpk2TywOuSv?=
 =?us-ascii?Q?8DdQHAf7RQIzc4/nvQutV80DsP6gyyWOR+k4TuFVdnNbSOmeA4a1Ibu3swUs?=
 =?us-ascii?Q?3LvuRyNkPI6mRnmAKkpI3ep4iY5Q43KKiGB7j3+Lj/1UTyObVCf5MA6y6AdF?=
 =?us-ascii?Q?P21rzViQoOg+fHnjdKmqezxrgJtQbSGihPmo0pYTMosI5jShK/5/5RPU64bs?=
 =?us-ascii?Q?R/2lXq2jiblh91qLrhmvB2yvANHJOFmowX+6DH9/BmYpwsoNk1Sx7PxQuk7Z?=
 =?us-ascii?Q?ySB18tOEwAfNbQ2n4c7Nx0/LbgtwHG5EFLJabTiNR4XLNravRnVycSPPN+uP?=
 =?us-ascii?Q?AuBgK3UFfManMVos+gxkkXx5Zk1pNq8O3WoAZWgvFFARnZkhuLldCSbkJIXq?=
 =?us-ascii?Q?6813Dr/bIAS0AdYfAUSzenAkhsc+P09Qz76PF4V0ypGt6mysLHzRLBbwhkIl?=
 =?us-ascii?Q?fAiStnD1T8fmtmapH+YcbwLBYHp6ZLMwOvjbgVWMtnNBGBoBP+Edfi9y8iAs?=
 =?us-ascii?Q?YVtDPdEhKV8A6C7jpHGxfCz8Ydlyd0/aVMG+72kZ4ZgrnF1Yhri8lh2hu55q?=
 =?us-ascii?Q?aGc63HbeGEm8Py2wRjrfFAovvtvzOJgoO3xb65GH1v0F+QkN2a7o8A1zb/tz?=
 =?us-ascii?Q?HpWzR+YABGD7hpuqD9g99jY+ObMiM4UYOjdo9UOCSMXxQYFfngzL8VGzDFXt?=
 =?us-ascii?Q?DHgcKKUzxn2DclVgWRdARW1MP+DnUwvmVq0B+MrJmj1c1Zb8BF6qgcJNU4y0?=
 =?us-ascii?Q?3pne47Xih9qtNeJUe5sEdGtyITciq99DiINp5eP2DQEJ/8wQgWiPc09HEaCl?=
 =?us-ascii?Q?4S7dvR5G5vKUSpP+hiVUr3lqNJFOjpeBjISbCtInqw5x2EvvM/hTJ6iVqDbj?=
 =?us-ascii?Q?hDfpJeP6XWL51T6NNczeX46zJSdbuO/JTQ9IjCQwcd+1++5Jk5CPi2LsBpAZ?=
 =?us-ascii?Q?8rhAcIzHNSczzCmjwgrrwXKqkRL7Ux/fRywgJgrGsuVj4rJn2rFcCMGcGvVu?=
 =?us-ascii?Q?GZ9DIottSNT//Q3UJxIyWtPnok0xd4BaFrvUt4R6SHdhURijY/vapsiyDUis?=
 =?us-ascii?Q?GNV0/7R3AKuA/J07h4eeZU3dV3c4pPOMs5wRcjMquwvKlb1MK+DdjAxxn12F?=
 =?us-ascii?Q?Uq8ChkNxpPFfmJCZO6hPVpYn22kEjjBGHVIWDzeorrJYaMQWOh2qFOjmJoVo?=
 =?us-ascii?Q?LiXuxugeSFQquxJICkz6erpaJkHbEUOZYT+xv1q0Uvt6H1F/eZay6d7Uzibt?=
 =?us-ascii?Q?qPfXF5RlMxvwjp2/2ci3CRx3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ceb627-026e-408f-c767-08d93a8b3116
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 23:19:35.0148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGZmGzCU/auhRl118ktqlnDtMv0+PjLimbHukNy8EJ5PIzv9aX8aNZZEEF8eK6Z7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5523
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 28, 2021 at 09:59:48PM +0000, Marciniszyn, Mike wrote:

> To answer some of the pending questions posed before, the mempolicy
> looks to be a process relative control and does not apply to our QP
> allocation where the struct rvt_qp is in the kernel.

I think mempolicy is per task, which is a thread, and it propagates
into kernel allocations made under that task's current

> It certainly does not apply to kernel ULPs such as those created by
> say Lustre, ipoib, SRP, iSer, and NFS RDMA.

These don't use uverbs, so a uverbs change is not relavent.
 
> We do support comp_vector stuff, but that distributes completion
> processing.  Completions are triggered in our receive processing but
> to a much less extent based on ULP choices and packet type.  From a
> strategy standpoint, the code assumes distribution of kernel receive
> interrupt processing is vectored either by irqbalance or by explicit
> user mode scripting to spread RC QP receive processing across CPUs
> on the local socket.

And there you go, it should be allocating the memory based on the NUMA
affinity of the IRQ that it is going to assign to touch the memory.

And the CPU threads that are triggering this should be affine to the
same socket as well, otherwise you just get bouncing in another area.

Overall I think you get the same configuration if you just let the
normal policy stuff do its work, and it might be less fragile to boot.

I certainly object to this idea that the driver assumes userspace will
never move its IRQs off the local because it has wrongly hardwired a
numa locality to the wrong object.

Jason
