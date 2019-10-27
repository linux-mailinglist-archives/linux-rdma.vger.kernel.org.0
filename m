Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4AD2E61AF
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 09:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfJ0Ii7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 04:38:59 -0400
Received: from mail-eopbgr00052.outbound.protection.outlook.com ([40.107.0.52]:56295
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfJ0Ii7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 04:38:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7bQEX3VCzYR68UoYLkOuBUcRu3FNbEJLyeqDuax7LgcQe/0Gb1sBwlhrKXHQ6kWRkGAU6Wz7UpnHKPHd0d3BKMoqhC3x5v+u9L3GnLSdLrxov6Io++Zbp1DqIdTA7AoIPUjpEYQkUcn0y04Bt77JL8GejxP/1Ol51OxCb3rUiY8QfwR4J5ErwyF2izCXbmgCeBqrIQ6Spy7DOM7aF6q1sgnmqj/kO9FXDaV6yMzs9LVnRa7F+IcdYJH16Kuw/vjR91cUlXt81iCYgNmktXWoXTwXGHmX8358nRLorFezdCufP22O2LFjMlUPTtuxBvXLDhvIHHlwzDo+GYvO/KVaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntdwMOH3zvYKS0QMvWEkHwN9fRe+zMrjzfXn/X/DRbA=;
 b=kG7IZ7oLVvj9LSErNqnuvtSspM7e80HYH0y7yW8vg8g8Q+m3vRp/3qAs7TvhowL+pnPqpZ6nzEX6Oj9sn35NGZf61Ct8kZrhjx1BxrWcTdbvn0icSFRuRRBeM7BP+atIkVzlzWYWwB9MbzQ22i90W0VahiMZa0UUlZT6WGwG61kiUMvBbI7U3YWKh6i5sAufwUWaDRSIzyek6T2opWdVOSjJxodOCjOkRA84NAe7NrkxqGopF2Zc4bGylx4XHYW4ZW4V2apG75rbHnKOKdT6HTLGK6YyCTJeoCWzJijqBTypp0o3rxgRAnkvuElR6+gqNBH09Zk7XIkrVlupUVsrkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntdwMOH3zvYKS0QMvWEkHwN9fRe+zMrjzfXn/X/DRbA=;
 b=EQQXzGvoEJTmFRFCbucxc8ht4zgS2BTCjliwhcajIvDPB90+/TiU7+jwvzJvGP5Eykouvpf7vqEIG00BSyoiV5UuraLrUN8aY8vzamvnfYHiDjIRXB4tCoEsAc2HY2CD0/bD9e2NN3oAp7QTuVSZ0TiX/oY+xWeHkHRjisDa/H8=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3395.eurprd05.prod.outlook.com (10.171.188.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Sun, 27 Oct 2019 08:38:56 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::dde1:60df:efba:b3df]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::dde1:60df:efba:b3df%7]) with mapi id 15.20.2387.025; Sun, 27 Oct 2019
 08:38:56 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/mlx5: Use irq xarray locking for mkey_table
Thread-Topic: [PATCH] RDMA/mlx5: Use irq xarray locking for mkey_table
Thread-Index: AQHVisWjPuXKtKD79UKwaBBBljL4iKduLmGA
Date:   Sun, 27 Oct 2019 08:38:55 +0000
Message-ID: <20191027083853.GY4853@unreal>
References: <20191024234910.GA9038@ziepe.ca>
In-Reply-To: <20191024234910.GA9038@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0102CA0038.eurprd01.prod.exchangelabs.com
 (2603:10a6:208::15) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.137.89.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b019374-192f-41f6-e9f7-08d75ab91a98
