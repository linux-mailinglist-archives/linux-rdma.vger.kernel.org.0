Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E52D40BCF3
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 03:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhIOBNv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 21:13:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:3652 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229586AbhIOBNu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Sep 2021 21:13:50 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EKxd1x018637;
        Wed, 15 Sep 2021 01:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=h6Eq9xd/+5ccN9w6DIZHmJvckm/3OR2CcesAS9BWVpY=;
 b=ReIcZ6E/Iha1if9E0Z1/OmkHQsLNW2Eqw5GiBFKDd3GhxHT6QeXvBmYgxD8muM1ZfDun
 o9HJgc2EknzuoEEfCuB2WViZUE8fXfqqHbDAqKI7UiPFgL1xIxah0daaQJhsYwMWcULa
 sfWEYRwGJTd/O2LPCl+9JohEk7ztzaBQDz3cs8Yd8txPAutHTnuVtms0wKY+LzY80rUO
 WwklSZMiRyA1hevE3JobylIeICfd1uK3f678q6kWbwJ6K2+2QDVl8QIrJcS+mpyH/+LA
 7TlfV0JroXkSMZqILnBrNPw6Oe+A1v03yKqEAsX7Drkj70yjR6ByIZ9XEDPa8XRM6nfa PA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=h6Eq9xd/+5ccN9w6DIZHmJvckm/3OR2CcesAS9BWVpY=;
 b=JqJAAtiItBIDgYye/xa3o3ztegkd59kqYopCOQjitY8+tRMWzmcq3dbHShPSAvFfN+Xi
 AxyvzRlhYa5KgZ9sc7zujkvJM1RsAW9jSVR+7Rw/gPVjfQ4oYpmc1apuPw5EqPbs8xS5
 JS37ElEQECeArwKOupVuT+wWPi3Rv/crCo59X3dvnuMsIJWuzqXkKbOsW/ysHPuxWL8f
 4Kq4RrLu2GXY9HyQ3PJi3bAuTBP9pCy42///P6T+l1oqN/d9W58uXlodJ5hfKAyZN6kD
 r3w4Q2kRH4D39vBWl4LTvuTzyFf2dplEFcTAjrCmAHqUIloOnGgCO5AUw2Ym2Ik8ZAgA BA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2kj5upbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 01:12:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18F1BC4S181550;
        Wed, 15 Sep 2021 01:12:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3030.oracle.com with ESMTP id 3b0hjvxb0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 01:12:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZS0KzeFyDwPcUacw8c2eM91MPlpAkPZPWZ3ldutpIRJqKB3Nq77QUYaIizG6px6P46d2cmu/qYhfWD28QY5G98GoTQOIl6UmFeDhnNAYZrEQ1vMM7heAGUbGW+PIVloA/sCW5pDUkR14FUnhZnTYRJaQ2+KKTihOQdU0IDb4nmKWre8KhGe4CFRVBXTmwd1ADfkh3RkikyHSX4t21a7XmFDzo6jtFeFJ8llR++4fJNLQRG0e8Z7k94DpE4qu9mkBkirdm65EIXO5Yz5ff6Fu00NV9NDqHjJmUFFtF1+/LBez5WMEarWAXtucNzqmU0VZHwLP0l3aOLM7+eo9AED3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6Eq9xd/+5ccN9w6DIZHmJvckm/3OR2CcesAS9BWVpY=;
 b=RghBNoJ5CfKzWZaQu8pChWbP6q+6ptqJpAJ90JMA+AvzrDsfMbUbd0ZEiTVp6EdYuJ/Q8aLq/CmU8695dAZ2sUwqcCU7EQdEfDszbE6X3NQEkFyN5tPOMDK1K6NmXD4ANMmynpVjyTX74Ni7dypoVMG6DtJw/mDUleB8P+pHwH5B/lOfS/KMiLhqwBWKosnGR948MZcJdza+TWhz8MuEl3zPqSkAwlWO0cMLGMQc5qrL83yuindNt3oblUNzMsIWpmHuOmYRMzQPW4atNpyBHgnLVpwnRyrHLHli0syoWFL2Q4Wohrg3dGVy3QRpDdpe7TQ2QUjTR+UDz4ytRRy00Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6Eq9xd/+5ccN9w6DIZHmJvckm/3OR2CcesAS9BWVpY=;
 b=NZzDscCvIrinRNInAifooc3oq29ueQt5nZRvvOVjH1gOZlDU4dm0+wzOGbqw10w7A3qePijU5Le99uGBGJRJszd33YIWzYQJ4buybKK9cE3TboN1w4SvtCUzCu1q1bjtE3VnYb+lL3JNg/cLaVk7OZSwW/3RC/OVW9Ajeq126UQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BYAPR10MB2439.namprd10.prod.outlook.com (2603:10b6:a02:ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 15 Sep
 2021 01:12:28 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457%7]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 01:12:28 +0000
