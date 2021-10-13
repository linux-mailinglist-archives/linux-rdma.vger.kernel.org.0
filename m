Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0584F42B9E2
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 10:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhJMIJO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Oct 2021 04:09:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:60710 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238760AbhJMIJI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Oct 2021 04:09:08 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19D6vsqJ004215;
        Wed, 13 Oct 2021 08:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=EUautbiWsiXCaOe0xwQ33M4GiaUFA3QPq3hawunfnwU=;
 b=U9pwQKYLwicjLodMZepSA1gC66AFgZsC8CJPB/Zf7/JRThI6CjPEAe4665EUVsSBQNo4
 bSr1nk9043bz3PTvqWMjAs+ip1dzWPF5vPbf/RbBTrDCuPD1EXb6LrIRs6q2Gt7v1VNI
 bWUG29Jd91pW83CxN1/5kETUiZvpHsUAxzYh8tgZ48Tu55FxivWgQI088f6PSW0+2Nhv
 4WqUApsz1TynHn5jcAQhqFczCEY3pD4jIPlrcuUvWztOJy1htP2WZst9s66g2gH7rnoH
 IwtP8NRD0LuKJ/NCARuLZhEMwQwooIpacAf01vNFWld0UDQgELIZueiWKi8VDYFwetVf Cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbua8fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 08:06:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19D8598V062322;
        Wed, 13 Oct 2021 08:06:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by userp3030.oracle.com with ESMTP id 3bkyvabwha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 08:06:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2p+U5BYVW7M+JR2TutA7nOUQy1PEFOQ+YFnbBlzf8oGYdYapYjlHy7tmaBUkVFAVff1KqI2CKx6jz/c7QjAVFKLkzzY6NO0de5ehlXBY1D+s9XOv+yv1Q0iepMSFOxhwd1DaDqA7Yp9ctO/gHSAZEYvfabGLMLaMWN2sPlPKkEo9CG9UAHo2s0dZsvKByOcABWNY1PT0qTGoMeKfqnXQH4EGVXTGmFN/4lQwU7Ze4FeK4IbDfaeV1sFpcPUaPHq2+s5xKj9s5BxIOGfLIe4z40ixeA45w8cFzvOcjZRB3+VQGIzaRej6SNYLp8z6gVFWZank8sUnqelVuRt9j6uzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUautbiWsiXCaOe0xwQ33M4GiaUFA3QPq3hawunfnwU=;
 b=h+cxum8Be3WKDdqmEiqd4D9LglHosPJgdVMbjrNc0L1KLuJVR3iwj12AGkHK8hpBlEoDlHYy7hQUgx3XfBCGubByUv9L4l+LNfahbYBOsr/UWtPTWN6jjhT/XvRGFo4esRL1Nymo1sTGPzem16GiG+/geYM6eDpVqk8uh3S3UOUClFv9YAsMtYtONvXr/WooHteVX3YO0a1prLTDd7d/qlnf96sg5MaW9D7mWvFermXPEm6/1s7fnQdkhpTKVQrKYgyxYrrGNyuylZqnVjZDC2YPeo3LXOrTv7Tfg4JuBI7eGLegqTE/bDteSQrgvGrIDtglz0P0pHHBB/6qsXdSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUautbiWsiXCaOe0xwQ33M4GiaUFA3QPq3hawunfnwU=;
 b=Wdz3b0xpKxfEtzfoJhOGst0iHKqS2shN6Yu1QL/4WUHBjWigHIBCxIkXhD+c1Aiez832burrYwUS41qYo6RbWRYGyaanElin1OteSDSUzbdSc6I6CEXXAyMrG4QdRKBMwrzDW3j11BK5SC0TI1dGNmPLrZIkCj5VLlt06FQQC6I=
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4643.namprd10.prod.outlook.com
 (2603:10b6:303:9c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Wed, 13 Oct
 2021 08:06:55 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4587.027; Wed, 13 Oct 2021
 08:06:54 +0000
Date:   Wed, 13 Oct 2021 11:06:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Gal Pressman <galpress@amazon.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/rdmavt: fix error code in rvt_create_qp()
Message-ID: <20211013080645.GD6010@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0110.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZR0P278CA0110.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:20::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend Transport; Wed, 13 Oct 2021 08:06:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47ab0b00-2442-40ad-c0b7-08d98e206ba5
X-MS-TrafficTypeDiagnostic: CO1PR10MB4643:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4643CDF4CCF0E52ECD4C560F8EB79@CO1PR10MB4643.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qB51buwIw2kg6Wjp18+QV8/HAkNzfjIfQRdK8Yjbu5AeU0V8RfaA0G9jVVFC/rkvwUkrSho+wz4ll7RJeZWI63b0Sfp3OJUMViYVHsj/GamAKa/6Nj5DOsyNWAmpT6zTGCQ9Ae2gQSDniPI0wYEmgc03xbit2HXKCD/vR7zfggEdkS1qK1tJ6hcM8yt3dReb4XY2iTHTeRwwFlr7ICAHXPK1Q1ZtZUBRzbtpiS+MLpVZhdhHGkd3d8GdzjvO7c2kERYZ4KdCg5uXZ7OqdFBZQjKL89Aiij2CUEcIVe8ojV0RCofV4KZXmhLjP7TnzsBP0nqdCA3uYZsRAPqd9DpG6cW3krS2hVzGLCYx4Klq2UzN75mICTidzrLnUlzN7blvv5KZK2wCnelX3uX77kadZIUv9nk6/J0/iUUuS/OjhMsVVyXwvDyJBJ/7GOpnBF/B726jk0i4/LPPj3ADRRkU3Bp/QBLeULO0WVi6fzS8WSUUa1ClbfF0jk7cwZvrSMkDCdbYwtGdIRNVQjrw5qtVTLk0boWd1oVKGI6neWb/0e05bUN/WCUv733AtV3KpFd44IreKO++L8xWlrgMW5fgRzgBGqNcS+c3S2NKO7pzLdY+0afwrDWzEVjiSTeliKPtT4BJOO6+0C+iz80STV4irOfxNy86y7IRHyVOYsu9qaLjSknr1Y8tni40H6jZhhESkZSUSKaMTz8slWAPHc/+rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(66946007)(4326008)(66556008)(6666004)(54906003)(2906002)(956004)(38350700002)(33716001)(6496006)(38100700002)(66476007)(83380400001)(186003)(508600001)(33656002)(1076003)(44832011)(4744005)(8676002)(26005)(5660300002)(316002)(9686003)(8936002)(55016002)(9576002)(110136005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tPo3xbsvuw7OFG3xLbOW6tTv5SLwX1y7sbjDNKYsn/mtO7VqqV8OiiHsQpXF?=
 =?us-ascii?Q?VWmZoBIb0WrD7P4rb9o8iF+TNl9PunEU2vfk4t18t2nouhJ2h+h2/8PTX4Qg?=
 =?us-ascii?Q?vNRrdZ/WO/K2FPAQlSIMcPSFrJ3kCrzgLZa7VBsw9KO/EQA0dMHtn4z5HZ0R?=
 =?us-ascii?Q?wKuc2bfG2FGAHpJ4qJgL3DsNiuyYln0+p8Sc+OX8ioenUmU2DCDroaLMZ5q+?=
 =?us-ascii?Q?B7MzWexe30VcDizjLaFJAY2WhxfEGM+f/DUmvGUojpGLxPYLNEERvWy/fs86?=
 =?us-ascii?Q?Sby2qcWTNNnrImUXzFYa3IweMhT9V+K2/WWA1bZ+zEuTyeQuxzOJgrfu+oBt?=
 =?us-ascii?Q?9hT+gRPYIrune5ZbSRk6tbDCd1jRKFng1Y3bCp1Pdo1VBziq9X8trl6L5O2J?=
 =?us-ascii?Q?7buaSWeT3HnBVZxDxRsXRD0+VxSnA0f9G5mEQJrEbQU/DXLGWA3dFmx+VMfk?=
 =?us-ascii?Q?2CnfxkZ8HedYR3fuI0muNRH9PDWcnqky9NYcdq+ntkhoHx2No+Jw7TbU+tg1?=
 =?us-ascii?Q?O/nsx3bLDUPisMMBY4WzqtUnu6XFtm7dWmiewdpcbI32FmWGUnYTkvY5Q3g+?=
 =?us-ascii?Q?JTFSGvDST+vIYdILOEZM5cFSSAEfJUJ44rXfqh3LlVOcBbryKC4ghM7/+CjJ?=
 =?us-ascii?Q?mD/Y6cxYdaP1IAGtm0ASv4m11vjUH3QfBI78J3FiUeCK1OtE1sfbNK9Fwl8P?=
 =?us-ascii?Q?nRRjlnQNd6loVyWI+OWYRfFxX10cwULCssA3NrkRuF+tFV+qAuaki3+kI5d1?=
 =?us-ascii?Q?HwceEu6DgLFce2n9f9YFY0Oru50bxtC3TVWb6LjkaIwVpD2/C1lDpeDxH7mk?=
 =?us-ascii?Q?BxTGzuDKvBltP41SC6iia2ct33oAzjxHdze7UF6zSU3CQiQfNcG2NlxczbZq?=
 =?us-ascii?Q?CvhpcyB7YUfStC7Lmda7yZC9n9F3cQgHfDgbBN4IpRFB6Qw0gvdPDK52l01n?=
 =?us-ascii?Q?9n71CcTJftPSr5AqIbW8zxIgaCGmFzZS+SlXFanTY63ZnXDU8lx4WGJWnM/b?=
 =?us-ascii?Q?9D9nFMM8tAslhhs5nr9R3RAyVQBsYvsXaMSvzZ0B/E3iN7Vs1w2nIeqlFQri?=
 =?us-ascii?Q?oC+cjhF9P5klL90qHLmMn5/w3IGVF6qIMYFramcfMQ2fFNCE806l3b4ydqXr?=
 =?us-ascii?Q?E9r+dRvSTr7pQT8KXiDAz+6mLyhlUhsArGQ2K03mqKGwRiytX7cobJLsn4nY?=
 =?us-ascii?Q?N7HoeWKQB1KUGYbe4EkxUim1RN9gv+kESZeCuAkyelDBoJ+A4Yvs/G42c8vp?=
 =?us-ascii?Q?3AP6a1ISisZHXYwOp69eyErubCpkExF35BxL36MsNzbt7qbsYtKR6NeitH/7?=
 =?us-ascii?Q?mr/KSBHNkMjVA2iBBpWQQvd6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ab0b00-2442-40ad-c0b7-08d98e206ba5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 08:06:54.8606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpuAPzYpyBbRLb6PO71mPjZ6aPl3KnjbIobYWvW0qiHiPaKfv9jHQE/5PF7E6XrncNnA5OXuosKUY38YmZXhi3jKYk5jA8vdt3U5tqWZESU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4643
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10135 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110130054
X-Proofpoint-ORIG-GUID: VvAcpkEi3oBDTe-hHzl5B6rjs0evxiBU
X-Proofpoint-GUID: VvAcpkEi3oBDTe-hHzl5B6rjs0evxiBU
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Return negative -ENOMEM instead of positive ENOMEM.  Returning a postive
value will cause an Oops because it becomes an ERR_PTR() in the
create_qp() function.

Fixes: 514aee660df4 ("RDMA: Globally allocate and release QP memory")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/sw/rdmavt/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 49bdd78ac664..3305f2744bfa 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1223,7 +1223,7 @@ int rvt_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 	spin_lock(&rdi->n_qps_lock);
 	if (rdi->n_qps_allocated == rdi->dparms.props.max_qp) {
 		spin_unlock(&rdi->n_qps_lock);
-		ret = ENOMEM;
+		ret = -ENOMEM;
 		goto bail_ip;
 	}
 
-- 
2.20.1

