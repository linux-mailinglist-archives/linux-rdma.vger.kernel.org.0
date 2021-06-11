Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17403A4144
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jun 2021 13:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhFKLd1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Jun 2021 07:33:27 -0400
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:6240
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230469AbhFKLd0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 11 Jun 2021 07:33:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ce0jBK83ivlAwJmeLj8HAHViXG5qd9aB70EXVwNn9AVFaTxGDM7u3r1EFxOezAYbBp2blJ/tNImEUGCxvW+dcg4LuOdvBVOYb9dopGhPZCpmK6ELxINPeL0r532rGheeLjrPR2CgnWrrkckkScA0dElURSrxr3bWHeICjuAFJ01eVYTK4gfe29gtmOFSJoaNJbxj9ynJ4i0tVPuhAdBHSF7CkW4Mgdwauzy5mL3fonAztRMNUvxVb3VVaxFsbOCk2IY06dAqUzd9mMgBTU3D+B4SlNIHO8YdmwzYmjW6FQi5CaFp6zeAEc+ngGhuoaSrX/tkHsqsA/AAVt9xxirT7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/lqebDs6fex3hjMCVlrrXa4kooomiFVJAFX2BWVr5o=;
 b=WjA/UFA5UfCWOzf68elUheHDwU821JzaLHgpT4L2yblr+ZXw8fxOe6ecT4XYh+OUKWcxFAXBv1LfVlYiiO4UHWVK0JjGZlS5E19dVlmT8JDge6/Wv+4zT9S/l+OSke7WqM4tZZ0Lwj3EOJT4k3lM97u3lF8aqcEzQjOPavz+asFLVe9+pkY/ofyETAWMLbXiAuwWG0p05gFgSShlly4y8b18l+MwYd9HmMxQF2gvtwIiVmTmt5HWiz1z1pt8mu7IiENUr9/MTapuliYerSVZnMCAPVv1nQEOh83kWojzCDo00/lTjZz0f1PbklfnH8zD8E/qVy9TU/rZGD1JfWpIrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/lqebDs6fex3hjMCVlrrXa4kooomiFVJAFX2BWVr5o=;
 b=CU38Owd1/46xZ2iHd1A5VuRavKBGB9L6mqB4CTLTXU3WDygo575Yh70gxsBEjpWxc8oFhGg2cBcxwWWvT0qo/PwQF+WiGvaI30bgekSlXx7PTeDv2B0Cmajo/IcrRlQqK2tme93kGFrDW84Zh83lgUv4oCkaZrEsMBQMnqXnyAcrp44kxk0ug5GTKTrr0ij5IRE3HuLDIm3pvrmO6hdF0FLm93UrMeWmGMSbE4xlGJGC1H038Qcq2vAs+4S1nUWt/2ggKKCfI2oCCNK0xmlvxFO/90lOfn7HsC0EJ1A0yi4uH7rYI0J0y1OeY1aMgr+Xfg326HFIrMxYLhxBhpmz5Q==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5095.namprd12.prod.outlook.com (2603:10b6:208:31b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Fri, 11 Jun
 2021 11:31:26 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Fri, 11 Jun 2021
 11:31:26 +0000
Date:   Fri, 11 Jun 2021 08:31:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liweihang <liweihang@huawei.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH rdma-core 4/4] libhns: Add support for direct wqe
Message-ID: <20210611113124.GO1002214@nvidia.com>
References: <1622194379-59868-1-git-send-email-liweihang@huawei.com>
 <1622194379-59868-5-git-send-email-liweihang@huawei.com>
 <20210604145005.GA405010@nvidia.com>
 <efc5283d762542f6a4add9329744c4ee@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efc5283d762542f6a4add9329744c4ee@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:208:23a::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR03CA0015.namprd03.prod.outlook.com (2603:10b6:208:23a::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 11:31:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lrfNk-005ZM6-Oj; Fri, 11 Jun 2021 08:31:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfe46db1-d95c-4385-2245-08d92ccc72cb
X-MS-TrafficTypeDiagnostic: BL1PR12MB5095:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5095FB15BC95FB050032E49AC2349@BL1PR12MB5095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BGmKXmDuQOclE6W+oVG4PYssz7idmbx9rR9z54EAIyF0uhRZIjGgzrUsS2HtM+B/51ncdjC/f8s2tDKG82uB/m6boQkC1I2JAqB+VxLIIyq7S0DkFfMPV6U0mpjC2JfXHmILEPXkGWpIcH+pKLF0vgrhoR7Hp7f/zEaIvuBR2NzQntDSsWSssIaa8RrKSieKSZwOLld+39TJj4HDudDmocyCb+elsnhBFbf7c/RWGQLkziVyUowu1Tt4e7zNY5NqEPScij/oUPp0JsDnIlSeg4MtrbjCcrcZPAAYs3AnwMBv+kQPyzmIMs6zEc9uOzKIaDvIIVviRYX/fJw6VbIZGS5EwsJn9t42fsV7hSBkoVPq5AwZs7I0/4tL5N/Xw7n2UvoCRMQBinLJUXN3dSRmTddrEKJSLDIlq+PC2fiHEJ/50NKYCQSIQcelzgGEFli7HB4JcyfDqSeClCzvoX++HLLJsi1vdJ/max6NGZ2UfqRp5uRIqMCvpM0gMiGUiEQrOhvQmjgNXDd7ZZ9BFuLoPskyRQ0x6w/jywA4yh5brt+6i5+1ZIcG3Fl31ltC26eu6xbZ0QKVOPa6g0K8N5ufvEQMFfavoz2yPRZDEifP/a0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(2616005)(9746002)(54906003)(66946007)(66556008)(8676002)(478600001)(66476007)(1076003)(9786002)(53546011)(36756003)(6916009)(8936002)(83380400001)(316002)(86362001)(2906002)(26005)(4326008)(186003)(5660300002)(426003)(38100700002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ZLvn1b75ExqkEyAS5ZvrKxgFULtjuvUZNhrAYs7r+brhZt0mxstew25jk+m?=
 =?us-ascii?Q?xPLd1snvX/LrF64UNUgYAsjvVjgc5+F4gCSZ+Y/sXTgWEfytOQ0wawCK/qaV?=
 =?us-ascii?Q?N3VRdreSDVLYFyzgMN35ZgBGU11GLKd3H325zxI0fha7kiRS7bIDSlRsU+62?=
 =?us-ascii?Q?J76hcCicgzxDAgvRSpucxq0oTdFpJs8nuapzkHzhClBqQRIorPTh0Ev3Q2pC?=
 =?us-ascii?Q?i/kA3+wQHwa95JzllNcfGzTMNc7jq1qJzOP4I5+YB4EYW0mZ8g4sRXnJphG7?=
 =?us-ascii?Q?Ji5AxvFH5cFutcIvt1jPF5iTIsosUAkBX3K+k8o6P3hxd3gKGTkuVmxYkbAk?=
 =?us-ascii?Q?ZdAM2x78byTdXyCu528/Br3JoE38NSyn/11M5iLZVGHqIhsTYArgaqyn3MCE?=
 =?us-ascii?Q?yzorOLU5s+9rCcdRZWHDcPfYcmXQpYYKqKHU/YZ6GOBP9yb/MCmNelZe7eXE?=
 =?us-ascii?Q?x9hfS70fbymdTY9R983OEEG8/mU5v5JTUmkKRACH0T2Yl04f7hzgTZw6k2Mp?=
 =?us-ascii?Q?S5pNc4dnn5Tn4DaXVoUDsLAKsLhvC0Hg29wBSrG3CsRC/NMhMzbyoeiWrbVq?=
 =?us-ascii?Q?lJ/idva+BH/Gw6S0SH00ykBGE+PAoOFftqkc812hgJoYs+mhfeR+y+0DlrpT?=
 =?us-ascii?Q?Eb8vmjzdgagxxPzHLJ2UbBoQKxLybXGUekgFh6lv2SfboaH8F67eQSmKMckP?=
 =?us-ascii?Q?9Ex2OJVDTqr4tXCnIwVz+WpW+3J8AO7lPF1m7fC5Yzr/nCLYMcEasGJR7CWJ?=
 =?us-ascii?Q?Rhre8FLzstbEYTWEr/bBP+dIjagLAcvmHzjTufXkxqhfIIe08yArcFMGjlLb?=
 =?us-ascii?Q?tdNPsoIFJRdhTR7pANa5eVt9TAz9FS5NPMBt1Ctj+UX/SHIF69pGDf+kjjHE?=
 =?us-ascii?Q?Dgiypz1GIwFH9PkD4aUztvim0T7ihLk2v5WcqJLn26UkKjvASEuQYarRxvWA?=
 =?us-ascii?Q?iqKciGyt1l+qP5ebVFEDcR8ojJyTy9I18idbts14awRFkW/Ygbxf3sAz56ep?=
 =?us-ascii?Q?qT5PhxF/+lMAKPrf5h53axGoOry0MRGThz08Wvw4HFEky49+AtoF1CyRYEXs?=
 =?us-ascii?Q?uFKB4bGapg3hAG3iYYhwOV6KprIdkzCc50P6B6glNTpl2Bzr3K81LhbQWMsk?=
 =?us-ascii?Q?GwFp2Iwpg7TKZD8HacPOlGrxq+3L54kCt5By8xsaqa4POcN9gtOdwSXj7Pwj?=
 =?us-ascii?Q?w4LDvR36sEZYhGTtBDb+at29KuMbD5MbztcrMrmQCELi4Muikep5BRLcS/3H?=
 =?us-ascii?Q?wq9usUOmWE0uyFo1Rx07LzMPZd+D7Wj6ZwOQnrjNI5dCrppk+/6JxhNaiME2?=
 =?us-ascii?Q?nVKQElsITqCqVGzsLMYC0aXL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe46db1-d95c-4385-2245-08d92ccc72cb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 11:31:26.2283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmNCbEq1pQFQJh3x4qjYkp5v0DILtCHyJXGSAGm6d5wQY+DFwtcWlWBcIFXoPssy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5095
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 11, 2021 at 09:20:51AM +0000, liweihang wrote:
> On 2021/6/4 22:50, Jason Gunthorpe wrote:
> > On Fri, May 28, 2021 at 05:32:59PM +0800, Weihang Li wrote:
> >> diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
> >> index aa57cc4..28d455b 100644
> >> +++ b/providers/hns/hns_roce_u_hw_v2.c
> >> @@ -33,10 +33,15 @@
> >>  #define _GNU_SOURCE
> >>  #include <stdio.h>
> >>  #include <string.h>
> >> +#include <sys/mman.h>
> >>  #include "hns_roce_u.h"
> >>  #include "hns_roce_u_db.h"
> >>  #include "hns_roce_u_hw_v2.h"
> >>  
> >> +#if defined(__aarch64__) || defined(__arm__)
> >> +#include <arm_neon.h>
> >> +#endif
> >> +
> >>  #define HR_IBV_OPC_MAP(ib_key, hr_key) \
> >>  		[IBV_WR_ ## ib_key] = HNS_ROCE_WQE_OP_ ## hr_key
> >>  
> >> @@ -313,6 +318,39 @@ static void hns_roce_update_sq_db(struct hns_roce_context *ctx,
> >>  			 (__le32 *)&sq_db);
> >>  }
> >>  
> >> +static inline void hns_roce_write512(uint64_t *dest, uint64_t *val)
> >> +{
> >> +#if defined(__aarch64__) || defined(__arm__)
> >> +	uint64x2x4_t dwqe;
> >> +
> >> +	/* Load multiple 4-element structures to 4 registers */
> >> +	dwqe = vld4q_u64(val);
> >> +	/* store multiple 4-element structures from 4 registers */
> >> +	vst4q_u64(dest, dwqe);
> >> +#else
> >> +	int i;
> >> +
> >> +	for (i = 0; i < HNS_ROCE_WRITE_TIMES; i++)
> >> +		hns_roce_write64(dest + i, val + HNS_ROCE_WORD_NUM * i);
> >> +#endif
> >> +}
> > 
> > No code like this in providers. This should be done similiarly to how
> > SSE is handled on x86
> > 
> > This is 
> > 
> >    mmio_memcpy_x64(dest, val, 64);
> > 
> > The above should be conditionalized to trigger NEON
> > 
> > #if defined(__aarch64__) || defined(__arm__)
> > static inline void __mmio_memcpy_x64_64b(..)
> > {..
> >     vst4q_u64(dest, vld4q_u64(src))
> > ..}
> > #endif
> > 
> > #define mmio_memcpy_x64(dest, src, bytecount)
> >  ({if (__builtin_constant_p(bytecount == 64)
> >         __mmio_memcpy_x64_64b(dest,src,bytecount)
> >    ...
> > 
> 
> OK, thank you.
> 
> > And I'm not sure what barriers you need for prot_device, but certainly
> > more than none. If you don't know then use the WC barriers
> > 
> 
> ST4 instructions can guarantee the 64 bytes data to be wrote at a time, so we
> don't need a barrier.

arm is always a relaxed out of order storage model, you need barriers
to ensure that the observance of the ST4 is in-order with the other
writes that might be going on

Jason
