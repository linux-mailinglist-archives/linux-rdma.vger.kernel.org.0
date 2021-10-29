Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55954400F0
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Oct 2021 19:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhJ2RLL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Oct 2021 13:11:11 -0400
Received: from mail-mw2nam10on2048.outbound.protection.outlook.com ([40.107.94.48]:5472
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229732AbhJ2RLK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 29 Oct 2021 13:11:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Om2HZQ3zJDvdVDxYqlRyCYnhCL7d1CbbzVqq/b/9EUyyDY52Je1oODxHBEXAM1VXOoFfUPR1ts4xcIbhStNK2MiUQuYTx98a1QZ4M/0W8pcNuxl3BepOBoBd/qYuFbTm/UPMO1wiEQFrdXN/O6CYdwXRMmQoLLCgjHV/tCAxCpBZ36af4Maqk9Qii21PycYsJcXlHuNOwoST0MgS1VaD/YTm0KdgtGa7Ahc3OKZpR32i5BDu5O8dpLEum9ZAbzX1+4AwHPEsZenhbgJuKH+m8olmj/DaS5ERp5GgiIIzJjobpt+MOjxqXWrQ/M9DlVT5mGh8oChhPK7tu12kmUYeiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbWTKy9FECMdgS9R4ubLJDxoDoNT06FOLqWWvkgPrPo=;
 b=cgKRp6Roy0V2evyfeMYu2YG+9QPB/H2cSQxa7mJnQHrYJdjsA4V/y7qqdaaFxhK6hwDKBIsILqVp9ALM9F+uDC3+j3uWJXox68yZgLovqMJl5ZtbWgfDZ13GMTyD6DOXL+G6dJKthrmCSGzfPvtFnC9T5aRMlsl4Tdds/eFlNjp1R0Uj6QxTS4c2mJXaTh7vksZeQuwUuG4BtR8MRe6Mo/Zrme/3ZkYhk+YhZv5qrgqOmEUTeGZGJzZ6uFK+gXu4B/hLVHu/6Pr1UxBLxRzd0+pRyTK3XevgUgx/VlWLVLeEfFqjnOuuHk+v22FCIncefFzX9YDSVm3EYV5eaQYOQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbWTKy9FECMdgS9R4ubLJDxoDoNT06FOLqWWvkgPrPo=;
 b=W6YBAEB7Fy9hm8JWDiIBaXWk10FqluWCqAPBqLZI66uO7cJdclkBIa11D39+P/cJqWSEYzfMWt0cgPlPsM3LK+yJKkq1l2Sv28Fgcs3udaETpyJgd/IdWSQw5XTRUyFZVonmtgkJFHucDwYktrUbrsGeeqmCthxb7SOxX5sNEt1M6L1zfM4HV7k5eWh0uFopLHbCv/mVN9da/FqbbbdRvoS1857GkvUJnrPQqjj0DyMPAH/UvFh5A90t+KxCnrlmO58+kBzwWvOUQA36zcgQY78mjgWlOKIzKfkk109jFdc+Ncp/c2yHkd0Fr+/Z5Frgu5IhbwZWj3KNzqtB5JB5dw==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5285.namprd12.prod.outlook.com (2603:10b6:208:31f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 17:08:40 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 17:08:40 +0000
Date:   Fri, 29 Oct 2021 14:08:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v4 for-next] RDMA/hns: Add a new mmap implementation
Message-ID: <20211029170838.GA872068@nvidia.com>
References: <20211028105640.1056-1-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028105640.1056-1-liangwenpeng@huawei.com>
X-ClientProxiedBy: BL0PR02CA0135.namprd02.prod.outlook.com
 (2603:10b6:208:35::40) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR02CA0135.namprd02.prod.outlook.com (2603:10b6:208:35::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Fri, 29 Oct 2021 17:08:39 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mgVMs-003ess-Db; Fri, 29 Oct 2021 14:08:38 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7db537e2-9fa9-4523-8a5a-08d99afec0fb
X-MS-TrafficTypeDiagnostic: BL1PR12MB5285:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52851A22AF008A4960712BA5C2879@BL1PR12MB5285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JhQKDQHRRVZOiKAwGTQkEuXaZGXZ0tn3BvX6EBbMmZEjQ4XXmGypbC4zprsrMrjkdzi79XfAl/99jE4p8c8+w+6USkFlCTYP0Dc6w3J/tmrJQ5di7G+glZoWBIsFNiNFv3s2SHAfKvoNzJqdDIwwK1bD1M5QLub7F6+3vz3RmtMMjHENf1yUAqdFiZ62Hgxg5V1J+k46CtMJMHlCm7/Rnan1Wu7OsKtRqMqWdke+KaEuDKbEvknxxWykMOT/mFNKRy/JANy2fNbK0SwS2+a9IrT9fB8ioWC1mV0L1NZtwSKgSiSMNXNuuqkcxClLQC2e0k+s2ZGawNudLWCiqfTRy7JEsW8nnvZTrSWA8KrDLvB/c0q5LBRvB6QJqcqGm+tuDRtkcaHT1qJGc72JYpgdstFWCQ0dJca5n8ZhXcGOCcwQTFhDSHQ0t43+NkBBYOUAyC1M5V/haMU08Yi6yHMfC1lzBd5Mxioi/UE/H+2Wa2cctN0c7vQ64V9diElaFSxNcffuBxlWLsTNoa32FxyIcKPJf49qbLvNJpnuFNO962Od3gYJ54u59fjZmoHkWxXxC1Sxa9SS1r0CjFnMWsIPg2c2UeqYXVX8sd2Qx98kNvPphV1botQM6HcfNCmXlXIfESpScfouBF89ihah8QVtwq19hhOBwldmgGlCxi9ZKkq3DmIgSjqGqKjimNnFIn2eTig9YYbC4bcEcXh51M7VVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(9746002)(9786002)(33656002)(38100700002)(36756003)(316002)(6916009)(83380400001)(5660300002)(26005)(66476007)(508600001)(1076003)(66556008)(186003)(426003)(66946007)(8936002)(2616005)(86362001)(4326008)(8676002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v66U5cCDfQL9oQJw7nuUmXWUJB+GvlFcyQEbS8+602qLJw3aXrVgifLlxPAz?=
 =?us-ascii?Q?+6mXR2fUzPYZ2+sAS+TPWBijjZ3UsMgW117HgbduIsrcYONbVo1DXcf/CwFQ?=
 =?us-ascii?Q?yecIoAg49GsKTnDnH0/KGA09QbGTsXP6/ftDwT+A/VUbmaA7GBVgJ4jEfHwW?=
 =?us-ascii?Q?fWGoF6OKMYps4yiTb/C36BGyCTDDW2EyUWSMMrBP0lpGud5uVybZOlsJg1nN?=
 =?us-ascii?Q?r9vLICRtc8V1fgvsRCif8LijVO058cw2zZQSbxC8AlkV63zQryEV/wiG+7HF?=
 =?us-ascii?Q?e+pCqQJKZthoTnT8HQvuOXwP38EoajYtr2oSUnyN5+Mwfy19j0qvF014AK0z?=
 =?us-ascii?Q?Lx5lzpfbQzU8ijkbN8WnZHfuGSSeLCgKL89hoSFBAWF5chmY6MQXp8etUNIZ?=
 =?us-ascii?Q?u7sLbjd6IKWpwStIwy6m47+bPxk/0mzP0R/+HEAX41htVi35MBDgwwEO1ly7?=
 =?us-ascii?Q?4QsUz5iCPVzoD8ZZ8gX9CIQEUz8tDkF+E4+IwDiW22NEmJNElqbDnZRccrql?=
 =?us-ascii?Q?Nw5U1jgow1zhf2zpOy+bxK42nmRfdRoJl9wsDL09MC6xgczQGPgSBbo79dwr?=
 =?us-ascii?Q?Lv9DZgPpCRwyEkZ65p1jXGowi5Cg8vQyUOWuQ/oawZ5fNDDSUPna1CMbtlXR?=
 =?us-ascii?Q?pkoYxk0RTYgZS6duhKarnFeQ/aHroOiPWS4H3UQk9uoUv3FIoLGlUvy+pcZP?=
 =?us-ascii?Q?NHN43rF9csFRRw3eNLdbjjSZLCfNUENAiYRTnQ2qYv4BiPpklKoOUSzuyc3i?=
 =?us-ascii?Q?n/e0Dv0EnU4eefHCxtLSHZEK2Ag/vaN4sscdWy2BmDVP1Iwl7LwhoNJXQpa1?=
 =?us-ascii?Q?IjEU65Qui6CiYbPc9qJ/U0N4XhSfljmplqIWxMVIK+ME3QqkKdCLi4/pptE7?=
 =?us-ascii?Q?kw/ken6mecVvxusfBOq4OIx/EsQFIILMrbzR4qSLcXWJVslYjDuH7LE2oEjK?=
 =?us-ascii?Q?WTqSjadG17QE83mWs4Ldjz8HLNYlJ8Aaa/uRp1dKJMbvwQXQ9PSnheVoJf0d?=
 =?us-ascii?Q?x2sYIHhJCqPk5WQb5OxJWVPGvP1pJGYVfEh+IeRjoHobmkeD6y/i8n0HBuNF?=
 =?us-ascii?Q?Vhlw+mF1jRkWMdW2mKzl6eRO1DWSXnXjglFby8BzU1i1MMLT4HR0vdV5D7Lc?=
 =?us-ascii?Q?PBVkr0ATRTbLImPsVc/7pv6iHtrXw8RVJf1sOb09o03C2yaTogFN/B2eJvSW?=
 =?us-ascii?Q?FHrJ7UAt6dULVR+EyFvcClLSrvZrGFN0RUfVQm9fyq8y5E2iiPw3Rx11U4H5?=
 =?us-ascii?Q?JC4Er6DQ74wItnXmBKS1L8JN1S7ljkT251VNtKYm3xSz9kFaTjIlu4dfvC9/?=
 =?us-ascii?Q?eSVXuKNCisAM8AHDm78P5rODgmgnXd13wvYVliJPUD9/tWvMKPOYJ0Pa0GpU?=
 =?us-ascii?Q?cdl624iLOYEfcZlE2bRxXJlx7UHn2yFZIlEfu+As7zruvdG64qO5uqKlF/Pt?=
 =?us-ascii?Q?BvcJM6tPLqOQ5czPmVK1spkOSNySJ5VeOWsNqQNJ0g5xNw3mUbbn4UO2dk8P?=
 =?us-ascii?Q?XVVvS8J+JKh45c9c9xf1j7zob9uR1weddGdHiQfE72twXMaPDN54c+RiYHEm?=
 =?us-ascii?Q?qs/GTNCt0RAhc7iEDEU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db537e2-9fa9-4523-8a5a-08d99afec0fb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 17:08:40.2245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5FpGdTrYXtIjZGtXTEEhaF3h2neTZWTkKV8FkozMpVU5xHy9r2YoGxzVKvwSXJVs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5285
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 28, 2021 at 06:56:40PM +0800, Wenpeng Liang wrote:
> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> Add a new implementation for mmap by using the new mmap entry API.
> 
> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  23 ++++
>  drivers/infiniband/hw/hns/hns_roce_main.c   | 142 ++++++++++++++++----
>  include/rdma/ib_verbs.h                     |   8 ++
>  3 files changed, 146 insertions(+), 27 deletions(-)

Applied to for-next, thanks

> +static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
>  {
> -	struct hns_roce_dev *hr_dev = to_hr_dev(context->device);
> -
> -	switch (vma->vm_pgoff) {
> -	case 0:
> -		return rdma_user_mmap_io(context, vma,
> -					 to_hr_ucontext(context)->uar.pfn,
> -					 PAGE_SIZE,
> -					 pgprot_noncached(vma->vm_page_prot),
> -					 NULL);
> -
> -	/* vm_pgoff: 1 -- TPTR */
> -	case 1:
> -		if (!hr_dev->tptr_dma_addr || !hr_dev->tptr_size)
> -			return -EINVAL;
> -		/*
> -		 * FIXME: using io_remap_pfn_range on the dma address returned
> -		 * by dma_alloc_coherent is totally wrong.
> -		 */
> -		return rdma_user_mmap_io(context, vma,
> -					 hr_dev->tptr_dma_addr >> PAGE_SHIFT,
> -					 hr_dev->tptr_size,
> -					 vma->vm_page_prot,
> -					 NULL);
> +	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
> +	struct ib_device *ibdev = &hr_dev->ib_dev;

These two variables are unused, I deleted them

Jason
