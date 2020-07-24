Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFFC22CEB0
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jul 2020 21:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgGXTdU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 15:33:20 -0400
Received: from mail-eopbgr20054.outbound.protection.outlook.com ([40.107.2.54]:56484
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbgGXTdU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Jul 2020 15:33:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfofRcGH/QTS8hoggJaw7QsV72T2X8KL27hKMwjn2N2Oc8sj41Ktg9EHIzfR3omLHvlej151s+aQ+VKt0iJxsgiU0xqfaVa0gG39E819g30MVoZJ5SAcSR/AxR+HwN11g6lq5nCPsE8TgcRz7c/qsNIiAdJ1orwmBmAbq8bASi4I1GS4H13w3xzTOsl22S2nK6ysluHN8P7gdNUPWP8GCOFCoSVF+prBvH/8KkB9kVar7MhzQZwquaUeAkaO3l4FR5PWWuBPWUQEcIMyhpndWtDQW1YxMNwaXyUX+BRq5gE6z6xaAdGtlCZCk6aeoH0ROWh7DZYI2AT+LFT4I2vyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfrH7ORZbHa2f/fYsRoadmhSWB6ImjNntendpACDK6w=;
 b=MfWsrhm1DP4xcH05pksCgtywBhkVFZaq2BRpmsQYdPu+OZSTmcplZzavJKk62GPwH5r0pMrdJigCcq8xOrmlDImTI8oZI8cb0xqhTOCL49jnBJtqb6Hjt1gQL3XQA12jyxTHtqX02tYKv5Xm4C9yZtIUbr4QG05OJcif/iYTv0LOOr/Ec/8Dc9cUeT6t5qMTvIpYT4zpX7Gzm53X3hjLll6nhCpbUmOOyKVjVY85dRDEKEPZDcd/LPO5n6Q0SFeJlVg9IlcepoGik4VSQJbTe6l1HUeT55JInvByoRHC5t9kBuPlhSFKqbajXK3bs7Ix446jjgXTNW1HGk0xkb/M1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfrH7ORZbHa2f/fYsRoadmhSWB6ImjNntendpACDK6w=;
 b=MwoYi+yMtIcteh+SY6ndaIL6EWIw83P8KycKQ+Pa4lB9W6cXDvUFH/bKsMDl+x+PfN+zdZuMfghiDTjBuCuFQsO41ZcDk//6QKXEDY9MtRuLRL3nrSDLicahlazwFuzAwHgASUGev/NQo8DMqKWSfDOKblHvOGVF/Y6vHXnMVJQ=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM7PR05MB6993.eurprd05.prod.outlook.com (2603:10a6:20b:1a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Fri, 24 Jul
 2020 19:33:16 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::15f4:b130:d907:ce72]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::15f4:b130:d907:ce72%6]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 19:33:16 +0000
Date:   Fri, 24 Jul 2020 22:33:14 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org,
        syzbot+086ab5ca9eafd2379aa6@syzkaller.appspotmail.com,
        syzbot+7446526858b83c8828b2@syzkaller.appspotmail.com
