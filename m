Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D907D7B164E
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Sep 2023 10:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjI1IqG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Sep 2023 04:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjI1Ip7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Sep 2023 04:45:59 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9074FAC;
        Thu, 28 Sep 2023 01:45:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCJqvPlh+uNz+NDeO8tXtR/jhqlJEFhSR755JVzqxVJUKuqoQeunGvyWVHBAG5HydAWqUhW1X4U/odJyDXx3Me4vEjWb4NbLc4Pvebtxdbu+DDG/OC8wuV54PEKoW9kGjv0/VbRcjsSfyPfYQQHcOfCw1p2xbyFebEXujxlIBDFoBe5/ZDWd9J8X9u5r2rOsgrkTCgP4Ax5A7kBf4Ywuv/XJ0DkFieL3KqaTCqwwps+YIVuSbqAGPytrpqTg6s2/y7I/Bqge2QOwVNiR1Q01eAsNHOyNXO0Xa4zCxoegvGkPtLDTgu1v5PDDXlt46hjScc0uJJ2a4XU4CKmCOiV/VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zp8eok+lsZyvgMj3X6hwPEcODvBl699lU4fDp4q4bVw=;
 b=CMGCu+sUF57J96t1Lf36ope/dQyoBDfBuQftE88QM6W9vUJmifq/cCbHSSus7XfbRDZ466OH2Zek9zPcLenUSC4NZ51CT5pe7DjzWXqGQwwXD7VoBe2X4S/OPMGU58cIm/XKgLoO+USd+H7c6kcZkxLjqUSx/6F5DK1Ml/diEPUleqDHsfnHaRvAk7oHo++a7Q8Yuisrz2jF4Gn4T58djP63b0uxv3GUWG9AMiJp0CzvjaRvYz3E/+foHfpJDDdr55+B3PaQmp42JyXMptLbQaDmFTBOqYyVgruImal9ZNdELNQOm1rs3jBn7pNWuS9gwq3ETKc88opA2UO8Vcjm/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zp8eok+lsZyvgMj3X6hwPEcODvBl699lU4fDp4q4bVw=;
 b=bdKdvqAgZcpCyok/zW5SDscGqZNOSQRCTSpb75BwJTzzI63OLDX/LRQUVzMbyHoo2yihOSDrTnxRWOzUr0lsvHFg+KSjZ8M1q9cOSYqbupJ07UF2hmsm3oMmFd1bInPVIhL9Ef6dE9tV6YBMHhH03ZPy0TgI75iI0nCunB6un80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by PAXPR04MB8475.eurprd04.prod.outlook.com (2603:10a6:102:1de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 08:45:54 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 08:45:54 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, borisp@nvidia.com,
        saeedm@nvidia.com, leon@kernel.org, sd@queasysnail.net,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com, sebastian.tobuschat@oss.nxp.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v6 00/10] Add MACsec support for TJA11XX C45 PHYs
