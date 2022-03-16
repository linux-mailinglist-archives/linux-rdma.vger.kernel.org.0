Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863344DACAB
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 09:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241292AbiCPIls (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Mar 2022 04:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354646AbiCPIld (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Mar 2022 04:41:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77BF6514A;
        Wed, 16 Mar 2022 01:40:11 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22G83Yem011435;
        Wed, 16 Mar 2022 08:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=5Gs3yTEQndVCw0h3MPD+xdWxdYxVkUwyg929Vj6GcHg=;
 b=wR3UKqmgWLdhFPyWT1q3wcSjnsyCTSzmYXOwYSg6duIFUsoNXWL7V6N4x8jTLzrkm7w/
 04WmQY5GSOaeViVKznl8kblkVMzXgyXsC6o+8KbmT8l5meAHX0LqNcZtRGP63hfmf5Bi
 XYYA+V18dwo++D2xC/OHWvG4l1/wbp4cqC/N7UH/t7cyBaQ4wR4ICp8WN+8b05ZawOax
 fKsP2UIoC+me6A9Oj5Mhdw/GL06zizcvwXO9ChQMfNoGWbgbUbyDZezeZW7k1utBhkUM
 r/CaVsjfL3VXRRdpsFqyKCx+Ub44D0j3FhmgqQ+++IY9i5D13zPx6Lcots3zWFPd6AJk 6Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5s6nfqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 08:40:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22G8UukD057440;
        Wed, 16 Mar 2022 08:40:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by userp3020.oracle.com with ESMTP id 3et658h2bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 08:40:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDW64CJX2ha5+Pd9G4Dj3mGuMgnd/umdR+MJViwJ4l04w06uUtd1ya6y3uF04DyzPFDlT5xIv6qLDZCFuL8xUvlHaYZHNMQ06BBpgC0CfeD30tW6mXQ5f/IlTktrg4nELah0BwiGzdkjkZmCZ/RK6FM6zXU2EEhjY2xfjIv1cS9V83BTKXK19fdaNuzd+CTjDfwMsTeh4eII7VsOQqMKcOdSKznvZDSo0eADyof3kq2RvmMlOi4IGDliCM1gRHf0x197K5fX4s6QzTyH3BKufd9wcDgNS1AMJDlwz+DH5wsitnkI9VUgUMUY/5Q3AGan7tDIt3NhbGF4hyO3rHqJcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Gs3yTEQndVCw0h3MPD+xdWxdYxVkUwyg929Vj6GcHg=;
 b=IOs5lDOkhG74SYZ2caiKd+o6TfC5YtGAZt7ABESzMwvYdctNCtAouFExiNyWpSPP93tX22C1BSBxDmUzwfXLJw0yHTv75sqdXfn/lCwZBQ/qYDr7LeUuqC0qlB92mdgrVXzGs2b6G0btkIFvDA+MRK0l0GSL+VbpSiTR6y+il1K4B5/IEY0rACzU3cJSWMCePp7cdBUg5J4aT6QQEKRR7CoI9snab3CbEWSsgqfyfoRUDjQ18Qc2IXZD51BjAyCra+6rQDzxF2MpvczDSlyKG6xspafQoQbHyDD3/kK23ktSZVPdRCqJgqQFFaTl6uRBKfGGxlG9BxxoxOP6GTEhgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Gs3yTEQndVCw0h3MPD+xdWxdYxVkUwyg929Vj6GcHg=;
 b=SSdvBmhKgdh2RHJb3YB5LFNzwI3LaAGGMvpNKTixT8VsEis4W/WawtjD40ufzjQYkeRO8BJgtpwfRUzf0C7BlSUTnTDnZCg2ySPkzVbyl0ev+13nOMGfjyUlrz34KPtKvRXtnNVRXCQ82LzSAdfj4TyjPLXX+hcYM+3Y/pSMl5A=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB4736.namprd10.prod.outlook.com
 (2603:10b6:a03:2d6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 08:40:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 08:40:01 +0000
Date:   Wed, 16 Mar 2022 11:39:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Aharon Landau <aharonl@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Mark Zhang <markzhang@nvidia.com>,
        Neta Ostrovsky <netao@nvidia.com>,
        Gal Pressman <galpress@amazon.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/nldev: prevent underflow in
 nldev_stat_set_counter_dynamic_doit()
Message-ID: <20220316083948.GC30941@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0098.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d046697-02dc-4f5f-b139-08da07288f64
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4736:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB47362C42A6AC3A818DAE87B98E119@SJ0PR10MB4736.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JvP2V4N9oJyJD9A1zK00hnI0bvORgVow8E1Dot+kBLR5UkNnENjKuGxRYthHwX3Hw0wMmjs2L39kz3fuXWuH/81DPGdciaickEKic+JXAh1TIxW7jq0eVJ/NhLrujq7L1yYbkdgnqG1Af+Rbf1N+m1iGn1CqH8qijOKUm3hVM9wVOJueN8I56wEyv4jC4OFWtlCmeMc7A6VRo8nTK0mx/bTBefoe/IP1xFD2N7t9qH3f8LVG72n91dxMLJjSj6rClosahw8Mh79kC1eP22vY+maZGE96Sc6ozFn5kmy+2TCXgND0GmEveLewkHfiaZMdGnFm6kVo5ahR0LwleAxkWioShgJjkngPjE3/XUcdBunrJjaeFJF6MOso5M5tqLT5LzY+NwtnVLHOW4JwiAG8RVMfeeVSp9BQd3ySaNrDOWLa1tidLxMrESg+CHEN8Y12VkG3B0RlvvXcpJL85TtZCraEsN2FaJLOm8hVpHFGke6Hj1HayNqzbpl1kUFuXIVgOOilyndFdHrWblN3rmPczo5WT0yvS5GFE5IHGE/Au3EtTUU6lH1yTHBlWXNLTuNNhtWgqKLeLtAGMHAr4wzqDuCnHO9gWLwtKQDiKtrPpJwpUO2Vj3FQgwB33fU3MJVySl/gt0cqJpi3WqcNY1Bheu6V+QSgxcZttKO6sAm/KrFJ7pK6j+Mxb0WrFjaHGh5qIZVwJZHyPoEuAsfi0goXJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(54906003)(110136005)(508600001)(6486002)(4326008)(38350700002)(38100700002)(33716001)(86362001)(5660300002)(8936002)(66556008)(66476007)(8676002)(316002)(66946007)(83380400001)(52116002)(6506007)(9686003)(6512007)(6666004)(186003)(26005)(1076003)(2906002)(4744005)(33656002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZLSDWcWPdfSQy5KD/4tjaOpUah0XiKKx8mzLas7rnf4GIliO5ifnHt3WJPnF?=
 =?us-ascii?Q?24vI4D7KEem6+hDdRt2eYZ6unSSIwF8zCJETzYS1Nu+a/B3kKCdVuTsO2U0X?=
 =?us-ascii?Q?r6ypS/qdvStXWQ/AnzG/YRILi9UFoetk/5J59eQyholSU5xW+pbRmnTN3qLB?=
 =?us-ascii?Q?iIEW7Ho0QFTcXorSJKolSujpJtNzvj/V/VR5WVP5QzYrLFFjlN4OCIekmEIQ?=
 =?us-ascii?Q?bVi8SS/7jisGtvGPaE7ddhzgRuucGfg5iInCYaO8XPJCzyERcAZ/B19GG0pL?=
 =?us-ascii?Q?PemiUOLYNuqFs6+tliXvGWBq0gyaOQEEfXYZQD+AAtEE+3h9J1JkA+ISowDX?=
 =?us-ascii?Q?xXNy2QhZsrNMumDL4ckiyOzFBkc70bm+RBSsChGELZPyNYJ/Rra6YQ3jGDaV?=
 =?us-ascii?Q?9ASIKzzDyP7+2MzdR2no4ohru2/07goKctrjxdHwdbUdGy4wSxNvaqIaLKf8?=
 =?us-ascii?Q?A9e8lxX8DhSuS0Q3wudm+sQ9GwqyLqOzN/0TkYONMRe4gEASGCbd16T6Pyc6?=
 =?us-ascii?Q?poklQorGEBVzuh3PCuiD4L2++tU0s+pqNsh0Nf2QG/C7G18QR699FOBmPCRF?=
 =?us-ascii?Q?ajvKQoM+HCGcHW2lg9/TPIthS5qSUdvjfdnKp/AK9ggRxNmz8gl9PFKCyBHs?=
 =?us-ascii?Q?2Zgom6I2pG9GqXhm2oUMBo97Ch/wbHMAPXoDSzMmeMTVpiQbfJ8WfQZddssT?=
 =?us-ascii?Q?nmpLRTCMwDrok4ZwISc01ee4B5JlYz9yy6zBC4YcS9P8FANT3e0muCbrMLTm?=
 =?us-ascii?Q?YSlJB+D/dl8h7yiJhjbJqOBTeu1SJ5Far9s173pqZHd1/RXu9Mj5JLwJclj5?=
 =?us-ascii?Q?AIZohMPkYaBtNVjoxi9IXOaNV8O4ieKSzAHQ4K/emCcV9x+EigXRyeDrctep?=
 =?us-ascii?Q?2hvZvUPhGeh9eXpCf3SxOkLjmaMseGwukCHMxPro9p5QJSRAcW8RUQIaIPp/?=
 =?us-ascii?Q?8naHWYWo7hKJIoUd+Zt3D+tl6ETEPD3p0zbdNxNkhxrNYHuQkeBFN3jyNVR6?=
 =?us-ascii?Q?k3hl84Yd6/Or3xd5olleOZ9gJ+pkF3OZKjSnSL5eSy8A0xZZiLJfz1tIKKk9?=
 =?us-ascii?Q?5Mo+WUYpwBIEhr9dbRmkP9y+6ZmzV0OXrcva5FXyf0mmg824VnOPc1DyAD74?=
 =?us-ascii?Q?tq+ax79uNeKPo43D4FcwWSvp38n81lH0LAI0oMEt9XpIQzdSVu8ZKW0aCj7j?=
 =?us-ascii?Q?EHSgdoc1+fL/XibpTiq/H6z2HEHUut4vlEPFB7DOGH8uKYZo/gNsEbJGlUZP?=
 =?us-ascii?Q?0grly/MOzK852WEgf/X0WofBZjmllwXG0DQ932NRBQA2fYRbeWn1mTUjrcHS?=
 =?us-ascii?Q?h0zz2l2o2LZmSKBPrWW2rAno1w3sqrAN0yFTTwntRBcaDz6QzBa0PJ6MMjDW?=
 =?us-ascii?Q?4NY+mlNnN2mP2Oka185RN0vIYC2HecDAij2nam3qo0md42XQNLcIhl2YwmI7?=
 =?us-ascii?Q?R62F2GRR/BKxdihlGPA3vIt+861X+m2FVxa97S6y2yoNdP+aNv4zVw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d046697-02dc-4f5f-b139-08da07288f64
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 08:40:01.5298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ct9ivbWhQSasojk9yioWpSgYU2wppvXu9EqD2GeZMui5BFIrSsGxJR5c7KfTdu0a51KHcgbOFg+Y0+Py/p2rW4USAic1YlQGRwjhtu079RE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4736
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160052
X-Proofpoint-GUID: o0b1Sikhs2_D51qeFIfA2kFuvE1bqRTq
X-Proofpoint-ORIG-GUID: o0b1Sikhs2_D51qeFIfA2kFuvE1bqRTq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This code checks "index" for an upper bound but it does not check for
negatives.  Change the type to unsigned to prevent underflows.

Fixes: 3c3c1f141639 ("RDMA/nldev: Allow optional-counter status configuration through RDMA netlink")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Could we not use a nldev_policy[] to tighten the bounds checking even
more?

 drivers/infiniband/core/nldev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index f5aacaf7fb8e..ca24ce34da76 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1951,9 +1951,10 @@ static int nldev_stat_set_counter_dynamic_doit(struct nlattr *tb[],
 					       u32 port)
 {
 	struct rdma_hw_stats *stats;
-	int rem, i, index, ret = 0;
 	struct nlattr *entry_attr;
 	unsigned long *target;
+	int rem, i, ret = 0;
+	u32 index;
 
 	stats = ib_get_hw_stats_port(device, port);
 	if (!stats)
-- 
2.20.1

