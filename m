Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5005C3C6C11
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jul 2021 10:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhGMIjs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jul 2021 04:39:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9330 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234396AbhGMIjs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Jul 2021 04:39:48 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16D8R8AH002976;
        Tue, 13 Jul 2021 08:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=eT0J4zp1dJ3s+3UakvAhgvhglH7NThU3oO43Lv/mADg=;
 b=JjgDw2qL/UuX7so7kGZYpeO1/HX5pp8CTmp+Mf0XyzMlYFVF0OSTfnv6YSJQGVR/8BNZ
 sA+HIehOaeOdQo+Dz2V0CU7odIGeXgYrieT+edtadDE44UAvhPYRn+xOLu5wbMIXD6Qm
 k1gchH5Amo/pUEWRxVdqksZhu+qc0Kx560Rrvc+veLVQmePMj7HtftQn7Y7Y4Wv5oBEr
 HzIhE6ARFw193fiDr/TjB7Q5GWkVYNrTLbIZXwLOfMSPht+BURAJzdlVni4X7s1mpu7E
 mQQC+HAzgBFKU6sh130AVa2TrvVRpakad3cgB/aYzNqdKloxe3MONNdUhQe4+ccXcILS Lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39rqkb1qvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 08:36:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16D8UjWE120842;
        Tue, 13 Jul 2021 08:36:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3030.oracle.com with ESMTP id 39q0p3eaey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 08:36:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lO4p+g0wbo/d01kqj+R7A+3s6gzYQxSZuc9FK7sRtiH7QZcs6FGUcLWynKmfgu9rMedLyY5pj6MaO8beZRpomcuAJoUmb0EqXV+YFRgazg4ZGoJSpMXraO5Q0yppsO2eHOktHpjUDzmYC9ExZG+KKwcu13kkVYCONqYSTXv10KYsYWJEI9XxNZUlOTnoHcDIY0MuBhmtEsi4Av/b8+NdnlrHOylyVeL7ngXn6M2QMq7UrBRByIKAA+OIM/yDBt5ZqApZsIp4N3p+llRbbmNvX3ZOWrtvW1uKV/JPgoUb7kK7YaD01SVHsX08w/DmvUbJGAQIcGiQ/N91qeUKXMyMlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eT0J4zp1dJ3s+3UakvAhgvhglH7NThU3oO43Lv/mADg=;
 b=U1pdqY1SDNPQx4YP7cNDYYoCncWsJwJdv+fDyHGpZVzZV4rnsnqmHh4mkCiIUL140VdTducvE8pbHD/YcLgId19prwQqfvlzHnu3wrZCbN+HYHh1pLYzvul1Z6UarlfmYEFZBWuAgo8hSXqYlNwMXsiuMTuxkSOc04j3PAlPPU2SRQL29Uj2cqlc82i6o9Q7VLye0TCaTef3avoyu/TaUfz2HRgcccL0a2yoreL+G143w7/wbb520hMdAFoB6MC85P7X2qD8ssC5E9s8pDTRaEYtw/JBBiMhROTQG+Aqbtb0HTMhJ4Qw/bDGtTFcYkbw513Xl+lkLA6++JqNwXQDGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eT0J4zp1dJ3s+3UakvAhgvhglH7NThU3oO43Lv/mADg=;
 b=Qz71EK0pw3QrFlAGVaXOuM8FuroPwo4G0e5e3Bsgii8DNw8xm4zuFW88i6ogXTpuE55EHbZwUz0xDGWX1aiGrmuSFmngzbh0LF6BzCAYYFd8b2iHdfwVmmb3sxidYNuYMb7cF+s/mh2yCZpzrI6ocMC1NRBTXWDl57vMvknftKc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Tue, 13 Jul
 2021 08:36:54 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21%7]) with mapi id 15.20.4308.020; Tue, 13 Jul 2021
 08:36:54 +0000
