Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA7822C715
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jul 2020 15:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGXNxC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 09:53:02 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:33386 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgGXNxB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Jul 2020 09:53:01 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1ae7ba0000>; Fri, 24 Jul 2020 21:52:58 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 24 Jul 2020 06:52:58 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 24 Jul 2020 06:52:58 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 Jul
 2020 13:52:48 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 24 Jul 2020 13:52:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwvApCct9HYU7WpP+91qgRtiqdY/En09asBJTBhz0HAIX26eLcdQUPd0yAQkp7xZWd5U9FqZsxbENUAhetb8YWpm74qSOCAXZk/HMD5CxISPKMB/uVegXpaZ4lQioKV++2AKb5intx30DIEg4t5d6qYbctRZqBsQ2vZ+PqP1cA/+t74/Cb6G8m3nmFY7r5URdlpYe0S08ffBsYnrnsfg1bsLBst3XwLYoX7behCIF926zw+UY0H4r8o1oT1vLch77mI57b9nk3ZD+UVPdO+xuilchKbMzMQq03nEm3CrAQHzo0SGaNf56bl6PCkvtB1QRSS1Gg/5flueZTQu4yeMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h99gy8av9Lo2r7Qcz6I/fxlOdaYOm9rFNsGDZFXjjac=;
 b=gEGor2X/RMwuRkVUvqGbbevpMBDjAVI6iAkSVRF2NRvI1QmRBIry/H+KM+NWV+oe2zor360ISt75uEXyfV7EZ3pnWKXTgoh5kfQ9b9CRFdgRl7u2igIVy0OTdUnwmy9pYQ1g7MTgmsRo96SXprWznM8VFkPlm//xWBflWyY7mmM24mEdUcnRDo3ae+W65KHcpUJitto8/ZHPaGnqc3ApQYGRFFpTK1mEbp39iHcVV6DuOr6pkMVyb89UuVALvHTtYldnrVzA0uDBB2yK4Fp9dNgtQpne2SXnoAoOPegleo2i/6lGElLVjQAWZz0EmLULLTrP+v9qSc3U5EVi9xO9vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1241.namprd12.prod.outlook.com (2603:10b6:3:72::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 13:52:46 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 13:52:46 +0000
Date:   Fri, 24 Jul 2020 10:52:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leonro@mellanox.com>
CC:     <linux-rdma@vger.kernel.org>,
        <syzbot+086ab5ca9eafd2379aa6@syzkaller.appspotmail.com>,
        <syzbot+7446526858b83c8828b2@syzkaller.appspotmail.com>
Subject: Re: [PATCH] RDMA/cm: Add min length checks to user structure copies
Message-ID: <20200724135244.GK2021234@nvidia.com>
References: <0-v1-d5b86dab17dc+28c25-ucma_syz_min_jgg@nvidia.com>
 <20200724134545.GB5479@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200724134545.GB5479@unreal>
X-ClientProxiedBy: YTBPR01CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::44) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by YTBPR01CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Fri, 24 Jul 2020 13:52:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1jyy7w-00F2u5-4v; Fri, 24 Jul 2020 10:52:44 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 544c8575-eec9-49e5-d65a-08d82fd8d875
X-MS-TrafficTypeDiagnostic: DM5PR12MB1241:
X-Microsoft-Antispam-PRVS: <DM5PR12MB12414FB47FD876C6653FFAA2C2770@DM5PR12MB1241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x6cz96XnLVa8hNHYjziAab8+RPIH/UA4hTUBf0j9rDIjMTznOCsQfA5T8AdE+YIaVN0kvnFJuyQa7UNBWG0tMP4YxNwHsbJM8sKb/azXD/x/8Ygli73F0Be2GkNccRJ80fBVHnS8yoEBHZpF4Bb/obvlGSOJF5LL9vVfbcfBMYutBGKj2d0Gg/ukPRsUH7PRI9NJAWxQh3/vUCplFsYyFaZd065tLsed1zsK32vsqgU9hpTZfk1Mx6FHBaV4fFnpVVrWjYDKHL0g2J6KKNDjai1jy+CxaXilNYPHYaEE1ibisXVlOAlMirYHLEk3WZjd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(9786002)(9746002)(8936002)(316002)(26005)(426003)(4326008)(2616005)(33656002)(478600001)(86362001)(8676002)(1076003)(66946007)(66556008)(66476007)(186003)(83380400001)(36756003)(5660300002)(6916009)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GAyCQ/72qyk4dEp31OVc9zlscIlFw+njMH5ooU/kvHB6P7hr6kqTgTeBZh/mpktZsl8/gQPdy7h5Hqyu6qYUayW9KqQk+wXDR5B5cMTav/5OQ3h9LN64amJ7Xvekl4rbwz/ozyswVzQw/4NM2yjl1wMd+K6ZugU1PkyGS1WYTwFroXZFHjmo3Zu8bHBslQvKEWVh4sJhQiEpPkHOh8GFXEjTNPzSSYh4ROpDnSyqnGaYy+/O+jEug5ILTPynW2CF36koxegnFLdpmU/aRRNakLUENPC/rfrLs60hA+iUQSgYx+9T+qbKJ5Kh3h0kmA11adkGYPgGImtBB8qJfbJBeq6nIjnvZDjCrLZGqQh4iL5gdbGNOZyMbU/VJKIB20X2mWH4IYd5yVJteR+i+ZLOa7sjpFpFo6raKawGFtc4tbMTGZm8gV8YnGjmlJX/xn6nyfZPND61kvNOZdw0ApiQkIeXW9nIrTSrMYStNoDCftE=
X-MS-Exchange-CrossTenant-Network-Message-Id: 544c8575-eec9-49e5-d65a-08d82fd8d875
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 13:52:46.5996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FYqmiGLvirdGaxar+I2UoQc5+XhcSPs2XSa5lSSAxKIECM2DyWNA8a8/qCNwgE5N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1241
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595598778; bh=h99gy8av9Lo2r7Qcz6I/fxlOdaYOm9rFNsGDZFXjjac=;
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
        b=H/xdF54UA/kkG7o+Mus96BWZXsRR/EpU4neKNRhY0Tnj0rUoQzn3Z/QuVAhai7B1+
         oJYv2zI91QXc9/MLRgqP9ppctY4ywxp7/8XHLhgeAXVmBA6GWjpozvZ2g8bXbPTHdk
         oMUFiXa4gEW9kwg92G6egzKhPCqp0N3SvdPMGFJ2hu4vPFXflEZ1UO8OuQUZjxFpH+
         JtyxXj+JBu76izTHS/9JA1NKGU6ii6TFY1yMN3awEB5yl4XB2suSG3/7rIMe8aeeSF
         zTAJx+VJ6ewR/eXrUESmhob/C25Q4iWjVSOW3i+m/i23MVuqoGqoiJcT1XC51MUbSx
         +dVSBxI5esbTQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 24, 2020 at 04:45:45PM +0300, Leon Romanovsky wrote:
