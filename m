Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7FA45DFB1
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 18:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242858AbhKYRbK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 12:31:10 -0500
Received: from mail-bn8nam11on2047.outbound.protection.outlook.com ([40.107.236.47]:5056
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243166AbhKYR3J (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Nov 2021 12:29:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbGA1Km5s+YwPLeT1Tyrah+AtHkTczkA/HrrvafF8v2eIWaSei9VA4JzRyYOxCI9Ft99idc34WbvdtzbZ9Fxv2X6agOFYzFHGtC91n69DOoFD2QOGTkPMZdG+a0CfNc/6+oMYh19c2vz+PMOmq7Q2frKv+baKtpZnJdpMkJRAKVaSl2o5NYzPPnODfLpLtNkLrg71g59n05TCYTXuoo69l1D9mkPjYtbVb3sfuC9xi/Gi40t1JPghMnKJUIF0hzaZl8m3V2tBJPz2JlSVOaYA2HXnxGalPxqTF5qnzqgGY/upa+4onnUCKiYUO2UXMd3mf5soX83kpP6xFZXF2KTMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUwhRS1NSjakpGpsSUuioAq8yb1h9ovWW17YhCTIGCQ=;
 b=H3u/R1o0JoreEsAMwVV7xeASh1gJAnLbGQgTLVKkjQbCBekM2iMciKzDA+Y3KdM/Wzhy9PU5aRACa5NWSa3Wv9fAn6SXrAm4vkmKIGtdazEJBnIaR7w/Wl5r/P9HnGL/yCIt3uG5YMb6y0Bd/EYTnFZwFnoHvLo7oQXvGmnfaXerJliyPmYBObf27Zz/cB0c9dRMyhV1GOIzII5Gjmo9L5MMZA/jG3oXcj6PePReAy0D+vL7dNt3mBNXVzK5gGjwefTV2Y2EA9TKoohg0pOZ53vgAfBxV2gbfioyuediaTZVb54tmqernTsKzysoruT26gBXYhwxBcwxwcgPPtShsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUwhRS1NSjakpGpsSUuioAq8yb1h9ovWW17YhCTIGCQ=;
 b=MoywvFMBaSCmuJhI0NgkQVUFa3b69Bm6yyXNq6mzn8pZ8Wqiz4h7Xry3nYPIsIAO5Ey35QZYeHhwn/t7UOY/YXs5TkaQFsmeJQ1qGq3x8HtAmHy0+UxY50PEMTbkeH1h/9RIotxlUR/1fN1q/QOg3LuGA9WkWirxcs1kdSgDQddBiLqDPrAiksucIoA7RTGDkhOuzwSZpcZN1wfMST4t7c2SKIDzJbUZhpY9sHy69bLt/u2eTzukE1bRoc9FOx31QaQ/mgVXELsI3xnKt8mJ2ldQzZ2A8CKIBr29AvqOdHqWqqMWMJxPtmyQynRKUYNoug1/87Fnzh2evgkq5F1iVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 25 Nov
 2021 17:25:57 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.023; Thu, 25 Nov 2021
 17:25:57 +0000
Date:   Thu, 25 Nov 2021 13:25:55 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     zyjzyj2000@gmail.com, dledford@redhat.com, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+aab53008a5adf26abe91@syzkaller.appspotmail.com
Subject: Re: [PATCH] RDMA: fix use-after-free in rxe_queue_cleanup
Message-ID: <20211125172555.GA490586@nvidia.com>
References: <YZpUnR05mK6taHs9@unreal>
 <20211121202239.3129-1-paskripkin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211121202239.3129-1-paskripkin@gmail.com>
X-ClientProxiedBy: MN2PR11CA0023.namprd11.prod.outlook.com
 (2603:10b6:208:23b::28) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR11CA0023.namprd11.prod.outlook.com (2603:10b6:208:23b::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 17:25:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mqIVP-0023dc-Uk; Thu, 25 Nov 2021 13:25:55 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b638805c-b262-4b2f-13fa-08d9b038a418
X-MS-TrafficTypeDiagnostic: BL1PR12MB5128:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5128EC1B53903B610245FFBBC2629@BL1PR12MB5128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dPdfNeRkUxHyGPOGl/y9nMcJxd1yM/IpaGiAAjG7CFVnY0SAse+zQFdChBJTXS1r3ujkV+oGZIrwbCgRdM9OLBmTqw4g1jkedL8ibw8xGnTFh7ubUpSC++KR/uX94uS+o8I/RLfNfYyAgh9KfYrlOt2wyRL89Q/oBd5zRLG0EhxXjmaJwcF0QPoFBoSe1QFv4CgkdwN0wWJAPqxBEqWBA6XTlT1Xs35KTdkdvbYIaiGO626Iz/W3eLdtjKSNoIhHwXuWWGxt2UD8AhrBR8EN8lKpcrN2WNP4v2DFKGgJ5qtpSN9fROat0AkZf9mELHQOpcYSreqhAhqe4VzNzxNxSDxfLCPqapw/gMljpNJIVEcRlVrYZriA+7aAmsrIFMH0enBAUbZ5AzEQAiiIWC5CSNJXfXBo88R0W+v6gJEhVHDrY0m+ZqJ56uihj9mjWTRpztIl8CsAv6aJVObLJKm4jNbOjRE4YIepq3QOz2GQYQJQy3eMhqGaiJwvvsN/WWNnZUVhYzpLODjC8nNgpKIZfdgV6EMX1LLyKMspzUxgucBkA1qvcHrNxGHCO4vzAv6j1WXQbvOacKlwKFi1myYhee0QtDpQpnhMCk9vEv7lSAO86y7Mb57sBGVmXP0n9hRNBUnedf77Qb9X10EeWn/O9OUypfz3CK1+hvdGLezSc6XtDS34Lw3p7EdTZw40jOqooUpkx3zSMzcfdKxKSvTKbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(1076003)(9746002)(426003)(33656002)(6916009)(4744005)(508600001)(66946007)(2616005)(316002)(86362001)(26005)(36756003)(9786002)(2906002)(8676002)(38100700002)(66556008)(66476007)(8936002)(5660300002)(186003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9n3KIPl6Ar1DRMIxmmtDwDPneywp+m3mFQ3q23jIY992MmOGzKplHd8VUrFP?=
 =?us-ascii?Q?LVwrKYt23anfzZ7pkx284WBYKINsyL3zS0qPmhbWdLEWN4XW4ylv4BDCiPbq?=
 =?us-ascii?Q?dxHstLCQcdHKGQagLuXzpg5Wkb73f08bIaw6MInRwTVZ4MOwUZl3kAS6mqBH?=
 =?us-ascii?Q?ajB/YqaBG3k8miBM+uvxWcRQSeau38/ltRzmLkSvQQHcqpEDPFZW+Czpt+rX?=
 =?us-ascii?Q?vqMvMm0dFDAFotzEd3sM7LSZacs9UCT59IcLpaQs4fgy6qJqV4pSN+0tZLZh?=
 =?us-ascii?Q?QlJbKIGYOquBXbBh3jRrdL9wFnX5RPtuAyAsDKOUzGlJM0d/4vUHZaEaXSjz?=
 =?us-ascii?Q?mDUra3lgJtvtwJG4pq1rh8t9sZFaN6r27P1b/BDVym6q5+JSysmwC2UXhgDj?=
 =?us-ascii?Q?SXBxl+T22ltJXNY6BqYH2G3hUz0YONKlCbBbOCeIERs07PuLEST9+AwbdY7E?=
 =?us-ascii?Q?3ac4n5DcdrDgmuue3A4rmXsv2sfxU9VSYAQqXKzueK/a+QiH95HzxkOcginH?=
 =?us-ascii?Q?odroFsovMAEi8g9ZyFn760XElua0FTrKPYvtJL5b7/x613BAIqKYVypc9EsY?=
 =?us-ascii?Q?12uuBTMtfXaDElfsiL4+mtC2rdptiM9GDnXPsiz81NRRhFUaMXinbDJ2UTm3?=
 =?us-ascii?Q?eK/PThvwZlpOcXHTPSfK3+3BgXbrwu+EZFwxDTQTpHD3ghE96O2/B9+gR5lI?=
 =?us-ascii?Q?YDrgrJ8DHIJuMtZWtXnXFAdoOAWnGyKKSDtrbOdWGx3NbT8FFY0F4iol79Ke?=
 =?us-ascii?Q?98hDJ3iAe+qKIgTAD0+TPZBOq6Z2wGA9vxH6+6+d+pXgFQEul4KLswqwSgQp?=
 =?us-ascii?Q?DMmPPPUuqTid0xQ9XqeKeVWIZO3jCMmqtH2bP5/2fQ+x1GY1npRLnXMW65PX?=
 =?us-ascii?Q?OYycIqygVJizD1af0ul4vU2V9/Zf+BGKl0y4yWImtfcKHxiJi7iQ1hFYcQJ9?=
 =?us-ascii?Q?K7Nu7IQUMHfJcgnC/cGHuvDkr0NN7K14SUs3OqQuUrKKUEMT+/natn2ZV6ts?=
 =?us-ascii?Q?BBDE6ydnyAUlceoT6C7twiQxAEt+a2wExPI4Q//HTh6UlODCHD8jAUi9A06a?=
 =?us-ascii?Q?u12PPI6clNwaoUMxPGoznvol/F1mpwMFvWzWQ4tDcAhP02iIMIfG4WNz11HP?=
 =?us-ascii?Q?iDaLCI9zOvLA51rl5gJqsiBJg+Z8g73K7iTapfMtmldIuvkPysjEVs/T8yuv?=
 =?us-ascii?Q?e2g8rBai/7NObzjVIngqNr5EBpch3qeFBVkX7WBIwvfuwYxBlRHU18urnaoZ?=
 =?us-ascii?Q?LuDkd3Htq25EeJAiz7jHbIageCIrCkHHu9URpPwTExAr/rw47aNM7KBzormW?=
 =?us-ascii?Q?l933pw9aLFCNNtC6tmO6F1DAxd53xzvFQE7je+a2Hy//CUDKBYKJ2R8UrOuZ?=
 =?us-ascii?Q?UfUS3yxiolmFDyOHR2LMfvgp1lxYIWhDU5cRLVHqf7JYYSRUVEb0hvHju/Jv?=
 =?us-ascii?Q?P5litcKSgQm4VZulJmkXJa0jhg9hr4rcqhBPAubBir5Ue7phFtrZgrmKdZiR?=
 =?us-ascii?Q?6uPGeNdFfiweZvQ63LMFiuusvK9PPhUUP5nHod5+JcPkaJaDd4akWjtUQ9wI?=
 =?us-ascii?Q?V18VUv49rcW2wYYevlw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b638805c-b262-4b2f-13fa-08d9b038a418
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 17:25:57.1277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ks2xdzbibZWMWBnHgNbF4Hmoe2KsmFYRLUjXWNTxou/HaW5vBOwjpAGlq9X2ph8W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 21, 2021 at 11:22:39PM +0300, Pavel Skripkin wrote:
> On error handling path in rxe_qp_from_init() qp->sq.queue is freed and
> then rxe_create_qp() will drop last reference to this object. qp clean
> up function will try to free this queue one time and it causes UAF bug.
> 
> Fix it by zeroing queue pointer after freeing queue in
> rxe_qp_from_init().
> 
> Fixes: 514aee660df4 ("RDMA: Globally allocate and release QP memory")
> Reported-by: syzbot+aab53008a5adf26abe91@syzkaller.appspotmail.com
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-next, thanks

Jason
