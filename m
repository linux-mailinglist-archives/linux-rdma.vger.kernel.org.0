Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E84C1FF3F2
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2020 15:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbgFRNxR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jun 2020 09:53:17 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4538 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730567AbgFRNxD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Jun 2020 09:53:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eeb71890002>; Thu, 18 Jun 2020 06:52:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 18 Jun 2020 06:52:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 18 Jun 2020 06:52:59 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 18 Jun
 2020 13:52:56 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 18 Jun 2020 13:52:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQZiU6V7A673uU/kasEvDjTQIjEBMKv19+B0rew4viMYeRaxJVB/NyhV8Dz1u79kOUdk79eaJTOqiwCDQTzuHRP9arwV7dM3XJD5cAQ4+j7GzKn4Xb0QXJmNeVMnIe93Mgu2PcoFUuc+21NjctArcwaFnjVGP77UamNEpPfOWkmt1EBUU8n/64y1YMa7WvsVEnzn/KGQfT4bSziv/+g4FXggvGuBWbgBNrag72YmEDRX68Q+QjC78G9WblgHC6gW7pwVjlVLDkZo7dGroKRIcFf++Scf1xtS7sz2NHCIVqWIJu88vLgfcn2wKsAc1DMThhXtMCBNwTanvjIExSNY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oLI/0fW8wRnnlKwT+wV0waDY5O8DRVU1CItGmaP+/A=;
 b=dLsygCOCdeyHIdqkAS9z4yJzP4H/DnpbIPR6cM6ZZOxsFuVCILkIeCURua3tSeL8SIlplIMNHoDB524huyd3BWEOmaCdjeXw5KbVECi8ATiyikSfetQf/cFLc/fJ9GE2j5kUFSfVjrtw8etZD3MqZHv5gf19LywMGN+44eRSOlRaKTRObUq6K37bWLXZwy58CG5bNqdbY7qJ/yEDmMRkYqpQ23vNDWoWaH5A+wAcN8sq/FocGe+F+Xis2+v2jq4BK0sfrZLs2HvbzPhUZzUe3G4o63eSSZpXx4qMKLdiK6BhJO1QhEzOJPcw0lP90hXXSZcEeX9tzcKAe/bfq9zvuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1337.namprd12.prod.outlook.com (2603:10b6:3:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 13:52:55 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 13:52:54 +0000
Date:   Thu, 18 Jun 2020 10:52:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH for-rc] RDMA/hns: Fix a calltrace when registering MR
 from userspace
