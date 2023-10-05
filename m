Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AC87BA8A9
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Oct 2023 20:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjJESHz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Oct 2023 14:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjJESHi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Oct 2023 14:07:38 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC92BCE;
        Thu,  5 Oct 2023 11:07:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdqbJf6pHzJd1QXnjJd/dtmTfCuKXnWAMoIt6DJSMSlFiHP0ZDgCsKgxLuO6in5skzeES2E7Q/uMf/XxCqwGxHrLl6nfFJTJ04z0lTIfRVQpwXVHTAV+luW0aHrTaThrxLEFc99r1/Lqagen5k0J/8mahmHw0MV7pXJKvvwAxco9CDK3ajGhAzWcZHsfDMPJudvDMew36+uGnyyWzfott6p89lz1uIHTsU1rU0Bv/jwDAJIYhUaDngNEyb9cuasKhNgu7e23Vw8JUUajHa0CV5nk/tF5atZtlFbE4vIpUVj1ExTZOoumfFwUUVXcC72GGqXuhbOjoQO8mEKJj6DwXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kj9o35ZKZhPAMSqqE+x2UeOe/m3DP19wAy6ruvbsgPU=;
 b=c4gtifYw776/MBY4x+JCxDDJ90jCd3iaKVFcakgzmJabnB4nxmSuPCNpCbWZOj6TsjI4eC1ubgG12UhwwBdK816inEmKPEV16eZdn9ctLjmWUP5/6wyt+ogDK0wclO+amkqIFuZCFxP7nb09VWXw8J+8FyDP/NzSQxDn4yqAChhT2PiiZdZGE9dlhz82EHDznCX3wlnd62AGOxeS0eALCD/DyJRA8qW6yk/lqX+EhggoZqHiuME0PqL233ut2SrbFRm6Hp0YWF23FWCee8BrSMO/MVcROcKBvddHCPnChgortq/WVC67VsO+hY146RTsoCDBPtL366w47zDkhqXxSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kj9o35ZKZhPAMSqqE+x2UeOe/m3DP19wAy6ruvbsgPU=;
 b=QCrYnS048LlUEokW+4sj4Ls5GS+rSo/THOyVsfzyTsk08kueiN3gEvbOFdF+mDCWZXaXXiNj5l3dRBEWOLIutfvAZcFhpAzfc3uts4uUTRvKAP9Zr4ROm1K0SvWft+ZfN2kBCXDxUt+ZJltIKflTK1cu6rFfKIyyeJyb6Q4untM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM8PR04MB7890.eurprd04.prod.outlook.com (2603:10a6:20b:24e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Thu, 5 Oct
 2023 18:07:34 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 18:07:34 +0000
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
Subject: [PATCH net v7 2/4] octeontx2-pf: mcs: update PN only when update_pn is true
Date:   Thu,  5 Oct 2023 21:06:34 +0300
Message-Id: <20231005180636.672791-3-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c31e4110-02e9-4ee0-3ccd-08dbc5cdf347
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UhLoi05Bp8HAlb+rLjbuNJAM9/0CODzC/w22OvJoVHjmrtszW5sRryOaUZ8+WFE3zfvc+jpNQkGkzujBl1r0JW98G4TC1jmiBHpC+NHpcexuDC/HI0F6jhDvsfyt/UjN1tpetBYrNISlIIlSGe6PdvhwQO6QOtqrxhx2ueSo/QtURsaDQYrn9slxnL3XeRw+M+UF/h1zfx9NVXXQiDTJbN29q5M7bLxvhDqHnuNxO0RX+9auTVHnCAAhW28C6kIgkXBYIFMNNycsHdD8S+/n5nwQh/K6QiuQw8+KLpS5cFLscuFuTM+JdKOjf68EuEcQw6VIb1V8MSCB2aRShNIzFT25Rzpc7tSh9Z4XHIXILH+DgM7131oK2qmujlfQRKZvgGuCTuLTyIho2WdJpjLt7O7BKutp0IU8k4HB8IH4RhVZCQfRvbISEhicZ48Ihp1zUinLCYOjiv+jVRXJhlkj+KoVjA3EURdBccrElWMhMsY8plEMLKe2DLfLuL39xu75N8kdcV3YLECWDG/6p1vb1jWQe4M9sBFMSPNMPSyhKZGhT2Gdq2yLyK9OPqcI9TocHCCAYtvd/ASiIGUAxcrr8rymson2X7uU/PqSOXSDF8mGlBvQU2mnkPd9yYW8xvMd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6512007)(52116002)(6506007)(478600001)(6486002)(83380400001)(26005)(1076003)(7416002)(2906002)(2616005)(15650500001)(316002)(66476007)(66556008)(66946007)(4326008)(41300700001)(8936002)(8676002)(5660300002)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n49vWnGH54LWdyRPeezbCj61XQnTD46niEjBm1jsBxsdJwthFrq9lDwC/Z+c?=
 =?us-ascii?Q?wA1RyC6psD1Eb91QfnGSOLiEUzPDMDz63X5dfEYz+KB+H8uO7y9NN55YucJ4?=
 =?us-ascii?Q?0kJ3f00lRmqVvqr8ypIrgLFsdA7uP/VpRr8u7dYeYQmzYJ6nARaBLjLoon5b?=
 =?us-ascii?Q?vqrW4YiP59DrCKAuhzF1WGmDcbe1rB67A9SjI0Wq52e40a1uZbc0MTZyB/wI?=
 =?us-ascii?Q?JRqHp8fonicHOcTrMHLsfFjs4RTwn00u2Z670xv2At5ViIPlUCbZkSHXoer9?=
 =?us-ascii?Q?MVI2dFiwtmI/FOFqGk6gyLDxm/9KUC1eEUwRE5zULwvC1axMW/HyGzaz1NgA?=
 =?us-ascii?Q?UD0uxIIyfALriR2BUVpUBIuu81zzTuvn1MJwj0v+6HZIHboufxipjitHsk7F?=
 =?us-ascii?Q?rlRkfT+ePoPFwHeeqy4CEcl2G22/R6zF+93+p3qOyMPYay3G27bUh4D3Wf3d?=
 =?us-ascii?Q?uK1RF/ADPw3WKOw5X5bGpfh7n8wX21vvSu/x0bVdKz2NtJ9YLn0PeYgHN069?=
 =?us-ascii?Q?HjJX/4fDQQDdVyityBOOFCTLgA8ISJjwdGwJWUuxwjQD8KWEEOJxv9WIZVit?=
 =?us-ascii?Q?+ftehchBRdxBRyCgt28eiacaTBhnaoKk4mbv1Hc8upg3/YQENu9K/BF5MNy0?=
 =?us-ascii?Q?5lh4BcFFSmKoOYVLjWRh9ZtxnVjQXEhyLBBrhanmDKUxECrE/zK4MeU7EThl?=
 =?us-ascii?Q?4+kurf6teBtOWiI4GQNEiEpi9JmTRzv4xKO+n33ov1OMwPRwvIS1RRWlIBde?=
 =?us-ascii?Q?m47X21YOxhkZDEkGKBfY66MWQjwBDvJWootybdprQkTtQKXbL1ubX4eqP0P/?=
 =?us-ascii?Q?+C04GxUhPl8pPhKuFg15yFFHeY/PHNHm2WQiGQmMIa+wHu9O3eQJYQEhxthH?=
 =?us-ascii?Q?WUHDm8CM2X/JEhb+sXHT0U9/+ZxlddCo9/MksB2i8wxx9R05/uI3m8fgNiTr?=
 =?us-ascii?Q?a2IA3dTjC+f5fb3Hr6+aubKTinCrQ27HfGeq9ZYYujE5tqBQ6ggkfkfdtMjd?=
 =?us-ascii?Q?I4M5O7OjDoCXsdj44/HcDkJz29oGXONUy79iXHsEUi1eJjBtkfzyqCUYp7L6?=
 =?us-ascii?Q?O+DOQC1pKG7amUIx6DlHw0JCqy4+WBH9DG3u2rU5YzwztptpgRSnaL6VJLrU?=
 =?us-ascii?Q?sn39QDhDWJSEwWh9Ia2YHuCknnQzSxHJb3jZuMnV6zwEJFmU4JcaUpGax8/O?=
 =?us-ascii?Q?TKsGJ+SyRlwYSqiTvGqWaBasu3FC5Brv+bLG5BZ4whOO71VDYMeeZVE1p7K3?=
 =?us-ascii?Q?cCsp27z0s6ZbdN+fXl2VSzS2T+KKtmJsw5vQmfFYnkWpeQpX1MnfoJR2rTUR?=
 =?us-ascii?Q?sI2d4ImuDzoybQFU+GeXwGP4sF5A8+D1qFvcUwM2AjFkTuBHNqmPsaNJaqhg?=
 =?us-ascii?Q?10h9tFNlvSZzDDTrJcYgMMIdBNvfQeHU1DLtc25BB44ROlRCF9iFCLiYJyQM?=
 =?us-ascii?Q?qqa/hy4t3P0FoflIXsYHaFhyfY7XJFJ5P0LohZdnuNiWG9PbT7VeMaFuBvJ+?=
 =?us-ascii?Q?LesIFYQinLhtBuPhGFsw5choAMQdNgfRssDIEwyp2aeuKkExGvFOyHYVRnwL?=
 =?us-ascii?Q?EiwS4vgc2wSIX8gLjIIj984QubjomDMJXpxTTq9QopxLp8G6dOmmqD9lqZqU?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31e4110-02e9-4ee0-3ccd-08dbc5cdf347
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:07:34.4833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8J9eopdDUsPVYU+WwfAqFj/1AqEaYT90OuEirgwkbEBrLX9cfRwGWDdg+znp89iR46gzbhzAdWtgvQCxF2jZTbFQpaxzEqp81ClSq/XvV8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7890
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When updating SA, update the PN only when the update_pn flag is true.
Otherwise, the PN will be reset to its previous value using the
following command and this should not happen:
$ ip macsec set macsec0 tx sa 0 on

Fixes: c54ffc73601c ("octeontx2-pf: mcs: Introduce MACSEC hardware offloading")
Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v7:
- fixed update_pn check in cn10k_mdo_upd_txsa

Changes in v6:
- patch added in v6

 .../ethernet/marvell/octeontx2/nic/cn10k_macsec.c   | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
index 59b138214af2..6cc7a78968fc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
@@ -1357,10 +1357,12 @@ static int cn10k_mdo_upd_txsa(struct macsec_context *ctx)
 
 	if (netif_running(secy->netdev)) {
 		/* Keys cannot be changed after creation */
-		err = cn10k_write_tx_sa_pn(pfvf, txsc, sa_num,
-					   sw_tx_sa->next_pn);
-		if (err)
-			return err;
+		if (ctx->sa.update_pn) {
+			err = cn10k_write_tx_sa_pn(pfvf, txsc, sa_num,
+						   sw_tx_sa->next_pn);
+			if (err)
+				return err;
+		}
 
 		err = cn10k_mcs_link_tx_sa2sc(pfvf, secy, txsc,
 					      sa_num, sw_tx_sa->active);
@@ -1529,6 +1531,9 @@ static int cn10k_mdo_upd_rxsa(struct macsec_context *ctx)
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