Subject: Re: [PATCH] RDMA/cm: Add min length checks to user structure copies
Message-ID: <20200724193314.GC64071@unreal>
References: <0-v1-d5b86dab17dc+28c25-ucma_syz_min_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-d5b86dab17dc+28c25-ucma_syz_min_jgg@nvidia.com>
X-ClientProxiedBy: AM0PR10CA0110.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::27) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (213.57.247.131) by AM0PR10CA0110.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend Transport; Fri, 24 Jul 2020 19:33:16 +0000
X-Originating-IP: [213.57.247.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3970d45-2538-4a00-b55b-08d83008699d
X-MS-TrafficTypeDiagnostic: AM7PR05MB6993:
X-LD-Processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
X-Microsoft-Antispam-PRVS: <AM7PR05MB699329CED62E6B194B697FF5B0770@AM7PR05MB6993.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Q1OMU/2lmwR9I9n46D1funS3aJWBofI2fVmGW9OaxYbg/IQJm/j1CEP4P3oLgNQbdwVFLTRSI0B1aDKN5Q8AqFHcHdOD8zZWx9Deixr+1FQSUtYemRYrI92ishPWmC/zcAkw9sE9nlP4etKKRHo37K5XnlTVlYZDzWIWxFxUlxPljGKiyx+8pYAVPRU8CbxRe38DtZ4IJBW7MQA4X/nFSOyoNk36DAELqk1DqA/s1GPzMvWraSAfKq+qr4yjurSe13sdfCLv6w+79YGVAqPe2xiHWS92sPCKlmKKLwmqAIeS8PkiGj5F9H2RQUYUhMl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6408.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(136003)(366004)(39860400002)(376002)(396003)(346002)(5660300002)(6496006)(6916009)(52116002)(478600001)(66476007)(83380400001)(186003)(6486002)(33716001)(66556008)(66946007)(26005)(2906002)(16526019)(316002)(8676002)(86362001)(9686003)(4326008)(8936002)(956004)(33656002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: K8j+Q4uD4hmskldxG+LG3AcNdQhB2sKFoxEOQa0gNW1Ro01jtcRCrF+c6w4pWZz7Lxm//4l3fyZrfpCP2hROmm0wtwbBuHL82wdUiWguud9sdyu/EKXe6dwvxsBM7s6cOFmR314zqgKYYjtSN2c07J1yeSvhQO1sU7fg4WV78IY+aBVHOEFlXnN1BkyftrccAc4pFNBYQS+pgX1YtR66+90M8Z+AZ2VM+PAXy+EfUPQYNgKJO2bk8uvdvJmZ0lhH5sdury1UmY52AfjGeOgK5WH8+XbB+xp/aH8fD44ley3xwLiHSlfPt7JAKMtba1VevE2+JGiUEBnZYm/64aUF5pNZoAvSUnq50okaYI19twr6dAIjkRdE5A1k8kbNXXkSEjuOmK1mPra7ZS/Ul7dONNKS1PHDScxh3OM4mYXrrWMLcxWOTFz22YQ/S9+4Akf092+i3uUrIpHxuSK/ETH1jUhJefUJRaBy/7kM5Ovz8SfZRdQVfXAU/i9GmMygAp1a
X-MS-Exchange-Transport-Forked: True
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3970d45-2538-4a00-b55b-08d83008699d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6408.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 19:33:16.3759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9WjXxbYQIWGun5W1LFk2dVuVamgXce2t7B38iurKEBQrGKLe7iN5cgHbEF4sdZH7gyJBYsdVuHEoaz8WS2eAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR05MB6993
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 24, 2020 at 10:19:29AM -0300, Jason Gunthorpe wrote:
> These are missing throughout ucma, it harmlessly copies garbage from
> userspace, but in this new code which uses min to compute the copy length
> it can result in uninitialized stack memory. Check for minimum length at
> the very start.
>
>   BUG: KMSAN: uninit-value in ucma_connect+0x2aa/0xab0 drivers/infiniband/core/ucma.c:1091
>   CPU: 0 PID: 8457 Comm: syz-executor069 Not tainted 5.8.0-rc5-syzkaller #0
>   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>   Call Trace:
>    __dump_stack lib/dump_stack.c:77 [inline]
>    dump_stack+0x1df/0x240 lib/dump_stack.c:118
>    kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
>    __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
>    ucma_connect+0x2aa/0xab0 drivers/infiniband/core/ucma.c:1091
>    ucma_write+0x5c5/0x630 drivers/infiniband/core/ucma.c:1764
>    do_loop_readv_writev fs/read_write.c:737 [inline]
>    do_iter_write+0x710/0xdc0 fs/read_write.c:1020
>    vfs_writev fs/read_write.c:1091 [inline]
>    do_writev+0x42d/0x8f0 fs/read_write.c:1134
>    __do_sys_writev fs/read_write.c:1207 [inline]
>    __se_sys_writev+0x9b/0xb0 fs/read_write.c:1204
>    __x64_sys_writev+0x4a/0x70 fs/read_write.c:1204
>    do_syscall_64+0xb0/0x150 arch/x86/entry/common.c:386
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Fixes: 34e2ab57a911 ("RDMA/ucma: Extend ucma_connect to receive ECE parameters")
> Fixes: 0cb15372a615 ("RDMA/cma: Connect ECE to rdma_accept")
> Reported-by: syzbot+086ab5ca9eafd2379aa6@syzkaller.appspotmail.com
> Reported-by: syzbot+7446526858b83c8828b2@syzkaller.appspotmail.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/ucma.c | 4 ++++
>  1 file changed, 4 insertions(+)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
