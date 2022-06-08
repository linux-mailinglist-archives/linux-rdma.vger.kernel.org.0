Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B907A5431DC
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jun 2022 15:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240379AbiFHNr3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jun 2022 09:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240335AbiFHNr2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jun 2022 09:47:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB349443DA;
        Wed,  8 Jun 2022 06:47:27 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 258DPrHA008787;
        Wed, 8 Jun 2022 13:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=YQ4MqipYQOfJ/q9qp+r7ZSjKEx+MS3a3OsCOhLiKOyU=;
 b=ggZpMIdGxOs9mAAqyWiOx4tOaWbi19CfE7f5K9WRWL3cGBvLHG6DwphxRShXONXOLrWR
 abfvf59CWg5s5yeZhYiypRh3DzwFwh9goWGFRYrdwNI0eh7BIN0fBttcPYVJLm+09MXJ
 VUi6qFRk+Wv/Q9ZkL2EsZf45ax9Z9c+LdnMoKSZAXKko/pudtudNT3LRPExm9wsvwDlG
 mOhadeekA0E/EdUxR2GwcwAuByIir4p6z9ShKxmabnwylZabZZuP1xcypdtGY/7aSeCW
 JrDWSTU+5kEsI5+tVpjnGceWP3FJjGzHHBNmAxjoY8jxwAqPKnjFfS2tlhqeD5ZAJ7kA FA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghexedyar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jun 2022 13:47:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 258Dfqjx034710;
        Wed, 8 Jun 2022 13:47:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu9n5hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jun 2022 13:47:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWo7TJZ8L5Wor3kcYyg6PjP+xfjrcKrxxmi7JmaBzEKnqw7sMyDIKTz1GHpJFOb9/j60pC01MQu1W5crUDBuO5rUdZujGGX1Jz4crbal37C0+1fu6IoOJP2Rk6jiqPn3oo2POrQsWl6v2sOUUidUBSRgdidL2NRE6L8kdujBNfgLxTiTqHPzZDYM8Brcz5qEWYxopsxqVghyuaTYgO+KJhV20hhKx0TsFtGo9oRSXkkp4UYTy2TB2oP10/Dr+GmiRh62flhAIqfxy2bECiTRhdcFVRDzG1E78Qqr4oSGGDzDP8SszYcrhQIt/DT+aPubESSxdX57nsrbF2ck0qoZ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQ4MqipYQOfJ/q9qp+r7ZSjKEx+MS3a3OsCOhLiKOyU=;
 b=lMheddkEX6LYR8fuVYx/Twvzex5zUjxHw2SJKQCzuEg+uzieR7HkjnFYNYoX2NrU0JC3U3XRx58tiWIDX+v/DLZAOOvi8fvqGJwlRHlwWcHFOb+SnmJwoli7WRaZ6qz69/LM2c6iCYk5HFZ54nPoONv8S6Ee8QJPc/WDzJSKMfpXdWOAtu122Y+ufmC7WMXd3CcB96EDsOjB2W3aAa41WeUyUHvYYupyCbq+JgZbjP0zJ4gL7fkHznXfHVpoU1W+gpjnoPflULbdyNeOgUQac0AjecZObo4LU0Q1FXVgZL2jIbJmuUWBmTImo8GKZLh+v1LCGkxzKn0+12xRQfqVRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQ4MqipYQOfJ/q9qp+r7ZSjKEx+MS3a3OsCOhLiKOyU=;
 b=XfiIf9areM5HUEqctZED4bLoG4IFek7lsVGylarI8Zo3vz/f+zFcEpQxhjaty/by3vEurxojFQ9Sk1aS1qkWOaG9MQ6CN1d81LyJNSeFfEQT4gFrWPfMA4UmN+/5/PbR2k9b8rksXctELKs4s+7syT/gj2xPejSLH2OvHeAjdd4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1426.namprd10.prod.outlook.com
 (2603:10b6:404:45::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 8 Jun
 2022 13:47:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 13:47:17 +0000
Date:   Wed, 8 Jun 2022 16:47:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     Kai Shen <kaishen@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/erdma: signedness bug in erdma_request_vectors()
Message-ID: <YqCoWrAXeGHPvTfO@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0178.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::22) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59a553e1-4b52-4116-fde1-08da4955670c
X-MS-TrafficTypeDiagnostic: BN6PR10MB1426:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB14262E6E1351B5BECDB5EC558EA49@BN6PR10MB1426.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g9MX3UX2eiInrVw8YeIvLaFVqy9p7qhJuHT51QY6FFiNxDUOmaBmbZinzt2Pe3ROVDjHjyXY533y+XN1kOwMv8JfH/MPPlLjuQHXkmJ/CsoOH1iTedRLb9zQQlvoK/irWllRm4gcQF+ngF7+XB92z4oS4ZUNmcXTRU7xZr2ej74AFyCyrg8DySbn+z4HTh7SVRcd/7+Xd4iCnAZnFsADnlET7i8gGanDFtDF6Yl/3cz1wMrWWybW9wt3LNxRYhuSd2EsT6zsfFhAnVTyesWM1tTkekmn2LQxDXJmFSY7jrDcD3GIptDWk+4PNUKQYrX7CFoAlxKARAAhpETh1ojSPJKwiGFc9yO7Umf0165zFK3MZWO/nfvJPNIRfFLCLBaAs1XDg7jbGYUVNpajR1LZzt518rygX92zzfgEp+AVVDk0GcPpwnwU5CD8sDM9BhSPWNtEGDvxKCWiLCrMD7mwHk4uuK6XiiwtjWNp++ERlwQZckXHKQAJizOLTu2K/mu6UhU/oNysNZ/3gOr4zG1qu19kRQYwuDt+j69Kk5rXyZEdYdxY7BtJTEDEJZcgsUSrbdGrz4iuieS04yPYNGKFPHSct7rg1VhXs66i3WgKifITtAdnn2d1Ou3qRM8C67jfZZa+DUmHZnhkWhiXtcqvApgKBOrISsU+rJpIYIKYRmRIpjQN0q2Fe/O5th5bSFy5tAV5sEzOah4BySur2NZ3Jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66946007)(66556008)(316002)(9686003)(4326008)(8676002)(2906002)(52116002)(66476007)(6916009)(86362001)(8936002)(33716001)(6486002)(83380400001)(6506007)(6512007)(26005)(38350700002)(5660300002)(186003)(38100700002)(44832011)(54906003)(508600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kjl8Vw0morDVJ/RdUxoHc6VEWKbAfmHVacmvfYuMMzH2kqjwiKQuaUVC2ktK?=
 =?us-ascii?Q?qfNayYAwtMGMIlEG779fmgl02iRPennALr5xrQjdGlhXgi8xU9yYfdQbvKUA?=
 =?us-ascii?Q?Yp28N0igqoxpQyY0LBzKVDhiyxYCZARX1DKX/XarhMfZB7HP3xU4AHuswcfq?=
 =?us-ascii?Q?bvOV6RPGaWJ1l7++Exo/M1AoWNKExRQdRd7A1Kwr1ro4yvRiahoCiqwaFwSj?=
 =?us-ascii?Q?ls17bGhyfnT4QYnwQXeQBxi5QHD7egcFcHP01b3HrANjQBerkKoNaZrRSfBE?=
 =?us-ascii?Q?zDOJsic7lcL6NQbbnrgtEafirQ/xHcHEp90Z2ZBXRI5kXzb+TjAo72Bgwn9M?=
 =?us-ascii?Q?08xwurRI9O3DNFVxWa/xOmPPeV7La2aQilpPqWevZbncvt5X+wjsyc79+toR?=
 =?us-ascii?Q?NujHPQM/3yejN5t0Cyt428x+qf+gi+qluOW5tHLd6RY+qWgU7v7oe3Brbfn2?=
 =?us-ascii?Q?Rn1nKM69ua5ZlExuxlIupE317Ldyt3vDjwvXogErONlELiwRiU3TpUlY59eu?=
 =?us-ascii?Q?7hFCtdzfED0rQNoII7bYKEqQyitAvHIfBDrq/BSPxi/87dqur8aLs1AMXfjo?=
 =?us-ascii?Q?MB8trsKfWb5HcGEXc7w3Mm1aOMEGOOiKCvijPAzyv2EkXfXHT68WlTnhxCN5?=
 =?us-ascii?Q?XNiHOhclZ5/JPO+PqcEJPTJNscl8Ir+P8R8WBIwgy/bugZc+6hBl6Bf+wj5U?=
 =?us-ascii?Q?+w7fybKZ+QdABltOalD67wzU2xMPbW3k21zrkOGsEMqvv32SOmo0Sv27zVqv?=
 =?us-ascii?Q?kYtzmPcfSf0apNwJupRGpZ70OJQmAhr12AAKoc31Zk0FJBn0FF3xkQi6JBKY?=
 =?us-ascii?Q?VUCeeD8gqgWsUXYwlZm64OdgQzGv8aHqfwWtzea99pMTAQMzM4wFsIxzCvlK?=
 =?us-ascii?Q?2QwCVnCaAZp7l9jOUXh6cTLtfQVSvi6rLxD5BgjHNCPEzzRiMIqF3yELzj3B?=
 =?us-ascii?Q?iV97dS2KLWyusWV8RP4B4txFED9BNvFT5R6kBEAwrk69lufNUjI0OdiPRUAC?=
 =?us-ascii?Q?qrHE62IXjMGG1n28WdTqkyQqZ3kS0WPtWT05pENNWHoGyPhZGpi6prvGsFjd?=
 =?us-ascii?Q?MWEwPTG9H+uxJlJfUwe6EgwPYHb3o6Snnc7UD5RIp0f75wif3Dye7uFFt4d+?=
 =?us-ascii?Q?Qsl6ebDyYXg67Z29w2t2br+4ACnG+IGZW7IX+3UZ7zbSOl0qa7jhokEBUrXP?=
 =?us-ascii?Q?9DfBVKXknqyFYkjqMVFhwMkBIKziYHtrQHDV9mV8V89pz+QZSN+W+tDEiwsm?=
 =?us-ascii?Q?6pv8m6s3/nxP8CUdKUMvUjKuECi+waC6BoVsOfSc/9TURONMmtgXGm+FGIvz?=
 =?us-ascii?Q?/pqbDmFyp8bNWIzScB8jgA+zdz2WFdgtpvY82e3WrAIqq9IzRgCZ5kTDgdGQ?=
 =?us-ascii?Q?ebxoyo33ku3B4qbs6oXZfYY2eItI8/BSVrJFhc45r+wqZ0iojgeqytxmVu6L?=
 =?us-ascii?Q?yhR4+7h8uAZH90j3wZS4S0iz+l8ghTQ9b3br+TEvVPvfzUy8IsQDw45SoFmv?=
 =?us-ascii?Q?5z0MYrFx3btz2UHYP1RH5oJQ/5HFtW+1aKJTDG3FPtr2evhIc4PYlnCAf0xX?=
 =?us-ascii?Q?GR+8XCcaPe2nOW5qEP/sMMvHgkw0i3ZmbTiXfbg2OVRGfbYeldXE8YMQlqdm?=
 =?us-ascii?Q?5dVfjRfBfjWqNuK7nJAxyQceel2/wUoxBdeacp6u7Pl5B/EJpU8pDcPybyUD?=
 =?us-ascii?Q?Kj0U31NujBj6tcHys8CAw1oZvPx9rWCP7gXWU5DYclTxHK6zHGSazwKuwoEC?=
 =?us-ascii?Q?n0WMSZ4K9KvrbHkOGI1wh6DYn633i5U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a553e1-4b52-4116-fde1-08da4955670c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 13:47:17.8017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyfrfBddsI7fBLMNIPVjzTEEuCWTTl+mtRqw711BX37WNGGnj5GqzqYHbj4n38oSD+MZU03Ypj7R8JeGV/yJCM+awm0ncN3j0Ab0l7Jpnqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1426
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-08_04:2022-06-07,2022-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206080059
X-Proofpoint-GUID: vHbaqNjvK-wvtVrDT_THMwDi7FBebQxr
X-Proofpoint-ORIG-GUID: vHbaqNjvK-wvtVrDT_THMwDi7FBebQxr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The dev->attrs.irq_num variable is a u32 so the error handling won't
work.  In this code we are passing "1" as the minimum number of IRQs and
if it cannot allocate the minimum number of IRQs then the function
returns -ENOSPC.  This means that it cannot return 0 here.

Fix the signedness bug by using a "int ret;" and preserve the error
code instead of always returning -ENOSPC.

Fixes: d4d7a22521c9 ("RDMA/erdma: Add the erdma module")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/hw/erdma/erdma_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 7c6728aebff0..078bb1c8c9bf 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -185,14 +185,15 @@ static void erdma_dwqe_resource_init(struct erdma_dev *dev)
 static int erdma_request_vectors(struct erdma_dev *dev)
 {
 	int expect_irq_num = min(num_possible_cpus() + 1, ERDMA_NUM_MSIX_VEC);
+	int ret;
 
-	dev->attrs.irq_num = pci_alloc_irq_vectors(dev->pdev, 1, expect_irq_num,
-						   PCI_IRQ_MSIX);
-	if (dev->attrs.irq_num <= 0) {
+	ret = pci_alloc_irq_vectors(dev->pdev, 1, expect_irq_num, PCI_IRQ_MSIX);
+	if (ret < 0) {
 		dev_err(&dev->pdev->dev, "request irq vectors failed(%d)\n",
 			dev->attrs.irq_num);
-		return -ENOSPC;
+		return ret;
 	}
+	dev->attrs.irq_num = ret;
 
 	return 0;
 }
-- 
2.35.1

