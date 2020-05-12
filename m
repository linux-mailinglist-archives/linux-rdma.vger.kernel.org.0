Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47101CEA06
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 03:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgELBMo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 21:12:44 -0400
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:5429
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728115AbgELBMn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 21:12:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9p4KUmQD7OJYl/X5zXo6QCroJRS1LI2vKom4gq0kDlMKwj0kKuS1LHhXOtY0NixEaCtnOjQficLWbXNr22a0cfu7FYhVS2C3jp5vlt7d0tMba+jqm0/rcwGUgtY/XGUO6C5jCQ9jM++Vjj6x+y3O+6RiUnsaFGfni+x4QhbwH0q8nCCDw/E5CiJdaR6PYTocC8KbIyAtN8/2lsZ4nX6bELkZVSKGxA2wPQ+cYKcvZwyXyzpc4afmu4hpna4q2LZQxvxduYi/3Fomku30Qhb6BK0rsvW97ge+cREizjK0ZLHSVmdr8XG/5JIhel5uD/WzHL7FMQH1VyX/6AoOdwnbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91ONJgmbd0PEvhabhdUwSGqJMI3wICitjIGshI9VfYY=;
 b=g9MgXVnWXA5JfoJKzRCFpSNn6kgTBiOpsH/Bhiw5NL+9ZUmd0wLjjCYRwWfTn+L63P/rA9uDlCVEcDM3TD+W8Y3GfGy8cKFUrhszMmY+1nc1uUorf9tN7b681fO1cicSIQ8BjETY6LSr84wJO6iJX9hqrgcBzgzG9JvcFhiqiKaoU6QzTbe+F4h240RKYnlB+sdW4+7zqKv8NfTzPslt1AyZEokNxmLlfFwntbL8xd7GHwZLZVKfe4dY43JbzePlLwM7jykgSDpaBqA69VpLLV1Q3ddC2BzrWc4Xz5ezIf2Pe/PTckVIGJa7klhGyY4h3YhwIKe0HerfTojm93D/UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91ONJgmbd0PEvhabhdUwSGqJMI3wICitjIGshI9VfYY=;
 b=YgyqzWRE0+KhrtgCj0W+Qtzc/XVXHWzvDHbjQjyhGcPwA567NLFYPvPgZ8hxfUtJuISvp0rpkUfufw1kF8mPq0kRScuyOszpZ5mPShE8zbxJ0qx6BKrwMlPA6Ox9HKnDBs3S+RthFKFIXFa3P1j48lOvWYRkAiUWr0A3km5mNxg=
