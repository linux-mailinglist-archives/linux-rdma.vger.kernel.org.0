Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3EE39BB27
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jun 2021 16:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhFDOvz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Jun 2021 10:51:55 -0400
Received: from mail-dm3nam07on2052.outbound.protection.outlook.com ([40.107.95.52]:59808
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229656AbhFDOvy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Jun 2021 10:51:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnRj2+nhtvA6S+Bz9MXQRQtTWLMPgt22vaSyhu6bVbodxDGcB+SAjYv/0qui3MuknQofH9x0GKAEa8inOVEW/Fq36+zZk6lMX4n2OwMXvYIROMAWBFuE4YG5egSosXfCY1thcpIfshGJ1D53YrnZp7+4fltSptR4E9fBtiQ5eKy0c4GFI0VwD9xU+OoxF2K+PHoB9hc09YalCKo0ilwbQjHPYyD6X3wtb/SMqZeHuWJPh4G65M7glOMcwm40JpuwidbwtkqEjolndftoh5KPVMRyPuUGYrGlLPq5DjhzWW/KWHWH018WS1JWEeTVWOOK5XQJ+yDhmG6wME/JZPM5gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZamV1GNBhQunwxPtdxVrGibiIiPuzltNxZXQMiOiKi4=;
 b=AIxy8ueEzyNsa1iXOdFTZLaBqBrIMT6Zu06fHS9EGT0oldepzlvn2VCEU+cvx8DWk2s4v+PYA5YcLqFfC1ekibjTJhSpgPvHYOgd2R0oyvqxInuvAbQYo2+7PkOIzKQ9A37XZkxRjvV7V9EDcKLKzZoUaI4LwjxPNi4ZSU6nLXYoRN32EPPQ2RqAUwnn0yindwxQGH+OHz9zy7zGQJRjMN9wfdzquy+7q5BO/8uHQP2eGFOS1wKDrPhjTdDrlUipKKRiTkbPiBQgtbHKowioV48cpcVzyYkuuMxSkDXCK7Qdk0o3Gb3eYexVfkbJTZ1vIjXbPLEDpKhm3PF7SLkjHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZamV1GNBhQunwxPtdxVrGibiIiPuzltNxZXQMiOiKi4=;
 b=FNx5zqWhX9vk1cwJSUF5112p47rwlVHyLwmfo/saG+V0zhdxw1qf6aufWCSnwmdcqPvD8OA1o/5n2tas+OlpS3xclIMdMpEO8VL9VYZdx4Awl7V/1S7negdMgfW3DT20fDLS27ZLY4lTKRJ05/zGhT7L2o5yK5taav817Iz0pTgxNpc2HqH8O/cv6++yergRKkcr/Z377PFufmOQQvvleycqoIiZ+bUP3PvLJYk1fQEl0EGCXLrwrtPA/tJLDQfW0GUlxLeHt8X3k6AVzt5eVhqknZnCItAEl93oDVvg7xUF6uZScwPvNzvNhKeDxbhGU0nUpRRRZQrlt4ZHdiL8xA==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 14:50:07 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 14:50:06 +0000
Date:   Fri, 4 Jun 2021 11:50:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH rdma-core 4/4] libhns: Add support for direct wqe
Message-ID: <20210604145005.GA405010@nvidia.com>
References: <1622194379-59868-1-git-send-email-liweihang@huawei.com>
 <1622194379-59868-5-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622194379-59868-5-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:208:23a::30) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR03CA0025.namprd03.prod.outlook.com (2603:10b6:208:23a::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Fri, 4 Jun 2021 14:50:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lpB9B-001hUB-VW; Fri, 04 Jun 2021 11:50:05 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6ac9268-d978-44cb-bb82-08d927680b30
X-MS-TrafficTypeDiagnostic: BL1PR12MB5128:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51282CF7EFA5B29548B02DF2C23B9@BL1PR12MB5128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p6sFLWHJ4lcs/y2igxtXOGimrY6jtNn+VFPnCTKRfVf6YzH/Um73nGn+IPl3QJAROWrA69nAXsVqTOb7eh/TqcAmdVzQVvOWlpuYCmRMZkGamaxrhs8nYF/0u3PhCholKY1liIUsDquI7eNDzQsuw+LPQdgN/qW8finkTosScjRpI74z1VC6C3FqD9dZxl+9ThV8gute4ZBT5E90ASeYvMIlb0FOXtMf+4sCADnP6gTj8VBC9e/6NzGoo1hKKKBd2ltK+nA4J8gmfP+djneLNBZmuY6bddkk28+z9d7P+hwVaKpqoOPKSqR0ljsFb16DymudQIsi/FbR1oTWUG44lpVmPSyLBjErTrpujS6e4G/ul4cMWl9QElU8qKMWnNtnL7Yr1T4bWiNYM6tZKrREAGgM4XA8g92wGTlUiD8tBTNOBc/YV3BIGtoY45570EBTSOhx9e+v70RXiPeOLqbPjX2toy7SrYHnROxKnVu9UI+UcSm7jSSoj3TJQCwUwi/L6LFxFld5u1oaz7kjK/J+4WoOwcd0QbfzL8On3lqSycDidj4jrDCx1/7bC/bNui+u6QAoH/yKfFyeqQN2XpjkSs7wV1PgYYb8ShwU5IVioqfk85eC5/67agxgEYXoOwsAXIiNdwJ+tP3Xa6xe6V+ZEOZJZ3VqMUc9IC1FfmdoqKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(4326008)(8936002)(36756003)(26005)(83380400001)(426003)(1076003)(33656002)(5660300002)(2906002)(9786002)(2616005)(66556008)(8676002)(66476007)(66946007)(38100700002)(9746002)(478600001)(6916009)(186003)(316002)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?THPiLT0E2q+2gemfOz100/MoS37jNJIwyRR2n9O1n/xG/jb/xpWLi9Cllas/?=
 =?us-ascii?Q?UY73tjLMctQQ5Xou7Z8+VF5/oOGDiXtWAvc3Oo+7p8SUxYyoSRH7as/F2Ouo?=
 =?us-ascii?Q?U8qP8ZZTyzJN1FH6yQB5wBNIpx1AQu4IkqGcx6rxl3SQxnqsozH/7eeukyDB?=
 =?us-ascii?Q?3bThrHTNo9UJUhCLZ7dYm9JeIXvIISUtG5elcZILdGK4J1MyHDpLRBjbowHn?=
 =?us-ascii?Q?uzU6NU8/dekbV7rcxOyGs07T5mM6ZBIHZDUlu33CPvVv6DBFBeRJp/zKNu4V?=
 =?us-ascii?Q?j9EOFQaIy7eGK6aQhcKGaG7boHaa+0HLw7h3EeP9pKXhQyofYtFgRepGRray?=
 =?us-ascii?Q?nldLcyk/ho+oIZlEGzIKM+XFjMoCMw20cqp9A0ghRVV3yJiKIpWa22K4O14w?=
 =?us-ascii?Q?4rhicX4OOypa/hY5OzP0bS5mzRdU1chKamm3/bZe4g0eAEks7kdyBZN/z13N?=
 =?us-ascii?Q?JpZ4kG4vPu5HBtfjcRe0/Ez32TVg8gWF3MR+ceMC16R//Shm3U2OlwnThU0z?=
 =?us-ascii?Q?7Xlg7Z+i1C/lBkIjK61tPzB510jgxjCX65OOSTOn9cLYPx4Y9ABkyMxUPMU4?=
 =?us-ascii?Q?/sVe8tjBLrUO7IQfti1YXlP2YOLKuIkG2rm1gvGU66PN10+X9UzSb9DIxsTt?=
 =?us-ascii?Q?uCJJM2JmuSWUDcoVXbfU2zp6iV6MEhH+yFgaj2bSD3sfE7zx3Lph5aUR8PKz?=
 =?us-ascii?Q?qKtGIQ74ySKp/KPVVC2vXbh1wPIfSqzfQNbS8dCef1b9BvcZVEqGEaMrLRM5?=
 =?us-ascii?Q?sNFRQobPv26IeVqtHiUEa7OT0GzbfsgMGfqCJyMwki/QdIPtm0ZvfeaNH9Ot?=
 =?us-ascii?Q?BgQQ3nQhbN+rjzBirACHtUEh6qI4Lt/igjaRalLE74rov0yxxwEmQHFvkZGf?=
 =?us-ascii?Q?sdhhG+m7NDtf/xb6hzsCHG2YAbhpZwLnSasG9umerjT/QmZeS/1uZH/t/uT1?=
 =?us-ascii?Q?Fbhp9OcvVOjekSkopS/ESOWcA2ldjbdwpQco5u7N3eE6pFDKAkITFfj8KpN9?=
 =?us-ascii?Q?OW0t7ejr6h+x/slsbfi5tFk8103jaNOEffzZ8L4mC2Et6yT9kguaXhDp7W4q?=
 =?us-ascii?Q?XEo3iv70J0l9FfjJ08HDdTU3Q7QnFcp7xUGeMX+nCFmnUUu6S2kZGGDOKlxL?=
 =?us-ascii?Q?tDW0eaMk52fAYWNCw+WCj+UcE5wjn04yl3Vqj1bMSjw5XR2mX3qPwz50gB+U?=
 =?us-ascii?Q?9Ry2d6DfF/4h8jr0U/iHAqzPEMzDva6wjN0CPCXP/EVa4ZlXrEpwi53jeUc5?=
 =?us-ascii?Q?RdjQ4pk3wkYorIf+9jBE2n5HB0fUwKnhAFljp6+znqPuSFQMRkYwkVxUruYX?=
 =?us-ascii?Q?1oMcKqkR/Rf5gAd/Adi3gw0R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ac9268-d978-44cb-bb82-08d927680b30
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 14:50:06.8615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eW3fYZsRY9Qqv+CtfsX6+aZ7opG7Cid/RiSmJTHdDno5SMQMPdeNIZlg82O7soc/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 28, 2021 at 05:32:59PM +0800, Weihang Li wrote:
> diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
> index aa57cc4..28d455b 100644
> +++ b/providers/hns/hns_roce_u_hw_v2.c
> @@ -33,10 +33,15 @@
>  #define _GNU_SOURCE
>  #include <stdio.h>
>  #include <string.h>
> +#include <sys/mman.h>
>  #include "hns_roce_u.h"
>  #include "hns_roce_u_db.h"
>  #include "hns_roce_u_hw_v2.h"
>  
> +#if defined(__aarch64__) || defined(__arm__)
> +#include <arm_neon.h>
> +#endif
> +
>  #define HR_IBV_OPC_MAP(ib_key, hr_key) \
>  		[IBV_WR_ ## ib_key] = HNS_ROCE_WQE_OP_ ## hr_key
>  
> @@ -313,6 +318,39 @@ static void hns_roce_update_sq_db(struct hns_roce_context *ctx,
>  			 (__le32 *)&sq_db);
>  }
>  
> +static inline void hns_roce_write512(uint64_t *dest, uint64_t *val)
> +{
> +#if defined(__aarch64__) || defined(__arm__)
> +	uint64x2x4_t dwqe;
> +
> +	/* Load multiple 4-element structures to 4 registers */
> +	dwqe = vld4q_u64(val);
> +	/* store multiple 4-element structures from 4 registers */
> +	vst4q_u64(dest, dwqe);
> +#else
> +	int i;
> +
> +	for (i = 0; i < HNS_ROCE_WRITE_TIMES; i++)
> +		hns_roce_write64(dest + i, val + HNS_ROCE_WORD_NUM * i);
> +#endif
> +}

No code like this in providers. This should be done similiarly to how
SSE is handled on x86

This is 

   mmio_memcpy_x64(dest, val, 64);

The above should be conditionalized to trigger NEON

#if defined(__aarch64__) || defined(__arm__)
static inline void __mmio_memcpy_x64_64b(..)
{..
    vst4q_u64(dest, vld4q_u64(src))
..}
#endif

#define mmio_memcpy_x64(dest, src, bytecount)
 ({if (__builtin_constant_p(bytecount == 64)
        __mmio_memcpy_x64_64b(dest,src,bytecount)
   ...

And I'm not sure what barriers you need for prot_device, but certainly
more than none. If you don't know then use the WC barriers

Jason
