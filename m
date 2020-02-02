Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F16A114FC67
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Feb 2020 10:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgBBJd4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 2 Feb 2020 04:33:56 -0500
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:6184
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725947AbgBBJd4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 2 Feb 2020 04:33:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egATDZtkgA10lofeeay9EnQldcsQxftHhtihbp9fqXw76L4F7tXUoL8sOs0x7xUVAqQH0VWv/uc962g7shbj7Itasq019yebg8exb5gZjzkZkyOAkZB/5zt4ZQJGfmDEBNYKJ1ynC8LXFWX2u/yXQTL8roNYzUooqAzulLod9z3OEAOJYfd/7JYspus/eSsgsoC+81tXZoHRRUPc0+AS43LnvUzoUa7si1o29fsktjOcxPTe2nJqBF7e6bhBowttY0ZML8WCZsqAVvufaRQR6MtZtCKFVVfeV/WP9j9LdqDkO/NMNmuXW26hvcKGlh+Ni+XrpNlA+RtpGwpsn/kGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F18tSXsoPsIoL880B+fg5DK+V3A6YjVtJ1Bu06DIYkk=;
 b=m9nWBDWxDj8rupwtCI4QMhkYDeiHvofhLT3k5Uodl85AUzooOOxJmMgBYFLBIk73+k075Mv24I2AjUigu8CCMnlT+g+uIQtxOQaGAaweoYiXyAGnVxjYs4qyhDC2to1aN3/iqaGkqcV/YWEGncpy6JfBtltWrhTMUeIklgdviIqfB5brem1aDBcCfEJk8U/ykRZ5fJ1kuhUK+vsXkDa8w7XQvCzNuvSYnsyx9vdFBO6qfGMD0llh0bmnYLBU0fURn+KDRLz6zK3+qXJIyCOFKQ2zL8uVGrZuGtCz3zmVglvxD8xij7jNucvaWa96VA4eTi4JGYHU1DNQsS8e2maiKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F18tSXsoPsIoL880B+fg5DK+V3A6YjVtJ1Bu06DIYkk=;
 b=ooOeQfb1SVYM9O30BlIrG/A8HoOnTzNLwNEs7BPelpCyno6kpk9hqN87o1TcMdSiUldr0ts7y/WYpniIkb6HZVZ53D8eIe7zcdNOa7WKRW+64bNN/mtmjARbe5RA4+JhdVU7vU5LEByxT/Jk7GYIBXeP1qiV1LyNSBs1gJNf97A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (20.179.5.215) by
 AM6PR05MB5286.eurprd05.prod.outlook.com (20.177.197.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Sun, 2 Feb 2020 09:33:11 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::d1:c74b:50e8:adba]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::d1:c74b:50e8:adba%5]) with mapi id 15.20.2686.031; Sun, 2 Feb 2020
 09:33:11 +0000
Date:   Sun, 2 Feb 2020 11:33:08 +0200
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/core: Fix protection fault in
 get_pkey_idx_qp_list
