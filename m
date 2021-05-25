Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACAF390A63
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 22:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhEYURR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 16:17:17 -0400
Received: from mail-mw2nam12on2067.outbound.protection.outlook.com ([40.107.244.67]:63457
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232744AbhEYURQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 May 2021 16:17:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvyToJSsIRfahW2JKqUFRnRCPfFPhLgL/rZ7oKTVLF4w3bMYl3O0dXei5fRnLAmPY+f6XQRsKx0ZxAMLSmMcw56GUHrSqTXtiTAjnj7uU9EkxtbyapbiTh3QFWdIrM51BH59Q/SOI/nmhsp3gmU3ChvW/zfwfsrWex9ZNoJzazHFakwLYRHGUER4WM3RCC8IAihcIz93vZeojTTdieiAmTVqnx5bmBJXjFG0Z/ztvVGJVYkyLWrQtVYL4WFxk3ifAs4EACkmvcR5pUajEnOONYJXcyvUIP6I+lyVbI4+tQdFeBJcDTlBY+VJdpfqJ6lJeLJV2ybX7k+5YweV1hl57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjYPBn5+k+057EkZ128A1cZVLKyFyT6u/ahiQ1D2kIg=;
 b=jKXllUK0C1a/NMQHMXkqPoOfJyE8g/m2upx5FT+4EfZPgmYmgg5xhwtZdxss86f8b/hV1uiUkh7BtlKScHP+iV3FwcTBPvit7n1rscH4WuJMQObxCdzr/D0IaZmmW3cnqNKcCUvkx6qHmJBririlj9sukktGDucfP1x68mDbPxwwKER8H+swE7GlWF89PsWL/TLyectUdsUnF4M1sGrkIyOVyr/T/LLR2P5q3Cm9oBV2Eeve0p0aUNPPD3MGxjBd4z1cnl4dVo/Qu9a1Je1zHT0XxFVBobNsuNOJggAcbOpGvG06YMnm35fhQcHIrtJuyDJtZAWNWtYuNfgjPrOsXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjYPBn5+k+057EkZ128A1cZVLKyFyT6u/ahiQ1D2kIg=;
 b=ZY9/QCm5owjRZFypoYHzucCKhyW6fsFjh58mvBTRD7gNdg17jNhMKtlGJkZLnVuH2RVyPA/yKYwSK06OXOcu0/U+vx1c+L+G0/rJbBHZO44QQX3ps9cPzY2xTOPQMXODbd1RudTk14QY+z7A7v2Jw+EXniui0mTzILuD7ENBrw0/tzzv3pDkdf1vd2FkazLJILbwcx0u7ycYgrjAipwPEIw2zH+Bj1Q0PVozBqTqF8M6CqUgivWnXiq//YBaVY2FCWn5DUJzLEv4sez9/GSEeJhJk4CcJkahLhwBp/qwYejzpgOHVGot4ohs6QW3oBHW9N1Nk0uKSxQUXpis+jNaQg==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 25 May
 2021 20:15:45 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 20:15:45 +0000
Date:   Tue, 25 May 2021 17:15:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: Re: [PATCHv2 for-next 13/19] RDMA/rtrs-srv: Replace atomic_t with
 percpu_ref for ids_inflight
Message-ID: <20210525201543.GA3482418@nvidia.com>
References: <20210517091844.260810-1-gi-oh.kim@ionos.com>
 <20210517091844.260810-14-gi-oh.kim@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517091844.260810-14-gi-oh.kim@ionos.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH0PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:610:b2::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR13CA0049.namprd13.prod.outlook.com (2603:10b6:610:b2::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend Transport; Tue, 25 May 2021 20:15:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lldSp-00Ebwo-TZ; Tue, 25 May 2021 17:15:43 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eddbfec4-9319-4e1c-4b37-08d91fb9e0e1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5157:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5157125D006DC5CAFEBE21C8C2259@BL1PR12MB5157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:130;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qp0IVh8ExBQ/IAOarNB5MFUkN4J/qLjRsNXnaziel21ziB+Z/xTl2NdLOzRB+Va662NyK0bc5PPM74wIEqYsImeBSxIOjQJv6fxh5jbA4WCGRpLDJuDMXvIZFY6XktuhMB6c8YbDbtqSA9rcTG5azpP8iV7mrJkYFDJ798Ev8Kec9aHYTwltpqwhRBOy0tdnAh0wItVST/zvuuADlB4IwLLVH2YjTyv9exzeLHpwgCsCd/ZfDw2HxDwY76C9h9KM+j+NBK8p3VPjlilSRe+Zuq+LE3XFMThsoaB86SC0jKyLj9R4o6mR4B1mAkhFPO6LBdi0JhQLpmnEDqHoGSybx9zXrkOPijqn0oDjXpNEaMbDqNvHdrYHUYUYzW0P9cZ3l9YuaZUpwtM4yU4PhaS0JMN+OzF1ZZ/AHc19IVIZzcFcpnrMVYedcLp7baIkY1L+r9CBQdZitDyR4ehE05I3Q+vc3/qtXmlCSOOr2zml9NqQA/F9egxv9lsClOjJkxOkq9GZMru4R8p3vjlIs5sD2ZamKKVuHcGPV5De2IXwWAMREnxkAM6rmKCw0f/4w0HNQuN38s4vpD2XpbHNcedTG+BfctZRmahWoaPte2ldsII=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(1076003)(6916009)(38100700002)(66556008)(36756003)(186003)(86362001)(478600001)(66476007)(316002)(9746002)(8676002)(2906002)(9786002)(8936002)(4326008)(426003)(2616005)(66946007)(33656002)(26005)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jbY1ateB17cUHHVhXWLnieK2MQ9AFasUy9zucviCSizQVfgrYX6syVin+hgC?=
 =?us-ascii?Q?Ljv1ErJoJC/AsOcqaiV6/SsJXpGvzjxMPwyOf3d8Q/u6tnm24oMpFvDfrRMf?=
 =?us-ascii?Q?4x6GYgvzg444kspvpTJhZid3+8ps7tvqH9XTFf4kf9DOUGUBYcN9rLxY9Axl?=
 =?us-ascii?Q?H6dzkrwCbgQlDEaLtEbzr76YWybtPRiL+fTRvkb+NMZC6NVhO82jyBjvWeD+?=
 =?us-ascii?Q?K7jHXTof4BeOW5jp75ZXPTMonw3w4uB2GwZSrXIXbCXzpwVaP30IcsmZL4mD?=
 =?us-ascii?Q?45q7J/Za7OvlY53Sz4eUKjeN2EAzBRT6qqNlgRGdW8B6N62SSmcqg9VFGVpm?=
 =?us-ascii?Q?E4eFATXWftTTrjEmE3UGzLLQw5rqFYlI/02qqTFKPrqCmG4+QmeBxpn492My?=
 =?us-ascii?Q?vm3snjg2jI6xNC9ygL5g6equQpzPqcwgT7/rqiNHMFz5Gfx9xf9Lr8C0bEE+?=
 =?us-ascii?Q?jWOr4Unrjfz0anRD1P7ARPjXDDAfYAybnruXmQMYVmROBIP0LLQ32qpHvl9P?=
 =?us-ascii?Q?p0bR8+yqhbSt7nRybgN5sa22nbM54qAQfoJbyBPoDTvO/8epvOQrPSe4cI2W?=
 =?us-ascii?Q?eWhgVg2jrWJBNX7L1VQAEEMArBfmcgN5o3aI5110z7QsrT3kbRlT42GhGJMx?=
 =?us-ascii?Q?fF1HVgfKM6p3xZ1w0i9VhmfG0M+rHslRrY3APo08R+ACLelmZTwWxr/+sZ5e?=
 =?us-ascii?Q?B+IaaEeCfOOoEtPqN4W4U2Zxt0Vkf69uTMhlVGz8HEhu3iqMvD9isZMXWUhs?=
 =?us-ascii?Q?JXG+FPIpYchiO7rjPK4FYBMgoUHnNTLPdheP16lcF6Z3waeImstVgR7AxRBS?=
 =?us-ascii?Q?rsNFDxRaeiOPlNvGJpykk63+sIfLi4nvx1q0gtUNnFOHO3hKKgCvChXza3jX?=
 =?us-ascii?Q?ONmuZ2KUzOHLexob+rc1QnRjL9LuNO/F3TMx6snxWBL7CpFZpOh6uwEaNaS1?=
 =?us-ascii?Q?OBLEcei9q+pzXT/qKeuBcmcLdtDPSupEyeFb0PDrvXwd8r0PqLVLM7x9r7JE?=
 =?us-ascii?Q?98M7wZK5nqVXW0JNAZIa3JcUaezC+oVVIT1cwm056VSVgRBAJv+S+vfTEoM/?=
 =?us-ascii?Q?60SqnY/2Px71gU7cF1syplzyRKZT3C3Me/NJE5f7M+F8J4PeO9SriGquiaJt?=
 =?us-ascii?Q?FTv7FA/ejwKDiX+DatRyTPv8byI9w+oWIelXd2CBCE8uKLMDNvmwsKo5+uDa?=
 =?us-ascii?Q?JMoosSwYw19VuJQU2p1Du2MgPukHtPUm+W62nLbuvuAXyII7ZWlXKXKkhZHG?=
 =?us-ascii?Q?PLtATgA4FFyE+Mqfb6LVYwVxP96RRvDcJPMp4j7piWn0aXZoREv6RdpDt+N+?=
 =?us-ascii?Q?OIhCHMtSASIFb4sYYKPv+0Rn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eddbfec4-9319-4e1c-4b37-08d91fb9e0e1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 20:15:45.3500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2HNRj9n6CqP8X1SR8HbA0KBPn9ROr3aHpW6RBj8LPMo8rJV2nFW/FLEguxxZxK2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5157
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 17, 2021 at 11:18:37AM +0200, Gioh Kim wrote:
> From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> 
> ids_inflight is used to track the inflight IOs. But the use of atomic_t
> variable can cause performance drops and can also become a performance
> bottleneck.
> 
> This commit replaces the use of atomic_t with a percpu_ref structure. The
> advantage it offers is, it doesn't check if the reference has fallen to 0,
> until the user explicitly signals it to; and that is done by the
> percpu_ref_kill() function call. After that, the percpu_ref structure
> behaves like an atomic_t and for every put call, checks whether the
> reference has fallen to 0 or not.
> 
> rtrs_srv_stats_rdma_to_str shows the count of ids_inflight as 0
> for user-mode tools not to be confused.
> 
> Fixes: 9cb837480424e ("RDMA/rtrs: server: main functionality")
> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c | 12 +++---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 43 +++++++++++++-------
>  drivers/infiniband/ulp/rtrs/rtrs-srv.h       |  4 +-
>  3 files changed, 35 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
> index e102b1368d0c..df1d7d6b1884 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
> @@ -27,12 +27,10 @@ ssize_t rtrs_srv_stats_rdma_to_str(struct rtrs_srv_stats *stats,
>  				    char *page, size_t len)
>  {
>  	struct rtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
> -	struct rtrs_srv_sess *sess = stats->sess;
>  
> -	return scnprintf(page, len, "%lld %lld %lld %lld %u\n",
> -			 (s64)atomic64_read(&r->dir[READ].cnt),
> -			 (s64)atomic64_read(&r->dir[READ].size_total),
> -			 (s64)atomic64_read(&r->dir[WRITE].cnt),
> -			 (s64)atomic64_read(&r->dir[WRITE].size_total),
> -			 atomic_read(&sess->ids_inflight));
> +	return sysfs_emit(page, "%lld %lld %lld %lldn\n",
> +			  (s64)atomic64_read(&r->dir[READ].cnt),
> +			  (s64)atomic64_read(&r->dir[READ].size_total),
> +			  (s64)atomic64_read(&r->dir[WRITE].cnt),
> +			  (s64)atomic64_read(&r->dir[WRITE].size_total));
>  }

This seems like an unrelated hunk

Jason
