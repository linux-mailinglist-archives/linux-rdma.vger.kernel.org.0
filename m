Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DB9355F1E
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 00:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhDFWzH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 18:55:07 -0400
Received: from mail-co1nam11on2078.outbound.protection.outlook.com ([40.107.220.78]:27489
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232452AbhDFWzG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Apr 2021 18:55:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuWp+TisTF3EJ8O3gKiDLY4sSpkhUfmXNmuZRNwcklsu2jb7JbogA5AmKDWx4pNYswGwllpOsOHnvzQF6aad5rZPW0MGNFN32nTfVr1T7XTE1fwhrtISCPSOgLYGcfvLLGRnD3FolVaHZTesG9ynDh/+m184xqTed1mJ3P4t0kUrRHSMvlCvv+Ry+CCW7MgE8Y5zbvRp1RywXtqUrSL1UK/zC7ZeqwtPF0m7B5IsJ80w4JT8flHLwy0TjSuoxARj2eN/T38TWQ5l62i8vE6rL5qWlxlJTsD0LI+SnVzUjz6qg59uCQ1QuZfof7jl/oq0TocBkOYAQoWFPjW1lIZbdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTMy12AdNxZamCGb1QXTXNQGadjHCHxs62k9H2ZluzU=;
 b=GlKh2boDIPWwQLADRA6gle9CRwIvfWKaDs1Urx0p343nWUvnxT9mYY/76wim35fRqBoUolDznXIoJrFhnTLpTqMcPRqU5WFlk1jjdgAxrE2ncORsXS9wKK0fyaeTMMFlzpvn15LWvu1eXMw3yKoJmhsasuizaf88DyX1i/QS39YQY1/oH3yPxuk74aSOdtxmyvniPdlcEesrJtuc4prqPhUacHsmi4wgqhi2VFi8CDxfRofv4eQEJxabO/3pOHq7QhlLOQ5m/mAomz442PZiVhvxHqASFKgfSNGnA+aghgu9LEl36cCYUEEwci9UwjsAyL1JAAkjxqnCYdl6JazFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTMy12AdNxZamCGb1QXTXNQGadjHCHxs62k9H2ZluzU=;
 b=Tvwshwz3ELngGHZrmbUGCXMp7BULRTM1eQnwjwgINQJaMMftb4CxtHtjHffobJ7zL0gEmPsium57B80vBbm7EFgW7XA3UNYch0XJs5lr9Ot02QwZNXfsLNtWLH2TEHlHSY37qBIjG4p5NFcK6OYrFrh23EW+M+hNreD6uLgAEje1LUiTZx74nSje9zuTABZKXOoMtIMtCHwYB10IMQgdWXbO42Dhh/5oIeR7pnTygyR8sElZIKrzHfQp+lM6nG7WitPcaCrIMxQEd/6ZBWZLH56GH1ZUKZg2E4cTJcN/nvWADmnAWN1LJLk+9ug4LAfkO743zU2VDbzUFG2imo/bVg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 22:54:56 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 22:54:56 +0000
Date:   Tue, 6 Apr 2021 19:54:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/5] rdma-core/irdma: Add Makefile and ABI definitions
Message-ID: <20210406225453.GY7405@nvidia.com>
References: <20210406211728.1362-1-tatyana.e.nikolova@intel.com>
 <20210406211728.1362-3-tatyana.e.nikolova@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406211728.1362-3-tatyana.e.nikolova@intel.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BLAPR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:208:329::7) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0062.namprd03.prod.outlook.com (2603:10b6:208:329::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Tue, 6 Apr 2021 22:54:55 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lTuaz-001pJL-Jr; Tue, 06 Apr 2021 19:54:53 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a78726d-86fe-402e-6442-08d8f94eff0b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4042:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4042DB4BC7B2B5A3E1C97C12C2769@DM6PR12MB4042.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gmm5+oXpoZMIKLPGpGYbnjblaxaWbR76BZqzVzY3egukVU5ozr+YWrblV+87lkYzUZGeSnhc/g9oZEChhEqbWXEjP8PaAgGaEcreIW7Uo3/Wo2FLz6TfTp1xsSVbBSMsnqWBpl2SRIjO/TG/xaYKTPICKeSxmPzSQrriUGTXgFYREnjaL3DzhVO99rZNNZKh/gc0478+Uvqp3yxZy8TyaGsV1jNAkkjg8fRunGQb/do65UZItgeomke4ycPNaUEadz72Q0uCunBdyTQGixhzBQvbFMN+gtp7oc99RReZTSWNLU/CFP1Q8LtEaYBRr9Jj+jj/N1bNwuILHhpHcXXMJDb+SUNQqOpLit0wwJgKourA1Frzpa45qndF3/7JEb6z9/59BoKH8eCr7b68QYK19f0UI4IjhvPGT1JH2/ieZtvxbHJOHFbQ0i3AjnFgILsQIla8CrJ3HcZibaSPUZkmluFDwK23N5TRjz1i621l6wxuX70LrjQCSB+SNmPIFv2amfx0CgbLE3h4KW5VFyGjGZuFU6ifbx8Ab2QbSsDdEmdXpsFgiRM5TyuaTCkjElvH7Vt2IXflqghRwWV+c++y5Z4EM9as6Qik04bkmeo0tV009RuLiM6HiEyHa0r7c3jDPgcPZOGgVRKkqKdu/lfN+5TAHy/DfV/KNZQCYaSZW7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(36756003)(2906002)(86362001)(5660300002)(6916009)(26005)(1076003)(33656002)(38100700001)(4326008)(66476007)(478600001)(8676002)(186003)(66946007)(9786002)(9746002)(66556008)(8936002)(83380400001)(2616005)(426003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3sDEml3rlaei4I86x31YqntQNJ3AUp3VBMVEyHwokOpSAbNM2kB5CwHlo5rM?=
 =?us-ascii?Q?TylHe29NAs8rvZcKEJrS3IhHZ5Gr86EWrNup68sUmEzdsPrdnK0JvJ9k++Bn?=
 =?us-ascii?Q?reh7yWWY8UaAIo7RKZXz+9NmuS9l9OHui3R9KhvRxc7+c5Ij2WHhlDw9b9fT?=
 =?us-ascii?Q?bYySniqSA06WxPIS1FpV6cGRsvOmvmOj9lY4PFu9Y49GY3lS6wISR2aN3OQI?=
 =?us-ascii?Q?FLUbMbQeSsYiSz2DQtDGuasbJFHT/jSGogdzSG571n2tBMD4Xdf1ucQCeyna?=
 =?us-ascii?Q?MoqNb+TmtIXK4/7pOkwcqq5t6CclA8zinZ6ZcfW8GL9clgXaZTO4ydcIUyfo?=
 =?us-ascii?Q?b2JYPmNayV/tqPVNehv3NdEy/o6xhAovAI++u86JStqP/UY5dQtqfcODgZzC?=
 =?us-ascii?Q?L0bKLR0hywRRtkQ6beWOACHksFE/PFtoaH80MSDYzwuiY+gZHc9O0Mup9E5O?=
 =?us-ascii?Q?WrN3FSbuhTxcTKkfonBX2dvh+ul/2PA0n0adQAFwuDOCtQAi5kqDoNeZ+Di9?=
 =?us-ascii?Q?68v4h6Ovkq2/poFPCQY/c9dUltwkGpfa2vOeDMqi3A0GJ4Z8X3l/zkq3XDEM?=
 =?us-ascii?Q?uhlHXDu998h49lPWoBknsP8vjfuNMX+5y07AYeEhY3lmO+Bna/nm3zBThGI8?=
 =?us-ascii?Q?p1MFURpK+XqjRI/hdpi0JvIATaFvNPacdXUsJHOyTOeheUbp3P0GdBIawa0b?=
 =?us-ascii?Q?kGWXmdleiOF0HZtD5Hjh6PYjxaXQtvor9WsVZiVTwanAmgLy4Q+ZFijxhpC9?=
 =?us-ascii?Q?+DeAguapynQ1fMpItVtaTfmyHtM+F5072+ZiDJ6wNpwAXVKMcxUFDg9Q4N/W?=
 =?us-ascii?Q?C8WIDZOknXhlkR5/0C8B1Smv36wPNJdSq9eTYQCchvc8s+dXj0ZSoLFXa/hY?=
 =?us-ascii?Q?vClA2OxL36R9ykMCwGifxJeXKkZqkKwCMEMkuJXINo7Tseqi0smQPm+mdvt5?=
 =?us-ascii?Q?n8BLLxmJxw1YLhvXchk/lbDsc+Z79isGNBOaJMf+jFJmS8XtrVrzxQYEHMSX?=
 =?us-ascii?Q?4yFfHg/2wybp+9Cs3lIN5qGjuaLehGiLvRneVaFT/rlB8Vyitr6N4Yn37Gl9?=
 =?us-ascii?Q?LBbXEgQw4Rgr1/0212/ovoV8tlVKk3jJNltatdkqwUmdRJztnL9GfJu3MA9h?=
 =?us-ascii?Q?VTq5XTZYZKUgCZKfeLPh+LlNbCq0VTSoPpx6OpqPpGc9jD7NkE3LXzfdoeNR?=
 =?us-ascii?Q?cO0/b8l2SYPNUgzVGV+BpnO4FeeWyuCFCGaxo+Gvmi4nL2UO8atmRpD2ekq3?=
 =?us-ascii?Q?GolsNGgyUlQU9W94yy/M/LDodwBgYMpsWRoBExM/nnxVElOiRnwV6xxyzINJ?=
 =?us-ascii?Q?ALEV/pbHIK3AJWxrrPZNQhgvysmrdRMvTVhXnZ+VuJmZEg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a78726d-86fe-402e-6442-08d8f94eff0b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 22:54:56.0273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jo3CoDt44/0rg13C7LmaRrKpSMMkyrB+KjhuTnrmzsWno0e8oKAlRA/jLFx/Yhog
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 06, 2021 at 04:17:25PM -0500, Tatyana Nikolova wrote:
> Add Makefile and ABI definitions for irdma provider.
> Add utility macros to rdma-core util.h which are used by irdma.
> 
> Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
>  providers/irdma/CMakeLists.txt |  8 ++++++++
>  providers/irdma/abi.h          | 39 +++++++++++++++++++++++++++++++++++++++
>  util/util.h                    |  8 ++++++--
>  3 files changed, 53 insertions(+), 2 deletions(-)
>  create mode 100644 providers/irdma/CMakeLists.txt
>  create mode 100644 providers/irdma/abi.h
> 
> diff --git a/providers/irdma/CMakeLists.txt b/providers/irdma/CMakeLists.txt
> new file mode 100644
> index 0000000..1542482
> +++ b/providers/irdma/CMakeLists.txt
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
> +# Copyright (c) 2019, Intel Corporation.
> +
> +rdma_provider(irdma
> +  uk.c
> +  umain.c
> +  uverbs.c
> +)
> diff --git a/providers/irdma/abi.h b/providers/irdma/abi.h
> new file mode 100644
> index 0000000..bacce40
> +++ b/providers/irdma/abi.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
> +/* Copyright (C) 2019 - 2020 Intel Corporation */
> +#ifndef PROVIDER_IRDMA_ABI_H
> +#define PROVIDER_IRDMA_ABI_H
> +
> +#include "irdma.h"
> +#include <infiniband/kern-abi.h>
> +#include <rdma/irdma-abi.h>
> +#include <kernel-abi/irdma-abi.h>
> +
> +#define IRDMA_MIN_ABI_VERSION	0
> +#define IRDMA_MAX_ABI_VERSION	5
> +
> +DECLARE_DRV_CMD(irdma_ualloc_pd, IB_USER_VERBS_CMD_ALLOC_PD,
> +		empty, irdma_alloc_pd_resp);
> +DECLARE_DRV_CMD(irdma_ucreate_cq, IB_USER_VERBS_CMD_CREATE_CQ,
> +		irdma_create_cq_req, irdma_create_cq_resp);
> +DECLARE_DRV_CMD(irdma_ucreate_cq_ex, IB_USER_VERBS_EX_CMD_CREATE_CQ,
> +		irdma_create_cq_req, irdma_create_cq_resp);
> +DECLARE_DRV_CMD(irdma_uresize_cq, IB_USER_VERBS_CMD_RESIZE_CQ,
> +		irdma_resize_cq_req, empty);
> +DECLARE_DRV_CMD(irdma_ucreate_qp, IB_USER_VERBS_CMD_CREATE_QP,
> +		irdma_create_qp_req, irdma_create_qp_resp);
> +DECLARE_DRV_CMD(irdma_umodify_qp, IB_USER_VERBS_EX_CMD_MODIFY_QP,
> +		empty, irdma_modify_qp_resp);
> +DECLARE_DRV_CMD(irdma_get_context, IB_USER_VERBS_CMD_GET_CONTEXT,
> +		irdma_alloc_ucontext_req, irdma_alloc_ucontext_resp);
> +DECLARE_DRV_CMD(irdma_ureg_mr, IB_USER_VERBS_CMD_REG_MR,
> +		irdma_mem_reg_req, empty);
> +DECLARE_DRV_CMD(irdma_ucreate_ah, IB_USER_VERBS_CMD_CREATE_AH,
> +		empty, irdma_create_ah_resp);
> +
> +struct irdma_modify_qp_cmd {
> +	struct ibv_modify_qp_ex ibv_cmd;
> +	__u8 sq_flush;
> +	__u8 rq_flush;
> +	__u8 rsvd[6];
> +};

Huh? What is this? Why is it here?


Jason
