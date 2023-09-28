Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1577B1665
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Sep 2023 10:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjI1Isa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Sep 2023 04:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjI1IsW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Sep 2023 04:48:22 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99361B2;
        Thu, 28 Sep 2023 01:48:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcB38tmDopXc/acHiKenNyCrPRUU35I/SWlz1d1p+AEhHDSIQ3ox5f4hJFNeF4spKOKP6K34bDbps1K5wuF11rYzlIKB9anSjW18VkXB5UlJlstALkqq8TjVEq5iex2xFZpbQvd4MrvM+WWe9WejrFOW5cpRRrjsf9jun2JxVzWG30NVsFOVC2goQjterTkg4m2kQTGXF9IjkayRWnW9B73SPv4r9Suz3hKQ70ODHCVrnbbbMLB7jllSxJN4LeYsnxmxmUGLJTgeSl33BzahTb2Blk5Pks7LiR85k8crHNPNSsX8tRFjCslC2JSERCwE/z6goPOVLNHzNAfNyBGcuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6A6gygkYydHoomJeXPSTUHPEz0ndPivGEoqdBqN56mI=;
 b=I4Mhh/C1RuGuT7m2xIcwOLhmLop9/5o8oSAEteCjl08g26wENgn5uthWdfDkBrLHdMdm01U+adWHbTW2QKU3vH5NEbWc8pcHEm0W16jXQ/+FRD9bdMzchZQSrdVI1o2vpTnAICz4Ti4JYPZu+lp1Sb939jk3I8xIlhC6EK6YGcY3zMQvlvVJCzpoK+QdX05CBurjjJxIruz49lt8qCS6l3gtyVHXRvrFzD4ZBMFDgXxijgn5lX7Z4N8Y9PSGwUgW5dpTpvED+E4uCTC0r4kKdUQnZrAzRp202wzC3hvX5jlYRPod20NzzDneHaNsIiN3MVxAA1iL39d8RM57EywUvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6A6gygkYydHoomJeXPSTUHPEz0ndPivGEoqdBqN56mI=;
 b=Iq/QPALPM3mHKB7ADX7kNpoEb5M8w0T+g8glUlsEPhALgyfc3FnxsP0zJtlCHfQM6iSGqaie9Rq1k4lcwV9G5KY+raNvsBL+KTccaMcVibYGNnBNo4Sue2Cc0cDdY3H2KEv/2koC/oOLurc9w6Pvknq/PbRAx1MHa8oiA4g7u9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM7PR04MB7031.eurprd04.prod.outlook.com (2603:10a6:20b:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 08:48:15 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 08:48:15 +0000
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
Subject: [PATCH net-next v6 07/10] net/mlx5e: macsec: use update_pn flag instead of PN comparation
Date:   Thu, 28 Sep 2023 11:44:27 +0300
Message-Id: <20230928084430.1882670-8-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3f4beede-92d6-4608-824c-08dbbfff9938
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KZfBa3iYrLROKlwBQJLseOcwkuvKpMLMuwWmybAH+lUkfvdXSz4Z0kcDv/sq44YtV9FF0NUgGEhGhxntRvYJPTbioyEBv8A9/Zv29Hex29PMU/2W06f4B49iHH3oTRIyGPeZA6qZi2UDrn4GAmiWYQcAPXQoz7fV5OxJSC4wuGSGCxdSBdqq3NtuHKuN8MTfBiOqgOMwsNC7oHKsJJdovUR/Q7eI+aDZ5u3awdd0XkQeK4kYAfA/uTBhAhEy/xbEZL22xdgZApDC4Qi5DrGYnpQssljFRcgHl5npgFiwS+eWtw8SwO8sHrtmoaWkE8mmr1vID2EwswEIKTzKgnAisd8eboQDUi+jTV4A554MjyE6RdKzY/ordbcYzixN3HfsLGsvvR+DfzZ2sp/pY4B45RcpEvrqnqd3drUeJqmuVSP+HX3V/u0mP0jCAV0jXdiDWH4Wa9yWdt0hYtGZBZN2wrdAFXhUrkP1x++D6RRdyEqWP1BmKDuUYWjrJVIRICkwl8GeptsdVFPOkkhA+8Su665V5rcDn3RSi/q1TqirB4lTQM1ABJnElVKZookBaW4BXAuy/UN08yLHhL3KUgkSFe3ITUSSzsFXDbM//muPalWUOSTYQewSt+QKWPDaeqJBmYZBsQk9KDRIymsY5BCRXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2906002)(86362001)(38350700002)(38100700002)(5660300002)(6512007)(6506007)(52116002)(6666004)(83380400001)(921005)(6486002)(478600001)(4326008)(8936002)(2616005)(41300700001)(7416002)(1076003)(8676002)(26005)(66476007)(66946007)(15650500001)(316002)(6636002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PGFUKI8Lk5BG3H3ZjRYV5V05HIfX7KC0Yo/ZEkPK7FSRqnvjDSB5J3brQNfJ?=
 =?us-ascii?Q?S/0KCPqgL9eLPlLoC4D4xnChpq07UsPu3H6LIKRng0CXRCY6tC1blMxW4w0w?=
 =?us-ascii?Q?7Aw/di7/Gy1NJzZxQg1aejqmbeM+7PnD26/UHejWxvHxWVrVlLZVRtxflGPQ?=
 =?us-ascii?Q?TeFYZyGenpQgcLIVM6pp2cYDbUpUP3HDE+xlLQmETKoKufNahTD/EzoT0/gJ?=
 =?us-ascii?Q?bXZ29ppwUpI1I+8pNp1lv+FPXp74U2JG4DPENix2vPMI6014ohm5969Gulvd?=
 =?us-ascii?Q?eE8myuYGsDWrR2GRyaNrEyWkdTNnLrTXLskZZwDwCpWFzlh8uQ/LrZvCi8Xf?=
 =?us-ascii?Q?N+H9bcxlpWOxU5Ghm1bofew+qt4tjeUgy2AgnkrYaxSzwFX38OHlotOY0MJB?=
 =?us-ascii?Q?Y40DNeAi7fvcLoXO7S2sGTWziQU1JYGKel1fJNtcgvKY8P3Nen7lTF05vOtT?=
 =?us-ascii?Q?4EYzn0yfUYfsSZTCKab+aDWDS9CuL1EH3I5PKAbVCotGJyG9ZWMgAv8dQ4GJ?=
 =?us-ascii?Q?h7WhWfgFfNjeMo9NdeZEFceEU6nDzGTdk0NkIuk/Ki3fDS9R8Gy59nmTIYqC?=
 =?us-ascii?Q?3c8oQn5jHGMa7z1Zkci9huab/rRZlCUtg5FoYHZZtwEiRJq0/9037rMJv704?=
 =?us-ascii?Q?2TDfQaA1tkBFi3wnwfmKj7LdxRrZ7GSzQhSAimUw0O+cUtyzIbIOnilZ9iTb?=
 =?us-ascii?Q?WAbwlRg2jPHdgriNoM2zB49YoOKbzHmqcsFccsma01xeJrV7vgvUvEtcSWm/?=
 =?us-ascii?Q?ptAFbEXMlWYDuoBPchLSMjpfy/Rnfzf9BKnj5VenCejudHt9Ae3mUW0MvcOS?=
 =?us-ascii?Q?tnn/ceODO9dq/YoqRiaHnDJI+Lv/m6D49mcVVqsoC7MydE6MZwNM6eT/pdIk?=
 =?us-ascii?Q?P44lbu1UX0cy2AmHAKMWIYcUtrTpNyH2v+ibykYy63bOCvrjI0B+zENUqpck?=
 =?us-ascii?Q?VemxCg6yMH8Fg2FELNv9OYE5tLrTvbR5uzSU+CHsQLJd+pb2HnRBFOe9m+cz?=
 =?us-ascii?Q?jdjvme8rk9glNbsFcj6GpXKpBsgrIepk7ZR9ef7pGu5QMlII2g8X2AkqnPpI?=
 =?us-ascii?Q?vZZRRsxZiJM5irJwZa3V+4a5K++4yZKtnsxf+Y7vuF4jOJO35cqXoNwD6m4N?=
 =?us-ascii?Q?tfTQiUjpp0u/Np0ygvVVoOHrToVrmrx4z/xrcdOE4xkgOL4kctm5Ts1LaayY?=
 =?us-ascii?Q?2FMx9l5sSYcbtPq+DgZc/5jrWy+ip1CEjPEZT9tkC/QSqSf6ZTUKbQulZOU5?=
 =?us-ascii?Q?F6xR1UNjg8Fj0L8x5ph4vbZzuVE4Um2zWL3k96fpi+WT7ij3TWz2yXs+P/UN?=
 =?us-ascii?Q?Lyv4mHbY7H01eCl8yHrlfgH856hdKaAo+J76eLxD7U0ATSxskpiBAzzmy6dX?=
 =?us-ascii?Q?yAMQWDLtjpe/PyP9fdspUoo6T4i3N+4DjyaN2HGC0LIXLFTZzya1M9P4Q7lJ?=
 =?us-ascii?Q?22rcjttBAkUV7D3J0mj4594WnO0BA+Vh876rqPIez0yUi8bWBG38r/uyeIv4?=
 =?us-ascii?Q?1MU++8xcVmaeU+lg0J+/C74Q9jJtUWq9EEjWmGtYJI79zKtBywiol0gTbeL1?=
 =?us-ascii?Q?esdIC3o5Z6U5sKqSEheKnOsEpySK3ycGpjxF/8uybZDv7wWP/JJm/1yREDxu?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4beede-92d6-4608-824c-08dbbfff9938
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 08:47:52.3019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBWtMf+xSJDIfh2jvxQcqEEkBJYEz1ZRPY2BvF72/oDjmZuTmX58mHcLFTXsrlSCugSETGus1lFggIS1UkWZDPXg9w/Vv2LpYatjZ5pJAb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7031
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When updating the SA, use the new update_pn flags instead of comparing the
new PN with the initial one.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v6:
- patch added in v6

 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index c9c1db971652..d4ebd8743114 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -580,7 +580,7 @@ static int mlx5e_macsec_upd_txsa(struct macsec_context *ctx)
 		goto out;
 	}
 
-	if (tx_sa->next_pn != ctx_tx_sa->next_pn_halves.lower) {
+	if (ctx->sa.update_pn) {
 		netdev_err(netdev, "MACsec offload: update TX sa %d PN isn't supported\n",
 			   assoc_num);
 		err = -EINVAL;
@@ -973,7 +973,7 @@ static int mlx5e_macsec_upd_rxsa(struct macsec_context *ctx)
 		goto out;
 	}
 
-	if (rx_sa->next_pn != ctx_rx_sa->next_pn_halves.lower) {
+	if (ctx->sa.update_pn) {
 		netdev_err(ctx->netdev,
 			   "MACsec offload update RX sa %d PN isn't supported\n",
 			   assoc_num);
-- 
2.34.1

