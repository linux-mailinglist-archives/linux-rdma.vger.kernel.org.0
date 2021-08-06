Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7483E2100
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Aug 2021 03:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243201AbhHFB3L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 21:29:11 -0400
Received: from mail-mw2nam08on2054.outbound.protection.outlook.com ([40.107.101.54]:5040
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243191AbhHFB3L (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Aug 2021 21:29:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuozgDPpt5V/67gELN3A9zPQUc4X2ewUjFlZ0QPk55TVdojBwq4CIpORn3VYJhkUfDgV8xUCkuuMouUXQJgjjP0r4vPhurL9FcQxdnF2rb3bTp+26I+XDmDCnHg/7HsdbBqUyqbdlUFzgS4wDcGcID1DtVG10wC6W4TpYSabf5sUl2MIomZj2Fh9B/ecl79xhRbKZ6I6BoSJz7ZVhQSNh6wPfJZM7Lff49jof9b0SiC0lUFrOxy2w5c/PuEjQ8rnavdQDq6CZBIEgPhRuw+9rdMZhTcysYPxl7xdb4NYBwPbmMVjNoEi7TGD6EpKDc5uGHrMlRJq4OlAKpEOkpdVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFTxiGy/Zm8abmyXbloqOyFuq9OTEo+V8eUwGTOwqo8=;
 b=Dn/aG0WScScivw3zwy8dERlpIyPaqr7G78N2IbNILnIo9ZNXF4ZxpebJM5zLMfEpXu7EsmXIUbLIdv0eYGa92Qm0fXs0TsNyFxokn+LCoh0mBOQpoae7SzZSoJ+H4j8AsHDWw3ruE0thXJ4y27t8fdoFv3ddbfxdv4Wa9t4sGmsOgDBpN0gKOchL7mT2tcZOC8pckaD3RnTNaiuaIpirYMhEWYZv1d3Mnx3r6RZb4Pk+tR8D+dPyC1dAFW/eJbevavdawydm7ms8mCvo2Wgmb87UgwyAzPkxB/HXCyUItsnkUznaPRcTPwnM0W1fHt0eAW5+xu2Wgmi4CxETjR+Bwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFTxiGy/Zm8abmyXbloqOyFuq9OTEo+V8eUwGTOwqo8=;
 b=MhMiacG61JCt5fMJKH6f1LsHnDf+kPJj0AKdcG47FPrY7+2NBQeLz1zQ8GL1DCqUC5k4AYPkm2umA+6Ux+Db7Gjnyw7/wzU6Qv+sll/jHLcJSZTSBST+Pai5/45Isx90fNNml/Ym3YM2ES55d1wDmwJ2SXgSX7IMX4qXpHQQZ3bvyvZNPShc+1gtozIyV+EV0zEcxOIJ/moAA7B/bJ4tt8jlhW9r8ur+BqXlISu5xYRB8bZAgkO/xRdkgeAF4cDbPv+kTcTaqpdJDHWW5/BfgDSBuODdAqZRwkH+3As0ODOUvdJFZGRIkS4n/gcbR2ZzwpN90LxxY5yvaCJljHMfEw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5379.namprd12.prod.outlook.com (2603:10b6:208:317::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Fri, 6 Aug
 2021 01:28:54 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%7]) with mapi id 15.20.4394.018; Fri, 6 Aug 2021
 01:28:54 +0000
Date:   Thu, 5 Aug 2021 22:28:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-core] irdma: Restore full memory barrier for
 doorbell optimization
