Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4D06162AC
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 13:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiKBM0y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Nov 2022 08:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiKBM0w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Nov 2022 08:26:52 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9FC27DC4;
        Wed,  2 Nov 2022 05:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mf3zYr9cN6OcrKkJHsWNG94Z/oypBWwlHrJ+s8zdleWQVzoGjwTZIifzt8c3RrZZPRihSCtAc138OY0j/HOM/oR2cxmMiQ9gkv8DtJY1xCeg2rjVTjHGf0KuHTMJhfS80LQx1Z0rnRdAcgsZoHVFBiT/un3/hvlNxbXE8xyNOqzxgxSbNfu4bTx8xMAfWm7Nd8eSQhfZOgy11KrOP6wvFSO9S7S4kJrDJ36NGgqH9tbrxGFrwgxyDWIJzsY+0ZjJzeeZVR7zuCGzq+YU41K2whm0Mwa9l+vUubRq5yRBie4blNYiok1ZUR27I3UGKPIo4577zozc06SgtWchNM4PxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReQk3zRPgVzEU3KyCHpema5cQUAvFLcnTzuDMFRsKTA=;
 b=lnwXLX4A6HnW5LCwy6r0lw8JT7Rxb4wVr/wcePnMGaPQ/SSi+UV69PEBXrYSfOxLTA1eLlbLqWg2gEhH9noRhrimcl3Q9gVP8eR5gN59do1Cnhg5MKP0JEhWKLJ7X+vKeUPFaIemR0O3BwzFRwGj68NVne19jNGoSwosSQjYtcJCSFUjrtALftZEkkkPvpBV4srUR9+58ujBqTAsTf2OCswSk9utIEFFNIZ8ubq3yNMKtDqkqXuzSVNBm5wI/+MgsqWNSyWScf5m5OdDok4JnEeusDK2tHs0A5QwgLWqvRH/QHJ2x7V73N0UhVA9Da2GPYCcZndAAKjzgVdL2wlu7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReQk3zRPgVzEU3KyCHpema5cQUAvFLcnTzuDMFRsKTA=;
 b=QR4ncM3spbKcqTziNOdjTJIS9kr4fsHVRyqxKHmc3nxEFptrmVqDkBECsDWpPGnIs/sDLQvoJ9vBbQ8KATiHRx1py5PA9021jcqykc50Xw9iMSeZ815TN9xulJNehDucUpnDxerYTLT8iQAnMFCXVqkg/WE0GqfTlsPKjTco5iO2Su1kRQM+JpwKj95LXtaSMVFlvUxKmxnGus1mEkxJiq0OfXfKIGX6Gpb+b73QApXZ7jdqraRoA6g42Dj+D8h3FLk/jj2bM2alYBDMOaSw3NOGFXjFxwLhbyJfHTuSQRyFcGO0FHN+gdVr37mLLxLQ8WggCUfQNcpFe5SAPBrrCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7156.namprd12.prod.outlook.com (2603:10b6:806:2a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 12:26:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Wed, 2 Nov 2022
 12:26:49 +0000
Date:   Wed, 2 Nov 2022 09:26:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <Y2JiBz6YMTTFfxI/@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pi2VHx54BGkc/iZ+"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:208:120::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f90c28-1e57-4313-80e2-08dabccd83a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eR46IJegqYAwOQP0FJ0B+HX9a1EioK2SHMQ5xOw2cvhTsnW+jRIqj6bWUGIrjfI1Hi2APC1zQDNiX+pT3YQ/uoDaL5vpQSUwI4nmW/RX+cOCeuFlPR7a6A6SD5aO9jb3VJmG8NsfINkxpMNxiS7n2EFaMdp4Zhm1XMeM2LtoKs1MQiMwZtzk5crxqpciymLNBQJq8Ws1RMLpGRYDtEexGPELb1rnPE5zkMWL9ALfF3XDGHseK077FII6D5TEJHeEnut+sfnbuJ2kVvDZIT8Tyc9LhZbvyLL9jvFldVPS/hvClRADN927zdrx4/H6Px1xPgRIOLCqMUTYpnChjZgftK7QvL0im7V3OTRQ5BaZpBmYvTC5RxyDDcBxy+4fJoW+f95oJQaqhwv9aPnZpt5eneOSYblx5DaWAhBwH0DZDPlZtDJcVmEPeacfNbxXL8ov7cKPvIZt2OlrK/wFZwPbelY5q9tvh4/x4KH1mlxyQOLXVh1X5QzbdEphF8YVxHT1neeiVsTVfMutReotxDwBqWvt5ZJX5IdELDT+e2AS2k623nKYaeT90PjzvBCnW8Hm4mcW9Hm+bE3XCK1IkTaclb5TbLqyGegGgDvznC3kl9Fc9ThLGzopSu9FyyXQT9P+AOnsDEpw42pP5JGSMaCnPItZzCJNGk+P34dWnJSfdIdQKYpdLGX+VK99Rf0RxQMZJ4GS6E/C1LVLf8L5xcLLxcxhhI5/oK8h5NzMHdV3DkkC2Mv2vhucTuBnWdX4Osh4kWj84VGoCvvIlwL7N437uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199015)(66574015)(21480400003)(86362001)(36756003)(38100700002)(5660300002)(107886003)(316002)(6916009)(83380400001)(8936002)(33964004)(186003)(478600001)(2616005)(2906002)(4001150100001)(6486002)(8676002)(6506007)(44144004)(41300700001)(4326008)(6512007)(66476007)(26005)(66946007)(66556008)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFRhMkwyNHE1bEsweUdTQkhUSGNKeFI2SjFNUDlLMnJEU21Nc2p2ZVVWOWFp?=
 =?utf-8?B?TWVtV3BDRDhXYmhmWklrTVBkOFVESlZwQjJTQTBPQmhkQ0M0ZTJDYmV3c3Uy?=
 =?utf-8?B?WTJZTUdGVUZEQVN1VVV1MnpvNk81UGVmV2wrVGQrTEFrRE5Ma25Ud05ISG0z?=
 =?utf-8?B?UjRKNnpkN2RROEFQVG5iWXc0UXhKL3N0Q1cyRENKVkJ0K09jZWtLLy9oNjA1?=
 =?utf-8?B?ZWlMSHhvZjdKMGZwVGU3RFEyMkczbGlaM1FwQjR3SUVkNFc3TGxObDZvTEtJ?=
 =?utf-8?B?WkdvaUpHQ3hnb0x3NklCNGhyckQwL1lmSWR2Nm50ckdUNit4ZERMVHc0QXQz?=
 =?utf-8?B?aUltZVovQmU1K0Q2RCtnWXhlaGxDalFxMGR1bmhmaElYTW43OHRnN3pNQXlD?=
 =?utf-8?B?ZUpoWndtRjVQbExtckxVSnE0a3JJTjZVaGJNdDhCZyt3eGhlNkxSY1hQd29N?=
 =?utf-8?B?bmpBV1dCdHBVcXlzS2FBS1IwS05yRlJEZ0dldVNkcGxxa3doWVFNRFRMYkp1?=
 =?utf-8?B?Q1NLMGdIV05RbWU1YjZaSmlBekp6RUNzNEk5TDJJaXhIdDJqb2FxUWVxZEpq?=
 =?utf-8?B?KzZ2aVlFZUNjemtLUzRsUEpPSW0weFB2cnVESHlpN0YyTkhhOEFCaUNJZ0Nx?=
 =?utf-8?B?M3l0VlF6VWcvR3VyM3I0NmZERURnNUUrenlLSUFnempvUDRIM0tQRkpKVVgw?=
 =?utf-8?B?elFwdDJvemxIOFNvcFV4eElVY3BpaWI0K2ZsY3hXZzBYU1hobmYzaFRHMllU?=
 =?utf-8?B?NzM3ZHcvSFNkZ2JLcmtoVGdXa0dVeVgwRm5FdUVTYWs3U3hrd24vM0JpUzhk?=
 =?utf-8?B?M1dlbzRTemNZQytMUnBmcnFhdm5DcTVIUDRGUHFMLzBSNmphbCtiMk9SSjdk?=
 =?utf-8?B?S1JVa3BqVWRSUU1PQjhvbGxhZkk4cUpFbWlVNEgydVN3NHN1NHpHckcxbURW?=
 =?utf-8?B?N0V1akdNQ2NLSjVObVROeFFnQlA5N2hpTnFtaGRyU2RJUTJ0VVBNdG85QTJr?=
 =?utf-8?B?dFlXcUh5OFRSZ3Fra0w3a0xXdkxpMXc3dGZ1SVdFOFIvaUcweFcvS3gyVDYr?=
 =?utf-8?B?Y3JlNWFhYmxWRWNkTWgwOTN6VGxJYmUzSTRvNTZDUWFQenFFZDBDQTlwaU9K?=
 =?utf-8?B?RytOZnJzZE4wUVlNWXpUTFAyektLYXdXWlYwbHlJczc1N3l4T0tVV0RBRlRz?=
 =?utf-8?B?OHVIQWpNdHpXS0w2MTFTamVxamhQM2ZvTG1SZTRqdTd2Z1VsaGxhUERTbHF6?=
 =?utf-8?B?NGZCbXl5Qzlyd3FQRWg5RlpHNHkxU2pUcEJtWXFkYTBWaGUzUzNBQzEwR0t1?=
 =?utf-8?B?aXp1SDR5THh5TUpETnJ3OHJta2ZPWHd0dTVCUGJLR3hiR29hMkNyN2tiRnJO?=
 =?utf-8?B?ZXZLbyswcllrTytOZ0cwREJMc01GNWJvRm1Mcjg2ZjFLUm1XRVdqemR6b0lh?=
 =?utf-8?B?TDZkb2pCLzJ1aUpCM2hGN2dHK3B4TGh1VFRXRWxUVlJQT2o4TUxnM1RmV09u?=
 =?utf-8?B?WFNQWFJ4dGh1eFJNczk0Y05zTmUveFg3bGZBZ3B3bWZ6VmxKRjcvRjJHazJn?=
 =?utf-8?B?R0UwWlZOSGowNUoxYmNjNjczQ25ML01ob1l4ekx1TndYUXYxTHRUR29ROXcv?=
 =?utf-8?B?UXdCWG1wbVFwQTZ5dVZGbDNKdEVZeWZEa2pmLy9wOUkvbGtPUFBSY2d1VzlK?=
 =?utf-8?B?amtoS2Z3cVVob3JVaGFNK3BxU0ZqZlBWTTRxTXRzam85Qk95U2xSbWU2ZE9v?=
 =?utf-8?B?c1VSa1dnZDM1d09tQUJGQ3cySU5iYnJ4VVdpYVFFdFZMZnJnTXVTVlJZQlMw?=
 =?utf-8?B?Qy8ydkROYmlDRUt0dVJ2V3FQYjl4TDJZMzdnSmFxOEZSNnd6MFhBcFBuUmQ2?=
 =?utf-8?B?NU1NbXVTMk1BY0gzZ1NMKzc1cEl2WkNNOUlDR1dWaFZHdFJrMUszQ2NWdkFa?=
 =?utf-8?B?Nll5TEF0YWk1eDhCc2JqWEF2bklkRkJBak12S2tGT3EvRkY3MXBTZWwzdDl0?=
 =?utf-8?B?V09jUjFXUHZjTGNNdkpsQTRNeTd6Nzh0ZW5yenAxcDlLR1NhTEFMcFNINUR1?=
 =?utf-8?B?b3ZwUzVyeEZVNzJzeHVRT3FPQkMxL1dRdVlKL1RNR3NrcnEyeUdpalkvaVZp?=
 =?utf-8?Q?xJgQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f90c28-1e57-4313-80e2-08dabccd83a4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 12:26:49.0041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+Fz6+FcGdVnMuyxnpLA07OyZj1iqgcevF4WdpxQVGLY3n74mpGt2aq7okuO8/Y/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--pi2VHx54BGkc/iZ+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Small set of rc fixes

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 7a47e077e503feb73d56e491ce89aa73b67a3972:

  RDMA/qedr: clean up work queue on failure in qedr_alloc_resources() (2022=
-10-28 12:59:40 -0300)

----------------------------------------------------------------
v6.1 first rc pull request

Fix a few more of the usual sorts of bugs:

- Another regression with source route validation in CMA, introduced this
  merge window

- Crash in hfi1 due to faulty list operations

- PCI ID updates for EFA

- Disable LOCAL_INV in hns because it causes a HW hang

- Crash in hns due to missing initialization

- Memory leak in rxe

- Missing error unwind during ib_core module loading

- Missing error handling in qedr around work queue creation during startup

----------------------------------------------------------------
Chen Zhongjin (1):
      RDMA/core: Fix null-ptr-deref in ib_core_cleanup()

Dan Carpenter (1):
      RDMA/qedr: clean up work queue on failure in qedr_alloc_resources()

Dean Luick (1):
      IB/hfi1: Correctly move list in sc_disable()

H=C3=A5kon Bugge (1):
      RDMA/cma: Use output interface for net_dev check

Li Zhijian (1):
      RDMA/rxe: Fix mr leak in RESPST_ERR_RNR

Michael Margolin (1):
      RDMA/efa: Add EFA 0xefa2 PCI ID

Yangyang Li (1):
      RDMA/hns: Disable local invalidate operation

Yixing Liu (1):
      RDMA/hns: Fix NULL pointer problem in free_mr_init()

 drivers/infiniband/core/cma.c              |  2 +-
 drivers/infiniband/core/device.c           | 10 +++++++++-
 drivers/infiniband/core/nldev.c            |  2 +-
 drivers/infiniband/hw/efa/efa_main.c       |  4 +++-
 drivers/infiniband/hw/hfi1/pio.c           |  3 +--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 15 ++++-----------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  2 --
 drivers/infiniband/hw/qedr/main.c          |  9 ++++++++-
 drivers/infiniband/sw/rxe/rxe_resp.c       |  4 +++-
 9 files changed, 30 insertions(+), 21 deletions(-)

--pi2VHx54BGkc/iZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCY2JiBQAKCRCFwuHvBreF
YUPRAQDDNwABsVR5P1OpHDjZBqGzeId99J8CBB2a5SCj3G5sHQEA479dt53ElTiV
NoCQD7o2BeWAJtTMAkrN9O9MQQOulwU=
=Y6bH
-----END PGP SIGNATURE-----

--pi2VHx54BGkc/iZ+--
