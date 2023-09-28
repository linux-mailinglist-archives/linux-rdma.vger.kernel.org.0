Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0F97B165D
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Sep 2023 10:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjI1Iru (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Sep 2023 04:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjI1Irt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Sep 2023 04:47:49 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2052.outbound.protection.outlook.com [40.107.14.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C3C9C;
        Thu, 28 Sep 2023 01:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVEyJ+qXQYTdfs29Brgp+b0V/1k6mfqbIvsHOs5BBjduI8RSyTB55uQsgEVCgHtcH9yPZ8wSQQ0tRSpb4pQrtRxhPXZp2rv5YRMQ+I27pZBuVMLrKbE6HIaij1FU7L2UAGSYUJIy+1pig6GCFdsr6ZTNnMO4fKs1bcj96ydcbRJ3HFvUIofvUsdGpeQ/SSD09F3ZgCggucKoiUOiDzDB5IulUfZWpSH6IKZQarqYvY/+I9UiNa4I4Gko57nSOEMyo1SLjb7sSumKnW5220HLR5qqnx3YSLe0r6NC3ah6jY9dhIXZJlwVlK5Jm8NBrCEjDcwZsT535Rf9DLjl5r103A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOaGR7AwYpP42vjC209vORt773LJsJ1Prod6yInbC/A=;
 b=I7qCuDvZg9Hkn/C+RAInYDZKtxJyASiDIG86eICHmb1wFXmB9ixNnVA0nGgYgTdZYPTJMSy9r1iC9rCQzlPb0OiMuPGmbXNbI+6i8kOGHpD944NiF6kp2JA2p0C0dN34mbcjILMmOFY6mV0TVte22MgaQs+TKQdYMnfrer5vG1lQGeeh2HOKuJJoc+J6++3IwuvPg2vkCigv3gUbN4aN4t7D8A7NcJDtmU4HFCPGEoZTYtNHWY65I2EK3h8o25QAnioSjG9M6o+X4fzn050FU3ptcajAVyjrmDOVvvZxZJc686feYTt4XlJLeof+woNbWnn1gGBA6ZkRjo+M3trbkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOaGR7AwYpP42vjC209vORt773LJsJ1Prod6yInbC/A=;
 b=iMeg3a5WJwe2z6Y70fdqhIJWY3BqcTS4uw8CAVEnQ6R5lO9Oe6auboRoek3yN4u/If6DGwn9C770YkBcOath7RcVDplxe7eqV2Ka9zcT4SEPuXuSb8l83mSwBv1ddkrgxlbiUHmfF6xlvOUDRZr32AG0+h3R+jwUrz0/3cDNv0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS8PR04MB8514.eurprd04.prod.outlook.com (2603:10a6:20b:341::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 08:47:43 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 08:47:43 +0000
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
Subject: [PATCH net-next v6 05/10] octeontx2-pf: mcs: update PN only when update_pn is true
Date:   Thu, 28 Sep 2023 11:44:25 +0300
Message-Id: <20230928084430.1882670-6-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS8PR04MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 6447dde5-a622-4139-06c8-08dbbfff84a2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bqSimji4B/iMcKeVA7XTNRDnkURUBtX50cxDQ8McliZbw+5rY5omF1F86gV0U30eIc0C7XkJKTAqBqCS+LTdJBM3wuluHYYNVmhXAlMTjQrbKVaFjt0xcxs4eGrxBO+aMyHtScpwwJGjmazLX1sf+Sj/3XZejw3PZBviNTtnwebznzctmWMIPPQsVzxMxSAVQIjdWMCrnPhxE63kUWRnR+tQl0iarbJHIWwPgZTH+NySntBv33BiHbbs5p2XxnB05LltrGbKHUlaEQ0B2zt9Wpa47qv/ewVaRF5iPtXlmhVv6a5J1CKuTBxrzafpg+KJ9nDzArWhXCAYteGWRRGWZxDyZFgmJAn1/0Nv9dJnWY2wV7vDY5eCzQ/to+NlyUSNscG4fLv4BWw+Qzwuou6Zm6UDs+YlBfi8fQeEr/VvYjIuPgkwpKf26eKjvt5SMV8qd1oOUhfIexbmYzXqTsCEojOiCVYnQd84T+IrbYyh9XtDUGfl3kMxZoECb5TdJOBPuJ1DDT6aXd9/dlvkM0bo1mGidvWS4DJIxrxgN1L6LuyMyyOMFnrFEWj1tizqIa40cSJoVrDs6BKh4ybG6T9jmasUgKhOhtIdgahxv5Lz/ofjNsaAatu3WnC7Aqd1OuDl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(26005)(66476007)(66556008)(6666004)(86362001)(52116002)(1076003)(6512007)(6486002)(478600001)(2906002)(38350700002)(38100700002)(83380400001)(7416002)(316002)(8936002)(5660300002)(4326008)(2616005)(66946007)(8676002)(15650500001)(921005)(6636002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sxy94rFrcUXvjLjsSAcT8D9WEnHlUY7iJhOV2A1LowvxGMNmp2hwovz2aw+1?=
 =?us-ascii?Q?ygwSbsWyIpgQPmo91OTVYsWhGyOf2K7pFaYxKHdKehXzF7MgLWuAHUUV3epo?=
 =?us-ascii?Q?XpZ/l+AYoNXaiER7HZAs4grYI8d7L1Zc1rJrGIsBJcJKWg0pbY8NNsHjcTwn?=
 =?us-ascii?Q?mtQDtLiRbmd9JD7/F1g+j1VXlhM43sXx/qsxF8Op0Ljomx1uhXQyZc/+VVd5?=
 =?us-ascii?Q?x+c4j1QRyYQou3yX2UW0SNfk2WbhNgHZiWZcknjo4gh/Wfq25hCCzITBat1j?=
 =?us-ascii?Q?XF7AykBXTV8raNE0DufhoXGxMFeWhulTlIonjEIYY9HbdtIM0XtH0TwZlE4r?=
 =?us-ascii?Q?GrC1vFF09tbwEX/ig8GSJmZNOqdMWPGSJWtvFZYJv3EqwLvexVtrbSJO24OC?=
 =?us-ascii?Q?Yyx0ip449QEs5p8cGOdfoq+2gKlKI4wvUhz2NtQiVqJNbHjdNUwEFhzLaPuz?=
 =?us-ascii?Q?hMy1H0BnLvicQOTq/r37T9Y8NvKwKooATFfcvSeAl+LIDXLA+YdiYbwKKAjc?=
 =?us-ascii?Q?GPwSqcbRTYSlybKZDkQ9wMWBHvx2ddx48BaJRmhmsYfGIPBx9J6/jSn7SCM5?=
 =?us-ascii?Q?h+4Sk4TT93phgZuNPGgk2PAt838a7ljqm4J1ozGp89TjxnbmzNTgauLFZCrq?=
 =?us-ascii?Q?OIWEZf3AVta304P5/2kgn8xb0AshAcYM2T+AhYSVendBm4Uimjk0FyCs3D0M?=
 =?us-ascii?Q?rhEGR1EYPrwN2vaFIU2wd+d21WV9DGXmUOc8DV2wfbRoj8XpFXkBXtuuUzia?=
 =?us-ascii?Q?SSUZQML2Giz6YgDgwaBVzy1763aVHb5yOu85NsJxR1XDjd11cOVaz8CiJ7v+?=
 =?us-ascii?Q?EuNQYxdY4MdMsnmkkCnPNLIG1jOuhpYv2HITmXePzoYVH13ZnXvOxDUgrZyf?=
 =?us-ascii?Q?KDhh+pwWw8lqnpRWQEBKhnz6/Y4Q+Za0J25vYDk7Ap72fBYTlg4AkhJKQUm2?=
 =?us-ascii?Q?gqHkdZFz2E1v3K5XGs+gu344BSov20vzgf7pabBQXb8Do/xCbodBZDUNxAKb?=
 =?us-ascii?Q?FHso5JhA4bLLpr1aMBYDbCiXaESCwgV+kGqy2pq8wu1PRQqNVD6hn3O3G7X6?=
 =?us-ascii?Q?dApShj5ATlOZhDeu/KtWu2xnrNIUqVJJeFTxl9Z1lL9T4dXVvyKFYrCt+v95?=
 =?us-ascii?Q?Z3+h05NxQqhqkrNZr5Hb4bWjgNOrZjbhanc3n3rphVVRrLy/mInT2KW6f0kQ?=
 =?us-ascii?Q?OXxaS7glfzVgdwjJAhumn13qM7KeNSwaNUO4Wkyf3rzMI8MVILy/1e6bt+7Z?=
 =?us-ascii?Q?/nD2yUVO1gUkvJmyepuWR2otj8ojUSjFDS1JsmcGXz16q6kuPc4x47vxSehO?=
 =?us-ascii?Q?0ft6U58yvlBe4zHtt3db6O8vpU3sC94Gc1Aw496bvcNdi0AbhL/24npo5xN7?=
 =?us-ascii?Q?oaEOdhPZUNYjJ91b6ZwTuL5dKxVTCQNJNDeafSrxAzA8IDG4xpaABrk7Tlah?=
 =?us-ascii?Q?LIMafo3lTuDK00pL7esW53FZf7LOiGnA1KaYlUA43ptHocw/Os4hNL93ndRN?=
 =?us-ascii?Q?5NGvkEoAMjyIZU935LtAJ9/LlmxahdY5GWRCRsv1CnRv7FN0FzfRapShS/CP?=
 =?us-ascii?Q?7/rSLk7UvU1olaiZJP/ZehiwRqhIiFTc68gburp/INmV50spw4YDw0jXlK3n?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6447dde5-a622-4139-06c8-08dbbfff84a2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 08:47:16.7396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bw8lczhdXJ495Y33Uzrx1WIevVh17/CF5iB8vKnNNgLAU1rfKVUCQqTquzMZLsSD8OYXOFpB+aLt85gOFlyiVpiZxc+an9o17hneMiuyjbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8514
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When updating SA, update the PN only when the update_pn flag is true.
Otherwise, the PN will be reset to its previous value.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v6:
- patch added in v6

 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
index 59b138214af2..4c59850dfddf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
@@ -1362,6 +1362,9 @@ static int cn10k_mdo_upd_txsa(struct macsec_context *ctx)
 		if (err)
 			return err;
 
+		if (!ctx->sa.update_pn)
+			return 0;
+
 		err = cn10k_mcs_link_tx_sa2sc(pfvf, secy, txsc,
 					      sa_num, sw_tx_sa->active);
 		if (err)
@@ -1529,6 +1532,9 @@ static int cn10k_mdo_upd_rxsa(struct macsec_context *ctx)
 		if (err)
 			return err;
 
+		if (!ctx->sa.update_pn)
+			return 0;
+
 		err = cn10k_mcs_write_rx_sa_pn(pfvf, rxsc, sa_num,
 					       rx_sa->next_pn);
 		if (err)
-- 
2.34.1