Message-ID: <20210806012853.GP1721383@nvidia.com>
References: <20210805161134.1234-1-tatyana.e.nikolova@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805161134.1234-1-tatyana.e.nikolova@intel.com>
X-ClientProxiedBy: BL1PR13CA0420.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::35) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0420.namprd13.prod.outlook.com (2603:10b6:208:2c2::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.4 via Frontend Transport; Fri, 6 Aug 2021 01:28:54 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mBofN-00DtNg-TR; Thu, 05 Aug 2021 22:28:53 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5c9327e-9f73-4276-f3ad-08d958798e06
X-MS-TrafficTypeDiagnostic: BL1PR12MB5379:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5379F988F502271A77958F18C2F39@BL1PR12MB5379.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w7Wc0ha/lKuykGvpSGJvWO4ZVA8lZkISVjmS/sFoGUAHap6viKV71u4WmcuX613Os5n3k062QiPY/Sd7rkTIMC8sZ2pvq1ddeXZ9SZtQA13ESuMB28V9Ckkuo0kh39FsyzdHQNnkvgPvfEyR3E8qPKRGdmJoB3xSeijedDECJyrlUOQjIeRwFch2mbrlNIMbqE3LFzqHdAVWEf47tQ0gxaC6rgpRvFniyxbj096fSVDejYoSMB2F2NCOkhCd6j3xqi6zSJPcNZHUVmOauLCzkgPhWJV1sdJwXPnEwZDuagInZYOk9molEMNS/sZmTtF+gD0SBCYksJAT9gAPmtho18holWPj48T5RTfdLByKYMqC9XgEguengc6q0qUjoITEqG78S7l8T9RcJ+rT+igtlSIxhzrHsQydZ4L7Ltp8vUvJspDDZszacnGqjKZ2COhitbtmf0r4lunlj4Np3jHaGtsyUgUMjXY5iIfiR9VUp7X7dw2Ql+uwDnpmFii3Wx86XB8/nbJ5kSM8PqX3he8Iv2/TqXgVUAVxMDoVonhP+hToSZ8p+KM0azB2oW6fiSaQMzrocLFasDn9WkGgwAf4uQqR28KEi/+RcKRuPLh0PNKuTNyAval2MdJ72lA/IECSS3pkLYC7J+gN+F8BioU411u9jok/x8dKAbrbjMybFqD7zH2KzGIbWjuibykk3IPaLBok11i7u9wj6d3vEN/YmQ5cAqC+wwZDzIAT1LUaCqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(83380400001)(5660300002)(966005)(9786002)(2616005)(66556008)(186003)(26005)(8676002)(66946007)(2906002)(316002)(6916009)(4326008)(9746002)(66476007)(426003)(8936002)(86362001)(33656002)(1076003)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DMzhTeKt0t/Q99Dw76GSNWPYyeU1bcsck2KdKbdv1vcWqmCy3hWv2rkelkgS?=
 =?us-ascii?Q?1yUkRmzrkhtPn/HlmHph1/vWn1YPF4MsFq67tbh9cShB4L+JgGxiuwuHc5Va?=
 =?us-ascii?Q?P3M1q96OLZVh5abIIzzR7dSSoeqBhS9QwaLXHJOYMOND5c8IM99rN0kelyXr?=
 =?us-ascii?Q?3AM4jUhN0Ff3QMrZ31xlHLg5B/HH+7adiK0JeRLbETUFeScrlTbcyF2hqqKl?=
 =?us-ascii?Q?01d+e9RhZpBHgDLKdEji2VfMdJEeTnDvHxdouyD5C/i1XvplOOtiYYYiNFlU?=
 =?us-ascii?Q?CAF5F/UfFYj/CXC6Iuvgit4Ybt5fEnCnoyg/LwMZ4VSF/C37fQr411wfoI/S?=
 =?us-ascii?Q?APgmgVkImnaGN5awS8bbu3/DpN1MxV8dT9GcjMmabI/p1LvfYiCSPe3dr+yy?=
 =?us-ascii?Q?NrnuOPfdLBsU9sqOvcP45UIU4eY7vxAvnNR+KbNxBpKwrB+g1mh27yMNAFeQ?=
 =?us-ascii?Q?cjM4mIO+X+LvxgdpX1tDILHPH0XS9v6h/Zvgt6U7KKJ2G3uoialQjRlc6hDI?=
 =?us-ascii?Q?1/p8ZOkQwTYdKLPJzPKoiqoYybRSDA82qiTGtwK5oBPFvMhs+0x5HzpyHrqk?=
 =?us-ascii?Q?X8+38WGDWGKcpKeID3MniGoV37EirrpwTgzOcK10ISmEN75xBZWH6XlaU+EF?=
 =?us-ascii?Q?F+37i0xqSzUfAbcwRWrl9Aok0k7bs4pAKycv4HbpGVzk3SrB6rXBri1IYewH?=
 =?us-ascii?Q?0Qx/3orHkHW9TAYrdUCmxpJmBGRoo69DhSnEQpYvBBWv8PhPF05rldvLXYM4?=
 =?us-ascii?Q?Xe6eiZlJIJJQKmg8oWpenhfGSaX8Bq/bL39WHNBAOsFrWSiqySz7VulfBz6R?=
 =?us-ascii?Q?koPSHWl+YYiN7+NJF4pYBWmGNcf7ypw53ApO5D11ubAspzE4CeBRSIDVE3Y7?=
 =?us-ascii?Q?cD1HaxzA4fZJ3o7/jtMPiRS0VmrDU4IwF3qKnND7s972d5dyxiqdYFyzYG9V?=
 =?us-ascii?Q?3nMfrCvcLlud1/Muw+WbAh0RWRMs0uDGU9dyJB7QwF4TTrUVnEIcy/hu8gh7?=
 =?us-ascii?Q?y+KT7cjuWjHTN6e526VJmtf3/M5c+JMo33naV5AdCiiue1kyxv0kkIKKO1Zq?=
 =?us-ascii?Q?ach2Qz0LldKLj8YEjxCkVKgSSMkntD4Rt4lsmuyo5/EO5hdecjO9igAo4OYh?=
 =?us-ascii?Q?AaoJBY33QcRdVklPObdA+pBSGTlGrC8zTF1QQoGRdyffQRqEUOsN6+3KYy8n?=
 =?us-ascii?Q?enb7vuLGv6RJwevMKCjabUkX0c0kc0xCe++Jfr9X4BmYmWVsrPosD5Lk0mQK?=
 =?us-ascii?Q?0fIFh/1MQVa5FGFqX7s2cWBmO4/5uOac6gDelq+XmZHP42RQ1YDzEbvBGzSd?=
 =?us-ascii?Q?qEWPTPANJuVtVR1JQ+yeBce9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c9327e-9f73-4276-f3ad-08d958798e06
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 01:28:54.7957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+D0xjRq/ecXDw7K2qAJhuy5BbYwUquExy0S7dmBtp2phJqRjbeok702nk6PC0Y/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5379
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 05, 2021 at 11:11:34AM -0500, Tatyana Nikolova wrote:
> During the irdma library upstream submission we agreed to
> replace atomic_thread_fence(memory_order_seq_cst) in the irdma
> doorbell optimization algorithm with udma_to_device_barrier().
> However, further regression testing uncovered cases where in
> absence of a full memory barrier, the algorithm incorrectly
> skips ringing the doorbell.
> 
> There has been a discussion about the necessity of a full
> memory barrier for the doorbell optimization in the past:
> https://lore.kernel.org/linux-rdma/20170301172920.GA11340@ssaleem-MOBL4.amr.corp.intel.com/
> 
> The algorithm decides whether to ring the doorbell based on input
> from the shadow memory (hw_tail). If the hw_tail is behind the sq_head,
> then the algorithm doesn't ring the doorbell, because it assumes that
> the HW is still actively processing WQEs.
> 
> The shadow area indicates the last WQE processed by the HW and it is
> okay if the shadow area value isn't the most current. However there
> can't be a window of time between reading the shadow area and setting
> the valid bit for the last WQE posted, because the HW may go idle and
> the algorithm won't detect this.
> 
> The following two cases illustrate this issue and are identical,
> except for ops ordering. The first case is an example of how
> the wrong order results in not ringing the doorbell when the
> HW has gone idle.

I can't really understand this explanation. since this seemes to be
about a concurrency problem can you please explain it using a normal
ladder diagram? (eg 1a3402d93c73 ("posix-cpu-timers: Fix rearm racing
against process tick") to pick an example at random)

> diff --git a/providers/irdma/uk.c b/providers/irdma/uk.c
> index c7053c52..d63996db 100644
> +++ b/providers/irdma/uk.c
> @@ -118,7 +118,7 @@ void irdma_uk_qp_post_wr(struct irdma_qp_uk *qp)
>  	__u32 sw_sq_head;
>  
>  	/* valid bit is written and loads completed before reading shadow */
> -	udma_to_device_barrier();
> +	atomic_thread_fence(memory_order_seq_cst);

Because it certainly looks wrong to replace a DMA barrier with
something that is not a DMA barrier.

I'm guessing this problem is that the shadow memory is not locked and
also not using using atomics to control concurrent access it? If so
then the fix is to use atomics for the shadow memory and place the
proper order requirement on the atomic itself.

Jason
