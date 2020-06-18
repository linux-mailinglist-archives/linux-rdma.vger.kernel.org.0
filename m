Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03021FFAE3
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2020 20:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgFRSPf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jun 2020 14:15:35 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:39191 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbgFRSPc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Jun 2020 14:15:32 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eebaf410000>; Fri, 19 Jun 2020 02:15:30 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 18 Jun 2020 11:15:30 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 18 Jun 2020 11:15:30 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 18 Jun
 2020 18:15:23 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 18 Jun 2020 18:15:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxGSq1wWGqhMbgsdUxEmrlptaPxQsQ3LI2nauCtfZ9yhWsikO3tsLdaMS/GEJqx21W5sbmUx1dpaju3cog40JPm30fvWnKJdBWjauijTWaR41kgRuhsHdBOHDMrhpqmZRh4bb0DQWR5i7eDfMw9yjD6VYj3qaf4tmJPPPS4Aih0WdFOBLx8wsNH0RKLwtCqAwvIDRET/YXhqsk7HhEA7hvzKWZGmrBu4JwGplqPMY4vzFQ8ep/7ARwnb+bMUbQrzFa4BcIF4+emDSMk/NCzH9NWSroFUcBIix7tH/2X958PMZ1To8lZTVhXsdYgExK7y+/00/3zRHRgaCJ6VFFyGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yV0BWspwScfsja0JymM/YTIwjCH4XN0JFe2H1c/pxmw=;
 b=Bcsk8dnmqT84eDS+jsUZyUkB7NvE8GAqx13LC83YYxEuMsp2m0AlgGE1rogP65JjIgAPRtaFiResWUXsZ++TQ40yD9qy990qA1A3kaESTNxTkzn4xXa4doO3H/NU+1bjxVS1hAEE85VbNhF6bEMtBAhk0ks+DqHgTSXJ36lsqg23GCAkTEmN3pHj5FkYhQOxyDjz4niO2Kyxsd74Niu1a3Ro1V6L6l9ij1JKoewidUB97fpMZFOBjuQGxGKXgExCKqiwKxGNudbNcNHPl3UtnoerFY6YttdBnjb7k45QAVSDSLpU33HmUqopRWeQqFX7OeSQP8jba0H/QqTiGLJfzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1244.namprd12.prod.outlook.com (2603:10b6:3:73::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 18:15:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 18:15:21 +0000
Date:   Thu, 18 Jun 2020 15:15:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Max Gurtovoy <maxg@mellanox.com>, <linux-rdma@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix integrity enabled QP creation
Message-ID: <20200618181519.GA2449914@mellanox.com>
References: <20200617130230.2846915-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200617130230.2846915-1-leon@kernel.org>
X-NVConfidentiality: public
X-ClientProxiedBy: BL1PR13CA0041.namprd13.prod.outlook.com
 (2603:10b6:208:257::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0041.namprd13.prod.outlook.com (2603:10b6:208:257::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.11 via Frontend Transport; Thu, 18 Jun 2020 18:15:21 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jlz4J-00AHLZ-W1; Thu, 18 Jun 2020 15:15:20 -0300
X-NVConfidentiality: public
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b462d4ea-4eb8-4792-6498-08d813b39013
X-MS-TrafficTypeDiagnostic: DM5PR12MB1244:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1244120A26C182579F5421FEC29B0@DM5PR12MB1244.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obKk+5hdOSOEnlmRTr1Dwq0fh4Ucboy01dG9EhMQO44+11fr2ojmAmPauQEJIv+Vpa35Sp+nG2LCUk7G6fyBHmNopN9JFTC+2k9WQoXmxVi+LnuxZX2/KF/3pB6vRkXthB488xSPpPR9fZHGK4rzRaR4AiJXzXbr1VUPik7P3725Hvhx7hGKbNq9mUccmOIoB6AyfnRyOuEsvDv/A6zrUlJqZ4+RfVCComCxAyrhZgGWCgvLULoMF51riDKJFCpHRNhshlbEctFdjVAS2I1MsIVkoHpCpYn5HoDVMt1dAkAzv2CyXa7IrzYRYLFkOef/fuyp/IfoNf5/MMDrGbm1WQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(396003)(136003)(366004)(346002)(66946007)(66476007)(66556008)(26005)(33656002)(426003)(316002)(54906003)(186003)(86362001)(478600001)(9746002)(4744005)(8676002)(1076003)(5660300002)(2906002)(36756003)(4326008)(9686003)(6916009)(9786002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: QVEKTOOhfAlvvxWKvn2KLFx6Frjse+852HUQY0vUqtDvQrNNb4or/Ra6ONeOMD+7BAq5r45iYj0sralFqget2NN/j2ZY6MGmzWQgDbZCLopY2Imdcnnj68grtxDvSNSnAZyUnPIjLxScUTgnuARYv6zPFME9hngQJJOWHT7tl9PsS6Wnrw0/eAY+Iv37djy9xPmGW7qahEU/ORDkXlnuBh0hVL30ptPuJtGLnp7aJD3rCW1yHJQULmJroFe8uEy7yfXDUlEOQ4MltjO6nlfTNBSRU7SSGmb7C3JiNGWyv0Mrw8oQZPIYnylguszVoACgfv7vZurHoOUX4XmeizVHhkEqtELhqgzNWDXe1PEViMwrR5ZZqwhoF/N7LwQ9rFjoXT9pTjUNB6Cl1Zw8vSa1SSSdTEe5H5UVZf02ctRii/eC+YbkpHzINgcx7djbIZxhV65KVzj1DVeqgpxYOVO6nDKZNlcgQKpShUr6QVYTJzc=
X-MS-Exchange-CrossTenant-Network-Message-Id: b462d4ea-4eb8-4792-6498-08d813b39013
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 18:15:21.1528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFSFR2RRBU2XLIqA2ke43YQ8pas41RoHYs5LuFZgBm8rEJb8xPrWzdEBF11CGxJK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1244
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592504130; bh=yV0BWspwScfsja0JymM/YTIwjCH4XN0JFe2H1c/pxmw=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-NVConfidentiality:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-NVConfidentiality:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-Forefront-PRVS:X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=nEdVA/w5sVe6dBpmfG2YOMUHMPXfmHZtRGb1rIvDQaCUddPLoKrCv1fosMqMAy4ee
         yNEPqn1extW18+iC7kmtptWCvD/jUmM2ZJ4/EVs3TkoKQ0QAifX+fTS53yHqBLu7X/
         OZBWKxWuoeXHOZp1PvS8ckuDiZPcsdtG39fKt/G7p+cHAwFc3oMp8nNmnxVkHZqAwi
         noHOcOT8b5rw7422D4Dnhhyjv8kGJ9EacV6R/2CKxGC3f3f9dTQT1iTNIVtMEHoSAA
         8LkphhaJV2nSqubgmGY3lvCOQwVvWpRKIlilCJz3JOKuUoE6w0rJCqmO01bpwZU8in
         7on0xTugF82Bw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 17, 2020 at 04:02:30PM +0300, Leon Romanovsky wrote:
> From: Max Gurtovoy <maxg@mellanox.com>
> 
> create_flags checks was refactored and broke the creation on integrity
> enabled QPs and actually broke the NVMe/RDMA and iSER ULP's when using
> mlx5 driven devices.
> 
> Fixes: 2978975ce7f1 ("RDMA/mlx5: Process create QP flags in one place")
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to for-rc, thanks

Jason