From:   Rao Shoaib <Rao.Shoaib@oracle.com>
To:     linux-rdma@vger.kernel.org, jgg@ziepe.ca
Cc:     rao.shoaib@oracle.com
Subject: [PATCH] RDMA/rxe: Bump up default maximum values used via uverbs
Date:   Tue, 13 Jul 2021 01:36:47 -0700
Message-Id: <20210713083647.393983-1-Rao.Shoaib@oracle.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::34) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shoaib-laptop.us.oracle.com (2606:b400:8301:1010::16aa) by BY5PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:1e0::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Tue, 13 Jul 2021 08:36:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac474245-21dd-4b0c-5727-08d945d95e94
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB429054A6C99E6C1E8B5B376DEF149@BY5PR10MB4290.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YmCSI0bMTVQa4bq9I47tIljnAvHtq/pboxemD9RhIdYE3A8d5Vz2VCnzErcYYvQe5/lsSg/MQHlFYoerW3Aib5yYJW7fS16w/rsGl38TXkN/PhJfDO8JWN60+y6+KWd4QShZmg/KBcjmg+xROXuwXBjT1MY/gKYp/gehN9FhXGy+kdy9jJjSPdWWm1R24wEJFerW1LJGRpu9chAd4cU/VORtXXAZh5K1U6aHS8PRRw/+zK/8u3Pf7RY5RsCFslNaNJ5saenOYK7KGPuueLNnxcdiXQX2kZaa8BjggLqQB0avhTZgkGlHFDzdkdACkLVohOzp/nPNBdpPN7li9fT3e5KS5O6nuia2n/5V2cnslPmmX4LyfcBP/X8+9GHuEaS0qDvt55NR3eTm4R+RO/YJozq80R3BfzTgdD98zGw1h9MYqPCGIj9fuVtSyi96IOTiOqK9j9RTzGi5+x+ZX9WULK3eejU4apbmgOxcwRoCPKbAmUfnDbCs0kzuBxjSyphBaczPX8IRHxWC0BWkNjISp4YA+UgyLE4AU9ChoSQiZvwPRKfsVr34mNHFCHZE89ETfy7TjS49yxirN8bGBNc2cwKOyxReqnFmrVvASvNtF9/O2B5DDldmM0weX6ZVNDyvpqYSXiqq8iRlyEhN2b1nsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(39860400002)(396003)(346002)(478600001)(52116002)(6486002)(5660300002)(2616005)(7696005)(83380400001)(86362001)(1076003)(36756003)(66946007)(66556008)(316002)(4326008)(2906002)(6666004)(107886003)(66476007)(8676002)(186003)(38100700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3yf57VsmeSUYcsOvOBv+/kTSECqlLcTzIJ5VT9FFuN7zkqv0IioybO/QRTxw?=
 =?us-ascii?Q?Cve1G5Go6ceq0qCa0PKvadI55f2GISJiVxbhWx3u3IG3N3edLkq072CrFFA6?=
 =?us-ascii?Q?L+X7j2x1/Ul44uqJLrECHaLE2DHQHqw3tHamjhEQ/mQmWsRppQ4uF4rGOkz3?=
 =?us-ascii?Q?SiEeg/SkPhs/GpFiwlkUez3mhSCPRIizEo+RW2AQmhRFqS8qlxq65nJ6Qt1F?=
 =?us-ascii?Q?EfCm77vCA22pZmrXlahE2UBaQXNHZ2e/79EGKT4ePtAyJKTs1ovYLsZPdFsR?=
 =?us-ascii?Q?+s+Xxe9rcX2yNoMYwLwmS6QiJ5bpKqOPTlG5/bhm9VNZ/Fb/8b/jhJyBkjKx?=
 =?us-ascii?Q?qG6a8h2Cn8Wnu7WOdFvPJHflv+j5OkEffGHhuKaLsIUNA6V3fxnRoLsStdCL?=
 =?us-ascii?Q?2m254+Mr8ZsrynPg4VY6iyEpMUQ8pbjz06xVlU+tZxhFlDYcUyqMI6PkVmGj?=
 =?us-ascii?Q?zHHkrDTA26omYc+UDd85JaR04jsaZHdXy5JoJac5C1u0fdANg91CEENT4vea?=
 =?us-ascii?Q?Tyg0Gpok69SdVcj405QkkMVc/Aeqsp3IAC/9rfXBLgrVfC+1tNky/bJn3l9M?=
 =?us-ascii?Q?67lsL3jWK6tAe311s+wJNo7WITDptivoTxQFGl+oJ42QLVn/DBMX7kz4IOPv?=
 =?us-ascii?Q?YtnsLsk7FJOlI1xbwcyiUh0w7rV7lMzIBCaVeRoZsRDQsORLPuXPvRy59bI9?=
 =?us-ascii?Q?SIg+yya0zpQGNic1YeU6I5/AK1zIfP2JuQ9acgQet89KdMwUX+tipLgAv6sC?=
 =?us-ascii?Q?yPokyoiPDCzWQT06t+IF0DZ3REX4y/dIeTvg5iuAWFy0XvHa4QrPrw/sv0kR?=
 =?us-ascii?Q?zorG/i3sxmvEYsuA4/QzAfvKcEmkCPJs9Rkp1XXMFKFonFZGDhyQIZFOMBzr?=
 =?us-ascii?Q?27CWXsfb1ifIiT6Buo3Sjq+JBspjw8g96H3d2crOjHExdM8Gzu5dujTUcWxP?=
 =?us-ascii?Q?ZmYH3d0GNU1qObFMcXYaehadR812ckbqQ8YcDYC3IInMAQnXD1KEEh+rD03Y?=
 =?us-ascii?Q?hWcRFUIbPNDEVXl5dZAQjuBdhQmlSEktzh7yQdWSr3sfjYSH9GBmvuqSGUDX?=
 =?us-ascii?Q?1UlEp5tKh5o41Bg06oZJD40+R+LZ3OqO6hzTVCz8RjwrotDjf5JjM03+G9lT?=
 =?us-ascii?Q?Oa0b7hIy7G37cedDrnKTbuEzqBlncMSBsnaXUWd1+nMp+HX6uprUXUtEVBG1?=
 =?us-ascii?Q?DSjHjB6+DI1RZRHTGFPds7G8lgaIzeUp4O6eWrwSiDRklDWK6gvWfnAjAxu4?=
 =?us-ascii?Q?BmLbbuI9mysb5JGpEVfOOcqY2kXj1I+4Gx+30XLWVBT52aRkSfRMh1DhX8tx?=
 =?us-ascii?Q?7EaeHfqpMQi8ngBWgQV88enV+VlpJCP20H+EAU6v6kE0teHwD2DtUaO63mcP?=
 =?us-ascii?Q?8LhwJP4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac474245-21dd-4b0c-5727-08d945d95e94
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 08:36:54.7830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrY5CQlXEYyzbcO7LHbcDq74zrAnFjDFGSE/BS3s6gzUmjYSCpdGH+Q/kn7dzDqYwAGZIDXICbI7t8OYun4cjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4290
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10043 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107130053
X-Proofpoint-ORIG-GUID: M3EJUrOYsWY8jfM96RRDGokaiBXUw1zJ
X-Proofpoint-GUID: M3EJUrOYsWY8jfM96RRDGokaiBXUw1zJ
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Rao Shoaib <rao.shoaib@oracle.com>

In our internal testing we have found that the
current maximum are too smalls. Ideally there should
be no limits but currently maximum values are reported
via ibv_query_device, so we have to keep maximum values
but they have been made suffiently large.

Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 742e6ec93686..66a948adb1e1 100644
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
+	RXE_MAX_PKEYS			= DEFAULT_MAX_VALUE,
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

