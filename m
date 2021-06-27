Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DA33B525E
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Jun 2021 08:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhF0Guu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Jun 2021 02:50:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51012 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230051AbhF0Gut (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Jun 2021 02:50:49 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15R6le0H031729;
        Sun, 27 Jun 2021 06:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=fooMx7WBOS/aanX8irE85qe45p9K5Px9Z8HRLrQQ1Mg=;
 b=iXvYnK5jw7mInPrlXFo6RJrPPDdpH8YS69khTkCFXt1PzAyd44E34pVTZCWuzpbIvV9I
 aJvMwVn6DtIffZjNDaxe9tQxz+tIVJgP63cp6crtVwzwg7umQXB6NFQVDSpBMFRAhe9n
 4SZ8/eL1ipq8TUuOu3c+2GQX7B0d6iuoo8+ObGZ5vPkhedbMfSoRrW46m37aCajJu1tz
 KEMquFHJuVJ9Q4KEanwFdex3GeI2bllZxlwku3xzE7hUpLDzzeQpAPpifoBDSZJR8gnh
 M8/9QRfR4ogI7ttVrDEjDseMP/uWkQ9m4hOoHBaWd2xbqgYbcHxCL0P9jGzqqCdDUXqD sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39dv4ah2nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 27 Jun 2021 06:48:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15R6jVCk091536;
        Sun, 27 Jun 2021 06:48:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by userp3030.oracle.com with ESMTP id 39dsbte86r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 27 Jun 2021 06:48:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrItG52SiRBgzV7l90v9ny0bFpfGCXvGpfOZ5CWq1wYGnHUY9zJ16wLdk4fmn7r79ADq+/9+IZmmKWmUGCHaC/5qbbY5+OC0xjAu/C3S/rxtGwLgM9w1CHAmNZ3rK+hhCEHaG9S9OuHWRZg7WtCpSNyRCuEnaQd8f4Jx++yVtpZopP+0XzMoDs5Qe2/fsXVNqwS1h5mUSFp0Jw0inr1uFwSZnV2mXP061cGlFqpsU7YwXKRvuYd7PONzV61Q8YHDAVjd7cP33SpfBJb7HddlsRijv6CvfRTROmplseKUyqMD3GwN0UpH5+OOPJJjaniEx4tfQFwhQeMtqY60hT/uYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fooMx7WBOS/aanX8irE85qe45p9K5Px9Z8HRLrQQ1Mg=;
 b=g3BQc14CskTtGzEyL8YzR4slH+OfCF+ZLMoZiuW5kZqGiLd5dPU83kT9YbN1EYgUXZ9c6/ahN+TU2nGY1FyDJr55NRHtyNDX4swK3fK2ES5NZcxmDe/EvtYPrbEbax1KPzS1KCEvagoOBFYZSfNwpUMuLVPtIoHzZ937LyOSf2ozHySs8zeGI/xgSdtrb/vnlCyAmE60S2KKlgbLDrl+mbCMMwZ4djRKaCr4BL5ZxdpEfzqk8F2hliAfc+J5UG1tA5qCj5SrpCT2DEXaUqVGZCjhfK366GcLiTZqGvRa7FjI8eefUHuI9EjbS9P1B9ZV8vAMJDuPq3etj3/ZvO86Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fooMx7WBOS/aanX8irE85qe45p9K5Px9Z8HRLrQQ1Mg=;
 b=njsEI8hd5MMDc7qqcoUcv0z8yqJ6Ugx31WQqEWxJXyrX49TuHWlIAv5fU0QubJst9NBdBjOdV6oCxFcnjpWtOvm3+TNyjTeczuD0bVSj1SwNmSaiKAAUBA3LxM4ubtGTSRTjk1jMRQhqyvQOngAz0/8MJFytHGuh+ZB1b1tQW9E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39) by CY4PR10MB1704.namprd10.prod.outlook.com
 (2603:10b6:910:8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Sun, 27 Jun
 2021 06:48:19 +0000
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::19cf:f38f:51e0:a5f4]) by CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::19cf:f38f:51e0:a5f4%5]) with mapi id 15.20.4264.026; Sun, 27 Jun 2021
 06:48:19 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v6 for-next 2/2] IB/core: Read subnet_prefix in ib_query_port via cache.
