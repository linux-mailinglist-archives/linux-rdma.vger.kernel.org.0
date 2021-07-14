Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628723C8058
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jul 2021 10:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbhGNIi1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Jul 2021 04:38:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28244 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238503AbhGNIi1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 14 Jul 2021 04:38:27 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16E8ZY03001664;
        Wed, 14 Jul 2021 08:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=8GsiThGvn8iqi9R/NzeiUiiBn+A1w/J5ENbUWvtDlgk=;
 b=tFuEMiMYYylByxkLTFno+Uz7yDrnPjMyA0mJAqYmXC53d383iAvOgjoyQegXcivjxmG9
 IplaEPlx8WzbYUuRUw05ONA9qVUKkJ6tKwqWv7BSGILrCHJWR+lsVqZHk1GdXqbmbZNu
 Cz2fFbADCIBhVdmfkGKsM23n4OXFaJUTQaMmJGSwUpgRwoBigOr9fAZSqkQrLL5u2DMX
 jaqnQanu1m5XewqSakSPIc/vWrZIqFrq5sbRYe69A1QWfY6kVzgg2jhotM7nqN5Uj6wk
 kbHnGmh+gwpnvTjakLHO7GuL2PlRxZc6RJgQ5uhDw7uF5rWu2Glmhp/qjd7GrM0cgyDe Xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39rnxdmbqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 08:35:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16E8Ui2c039942;
        Wed, 14 Jul 2021 08:35:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3020.oracle.com with ESMTP id 39q3cep23n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 08:35:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sjh7fpbdlR0/vHe6vi+pvTxi4aaUOFzH5X/lJpNY/9g4AEEewU/CvkM0eCi0RlqWbYxziDIWvl+vCOBN3j9zwaiMjFxV4pwl3D479taNBK6N87BaOJ2iKtak/kIje9w0jJWONA23nC2c1gEmxkWyIgFVEO0WvuIAVPZVWtlYLIWd2dxnaaa4FNiC/ewoD5jCWC4AkfGvFChcZY2mbVhj7Zv8AAjzyA4PjIXK/2FKlwuafsT5UE/WJQpyM0Rm5egxE0y+gkaLsM3Rj4Jpg+HmIZffe7PxWdWJpyYqZ0DKs1qIwiybbIZE2yDxzHm0VPvRmulpjf0gp+lrgeE4zECt0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GsiThGvn8iqi9R/NzeiUiiBn+A1w/J5ENbUWvtDlgk=;
 b=VktmvdhnY7kGJlZ6zEcoqhwRf/AMRO6H4t/HCtttXwIvvlNyaDYoaGWrK+qDrxYhoaMWbG334Lo+rxA7S5bfsYymLaOh67J4yrM9Jlx6tW5Xpy/79hoIvp7t3lbILUgTd4NUyZQg3etQwDqFBiYueO8rk1rz9fOEHWy7vNC8LpjCe1/moaYTXIU7ZYda6ymKE3OKZxjz4+cZSptSU8Xaj7LryllnAEiX+8LGGhdyWrSBTpIR0uGw31S/Iw5zEHo8dIbkpRNuY9R3IuA9NCbuTzwlAkro4mYFpn61QUGzRgLfdij2TAS4Oh0El1FiZp1EODEd/FPBr7lCCWV4mFaDVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GsiThGvn8iqi9R/NzeiUiiBn+A1w/J5ENbUWvtDlgk=;
 b=bckceIsbvh/fUdoBh0Q2hUdRBBwe32yjmVVt4vtr9OM56e/B3ExkKwFoONesakXjd5nYWdgI9VA3B2c8JU+3qt5P4qFk9y/nIUbPtjTTyGWLbjQ2p060BaYDvIBU4tdZoqESkPiUQmXoqHqdKPvNGa8VRrWWmnY7Pv/Mj7ujx0I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BY5PR10MB3857.namprd10.prod.outlook.com (2603:10b6:a03:1b0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Wed, 14 Jul
 2021 08:35:25 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21%6]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 08:35:25 +0000
