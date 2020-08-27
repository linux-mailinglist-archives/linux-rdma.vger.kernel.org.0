Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7052547CF
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 16:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgH0OzD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 10:55:03 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:59223 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbgH0OzA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Aug 2020 10:55:00 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f47c93f0000>; Thu, 27 Aug 2020 22:54:55 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 27 Aug 2020 07:54:55 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 27 Aug 2020 07:54:55 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug
 2020 14:54:54 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.51) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 27 Aug 2020 14:54:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dh5u2eTut4VTmijM5ta9c7MONC5IoPbSjk9POlaWDHFe9qbiv+YfBTqhfDZ2l6y4ymYH0PACBnwyFhE7Ck6HmBFkJ2mzDLdkRmbzfw9eL14cAvkIgMucbma5GRrdAvzYcOgqnMOJjFdvy5w0eYG8yMs24GWjJx4Twqw+mCyj2vsWeApUJpHM/sNQbP549RqZMBpZAwy0j3foR7iaf3z0M0pDwMV5yaXTvddajJUkRxDaAqlPQtdE1fkPFXSspG+v09AVMe9AQzLXCF/RoJt1lOlRr+tN+EsS4hq1WzR8B3M0EFlJZEW9c0nGAOk8HLi0iDxYzevlhX3+h659/oNgrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRymTOG5d1/2C2HzYNCfm42dEb5GdnNhSaOI2/jjPJg=;
 b=W7cq+YJdxJJF4rtY253HUz2IlqMJbqT/7S+bRlRhSC0zwH5qEiA583YFbIjYlb34uKiJSZE+gQ4qkFCPFscr0BrYxkXUc7A86S+WxPGVGR/X0TjoflQeG32HtHhswe2+MmFFXh7k5UEDYj5hP0mOFJHXYjlMeOeLJtpDQVi0eLiRmL/JK5ESxQvVPVHffWX2CmCdSghpnWd2UcwRVtLBWBZRAIORiShz4eZ+SaMTy94qVR0Qz+tseWBBzMCDUrYIjTAVxaIUeVgp1rFSoqvqKa86tN9Rr6oXTlmH4uG9nEDYo6W1OxqzmFeecCsrB+Rq8YGKRQUrWevBvjmDfK+8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4009.namprd12.prod.outlook.com (2603:10b6:5:1cd::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 14:54:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 14:54:52 +0000
Date:   Thu, 27 Aug 2020 11:54:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH v4 for-rc] RDMA/rxe: Fix panic when calling
 kmem_cache_create()
Message-ID: <20200827145450.GK1152540@nvidia.com>
References: <20200825151725.254046-1-kamalheib1@gmail.com>
 <20200827121822.GA4014126@nvidia.com>
 <20200827142955.GA406793@kheib-workstation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200827142955.GA406793@kheib-workstation>
