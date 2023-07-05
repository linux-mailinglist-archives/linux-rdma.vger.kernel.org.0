Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F11747BC1
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jul 2023 05:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjGEDT2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jul 2023 23:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGEDT0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jul 2023 23:19:26 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2122.outbound.protection.outlook.com [40.107.117.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF93D1B6;
        Tue,  4 Jul 2023 20:19:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euEIPDDxVa0SFYv43Q95xXDSDjx30ZQTtdFUgivqLjLo67Nm8zvtHGcv9IKD6MswL+VmGoUI51gaA3cP0ex2QnMGda2jFAJaVudUMwrpAVLJBtsmN28DFbuQvtjNMrRhqZGjIBxjm4rVPoPOyfPD74tKCNo97Y/KiRcS11VkcfGKKksXR7Ar1QYWNPMK/DdKUOUhvhMCpH5te3Vjz+XgHcUrwdGl+P15d55wqLWNXy6MW+jLGTdphcLiStJW6VtWFu9/BS+ncI+Ku2U9wdMDWUt5SSiJj5uC5heryhn2+wE3j2dWIde5yBHbacnTTeIT4IIg0/uskCJCTe4f3ut2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4ZYWoe7TQjP431yKcPFnJX2obdINcZqdvH9uCkJcMQ=;
 b=VVGRRA0C4geEF+0tMdk9uoIvLIOTzMKXlm+RCGp7pQRN9OAiyOj3EDtclcNrLJi3Yruz55E6paBrGUnQwLpaF8EIYBL1erAA0F6DQAm3J1dOHjH0mbXRB68zqno+LnCCREnWlQouK2YZt+jQVtAJrQxnbwmSzJMx9IdcFkE5Jm2Js27f9KplwbJ7yf4gJcFtw0GZNY4hhQoXQwaRLUgZ7HA+F1WLyt63IvYhJ1o+9wcdBrOCnTGtBY36sBt7htZLFXj8Y9ysGm88yigzvf2IcaxD+MP+IHvWKO8Aol+VbcDc3sLKLtpx3ZTOfHPRtvI4XiPqcl8/ArAP6916phC+iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4ZYWoe7TQjP431yKcPFnJX2obdINcZqdvH9uCkJcMQ=;
 b=EUmmijhKkMJFzLjbwuPdjuw0OMbyJiBmJdy3cgRyYwlM6dX8cIynLGDOG5U92QJL7BM6MgGvgOe+vHVSFFLqkqmqkXMrpywmnnpiPQAMxyc6akoUIBxDEIk2QthiEr2zezg9z1mZ2HI6pR4e3b2Ovxm2Bp5lM4IKObqz7m4FFEggrzy2kNFk3C8ZEZUBWWwhBKTj8Rc1oOzAl/XeumwEJu1/5MWliWgaJOISo1R3fp56H4EltEWgnvVvMxRvG8Fjdd4VpBkdQ14G/89gv9scJBeysAisnhckqzZ96ZQ73wJOh0beyx/MQ3JoeNRZoqYinmt2VUGzc4sEJTsxiojNGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by JH0PR06MB6317.apcprd06.prod.outlook.com (2603:1096:990:19::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.15; Wed, 5 Jul
 2023 03:19:18 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 03:19:17 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        linux-rdma@vger.kernel.org (open list:INTEL ETHERNET PROTOCOL DRIVER
        FOR RDMA), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] drivers: hw: Remove duplicate assignments
Date:   Wed,  5 Jul 2023 11:18:49 +0800
Message-Id: <20230705031849.2443-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|JH0PR06MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: f530a96e-c903-4670-43f2-08db7d069deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mlBI3sV32Th+1/Q7NNlxT6Jwmj6T2dJ6lmOSJrqU4dqfAaW3VD/6vs0m68elOwBJ/hQ48tBOw73eGFN8M+7tCba6DhpFu0GMGPoS5y6KQpATX05lu0oJqK+Ck3KALgijSYofF46wrM5SFkTaei8kpsI28ztL/leD9fT/+4ZrP0XqSEBg5xkBPEfWE3J8myo9Ny9QV/qvrQLNXo80SIgTUf7EZnbKtVYOalUkjZ8yt7TkZzvAW9uPp0FieCRENlADxLziP0hFitP7kO8CoYM7qRQ9EZFE7lq1aty0XE6q6/9vWChayG8crisC8NBJmXZvcSfn2ownoSOA6bHnDWPfosaq3X4IkOGDRN4ioyQ0/7c4UtDP19fzmIjNQekPYwfVIR3en+gClqJk8Lj+RYUmZRxBZaxGZzxD8dTT4Mu15hI988Rf1xxLD97V1+14L0aNCXt0TYbirrcT4hdL5YVIxsAkT8hRjERWBCOwppT/S35iwfGTfdSVi7Z9vVJI5Ioi3FV3BTE/g2YaGmoQralDUV1TJ1s8g4XjhRra0Ru4xwU+sXCJpQkd1B9jML9po3h/tHtAB+rzq9Qcwa4WB7fxgICa2Bf4gk3btYX7lzmiufo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6512007)(6506007)(107886003)(86362001)(2616005)(186003)(38350700002)(38100700002)(4326008)(66476007)(66946007)(66556008)(83380400001)(110136005)(52116002)(6486002)(316002)(5660300002)(8676002)(8936002)(4744005)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UVNKvgnqE616F7dfnoFsGcWF1lI0hZlmiJDH/ieOfOXc++1mZpVHgzJn3+WU?=
 =?us-ascii?Q?XVAbVht+KmQ2EsM+sUsmc6RcDm2vNdNfH1MfTVQMSG4v6c489LT0y3hYWUB3?=
 =?us-ascii?Q?YmyTmkGY9ywDynPSgnBrqvXPBMZZ4Bx0Z/HUJsaYtGTQNCuB/qF9ZX3LYNT0?=
 =?us-ascii?Q?odZEjGz/XJaU40gcW2ChBM79MospSgJr1IGZyspbGMJmXJicKzhaqszq69LO?=
 =?us-ascii?Q?N214KGjmJ3ffwtqLqxz1X3FCBCMgxCbRaL96ypQv/p2Anh9tulooOfOu+Z2R?=
 =?us-ascii?Q?2meeYa+eY0aULiGouKB1SH02U+A5zZrziWSMY6b9UCxTSw4PddeBreQBuoeZ?=
 =?us-ascii?Q?/dfB+cYEGh4d7Ktt69DLVqm1AP+uv2HCxu/pPcFVW5dC1lgmIFDBrqEX68HN?=
 =?us-ascii?Q?YCSa8yURfocKLjLu8pAFvOtju97dIuIum0md25VVQ1ip0uPAE3ygz/RxqDRb?=
 =?us-ascii?Q?LcwvlpQool3KdB9at6B7c8bKzmkZLRD9wIJP53kBhEe8lhp9BvBrHle/7jle?=
 =?us-ascii?Q?s04/3EglvkJt2tRmrpyW8ITXX37vxcQED3kO+0zZoNJdnV5cYtNwLtcwY2Sl?=
 =?us-ascii?Q?tzZtepwP3hEBlDudUHEqwdlMsxmtFFqR+V6pzgms0DA0i3zNXyhr2zGCyh6p?=
 =?us-ascii?Q?lEBSNiIe7yH/WKsFZu0KEskrZZBMTYRwxitbxqD7s4JoxxwIvt/xLpjAZ517?=
 =?us-ascii?Q?LY5AaiyQj6FHGT7qmYBFP0iBdAGuNc2vHsCdZMdtq7KDGutpOijUoUrlcGYw?=
 =?us-ascii?Q?281pna9GAZ6C14dlkBZv8ZnXs9lDFHwBKttYe7R9Mf9HqrAnX28gNWWyZAiM?=
 =?us-ascii?Q?9rMEBh9CEucrT33jTTrUWZT3uXnZ33lp1C697X4rQar8am+cTi8IgTCv2MOO?=
 =?us-ascii?Q?o5t+Hwl7pnWE44t/S2tmkZ/6G68FGIB6/Py0mHfIOnkhpDBeJTp41N1xvuk9?=
 =?us-ascii?Q?/rkCS+BSZkhI806Zur/9Ni3+As7nQjGcIsmI2sk6A4cUGX9GEA8xokXzA+mF?=
 =?us-ascii?Q?mSxtkcc/zSWvFciti1dw1SgozYjeI4ndlSCRRbJ5IRBTyoHLv8HENWebvtp9?=
 =?us-ascii?Q?i97ZXfK0KQcJQ5QJiiaXkoqYFE7J+f8FfNEs+Hl+ukGYAXQSfSzecVONTS9x?=
 =?us-ascii?Q?mezuVsk1AWud9obKYpka2UlVKM08p7CRSDPQN7lJ26lMW36yMPnoF17bxYj7?=
 =?us-ascii?Q?8h6gTEJzgdva8wvE345f+EeW3Do/jjpg/CzdwTPsq+ZVHRMZ1XeOq/LoYV5T?=
 =?us-ascii?Q?b2XPJD0nLxcZVB93CNeSTJUdyuA060I7aXcXq7slS/2+XRdRY0XhTAKpXpyH?=
 =?us-ascii?Q?AdNAz75btHr8Nc8UsyCxw4MvDxyobx9AfHj1b/05HxicdK7mxl3F1QPEd0fk?=
 =?us-ascii?Q?TxE3R5TUKE8aoFho+PS63CElr401UDwAw3hlL269yvQMUpRwaTrVuDFgJFeT?=
 =?us-ascii?Q?v3LKyeQUULPTWzif9g6jowjUdr46a40QCKW0HNr9e2RgvkCEl/08kaBURdJq?=
 =?us-ascii?Q?EQTNj2LiMLVM3OA+mRPoY62dThiU2Fj3Lq9t/W00F8SsfFckbGf4+b2XHr3s?=
 =?us-ascii?Q?Ybya20z425Q7i5VGcg4ESDeJ9nbS72g2AmLgmntC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f530a96e-c903-4670-43f2-08db7d069deb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 03:19:17.8819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/yDpFZsJyqZfs463ZJWB/8bfHWkfkKFOAHOWLO8ATsVg+5owXGdaRqLmhU7g4h5DxdVTmid8TuF6VnAiCC1HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6317
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

make iwqp->ietf_mem.va avoid double assignment.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/infiniband/hw/irdma/cm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index 70009b970..a65dad5a8 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -3577,7 +3577,6 @@ void irdma_free_lsmm_rsrc(struct irdma_qp *iwqp)
 				  iwqp->ietf_mem.size, iwqp->ietf_mem.va,
 				  iwqp->ietf_mem.pa);
 		iwqp->ietf_mem.va = NULL;
-		iwqp->ietf_mem.va = NULL;
 	}
 }
 
-- 
2.39.0

