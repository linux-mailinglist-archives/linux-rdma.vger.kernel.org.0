Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7BF22CEF9
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jul 2020 22:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgGXUBs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 16:01:48 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10898 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgGXUBs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jul 2020 16:01:48 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1b3dec0000>; Fri, 24 Jul 2020 13:00:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 24 Jul 2020 13:01:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 24 Jul 2020 13:01:47 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 Jul
 2020 20:01:46 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.50) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 24 Jul 2020 20:01:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/zmr752TclYr2K6o2qgrz9C+huFhxpY2LtOdTkR54GDRbPEtottSUQ84SoZI0oWHYxvbzq93yOs44F+BCTxl42mGkxTSp3GodOXdi6fswIljyOW320oQ0XKbXTohM7ffhBHbvOWTHG19N1KS8FgrXynqKJAwY3E9DN82H9VJlgyZXcnpJY/dWdfFmoNOEMsbn52nJl2B2SGa0HuBbRIvt1VrG81X4BdouIlYR4nEAH1Dm+JSxZ59HCtKknKhwDTkxZntjelyNbr9ouTVvEydoeJcHtOeeEVtya58zFPY9HwiV+P6FgltULS7ZaT1rbpL9dv+bCUzM3EVuQNwNyStw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8iTjwSiBGRjKt/Q0mqiAkXf2Z0ZzImx4g149faujXk=;
 b=EYPxrlGfpYkGlG982luCyIA4uapHbcjhiivlOKjFFh+5vYNH345L4Y2NQjfmBQjdDpTjZFnP69ZHJMllUhyR2M2QyiSHDwl3dPwOfZ6iUXIlQC3US0XN4KdageYU6HGlpLcA5aheB3w6NDseH6kozIHN5qrpF5pdcbTAcp7WRIlu5cKr/jV9k46W1Aqwysb0wxy1WMTIMEY1uwdtkeZ615J1B8IKKUW2Ho9r5hLD2kcE1h3v0cNzd3S4ObqpC2SjE2PiUAGg8F9LbDn6u37h+sU+6dwDGZkyYMTUn1ZucBeFk5ny4dIGNKe8YcN1bNAKiw0Oc59TnIi40oDRlttc5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1658.namprd12.prod.outlook.com (2603:10b6:4:5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21; Fri, 24 Jul 2020 20:01:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 20:01:45 +0000
Date:   Fri, 24 Jul 2020 17:01:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2][next] IB/hfi1: Use fallthrough pseudo-keyword
Message-ID: <20200724200143.GA3670533@nvidia.com>
References: <20200721133455.GA14363@embeddedor>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200721133455.GA14363@embeddedor>
X-ClientProxiedBy: MN2PR20CA0038.namprd20.prod.outlook.com
 (2603:10b6:208:235::7) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0038.namprd20.prod.outlook.com (2603:10b6:208:235::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend Transport; Fri, 24 Jul 2020 20:01:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1jz3t1-00FOsj-IO; Fri, 24 Jul 2020 17:01:43 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da3f053e-0154-4b0e-f464-08d8300c63e9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1658:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1658EBE65407768A251DAA06C2770@DM5PR12MB1658.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: By9EqZp/xsTmX++O9jLkAcuE0V+2pzUXl6bDQyxzRZVmhN6Q2gcIocthPyhG7uSvwY0wDifXJDuNvPDFDCpUi5sTA0Yt/eq5d1XlgPvf7hXk/bpQj1hosGBnkH6mu96IAVvC2D92zfu9UisAqpeap6TPGtom0vgr2nDZZk+mBzMYmSps34fOfmPF2sXjimMuFGmCz+LktLdmPw645zPJTVj/FcbCmA/DR3E0vpXHR94GqtlG2AF6NV2SPxD/bvbWU4RByMGKdtzb+CcYOMnFp9cxTP7B6JgL5UK+nc61ho/6Y064ZlDJnIc4km6vNxPXAVGdlbQAQOi7Y/b8ddN3QndDRkhDFAzCqtvW+rtiHS3znBOJPJ1e/FMrzYAf1wNBu8ShAtvUmN4tot4ch7JW5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(33656002)(26005)(5660300002)(2906002)(66946007)(8676002)(966005)(4326008)(54906003)(8936002)(186003)(9786002)(478600001)(66556008)(83380400001)(6916009)(426003)(86362001)(36756003)(9746002)(2616005)(66476007)(316002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pzIrqneAeH5ivC1URiDFa4ybpn9DMwL/gUeNiyfsXPRvqhjx1KkN27GuGsHLwTeXaSQsBKuLwu2HuXHoqduYTxtDjhkgZ5f65kmzQp7EDDA80rB0EWhQ9y3gvWXmQGOpHgm3i8+DGklffhxge2f0zCn37I1pdxjR99II6VFAhQRZ1QhLmcdKjkb+bH7qt3PERgGf3IymR80LwEKXRGI1gpHgkXs0vdkIBd4mwp2srBZZFk+FM1Hq/JObtD8Y8Z00c6Pxxo8o6qTC9+0t0LloWKqvSBjmG7hHSqqmm0sKOPhSDBcsvfbrTX0SKFJFzwHbeY5WBCI2sl/4yla+0bAB/XYWEnST7fQa/U4W7mBvTOgaHIJcxtPsuKwzwTYUudpt9vk0Yonr2rxnLEdHvGJqnPQ89BZ95IIw6M0BwLYyaMUcRFxu7oI1jLB/GKF3rIQG4CVry2rn5Sxhq4+FhwgR51TAXu7NQbXTR3UOY9dcVJU=
X-MS-Exchange-CrossTenant-Network-Message-Id: da3f053e-0154-4b0e-f464-08d8300c63e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 20:01:44.8941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vV85ExriqiUDWJcL+Yumz/ZBP7aUXg/yJZeEObI0VotUBkMFsnPAI69jwtIVj2L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1658
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595620844; bh=b8iTjwSiBGRjKt/Q0mqiAkXf2Z0ZzImx4g149faujXk=;
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
        b=qqxZNo2yCdRVVWPAWetnLgXlDJSOr7c3lXyiAq4GhwVS9eO/MxMZUCZaExmNQLRf1
         FBamTX6W4azBSrrHBT3JZe2F/s7mkk70OymVImHEv+KAZphoI1bNajW0MW4nOUoYAT
         ZO56r9gqDmu4XTa6pbl+ofJsJBBfytPFzkZk/hOl6UOCKP+tCyX5ue075zeSx0idXW
         oIoR2vf2PyG3nTrUJ0OJClYbafg3lQjfpe6Z9eY/a9SKN0dIEkUKWQYJnnyPSLQ/9N
         b1RnEjnMCYYKjEBNmofz5FFEMcGvhumzfDtOvFxl6Hg9+P8a9SBVhmdILmckILbUVj
         2f3IEUqe2iQtg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 21, 2020 at 08:34:55AM -0500, Gustavo A. R. Silva wrote:
> Replace the existing /* fall through */ comments and its variants with
> the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> fall-through markings when it is the case.
> 
> [1] https://www.kernel.org/doc/html/v5.7-rc7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Address fall-through markings in drivers/infiniband/hw/hfi1/chip.c
>    in a separate patch[2].
> 
>    [2] https://lore.kernel.org/lkml/20200709235250.GA26678@embeddedor/
> 
>  drivers/infiniband/hw/hfi1/firmware.c | 16 ----------------
>  drivers/infiniband/hw/hfi1/mad.c      |  9 ++++-----
>  drivers/infiniband/hw/hfi1/pio.c      |  2 +-
>  drivers/infiniband/hw/hfi1/pio_copy.c | 12 ++++++------
>  drivers/infiniband/hw/hfi1/platform.c | 10 +++++-----
>  drivers/infiniband/hw/hfi1/qp.c       |  2 +-
>  drivers/infiniband/hw/hfi1/qsfp.c     |  4 ++--
>  drivers/infiniband/hw/hfi1/rc.c       | 25 ++++++++++++-------------
>  drivers/infiniband/hw/hfi1/sdma.c     |  9 ++++-----
>  drivers/infiniband/hw/hfi1/tid_rdma.c |  4 ++--
>  drivers/infiniband/hw/hfi1/uc.c       |  8 ++++----
>  11 files changed, 41 insertions(+), 60 deletions(-)

Applied to for-next, thanks

Jason
