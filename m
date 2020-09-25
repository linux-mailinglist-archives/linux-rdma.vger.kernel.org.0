Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C342788C1
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Sep 2020 14:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgIYM5j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Sep 2020 08:57:39 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:15455 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729705AbgIYM5h (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Sep 2020 08:57:37 -0400
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6de93e0000>; Fri, 25 Sep 2020 20:57:34 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 25 Sep
 2020 12:57:33 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.51) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 25 Sep 2020 12:57:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXzObmmCc4lBJjRhePQcjBToGzS7y6e9f/vIRfEjkplrtABdFfLA8bp4kSGVe+x3M1BZ/Uf+NapEJDvGoDtQNyiBumF/smsQR0hfNyD9/Vr0+RynbONm86dA4edcpBFykQ7/a+BcVDMb3GeqrFrWsa7j6X6T6LUiEcf+Ca2eF6dSevVYxtnxiHB/MOMUYqOXkv4Gi7w5YWoIV7lplBFeuoeB3JZ43hq93X6OQXNm9KCg9uV8p3SodNG+2GU4ZzufATDJakw//3cq4+4w4bnUlifvASaxrzpqx/009IxyYowjgedlIoITHPOPHykWx8RUhaPjuObYgx4FnIq/UAU1bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veBlpLrwzafs7vT02VqoqEuRMd5oGd/xpQDIGf5PviY=;
 b=Oq5nltk0/V+ALK8Ly0mZoYIkpEKCyW5nkBRgct75yyU/ktgKjrE/rlGnP6g+3os8ocAbF34y6JLuuYJVsMaveeG1wd+YroB2vMUoONogR3dFUFssnI8RonT2wjFr9B0z34D1udOVRAtWzH0MSkRNdRypF/1lapmRLvpGW3pH0mBv3jobopqZZi8Tk03rUlRnJdoox5i+Z9fxfpCVdwh1j4j28JWkIJ/c/GY/nJnu3pYV4RB1WdkpSBRp5zN4eRz2qakM5kf1Pa7xHnW7tqPmZd8BlUfoVpbAmYZidQ05VOLldKtBKuY6u/t6z0q6vAxLYVY8hKn2K9Tiu+j/txUZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Fri, 25 Sep
 2020 12:57:30 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.024; Fri, 25 Sep 2020
 12:57:30 +0000
