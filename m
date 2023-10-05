Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFC47BA8AA
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Oct 2023 20:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjJESH4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Oct 2023 14:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjJESHl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Oct 2023 14:07:41 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820E793;
        Thu,  5 Oct 2023 11:07:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iu7BWHsSxK77pEZWSyps2nFaqxFYODkBkwn2y2cYVXPT3maJnw+a3FyHACIr+Rb5/oN6P/PIVFXQew4c6WvkY00aId4ZWS7ClEtBxHBCGojMBoRTizrga39TECYOmYPSdArXJXvqc/CSFC0jJmRO6eVVHhTQ/ngTwEzhK/85Mmr7hYrZ16petvvr4OZUlYbd+wKXUhV1VUJW5zn+SzBTWgdwf3WtLKywChgPcmNvGHUB6ebj8OBGwoG1G3quALeVHXA4NWyyObvn1wkaBfXpdzl8E729ltudMQx1GS3f6O25PgTCmaofuYaqGSmmWYypXieYqWqJnovcRSF1XNy2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPFhBZyLC0qBinCvNIGYq0QFRoz4qNOw8azdrzHJyIs=;
 b=axNn7oUPexSQV6i2mX7jZjBLs5qoTtYiJW998t4T0Hsuvlc7Md3QXwpJqT/AEvuKorgsNuffIj2lJLxamU1LRzFW8WNky9mmOiVz+VwjjNnK/i8YzasMHY0Dku038FKmA4Zp5+zopEw7qwxO6fjtPhACltpw6OBlCOUqdRMWEkemZNlIZTVv7iAUY4CVT9pvogoT4XdKtc/KJoUFyHFuIGStgvSTncEQLtWy0On4+Wq/xl1Wcrkwe721tcCf8QuwBU8voUohlZTYIl8rjgEheNipQHX2I+QJ+zTEHWAwqZn3GfdNs0zSakxFI8+/E9PQ9Yy/pm5FFbaD3vJHGPQoyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPFhBZyLC0qBinCvNIGYq0QFRoz4qNOw8azdrzHJyIs=;
 b=gFJ2EPNTOHDJKxCEi+9d8ovBasrbgb9hX1YfrexPK27Sw6B7pm3HybJoZGdPIHvmc35OCV2BlU1126lYbeAiRPuroJYz4INSj9Askaug03M2GDhdnsVMYZ/3zq2XDIj007Q/eEYKSQwLdtH54D0tPlpR1xWIfGbrkAZs0JPDqHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM8PR04MB7890.eurprd04.prod.outlook.com (2603:10a6:20b:24e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Thu, 5 Oct
 2023 18:07:37 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 18:07:37 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, borisp@nvidia.com,
        saeedm@nvidia.com, leon@kernel.org, sd@queasysnail.net,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com, sebastian.tobuschat@oss.nxp.com,
        phaddad@nvidia.com, ehakim@nvidia.com, raeds@nvidia.com,
        atenart@kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net v7 4/4] net/mlx5e: macsec: use update_pn flag instead of PN comparation