Message-ID: <20200202093308.GJ414821@unreal>
References: <20200126171553.4916-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126171553.4916-1-leon@kernel.org>
X-ClientProxiedBy: AM0PR06CA0014.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::27) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
Received: from localhost (2001:67c:1810:f051:2098:733d:8080:f67e) by AM0PR06CA0014.eurprd06.prod.outlook.com (2603:10a6:208:ab::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.32 via Frontend Transport; Sun, 2 Feb 2020 09:33:10 +0000
X-Originating-IP: [2001:67c:1810:f051:2098:733d:8080:f67e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 20b4e502-93ae-45af-6b37-08d7a7c2eb3b
X-MS-TrafficTypeDiagnostic: AM6PR05MB5286:|AM6PR05MB5286:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB5286D7F3C035C4D09C0390ECB0010@AM6PR05MB5286.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0301360BF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(396003)(346002)(376002)(366004)(39850400004)(199004)(189003)(66946007)(66476007)(66556008)(86362001)(81166006)(81156014)(54906003)(110136005)(8936002)(16526019)(33716001)(5660300002)(6636002)(8676002)(186003)(9686003)(316002)(1076003)(6486002)(33656002)(6496006)(52116002)(2906002)(107886003)(478600001)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5286;H:AM6PR05MB6408.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ie4CRLlyL5xoThpuXo+50myu7q4khw8vLx49xGG6r4Qkex99lt7/sogVALKEBsxCHhztsAlOeTXXUSWwd4fMvQDuaY0j2vdkXZqbzdKvNJXMsAxy19OnC65eI0f1PAd8sjsfI+ZInbxYLhExVQGOTOAeBIKlkHmncSlcmLEfS7tkvMJoUZVJdvLX6icf955BZRU0jecZwLrsfterpJyAGvyL4c3n64xcpLgrch4Dw0gAN+XoH9mhSmxpirRfCoQNN5QBqyymKrmmj/loMy2ZS7ghVW6r9tf/VeZvNg8x359azUWTL5xQR65bHk1BmQVb0oQEwEhTwF63XnQOJ4s1DOom8GTXpY7fj55gP9c7Xe3rMhx8DQrVCCoqop3MvdTkS2PneXTCXI4+LlvwFyf3GdePMDJyQY7tEp4QsyBGlFY+BVVYZ/x6gMA9CL/wo0gk
X-MS-Exchange-AntiSpam-MessageData: ng628BoyxWsC9Rheh+/cnvrJ4X4/JxXMRzpnuBOaUWbGvwpbi9GwIlQI5V25WJQf/NehcJlyY+ittVz6xn1RdQ7/9tLh8GcO8w4Y7/Wlquu5FEJknUICcfvQXf8FxX/cM9Je4cH4yNIOLeK5IB/yK0xD2b2ySvESimfBRpDyGB95ISWD9+uKb5zm0uC/TCZOxK5OXI3KvzkoIcZJS5nAuQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b4e502-93ae-45af-6b37-08d7a7c2eb3b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2020 09:33:11.0007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPYYnuABEGnws0m+BVu7FbbHwgAnrh5iXsz3NdKmeXosDSjL9QUv5lgi5jRm0fDudEHaVgBkmeMvzn3/Zhod1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5286
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 26, 2020 at 07:15:53PM +0200, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
>
> We don't need to set pkey as valid in case that user set only one
> of pkey index or port number, otherwise it will be resulted in NULL
> pointer dereference while accessing to uninitialized pkey list.
>
> The following crash from syzkaller revealed it.
>
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN PTI
> CPU: 1 PID: 14753 Comm: syz-executor.2 Not tainted 5.5.0-rc5 #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> RIP: 0010:get_pkey_idx_qp_list+0x161/0x2d0
> Code: 01 00 00 49 8b 5e 20 4c 39 e3 0f 84 b9 00 00 00 e8 e4 42 6e fe 48
> 8d 7b 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04
> 02 84 c0 74 08 3c 01 0f 8e d0 00 00 00 48 8d 7d 04 48 b8
> RSP: 0018:ffffc9000bc6f950 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff82c8bdec
> RDX: 0000000000000002 RSI: ffffc900030a8000 RDI: 0000000000000010
> RBP: ffff888112c8ce80 R08: 0000000000000004 R09: fffff5200178df1f
> R10: 0000000000000001 R11: fffff5200178df1f R12: ffff888115dc4430
> R13: ffff888115da8498 R14: ffff888115dc4410 R15: ffff888115da8000
> FS:  00007f20777de700(0000) GS:ffff88811b100000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2f721000 CR3: 00000001173ca002 CR4: 0000000000360ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  port_pkey_list_insert+0xd7/0x7c0
>  ib_security_modify_qp+0x6fa/0xfc0
>  _ib_modify_qp+0x8c4/0xbf0
>  modify_qp+0x10da/0x16d0
>  ib_uverbs_modify_qp+0x9a/0x100
>  ib_uverbs_write+0xaa5/0xdf0
>  __vfs_write+0x7c/0x100
>  vfs_write+0x168/0x4a0
>  ksys_write+0xc8/0x200
>  do_syscall_64+0x9c/0x390
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Fixes: d291f1a652329 ("IB/core: Enforce PKey security on QPs")
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/security.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

As Maor explained below, the code is correct, so what is the resolution here?

Thanks
