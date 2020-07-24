Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7CC22CEAF
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jul 2020 21:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgGXTdH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 15:33:07 -0400
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:23044
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbgGXTdH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Jul 2020 15:33:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ob2i/LkFy5VSGDXewTQMT4jjcG1sBeayrziZZWxKmZ/t+Dh7nafaOQgmx8P1v6Q73f1SNET4Unjq2o6Wf0K2i9db0F2yLoUPIvvyZzVaGRhxlHiZsjjg8qNi5jKSqsQOH4h7pMwcPzXgLxzzTok2Ew56efDwrJ3pmqLjbBxGcECYzKccpnlWw37dP1WBIfjOhNssSDIge1/d47LDycEI9PNKnfl8VhsU7a7Qv5OPbNlS2XI6abpH0sLiVki6i8L5FPY6EcNaRx8NGP3g4YjrybtWq5Pr0IKKrDsiR+6gwa5ljP1HRMa2Ix0wqp8k3em6ZP7bLhtEQtQbBH/QtbVaKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgyYEJ5wgoWL20AB36js111nY3vJXc+0tkXQnAnDHwA=;
 b=AiKO6lHxQVhHbSNa3oZJcusSuP7yMVD3IbacErh+2oIa4hl0WEgzl3Y5+k0UNnjRL1CsN3owL1Yq3bMqpqlypHLtYLfsJW7ppqZwAaJGEmn+4+ntvzNiW7OFTGq1Q4toe8jEFsB3ceLHvKu2pEgmYAzb0mVlRIz2s3jIsknaJ7QqyPJ09yadNWQVuoiyqfIhsQneCfivxBAEOjlGz7r17pdDe2826nERFLqCPJAFR6zdSVr093is8MiEZsMzbQztBPmLc25oEzp0r04sQhnjcqH8ZIQ3S/hRmaHAr1fIMTNXK159VyA8Z/fg/SDrqJO4tvC8IcoYuvNw0fNqVxhpCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgyYEJ5wgoWL20AB36js111nY3vJXc+0tkXQnAnDHwA=;
 b=DMwxPSEulCcRg39CZ8s+ITUApzImhh1NAiFpWK+x8CjogvZt8sOI92pevtMn3S0wuAFX3fuJXE2jBYQJ3bKtJZw8moPdCIqNQ9AQQQUVxmjpY/JeW383Ucb4eFZ+9eCpOoX2jP0xlAoSsUVSd17byCHph27tttlmrwMw0O4lc0k=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM7PR05MB6899.eurprd05.prod.outlook.com (2603:10a6:20b:1aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Fri, 24 Jul
 2020 19:33:04 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::15f4:b130:d907:ce72]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::15f4:b130:d907:ce72%6]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 19:33:04 +0000
Date:   Fri, 24 Jul 2020 22:33:02 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org,
        syzbot+086ab5ca9eafd2379aa6@syzkaller.appspotmail.com,
        syzbot+7446526858b83c8828b2@syzkaller.appspotmail.com
Subject: Re: [PATCH] RDMA/cm: Add min length checks to user structure copies
Message-ID: <20200724193302.GB64071@unreal>
References: <0-v1-d5b86dab17dc+28c25-ucma_syz_min_jgg@nvidia.com>
 <20200724134545.GB5479@unreal>
 <20200724135244.GK2021234@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724135244.GK2021234@nvidia.com>
