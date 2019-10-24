Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A26E1E4067
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Oct 2019 01:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbfJXXtS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 19:49:18 -0400
Received: from mail-eopbgr00053.outbound.protection.outlook.com ([40.107.0.53]:10962
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730783AbfJXXtS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Oct 2019 19:49:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewvpJtr/gjrO2I5EgLCxpcDMZASwkyR5yZcmAhlo/80G94RX8+I3zDCEL2mlKoGddHufPNOID4RxKAb4fj81XpyHnhbw449fxP3iFpKnXSXIEpfPnHHeGOW0C3AdU0NtLHrtg412FO+SzQM7/HklFvwhZhwR8dC0kLhDurXO0d01lxKJVEP/67LlSFxDnWZHHiihJDhQF0cI0cxi+Dgtf4Fg5Hg2h5DTmUZ7Ue+gGpl41AaEFAzHBnKwdHLHFTf98FXVmQPUxX+BWRjx7EYShSqEkRWvW1KkB4APZbMQwDIgAltq5bV6XuoYKLT8sBnae6P4OsfxZHc0GgCFiwZmYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UA9rkPsJjcMVKzm5zLal9u7YwwvQ3gR5XBwq/UIywmQ=;
 b=Ss6sElOrvR0iY3VnTFXtYEaqfmPZDxHIZwmlVuIvjkRCJOzko5/ArHImqGiKmNqulgQuUlfhqxuHrur757RH2W4eSS8337gQ/07MD4jB0P3zOjzzlOjBbQ1oaWHBDT3mitqv8zgqNESyFnlyEmZqrRcu32IG0WyIPFncRdXaH0rAlMJeL+8bpL+/NTuzF2rHLkS3KqXgnxpnHhbfueZlaZVW6cTmm9Guzpom4dXF+dv7d6L7Iy5jYPT7oZRtajaNoMHw+fid5Q8NuLdMPuGX6+WJHOoctQi/iTcMiHiqgAW8ymGa8GY7D7+gwrv2FEEM0l8MKebLqJq87nPnu6HUJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UA9rkPsJjcMVKzm5zLal9u7YwwvQ3gR5XBwq/UIywmQ=;
 b=skXXPrLLJ0QmTs3yo3W+kcS55oGo51+879kwxL8ToVmEDaTOg5J8yN8AWW9oX4f0f0sZDhWmaDhtiezobWZsS9aAenrQ5RBMswrCLrOdutOARRiVnmx36LHDUggdhs2CzXCjkcQSYB3UMSbiVIxGzlpYJ5RBrNLS5k3gen+Yoyw=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4382.eurprd05.prod.outlook.com (52.134.31.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Thu, 24 Oct 2019 23:49:14 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0%7]) with mapi id 15.20.2367.027; Thu, 24 Oct 2019
 23:49:14 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH] RDMA/mlx5: Use irq xarray locking for mkey_table
