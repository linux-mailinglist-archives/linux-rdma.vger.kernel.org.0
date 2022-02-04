Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6074A975B
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Feb 2022 11:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbiBDKB2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Feb 2022 05:01:28 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42244 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231847AbiBDKB2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Feb 2022 05:01:28 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2147eISl004636;
        Fri, 4 Feb 2022 10:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=YsdA5RAXUxSpMh4O6z5JlNzQC17K948VmgRb/UMIhIs=;
 b=a23JpFu//YkvkAXGT1PsbBkFHNTpTfvzCXQqH5Uhe0lnztvkmN2hJ+DdF55PP8+CfwyW
 D+ILbmpzKVJ3ajvBHPOHSDTcRUZ2Nt2HgQsgBq5Db7j81Do+79Fntarxn1O/2trFH5dp
 eckumDAamtXTjbrg64ZStxiia2GLC5TXN25uIByNXuR0LjV7kxgCpjmU7dqktxbwHcpi
 0KtIBn16nhUQS7lsYitKxxJ2ANt1/y75vLvRzdpeYKUhOHpamKIvDPSlMeSflCPRoBwb
 QN8Z5q/CAJjD51DGD/KBTZsoCH86tjw+jIE0AhJW9+b8ZFIWCMirHAHB6pv6mVy+9/AY eA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hjr2abr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 10:01:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2149tK44108367;
        Fri, 4 Feb 2022 10:01:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by aserp3020.oracle.com with ESMTP id 3dvwdc2dgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 10:01:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9ToFX54yYLbJ6N3Ot16NDti+6f7Zskhzn9aFUMkwqDk4dX529aaQgowRjVbygXAL50DjnAMHscnCCQsyTiNtawbY5sL1g6q3ZzxCIfKDHqv2qaY/IHyFRMzdaU9ELMY0HJZVqbS2jRimhy3f6cGnuTRi9Lpxcfx3YUaJ9355ikPJD4EZfnMKKHnfIgGtOcGT1BwIvQH83Sl6sJFO4yxLH/nTaAouJOBGsojbingUD/U8lXXjePu2EOJZIgHQ//VCwEcelO8n/v1MHz+QdpwsiNS6w0B+fP7TngFCNviuiuErR8hm2E9QG5zKhSNGKBCLjwh2phLs1dqkjPXTwkXLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsdA5RAXUxSpMh4O6z5JlNzQC17K948VmgRb/UMIhIs=;
 b=XlHTFovF06721+PHq63ElMc0Z4+PRXqIUYiHKjLPksemyHR44SPFsPtjeWmrw4XCCtEDeSkRjHcTkGFO8vNHY5aJmJydijZWc3feru8Y39o2EL3UcnjnA0i9YNAOpiAa+tFm94jtpaRi3yKN8aWpu4WmSAJq1Ev82cSktH/4g+sa9I9/GYE0ejFuSWPhDmCwJ9biv/kjUxuIoWwIRD4HTgkeNWxvqWO2QEWTRYrBA95b/rt3HBkisU1aVUGsk810gXcQi0wT/lU+MjNgwMXT+dxL6tGOOcLVH74MBYf7J9XBwQLd1Uayjbc6icLRxtaJJXH73dpN6inHxv1rhmBBqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsdA5RAXUxSpMh4O6z5JlNzQC17K948VmgRb/UMIhIs=;
 b=mTmfAlpgI361aIrqW/LkBZKpuyDUSMmh33SxHLeUXFYf0LrODp/2bmthOU96A7buLg/8axTm9/iP3xUfVb5S+fo4Ew2zejEoomjT3UB7ugDHiLOXMQq4QL6Vh/EnXifScvKpgHu4874FynAl42IznZGEQMja6RpPSPp7QYk1jJk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4482.namprd10.prod.outlook.com
 (2603:10b6:303:99::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Fri, 4 Feb
 2022 10:00:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.023; Fri, 4 Feb 2022
 10:00:54 +0000
Date:   Fri, 4 Feb 2022 13:00:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Haimin Zhang <tcs.kernel@gmail.com>
Cc:     Wenpeng Liang <liangwenpeng@huawei.com>,
        Leon Romanovsky <leon@kernel.org>,
        Weihang Li <liweihang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Dasaratharaman Chandramouli 
        <dasaratharaman.chandramouli@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Don Hiatt <don.hiatt@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-rdma@vger.kernel.org,
        security@kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH v2] RDMA/ucma: RDMA/ucma: fix a kernel-infoleak in
 ucma_init_qp_attr()
