Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98610261CC2
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Sep 2020 21:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbgIHT0X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Sep 2020 15:26:23 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1580 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731073AbgIHQAj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Sep 2020 12:00:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f578bbb0002>; Tue, 08 Sep 2020 06:48:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 08 Sep 2020 06:48:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 08 Sep 2020 06:48:57 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Sep
 2020 13:48:55 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 8 Sep 2020 13:48:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRuIGXHmShFlYKK81GyaxMxGe3OMRSc6hfLMMqFhrc5czR5F+RSGYnUE3AHVaMy/B4LeznLJTPmg1utFXsaRJ92a7CXUBROzDrcxehh7LfeR5+PT8sUUctzAql2rxwAgVylLNTVhLqatZg/5urxJ+zQIQXJX6XxRvnT91brtujcqbpvO/sKRCT8pYcerWdWrk7g26Miv1Q51/vORZoEMrX4pa4OHUJLpGOZemvCc+P4g+zAwsjCg2BTBuSyYv/0pXOHw7gCNlv5LWW65Bf+ZVMRB5uz8FalFdqdlh+VldALFNT3QFAU0fd7MxATjajOv53aAlAsaXCEAEb+zTdg0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uC2xlxjBA47mqL2L4YCZjPVJukmAEPpciumla4U7H1k=;
 b=hu35VxGfVHYGaC2pVXyxtn/LRUlsBKE+uqVy7i9O1sOgBQ3y7bSFT9W9rJiRRs7HrS6Y7F61dMNyXRspJWEcC4vvsoJ8m+y/YyVSHVF5vsviGXUVc+9vCn9yDvwHLbCR2BIlzkgpI0E4zKDN9r4y8e0MmtT7pNOMKmwyEi5J1B0B/4BpApyxTxhccmyOZjn0d8LZFUxFlB1JDnmngPRFmlpiHZGsCl3BsyPCFV98jBo5Wz+EBKbR4dv/qEPfaBa+9j+hjyoKi8AND8lywnwhsbPeaU498QDzIXSpl+v6WR7nZ7uqnwsxV8wS/SBQMCNmKwYNaHrZelbbXB30cVTw8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BY5PR12MB3940.namprd12.prod.outlook.com (2603:10b6:a03:1a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 8 Sep
 2020 13:48:54 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 13:48:54 +0000
Date:   Tue, 8 Sep 2020 10:48:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        "Firas JahJah" <firasj@amazon.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        "Yossi Leybovich" <sleybo@amazon.com>
Subject: Re: [PATCH v2 07/17] RDMA/efa: Use ib_umem_num_dma_pages()
Message-ID: <20200908134852.GE9166@nvidia.com>
References: <7-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
 <d9cb7f02-86d0-25d6-1314-cc048fd1ebae@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d9cb7f02-86d0-25d6-1314-cc048fd1ebae@amazon.com>
X-ClientProxiedBy: MN2PR18CA0019.namprd18.prod.outlook.com
 (2603:10b6:208:23c::24) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR18CA0019.namprd18.prod.outlook.com (2603:10b6:208:23c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Tue, 8 Sep 2020 13:48:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kFdzQ-002zzR-EZ; Tue, 08 Sep 2020 10:48:52 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 937409b7-3797-4726-d76d-08d853fdecda
X-MS-TrafficTypeDiagnostic: BY5PR12MB3940:
X-Microsoft-Antispam-PRVS: <BY5PR12MB394032836D73446F8177E42DC2290@BY5PR12MB3940.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /nOq67s8oQ4q6qccn5TcJ/vKIJDxfOUF5azZKFyHtuTECPwLQ1HHtNIT7A/STexvCGiqeWUtNqKw4P5Ji7mt4UpqSh8CTsgdSinJHp1x9M5HbNHpvRm9QSP/fKEO1FERLwnMY2HEw/E6WeeFfPdLuLsil5N+inqClsrCaRUD4uL7A42aG7Hk1Rg4Stg/xMXLUdFJmHkOPmHU1LbZuZwzccs0l0z/HjkSrs8Sh9OIgNf8lSwmcgJufmL3+zSMBhB6Vu0HI8czD2E14KGcQVVnz4EuM1x5dHwBb7HmHzf8sjGxF7p/albvP9WCZ+5Npz3WAIQHLnrI670ie7H3NI/fcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(66476007)(66946007)(66556008)(9746002)(4326008)(8936002)(6916009)(33656002)(9786002)(5660300002)(478600001)(26005)(186003)(2616005)(2906002)(426003)(4744005)(86362001)(1076003)(8676002)(316002)(53546011)(54906003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: o1VRaTrgNRWhWmKQaOsztF/yxIVwoijmlCCN89TjHWF3jG8k8RqcMtZFSDasfP4R6NHCEvv8KcuHkFaGL/C765NSiom/Rs//3exvS3wDFKCdk8nUnOH5kcJvcJyzvRoJzAooJTt1ulGgM7Myk6AOBYXEF2Xdj9SAVTXf4WkvuLEMjs7MB1Ko/0H3+K5g7VJfYILhNwsO4zYwj9diIyKLKUKw3a+nHF9ATzMIaJkaF6hwrHJAjmRlCto5jg9W29aYxqjnscsUeq8It5dPMjflkdao9nnfkrhDzu6bOzmDWP2h8sZtmOCHk4C58iv5f9qTqLMTMyaX/XLtVKYr51mbOBbhmjYClFhyaPrKN7OT5n9qAE/JNRWZKt4sMr5iXf+LmLQXh8+AUclEmajckaXOrBotQPaQjFMfS+yVVcr9LIHzeKPRoAbrgMsTkw0rSby77rdzHhh4OD3qFDYN2+5VE7asJ6ZDcVw56ZTfYNTWnepdWUH9/H4GDuAgGBxDoBO0SjJZ0V0WSneJIBiTYIEI3HSEXUaq83t9svwY4KhYN5skv8iWQNSq7AvB2//DiCD6+tMjmJGvK2I3YH/FZWfiX1Wec8PcYr7Gf0sKTitZq31aBNhtuJX5C6w8vPeZB6/gqgZud8RndEZWzJIGB7sNAA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 937409b7-3797-4726-d76d-08d853fdecda
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 13:48:54.0990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HkOIUX01wuDXrPUnHCI+tG1Y4z9KCmG+NDU/v3OQHJGyqIXCV1pSnyBrP0wzu348
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3940
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599572923; bh=uC2xlxjBA47mqL2L4YCZjPVJukmAEPpciumla4U7H1k=;
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
        b=cwquQnVUNw+/iZGRpdgmKCfyr/43CGBvIck/C2m/JCNz6emv7KHYvzwmyzieHSaEN
         wADosJX9gVmvcm31bIw9aQRD4EAoK96tM8NV6lInTVC/RNWtZ4MdmKRPZxVQNo76Pe
         iiQ58/ZCnz9V1hDae8ciM9PzrMg1aBaHFiVxZb9eJPe0Wre1mPOsA+Ix/zAWsoauI5
         AGYJyhD+DYTcbXm4mrDlZyDxYQUZDpuQbuAUlxJt4CP8DnE41W3+l8bbtiVEh8Qrjm
         xpgN7ChYFE/8auT+m1GsAOIJtUJqpN5C0VHPHip2GSokyrn+W4xmTcYm1Wh7UlDOfP
         N4f/fOCAWtYtw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 07, 2020 at 03:19:54PM +0300, Gal Pressman wrote:
> On 05/09/2020 1:41, Jason Gunthorpe wrote:
> > If ib_umem_find_best_pgsz() returns > PAGE_SIZE then the equation here is
> > not correct. 'start' should be 'virt'. Change it to use the core code for
> > page_num and the canonical calculation of page_shift.
> 
> Should I submit a fix for stable changing start to virt?

I suspect EFA users never use ibv_reg_mr_iova() so won't have an
actual bug?

Thanks,
Jason
