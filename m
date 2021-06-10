Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADAF3A2BD7
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 14:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFJMqx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 08:46:53 -0400
Received: from mail-co1nam11on2041.outbound.protection.outlook.com ([40.107.220.41]:25377
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230001AbhFJMqw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Jun 2021 08:46:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGfHX8bMIZ7KN4gkyVaTtMvCOPr9NoJbSGoV/HB0UWygKTwT1ysMGCWsSn/6h8j6KGjiDTee0W5eQyxq6ZDwIOsIxIR+itzeKfwovwE0x54l0YLFLdeJF0Uzsmo0wjrNzI5xZTyCwrEhk120IGGhs3MoJj6WCwTa6/b8q298df5soIkP46UlwXfU+Sxpq9bnkkxnfL+vbycgtcJqA4QXlr1GGdizOG3I21R80UrAT0Nw0BmDuw7saKpFSAGw3MFSppbwidcpZMmUrfADKHUNpnYGyERutTh2gnpWAJ+IeDMj4UmJrP3cec4nLeE8v3T5cGKbjM6fRd/r4vIqG/a0xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spKCA/3liZjDCcrF2K4w12W+bB+fs7eWlT+3jqg3jzo=;
 b=hNu+vSPqXZYIS/qhj1/diWv8qolq8bljDM/JZ5TC8Cx/ZVK6laapb3SK6xDIgjAndgJWkR4wRWuHZ6xTNJVLPghnvdrEH369dBhQZJSShZpso6loBbv0l1rHkv29wuIZGUB3sHmi982taaRQTH9ollJxmSVeSjIBhTHse97nODB5Y3Sisge7di5IGpVPs+VnT9TrtX3251haTVmmBUhojMfnEtITS9iuuUTSP3Lcm7Yf1nGJP4Of3K4CdLUKXbWAucVAcKVyk1WgfWxA92DhWnNCZRJADqvdYnUa+EsjC6cu4qENAMEbHR6rFnli1YFTQJeeVOQQifSwZn/FriF4KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spKCA/3liZjDCcrF2K4w12W+bB+fs7eWlT+3jqg3jzo=;
 b=IGz31pPJpnYQ2KDH62ejuO1pbqTrmJDbcONOHJ6Jsw8Ibgv38CphvR2mVKA+FK9KUJ3pHcLYcjrivTiNUr5zGT/KIsShuGuFjosbSZfwK8IklX/l82paCoWalaQTFGl8XVelanOf6T66QwXy8n81OcZF04a9zbjvX1ZVAWsH+scLqJ+4f+qY+mtkbwDWAwK4bWtp1OuMM/QJXlDcrQfNo4vLIBiXvrH4Yt3hxzuwwAInF7wDE7jmAQDiTo2F3hSpLYPkbFLeLIZVETH+SWIjw+O8oG++Xmj1tl5vV+YlWssUyS7kWLEdzEFgyJd7BMVS/LnD59LL6uGd2tC7N4gXpA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5272.namprd12.prod.outlook.com (2603:10b6:208:319::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 12:44:55 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Thu, 10 Jun 2021
 12:44:55 +0000
Date:   Thu, 10 Jun 2021 09:44:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH rdma-next] irdma: Store PBL info address a pointer type
Message-ID: <20210610124454.GA1264557@nvidia.com>
References: <20210609234924.938-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609234924.938-1-shiraz.saleem@intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0070.namprd02.prod.outlook.com
 (2603:10b6:207:3d::47) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0070.namprd02.prod.outlook.com (2603:10b6:207:3d::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 12:44:55 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lrK3K-005J0b-CT; Thu, 10 Jun 2021 09:44:54 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8f75307-e517-442b-ae87-08d92c0d8c68
X-MS-TrafficTypeDiagnostic: BL1PR12MB5272:
X-Microsoft-Antispam-PRVS: <BL1PR12MB527278F041B457FF0A085986C2359@BL1PR12MB5272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: negLsACjmU7v0cyoCHthd46U2oIXz/Mh6nhaPY56pd5oBKMLVNae05rtVAuNN1d1U+ENsCORnDEd1cuWeX6NQjMBzLIBLzBTKEHgiY2kDRODspxV/QkC1iwLNtiHQae7oqOIMY+mR5ZsSGc0V34ueCK98mBqUUiun7Z58n1aFdRKTpHQ400LHR76mL6UJJJmuo4P8obLYrNKByAr8Ux1Z5dVZeNYFTuLbvMOi16OB8l1f8p0k7bHE2huOqwMjrIpHbk+29gZ2aWi+r0J8KWoJPDG1nDU2RjngHwyUMhZsxOiuokfWTO9Oy2go1gLO57loRQmAy+FPkChYqsRyWtz3XyMxGjldIJ4SEVM8uT68wPGDRVWIc2rzYn4/hTZb7UijSb/pZ6ZmSJXiTQd0AF4A2OtTQDFpt+3umRiLcjZNiKKflItWAiOcl/hBbea1q3M73jt2QbBx8vapskpU4ItrsYUrjLueYhuRicOfC42MSB6oS9AJk28JuNLCrz2zHs7o9xHdO1OkNVPctS1miECv9h0SPWWmDkXgSyqieqb6lQWor1KsrOttU9qOznsAvIPxSTfZcNtipSUcpQrQ1lo8+oN+PPBsNvaeoTxInxfYd4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(83380400001)(8676002)(6916009)(86362001)(26005)(33656002)(4326008)(66476007)(66556008)(8936002)(2616005)(9786002)(1076003)(9746002)(36756003)(426003)(316002)(186003)(5660300002)(2906002)(38100700002)(478600001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U7n4w8oO/Z7RNmGblWi4fRQZaC32BGzoJq1YeyT666mBXentwu93BGpuJnUi?=
 =?us-ascii?Q?VU8XA1EOY/2I1KLnyVPNbZKaraScDfUXYeVotXdIJ/aQqa4zxU2M0zd95GsO?=
 =?us-ascii?Q?PMR/XetSbj2IDSPhKcNHnJdyBMwG0hBH2uN+Pjcwd22q5h/OCRmBZBGgnxVx?=
 =?us-ascii?Q?+mkS08PcAa9yTdJFfaOTJ49Mzee2ia1Yf1AINGNj3lalbyR2TEezsiOK5bUc?=
 =?us-ascii?Q?EuDQiTEzD0bGeuowDYZGJKTOCO0zAmXl+ce3obRfry23Msw1JvfRhBGGFRV5?=
 =?us-ascii?Q?VDGhp+F7ysHu/Dor7uzDfv9r5RrIzqr9GLIqaQtRV7wSsL/jESoMY5dVAV73?=
 =?us-ascii?Q?M36BOqj+zXrbfej2vYIIyPp5Bu6c2WsR9jXxXnWRzVui2Ds4XZdS727xPrtg?=
 =?us-ascii?Q?JXzs5btGNgHCl4GpZL5PUGYKePLvkxvdWNJVsDc0qZ26ANT+Ip5eiHAlVsoV?=
 =?us-ascii?Q?94crCpFb6AFE98DHxNHpZWQNnWvPUb9X2MSrZpFnHkqaGlK09nj6xcY81/f4?=
 =?us-ascii?Q?Y9RrJVGQJSfEnUbX6QegMOmkNsDtkMcnpDlPP7tPeGpI1rMIwkhWl6CqluJ9?=
 =?us-ascii?Q?2WVDEP9fz9V2QanphZVKihGmSEIHhsPAd0b9IUu5dddIn5s+1HoQTlDy4v2G?=
 =?us-ascii?Q?92xXUMzJcy+JdHFnjeTTeSKsySz7nWhHOSlglM5tPMUy2iZNDzmf2X8X74e8?=
 =?us-ascii?Q?Lkdp/CsTgd2IjU0JWSNxsIGTBbw7GAtiwvxX02mqPKTyhJYh/1NX+jzteBcS?=
 =?us-ascii?Q?aQkSDxckpsAOz5ozi/8x2mJoh7T7RSDEnpFTC+1OsRCWS0fyW0sOt56DbgDY?=
 =?us-ascii?Q?3lkoJ/WrJ2YmZqzPq9Whp5KxDD+jFb1GXNHpvH3D7zMVpKr3PjasOhBdMxb3?=
 =?us-ascii?Q?zkhMrSG+GvgYxM0gJC/VopQCLzH3Zp3miexR1XNOhAPCx/dc1nkg6KBZF5aZ?=
 =?us-ascii?Q?lnoyr2sKRqga15t+kb3C27xZVoXmje5wIddMVqLARUNKDuKkP2zvvZGMFVec?=
 =?us-ascii?Q?Nd/A9a7gC0/8e0c2UUc0WQ8HNOFcx9CFYAHDUMa1sazvzYiDAvDJ4fu4b7vR?=
 =?us-ascii?Q?ZknF1ACL+JO8mBiuEhYuB8K0p98iZzGXxtAkUqUJnYyCYK5Q3tEXA8WbeG3+?=
 =?us-ascii?Q?DqOirWwywSki5l20yvDS+iLwvc6rzzrSH3qugKMLUToy2PjprU+EuW0qfPze?=
 =?us-ascii?Q?XVU+NSOtwkfTQPtS6Dd0kP2lnZVR6oNHeyeLjTRc+4SbHVTDAXOBfo3qXM2I?=
 =?us-ascii?Q?Cm3D96/rpxQUPf7jrPudF+i1xjZCnaBGvtgDWZTSR1hQV8r7x3M1fb9+dmHH?=
 =?us-ascii?Q?bo0hsoN9/IOLToGEkBsTek+h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f75307-e517-442b-ae87-08d92c0d8c68
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 12:44:55.4420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+7wYU9wHV9PFBBMDuAw8XMwiINT1Fb4pAidlShe8gdNWEDoBl3v4NwCW/BhqP8x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5272
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 09, 2021 at 06:49:24PM -0500, Shiraz Saleem wrote:
> The level1 PBL info address is stored as u64.
> This requires casting through a uinptr_t before used
> as a pointer type.
> 
> And this leads to sparse warning such as this when
> uinptr_t is missing:
> 
> drivers/infiniband/hw/irdma/hw.c: In function 'irdma_destroy_virt_aeq':
> drivers/infiniband/hw/irdma/hw.c:579:23: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>   579 |  dma_addr_t *pg_arr = (dma_addr_t *)aeq->palloc.level1.addr;
> 
> This can be fixed using an intermediate uintptr_t, but
> rather it is better to fix the structure irdm_pble_info
> to store the address as u64* and the VA it is assigned in
> irdma_chunk as a void*. This greatly reduces the casting on
> this address.
> 
> Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitions")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/hw.c    |  2 +-
>  drivers/infiniband/hw/irdma/pble.c  | 13 ++++++-------
>  drivers/infiniband/hw/irdma/pble.h  |  6 +++---
>  drivers/infiniband/hw/irdma/utils.c | 10 +++++-----
>  drivers/infiniband/hw/irdma/verbs.c | 16 ++++++++--------
>  5 files changed, 23 insertions(+), 24 deletions(-)

Applied to for-next, but please be careful with the commit messages,
the tag should be 'RDMA/irdma' and word wrap to the standard 74 cols,
not alot less. I fixed it up

Jason
