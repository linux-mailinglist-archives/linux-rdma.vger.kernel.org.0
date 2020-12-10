Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7ED2D6082
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Dec 2020 16:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392066AbgLJPu4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Dec 2020 10:50:56 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3858 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391991AbgLJPus (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Dec 2020 10:50:48 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd243b00001>; Thu, 10 Dec 2020 07:50:08 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 10 Dec
 2020 15:50:08 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 10 Dec 2020 15:50:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlFnuBJctTD4hYBBDRky19ieUAYFbpActJYjEo2ZKLwXHeC+65J6bakbSa3FKmG5NsKQ66Nqyeh4Yr/93vV6u+Zn4BXlnpzJwd+NwI0aFKS5IFyAw1WRk07pjwcI9uTk4JkSmBc7iExaHGDlLe5UCcfgjca1JqqGzgN/sU//TVxb2ScvuI+QygaDvux3R9ZMNKGLRyKTOCV/b5/5FWXcBhu8tgy8T8wOTAAPZkMfWhi2v9c4LKf7a0RW113i8z4jGH6ewyBPUAttccZBYS6rFz0OE7U0lv6/s08Z7yBX//UvIJxA/2SJK6hxOh5R3JH2Lb6cKsqbUz8I/UwGbV5N0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmdXm8bKtO6paHAHMV1bxkXTK0Hy6gLzRmX03mMJI4c=;
 b=cF8ViMx/VzAzN0qURJXNQBNqkvHtLxPKVMfEGuIZJ1TWQskM5iGwVis8uNGBwRNL2LlB8OfCriLI4Kv9mJdNie6TpBbZBppWW/2qMckNK//KtIcy6renDPWSg2Y2O+f+COV/UJufU+jZIFP/9QHfOdGFe7IMSIC9DwlFG2KrqghzckS8GGeO04uPYqYKS38nTdy2rwZ+QCwivaLooZsgOmTjl94w1o9FgXJ8dg5yOyCiIg8uzKw1FgHteoTYcPYPg/m5SyLiVooRIdcXgQkouiQQQbwr/ZFgbSFw1mbbuWlBJFoni8s46HCB24vvcwBfKX1ryvy6jwDBaXpIWwUKYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Thu, 10 Dec
 2020 15:50:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Thu, 10 Dec 2020
 15:50:07 +0000
Date:   Thu, 10 Dec 2020 11:50:05 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20201210155005.GA2106949@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
X-ClientProxiedBy: BL0PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:208:2d::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:2d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Thu, 10 Dec 2020 15:50:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1knOCj-008qD7-4n; Thu, 10 Dec 2020 11:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607615408; bh=OmdXm8bKtO6paHAHMV1bxkXTK0Hy6gLzRmX03mMJI4c=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:Content-Type:Content-Disposition:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=SlkYL/s/7RYYLStuF91nLuHZiMVCdQbIzCG8F/2GxLUCFHhTX2wY5orVxOIRRYGtu
         HgpmQKtjaavaysQBCjoc6fEz6pPgINlk9n9Kg3qky1GR7rAJBaGh0Hsd7Rbwe9CfU+
         LW9G6pKyndAGA530NxVgi9AJn07H1NbTVF96cYEZ42vB7+EdhK7wHIYe990DFXY4km
         imcmecVRC8VFmQwHGD2DGnpew1Jep8ES3hWpn47YtqUiKjCQRJ37f4I5OMfbw65vMJ
         vbWgbdoq/KaF1tBtPL9lNku0BcRO/K6d2YnzfSr48ElfdRsbEEXatQGWwnevoT9r6K
         abe9wbECbqeEA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

A few fairly normal bug fixes late in the cycle, not seeing anything
worrysome for release here.

The following changes since commit b65054597872ce3aefbc6a666385eabdf9e288da:

  Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 340b940ea0ed12d9adbb8f72dea17d516b2019e8:

  RDMA/cm: Fix an attempt to use non-valid pointer when cleaning timewait (2020-12-09 15:51:35 -0400)

----------------------------------------------------------------
RDMA 5.10 fifth rc pull request

Two user triggerable crashers and a some EFA related regressions:

- Syzkaller found bug in CM

- Restore access to the GID table and fix modify_qp for EFA

- Crasher in qedr

----------------------------------------------------------------
Alok Prasad (1):
      RDMA/qedr: iWARP invalid(zero) doorbell address fix

Gal Pressman (2):
      RDMA/efa: Use the correct current and new states in modify QP
      RDMA/core: Fix empty gid table for non IB/RoCE devices

Leon Romanovsky (1):
      RDMA/cm: Fix an attempt to use non-valid pointer when cleaning timewait

 drivers/infiniband/core/cache.c       | 3 ---
 drivers/infiniband/core/cm.c          | 2 ++
 drivers/infiniband/hw/efa/efa_verbs.c | 4 ++--
 drivers/infiniband/hw/qedr/verbs.c    | 9 +++++++++
 4 files changed, 13 insertions(+), 5 deletions(-)

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl/SQ6oACgkQOG33FX4g
mxqPyg/+J+DigTCn0mComWCXX0B9e2bKF4HVWOBAO/yX3VOuRWmZlpJNgdLt+oNj
HW5AIUMzV8+TP7ir8lpH2Yvxdi42UKtMcs1B4MLF+Jz4rFo9KqY81Re/PaLNm4H/
ACO8H3wNDdp+RFj4LoQgl5dXNqP0JrKnK/jkaGItLWX3uaAonlE0sNUUWy1rxkq0
4BDtjSd/z3zkEWTeLBtfFoYPGsvQAbJL1bpdyr3ZVQizIJqfT+yjjFS0Wdmta3jC
Z4VbHjESUc13s05GAc38MRbDI5V2X6Uv9R/q/CWbFywpvMaiGL/aiy4oMbMDK5yB
kZQ58Ohs4GudNdqbQDvedxJNLd9siFRvGuN92KjhsILbsJsei9Vh/HTIwaEdzKaf
/s8gk108j3hLDmp25ThIcXesn1vPtlvvRiUh80Qrb89mdgc4YW2kjemJL5NG7aQ/
iEILgBK84YaSt/8BHjscvvM9kYO6kmPliUGG9mffsBnzGbnP3eofGeuSjBUMujo5
ZrFBl8Yzf61mY96Th9rsKJpNUMgANvlnw88Olpl1DW9G4r4PGqLhmkb6ot8TLB6J
T65Cijd/9mhnXsukSozw5geoOHcqsYlcPjYecRamtnQCuJNxHYtUMMOMnHDdHQGh
6u0g4NCP6g4hv6OFK+T9uKQ9c60lJtSnz7qW8YQ4D3mEcU5/mIw=
=gHM3
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