Date:   Thu,  5 Oct 2023 21:06:36 +0300
Message-Id: <20231005180636.672791-5-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005180636.672791-1-radu-nicolae.pirea@oss.nxp.com>
References: <20231005180636.672791-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P194CA0041.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::30) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM8PR04MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d2f66ce-6c82-42fc-8351-08dbc5cdf54c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uIDjLEGi80KKfLoiKBfPwR6SqRkJ+sSccc8AY7alPd9vphDHJqiL8c1EX7a4oxWxSflCb3TGzhT2L41ko0BFQC3mUi+29PrRt/UPUzjsAZ2vdokL8MyR8hOkaYFRC65GyqN2fcjCQsyeggNsh1vJi0CpscSWP0c7pEEUYP7MIERHbKjoJyDfXRnK43pHQH6+tISaX7unS1c61Sse2lbOYE8WlmMaWjHaZxpgL6ciisVV1UOErPXdrh1GJM/lWUYEpTKXZSNOrPEQRFm8EgCvkYSrVvQZRJTskMgV/818omRH1IMZ/BlmZ57UZFngqDxVBIEGUSwzRgjwFB6YkIyFXYExkpUzV9dyIxM2BlRZ2FqAlOT/Z4rh3TjyXYd+vgrClJx1UCKN8Fz03Goq3aFG839x8Zg9KLR6o8XW9k2X0IVXvvMUaHBZYlTnxfiMbiutb1d4+bZgk4HgEr8PsjUZXtgnRo//voKJFY2zJ839NE1ubJ5xrYfRb3w15NnvnjN1y4hladjgmPsTAl8qy7Dv/qXTyNbz6ppABx8pO4hraRNqp3w2zE20yd0xaA9qvgk2tfRPEdo2sSSvYJh3ZstJ8O8zqQL8XcgvLa4cIbbWpUj09bLUZn1+/YGeizQWV62T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6512007)(52116002)(6506007)(478600001)(6486002)(83380400001)(26005)(1076003)(7416002)(2906002)(2616005)(15650500001)(316002)(66476007)(66556008)(66946007)(4326008)(41300700001)(8936002)(8676002)(5660300002)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w87/Ekzlr9nZCSapRGFAiGe57PVptEovOoBjPVxentKDEHTKqaW26LDgsP5/?=
 =?us-ascii?Q?05CE1hM89lti7rEPgfelnKLyf0CBJk0RBNRau9uswzrA4BKNebKDajCym/1W?=
 =?us-ascii?Q?X0QOo+Pr/HC9mPuM733OgG/VBl2HA+VhHpsBSoq1BpYRU6TbMI2Ri5grcL8o?=
 =?us-ascii?Q?XiiVQVNdNCvQo6cZIkxujqYmZawQzeisOVMCzZI1swSIW/fIOBTw7g1iO1qo?=
 =?us-ascii?Q?su4IDDGVaTmP93ivrbHnywE4BMi8xscPSL9VraVceIXHirBDsICFAkE+LCjc?=
 =?us-ascii?Q?6d6VLTPIPozSjCSSvqKKAYOi1bJjO4AUosy8E51yokuXDbfZGVB8Y5+7xQfc?=
 =?us-ascii?Q?o1FWgn4iHbCLVVorZA/21XvLjDQg2G0X53WTBd2ffEbWAQjmzOciqXxZZf1b?=
 =?us-ascii?Q?f8sfR4VqeasnL7+kosKQfkUPtFkO+6BdQO1023AyvNnbc+d5rmUdb4nCenbf?=
 =?us-ascii?Q?gYIRRBsJQV5YwuijD+YLYm+m83pyJtBORpoy5V6ovqC/lqtssQmFmz04gF8P?=
 =?us-ascii?Q?vcmgeNwgTIQ1Lo0dd7RSFefu9Sua7lzb+TiL++xKNSllXlk4NpT5TGEd8wkN?=
 =?us-ascii?Q?tOXnF4gbMO+4oNyzzq5ABm6P4uWGW5iBw+4212IiZIFPI933+OXRAzjAYGkR?=
 =?us-ascii?Q?zmQFDrp/ABUZMIT9TgNnxBty8WjyFhJVQE890S1Yh9/YyDx0fm+xVSyjrTYR?=
 =?us-ascii?Q?4tjqllnWhdRJHCsbAM3KZKdMLXz1+gOxx82FjSBpbu8C3ilZozP+oqSqDNse?=
 =?us-ascii?Q?iJIgiavhgJSU4s8KK5FTWT8nwzeuPH0RJh10iRqyWGekDDEwpR5ksEVD7lJ5?=
 =?us-ascii?Q?/AC6b1NKVzcUbhWwbzE+qWnJj3QDI4deNytsubLE+K7L0FPBMKJjkoxDnLyA?=
 =?us-ascii?Q?grItrMLbcYBP8pM2O75dKnvTytmnBckIpr38MQ3XHHTD5taprPIcd/yjUHL9?=
 =?us-ascii?Q?fFUXtzw/oBNBPuo3J4tZMDUUD8VIJVt6/eK3RlT4YCAb01vZE4JheQeyfGjO?=
 =?us-ascii?Q?px7I9BJm6JRV7wUPmGXbL4EwePLQ3VMC5ab0r1IGKTROiN+T88YnEWvPg+tP?=
 =?us-ascii?Q?235Wm8sgEY+A9vBCMVE904/ZrD+SWqrLJYux+e8xJ2Kt3LCIPjt/xw6VxLJJ?=
 =?us-ascii?Q?o5BB2r0Qy/QsDrkuwtwXaWX7KuhFiHZpGJISBdUUCMzH4sgbR9n3epQmoZlJ?=
 =?us-ascii?Q?icGYF+482xq59clnDpi0WbcdmibHQGAosB3P8RI+wyUhFtl/78eLAE07RgRa?=
 =?us-ascii?Q?SeXovM/g3k6HZ1DTx0D27udW3HAE/CxaDD04snavPLZdq/QdDmSXuDLy0WPN?=
 =?us-ascii?Q?/DUuFvgbvr66MLwLYJ7DVQySowRNqCSRySDGGYW4bL3D5Tn4C3Oy56nSoDuY?=
 =?us-ascii?Q?xgEyQ73xpj4C0jZ5Svvu/bXClAX+afOwVUN7B2LPKHFcm/ZM0LgAXlUFwVIZ?=
 =?us-ascii?Q?mQCFKu2Jwt8ujq8suhyz0Q/ZOlM9pdPQQxP5m7TzxKusAi08AjS0xO52Czml?=
 =?us-ascii?Q?jrdDPoTqOaTpwCBcMDF3dVgxJxJq/W5CkpoK0hjieNF54fP+MbCD1jva1cSW?=
 =?us-ascii?Q?l8w6kCri1M65F/TO5CxlvG4auZwYH9ktL8Rh+XOyJTIPJD+jmwLWKlAZwSMY?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2f66ce-6c82-42fc-8351-08dbc5cdf54c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:07:37.8904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSZwLfTRQRK/jqqYxjWBxJfW+Raot1eWHKbWyyS2y13Ys0VkuSUIJoCKTw5rpDJ3g7SFeTE0TLXOptGQkgYxoZOhHhM341fPRva+Dk8R+gg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7890
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When updating the SA, use the new update_pn flags instead of comparing the
new PN with the initial one.

Comparing the initial PN value with the new value will allow the user
to update the SA using the initial PN value as a parameter like this:
$ ip macsec add macsec0 tx sa 0 pn 1 on key 00 \
ead3664f508eb06c40ac7104cdae4ce5
$ ip macsec set macsec0 tx sa 0 pn 1 off

Fixes: 8ff0ac5be144 ("net/mlx5: Add MACsec offload Tx command support")
Fixes: aae3454e4d4c ("net/mlx5e: Add MACsec offload Rx command support")
Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v7:
- none

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

