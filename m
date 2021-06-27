Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036B33B5353
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Jun 2021 15:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhF0NJ3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Jun 2021 09:09:29 -0400
Received: from mail-dm6nam11on2088.outbound.protection.outlook.com ([40.107.223.88]:40033
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229817AbhF0NJ2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Jun 2021 09:09:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4SKYCePF+5vWu4pVkcoJdru6ucNOPLjikWqvIxumpPP2XQhq2qstFedwuHznQ2PAhd44dSYCw904pCt8x4TR5bqfvNdD3H+WipgeYEEBLC1Ic3bBfehQiWmHgVuWU8MmJzau+/JgWaijFJ0bANHTUp0Y+poEf0yHfcYwa5iRt49eQBWgoZSRC2YgAYNS1JzwgkU7leJcPhzLadkR06+eGogM8ZVdjFFyLKvOymrtKMiIp8V9rc1URl/MFkxJH6aqHwz9ItlwEOZ1pDsXBZXaUUGGvVKvLt/f1kQpCwii3MhA/8lZp2Lv6I3ZJye6F4J43Y5KMsI3G/W5WFK9swJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjZOMPqMu7f7vsgffh9IdebVY3rqpnxmJ4CTZwiJlVQ=;
 b=ElE+13mforhyXpeqbjw9KhpPXQxwpwYh5vvvLPi5j+eplkNNast1YxMm0jIN30tB2Ub/X5FkkWnW51UbujC8M5zD8xZocG3/JjrBQN2JHHfYZGJ2dwTo1p0xQeqlNG4zv29FT3516ll34hpf3VCwl5FpikoX7FDYYGemYVK7kVGR3sv2LpL58Vc21isnEjCn/WHSW5OFudne6rDztiZsjP0xPE8GHJsJmHmqVfPIUn7Zc6AV7xre4XF7C4JBMBAzryezm95XwylM6sxuRDeni1cmDSEbdPrUecVCMwVxiLB0pbPKEW2Zkl+9hbsG4NAi0ibdJ5TzSjBSO/PMwMtUgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjZOMPqMu7f7vsgffh9IdebVY3rqpnxmJ4CTZwiJlVQ=;
 b=QRTjjmobMYuz2NLAx2vaJs8Gv3MHRry1rEA8ijdXqN2yAIQ4LCj1wMfYVwylc5tihkeqxnG+gyMvNYhzRn2AR3HKkk4OKOHsLOQ1AiyJe7N8WIfDUrnG3/Ec6XVuV+N7BrN3xHEAmoPsch9KR66OF5VZQElT5wLhrkMxxSKV93eAae9F78KSphMe77HQe8gjS0AGxHLxR7nTf0ptwMLYrhjJtf1Jk8kDH/L/5Sr1CGM1vmALKfUAf2FkJgsqurvQzkEW+HiQWeEqpIAzpTb6s5zEFqPMjHnHm/UvHZbwF04gLMzBTwVzNQyqwYKe+9afMITxcwhBp/jnCfn6+r8YEQ==
Received: from PH0PR12MB5402.namprd12.prod.outlook.com (2603:10b6:510:ef::23)
 by PH0PR12MB5433.namprd12.prod.outlook.com (2603:10b6:510:e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Sun, 27 Jun
 2021 13:07:03 +0000
Received: from PH0PR12MB5402.namprd12.prod.outlook.com
 ([fe80::69d2:50d:3dae:77d2]) by PH0PR12MB5402.namprd12.prod.outlook.com
 ([fe80::69d2:50d:3dae:77d2%8]) with mapi id 15.20.4264.026; Sun, 27 Jun 2021
 13:07:03 +0000
From:   Tamir Ronen <tamirr@nvidia.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "ewg@lists.openfabrics.org" <ewg@lists.openfabrics.org>
Subject: [ANNOUNCE] ibsim 0.11 release
Thread-Topic: [ANNOUNCE] ibsim 0.11 release
Thread-Index: AddrVLzd5PhpqRoeTzuVMZCF5nR2tA==
Date:   Sun, 27 Jun 2021 13:07:03 +0000
Message-ID: <PH0PR12MB54025ED9BC49B4D2A1377E27B9049@PH0PR12MB5402.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [2a00:a040:199:82fb:64a3:35c4:319b:b80a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 141efcec-7a7c-4775-d012-08d9396c7535
x-ms-traffictypediagnostic: PH0PR12MB5433:
x-microsoft-antispam-prvs: <PH0PR12MB543326CD1A5DA4A43B0951A8B9049@PH0PR12MB5433.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XoJL1tC63J9x4tzoG0m0vpOVJjipt29A06OTPbp7KnBn4RxPaiMNTd8FfKDM8ajBaHryYy6IiF0pi/3wGDaBB+g4HJKv9czhS1pce/EELEZoNOiiNtW7XLrYWPYsYLy9K5RXlIP0sgXhVBcMTDd5iZbIk4/KVcy7yaFGNAh1k99llu7W/V7+TNsUx7vHo7uTOsj62S4EpwK7OgVoogxIo85NVDjaXTDjwQTKaB26R9ngJBcDf3/3LeWmZpQvPq9RmX8Y/nkj2RnsI0IA8bIkaGRTaL6lQyukbmw+L+kQJ0D3UHbG7hS6EMak4we3wY5cp6fxqiPgEOABtSfSPox5IgEtnEBJW7SFPhvcNCBSxj384NWE/qtXyOkifcgUW2lqj/0oiGWGUOoVbeL/+svOWSOx2+MRhdgdB++lDfCtvUf1NIFgEo82yQFqrMAnuBF4JVMeKko7p0Vp2Mj+Gj9B0prlFCNRaqs7dOP82/G7vkYON2sXq1lzk6cH6yM3L+lQIrDPfkgxD4jmGX7+sJGYCXZLozfu6WuFhoyvGpRjQCUt6KohIgix/dpwlBrIwVGk7cLyLRYO4OylEIE2aUwFqNvLWhwRyFyGCTMgKitT9rjUSYb9vHR/d984mhiL3hPFaBUhuSMmMbQUcEilG4CaAh7+WCvJ29zbRoJtM1zcwH6/H+Nx8XZKtE3Cp3c+S5fWNyuWZFpz34hQfdrOmij95uAp+y5Z4ORlFqzv7LtjyhWNGITXRE+Bl6gyxk5kIvdnOOULjJ0vxx5Y/7D6vks5ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5402.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(55016002)(7696005)(52536014)(8676002)(83380400001)(33656002)(9686003)(8936002)(86362001)(2906002)(478600001)(6506007)(316002)(66946007)(110136005)(38100700002)(966005)(186003)(122000001)(76116006)(71200400001)(66476007)(66556008)(64756008)(66446008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tUywc8oxW1PnX1gzNtYO/Jzz9b5rkKQCQR/Kt8pJBhqwiAUHAnGA9rCLqsWS?=
 =?us-ascii?Q?0qfsJ3bf7m/QZTbcjRagfpquv1WbME3W7qTi63CNmBnQsZGNoc5WkG3Eyegc?=
 =?us-ascii?Q?jlhXi8RuNz/kJv/jJz7Rlsy2M7srQKjKBJCXo5ZicpP3u2TzRZGjpM+ZNn04?=
 =?us-ascii?Q?xNMkJQ/DXMj1hQIKmK6Zgk+RlDqueGxaQJ8/J2eL3ZKeQ3tcY3dvvcOcE1V7?=
 =?us-ascii?Q?5piX858ZwcDFCEb0ivx8GDU+LKXSPr9HADxpQnqOqct2s2eb9ZUma5d6fBjD?=
 =?us-ascii?Q?GkuEdZnLMKlznIkVjZx/eDIoRr+BXJrfZj6XxW+sBXeQcdy/8gMVjtKY8vfP?=
 =?us-ascii?Q?Tq49mqlhd4EcO2ZMd2l7O2EVXmrp++WpHaJoilUc1yGPIAFG1bNWC7AhkxwV?=
 =?us-ascii?Q?kyWHZ+Nz+wQy90vPOsingIfM33jo+T1rEBsSRhsM9QEb0BcjwqcAxQhof59U?=
 =?us-ascii?Q?bOTnNd9w8GViKd6ZvjYWwtLGD9aPkAL8wsEPyirvl20w5nacAyvIyDUdZR5V?=
 =?us-ascii?Q?MdlerjsHPBWBTIeiIV2O05CPzxqoWIbJxcQV0yGmvqXasqua/y04cu6N26l2?=
 =?us-ascii?Q?/OB4j81CbPK8b8Iz/voNkK+4pBW9zmHDrGy1kXmm54NQUGuaqcDlo+93D9Yd?=
 =?us-ascii?Q?lGxFDiLInmbS8rwqInl/8iGjVajcUFu0VC3nKOzVBkLYNNH4TJ2gJlplBgfd?=
 =?us-ascii?Q?P/m3usjbuK4lhILPfihaJbajiDNKQitbAC1uHw769pUhO+1j9Rl/DAkK1n2H?=
 =?us-ascii?Q?eytiA1WZy6UCrFdw4TjhVRkUyFkB0zf35ESv62TqPywCUn8UmWGMxSytSyD7?=
 =?us-ascii?Q?KJH+UO2fXaPSCfZRhqoVcmZc0o2nbA0Ee7u7a7dDiX/wUUEkcpqpMcEvsiEo?=
 =?us-ascii?Q?cAgQKkWaq8lB5TSTAXY81/aCtM027MTIl9aTHzRrDoZn3fWd7ry6C4dW4Qea?=
 =?us-ascii?Q?mSYwA+KCd77ePyG3XJhYrI7uwhbdxIAVCy1wmXGohpFdm7tfcXPAMsNZ8IPm?=
 =?us-ascii?Q?bw72hVBrP4Q8Ozl3+vSPYatiRIfgJxLfud4Y1hPK3f9D2qOiDEXcv9l/RpiP?=
 =?us-ascii?Q?gNupRC3BHTPqmsGvql7YnLIzXqj7K4wI6ROm7ZbsempX4OGJIMLPsCk3IQry?=
 =?us-ascii?Q?CA9BM8OZaqLys1DnSoQCRgvRxf9GJAt01rhqSMMYnKJFr7RRzzXrRgr1fVoI?=
 =?us-ascii?Q?S3cGfdNRCSyHoHvvIUlxApIDYkuBzQxo5bQwC74sic0vAP51B4Wk/LUYmxIe?=
 =?us-ascii?Q?tWuRee4mGI8mrKS2YhW217v0ic8AIrBQUMDFkM+YMaUvym1YtTaOVRoZ/4Jo?=
 =?us-ascii?Q?AXE78WArhX5+cXOH7Hdoeph1gbM6ui4sZPO1a65Q1P+PLGC95fZ9iw48fmYO?=
 =?us-ascii?Q?HspOPNOWXyeVno/jMgsVWKwUPcYD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5402.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 141efcec-7a7c-4775-d012-08d9396c7535
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2021 13:07:03.4302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qN5zHRdw79JK6cKIXKyD4P3h0vUCfalrzcLDQVZaBFO9FkIOvIfkXbJpNWb8OkrKyeX0tP7vl4kdg5tLc7Muqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5433
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is a new 0.11 release of ibsim.

https://github.com/linux-rdma/ibsim/releases/tag/ibsim-0.11

New features since 0.10:
Add support for NDR link speed

All component versions are from recent master branch. Full list of changes =
is below.

Tzafrir Cohen (8):
      typo: scrips
      clean all bins, not just progs (including tests)
      dist.sh: Add ibsim-run.in and spec.in to dist files
      make distcheck: Check that dist tarball builds
      dist.sh: update version in debian/changelog as well
      spec: add ibsim-run to list of files
      make distcheck: use latest dist tarball
      make distcheck: delete checkdir when done

tamirronen (5):
      Merge pull request #28 from tzafrir-mellanox/distcheck
      Merge pull request #27 from vladko1974/compilation_fix
      Merge pull request #29 from tzafrir-mellanox/spec-ibsim-run
      Merge pull request #31 from gregoryl-mlnx/ndr
      Merge pull request #32 from haimbo/disable_IsVendorClassSupported

Leon Romanovsky (2):
      Merge pull request #26 from tzafrir-mellanox/ibsim_run_clean_fix
      Merge pull request #30 from tzafrir-mellanox/del_checkdir

Daniel Klein (1):
      ibsim/sim_net.c: Remove IsVendorClassSupported capability bit from HC=
As

Gregory Linschitz (1):
      ibsim:Initial NDR support

Tamir Ronen (1):
      ibsim/ibsim.c: Bump version to 0.11

Vladimir Koushnir (1):
      ibsim.c: Fix compilation warning