> On Fri, Jul 24, 2020 at 10:19:29AM -0300, Jason Gunthorpe wrote:
> > These are missing throughout ucma, it harmlessly copies garbage from
> > userspace, but in this new code which uses min to compute the copy length
> > it can result in uninitialized stack memory. Check for minimum length at
> > the very start.
> >
> >   BUG: KMSAN: uninit-value in ucma_connect+0x2aa/0xab0 drivers/infiniband/core/ucma.c:1091
> >   CPU: 0 PID: 8457 Comm: syz-executor069 Not tainted 5.8.0-rc5-syzkaller #0
> >   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> >   Call Trace:
> >    __dump_stack lib/dump_stack.c:77 [inline]
> >    dump_stack+0x1df/0x240 lib/dump_stack.c:118
> >    kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
> >    __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
> >    ucma_connect+0x2aa/0xab0 drivers/infiniband/core/ucma.c:1091
> >    ucma_write+0x5c5/0x630 drivers/infiniband/core/ucma.c:1764
> >    do_loop_readv_writev fs/read_write.c:737 [inline]
> >    do_iter_write+0x710/0xdc0 fs/read_write.c:1020
> >    vfs_writev fs/read_write.c:1091 [inline]
> >    do_writev+0x42d/0x8f0 fs/read_write.c:1134
> >    __do_sys_writev fs/read_write.c:1207 [inline]
> >    __se_sys_writev+0x9b/0xb0 fs/read_write.c:1204
> >    __x64_sys_writev+0x4a/0x70 fs/read_write.c:1204
> >    do_syscall_64+0xb0/0x150 arch/x86/entry/common.c:386
> >    entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > Fixes: 34e2ab57a911 ("RDMA/ucma: Extend ucma_connect to receive ECE parameters")
> > Fixes: 0cb15372a615 ("RDMA/cma: Connect ECE to rdma_accept")
> > Reported-by: syzbot+086ab5ca9eafd2379aa6@syzkaller.appspotmail.com
> > Reported-by: syzbot+7446526858b83c8828b2@syzkaller.appspotmail.com
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> >  drivers/infiniband/core/ucma.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> > index 5b87eee8ccc8b6..d03dacaef78805 100644
> > +++ b/drivers/infiniband/core/ucma.c
> > @@ -1084,6 +1084,8 @@ static ssize_t ucma_connect(struct ucma_file *file, const char __user *inbuf,
> >  	size_t in_size;
> >  	int ret;
> >
> > +	if (in_len < offsetofend(typeof(cmd), reserved))
> > +		return -EINVAL;
> 
> This check wasn't before the patches citied in Fixes lines. This is why
> I didn't add them while extended ucma_*.

It wasn't a bug before.

> >  	in_size = min_t(size_t, in_len, sizeof(cmd));
> >  	if (copy_from_user(&cmd, inbuf, in_size))
> >  		return -EFAULT;

Because this used to be:

       if (copy_from_user(&cmd, inbuf, sizeof(cmd)))

Which always completely filled the stack memory.

Jason
