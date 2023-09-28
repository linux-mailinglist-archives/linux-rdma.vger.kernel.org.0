Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB8E7B1654
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Sep 2023 10:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjI1Iqt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Sep 2023 04:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjI1Iqr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Sep 2023 04:46:47 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA43198;
        Thu, 28 Sep 2023 01:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cx2BcfVpqT5VnUrKg5I9oBU1eyoL6ZJwDW6/HELlwPlGMNoFP6SRiuFS3RCTCFig3pCM1/BSYuCudPaA0I5jXtykeUErRCI4YdRX358kavuWOzR0yitCHLKXc3YKaIOkQC4IdO/kpp2CuePZa0Q6k+dwXs1HhUYXDHGWUrF2NDYS3ctn7xav2YnAldJO9pNWHJz/3RBgFH7X1nTT4McuISyGsj0ndLkUYZv6hvIYQGsXN/JPGaXjNTi2vA3SdAuyy+cMTlHZPAYh58pj1xqObowJQKwae3qPw2FEFnlU1YrHsfZdY/JBg+nsywiz8qVG31eMpo5GvCzZfaEvTgvSBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McNT4W0p/+buOEGJAz5QBoS1T6lbeQuIcj0fqqjRD14=;
 b=YZVCo7heHIBp8HaVfSWJzQ/KsDUBntN8rp8KuIm6iZOVXr2sLD14B416C5KOvZ8pq1tb5NFEKm00ymxWvcUQ7s2ssGCM+6Y8r407vz3kOZbolkj2S7/KjbFAsNWELFdH60hAsEILrHThTUvas7Jft2iWWje9WQHUyVx1/I+4JTARb/e25aRuYVUEdkgQP6sdjbFk2wd0XNFJoBwFMaJy4J6CDB+dTkY7iZBC4NHNFiS5kezzGkIsErfwgef4oS6rePDzGymL3GW2bYN9878fzqEEe1LhtpMAloHD6PkzGR9upMT97VP1dirKj03PyQ48EBOmESTcCbj4BmXN8Qcncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McNT4W0p/+buOEGJAz5QBoS1T6lbeQuIcj0fqqjRD14=;
 b=Yg7m3Atwwg+3b1EvOrMmFxXwr547j7ghwAgCOdFfzlOAR/VAsPxlpEuGQLRuTTnSGB6jdY3awDP8s11zlNXvfAvZ3o2+KlmIg47U6GWSYvfP9wH5j5bcJUh5zgylewult31FrknOikpKuT7E5tUr1lqZPIFam58OrLZ6hkmetOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by PAXPR04MB8475.eurprd04.prod.outlook.com (2603:10a6:102:1de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 08:46:41 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 08:46:41 +0000
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
Subject: [PATCH net-next v6 02/10] net: macsec: documentation for macsec_context and macsec_ops
Date:   Thu, 28 Sep 2023 11:44:22 +0300
Message-Id: <20230928084430.1882670-3-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|PAXPR04MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: e88797f1-3f8c-482f-6229-08dbbfff67c4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UqRIhAGT427BvCE8mpxW3tRjSUSZ7wf2H5orXAHI4QX/+59WMHexV5w8YtGlQcPVNRo+cDBMwWWMhcBZ2iCZ1QTwXixxaZfWlM3g82By3NypQaKkx0LRbz8/19wtaCJlQ60UFWfZtdtslccoikdHVoBYS7IBT/xIaLCAjzzIu4NYDBQ5po+X7q0j6EABzRTTYn4hOcez19m/NdOCLwKcl0slWfu64cFYcnF9bM5GY3b+Ir6Xy0GVYYmoWQoaLDLK7HNO4MPnJG2ZZvzo+Zi7aQPxND8vDkR3ZcTFqJRdn5j7nubOSuGqW3juGZzF6Au4Y9GlGu9qOFWMnCS8CWCmUrJrHltPNcRfFFloeQ+hEVa+AQRO4pxFPSakQBQlxMTEwPDe4fOjouedl+ywLWd1KzNiKjWAdL3RTeo4lWFYyfKQuU/755O8BFRG6XUj1/U/GmPoybvzh/PHOl+xqfnFWoHh0QRyv11UBnZmwdSN5XZZmNh4dNrzmjIlKtRDNRF1VDHTjHXs7N2YteFaKZuXgMHwQfXlfBKbHFLpMd9VAnrz3og05S3ugXxCSDn1ecOvH6eruO6o+jejlxECuCmmOH8vbiCoqiXcHGxO4qwKBdG/8Y4XcPMw7D2hjPEHnMu5vKyvi9b0l5sdeTCBNAtfsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6636002)(52116002)(6666004)(6512007)(26005)(41300700001)(921005)(38350700002)(478600001)(38100700002)(316002)(2616005)(1076003)(83380400001)(5660300002)(66476007)(6486002)(6506007)(66556008)(8936002)(8676002)(4326008)(66946007)(2906002)(7416002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vvBpwrhxYmwicWkyyFq98/AKJsfJd6hp8Vk3W57CHOaiwQWO+l+ou3oVTxrY?=
 =?us-ascii?Q?qVAgRgh59w4c/Ku9GMBN2D4hJ3POjn6FJn9fevClGEUmH5ZXnh8YgJaeqmoc?=
 =?us-ascii?Q?gxL1JrBmnBPllDmtcrfka2j3HeVTStZOn0CkkYEtxqzlEc38AgF9ZVpJC7DI?=
 =?us-ascii?Q?TDTlLKa2aTr3FUdO7VxY8QI5OZdwLUsZtCSQpJY/BFxJQ+qy+k/hjYxTvPDp?=
 =?us-ascii?Q?BGSHhcxAqbC0Okj04ffHaV/RV6D/tklJp6hx0Va/OBG6Q769Sesygp+MLOyw?=
 =?us-ascii?Q?BpCBafWf/Q7X+uU9lVuAjBLdWRlenYyl9EnQZkRCmRumngacJfW6sJp9ZOmy?=
 =?us-ascii?Q?zSv9iy8FvoFRwrHz+iS01G+QkndZe4T9XUelg3AQry9xLxjfcsUISzmlLWq2?=
 =?us-ascii?Q?aHDk6N+cxB2dWgZt7BXknu4MThVden9PY1+rp1kRJgolw+xcsbpCFi9Z50rq?=
 =?us-ascii?Q?xo+adiTWQ4MVTSopXyWjxuAl7Nn8wSG4UEK3/c2yuuzwDUnSM+28p2igDYqH?=
 =?us-ascii?Q?I4BczB02fz3ZqpotPSS7/waK/vvtwyaW05UX/MJJtlIDWyr8ultzOh7oUoUb?=
 =?us-ascii?Q?wAHsMB2qYlkNEpYabu9jK6ufSPMFH5kzgRtlI4Yj8+7dsmq791J4ptavoDaI?=
 =?us-ascii?Q?S9B/4FCWiHg+yzu+lCwGCEbzBKJumDiiQafIXv4WhMzzd59aRz1fsY4CUyx2?=
 =?us-ascii?Q?VSAXPGRY91j8Po//7fgE6HgRaYu9ETK7aWvBCYEcdrUKoHKwCK+n9nAbeOvV?=
 =?us-ascii?Q?u1duzFZW3oYLzlZgEg1GyTfIDwZpgcEVD1k2t9Updt54F0pdkwEKY2S0FxmX?=
 =?us-ascii?Q?eBfs/edwt8EZUCNxu3o/FQYFPrQrP/Jd2EW7z+C/sMutWVqrdgP8MrxOMSj5?=
 =?us-ascii?Q?/gneoqCV2mmHAp7927VzDrSonmz84GMEqGBTkC4sMbs1u2xtBi/sujc2NKwC?=
 =?us-ascii?Q?50UmvdFyaJjmuq7GyOdq41y5a8piij122OPA4awtv+B1ht/rnib8EcRaGjxJ?=
 =?us-ascii?Q?m0lr1LfeyMuyFBAEmCuOlYMsDzOIOT0N7b4u6Qz/IVVnoIE+Eq09b2hQqCq9?=
 =?us-ascii?Q?2qondtCQBC0sb8QMbkHHED5vKU+zh5EC/yzyk9SQrdBu9ui+84degBqH/992?=
 =?us-ascii?Q?y0Wxx3fLFOfIt2UYOehTqduMLBj61HMNqyUzOJ/W4wVo0f6laGfF37Zg01Q7?=
 =?us-ascii?Q?srtJ/X1XTRWQnhmC1KkTIlNNGkA+r6aaYdkpNe+gB59kuWca6fRqtiBx5+aJ?=
 =?us-ascii?Q?72szYL2Hs2u//doLwnDS8kLhC4CDgJtebfcR8R3xONoAAdhlszmIomXG4C74?=
 =?us-ascii?Q?vQ3jl8v6Gbwp4DVG7AC4Cp5O3PGtICfpV//p/noRwPgutoYX5KM2UfDlfIr5?=
 =?us-ascii?Q?o7hXrCsnpce06RMbvzWtTv2SkDYLLQcs8R6DLBlWqoiJNVSRHMbKfgGaZi2A?=
 =?us-ascii?Q?M+SDfAyhoiKCv6CM2ox93eib5tlcnWZf31nSXqGU2eN9fSDotqf0/Zkfi9xe?=
 =?us-ascii?Q?X58QQSK9spoI1bGaGCxse3n2PWLg7YWtdliP+0OrHgcUSIP2jqjEzH7IdOvI?=
 =?us-ascii?Q?pYJ4U/ZQciDJUrUs+tq7yHjYbzkgixv8/Q0czjBMgfRxbc1ruPCKEKz04XD3?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88797f1-3f8c-482f-6229-08dbbfff67c4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 08:46:28.3515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWVdo8o0hraJb2jZZ8HA2YfEUT7UloZZH06OTW6y6AtlFyuxP8lgNcC+sOxZhPpbcBIoClmWQ+l2oAeElSFLcppitcEJk4zwIR5X6UfQt90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8475
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add description for fields of struct macsec_context and struct
macsec_ops.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v6:
- none

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- improved description for the netdev and phydev fields
- fixed typo in mdo_get_rx_sc_stats description

Changes in v2:
- patch added in v2

 include/net/macsec.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/net/macsec.h b/include/net/macsec.h
index 75216efe4818..ecae5eeb021a 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -247,6 +247,22 @@ struct macsec_secy {
 
 /**
  * struct macsec_context - MACsec context for hardware offloading
+ * @netdev: a valid pointer to a struct net_device if @offload ==
+ *	MACSEC_OFFLOAD_MAC
+ * @phydev: a valid pointer to a struct phy_device if @offload ==
+ *	MACSEC_OFFLOAD_PHY
+ * @offload: MACsec offload status
+ * @secy: pointer to a MACsec SecY
+ * @rx_sc: pointer to a RX SC
+ * @assoc_num: association number of the target SA
+ * @key: key of the target SA
+ * @rx_sa: pointer to an RX SA if a RX SA is added/updated/removed
+ * @tx_sa: pointer to an TX SA if a TX SA is added/updated/removed
+ * @tx_sc_stats: pointer to TX SC stats structure
+ * @tx_sa_stats: pointer to TX SA stats structure
+ * @rx_sc_stats: pointer to RX SC stats structure
+ * @rx_sa_stats: pointer to RX SA stats structure
+ * @dev_stats: pointer to dev stats structure
  */
 struct macsec_context {
 	union {
@@ -276,6 +292,28 @@ struct macsec_context {
 
 /**
  * struct macsec_ops - MACsec offloading operations
+ * @mdo_dev_open: called when the MACsec interface transitions to the up state
+ * @mdo_dev_stop: called when the MACsec interface transitions to the down
+ *	state
+ * @mdo_add_secy: called when a new SecY is added
+ * @mdo_upd_secy: called when the SecY flags are changed or the MAC address of
+ *	the MACsec interface is changed
+ * @mdo_del_secy: called when the hw offload is disabled or the MACsec
+ *	interface is removed
+ * @mdo_add_rxsc: called when a new RX SC is added
+ * @mdo_upd_rxsc: called when a certain RX SC is updated
+ * @mdo_del_rxsc: called when a certain RX SC is removed
+ * @mdo_add_rxsa: called when a new RX SA is added
+ * @mdo_upd_rxsa: called when a certain RX SA is updated
+ * @mdo_del_rxsa: called when a certain RX SA is removed
+ * @mdo_add_txsa: called when a new TX SA is added
+ * @mdo_upd_txsa: called when a certain TX SA is updated
+ * @mdo_del_txsa: called when a certain TX SA is removed
+ * @mdo_get_dev_stats: called when dev stats are read
+ * @mdo_get_tx_sc_stats: called when TX SC stats are read
+ * @mdo_get_tx_sa_stats: called when TX SA stats are read
+ * @mdo_get_rx_sc_stats: called when RX SC stats are read
+ * @mdo_get_rx_sa_stats: called when RX SA stats are read
  */
 struct macsec_ops {
 	/* Device wide */
-- 
2.34.1