Received: from AM6PR05MB6263.eurprd05.prod.outlook.com (2603:10a6:20b:5::31)
 by AM6PR05MB5781.eurprd05.prod.outlook.com (2603:10a6:20b:95::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 01:12:39 +0000
Received: from AM6PR05MB6263.eurprd05.prod.outlook.com
 ([fe80::6dad:73a3:a3af:c829]) by AM6PR05MB6263.eurprd05.prod.outlook.com
 ([fe80::6dad:73a3:a3af:c829%6]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 01:12:38 +0000
From:   Yanjun Zhu <yanjunz@mellanox.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] RDMA/rxe: Return -EFAULT if copy_from_user() fails
Thread-Topic: [PATCH] RDMA/rxe: Return -EFAULT if copy_from_user() fails
Thread-Index: AQHWJ8NJYVVyKN0IEUq6MA/gyfBb3qijpRUQ
Date:   Tue, 12 May 2020 01:12:38 +0000
Message-ID: <AM6PR05MB6263ECA5663A63A9CC825145D8BE0@AM6PR05MB6263.eurprd05.prod.outlook.com>
References: <20200511183742.GB225608@mwanda>
In-Reply-To: <20200511183742.GB225608@mwanda>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=mellanox.com;
x-originating-ip: [118.201.220.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 36d04bac-2001-430c-3d4e-08d7f6119008
x-ms-traffictypediagnostic: AM6PR05MB5781:
x-microsoft-antispam-prvs: <AM6PR05MB57814C3DB95802F4075A6292D8BE0@AM6PR05MB5781.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:519;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O0c3ZRYM4sQblCI/mistx1VEsjllQ1nGMXhAVkpk8FCLz9MaMcw2NwC2un5NG52Ldh+fpx67actdyrYBrlYTZSfHlIQ6AqkOaUm5BY1jfsQrDB4KHZ2TwtCCTYc9YHwTfYY2rUPbrBxeULr929eb1xQwLLcEZVI57UCZQb/iJClkPu+rX4cAol/zdHcRppS/74IgDsBrAypP8zFgOVQa4yfDg0cV749CHJKKW1sXIHeOV18oBU4K3jdisw6AqYd9d/BwEZI2kGUx3/fTRrACveujkj/eiezsqB6h8lxrSDlcFzcnvFe5DIfe3Xd2Gqa6sIWHGPo6FXs/kV9wHFWMC6wOfXzbM45ffD/Wea/sTOHpH5oJQYBl/694v39d2sZux0bdLMCW/avMXdhmQfB1O9N/3WGtvcHRqsbd34Kyi/eT/1ZlEXGdEhDCCuASytjfdRQ0DiAnKphjUG+3k+qhU9UqsHEQKFScyZvObCGzMiZpnrgXVuvdFPgso8SZGuPOvFVNw2ybFNh1mNVA5SukPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6263.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(33430700001)(186003)(6506007)(316002)(9686003)(66556008)(33656002)(478600001)(55016002)(2906002)(33440700001)(64756008)(66446008)(52536014)(110136005)(66476007)(26005)(8936002)(4326008)(86362001)(8676002)(53546011)(71200400001)(66946007)(54906003)(76116006)(7696005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: OuKpJTtOzqH4nfAwZ6VxtG7U6Y2c1WQEkcLLa34hDvzXQoFtDHft23NwNj/t7gXw5cSJdbwAT8KnUkc1/RI0YeGlcWzIBtBZUJrCXgyntElIzw8ZBZ9aLFUN06Ff2VQ78q9JoXL4kEBE0D6tjZPuEbMft02EEGErN7lu+ytrQVYIMgEG8f4eXG82QfyfbGpgRuWPjBsuB23r9XYc43k+SdZ1lakNhssQhMIDV0j/BdjNQZtoIB9G1BxJOWuPsGyKwuvfPavhYkqy8Y/oT0T/NtmA4MJu55lPaOOnvsbNUBrbrrhd9fl3zD+rl4YUCQ++GpZySHfZqqcf55AKVXN9I9sILqIMtzzJsF/fLQMXMtZBqjUc7MwGFtQjaXPnCM1W9iZEthvDZ9UECYug9KUY1w/q3gtM9W44pOdI8+FBIubX1VlGwLRc5wgTZLl4sSABxuRRxd8bgKCaHxGQv3/I4OYEO1g+GM922SI96+MLhIyK1Gn4rQd34ir3JM2p5yAV
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d04bac-2001-430c-3d4e-08d7f6119008
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 01:12:38.6221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Skx18CmWCFiQNvOgysSOqcL5gxeQS0NUeC7+iqjp8CPdZZXKJC21g5MxwN4sMB0CsUgoqOY72YE1F00u6YsS8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5781
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Does this "err =3D -EFAULT;" make any sense in your commit?

Zhu Yanjun

-----Original Message-----
From: Dan Carpenter <dan.carpenter@oracle.com>=20
Sent: Tuesday, May 12, 2020 2:38 AM
To: Yanjun Zhu <yanjunz@mellanox.com>; Sudip Mukherjee <sudipm.mukherjee@gm=
ail.com>
Cc: Doug Ledford <dledford@redhat.com>; Jason Gunthorpe <jgg@ziepe.ca>; lin=
ux-rdma@vger.kernel.org; kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/rxe: Return -EFAULT if copy_from_user() fails

This function used to always return -EINVAL but we updated it to try preser=
ve the error codes.  Unfortunately the copy_to_user() is returning the numb=
er of bytes remaining to be copied instead of a negative error code.

Fixes: a3a974b4654d ("RDMA/rxe: Always return ERR_PTR from rxe_create_mmap_=
info()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/sw/rxe/rxe_queue.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/=
rxe/rxe_queue.c
index fef2ab5112de5..245040c3a35d0 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.c
+++ b/drivers/infiniband/sw/rxe/rxe_queue.c
@@ -50,9 +50,10 @@ int do_mmap_info(struct rxe_dev *rxe, struct mminfo __us=
er *outbuf,
 			goto err1;
 		}
=20
-		err =3D copy_to_user(outbuf, &ip->info, sizeof(ip->info));
-		if (err)
+		if (copy_to_user(outbuf, &ip->info, sizeof(ip->info))) {
+			err =3D -EFAULT;
 			goto err2;
+		}
=20
 		spin_lock_bh(&rxe->pending_lock);
 		list_add(&ip->pending_mmaps, &rxe->pending_mmaps);
--
2.26.2

