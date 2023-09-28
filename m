Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F24C7B166C
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Sep 2023 10:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjI1ItQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Sep 2023 04:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjI1Is5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Sep 2023 04:48:57 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBBD10C6;
        Thu, 28 Sep 2023 01:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lsay2FTwWLvrnkyqGsgGqH/uwslTJuxOi5oW/FVRg/Lf29XB1fia6CpMfLMwXr9osP1Nd5MJ4uYhB8jWj97j68uTdw/45kreLuz6pvLiq5M/582T976FqNZ1x65Xs6Plod1z5r7/nNFjw28tI5fmhaE15Pqi7lGx7B5kpVBkxSE4beySxmLUzh+YWKp+ACDa3Eej90t/i+IPYlDAjeOLIUGzSLl93MhP6P//ogg4QtmoRG0H4YTgsZCNxwD+bxDenPRjcojZmSXubGeMN1qO5t+xDC1k4SjfdHC0jMAzA7b+yirp0ZWVWtKjCqnMrtIKkNxX//o9mrteHTpePAMPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RG6zt1hg40c3g6P6qc28wrj/1Fd65CT+TtzSq6WriZw=;
 b=g/iGiuQMUm42ukCXprEBARIjE2C/9rIrtX+PCeesDpQzTdN85BFwBMK2Xnw37xdwn8sNjli1PP9feOmVwfL1ZtPqP+pgW33ENUF+9f6l3fjU7hgqvCY6zSJk4va5UADptFIpoyZqaUiPCEjK2KRnKPFJ0wpec6jQ5pL3i3kiKrYD4kbNaOGTkIeQzlPfDN75YM0QJDle0vTK/pKbQC6A3r5W3YmTDYDJPmbyCuvO5ZZ90uMBd9ufn9OgEB1vJS4hhmRRU6Vj3fxDctXF1cWOiQufeXNV1DE1vEJKqyTLJGKCrJ4/v3yWH7AYpRBrfnVbNGJpMp/wmWr8MdJr/BLbAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RG6zt1hg40c3g6P6qc28wrj/1Fd65CT+TtzSq6WriZw=;
 b=ZfSb6ee7t0rs9DtWnkj6fDe4BIOPJ/EiCowp/EXHlhSsZRf8O1Y60YvSZ+WYSvEzOMk2E5DG2oXqaDbMvPTl2USGwDTC6ZXX5NXL6Lp0q2Y0C2/Ychy8wqj4BztLggdr++dRdG42llH1JibfCEq4YVUnyhuL5PXQasqEArnQLsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM7PR04MB7031.eurprd04.prod.outlook.com (2603:10a6:20b:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 08:48:50 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 08:48:50 +0000
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
Subject: [PATCH net-next v6 09/10] net: phy: nxp-c45-tja11xx: add MACsec statistics
Date:   Thu, 28 Sep 2023 11:44:29 +0300
Message-Id: <20230928084430.1882670-10-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928084430.1882670-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230928084430.1882670-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::31) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM7PR04MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 4733d007-2a0a-4be4-76d8-08dbbfffb2b2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hsTtcEnGg6jg6HapeYPHBaem312y+0a16ihkty7cl51nYB5IuLgb2FMEUZbcUMrX4Qz2RjZyakxyi//yVpNDNDIcnNNfsFTNHValWvnNrSiDmBaRS9y6VcFCS1vnhoigifDXHojv1hHC029+jbJsua1GKKAQX2K3E4RDU4adNBWDBro2uHLCY+NysLX/xl1CXwjLAxbUdbaTSQL7ANZ85UMhTtquXFK3PaAJ4E4LkXWGdt/+1XDykjM01sUajNEYfaLJ9yfihXZlWMV/zfg6QTlNl5TvmEygFz8icTNBlFfQrz6GVVx4KsZjCnuTTswzUC0iGQkCxDQLQ5n+EImqlyStrDVMZB+cznhaOHRA+4ZvdrVh2urXv93826MLpFf3Akvceb/z2IPPvKZrySAs9AJIJX/mu2Vli7BoD+xp5ZTesBfMLBGdm17d7/VgLRmT76rljcAzFmOneJFNp7e6jIgH2fOyTxUrUg4FCvsZUzucdwNOV7pmXtikv3kX3BA4xP5tR1CEw8QPPwwXx3g+Bvd+/TxTO9/VxxoCGyCx4gm655NPNgfOMLnGtmaSVjdntY+ythHy2k93if3v/qkOJ5q5kh/3MOQ7ht7VFv3uh/d8TYlqt++KBu7ViX+uwvpWXXUEoLUVBG1Nn7mGCvM4Bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2906002)(86362001)(30864003)(38350700002)(38100700002)(5660300002)(6512007)(6506007)(52116002)(6666004)(83380400001)(921005)(6486002)(478600001)(4326008)(8936002)(2616005)(41300700001)(7416002)(1076003)(8676002)(26005)(66476007)(66946007)(316002)(6636002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vAKoQLzICbo/iwWQq+LU+Co7PDMQxGUdqBatNfeXVw2nOIkqwmMMqn8L9MgO?=
 =?us-ascii?Q?wftsqEi+sbVYl2XrZfzlTxqdZTp+Br4LM2iMkvFvRtqa+mVY9oNVK4TR8WVo?=
 =?us-ascii?Q?Z/l9EmJ9x4HpV5l2MqvxZFv04D3wxiq2E8gdVnA2fV2J5lokcB3/M8RUAmaL?=
 =?us-ascii?Q?jFAXgnd8qpGP1cE/dBfZ1q9AAthTnBem3+UssgGBEdZdsvno7o+agFiLsR07?=
 =?us-ascii?Q?vdSIarijN2oYm3bEHMnDqeznBIFrZtA7tbpMwrg94XzouP+9e+lIf4CmJsvd?=
 =?us-ascii?Q?gmA8jBMhakJozINr9qAfERjf7V7gQnAcW+BwbvcCPPS62Ft7A9RPYGSZxsn6?=
 =?us-ascii?Q?DN/32ghGdlUC/NTthSPv6qXWDd2GxkUw7mEt23nLJE+QxehmB2YhrWI0tTwn?=
 =?us-ascii?Q?JIgZYUNu/yrXobx9/zuQ1f4zVSOhXW9UiQg7SSIE9gjfcOQiVNvy2DxZUDMj?=
 =?us-ascii?Q?pTcSC0mKhAVJAH4c+x+vwNKGZue/vC2Qj7dzmrtdnuoqTdxiC+sig7pRpJuR?=
 =?us-ascii?Q?G/4QlQnPjzavO+FI7isfZNBoxyqrr3FrNV19YAp2eJm17TC8vnG+zOxPfTN1?=
 =?us-ascii?Q?i8me4zSHa396B+TjVkHi9dOMWlX2PIpHbJvq8QeaQ2+qVHpJHUzF93QVgLmM?=
 =?us-ascii?Q?sn9SRbYCyp1W9OwH3uMkzht+XnGJTQjBzi9CQK9ZAikIuAUYn/cXELJJYfQP?=
 =?us-ascii?Q?EGZfnPpRrDdH7R2qQwaqQY5wfcCrpnngLyI7nPSJQSr/Pzx1EmaAsfdRU1Z9?=
 =?us-ascii?Q?3Gn/25MxfYGVVS4UKjBxe95S7InqYurHmr2QO5m8ZKFECo++TlYg68N0/1ED?=
 =?us-ascii?Q?NM+aOXgrgMCKy4SRz1XnXfGmfPbzyCYEWuYYJiG9zxk9laLQXARC5OSXKL7/?=
 =?us-ascii?Q?z/mULbKEdz36utDGleKm9Jl3noqUAyp7p7ixnLmfkBmmqpbv0wx1eNx12F2h?=
 =?us-ascii?Q?kDIDb65uKyfCAtrxzIdAaz6WBG99l5aXv6Wy6MqVR3z/2l6RJgFkGkukKpbc?=
 =?us-ascii?Q?CY3sxc5zGP16BFrTC9fPlCgtOpJMr869V7pZ94TWersG9ZMud8tPGN9Zgh+J?=
 =?us-ascii?Q?9XtUCjiczPzBzLHLbDECKljtBlnJjVPWpvnWvF6JhEYQgvKtaylrwnM3aZFt?=
 =?us-ascii?Q?6EgicATebukVWiQUCUbmD6JbNAKVTuJVhTbWVBc5H8jUfbA3M9dgLwAFGH+X?=
 =?us-ascii?Q?B9pjJwjEZb5lfkfDeSWkOptO9YJvIAN7b6aafcQCgm7JrbblCJcOXMSHDFwS?=
 =?us-ascii?Q?Z0x4R3smU5MRJZYVXkxdqSpkhB03yaj3J+Mi7wFe9BC/xvl6QGhXoU8C93Z0?=
 =?us-ascii?Q?Zor1/S7SbCDYp3JdLpWm7nMR9XYwqxJZ0cP+gUA3zHqutoquJ2txGn9lRiLG?=
 =?us-ascii?Q?gCr1TIXDKJEMGIcfb7yoKJ5jAJnGFGjpLjHC4lDbud/yU6QtZGhlw3CNqgXd?=
 =?us-ascii?Q?wMGeMk+WKUDix7di3VF0g4eZ8QxSbMzFE4CtLCCQgn3jmcDTEq7DSJ3GWkdd?=
 =?us-ascii?Q?nFuRxO9XBHx2XNTpGXicIbwA2oeCO8M/s3ANx6LVJcu8cZocamQBY0gBDMPU?=
 =?us-ascii?Q?DSqPIl/VZKqxC3DuVpU4NP9BSTYnzC8FOVRMwVi6YPnzEECVmHxsXB5PpCGY?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4733d007-2a0a-4be4-76d8-08dbbfffb2b2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 08:48:33.9880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Po8Cw7PRb+iLfQCqm6TAL7iDeb1YDMNiziiUWNqLiBNNLomrVjVqw4vvQ/nlLcy1XwWRkghpmm6uGcwK+yxFdDpqvSb9uM56yXgrl1dVFKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7031
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add MACsec statistics callbacks.
The statistic registers must be set to 0 if the SC/SA is
deleted to read relevant values next time when the SC/SA is used.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v6:
- none

