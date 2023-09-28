Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2601A7B1661
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Sep 2023 10:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjI1Ir7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Sep 2023 04:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjI1Ir4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Sep 2023 04:47:56 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5124F1AA;
        Thu, 28 Sep 2023 01:47:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxGx+7u6Qomxp+Oo1XTVX9cuMoal4WqsbhcPBqgKTs9IT/qk1yKFovGC63W9aXuG9IrRh53u4cyf61MucC9gIZRrnS4EipDdcNYRPU9aKUQbohYLuUHa/kzInFy2g55xs5XKP4EQx4qavpXaFU+YNYm3rCXaC0pZcQ/BkYhJwaN9NsekuSYPHqiT+4rw9u82q/Cte4GVBRApNAANRmuF7CIgYGaUnHn3GIthWxnQyzhx/xrjLdoXqgVnsZnN6ZGicY8fw10XRle9v/xrbryaYLj6AA3Ta0A2HdNToZUP9MppH+eIubnpBjDv/g/SS8orx3p/XWbD2Na1SG9WdX1TGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YD8gARdxhUZn7u18VU7g4skk17BOPVisbnpfYNFdqs=;
 b=OMdIVvMoNq5+1qaOM94xTgSZk9GGGWGPbjiXbLaAJMkzkgbX6z9Qk+K/Voq+tFM2QE4EhjLXhMIYlwZ/lZGRXF7uoOAxvYsT+Y/+wxSEITId7K5Mz3HK4/ZQOpci3zxwc9yeUqHW3T2743rd7eRoTBdIVqLvS0JY1i9g/D07tyWeaoROELn1dNZDS4yq/BTDP4Wm4DJkbGzN9MiZKRTacIhfyzxTbv0Ux1Gyl7Z4Tlz3AjdIpFQ4NfMmUqQ5u8zEhgM67aGy3WFgkfvbm/qyquLNIbnILpmfixiL6Nm0GaqP53WaKgTCsCSJwVq2ptsNNRYd3NeW+S9x+pZhvi+Oxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YD8gARdxhUZn7u18VU7g4skk17BOPVisbnpfYNFdqs=;
 b=AhqPyuMsotQ7/JxkbtywU/NDZ+tUTI1sD2GL8JoOL0+Vgq9PrtzF2G/5f4q/9E6m4h/jw+7AWyp70dAjYEioNe65ZI8vaS/vgvw+hxrPvGQo7YYnZLfgDXYqt355W4iaDT+BUfCWM2k21kerAbwyY/xz0DF5bMKQdhsmqVwa7UQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM7PR04MB7031.eurprd04.prod.outlook.com (2603:10a6:20b:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 08:47:50 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 08:47:50 +0000
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
Subject: [PATCH net-next v6 06/10] net: phy: mscc: macsec: reject PN update requests
Date:   Thu, 28 Sep 2023 11:44:26 +0300
Message-Id: <20230928084430.1882670-7-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5707440c-700c-48b7-1634-08dbbfff8ecd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+p+hc/q20wtjMcxMHPEmdL/mV0YnonmcyvqXhfGlnUW4X4HGTckUG2+CY70PzKKifFTiTbXr9fFNPZn6GUgdQpZxAPSEyR4TEVzBex927N/6aB8QesXk0EYJp2qp6Pj30HDpnNk0++rgaBdL8sdgqoroJ7RooREVxyCtKYlwuF4xAmWXk4VqNOY3z5ms4F9XoDvEpyHMKIrgpqZ+IFagoqO8NHsxXLKjCjfMdA/aW8kPhQz3KWc1qrlwjQBpIeAI3jmXZBrX3YlJxYaIy2W5j1LT3UU89SxnSY2DMybhMob7k/NvJUoeXwJBP/KKtj4t3JuYSY+iRppoonwk/Kmw1AP+qd7NbeGdkqyqkxJ+GTJospDtIj8FLsjDTlmX3qVgVOYM73879ynmddsDEj5sxDnN55wk1vLW5Mm3Lsfc/9puNr0uB3Mf2c6751jIWN63dunjRS3LV1+Mg+DJqIvdDW+251HGkfhExUC084HW4w1ZyjgSjDYyoiP3+CEeoAgRcgIYschOL+FDGB7iVsgMYuRxOAMUDni2Xl4uB+poO50zVJz72/Eue//LBF7zjnmM6Dq/w38Br7sR32chtSzRYZb7vc5CUY3EQPh/R0E3UzqkIhVe0pphZpBxpZ1qfVL9KMvLq0MFOpbD4NByI/iiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2906002)(86362001)(4744005)(38350700002)(38100700002)(5660300002)(6512007)(6506007)(52116002)(6666004)(83380400001)(921005)(6486002)(478600001)(4326008)(8936002)(2616005)(41300700001)(7416002)(1076003)(8676002)(26005)(66476007)(66946007)(15650500001)(316002)(6636002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T4Pw+9LuJejgKYybNFGO/fQAHPc93Vuo3e4UnbuMPsmJhcEDBIyMhZGvzVuG?=
 =?us-ascii?Q?MGfeIV+PwkZKxCC+AjJEAzkTTTeaANQsNsSm5tt5A9fWbYULCLt2iSvB2o+r?=
 =?us-ascii?Q?IHN167BPis5gR3QOVPS9a61anC81u6flxg7Th8Cg4KnfmBo9HSEP5mbwtcCj?=
 =?us-ascii?Q?LWQMjJUx8YEcNFCDXyhrOu+PUQ3PUs17IEsERu+crqmtikvSrF7jZh0o5j02?=
 =?us-ascii?Q?Z7T/NBCb/Z2pHJFV4ogy72TbV2DWNMKDahfUj+/kX+glVr4vH15n0/mqiGbD?=
 =?us-ascii?Q?SkfcbmMCmCyTMktrz6rr15LsVGLiu0kJAxiD+vfFVUOQfuHJWBWyBkByocbk?=
 =?us-ascii?Q?zNz4FdQf7pdPuu2XjBEnduhoSHuf/8Rd5KPGBWlf4KvDcK/bqpdI2GMmkn4Z?=
 =?us-ascii?Q?K9W9gYXKmfSfPAZ7t0SPFHOpiCxiQQgXiB6kkY/ddxbIucer8a6qMr/recIT?=
 =?us-ascii?Q?IsdUocTCfw/lRXWhryZfU1mCo5YmN7yLZV5mtSjsFyjwttCV66WGLymE/xpS?=
 =?us-ascii?Q?hswedvGo6wbaZle5vXuAzKuIqBeMOXUDnlIWsf4had+JTL/mVhYss4Pxu5V4?=
 =?us-ascii?Q?+1NjZZtUVeHMj2MTrOWqqQgKhTDaatS2xLDvEQt/YYIOXv1gCZasgRA4XyDe?=
 =?us-ascii?Q?RoV0BogIOQaxCXVPWhfiefrC0c5kaFVXpt9BEq3Z7opgpa0akISdjjiyf3sP?=
 =?us-ascii?Q?FX/4NqwqSDRlHYXpMz+K4A8/s4qiZNRunl66VCwEu0rl3IAtIbdf6HUkcpbz?=
 =?us-ascii?Q?MmCzhjA2vagDtDRhWdWqZQOxf6NX2ULi91S1a/8FPzA1HFCrJ7+cGTBBDWDj?=
 =?us-ascii?Q?5DPNBiT+ChTkjKKX55dVkd1Z9KS74U/ZFm7Sgvu8HJI0p0jWvUzy1gXZ+886?=
 =?us-ascii?Q?K5ajYzhhwCUTX/WJ9m2CmehKWVSWzEcRoQ4Mb+i2N6oXlHAN8Sim9UNB+5yX?=
 =?us-ascii?Q?z40WbFw6jIb/hQ6JfAguNO+C0hllGDe7Xdeekb6LaQI5DbePRH7BEJvBSowg?=
 =?us-ascii?Q?L+cphJNwZGqJUdlnGH+SBmaQLeDonf9E6hEUnSH5HkRnuDeaAODPvbcqNRBT?=
 =?us-ascii?Q?l40uYdcYHbXqgKiw7hTx+mYx/ux5736IdKn5dEz61YHmd/0tuTctP2MiBrfl?=
 =?us-ascii?Q?NdTt8q3Eo3iBjgLQ67thpODEwG5KnP1yjU8en8uiz2L6BbeZyetautd36fQc?=
 =?us-ascii?Q?fH8p1oy3Xd+GW5tliGBNGPrvCC/+pUu4SWn/Wo61xAWzoFyuRnaEpQdGf2va?=
 =?us-ascii?Q?KgnoDHmRhTpwGs9GH7z9E09IYSt79nhJToazWTTY99lMLvY+H+Qwc9gNruqY?=
 =?us-ascii?Q?+gLxxn7IEz2AjTu0wS/mliy1vSy9O67qM+Uv0E91VOxshiYpdPEym3EfrjGk?=
 =?us-ascii?Q?w+GFKKNj+Uk+5+cupds3wItG95yvbvpIHNzb0ATo4YQ0kqMfIaGqR6TYJKxL?=
 =?us-ascii?Q?Wt81w7fnk6O5kE7eAA+uxTkMcrDIP+69vBWw3xNDmKBe5etLLK1QcoMYoXtg?=
 =?us-ascii?Q?BGBuN2prvCxNLG+a6CTI7bKk5HpdWRBWqccuFUJcOYT+JWR0tlNY44gDWxmq?=
 =?us-ascii?Q?QzKkGjKeYG9b2t3F4W/bEltUZ9mJbnv+2QHLtdGMSgF0mh/diiC2tVkRx3N3?=
 =?us-ascii?Q?xw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5707440c-700c-48b7-1634-08dbbfff8ecd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 08:47:33.8057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5F/DXi6zZ7RvpHn2JrxpdUiIa3VF2IXOIZwiFd9rjNto+Z+fbhGcMiyjNtxi3O3OgGRvqYQaOBt0mWEKg9j8AjhLFh/923zf4Ue/8VM2FWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7031
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Updating the PN is not supported.
Return -EINVAL if update_pn is true.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
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

