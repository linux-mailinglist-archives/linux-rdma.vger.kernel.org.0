Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44B281E7C8
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 07:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbfEOFDj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 01:03:39 -0400
Received: from mail-eopbgr30045.outbound.protection.outlook.com ([40.107.3.45]:25574
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725933AbfEOFDi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 May 2019 01:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqOv5jNRa1UMiYUc/LXhcMNbOJ+Q0B4YqG9x4oj4cpU=;
 b=hBZdGePHEEzhnyxvZGNq9ypZKgNHcGl0mBhOwk74vFt06PmpfIhNCY/Zn3bIY2ixafWcnkIv3M5ZISShW/gnzvmWVhaauLsUmDoaPtv/8usyEIQYFyXH84x4qvVG9w9ruRINv2bcd7mdJzTJpjSrwfuwlDLqA4iStevgbL9P5pw=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.186.14) by
 AM4PR05MB3330.eurprd05.prod.outlook.com (10.171.191.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 05:03:33 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::74f5:6663:e5fa:3d6a]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::74f5:6663:e5fa:3d6a%5]) with mapi id 15.20.1878.024; Wed, 15 May 2019
 05:03:33 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Nathan Chancellor <natechancellor@gmail.com>,
        "fengguang.wu@intel.com" <fengguang.wu@intel.com>,
        "kbuild@01.org" <kbuild@01.org>,
        Ariel Levkovich <lariel@mellanox.com>,
        Eli Cohen <eli@mellanox.com>, Mark Bloch <markb@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: undefined reference to `__aeabi_uldivmod' after 25c13324d03d
 ("IB/mlx5: Add steering SW ICM device memory type")
Thread-Topic: undefined reference to `__aeabi_uldivmod' after 25c13324d03d
 ("IB/mlx5: Add steering SW ICM device memory type")
Thread-Index: AQHVCo2O9TJIO+iNpUCG510W44rIF6ZrVh8AgABL2oA=
Date:   Wed, 15 May 2019 05:03:33 +0000
Message-ID: <20190515050331.GC5225@mtr-leonro.mtl.com>
References: <20190514194510.GA15465@archlinux-i9>
 <20190515003202.GA14522@ziepe.ca>
In-Reply-To: <20190515003202.GA14522@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0402CA0020.eurprd04.prod.outlook.com
 (2603:10a6:209::33) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:3::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [37.142.3.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 584dad70-3f43-43ef-8af0-08d6d8f2ae0f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM4PR05MB3330;
x-ms-traffictypediagnostic: AM4PR05MB3330:
x-microsoft-antispam-prvs: <AM4PR05MB33303D8580AB40538286C44DB0090@AM4PR05MB3330.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(376002)(366004)(53754006)(199004)(189003)(486006)(476003)(71190400001)(71200400001)(25786009)(11346002)(68736007)(316002)(446003)(4326008)(6246003)(256004)(53936002)(5660300002)(2906002)(6916009)(186003)(14444005)(26005)(86362001)(6116002)(3846002)(1076003)(64756008)(66476007)(102836004)(66446008)(66946007)(73956011)(386003)(6506007)(52116002)(14454004)(99286004)(66066001)(54906003)(305945005)(6436002)(6512007)(9686003)(508600001)(6486002)(76176011)(8936002)(81166006)(81156014)(229853002)(33656002)(7736002)(66556008)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3330;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CDIqezZwABcksyJS952/ceN07/N25DH5MJX/91ynfHyqHTeK2ayUJFMbxlfLsXguBPb4kcEZbirCy8xdvuYBKj4nvqcaznhW4UITC4IglrtO0d7UzaC/ARua4qJwa4Gginn7Qge56n8bsSicrJKCgdNDbAEwF6efg00gMqffJEiYpWGdNF3HGRC36Ng+KsDhN/AGwGMVWkVnRBYAq9flEnLXYKIykWogF1ayIVOaT4MqvgmK9jDlJk8VqnEvGWUvbrNzj/jBatSSM73YCkcTJjdUS5hgcNeCo1YL4nc3HyQ7x3j7RYa5nMV0ZcPCdBAVBtawJjEPue/+9LvQAr3NpPpyjCGbM/GEjut9W6pt47H7QuuuwIyfQ8vrzrjz4vtJcLFHXskbuqEXYFzYVE5K8pJMgObV9AqSFWKSBZvNasY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A61103C5E14CC1499F108762A7D8805C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584dad70-3f43-43ef-8af0-08d6d8f2ae0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 05:03:33.7840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3330
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 14, 2019 at 09:32:02PM -0300, Jason Gunthorpe wrote:
> On Tue, May 14, 2019 at 12:45:10PM -0700, Nathan Chancellor wrote:
> > Hi all,
> >
> > I checked the RDMA mailing list and trees and I haven't seen this
> > reported/fixed yet (forgive me if it has) but when building for arm32
> > with multi_v7_defconfig and the following configs (distilled from
> > allyesconfig):
> >
> > CONFIG_INFINIBAND=3Dy
> > CONFIG_INFINIBAND_ON_DEMAND_PAGING=3Dy
> > CONFIG_INFINIBAND_USER_ACCESS=3Dy
> > CONFIG_MLX5_CORE=3Dy
> > CONFIG_MLX5_INFINIBAND=3Dy
> >
> > The following link time errors occur:
> >
> > arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/main.o: in function `m=
lx5_ib_alloc_dm':
> > main.c:(.text+0x60c): undefined reference to `__aeabi_uldivmod'
> > arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/cmd.o: in function `ml=
x5_cmd_alloc_sw_icm':
> > cmd.c:(.text+0x6d4): undefined reference to `__aeabi_uldivmod'
> > arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/cmd.o: in function `ml=
x5_cmd_dealloc_sw_icm':
> > cmd.c:(.text+0x9ec): undefined reference to `__aeabi_uldivmod'
>
> Fengguang, I'm surprised that 0-day didn't report this earlier..

I got many successful emails after I pushed this patch to 0-day testing.

>
> and come to think of it, I haven't seen a success email from 0-day for
> the rdma trees in some time - is it still working?
>
> Thanks,
> Jason