From:   Rao Shoaib <Rao.Shoaib@oracle.com>
To:     linux-rdma@vger.kernel.org, jgg@ziepe.ca
Cc:     rao.shoaib@oracle.com, Rao Shoaib <Rao.Shoaib@oracle.com>
Subject: [PATCH v1] RDMA/rxe: Bump up default maximum values used via uverbs
Date:   Tue, 14 Sep 2021 18:12:20 -0700
Message-Id: <20210915011220.307585-1-Rao.Shoaib@oracle.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0701CA0035.namprd07.prod.outlook.com
 (2603:10b6:803:2d::25) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
Received: from shoaib-laptop.us.oracle.com (2606:b400:8301:1010::16aa) by SN4PR0701CA0035.namprd07.prod.outlook.com (2603:10b6:803:2d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 01:12:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 564b6997-3bd7-40f6-3e2c-08d977e5e26f
X-MS-TrafficTypeDiagnostic: BYAPR10MB2439:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB24397FFED58BA042F8A800C8EFDB9@BYAPR10MB2439.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bcj+7IgzDz/V1Ijh9qJGgZHHSTETE9twAy4RkqxyWlqMnOekmu/BJYOf3pthwXFps7RLfVXg1NTrkehl0entiHKqK6k24q1dzzWAHo9HqMKJK4fHzOqOlkTu2NR3kSxkDysvthECsLE3QoUsTIhjEUtmtUCiIJ74WoAlqnQkMQA/pLDKAwxy8BLtz/YAyjX8iAsXXqS0IXpkBdadAI9CUlRGaMv+epz+/vT77kw2HUgCzENX+bLAtHH6B/hpFgxGo/AHEwYrXNqJnx1v39gNwgfk+p9+06d4Nz1xHkwnqCQydH3YMyQzHVTJHV5OG0UjbAbFYR5O+YyOQzIth8aW2QGlncPUR8rCO5f8fm2ZTetUpoDVWZ1b8N7XUycmQwvpkPJovDM25KPS2C18AhlxlZ3mwPCFpc9ce/ERC4YXH4f/psUnf9LVSjk2K1hq2Lyrn5VfNgTz1ihHdKnwGNN1GKQTJE5RZHaSZsRbcUoQQ/zMQQO6545l52Wg5StBPTQtrwMn3/Go5VyClJTkYducGJgN4vcTcLiUGlDFnR1/klly0lxs+d+3mHnr7WTYSREYUdF3im2q4XjRtQopMSw1oYvBo+y0lwGwvEJsqJuO+xsTDfJhEWD4bkIRxblOa787ZJFqjPF6GoMEvB7BRDfU3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(366004)(39860400002)(136003)(1076003)(38100700002)(478600001)(6486002)(36756003)(5660300002)(6666004)(2616005)(4326008)(86362001)(316002)(83380400001)(7696005)(52116002)(8676002)(107886003)(66946007)(66556008)(66476007)(8936002)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hh0Q1wKzWazN4tzJrO1nUVCGwrfOe67l1CF3+l1R8Wg8e4CQre1u/Ez26Lhi?=
 =?us-ascii?Q?JJxWSL+WF3/nodJFwnq/dEqYXhlS5dY7F7ulGgjomLtBJJ87BS+Ay/3tzSMI?=
 =?us-ascii?Q?kGSqhlnbv/tJsAmdJyd6/J+4KDgfP+kQMTWl/h1OhsbU3GOIqYBgDgpXQXeE?=
 =?us-ascii?Q?tfQhaF7btAqhbsErUrhSGsJfc8NtJgn+DTkJ9fj01TEiVTyER/rMMlA+8L3s?=
 =?us-ascii?Q?zT4VvDR1SeJx8HumOf5MqjWmgYBHMCNGuame4iy1BvuRus7VRI3uPhDnfIMM?=
 =?us-ascii?Q?YFDMVAok25Ijyf2f7x251INBk4CXARatRBxKj9+Qp+52hBhRaTReK5oamlvL?=
 =?us-ascii?Q?1TSX3ktI9daxADlPE9PwYgpgMGowwDMzZkRxspgmsiQPTTMLIGGUzNXUG0bT?=
 =?us-ascii?Q?z8//jFEuSPCPBoJA0W2XOaQrZ869GKh1L1amuc4SEgNnnjwRqhqKOk625zUb?=
 =?us-ascii?Q?R/2sTbx3a2Dgk72f+0E2bzlqV2pIX8f6c+XB9v5Bs19Em/qP0971Co/fvy9g?=
 =?us-ascii?Q?arKUFVYvSrRK2dusDKq+Am7MR1G06BQaHkIpf2i7sgYUvl2WyIxBCv29H9iA?=
 =?us-ascii?Q?FOqY98QYJ3yMvSycX8zNBiJ/cySs7tdat2OQUPgazO636AzouSuzMybQ9obt?=
 =?us-ascii?Q?FczxXhb+eZ3JpvNxE4Bo2x1M5KVDCp7gTHhLgoT5p2RZ9uGV+JZnYTHD/5cz?=
 =?us-ascii?Q?hxi7fD9gQidMoFzY9YehWSguc777leah76a8wrePJaKT96Awv2s6AarStldz?=
 =?us-ascii?Q?zYzSs9OMWH5MydvU2fAehf3ne2/de2byD3q8S6e597p5BCUZd4mcdW26WSlF?=
 =?us-ascii?Q?RgSCnhMkjwhzufmB+DlnMUXKCaWCu/XcPN6tKnAdijhwnn7rkzC7TeL/unrx?=
 =?us-ascii?Q?KVmJ2c3ZLQLGbKdTaL5etVDXYnPKxiOJrWfRJ1KD81oeIv8ndXaA1UXxylyQ?=
 =?us-ascii?Q?SMaddq6hyAVLRXFM8xGARYbB3M09WesIItH48F9dEUX9w6pXgupkpoDetgFM?=
 =?us-ascii?Q?butq88rqGNYqs4nvNuD5HH0us0kPHOKGjzTv8nL74Txm8fLN78TPpx97UY/Q?=
 =?us-ascii?Q?nvg3wyowcidcVO40OAq47aTTMeZqs8tBq+MeFif6s35/Yq8pZtzfW+Rh/noE?=
 =?us-ascii?Q?JbnQMLk5aY7MA+GwzHUgJpYepXRCOyOco5VYPNQp3UiZvWpdo5rs/ynz5TDm?=
 =?us-ascii?Q?+Bf/v4+tuYAfPm0MNF2MTS5fFP2JlpBzlZsScEDkfLVFlTHHF9tMwUOaXQVE?=
 =?us-ascii?Q?gCXndi2pihM2iWkBj3vin42nnwzeaYRMv5D7u1C0KjfZL8LRLmGjBzv7N1dU?=
 =?us-ascii?Q?JSUNGGHiETs0SN3NcQj7uImJ8CfNJoHG0se3AOT+9KFVkSeXH5TeGqDxdBaB?=
 =?us-ascii?Q?/ayYIRQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564b6997-3bd7-40f6-3e2c-08d977e5e26f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 01:12:28.1913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AthXZFmx0XT8FbsmnS37fQYYfGhuBsubvRp8WmxldO2uaV9pqQlrzMtGIEXVS77pH+ab5p/1ohQvlq4qk7riFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2439
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109150005
X-Proofpoint-ORIG-GUID: dSrsXJCUOZ-dYeiExuf8e75q6fam7r45
X-Proofpoint-GUID: dSrsXJCUOZ-dYeiExuf8e75q6fam7r45
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In our internal testing we have found that
default maximum values are too small.
Ideally there should be no limits, but since
maximum values are reported via ibv_query_device,
we have to return some value. So, the default
maximums have been changed to large values.

Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
---

Resubmitting the patch after applying Bob's latest patches and testing
using via rping.

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

