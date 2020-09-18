Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA1E26FF94
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 16:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgIROLC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 10:11:02 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14065 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIROLC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 10:11:02 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f64bfe90000>; Fri, 18 Sep 2020 07:10:49 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep
 2020 14:10:56 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 18 Sep 2020 14:10:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XY6j4AlglbsCyvWaxHgEl9HiWuYeGwce8EXPU7eiXBNdQ4/vHvHJvGRj9q1uu3+QN+lCgTOEo0Krcp01wVtyIwL9FP3Vv3IW6GdHxnZeLfsi/RzPhPHkiXSVXfxFko87hBViEg8LGhwJ8DDIY6vws65Of4J3E2oyaqQjYIVKe8pCe83c4vvqYz7TgFHiN5c4zpHLpm/267UPOPkT5zolbBS2JSmAX/Fq3ERgBe+mOsrvHcpQ4OBOsvuHkr3DSpEHvkE1CXSeoc41vzvEtimci80O6ni+bfUXzokCI0QI6vy52Tcl6/uYJzFpML7nGHkPi4RYUlqOSlSesMDdtMokkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOkyHYm+ZKFNxdn52RCEuZzNnPDr8/uiUHkiiRmQrgo=;
 b=eMQ5QJjERdkm/+mKlsTNup7f2jWexF/x2zaKh2JUraZ8j2tzKp+p9iLrmPTC2Ih+omeq7NJn35B9jINrJhVSbuXA5HWH6GSSrWgZ6NybBzM8idzjIvdrDkGHi1j3ZRiAYHklIEZILZyXKhvJCgwI7cvediLPPEnJscH7wObofW/HJdo898UG5vdRjsJjSjJxNa055RwodxX5fwYxQbnlG0DYqmnBWNYgZjJUNaP2UPaeDYBmAGsj3QbYGkAYPUVpZiHFVhI8veY4j+/tH34kBG5j+p+nZ7Nbl3bJ1mX0fhSGCukdH6HIKiw08Qf9ZS8aL72wIw4fQK4s4MX7+gtSOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2940.namprd12.prod.outlook.com (2603:10b6:5:15f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 18 Sep
 2020 14:10:55 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 14:10:55 +0000
Date:   Fri, 18 Sep 2020 11:10:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 6/9] RDMA/hns: Solve the overflow of the
 calc_pg_sz()
