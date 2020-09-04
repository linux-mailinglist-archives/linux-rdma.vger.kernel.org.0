Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CE125E3BB
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Sep 2020 00:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgIDWdB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 18:33:01 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18179 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbgIDWdB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Sep 2020 18:33:01 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f52c08e0000>; Fri, 04 Sep 2020 15:32:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 04 Sep 2020 15:33:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 04 Sep 2020 15:33:00 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep
 2020 22:33:00 +0000
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 4 Sep 2020 22:33:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QE9MYAmNOJWd2KUPe/Icjdvt4ARjh1tcj9ahcVibZEipjfFMdkxNkG6gGsj3GvSjjXuUgp5hTNJhWBONBn+33atZQr9a19m1MzOEWZ1l7Gp7OiepfBE9/LIL8t2qxGgwffxojzrn4syqDbQwfUadi1CBjN0S9VOTTFHMQX84zzQct4ODw5x+AcR7ATi3WmW8triUfrD8r9VrLOl3vj8yeZUuHKUQ1XDXAuQpUFt+vUa3CcvgsslnV/Vv4MyDn+7mNSWI8mNH9oG1sd2eJGvnp2Mz5CupD6cjRm0/VaXHO9ivEPBxIe5VAUPYoHOiYN1QDXj49Y7iBi3O64ygrhQzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvCuK5US/98XMQR5kpvg5hC0iI91xNec5A1rEXhXlbI=;
 b=j2OjbKG0KmUnBqGK06oronvxuj8mKd9UhoG4j46yCTEOqgbNWvkNFepWDBir1U3IST0f6PuEOh/wg4JWYcvqL1mNpM4M+mWaQaNxe9dNi7zmzV3Nb9n0qKA+Z5yFvtX0N5gk3C2wNBrJCbw5ocEg+LjhJta64ef8T8riBu8ZjCObLmfv4cxLSJ3K2cpAdao4Xl4rSm+jkkgdhs8lRA9ORVe6E16cF8lWxtFDCsoDUpMi9yL123fzFiyBgs5N81UGkEj+F/LUdXNyQOiqHpNqHXiJHqpUGu3APbdJpdC5vEr25oto1PW2IRUPJAkzpaTLn1tVjHoFj5af44nSePVweQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: vmware.com; dkim=none (message not signed)
 header.d=none;vmware.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1243.namprd12.prod.outlook.com (2603:10b6:3:74::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 22:32:59 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Fri, 4 Sep 2020
 22:32:58 +0000
Date:   Fri, 4 Sep 2020 19:32:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Adit Ranadive <aditr@vmware.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>,
        VMware PV-Drivers <pv-drivers@vmware.com>
Subject: Re: [PATCH 06/14] RDMA/umem: Split ib_umem_num_pages() into
 ib_umem_num_dma_blocks()
Message-ID: <20200904223256.GA455005@nvidia.com>
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <6-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR20CA0039.namprd20.prod.outlook.com
 (2603:10b6:208:235::8) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0039.namprd20.prod.outlook.com (2603:10b6:208:235::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 22:32:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kEKGO-001uOn-Sh; Fri, 04 Sep 2020 19:32:56 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0081f9a7-bc9d-4e0a-4064-08d85122799c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1243:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1243BB3D251F899981842F51C22D0@DM5PR12MB1243.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dif5vg9AErHdC+ZEVEcp/j4uPu3TEMqmSh+CTAkvxSe73Uq9dz57Gon1UMI10i5GyOG57vEThtprtWARvANxfIYkoW7B4NvqXHzrgJPn/IbOAfY8G/QftXfKhuMPU0oyP7g5cn7R5jmA4qLBe8ZP1b2FP/DK8+lv2hjc/Fs9fZC30hsAo8uAy5zQiNjdzHI0nyfGwh6qfImjUyi41w9bLUQ8PGmyuTV/2i90PhSuj/gYZ8qWdQg/DaHd2QA4WRR4py1uQwPjwaCtAIGZvPD+UBZb1xL1pdhZgvTdrzjDQmsyFicBSMpDH3H65vEKR1cE0Ws6ZO12D+GNfOk8X7EPduhntBwy7T9gpgTVvAmXm3FrdOgk0r4rA4t1TqYK1vBW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(8676002)(33656002)(2616005)(8936002)(110136005)(83380400001)(2906002)(66946007)(1076003)(9786002)(478600001)(86362001)(9746002)(36756003)(66556008)(426003)(5660300002)(66476007)(316002)(4744005)(186003)(26005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 6ggrmTfdPJkGUotDEDs3qdcldqtd8CXtLN23g+RDX3Cpu3aVA8KoSt6Zz8tPd7Z8GnQB7UHf9i5GSNUUz6pydUOFGiVxxhn2SQ0lwTZTpfym5dZfWpV+UxzSQkrOgFiL/BucpS1B+3vUuS1nrWR1ZnqhRhRDllFrJDMH33gtruHwWJBQtMtailaZgd0gQT47VaMlW601hyBdCCBaSr08M+3O9y/EMwwxesY9TAtUezDUw9d1TStLBy6u3+iHRuJbyiZNZjdkjyG0rMZmynaXcUm6xRkfMibeWsiYejTpj/t1wDOEAZJ9atxxRiSUOiumXcld6pUBPD3ILEmXr3eoHWn/NiENlvMW3Xm79X3banRlh3V/TYzc6kYlIdq8V3qH9EyXcQoaKhBv7m5GADukpIZK4ZZ2x7q75/vRbNg2IUCtD6htke2spZLY82rudYrbm069+orGGJpXiDoYdNlbAHMruicv2mmcq7cJjrg4d9uM0NXXT+Ae+SP8XHl862Azn4YRGpfYc2sphh/llbhgawYFmn2z4rJPZrXPbRcmFVepCt3lkVRmVnuBWHkBiIHo1VLWTUadmD0Gzcs38f9IHcUN60Jla1BNYlHs2OMgeKIMpFpxMk43U3coGPP5wBWFIzbDyRJLN4+DuSQzZ0Bq1g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0081f9a7-bc9d-4e0a-4064-08d85122799c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 22:32:58.8283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ss9ZO3LsTdWPB8f4eRlvt4uB2uChYAWqqsxDzjmDds21AxMaA2oiD2rJ1JNcCS6A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1243
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599258766; bh=KvCuK5US/98XMQR5kpvg5hC0iI91xNec5A1rEXhXlbI=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:
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
        b=N74kHk71ZoKx4NzP6LyYl/WRkSRcpiOjAQn1v/E5r7t3Gh1t5OHehPOis5RnLyMvZ
         Zy6cpwz9pMzxK8fmH1dS9R7lrpg8GvtP+dcRub2vd1K2J0KCFbxN217Zt+50kzbtRB
         ljEYwilSpWHluWWMmG00mv5jCW1YnejzGnSuDqeFTLpNyRXKM/4M0L7+rkS5I50ZNb
         11Cchiq+Yk1RNuSKY3osILJdRnK8K5+BdgCfShHZqi+yDyTRw/JuexawwJXJ+BxA5G
         ddSEILjlHir1dSy1VNvK+StcfFhdA1fLTTLJuXeZCznWxdOR6kkAFXZFthjqhpPixb
         wzhwzyde8+FqA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 01, 2020 at 09:43:34PM -0300, Jason Gunthorpe wrote:
> diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
> index b880512ba95f16..ba3b9be0d8c56a 100644
> +++ b/include/rdma/ib_umem.h
> @@ -33,11 +33,17 @@ static inline int ib_umem_offset(struct ib_umem *umem)
>  	return umem->address & ~PAGE_MASK;
>  }
>  
> +static inline size_t ib_umem_num_dma_blocks(struct ib_umem *umem,
> +					    unsigned long pgsz)
> +{
> +	return (ALIGN(umem->address + umem->length, pgsz) -
> +		ALIGN_DOWN(umem->address, pgsz)) /
> +	       pgsz;
> +}

Like the other places, this is wrong as well. The IOVA needs to be
used here or it can be +-1 page away from what
rdma_umem_for_each_dma_block() returns.

However, it does work if pgsz is PAGE_SIZE, or for the very common
cases where umem->address == IOVA... 

Which, I suppose, is why nobody noticed this until now, as I found
several drivers open coding the above.

Jason
