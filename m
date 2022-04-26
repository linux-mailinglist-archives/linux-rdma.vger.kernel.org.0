Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6109850F1D3
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Apr 2022 09:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiDZHMo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Apr 2022 03:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343689AbiDZHMf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Apr 2022 03:12:35 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2123.outbound.protection.outlook.com [40.107.255.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC5537BE3;
        Tue, 26 Apr 2022 00:09:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsRwxrQOLtR9X/+IdBAs2oURh6PIR4vTCa50szfe6Q4ImPMsi+6yeGda3S/VOfPB2y0E8BlWmf3q3J38+FKJOoNTVHzSVWHVV40Hzi21znrIJZsTePKMYcad4hw2FUSIyEWd4+mICePzQ+Oh8arZ2CDw1SyVSST9qgKIZvAhRLPevwiz8lr5GfVjVe0r/EVzVsl5r1sAjOXf6dgLCq8zq4NwWf20QRjddsBo7c0u1rtSojVzg9ypTcg0x6lCjIbuTIX2OJURbZ+liCsjXWA+vtzIUs8REOGFO/qPIXiC0Cb7Wfp24lq8kRBFkayvvKDFFAq+8Rx2UJFxy6ASIwpfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+Mwo+kI9IJ0TdazOsc4a6RXRcrGWWb77F1gLFHmXfo=;
 b=JozYvhHnUHNXGUq9m/WE6n1FXLedfOPszoQ81LyQIosgb1kuE6N8HldM3OqMjdVNGlQmI3iiCFlFh1UyC2k53PwOC0XlOoQAembqBHuOqHe8xQF+YVslNPsx443cm3kY19kMA8dOpgYjEMlVk084R4Y5EMsct1c6Kn87UvQcNWWr7eyBeqqcXG+2oEcIy8wH5BmMb9ewK3ILykgBCp/66i/qld5pkjIPvHGeht72oK4TaUHksllWSq77BKILxhrn1+bfS4MyyDpoF56eKVsotNHevOsvVfF9usi7PJNgGkifzVMFCY5DgJ29SshAOtHryUbnrmBB54PrC74TpBGHTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+Mwo+kI9IJ0TdazOsc4a6RXRcrGWWb77F1gLFHmXfo=;
 b=EM0rPDtx4pdJq7RkbN8+hvJQPlvByPCc9wlulTvfzfKgq+DJ6z9PrjX3FvZpIjZQz3szlQbX/2ECV3IW73T2xW5RZjwMSQEzoSJvnURri+HW0nRzPq+9NyrPBvxii9r4Sr0uSQPCmmErHfg3BdXPzYq1y+qNH1us3znW/IdjJIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by SEZPR06MB5094.apcprd06.prod.outlook.com (2603:1096:101:39::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 07:09:25 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 07:09:25 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        linux-rdma@vger.kernel.org (open list:HISILICON ROCE DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     zhengkui_guo@outlook.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH linux-next] RDMA/hns: fix returnvar.cocci warning
Date:   Tue, 26 Apr 2022 15:08:58 +0800
Message-Id: <20220426070858.9098-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0084.jpnprd01.prod.outlook.com
 (2603:1096:405:3::24) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c94db07e-d23b-4dd8-3191-08da2753b204
X-MS-TrafficTypeDiagnostic: SEZPR06MB5094:EE_
X-Microsoft-Antispam-PRVS: <SEZPR06MB5094F320811372225371A8DEC7FB9@SEZPR06MB5094.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PQlq+EabCa5Xvh0phdvOvxLFvSeMV767KXHeucZM+4tiqQVE58LieHA/kaDz2sJNNX02pW6KNA3ReZmFvDCziN5KcbME/Kq9DTA6em8MdQWpXEnwQiIXNfnFoBj96R794DGlXQAlSWa5jt2TCMeBrRB7MV1Us43UrgRs18CeKPkAqUcsM2ACVdbbu2eS8VSc70s1vjbozvBhqe2wRR2vesxF0mvOUxKs759sxZwfKvkb4ipjFha27DhkgMngA6Odi+4VYLtV4oAHwFn2K4ruVX9yH6lyPu2iwhXWgEHN8iWQveQfChxxBtzWzON14oM8xPJvvPObItqsNPEbqdtwvSJ03ZSe7Umj76AZqHcErs5HvjHoT+xHsO0E1Uu3aanWW6P9aJmN25WyKbdhc0oQOaa6dKhVRnhNsxxuH4f/pyuPhel0SaXCsl9EeBYnpVgRQACEu9dVyGKO7XltAcoe2ZO5JwYJprRPt0IPswSnUEa57gvpbk/b8LCvs4dJitGrGXnB8BsY3HWcTbBkOwUcpuDXPh3WZqvLOrmfHeEs+ZdMN6KEobWG7wh86pZ9c7tg4gKeH5vcxvIMI/sri+B9AtvCb662b6bJkalnGhfVMFlyLWxlRuRnNvRQ83PG/NiQZKqrmYUTl5pV33zpInlZ0edzoI3T6zVeEPkEJn75f4MK41j1eDxKwv9gZQpzJexPQblJ5K1810z4tlrHnljL1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(2616005)(86362001)(1076003)(5660300002)(6512007)(6666004)(26005)(508600001)(2906002)(52116002)(38350700002)(38100700002)(6486002)(8936002)(107886003)(186003)(83380400001)(8676002)(110136005)(66476007)(66556008)(316002)(4326008)(36756003)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pSr0Ylt8c7l6WJG/um8sjHOKPaP3P6ZqyAT1o4zE32v5cXUn62zkjI0CVQru?=
 =?us-ascii?Q?5j0YzlmB33hO0v5+jr/NxMpeXMLn/FUgtQsULW4H/Jt+Qg6Jre4tvjhbN3r3?=
 =?us-ascii?Q?JgfL2BLTVO3l/oL7AX4xIXC/7fGj5H3Etqg78pgzLVsfl7XmmmKFewcTSK4+?=
 =?us-ascii?Q?2xghAcZCvABlsWg2+h1Kt3WXFYUj+m9E9K1sN39Np2zltViZTdufwyFMUppr?=
 =?us-ascii?Q?8zD3W2rax4j81yY/Bw/7qvBzWEg/G9Ps1sxYx9BUUQJR6SkvRt57IXYa9lWd?=
 =?us-ascii?Q?g9LNVEM9vljz/L5GgOQnPN+5OWQ5vzoCdgbIsP9xjaUE3DrLAOjqNWRA+2q9?=
 =?us-ascii?Q?sCh0OoMrSEW9+lXo4eraq4rtj4rLYwdXxps/gNmEjhX4tXz9ZxcE/WlR72Bx?=
 =?us-ascii?Q?ONY975w4KAg/ZSwEjb0HMnkqYTjukboCKkRK1DcdWzeG5IF7lbqSQ4o4Y2GZ?=
 =?us-ascii?Q?fjdfsC4IsZ7b3+SwxDc2EKRA823b/WrD78G6MmmnGDVGNJdwqQ/n1bxjPKHN?=
 =?us-ascii?Q?Jsdu3yDR8O4QrmFGkiwZrye999bTHmWyK+i+kx8NuMkpsZ9x1tHxuvVQRrds?=
 =?us-ascii?Q?vHcW7axq/YFVB4Di4ix2DaSGYcedboUor00q3CH6ad6hIT8CWKAZzZTkcjix?=
 =?us-ascii?Q?4w9HKCTl6fXj7GsEJfpMByp1Zc5yCfTAtW7slnl7YT4tiulIW6xWVLm0m3Sm?=
 =?us-ascii?Q?r5p8DHc9CsX7DmXq9DXJN7OAYqjjrzQqrSC0b/mYv6MuzjJ90uV0fe0N3alw?=
 =?us-ascii?Q?nRm/dzUI7wEGgMNWYgm8kjDz2cmawv9Qd9YmVbfrqVcGTV+cNPFLWbs9xmD4?=
 =?us-ascii?Q?jQWPo12ukA/6knREJo/go6JeOwKyLQ8MX6jIvlBipRZiRtMcta4087mdnfoz?=
 =?us-ascii?Q?cD56mNOh+D3/Xj7+ShEt589I7FOurISMCXAqY/A6Umwkv89pvwp+tkjZLUxw?=
 =?us-ascii?Q?qzl65/dvYOEDJ9uwu8ttPJcVP1W28SQnM/82O9Hj/DO4cJh3s3SHCGsOpMAU?=
 =?us-ascii?Q?C9oVJy3Seq+bDGaR9LF0qtuTK8gLDvjhUcUHgqR2ef7K28hdp+cJK0GSfrrU?=
 =?us-ascii?Q?wjPRB8wvwY12ibEuW432IjWFgPDvtuqZqpvO+t8qPjOTGLqPBLCdydsNxaig?=
 =?us-ascii?Q?4+gf+x2okbbuTAWstpmOCmceM9chMVQs17lFI8dvO2BLHf7KYjPs+yRxGwD3?=
 =?us-ascii?Q?WQUg0+Iqmx9sVZ+mgnGrmxMK97WgXLYr05CI0fbIvBiU9eYbNr2N4OlCp5Jl?=
 =?us-ascii?Q?4+Elv+qio9DlD2tcx2r2AM8bAgdbiuM+1KSg5qizs+JdzVy1zRjMNLmMBMzp?=
 =?us-ascii?Q?4+pXrlxP/Xv5nCEs/6d0EW+NEuVbThCkfPBQLIG+6I5RYzvPgOlTEu9khTqa?=
 =?us-ascii?Q?mA89fUrjPof87WWuzUmIsQpyqw5byjF6D+Yj4YGN6WcRSsJilBq7iY8g1sWC?=
 =?us-ascii?Q?ZpFeRQmChyJLlcRmYdvbO3bTXR4JdVufu4cRGpY0nKlhdRPlie3/rQHfcXOp?=
 =?us-ascii?Q?4gY84xeFYkej8zlBI5UXua1dPY4PkVGMgL6sxdcXP555C11aUH6bTl1+UfWd?=
 =?us-ascii?Q?4Akw3gFqKd5dyJCpnpH79AddK75F+mCx8NPoUVQlj9wD89RGOQ4jLnXn/TVI?=
 =?us-ascii?Q?+2n8qMYj+DMtwPGyL57u/8LMhlA2P1ILo8s+xzx6euvqOqeOGBBaaB8ejt8Y?=
 =?us-ascii?Q?eXDVYSAKNgn7M61DI4Fn4sNt/qOdfMkQefm1bTKpkjKXWKxhCfOt99UR98sk?=
 =?us-ascii?Q?y9HmVRqmEw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94db07e-d23b-4dd8-3191-08da2753b204
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 07:09:25.1859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzYFG/RTZu5oILm6XaMhkvz58UOA31+vbdWgCwXmMB6kLrtbvRla1KR++tD2Hc5fltLge8ivc7Ix30cfGC/Zgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5094
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix the following coccicheck warning:
drivers/infiniband/hw/hns/hns_roce_mr.c:343:5-8: Unneeded variable: "ret".
Return "0" on line 351.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/infiniband/hw/hns/hns_roce_mr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index b389738d157f..867972c2a894 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -340,7 +340,6 @@ int hns_roce_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibmr->device);
 	struct hns_roce_mr *mr = to_hr_mr(ibmr);
-	int ret = 0;
 
 	if (hr_dev->hw->dereg_mr)
 		hr_dev->hw->dereg_mr(hr_dev);
@@ -348,7 +347,7 @@ int hns_roce_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	hns_roce_mr_free(hr_dev, mr);
 	kfree(mr);
 
-	return ret;
+	return 0;
 }
 
 struct ib_mr *hns_roce_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
-- 
2.20.1