Message-ID: <20200918141054.GB305257@nvidia.com>
References: <1599641854-23160-1-git-send-email-liweihang@huawei.com>
 <1599641854-23160-7-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1599641854-23160-7-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL0PR02CA0113.namprd02.prod.outlook.com
 (2603:10b6:208:35::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0113.namprd02.prod.outlook.com (2603:10b6:208:35::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Fri, 18 Sep 2020 14:10:55 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kJH6E-001HTR-7V; Fri, 18 Sep 2020 11:10:54 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c8b3e39-ec5d-4a9a-ba72-08d85bdca8ad
X-MS-TrafficTypeDiagnostic: DM6PR12MB2940:
X-Microsoft-Antispam-PRVS: <DM6PR12MB294033419AE891370BFA7AF5C23F0@DM6PR12MB2940.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yo79gvF6++KNh/+c2rdjWuWodpXU+7B1AEuX4slY1uL75FIOTraQ0gRCzdvxwHCiEW12MOU0XoqrWcI5v8pDDn3HsGQCNWhFdAerBl1uQAfUpg6GJHHdLB+pXRjzh6CoL5W1oI0jyCCdZ/ycYGqxc3eC5K4zOkD2DtRNk6u5nDesXjmyQwbDNZOTRDGNVOJsj783qg+oSd8VVlPMkLNL8K6KC1PEFW54GVJ1yUONk8g0hk/a9VYYQiBPpufV4F+gVoK/yyL+2MO27xuOUo+KqconAbfwT8vgx50I5HuqsyoUmxr+gMcdD1woRJ5PsLmYIBCfH8NxyWAQ9x/HLTIBhaM0EnglkDYAazXkBhKO3VQQy30J9AM/1HILWFQkyTHl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(9786002)(9746002)(1076003)(4326008)(33656002)(86362001)(66946007)(8936002)(66556008)(66476007)(2906002)(478600001)(83380400001)(6916009)(5660300002)(316002)(26005)(36756003)(186003)(426003)(2616005)(8676002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: FBjFAjbOuRDQM/jngEoP9jwGpaxn4mBLpIJj+KU6thIJONIGe2t8p2YIRBDtlp884gLKS67kWexSA/RcCc2L+GovtqyU9ILRmTfH9/1mP8EsJkg7fFEU9fPV5GD84v2iR6CF8KUCCCDSYKhVZuYdREC35mHxpHe+6B+7RrK4xJ7m+QwTDKtKtHYJSB7trxpRV+aBeoQVVND3K6KWzqgRzYlDFPJPAE1S32qJk6fMMZqzn7afKluELx0f2d/94H/0Gz4l5lRU0jrCoP/Mjm22u2itLvgAEB8niITyszjsv8PF34Co7//e4yScfz8TBlFBEG9VwGAn/vu0axkkXR4tIMU7hqAC6DJ6CS9lxQ/iZzSdwb20qEoymL2IGbUd+bhnUI5dhanLz80LEvU/9aI2+YkBHYLRWs3Am1ivtOJV+YBQr9rb5nVNhW1FPp2f8KHld3giTTGWIPdj7j+kl5JOX6zYQbHE6EiEbTjqK762Kv5UXI+IXbp36Tpt990knKuTcN66DoOeQP5i7yD8MeNKp6anp81lsMIHZiF8BU4lnkSt6sqShBJPWUX5sU352YhZRe6PKyHQBgOndH8ZZMVpfr36DrksD64hWFvxfjV6q7B55J3kciMF12xVqTmAEXzCqDT8IaWJMTx/+qkWnh7upA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8b3e39-ec5d-4a9a-ba72-08d85bdca8ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 14:10:55.6524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+bIg+/au2WPFennbzo3YV+AAQyUt/p1ojjt8VIblK0k/b4NEma1Bn4mT2AcDp45
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2940
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600438249; bh=bOkyHYm+ZKFNxdn52RCEuZzNnPDr8/uiUHkiiRmQrgo=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
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
        b=SJ6EpXwHtjrGmeIs76OR4Lf0a928DltOw7xcNDJvvsmQkFUYvSzw+KTfvAjFN4vAb
         x11AW7SYyvhq/f3hVjD80kiOvpL6TYTPvnypINmfg52zLJOVczJPGSbyF7JhydSW0y
         Wgl8nPNhzFW9vkvdadkklUvZLpmPdolkFRTZKCO6Jd67sCvEsvKuLydlT4MalNiYRx
         YqN3914+o/gf/JtZk/xHVBWeBGbOEccnQxsvg1qvPXSv7VluyfQQW8Oll7eKARPGC8
         jqK1EkW5X1Eb1pKLOApCY4KEycme99q6RlIVAWl0qLVVaUAbedTm9bmEMK+NdTwqUx
         yLXYWbWzM28pA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 09, 2020 at 04:57:31PM +0800, Weihang Li wrote:
> From: Jiaran Zhang <zhangjiaran@huawei.com>
> 
> calc_pg_sz() may gets a data calculation overflow if the PAGE_SIZE is 64 KB
> and hop_num is 2. It is because that all variables involved in calculation
> are defined in type of int. So change the type of bt_chunk_size,
> buf_chunk_size and obj_per_chunk_default to u64.
> 
> Fixes: ba6bb7e97421 ("RDMA/hns: Add interfaces to get pf capabilities from firmware")
> Signed-off-by: Jiaran Zhang <zhangjiaran@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 01aabb7..af2dea1 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -1804,9 +1804,9 @@ static void calc_pg_sz(int obj_num, int obj_size, int hop_num, int ctx_bt_num,
>  		       int *buf_page_size, int *bt_page_size, u32 hem_type)
>  {
>  	u64 obj_per_chunk;
> -	int bt_chunk_size = 1 << PAGE_SHIFT;
> -	int buf_chunk_size = 1 << PAGE_SHIFT;
> -	int obj_per_chunk_default = buf_chunk_size / obj_size;
> +	u64 bt_chunk_size = 1 << PAGE_SHIFT;
> +	u64 buf_chunk_size = 1 << PAGE_SHIFT;

This is PAGE_SIZE

Jason
