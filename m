Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E48524F11
	for <lists+linux-rdma@lfdr.de>; Thu, 12 May 2022 15:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbiELN7N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 May 2022 09:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiELN7L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 May 2022 09:59:11 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2108.outbound.protection.outlook.com [40.107.215.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DA91E7815;
        Thu, 12 May 2022 06:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEoL1xsJGVDMZFjqa+Y/ZzdJl2zTXPDSDo8FHktxK23KS5bi0AkY4YtyG9mhVtRtuOo7f5ksl1WorctF5wOPn+sGXfKYrZoTWFC4ww50Lvz4e2Cs7avap84K8vCOQBeTQnsjIVxmeL4yA/xTrJNuS1zEP094QxWcwjp61e7VMOQ9qPaTzRWWw3KAjHHkTABorwHtEAskk5NtQHjfS4V41Sa4Tr1ZVQIQux1pkqt6rMNap+7zxIjYMbLAROfkrqRMU61ese+Ezn/O1r6Y6+In832DaLSG21Xdrl9qeBcH0naHbFI/0kfJQD3HAKLTLvXlfJrhyYeNDCm0noa8IHPr8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDYIrMGpDUDoRy7ePh0k3aj1UndPkY05Nvzfl8F/q8k=;
 b=icexmYNbJQF0BJ6f2IsFGCLV0PPrk3LLR7JaR2NXtmwBToYTAjMVkfMcl2K86zH3eWyutHnCzW3kGo4suFplSLMgh8QJR57O82iUxfRspKrj3xJHsP4igZlUeb2bewHN+SrgFZR6L9ktvjeL3eEYTgjs/uSm7AwpPliIBdWyyBSqjRNutB8KZeByCOSnerLB3NT6cj1Do+xemtjxEsLjWuYjoortj1nxyy8aC8zd/HEB+O5+P7vLoQr26edHJ1tapf607aUDEB3Oft6ONLMnYMUcetN3ifm6eIxTOFdCJ4ZVxm7v3YUUzfoM/OOfOoP1EpmYxkZsI4ZHWBZCcAlvNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDYIrMGpDUDoRy7ePh0k3aj1UndPkY05Nvzfl8F/q8k=;
 b=ZXMye9VrpuxIyUVAcnOMAW1mHbaEX9CQ+5d9f80cozVyFjjIbZZxXKUdvYF7iLAy/TLwQCgCH2BcRq7BE5ecDzFuvdjqwRDkcG1J0jt0oJqnDM/SaFs0yx9UsaHEMNaD54e9/dHRv+ew4CMkBrmHH+IPPxcMYdEwvY3GpqJWReE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Thu, 12 May
 2022 13:59:03 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08%7]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 13:59:03 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        linux-rdma@vger.kernel.org (open list:CXGB4 IWARP RNIC DRIVER
        (IW_CXGB4)), linux-kernel@vger.kernel.org (open list)
Cc:     zhengkui_guo@outlook.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] RDMA: replace ternary operator with min()
Date:   Thu, 12 May 2022 21:58:37 +0800
Message-Id: <20220512135837.41089-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0050.apcprd04.prod.outlook.com
 (2603:1096:202:14::18) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb587a97-8077-4cb3-5e09-08da341f9251
