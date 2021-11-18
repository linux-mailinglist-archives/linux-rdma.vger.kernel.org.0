Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B3B455AC4
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Nov 2021 12:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344078AbhKRLoI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Nov 2021 06:44:08 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42890 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344051AbhKRLmo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Nov 2021 06:42:44 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIAfUkX020985;
        Thu, 18 Nov 2021 11:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=+vQj8dV+IBlhr1+fqkdhvP3u+m0p/R8xFZ1QXBau0AQ=;
 b=JrFvacU6SxOce6o0AT8wgfoRMYJ5ZXNWwHyLUXt6YuXZzXmgjHPnHvrY41feqR6yXgmC
 q4J2ZjhfKy+EGR8HN7HsIZOEya4VwCGJXmYpPTpBLsHUerYQQOPC6vKyFedRb/wdCU3g
 qBcH1qDujJpp+R1cuYqNF5f1X/JosDgXiJpjsJqTdPKkUyN6Fcxe8dLJT4msN0hQX5OU
 wYhwfyeQ2fqmbk1ShX9K7nr04bINBYmhcNSvzC9tYSLf3SoUoOhoBn3SdB3W+GtYNd9Q
 bQArnSQbvamZ7IqyzeOBjsp6MgMdKuk0/VDuMM65R8b4T+f8tEaJFe4yHr+bZ4/o5js4 bw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd4qynn6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 11:39:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AIBUZV8120579;
        Thu, 18 Nov 2021 11:39:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by userp3030.oracle.com with ESMTP id 3ca2g0c3hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 11:39:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQzhCiwwy4N36iuP4ZeUNlMF81I+9bXauIFeUoFQyG5/lCFJGmw6+RptBdgR+9YNKgMBgfbe8QTmiF0uys1IMVn4SHolMeoZco3fh/s2jG1D7Pk1ESQ2IzsuvAhma/+pjDbXa/BDMzE1/HNHEEsarjfl/CTlsbA/P4h8ZCj/FVGTFMyDCqMcIZRurb/2hjRQm697KjhaAi9IRpMzZBYNu+mem+OYiy6X7oo0rlM7SZ+3VTnz/myuMpHwBvBcwylwR3dhA2hdtjD9V6Wy5Qb8efugkghd41HA5w5bUmTbPOjr4Iz9c7X6CTgA5rYXwc3a48LwzT4qiPFkoiSoUN0Wlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vQj8dV+IBlhr1+fqkdhvP3u+m0p/R8xFZ1QXBau0AQ=;
 b=fz2HLDTZ93+/4mK0pAQe3XqpO68ES+NAFMYa2E3iyHuLDSz9O9Dg+V0TaUrbOqlnz63TSvIqmQSdlXquso88OfIspLFdijQ97RBflDL3HpCCHx5iP+Q371vxlxZja2+V+9Uc3/w9Ch0733S9ovtOvI21EOK5370Je0rhUH5o5FkCquoLSQGeqcgsWhFEV29xjs9MarwMBZXspCxKJ5GFUFzUgW7eb9kO3vIiPpmp4voUta0oTYw8o4MK5Da+DQuNMkYuGSt08723jpWLBZvCTakY2CaraRwTOxT/Fh0j3krUYg+SBuFXKlzoQcm0RY3egGEF0KBM9912BUdJSWMApg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vQj8dV+IBlhr1+fqkdhvP3u+m0p/R8xFZ1QXBau0AQ=;
 b=kRMBai1ElIR5LqK9CBhfvPdx806WHGYIMweH9Z8sHQGUwyfEOA7DZ4xHAI5OrQNzQVnnUaqblm6ZVsfbRHWfs0AXATyZCBtPuuqMRlt/AdPvCYCf/VhsnrtQYdCA5Tp2e7mh/qZrcCdOS9SR94KqzSyH8HWvEbQvUvqA6Oaa8WA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1823.namprd10.prod.outlook.com
 (2603:10b6:300:110::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 11:39:36 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Thu, 18 Nov 2021
 11:39:36 +0000
Date:   Thu, 18 Nov 2021 14:39:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christian Benvenuti <benve@cisco.com>,
        Upinder Malhi <umalhi@cisco.com>
Cc:     Nelson Escobar <neescoba@cisco.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA: clean up usnic_ib_alloc_pd()
Message-ID: <20211118113924.GH1147@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0146.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0146.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:41::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 11:39:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba546337-ecf7-4c56-112e-08d9aa88193e
X-MS-TrafficTypeDiagnostic: MWHPR10MB1823:
X-Microsoft-Antispam-PRVS: <MWHPR10MB18239FED9631972CB4F620378E9B9@MWHPR10MB1823.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g5ufWxThXr6peSIgp+LpLoV1dEKsz9xfY4hmgUwQ88Rvaulr8FiouH6JVej64kHLbwsZ3prCh5t2+Oj0XzEmo59KqT/VVO7fle6ZZH8Vbu0w2EEn6pOvXJzTKU1T1/4DUyO4ka6WBZM8/0wx6v+lEQsASvQ3uIjdNB+uHMF+I3jrzthuZjnHYCPD4gttZC1RPvs5UPpEEbAneI0xisZQFbpRin40vlhmvl5xWyymoKEs0zpBg63ik3YDd1xynL3vangiAOJ1jiqIegnt8AzoTdkfkYHqGRPCO2kvD1+fmWMzA50OghM9lFQK0C9KPgVq6yVR2YLJYv8H7yFE5E2+RZiwIj5aIoaUGzV/Zo8PWv9HfN1+M0tJr71i9U9BRDzT85k/Hw3JfApt71rIrzvL6RejMCRo5W7TeXM7clqubd5r/y/d1DM40YY+4TZJ3MnWlLpFmtfXn/huV0ZgM8EUMyWaAxx2doI1g0XqqLqovacIDd/l1jonQCkcQaV+9WUAqORM0wCR+JOUZ7SRekx7JmhAD1c3uUUVFN32RT5gnPscOH5p54fAksATqbPlxt1JaWsDdhBKKymMTcjuyCFiPRFUeLABTRsq4BlwwxgapLESunXAMp/6ZeHOfif1x6eEv5GX/cqhu71qKHZ97NX1ei9SijKS1wMo5U4a7sa4n/TSIr8rP6Fz9wqOH98gdDv10P5G3n8PJe/xEdNyRKwiuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(2906002)(44832011)(1076003)(6666004)(52116002)(6496006)(5660300002)(4744005)(186003)(33716001)(26005)(9576002)(956004)(83380400001)(54906003)(55016002)(8676002)(508600001)(66946007)(38350700002)(316002)(38100700002)(8936002)(110136005)(66476007)(86362001)(66556008)(9686003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ic+XOOgPdUx5/xvVe6CgfR9lghH2KcF196ZopKcY+ImzJsQu79NSxsdF7ZaC?=
 =?us-ascii?Q?JNt3JK6fN/71sekN1gVmWJUDDsw3JKmz7khAcW5y5div+3WiaN97j5FJOFwz?=
 =?us-ascii?Q?29EdG20JRUpvurR3sMPob5HrB74fmOswHCJgYzzvBVVHA+miIGnu+BTnIMUH?=
 =?us-ascii?Q?hi2/uLjqTH4AOJUin0eIgYxpiFEu94J5pNJsipFd68E5gnCt0b8Qwh7dzri2?=
 =?us-ascii?Q?BqK10ggHg0tMU2ee5iXuMuuZca0tKrnvs9S2o8LYShvoKQhhEqnESJPRLa9A?=
 =?us-ascii?Q?unEMqu9iSDyImtp7tM0QT2jzyMcU+zHnvGX1q8dgyNgsMwIfpTDzke8EZ7Hb?=
 =?us-ascii?Q?6ybSV3ZeL8H3AQblDIUork18vaoPNAxuNl/K3E/nNZAfcXoti3cpSqtJN+M+?=
 =?us-ascii?Q?+285Oyg3LP9YyuIplCMKA/z1j1ExYjtORJYXhqrn12cFxMOLdXwsHcyZU8k6?=
 =?us-ascii?Q?kYEP31LFr+Q+v1ghrRsiwE/JKI/uPQvSN386Ofp1hTh9qJGc9pH5t1LiHaLa?=
 =?us-ascii?Q?0o8eHFrhqg4klq4jHQsWEc9BaaiPhrhdek29CEffe/4nFuEghGkOTBA2OVw4?=
 =?us-ascii?Q?vCJAMZD5ebUZe0hHvg02qHtwmaPX2QZf13xC3vdi8Ahvd1OQEralkFLApWjK?=
 =?us-ascii?Q?KuLSsFriK7EhCRg1sEOciMXdSgDF0umpyfH5/snwGeQhyWiSh4TgoAKke5Ls?=
 =?us-ascii?Q?LWk4dtpdM27K6boFjK6eThUyw+iK1LJMc3jG4zz0UeNvFX92sfMCu0zRvyv+?=
 =?us-ascii?Q?xSjF8mfRmlIwk/0KZBORSG7NVaNVkg0UQEfxEgLucsnPzTkbvGwCrKN7RkU6?=
 =?us-ascii?Q?bCoTKBim0b3LnOAcEM4O+8ULGCEAXumoMYfgELAj6HqrG6kNrR3+Jo60zdN7?=
 =?us-ascii?Q?ZkG11ImKppFm08k06FHDz4n/2aSf1dgSCwRKzxvCrRVMK6DJ4mdZhkPtGri/?=
 =?us-ascii?Q?bGrPc56MdFSOMrqsy5DXONBWssESEHrV2eIWnAQff1ZSPvjW27AAqQha261M?=
 =?us-ascii?Q?uvFtj2K5pIk19Nn5XC0O5cCnSA9F1mHTMSsoWaiy3zUsJBxXnB2K+9+R4J/t?=
 =?us-ascii?Q?AT3YVzdvxeh8kKGcCRtYedQTIz1w7l+HGqpHk5QS9PUIWgdYmhb4f/gOP6kI?=
 =?us-ascii?Q?uvAMJ1j2ITlkjU+EK8JfQHS8F4SvpBhUs5u2gJrvCOBeqeP4MoByYpvvuure?=
 =?us-ascii?Q?/G7vVTHfEKHbNC9HKsyb5RPd2iNMMtUuG7ekArEgsVRl9VuJKScwabd/FIk/?=
 =?us-ascii?Q?DS+ol8z3zwtapLJwS9/1ZcZRH8Kmi4ACBdxb9b40kUPn3zmG0dzC5d067g/i?=
 =?us-ascii?Q?VOneIqHAaCcIk459Xvt2jxWnwXst9udzzYeB2cKhU1sd9fFt30RY7arCjoA1?=
 =?us-ascii?Q?U0hqKa5bh7fVTtc2zBZ1H5w6tSBRCOsaqo1XA5gr6oL2k8aoJzbCPziGDK7n?=
 =?us-ascii?Q?AubDi8pJEg4x03g1Aijw9moKWUdBtt/BUz89K+E3LpCC1jlszjwO0uPin0O2?=
 =?us-ascii?Q?GoH6Yg0DDEz3BvAVMnZ/VDwB7VhjAmAEp8DnM79GZCQ6vhtKiTccfbRZQZIY?=
 =?us-ascii?Q?9tfY53pFSfuwlwEQNwedwuRN8ShoLmrLHyOG20RNlvLXfbwdlf61V25A3pGW?=
 =?us-ascii?Q?4cZXdcyWwz68kcchhE6SGi7Jz2OX9H2Bp27If5EiBznb73Cyhq41Y+hJ/nCF?=
 =?us-ascii?Q?hbmVqR8pSqMkCP5HfeBbv7HkvEc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba546337-ecf7-4c56-112e-08d9aa88193e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 11:39:36.6427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJoW1UJOd2WCcbyArtrQLDV1peBmAiMRMcuie0jttVskkmN8HpqfhJDCNF0uGLR0aMgwcNm1HPcVy1vH24LEU8zgtAKW9wXmVunYD+h6f38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1823
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10171 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111180067
X-Proofpoint-ORIG-GUID: LmCY2BJgNPelkoESCG0FwSgdTNlzBFl7
X-Proofpoint-GUID: LmCY2BJgNPelkoESCG0FwSgdTNlzBFl7
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove the unnecessary "umem_pd" variable.  And usnic_uiom_alloc_pd()
never returns NULL so remove the NULL check.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index 756a83bcff58..5a0e26cd648e 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -442,12 +442,10 @@ int usnic_ib_query_gid(struct ib_device *ibdev, u32 port, int index,
 int usnic_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct usnic_ib_pd *pd = to_upd(ibpd);
-	void *umem_pd;
 
-	umem_pd = pd->umem_pd = usnic_uiom_alloc_pd();
-	if (IS_ERR_OR_NULL(umem_pd)) {
-		return umem_pd ? PTR_ERR(umem_pd) : -ENOMEM;
-	}
+	pd->umem_pd = usnic_uiom_alloc_pd();
+	if (IS_ERR(pd->umem_pd))
+		return PTR_ERR(pd->umem_pd);
 
 	return 0;
 }
-- 
2.20.1

