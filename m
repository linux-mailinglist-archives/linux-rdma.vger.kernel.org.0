Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9A01E7CB
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 07:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfEOFEd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 01:04:33 -0400
Received: from mail-eopbgr20086.outbound.protection.outlook.com ([40.107.2.86]:14917
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725933AbfEOFEd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 May 2019 01:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPJ4RUQyuQjEg8s5xyhpT7kr9Q29J99AqZRzISnb/Ak=;
 b=eQQHQU7zLRn1EFuc58KUl/fibBD7d54TvS5Vhd0fnGCT88moR2pr+GJ/GQa4ddnftifzlpx0oiYWQ6ZIBN9ZSYxbUF4eEzuslYuQ9s9S7P98DQBFe7sSB3hhEgmTu5Ca8d/EUl6LtPeJJPU8cZNA/DhEXzuW8MpMMgeHDU+/jRw=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.186.14) by
 AM4PR05MB3330.eurprd05.prod.outlook.com (10.171.191.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 05:04:29 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::74f5:6663:e5fa:3d6a]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::74f5:6663:e5fa:3d6a%5]) with mapi id 15.20.1878.024; Wed, 15 May 2019
 05:04:29 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Nathan Chancellor <natechancellor@gmail.com>,
        Ariel Levkovich <lariel@mellanox.com>,
        Eli Cohen <eli@mellanox.com>, Mark Bloch <markb@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: undefined reference to `__aeabi_uldivmod' after 25c13324d03d
 ("IB/mlx5: Add steering SW ICM device memory type")
Thread-Topic: undefined reference to `__aeabi_uldivmod' after 25c13324d03d
 ("IB/mlx5: Add steering SW ICM device memory type")
Thread-Index: AQHVCo2O9TJIO+iNpUCG510W44rIF6ZrVqsAgABLkYA=
Date:   Wed, 15 May 2019 05:04:29 +0000
Message-ID: <20190515050427.GD5225@mtr-leonro.mtl.com>
References: <20190514194510.GA15465@archlinux-i9>
 <20190515003355.GB14522@ziepe.ca>
In-Reply-To: <20190515003355.GB14522@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR06CA0022.eurprd06.prod.outlook.com
 (2603:10a6:206:2::35) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:3::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [37.142.3.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 693f653f-3161-4745-9bb0-08d6d8f2cf39
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM4PR05MB3330;
x-ms-traffictypediagnostic: AM4PR05MB3330:
x-microsoft-antispam-prvs: <AM4PR05MB33303D1390A217B12AE7CF7EB0090@AM4PR05MB3330.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(376002)(366004)(199004)(189003)(486006)(476003)(71190400001)(71200400001)(25786009)(11346002)(68736007)(316002)(446003)(4326008)(6246003)(256004)(6862004)(53936002)(5660300002)(2906002)(6636002)(186003)(26005)(4744005)(86362001)(6116002)(3846002)(1076003)(64756008)(66476007)(102836004)(66446008)(66946007)(73956011)(386003)(6506007)(52116002)(14454004)(99286004)(66066001)(54906003)(305945005)(6436002)(6512007)(9686003)(508600001)(6486002)(76176011)(8936002)(81166006)(81156014)(229853002)(33656002)(7736002)(66556008)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3330;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZjCbH+ASCGWnI/QztHblDmwFeHqnnsdNS1fwDpdpcI/v4H4mVdB8sw5WSu9XXKGlv+hYkk2Y28yQlG5q0L+XAyguJFGtM7yypNFSXvmUxn+rYu9BNWLwjXxV2SPOrhFIZctPEE93sspiTmMSH+LTbEudE/Zy/RKiNWOR06cYM3uwTVJnR7wB3Py6tCtJ0zJs/4Pe5s4GMwftMpKyvi4VtKQciJk5B6G9M/mlc3XAoHSy4+Q3j1U+0vFU1uxk+UcUCWLkHQGUM0kO949bkLg6rVdrSHYiCv4mBobV4DqsxVKJQYiGepOBA989zs+0dK4Qvjvm8pMePq37KvhNhZwLJTk+0frW6f9/9GB3BLmv990AqyYog9oXQ+pkAXK4mYPQAvEssEBvjgLyG0G2Q/0cNSJFIyCLqHTFpckO2Rl8qqU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EBC5629F291FC84888414FB7AA42AC27@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693f653f-3161-4745-9bb0-08d6d8f2cf39
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 05:04:29.2776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3330
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 15, 2019 at 12:34:00AM +0000, Jason Gunthorpe wrote:
> On Tue, May 14, 2019 at 12:45:10PM -0700, Nathan Chancellor wrote:
> > DIV_ROUND_UP is u64 / u32 in this case. I think DIV_ROUND_UP_ULL is
> > needed but I am not sure if that has any unintended side effects so I
> > didn't want to send a patch.
>
> Hmm. Most likely those u64 length's should really be size_t.

Indeed, it should be size_t.

>
> Ariel?
>
> Jason
