Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9322B9B7F
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Nov 2020 20:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgKST3d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Nov 2020 14:29:33 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:23211 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727480AbgKST3c (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Nov 2020 14:29:32 -0500
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb6c79a0001>; Fri, 20 Nov 2020 03:29:30 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Nov
 2020 19:29:30 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 19 Nov 2020 19:29:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eb8CO9jgVqmkJoBEnPq8icrxdfysGShlpWbO03h9JRLLWQfIVwAqqwAvUoC0vh5sso6V3FMPZ4FTX5v9w31/cD9+A3BU47ABnDvnyCN9XOo5qSlxXmxJTerB/1YlmcC3zgdQ5AFfi20X93uSKPVQ2TZIOTdkPmFMq4MW6stkJvx0oDrqWrpGNXZR/QEIKU6PwAhzJ4Eb+9jfgiNZWn6xVfbt8HSOJNjLPynsFoI5hLc3mVc9WgzY5SOAGg4ARhH9zNTwSRXvDqoj6BaUndlY5elkdjDwbshT8wSwos6xEgwFtlpTCHywXTAS32P5nBYQOgBvaB4iirHbDtJ82y+QNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1cK4qK/b8nZmk5isMR4Fi2ireT+FoBV3gviK4nxE4s=;
 b=L23mZs9i6idlN2KgIHi4qB4z5yz4umiYZDOmYXuJdCcbnOvYZo2Mz9sqIBuoo3V2kTeln1aaCZUGkOfmHPSELCYFBL2L9sKukFkX+O1qVRIRVY4vLYYpsDC9PWe1Pv7OGLAZz4Fg5OJ1vHnDa7g/l3pYA1+IOh3HQcaFgBRZXvzCWlYz0UAev8QkUCPL+dJ2ckExnyGp9BtHqeAlhTInRYTp2WqYL+J0Ovk2DF9ko5wm/hCkbiFfvsrzfSunDtpBVTE7KWoHnodafnbRDC5jlKEgJ0Ian1lmzpLEAStKy2HE4dtaOokH0hcxS1q0KZc8FXTD/LfLed06XUbRtd/u1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3306.namprd12.prod.outlook.com (2603:10b6:5:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Thu, 19 Nov
 2020 19:29:27 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3589.022; Thu, 19 Nov 2020
 19:29:27 +0000
Date:   Thu, 19 Nov 2020 15:29:25 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20201119192925.GA2028353@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
X-ClientProxiedBy: BL0PR1501CA0028.namprd15.prod.outlook.com
 (2603:10b6:207:17::41) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR1501CA0028.namprd15.prod.outlook.com (2603:10b6:207:17::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Thu, 19 Nov 2020 19:29:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kfpcT-008WLD-J6; Thu, 19 Nov 2020 15:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605814170; bh=m1cK4qK/b8nZmk5isMR4Fi2ireT+FoBV3gviK4nxE4s=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:Content-Type:Content-Disposition:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=KqL7LsUPVtkds7W7nGarBy8IEmJtBiXwi1Ez+QSRrXpirq7ka5SUyNV0t6R0KkOSv
         87q7Mp8lpsOfYjEPbYAFjWl3YFbvRv2Kuvk9bL5Zpimm0TbcNoAEU541DjrZhzgkgg
         FnuAKeaOHheCzrVhENQl1AFujKT5bPjBrQ07uYHammqNLdYLMZO8uftJ0ckxl67hui
         iWbLhFvfnN5dSIC9FFpoer6ETGFYOz3lvOQLZIsiA03+KWgM3fwX7fhFUyTpdErQcC
         tIT6x+41kyM67QYsFKKS0pJdW4THnvSx+y4nz4OgvE377OU1fCZ/1YtF/zeP2l6M4e
         UZyW/OmKE3B3g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The last two weeks have been quiet here, just the usual smattering of
long standing bug fixes.

The following changes since commit f8394f232b1eab649ce2df5c5f15b0e528c92091:

  Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to ee415d73dcc24caef7f6bbf292dcc365613d2188:

  tools/testing/scatterlist: Fix test to compile and run (2020-11-17 20:02:20 -0400)

----------------------------------------------------------------
RDMA 5.10 third rc pull request

A collection of error case bug fixes

- Improper nesting of spinlock types in cm

- Missing error codes and kfree()

- Ensure dma_virt_ops users have the right kconfig symbols to work
  properly

- Compilation failure of tools/testing

----------------------------------------------------------------
Christoph Hellwig (1):
      RMDA/sw: Don't allow drivers using dma_virt_ops on highmem configs

Jason Gunthorpe (1):
      RDMA/cm: Make the local_id_table xarray non-irq

Maor Gottlieb (1):
      tools/testing/scatterlist: Fix test to compile and run

Qinglang Miao (1):
      RDMA/pvrdma: Fix missing kfree() in pvrdma_register_device()

Zhang Changzhong (1):
      IB/hfi1: Fix error return code in hfi1_init_dd()

 drivers/infiniband/Kconfig                     |  3 +++
 drivers/infiniband/core/cm.c                   | 12 ++++++------
 drivers/infiniband/hw/hfi1/chip.c              |  3 ++-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c |  2 +-
 drivers/infiniband/sw/rdmavt/Kconfig           |  3 ++-
 drivers/infiniband/sw/rxe/Kconfig              |  2 +-
 drivers/infiniband/sw/siw/Kconfig              |  1 +
 tools/testing/scatterlist/linux/mm.h           |  1 +
 tools/testing/scatterlist/main.c               |  4 ++--
 9 files changed, 19 insertions(+), 12 deletions(-)

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl+2x5MACgkQOG33FX4g
mxr8rg/+MINOgEgVN/37onpY3U8k92nvspNqnU+5mPcgUJLOeF6KwId5+8dP/4Jc
ms8tl4Yogd9KOCyhepkYbKx0vEN8bukBYWSvXHlcHbrE1aqLKXl6ZgX7SkAj+6TT
bgMe8f8jCWpjomO3UdWBKc0BJXldKsRNehK7UK7Qva+upP/5v5zWILTkTRRnq5+L
dTyHpyH9fZw2wNw1uRkDfpvsad1yCTKtX8aXlV8PBxzqpHlcCa1dRMvFnFIoRXd9
YtqC9bBi2sielS0AqIeT7BmPaWxUrRV2Fz+1JtNmpLBnr79wiel2kAyOEl4Zftzp
pM0KcXEmAiv66N8A+G6UKaLOa2NH3RZwe19K5UM5oUj2HoOoETRKKD4fkAOIby19
KCjck/mVNsMmjg5OHZ0LSkoP1ugQWNrSPM9l/ysXxGnA0+eQBK9epv5rAxxHVVu+
a+nan7bHR6jJowbvd4VzKBYoD02aD9Rw3gYgH1Igf+7ryimpuSCeo9Rbwx1Qq79s
DFUaTTitVClX8Yo66jvQsRp2SatAKa6lHvLhF9QXn5luW4WPQASLq0mki9qRmJXg
EbAAE1YOXOzWdOO6S+xNjEjDI7fE+wGNGsJIq/sOKKhYw4zELOP5WOD5+dav8N8H
5Sp0HcgApQIIEYibx5rtgiRdnAfby62ww7py14ZxXEnnyFw21pw=
=rWNO
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
