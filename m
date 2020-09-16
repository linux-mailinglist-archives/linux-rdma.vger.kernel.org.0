Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C931C26CC94
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 22:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgIPUqV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 16:46:21 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8351 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgIPRB6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Sep 2020 13:01:58 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6240d00001>; Wed, 16 Sep 2020 09:44:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 16 Sep 2020 09:44:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 16 Sep 2020 09:44:43 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 16 Sep
 2020 16:44:41 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 16 Sep 2020 16:44:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEYzz5hY3DcxScpQuwARqkjqFIdXmEFEecus4Wf3wpjsbr2r9UrSj8dv9N4YsZvn+CPbhHHuYdWQwqEvRPKKnckfjJZ9Qelke7lwPHWXO8goPEAf3amKkWwF7ok5LUrhzeYVHCmhCXHUjHNLaPI8j7p1Ba7CvVsrXfvDxQt4riemxLQWDMUJ8dWSqWQ3vP7nUGLFw/o0mVej01cobk3GY4nB7Kc1NRTjLCp4Elg5i3eltW+KKjCvF/bTX50E4vL2na3N60+A+9B7XRcSX+N7PhP23IQeOXZdRrMLcgUyQFfhag8DdAOFQ187jO1gGCEc0tMf1TYhkVgQPzVL6/r4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaryOzjcvaucPF70faeILdSQ+37Gkhi4ichDS1QXKug=;
 b=lKxbPqMNbu6xX6pwZ4iXchT57s476mCzB0UGpT4e9PBp4RfpXlXRU7MYUEYaQcIdrTDCp2Dmdgqtw1ULZV2cz23koTG3rxnMVqCnkHJyLLB9A0/1GKER32Facx3LVOIdBfPvmRWPF+npiJqZ7ZYHumgVWfhix/bgmblmRixEySTjHaisl3MCzukuv+KLl6qTmxi1FJKWQcxMJ3yibJy2GvipbU7gTOKomm6PSW9WAkOMGuAtJBCZTZd3g+DhO5mBLUSM3n6aPBz/DdRkJfHvuG1lB4ajh7vjURnL18XhDWIizcESQSwLa/3CuEKqbAR4MLk4QbuEt3PpNWTmBxLGHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3513.namprd12.prod.outlook.com (2603:10b6:5:18a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 16 Sep
 2020 16:44:41 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Wed, 16 Sep 2020
 16:44:40 +0000
Date:   Wed, 16 Sep 2020 13:44:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Parav Pandit <parav@mellanox.com>
CC:     <faisal.latif@intel.com>, <shiraz.saleem@intel.com>,
        <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH rdma-next] IB/i40iw: Avoid typecast from void to pci_dev