Message-ID: <20200618135249.GA2417384@mellanox.com>
References: <1592314629-51715-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1592314629-51715-1-git-send-email-liweihang@huawei.com>
X-NVConfidentiality: public
X-ClientProxiedBy: MN2PR19CA0067.namprd19.prod.outlook.com
 (2603:10b6:208:19b::44) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by MN2PR19CA0067.namprd19.prod.outlook.com (2603:10b6:208:19b::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 13:52:54 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jluyH-00A8si-TI; Thu, 18 Jun 2020 10:52:49 -0300
X-NVConfidentiality: public
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4527c1ea-8f83-4c5c-7f9a-08d8138ee682
X-MS-TrafficTypeDiagnostic: DM5PR12MB1337:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1337F81370F30B4FCC8A6F5CC29B0@DM5PR12MB1337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: szZ2bu9VXeePWzcaSWdIopd2GbAvjMpEjlfyunPSjKsSESHpRCeksOHNcOG+tA3Jcx2lJz8ayU+4QVjW/yzhDwMZx1/xzDilEBiNOcWh6j2f1MeRwXtu2GWsUVqDmY6/Oz7uSKL1jKpkTept0wi1SeD6OO8ec+19bAHxPTl3S7R3g7w5OU+dhFECwTOtZS+lT7vjjzL07YvUqkd2Yx0SFPSqY1kGmpGw35ZjIxcxTJ1UCj5wk3ouxoldct0uPcv0EcuSz/YqjDlEJNBe4tVHxENwT3/9hkvLJXF9utylBedDXwQRAxNevIjoXojzkwbr+R7hSlSbAJOkoYrfa/YWVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(136003)(346002)(366004)(376002)(6916009)(8676002)(26005)(66946007)(83380400001)(9746002)(2906002)(66476007)(66556008)(426003)(478600001)(9786002)(36756003)(8936002)(86362001)(5660300002)(316002)(1076003)(4326008)(9686003)(33656002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 9XFMVO4V7D6kzMy3OGOqCTdVvKjEDiIwXqnJna95NxIZra86SOCkzJFqRupf4NH+v1pXLeSqhV7FkwYblYjGzVXcOpU9wV7IPGVnykCvrTQOKTaZ2gpzdws/S67uUndEa+CoYyun14RqyJfRY8W52ABhKMDC64dJA8vEsfjcEBqF01VGLRVnGlVvhxFqXSKpwj2O+ctAtpJEyXhuZ8xuif1vvEt9vnOW43FzTkbTz3P5V2E9I1foHZKTX+2AwgT328dyg1rGhq7//wV7QpaomNSpdL+ZysJonuVr7NJWYl8xfeiT/Hl5mcmzBPTIFF6gfj6kRNepeIgT5uQyApiQykrgLiZW725XY7ZlaIqbw7XM4DBcO3gs7vNl5FGmiVRa0JFDX2f+prMVCTg31EdthN0p+oE8VER3fF+RP5w2/OcU0SmT9UWCKo/8sf0V4gnRT6VfaoyPtDReLSd8xX1JqqtRZ1DX8ei+fbN3cbFpBHsdrLkMOcqzMgh08BqLXaVm
X-MS-Exchange-CrossTenant-Network-Message-Id: 4527c1ea-8f83-4c5c-7f9a-08d8138ee682
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 13:52:54.7840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjyEoOgv0+w2igmcO/ixICtIF+ch7ZwiSxo209oFttL7h0KIqZdM7b1NBRoV5BcJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1337
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592488329; bh=6oLI/0fW8wRnnlKwT+wV0waDY5O8DRVU1CItGmaP+/A=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-NVConfidentiality:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-NVConfidentiality:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-Forefront-PRVS:X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=MrmPRpYf+fyEVmeujoqKMqfg/i9vOf5gh06PVM70BrWD6Db4mf0AtpK0FjY6NAlFt
         anGfPGIGN6B3ZTz9Idj8POCTOC+ZkLIw3u1Bjm6sC2vjsKFXu+HJnTHtqizlxIbJa4
         VEcwlbnY3iwWJL8TLjSrJVDk7vMl4dMulJcksk65bUAjdSkA6eks1gdpIESMIqiQB2
         vuhnIrZBxrnnwf9gReGNe4aP7/T3LAXWAJ8pHZ2CGmHLkCd5IAV7azcxd+kjD+7Ovz
         mRaHM7x7Zj0mZKLmCggZ12jYLLgJvzhnBQEhDgIW04E80glfzIJ91NMf40W6kJGFg3
         bE4rdZoE+DkDQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 16, 2020 at 09:37:09PM +0800, Weihang Li wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
> 
> ibmr.device is assigned after MR is successfully registered, but both
> write_mtpt() and frmr_write_mtpt() accesses it during the mr registration
> process, which may cause the following error when trying to register MR
> in userspace and pbl_hop_num is set to 0.
> 
> [ 3307.615548] pc : hns_roce_mtr_find+0xa0/0x200 [hns_roce]
> [ 3307.615554] lr : set_mtpt_pbl+0x54/0x118 [hns_roce_hw_v2]
> [ 3307.707924] sp : ffff00023e73ba20
> [ 3307.711225] x29: ffff00023e73ba20 x28: ffff00023e73bad8
> [ 3307.716523] x27: 0000000000000000 x26: 0000000000000000
> [ 3307.721821] x25: 0000000000000002 x24: 0000000000000000
> [ 3307.727119] x23: ffff00023e73bad0 x22: 0000000000000000
> [ 3307.732417] x21: ffff0000094d9000 x20: 0000000000000000
> [ 3307.737715] x19: ffff8020a6bdb2c0 x18: 0000000000000000
> [ 3307.743012] x17: 0000000000000000 x16: 0000000000000000
> [ 3307.748310] x15: 0000000000000000 x14: 0000000000000000
> [ 3307.753607] x13: 0140000000000000 x12: 0040000000000041
> [ 3307.758905] x11: ffff000240000000 x10: 0000000000001000
> [ 3307.764203] x9 : 0000000000000000 x8 : ffff802fb7558480
> [ 3307.769501] x7 : ffff802fb7558480 x6 : 000000000003483d
> [ 3307.774799] x5 : ffff00023e73bad0 x4 : 0000000000000002
> [ 3307.780097] x3 : ffff00023e73bad8 x2 : 0000000000000000
> [ 3307.785394] x1 : 0000000000000000 x0 : ffff0000094d9708
> [ 3307.790692] Call trace:
> [ 3307.793130]  hns_roce_mtr_find+0xa0/0x200 [hns_roce]
> [ 3307.798081]  set_mtpt_pbl+0x54/0x118 [hns_roce_hw_v2]
> [ 3307.803119]  hns_roce_v2_write_mtpt+0x14c/0x168 [hns_roce_hw_v2]
> [ 3307.809114]  hns_roce_mr_enable+0x6c/0x148 [hns_roce]
> [ 3307.814154]  hns_roce_reg_user_mr+0xd8/0x130 [hns_roce]
> [ 3307.819369]  ib_uverbs_reg_mr+0x14c/0x2e0 [ib_uverbs]
> [ 3307.824408]  ib_uverbs_write+0x27c/0x3e8 [ib_uverbs]
> [ 3307.829361]  __vfs_write+0x60/0x190
> [ 3307.832835]  vfs_write+0xac/0x1c0
> [ 3307.836136]  ksys_write+0x6c/0xd8
> [ 3307.839437]  __arm64_sys_write+0x24/0x30
> [ 3307.843347]  el0_svc_common+0x78/0x130
> [ 3307.847082]  el0_svc_handler+0x38/0x78
> [ 3307.850817]  el0_svc+0x8/0xc
> 
> Solve above issue by adding a pointer of structure hns_roce_dev as a
> parameter of write_mtpt() and frmr_write_mtpt(), so that both of these
> functions can access it before finishing MR's registration.
> 
> Fixes: 9b2cf76c9f05 ("RDMA/hns: Optimize PBL buffer allocation process")
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  7 ++++---
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  4 ++--
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 15 ++++++++-------
>  drivers/infiniband/hw/hns/hns_roce_mr.c     |  5 +++--
>  4 files changed, 17 insertions(+), 14 deletions(-)

Applied to for-rc, thanks

Jason
