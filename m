Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7D322C6F0
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jul 2020 15:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgGXNpy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 09:45:54 -0400
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]:57830
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726235AbgGXNpx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Jul 2020 09:45:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4jBkSLfLVSMHlRmscApNnvYpoL2wjmQct5+Pld+54ojwrmUT+OwNBOk3/LrnpviNXESnA1RWH0YgQEElX0J9f3JfLgr08bVRDGvpKdy7iriKI9NIl3T51PhZHadnL3eGb/pVXl1zirVHwbHz2WaI/7Rh4OWwrQxglETQFWVe187QkZcNy6GOpxRB0VXOAAdTk4zYxkdTZrilYlrKd2pp93dSs+zGg0v6zC3Iql3ulO0hDKQpL/S5W8DVZ2oYaS9qCcEBAdFCZZJ0EyxdBZ6BYJmBJ7rALXQvEDrx2T639T7OPvpeIruLI1rnSWXEFc/vf82qMWbdHIV6XSI3VF/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+psTmk4fdepwVKmqT3OEhCDjEFf9O+JnONji24fHW5s=;
 b=lajblyMTjQVXWJ01wbJGBP2c+irR38Tm/cJjflbu3jieYTbnSvfAMSSFVJwdUAj6/E5JIEK0slmFQGGnIfcXVmpnYhVYmnxg+IyJKD5vIm6HH5BnywI0MApEIHkxE7VbjdkFLIXi0NiAXW5M7Al9FGW5SqeTFaGwQOvMxnuUlon5AFeOPg7sEXynJhivCFNK2CJkhiXG3k9a+5VE+xP+WO8mMEG0oMfubNEmsGNhUN2jYbCPQByzaepTMwKydD4VbYRYi9Rx4jkjOjPzeONAmqbsf5uEPHZxf9Uo+8SdGh++W0swFiEvFSFSvyU93MtHfNi/a9iULG2X3etNz9Rc9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+psTmk4fdepwVKmqT3OEhCDjEFf9O+JnONji24fHW5s=;
 b=NBn7+y/v3E+iHpjHydMYXAhpbdcTQ/SlMFcc8A5V5Jst+f0qcHQt9AtqJX6dF/zudwn+BJPUY/HYnmf4LT6nBDnmZp29J1Mt7USzrD5hNJraAasVszW35hQeewGj0yHmb1eIW0jEzCttUiSyvVVPD0r7wDmmXHGzpJ73umjBh74=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM6PR05MB6407.eurprd05.prod.outlook.com (2603:10a6:20b:b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Fri, 24 Jul
 2020 13:45:50 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::15f4:b130:d907:ce72]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::15f4:b130:d907:ce72%6]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 13:45:50 +0000
Date:   Fri, 24 Jul 2020 16:45:45 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org,
        syzbot+086ab5ca9eafd2379aa6@syzkaller.appspotmail.com,
        syzbot+7446526858b83c8828b2@syzkaller.appspotmail.com
