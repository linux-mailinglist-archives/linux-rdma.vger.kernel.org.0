Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677B8222466
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 15:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgGPNz0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jul 2020 09:55:26 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:31419 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728929AbgGPNzY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Jul 2020 09:55:24 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f105c490000>; Thu, 16 Jul 2020 21:55:21 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 16 Jul 2020 06:55:21 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 16 Jul 2020 06:55:21 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Jul
 2020 13:55:11 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 16 Jul 2020 13:55:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4ly7ueWKA/9WAAvrGw4uFPZOv1cZAyzlZ+uOk+D9b5dAMSPI5NpaloUzSRUwljustB+fRNaVT6h149vn6/wDkKECEa8N5owfKHTQykBZAVNs4+2d7sHid6G6HeLRjjTKHasVcLMnFnWVNq/6IHIRxtZyx7C+O5gS0NyoyAaMOq38b75CuTU7M8+Rw79z2TFpuc8kD093TI6X1hb5bvD7AXnPHHsKLzD0AtIuqxl7RLgZYF9Ypk2ccgGzbC0T4eQs8UJ0zr5wFM8Sg9QEbXOypCKa37F7DsYf5W3pJq0oosdSd0wX7DdE2GP3LgKpFCS5uHmmIyv4EfQtEhwD+Qasg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t03fRMR043UDUMyeISVVNRalE07zM694spPtKeoR3mc=;
 b=DwrTSvkTy4elHx6U2lI2wPg5jtx04QZ4aJtAOPnB/jAjxixU+uhRx/jO5icMVaEL+qwcx/wY0M/tE2QSOHm768AdqbmN1OwlzxiIFOi0cUcC8dcRI0FopL3xEJk4kdOGR+2LhVE1uj1uuBl1JWugzE2ZWveF91/nWBb4+uM9SKgJ6UvhIotkfkRg1YaAyw0DWhxIDuLDpPkLonFk8pfw1cpHRKyp4vc5JGRBFfGRY6S2/C0bLvzccZeS8Kwkcw5dOJzbLfZuJPLo4dDEaAIg/KfTMkpWjYHtimJuf0WF5kWxMSDtiRCbnLliWUt4SVacqVfO2zdon7TukHKK9NSVtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1514.namprd12.prod.outlook.com (2603:10b6:4:f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Thu, 16 Jul 2020 13:55:08 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 13:55:08 +0000
Date:   Thu, 16 Jul 2020 10:55:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-rc] RDMA/core: Fix race between alloc_uobj and
 destroy_fd
