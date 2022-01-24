Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F4A497F59
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jan 2022 13:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbiAXMZZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jan 2022 07:25:25 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20736 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239530AbiAXMZY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Jan 2022 07:25:24 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20OAvbST007788;
        Mon, 24 Jan 2022 12:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=r7hVKyeJoYrF//f+VRT0yR9CmegOuW8uMEw6x15vcR4=;
 b=JtOGhUGs6cjCN3Lb0BR5i5+M4QiWsIYKB4nouksGyssPCNAjI64npX98cQ8kTXx0EafD
 c41tjOSaCJCenmC6Wygbt+4iEpc/L1KclGMJUYdqs/5Ls2QOgdTmEd4SYQHOM/7kJlSO
 r/Rry/IwhhS/dLh6AxecbRM1LBGiCxUO7tH09bAmwOng7K7mpZgW7gtnq9cemxAHdXww
 jNdcW4+/bnuVrlYPLH+l2F8LzzRgWmecxJBiqvGZO6akAO2p/eDniFMLyuUwjj9772WU
 0yFTy2cZ66eXn0X6GepgoP1YZhNeOrLu5wiyKnGzbHr5gM1F4rNjTyBBreme8k6wSrA3 8A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dr8bdkx6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 12:25:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20OCGgg2180195;
        Mon, 24 Jan 2022 12:25:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by aserp3020.oracle.com with ESMTP id 3dr9r3v1r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 12:25:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJgsrV5h9lSHoD0aOb0Cui3Hf0UJvmtDHLkVjFpIjEZchlUF+1zH2P6RyL4gvX1bSy+hKdodSFcesUhoXNNcyhdT3PVFSVWUkZ7Zc1wagm1sQ6ivZmh4IjJ1JXQCDb7bKOb4XUdSUPYt+oh/E+hUZREYsYuK6NahY2VR3uA6Y4GOzbV2lqDFgpYePO3y9SzvJ4oJK2kp4E6MmuwZpoJPi7EDY6U4qMzai/d1YsjjlTwjeP/hraIEYyb3AAc4sA0luAv4aGtfwxj6Msn+LJRUxrPg3SCTIzvLtEVcBbQd7omXmewRcM/wFEfad9PQAqA2ymbHoYhAI47J+XEpZTb2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7hVKyeJoYrF//f+VRT0yR9CmegOuW8uMEw6x15vcR4=;
 b=cvSA2mLULrgcdmlyOKYyW7NPPQCxpFqTqatR79MGyhNQE2PqGUkIBsWt+iqDRNy4o+nKcLTOk8awkvpKtb/MBvjwB8qxb9w/TznkGkqx/k13hrsUk5rzUA3dxXp/hbuyt/E2r0Q0T9S/nu9z+m+A5uYIC9qMWZv7lzwc4Lv9cXD/Yt4hUwPIDhJfB/gr3kt0cPKry6/O1ftdIzJzbZapTTQCy71qLkmqw5Y/OJSwcq0oqRSHpQZ4BCZ5xrRpqGXh9mmYi/HCDbqPadrV0dxerhNUefsADkkQLROMDVUoB8S9kFAveHC0Qpl6j4MQnpWjBA5cqhyM7nmCGgYmBNh/7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7hVKyeJoYrF//f+VRT0yR9CmegOuW8uMEw6x15vcR4=;
 b=RALK228yduNLARp0M1VDGIhrBeR70iEuKr8Vi8SNM8HeRYT3QH2Hf4TbZRlPsqv2PdgMsaFAgnbtJ+hqeLhmgywUK9Y24+N/En5QcNL5A8shjKr6APPXa5no5ksm9eG5HomV/y978cux6OCo0bHN6e8+jXvDerjZ6GiWg2h/VyQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1734.namprd10.prod.outlook.com
 (2603:10b6:910:8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Mon, 24 Jan
 2022 12:25:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 12:25:17 +0000
Date:   Mon, 24 Jan 2022 15:25:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Steve Wise <larrystevenwise@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/cxgb4: fix refcounting leak in c4iw_ref_send_wait()
Message-ID: <20220124122502.GB31673@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0043.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e034005-95a7-451a-22f0-08d9df3494c3
X-MS-TrafficTypeDiagnostic: CY4PR10MB1734:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB173496D16786C0E1281525088E5E9@CY4PR10MB1734.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TmYJxufqehyGPTkmTMD7ZdirhdBbkxcQR6lblEEMvoZNkGEdKWknvqRU3QuBSXlIZl1R4s1t8LZjFF/1A5/SnbaeLWyCnm4/qT2g7PxQb+odIGwk+6aiMK/S+zLSch4pePhPNPyGLeaggKr7YZys7/11vmr0PAckO3ZxBRBaBP+xIP5uPEaqlP/f3o+L+80lO7SHiPB39ofNDJSQRmq+Yb7f3KozWVT+ua0wILIYmSsIM60UbJp+l/7FX8W+r7SNnQ+8iJlglXjU/pO/KlGK92A2Kk0ciVNlY6V356EISxOQLf+AV9owS6fAuAsopDyayLuRDx8gKv8/uyCp/367rWRblFOw4u9SGPePqtq4m7hNCnaZLkdHetr0cldcKX0l1Gq/6FiCAZw/ADJLOnIJ7Q0vdNpmgZE2k6vVQ+AVJYwt6g/pCFe/fNCu/3Yic1oDbR91YWJEQ+Wix71k0ymuugEoRWaOqXDPof9i4zijOTIB+YuYnzCjDcPr7mG2pJYospnJArWsknJzIiCHAjDYVc45IsU/ksQ2soZGTIcv3YSqitVyYMxhTo8XMzZEohnKFYR0ektsM1fh4qzjDh96Echqm0upfWW7XwC3Sd9bmfHlwsv5ye6SVZH7+q+aqSx0n95gSAP3liLSyPg+GaDq4yJEdQtAMUV0b9X06OqrDPkgrwB0sRFQyPwfbKDYvKl91zmdrrMOHAiXIDO8xFzRkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6486002)(2906002)(26005)(6506007)(316002)(186003)(52116002)(6666004)(33656002)(4326008)(66476007)(508600001)(38100700002)(38350700002)(66946007)(86362001)(66556008)(1076003)(8676002)(8936002)(44832011)(83380400001)(33716001)(5660300002)(54906003)(9686003)(110136005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QjAEGjKcjTbVM067eudGzLY5RuStqN9Eb8P+fFg+w1LoukGSwMNk3jjnMqhM?=
 =?us-ascii?Q?SyZyJ4U7v6RXBNJvSLn56NFlKT5L5d7AmS4Rn0ShKqRKlj+a+Sp4UDDSQiyR?=
 =?us-ascii?Q?435m7jCipTl8RvI1yUj7CSHh+1ckeP4zFx8hC3jHw4/eUxLNtbqyKcVPe4O1?=
 =?us-ascii?Q?FM6EYAaOsrA8s3HGWTUNXImMIm90rD3Se8MT9CTL4u3dbTHKEIxIEkjE90f2?=
 =?us-ascii?Q?VN3KdX0rFAGy8zZCKLrRB9wODA7CTOvBrSaSm8U+CaMUUk3nK3Lmo2BMVuy4?=
 =?us-ascii?Q?rBbWhjyQpjzclQb5iX5Kkluw6ivqlSV0NZ3WPL5gOS8qzAm36QH6tOq6LaJU?=
 =?us-ascii?Q?3o5I+MJGCoUNVjUmJocuqlRNq8ZgnpRdjHS3G0mhqVW3RoIqjAItZW99O8q6?=
 =?us-ascii?Q?+vwOvNfRdNLNYnTF5lZ8r7xp6ZygQu5xl+ALQ3UmeXCKesgLTFNVHaJjp/3r?=
 =?us-ascii?Q?a/GYz3aOVSTFlQNTmsf/BC8c1Kj0EiSyhbcNlsIxfq+S7V/Llv/9FvxYmY7U?=
 =?us-ascii?Q?7oZaexWRBwqe1/cnRprn36yVRTxZHfQGagkjCHEUbrSchpnaX9ImwA5cCszg?=
 =?us-ascii?Q?Rc/TwTG+mNaf8gKUuuZ66/HTBQx1dZoBiyvlH6YFkLoUL7Zkzdx8AyL9oicj?=
 =?us-ascii?Q?HOElWzvqO21gndfoRY603kgV9VaAqxDwYApguJO8/9WpI7GYcxtQoG8oXouF?=
 =?us-ascii?Q?D6+jooq8max8oXEao0WsiJywtSylFtJniAgapQbHhrgltKkGkDs+bmlP/l7t?=
 =?us-ascii?Q?O2OOMjLnd6QhWDvPtAJWvMigvccEQyRAs8whau4z/ZCAWPluIQERA5x1by+h?=
 =?us-ascii?Q?UWaCJN1XjPHRLfVRy2VRmmaX5vMdeN5W+q+hgG2ZfLol83pfbYXvqeRUHXq6?=
 =?us-ascii?Q?wPmQC+R1vvPZpjTClAfO4x8Q5xk8UpSbLqKqoOREzoikYQNnDBflj+gGLW4F?=
 =?us-ascii?Q?b5R/3xRtvQ7HAXY7Zq/J80C8r4Y5iyDedZbrCyo4Z+yHep1yUKSew23GH7Vv?=
 =?us-ascii?Q?ocU3/yEHYL3Ys6XUcCj1oAEqjtp7Y9oovCoizy05K58nou0ilgWkciA3OQ8C?=
 =?us-ascii?Q?zHYkRN6OKIWXZ0Ty79geKFpS8mHlChGlutsGoN5tnOVyJI451u+tSs8+MAkZ?=
 =?us-ascii?Q?rrBJob9qWtNICgZu0Vzd2BlnNUIoFoWhK0QiCMaa3OKlLIkH79Pe8UI1kFoE?=
 =?us-ascii?Q?yr1p8jzYygY++nSi2uJRVwP6+9zbJbruoRr+bx/6aqfda0E4lRopY+rgrsF5?=
 =?us-ascii?Q?n/MCRLBwQDUPIS0REVZbsIK9Hj0XVkM0E887tSRD0bClExdz7MBfNtGm/YA+?=
 =?us-ascii?Q?lbvmUbVhwSbFTZNQihwPwY2NO5WnF9GbKfovV/SiWwrVAEDdwVBkx4d3/xQo?=
 =?us-ascii?Q?d6a3iGZr6UO1gimsF1jJQRXh6tZNgW0POq3NvRjj7xitw+Z1HxUFbdkvV0H3?=
 =?us-ascii?Q?NYQqrqg+h0Zc4eHry8UUzMkIycC+c+UrEmJPr8uzgmtXnmgm/1Vyiqs+FO5j?=
 =?us-ascii?Q?5kj48JVqAhzmyMXhJ/L6LheEQtHWMn4ebfmUxGkEKjRmmZAsuj/ik3ulzYsw?=
 =?us-ascii?Q?sCHBVPVLJUE82eI+BcogJEu2Td2dgKbpSHLFJA+jX2BD8pk6ajU7ndPUwISy?=
 =?us-ascii?Q?ZJB14O1jt6D1Ci6YdbOLCcZPiTCMi8pWUYKMJ3MdbrZt+kb00Nh+SxbkQvgJ?=
 =?us-ascii?Q?3X4s0SbxhgEdV//eQDuaA1nJLuk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e034005-95a7-451a-22f0-08d9df3494c3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 12:25:17.7683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PvjfegpyjCSr5cXZBjWICGTQqBvmaVR70hi9TUVCw/r7yz5GWrP84FWeCVBFhGeJ2alMTl7O02QGq3py+RkK0J+W7yXjOWezpVs271iY5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1734
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10236 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201240082
X-Proofpoint-ORIG-GUID: USQxM5xlyp0v35t39V2T5oAB0la8866Z
X-Proofpoint-GUID: USQxM5xlyp0v35t39V2T5oAB0la8866Z
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Call c4iw_put_wr_wait() if c4iw_wait_for_reply() fails.  This
code uses kobject so the worst impact from this bug is a DoS.

Fixes: 2015f26cfade ("iw_cxgb4: add referencing to wait objects")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
From static analysis.  Not tested.

 drivers/infiniband/hw/cxgb4/iw_cxgb4.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index 12f33467c672..1dc0e00aba5f 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -297,11 +297,18 @@ static inline int c4iw_ref_send_wait(struct c4iw_rdev *rdev,
 		 qpid);
 	c4iw_get_wr_wait(wr_waitp);
 	ret = c4iw_ofld_send(rdev, skb);
-	if (ret) {
-		c4iw_put_wr_wait(wr_waitp);
-		return ret;
-	}
-	return c4iw_wait_for_reply(rdev, wr_waitp, hwtid, qpid, func);
+	if (ret)
+		goto put_wait;
+
+	ret = c4iw_wait_for_reply(rdev, wr_waitp, hwtid, qpid, func);
+	if (ret)
+		goto put_wait;
+
+	return 0;
+
+put_wait:
+	c4iw_put_wr_wait(wr_waitp);
+	return ret;
 }
 
 enum db_state {
-- 
2.20.1