Date:   Thu, 28 Sep 2023 11:44:20 +0300
Message-Id: <20230928084430.1882670-1-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::31) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|PAXPR04MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a1423a0-62e9-42c3-b9eb-08dbbfff5364
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kl69+43urnH+YPJ5Hzg+r3/qvMOgKzDwzVMIA52TihFt0RPzPGCiWdHbEdbtXNiSdyt9LjnUH83JY98dWFGEZ5tzh7hBd+EKxeek1hSCep3K1Yrk9veIExXrU2pi4/rhjDJE+6o7qWoY6FArMUPPhmF0pFKlqiiIMB/Xk4Fu9TuXvHBv55/y2/bRKvLgP1ZGAupoFsyIBpavPUqz8thZW3gdcb6xwokxCY0qHSFRFdXJjuuPNsAHyZM/1NolzPszIp44zQY9TGILtOSfPENskOzYC9oi2XOk/KqM7/8JJCcHMkhgnt6SaIP8nldJgtGSeq5npPOCyb125OI2ZLnw0MnMdScAiBcdJDcN0kLj0rvH36HPKF8QQ7Ly0g54jGbiwIiToXRBBRu3q2ZxAZHyDRMch0vLCY7OFDQDhTaZn+gax230Zjz20Udgb/zD3QuDRYFHgi8d+DE9va45swaQQjzvE9qHzsOb1ua69wvMqG7urflNgVLIPOgy4CsEDjFeILPKGXGb4xIToDap2vQQjIGJY9hExXPc908bOkHM+UUWgrxOJs1TQvPFrHYJTZBZxYpMAloMFGYsTWwCVdKawn+8N3336p9mQJ5xrhvGuQwrfBMR+YHKvzZZ+bhlhog1z24x980AOTke2qRjqox4Pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6636002)(52116002)(6666004)(6512007)(26005)(41300700001)(921005)(38350700002)(478600001)(38100700002)(316002)(2616005)(1076003)(83380400001)(5660300002)(66476007)(6486002)(6506007)(66556008)(8936002)(8676002)(4326008)(66946007)(2906002)(7416002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kQSp386tl6gTAtnwIiVOPS99Yh1q5fr5K7aiXiscimNK8i/t7LJCVCtlLRG0?=
 =?us-ascii?Q?tCOCyD3KOcfP5KMvdd0oRDwrLO7qy3AMjUUmtBVzQzuC1BuLzYkGvfsDwSAu?=
 =?us-ascii?Q?DZBw5SzI3zKX6/hVxGXhoh713FIqXJoqXsjqKwo3A7ojJ+1Pu8PFtva+LH8A?=
 =?us-ascii?Q?fsndhBxDU+Ofr90soUm9Y2ALOxqWUwvhemRNNOmQRgaQRSD0NYgbQRTBuet0?=
 =?us-ascii?Q?e7tKBK3QawzWCAD6EyX+V2VVX2WRP5lOHAB4Yqmc+E0M9hrCF22Uqc28xBXd?=
 =?us-ascii?Q?PzzYe9s41aL8witYU9CUBe9nI5+85Pol7dNH0pabHRoUhNOq4H0PjL5KXUud?=
 =?us-ascii?Q?CaaVRWUvofZUIN6aqDC6GFk+HbVwEJrXUcAVb5Jv9N9K93BRvLVa1iLMta0b?=
 =?us-ascii?Q?AqXxvwivdAEGWw7gI4o2ql4hmOKxyGxvGGCtBD3Vuy3VvHuXTZtBt+mHGKvl?=
 =?us-ascii?Q?pybkBzT+nWaiS747yfp2sUHGSnzcFBVu0J/ZxLXbjt+rM+4eItD8RJQjxr1P?=
 =?us-ascii?Q?Im0yiWlPTjVw1LiZuE1eitVy4ubJIeAd6Q+ms0I9CGI7GHC69NzMa1lRVN/T?=
 =?us-ascii?Q?y8rJBaWMMTCY0Em/Crmd7rq3aOaT6h92soDORFe3yXb5ZiF5GAvyAemmiXCM?=
 =?us-ascii?Q?zjhYOe46Wyk9HsvAo+le/yg1STHF0R3xfNiE9bNMsOZwx8GFnTmr8kKyUmXD?=
 =?us-ascii?Q?CTYv5KErKMphJ6OrYb0Cal7fX29/gva5uNsNRxguTwCMKYK03AGdAUnzxaoA?=
 =?us-ascii?Q?6LbG4QkQmdZnuYA2VxtMOF/E3+4lj7s2iQQA0uuwhbb9OzKgNpHenX8GQY+d?=
 =?us-ascii?Q?dvXP3Q93ONQ3cY5WMMJHgRZa5nvvL2kIJmhEYnU9j/KwwMJu8FwBX6402VBK?=
 =?us-ascii?Q?hEoHQUxrEVux7HYF+DtrW/tGWzJgu269xxV7wi/02iT3Zxk9KCHeQueboLBb?=
 =?us-ascii?Q?36Bgk43BGGB74pcYUoC/6PzxfO181hy10vTl7o5AmGuC2sQWbQdMOUda1TYY?=
 =?us-ascii?Q?sc7ZvsJE5MKBo9d0KNE0ncVfnLQIDPZ0nwNf4hLbeih3fYCpdE+mrqd24uBa?=
 =?us-ascii?Q?sO7cW+i2THTA+hwQ9No5/xQaK0JOO82U1wMx9R/wOpn7HNtM1B93ei2X7R9E?=
 =?us-ascii?Q?av8HF6ZIbPfbmaJBccltzqGbiQcSuaAvIEvvff2b9lwGteBGr+8QBF4j+VFd?=
 =?us-ascii?Q?pLipuYFqiEasgF1aJN03XyAG3m1so/tKnweHHqsETmg8+2mbeyhI0k+jG2Pw?=
 =?us-ascii?Q?DeLrAb38+GY1ELZJGRd34iSc0jcIcvTM3ZzP2THmpyGHn6sdygTDpl5mpAgy?=
 =?us-ascii?Q?HcUrfp4m70+j9ZeZFmb34k1wfcUV2gC5o25BV2bzU7BFX30nsExRreT3ke1/?=
 =?us-ascii?Q?MYXKLheQ8XkpNUh5+hvwCGTqMEBUL1iaxfsu6F4Bq9NUQ0l7xGI25W6VdLM5?=
 =?us-ascii?Q?FDzdrWoR2DpZfAgE4kAC5wMcyrPClaKWX4EBozDN4NWTXSWqXLBvyWxgwPqG?=
 =?us-ascii?Q?S0m4G9xn4dud5vDUQ8GWqog0SOBECM1nqQJ6oJF1Y8TQFqEsftDjyDpZyRfg?=
 =?us-ascii?Q?iwv9c5wzP9z6/fpaJCfqLHz8n6GA6Qhh+xq7VlJ1pFyiO9uQHcCzTjvk/dLL?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1423a0-62e9-42c3-b9eb-08dbbfff5364
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 08:45:54.3055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDmRvmmbAPu5Uau1QUDCR+Fu36sco5hz5mqMKqH+jpe89dq3FYT4TPQ+GINKnEOpt7Qzlb0YSG+6wMgtBdyihRQK1AHEuQQmMTc185R8Spc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8475
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is the MACsec support for TJA11XX PHYs. The MACsec block encrypts
the ethernet frames on the fly and has no buffering. This operation will
grow the frames by 32 bytes. If the frames are sent back to back, the
MACsec block will not have enough room to insert the SecTAG and the ICV
and the frames will be dropped.

To mitigate this, the PHY can parse a specific ethertype with some
padding bytes and replace them with the SecTAG and ICV. These padding
bytes might be dummy or might contain information about TX SC that must
be used to encrypt the frame.

Radu P.

Radu Pirea (NXP OSS) (10):
  net: macsec: move sci_to_cpu to macsec header
  net: macsec: documentation for macsec_context and macsec_ops
  net: macsec: indicate next pn update when offloading
  net: macsec: introduce mdo_insert_tx_tag
  octeontx2-pf: mcs: update PN only when update_pn is true
  net: phy: mscc: macsec: reject PN update requests
  net/mlx5e: macsec: use update_pn flag instead of PN comparation
  net: phy: nxp-c45-tja11xx: add MACsec support
  net: phy: nxp-c45-tja11xx: add MACsec statistics
  net: phy: nxp-c45-tja11xx: implement mdo_insert_tx_tag

 MAINTAINERS                                   |    2 +-
 .../marvell/octeontx2/nic/cn10k_macsec.c      |    6 +
 .../mellanox/mlx5/core/en_accel/macsec.c      |    4 +-
 drivers/net/macsec.c                          |   94 +-
 drivers/net/netdevsim/macsec.c                |    5 -
 drivers/net/phy/Kconfig                       |    2 +-
 drivers/net/phy/Makefile                      |    6 +-
 drivers/net/phy/mscc/mscc_macsec.c            |    6 +
 drivers/net/phy/nxp-c45-tja11xx-macsec.c      | 1724 +++++++++++++++++
 drivers/net/phy/nxp-c45-tja11xx.c             |   77 +-
 drivers/net/phy/nxp-c45-tja11xx.h             |   62 +
 include/net/macsec.h                          |   55 +
 12 files changed, 2002 insertions(+), 41 deletions(-)
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx-macsec.c
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx.h

-- 
2.34.1

