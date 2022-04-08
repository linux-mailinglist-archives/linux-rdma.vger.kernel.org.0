Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480C04F9D6A
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 21:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiDHTFg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Apr 2022 15:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiDHTFe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Apr 2022 15:05:34 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863B7F896D;
        Fri,  8 Apr 2022 12:03:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMaIw9ca5CITHXVja7f0CYsXFb+lbS1cKYZT0teXzrSfab+U+HJT3dHGbg9R9AFcEOEa4MFsGGyuxHGRrUSNVn1oYm67Fy7KXnPTZLwcizjJLpFnb5iT+5XxF/+JwP5e/SuLDQaN74pQsdETTEX/mlZdjy59cn6s976yWaywSkRFIVt5NgBfhUABT76TnvUhskglr8E0iFenUlGmcbbQ4M6unri1sFv/pUnXHiH2k0EFBSpNalDVXHSXtv7QTrRaGxHEvaqz2NrRLsw4fCciC5EhBCTz3QZUV7VlCPhHZDzojAZhaBkjqpADEl7U8GlpKJxGBYL7knQ9oecHYHnaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQrl34pvmPbLwI6YEhKOwefcfloYF9zwlMcf6ewN7LQ=;
 b=aUPUOPG2CR8GgXLvzGWJT1RinF0L3azlYLjTDPBZO+W/6HZ5qW0Fvz3Acab8Hv8YnKtVS0km9awU5CGWrYh4ISs6Vctsx0YJ1lVvV7yTldA6POqCT212xa3TbP/raPqHzRcXbz5rDXsIFwQC5c/XaELpWHxgusduxzCF2crbZVd3hDuZct+wDSUOUCeAZm0vDyowEOxWjK94F2s/eZV52IsVcBBRJ1u1nscDATk0jx+8t82DFUJMuDUcJEYApvN74dkyfkdUkYgr2a4g8bqhKDxeERAjoowU3koEGzaEVbQ79n8CAmCrao/hBqtp4ZF4KpNFj+8oWm/8dm4KYhW6DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQrl34pvmPbLwI6YEhKOwefcfloYF9zwlMcf6ewN7LQ=;
 b=p9rza6jg3MxWRp7ti7lKVAs4k6UdnkL+SMjCyIHmGggv7x4ldbSQzMVk+R7tAqjxhx86bInk3Noa2jnmr5HfV4boR7Namufa5wCB63FPwA8/+bTKKbbYAgiU/4kATk4fnTpXhgs5aD+AGRhu2Rhvc37F3rzur48vPGs2VY7fFmZwcL+3TxQH2STsLgrDACp6JhGE3c9bb1lhjGa4Ch/X8qD6GsS1Aq2ikWZN9pns9Oj7ZQJDS10T3ZikQGsN9mhSZQNt5UdG3y3d3vOSaA4FsNMsG6jyT/mrSqvR2zyBdKgpXKWj87ICAmhs5m91vTsJR9uAtTRLdr/tS7kyHsj1xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN7PR12MB2673.namprd12.prod.outlook.com (2603:10b6:408:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 19:03:28 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 19:03:28 +0000
Date:   Fri, 8 Apr 2022 16:03:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20220408190326.GA3698843@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:208:236::26) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 861eea8e-89dc-4296-ec0b-08da199276fe
X-MS-TrafficTypeDiagnostic: BN7PR12MB2673:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB26739210C1140B3957270BE7C2E99@BN7PR12MB2673.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rt8mmLvhTaIe0Gt8o1EByZqHjywFcXtvSI5JJEVL3p2xX89fyAm5kZ/mP1QggVF9kFpXUcoLKaDXtHD6MAt1U5vNKOnV9omQgvZ9D32czm8HfPRNCeMpZy47VJpsHgAUNAgwAfqU3hxj+KI0dAoSd33WP52Xqp57kVs0CS8pFqUmVbZw7CjaOtmO/s20I4Zv+D9Tl3xAMc1+uEA+fbTkkjPoQ+ej+ApbygNfe6ouPOqGIGCDJIqcGhH1n7tz6tKEXzNXTAg9bIdlM3QhDrJY+LPR+sVCt2BIoqEK80RDuz6t/HP10wHZnwHQX3b59cRgiS8JBOGKpaMyNrqqspYy1X/bMZ8Q30bhFvfpgpy/q/oXNSqMG4MaU0enZKw2VXzH34gzCyeYlnJ8EStL1ZSgaUtH4D2gBclYxGLl9rQI9s615GlRsWDOKkp2OvdZLupsyxRl2hBvST7tHP9D0vYEcWKfp6v03i7jerFJWVD1Oah5Y77hA3JgEsBFFw3k4FYKNlZc1e9ptyBbfz9JoyeneARdqFQ/yERd+9d0mSMbsJTTYQ93ASTbulefkTVrYycWiMev7/78im5Am8VilDHmUnlrnxRpy8LJygjGWZtks3gcV5MkH6shwCfchGgGcdsQlfZaWj+HE4+hm7Qp1NFR10JeUVtGxtwU3T8Q3BDUWvIBcCUIWqzE1QsA/8zE77lnPbOe1OgkcJzxHaHj9+Rf8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(21480400003)(44144004)(26005)(186003)(2906002)(66946007)(1076003)(2616005)(6916009)(33656002)(38100700002)(6506007)(6486002)(6512007)(36756003)(8936002)(83380400001)(86362001)(508600001)(316002)(5660300002)(8676002)(66476007)(66556008)(4326008)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dXYleWnhsccSRf1e1Lk3ViXEI6LsdIvQ2XcYwC0YLBRksuy7Kyv+ni5sipnK?=
 =?us-ascii?Q?VL1ktNZL4k0Teo8Ws0VCizrhlZ2RWt6PtSjZXOEXls7euUh68AHoG0swgFhs?=
 =?us-ascii?Q?wJtaGaIluTPo7CKyuF6GzHAd0nhWKzUJCwu/QYHjDSZVq4ADwCoATHOVYRdY?=
 =?us-ascii?Q?trNAEYZNZsNy4kmci/L9PeamK3J8pO1yMt+nQqrVUMpDAKT7bsim5sONrwLQ?=
 =?us-ascii?Q?8s7MC8t0h52tAABc/ubYT65C5fVqEoAQo4C0HmiUEgmmHYXGv902+wn/d9q2?=
 =?us-ascii?Q?BDSylW6bDmbuhcDgyMbCPhtyNHw9fSAEEz5CUzLJntofm4u7y3IsylOA5lKI?=
 =?us-ascii?Q?o3FKofEHswHeMOK7Wn9fQmiU4xqeUvfkVdaU+nRo52Y/vmkxOcQhVRg9hWJm?=
 =?us-ascii?Q?vJXbvNzb29gfEpodRsXuCUOnlJPsY+vlFRfGQ8RcTwz8ub+8IcKIIHch4FUO?=
 =?us-ascii?Q?gyQrBm6dstGma/+Z7Osusr5yb4b240N8CqsG0ZgMzDmcECpgrk/Q/WKfIvvs?=
 =?us-ascii?Q?abt5UqRElEJOP3zk1lZJbIoXj7fc6Ry1J+9mnLlJBCZoKBgAFCcpR8ihvd0Q?=
 =?us-ascii?Q?G0mOGmTaZ5dkZiKmwxPNwtset1Ml7kw2LfzAQHgnN6EjXhclIxKDs00H8AOW?=
 =?us-ascii?Q?4chWm7pzcOmhryzcsJr0tKKTW2OE0edYLmrnMZFnhAfUjz3F2rdtlbeXMsRO?=
 =?us-ascii?Q?EPwvcr3CdRt/b1x+S13CDQY3altLcUBo676FJARA269esAyESVkxzoCUkolu?=
 =?us-ascii?Q?UHsyBsEgP++OkUY9hT2zHmpwmUITHJ7i04Lv3LmwvKgBxzR05Mdwug56qJVh?=
 =?us-ascii?Q?CDDcGEJrZwDNkAqkkIOV2gEAxIfqLt8PaStIqmomGrmIeW5nwo+E48AuJfA+?=
 =?us-ascii?Q?CdiCFDxTw5nn8rh+wMSdW5/rgsk2lObOvZjT/VNrsBEPADxtlYBbxkb+10ZQ?=
 =?us-ascii?Q?u2zHux5lacvVnrxxono93wriLfqGrrJs/d9xTUpd8ndjLjMOIXmCywLdjWL1?=
 =?us-ascii?Q?u5z2iDF5E41g+lIHZh6yNhsIDlyyq4MF/KYNnea/1FNOnVnLOw/br6AAGSg3?=
 =?us-ascii?Q?sq4U2cWNehcTMn9UUgm+TAUNaOjNF5jYQnO4RE969hHlr+Xy5+s4EjuY6+9w?=
 =?us-ascii?Q?y7jDulDm50Ab5aHgauIFSakF8xcoLBuhYyrLK38S2Nqx/OMQ8m7KFA81X2qP?=
 =?us-ascii?Q?JtRTbJe1nlGWVDMWI9ubeUFF68lCeeKjVZWZ6+/V/oejKze5BAGsyjXJAOX9?=
 =?us-ascii?Q?jFNVaEPbye8FIwKSDhJwgjGNNUBsA8nD2M/9GDAq+HxhJBv165bZ4USzb/oZ?=
 =?us-ascii?Q?3K2On4j8KpOfbwx/aFm9DoClltAS7B9SkkS2TdTyX7Y5hfA3MDEZVD8j97Tj?=
 =?us-ascii?Q?lRSshk/G5v4WM2TgyprbQEkoQua4s+KTIo+KCe/I3jIkWdA6DK4tiyLOosv5?=
 =?us-ascii?Q?bc7lUmo4/0GnM3NSopG2Ew/TIprnbY2kNmw8IGDVTAxirptBhTYWjdE4+MMm?=
 =?us-ascii?Q?3fnkSF3oUnOV0Brxc+5rrVN5kuvi15q971hZ+Sc/e+IiOXxE1n/z8FxeNPA7?=
 =?us-ascii?Q?pFg0b53Wu/Gwp+qP8I49AnFY8dPxTI7ksiTjay6PIR1sMG9/E4tIndwKatNG?=
 =?us-ascii?Q?5KbzKCnlgsQTj5y6y/MJTiMmCGJ99qChvW4b8o6NzNCEWpTsmkEwls2c3N2A?=
 =?us-ascii?Q?TsWTrYgJBl3UoXs8ycKOymJGhcMmCAgfw8iiy98vGJWH8+LnY79SjktQFE71?=
 =?us-ascii?Q?BuG16IcHgw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861eea8e-89dc-4296-ec0b-08da199276fe
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 19:03:28.0246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ud0ltGyBjz3Ue4h7Ts1FFlZtJWJFtTVP0Z6obDhnlfK7VDI1k2136PcdvU7jgETR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2673
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Small rc1 update, there is a new regression in rxe that is still being
looked into.

