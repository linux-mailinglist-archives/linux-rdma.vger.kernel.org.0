Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932B4234844
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jul 2020 17:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgGaPRL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jul 2020 11:17:11 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:29935 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbgGaPRK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 31 Jul 2020 11:17:10 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2435f30000>; Fri, 31 Jul 2020 23:17:07 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 31 Jul 2020 08:17:07 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 31 Jul 2020 08:17:07 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jul
 2020 15:17:06 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.55) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 31 Jul 2020 15:17:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSGiefaJqtNTmHhGe+WV8EE95bc47dmC4Ip10rS5iIaoTgLrwiwlCMTZ7Z7y7iHegIVXyiIeN/oM7ystzOPVk7C9DqMXJmv85vRmej2ko1aZChfT0i5KZSkLa3xmo1Z0tI8mNPUE2SjEIKpaH1018vT+GnG9zYZApnnKJ/qbTvjCj5TnzFHrf9qFuychH0FVNRY9TXFjWo2Jsq7CBiG2DLYPWv6p83Tidbo0csXyNJt0lekJ/1kRWxRfDbAWa6QG19ZJQ890mxCayeRirhAzN8yGUvgYjUJa38RUcIMd1gBt9ocVvystxrCdjfBXMv3O9yOO7fDi8enxu9E0kvQc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9uhR1ZM2v/WSrrZwf71Ot3niNays4xcPe+uJo87CNA=;
 b=VedDMdMBWikJMCrCdsLraSM1RtPtTM3Kttq6uQ3dNV+Jt31+3jTl2XOEFK81bDIrsEVBxYIUXSJWFn+DoqdsbuYeE+AHB11AerGX0IddjcjlgSAfY1Ir0bFUX1Nz+Rtswsi8TQcRi1yozNLcHYJhP9eCJAlNKQ9+47vrrJ6vwjawVf64CXgvhOLLcYWEGF5cKk52c3l2FjynCf1C+c0aSg12YQCAcwmyg8fubBv/YVEO5b5ZJ5UnVVA7kKF9kMPflGJi4LR+iEy3Cx95dq1Fs6WOT84BPb9WGNQJP4EnrKBS/EynaqXmI8NKKdIWMG9RA0n9a39BhsYSYXxHSkRmog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0107.namprd12.prod.outlook.com (2603:10b6:4:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Fri, 31 Jul
 2020 15:17:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 15:17:04 +0000
Date:   Fri, 31 Jul 2020 12:17:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20200731151702.GA498584@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR22CA0019.namprd22.prod.outlook.com
 (2603:10b6:208:238::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR22CA0019.namprd22.prod.outlook.com (2603:10b6:208:238::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 15:17:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k1WmM-0025jJ-Iq; Fri, 31 Jul 2020 12:17:02 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91ee9e12-5847-4bb7-998c-08d83564c7bd
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0107:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0107DDD05AFF68317A53FECBC24E0@DM5PR1201MB0107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6suBuhIG5FVAkh3vP/IxY+Z+8HzxWXr1AMk70E1CV/zP2DKEkqkrAomb2+S/FUp7j4uDTYrZlE+gkad5NwZ9dpgs+JcaNGIMiLy5RMRIVVD9CxLNH2TT85/hBWrQhaZbvxOAAspp0JXQJVO9GB1G0HmGb0qADjUU1M5WkbL9AeJZqoouxYhf7lZS8If5nlveHLoTFFogLsjZlfkSO7+MhYL2ufI+wkihdYbo3OoHiD/rKs/efQTlonHY3gZfSEIl/RSXBAOlawAKf4+U+pHoDW1FrqpPpfN2OWwY7Z4lDrIMVs1ihXiOq8yG2en1pBqgBLmnPyXAF0GrYzNStKeO7wUFaXuatrR+2zMsVX2PIDF6goXv+EVCmJaC+rvQlr295tSSiOpn3pwRWHAhxvhTFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(9786002)(9746002)(36756003)(186003)(4326008)(2906002)(26005)(83380400001)(316002)(33656002)(426003)(110136005)(478600001)(44144004)(5660300002)(66946007)(66556008)(21480400003)(1076003)(8936002)(2616005)(66476007)(86362001)(8676002)(27376004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1TaxzhtU2zs1KxyqAH6y8opqmwpbFbar9ovNoNlMr/DfBbGJy4ENo5RL0g/Mhh0NqGHv6p52But1MwWKth9gNfb1DNmWtmba5eu4i+o0ysSIpNmGJL9s+HmBj46NorEs++9ysgdyNciPdVscpDP0vmp/Bi9o9iceU4UP3TRFjR06/HJI0jvjNYlsU1w1DwSLYDuqKDeEFCzySx43w6qMNx0TdMqS90+G2q50RWvwQkPcuQ3zzswiScGXv2Wb5qd45zjXUrmCdlDaBXoiksWZoswblwuKucyYFMCDAqE69cwTPVrkszhljvYTTEQIDRAW2VblY7CkDlqFmeqoTmAqGGWGLOI/i7hJO+g4pmPoBb4x6X7yS6uImcXZTbOvP3riX7W6Bg3+gXt2E2kSo/wX4DsIilAGgO5+LuDnKso76v36YvVXhD4sChcMccViBT0Kg8Lmba+WSQxxaK5PAcmxnk+UP6Q/loUDiZ16q0viUsw=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ee9e12-5847-4bb7-998c-08d83564c7bd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 15:17:03.9117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eys7Qzgs6HsjwNJI3AM+2vEPNm6tPzYy53gUFMwXhFn2uVELzyQKomqeasXUha1E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0107
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596208627; bh=r9uhR1ZM2v/WSrrZwf71Ot3niNays4xcPe+uJo87CNA=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:Content-Type:Content-Disposition:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=cJ5D4Ub0MS9iau0pzEVFtCPzTRNGsykKwtqS8oAeJlERFFwQUJb0m4cPVndS7TwkR
         94UEDITH5txuvgtHYvq+IcqXoPpO1zzzlOSmCYLTqwvOOI+qHI5IUj3i8ak2qSazCi
         IyTUBoxCCxl6wNgfklPrjX/OR9ai0+E2LEGfnB+vo9rSzW0dNsgN8DPH/EAW/0bQXQ
         VokXGq3vnOIAoUl8taLI/rw/Ibiv9+NmwdpleRXY/7aGzMJUGYmA1p3S7vhZ6KLXVU
         ixLt8EJJTrArrDMlEO9lSrUP7Ic2lqSK7MVr5zcYx0vuV0GfYE+VDbuGCsksxdbfVI
         K7t1NVoQm1yeQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Still a few regressions from the merge window and the usual collection of
fixes.

The following changes since commit 92ed301919932f777713b9172e525674157e983d:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to fb448ce87a4a9482b084e67faf804aec79ed9b43:

  RDMA/core: Free DIM memory in error unwind (2020-07-30 11:03:33 -0300)

----------------------------------------------------------------
RDMA fourth 5.8 rc pull request

Two more merge window regressions, a corruption bug in hfi1 and a few
other small fixes.

- Missing user input validation regression in ucma

- Disallowing a previously allowed user combination regression in mlx5

- ODP prefetch memory leaking triggerable by userspace

- Memory corruption in hf1 due to faulty ring buffer logic

- Missed mutex initialization crash in mlx5

- Two small defects with RDMA DIM

----------------------------------------------------------------
Jason Gunthorpe (2):
      RDMA/cm: Add min length checks to user structure copies
      RDMA/mlx5: Fix prefetch memory leak if get_prefetchable_mr fails

Leon Romanovsky (4):
      RDMA/mlx5: Allow providing extra scatter CQE QP flag
      RDMA/mlx5: Initialize QP mutex for the debug kernels
      RDMA/core: Stop DIM before destroying CQ
      RDMA/core: Free DIM memory in error unwind

Mike Marciniszyn (1):
      IB/rdmavt: Fix RQ counting issues causing use of an invalid RWQE

 drivers/infiniband/core/cq.c      | 14 +++++++++++---
 drivers/infiniband/core/ucma.c    |  4 ++++
 drivers/infiniband/hw/mlx5/odp.c  |  5 ++---
 drivers/infiniband/hw/mlx5/qp.c   | 29 ++++++++++++++++-------------
 drivers/infiniband/sw/rdmavt/qp.c | 33 ++++-----------------------------
 drivers/infiniband/sw/rdmavt/rc.c |  4 +---
 include/rdma/rdmavt_qp.h          | 19 +++++++++++++++++++
 7 files changed, 57 insertions(+), 51 deletions(-)

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl8kNewACgkQOG33FX4g
mxoP+g/8Dn7gXjy6A+5sCdgeqa0xJt2fFCNkWcdxls1/RzbXg8WLLKmE7MKzLWPd
QgK7Bor3/Sawkf92Pn/pUqVZ/+1xQFuDKl/QfBcw3vREbQFHsigO1ZW5jHr4/L+l
B/hGV+zYl0gXHa40VTmhgF7qXpyh2/UdofX83EP83g0wweadFLyz0+Sqcaan3W2/
7zSnl1c/0l/sEEbcTK3deyTTcNVhe8crewigSiyVWAmJ2EiY3O3zP/oY+u9RwqKo
BFhw7cbkS0sNfvhZf/fVtOLmOPV4WoH41hB/NhoxpgV/EczmTJ0NtHsSUfzgS+qA
BHDw/KIgm+uAUzvYZ8qResZRfL+/D1sRniN6VxsZrsIoMib7CNaKh91iLWnrz1zv
AW+v9lQ8JH07ThGXCNFrY5HE2r70socqTWpkv7lEhS/VMDlb4WuEWqwrn0efc5qL
ZBxrS8+w4PPuJF050l+d6V982VNLTAZlOgdGrfaISaQRaN8YFFTL3spR5NuFTznt
npdcy8lTSAP48uZ8mG7/gY0DfSoAPOX2DVGKqfjhbzBoDCU1DJH2uo7PKIcZKW2g
nBm3Nq2jj/UMsmZChqM2EZ1CWIS05fuUPgEoBnPT2uUV93hT8bUF00ZBA7IFrTiZ
aiBDTxCSKECrgcNLrOwcLRu4hfNjrAn6Jacul2ldtreLamKAGNE=
=YkD9
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
