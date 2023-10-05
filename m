Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918417BA8A8
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Oct 2023 20:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjJESHy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Oct 2023 14:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjJESHh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Oct 2023 14:07:37 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB6DAD;
        Thu,  5 Oct 2023 11:07:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0mp/EJrr0B5guUpotlM7SuGNq6/XqPQoPuHy7D3SmTFaC4atEjRUK95Bw0qP/jvqTpQpzwnecVIH6iQ7xM4CztehJ2Y1mMw8NOLyEf9hBBgIap0mckJpyrF5DkCKpOY07vXLAnxpqzUnNeBWiUnElFAJJ5DcCvZdY52LYYI/66786zzraV2johK0HzqFez4U0JMderTDSY86QJoecH/VeE+n5XVM9NJrnWaZR/xZvpdKUYfzHEvydsL0uvh2UL5Tl2byx30mQyeiBEc0BsyxQt6BjUUe0ukF8Ha+Hvdhmb0d7Z/wB7eIxThAiq5tnTJSngFjDq+TbX5u2XDYiwNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9fym2qITc2WFFqqddKor4bIjquCyVaSCblHfjZR7hs=;
 b=GuBHXR9OxHtDp+e+expWklyqZYOTc+oa/EBbI4zZaH3D4hR/7+yItrO5TQ3GaKI3jXBDNZfQS4yV4giLXrZu1S641/0Rl4wxyLWS+PlFQwFsel8prfXTq3YRpzHGbJdQqV7md64rNmPm2pzmoErioOSeuBkfJ9Hsj37YeTWU/Zphz29ic+khJp54s2L2X2/yooHLmTX29qqPk3bh5xUBlTA7I7yVuNHWsuI4ODC6/1mNvKkFyZI03cSTTZdwWnQxIDFVD39Ymr7IhWOZ69qitqUWiGUpmSX2KHGFKd5tAZtCfo9UCCMeXAEyJQWsPP8sTKpJwl4+NQkkW27PgQb8Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9fym2qITc2WFFqqddKor4bIjquCyVaSCblHfjZR7hs=;
 b=jRRfd7xRFPru16Jp4hkWIP61ViGEALNcfowEqLdw1uwIMkn6PiXkiZKiIr3BLQclfa/PuT8mYlVcGzolx/jjIK18MUIzz5qUPknb/ZQ+BE4lFNG7h7bEZSkDMss7cCMzI0dYmSSEVwRatdLXugOBbjH4S/zkh/DWzU51QAn4kYQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM8PR04MB7890.eurprd04.prod.outlook.com (2603:10a6:20b:24e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Thu, 5 Oct
 2023 18:07:32 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 18:07:32 +0000
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
Subject: [PATCH net v7 1/4] net: macsec: indicate next pn update when offloading
Date:   Thu,  5 Oct 2023 21:06:33 +0300
Message-Id: <20231005180636.672791-2-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: bf57f076-7d6e-42fe-7d4f-08dbc5cdf237
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wY9//O6UK9USFYeM5N5CJ37SK4+ZqFWJl7b4EBFQXE1NlOGUnpPqT5qLz7R/rBgzIosjUJHJv0dwcXpqbIXpnaLStaelUWwsbcaRrRQ+MRGzIB4zHUvuFySX0dT7aYfwyPgnZJZ8lFjFVQlRS92VG9eF45StlKichkMlRqjAuQ7pzSYCZoT84rQvYOc9VsL8hQKxPUxsilPeCTP6MT4724+YxzNVlBTuQe01oRfGqIJ7eMcNpeQSvdilvF/gWF2UxXorHA85+2V1+w25bxclu1UlgZPH/RI1osdr86OOKoqzmFrfJgD474IApOZiUOv7luXAW9qlIGXHzQi4Uq0liTe0Qhp+D8TuDD72IUWEhErsW7LzYPd0h7Xf9daEsXbf2yJFM43SEHCG4qKEXHNeYGRqScd6kLl5jpgfBcGUepZ4AzywfX2GvO/puuZIxzZld2kjTtxf+P1BMMl+KcmakwaLqfwqAohwBhjRyv4pkm95l5olzdovRtwr6mCstIkyzfZwaDvcKOTQlQ4qSBT6rRMen/y8JYOTBi+mJZk1iWPpYpCSxCjCC7SHfxFyz+G5qUHWwZjSp/XRfPTvjeeJE3gDGiBAVlo9a+5AERydsPl6cEdfn63F5Cc4XZ4qi3eJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6512007)(966005)(52116002)(6506007)(478600001)(6486002)(83380400001)(26005)(1076003)(7416002)(2906002)(2616005)(15650500001)(316002)(66476007)(66556008)(66946007)(4326008)(41300700001)(8936002)(8676002)(5660300002)(38100700002)(38350700002)(86362001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QLpKHhiFOChN5X85ecZpdemfhvxC0ezIkgbnBEn80YO7UGou84iTxC3crdt9?=
 =?us-ascii?Q?Lz4yM9oX2JK14R8cxS24cwA1wQ7v/7CVvXsp1fOKW/piyl+rDXvApWpj9wcb?=
 =?us-ascii?Q?J7YqNX1JrnQ6MgNCsSH2r45+CfZ3hhwO/u3kS7QtOCluCTbqVkbvlYFeodJF?=
 =?us-ascii?Q?aXaIJ7+IIdecxYsryJqyAmWXxywObLJQawd/+yTU8fAEyVTeWOMq5xzbDlPt?=
 =?us-ascii?Q?lNkz2KqxERMwug1sBb6wiCJi+cNAaivJK8+44cp0H1utchAXPN3Vt/l0EwzO?=
 =?us-ascii?Q?JYImJurzOTrefmn32SM0GraJgmjJ3P9hmz7oaVrTe6dzb0LMK0Nr3iP1eQH4?=
 =?us-ascii?Q?NzkAoNWHD4C56Z+8aXTYk3FACg7LJhK+4bj4bjyMmRxQHdMuPY5OFUO5GD3Y?=
 =?us-ascii?Q?q/8JfCO9UdbjaI14AJGSuNI7KAFBlsBpmEi5ZPJngR9Yc8RAP5u08wt9GW8M?=
 =?us-ascii?Q?QuxH6wkoFDzOn/YkpZG0/U4FZ8pLnRkJLSTpdokGJ+fcG47MPiXHc4j3UAtL?=
 =?us-ascii?Q?Ubh9oS2Zp4kvZa4pDSd0Cf+T38+P+86DkeAtk7h1JlXuoAqIi/UBzTiwcS9Y?=
 =?us-ascii?Q?1lj+Pkx/AwPLnL678AJnEMbezSV042kJo5rjq/POwYqviNg3k1AqEg1mi8MI?=
 =?us-ascii?Q?DeXPF7uPQwaE3uerbTc2paIWsCowT7t7fzlntQzRE3I7aySVl2JF4VIDssHx?=
 =?us-ascii?Q?YKXlIpqtGZtSUkfJJyAuYbhlyXtiDaVXqm4ER6CpiG7DpLkBcg56ZCd8PmZM?=
 =?us-ascii?Q?+Ebwh3oXS9RJDV6qbbh+Zf3ety4sSw26GqhAV0w8lP0KCdaJxTPXfBC+B7GC?=
 =?us-ascii?Q?iIQnTaEqff2Qzc+eZ0hjMzadxNVusYUk9aRJN7Zo3Jw+/0iM8QvaVnhA/Y78?=
 =?us-ascii?Q?jyMzzcOra6t+PwzfkUyab8y7BCuuB9QA/vbUox4+OMRqtUW4yH6tH7p116Ki?=
 =?us-ascii?Q?MBdUpzJHqLixfLttCzzNBFof2f3dSUWKD6N3IAZJ040MJu5FlMedb0fth4KT?=
 =?us-ascii?Q?v6jQfNaqteXrGkq5PZZkTfXS3sel3RdEQ2Hxbf7XI77W9SgFInMAznxO3XFn?=
 =?us-ascii?Q?e//J0Gq5QK3rOdJVmnc5Bsx6g7MRqRAWlZCgVHuN0wrKJWxikXunhAGhh/7F?=
 =?us-ascii?Q?P6Q/C3mMruiKlZ1Y/UbZwt/xcuGnHkDZxm4c1XrLvE5UPc/2/4Vtk5y7tR4u?=
 =?us-ascii?Q?ubLTZDkYj/g0c/1W8OVltqLjUIqsNh/Rwg+BOrHzUIaeUDxo93ByCHkYBkQc?=
 =?us-ascii?Q?VeGb9dmUZanlvZWcIIBwOSep4wAfB3AcDANaTcS4HDgc3TEDKs2v/MNNIt7z?=
 =?us-ascii?Q?QlfOMi8EWWjcc87sTQxuNeat8lE+cnNBPUe4Ww9VehzWf/lQg/9fPOcByYdO?=
 =?us-ascii?Q?8u38V2+mOV+df/0nWNMeJ+/eG9UdcxvBE4yjkoAxbx0EEZD/7mbqMmE9er2I?=
 =?us-ascii?Q?HwWFf7LFv2cD7J0fuzSpMUAWf7jQGR74cXrgJIukh++Qq0DQw2LmIJyvhJRF?=
 =?us-ascii?Q?iSCDkSl5bddGkOBkBiAxfvqXyXJCv6AwYWrnWF9cQk6MzbJubckSq+GEFUe3?=
 =?us-ascii?Q?BlHNFWFgFtpylTEJvh59ymiOtM73DsBd9ZGNKmHbD7hutkx/f+krDLEnhuTE?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf57f076-7d6e-42fe-7d4f-08dbc5cdf237
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:07:32.7370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lXkXs3ORK+948RFKo29zbeKO0aAKu2EjmWAzs07g+Bh6gtGl9+PjswhYxE6j0cr9hMQBbXsxa7G4my9aIc3ooRVAKeH3i26oVuX4/7XGsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7890
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Indicate next PN update using update_pn flag in macsec_context.
Offloaded MACsec implementations does not know whether or not the
MACSEC_SA_ATTR_PN attribute was passed for an SA update and assume
that next PN should always updated, but this is not always true.

The PN can be reset to its initial value using the following command:
$ ip macsec set macsec0 tx sa 0 off #octeontx2-pf case

Or, the update PN command will succeed even if the driver does not support
PN updates.
$ ip macsec set macsec0 tx sa 0 pn 1 on #mscc phy driver case

Comparing the initial PN with the new PN value is not a solution. When
the user updates the PN using its initial value the command will
succeed, even if the driver does not support it. Like this:
$ ip macsec add macsec0 tx sa 0 pn 1 on key 00 \
ead3664f508eb06c40ac7104cdae4ce5
$ ip macsec set macsec0 tx sa 0 pn 1 on #mlx5 case

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v7:
- removed update_pn description. I will add description as part of the
following patch in v7
https://patchwork.kernel.org/project/netdevbpf/patch/20230928084430.1882670-3-radu-nicolae.pirea@oss.nxp.com/

Changes in v6:
- changed update_pn description

Changes in v5:
- none

Changes in v4:
- patch added in v4

 drivers/net/macsec.c | 2 ++
 include/net/macsec.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index b7e151439c48..c5cd4551c67c 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2383,6 +2383,7 @@ static int macsec_upd_txsa(struct sk_buff *skb, struct genl_info *info)
 
 		ctx.sa.assoc_num = assoc_num;
 		ctx.sa.tx_sa = tx_sa;
+		ctx.sa.update_pn = !!prev_pn.full64;
 		ctx.secy = secy;
 
 		ret = macsec_offload(ops->mdo_upd_txsa, &ctx);
@@ -2476,6 +2477,7 @@ static int macsec_upd_rxsa(struct sk_buff *skb, struct genl_info *info)
 
 		ctx.sa.assoc_num = assoc_num;
 		ctx.sa.rx_sa = rx_sa;
+		ctx.sa.update_pn = !!prev_pn.full64;
 		ctx.secy = secy;
 
 		ret = macsec_offload(ops->mdo_upd_rxsa, &ctx);
diff --git a/include/net/macsec.h b/include/net/macsec.h
index 75a6f4863c83..ebf9bc54036a 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -258,6 +258,7 @@ struct macsec_context {
 	struct macsec_secy *secy;
 	struct macsec_rx_sc *rx_sc;
 	struct {
+		bool update_pn;
 		unsigned char assoc_num;
 		u8 key[MACSEC_MAX_KEY_LEN];
 		union {
-- 
2.34.1

