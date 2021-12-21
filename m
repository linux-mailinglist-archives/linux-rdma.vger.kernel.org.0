Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B716847B6D1
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Dec 2021 02:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhLUBZn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Dec 2021 20:25:43 -0500
Received: from mail-bn8nam08on2063.outbound.protection.outlook.com ([40.107.100.63]:6241
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229596AbhLUBZn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Dec 2021 20:25:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaEg0OPbVW+BkjavblKNOF4pN2fz8r8OCQaLkWCYVhzVFuZgrco8W3jltZoqEEZVGCH30aN62/Bu4JKk6vtPkuQ9fR8pPG1z0Uv6WnTbRSrBfH82+y2vIXEeSjmP8G8yuhCeYBJleln2ywjhMwU1x4/P6kCRDaM/0qAHv7vyzHxDmdqya/zDWjPWDXOS1LiK45Bc1uMtcw2w17iACCa6eCscC83MJ8dr9VxiTWq8ETp4ShG81q0FcUkox7eOMFuOBQhZSlxTXKtEExeDAH5nEMKyKvEPfdnlA+Q1ZtfDU2QC/4FlsfttwKpPEE0P/OEajuvbokVH91iFPLVhdgqjdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G78txVDzL/UTsiRKmKxUHzeAfCLRnhqThboYwn48l4Y=;
 b=nAa5CCHC7Hq2jCmXZSWCnzMbPAHjS+zokUALNIATLa/O4BKsZJ0bcVfxM/to/F95rt38OcXRP6HC3IY7pMVFxrrn2PGKBoIcj42N7ceOVih7A4CDZ1Y3hKssQITHnAwIlc9OTg9NhM7qlgxztme+n9gjRw7CaBtLqTUeHnSOmBmYpXnIo8I6T2FJUknxX4vjCC6riELxJgwC0OyeKc3jIcQhN4bURpu6ujXc5Jcnz73975LfOCvwDapcjUiRcgwuZ0eT8VqhQb08FfabM1CoQN56XXLWxIb3RgO2l8ycav0AsYzXmfpBp5FPRwxO765XZtTDT9mmrUKZlwodRsdmcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G78txVDzL/UTsiRKmKxUHzeAfCLRnhqThboYwn48l4Y=;
 b=DrCoaGpB3p/1W3ODyhFxbCtoURIWDneDG9aDdlR7O8xqV8o0U+WT4xPTnvWzkjvN0BZFm0rwjUP05yePEPqQTwPXcIRUmKTdjLWqpgf2IjAiWCYJxiImqmvV4AEhylQ/U16XWiHFO/AbVmnSaWwDegbnQdhJz2mgVqUwqOa4hRoQiDWNgighogpHBN7IlMPaxdfI3k1yY6Pj0ZPlrK66FGkZ8+AyA9ZKU1XMud5i53jRjDS9ewdlm/B9SxhotIN2Hbdo0ANRTnNRUPv2QoKcc9PuIgzojU5buc1OVCHZqMtU4zP8W/T9Tm56FzAD3AJ4KygD3KP00zWTPnYWK3uzBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5096.namprd12.prod.outlook.com (2603:10b6:208:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Tue, 21 Dec
 2021 01:25:41 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%8]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 01:25:41 +0000
Date:   Mon, 20 Dec 2021 21:25:40 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20211221012540.GA1665423@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:208:239::22) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 746fc7db-1bc4-4fbf-b7b6-08d9c420cd65
X-MS-TrafficTypeDiagnostic: BL1PR12MB5096:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB509651EB76C3C04BEA5D9E2FC27C9@BL1PR12MB5096.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pCW8v53PYrBpLcF2WnaXIjldOuhD0HB0iSGHZvaatJM/z3rgOGzRQ3+g0aucyZvo3gXA2e7g+bXICJozjeezbHaMaGSsO+c6t4/NptSXKpU7rEZgnU2/sIS0p5CD5vI9DBeAFD5Zt2Et9TxvpplCOcyiVPfW/0FX5nG63dX50w7+xhj1wLP74Hq8pN5gCDws4mdPjI1XBYzQh2RL419UNVUHc1WGJXpkEOxoqXGeLq4jXn0hXlbcGn6cyiiSTagNFONHau7L7Pt/FePEvQx09FJEB71hP/3IVpqzULj4ZSL3uf3wgumQGhMnomoisdkN0or12pb7X0w/DeMByXSiPgI6EPsqwOn/vgeVVM+m79pV+oAEG66Yz0IaYF8evZbOWBfJUnp50h8WWtfyVZEfAYy/HUiKVM3q02VFtv4yK48H1ciAACag1WizMzPUp2KM1gwvSW2+JZJDuoA7SnRwbvnP9ySQfJWUp5AA94BVscJZfuF4MgfglzLKkhGw04PMXU2AxOgdRpk9b0OoWKa9zwtpZIpqWSiHXiH62Q44J2+Xgg31SWLZHdk2cQFGRnhzwzHg4foG15Sx5pi3y3FDpWnedbibn7CbdTnL20dnPBPTGfqLEMRrsMZ1ZA9rgIGpvQ3v1jqiqUCYdM/DN4NnRQ6U9iVvbc9qTj9uNS0yk2hGhr2Byh9GwxDk9EeerfgQNFbdB6PpnrfJm33Cy8gX7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(6512007)(21480400003)(2616005)(26005)(66946007)(2906002)(6486002)(6916009)(508600001)(6506007)(33964004)(4001150100001)(86362001)(33656002)(36756003)(316002)(44144004)(1076003)(66574015)(5660300002)(66556008)(4326008)(83380400001)(8676002)(8936002)(66476007)(38100700002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ly9CM2xpZWtEd2gyZS80c0RPb2ZJd3JMV0JUb09sTzJoeGR0UDA3R0JkMzVZ?=
 =?utf-8?B?ck9SWGFLc2UyNlVnd0gxNXZtdFNKM2ZPR2Y1dExwcjBXc3g0L1k2dUNsMkYx?=
 =?utf-8?B?SXBIM3hONy9GcXdadWNiSStUT0dSdFdJNXZRM01xV1FJTzhxbzQ3UzJIbzFi?=
 =?utf-8?B?L1VUUWQ0aTh1dGNoQUlUbHppWndWVktrK05ybjdGNzdKOTNoYTcvRWtXZnMy?=
 =?utf-8?B?ZWtrRkxqRUpGSVNOdUhRZWQ1c1NHQUVTVFJFdkluMlRQUE5RRm41TUJHbWRl?=
 =?utf-8?B?RjJOQ1FsNCtIenBUd3I2bTNhV2svRGVxT0tUWkhIelVycUZoMTQ3VU9FTk04?=
 =?utf-8?B?Q29QYjg2Z0h2bGFDc1prek5IRUdaYUZubXBoMUQ2eHZ1QktGeFdPMG1UWUps?=
 =?utf-8?B?UU5kc05NOGVRaEY4c2xsZE9KVmNleHZmZlR2VW1NL2QyREFLekZNOTdTRG9P?=
 =?utf-8?B?Q1E5MzhzdnB5UDFNakE4VlBsK0RWb0lHdDRvTGI0MmlpRmQxY1JLTjJ4Tjgx?=
 =?utf-8?B?aWdRSWlyZG8rUCtROFNNVHNTc1hIUzF1VmhVbW1yY1pTUEUyZ1IvRXNLMUNE?=
 =?utf-8?B?L3VGOGUyd2htWjhCb21LQVhWc0Y4dG8vbHRuNERkVVZYeE1oWnNSQzBCeVRR?=
 =?utf-8?B?cHZGSkw0Rjc4MFg4eFgzZ1FER3ZLNXFHbWhzQTkxQ0xjdldSTmR1SHJ0NGU5?=
 =?utf-8?B?R3RIT09jQlhWY2lJQnRqTkxlZTJCdFZHZzEvaFdtR3RreUY1VkVaYVNNeTZo?=
 =?utf-8?B?dm8rQ1FSZnZwUTBCcHpsYitHcUtnbWhta3hEZk53b0lFbnpsSURyUkRuTmVW?=
 =?utf-8?B?dUlsZTNJeS9vcVdaMlpza3ovaHZCcVAvRmlPN3FjTFl6dkY2VTIva29ZUjdM?=
 =?utf-8?B?KzZ5dGM2OGdqYWxwdDhYSzJHQlhERVNUc1JURlZHUWh4bkM0a2FWakw5UFRF?=
 =?utf-8?B?dnZpb0ZwTDFOUyt3RzNYR0JRb3BCYURhTitycXJ3bGwwbjE2OWdXdmhmTlRi?=
 =?utf-8?B?eFk4cTJZNVczVTBsNDZSckwzcHNDc09GZlAweHF3Y3NaK0RrUkg0WFUyU09v?=
 =?utf-8?B?L3JrSDZZdVc3enQ2Mmxzd0tLTTBpNm1SRUN6dThhNjM4aWJ0enRmTDV4bmxm?=
 =?utf-8?B?MlJkTjAxWXRvdGFWNEhPcm9HaHFOMW55Q20zYTNEeC9XNURFblVrQzA4RXJo?=
 =?utf-8?B?a1lJTlNLZk9LWUZzNkh0VFBzVXQxRGlWZ0dvSVpVdTR3eTZpSHBwZHF0MTNB?=
 =?utf-8?B?RUs4ZS82ZTQ3eklxZ2l5ekd3UGhtVXpOWmx1UFRkeVo4VDhNV1VDMzYyZEFh?=
 =?utf-8?B?bVVBVmVRTnNUTWRET0xuTkFaTTBSbVZMbXlseHVBWFc0K3UwcUNadjN6bTZu?=
 =?utf-8?B?eFlQa2YzSXpoNytwWisxSTNkSmx3TWowM3dFSVFpQU9NdkNpK2V6SXJ6RkY3?=
 =?utf-8?B?eVVOVThIRkJBVTUyUEd0eVRuS2NxR3JndUlwYXhPU0M1SDZBUUJuQTJxVVdu?=
 =?utf-8?B?OFpjTHFmWThIRTJPcVh4Vk8xdEN2c3R2VVVmWlFXclhoZk9BanF5R3hKUmxJ?=
 =?utf-8?B?dXh4MXd3WjJJZzkwZHljcHBUWGpFWmQ5NzdmL2tITlJDTjZ5dDBMdEVNUnVR?=
 =?utf-8?B?L2lBSm42bWFqRTlKcnd3QnpUM0FqVmw0VFJaK2RuNjNYRUZxUXhlR3J3d1p2?=
 =?utf-8?B?cGE1UXR4aU1MaFZvWWJFSjd3dkwyK0Q1Nis0UmRUQ2ZuMWluTEVrd2NtYnJr?=
 =?utf-8?B?T1ZsYWh1cmQ1V3ZPL3lIYTIvcXhDN3NRWXA3TW52UThCVHZyRUJ1OVBnanR2?=
 =?utf-8?B?YmhzaXRhSW1KSWNmTXh6VWtnekZibjV5eHFLME0xQUg0OFRuY2RZL0Frd3lT?=
 =?utf-8?B?OHRkM01VaENodVRrOCtTbWZnNGRlM1hCMXF2NmhhSWJlNGZSOXYxeDVINzlU?=
 =?utf-8?B?OTFiWW5yYlZvZWR3Q0x0eFFZTUlUYVdNTWxyY0pvc01uZEZrK3pvZFdRbzZt?=
 =?utf-8?B?eDRvUTcxckJjdHUzSGhkUTFuNy80YlFXaVpDWUJRWGlsZHBUQ3BWNTMwZXlH?=
 =?utf-8?B?VEJUcTl1eFNKRTB6WGx1QVRFK0VLa1k3YUpaUTFqN29DSHZZQ2VheS94K28z?=
 =?utf-8?Q?MbeY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 746fc7db-1bc4-4fbf-b7b6-08d9c420cd65
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 01:25:41.4254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zns85N+YIncc4v84jEs8rj/cY/ozEqTNnQgtkX9hSdWJzfrMDD0l7qVdT3Fpx21O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5096
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Getting RC patches out of the way before the holidays. Nothing very
exciting.

Regards,
Jason

The following changes since commit 2585cf9dfaaddf00b069673f27bb3f8530e2039c:

  Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 12d3bbdd6bd2780b71cc466f3fbc6eb7d43bbc2a:

  RDMA/hns: Replace kfree() with kvfree() (2021-12-14 20:13:29 -0400)

----------------------------------------------------------------
RDMA v5.16 third rc pull request

Last fixes before holidays:

- Work around a HW bug in HNS HIP08

- Recent memory leak regression in qib

- Incorrect use of kfree() for vmalloc memory in hns

----------------------------------------------------------------
Jiacheng Shi (1):
      RDMA/hns: Replace kfree() with kvfree()

Jos=C3=A9 Exp=C3=B3sito (1):
      IB/qib: Fix memory leak in qib_user_sdma_queue_pkts()

Yangyang Li (1):
      RDMA/hns: Fix RNR retransmission issue for HIP08

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 64 ++++++++++++++++++++++++++=
----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  8 ++++
 drivers/infiniband/hw/hns/hns_roce_srq.c   |  2 +-
 drivers/infiniband/hw/qib/qib_user_sdma.c  |  2 +-
 4 files changed, 67 insertions(+), 9 deletions(-)

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmHBLRAACgkQOG33FX4g
mxqgxQ/7BRmIRxmDXoGqZpXvoyikvukDzStenpzBrFSeI4cjoXhXNHV3/IkzpNhI
M/1V8S94PZ31ZYZvj0qg0oca2MhCSoYTQNYQC4xo7Smn4Am9e58906j5uEEtJyC+
XZaAhsaLwzeA+7fot9dQgVKrsIz+dxDgJP+fIKVxtsrolG4ycPCkeDKtrEYVF6gB
ZWsa5NXe0dBAucMgaGhfDGi40ePWVVWyxO+4oj+9tLDWM6b56CYkVjLSrLANKGXr
VWBJK1rTqYRV0LCB+PuIWA1In7j4ApyY4sn2AzlhrG5Q1NK+n3eluaKuGrFeAegZ
/EGCDiPjApFCjsbEDDC2ujZwtgJkUtChB+laow2tOxlLKS3hs7dvEVtTcntFzdHn
M71u3UAgvuMkQc4ZDFPqx6tebyyp0AeryW9PpAQEJDe4+OtFGS4ROrtZta67gyek
cD0607S8eQkOelfIWY7NHxKwkKDtrvtEPhFQ9zumI/o8ogWBQ+iGditsrLof4dqm
UI/tY1f7zOa1ux9r2F+hkXSTkZf9n3mPsUVg0Q7tF/O/pOODb/pTcaF9R6mv4kkD
FGfj03IFB5jehKLpdogaltoq7ot+Elc0zNHbVprrcj5glIu7/P1XVQwqJRBvAAqz
SsZs20fX4kaaUHRshqHGMkaDKciO9O3qP7rE2dtfPEAWY3LaqcA=
=v1dX
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