Date:   Fri, 25 Sep 2020 09:57:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20200925125729.GA241108@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: MN2PR16CA0034.namprd16.prod.outlook.com
 (2603:10b6:208:134::47) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0034.namprd16.prod.outlook.com (2603:10b6:208:134::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 12:57:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kLnI1-0010kn-0t; Fri, 25 Sep 2020 09:57:29 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 986d92b1-6d24-474f-c902-08d861528ff2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3305:
X-Microsoft-Antispam-PRVS: <DM6PR12MB33052A9EBC4510E85E97222AC2360@DM6PR12MB3305.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dMXDtoDKymtW7nbsZK/nvVd9atoJXVFhdpu4i74UIe53uhzsPf9dnLFh7Zms428nSTwuABeBBUzEJXIJImBvvzwsGYvvjZpZENImKIDn1xJyXpbMnb7haRZhLGXC2cL6X0funoPk4PEUAkWiDfmsdYOgUOX7zNGXve41P+gZk+ciKkJnB6vDR/6atQHk7M6sMOWyefUzUe6JuB/tThz9/8zCIFPoaaEvh2Wxma8Oc+Hh9RnkSwEbsBmxwvsDO/mfwN25IHVCgxPOpc7XzUyv+XQdO2hJWDB5SVPqnGSupzs2DDiEHIzchT4QraanT00IFYhUYAjLCXaKoQf3cfQzmgV6fQA2c4t0a46U6ekkJ8bvj3G387Bev//j1pgwV5zPJ4gcdGU+qO8UQCT6kwkhzG4PMPui7eunngiZLflzRTU3PlBl8pWnXR+9ZD1BpsfuN9OiVNZbpIdRZg1e8sTx4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(36756003)(5660300002)(26005)(316002)(186003)(83380400001)(2906002)(33656002)(4326008)(44144004)(110136005)(2616005)(478600001)(66946007)(66556008)(66476007)(1076003)(21480400003)(9786002)(9746002)(8676002)(86362001)(8936002)(426003)(27376004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: j6Yf0Nc3LdSdRpunC/+iplMmhkSK31sIYq8I5jNFaFHoKaqBWaHgc3ejJjMXhHsPNsjI/jj7GJZXc6Y6mbyyRW94cwTTiHcc9gTeuwyTnA51Gx+E2tzDeSvLqAs2rAuqmBj8gEGyh3NBie8dsmMf+uJblEcMOEcpc5NUki03q6WBZSBPfyGF8qzC9sUaWMuZ97QaAxJt7lc7m24UZO/z3k9XMO+OT0f6uN9LZkObj3eOAwQ8s0Hcebx9cXEj+aaz7hl8D9uCkWnxSYdLtRJFxZArKCLb2q7mzcBCEpRaXogPvg/n00coSWRjDOcpVMmjvunlJ9RgMuwdZjVSEFrV5xeMcfVopAXeLKtApjbpNEkKCSpi22beloy9m7AiSO6x1SFAYi8CsuQMeqH9gyPqJ/uMhApPHN0cXrBTuLFcOLgXfxnwxR+S72EZJSXf9idRGcDVyOlhZrQmsKelf2GuDwHg5kVtQIF9zkHK854Sr7AJgeQkKzQkIPM3leq85yLnCmtMvCpYAt/CTXCWSyOoSHIPOQ7vnDhIGyUbSPYLUrHa1xHffdAcfm/ZtKRnTlQmO/S8RXGdJhlZX79WvgOa1mrV1vcA2owJwR5gN+QGvtTPJGNPYDSOWo3xeqec7gAk9b8ketOeo/wWbmjlW2xOVA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 986d92b1-6d24-474f-c902-08d861528ff2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 12:57:30.4939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7YE/J0aaPrpTUX6YwO/ozufTJtA9/HEsgVDbc6JmFr3dDCGy2d2Y66uRzQFNxaqj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3305
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601038654; bh=veBlpLrwzafs7vT02VqoqEuRMd5oGd/xpQDIGf5PviY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         Content-Type:Content-Disposition:X-Originating-IP:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=DIXATbD+5DYToHdW23v8dGQtYcOPxaGgdH9Ig8BkTUGP7LmA5CpeBUhANW7dIdK6m
         qEciKshtP2ZpcSYJFK7FWC9AWHZkiKIHw691+RCH2HsYeizwelXMCZJjOL/MClYCUv
         MfWgomAPYK4HU40zpG0pNv/lQ2OSOUmQfnV63HE5QtQqMJvGqBzwme8hE7Fr0dI/Jj
         oxW3v+B2zcwDtx2aipCvZuKi9L01aXx+oYiZCXR23nWB9pNpYG4j/tJVQBU0t1hmdB
         HQkx2Bar6EMit/260eSCIgxmz/9is4Kwp9XOapeKBa5Lateec3DKkK3f845RSdsNWX
         lvuybnG4hW5Fg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Only one small bug fix for rxe found by blktests.

The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 4aa1615268a8ac2b20096211d3f9ac53874067d7:

  RDMA/core: Fix ordering of CQ pool destruction (2020-09-14 15:20:18 -0300)

----------------------------------------------------------------
RDMA third 5.9-rc pull request

One fix for a bug that blktests hits when using rxe:

 - Tear down the CQ pool before waiting for all references to go away

----------------------------------------------------------------
Jason Gunthorpe (1):
      RDMA/core: Fix ordering of CQ pool destruction

 drivers/infiniband/core/device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl9t6TcACgkQOG33FX4g
mxoDvBAAhnyqDQ8wLkVMDtGu6i+PX4FZWBcOMEooi8WpFJDXwhsTr0aX23n/pB0F
osbMQtlV+XBoHkOehWsA5subNc28/vcguaD3xIwZccfw5mg3QuNbzDtdCRVHvfzo
Fzcaq7OWtOzGAujf0s3P9xHAiwNDpnwU3UNMFjDAQYV68DX36zfziWj8aM15bukp
TFgTR5P8mgjBV0x2HuJayqXyYoRy5ZMtjRRRNwqJz96QPcIpgUeR/3hn/IfKr9EQ
Ows15H4VsUqC7QI+WV1bcjhr50O71jTTbhCjWkhWAzstHEffJqzl1L5Ely/jsGOr
zjlVNhZ2gFPrAGf8jdh/GUlpf/8ij0yXmy8vcQBqIeFKeFoCPV7ziObSWWMx5iFC
aHMXJz0f6BwtdVH/XMiuY+SrnSAUKDCeLcaph6l/LXgvxbU7v+j9yir6sMfRJc0x
YLVmbY7d32pKBwBomKKPn86Il+d/EXlEFt1XnW0ncXGtBTWkPQdkFviYQp8ZKTsX
xrNXXI/kK9F3U0hjKMx/CAAFnKIyI2sonmfhB7GOTeeO7Q9kkZzqMvqs0Vk+tVeh
lNhPy9iqI+WVj0u9JOwqFU37Yk4Z98XnKvxYHLmVP11bxR8Ju7sQgV4a1rBkWgvP
xM47m3E/eSfZzW6Wig8CWtfHLbxvVLclqkOAmVarWcQSGdATFDA=
=Zm6B
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