X-MS-TrafficTypeDiagnostic: SEYPR06MB5134:EE_
X-Microsoft-Antispam-PRVS: <SEYPR06MB51342484DEDB46DB36451EDEC7CB9@SEYPR06MB5134.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iTuLSRZH6VhnYzHSBxED/1j83h0dPO4F4XO0YAqOGzW+NFf5AI3jO6Q8ODGMwVwWHsngfN4syBa7fVfIFymdEk/JCC9lBlUXij2OXPBzLkhRacCabslNEr/utGoX1SESAMmG/XmX2CNEHjIzt/4GxuOpdI2tXq9kkdfUFATX+y+9leKRnIGFCq07A8Xn3B7+chyLE8Xwob7iifw+fGMmQpCtieUd99BpD+Uh3tPq4ghuLqigOy40caX6gSjrERf9QLPkM812Ttnb3oFA6wyC/IYLD5lptYt7QRBckrX3VuJorJcTrroE39aoWlOvlzJHve9l5tjEF8FeYs4O+U5lgFESuwgr9b2OsL8ZjyAI6w5A70gfMf26zWZ8bOTZEgBZkqnbTE7bJR/bX2Bz2Fj3YlbxB124Kjp8t3SkvFOCNqqupkDTlKRJpEo3bSkmgsFuTF5KdXYx3PZxBqbYvM/FAFoUSlDssB0P6rPpl8Kr76uMqQhspoAScxRymDPa2SYv2O4VQpGkwcrkeCkqElHpgeLiHONCK7cmjsO9yYFlt9wjHSydBr8rFaJ5FFU0jDVJKg78JE6JxP74i/XomobxXpH4/wXAPXOqWebAl9yeKk55DlA6EMdkTdb/X13+RMYFsWxXFkfscBdPAtY/sIKlB1MsyEO7K2j4BR+KhspvK6ELOmSyuvkb+ftguLe/CpSe9Rf4wezthMuRL767feiVGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(316002)(110136005)(5660300002)(508600001)(66946007)(66476007)(6666004)(2616005)(2906002)(107886003)(66556008)(1076003)(186003)(8936002)(83380400001)(86362001)(6506007)(26005)(36756003)(6486002)(38100700002)(38350700002)(8676002)(4326008)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rOlp/cMOlvuKogkOgs9Cgjk3R19AgbXUK/TP6pyoG4cSr8i+WrvF67KmV4GA?=
 =?us-ascii?Q?Lmui44cynSEa9ieTYI9D1U9O0KSREKeqmN2dWB4thCLlx2QzbE2nffb1YBKQ?=
 =?us-ascii?Q?6IekGQBlMPDek69aTK4t57shMbwAe6PplilabxZSSnU1Sr0jem9gWJgRzFE5?=
 =?us-ascii?Q?jFW5fxVHOos9xrmBQaHf5TMq6YhtOMOuYinQmDhpTLE0ywgkLihrDq3HAkbc?=
 =?us-ascii?Q?HI2/l3Fxwos/ABGpXa02089cbbRLk97DHo3YKAi4HrsiPYCeGylBTUIvKfl/?=
 =?us-ascii?Q?f/5i7zMboR7y9pkgMHY2I/Fgt8y9xOWdAfb+b3dmTYQ8NZCkA437x7viZanb?=
 =?us-ascii?Q?tVS9kslSd5eKzgajCOCWJzJ+5Ytf8GlpH4uuLjHanEER/V7OvX9NtMR7Bnrb?=
 =?us-ascii?Q?tPZ9GxE9a2EjxUQLC4SPetEXx4DcKiusbm6Gyul9F3Vd5M/PJ+g+2Ns+B970?=
 =?us-ascii?Q?tpk431KZNil+uh8M82jUmrxxizfM8GH4+L/HuUL5AOcpgQ+eRJn4u9WR9ubD?=
 =?us-ascii?Q?IKhvgQA9eI/mhb+XS8ikssshE0YBfi+83tenuqnKcOJAszyelATHbVV9wg94?=
 =?us-ascii?Q?T6sg1lTyLObL0IWh0jXD5WtZOAMJYAdGFmnjBQswR6IUgANVtkeWVgifptT/?=
 =?us-ascii?Q?6Qa0IbskRIPcq99EFUCn8JVkkJZ//bot5J3nikzkXtzeYSdi+a7n32/KYJ59?=
 =?us-ascii?Q?P9XAH7UWu4RdbkRAWGxMwcXg5KBmNBMNn6C5BxT2emYOk6p6eo+PTq38ObRb?=
 =?us-ascii?Q?TXCDfj3tbMwEVpi20b/WnLWZwlIk9KI0+hINDn2wpc+EVQwbEkCxQ0SluUKh?=
 =?us-ascii?Q?BV/Vwr9pAOripfKSPlMlPLTNiAVrdCZl6AI7HVvv6yrFVh/uUjA+wFDbDB6T?=
 =?us-ascii?Q?fgB6pjkKAST8t6QofdIortnDr1hrlUWEz/8OtQGSQXB2di90w5nBsx6X3amP?=
 =?us-ascii?Q?Un5Rv78vugZaS6o579BikAiR514or0k9QZSA8tYgOoOwuq9B/gTK+QIeR+1E?=
 =?us-ascii?Q?/dM1XopC9P/oTZBTxRX4vdt02QcwUjoqFjDKIzR9OB7BZTPMqyaHxqs3K5h0?=
 =?us-ascii?Q?Ndz65c/7W2fCUJe9teWD3aCOoGg4YeGorPhdsdhGGc35D44i37v3WoTFD8iy?=
 =?us-ascii?Q?tnmfKPTpLkzMOO0Jxus8E8plIgCgan9nJanHdED76gfCULPt++DBnvo26d5B?=
 =?us-ascii?Q?2QFChYUaiPqpRx4UMYygJh38cZME9gLXFs+JUcp3aTD9tspZjZWaqDCAtw9p?=
 =?us-ascii?Q?GleIKbwAec+D8DAEQDW/XJvDhLx1sCVJhk1O//OHOg3d42I2baWOzxN2JCkW?=
 =?us-ascii?Q?5gcIFrJYhiIQLPNdFUcETSOTa26L5iQKgPoOj1xlPeDVBBm08MgNfSw1ZZ17?=
 =?us-ascii?Q?FZ1AQq89tcP5WUDlOuNQx6DYxv+VC72fnCbKXuJwcJasUag1/7eayTLBKi/5?=
 =?us-ascii?Q?kXQMdZws+5jbg/B4H80os15UoBcVHTzYAVIDUL1nudGloSh/oZjdFErrcj4t?=
 =?us-ascii?Q?JF6NaKzsRCo0wyPVgVP1jIZKxXWGiBV3FcrNWV6HFuhP1Qk3gU0REyubpJpJ?=
 =?us-ascii?Q?IIA8ha6050zCepknKaTNbK3+d9VRPsIaNqkTFuRBmDd5NgH2ILyoL99By30H?=
 =?us-ascii?Q?zS5F/OQIkD5XK6QsIW0eGgVgO5w6pp21djIYNqzDF/Sfq/HDev5bRIqMOJJ/?=
 =?us-ascii?Q?7+cHVhovWPCiWBqD74SZEDJAiGVcFFzNLn9DYe3pbAZCLgUNCRcCQ8AfdlLP?=
 =?us-ascii?Q?b6N1Vto75Q=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb587a97-8077-4cb3-5e09-08da341f9251
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 13:59:03.1189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/yeqwXVrO9jVuJRW0161pDAK/hSYAH2s2HrGJQiGQEpbKyw2tVmLUWRcMj7i9S2qnMiAJILxMOfVs4X/P2BaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5134
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix the following coccicheck warnings:

