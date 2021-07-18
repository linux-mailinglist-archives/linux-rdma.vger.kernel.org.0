Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771FC3CCB7C
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jul 2021 00:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhGRXCR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Jul 2021 19:02:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18028 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232582AbhGRXCR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Jul 2021 19:02:17 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16IMuVuG013989;
        Sun, 18 Jul 2021 22:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=s5P0wzcYkJQvSuAbsaEfyZm9ANkxRFpXsv5iGrktceo=;
 b=XvAr4GpBXbBSP/RzQyoR1LuwGAkSLST8eR7Boz5CpV+pKLrjgn5BfkPY50is7q0SmFne
 wb73x2p0ANK9jyq0s1ddSeLBIlH+r3njnTf89ruwE/PYILTenOYZhq22P7ZhGp+Levs7
 0UR2Uq6NNNyiqI5/HB2yB6/REqwTwHuQnrxRIR4G6sfSVbGEX4BfAyxfafyTEwNrT1nc
 4tH1KrB8eZ0xaxHBsBiZH0O8xd6RDjnOlBoB8jE3gTCtMUD95D7LdXTqpKXtXAi6FuiO
 wU+zVLGQCY3hV07DDXQC9262FD9oMgVVinn5f04fqyeR0Tmd5VLdKvUYtiwZ9HsRuHQ9 GQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=s5P0wzcYkJQvSuAbsaEfyZm9ANkxRFpXsv5iGrktceo=;
 b=JnTthjXMl/oZFRA16klQMQ4uhXDky+/wHy2WJw9CaqeheGmWVvM7cfUOGvRD5vhH1VOW
 Q1L2VYgK0/P5kZfjnSXodl9vLwFQ0OhGlAbFQ7/xr018yLoU298eLBwOZl0zCow774Be
 lhMhHTYvp/7FsVVZCstyDm8/Llofh/2XhEiRKLIMISwMGReYj+gb24sUVb+QzbRQrqIO
 bm418/OoPchf3UiIZygPxSejTOTsovB7oNj1i6W0Fft5Lh+Sge4jNi/URid2DJF2w80u
 4nkjhmmnoCHLI/wtBxLG4zy8D7j/bPQSy+vM1U6kARwcBcsTs9KtJdRSyQGWVr2Nud4P Cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39vrn5g52n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Jul 2021 22:59:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16IMt0e8175410;
        Sun, 18 Jul 2021 22:59:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3020.oracle.com with ESMTP id 39uq13msey-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Jul 2021 22:59:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSZWA8NvZbIHmLE02pfAnhFx9O+2TPzf79eCXNSpiEeh0QfGBIkomtdP1q8Hd9mqCSwXMukb1zQ//oWL060EBGfJeJWSdqrzf43umnh4TtW8WdMIhKUgYCttzLuHPhfCyGfsbeGgIzu2Ybif5Un/m/bEnWKVcuWCI+o+w0nZJDJoLhMLntzvnEGExPIhyxynJv1+Tnrp/hF60z1SpTFUWDq5mKujcxCXwhX7KGrxSMNOrNhPeH2g4h7TqIzitktm6A6dqs2y1O6IHnQAmqJun2OWSRiWutQgz43AZAGmYKWcAyXX25t57KZDbmip7BvUI82dLQtv2Er1Dy6BHg7aXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5P0wzcYkJQvSuAbsaEfyZm9ANkxRFpXsv5iGrktceo=;
 b=WhuQMx3o7QqP/5Q346OOnH0oZ+8Kdtbq7s1KmMT+oq0ud6MqVuZOLxHS1Mrn3/7nKn4epaLdHUnMCYcZ3b5Zlhjx+H6erlDHh5D0ZCJ4/JrQrJDq6OU1CyIerO6WxnIQV9cyJ/U034vaUCqlNBwPqocyIVDAoZmCW0ge52e9P87ZUwwwm5l9vv9kv04FnGhvapEZFwbHw//LcPZRD5IpvPmCbgWDvhJ/qKCHoItHpqWeRU/I1yU8fwL50Jnxgr/IE7ylwN3TWOF2Ov2LsHmC+1M88veMngQ9STCbkdUZFQPKWdtWolKtorBEir+vee8LkgNrUoXLgj7dl4D3imNI/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5P0wzcYkJQvSuAbsaEfyZm9ANkxRFpXsv5iGrktceo=;
 b=yL3MDoQ8lktQQDozB1r2+6hTfEIuHexKqSWWT9YYarCtrcoaxiz/eAmOPsPNQgzjljCwcIGkdLDFSmDskNE8tU0JrBLDsNsrMcYdnrlu9batJBdWFATL7tft/qeKrd5bgVAczXpg75I+NSRlKbIC0BfquzCxm1jYVn8j3LifGrs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BYAPR10MB2968.namprd10.prod.outlook.com (2603:10b6:a03:85::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Sun, 18 Jul
 2021 22:59:12 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21%6]) with mapi id 15.20.4331.026; Sun, 18 Jul 2021
 22:59:12 +0000