Changes in v5:
- none

Changes in v4:
- Added nxp_c45_macsec_read32_64 function to read 32b counters into u64
variables.
- Added nxp_c45_macsec_read64 function to read 64b counters.

Changes in v3:
- reworked the implementation around struct nxp_c45_sa
- changed the way how OutOctetsEncrypted are propagated to the userspace
- changed the way how OutOctetsProtected are propagated to the userspace
- read and clear OutOctetsProtected

Changes in v2:
- split the patch from "net: phy: nxp-c45-tja11xx: add MACsec support"

 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 345 +++++++++++++++++++++++
 1 file changed, 345 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
index 821f8926f7f2..4dd10ea6e06c 100644
--- a/drivers/net/phy/nxp-c45-tja11xx-macsec.c
+++ b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
@@ -137,6 +137,35 @@
 #define ADAPTER_EN	BIT(6)
 #define MACSEC_EN	BIT(5)
 
+#define MACSEC_INOV1HS			0x0140
+#define MACSEC_INOV2HS			0x0144
+#define MACSEC_INOD1HS			0x0148
+#define MACSEC_INOD2HS			0x014C
+#define MACSEC_RXSCIPUS			0x0150
+#define MACSEC_RXSCIPDS			0x0154
+#define MACSEC_RXSCIPLS			0x0158
+#define MACSEC_RXAN0INUSS		0x0160
+#define MACSEC_RXAN0IPUSS		0x0170
+#define MACSEC_RXSA_A_IPOS		0x0194
+#define MACSEC_RXSA_A_IPIS		0x01B0
+#define MACSEC_RXSA_A_IPNVS		0x01B4
+#define MACSEC_RXSA_B_IPOS		0x01D4
+#define MACSEC_RXSA_B_IPIS		0x01F0
+#define MACSEC_RXSA_B_IPNVS		0x01F4
+#define MACSEC_OPUS			0x021C
+#define MACSEC_OPTLS			0x022C
+#define MACSEC_OOP1HS			0x0240
+#define MACSEC_OOP2HS			0x0244
+#define MACSEC_OOE1HS			0x0248
+#define MACSEC_OOE2HS			0x024C
+#define MACSEC_TXSA_A_OPPS		0x028C
+#define MACSEC_TXSA_A_OPES		0x0290
+#define MACSEC_TXSA_B_OPPS		0x02CC
+#define MACSEC_TXSA_B_OPES		0x02D0
+#define MACSEC_INPWTS			0x0630
+#define MACSEC_INPBTS			0x0638
+#define MACSEC_IPSNFS			0x063C
+
 enum nxp_c45_sa_type {
 	TX_SA,
 	RX_SA,
@@ -175,6 +204,11 @@ struct nxp_c45_sa_regs {
 	u16 ka;
 	u16 ssci;
 	u16 salt;
+	u16 ipis;
+	u16 ipnvs;
+	u16 ipos;
+	u16 opps;
+	u16 opes;
 };
 
 static const struct nxp_c45_sa_regs rx_sa_a_regs = {
@@ -186,6 +220,9 @@ static const struct nxp_c45_sa_regs rx_sa_a_regs = {
 	.ka	= MACSEC_RXSA_A_KA,
 	.ssci	= MACSEC_RXSA_A_SSCI,
 	.salt	= MACSEC_RXSA_A_SALT,
+	.ipis	= MACSEC_RXSA_A_IPIS,
+	.ipnvs	= MACSEC_RXSA_A_IPNVS,
+	.ipos	= MACSEC_RXSA_A_IPOS,
 };
 
 static const struct nxp_c45_sa_regs rx_sa_b_regs = {
@@ -197,6 +234,9 @@ static const struct nxp_c45_sa_regs rx_sa_b_regs = {
 	.ka	= MACSEC_RXSA_B_KA,
 	.ssci	= MACSEC_RXSA_B_SSCI,
 	.salt	= MACSEC_RXSA_B_SALT,
+	.ipis	= MACSEC_RXSA_B_IPIS,
+	.ipnvs	= MACSEC_RXSA_B_IPNVS,
+	.ipos	= MACSEC_RXSA_B_IPOS,
 };
 
 static const struct nxp_c45_sa_regs tx_sa_a_regs = {
@@ -206,6 +246,8 @@ static const struct nxp_c45_sa_regs tx_sa_a_regs = {
 	.ka	= MACSEC_TXSA_A_KA,
 	.ssci	= MACSEC_TXSA_A_SSCI,
 	.salt	= MACSEC_TXSA_A_SALT,
+	.opps	= MACSEC_TXSA_A_OPPS,
+	.opes	= MACSEC_TXSA_A_OPES,
 };
 
 static const struct nxp_c45_sa_regs tx_sa_b_regs = {
@@ -215,6 +257,8 @@ static const struct nxp_c45_sa_regs tx_sa_b_regs = {
 	.ka	= MACSEC_TXSA_B_KA,
 	.ssci	= MACSEC_TXSA_B_SSCI,
 	.salt	= MACSEC_TXSA_B_SALT,
+	.opps	= MACSEC_TXSA_B_OPPS,
+	.opes	= MACSEC_TXSA_B_OPES,
 };
 
 static const
@@ -284,6 +328,26 @@ static int nxp_c45_macsec_read(struct phy_device *phydev, u16 addr, u32 *value)
 	return 0;
 }
 
+static void nxp_c45_macsec_read32_64(struct phy_device *phydev, u16 addr,
+				     u64 *value)
+{
+	u32 lvalue;
+
+	nxp_c45_macsec_read(phydev, addr, &lvalue);
+	*value = lvalue;
+}
+
+static void nxp_c45_macsec_read64(struct phy_device *phydev, u16 addr,
+				  u64 *value)
+{
+	u32 lvalue;
+
+	nxp_c45_macsec_read(phydev, addr, &lvalue);
+	*value = (u64)lvalue << 32;
+	nxp_c45_macsec_read(phydev, addr + 4, &lvalue);
+	*value |= lvalue;
+}
+
 static void nxp_c45_secy_irq_en(struct phy_device *phydev,
 				struct nxp_c45_secy *phy_secy, bool en)
 {
@@ -432,6 +496,41 @@ static void nxp_c45_sa_set_key(struct macsec_context *ctx,
 	nxp_c45_macsec_write(phydev, sa_regs->cs, MACSEC_SA_CS_A);
 }
 
+static void nxp_c45_rx_sa_clear_stats(struct phy_device *phydev,
+				      struct nxp_c45_sa *sa)
+{
+	nxp_c45_macsec_write(phydev, sa->regs->ipis, 0);
+	nxp_c45_macsec_write(phydev, sa->regs->ipnvs, 0);
+	nxp_c45_macsec_write(phydev, sa->regs->ipos, 0);
+
+	nxp_c45_macsec_write(phydev, MACSEC_RXAN0INUSS + sa->an * 4, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RXAN0IPUSS + sa->an * 4, 0);
+}
+
+static void nxp_c45_rx_sa_read_stats(struct phy_device *phydev,
+				     struct nxp_c45_sa *sa,
+				     struct macsec_rx_sa_stats *stats)
+{
+	nxp_c45_macsec_read(phydev, sa->regs->ipis, &stats->InPktsInvalid);
+	nxp_c45_macsec_read(phydev, sa->regs->ipnvs, &stats->InPktsNotValid);
+	nxp_c45_macsec_read(phydev, sa->regs->ipos, &stats->InPktsOK);
+}
+
+static void nxp_c45_tx_sa_clear_stats(struct phy_device *phydev,
+				      struct nxp_c45_sa *sa)
+{
+	nxp_c45_macsec_write(phydev, sa->regs->opps, 0);
+	nxp_c45_macsec_write(phydev, sa->regs->opes, 0);
+}
+
+static void nxp_c45_tx_sa_read_stats(struct phy_device *phydev,
+				     struct nxp_c45_sa *sa,
+				     struct macsec_tx_sa_stats *stats)
+{
+	nxp_c45_macsec_read(phydev, sa->regs->opps, &stats->OutPktsProtected);
+	nxp_c45_macsec_read(phydev, sa->regs->opes, &stats->OutPktsEncrypted);
+}
+
 static void nxp_c45_rx_sa_update(struct phy_device *phydev,
 				 struct nxp_c45_sa *sa, bool en)
 {
@@ -646,6 +745,23 @@ static void nxp_c45_tx_sc_update(struct phy_device *phydev,
 	nxp_c45_macsec_write(phydev, MACSEC_TXSC_CFG, cfg);
 }
 
+static void nxp_c45_tx_sc_clear_stats(struct phy_device *phydev,
+				      struct nxp_c45_secy *phy_secy)
+{
+	struct nxp_c45_sa *pos, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, &phy_secy->sa_list, list)
+		if (pos->type == TX_SA)
+			nxp_c45_tx_sa_clear_stats(phydev, pos);
+
+	nxp_c45_macsec_write(phydev, MACSEC_OPUS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_OPTLS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_OOP1HS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_OOP2HS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_OOE1HS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_OOE2HS, 0);
+}
+
 static void nxp_c45_set_rx_sc0_impl(struct phy_device *phydev,
 				    bool enable)
 {
@@ -735,6 +851,32 @@ static void nxp_c45_rx_sc_update(struct phy_device *phydev,
 	nxp_c45_macsec_write(phydev, MACSEC_RXSC_CFG, cfg);
 }
 
+static void nxp_c45_rx_sc_clear_stats(struct phy_device *phydev,
+				      struct nxp_c45_secy *phy_secy)
+{
+	struct nxp_c45_sa *pos, *tmp;
+	int i;
+
+	list_for_each_entry_safe(pos, tmp, &phy_secy->sa_list, list)
+		if (pos->type == RX_SA)
+			nxp_c45_rx_sa_clear_stats(phydev, pos);
+
+	nxp_c45_macsec_write(phydev, MACSEC_INOD1HS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_INOD2HS, 0);
+
+	nxp_c45_macsec_write(phydev, MACSEC_INOV1HS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_INOV2HS, 0);
+
+	nxp_c45_macsec_write(phydev, MACSEC_RXSCIPDS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RXSCIPLS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RXSCIPUS, 0);
+
+	for (i = 0; i < MACSEC_NUM_AN; i++) {
+		nxp_c45_macsec_write(phydev, MACSEC_RXAN0INUSS + i * 4, 0);
+		nxp_c45_macsec_write(phydev, MACSEC_RXAN0IPUSS + i * 4, 0);
+	}
+}
+
 static void nxp_c45_rx_sc_del(struct phy_device *phydev,
 			      struct nxp_c45_secy *phy_secy)
 {
@@ -744,11 +886,20 @@ static void nxp_c45_rx_sc_del(struct phy_device *phydev,
 	nxp_c45_macsec_write(phydev, MACSEC_RPW, 0);
 	nxp_c45_set_sci(phydev, MACSEC_RXSC_SCI_1H, 0);
 
+	nxp_c45_rx_sc_clear_stats(phydev, phy_secy);
+
 	list_for_each_entry_safe(pos, tmp, &phy_secy->sa_list, list)
 		if (pos->type == RX_SA)
 			nxp_c45_rx_sa_update(phydev, pos, false);
 }
 
+static void nxp_c45_clear_global_stats(struct phy_device *phydev)
+{
+	nxp_c45_macsec_write(phydev, MACSEC_INPBTS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_INPWTS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_IPSNFS, 0);
+}
+
 static void nxp_c45_macsec_en(struct phy_device *phydev, bool en)
 {
 	u32 reg;
@@ -939,6 +1090,7 @@ static int nxp_c45_mdo_del_secy(struct macsec_context *ctx)
 	nxp_c45_mdo_dev_stop(ctx);
 	nxp_c45_tx_sa_next(phy_secy, &next_sa, encoding_sa);
 	nxp_c45_tx_sa_update(phydev, &next_sa, false);
+	nxp_c45_tx_sc_clear_stats(phydev, phy_secy);
 	if (phy_secy->rx_sc)
 		nxp_c45_rx_sc_del(phydev, phy_secy);
 
@@ -949,6 +1101,9 @@ static int nxp_c45_mdo_del_secy(struct macsec_context *ctx)
 	clear_bit(phy_secy->secy_id, priv->macsec->tx_sc_bitmap);
 	nxp_c45_secy_free(phy_secy);
 
+	if (list_empty(&priv->macsec->secy_list))
+		nxp_c45_clear_global_stats(phydev);
+
 	return 0;
 }
 
@@ -1106,6 +1261,7 @@ static int nxp_c45_mdo_del_rxsa(struct macsec_context *ctx)
 
 	nxp_c45_select_secy(phydev, phy_secy->secy_id);
 	nxp_c45_rx_sa_update(phydev, sa, false);
+	nxp_c45_rx_sa_clear_stats(phydev, sa);
 
 	nxp_c45_sa_free(sa);
 
@@ -1195,12 +1351,196 @@ static int nxp_c45_mdo_del_txsa(struct macsec_context *ctx)
 	nxp_c45_select_secy(phydev, phy_secy->secy_id);
 	if (ctx->secy->tx_sc.encoding_sa  == sa->an)
 		nxp_c45_tx_sa_update(phydev, sa, false);
+	nxp_c45_tx_sa_clear_stats(phydev, sa);
 
 	nxp_c45_sa_free(sa);
 
 	return 0;
 }
 
+static int nxp_c45_mdo_get_dev_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_dev_stats  *dev_stats;
+	struct nxp_c45_secy *phy_secy;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	dev_stats = ctx->stats.dev_stats;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	nxp_c45_macsec_read32_64(phydev, MACSEC_OPUS,
+				 &dev_stats->OutPktsUntagged);
+	nxp_c45_macsec_read32_64(phydev, MACSEC_OPTLS,
+				 &dev_stats->OutPktsTooLong);
+	nxp_c45_macsec_read32_64(phydev, MACSEC_INPBTS,
+				 &dev_stats->InPktsBadTag);
+
+	if (phy_secy->secy->validate_frames == MACSEC_VALIDATE_STRICT)
+		nxp_c45_macsec_read32_64(phydev, MACSEC_INPWTS,
+					 &dev_stats->InPktsNoTag);
+	else
+		nxp_c45_macsec_read32_64(phydev, MACSEC_INPWTS,
+					 &dev_stats->InPktsUntagged);
+
+	if (phy_secy->secy->validate_frames == MACSEC_VALIDATE_STRICT)
+		nxp_c45_macsec_read32_64(phydev, MACSEC_IPSNFS,
+					 &dev_stats->InPktsNoSCI);
+	else
+		nxp_c45_macsec_read32_64(phydev, MACSEC_IPSNFS,
+					 &dev_stats->InPktsUnknownSCI);
+
+	/* Always 0. */
+	dev_stats->InPktsOverrun = 0;
+
+	return 0;
+}
+
+static int nxp_c45_mdo_get_tx_sc_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_tx_sa_stats tx_sa_stats;
+	struct macsec_tx_sc_stats *stats;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_sa *pos, *tmp;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	stats = ctx->stats.tx_sc_stats;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	nxp_c45_macsec_read64(phydev, MACSEC_OOE1HS,
+			      &stats->OutOctetsEncrypted);
+	nxp_c45_macsec_read64(phydev, MACSEC_OOP1HS,
+			      &stats->OutOctetsProtected);
+	list_for_each_entry_safe(pos, tmp, &phy_secy->sa_list, list) {
+		if (pos->type != TX_SA)
+			continue;
+
+		memset(&tx_sa_stats, 0, sizeof(tx_sa_stats));
+		nxp_c45_tx_sa_read_stats(phydev, pos, &tx_sa_stats);
+
+		stats->OutPktsEncrypted += tx_sa_stats.OutPktsEncrypted;
+		stats->OutPktsProtected += tx_sa_stats.OutPktsProtected;
+	}
+
+	return 0;
+}
+
+static int nxp_c45_mdo_get_tx_sa_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_tx_sa_stats *stats;
+	struct nxp_c45_secy *phy_secy;
+	u8 an = ctx->sa.assoc_num;
+	struct nxp_c45_sa *sa;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	sa = nxp_c45_find_sa(&phy_secy->sa_list, TX_SA, an);
+	if (IS_ERR(sa))
+		return PTR_ERR(sa);
+
+	stats = ctx->stats.tx_sa_stats;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_tx_sa_read_stats(phydev, sa, stats);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_get_rx_sc_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_rx_sa_stats rx_sa_stats;
+	struct macsec_rx_sc_stats *stats;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_sa *pos, *tmp;
+	u32 reg = 0;
+	int i;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	if (phy_secy->rx_sc != ctx->rx_sc)
+		return -EINVAL;
+
+	stats = ctx->stats.rx_sc_stats;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	list_for_each_entry_safe(pos, tmp, &phy_secy->sa_list, list) {
+		if (pos->type != RX_SA)
+			continue;
+
+		memset(&rx_sa_stats, 0, sizeof(rx_sa_stats));
+		nxp_c45_rx_sa_read_stats(phydev, pos, &rx_sa_stats);
+
+		stats->InPktsInvalid += rx_sa_stats.InPktsInvalid;
+		stats->InPktsNotValid += rx_sa_stats.InPktsNotValid;
+		stats->InPktsOK += rx_sa_stats.InPktsOK;
+	}
+
+	for (i = 0; i < MACSEC_NUM_AN; i++) {
+		nxp_c45_macsec_read(phydev, MACSEC_RXAN0INUSS + i * 4, &reg);
+		stats->InPktsNotUsingSA += reg;
+		nxp_c45_macsec_read(phydev, MACSEC_RXAN0IPUSS + i * 4, &reg);
+		stats->InPktsUnusedSA += reg;
+	}
+
+	nxp_c45_macsec_read64(phydev, MACSEC_INOD1HS,
+			      &stats->InOctetsDecrypted);
+	nxp_c45_macsec_read64(phydev, MACSEC_INOV1HS,
+			      &stats->InOctetsValidated);
+
+	nxp_c45_macsec_read32_64(phydev, MACSEC_RXSCIPDS,
+				 &stats->InPktsDelayed);
+	nxp_c45_macsec_read32_64(phydev, MACSEC_RXSCIPLS,
+				 &stats->InPktsLate);
+	nxp_c45_macsec_read32_64(phydev, MACSEC_RXSCIPUS,
+				 &stats->InPktsUnchecked);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_get_rx_sa_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_rx_sa_stats *stats;
+	struct nxp_c45_secy *phy_secy;
+	u8 an = ctx->sa.assoc_num;
+	struct nxp_c45_sa *sa;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	sa = nxp_c45_find_sa(&phy_secy->sa_list, RX_SA, an);
+	if (IS_ERR(sa))
+		return PTR_ERR(sa);
+
+	stats = ctx->stats.rx_sa_stats;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	nxp_c45_rx_sa_read_stats(phydev, sa, stats);
+	nxp_c45_macsec_read(phydev, MACSEC_RXAN0INUSS + an * 4,
+			    &stats->InPktsNotUsingSA);
+	nxp_c45_macsec_read(phydev, MACSEC_RXAN0IPUSS + an * 4,
+			    &stats->InPktsUnusedSA);
+
+	return 0;
+}
+
 static const struct macsec_ops nxp_c45_macsec_ops = {
 	.mdo_dev_open = nxp_c45_mdo_dev_open,
 	.mdo_dev_stop = nxp_c45_mdo_dev_stop,
@@ -1216,6 +1556,11 @@ static const struct macsec_ops nxp_c45_macsec_ops = {
 	.mdo_add_txsa = nxp_c45_mdo_add_txsa,
 	.mdo_upd_txsa = nxp_c45_mdo_upd_txsa,
 	.mdo_del_txsa = nxp_c45_mdo_del_txsa,
+	.mdo_get_dev_stats = nxp_c45_mdo_get_dev_stats,
+	.mdo_get_tx_sc_stats = nxp_c45_mdo_get_tx_sc_stats,
+	.mdo_get_tx_sa_stats = nxp_c45_mdo_get_tx_sa_stats,
+	.mdo_get_rx_sc_stats = nxp_c45_mdo_get_rx_sc_stats,
+	.mdo_get_rx_sa_stats = nxp_c45_mdo_get_rx_sa_stats,
 };
 
 int nxp_c45_macsec_config_init(struct phy_device *phydev)
-- 
2.34.1

