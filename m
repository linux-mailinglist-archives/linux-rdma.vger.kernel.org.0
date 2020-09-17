Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AE126E336
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Sep 2020 20:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgIQSGZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 14:06:25 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:45157 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgIQRjB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Sep 2020 13:39:01 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f639f260000>; Fri, 18 Sep 2020 01:38:46 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 17 Sep 2020 10:38:46 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 17 Sep 2020 10:38:46 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Sep
 2020 17:38:41 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 17 Sep 2020 17:38:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQIjXGCH2fdb1GVfwAw21kxSmadqYOw+K2Q9bUKATSJCnqRqoNONtWWsPhYXrIaTp10Zzv/CvYInVzlRGPt/7YWuTnTCFAHFLbio2xQurHR925xQB6Ku2w14u3birFQ9+9y35j/4zDL5bsVZ+mnk8/6NijtvanI9Zeuu8mx01ftIPdZkJr5IFWtFggC4AM03Wl5qrV+m3DNV+BIX1+HA6+p+6MPX570ZqvrfN+UMjWZnUN9xGrIyR49Eb4YrBURwq6kUynD5kCQsmB7CTZ9bcV8oD2y/44QhJ80JjCFzTdxFu4uLIW91pgwjkiZl7XX8fOU8moebqJUvX5kqEAilLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lK9KGzE2h/akOHZOPppoHCgoY5LlNSx3LUneGLKJgj8=;
 b=Wt+f10X74lLaUt/iUp50BOfSVjZDWAqudWrUXiFbkLRogX7HjDyDr1DvEXUBtTjzG+CqvQu5gqY2m8MOXuqat+R+jUQXzAqr/ASwtwn5XPEWLfG75fAVUWPqw6JtzWHTcEArpxAP0/dak2MFDo+KH/qH3DU82lfOWq43DZun9vLovZSp/CJrNssmlhQSsjEua8WyfuhejV2HJNRdlbRKkRCFj9ybwFgnCxtx3AA8fqDfIxgS2zBVduq+jGLmdYkihXPnaUJpf03I86yXwd92gTDXbcom2KeXFR9QJRnwWhp3ZVww7J9qkJwSoLWc9oGRREeG0asnJpYWY4yroTRrtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 17:38:39 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Thu, 17 Sep 2020
 17:38:39 +0000
Date:   Thu, 17 Sep 2020 14:38:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Lijun Ou <oulijun@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>,
        "Potnuri Bharat Teja" <bharat@chelsio.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 0/2] Convert RWQ and MW to general allocation
 scheme
Message-ID: <20200917173838.GA142152@nvidia.com>
References: <20200902081623.746359-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200902081623.746359-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR15CA0034.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::47) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0034.namprd15.prod.outlook.com (2603:10b6:208:1b4::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Thu, 17 Sep 2020 17:38:39 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kIxri-000azR-Ho; Thu, 17 Sep 2020 14:38:38 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2078f1c4-e43f-49c4-2e71-08d85b308375
X-MS-TrafficTypeDiagnostic: DM6PR12MB4498:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44984A2CFC39BC0B49641364C23E0@DM6PR12MB4498.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XyJvVDtLyR/TZIcyVoj3r+dqtLOlyjZR4N90raJt4tx/bakTrvrg+YACUGDIDbIVGeA8r6H7fOETgq00WNb3d8Z1hnl9MIVUlm78O9JGs3yJukkx9JWUUP/7S4BTPRD27UdqP0Xi17nCYpFokAkVOXrmOKeQFMQnmPw44/OIzvxFfX7WgjwZGP49n3CMZ+6JjLggQ1O9Ztp5r7DFjFjNXSkGZZyrpAYTPXJWRXKJH+1V/6twBjkCGCKvvZNlVzRrX3OU7LpPc3grocqOTFxmGvMRvA0W/bxvN590V/sx7NS+TsZ4JngT3X36t8cCdIXDiGgviv09u+JoiZheEuk3RV+RhRbqXIgE6PtybylxjlqNWQ66vP/JPvrqHM2jqokm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(66556008)(66476007)(33656002)(107886003)(26005)(316002)(36756003)(54906003)(8936002)(478600001)(9746002)(6916009)(2616005)(186003)(9786002)(4326008)(426003)(66946007)(86362001)(2906002)(5660300002)(8676002)(1076003)(4744005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Gb79GOd51oyHmZBXHEkqA5CbgNC4AfoP1DsMGlNN0B3ARmzGjBh/Vd5VCCtJ6BPhFIYKXl0dghTGKLtBp1qtT6rAJoKVwdY6VKaizg9KKcM26HFp2X85air4iGAaMTMI18g5yDv+pyq0d43wWa0C29bU0vb2V8/UFUQ5opCIP6P0Y+eV75JS1p2Pk+kAzWJgeeGus6j85bO+D0YDAUjllVEAtPdA2AC8HMSkkMVVqv1QDX29H2AZ0M/fMDSBK7T9Za3cdH4iK8u+Sj4ZAwlrMyCyNySuYoXoQCSngmKIC3ZbxhzoMIABhXRTx7lKSIn84Bw25FGqinnKZW94cB7HsnaRyfKcmcbCVoR7GhqanoeUUuJNdMKPC277RHGjEQbzIrqstaPLGbpmvtQltrUqnPXtuPHuvXlqQvSlnGfLdpy0tIX0iNuNkYFa5XkyNdQgRF9zafJz0BznPrYRXQ8GlYEuQSfS3hT5ItO3/s2Xwrx4PUduVqi3kD3MnlC3Y1cN8C5G/4BR2YgBEx/HVovS4/qE53xE9dS7rsQJlybqjtrUnPzU0DTr0OwXgf6KaA8z092SZgbPaA18FyHDCbpsX9aGDoGcRb/kCr71LjbiCOKVvYFl9iIrMF2IgwK9huPfLmYT0wKlpYfn5RbW3qOQzw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2078f1c4-e43f-49c4-2e71-08d85b308375
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 17:38:39.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCsgLYWjVDCuJePycZWDld6AWisjZOuZCV66GK5sI6tBRZmTey84m0Tg6OLKTuAH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4498
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600364326; bh=lK9KGzE2h/akOHZOPppoHCgoY5LlNSx3LUneGLKJgj8=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
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
        b=YtTRGrdZpcCuYhftJRZKHaT1e9yx92wsCq99pwMSrnh9h58m+TjjXbP9SSmBeWDC1
         88jBEIPjE7JS9Lwm+cHddPFwMjf07sPjGdRbTUmx4ocWuFznf4QtLT9by9g7Omcq3u
         q71prSrJ1zkI2PLP23FnOPbTf0Irs+yuIIVJUTwRu4E7m5xSe4+9E0q4Vm7eHTBBFU
         7WuScPow5zPTfZYrwXavdIOLgYuosBH8cJ8cJPyQDVqfHG1sifyo7wpaZpLRCJuzmk
         e8YySVaabD/eAMOS6so42VV6lH3e29LhzGSZueSl5cbxzj0vk2xANdfagcWNoIDqUo
         bacdBnd9YQ/0Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 02, 2020 at 11:16:21AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Continue with allocation patches.
> 
> Leon Romanovsky (2):
>   RDMA: Clean MW allocation and free flows
>   RDMA: Convert RWQ table logic to ib_core allocation scheme

Applied to for-next

Thanks,
Jason