Leon has agreed to help with the maintenance work. He will send you
some pull requests from time to time to ensure everything is setup
well.

Thanks,
Jason

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 2bbac98d0930e8161b1957dc0ec99de39ade1b3c:

  RDMA/hfi1: Fix use-after-free bug for mm struct (2022-04-08 15:40:06 -0300)

----------------------------------------------------------------
v5.18 first rc pull request

Several bug fixes for old bugs:

- Welcome Leon as co-maintainer for RDMA so we are back to having two
  people

- Some corner cases are fixed in mlx5's MR code

- Long standing CM bug where a DREQ at the wrong time can result in a long
  timeout

- Missing locking and refcounting in hf1

----------------------------------------------------------------
Aharon Landau (2):
      RDMA/mlx5: Don't remove cache MRs when a delay is needed
      RDMA/mlx5: Add a missing update of cache->last_add

Dennis Dalessandro (1):
      MAINTAINERS: Update qib and hfi1 related drivers

Douglas Miller (1):
      RDMA/hfi1: Fix use-after-free bug for mm struct

Jason Gunthorpe (1):
      MAINTAINERS: Add Leon Romanovsky to RDMA maintainers

Mark Zhang (1):
      IB/cm: Cancel mad on the DREQ event when the state is MRA_REP_RCVD

