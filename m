Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6E07B1657
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Sep 2023 10:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjI1Iq5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Sep 2023 04:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjI1Iqz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Sep 2023 04:46:55 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0469C;
        Thu, 28 Sep 2023 01:46:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bm1EvonnixUEjFHvLymVcIlSQDfVYxZDGXOPy0C9ciQMioR5xSHsuRRfeR90hm1K3sVyT07OS5+rjdl0lLGUGSY47RkhF36vkgY5o8HRc8/Mw36DUjWvWiDlObzLPBwCnJzaEnI7g1IL3XDKcVGRxqGUw698ggEQXnRygs2oh2Ss/VdhF4Ofh8IVGnuLAvTSr178bshp+HF2PyTry9Nymjx97xuQXC3/4Lq29cUhf0sefRyGyM/VneQSIExFjl5r4GB+xtz8sIsAmSAQ5Ps83FrTswnjv34bw2sLJqh8H+LBXC2/Vr4UAe1Jz3rQKAvFkujEc+JfJIsobn9m7dGruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6O9ES834w+8WlI3OZppjlnFcdMIUBAc4K7SW5kEhwRc=;
 b=RWYWunRjeCCHh780umuokNsAbITMxR8juXxZTwo/yrBb0RkaQjzXKlfV9XDMIjpzXC01uEy4fGN58zRUBHypSsfaytHQIoNQgo+UF00+l7f/Sr/GV/ZLTxVEs2SjaGOOk2B0kh4trrYdp2rlWKUjkpjswzgelLa5ognMYMIUD9NWPhh2fqJjL9p0KLbLosdW2SP8Wkl7b10ZBCfnU/iPJN3bIQjTJJRY1DgH0AB6fqAc++PyU9m8gOUM4oJ/qkjiH/0M16dT6xXb0//RCcLq3w9ryhJb+J5yYkbq9rbRe8EwSsKbR+wZLdBjpKLp6S3+vXx9p3o00uDi1/jr7UAGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6O9ES834w+8WlI3OZppjlnFcdMIUBAc4K7SW5kEhwRc=;
 b=FGs/EiOuUTuV19oOgx0/PTVagIDOOj7S7RX6Uf8a8twsP6T6YyprJ4l/BFteE0OZDHtj2lp2ecjblovPINJKXGnzcMkJcNq+NiKLw1QPXvKl0iYisV6LlLfFNUPV4BhnIWha/2MAQS41vnvPU2vumHVlHo3vzNJh4Q8ymFRgDwY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by PAXPR04MB8475.eurprd04.prod.outlook.com (2603:10a6:102:1de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 08:46:50 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 08:46:50 +0000
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
Subject: [PATCH net-next v6 03/10] net: macsec: indicate next pn update when offloading
Date:   Thu, 28 Sep 2023 11:44:23 +0300
Message-Id: <20230928084430.1882670-4-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 73d56853-3f4e-46e1-4b0d-08dbbfff71e8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vT38auWvH54DitEpExOZ+r447Ix1nKVd7UIu41vG2rP7M5Zf8Ldv+y34Ny0PXfpLDzEIU6nr2npNihQ/ckLPCtp/Vb2dwKh9ZNw6MYEOEPP0AfmFvGz242VeHRYzyF4Y/odXP4QbVr3Gjv7wqJqOucAHwpiMNZT45DwMoK1x9R9EXEQzGv4qIusq+swworzxqXrSch59c9fB22D/jrwCdOiCbA6CP7+eimSsVIe/P12s4KsCk0AaFfuIkhfu5VBz5+adVL01D3lOZhSvwo7vfAMBxOOLj42RFGIswtyPXAOEqlqR+eQsZEfYkKZ1NqIdOmr09oMeFf9fguuX+OopghBPCDmEZWIfnqv4n/36xFiONdnLQ+BTF2Y9nGbtSAXWM/u4+V+7J5giShNKXoe9qIbJgjzsqDyHczpHzP3JxjuImYHRJnyn30xKL5rURc0x7yJJHTQv9Nzf7BkftETtZJLGyFJNJelu8TGpVLf8JKWikcGkV9zGBH/T5SX5Ok9LaZtfsE0PdnZNwbpoaC+5rGJf2qgiLaZaw11JNHK5C2HOYvQE50cOcOH0AYo4Gwyfubn5DmpFcCKZ0pw7+qIr2dLktlbXqZYr12BolonbAoXS/DDYuH/dlax9mfWHUI3c6M95HHwOFqwjY98iKazTpxaRK39wmS25C32szvW1AOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6636002)(52116002)(6666004)(6512007)(26005)(41300700001)(921005)(38350700002)(478600001)(38100700002)(316002)(2616005)(1076003)(83380400001)(5660300002)(66476007)(6486002)(6506007)(66556008)(8936002)(8676002)(4326008)(66946007)(15650500001)(2906002)(7416002)(86362001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pFYVkRzcxwGv64y343ogvM/Y6hG+FkfvzsnIAhW+XOuJ0S6xB+16wH2oKyTi?=
 =?us-ascii?Q?No7QZofFdRoyXOnsbWixNKaatq8qiWXny0ZGf5AvlJit4ynOxgRVAJBEylJz?=
 =?us-ascii?Q?TSb6VsLlKgxyVMjGpBOx7T81o6LvgSqh7EcYGZAohvTPnHzu/67gHpBMO+ZV?=
 =?us-ascii?Q?RUUJij+cTw4Vigc0cf1zPFMjJqy23uliAn45qnmOBJpWnlnXKUAimafwjF+5?=
 =?us-ascii?Q?UbtI/nBoII1UX0D/ajgSqtN8sX9TX4FWeEHSiOpAc1AfZcUIa6xieu7U5Fdi?=
 =?us-ascii?Q?HPF1Pfgwo/qcbmMuqsLDTApLl5y9vC1ECpMUc2Megoo15wrISivLWEuNoDv9?=
 =?us-ascii?Q?jH78fXjxSrhd64ig6TLAOXZWt+XzQBmEOn5MbFhPz8N1gwIEjRCrk9goAiBM?=
 =?us-ascii?Q?ZmLSNdbl5DTdyrtOZSsKgoskfSF6W7s5A8dNc35W5BzDSMQAKdMj/pyOOdMO?=
 =?us-ascii?Q?q4BTQO7+5+4q9oNoCYYWyCx35sZpjEPP/D/P/2aT4WbYS2OIrSI/kMoZ31cw?=
 =?us-ascii?Q?TBxMlbAxz1SjK0YWDbVNp6doCj7iT4ITOtY2XibT6NhXC7dfTYSUwj7MnE+e?=
 =?us-ascii?Q?fyKEOD/M2in7agRWTUYny2Sgzvs88MPx0eYfvHr+YG0xie7+k0z9FOH6hQDG?=
 =?us-ascii?Q?R4W8ijYueiBIW231fJU6b05yi+BNcrhQF/0ZdLwD4G8moCpV800UVSDIU57m?=
 =?us-ascii?Q?j97oiCkXKoMI6GBnu9k2s5NV5/eziV7XT5T47eFajMJTbL6WFRdjbWvxmoQU?=
 =?us-ascii?Q?UtCbZcsOAxvkXQz1C3mWlRHefGGKS2CiNuLskKqSDruDxSxjmhknpvgPs7sZ?=
 =?us-ascii?Q?8q6lIJKZ9ZuZW4q/mqTRtB8Kz7HCn5A44SjpvzlYMosYtJWbkUn8PvVJP1lO?=
 =?us-ascii?Q?Ax7s0EEkzT7FOo7U3SogDq4Zk4SbMqWjX2nfBM0bgEwSPqYY/HX1jOTLO5PW?=
 =?us-ascii?Q?35GsTPkieUuQqMWLvfaejSoADw6Ciz35gk2B9+4BiSCLXDBddpOwy5dFW1SZ?=
 =?us-ascii?Q?hawkhd/Ibm/DtPVC2TGcX5ectF3vLuzLSKNCob/mdznk7kslMZ4KO0xighDi?=
 =?us-ascii?Q?rskbPVAq38tQXQA0yqsnp7Feolp0Qv3+5Px20+GOWVX7krkTTtJPmoIK2NiC?=
 =?us-ascii?Q?SNKoMxk5p/4yrId6tF9ALKn4Wqr+fSNOiIDfKw5HbOg5LGMJFlw+i6qB9RIg?=
 =?us-ascii?Q?Pr1TYPwWiMuR5Sr7QKbN54UtbSgWJPKJHtMHoQsGD4Hf8qgMWe1FDTzjdik2?=
 =?us-ascii?Q?MDsKk4db59a5J6/53KVBxNwHpO3k7HPBItZVuzTMdY1tyWJlu9IZddLZe2+q?=
 =?us-ascii?Q?ANAb35YazoOo3fYRd/5oBJUgOmXkO0B2JBKMLwO3aW7cYV5Dgv7iXv0R9/z8?=
 =?us-ascii?Q?awWDMUYMLVH+ptLAMWOb3EA8/DeteaKswP0PzqqpfzpUS6XsewDm4I6n9Utf?=
 =?us-ascii?Q?l+Z0BgBYE/ki9N3DWY0a68wRJK0ms5Ajaq7hcLWHr8YjWQ5HZ7rQaG3ev1/h?=
 =?us-ascii?Q?eLzJrIc+hOlTIk2M1/tYdCSaquC4vyDGMfyebfxZDw2PPy/Lu97xEJGHpTgF?=
 =?us-ascii?Q?fohbl2e2m/dSedeUIKc3CO4WwA3T6fuJeMQp7dntzAqno1Yn3wSGF9LguwWO?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d56853-3f4e-46e1-4b0d-08dbbfff71e8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 08:46:45.3147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YN1sSSx+uxQyWon+hRas+Js142YXSU3lBBHs53DGTs+z8EX6S12Sks8CVBOjGnjntMqK/IdZQLQ5M0/EofrYsEChFzMryDmo/CAiKETw22g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8475
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v6:
- changed update_pn description

Changes in v5:
- none

Changes in v4:
- patch added in v4

 drivers/net/macsec.c | 2 ++
 include/net/macsec.h | 2 ++
 2 files changed, 4 insertions(+)

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
index ecae5eeb021a..0821fa5088c0 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -254,6 +254,7 @@ struct macsec_secy {
  * @offload: MACsec offload status
  * @secy: pointer to a MACsec SecY
  * @rx_sc: pointer to a RX SC
+ * @update_pn: when updating the SA, update the next PN
  * @assoc_num: association number of the target SA
  * @key: key of the target SA
  * @rx_sa: pointer to an RX SA if a RX SA is added/updated/removed
@@ -274,6 +275,7 @@ struct macsec_context {
 	struct macsec_secy *secy;
 	struct macsec_rx_sc *rx_sc;
 	struct {
+		bool update_pn;
 		unsigned char assoc_num;
 		u8 key[MACSEC_MAX_KEY_LEN];
 		union {
-- 
2.34.1

