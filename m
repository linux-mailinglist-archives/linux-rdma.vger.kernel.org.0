Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F9146C223
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 18:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbhLGRze (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 12:55:34 -0500
Received: from mail-mw2nam12on2087.outbound.protection.outlook.com ([40.107.244.87]:2913
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229703AbhLGRze (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Dec 2021 12:55:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0BY1RFtbmyZa+K5m6sNkPZqrUjqxhS9OdsmDviCWhoU27g53rSVapAWDP3u2r11PkAyYPrmxVr2qv5+wZLnkUMaU2lr2p2BFCmOAFDbmvSzchxx1V6O4XR7n6stpqFHp5eSpmPdmcM4u1141Wmy21ivjAmBGhOSfcTYNzEEn9z7KEwxgjtbAC53rYhBAeVQBvqwWRmejbzmDgeR/nzK/unxeeVLUXUAZZgrycuzV1hCXrKz6CzNt9m35rJ1RnUS5SiTUmdfd/8yIG/1lMxOMiVzRzEhcA481umoMJ+zI3vI2eGqJttsZF9lz1W1dbv6pmJHhLTWGZdO0LCmfzsV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GnXcCjWbvstPhFM+iIxb3cyb7K0P6JjGU5QMF609kM=;
 b=NFHIbLcFhguhXw7X3DqIsBFKVt76bT2GghtgAzMUyBfd7bYufU2StXQKrX9MGBnQu3ugM8YTcpxzvlMix1YYmA+25abqMOpz9yLEoFTCsZfOmuXUz5StCxDVeCq6rrBc3dM0g7JG4nVQvR2eq20oPLvp3xDJ7vhiXjnh/ikodcOaVAArfUM8sqDXHjG1mVg6DXOdqrrGTdlAn02UJwkjDhSieWcScaoAI4ZHBO3/aZ45PEGWe2Y66VinCYNVVvUVV/U0wZ74wMKpB63nGu2QXW/W7xLqFCDKn/0HOsLO9bzGsdGtYGbhkRQFR1/DOxLkdAIQxvNVUPlaBvTuhplSmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GnXcCjWbvstPhFM+iIxb3cyb7K0P6JjGU5QMF609kM=;
 b=VFFUfDkNKXPg9g+dGCP1xyjLLxEgzV1drV7Ct27vngmCz22U4lF0uo/ob0qXwnRpGIC0TbI//yAlLlALB1DyslaMLD4X47eJK+BMlaAPRIwEZOREHR02v4isJNlGiAuwroTssIsqyjUCG9Nb/w2DS+2vt8TP9Exxk+fNUsiQbXEj4Yaelyjrxpr3pwuIRnWVnnOmFYfnAotrj1gfFxKZghsinE4VHaQNb17it/v+gGEvxK3kaBzDrUIuvEAaUg/Tkm/YNEdaT19srGjKr1gLc7cg3GqeLlUMTiq8HyHr1QhM5Bbh0U8+Kg5JLq1O7sCseRfefGUYVYv/chY2+06XAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5158.namprd12.prod.outlook.com (2603:10b6:208:31c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Tue, 7 Dec
 2021 17:51:56 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 17:51:56 +0000
Date:   Tue, 7 Dec 2021 13:51:10 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: Fix a potential memory allocation issue in
 'irdma_prm_add_pble_mem()'
Message-ID: <20211207175110.GB70682@nvidia.com>
References: <5e670b640508e14b1869c3e8e4fb970d78cbe997.1638692171.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e670b640508e14b1869c3e8e4fb970d78cbe997.1638692171.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: BLAPR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:208:32d::17) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0042.namprd03.prod.outlook.com (2603:10b6:208:32d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 7 Dec 2021 17:51:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1muecQ-000IPH-Un; Tue, 07 Dec 2021 13:51:10 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ffb226d-592e-4b61-322b-08d9b9aa42e9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5158:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5158B080FAE77648A7449BFCC26E9@BL1PR12MB5158.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05NZTiWrwXRIlWOGAbH4BpGlyP0cWFNlIY+ipzghNIVkxP3CpXupqCSTuQ1zHEkfnMPh0PKC6i+bza+7/nAO4u718HAH1j48U/5y14xuAS3RkgHFC/reeRII3g2tAiyz+7ixJ4GAF3ySSw1SKVaykcBFYjVuSbpj8W7YXmRiWDoO3tKnw/sL/CiaQTMK5eh6yJC0A31OJJoPIv+tQknWtfbsPpJPsI0TF59f3Rnpsc2xsT2mgduZrlnX+2UaSR5BlEz0nkCTkQ2IKW1uez8Sk12i3qfrPbNCmSTa2rk2VmpGHhOPfdrXpWc6/k4GaMhllZvcAGl1/CBbxtmYTkBDrWP8I1bcOZ5BFPbDKdxRHX6JUamN+DX0r6m+OBdveMPf1tCgJWwgAGlxPnfpDsI6r6Fd8evKFBgK3HcSwy8PBEaD/UNSjJ1gygmfijg/1QcSrGE9GveXa+tLpqvwmVpUOJ6bWVUQHyRAB6zoSS0i7JsUuSTyg+kHz4aO6GDNFqhO/nbB2Uc/CfU8hTShQ3gfdtcrTqg7HHXbfwqVPboX65WVPpEkGQNsxJK6h0OaIGr93VwZYxILPPsfdpzISOxaE00yRXVoZxdg1F5KDYDocZ4m5nEnU5V7TMrL1Vt8eo4UKUrqnLEhXbV6BASZTSN+9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(83380400001)(508600001)(426003)(38100700002)(5660300002)(8676002)(66556008)(1076003)(66946007)(8936002)(2616005)(66476007)(36756003)(26005)(186003)(4326008)(6916009)(86362001)(9786002)(9746002)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2QzTsOMmNCsnmvQLArU2HyOniohbsCLlvau+RSibgRi+orHhAOrwrU8cEEY7?=
 =?us-ascii?Q?eEkWuEtFHT0Mg/NJSu3RuaqNCPKTaqVRfmIcOvKxVRj2vDpfLp11TJSRC8KI?=
 =?us-ascii?Q?tJWZrwU1JTiiHBiCnz11+lIOa93zWrpzZspl4+0g+wS3qWL3K646ZB3KW5pm?=
 =?us-ascii?Q?WtswLweoCTy2f1uoQ/daHAiv6DFz7gDgkjWNR/Ms6kAP2yu3dXzbFV5ba2Rf?=
 =?us-ascii?Q?YFg0E9QXL+sVs/+6kMNDH4Wmlu+8uO9xXdNTtO+Ftap++BPLCw2a+JeeG6ll?=
 =?us-ascii?Q?XnAFJ4KYgR5RvdRnztOoVMFvFw1VqHtWX1HRokH0FuuknT4JO0WM56Fk1oEc?=
 =?us-ascii?Q?XbsVQQz26JCAuqq2/KtLWFkE27ATTYQ5sKJIXw/QAqSB5HbcCiMcDVNthWab?=
 =?us-ascii?Q?ZvZLOMbcnuum0S1exqeCAPRCleidGDs2gMhpKBGMsi2ffTU4w01341h5o1/x?=
 =?us-ascii?Q?LO2SeH7X0xdpLs/aNdffdY02Osy0fIqC/6CzqlfoOgPwc4pQwRQ1PAYJ6g1/?=
 =?us-ascii?Q?3JEl/0xjIZH0eSKFGaJqoASCXJntricUcPIPrxoLY3Qz+Zro15bfaXw5dRqT?=
 =?us-ascii?Q?cxZcoN717HZl198GDuvvdwQhRpWacUwNmFJMe2nDl3XSUL7QToSke0WVGn0O?=
 =?us-ascii?Q?jLEFcKVnDzFEXewnNFb2YeGlpAaBrSmg5dLxckFn9gQe1HT05fm/+CWaMvAF?=
 =?us-ascii?Q?Z7uiQQb+rwa2cofRrfM+RoQ7e7ARGOV+9UKE+KlgYZZwMZmr3Rr5Ycyx8qMj?=
 =?us-ascii?Q?aoV9tTBgdGrvpagt1eMnzhQLUxQtK4U6iYTgkiw2ygtRtrnlWK6ePA2A1h6f?=
 =?us-ascii?Q?pNBKpe72atgjNwfi65SJ/mXii6X0M/TuJYdFmODonv+b7puqrm+O0kBEEdZo?=
 =?us-ascii?Q?qtS/QImsUqvDBMMQ4jeEn5w6d13Rqc/DxqpHD+Yks6K0QG5xVaTobKzYoy6D?=
 =?us-ascii?Q?bvBdI0VpcFtgUixYiEbd/M+rDlwbMoXMko5evloIK4pfdRz3V2UIXORsqoMR?=
 =?us-ascii?Q?EMLAgNAQ3gCR9vM4gVPrkx+kuDg2+IFbwr1j7flL5SLAoiMTwKC6h2FcCGxA?=
 =?us-ascii?Q?vzSuhkjlMHSVh5+yaKnW0CPC+HjWwtONkeQBPpGUbNofbES5OxhNczBbwN5u?=
 =?us-ascii?Q?YWSrbpp3kFxf3XhZ8U2CYHHMSOhfgWtT43Az3cX47pjNU2KmB1L1rWJsmjZ4?=
 =?us-ascii?Q?/yNxZEdbKI21feda5mnF+7LL+xiSsTy8MO6RxBjtALfO+8GBR7bfU50/y4X1?=
 =?us-ascii?Q?iiQKNfqeUOFxNmVuQakgJqyP07uuYgwywpynyMkXqi3ppqEXn5k1+7effTz0?=
 =?us-ascii?Q?5Ewcsmm7R3dOj0aVtOMQN6ZObyVvnyIRL8RQFkwfht/CBO9ZtS9TLl4Jow6J?=
 =?us-ascii?Q?tDWvjbkvPAB4OyZxTqm3phgwQhEY2YSxV+IBKxnYm3y1QH6h4N2YITG0RyPB?=
 =?us-ascii?Q?Rn43Z+jY9i1gjC2Zd0BiA618zPM8bEuBew84w3pikBb+xvhYNV06SEo0wmQB?=
 =?us-ascii?Q?xjfcmstw1OVa0IjEOogvfcg1DUS7ba433hqvfpAI0tMSljT6JS/LL0NtBocf?=
 =?us-ascii?Q?RhwkDFsU+Axg+b2FbjA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffb226d-592e-4b61-322b-08d9b9aa42e9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 17:51:56.8887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCMcc8erYHx7U5YGdGAOttU642NPeHaaROIJ545JTSpQowufxxnFz6qY9LpzUIQq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5158
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Dec 05, 2021 at 09:17:24AM +0100, Christophe JAILLET wrote:
> 'pchunk->bitmapbuf' is a bitmap. Its size (in number of bits) is stored in
> 'pchunk->sizeofbitmap'.
> 
> When it is allocated, the size (in bytes) is computed by:
>    size_in_bits >> 3
> 
> There are 2 issues (numbers bellow assume that longs are 64 bits):
>    - there is no guarantee here that 'pchunk->bitmapmem.size' is modulo
>      BITS_PER_LONG but bitmaps are stored as longs
>      (sizeofbitmap=8 bits will only allocate 1 byte, instead of 8 (1 long))
> 
>    - the number of bytes is computed with a shift, not a round up, so we
>      may allocate less memory than needed
>      (sizeofbitmap=65 bits will only allocate 8 bytes (i.e. 1 long), when 2
>      longs are needed = 16 bytes)
> 
> Fix both issues by using 'bitmap_zalloc()' and remove the useless
> 'bitmapmem' from 'struct irdma_chunk'.
> 
> While at it, remove some useless NULL test before calling
> kfree/bitmap_free.
> 
> Fixes: 915cc7ac0f8e ("RDMA/irdma: Add miscellaneous utility definitions")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/hw/irdma/pble.c  | 6 ++----
>  drivers/infiniband/hw/irdma/pble.h  | 1 -
>  drivers/infiniband/hw/irdma/utils.c | 9 ++-------
>  3 files changed, 4 insertions(+), 12 deletions(-)

Applied to for-rc, thanks

Jason