Message-ID: <20200916164438.GA19370@nvidia.com>
References: <20200914123528.270382-1-parav@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200914123528.270382-1-parav@mellanox.com>
X-ClientProxiedBy: MN2PR15CA0006.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0006.namprd15.prod.outlook.com (2603:10b6:208:1b4::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Wed, 16 Sep 2020 16:44:39 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kIaXu-00055J-Nt; Wed, 16 Sep 2020 13:44:38 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32576a0c-adb5-4fcf-c948-08d85a5fce22
X-MS-TrafficTypeDiagnostic: DM6PR12MB3513:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3513349C57003E21C76217FFC2210@DM6PR12MB3513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qYGpUgYlewv9GxdciCFGSJfJuRo43C1MvA54OTR7Ycg9o6M4jZti5IsHmvQ4hiw1Cff2xF84yKmohriFLhr3OXWTvLWW1k4pN09S/Cn1Uj4+cVsZ6FE3/xgfj8wWv94ZJSkKJXkcykIX56iIbkL+w3WDMjvuQ+xZjBkqfkt8aiyh/yXmEC+tqMNlL4KGltiRaGIyyaNrTUeVhlyJON77VTddF3FBu/vH5v86xW9WduIfH37pnaT8EVwEgYG5PpAuWMXIUsoW41zHROJZ/pIIGuzebarlPEVvmChz+ON4LasY56TlSkMdtTahtVziLgytMZcdqwJUhgocmzOlJsUvxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(186003)(66476007)(66556008)(36756003)(5660300002)(86362001)(66946007)(1076003)(8676002)(33656002)(2906002)(4744005)(26005)(4326008)(478600001)(83380400001)(2616005)(107886003)(316002)(6862004)(8936002)(9786002)(9746002)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5pyHfaowRZUunJRwGQpWsmE1/KfMCcicHrPouCi54DElfsz4OYyHuyws1nu3pvT2852kS4bcGYD5qvbWXH9d4UspvLDstCFaXKIi9ookZ/iIAUWmGIDNGkMgRakatBztG5hcWpDIyPbPIOfIDGrbBjj1a+U1L1rlyZweWNSP+OWa5iRdV6KoqGLoNzRLz3sr2R3EUXJ/DxJRXp/SFscbjCpPgbBg+mJ1P0byLMSbzoBFt5AHyR5zTHYpKkHpt83AFJpu7x0Y/B8v93gKQtwPKvlWTNzEGM0KGc8i6tn0erf/ReMcXLEnRUh9m3yzDS6DluOQ7rBuabM7EaIqjnSTU6KXmtdoBaWazzTUdugSXc6vrI0gY2fVgUzWK/l5To/bRFBMsj3n+vhWjCTkVq18UqqYqRLOrKWEv9IHxhU/+XjbweAtg7i0uhwWR1zTukWwhiR3PMHohnp+VPsEuT7yn3rxJl8iJQq+b//pMFWlqE+vmJolYAmD5kmUKJsSFX4YhFxLkwuW6gChhTtTwyBps+BeiHH+RTjlm9POBQOHfI8iOULYpN5cYrVctuG8MRmd+oq4e/P12JLOkJsKqa/U24R88o4nh3w4ChVIyovTyOZ0MjnaUdsVKRUD3JK+7D1ghHaqvjR2uGqZxCJpUtdyfg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 32576a0c-adb5-4fcf-c948-08d85a5fce22
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 16:44:40.7689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kc3VHWmqff+1VM6mZ6DwxuWz5q4WOtZnWgpiJD0RqvD9AQdK0Due+whTz7RPy9Xo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3513
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600274640; bh=IaryOzjcvaucPF70faeILdSQ+37Gkhi4ichDS1QXKug=;
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
        b=jhEmIi+Mrni0/dEz/9Q/jhYyG5qPCkjeg3HdolMznzkBXNmAM0eJHTJ5iJ21o3Sz5
         Ijthw61sDOn+2YqRfsahxl/GQFWRjlLMxndxgzRxXAWXrHeI/IulxvHPxQqi86EOhr
         t1wrsxhlehYGWTnvhjqONWmboSLaSpHHjCPDWZIPIdmTRf2RpWYt2awpTbe1Od8ZHB
         lqCS9NtZLJPt5MZbcuDXTsc6hWiS/8R8FTh4nTH82WjB9J/3/yXJ2PjD/Tln1eUFm3
         6QFhEg/57rLvoyAtiIEvg71d2eNUYXiV9xXfZrBW3ToRcGtwBhi8uXik5uKSVIBA6G
         oXfbnJXGp2SZg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 14, 2020 at 03:35:28PM +0300, Parav Pandit wrote:
> From: Parav Pandit <parav@nvidia.com>
> 
> hw_context stores pci device pointer. Use the pci_dev pointer instead of
> void * and avoid typecasts.
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw_main.c  | 2 +-
>  drivers/infiniband/hw/i40iw/i40iw_pble.c  | 4 ++--
>  drivers/infiniband/hw/i40iw/i40iw_type.h  | 3 ++-
>  drivers/infiniband/hw/i40iw/i40iw_utils.c | 4 ++--
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c | 2 +-
>  5 files changed, 8 insertions(+), 7 deletions(-)

Applied to for-next, thanks

Jason
