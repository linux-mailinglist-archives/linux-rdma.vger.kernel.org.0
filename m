Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D733D218730
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2020 14:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgGHMZi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jul 2020 08:25:38 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:34889 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728681AbgGHMZi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Jul 2020 08:25:38 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f05bb3f0000>; Wed, 08 Jul 2020 20:25:35 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 08 Jul 2020 05:25:35 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 08 Jul 2020 05:25:35 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jul
 2020 12:25:35 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 8 Jul 2020 12:25:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJadQTHFTa7YcDBNaYRpa3NgRgCHyjgtFePlBkqKQydMJPNF7LPMMQN5IHhNwgGF+hSg0ybOuQ7+XvZF38DAMnEqq9gdKqo/+9haLuOrALaIkg8E4ZEFbYXvuqgIoGAstVntSZdEpbo2xqkptFMoLstVtlQC11Yvoqpabs0HZpHMcBDZRrmSpeCsxpjDOzjX9eJXT8qzS7pXOJYEUY6NFzfAWuDnWtLq0KAymdpNHnnT4UCZrkLBKwB1Pnl5BY2ODNGjNh9S16h4o60D5i7Pd1Qjh1gfq0sGwAU/A98X5SiAJOZs+z2SljqO4RTsQt1olU10K+Np41xKWXmxg/OZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4dsLxnryU/aGEPOSloq/FhrXg9vASSRPRx14RFpRkY=;
 b=eLc0JvWCvtrW3sZ4wtZDvA0C+e8d3Vqi/Kf2XIyDLpF3U2fvJyHcHxzg8CUTwdo0cxJMgUlvvT7USpbnTuTiiHu2CEoDuxvjGc7AVltU5x2atkUV5FxNohFFEJ/8awrGg6EUFxOzsV6Jho0FXq0wBXUv1N1T88T97uNfB5ZUr6Xe43ruc1u/IA7JTPGGrlpdYYZNmdQHAwfAtayMttq12nr49DquscN9jcxGCtD27PrdjHA18iFuCU4enYiR2dcQwM7RSvfsufVqhideBWAIefxMJazC/QMHe3lP9pKAhxZA2PHoPNMZ/1oYWHfisQQTuRS8mFjwanAyddBEekW8lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2937.namprd12.prod.outlook.com (2603:10b6:5:181::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Wed, 8 Jul
 2020 12:25:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.030; Wed, 8 Jul 2020
 12:25:32 +0000
Date:   Wed, 8 Jul 2020 09:25:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH for-rc] RDMA/siw: Fix reporting vendor_part_id
Message-ID: <20200708122530.GA1574752@nvidia.com>
References: <20200707130931.444724-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200707130931.444724-1-kamalheib1@gmail.com>
X-ClientProxiedBy: BL0PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:208:91::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR05CA0021.namprd05.prod.outlook.com (2603:10b6:208:91::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.14 via Frontend Transport; Wed, 8 Jul 2020 12:25:32 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jt98k-006bfv-UZ; Wed, 08 Jul 2020 09:25:30 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63742edd-dae9-43b6-733b-08d8233a01f5
X-MS-TrafficTypeDiagnostic: DM6PR12MB2937:
X-Microsoft-Antispam-PRVS: <DM6PR12MB29372CC2892762DCABE1CEC2C2670@DM6PR12MB2937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C12ZDSA7KAdEt73AZ6dK1njEm2NL1WgyFfB8C38FN9PWgWQBv2novim9xQBcMr6XMg6S9uBAhIb2+9di5Pjxpm08OVzXpRbB2IgXfqd4GD14lKn5Rbo6CJltN/SebxbOTD6pfN4qIVgZ1SukARGWPU+kDffnt6hGv3i35mO/8oPduEjw9Do+GkhVUANueYauMMof7pr2Gy2avAPezqEC2nDWHJQf3zLhU8jo+pMUCCTKWxk18yYBYfVRoCrjTHNH+bnWzjphXnF253DkjOEp3OQyFdOuYjoe/LSBUckZmyLdTaz378taZ1ZiWGhbMHMGN2ZjLG7h953MTGy3+wbRRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39840400004)(346002)(366004)(396003)(136003)(66476007)(426003)(36756003)(2616005)(54906003)(1076003)(316002)(478600001)(83380400001)(4744005)(5660300002)(6916009)(86362001)(33656002)(2906002)(66556008)(66946007)(8676002)(8936002)(26005)(9746002)(9786002)(4326008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: KBnsLbZu0D1bGqukMHigYt30zP2q22xLXPXCNLu3h6yqjxgWVgYh/YxP6+zDh+XGpV9/uyTopAA9naeArdxKMkS8KE1CmSy1lBeyGjCrfQi3N2BFhdiDrbZAr9wqr4AWah6OKz5+6V6mAKRJn6O6GI11BabGcxXaihocZtxOq7lgFnfWLQI6a6euyRBzgAVCKgxAEkbPrRPmkwHIrDt6oFm/gxkbi8L+3LAsDYoIuoz6LaumoVSJ86hCoc8X7H1x3i8P8duwfw4feFpfVy3OVfSOCuhgsMwwd16FPZTXSN8ToU6gntI+GLcS3U3Xp+1u4PDYYtsclZXlbT+NGwPzMUPZqjY/yPP803Sjo752kw7Vln+tyy90isI7YXueMxx2TJuvbBSxBgxlVnoXMb1xMWGkXm5xMd3hIdCpYBt1RSO3roAG20aTacShSTGpPUf5pLrqVF+JsOwYDajc4mq9ffoCN++42fk5/g+UUzwaRTk=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63742edd-dae9-43b6-733b-08d8233a01f5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 12:25:32.3721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kRG2gQifbgSgEMYFBBlZZua0PzbjAlKGrhyNuwIRyvVA7izwh4gb1euEnJNtFlZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2937
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594211135; bh=U4dsLxnryU/aGEPOSloq/FhrXg9vASSRPRx14RFpRkY=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-Forefront-PRVS:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=DLuPMVfruCqmc6hvegL+C6i34xrQDyrggwne9gWgG6t96lFHQcIRrSNBPozW7YYMt
         y5KWj34336VGKHJUPj2w4jrpiY1RdsoroDBZO9iDY3wBiPzKXcBf6HZsLOWFVx9ddr
         G9Sfu3xH+aMzOXyehD16EtFXzdMKy1VJD60n28EGgK3t9KY9+BFGpcPrr7eRX7uB0R
         g+jUsMwimMlOJtG00DpfRSGiR9KFlEtlHeKbXQIv8tpKQJQNDMeTixetvUOWavcrvo
         DHv9Dh0OsMrTGD/Fgf8haGWOMxaFtYbJW05nw1KG2RUNTDRoL9A5aUKxdSd1F8TaO6
         4E+bNyeAbBh9A==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 07, 2020 at 04:09:31PM +0300, Kamal Heib wrote:
> Move the initialization of the vendor_part_id to be before calling
> ib_register_device(), this is needed because the query_device() callback
> is called from the context of ib_register_device() before initializing
> the vendor_part_id, so the reported value is wrong.
> 
> Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