Niels Dossche (1):
      IB/rdmavt: add lock to call to rvt_error_qp to prevent a race condition

 MAINTAINERS                         | 5 +----
 drivers/infiniband/core/cm.c        | 3 +--
 drivers/infiniband/hw/hfi1/mmu_rb.c | 6 ++++++
 drivers/infiniband/hw/mlx5/mr.c     | 5 ++++-
 drivers/infiniband/sw/rdmavt/qp.c   | 6 +++++-
 5 files changed, 17 insertions(+), 8 deletions(-)

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmJQhvwACgkQOG33FX4g
mxqT/A//clPxTaovNGo3xUDEufN9zOuRnxeqLXUkuB3CdwD5FJxNQRNWWC6Ap/Wv
s3Jj3Mk6j702JNPIXpWnbjiBKqRvOn+LIav/2j74RH2kWZ6gmS5sEuyIjyNsbChq
yGTzvy39cPb3xQSxFmpxI6fRLLvCpFge38k0cuGq5iUplWtMlj32i/BsGN4S+W59
tGeXusk7NWgumzs10lT88L9rGDbXjnWonmEz9Nc2yCzz+f2EinGxGh5IMD+dFw2U
HInRDf8Y2hnr32OdydpXsIHWP3lFsCEr2qw9E79OpKkv1MKivsHE3i9tJHURK/ea
mPqRvH6dUr3I5vmtRO5dT9NRsGka7SwLFvoUVJqgnPCDVbCkmP+O/JAR9AK2itQD
ce4JZWvabKQh23z2mQFbQD7/2gbd5Abp/Ta7GScLNqsd/8GHKSV6hmWUwnkgAYqD
VTQfnlKXi9qKYMEfd7L1Xq7hvybZWjvtVvs9qIJ4SOK1+rlvVyscZWb5qIXSm4sr
kjHvuz3BDO4huFe6BVWIMF1zc5AdENoqrylTFUcHcprKr0tec1AdIgl24SA1dMMn
66K5U9IJ6EXs0Ewr5jXQegmpzzQR8T5lqdagkzH5SVGDo8j9Dd5MA+Rhous7MkFi
Wt9hjSnPoyK6to64bWqKAzuGTenR1JDO2pk7Z5N9glgpZ7Sjiro=
=DqAb
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
