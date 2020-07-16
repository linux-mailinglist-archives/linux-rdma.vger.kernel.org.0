Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C0522230F
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 14:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgGPM4c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jul 2020 08:56:32 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:41066 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728793AbgGPM42 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Jul 2020 08:56:28 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f104e7a0000>; Thu, 16 Jul 2020 20:56:26 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 16 Jul 2020 05:56:26 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 16 Jul 2020 05:56:26 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Jul
 2020 12:56:22 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 16 Jul 2020 12:56:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nspICqUh/CGWbYgVZEmSM836QiZiRUijAG28gGXJsnOHD8fH8MyDdhRdYKAVYq+QaijRPXjyGcNgSdA3qBdciQ2EEMlHhGSTbYAV5AQ9FTm5f+dFLt1wtr6eCKxPnGLizrza+4PFJmhFrf5rBLtZaVpg8piq8mEdMaSHy90zuhDkC3wLxj/LiFKC3PkleLFQFo+gZtPhb4RKOSErIKHbAD6jS3AdTzCOZAzC/FDWODx7bi+77UaNoqUmkkXSwaEhnUExCCsLi0w8A0jOmWD2sSTXEZN3edFKNzSoqlsFE/QVIq9JfMsSqDUQgL5qqtVR6m5NPCD+PT5gutA0QuhJJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaJCl/87lwPtCVyxFWmUcLGvEplXuxsVGiGHwQLvHRQ=;
 b=kCL1Dtj2JF80v+jd1k8UkxnTciAJ2p8ctfp8yUTC1ucfxTySSbh0e24w0iQbqrBj0XABxUfnN3P9jqdAeykF3kAn4HrtrZZHWH4Ff49ouqegKMHbUWPVYx5to70zucuu2gA93vT3eci3NcFsT9xmme/us80dVC4/DmhH2/oZFkINSJZ5DoVl6DNMFkNvdRT9kZd2DDjF17aoeHtiM+IjYoX2ljc66KvdKa1uxgKd+9SEZtkC9NbEyl7qPZ2EYe23NrVP+lln52EQH0RWzv6FFGQH8ZVaLzQ+oARenh0v7muzLEvYzIx6vCuWdSqwsjjuIqsI2WH6LGtWwpLZjcpEoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Thu, 16 Jul
 2020 12:56:20 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 12:56:20 +0000
Date:   Thu, 16 Jul 2020 09:56:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liweihang <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH for-rc] RDMA/hns: Fix wrong assignment of lp_pktn_ini in
 QPC
Message-ID: <20200716125616.GA2615760@nvidia.com>
References: <1594726138-49294-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1594726138-49294-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: YT1PR01CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0092.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Thu, 16 Jul 2020 12:56:19 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jw3Qu-00AyUZ-A8; Thu, 16 Jul 2020 09:56:16 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3baf697-dfd6-417f-952b-08d82987a26f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4235:
X-Microsoft-Antispam-PRVS: <DM6PR12MB423530244B5A79B64F74125EC27F0@DM6PR12MB4235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +++muGJxvkWSw3uDw5HetumznlQiTUjmIewexPgVHR8W2za+OTntGttSY5582KYDK3d98p/SWSPiNykwYYgmTKPsbtEPn2D2rDhrFehHInvQwIrPqou6s8cWzWxSFjp6xZSS+axk9Br4uH+j12rANUxOTUCowfjfCw4PXjFHSnYtqKSfmKCMxZKfGl72rVNgFjTRJb6aapPUzyTv+/CaG+bq2dgmHK/+7TrP2gH8b4WEDIVuGERlCH6kvbabRBIVYdXHwcYsVcT/8mFlTebLnhzmcgrXiNkiLUgCt8N5O/ILOORB+ouaVgw3w3eaMDZXnoKHviSGHyXyfXuVwc8MJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(478600001)(66476007)(66556008)(66946007)(4744005)(1076003)(26005)(186003)(83380400001)(86362001)(4326008)(33656002)(5660300002)(2616005)(426003)(2906002)(8676002)(316002)(6916009)(8936002)(9786002)(36756003)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mgxj1EWrHG0XFiTQgTeCRxY7joQ6YFukyUisnXer7z2FrEHOnKMX3DW32Z5J8Mx9iHRqCsYwYn8izJ3EZUCZJi84GJgMXVYOcrZGQcTYh2bOp7fQZAGcicMfjNNlUDUeGm4FkCiFG7e/JCt1hw6DjjHsj7cOljrFszZ/za4lTmPBAdqWWgkxntWAv7/8h9yKLRDSwqF6VPbcBuvdpjFcipU19jB2EFREqU+yDh2z9P8jVp+NYlDYs6+xLHdYBEND/LMnrEN+NbhwlWlYVsRVj65wfw3c9CuWE88RbI0IHQURPt1V1pjxbhB1koM6LI1Vxw7UJ/+c2VEgpK/Xy2gdOBYjueTTiU3wUgBnq7tY6+BKohFU2A6lljc5bBfhCQiW99GhnH3LPUnR3A9cSPvAtWhKEkHNpjbfKZlThxTuIl+X3xYvpDEb0XdZieNfbDBwxDvFgsJ+12FL2yIl1OurKvn2ZVyr3CpB3iuajPvEFRDfUOesePhZi57zMeYjcGFX
X-MS-Exchange-CrossTenant-Network-Message-Id: e3baf697-dfd6-417f-952b-08d82987a26f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 12:56:19.8568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAWAYR/1nyzJii0NugVwtcIwDeOPSr3gMb4ibqvwb6dv3GwekP17Pwrj8VOxog4B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594904186; bh=kaJCl/87lwPtCVyxFWmUcLGvEplXuxsVGiGHwQLvHRQ=;
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
        b=C7hBSRDwAQ4Xs3M48XwuutWddahmHsUmbgZT2Xe7+PgGgqGjkH9IOpMBCUzHEf38K
         AWb/4x40zh8NVNd//pv/VPNwP5A48titSlf+aeHb/Rrdh1sF6JMIav4NwHnq2xlUL8
         RVPT7kUKSR7shL4UdLKQhD7E0mBtY7jv11YcM8Pc9Wrw2p6hx96ADMgDrABgwNiYEf
         cIJ+BHSVLU+ShCCmqgOcWtkPvFDWUb+Wv62sjH/xOQnoEXZQgkU/pEgh+pntKH4fQQ
         OFSIEgOeIOzto8gCEkOGVXjFsHiULLB5evB8RyvJprbb5p76qGAp7kaYJu0LSC/gtg
         tIcWLXb2/TLGA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 14, 2020 at 07:28:58PM +0800, liweihang wrote:
> From: Weihang Li <liweihang@huawei.com>
> 
> The RoCE Engine will schedule to another QP after one has sent
> (2 ^ lp_pktn_ini) packets. lp_pktn_ini is set in QPC and should be
> calculated from 2 factors:
> 1. current MTU as a integer
> 2. the RoCE Engine's maximum slice length 64KB
> But the driver use MTU as a enum ib_mtu and the max inline capability,
> the lp_pktn_ini will be much bigger than expected which may cause traffic
> of some QPs never get scheduled.
> 
> Fixes: b713128de7a1 ("RDMA/hns: Adjust lp_pktn_ini dynamically")
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 34 +++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 12 deletions(-)

Applied to for-rc, thanks

Jason