drivers/infiniband/sw/siw/siw_cm.c:1326:11-12: WARNING opportunity for min()
drivers/infiniband/sw/siw/siw_cm.c:488:11-12: WARNING opportunity for min()
drivers/infiniband/hw/cxgb4/cm.c:217:14-15: WARNING opportunity for min()
drivers/infiniband/hw/cxgb4/cm.c:232:14-15: WARNING opportunity for min()

min() macro is defined in include/linux/minmax.h. It avoids multiple
evaluations of the arguments when non-constant and performs strict
type-checking.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/infiniband/hw/cxgb4/cm.c   | 4 ++--
 drivers/infiniband/sw/siw/siw_cm.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index c16017f6e8db..167faa358800 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -214,7 +214,7 @@ static int c4iw_l2t_send(struct c4iw_rdev *rdev, struct sk_buff *skb,
 		kfree_skb(skb);
 	else if (error == NET_XMIT_DROP)
 		return -ENOMEM;
-	return error < 0 ? error : 0;
+	return min(error, 0);
 }
 
 int c4iw_ofld_send(struct c4iw_rdev *rdev, struct sk_buff *skb)
@@ -229,7 +229,7 @@ int c4iw_ofld_send(struct c4iw_rdev *rdev, struct sk_buff *skb)
 	error = cxgb4_ofld_send(rdev->lldi.ports[0], skb);
 	if (error < 0)
 		kfree_skb(skb);
-	return error < 0 ? error : 0;
+	return min(error, 0);
 }
 
 static void release_tid(struct c4iw_rdev *rdev, u32 hwtid, struct sk_buff *skb)
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 17f34d584cd9..3f8181664050 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -485,7 +485,7 @@ static int siw_send_mpareqrep(struct siw_cep *cep, const void *pdata, u8 pd_len)
 
 	rv = kernel_sendmsg(s, &msg, iov, iovec_num + 1, mpa_len);
 
-	return rv < 0 ? rv : 0;
+	return min(rv, 0);
 }
 
 /*
@@ -1324,7 +1324,7 @@ static int kernel_bindconnect(struct socket *s, struct sockaddr *laddr,
 
 	rv = s->ops->connect(s, raddr, size, flags);
 
-	return rv < 0 ? rv : 0;
+	return min(rv, 0);
 }
 
 int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
-- 
2.20.1