Subject: Re: [PATCH] RDMA/cm: Add min length checks to user structure copies
Message-ID: <20200724134545.GB5479@unreal>
References: <0-v1-d5b86dab17dc+28c25-ucma_syz_min_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-d5b86dab17dc+28c25-ucma_syz_min_jgg@nvidia.com>
X-ClientProxiedBy: MR2P264CA0074.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::14) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (213.57.247.131) by MR2P264CA0074.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:32::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend Transport; Fri, 24 Jul 2020 13:45:49 +0000
X-Originating-IP: [213.57.247.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cd1c61a1-f11a-4f72-4a2e-08d82fd7e03b
X-MS-TrafficTypeDiagnostic: AM6PR05MB6407:
X-LD-Processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
X-Microsoft-Antispam-PRVS: <AM6PR05MB64077FCE82AE6A88DC06654CB0770@AM6PR05MB6407.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oAce4GY8xWoNkKHgJbxWBdpmOHrTtjg1haZIGqVab3hFwMHi40/+boTy8/Lwr+lAnrGTp2mWiU5K8Wbgsf9W11lBQOMUXULa1C/MhKaJMEcFzKUEH085WUqF+fvYyIHyUju4OZsnNJ4IKlvGlhyRsTEIDGnTHS77a7I1Vx/bjQWjLFRXw6cpohb3S+trMOoUjCe8fnA3Pc1qod4FnJsYKee7PR0XbjFupLup2ROg8xjA1hIZlvJrny3LuJVNjKlLrtcPNExy/e9J57uHe5IgV9J035tiCAluH23xYtI/SbkOTd26t+conAh/ved1Ton2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6408.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(478600001)(6496006)(6486002)(186003)(2906002)(66476007)(83380400001)(66556008)(956004)(4326008)(26005)(86362001)(52116002)(66946007)(33716001)(6666004)(6916009)(316002)(8936002)(33656002)(5660300002)(16526019)(8676002)(9686003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HXFYNBH4Cd7cve5W2x5LyZY0QAi19evxWtQUcqtQtfPsvAKhgFEOWHHlf++gOiQ28fonhSTyh0NfQVs7FP3knSvG6ooFZ1y+dcUcTIMcffQ/E6hZOj3e0b/4tJjorRNF1HKE3XLp04/pd5/sH9V7GwG28Y6tdtUIIuqDmesoRnWTVfOvLib9MbD8dFOD+ABTb1xR5HxJjg436ZOWx/K+pTVJxGuMfXAW9Oo5mlW1Wn23YZjr+zO8PGIMDD07EKqsZ0JTmSvsA1E1Xn/LOPmcNbzVVYl9czGqbqBBuyWAuPWVgR2UwxW/a8WbvBiFZkmXgk43//rS4hdQz+cvCqKBuHstIKlEEb0zukQSgNEsoMqp/61RiGmEviRtUVgyhnmbPGT5KYoG3OBbyyb9wv1dzVc+sstCfsmLw58Zups7t+JTDXPQj6RKclun8LU4NueARsol42JDA1sVgHGTP/RyqiCaFcdUBEdtkcYuQWy6d/Ip1j7v5NjA/SacoObhCO6t
X-MS-Exchange-Transport-Forked: True
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1c61a1-f11a-4f72-4a2e-08d82fd7e03b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6408.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 13:45:50.1380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TrwJ8kBk5H/5q2v6YxKQAdDXxSqNLfGE4FoG53cJjYbxmjNU0CWGGdAqeDDlRd8WcRV1N08w1RnVrxUKMs7+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6407
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
> diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> index 5b87eee8ccc8b6..d03dacaef78805 100644
> --- a/drivers/infiniband/core/ucma.c
> +++ b/drivers/infiniband/core/ucma.c
> @@ -1084,6 +1084,8 @@ static ssize_t ucma_connect(struct ucma_file *file, const char __user *inbuf,
>  	size_t in_size;
>  	int ret;
>
> +	if (in_len < offsetofend(typeof(cmd), reserved))
> +		return -EINVAL;

This check wasn't before the patches citied in Fixes lines. This is why
I didn't add them while extended ucma_*.

>  	in_size = min_t(size_t, in_len, sizeof(cmd));
>  	if (copy_from_user(&cmd, inbuf, in_size))
>  		return -EFAULT;
> @@ -1141,6 +1143,8 @@ static ssize_t ucma_accept(struct ucma_file *file, const char __user *inbuf,
>  	size_t in_size;
>  	int ret;
>
> +	if (in_len < offsetofend(typeof(cmd), reserved))
> +		return -EINVAL;
>  	in_size = min_t(size_t, in_len, sizeof(cmd));
>  	if (copy_from_user(&cmd, inbuf, in_size))
>  		return -EFAULT;
> --
> 2.27.0
>
