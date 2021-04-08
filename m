Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77823358DBC
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 21:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhDHTvm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 15:51:42 -0400
Received: from mail-bn8nam11on2087.outbound.protection.outlook.com ([40.107.236.87]:26592
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231676AbhDHTvm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Apr 2021 15:51:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwI8t2EfiwpXP6kS8hjs5MidxnzhDy9m2Kgrqk/wqrceHxF1E2sr5IhggVO9iELvVOCE4yS7v77ZX8RRPCr9+R4lRmD22geG+1MkHfjcWv9bj9Ux8ML+BFCdBwffF84xvVkEJUjoXGfEDkvlzXA1jOe9ba76GfmM5xEG/YlHO7+dv6icxGzH/lTQyL9Zv5EZxhCz/wle5gf/4mxHlMnuusVH3v9Sde7gX69y/l6vwVpVcBhecypX3uPK2pmumIoWxcwasirvxYp2gJOaZ///2po8Q21EmHAIr9JExKYgkdA2Kw0YJiYKI2aREmzJ6ziYsSoqkvSjAZ9akTjd/8jLDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66iKhI9m3z+u1/VxgVGlTAiRUp3lAfEiH68hveA700M=;
 b=SY5yK92o/CIIs5L9neCykp4lbEs1o63gmhhTdur5cQ2X0PBAhzUirmnl4N0/d3+Kfc59H+Q8t1sBZftEPUPKuoJ18kpCwHoo6NjGuK5A6xkUI39dxJcXqcWr5m9eCWWlYhq1+1PuaPISjHYvrVmxyrQ4Kiqq5QC2ekS8C8bV7/vpn9A78lkUADmIVFOMj+wOIKmeb8jv2a0T73LCzy1DhoEtT6njCp5VKi2WiJiVgh4GAOotCoJ2WRLGjPYgRZHgMTMfjEiS4ZSwcaOb7NLKrjo4bd0A8RUSA+u1vZl6xNnN3ZlYVaDBoryFpFX/dfR2020pW3W1v/X88UFGEsdhPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66iKhI9m3z+u1/VxgVGlTAiRUp3lAfEiH68hveA700M=;
 b=DxD9Lb7F0o57ayxnh661udc6wB+nsF1Xy5/7JlcbDNYwN6mgZsZPN/trfvlFj8bLzHmPAikIIAu4kOO6E8h6Y23eLS3ajObSiNAFbYIr6yxfzddCdgg+0ptYrbyntNUKK1BK709H0r16uH16kFJPz2bZBgJgHv5OxA3bQfpEI6lcQYL+bwwHfaEXt7ASSn3E/FIea1x4sn56GxWGRf0RxhxZteYUVpG9Rc+cI2XG6DFjAXIXHp2ebDqPkqyL2O1E/JYrmfnbbVNr8jPcN4Iiu/1Nr0K5TiXXnXHOdnbkSNU/4cFscGnSd/yMh51XLakucRfj58xOsE3wDolOOmSJvw==
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 8 Apr
 2021 19:51:29 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 19:51:29 +0000
Date:   Thu, 8 Apr 2021 16:51:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20210408195127.GA742240@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR02CA0086.namprd02.prod.outlook.com
 (2603:10b6:208:51::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0086.namprd02.prod.outlook.com (2603:10b6:208:51::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18 via Frontend Transport; Thu, 8 Apr 2021 19:51:28 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUagZ-0037JI-Gn; Thu, 08 Apr 2021 16:51:27 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bb6c819-4640-46a6-ded9-08d8fac7b350
X-MS-TrafficTypeDiagnostic: DM6PR12MB4388:
X-Microsoft-Antispam-PRVS: <DM6PR12MB43884F4136B6DA15C34B62A1C2749@DM6PR12MB4388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qqq86pS7vvhUY9lO/f/40kc3PJpqyUcA4TZViUnryxg9YSAuxWyoFDTgpSS8iopQzua7QTLFm9YppGumxhjos2rRohyrxYWfGV41vMMLlhPtpJwE/KLSk4irjXIhWCPj2e0n/ZDJs4ebo/e8npIuSjq3XVZAKTw5zpTY5XfAyot8U40q2qJ/UfK4+ukSowtEbFoPmuNqmVhw5kiES+iZoyWNVKLv+iSbn39aPkR1mbMl0u6PCzhFMcbySjdNpkx8hHN6sd3EJLQXTmv1Ub2YWs2R0/nskLJCs8DZqvXInahTN7d6M2LS37njQLqp1TI//PzIlV+IeNOYJFT/YlWpQ7A+GN2o6GQ7rjsnnHvRwzHXLvcymGarfSiL6wQDPjBlFpKlcW8D/WSOygiawuF1lfyqfExuvFghh2r1Jgyi45H1Oq3Rkpms3x9C0qeTZGvgztZfTNgYXKVtZsw6w+cYMh048moAeSC9rG6Wv3sqBRyE82YSkIwl4vECD1KB5Wyf1mav47FhdNREhkB9/svbFoLi7Qk23fqISWgt+8aKnf5DdlsanTufIdTT38I2youafiHT9hcOdUU4N6n/VvfE6Qa4sciJ1tOXoWzE1Cc6hKWtxr1Xg8upTmtjqpbIW7z+NKDJLdkGsICl0b7+cjxcyLFwZwORl0av1ueI3707w+bWca3w3FSuP/TAUihgJeY1xyJdW1sz/NkwhbeGBnIWcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(8936002)(478600001)(44144004)(8676002)(5660300002)(426003)(38100700001)(2616005)(110136005)(21480400003)(316002)(83380400001)(4326008)(9746002)(9786002)(86362001)(2906002)(36756003)(33656002)(66946007)(66556008)(66476007)(186003)(1076003)(26005)(27376004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VJeK/TRghNnO6QiPyijppGWQCkmg/UZtBxf1DZDrFBes3P8/rjaNXmJIKupP?=
 =?us-ascii?Q?ZDSSXOkWWBMR0nzwvmLLlK8pYhSI7SsF8IfTPMibXHhIquee6REaxHHxXHFA?=
 =?us-ascii?Q?C4RTRyjRK4ihm9ZTGRpgQxIGc/FhqIkiaKl9bXGzg8Kw5TCzl4LJOBBKdd+K?=
 =?us-ascii?Q?8FWfJiynamGwrlnRbN9NGPSai1Ausyr0d3XuNHpAnmymqDcQhV4T4ObmOk3T?=
 =?us-ascii?Q?B97A2iIym4Gncu6GxcxTEaUMVaa+h4FCGs7Dt/dtXJGw6zMKtvlGlmqBOpYy?=
 =?us-ascii?Q?noJKRNjOmR0nv0Ra4wu9rUStOitgkdFEFTXlmLBwvySpNxoPH+w7Gwo7APst?=
 =?us-ascii?Q?DQKiSQqB/EcFbraXd4O+FH3m/7f3eik9l2tMPDZmyY5C988uEc6Vvkjht6NT?=
 =?us-ascii?Q?WkjrZC+i2nfW3asSUl2Mt/wYEf7l4iY6Cx1sPbu2quNS6HCckEfIxteR8PhZ?=
 =?us-ascii?Q?p/Vh3b00HvAr4V/PclHS+S/89JkPzvdVOmwj3TnVseEa28qQpFHOCBnrp6yL?=
 =?us-ascii?Q?uvgEeAyj8vLwGIHRDTjuGLm2QDCH4mlhItSlDUOo63839yZjL9icbNsAmRcv?=
 =?us-ascii?Q?Lnk5HXDU3Jpv+zlIHcxsJnjNiaufunQhQZGu3hwmuQaHUYchK9jJxb3C8f8g?=
 =?us-ascii?Q?Cs9YRRaW6PGyf2Pf9DXFWgMDk+wOeOaygPU74ce6KqtpD4YOxSSenXNAtSqO?=
 =?us-ascii?Q?NZjBbbAiZZOhrIqnjJT06bm5DRlplJrMkriDust8CPBuMhV/JBfCnHaKezSC?=
 =?us-ascii?Q?CJVdB+Nr0UP2Ky5bxZ/tC0yzRLQSZ+z32t90dhZPYWMjvVJLDkhbo9tI8PrY?=
 =?us-ascii?Q?t0xoyBU8txcDyqLM5tIK6JleYYP41U4ATy42MSp3RUw4f+9m4kkwKaWoKJNF?=
 =?us-ascii?Q?yBlvxMHjFDqs95L08wNMcJjUsfGd9Q9YvvVfBwBIeqmVYRk8LOo/3GUH4R5Z?=
 =?us-ascii?Q?U4k52aGkGyJtPrmFdK6NRmRVZAQXAvfgMt1TAB1i4+yrFEIhFkpGUdlHxpvc?=
 =?us-ascii?Q?y9g6DVJZB5aTpouFnv7a5W5gLT2qjwY2yKJvWaOVqu8VC4EAnbvzUo72og2T?=
 =?us-ascii?Q?Hm6efp4QbnCOGaoXR/i2ska7svq7thLZ3wntz4CmoP1g8voF1hamnUV/+O6t?=
 =?us-ascii?Q?1wSP83OlhyJs66J19N8joQKo8dnzRmmfzHySNLuKHCPROizHYyUMEy0eQKJ4?=
 =?us-ascii?Q?Jx///si7SS1GgOeCqR6Juj/6vv9vRdUY0Que3fle5MleKlFv3Ya+yggAP0bh?=
 =?us-ascii?Q?edv6lLKCpyZCW0VAIn4cEx4nEjuUos8pTAntm7gLLVCcwVQiLgBwQTAjvq6L?=
 =?us-ascii?Q?w0Dh9crcGgqf94iKUWMc9ZTZMu1tlztFTRLbiZhzRlQmXg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb6c819-4640-46a6-ded9-08d8fac7b350
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 19:51:29.0610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u97hQW+HVq391PspRcuLPOLChXtWyuNLdPyKouGJpI70Cad8iQS1vQSXVsNfZMrX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Nothing very exciting here, just a few small bug fixes. No red flags
for this release have shown up.

Thanks,
Jason

The following changes since commit a5e13c6df0e41702d2b2c77c8ad41677ebb065b3:

  Linux 5.12-rc5 (2021-03-28 15:48:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to d1c803a9ccd7bd3aff5e989ccfb39ed3b799b975:

  RDMA/addr: Be strict with gid size (2021-04-08 16:14:56 -0300)

----------------------------------------------------------------
RDMA 5.12 third rc pull request

Several bug fixes:

- Regression from the last pull request in cxgb4 related to the ipv6 fixes

- KASAN crasher in rtrs

- oops in hfi1 related to a buggy BIOS

- Userspace could oops qedr's XRC support

- Uninitialized memory when parsing a LS_NLA_TYPE_DGID netlink message

----------------------------------------------------------------
Kamal Heib (1):
      RDMA/qedr: Fix kernel panic when trying to access recv_cq

Leon Romanovsky (1):
      RDMA/addr: Be strict with gid size

Md Haris Iqbal (1):
      RDMA/rtrs-clt: Close rtrs client conn before destroying rtrs clt session files

Mike Marciniszyn (1):
      IB/hfi1: Fix probe time panic when AIP is enabled with a buggy BIOS

Potnuri Bharat Teja (1):
      RDMA/cxgb4: check for ipv6 address properly while destroying listener

 drivers/infiniband/core/addr.c         |  4 +++-
 drivers/infiniband/hw/cxgb4/cm.c       |  3 ++-
 drivers/infiniband/hw/hfi1/affinity.c  | 21 +++++----------------
 drivers/infiniband/hw/hfi1/hfi.h       |  1 +
 drivers/infiniband/hw/hfi1/init.c      | 10 +++++++++-
 drivers/infiniband/hw/hfi1/netdev_rx.c |  3 +--
 drivers/infiniband/hw/qedr/verbs.c     |  3 ++-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c |  2 +-
 8 files changed, 24 insertions(+), 23 deletions(-)

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmBvXrsACgkQOG33FX4g
mxrdcg/+MSRt1+MEeykv2poZB09xKZgS6eH6hQ8rt4phjgsoEd30SbwpWGeblXKd
T1Q0KPxVWeokRmkVa06N27WBMdPOPgEvbag02bRaZ+MvHO0UGXK+9IXnPmMOB6n4
QeQ/jwDsIlFEJgpcteYG0puhhOqcMyCtsHpX9lZfMaYKomdxqGFw5CZI6lIFbdOx
uoPLJLUOVO8OuvRTqhSaTqzNCCjYYl/xhb5mnOB8LG8hL4YFQ+wNzRs8KPd03zyt
tXZgA//8/f+Lf7rEFzc09TqJzce0M2xCCcPdh2oqR58yeFhYKEqwWkqVIok07UXN
mxvaGihsYsahfwc/MjQ/y+7od3XOKChnR36fnZM7ZqPdp1eJZeoA46j4WVZ1a0ZT
zloOGHbLRy4tDsAHjKCmvs3NiHRImK21p3QD+gyfaljE6FO2DwmMRpLEBav9ICYU
1mQaXtxnoC37ZA5imTBe2e67QOlIjE/Uu58Q1Ceiy2xcF4sHcZECA+7yI+qI+JyR
6+32JBRjFJnpxls7bMC0jnPPCwS8dkirdCLExtUfSRsw6UyYo4Zgg3fSxhymC7fq
dYTdX5l96bTtZeIeTi1YFO+gPW2p/CKQ8nbWyBWBY3DK8W6ZtESbuU2iK/EM2r6/
OQRuP9h+5u7kdj767pre537q+9T7u/BFWLsu33Vm28Mw+knlBn0=
=LQuj
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