From:   Rao Shoaib <Rao.Shoaib@oracle.com>
To:     linux-rdma@vger.kernel.org, jgg@ziepe.ca
Cc:     rao.shoaib@oracle.com
Subject: [PATCH v3 1/1] RDMA/rxe: Bump up default maximum values used via uverbs
Date:   Sun, 18 Jul 2021 15:59:05 -0700
Message-Id: <20210718225905.58728-2-Rao.Shoaib@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210718225905.58728-1-Rao.Shoaib@oracle.com>
References: <20210718225905.58728-1-Rao.Shoaib@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::13) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shoaib-laptop.us.oracle.com (2606:b400:8301:1010::16aa) by SJ0PR03CA0248.namprd03.prod.outlook.com (2603:10b6:a03:3a0::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Sun, 18 Jul 2021 22:59:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e2cfb64-ded7-41e3-22f7-08d94a3fa899
X-MS-TrafficTypeDiagnostic: BYAPR10MB2968:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2968E1A6E16C19D61072C236EFE09@BYAPR10MB2968.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pOBAEVbtkF9AhuMvaYADxzSnHdFmmaa13v70VSNne8ucy63aQztJGG66SWHxsvaolSpxAREUNgrXgBEJBXFuerqv8JDOydQU1ryIEy7v8CTtVuIf40OG2aTBLjVd4YbVwAxum2sl1Cv+48yeSYP1dCj3b2YqFVZt0rqeJXicDFdcHdwmiam/5qUzgBN9ibD0iSa+gmCP+A177Cy1iTGUZHNUZCFDS2u+/6VnBlVtTPI36mBSZs5MlZ5RNu/fqmf5WNgG5fs9Xl6FB5RZjiXjhVVySMYpSO5y2Vcondv0mtGvfqEri0jKt7RCAg7mlrQKU3VQuyDYzrMJv3wL50qUJpWTjVIBT/kkzIcWODui0BT+7Do5jEoFVUoHQj6sPt4gHJtg+lfb8/cYM35xyA/HskotHPPtmkmdoasQVEd9uCb0M7eDLFQqsuWrAiJDg6M9ld5o9IMG/z6ZdhCJPcC+XDGzzC4qvK2f58u0X881oqhchbrL3j8puWOSMTSixA3S3M4O4RYvD8AMmUbFhR6OjLVEeKUoZGhD4J8C+59VOyv81OnovLRct1KWJZqSpWyFLbHZLaVn+gGfUDbvV1bA+9fIRxMv6uxxOBNu3JTm7N90/9BkZUSjjuRivNWsnWZHIyIIooT4OqC2+7pU6+rWdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(366004)(39860400002)(376002)(186003)(107886003)(478600001)(36756003)(1076003)(66556008)(66476007)(66946007)(38100700002)(6666004)(8936002)(8676002)(2616005)(86362001)(4326008)(52116002)(7696005)(5660300002)(316002)(6486002)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Eo+NWgrORvWEQVXfAbnOOP/EKpsJhUE2fpCN2iMF8xJ9WlgfQPXQhEzSUmn?=
 =?us-ascii?Q?sI7mCrEw4KXDe99mSNBDBEXbrekV9eLZQUB3yNOMuapbhZN6taezhOlZPjfT?=
 =?us-ascii?Q?HJ+CdPODiqG/KvUAskA9e64TVIHwGgRPbeFZ/RMciteexqyfrYqSpd+24YLR?=
 =?us-ascii?Q?LgZlmvRP8Eb4LTx60k6kprgk1tbJZ2XoDbSdCaj25bij01PKjZWSqgUbpLvn?=
 =?us-ascii?Q?o/roX2ImsCrvLPXvjRPz1/MJrADic4B18DI0sLQN22H8CTjmbI5kZLMM41IA?=
 =?us-ascii?Q?JFv5QFa3lj67v7bLJxUT7zCf3q5KW+AAS4BxRVfVu0J68yXL3G0Z/AMQg+cc?=
 =?us-ascii?Q?SubkJZd+vbWqRUtvdSiHK9lQdX0rQ4scngqclASGJ7F1U8iiB+nVxzJtx38l?=
 =?us-ascii?Q?bWCB3BDCRITYPtWvGshCx4NnrGmmqtejXSMbPfYAApC+j0zEs6eaxO+x8FPy?=
 =?us-ascii?Q?J2iJcnzvXkSccExb8zcOE8VQItuVLguvzNnNtpncQitZAESohrv9KWmKZN+e?=
 =?us-ascii?Q?m7sXlCttU+DnCBUm9SOqYpfik/oMgKPfxm2ZvkvEfnQNIQTWpypIQ3BfeLWM?=
 =?us-ascii?Q?DAP+D83jM/gxOOQrKEIMowvE29e5wHTyNt+js3Gxpm6LBW8H1IblV+m2yg2D?=
 =?us-ascii?Q?4p3FJEqwsl2L8A2Yu6vFvihlo8XtQlvk2JV39hT/Rm+ZVvZgKHiobduxFvL8?=
 =?us-ascii?Q?qNKnx84aDumaUVHdzBPLroSwVFZIAQfqzutMHCS1exLRYv5yWq6DVbwKuSzt?=
 =?us-ascii?Q?QX2TPQzLXO+5DH8TCgYwQHRL1uDmE7XQaq9PpytFciIMTXKwzLSY7FMh4aDe?=
 =?us-ascii?Q?DopStvWTNrmVWl4mkaarYzZgzlcXXLeQ9cnk0vd3O6Fj9Mcs5w/hMSA/2KLK?=
 =?us-ascii?Q?TSkjN88PleImBfQ5oP8hLrOZQ2aYej575S2n4jy6Axl5qlkVeLeiC26zRqRB?=
 =?us-ascii?Q?YwDkh5VLMPYwHg/dHlxp8YwjE14jDq+BbpkJsG0HJ7YF8oVgR2RHAqETukcK?=
 =?us-ascii?Q?ZuPjoppF25hXqWej2sBYptrUgEC0lTEbi4vfBVUsDqYfZmIdragVhe35DCbq?=
 =?us-ascii?Q?f/k+sCm5owmAw9INf+tJ5JN1YIliN9d7japKpypwxDw7nBmDdwBf/jG9Ol5V?=
 =?us-ascii?Q?awqGDve5xbKxCKsgYl3/6FMnQNpXFfLN5uUHop4FGdd7I6ceirr2UujDTadf?=
 =?us-ascii?Q?+cUEMfI1XPEZfVawLO8o3iFW9Rgz5r96eVVF/O4iPkKhUPv61xkE0FGSRFlr?=
 =?us-ascii?Q?gsreQMMLZgzHtPaxVs0Ihaq/eC6fanGdOlsOPgh1Mxh+pVIUMPIn28HlN/w9?=
 =?us-ascii?Q?oYbNBBokkKNoCboz0bDQSM7V9AWAgsjeDZJUoUBDazf9vg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2cfb64-ded7-41e3-22f7-08d94a3fa899
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2021 22:59:12.2585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lqh89soVIKkADaZfbQRFJIyvykgyeougYoS16Z7IirpSNcI4PNlysk4TQCn/21BDNWoJHW81xraAwpKccLYYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2968
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10049 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107180156
X-Proofpoint-GUID: i-Qhjr2EQ4Pk_ZYKvBc1XplIZDPyETAU
X-Proofpoint-ORIG-GUID: i-Qhjr2EQ4Pk_ZYKvBc1XplIZDPyETAU
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Rao Shoaib <rshoaib@ca-dev141.us.oracle.com>

In our internal testing we have found that the
current maximum values are too small.
Ideally there should be no limits but currently,
maximum values are reported via ibv_query_device,
so we have to keep the maximum values but the
default has been set to a large value.

Resubmitting after fixing an issue reported by test robot.

Reported-by: kernel test robot <lkp@intel.com>

Signed-off-by: Rao Shoaib <rshoaib@ca-dev141.us.oracle.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 30 ++++++++++++++-------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 742e6ec93686..d703a54df4ec 100644
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
@@ -58,42 +60,42 @@ enum rxe_device_param {
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
 	RXE_MIN_QP_INDEX		= 16,
-	RXE_MAX_QP_INDEX		= 0x00020000,
+	RXE_MAX_QP_INDEX		= DEFAULT_MAX_VALUE,
+	RXE_MAX_QP			= DEFAULT_MAX_VALUE - RXE_MIN_QP_INDEX,
 
-	RXE_MAX_SRQ			= 0x00001000,
 	RXE_MIN_SRQ_INDEX		= 0x00020001,
-	RXE_MAX_SRQ_INDEX		= 0x00040000,
+	RXE_MAX_SRQ_INDEX		= DEFAULT_MAX_VALUE,
+	RXE_MAX_SRQ			= DEFAULT_MAX_VALUE - RXE_MIN_SRQ_INDEX,
 
-	RXE_MAX_MR			= 0x00001000,
-	RXE_MAX_MW			= 0x00001000,
 	RXE_MIN_MR_INDEX		= 0x00000001,
-	RXE_MAX_MR_INDEX		= 0x00010000,
+	RXE_MAX_MR_INDEX		= DEFAULT_MAX_VALUE,
+	RXE_MAX_MR			= DEFAULT_MAX_VALUE - RXE_MIN_MR_INDEX,
 	RXE_MIN_MW_INDEX		= 0x00010001,
 	RXE_MAX_MW_INDEX		= 0x00020000,
+	RXE_MAX_MW			= 0x00001000,
 
 	RXE_MAX_PKT_PER_ACK		= 64,
 
-- 
2.27.0