X-ClientProxiedBy: AM3PR04CA0149.eurprd04.prod.outlook.com (2603:10a6:207::33)
 To AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (213.57.247.131) by AM3PR04CA0149.eurprd04.prod.outlook.com (2603:10a6:207::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend Transport; Fri, 24 Jul 2020 19:33:04 +0000
X-Originating-IP: [213.57.247.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f274a4f-840e-40bd-27aa-08d83008626f
X-MS-TrafficTypeDiagnostic: AM7PR05MB6899:
X-LD-Processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
X-Microsoft-Antispam-PRVS: <AM7PR05MB6899AEBCA1808A79AD69A344B0770@AM7PR05MB6899.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uWWwvA1qhlFmtLEHXW4dcLAjLupjM1/QIyoMaq4odQAKgMVHp45/cGHd3pUgZ6zKPR0FOP+6KG70WOtXSW/8cNOQSENLDYYNuhfgoi4j5f5KBivyDfDKx2vm5fllIEtzGtLXmXokUN0+i5CGNb9APUtoaqgXg4drEpdWevx7NVBagso4hPGtGvXBDBgcU1o9ricdYS1zQepMIZXpeh5iRFLSBpAOMcgKi3YsGd47BaRawPrU6azp4XXRAILr51KhQWZFkKELElVDmeWKKtvlxQpGus2JixyZCHK8ttXmtzncPGD+iQVhOOz0hZSUp87/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6408.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(83380400001)(2906002)(956004)(9686003)(5660300002)(6916009)(33716001)(6486002)(86362001)(4326008)(186003)(16526019)(66946007)(66556008)(66476007)(6496006)(52116002)(26005)(8676002)(8936002)(33656002)(316002)(478600001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: n5QYB3KPZz8eZK6bpXy5J7EOuiu8rcAlXh5jxxcPTa8u99XytGfvjvyDv+jobAfySrUxfLQjVBym0Yvzkz1n3Wxs8ZHLCdqYkV7K8JMt3dsZJU+I2SQbiNlkB86Td+nhbt3PgUUpCM8MTmmIOEll4VRfFwexzXCaaDgE9sJp7mzKdsuJNo+cLeQC98kUsWXah1UU0xnAO8baOoLzMkBMu0s5UeJqJA35HkolC+n6F8wTElRFZMUAQEVBzvFIAbKmTlLDoleZR8HoXbDXidMfCvbbfgQkP+5y47/WV2FdaHpi1OO2b9pxbCYIFblvleVlattqCP3tn6YuRtVnajBcQSbSFNtsEY4bZ76gjhB2EJ7YApekVWt4v7gPm164MiT7dmHQNYl9TaW5GQ0lP3txX+R/w5v6UJ9eM0yp/1yMjAOM4ctWv8bjEhpKhw2D6cZXh7sDKXaWhJLySePqxjM4Bwg+vCfmVTs2XksyD//eACu2E0IkD6T0XTbP+e2v9T+c
X-MS-Exchange-Transport-Forked: True
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f274a4f-840e-40bd-27aa-08d83008626f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6408.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 19:33:04.3477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7/X5LV6coZoRR839IKlF02pLrabTBcueGdZ/Q8kHWYV9sHlbxjyp+TNWTKSSavsbCjTIthTbFSbA935BvIeyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR05MB6899
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 24, 2020 at 10:52:44AM -0300, Jason Gunthorpe wrote:
> On Fri, Jul 24, 2020 at 04:45:45PM +0300, Leon Romanovsky wrote:
> > On Fri, Jul 24, 2020 at 10:19:29AM -0300, Jason Gunthorpe wrote:
> > > These are missing throughout ucma, it harmlessly copies garbage from
> > > userspace, but in this new code which uses min to compute the copy length
> > > it can result in uninitialized stack memory. Check for minimum length at
> > > the very start.
> > >
> > >   BUG: KMSAN: uninit-value in ucma_connect+0x2aa/0xab0 drivers/infiniband/core/ucma.c:1091
> > >   CPU: 0 PID: 8457 Comm: syz-executor069 Not tainted 5.8.0-rc5-syzkaller #0
> > >   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > >   Call Trace:
> > >    __dump_stack lib/dump_stack.c:77 [inline]
> > >    dump_stack+0x1df/0x240 lib/dump_stack.c:118
> > >    kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
> > >    __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
> > >    ucma_connect+0x2aa/0xab0 drivers/infiniband/core/ucma.c:1091
> > >    ucma_write+0x5c5/0x630 drivers/infiniband/core/ucma.c:1764
> > >    do_loop_readv_writev fs/read_write.c:737 [inline]
> > >    do_iter_write+0x710/0xdc0 fs/read_write.c:1020
> > >    vfs_writev fs/read_write.c:1091 [inline]
> > >    do_writev+0x42d/0x8f0 fs/read_write.c:1134
> > >    __do_sys_writev fs/read_write.c:1207 [inline]
> > >    __se_sys_writev+0x9b/0xb0 fs/read_write.c:1204
> > >    __x64_sys_writev+0x4a/0x70 fs/read_write.c:1204
> > >    do_syscall_64+0xb0/0x150 arch/x86/entry/common.c:386
> > >    entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >
> > > Fixes: 34e2ab57a911 ("RDMA/ucma: Extend ucma_connect to receive ECE parameters")
> > > Fixes: 0cb15372a615 ("RDMA/cma: Connect ECE to rdma_accept")
> > > Reported-by: syzbot+086ab5ca9eafd2379aa6@syzkaller.appspotmail.com
> > > Reported-by: syzbot+7446526858b83c8828b2@syzkaller.appspotmail.com
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > >  drivers/infiniband/core/ucma.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> > > index 5b87eee8ccc8b6..d03dacaef78805 100644
> > > +++ b/drivers/infiniband/core/ucma.c
> > > @@ -1084,6 +1084,8 @@ static ssize_t ucma_connect(struct ucma_file *file, const char __user *inbuf,
> > >  	size_t in_size;
> > >  	int ret;
> > >
> > > +	if (in_len < offsetofend(typeof(cmd), reserved))
> > > +		return -EINVAL;
> >
> > This check wasn't before the patches citied in Fixes lines. This is why
> > I didn't add them while extended ucma_*.
>
> It wasn't a bug before.
>
> > >  	in_size = min_t(size_t, in_len, sizeof(cmd));
> > >  	if (copy_from_user(&cmd, inbuf, in_size))
> > >  		return -EFAULT;
>
> Because this used to be:
>
>        if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
>
> Which always completely filled the stack memory.

I see, thanks.

>
> Jason
