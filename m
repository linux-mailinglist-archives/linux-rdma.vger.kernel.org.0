Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA0D3498DE
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 19:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhCYSFB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 14:05:01 -0400
Received: from mail-bn7nam10on2041.outbound.protection.outlook.com ([40.107.92.41]:60897
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229676AbhCYSE0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Mar 2021 14:04:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSvM8xZFynKTQq5El858zbAjmNJq35uTqoGAyw5N2Ki3O7Qzms0x4ZOKx/aUxCPr2rvRbCCxpqnAe1MIpRqBco1mcdGX3mT5S9lsbKO0fe2XsF94EQFLvO+faLBI6AA0bDUMraMSL9Uld537biC3D5NRtupUDVJKC3tl+GlFXre9/IduQd2Ll/dcT1Kd0PjgMCNeW/aGcYQ+rzvgVeQrN09U06pFaaEHEiKIIxsFu8bPOrKPn3ka3oKmu0AS+2SDTXyph2eBmq4FM6iLiwMHQ1pe79U5Dv5tG704xwsA6Jh7rDb8txS1hXyzsoaauNkskXb5sKhgiDAjzl2pFPR96A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72X4ZDABLqF4SufjvnzEj0OIWSIlhKZXoNGrLaUq1wg=;
 b=DLBU6d85rXnrlOzz8/p9HjJ2M5pQwFBP83g9HAbHXg9wdnl860INiLl2k5iQHNvsb2tI8ZScwqt6xHoM1WwK52JDJdFKdMlFE+rDDxAYIU9aSimYS8GtBxHsLaj9JmkY4zDxp+qGxK8vG7wQSaTmsV5p5V7RhQcep+YH6VS6fFa16MBMXbH/SgoiUh3svMG4pWzCoOGs8aC+o7A90RZxL/Vrx0hHFnjQYAaWVSIHI8ijPg1SlYfmEIxd5nRW/MecujKifoekDcB+OZDlcC32IwQNHjNzKLBq8eBawUGEh2y2xhcq6WzE3XlD8IlpzMW/bR/6WuggOXHPGsKaUewI8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72X4ZDABLqF4SufjvnzEj0OIWSIlhKZXoNGrLaUq1wg=;
 b=BuEqCZeUAGmlBa1et2fg/5x31BWYYVlcOH4ZZopqJ0moWeKm3V/Int74DhosmahIFSgnNwKFqHbKTx7NBO3pDxhglFqft+aC6xEm6MY6CAWnVj70mJkbiL7PISpEMPaMIgMYE1304XTbUa8MRRseC5nUgGv4zRSk5icrm1QRfsnfu3PaiLJQlzyk1neBwO+n9n8ZDASEdgLVqq5oSB3YUcM6rJT+a2BQxPJ5+seXOkPwh+q9mT93cLTytBq4Jah5wyK7FgclQru5+kjmymI7z0FR7z/UHkn1tKzCq7s1Sk5jcNF6zbfCRHw3ASpnomXf04laqO+8bfTRKjagI8b9wg==
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1548.namprd12.prod.outlook.com (2603:10b6:4:a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.29; Thu, 25 Mar 2021 18:04:23 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Thu, 25 Mar 2021
 18:04:23 +0000
Date:   Thu, 25 Mar 2021 15:04:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20210325180421.GA702731@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:610:54::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR11CA0013.namprd11.prod.outlook.com (2603:10b6:610:54::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Thu, 25 Mar 2021 18:04:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPULF-002wpT-QL; Thu, 25 Mar 2021 15:04:21 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c2ccfe4-0724-46ab-931b-08d8efb86b90
X-MS-TrafficTypeDiagnostic: DM5PR12MB1548:
X-Microsoft-Antispam-PRVS: <DM5PR12MB15481DD89CA34790CA6E46C2C2629@DM5PR12MB1548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S+KjO5ROHqK83sj8K4ML/sGcAZ2iK3YzdXyz4XSWV/8X8vk9cufpF+Usmmm6hUMw1VATApzKllMfcXc+XM0e0KKFJcJhRbVTWzPiH/lhZ7g0JgEN6TOR6nfsd3/JBlNnOYTkuiPUj9IV3C9qyvakOtN7qsxlGHFOAk3uWwYpPZBEzef2U7h0KZKOhRJrbeHGLTcmTSyGHnVmyqh50aNQ2aYXNmGtVbv9gJccTTmb2BFU+g9AsgNtu1XfSDni4UlcNsSAGVBxsUade4j5FO6RItEEqMb+9PV0OgZpHQ5haYJivQnn+ebTvvcIC3Hj2KA8iwj3pkIhsKFSZbXwupAUGU+G45WArXKt6hF78G264mpLm4Z31B8UstXeHMqJb9ATl1zcvyC3hK6a8aItm1cfEK9M37BrkVxq8sORD5zVzvzfe8+LioEyyWYEn/TYCNndivJDIShP0WboLtTSUC5uyvXYBvIzGm5P6mt6rnP65MEp4rDsNDVH0ZcXiTIG4xdN8j51hVkrsR4cVZa0XZirRwzGAg39DuI7ZVDALvdS435z6OWLoG1VN970h68TsyxDy+ikseuNuiL+ISVA64VIpMd2L9b6gzncpvmxSAWU2NSNeVDNg3IRNRwV4XukJ12SF+xieM1kDmptpSctxDcIFs+iRwEvSxbtHIzFXAJrgato/es83O+glunxFgB6gXN4Zf31Bpxv9IAcbBiwcKlP9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(66946007)(83380400001)(36756003)(26005)(33656002)(110136005)(186003)(316002)(5660300002)(21480400003)(1076003)(44144004)(2616005)(426003)(478600001)(8676002)(38100700001)(2906002)(66476007)(66556008)(4326008)(9746002)(8936002)(86362001)(9786002)(27376004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0Qj9nYIDW3HeHd2K9DJhuNNkcOE1b7scTgEm/p8P6A30o2FVS5V17cvDgagX?=
 =?us-ascii?Q?WIVYlS5vI4JxQY+nSlsdgF6SnUkCYN/q7lnASYG0mjQSJF5/RblIIeTQDGw0?=
 =?us-ascii?Q?HeSTpa/LTjrbLXi7oiDKqm79CIgyR0Dh3vXlbXQ18PMq6dn86Jg8xLowMGBy?=
 =?us-ascii?Q?yN9V0PeQqPn/p5NDjh3O8ClD4ax+8hBl79mzmHShQKWBsEEsBZ0z0KNlflxe?=
 =?us-ascii?Q?BFNKqFRq5vyx4C/YaGNIMKJVNB2LcIzbsWQ6j7H/zOJWExasB3mKvl1YOHC7?=
 =?us-ascii?Q?bxgi8CeZFIQprj0OFt3IDLKHqOK2ZO7ucgasiKmu1PLoah6Amib4s2GEyTDg?=
 =?us-ascii?Q?Vis2Cy4KXSXD+ND5a/o0Ut+0u4qT07yi/k9DqH1OatNFKtBZ6P5sUvLJ9oG7?=
 =?us-ascii?Q?YSvk0HsnVk2LmM3M7zKuHXZu56VBMXh7TzWb/CxiKixpOkJQ9NxT0VGy1z4D?=
 =?us-ascii?Q?h1KZXYvCZyNSGx6I8DfnsN4o8d1ZIjhbYfSJOOns+qB4R8u6UOpTjqoqcyzq?=
 =?us-ascii?Q?GjxdW5n2LeX+AVcR27KsuZrv4lgFDdVoXmqdyef8LY+eKebRtKgBRMvjpL4r?=
 =?us-ascii?Q?TfD1NO5PohgwVHGT4I0PhkrbeT3OMzuPDfHqUmZOF/RQBYx0BsysIn4QBT3H?=
 =?us-ascii?Q?P4XFEok+fXOZf56AA5VGpCOcgQRJV5e67Kg1pe0kTc8X8kHArlDhXBwSQhCu?=
 =?us-ascii?Q?yei4KRIrLQcFwewTg20Kh+lfD5Rxs1rC0E8ATeS0NuvCN6DGujg6M19VKtX/?=
 =?us-ascii?Q?VDohKKIHDyxM5nu2vdgHOnceBxGXcZXH93GClg0pYJoPsvmCPlweLi0xwx4q?=
 =?us-ascii?Q?6AYLgYNKLhyXsC0YdS4lHStNkvmfzv0ka+u+0PYAugyMd6SxiTNSrAmmp0e1?=
 =?us-ascii?Q?aKWVEz4nIGS1N2fj0zzbi2SIOtyOqsPuiI7CLa7z0BHD0w0I/7GjIBx+r6Rj?=
 =?us-ascii?Q?RGPySjzoQA0B8fhOVPkWv7ZLvHTVhio+M6vjNsRea/18JgvrU2eWHSxnf9Ph?=
 =?us-ascii?Q?giWxcNJ0XidxBJm+vs2jW9AViAWGjcIuc5C9014iGvoOsn/loqiOhyUrlHhO?=
 =?us-ascii?Q?2hGznlx3hdQiGaQusGQ8vCOi6ClpLj36mRshk/P9fxz7jcXniN73jtY/3Bh8?=
 =?us-ascii?Q?B+XneupYdHXD34vqVTb5+ISfzIDsIIVvfWcgWrQn5f83SFqj9CYdiIT25tA5?=
 =?us-ascii?Q?amKpotbXbCdq3nNipNU3IspTqvDaiEnZXCcckVXGOb6ZBCVbZLyWZfaA3m5o?=
 =?us-ascii?Q?Eams1WMK1mn2GyHvb+apBS/ZJ5dwudmdCGAe1qP6FROLgYR5O9gMSgp78yYd?=
 =?us-ascii?Q?b1A6sos2OmCSVp6Nk0bBdzCQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2ccfe4-0724-46ab-931b-08d8efb86b90
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 18:04:23.2272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lh6qnGL/rzc9XO2A35asYwxR0tGHTt9WuM2oqtlKa/BLOTjWPySSpzyuOOD3GMRH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Not much going on, just some small bug fixes

Thanks,
Jason

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 3408be145a5d6418ff955fe5badde652be90e700:

  RDMA/cxgb4: Fix adapter LE hash errors while destroying ipv6 listening server (2021-03-25 10:25:58 -0300)

----------------------------------------------------------------
RDMA 5.12 second rc pull request

- Typo causing a regression in mlx5 devx

- Regression in the recent hns rework causing the HW to get out of sync

- Longstanding cxgb4 adaptor crash when destroying cm ids

----------------------------------------------------------------
Lang Cheng (1):
      RDMA/hns: Fix bug during CMDQ initialization

Mark Zhang (1):
      RDMA/mlx5: Fix typo in destroy_mkey inbox

Potnuri Bharat Teja (1):
      RDMA/cxgb4: Fix adapter LE hash errors while destroying ipv6 listening server

 drivers/infiniband/hw/cxgb4/cm.c           | 4 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 +++-
 drivers/infiniband/hw/mlx5/devx.c          | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmBc0KEACgkQOG33FX4g
mxo8yg/+OtUzwQItynJubR39Y0hPHJERlnfegP0kolgQUo/TRbxiuIGjEvX0FCG1
HUh1vogSMgzkn1b9HFDtCsbTKejq3ZHJoUh1n+Gn8zCcZU3wMwoeYvm6erCMYckY
5NNXg/zkNB1D+SEZf/n+TK3KJ02ohu/lPlTBXmzj/87bpg9WsWL5rWg3FDHr8gfK
sNO4q19co17zEDehh8JnZLrRus/eku3Z5rpVCNIbn2OCdtwYXga18ZI/9QM5emUQ
FanaZLKlHIRiEYJ0V//zezhEzUHmMK6QjAgJRZJCUZ4A6MsCgzFH1rqChcUnDbcU
RjFcQ0yUZCTKEj3rsP7NWlH5bjrQt/Tn/Qz0RYDasClYe8bqj5oWUfAdYH+yZme/
gRaGxBB5I55G/LTAum8KwdZ20PDY2SRsOJwcu0oRXXSs1K1AkFdrr+0cvQgGuiJC
3LenE1AQX/09HwpC4Zw+NiEvILA+UnDCf+4Zhepgs8jsDj7BQlN1F9QWf3M8/xb+
sSuQK65PT5ykTKMfaLXHAM9ydblFwlzwwzABzPb19DfIMMxtvqkSMgWI6zubfr/+
jz6Qw/Rw33RXkXNMFkc1RUMbDAc8GHmofmg8vHEB9Nr85TCxuK3ChLZ1Es4NwTtI
yYOomQVwMCvkj5X0QuUFNsTjtfzTiZzcF+FNX5Mwqm94AS76hc8=
=peaQ
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
