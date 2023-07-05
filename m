Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A921D74824D
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jul 2023 12:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjGEKkQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jul 2023 06:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjGEKkP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jul 2023 06:40:15 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2138.outbound.protection.outlook.com [40.107.117.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B100E63;
        Wed,  5 Jul 2023 03:40:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFeksQ3p3SR0NYHsB2Kc7PUKi21ixJV5aWLA+ISiQa/23CUOUIol09gBLGM0YCw4A4A+t2J7YV5F4nUO2rrTUrB1FWBlHC4/er8b5zeyyStRb3E9WW97bnuVeWXgk5k8+QHggP69uYFs5xn/0FDE2sljuKSKeK/owZhbWeE7TtGLDQdt2fk3EERGlBtTfgHJFTNmwAjnJCZY+ANGqDvnOsbvAS//p/3t5GTFi/FAoChoUSok3urM+0NlljuaAB7s7t8msq/CHjBbHnN3vEI15oV2/vHwflF/EhdtzvKJs9qxPFt2wMzdDmlfTrzvHc+D28X95Lmz26YjkJBMPTe3cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Vk95VKEXhW9u8TltFZldVDSSnhngu23wfCNwShB5+I=;
 b=dNXvucPdOSqy+FgLwjUGxQgWT1VsPR5kzKJ7ybCkKZsXvS88Gfqtmk+57x+vIQX17XLWgEG2cmgR6Oqt26O0XiLSesb4xtkyFvR/yAtEeK/FNYNYh3tJoOYIZ3No0vEWds1RGflzBiO5ul3mBlRTA6pus4Jrg7/Parm34rCiyBQwklukhKcPA0JWktLbKkBe/lQm/cV09a2R3mwDQhXe20aDYkIFsC+7rwPJN05eFQ0loUSK5gVFXbwNq3q3KdBY2U9sREc990oPdDRvWt1oKvZ4lBvhDQY0pZrhALJnMqtyR+CtbcEL/sm3cik0FaDahfj9hvFbtlbSrHlzH6hD0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Vk95VKEXhW9u8TltFZldVDSSnhngu23wfCNwShB5+I=;
 b=lX5SDN6qlzDD67vY5wb/gp0wiW+NJJJY6diDNXL2PMaHTowPxVhcMiRZvGaVloT7gA/U89c237MkBYonjvaHFbwTRjqyMPLi+sGn3F9a0zPeO1O9FXkQElHpKDBaEwsjiiREsCUKY734PsrlbrurnSZGf99P1pF219twg2sCCeNt+1b+jC2Qg6AvJnfE/K4aYDGGOMWSzPDK/UVeeAGOUaAQtW52f4yzRs2kB9W0yxztWNpENc8lxxTcLqX+FrqZ34WRIqnQNHUERlqZ9b65M0xfRI0FgQGw9enLjUBXQaPAsvAVeJOvfueoTLWvjwVtbjre+aCTBuUlf4f6DLI4TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TYSPR06MB6444.apcprd06.prod.outlook.com (2603:1096:400:47b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Wed, 5 Jul 2023 10:40:11 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 10:40:11 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Markus.Elfring@web.de, Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        linux-rdma@vger.kernel.org (open list:QLOGIC QL4xxx RDMA DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v2] RDMA/qedr: Remove a duplicate assignment in qedr_create_gsi_qp()
Date:   Wed,  5 Jul 2023 18:39:50 +0800
Message-Id: <20230705103950.15225-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TYSPR06MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a6e19ff-6831-41a9-cfb3-08db7d44354e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wOJWrLjYLe3ieqcqgH0J0AnXfokwiGR361pUAdDY1oyHpQ2T9ME4OQYxUHtlCbJEU13uTB7AyJlWJEkOnPIO3WK3ptpGiX4bdU5ccR82qep3sL8Tx9rGXyh2/6N6z7CDj6GKM2gqF0lly7Yf5dFNec1Y0aZZcIbQARKLTnkWsKxKC7rwwce3agNCPQpyFGmrazhAgQy6OY6PydWgJG1G1UDAB1DXwGXrlDF8pYplkkOj5C6YdGGgl43wlRJs5YBF9HivHq7vFpibyYaqFg1G6zq0RjdznSe71igJ6WOrnKjxLCpb+3LCKNwIa4Sd6g6V71eZ/aplLzzCb4RV1oJCCw7v4vUqJpnpjaX6QA3SpeLYzwymJ+PqemfhG9HmYZwnfwelLolLRGdRjg5Di8gsBHrcgCdnggvmD/+aw9pX2aKGiL3G61usB0vXPjO6k21W5D/ttTdbZWgWQnzkeQOCOvMdBzeTovjyU1LgjHBxOeBoPzqBT/gE3f3SuY0s+SnExbG5w/dcwvEi6JSgLsrEhFSbRHViVX39mEy88VpA20M/DKo50IetZFMT0WUUQwmzQLFr57TDQga3IIGjOOviRWL4/cVCEqQ4YJZMKw2MJuPUQOI3gR1vZuwF9kpRp8Wz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(396003)(346002)(39850400004)(451199021)(6666004)(38350700002)(38100700002)(52116002)(2906002)(4744005)(6486002)(8936002)(8676002)(110136005)(36756003)(41300700001)(5660300002)(478600001)(66946007)(86362001)(4326008)(186003)(66556008)(66476007)(26005)(107886003)(1076003)(6506007)(6512007)(316002)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h1YYRkW01Y22f4ci0fuxZiBmwYw8S9JfNXoxaEHAZa7A40/RrnkkhXIkebYv?=
 =?us-ascii?Q?mtt61uHuY24BJUW1DD5fm/kceXBJjuS2HGZiKXy2O4VZBqjfBoL3Ond+JGgv?=
 =?us-ascii?Q?UX+7j5f7C3sZJHLo7P5rnTdDSrDWVdkR9ouUJYmkWv0Hr4Y/YC2auLDQEEfj?=
 =?us-ascii?Q?qNbX2BWFdCW5fm8SPH60xWDg9euH77jnJe1FVuAor4e0Z4XPh1xYl1XbAsYo?=
 =?us-ascii?Q?sGVB76HzL0ETET07F9Yz1GNwNBfQX1SALj9YZLE9uFCR2kgFBgnLvsQ60bY4?=
 =?us-ascii?Q?7isjZEztkg1NDcf2KlpiXNnXBIR1WecNItYlGaVP0MChry8rX1T2fyAtRWAX?=
 =?us-ascii?Q?K2QOqQHKLv+yEhNK2O84i3LtX7pNyRih97eXNe+xotHnCLpWlde8L6qsUXAI?=
 =?us-ascii?Q?GesTdB6oEA/2G2Aknl3DhFuV39Tn6vddi1PHpu4mjUYt6DCzxCt7sy6B7WFT?=
 =?us-ascii?Q?Q0GaOAwqT/e2RP5z+UmtPexzifzoRc5FZiFPEBTa8tNVc+TUs5rP4WAoDc2a?=
 =?us-ascii?Q?bsm3qxd9Fn4H5EkskOwT6aJQPM19xL56gaq8/4kHSMTodud/ZQMwmj5DKPXU?=
 =?us-ascii?Q?KkPgJQQAZeDRIuqpYSrSMu/QZTPOdOgcD6JX9K2KMQGz6TEVz1WpYQiHMAlz?=
 =?us-ascii?Q?ajgKALPDYEm9W70QSgsXuVLf9DMH9VJKuqtJfL906sZIw9Ij8FA1SwD4NpNU?=
 =?us-ascii?Q?IYbrmmOYQEixFxq7Yq4ttbUyOpt1mLga2DxGjszdpIISWgVAV1za8mUwcmMh?=
 =?us-ascii?Q?v5Y7Yc9DwogvUHlr/2Qh9IQ3iJ+fC/cUpBZVvjPib/efix+6R1n6FGX2qw6H?=
 =?us-ascii?Q?FNxN5XfVGqu6ZIdZNxmm8k7s7MYpQnZ1/vhnqSGnjBX6lWk1c7XPlEAnWb15?=
 =?us-ascii?Q?as5TaysywtPuvOMeWi8YxToH13rYQ7yYC+KzikjEduwRNncxf0X2EMolZ1/j?=
 =?us-ascii?Q?Ft2fvAicxi98tFFSxmcmisGDMqg/Sqyi6Nw3v8G5VImGaCYsvtcj70NIvUS3?=
 =?us-ascii?Q?v2DZ5K6koL2lFtq3RoaP9bfgsLVdVKb9cGXPERaRZwAgANVJ0Rf5ho7HPJT7?=
 =?us-ascii?Q?j/xrfWFrJol0/wWWAzncH1b8ztHMsunZ1/YSVf/WrVSz7WqbAHXBbyY7BDhD?=
 =?us-ascii?Q?9ROgJfVMZA51iSCMeM8S344WsRVb8LiQJDLmpym7ducOziA2rCNIyuNLw95V?=
 =?us-ascii?Q?dUVQ9YZL8wUbvxQapvXlD6VOEC22J1LG5v9rwUNT3mh2yzF/GeUysp0ANoIc?=
 =?us-ascii?Q?S/+yeVxIQ51IYJjokzvI1RT9qRv6cRbvR6UgmfruAtuscErM9b7EEfKN6OiV?=
 =?us-ascii?Q?Qpj22IJ6e2GbVI5BWh/Ymn+8st83utfqVM09zvzbErLSrQxOmYzAJOJbJxyg?=
 =?us-ascii?Q?PB/lhrTB7bApFjpCuNT72ZnllNvutFBb3vn6fSTBuvLHNefZhOPn0VAJpoh8?=
 =?us-ascii?Q?yp1Munvl3y+ZhhnDxgdSykYQfgDkbkPK+/6cwFSD1ZQZnAXdJzrw1Wj+t0Xg?=
 =?us-ascii?Q?2Kvkz/9l2Kp7n/ZKSUUCH34blb8B5su2lPCkOINIS9f57JK/NzaoRZERGevZ?=
 =?us-ascii?Q?V0kI5Id9UNrS5HPHPrmpprG7iUAQaHyUROVe2CJX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6e19ff-6831-41a9-cfb3-08db7d44354e
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 10:40:11.0300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jHxKMjC3MbG5o949DoLC/9IRxAWvme00HM85xKYl7lZNNNdTbJznAHEVp+bj93oM7QD8XmX2ok5SDuVLMNe3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6444
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Delete a duplicate statement from this function implementation.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/infiniband/hw/qedr/qedr_roce_cm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/qedr/qedr_roce_cm.c b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
index 05307c148..859f66a51 100644
--- a/drivers/infiniband/hw/qedr/qedr_roce_cm.c
+++ b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
@@ -354,7 +354,6 @@ int qedr_create_gsi_qp(struct qedr_dev *dev, struct ib_qp_init_attr *attrs,
 	/* the GSI CQ is handled by the driver so remove it from the FW */
 	qedr_destroy_gsi_cq(dev, attrs);
 	dev->gsi_rqcq->cq_type = QEDR_CQ_TYPE_GSI;
-	dev->gsi_rqcq->cq_type = QEDR_CQ_TYPE_GSI;
 
 	DP_DEBUG(dev, QEDR_MSG_GSI, "created GSI QP %p\n", qp);
 
-- 
2.39.0