x-ms-traffictypediagnostic: AM4PR05MB3395:|AM4PR05MB3395:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR05MB3395A578946D418F9A33C060B0670@AM4PR05MB3395.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:133;
x-forefront-prvs: 0203C93D51
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(396003)(346002)(39850400004)(136003)(366004)(189003)(199004)(6636002)(478600001)(6506007)(229853002)(86362001)(8936002)(316002)(1076003)(305945005)(6862004)(7736002)(11346002)(486006)(6246003)(446003)(186003)(5660300002)(33656002)(81166006)(81156014)(8676002)(4326008)(476003)(386003)(25786009)(14444005)(6116002)(3846002)(256004)(71190400001)(2906002)(76176011)(33716001)(66946007)(64756008)(9686003)(14454004)(66476007)(6512007)(66556008)(66446008)(6486002)(6436002)(102836004)(99286004)(71200400001)(52116002)(66066001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3395;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Qlta7TtUO3EC2VXh5fcj8PRL6iNNx5v83ul9d1pcOdKcC4iaQ96r0r8yO69/ZJ3mI8lrtozDrTkf0DBwz3zzmQEMm8v97uCUE7a91EyIAlFylO2uIrEXyeFbsEpuc1wcSYfZpc6HfvqUYIOl2hyHYloutSi1g5FkJ46i0HmYvRfCmmLBRkB2pjJc3ScaG/dCUZm9bhdvfcklnSewiVabu1EB2fHzbsKzHkH4IJoGrdHmQuAtyLFrppPe+5VBzs5wNaeZhWpJqX30Z1qwMIaORpcGe4BmWxww+lMtJCMldFCHk1jwWSxD+X6l9nV+abhCmx9Jx162Zm8LivV4ds0iGnRPJK9qa6r0RNHMfFbm3oUTYWcQD9NVx4yYmN/t7ZfMeiSXZqaQJ2Y9zD+lb4Wl9p82wlARI7lm54Q/cyZbJfCDd+m6mdxCAgSUFYl51f7
Content-Type: text/plain; charset="us-ascii"
Content-ID: <49FDDA2931209049BBA3BB3E8E097585@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b019374-192f-41f6-e9f7-08d75ab91a98
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2019 08:38:55.8892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4u8mbyDIWDoLRaVoXcQJ/3VXEF1SDB2/XjD8mVmGdCIf7265Uur0BAgR1Ayx7jMG0lWRt3Jl8NHVLxa4Zfuq4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3395
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 25, 2019 at 02:49:13AM +0300, Jason Gunthorpe wrote:
> The mkey_table xarray is touched by the reg_mr_callback() function which
> is called from a hard irq. Thus all other uses of xa_lock must use the
> _irq variants.
>
>   WARNING: inconsistent lock state
>   5.4.0-rc1 #12 Not tainted
>   --------------------------------
>   inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
>   python3/343 [HC0[0]:SC0[0]:HE1:SE1] takes:
>   ffff888182be1d40 (&(&xa->xa_lock)->rlock#3){?.-.}, at: xa_erase+0x12/0x=
30
>   {IN-HARDIRQ-W} state was registered at:
>     lock_acquire+0xe1/0x200
>     _raw_spin_lock_irqsave+0x35/0x50
>     reg_mr_callback+0x2dd/0x450 [mlx5_ib]
>     mlx5_cmd_exec_cb_handler+0x2c/0x70 [mlx5_core]
>     mlx5_cmd_comp_handler+0x355/0x840 [mlx5_core]
>    [..]
>
>    Possible unsafe locking scenario:
>
>          CPU0
>          ----
>     lock(&(&xa->xa_lock)->rlock#3);
>     <Interrupt>
>       lock(&(&xa->xa_lock)->rlock#3);
>
>    *** DEADLOCK ***
>
>   2 locks held by python3/343:
>    #0: ffff88818eb4bd38 (&uverbs_dev->disassociate_srcu){....}, at: ib_uv=
erbs_ioctl+0xe5/0x1e0 [ib_uverbs]
>    #1: ffff888176c76d38 (&file->hw_destroy_rwsem){++++}, at: uobj_destroy=
+0x2d/0x90 [ib_uverbs]
>
>   stack backtrace:
>   CPU: 3 PID: 343 Comm: python3 Not tainted 5.4.0-rc1 #12
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.1-0-g=
a5cab58e9a3f-prebuilt.qemu.org 04/01/2014
>   Call Trace:
>    dump_stack+0x86/0xca
>    print_usage_bug.cold.50+0x2e5/0x355
>    mark_lock+0x871/0xb50
>    ? match_held_lock+0x20/0x250
>    ? check_usage_forwards+0x240/0x240
>    __lock_acquire+0x7de/0x23a0
>    ? __kasan_check_read+0x11/0x20
>    ? mark_lock+0xae/0xb50
>    ? mark_held_locks+0xb0/0xb0
>    ? find_held_lock+0xca/0xf0
>    lock_acquire+0xe1/0x200
>    ? xa_erase+0x12/0x30
>    _raw_spin_lock+0x2a/0x40
>    ? xa_erase+0x12/0x30
>    xa_erase+0x12/0x30
>    mlx5_ib_dealloc_mw+0x55/0xa0 [mlx5_ib]
>    uverbs_dealloc_mw+0x3c/0x70 [ib_uverbs]
>    uverbs_free_mw+0x1a/0x20 [ib_uverbs]
>    destroy_hw_idr_uobject+0x49/0xa0 [ib_uverbs]
>    [..]
>
> Fixes: 0417791536ae ("RDMA/mlx5: Add missing synchronize_srcu() for MW ca=
ses")
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/mr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Thanks,
Acked-by: Leon Romanovsky <leonro@mellanox.com>
