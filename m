Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1738125E3BA
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Sep 2020 00:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgIDWam (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 18:30:42 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:56227 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728076AbgIDWak (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Sep 2020 18:30:40 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f52c00d0000>; Sat, 05 Sep 2020 06:30:37 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 04 Sep 2020 15:30:37 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 04 Sep 2020 15:30:37 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep
 2020 22:30:33 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 4 Sep 2020 22:30:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0zx4cTClaWOSWPXklRQ48EfxSiNW+ynnLY9aCnemY9c9z7Yc5QfyWap3mLDmIO+z9r7xgyYxno1OBvpl9czeNhKLBHlOdIK4Z/zYnZUG0vVHwV+SThx+LGlu8VCPmSSvDqsUk9xpyQJC7eJcKG7FCn9kgnIMhTUXNAJCtCFzMfBYzFvkyQrGusDG2hdKjZRyZSRjXTneCIa8a/t9Rbqx2PP/Stfnub9TEGCev6l5uddm0fcgzpd+xqjTAliQN+lr8euVXSQMvNOEt6StQQXE0MepVrh49Kb0x+VJlpHeAFzs9H2Mt6Sx1LJh57jia92vkZrsCjTBVY4j5Tl4xNsYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9ihEJGjnZFrk0st7bErG1HtYywJMJeUJK35fT7u0ak=;
 b=GlzRz/2aT7XJoplEB/R3qqPlu49Rw0t28SQn/lIhDI88sivP04Ttp+pkktBsX960w+QThcXMzZbTjAHvyBQ+pJlrLcv51D896qR5in/RBOkLm1SBJ4nXuVThW/dYL6OGZ+fRr20Dxply1p5l9Y3R/Yk6WE8uVtIlseeqxKY+ehtzuPqpk1fkNZcztpTS5A5UXkzrXpGmZWbmR/hGngGL/XexMOwDhFz3jDRtWO+/ZtZ++GlGiG1zMGY28h36dEmGwHIQSYkGCDPmxHl5UfOla6m2Ov1syaLtvd8jAmZdGVZCiZl7vcAlCk2I7wL6a2x12Mxx0FRiw9u8GsnaSweSyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2439.namprd12.prod.outlook.com (2603:10b6:4:b4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 22:30:30 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Fri, 4 Sep 2020
 22:30:30 +0000
Date:   Fri, 4 Sep 2020 19:30:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
CC:     Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH 01/14] RDMA/umem: Fix ib_umem_find_best_pgsz() for
 mappings that cross a page boundary
Message-ID: <20200904223029.GA454890@nvidia.com>
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <1-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
X-ClientProxiedBy: BL0PR1501CA0008.namprd15.prod.outlook.com
 (2603:10b6:207:17::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR1501CA0008.namprd15.prod.outlook.com (2603:10b6:207:17::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 22:30:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kEKE1-001uMA-7i; Fri, 04 Sep 2020 19:30:29 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1efd8c8a-79fc-4872-3615-08d851222178
X-MS-TrafficTypeDiagnostic: DM5PR12MB2439:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24398B4E14ABACCADFFDB19EC22D0@DM5PR12MB2439.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qa03sxYigfF8vDomYPFtVmB9Ys8PHtGi65gCq/SmtUEOnsC8CLGYqLKjUDLb8hlGLaYo3BUhEiobvHQEsGktaO7oAdgC/DztZF10e83Ufx6L7cRBf1yeFHVVjG1UKheFYa8ylC5QgyRIAe9Xd5NqDVfGCVmHjmXKeGvxM0y2oK43pcA7hmPxB8EsEG+R4XaKjFWvjTxaRUoxzF4kc/taWR8cXlnfthUgr7NjZ/11pIABJ425+Zj2xyMC+/7PQzNOleg9nvTGvLip8JWvjte40TlBtNhZeuRxj9I0NfAxZTdbi9JH0IUshTVULl8qBDjDNyYGiDKUlSFE5znM4BrbVthG8QFNZ0EpMQE95/Iiwq8JC0a5oepb4Mik/OJrV1P6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(426003)(1076003)(8676002)(4326008)(83380400001)(2616005)(8936002)(86362001)(33656002)(36756003)(66556008)(66946007)(66476007)(26005)(9786002)(478600001)(316002)(2906002)(9746002)(5660300002)(186003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ElJPHN/a9YzqtGneY6W97M5G4ui6x5KaFCXyizGBqhL6iehnTbRinvXdzrWXVEmHMLJn3JWC/sRlFzNOc72rQz7LQl3Rb8SO59efOvwM0oDtE90SASNe13Nl5WHCxSQBdh7lI1g6ORaHbuFPY2qc83Jlcsg9ZOrF0SlgrOedQZ5h0SkuziFM0sNeeaudfpA2gevH5M/Y5AhMXpmIUVsoPDCI+miMxXBYxb1jJhOEZm19OFK0VQ+p9ux02uQwy1/hCbelxV+Cyr6ydgToRkj8dtvl6Tw8gyhes8PXEB0hDqOsGtSQ5lHnMpsmU9EXgOPRBy269jjaTPlFdKXGFA4fvvY6HkPgiIwzzYvX7g31nFe/5354vU5c3O0TZ773cB0M9E+4fRjZzlAu6UEnDCMCw434ayw/qiLWRFWR7OiO0nix0fDyErlkrnX7KS10/kred6BNJCuVGETUZ3BdrunErh7VO8/GfeOogepL00ZmcrrOAz9Gy6MLzHcs0j4qIL5JOt55r6RyxWQXVjkl5P/Q0wRWvDH3kcfxI2L2T4igjcvc48VXHuL+qeh8kbv5s5qlvXZxu9NYMhxt9TNT1sLMcpu8qe2fY0Ior/b/krZAe4aF/OskjyoRQCMrUPLRAOqtyzjz4Cyxf/6BIl5IKT1R1Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efd8c8a-79fc-4872-3615-08d851222178
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 22:30:30.8157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CifSKgHGnBy6//UMIVtCR+bE7VeggdFWP30mONWn9reTDXHLh4vEhCkTLLFmUvJW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2439
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599258637; bh=D9ihEJGjnZFrk0st7bErG1HtYywJMJeUJK35fT7u0ak=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=oKgmc6CaTMHGbyDxF9JNx6lE35XNBv1o2sX977jgmTmPcpWMiAPyJL4lYvpd43pIv
         C3Cjj9fpDpFi/jjECM4mzR95UVTEdBfN5JS2kYnMAVvcwxc2W6oEn1c9oUeV5fsDgA
         WtBrAnEsYwWiRG357kjKrnaIuKZa/zKQ2eJpBLRSsNyRHif2B5CHSkRuRpIMxJEqNq
         KGBEdo9L/MaOMvmHpOeWWcFC9Zf+M392Bb9j17gtxWHkC14nBkK9YTAycmO30XU5TW
         gBGm5SyqHk6UoJZ6/BGH+B0W+PUof8nYAXaulQNpbYDVE3D1djeMA2rr1a+MCVykM2
         aG4OQusDUX0Pw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 01, 2020 at 09:43:29PM -0300, Jason Gunthorpe wrote:
> It is possible for a single SGL to span an aligned boundary, eg if the SGL
> is
> 
>   61440 -> 90112
> 
> Then the length is 28672, which currently limits the block size to
> 32k. With a 32k page size the two covering blocks will be:
> 
>   32768->65536 and 65536->98304
> 
> However, the correct answer is a 128K block size which will span the whole
> 28672 bytes in a single block.
> 
> Instead of limiting based on length figure out which high IOVA bits don't
> change between the start and end addresses. That is the highest useful
> page size.
> 
> Fixes: 4a35339958f1 ("RDMA/umem: Add API to find best driver supported page size in an MR")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/umem.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index 831bff8d52e547..120e98403c345d 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -156,8 +156,14 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
>  		return 0;
>  
>  	va = virt;
> -	/* max page size not to exceed MR length */
> -	mask = roundup_pow_of_two(umem->length);
> +	/* The best result is the smallest page size that results in the minimum
> +	 * number of required pages. Compute the largest page size that could
> +	 * work based on VA address bits that don't change.
> +	 */
> +	mask = pgsz_bitmap &
> +	       GENMASK(BITS_PER_LONG - 1,
> +		       bits_per((umem->length - 1 + umem->address) ^
> +				umem->address));

The use of umem->address is incorrect here as well, it should be virt.

All places on the DMA side that touch address are wrong..

Jason