From:   Rao Shoaib <Rao.Shoaib@oracle.com>
To:     linux-rdma@vger.kernel.org, jgg@ziepe.ca
Cc:     rao.shoaib@oracle.com
Subject: [PATCH v2 1/1] RDMA/rxe: Bump up default maximum values used via uverbs
Date:   Wed, 14 Jul 2021 01:35:16 -0700
Message-Id: <20210714083516.456736-2-Rao.Shoaib@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210714083516.456736-1-Rao.Shoaib@oracle.com>
References: <20210714083516.456736-1-Rao.Shoaib@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0075.namprd12.prod.outlook.com
 (2603:10b6:802:20::46) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shoaib-laptop.us.oracle.com (2606:b400:8301:1010::16aa) by SN1PR12CA0075.namprd12.prod.outlook.com (2603:10b6:802:20::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 08:35:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf75791a-0d07-4889-4167-08d946a253c9
X-MS-TrafficTypeDiagnostic: BY5PR10MB3857:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB38575CC3817AFB9AD8BB4C8AEF139@BY5PR10MB3857.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 06aFLGXFEmDyNiDtM/BzSPy20v7cOJM97bxHFaeYwSPSfttJOkmC8DPw9MvH9cCEWy2EZrCDff9WdHjSgdN9AUS+z8x2opXUkiTpTp3YfhLBI8UAPY2IBOl6gqR92IdS0cUyVvJdXZ0AExOlXP046LUaTCNAiY3jhAH+gJYAe+bip/y2mOH5jSm9GnHEHIsyLts1Hdm0zL65Tzwc8+HJ4dUVB4SYRn0sXbSYM2e3SD0L4tUwB5Uft5WANR7aZg0GImvWoVGJ9J8WbKpu9n9jOkV/KEjt8u9ix4dIlPvYJZTcRXX9xB5lRNWwokUFSWuMTUlrYoke0Pfd9LcHyzJiMeUgcej22dFdYun6ju/DAl96xfT6oFngtxXCxqKw5mbESN8aOqbjn4GUGtBZxLG2wxX0PJJttA0K0mBHcTwCA+kSUy3MuT5/NLsLHFBj78ihe2Mx0qPD0SyJW2GW715idLK/qDfXmQRlXA1Lg1Za+R9VV549bswHx4Iv6W+2eAAW1u4MzFkTQMvY1a/boRL0AqnxzLj06t0Q7dw82Ry2Yu9ZNsuPJhrHajVGCumPUjbuv4DvZdIBJVSfvhfD/OGFu7OoR3AR589+NrK5QALU9Hb0yGdBgKKnGxTLsyB/eKbBIn/g6iM2r0iTwTig5EpVZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(346002)(39860400002)(366004)(2906002)(478600001)(36756003)(4326008)(38100700002)(1076003)(2616005)(5660300002)(8936002)(52116002)(7696005)(107886003)(8676002)(86362001)(6666004)(186003)(83380400001)(66556008)(66946007)(66476007)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UlndQGvPL83bMAuE7Bv3fx+yWroqQOvJWyKLRkHdiiV7YglajxFjV5jU9kUg?=
 =?us-ascii?Q?cjPJ1tBhTePfGHlpvUTg4FwK7Ir+X4L6X3Kp01nBzVN4jXW02Xt6WCj2x8Q/?=
 =?us-ascii?Q?u71b0Tzmg/MWjuiaUuXG3pQ6VKRWX4r07vCxNQr/4nXAFn06VzAdOC8XKbYC?=
 =?us-ascii?Q?9ZdpYJsVuJlLSasthuziJ3F/TTSUI6GlawHZgPUGmv3ZJODloRZ2+EERXjW+?=
 =?us-ascii?Q?9S5UzxMzO6JF8gcNRk/1b0/HKSAd1uDaCNWEcMpPvdkx3S73Y5Fxjj6jPz/t?=
 =?us-ascii?Q?e0UIijrwH4SaFFiZkay/FXT/wvoviFjH8idmfWdCdwyXKpqZy59VY9CaC8DP?=
 =?us-ascii?Q?5xJdqqz6uriQmt3Ivte4Nty9wfLj1ek2/wDIRwyjvJRm35AluPly6Dt+eWGg?=
 =?us-ascii?Q?aON5W+HmcrHQZm1ckuvE8aVzVlFkjqrrVNKLOTYonWzYFHKzaF0r/xpJ4zVv?=
 =?us-ascii?Q?O63GbVmXooSxGT8bn5lIqj1C1l4kuOTOza2bFjXSV0oRq3UPoU78L2n1r1v2?=
 =?us-ascii?Q?DVxZbIgeTWGGwAl5inHsPeiwuqS6gIW4/ghw2wfHRTaCqhvLa3LYFD3w+1I+?=
 =?us-ascii?Q?/AZWniO/9KYZkZf2w8u9iMp9QGDyazIQr1i3xGwpxS1S1zFyXPfMRu+qvYMI?=
 =?us-ascii?Q?imbtZBCNvDWJGz5pmkBHvm8aAosp8G+faAb4TVTxLXtgSIOVND3BnVP8Hr9b?=
 =?us-ascii?Q?zxAq8ZHb//hr+wCBF0T4NDOYY7l7Ulb6+OSK5o7NbT8jlb5xxGhwflttFqCg?=
 =?us-ascii?Q?vbQlYF4UJj/AAWOSaj0O+f65JA2RgHDI2BRs6nhe05e99w/W+vGB0va1vRz7?=
 =?us-ascii?Q?F3RHFMBTwpg+x+M/2oaTxv6RTo6bomanj6J/ovS1QoG82+y6N9qVChjvIKbl?=
 =?us-ascii?Q?jdufmgwIy6dDL+X2Di6RFJ9S8jnaFA2az/Rqlq9jLsR01K7HK4EDGARjpQUV?=
 =?us-ascii?Q?O3BY49pNO0OUSUDXPys6Eh3J6W0L869vOIlrkVlVngPiUiT67FSfdMTkw/wg?=
 =?us-ascii?Q?cfnetKeKCa92teDxDtcbMGWb2/4QqQHUit/XNoVNQuQ+TEIOnRsy8tLarwhz?=
 =?us-ascii?Q?TQJzvOHqNoeUN5HvyqGOrj9bCg2ZyGUiN57n0WAJrrFODU1oXv0ZO6s0zmvV?=
 =?us-ascii?Q?XWtFtxXy5a7/CUL3BmFXsDSXQvb228/0sb7skp9CdISw/6o1aBNtROzHdve/?=
 =?us-ascii?Q?gJz2cQwBTZrih1ilPvtnJoXAV1YvYYKCr8X5R5M9st2P3UueyOY8z1clIum6?=
 =?us-ascii?Q?drcwi/qFR1LHAGYiIKuIdiFqhcVa7N6fX0Kt4TGDkybvRgIeoh6YNeVIUvP/?=
 =?us-ascii?Q?jh8J6eg5hC4j3LB+OniXxj/g36wYCicDFonWONyu3dL29vnb/tIzLj8F27uJ?=
 =?us-ascii?Q?/Gn1nIo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf75791a-0d07-4889-4167-08d946a253c9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 08:35:25.5772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRTcz+FdqDqQPZM4tJ1lpIFGefraHn7RwlSkGZ0tSjt+kfkeCUMmjQ2w4cMcNzyot8JN84rmvd3oP4uj5QxAcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3857
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10044 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107140055
X-Proofpoint-GUID: C-Ss8FOyoXjZt8iEhFAgpgpD8nQkv7h4
X-Proofpoint-ORIG-GUID: C-Ss8FOyoXjZt8iEhFAgpgpD8nQkv7h4
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Rao Shoaib <rshoaib@ca-dev141.us.oracle.com>

In our internal testing we have found that the
current maximum are too smalls. Ideally there should
be no limits but currently maximum values are reported
via ibv_query_device, so we have to keep maximum values
but they have been made suffiently large.

Resubmitting after fixing an issue reported by test robot.

Reported-by: kernel test robot <lkp@intel.com>

Signed-off-by: Rao Shoaib <rshoaib@ca-dev141.us.oracle.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 742e6ec93686..092dbff890f2 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -9,6 +9,8 @@
 
 #include <uapi/rdma/rdma_user_rxe.h>
 
+#define DEFAULT_MAX_VALUE (1 << 20)
+
 static inline enum ib_mtu rxe_mtu_int_to_enum(int mtu)
 {
 	if (mtu < 256)
@@ -37,7 +39,7 @@ static inline enum ib_mtu eth_mtu_int_to_enum(int mtu)
 enum rxe_device_param {
 	RXE_MAX_MR_SIZE			= -1ull,
 	RXE_PAGE_SIZE_CAP		= 0xfffff000,
-	RXE_MAX_QP_WR			= 0x4000,
+	RXE_MAX_QP_WR			= DEFAULT_MAX_VALUE,
 	RXE_DEVICE_CAP_FLAGS		= IB_DEVICE_BAD_PKEY_CNTR
 					| IB_DEVICE_BAD_QKEY_CNTR
 					| IB_DEVICE_AUTO_PATH_MIG
@@ -58,40 +60,40 @@ enum rxe_device_param {
 	RXE_MAX_INLINE_DATA		= RXE_MAX_WQE_SIZE -
 					  sizeof(struct rxe_send_wqe),
 	RXE_MAX_SGE_RD			= 32,
-	RXE_MAX_CQ			= 16384,
+	RXE_MAX_CQ			= DEFAULT_MAX_VALUE,
 	RXE_MAX_LOG_CQE			= 15,
-	RXE_MAX_PD			= 0x7ffc,
+	RXE_MAX_PD			= DEFAULT_MAX_VALUE,
 	RXE_MAX_QP_RD_ATOM		= 128,
 	RXE_MAX_RES_RD_ATOM		= 0x3f000,
 	RXE_MAX_QP_INIT_RD_ATOM		= 128,
 	RXE_MAX_MCAST_GRP		= 8192,
 	RXE_MAX_MCAST_QP_ATTACH		= 56,
 	RXE_MAX_TOT_MCAST_QP_ATTACH	= 0x70000,
-	RXE_MAX_AH			= 100,
-	RXE_MAX_SRQ_WR			= 0x4000,
+	RXE_MAX_AH			= DEFAULT_MAX_VALUE,
+	RXE_MAX_SRQ_WR			= DEFAULT_MAX_VALUE,
 	RXE_MIN_SRQ_WR			= 1,
 	RXE_MAX_SRQ_SGE			= 27,
 	RXE_MIN_SRQ_SGE			= 1,
 	RXE_MAX_FMR_PAGE_LIST_LEN	= 512,
-	RXE_MAX_PKEYS			= 1,
+	RXE_MAX_PKEYS			= 64,
 	RXE_LOCAL_CA_ACK_DELAY		= 15,
 
-	RXE_MAX_UCONTEXT		= 512,
+	RXE_MAX_UCONTEXT		= DEFAULT_MAX_VALUE,
 
 	RXE_NUM_PORT			= 1,
 
-	RXE_MAX_QP			= 0x10000,
+	RXE_MAX_QP			= DEFAULT_MAX_VALUE,
 	RXE_MIN_QP_INDEX		= 16,
-	RXE_MAX_QP_INDEX		= 0x00020000,
+	RXE_MAX_QP_INDEX		= 0x00040000,
 
-	RXE_MAX_SRQ			= 0x00001000,
+	RXE_MAX_SRQ			= DEFAULT_MAX_VALUE,
 	RXE_MIN_SRQ_INDEX		= 0x00020001,
 	RXE_MAX_SRQ_INDEX		= 0x00040000,
 
-	RXE_MAX_MR			= 0x00001000,
+	RXE_MAX_MR			= DEFAULT_MAX_VALUE,
 	RXE_MAX_MW			= 0x00001000,
 	RXE_MIN_MR_INDEX		= 0x00000001,
-	RXE_MAX_MR_INDEX		= 0x00010000,
+	RXE_MAX_MR_INDEX		= 0x00040000,
 	RXE_MIN_MW_INDEX		= 0x00010001,
 	RXE_MAX_MW_INDEX		= 0x00020000,
 
-- 
2.27.0