Date:   Sun, 27 Jun 2021 12:17:53 +0530
Message-Id: <20210627064753.1012-3-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210627064753.1012-1-anand.a.khoje@oracle.com>
References: <20210627064753.1012-1-anand.a.khoje@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [49.36.45.114]
X-ClientProxiedBy: SG2PR01CA0109.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::13) To CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (49.36.45.114) by SG2PR01CA0109.apcprd01.prod.exchangelabs.com (2603:1096:4:40::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend Transport; Sun, 27 Jun 2021 06:48:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a62deb6f-3743-44c0-d1cc-08d939378c36
X-MS-TrafficTypeDiagnostic: CY4PR10MB1704:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB1704875A185C38BC60269590C5049@CY4PR10MB1704.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECNPUH0OFfteoZ31LXPtB+g5tP6Cna4njNNqOu3B5WPLfrLkpNykOw5f9IVTxlGasACYnfGaR5CAfUHl/mwLXYnQlOI4F3M7C211IwIPtw5hHopXuZvfj4LuIJtbxr+UjsySgeEmHiuy714v9TQyJSdHfqQz+VQ6PCgyFZW+G+dZApyUGUI1BQ9rbpoRj/SOo4M3JAlZDit1ibTkWWEjRLMw1fieKNj45azjDORxtAZTH+hBIoM3EbxTvydSATMNBncq/M5Xs1rKSTOAt3PsRaem1ftyvTTQ5VfwxBsptHZra9RJTNYJPIoghs1QJtbpCKOyukVSm5y9GCj7eBzGsxLDDuyVWdjMoZ9hqBEGh+MRSTwxZ9vAZIUIqLmgsGO5yBL6ljgO9WbdhE7FnlpqatxRbMTnS/AUbI7z+GXQkor9wVgyB4nSMkniwRPQyuYOn63ScX1btqNwD5Xwy4VKblBiIb3DukTE+ItnpNqEM0XwvROQe5llQi5lGKiWuDhHjjBphlAp29hvP3OSXt1xLdLcHdejhkqPq4MGaknYFJnW3/EsWBv63gxjMtMsv9IMp+CMykrndW47Mk/TJ8DtFUr73NzIkUYiGYyP7BPIMMIXCTjihht5G8Xq4qIMuGEpMJ5XesC4nbkTgnAadX2Ji8Aq23eqRsS/4E5TpoG3rGti8jzYbDuPLRhlDM1o+1KVPFKh9of/+HpL54lVMRn73A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2086.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(396003)(39860400002)(376002)(6666004)(2616005)(8676002)(36756003)(6486002)(16526019)(66946007)(103116003)(1076003)(478600001)(1006002)(4326008)(186003)(86362001)(956004)(2906002)(66476007)(66556008)(7696005)(8936002)(83380400001)(26005)(38350700002)(316002)(52116002)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WEVLeJMya/w5o051aAFbQb9Divf4D3F10xggOLnvIa4Hk3jez8V4OpxmDmGK?=
 =?us-ascii?Q?vBQKNedXagHU+7OcxL09hVLmViOh+6ZisA1rglOOPN1nN1MwEUxuYmwfyJHd?=
 =?us-ascii?Q?glnOQDwnd9ZC47AzEnrrNhq4+uHv9X4BIVv0tobdVpysgB+Gj+rD7aPTPi35?=
 =?us-ascii?Q?bhzk70kYRfF7jeyuhnBGubCy3KPHFKDhm9OD9tZpeKZchmgFlC+gXM+80yol?=
 =?us-ascii?Q?D+U/+4rJmC05GLru276KM5s0ShoO4083vFZK+rMGP0INfaAlfQ62CWSTiR0w?=
 =?us-ascii?Q?F2EqdK3/Hu3QiO8gPJiPtIOszzDHcHhetUzsFSAiNybll8YcfWf3jK7RskHc?=
 =?us-ascii?Q?iocQ19Q3sAB2ILheV1gPdPiZu++nNVhhvAdHAftFp6bKiisovXwpyLhNfyuo?=
 =?us-ascii?Q?AZU9ayZ/NNVUCtde1UlZOQupicxfvGlEHeVXhksRL4syDXKY8Lcsx5tPkXiF?=
 =?us-ascii?Q?LhC2drK/ONpfodUVaO9SmSFZBduIKhW19w2iAflxVIxFPVFnHBE43i2z/n7Y?=
 =?us-ascii?Q?QhLSN9b8Zhu7n/6vL/m5KSvWgG5i/2pTmvN78+4BxIg6VyCqa67U8x4TKcOL?=
 =?us-ascii?Q?rjts1tqetqxTjQ8bAUZtlb8K0S4OwXYBs0//QFTsSKsaTxw3guQO229TFC/p?=
 =?us-ascii?Q?J3kcZpFjYJWJ8X8T9EdrVXWtr87+LDutb+GV/tDchU+jqzrPCppt9Ss71u9z?=
 =?us-ascii?Q?aBhUadZjZcCwmKB11VnWQiaZBwXsfRHE3PubizYvKaTD6LXy2UFXcl+a4wSg?=
 =?us-ascii?Q?bv8FrphwMJvB8WsGPMJJfSxcWirOKRaPgzPLS/wmxX2NiQB3Lyzg2J+JbU3t?=
 =?us-ascii?Q?PGtIPabVZfqW4iJnoY2ZZRmDlFagbAwrA6EH+zjTFmGrWZKBIeyrZKjbKbpF?=
 =?us-ascii?Q?a+Q6y0BJirbK01/Ev5ZrUnFkNceLTwi/P77MoU8OpK9xE7l9N2VHB1W88YzF?=
 =?us-ascii?Q?ywwGQBUUB8Cxt1BaY3BXHZvQv1jbUr2MBz7RYjmx7XSm6m6ShnBPjrjdyw/b?=
 =?us-ascii?Q?J2MDDbHKDBJreQLlCXhzt2qnYmThwZIHMSvOehXNCUthVnWPOc6gKs8pWHrf?=
 =?us-ascii?Q?BMsEnarjd1scFWfEQ0UDtxNM7IxoxnqzQl+5apB9Rh121M8O/HEZhr0l/cLg?=
 =?us-ascii?Q?ZNO968p94bshYDFhszdKvsifJ/Hhb3VVfi0fgGlqMII+PltaWnRFIECms/J/?=
 =?us-ascii?Q?+s5kq4hEvf0xQV8QMOUSi9xhdTxaD6p88j4TtNl15MxnvCdQpKb9z2DTX3hK?=
 =?us-ascii?Q?iVYXzeNFh5S2MonHS9cp95hCY1fGafovjyH5kiWQV8OxI/RGMXsKWMTsGD02?=
 =?us-ascii?Q?02WPJM2xU61VvwImIroqbdm7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62deb6f-3743-44c0-d1cc-08d939378c36
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2086.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2021 06:48:19.2330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjTue/bdg4OCOeDcu1k50m8FqxamZgvb7q3rT3I8AnuCpqlygeC24ETGwDr8khDn36JLSRJ0e1zXdZFnnBEHnTI0tPOnXb4OovS6weQb9Ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1704
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10027 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106270048
X-Proofpoint-ORIG-GUID: v70_UC-1K5shYghl1kgIwjewFyKfpKKD
X-Proofpoint-GUID: v70_UC-1K5shYghl1kgIwjewFyKfpKKD
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ib_query_port() calls device->ops.query_port() to get the port
attributes. The method of querying is device driver specific.
The same function calls device->ops.query_gid() to get the GID and
extract the subnet_prefix (gid_prefix).

The GID and subnet_prefix are stored in a cache. But they do not get
read from the cache if the device is an Infiniband device. The
following change takes advantage of the cached subnet_prefix.
Testing with RDBMS has shown a significant improvement in performance
with this change.

Fixes: fad61ad ("IB/core: Add subnet prefix to port info")
Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/device.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index fa20b18..9ad10c8 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2050,7 +2050,6 @@ static int __ib_query_port(struct ib_device *device,
 			   u32 port_num,
 			   struct ib_port_attr *port_attr)
 {
-	union ib_gid gid = {};
 	int err;
 
 	memset(port_attr, 0, sizeof(*port_attr));
@@ -2063,11 +2062,9 @@ static int __ib_query_port(struct ib_device *device,
 	    IB_LINK_LAYER_INFINIBAND)
 		return 0;
 
-	err = device->ops.query_gid(device, port_num, 0, &gid);
-	if (err)
-		return err;
+	ib_get_cached_subnet_prefix(device, port_num,
+				    &port_attr->subnet_prefix);
 
-	port_attr->subnet_prefix = be64_to_cpu(gid.global.subnet_prefix);
 	return 0;
 }
 
-- 
1.8.3.1

