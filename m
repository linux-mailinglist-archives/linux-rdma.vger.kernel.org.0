Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677573B07D4
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 16:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhFVOts (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 10:49:48 -0400
Received: from mail-bn7nam10on2047.outbound.protection.outlook.com ([40.107.92.47]:8096
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230047AbhFVOtr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 10:49:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8vIcgNlf4qmJYEprJyI/g7QwcMwUhg3WQiGakveZT9jfjArGBGR4m6JWTO0YgalF1v086rVNEqBaP/yogJ+8+6IomgKOnyUxbPXRBU/QL1C43f0XZBtvle8rhS2JS736Hb9+Ahp/stQdUJx6et5ZO4DkvqkpnMKv+Dx3bttKe/BEbcmh6D+iT60bkad76bJBkhp01gsXhPrFb2KwGhl4ljb6MP0m63icGjiV+a19SY+X6jVpgglEVIdruEGvSUOByCh3fBM+WNErKBRwGlB0ECtjec0AVp99u64leIuSLaCnWoWUitpo+qm/dvFj6N+dGD0enkE+hDu0abGMnBRRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjuC2zVCFS2Nge86CmOQ3lcly4lQu1Jg9vlgqdDIV3E=;
 b=APm51w/G0uWYrzGK37Gdlm6Vv9FOx81pUQmYrHgMJMZk7lIMhyoeXY1xxxAig78XYccdKys0+47Clpg7l6+aYb23DsH2Bf4hhqj1ZjM/2wvKkEzzr09Ah+y7yxt7sPS0j/xbaAc4TYp3nysBWERcj+4UmH3H3wwkGvEvMm/JcMKbY8N6yaT3tK9PaWXAFAwOB9gGlmueOK8QC4KF/ETbrhNYrLOg2/BFymE5wlPWvvFueS6ffxSD13//mW+b7aLT5mIVI1BpYSetRWzAPMIgGpsIU14rexPPCTs1NzHD8twpqz/RsmIfNaGMMLF38K90vIDlu4vtFu4zKok0Cbc9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjuC2zVCFS2Nge86CmOQ3lcly4lQu1Jg9vlgqdDIV3E=;
 b=mf1AIFhf9Kp8aKS3mpj+a+KkOhq+lmlt5Q8Ab1o0kRCnzHHt+XSZc+vj+RNztkN2r+twZegG3wkcWqNRZtOz7/9Sge5/16RopACAwyU4vy6eVINsV1zpwczLNgtxI+McAf4cwCnr09AlmjxAxxyFlqorzmFgCR0TGBK+xyrLZRCELXWDkqd8sdlWDT7rNixYFxFL355ZTmabdSG6QovnilbYFd1LDqY3hIUQQXwy8iwkD6W5hYvkZo61bCutmAoo/MrEkdBISXJ2+4Gu4dtqzpI7EM8Zy4Pp8ydt/EVY6RWHvxjgpJXRgVO/vh1zqXDgoIEBLHwMbDM/sDPdVILECw==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5095.namprd12.prod.outlook.com (2603:10b6:208:31b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 22 Jun
 2021 14:47:30 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.018; Tue, 22 Jun 2021
 14:47:30 +0000
Date:   Tue, 22 Jun 2021 11:47:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: Re: [PATCH for-next 1/2] RDMA/cma: Remove unnecessary INIT->INIT
 transition
Message-ID: <20210622144729.GB2371267@nvidia.com>
References: <1624368030-23214-1-git-send-email-haakon.bugge@oracle.com>
 <1624368030-23214-2-git-send-email-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1624368030-23214-2-git-send-email-haakon.bugge@oracle.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:208:32a::17) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0102.namprd03.prod.outlook.com (2603:10b6:208:32a::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Tue, 22 Jun 2021 14:47:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvhgX-00AChI-MV; Tue, 22 Jun 2021 11:47:29 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6abad96e-63f5-4a55-5a50-08d9358ca961
X-MS-TrafficTypeDiagnostic: BL1PR12MB5095:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB50951CFFBE0488871E9F9DA6C2099@BL1PR12MB5095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vZoNOobD50MJOyvquPsY7nk+sNs+k+aBY2l48+jgeK+4EDfKjdh7pEvr4DoXlKRirIGOqlUX0QELg9sj6+du0Mou+u89S3AXCamPSJ9kUwuJ85xcj2dmZthmWfRY0+bUNHf7BEmty9CjBow/+m/b4cvG5NPnv+u22LfffKLNrPcH9dnJivKylGI64UgLGrQ95ge9nZwnn/XSJf/0s4Fpto+A99IZmOvvOIYeEeQSUcB6JqXLaUiEF3H4Vjy6JJYRTD5oOr/GVR7hLVswUQa/U3Ej03f4WWhrj02sQXCAqCC2Wva1BAEmNGdVQ1uJA6jk2yI6Ra9wtPROYGv84zgoUcWDfyHFk49cC4/OtR2ELyw5bnc00EJTZiz95UNwLzqDtFaolTOZggpfmBc7ks/WuXZNH0ZQFv9n2PfDzAroDjCfpVULd8UzrKAWh5StO9U455pA4BbvdX5St2f/BP0d3a6vGPNU4xzXaYMFJ1iXsnmSIxJHVxeNUxq2Z+Oh0cQd0KGgoGbdD+g5FRTTCsU9xpq2Ko8gFqgJA2kNdwXFRL9rVH2DWoBtQx66H4ni1Amb3GI2wTMipiozFepPnjlFw9HBAbYf8BaxEQOsm1VIok=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(1076003)(86362001)(426003)(2616005)(107886003)(4744005)(9746002)(33656002)(9786002)(4326008)(316002)(5660300002)(54906003)(8936002)(36756003)(2906002)(66476007)(8676002)(26005)(186003)(38100700002)(66556008)(66946007)(6916009)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3dydStES09hRFFyeXJMSGs2cDErSlljYXNiczJ5bDVESUxFU3FRNGgyejMy?=
 =?utf-8?B?M25UVnBsWXVmTmpXQkw5NnNocisvOThVYi9DUWowRHlXcVFpckVVSnVWQVhp?=
 =?utf-8?B?SDRqalFnT0Rsd3RvbDlPcWZLNXJxczg1VWM1bGE0bjE1d3p2bncwRUx0NlBh?=
 =?utf-8?B?eFJ2YmRmR2ZkUmFiek9kTUFDbUwrcktrbEdSODhxaHFCNkZGZ09tM0tTakRs?=
 =?utf-8?B?M25vQmxHRVo2RzF5NWZlbmlQVm5rU041SEdFU2I3Rmh4bUhEalUvQ3BqaE9y?=
 =?utf-8?B?ZENjSUo2Mi9yY2JJcGZoZmRHQmpISDE0bktQUmpKMFpHRGhuM1QrRWJGblNV?=
 =?utf-8?B?bDdmQVBVNHU0M2M1eU1FcFNiTWJCL2pPdWdqbm50QjBockFWTVMxTWNibkRz?=
 =?utf-8?B?Y0dmdHY3Vkw2S1pSNHdNNmJvc0dvQWV5T3ZGVzVGRUZHSzBYakxLUHVTUjJx?=
 =?utf-8?B?b1JiVHdlT3JnRlk3dStDWGNJanVWbTJydXZzWmlhZVhvdGRJb0tCUmtzOTQz?=
 =?utf-8?B?MUZqMS9ESFVhTmRHU3RZY29MZHV4V2NmZjVVWTdnWkFtRzJTVkQ1QzhEbEgw?=
 =?utf-8?B?RlY4OWJhdHFKa0pERFdReTlhZHBGSFRoM3hqanlGQlVGNDliVDJBNnR2QkpV?=
 =?utf-8?B?UXI3anMvVTdOYlVGNWVkL1hvVkFBbXNSMmYxNWpTOUdQK0NFMUVBY3FLNmxC?=
 =?utf-8?B?eitEajROK0psdi8zMDQvc0ZGOHhBd29FOUlUQnV5TVNydjJtVjBYWXpJeVlh?=
 =?utf-8?B?NjVwbFFJUGdhVHJHWFovRXBwWHd6V1RRZElFTTRNM211bGxKdGc1aVBCMU9P?=
 =?utf-8?B?blQ2eGl4NlI5UFNSUkp3enFnNU9FQWR0VFI5R3JEMXpWblhpZ1dUR1BXbkJ0?=
 =?utf-8?B?djYySUV0cEdlVjlFbmQvMDE3N2x3ZkFBNmJZcDVJZGZqRHo2NVpHbWc2dU0w?=
 =?utf-8?B?eHZCT213TWtoVnVpbjlmMGp6Qll5UzUzeEdFdHZwWkVWa1JlUmRwNkpZaHZU?=
 =?utf-8?B?ekVoeUZWM1RQVFFOQkhuc0dXallja09KS1ZObjZEbVRpM3hldWRGWU01NU8w?=
 =?utf-8?B?QklXVGhydTd1eTRMRjhHZjJLV2R5WUZEZENOcW1XUkRLWlJBVkZWQTVCTUJa?=
 =?utf-8?B?MDBlV21uTUwySGRtUVA5b0V2T0djSGlwc3FBZmRmZWFwRm4vSTJsM2pIMExP?=
 =?utf-8?B?aFRSZkhwRXQ3R1pMM0RpVzBmUHlxbXpWR1BqTW5TeDViaUo2K0dvOVVKZEs0?=
 =?utf-8?B?eHZvZEpiKzRYUkpYNWJLTHhQNnI5bFhNNHhyZ0NMY0U4am5XRE94NXMyc0hs?=
 =?utf-8?B?LytlNHdSVlI4bU5JcXQyVGpnUnRtQXowZG9oV2hyTmNmSHJFZlRTOFRKV3FW?=
 =?utf-8?B?WllaNzNPa3I4bDJXT0dpbC9zcDFmcDFRN0ZiVFc4YnRmTHI0M1pTZDNGeEp0?=
 =?utf-8?B?WnZLcVdvYktzR0hIeDJ0dkdCTkU5eWxFMnM3MEJldlVJUFBwUFNRMEJmRDE5?=
 =?utf-8?B?Mm5PSDVzL2s1ck1YWVFmRWpQdnprSWVQVHJpRUs2TUdoY3BqOVgyc0h6Sk5Y?=
 =?utf-8?B?UUs1YVF4ZDNNejV3ZFRZQXM5V2E3c2RhcWpRTVJLVUdZalcycjhMZTRTMmdV?=
 =?utf-8?B?cU1LN3ZSK3BSdmkyMGpkSXN6R1VpK1lrYlp4Z20zM0lSeER2Zi84STFtcnh4?=
 =?utf-8?B?VWt5MVUyNGtkamhUOURiWHFqRGxUeHgwR2RWbm4weGFVTWtZVnp6dVowWUJw?=
 =?utf-8?Q?WdYeDpHihcWwsAul0QTxc46LTD3ghNqagCND3l1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abad96e-63f5-4a55-5a50-08d9358ca961
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 14:47:30.5289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JMvsQH892B8BxxKsQhmeSzjJ+GcMn5SZMKHcjCGEyvAFrmI0xsmeoYx2W5nqcLw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5095
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 22, 2021 at 03:20:29PM +0200, Håkon Bugge wrote:
> In rdma_create_qp(), a connected QP will be transitioned to the INIT
> state.
> 
> Afterwards, the QP will be transitioned to the RTR state by the
> cma_modify_qp_rtr() function. But this function starts by performing
> an ib_modify_qp() to the INIT state again, before another
> ib_modify_qp() is performed to transition the QP to the RTR state.

This makes me really nervous that something depends on this since the
API is split up??

Jason
