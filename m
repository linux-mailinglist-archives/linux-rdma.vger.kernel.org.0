Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C677D25C437
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 17:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgICPGi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 11:06:38 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6598 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbgICPGa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 11:06:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5105ed0000>; Thu, 03 Sep 2020 08:04:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 03 Sep 2020 08:06:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 03 Sep 2020 08:06:22 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Sep
 2020 15:06:12 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.53) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 3 Sep 2020 15:06:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLlrDs78VGa5XI/6AGED2D207AiYn6+lPTL3ksI4gdkS9f8hzE9qf8cKyTqvpRgeVpxfS4OAr7h3ncRKtQQp3Jsj+olXqG+TGLFqcuv0Ajk2fkcAieOomSL5EUmW5MvHmNdWPsz9QFImDNbNPr23K0o0GOvQG46TjsmwetMtiITlU1upZAHVl2UtZl/UvOfuuCtrF96yGHnWjhcj62JT/aenFt0j7bIw7/JTz6Tn5Ni2RzuCvePS9gEQ+riGXaRVjDoNycvvX6Y8tCfJVn7nuXRX9hmA/zwo+IsOUhM3k5YEeKr/4sQwF3IpJkhuewSaQwIjGplsXOQaRWs5yvWVuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfGdJIZE9NKa073Y4/D08dm29GcpZoqHIdfQnXD/slA=;
 b=ehiLxC0dx8GkhZ28HkL1+gqkCZ0x2a8Vxpw7Wkoe0tIjRLbGtXU69CUM8brn/pKjzhOhV+bWNYxosaFdBwHEuPQAYdnROJpdFDgAi1B4rjnnM5z3Bf4OIG/MDhnooWD5bBjiyINo65RAU0lxxmLuThujaIwalYZUIojS3YsQTbgF5JnKM/AnluKdJxmyMXRhS8WAFYBSLHkYwr+HQek9pPozpK4Z50j8MP8tSMa9gpD4HhnKg88sHH0QGRHHoiz2kFM3wpwENTIC9wDsi/GwqKy0nLHP9fw7TmFNMcQGoJZJsb+oXh51Pi+GxY5bcWqvADCcyfst+pntvxw8dHJ0ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0106.namprd12.prod.outlook.com (2603:10b6:4:4f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Thu, 3 Sep
 2020 15:06:10 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 15:06:10 +0000
Date:   Thu, 3 Sep 2020 12:06:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Allen Pais <allen.lkml@gmail.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <selvin.xavier@broadcom.com>, <devesh.sharma@broadcom.com>,
        <somnath.kotur@broadcom.com>, <sriharsha.basavapatna@broadcom.com>,
        <nareshkumar.pbs@broadcom.com>, <mike.marciniszyn@intel.com>,
        <dennis.dalessandro@intel.com>, <faisal.latif@intel.com>,
        <shiraz.saleem@intel.com>
Subject: Re: [PATCH v2 0/5] RDMA: convert tasklets to use new
Message-ID: <20200903150609.GA1569719@nvidia.com>
References: <20200903060637.424458-1-allen.lkml@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200903060637.424458-1-allen.lkml@gmail.com>
X-ClientProxiedBy: MN2PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:208:23d::13) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR06CA0008.namprd06.prod.outlook.com (2603:10b6:208:23d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 15:06:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDqoT-006aMx-8O; Thu, 03 Sep 2020 12:06:09 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a50fb9e-7260-41ce-a584-08d8501ae43d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0106:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0106142DFB5F03A8ED345AADC22C0@DM5PR1201MB0106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:369;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BFqgnqhKt5DuOC/mVIkXgjJSYaN+Af8JKS7S+kJrx/3QQqSy/Zd59jylbdo/SJV0+FvcXWsP8mh4sOn5+jU585FmdSYxOupgKaFl5tsFLb6EgqNyI1AhI8lrJ7eb00vSzLyoqbmuesropmWLpfYbktdLuT+p3cFIK+4RXhM/fKwy39wwzvepSHvkCd6jWQSRXz6DWJcMlO0XKlZU2mwNX1x+eVWELX9muhDwtYCJCSwwQdKRmPLQbGmLjhkqRyW79JLXr7+QEhqQ55mHU7D7l2LJFdoX8Hp+IzXqdIt8R+A6d3O0OLY2xWLpOgU+rAp8TZw6+3vpv1PulbBbnT5EnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(2906002)(9746002)(426003)(4744005)(9786002)(478600001)(33656002)(8676002)(7416002)(36756003)(86362001)(8936002)(66946007)(2616005)(5660300002)(66476007)(186003)(316002)(6916009)(4326008)(66556008)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +cPWHGDgn9wbd8HCFUzAjZlfaEfPDRXRDOWfWLCO+i2mm5f7jsRuhegeNOB5dWr0KZbUArhjpV+h6HpFkBKvKS1CxBIC5Js4ed7IDGEqPMEvTwYk+q4E5SskYpUS8OapT8AV774SNilxv3DAzw2toZ5LTyjCQJPXjy3ZWB1ktM8IqUwrgcO0U3Limf2dVeqQ83YqHhjfWm7Ha2O3zXLfZaY1W0SDRwqZXRk0vFCTCYRqJv+bCWUxgHOddjOj5v0x3SAWeo99tAMGD0Jz4ETSs5z+euw53I5zkphwYBAowo17/EvF0TEGc6hF7ixyhGhavbMFZGypFwvigjPaT6x/GnKs/+EAbkEPYztLOtwKa2nqGJ7EAU/eKv+eKjPOX7+1y3YQ8RSz/GEDs7Oo6F40pWpDU1tPARxcEbVYayE3bJPfpXYLpf8/p3elgdpEmJek8qro5Zk/ZN++5YNjOYpUc5dgzTOh1q0RWblAeh5bQhrOvnPdLVqj9knA5DdCP2XKrIsynM+2tlZAx5qXylDari/NCPBH71nH9jsZxXnKfjM4+INKtg3WRiz/PjttRA1BS8sZHZ/AWTO2eSD+2Wg774VL8D8XCsEsy/X2oenjgcRaKRMURLTeIvxDw6NB7pAIKYYg3uaynPg1sIEdM7bmoQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a50fb9e-7260-41ce-a584-08d8501ae43d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 15:06:10.5540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVuBKCchb6mRgEWS7/6nPzG63oKPpF+nYdxkLuE5KWVtY4EDZwgcg9VXoEJHu8h2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0106
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599145453; bh=wfGdJIZE9NKa073Y4/D08dm29GcpZoqHIdfQnXD/slA=;
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
        b=Wrqg4lCmlNBG8R4g8NKfgYs2/JB3fXOklI2IXQ1jIUPyd2mDnGPUqLtRymz/1RrMO
         gF2TspMsDnKIPt2qPY8M10CinZYvvl/Y/9pB821nC384vX8cSOxsh6YAO++Ua9Fplk
         JFXxy0VUWSxLDTbvIIslOfjrBVfD7XddkmgH5DCkUCFIgeO/58SH0dhNbU3mqNuX7G
         PC1C2/cNmmV/fLREMV/kEBuCpVYXQsaly+Gs36Sdnruo95OK1xQYYqcCcRfh/BSd4d
         OzdDWPUR9MCfDAlxL2Cc8ECEDbO47UPF710ZPLTlLJM6KKjcm+4aeQQil3KQmcaTql
         MJAdOyTv8B0Aw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 03, 2020 at 11:36:32AM +0530, Allen Pais wrote:
> commit 12cc923f1ccc ("tasklet: Introduce new initialization API")'
> introduced a new tasklet initialization API. This series converts
> all the infiniband drivers to use the new tasklet_setup() API
> 
> The series is based on 5.9-rc3
> 
> v2:
>  Fixed bnxt_re driver. Suggested by Jason.
>  Fixed subject line.
> 
> Allen Pais (5):
>   RDMA/bnxt_re: convert tasklets to use new tasklet_setup() API
>   IB/hfi1: convert tasklets to use new tasklet_setup() API
>   RDMA/i40iw: convert tasklets to use new tasklet_setup() API
>   RDMA/qib: convert tasklets to use new tasklet_setup() API
>   RDMA/rxe: convert tasklets to use new tasklet_setup() API

Applied to for-next, thanks

Jason