X-ClientProxiedBy: BL0PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:207:3c::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR02CA0009.namprd02.prod.outlook.com (2603:10b6:207:3c::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 14:54:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kBJIg-00H4YG-9v; Thu, 27 Aug 2020 11:54:50 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f651678-3fd0-4485-75c6-08d84a992718
X-MS-TrafficTypeDiagnostic: DM6PR12MB4009:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4009155AEB9F7C03B0E5FEE2C2550@DM6PR12MB4009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Xgj9sNOwfu9Pwu6L6cbBIEAJnTEVPTa3N6kSFexsImZawOly+43G+0++ROrYakjgNFqdehxSIZkB9ybPIrVX9m2lj4RM6HCePKryoIY0zO4xsxvzsMTyfodm7h/SRbFD/lHmTLW+T/ShiYD5lEHVSml33UCM4scaEwfpt9j13gkx9QCswvTQ0hdMPPWSKtKADfZzF0Pjk7hrJyEpdd0bkPKL0eSj9Lnd7ch3pk6GQzDy8QD8ySiiLbgdh3AY0TzPaS7uvmDt2cfmErJhzicVDV/XzqNdQyy7CnTQ9tVZ9sP/qgslIJaMSwLp7IHz4hQOkNKB6gzgFb0JmuuqW+Jnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(6916009)(426003)(186003)(8936002)(26005)(36756003)(316002)(33656002)(5660300002)(66476007)(66556008)(66946007)(478600001)(9786002)(9746002)(54906003)(2616005)(2906002)(4326008)(107886003)(86362001)(83380400001)(1076003)(8676002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: LaZmPqfs1wRb66TklBqnpC3JGyiLE8ygRy/LpDHqWAwbKc9fHyYWUSJJqztWJj9y4890kDHPJTye6ovps+gmHSsYwh5edfGSRhf0E6VgLO+ZGpNMhUytjdPHgeemt2L5de1XcA7kEIjfp6mV05hTrUSkX2gVQorlqW7OvanoecAu83hRy/732pIQVPAzJjVUfEFWmxxj6K5TxREbZhb4ZsgdHNmVbq3Q74hDheYtvOeD0HkrcvvEqhYCGMwnKaXRpDJdVChN0vJCeXnnRa1n+avtycIGtd2LHtdC091U2+xV+VvDTAja0PtIwsyU+5Nhtzz2F8MSviixB8F6oLjonpuix+M7tLC1oheu8pzgv/H9JbioMrdc+92ajyjLr9dYRXMvmzRoPrZlvyqNJ1d9WF7loigGzwPQWJU1GGihRIhdnlW7iJgUHDXZFGD70IvMiuP8Z9e2uLmJK3LrqLo9Ihfy6M54jbKdV3SJ6moOtlSG8sHKLcRafJhOEUh/0mwO95lteZpUUEfcrO5pqSfDOKxyfzOc+7NHPx6Ax+R2b1fmYdLeYPdE1S9l6OuppI/uxFLCYRlm5+foVMh5LZ0il7G6PPY2l0Jx7urCKcGkyE9N5zz1NItezh6EI9U+mPb+xxHEM6Xs2WO4HYfKYWdXyw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f651678-3fd0-4485-75c6-08d84a992718
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 14:54:52.1510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrgziGHEZruFuZ0Do3E4uOWBczCmjA3GXNc8vOEJSXVm6z69xNoBtVFkqSagCp6J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4009
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598540095; bh=GRymTOG5d1/2C2HzYNCfm42dEb5GdnNhSaOI2/jjPJg=;
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
        b=UclbhnZZ5Lw5P8EDVoJoY0K7WR92J1CdS2M5DCr/200M9ZLwbNkA9O4etE7ZzNCdp
         sQH57JY2Izuy9YS2rfQ/rFfieuTl32LyFZoMbtiwT+ulphEJMKpo24Z8jql63swGP1
         TrSPAWgkroLXPcpfsDJXe9KLCXbhpUdamKX45jCWc5DR6b+A5rAxSFR0MYqdjdu2iH
         ahXIe1kbhSUgdJeecGrIRc6XliwFd8LXa2NFz6Xb/d+H648nciynoBbnjhsIvWv1VZ
         4ELOy8MS7OygRy8HidxZFmNpDG+PetOWAhE9Vtmh0OQJlPX9U71HCQHaGq8I5mumTI
         L7A+uYu0I82lA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 27, 2020 at 05:29:55PM +0300, Kamal Heib wrote:
> > Can you send a PR to rdma-core to delete rxe_cfg as well? In
> > preperation to remove the module parameters
> >
> 
> Someone already did that :-)
> 
> commit 0d2ff0e1502ebc63346bc9ffd37deb3c4fd0dbc9
> Author: Jason Gunthorpe <jgg@ziepe.ca>
> Date:   Tue Jan 28 15:53:07 2020 -0400
> 
>     rxe: Remove rxe_cfg
> 
>     This is obsoleted by iproute2's 'rdma link add' command.
> 
>     Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Oh! Lets drop the kernel side of this in Jan 2021 then?

Jason