Message-ID: <20220204100036.GA12348@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0160.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a15d4c44-9e48-430b-1bc3-08d9e7c53b37
X-MS-TrafficTypeDiagnostic: CO1PR10MB4482:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB44826A49E329C0C3A36898868E299@CO1PR10MB4482.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f4SF86tutJ58gcR6s7sGVHpa2OvDyuQPvBO5+SIoJ1ycoISfjpmO91+m1TF+6O02+1J7qopwGnijwPjHn66AvpikR+d26QIMPkUZJXxBALQraaNbjDIJ3BoN6s7RXctmQ6SmRg4ROkF5mX+DVz9K5bDn3ZRKKKXhirS+aVi9eWE61FIuQ0W2d4+yltr105g0Npz/a/xF90VnidqkbyOxIHunSE7kmWbsYOK7Fw+vS7v9rm52Fto9DQl4+p/IEuWk+g4WU/U64lg8zvFX6/MiLxY6W9v9WtTtBI5JILulbxFmj/6eWcnqocMwxcdy4P1rmqTvKyVUHx9nhFjHtpvft8U4WMcCMjr/UKbAnt0SZ51edCxMacviP+2HA4vdjyFFFCNGQBi9gEzWXjQTyK5Ozoxy/y6IPRctNLHlV3siSG9CgMYXzJWiPJ3RSG5sBa2dYsyXiKE4kZlEleALxZebVXQ/0s6lP5ZHSOvAVrVDXmaZXfgisLElwI5HHBqmAFXNQI+2BRb7RUEPP1QA9LUIV/ugLpEUwIZ1/sbRhKG9s+c2tsq1cM+xvxf8MbqqsfK+C9TBs/oChZcCAAsAhv1ZR5x+uCOP+RTRIHOPIPl3bPASSJrQZC0+ZjKeUb05VFCrIriJvUDqY65Tkzszwz1OjE5D9fwDoFVKRNZOFzR7CjmhI2PW2aNaLcY3o9AhAYNFlupDkznzEljN6b4xXAaUxFhtcl9mObZt/F/sLjUZdcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38100700002)(38350700002)(7416002)(44832011)(2906002)(5660300002)(66476007)(66556008)(83380400001)(8676002)(8936002)(4326008)(26005)(186003)(6486002)(316002)(66946007)(1076003)(33716001)(86362001)(33656002)(508600001)(110136005)(52116002)(9686003)(6666004)(6512007)(6506007)(54906003)(5716014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PbAJUqTyV6ih6w2esJ4SOVwlzIiIzANjT+y8TDG7b2cXB2Uqih+aeEK9URji?=
 =?us-ascii?Q?Stbe3DP0TojHlqQwh0P7om2Gr2CwXQHoZfmdpsqAQn639Z03QYvNNNe1i3no?=
 =?us-ascii?Q?HBjG834dpy7pmuFREIo39udS8Q5uJ2N0urhDrabYSjC491IoV6XSKDWmq4Zh?=
 =?us-ascii?Q?JB+JIw4ZFuQJBzvLDqpRSvHeoxCLLXoF7VAT/X+DlmdMyO0b5dbuScJZseNc?=
 =?us-ascii?Q?V2nz1YjbmDB4J5fMAycDGdfBfgpliyByLdUtToS6OnEJ0EZgAmLASR2+Rcl5?=
 =?us-ascii?Q?nPpcNIuu9Wcem5R4BTcf/Ht4FfSZlvOz8teSg3I+PFkUX7+jU0A7Dy7MZ3b9?=
 =?us-ascii?Q?O/yPm3S4LT8lszOZ2IBpAk+s2MK+h8dopRGKkpOAfqOi27KaBS8SZ66y/cbp?=
 =?us-ascii?Q?5rjnQbEZBsPbdnVEElNseiiaySoxM81QtGBLxPt1sPJGNBLCurORtWAA2y+u?=
 =?us-ascii?Q?wU5CMF0LKWIs5VH2ID9NDwJE4dWB00yjT5u1YLwx/ylouMvSauP3wszqfNXv?=
 =?us-ascii?Q?0efESRQlpHNSecXuXTcvEjQ/NQQ25RQn6/3z863v2kPw2ZSu5w8YxNgm228P?=
 =?us-ascii?Q?TF9gDewQp8/V69Ud2Pv060er/o0hLDFmuOH43aakbG22DsmncxtEuakfKOVp?=
 =?us-ascii?Q?ez7bZQosm0JLl9+uFn/eUOjJRA33LPVqST8CkyCEaVpDvWLCjVJvrGk9e3iA?=
 =?us-ascii?Q?8UmEgn0TcmUEBGCQx+4vLlYdV6mZHHAsNrRqItrM6S5T67qcUSRmrtPlQ/5i?=
 =?us-ascii?Q?M1i1J4PkclqBAf9NCs6nrmvBhRxW9V1hrr3pU3GF6qXKWFrBceBlKuqItE2Z?=
 =?us-ascii?Q?eM2MbbN2k4Fc0UVnv3pbqwnTsOZkJOMMtJNc1bHMo4kQsVAbLt9UCtQ/W4W4?=
 =?us-ascii?Q?DXa10mEZuoYz7RvUE44M1sYcp6+5O1UGJ1qMMzAAvipaKeCtpZDhfzVlXOjt?=
 =?us-ascii?Q?WV1Ar6NLCLOaibw5+Kl1CoUHPHwaV0PFPaictqtOGfzXNSKEB51hABwmd+q5?=
 =?us-ascii?Q?XyLdzgmNOxs2yTIIg/Y3YcaSXKFOI4Wts+7znh354Na4ELV3ALhocnxJdMTt?=
 =?us-ascii?Q?wXa3L9DhiJ7tvYWjbyR3gBzQ7g1fYPsTkcMyRvfvHWo6vjfB7sgMqAt4pQsV?=
 =?us-ascii?Q?AKG0wZWZJSqg9NuBEdhfUfKi2UcfOVFp+cEhEx7BhKKBJnBGvi5pWdJ6cdZk?=
 =?us-ascii?Q?lQu3N6dvwqM0/zOItu3W2SefZ9rqcuzJ6+D47W0keAvrljS8BqwqvPhNEFxo?=
 =?us-ascii?Q?Vikv1EYhjRFowg0Sl1ItzRun5f0yx+8KL0dz3hypbW4yyhhO4Aa0bnK2hb3H?=
 =?us-ascii?Q?sbFSC2NRF1BBV7wuPDRXSSMNUBpLZcosYZzf5KW2e7eUM78Mb4yFQ70w7wdM?=
 =?us-ascii?Q?2QQG9ziCJY9dOMVKbGnIo01/q5yJW2ZRa8W2KwXiWKmTN7nDM894s3Ey9iqs?=
 =?us-ascii?Q?zD4AdGG1j/pP2PWj+RO/QFTBfPcdvecnoMhDdOnu+erF/nfpTS854JOELH8V?=
 =?us-ascii?Q?4edjd8ZhIJJXh0TXAT+RgsevF5r32niPzP5VWQxoY/uFM7JTTrhKrXUGbywJ?=
 =?us-ascii?Q?YkgVmnrH8fi7LEczPzQTZRGJFA22/aQmc+Z0bAcbXL2K2HtcUUxlNpGK5pZh?=
 =?us-ascii?Q?B7hbl2uLsCOJEwrSBsiqYtpCkbM5D7zAxrwAi2Cy2jdI+b9lrUbENokAOR8C?=
 =?us-ascii?Q?ubXNxJYPVmvYl/qlWSCJ1jY5CPM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15d4c44-9e48-430b-1bc3-08d9e7c53b37
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 10:00:54.0020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZD53FdyfkyF3YdsoiwzYU8a4Op57I5Mjh17jpW3kaI/gGaA1fY4odcwf60aTLuOaTroEcGrVCN08GMeic0n8es/zIbkjKJVSTpMKy4Po7Fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4482
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040053
X-Proofpoint-ORIG-GUID: OMlqdeLDiLf_dcey9PjrM9pn3OVLm4w3
X-Proofpoint-GUID: OMlqdeLDiLf_dcey9PjrM9pn3OVLm4w3
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Haimin Zhang <tcs.kernel@gmail.com>

The ib_copy_ah_attr_to_user() function only initializes "resp.grh" if
the "resp.is_global" flag is set.  Unfortunately, this data is copied to
the user and copying uninitialized stack data to the user is an
information leak.  Zero out the whole "resp" struct to be safe.

As a clean up, zero out both "resp" and "qp_attr" in the initializers.

[ This patch has been highly edited from the original that Haimin Zhang
  sent, so if there are any complaints please blame Dan Carpenter and
  Leon Romanovsky ]

Fixes: 4ba66093bdc6 ("IB/core: Check for global flag when using ah_attr")
Reported-by: TCS Robot <tcs_robot@tencent.com>
Signed-off-by: Haimin Zhang <tcs.kernel@gmail.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: Style changes

 drivers/infiniband/core/ucma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 9d6ac9dff39a..4b90ee14b015 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1214,9 +1214,9 @@ static ssize_t ucma_init_qp_attr(struct ucma_file *file,
 				 int in_len, int out_len)
 {
 	struct rdma_ucm_init_qp_attr cmd;
-	struct ib_uverbs_qp_attr resp;
+	struct ib_uverbs_qp_attr resp = {};
 	struct ucma_context *ctx;
-	struct ib_qp_attr qp_attr;
+	struct ib_qp_attr qp_attr = {};
 	int ret;
 
 	if (out_len < sizeof(resp))
@@ -1232,8 +1232,6 @@ static ssize_t ucma_init_qp_attr(struct ucma_file *file,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	resp.qp_attr_mask = 0;
-	memset(&qp_attr, 0, sizeof qp_attr);
 	qp_attr.qp_state = cmd.qp_state;
 	mutex_lock(&ctx->mutex);
 	ret = rdma_init_qp_attr(ctx->cm_id, &qp_attr, &resp.qp_attr_mask);
-- 
2.20.1

