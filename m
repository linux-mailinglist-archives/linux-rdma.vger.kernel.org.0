Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545767B166F
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Sep 2023 10:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjI1Itf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Sep 2023 04:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjI1ItY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Sep 2023 04:49:24 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20ABF1BC;
        Thu, 28 Sep 2023 01:49:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJbhWOGVJG1EjH05UlS/4y7yHFdp3iduXPW5t7Foz+bZLzS73qTAqT/hTAamm+iCzmoQL02DwRIB8W1cn48BZ0vWjCoq1L0t6o8dtfV8SD9hUMOhnqYywSt8j9HD4PzA/LcY54eXwCDg6R5DiEZJd1iV6Tmr2JYneJlM+jtfRRZYpu2tD5Xl/zFzenvTY7asGVx41yUZfQEL25NDJIs2SfrXwA1XX2fpg4dDicR9FEKvRAfbcqRDMG4zYJYbKdL3VxQELWlpnrWS0W4GlkyJE67uu/zmTxLKy8JbHDTQK5ffFzE4x4T/Ku1nVsoriD7DkD+LMJfs5E4nZe/Izt37jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDxW+HlF2eiHptX3MwB7502MMG86U1ZOVM6PfRMsk60=;
 b=fqI/ZB9AKJdDzTrcgW+igdDfgQmCpZidnpji2GkLVReOwLpzruKPEbpn0I9RRjuuEPRk7YiGEPphhe4zjYDs05dQCzGpe+f54iLNQhIoFSz6VUKvsiA063nT8DhgVs8uFWqv/x+mNvKTcsNI4GxKEBlaPNGUwV3jQjeX3ucDxso37XZyCtUPbKeHVkmNcMUiHdPS/2ry5xAnfyeWhIQJJN2NZhBIWdZM55MJJ2bhwqYZ/ZS9ZqiCdc3Q157ot2TrH3N/Lvf9EhYYGlPtoE4k2lEwaC/AvB3+F745mvNqtDwMX/9zsmOK8ORQwSaJE9UxMIvYX0zSY7hzClsBJo43hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDxW+HlF2eiHptX3MwB7502MMG86U1ZOVM6PfRMsk60=;
 b=BHq0dJm/0/vUPaMwCzoO38YoaTGpsGFyy3aZMlYEGLkhRcFadxP6rRNLYbydveOrD+SPYXM9VAeAiqWmBEodq3BSxk4yn7r47YVh4MmWrR1hErQnBBFK3lhUSg7QLCjgIt4s//RFj0lw1nUfFpirLFE5d1kUZuttuzru8r9X8WQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS8PR04MB7861.eurprd04.prod.outlook.com (2603:10a6:20b:2a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 08:49:15 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 08:49:15 +0000
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
Subject: [PATCH net-next v6 10/10] net: phy: nxp-c45-tja11xx: implement mdo_insert_tx_tag
Date:   Thu, 28 Sep 2023 11:44:30 +0300
Message-Id: <20230928084430.1882670-11-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS8PR04MB7861:EE_
X-MS-Office365-Filtering-Correlation-Id: ec3201b9-bdbf-4374-c870-08dbbfffbd67
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9dHK/GO2waIk3pFLLIWv6JjCOuCAt6J+TJ7wr+uPgtMju1WqtOHQn1q9OcDptUYfIekrwgTlLQUw7HRcJj7EFx01I9fQuuh8SlpnQJxNyGRVLWrUQITnp6XdtxEuLSWwPO/piM6bLwpDop8o51+K3P5IjbQ5tGOiHFKQ/uafVoxndVzZdLtv8ykf8mY93LU6v3uARmaXMgQf3PzqQ9vOs/jzPq1uVvqtdCl26VMIrl2ZYXi0JpYJZTEM27IyI7kum2L/Q7caGmgAevXF+n2hdBsUxtTzryCnTa6FTvyUYSxfHPY3ul4qHU91PbcYJ0b1OjYO1PEV84YBpzERaDMVb5iuBCDp712yVOvfmvgARorblbm11xCI2KY0i/vf3kxxSr6SW9wE12RRSQWDrHPBlXkA3FXWDH7jiNPjz6/9cR4kMVESrWwBPmqb21WX1WryIAGphdSWyvfdobFEY++Dzemf7yZi/PvXXK1TjoIl/gXHsydoRJ+j/DP3RGaJn6KSBmMPFmidQ5WbTfDsLeFwhUPFgBNDqlOO3A9EpGty7ZG/eGRv9zLSRPsatP9zxdiZCau5Co+1hh6mUczwGcQvdzk1vmYu3qr/lwc3Cz3SuoWG3hCjLZs6+U8MrsaB7wlJztjmasP1ixjJ10BElSLKhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(26005)(66476007)(66556008)(6666004)(86362001)(52116002)(1076003)(6512007)(6486002)(478600001)(2906002)(38350700002)(38100700002)(7416002)(316002)(8936002)(5660300002)(4326008)(2616005)(66946007)(8676002)(921005)(6636002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4fYMPIjD2GBNBFd11Fp1Vi+sncZ+zTBkFmSD2dkwPcjjyELEY2gqHcPXAuVK?=
 =?us-ascii?Q?FggSd8vJZe+AnrB+ppdnls6LNGM8ld3WqjnUrlbqFtGl7XnR7iSo7XzntEIp?=
 =?us-ascii?Q?RYT69ky0bYoyY7OavPy5WEiiD1zsNmJOxxqvaFoAwWindqLntgB5rLOuK3pt?=
 =?us-ascii?Q?g1G8oOdph28YUMNw6BvrSK4h2FoYwiA0P4Ra9/NoNGTLETLhA4fO9UV+zzI+?=
 =?us-ascii?Q?MnOz1/CyTclQUvGFNZ41cjyodzfJB1KpC0/6yt4UZgL6To8T/LF0qsrFSUXz?=
 =?us-ascii?Q?OlEOkBACFLB8p5+33GknmSY3jWHw32LA1A5akimYvOayntDHg5Gh1T8GfRLK?=
 =?us-ascii?Q?/D8PeL2gI7zTkToAj+9+1q8SX+PYBZRQ5w0dUbQfZf5u2gC8fb8b19YPb/P9?=
 =?us-ascii?Q?1ISsgarRkzIjGyG6ucshqqnJzsKYCJVZoqZOKDGlpv2nPnoSRKXt6tWDTC7u?=
 =?us-ascii?Q?Km8AQoZme6xCS/HZnjcPRuZ3ts+eZ10pqz3fplSIl205JhRWVSy3V4rWnh78?=
 =?us-ascii?Q?Yq4pNGDUBmNwU75IwY7F3KfBBKr8s5HsZwxBz4YNxmyYRgK3J5Kx3TsKM/w4?=
 =?us-ascii?Q?HJGpgTpLJgKL8sQoC2qxFiYr/n0+cSxvtWRqZSpuVOtJcTd/w+Ms0dwrMbBt?=
 =?us-ascii?Q?30JR49V7hDwsnRrjaboqSlvemYEWYGBM0AYoO/GudKw33FqOb2lRvRJvhFU9?=
 =?us-ascii?Q?ykU81TD8Q8+CVkCawrBPfT8BlyNuEgaM7wUNVPAeuPuxCd9Y02sgcIByyeWx?=
 =?us-ascii?Q?9JeyhhZiY7uYvLdID4ZWVris67ndsizysO7CjzJRUNDglg5xpiPsSn5+SPNd?=
 =?us-ascii?Q?lltxLDUojT9EWDXljh1IqsF5PiQBGDMMhD8PtTrDZU6YJ3lQYh/YYnhrXdGO?=
 =?us-ascii?Q?PW3ufhr2fj6wWZ+31kODmIvweJc8EhWxAa1bSxnWB6L+DgKBxJBqW6YYJOeq?=
 =?us-ascii?Q?M2nlJf56WHR2nn54bMBcdsSCvwUis6bnZ9EHe4lqjYBH5ExuhJHORWHiM4He?=
 =?us-ascii?Q?FsBAp1UD6RmcUdufTzPTb2uEExAluybuUiBMCK+yOq2ZngpLWmiOogg7m3RH?=
 =?us-ascii?Q?xyeIBq/FiOX8TROsCTD/y1O+VV86LOiqrdqto3IpYCUSXsApOke2egsQe8UG?=
 =?us-ascii?Q?i2K3N0ddNU0v64ZGHP4Zjume8TLuuD099Ko4bBmIjGzwwSRS5pFjRW0x8t9k?=
 =?us-ascii?Q?p6+P4afLPwi2EIR28y7mGyRNkfBi0ORCR3unp6ZOKQ0GnV68kAA0avw5pF1p?=
 =?us-ascii?Q?SypKkL0gQovO+zIb7YecDhlvpU0j/j0/rsPegWGv2xrN1qhElWv2BkEGj5Bx?=
 =?us-ascii?Q?7q+S4sYR39oWjOUAL9LyIJl6q3BIdB57pjwpVHiWC3qXH3i/W1CMe4cuz3gK?=
 =?us-ascii?Q?MiB/Pt57sVMWsb4c7mH0KY0crH/gre17gT4JsvY1B7KQPdodRwH/bDVxcn+c?=
 =?us-ascii?Q?+Ly9h92y3wMAPIyJ4xD+b5tV146ke8i4riCRkisIGzuaeKsXu5nG8uMRFNfI?=
 =?us-ascii?Q?GHdJM1U3ly4ABRqM0TFTvXIwgJI5/vD69UMez8K1hNC6UEhE+WT3icKgbj0B?=
 =?us-ascii?Q?y4jGgpT7M2WH5o5DxJE92e1KBnUI3fqPjIi0oiBFA49QuoGNJECIQLabC0MD?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3201b9-bdbf-4374-c870-08dbbfffbd67
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 08:48:51.9420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bKUaHJJLjOr4bcnEwBrjINnXm6Y6Bbzdw8Lb+2ghrXEu4FeOtFAJLHs2uT1NfZ2EqBciJ/TZ4Md9YvjshdVFs5SlsIVo18nePgn+hV92QA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7861
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implement mdo_insert_tx_tag to insert the TLV header in the ethernet
frame.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v6:
- none

Changes in V5:
- removed unused defines MACSEC_TLV_CP and MACSEC_TLV_SC_ID_OFF

Changes in V4:
- removed macsec_extscs parameter

Changes in V3:
- extscs parameter renamed to macsec_extscs and improved description

Changes in V2:
- added extscs parameter to choose the TX SC selection mechanism between
and MAC SA based selection and TLV header based selection

 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 41 ++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
index 4dd10ea6e06c..6ff0ceeeecd1 100644
--- a/drivers/net/phy/nxp-c45-tja11xx-macsec.c
+++ b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/phy.h>
 #include <linux/processor.h>
+#include <net/dst_metadata.h>
 #include <net/macsec.h>
 
 #include "nxp-c45-tja11xx.h"
@@ -118,6 +119,8 @@
 #define ADPTR_CNTRL			0x0F00
 #define ADPTR_CNTRL_CONFIG_EN		BIT(14)
 #define ADPTR_CNTRL_ADPTR_EN		BIT(12)
+#define ADPTR_TX_TAG_CNTRL		0x0F0C
+#define ADPTR_TX_TAG_CNTRL_ENA		BIT(31)
 
 #define TX_SC_FLT_BASE			0x800
 #define TX_SC_FLT_SIZE			0x10
@@ -166,6 +169,11 @@
 #define MACSEC_INPBTS			0x0638
 #define MACSEC_IPSNFS			0x063C
 
+#define TJA11XX_TLV_TX_NEEDED_HEADROOM	(32)
+#define TJA11XX_TLV_NEEDED_TAILROOM	(0)
+
+#define ETH_P_TJA11XX_TLV		(0x4e58)
+
 enum nxp_c45_sa_type {
 	TX_SA,
 	RX_SA,
@@ -1541,6 +1549,31 @@ static int nxp_c45_mdo_get_rx_sa_stats(struct macsec_context *ctx)
 	return 0;
 }
 
+struct tja11xx_tlv_header {
+	struct ethhdr eth;
+	u8 subtype;
+	u8 len;
+	u8 payload[28];
+};
+
+static int nxp_c45_mdo_insert_tx_tag(struct phy_device *phydev,
+				     struct sk_buff *skb)
+{
+	struct tja11xx_tlv_header *tlv;
+	struct ethhdr *eth;
+
+	eth = eth_hdr(skb);
+	tlv = skb_push(skb, TJA11XX_TLV_TX_NEEDED_HEADROOM);
+	memmove(tlv, eth, sizeof(*eth));
+	skb_reset_mac_header(skb);
+	tlv->eth.h_proto = htons(ETH_P_TJA11XX_TLV);
+	tlv->subtype = 1;
+	tlv->len = sizeof(tlv->payload);
+	memset(tlv->payload, 0, sizeof(tlv->payload));
+
+	return 0;
+}
+
 static const struct macsec_ops nxp_c45_macsec_ops = {
 	.mdo_dev_open = nxp_c45_mdo_dev_open,
 	.mdo_dev_stop = nxp_c45_mdo_dev_stop,
@@ -1561,6 +1594,9 @@ static const struct macsec_ops nxp_c45_macsec_ops = {
 	.mdo_get_tx_sa_stats = nxp_c45_mdo_get_tx_sa_stats,
 	.mdo_get_rx_sc_stats = nxp_c45_mdo_get_rx_sc_stats,
 	.mdo_get_rx_sa_stats = nxp_c45_mdo_get_rx_sa_stats,
+	.mdo_insert_tx_tag = nxp_c45_mdo_insert_tx_tag,
+	.needed_headroom = TJA11XX_TLV_TX_NEEDED_HEADROOM,
+	.needed_tailroom = TJA11XX_TLV_NEEDED_TAILROOM,
 };
 
 int nxp_c45_macsec_config_init(struct phy_device *phydev)
@@ -1581,6 +1617,11 @@ int nxp_c45_macsec_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	ret = nxp_c45_macsec_write(phydev, ADPTR_TX_TAG_CNTRL,
+				   ADPTR_TX_TAG_CNTRL_ENA);
+	if (ret)
+		return ret;
+
 	ret = nxp_c45_macsec_write(phydev, ADPTR_CNTRL, ADPTR_CNTRL_ADPTR_EN);
 	if (ret)
 		return ret;
-- 
2.34.1

