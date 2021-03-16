Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA1933D497
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Mar 2021 14:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbhCPNJU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Mar 2021 09:09:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58180 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbhCPNJK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Mar 2021 09:09:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GD4JRp049454;
        Tue, 16 Mar 2021 13:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=+hXv7rObpFq1x4PzGQoC1iiaHReilnV9b8UkburuBx8=;
 b=YMVlWmx+gHo4Tr6EKyQjLasgqXisAIwGxcX2gxiz7dnF22GJrklSqy+Fb1PI6mgAhcsz
 GwN8oTK09t+tSKJ7GLlS23kDtw6WquoZAR5K/TwzqS3dWBXfMjmSh6Wvj1YBd5AV24/T
 AKJG7PyEI3uzA0FlLNOCMJ/YLP56EibLyCOOdZGz4z780MdsOGOH1zbOwedQPbC6s3VD
 rFnLs52s1aFsOmiMLqfzPBTh/7YJ2oz0m2JRx/UL0WHVDuNqjrZsfxxnD7jOFic7TXra
 1Vrb0BVXC30vgw7aTdQxv6gpB4w1CnHlFVFwloNHYV3046WF9Ww6uBEmSc3fSGEEcg1I Ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37a4ekn2cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 13:09:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GD6d1w004005;
        Tue, 16 Mar 2021 13:09:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by aserp3030.oracle.com with ESMTP id 3796yte9xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 13:09:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1PbBDXom/X5sjjFzIXdh2led5MGDjiNMHUyIj8bb5U6G+zf/KK8lpo1NhAUFhthc0+rRd3NvpEUCDj8GzIXcyR4q+Wwiv4+VVOjtSV6sKgZUxoWyr2FfIjPLOAZELTpfSLtPtR9ftx3SJc5AjsdpAX91+gCRGNaNd7aAXxyEAM6QsMVDhLv+/ruWFcepp65XtZthp+5UYwaGJqoX+guh5Ib1Qe6cXzy/2Zdrsnlh6hAJvB85J0V7GfTN6ATneEJe/daKo/9lFOfDN+7diyRBlGPS8EndD0r1fg5eiOmazMz0k6PSgT/fZmBMmaGReKSsfxtSJN9vsMoWysvQ2Ab8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hXv7rObpFq1x4PzGQoC1iiaHReilnV9b8UkburuBx8=;
 b=INiMe8aWcjmYVtGInccrKJiiPD70Ct7G92pD1vI59ai0YOdaojtYhb7etkKh/vMpzv+MtzyD4FOmQWc5S1Xr0GdjbdpQFqrUEXBAb1d3fhj8On9OkOrfDUfTKR+MFv7lzoP9j27ZSRk2PSOf/zIbLyxLt+CucS8Gi/MrrjeyeX4ZZE9nfRkeUQgXuWA2CRw9MWAGERD0l7PpnwcsQh7RXrFak69J52rqe+m69Xc5nYgQQEuXhhTCp196JUv/V54QctmGfsKQQKjspU+/Yy5kiDSQvLDUHxZAsINI6tdfSSV9PaA6qwu0yrGkaeEWeh513B3+Mh/g9oY9Jh1RQAl77w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hXv7rObpFq1x4PzGQoC1iiaHReilnV9b8UkburuBx8=;
 b=pOYinmpcATxI3ASQwh/zWzZZ021/rMnsCIy9BsOvxjIajIlHvRsHc/X/CXI/5zbtgyUSABlsBWxOR37tXLZ/J4Tuqdig9saShj3ugHZCMOJHnU6bZ+GHUy8gLjxEfhIpgNLc9XAGX+H5BkR8BjYWPbzNHVUVOb/DrnMVYu/AEis=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR10MB1448.namprd10.prod.outlook.com (2603:10b6:903:27::12)
 by CY4PR10MB1365.namprd10.prod.outlook.com (2603:10b6:903:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 13:09:03 +0000
Received: from CY4PR10MB1448.namprd10.prod.outlook.com
 ([fe80::14d0:f061:b858:4c1]) by CY4PR10MB1448.namprd10.prod.outlook.com
 ([fe80::14d0:f061:b858:4c1%7]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 13:09:03 +0000
From:   Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
To:     leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rajesh.sivaramasubramaniom@oracle.com,
        rama.nichanamatlu@oracle.com, aruna.ramakrishna@oracle.com,
        jeffery.yoder@oracle.com,
        Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Subject: [PATCH v2] IB/mlx5: Reduce max order of memory allocated for xlt update
Date:   Tue, 16 Mar 2021 13:09:01 +0000
Message-Id: <1615900141-14012-1-git-send-email-praveen.kannoju@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [138.3.200.5]
X-ClientProxiedBy: CY4PR16CA0003.namprd16.prod.outlook.com
 (2603:10b6:903:102::13) To CY4PR10MB1448.namprd10.prod.outlook.com
 (2603:10b6:903:27::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pkannoju-vm.us.oracle.com (138.3.200.5) by CY4PR16CA0003.namprd16.prod.outlook.com (2603:10b6:903:102::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 16 Mar 2021 13:09:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f59e7af-47dd-4796-4a8e-08d8e87cabdb
X-MS-TrafficTypeDiagnostic: CY4PR10MB1365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB13656F4EA090A486C9224E6A8C6B9@CY4PR10MB1365.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9tDX+Xel1xiQ4fSP0PpaRPc3zxksRUEIW+dUOWyWw8S+phZwmIq0yL+3HrY/HyF67UkveQnpRAmQz2pL0p77gDN+lThH1WK7ltqr8gjjiq9kegO+VUAaWsNbzIb6lBRbht4Y+YPNUcLult+t0vBRDK02s4a6K1xNf5fDPIqpSh19hmdcnncd+IFgVS/wDyO/TfgFluZRz8fJvH1o1gUagZ2OdeFV4/AzIbUwP8Tk6IgsvyabEDMdq75gdiEvlKZY0yEbqfZlG2x4ymi3fwGDhZqbGH/z/30WcnAxj7Ob+Dwv/s/6ZbvinJ/aT/tuf64AuG+5M66r9Aylqmoh2cBy6LezLYmSvQrcc9fOjvY3D+XfNXnUk0MAwrlRLwNjnQaood+l05Cb5DzSFib6sG7J4UsMoXsEU2Y1wt9NcPlEaHjERsHBYrW9VAQkzspSXfKnKbSPgR2fskiLV7K2FqDKrn2mGgyiagYwCJX4zZGx/8hvG0DaoOk+TRaslin5w7xrf47FmDkFo32cJmJgOqYMzUkj5wXro8BkC8Y8g9s9eHCkOBb2jdlSn7q5HX1sqzrb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1448.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(346002)(376002)(136003)(396003)(107886003)(186003)(16526019)(7696005)(52116002)(4326008)(2616005)(5660300002)(6486002)(83380400001)(2906002)(8936002)(66946007)(15650500001)(26005)(66556008)(8676002)(86362001)(956004)(478600001)(316002)(66476007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?IATMpMmXv4Upk1YtcaVPPoUOTjZCt2opT4titly3FKWQa06+B7rSePFll4fV?=
 =?us-ascii?Q?h6UDEAYWilcmT/9rdkOy72WCKaX4JbO5EKphSeLgF+Uv2MeukLAoqOCUhEQv?=
 =?us-ascii?Q?DynjLGCMbuVVIzC7cQqiUuFWFOTBQD121ZFIpwY6nqDQLtbZZdgvovclw6cf?=
 =?us-ascii?Q?e/LFtv+TDI2fPLPvCxgMLrH4756FJ7FOiCiZj9XPWFqYOsdxwYQZcCPS8cXl?=
 =?us-ascii?Q?IwasvJDlSlpin8+ugL8O0IzC8aHVGhKMf3Yw1rX0IvvJXWSbhn+7k+69gsin?=
 =?us-ascii?Q?P+DZnazkjAPr6LZY5Pi6HiY96zJBkTkm8HFs9l6ebfznrY5nE9dx+7cpZBuS?=
 =?us-ascii?Q?E3DYpot6h1MQIsYF7UpmHsw9vT5gDNhCOo7fF0tR50qpLVYBYRIrGJ+mLQxP?=
 =?us-ascii?Q?tegeOl/Fh5HVG3Hh/iEhTJOVhG70TaUhW1NG/Ym+Td+grf+PenaMEvUrZMvy?=
 =?us-ascii?Q?MoEsttHHWssP2SzAiYfFerp/GymP8j7U2ORLBhWIT9LRrCdd9FML1MfMDVKQ?=
 =?us-ascii?Q?5F8brYxOZytM7nv9BVmEBabxHVKLl5hyfmTUfL+GUvKlhSYk1o2SZp5lOHdH?=
 =?us-ascii?Q?Ll4kXGHYvlUo7JiCHv8m45LNsJ0g9Dq7kWGt6IHrL+W0V0Wuov0kxm419C65?=
 =?us-ascii?Q?52AynnBVHGI63JeW1XblGWtm9oGiSYiKb2wOg/jLn3upmT4E33kAb87WBlLw?=
 =?us-ascii?Q?J77f10gs5m9vVg0zTuDMTO3SJRGY5xiJnu4UT1oQnAkciP2/OQrx5qI+353x?=
 =?us-ascii?Q?llQr/IP1Se3JnI6EZ2BBOeFpkg6mxUz/j9Nf7FUunV29B3NECFvDIHhxDD4v?=
 =?us-ascii?Q?Tmr49thFUlsdBGunYA1FItVt8lK91Ocz2lO6y7DRZXtNBV8YsXPUvLTe3Xq9?=
 =?us-ascii?Q?wJqmvEsoXlJjdhNZkKfPIsKW7G/7kgwDWZ0v+F+CYXvl5ffs4NhCz/X2CF52?=
 =?us-ascii?Q?darPYEgm9k5zdE3ED3FJtk2Bh2QXPXLZ+sNFYI0y905u1uv1kOQBDlJvrowX?=
 =?us-ascii?Q?kESwvazXQ+qSAyYEDdXzVI/LeySdGQqWd9NBixx66tv/KxSifHystkfOCuXG?=
 =?us-ascii?Q?ZVxq2ngt9YXug1uX/xpW/9PQh3ZjFIXXpkKK1RD2mdEWYhkSLjbfFg9SJ9S9?=
 =?us-ascii?Q?9+Ude3A4FWJmCZlWFeBA/FfNCT2m4UiYVtaZ5dsp+aH7ZwG658QicJPzhOJP?=
 =?us-ascii?Q?fAWdw+Lq3fHCBPI2v2K2HAnKuCCvWEQ3lo+RgvyJNj84RpEMbgHkApzMcYj8?=
 =?us-ascii?Q?Yk7cOe4isz5RcSVVp5J0dipanNv6ZjJFKbLMecRBro4ByA+E6L6F1KbNOG54?=
 =?us-ascii?Q?64hatLWwcoea0k3fQJ6T7/rg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f59e7af-47dd-4796-4a8e-08d8e87cabdb
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1448.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 13:09:03.1408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRWH3A50VBAwW46BMPnYmcOvGnPEApZVzzJTrjNPtWytGT2RnI+jSMrC61ijUkeKPDwt4SKFTpX6LUhlzTkX0L83a1G20ssSYwSZovkqSqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1365
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9924 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160089
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9924 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160089
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To update xlt (during mlx5_ib_reg_user_mr()), the driver can request up to
1 MB (order-8) memory, depending on the size of the MR. This costly
allocation can sometimes take very long to return (a few seconds),
especially if the system is fragmented and does not have any free chunks
for orders >= 3. This causes the calling application to hang for a long
time. To avoid these long latency spikes, limit max order of allocation to
order 3, and reuse that buffer to populate_xlt() for that MR. This will
increase the latency slightly (in the order of microseconds) for each
mlx5_ib_update_xlt() call, especially for larger MRs (since were making
multiple calls to populate_xlt()), but its a small price to pay to avoid
the large latency spikes with higher order allocations. The flag
__GFP_NORETRY is used while fetching the free pages to ensure that there
are no long compaction stalls when the system's memory is in fragmented
condition.

Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index db05b0e..dac19f0 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1004,9 +1004,7 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 	return mr;
 }
 
-#define MLX5_MAX_UMR_CHUNK ((1 << (MLX5_MAX_UMR_SHIFT + 4)) - \
-			    MLX5_UMR_MTT_ALIGNMENT)
-#define MLX5_SPARE_UMR_CHUNK 0x10000
+#define MLX5_SPARE_UMR_CHUNK 0x8000
 
 /*
  * Allocate a temporary buffer to hold the per-page information to transfer to
@@ -1028,30 +1026,16 @@ static void *mlx5_ib_alloc_xlt(size_t *nents, size_t ent_size, gfp_t gfp_mask)
 	 */
 	might_sleep();
 
-	gfp_mask |= __GFP_ZERO;
+	gfp_mask |= __GFP_ZERO | __GFP_NORETRY;
 
-	/*
-	 * If the system already has a suitable high order page then just use
-	 * that, but don't try hard to create one. This max is about 1M, so a
-	 * free x86 huge page will satisfy it.
-	 */
 	size = min_t(size_t, ent_size * ALIGN(*nents, xlt_chunk_align),
-		     MLX5_MAX_UMR_CHUNK);
+		     MLX5_SPARE_UMR_CHUNK);
 	*nents = size / ent_size;
 	res = (void *)__get_free_pages(gfp_mask | __GFP_NOWARN,
 				       get_order(size));
 	if (res)
 		return res;
 
-	if (size > MLX5_SPARE_UMR_CHUNK) {
-		size = MLX5_SPARE_UMR_CHUNK;
-		*nents = get_order(size) / ent_size;
-		res = (void *)__get_free_pages(gfp_mask | __GFP_NOWARN,
-					       get_order(size));
-		if (res)
-			return res;
-	}
-
 	*nents = PAGE_SIZE / ent_size;
 	res = (void *)__get_free_page(gfp_mask);
 	if (res)
-- 
1.8.3.1