Thread-Topic: [PATCH] RDMA/mlx5: Use irq xarray locking for mkey_table
Thread-Index: AQHVisWjPuXKtKD79UKwaBBBljL4iA==
Date:   Thu, 24 Oct 2019 23:49:13 +0000
Message-ID: <20191024234910.GA9038@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:208:e8::26) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b23037d5-2c61-4de7-d271-08d758dcc63a
x-ms-traffictypediagnostic: VI1PR05MB4382:|VI1PR05MB4382:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB43823CB3EBA36959836DD016CF6A0@VI1PR05MB4382.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:398;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(199004)(189003)(6916009)(99286004)(2501003)(6116002)(3846002)(107886003)(256004)(14444005)(66066001)(8936002)(81166006)(81156014)(316002)(7736002)(186003)(102836004)(26005)(386003)(6506007)(8676002)(52116002)(66556008)(9686003)(6512007)(5640700003)(71200400001)(71190400001)(33656002)(486006)(476003)(305945005)(66446008)(66476007)(64756008)(86362001)(1076003)(4326008)(36756003)(6486002)(25786009)(478600001)(2906002)(2351001)(6436002)(66946007)(14454004)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4382;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WyLsVHwehBYSbj6Iw2fyUxT7qJB52KZjvG0f2056WZEZR2G/oGvVp7066jeN4sfdccP+rzS4FORVQPfk0uGvllM9ejWijCktM0gwjiyncXI3ndD23s+gAsD9bc+fCLu63cLsZRqMvlaVDRL5G6/hQWJDAeRf2Zt7pieWSfeuoLeoX6bG9qnOc+C6tlz6AZeSeahxf9USwxmtoMpFigQlADS2+2izmhyzW22UqMIJ6OdATWmA99wCwegefvQOEVcK7FJagQF7SYDqbuyj56rxudkisR/ST7BqR/hBjCkZm+uiTryzxh6RULj6MmwG0MXYfDBQ5AmiyNpFXvqD1Rc9hpNCrwmdvCQMgQaxvzj6xmwI6imythO6s0OlXYVwJ2rOiO5gticMfb1VLgffph9Jes4U8CrROmWs5IP/3U4H8rHOoe1YYiRt0M73IcOc4AaY
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CA8AC5CE02220E48AC7025DEA531731A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23037d5-2c61-4de7-d271-08d758dcc63a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 23:49:13.8857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KNmHW7xbiaT9BemB4Cn2ZxwIE+nXe/juxbQ37ka/xQQ7xsW+kkrSVB0JTUJLdnXlLFnMfvGJ4qCafqiL7cHK0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4382
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The mkey_table xarray is touched by the reg_mr_callback() function which
is called from a hard irq. Thus all other uses of xa_lock must use the
_irq variants.

  WARNING: inconsistent lock state
  5.4.0-rc1 #12 Not tainted
  --------------------------------
  inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
  python3/343 [HC0[0]:SC0[0]:HE1:SE1] takes:
  ffff888182be1d40 (&(&xa->xa_lock)->rlock#3){?.-.}, at: xa_erase+0x12/0x30
  {IN-HARDIRQ-W} state was registered at:
    lock_acquire+0xe1/0x200
    _raw_spin_lock_irqsave+0x35/0x50
    reg_mr_callback+0x2dd/0x450 [mlx5_ib]
    mlx5_cmd_exec_cb_handler+0x2c/0x70 [mlx5_core]
    mlx5_cmd_comp_handler+0x355/0x840 [mlx5_core]
   [..]

   Possible unsafe locking scenario:

         CPU0
         ----
    lock(&(&xa->xa_lock)->rlock#3);
    <Interrupt>
      lock(&(&xa->xa_lock)->rlock#3);

   *** DEADLOCK ***

  2 locks held by python3/343:
   #0: ffff88818eb4bd38 (&uverbs_dev->disassociate_srcu){....}, at: ib_uver=
bs_ioctl+0xe5/0x1e0 [ib_uverbs]
   #1: ffff888176c76d38 (&file->hw_destroy_rwsem){++++}, at: uobj_destroy+0=
x2d/0x90 [ib_uverbs]

  stack backtrace:
  CPU: 3 PID: 343 Comm: python3 Not tainted 5.4.0-rc1 #12
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.1-0-ga5=
cab58e9a3f-prebuilt.qemu.org 04/01/2014
  Call Trace:
   dump_stack+0x86/0xca
   print_usage_bug.cold.50+0x2e5/0x355
   mark_lock+0x871/0xb50
   ? match_held_lock+0x20/0x250
   ? check_usage_forwards+0x240/0x240
   __lock_acquire+0x7de/0x23a0
   ? __kasan_check_read+0x11/0x20
   ? mark_lock+0xae/0xb50
   ? mark_held_locks+0xb0/0xb0
   ? find_held_lock+0xca/0xf0
   lock_acquire+0xe1/0x200
   ? xa_erase+0x12/0x30
   _raw_spin_lock+0x2a/0x40
   ? xa_erase+0x12/0x30
   xa_erase+0x12/0x30
   mlx5_ib_dealloc_mw+0x55/0xa0 [mlx5_ib]
   uverbs_dealloc_mw+0x3c/0x70 [ib_uverbs]
   uverbs_free_mw+0x1a/0x20 [ib_uverbs]
   destroy_hw_idr_uobject+0x49/0xa0 [ib_uverbs]
   [..]

Fixes: 0417791536ae ("RDMA/mlx5: Add missing synchronize_srcu() for MW case=
s")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/m=
r.c
index 630599311586ec..7019c12005f4c1 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1967,8 +1967,8 @@ int mlx5_ib_dealloc_mw(struct ib_mw *mw)
 	int err;
=20
 	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
-		xa_erase(&dev->mdev->priv.mkey_table,
-			 mlx5_base_mkey(mmw->mmkey.key));
+		xa_erase_irq(&dev->mdev->priv.mkey_table,
+			     mlx5_base_mkey(mmw->mmkey.key));
 		/*
 		 * pagefault_single_data_segment() may be accessing mmw under
 		 * SRCU if the user bound an ODP MR to this MW.
--=20
2.23.0

