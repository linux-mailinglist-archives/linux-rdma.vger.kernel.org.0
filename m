Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D907BA8AB
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Oct 2023 20:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjJESH5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Oct 2023 14:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjJESHk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Oct 2023 14:07:40 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CC49B;
        Thu,  5 Oct 2023 11:07:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jp3uowfF7F43a4Qslqn56sctlbIqT0k+7BAjzHc122NN+JLIFknxfPq8wdQrBUrXFGW9jWbJ3iVhYY4dmtbF3d+3aWHlYvCuZ/jhMFobGDDEVmOMxGrVh9T1LX8td7TK1JCsnHGORDPwUnFzs3n9Q6lfxgguS2n12jXfbs5qtrj8Njx5InXFf1zCK1xIcmaNABRHf7avJattlVoT2aWf2tjiu4k8UJ0f/1CSZnxK7UFgG7hC+indnH8UhPGjMu3uc2/GJR6VsjwoCsRxb/Wn7WkJtJX+zTvR6x3KDesfnmNvtpXgz8zSGSRP6HntNxguJGGce5b4zWXcxqUGsgfsLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCDNtZXqj+fVRDTaNBQMlm5rUOVakf209c8DevZDY1U=;
 b=b39cB4LqtydQAcJnyS2pegQTnzV0fe1VQmY83yhbU3e8T1RRkSrNGw7XlvPAvUnMx4KgkV0byjGc/Mb/mvYJ0V21H+V/37nNGme7wLWUmTAgoml7Re8Ku7tKsOwWyyljL07APKgcZKkSo159PXf4duT9yrgKUs2rtcSwAtuNotNPwyRlK1JZDTDcbJD4Fp0wmc0fBadj23NnRt+W2mxvfob062UuYMD3rWfbgN/zj6fCc4n7CzJ7/IprjP5WdVzMPIUP/I/zjNkRrfIlX3GR4yDULxMQWCmRyOFt6BmLbqvAXSpldIqGyk8MZOVMHyQYbdGI94AAV9XTMUBphlcu8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCDNtZXqj+fVRDTaNBQMlm5rUOVakf209c8DevZDY1U=;
 b=GOiHsDVIuGN+7eWDesjMvnvkkL9WZOZjwU9B3PCoMPo93q2BZKx4obN96bcQnJrkuwtKtDAkAPCdJdrhEsiq+2xQ2V6emiai6kEvh+CMv9AuQVOtHI0xwnlLwfiuFwEHjZIZqTAQdsxjLzR4VeMLsF+cbxUgH372i9LJ+EJ3PRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM8PR04MB7890.eurprd04.prod.outlook.com (2603:10a6:20b:24e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Thu, 5 Oct
 2023 18:07:36 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 18:07:36 +0000
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
Subject: [PATCH net v7 3/4] net: phy: mscc: macsec: reject PN update requests
Date:   Thu,  5 Oct 2023 21:06:35 +0300
Message-Id: <20231005180636.672791-4-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 45c83d54-9bf0-4a39-4cad-08dbc5cdf446
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQ5oilt0JSq3vb5dwQGOij8t6NrE1wwfafJr5HtyzkWHwzpbMB+WI/RzQ+S9vbxvQ6wvqv42M7o3KnVqaipce1nfPS8jXmnmaRnrD6LE2hXzviyXqPfg7MZ7h1/BM1HAGlS99vbT1VAj5e0MQn9X0/HfH9dnJ9VVrD59NIKCQV9WDFOtCmseWBfahe/jJf1h/Zv5iKwbJi+mEXbeb2n+dO7Pdr3jn03QNKCSK2wQlpOp0zPfBrG+RVJ72k4+7kYx0RcjYnCle0CP/pE35rEjO1I40H9rnmvEYviAIp/5TTFOK8aekN0pHsFMhqmry3fZD9Lg/936qI5y2msig97jQw3vxxvGVMRh/zo0BO1iGFiSVDdzzVevmca521cIyrAoMHBuH7iEmoUvxFTswsk7g4ytTvlpeU5tE0cu4C0QnloCn+I3ySMRrFeDwJuGTiAiAUruv4NIeMT/EX2VA4+/r14fCDxRDfLuk6zCmg1sjI1RjqMQow22SUEWw5urKfoOoVvehgTULF5nbk1LX3t1RQCRP90HfnAuD+eWKzVDdYP+XpvKaMjmdRVMtZ15yzjE9RP5TDBtnpfwnSxlCeUj7cFWZn2cfLkcFlpvLE3Je+08x3lJ7I/HY3ZNnnSFmx7w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6512007)(52116002)(6506007)(478600001)(6486002)(83380400001)(26005)(1076003)(7416002)(2906002)(2616005)(15650500001)(316002)(66476007)(66556008)(66946007)(4326008)(41300700001)(8936002)(8676002)(5660300002)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K1nS7W7ldY4V4Mx3NQqH2hLy/OsTfgRV23xY+zFaOURB1TelYqBjmAkxvvX6?=
 =?us-ascii?Q?iKZzIRclVKTNxNkeAk0qLoOBdjkw+U8kGEbLe/0Mtz2XCrIFnLk+Qb6kLPCm?=
 =?us-ascii?Q?ke0/g9QJz7WAnLXTtQPvydAMG4micDaAEJOangKM4jAFcOuJ9HsfTO55rK5C?=
 =?us-ascii?Q?iqGulAwiIWVeWJP2bHz041f8srS1LH7JEhVujABJBIaVV6xo7ckTGiLM2EC+?=
 =?us-ascii?Q?p/TJxg3MPH0zqUHAfaWKVPHjwsfCF6xTCcp546Q+sXiCrOrb0Q00pZvuO6IQ?=
 =?us-ascii?Q?VmTogpCcHy32sb7hevIkTieHsmJM9tCz0dpdqyVfuiXEzUS2BcN+GaYX9DMU?=
 =?us-ascii?Q?8u23KmBNR1yRvvBld1mqrwNcQA2E6BOXfeLe5L5eAq3KWYvX20OWoYYL0bh0?=
 =?us-ascii?Q?n0Pgkrk6oBXqes02Yi5qfP7BX/MLqpzCiONrKW/1UPDCbd+rKVrokEFI3xcp?=
 =?us-ascii?Q?9/QtKdlHwANTz/VHROrK4yW7v3y2EwQOXhcfZkAmAff9XAgLM3+IBo4pKJ3Y?=
 =?us-ascii?Q?IChfF7ZneUE1zz0lV3SzAFOvgUg/Ij/idijTNuNhQd7u03r9zAeldvMqHmOI?=
 =?us-ascii?Q?QyFYOnKvF/FzDC6wTGFge0tJMBd7JtxKe1vb6Siog/zwBKBZzyad+9aOfMsO?=
 =?us-ascii?Q?FXOjQvkrchZXGYVVeceEvec8OSZzbFtbtlgEo5WU0lyC+fDtMz8QDXRFjaTD?=
 =?us-ascii?Q?nA916esHmL0im+lU9AAdRSmWGJAb+bVfIwVNp8yQDoyGwOGm2RhwC42/A32F?=
 =?us-ascii?Q?RoxRqGSHnSSTIZhDCi0AWJPHAqsKv9sfu0KOPdwdfmQ2RKkCDhsi8ANaD+Ut?=
 =?us-ascii?Q?ds8maORAo1y1YBjqzIcL//pBlo+x0/h1P8GYejbJG3ENSmcutCiyN0dc3diY?=
 =?us-ascii?Q?zrCgW5eFjeCdOCYnuHdYE7sdU602UWipuNxM//qGhgqTTkriFAEi4jHxL90F?=
 =?us-ascii?Q?UqJZJklWQ1stXmTAv5ih7xr6W7Dh8sQ6OUbRujbyoEDN+QPw4cCslZOWXARg?=
 =?us-ascii?Q?53Ku0tzT1fZ9ZKFMdGt8+eBe+FOy9GhGNuWwto2Y35/kRXwNY6Cgo9qLYGON?=
 =?us-ascii?Q?+3uX+bZ8fryrEd3MbNnXsTkoFugCbiruB+jfHetn6j26LYVrtef4Bnop/IdL?=
 =?us-ascii?Q?honK87vV2Lcy3M5LLVJgFJkwNCiuOoo/PKAmqrVfwRzJUFkm2CKkZf5BRQzB?=
 =?us-ascii?Q?qUo7VcVsQci47p90z0snalPSTTO4N5rFrV3/9DnlATKFoOfuKqsCxCeBQ2SN?=
 =?us-ascii?Q?gyj4DC1AL/r4N4oFowVmr94WKEpEhYV90reebmNCPgMv9CEnjWox3M5H9ZR9?=
 =?us-ascii?Q?t/j5l/cx5BiJOZ/QcRDAOwpSdi0TbQdaYWccjluIm/GGSEONFQZq1UzPh5ex?=
 =?us-ascii?Q?/mvOR4Tvkd1598vDhWM1yUGtQlfQ5fdl6z2XPqkeHSlLrc9N5xOvD3uOMVHz?=
 =?us-ascii?Q?JwbSdcHVPQHM1l0ok9osslqzamf0QVeKrkM4ASI7mfNIjD12XQGEa+UPHXhH?=
 =?us-ascii?Q?DFsjXmHONsGAk33a/17Z9eWiZAX5GkIm/oFHkG2cNVxIsV70NqcI94KO5ygy?=
 =?us-ascii?Q?hqwp5XehDPetGXrSnw0k8NLyn9OutekzJFJtJdRYNl/0iHpkYlyp0IxFaFZz?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c83d54-9bf0-4a39-4cad-08dbc5cdf446
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:07:36.1728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7O0tpvS8pSYvn3AQHiAQQ6qD7XIxlH24L+y2mO1ly7HUsvRZ4d/V0iuw8RAKRHvznvf6JeFUB3aUlrpS9NVtIxkM7aIHyhCwWkLgtl+Wyks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7890
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Updating the PN is not supported.
Return -EINVAL if update_pn is true.