Message-ID: <20200716135506.GA2626442@nvidia.com>
References: <20200716102059.1420681-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200716102059.1420681-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR02CA0140.namprd02.prod.outlook.com
 (2603:10b6:208:35::45) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by BL0PR02CA0140.namprd02.prod.outlook.com (2603:10b6:208:35::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.19 via Frontend Transport; Thu, 16 Jul 2020 13:55:08 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jw4Lq-00B1H8-A6; Thu, 16 Jul 2020 10:55:06 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51b942e2-3660-4270-ce61-08d8298fd990
X-MS-TrafficTypeDiagnostic: DM5PR12MB1514:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1514780962FFEF2FAE4118A1C27F0@DM5PR12MB1514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:421;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iK3DXCfnbNoCNlDFDdvQcNol8BL1CKYJvWs7n0sSU1+/Yhp/vHmqHZrx5J6hy7BxXf4pzGzz81pI5Nh0uBsVMJXWGWZqKtWN1JqJw+FIorcCtAQOid1qYyWjshVC69EVBr85+poskmEiFJqwYLZCJLiquH+M3yxRi+EJbIU7ERdjNMF+Y8rKJbdRVrXFrL75Coylw//3C8O3YEReKvKywiXTePTuAmmV+Jr65PHT+JkZieEMKFBgsf/Ta4petbHPimznFO34lChiuPcCP2pktpl8T65+f2mn6NIKQmx3xxA9GtXBbGah+/QQmW7OxYCiOHCL/9PFX0ZEKf/ijNLwJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(8936002)(36756003)(2616005)(478600001)(66946007)(26005)(186003)(66476007)(54906003)(9746002)(426003)(316002)(33656002)(66556008)(9786002)(2906002)(86362001)(83380400001)(6916009)(4326008)(5660300002)(1076003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 43bvc8TpZx528gQUhfehdH1nXwLnYDH1wx7Jh5AW7xSFfvRn7MQoiHrI+td9MFnN/C1f4ALp5lQ996ktaA/7MgVwP9tlWfFx9pWlbKlDqb0eMWGjszmGlwdzQuwYS5Qg1p7P7qzvEBYwk57gRaYSZo6tASXlGeEHuBcZILP2UCXjZ+DBPks/KbXYJmrhLJCjxzxtxUGyhWD1x6nFkWLqwgwX0i+oTbtv87ukcxiRBwOloyks8tCbV5vhoWcSIzho/qCiFS6d1PD3/PnQYDt02+CelgOw+zGuJdzud1LZSxTu6bJIYdpDC79RcTuZOzEBha/BfJ66xXNWyw5ryY/IFxTfmusbw5jhnJ29YMD7oqsOurjJ5SrKG1CoAVYsIzfPv5OgLTyULMcR0RBMYrpsM0kV1OWdwyRzqLThL2QICaXpBcGvEH1u+o2Npnw/ukcGQ/1gZDLE1z6jXYGb73DsOdqBD9cKnstz7ozwi8ct6hmbob8YoqM9S1y0uTws2ggJ
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b942e2-3660-4270-ce61-08d8298fd990
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 13:55:08.2591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9OUDY4rZj9VtAvpwA+UXgB/ViWAc6adG9DjyfuALa0Url2vujZGZjqD1kOl6WRW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1514
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594907721; bh=t03fRMR043UDUMyeISVVNRalE07zM694spPtKeoR3mc=;
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
        b=BRWFWhnFmWI8TDCHhrJW4/zdGh211evNJBbUiZC3GM31FUQ+eB8gUJKRWr4nI5Exd
         TxzQ2TrBxJuE/7y+QgQA2c7Mgs2o1aMKguREk18UF244fdeuqrT0P+OvZSZ3s/2jHQ
         v/SCjfJUNA//48SimyrbPAd9/KwkVss/h5jQ3lznhrlqA+hgU7iQNwaQAK6gs+vsQU
         a+RQ5IWTVD7MfXMHfSGZr9fRzxqjKCcAERIf6LolXA7d5xX5JH1PwVj8Eqx7WnoTRG
         XcmfEd5bBgOFzfiElQdH5phjzFvzuL75Fml7JNIKKVLOSeQMhTJJKke9D9++nkWlUX
         GYn/YlStdAOEQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 16, 2020 at 01:20:59PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Both new object allocation and FD destroy paths hold UVERBS_LOOKUP_WRITE,
> the race between them causes the following dump stack.
> 
> [  268.688470] ------------[ cut here ]------------
> [  268.689460] WARNING: CPU: 4 PID: 6913 at drivers/infiniband/core/rdma_core.c:768 uverbs_uobject_fd_release+0x202/0x230
> [  268.691322] Kernel panic - not syncing: panic_on_warn set ...
> [  268.692273] CPU: 4 PID: 6913 Comm: syz-executor.3 Not tainted 5.7.0-rc2 #22
> [  268.693456] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> [  268.695688] Call Trace:
> [  268.696135]  dump_stack+0x94/0xce
> [  268.696784]  panic+0x234/0x56f
> [  268.697384]  ? __warn+0x1e1/0x1e1
> [  268.697942]  ? kmsg_dump_rewind_nolock+0xd9/0xd9
> [  268.698782]  ? printk+0xb2/0xdd
> [  268.699301]  ? __warn+0x1b1/0x1e1
> [  268.699946]  ? uverbs_uobject_fd_release+0x202/0x230
> [  268.700829]  __warn+0x1cc/0x1e1
> [  268.701402]  ? uverbs_uobject_fd_release+0x202/0x230
> [  268.702227]  report_bug+0x200/0x310
> [  268.702807]  ? uverbs_uobject_fd_release+0x202/0x230
> [  268.703618]  fixup_bug.part.11+0x32/0x80
> [  268.704260]  do_error_trap+0xd3/0x100
> [  268.704898]  do_invalid_op+0x31/0x40
> [  268.705581]  ? uverbs_uobject_fd_release+0x202/0x230
> [  268.706479]  invalid_op+0x1e/0x30
> [  268.707035] RIP: 0010:uverbs_uobject_fd_release+0x202/0x230
> [  268.708046] Code: fe 4c 89 e7 e8 af 23 fe ff e9 2a ff ff ff e8 c5 fa 61 fe be 03 00 00 00 4c 89 e7 e8 68 eb f5 fe e9 13 ff ff ff e8 ae fa 61 fe <0f> 0b eb ac e8 e5 aa 3c fe e8 50 2b 86 fe e9 6a fe ff ff e8 46 2b
> [  268.711365] RSP: 0018:ffffc90008117d88 EFLAGS: 00010293
> [  268.712218] RAX: ffff88810e146580 RBX: 1ffff92001022fb1 RCX: ffffffff82d5b902
> [  268.713439] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88811951b040
> [  268.714606] RBP: ffff88811951b000 R08: ffffed10232a3609 R09: ffffed10232a3609
> [  268.715805] R10: ffff88811951b043 R11: 0000000000000001 R12: ffff888100a7c600
> [  268.717119] R13: ffff888100a7c650 R14: ffffc90008117da8 R15: ffffffff82d5b700
> [  268.718401]  ? __uverbs_cleanup_ufile+0x270/0x270
> [  268.719181]  ? uverbs_uobject_fd_release+0x202/0x230
> [  268.720140]  ? uverbs_uobject_fd_release+0x202/0x230
> [  268.720967]  ? __uverbs_cleanup_ufile+0x270/0x270
> [  268.721758]  ? locks_remove_file+0x282/0x3d0
> [  268.722529]  ? security_file_free+0xaa/0xd0
> [  268.723224]  __fput+0x2be/0x770
> [  268.723743]  task_work_run+0x10e/0x1b0
> [  268.724428]  exit_to_usermode_loop+0x145/0x170
> [  268.725172]  do_syscall_64+0x2d0/0x390
> [  268.725786]  ? prepare_exit_to_usermode+0x17a/0x230
> [  268.726580]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  268.727413] RIP: 0033:0x414da7
> [  268.728029] Code: 00 00 0f 05 48 3d 00 f0 ff ff 77 3f f3 c3 0f 1f 44 00 00 53 89 fb 48 83 ec 10 e8 f4 fb ff ff 89 df 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2b 89 d7 89 44 24 0c e8 36 fc ff ff 8b 44 24
> [  268.731055] RSP: 002b:00007fff39d379d0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> [  268.732322] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000414da7
> [  268.733587] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000003
> [  268.734818] RBP: 00007fff39d37a3c R08: 0000000400000000 R09: 0000000400000000
> [  268.736472] R10: 00007fff39d37910 R11: 0000000000000293 R12: 0000000000000001
> [  268.737754] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000003
> [  268.738983] Dumping ftrace buffer:
> [  268.739601]    (ftrace buffer empty)
> [  268.740181] Kernel Offset: disabled
> [  268.740770] Rebooting in 1 seconds..
> 
> Fixes: aba94548c9e4 ("IB/uverbs: Move the FD uobj type struct file allocation to alloc_commit")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/rdma_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to for-rc

Thanks,
Jason
