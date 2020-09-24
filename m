Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5342778DF
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Sep 2020 21:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgIXTA5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Sep 2020 15:00:57 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2606 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgIXTA5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Sep 2020 15:00:57 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6cecb90000>; Thu, 24 Sep 2020 12:00:09 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Sep
 2020 19:00:52 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 24 Sep 2020 19:00:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyjXdaee3mjhAlaI8XkLYiOLtAmC5Vm2QtjINJIGzOOriW+pM9FnKt0zgYhhWF1Y0IHPabpkLzDGIBdZ+4zozS8if/YN9oDSndTX8c3bymdS5N72nIm93DKqg7RdkBkjJJqScH8iz4NkA9alMq3JbSBx0s+/DFmTLKEJJ+kj3ssXB6/m/d2bdshLvgYThPxP8byuDZhA/LcGO5WmsRGgy3I5Na1+y6+0fbWkYbia9I8eKhElELnygrNpaWq1ASpAMiZ7aIyX22cxd2qNb+8ydosWBWECHPrA6/Uab4C2h3+QZ8eXIhy0TBc+PObKrfcGnF0U2v0svA92GqQMBqyaKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uw4QWEY+6FKtz/I90z4OLmXFvy9hg8cp3SPSSLVKMWE=;
 b=a6bLDRIBKhupj8A0rnxu82bFa5VFV2WKVfQBKdLdfKQnw7RX2Kq/iosjv593/TAXbevNyb8MR+fu1vH/lNmTqYSQJZAfz3gmJJSH1QkIowHIwo4b8MIzjOzsxV7uVVvkpvHhB1BwGqoyNbnlvMrW5kymvekkPCoEKlNhZ1i1X7SaP88VwlOg1pK2ufkVk3qrX9M6Y3oKQnLD8HV6y1OmGMdzH4pBr6Dax1lw2+fkEs+oZUf4bDyRdh33GTlm9cbY/7Xw44LNxZWUu5CwMkQhypK5cPC1HjCLp0e7iu5GesscLdVl28B+kvumfpyae5ounoKBxqBOfCjj0p9sO+PCug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2489.namprd12.prod.outlook.com (2603:10b6:3:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 19:00:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 19:00:51 +0000
Date:   Thu, 24 Sep 2020 16:00:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v3 for-next 0/8] RDMA/hns: Misc Updates
Message-ID: <20200924190048.GA121710@nvidia.com>
References: <1600509802-44382-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1600509802-44382-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: MN2PR01CA0047.prod.exchangelabs.com (2603:10b6:208:23f::16)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR01CA0047.prod.exchangelabs.com (2603:10b6:208:23f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Thu, 24 Sep 2020 19:00:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kLWU4-000VgP-EF; Thu, 24 Sep 2020 16:00:48 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4182121d-2066-4ef2-cf8c-08d860bc26fa
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2489:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB24896AD4721C30004532B64DC2390@DM5PR1201MB2489.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ecj1fM7BB5TdtvFXGS9mCwa+zMlb45Q4OTyIhZQjSLSyFFeXLXE6WIZV3DxBIXkOL+Zn0mb20O0si9R5m5KOGGohx6BkbmZQHv98INP3jnsRZ8dTPWx2bpuDAPJZitAwWhdiYbaS+AQY8MfF+P2Qz9t5Aj7yKYVijtjGHZot2340XTwrRfF6Jo9ecdfDg/VDEYP1vKculs6hOTCf4atkBWzoqi08hFuVMBvDbzorFPeT3iyXMX5ibGMaQPrPYT7oBCdj5ueGCWy/y2d3Ede0VQvxv6JJm8vsTG0xcLndg+KBFv77b1i5EJ5marq36ZGQrJCY17LHvg8oVlorhTbyTpZQcfDxFTqT9nptDhaYIDibiA3KEwY6mvkLtEP508iupKZVk0No6R6e4rndUu+ihGTBoXcY+kuW367FcCUb+1IrxR+7dyuN5tdQTdnq8kbOzfqNTcbALDkw0PNSUUyk/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(9746002)(1076003)(33656002)(66556008)(426003)(966005)(26005)(478600001)(36756003)(66476007)(186003)(2616005)(2906002)(6916009)(66946007)(8936002)(4326008)(8676002)(9786002)(86362001)(316002)(5660300002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: h8XSyIpYXJQPy3x6aKoB7D51BtAR4yz22hrQbKwDcSHliD75XkzRPr9EwBMGLGVHNz8/b74P8Axs9wji2T9AaK31XZmVZv5LV/WHAJJB7OrT2d2J3ch4aQzG3e7hFSitn/MmTihChyBEAyPLutkfIEHqxmUtnohoO+m5OsCuixC+tnwIwXnWmFUBDckVKF9qko/2HW95xkBASHx1x2d0rlSScpCICSfCRNu33b6Qp1fCpFCrKRUiIqvZ9/FgiMpV/u4GSbfYNnQFGEV482XO2mewiYnWZ2dlxlk841Ufrma0w/ehQ4LQD34hKLOVIlLZP6Yt/zoxEtaRPM7MXTDRXJu9fO/6WoGlUtCvcTxwjfEZa1g5nc5C9iNSBdM0jUTrNHV0smMkOrmRNmvbXNfV6era/Ktqv3XVx7IW+81K/4DAnmst2FRUDwZjsN+H9lgH+PxgXNfov0E04vHooOK8G210PAsgoFfdGMyVAmzIjPqela1YRdolEKbdkI3GYlhu7dLI3B+vfERTKx1xaCT8TZGVrK/7ZwFsY+cu+WzHrj6OXEx3KDz5+eld+w9J997xaBq5tvYbki0u6qHiow7nzyKMAM1oK4oRaubJd6OcyVfYy4ojyp01/TOm3JYr+eGuDtyyqvG0JBJI7+ck7LUc0g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4182121d-2066-4ef2-cf8c-08d860bc26fa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 19:00:50.9787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBRcNP3DS6oQ5ufS3TbPF4t0OyQM0Bbckh7DlXyJeuW789QBekQkWIPQWH8lWW3O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2489
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600974009; bh=Uw4QWEY+6FKtz/I90z4OLmXFvy9hg8cp3SPSSLVKMWE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
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
        b=JPClUYbFFavyOkFwho1MuqTJR/sYo5wFz33CCunSAf6yLl2wIWHKuHMZfa2kCW1gn
         AjXbYnkrlo7bnnBhXrzC0R/SARDAd/Zeb0GykvGo+t+4B3xD8GzxiB6BYpiJZY+Ng3
         SiT28RpbNMSn3GgNLAE84ryY56pVMJE0rgDzj9PoeG3Oo1/mbDtAfVlgVUVgmMSroa
         bjHUGbeghOMTQCmepvLhvKos6RAbrDsMgsmfae7qgnzSMwYeY3t+vZHJFMnh9sPfp3
         wwqLAejna7TyeD+FFc6YuPh/qQDiXDVc5nCbQf5skDWsXeLZikTVQEsbhLw9BjFd9g
         VCOFH87SBZoFQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Sep 19, 2020 at 06:03:14PM +0800, Weihang Li wrote:
> Here are some miscellaneous cleanups and fixes for the hns driver,
> including refactor, some newly added checks and so on.
> 
> Previous discussion:
> v2: https://patchwork.kernel.org/cover/11765125/
> v1: https://patchwork.kernel.org/cover/11761647/
> 
> Changes since v2:
> Fix some issuses according to Jason's comments.
> - Change 'unlikely' to 'WARN_ON' and remove prints when getting illegal
>   opcodes.
> - Drop patch #2 from v1 because the newly added check is meaningless for
>   sparse.
> - Add fixes tag for patch #3 ~ #5.
> - Change '1 << PAGE_SHIFT' to 'PAGE_SIZE' in patch #6.
> 
> Changes since v1:
> - Fix a missing assignment of owner_bit in set_rc_wqe()
> 
> Jiaran Zhang (2):
>   RDMA/hns: Add check for the validity of sl configuration
>   RDMA/hns: Solve the overflow of the calc_pg_sz()
> 
> Lang Cheng (1):
>   RDMA/hns: Correct typo of hns_roce_create_cq()
> 
> Weihang Li (3):
>   RDMA/hns: Refactor process about opcode in post_send()
>   RDMA/hns: Fix configuration of ack_req_freq in QPC
>   RDMA/hns: Fix missing sq_sig_type when querying QP
> 
> Wenpeng Liang (1):
>   RDMA/hns: Fix the wrong value of rnr_retry when querying qp
> 
> Yangyang Li (1):
>   RDMA/hns: Add interception for resizing SRQs

Applied to for-next, thanks

Jason