The following command succeeded, but it should fail because the driver
does not update the PN:
ip macsec set macsec0 tx sa 0 pn 232 on

Fixes: 28c5107aa904 ("net: phy: mscc: macsec support")
Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v7:
- none

Changes in v6:
- patch added in v6

 drivers/net/phy/mscc/mscc_macsec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/mscc/mscc_macsec.c b/drivers/net/phy/mscc/mscc_macsec.c
index 018253a573b8..4f39ba63a9a9 100644
--- a/drivers/net/phy/mscc/mscc_macsec.c
+++ b/drivers/net/phy/mscc/mscc_macsec.c
@@ -849,6 +849,9 @@ static int vsc8584_macsec_upd_rxsa(struct macsec_context *ctx)
 	struct macsec_flow *flow;
 	int ret;
 
+	if (ctx->sa.update_pn)
+		return -EINVAL;
+
 	flow = vsc8584_macsec_find_flow(ctx, MACSEC_INGR);
 	if (IS_ERR(flow))
 		return PTR_ERR(flow);
@@ -900,6 +903,9 @@ static int vsc8584_macsec_upd_txsa(struct macsec_context *ctx)
 	struct macsec_flow *flow;
 	int ret;
 
+	if (ctx->sa.update_pn)
+		return -EINVAL;
+
 	flow = vsc8584_macsec_find_flow(ctx, MACSEC_EGR);
 	if (IS_ERR(flow))
 		return PTR_ERR(flow);
-- 
2.34.1

