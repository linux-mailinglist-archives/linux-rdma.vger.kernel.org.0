Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF65C22CF03
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jul 2020 22:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgGXUFK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 16:05:10 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:36144 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgGXUFK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Jul 2020 16:05:10 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1b3ef30000>; Sat, 25 Jul 2020 04:05:07 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 24 Jul 2020 13:05:07 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 24 Jul 2020 13:05:07 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 Jul
 2020 20:05:07 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 24 Jul 2020 20:05:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlBuPhvKFBlISCytCjT2fYgdfEUxiWLW9CSIbzunf6Fc9hUoeELOlMDnKj486+FP8Si1I4G3QTIas8gymrxyu9tDynjalfxJ7vb9DHelUYRDwG8SYw2qkldNKKnmpzJIT1GyiHfINWCoyI479PrQrk0Ht3s6arx66YVJ5Q8xKWWM467tChJU5G2wc2a18V1/ddNFuhAjB7wKZFse3KexTiooWPn9yxI10rQHst7M8AXHY+nkrtELDL6kwy+MUf6CX2hp7p08HgdGrO3kqQX+U09IQIhbCF07fjswKcdAzRkYPesSrjZyDaGmZeuJoRVep8xLg4GR4FG0+QZoLqzjJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Y9GDbXUogGyoJfp0xcchvrjcp/jc7V3YPuzA556lps=;
 b=Ca3KOlXrUOmZkX2Ag6izDFWZtSpyfxz265hj9wKn4qm5q6MGLj7cBPihB35SZ8R/6vBdIlrE9srkR/Chai+eKjdqmHJN8Fv3kHeccSwTacWxj3U6zpJG6pBI/e+6K9J9ielRgXaQnUaF586cXX5ASJX55TmcHMqG5C+G6sqw3hpxWs+xrOBxbg1C2PMRPlRCE7vDupC5JDrtW2kUn8qsDyRGHoG8RHuTbEeB9iQgq6/vvA7rTUF0m2C6MHcZ4z6vmKlRwp5fBguUmW5MT5NUdAOPOPDenTp3eKsl0Ke9xOZFF+nWZ70pFixXLgbYMWp2U0HTP1xXgzBNN3ocfOKmQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: ucw.cz; dkim=none (message not signed)
 header.d=none;ucw.cz; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1658.namprd12.prod.outlook.com (2603:10b6:4:5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21; Fri, 24 Jul 2020 20:05:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 20:05:04 +0000
Date:   Fri, 24 Jul 2020 17:05:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Pavel Machek <pavel@ucw.cz>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trivial@kernel.org>
Subject: Re: [PATCH] RDMA/mlx5: fix typo in structure name
Message-ID: <20200724200502.GA3671003@nvidia.com>
References: <20200724084112.GC31930@amd>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200724084112.GC31930@amd>
X-ClientProxiedBy: MN2PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:c0::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0013.namprd05.prod.outlook.com (2603:10b6:208:c0::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9 via Frontend Transport; Fri, 24 Jul 2020 20:05:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1jz3wE-00FP0m-Mb; Fri, 24 Jul 2020 17:05:02 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 621ed405-3b6c-41f2-0a45-08d8300cda8b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1658:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1658378296F8D5E3C354F38EC2770@DM5PR12MB1658.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/B0y8olNcJBBzfl1teUwwF1GwYNE4fZZXpMwda/kO8ivKC3jIxD0ebd9+xci2dss8JBc9Ds14xPqKuLND/T29zS9IVOv/TySDnUUdYNsGYm/o5ovdoloKN1eQu6e5bVoFyfokf3cMH8Rf8EfaZ/TPbWgBZmaI29t9PsAs1dep6yjXFxM5QswhVYbMgpeBmXnWaJZUIZL1LsrdMuNk9mHkEw7gvEB1fh+UmIAqxQ7d0V5dYEIyURKePpLqRAtbW+Us2WAoWCw4HSk/JIZM8VZO4sAUx7dspoJhkbMJuYXv9yj34de/hFBV/SAuRj8zHs2vDxSWvTxUs3OJ9vASn8sA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(6916009)(478600001)(9786002)(66556008)(2616005)(66476007)(316002)(1076003)(86362001)(36756003)(9746002)(426003)(8676002)(4326008)(33656002)(26005)(66946007)(5660300002)(2906002)(8936002)(558084003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 2PXy5G48LhH4r8eRU+kTmjBKG24EUViycfuvynRo1aGr/7+bb1J3Iz437/bi4hLO8Avlx2BT5hNOm10I2v1+fioTeoacrHZ+7NQYOMw5uX/R/D+N9bIOfSMlxBEmiQ1qxgUL5KS0OXRHQFpQMCQNdyEHlzmXUpCfkBeX/RRcEWxVi/jap0Anrgzi0L/+KQVvBZz5MUdCzdH44HWltrBjmDf3ccCJlT9lkOA5W58hzqNw40YbuYtQV9nzaN9h1ScbDYbP0rKbxpfvAjYTjcnHu/T7vRe7b+JYD+F6LaHF5mUW1G4fbSVhunsIiLrH4kwy9v5LyEWY94Mp5gsCA9io694dbBwzJl28rJUWEC/6mCLdV/dTUGzoUtDng31dSqj1kOgG8yRvxMpec1rexscvBcWtAZEKTYlTA7DlwPFi4lLxRikUQu0OK8nIFkL8E2zt67X4aFDjeI6hRnDSY3pHBlVQpTqZcdTK7/msE0+YHi8=
X-MS-Exchange-CrossTenant-Network-Message-Id: 621ed405-3b6c-41f2-0a45-08d8300cda8b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 20:05:04.0109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9SB9lSoFjyBkpChZBsgXcvmILWWOCZmkcM74iYAIQS7qNVY4VUbSzeIz0z02Fpv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1658
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595621107; bh=0Y9GDbXUogGyoJfp0xcchvrjcp/jc7V3YPuzA556lps=;
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
        b=T0IFBHqanoyaFNmN6B3oTFPuAPg1RWtZwV0kleyedHsC6KCKaPTP7Bc+2FllDCEFG
         BYWBWtOuAaaQ9qpebP44uKN2qOugxP85cPdkQuupoh3r9bfJQSwLFgqdHR0nxwqh1n
         6p4a+suTfdAtBwsI1IQ9SGcVs+FZ0jT9yiD6eHq5OumEqQGq7yRZnrFWWULyzOJNRq
         lNb5aJA2wja/AUaeYUohQC2ibiH/b4fw1FEfQj7K5WaCcor87m8YZq3hZxK1qZAsas
         r0jUVxzlUBuY1cX7Vgw7k2BUJRPrGrsQCGAhoFC90wq8LtMMO0/53QC1wDeyK4ku1e
         XHTPd35w1JcNA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 24, 2020 at 10:41:12AM +0200, Pavel Machek wrote:
> This is user API, but likely noone uses it...? Fix it before it
> becomes problem.
> 
> Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

Applied to for-next, thanks

Jason
