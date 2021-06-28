Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77843B5B42
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jun 2021 11:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhF1JcM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Jun 2021 05:32:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37722 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232152AbhF1JcK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Jun 2021 05:32:10 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15S9LOF8007220;
        Mon, 28 Jun 2021 09:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=2jc2HTXzMepww3QH2bWX+3YpvCGaGqs+ihG1ComwaOg=;
 b=CwCxUexiPlZ2s7xmZ/9eWF66k4SrbPRqJE2EEyE8cuSPPWQDhHwJSSDB6IEEtlCZj+R0
 DGatZU82oG75zT3YQdj1XJST1ypfYKp4L8Qy8Ip+9S9ULviQENMuOv1YrhemZKsSsQGv
 I8BrkjV4nWA1X/xoItQelA02LfWN+VvUcCdFdvaQB5ETc/ASA5nlSYjbO+1fvrufno9j
 WrVZCYctY1Wn2aymCoTojzlE1ulgFFOQreXL6NalUVpNcfQetwgfPH1zwKrHmTrh+iXL
 n1mbG0ODvxTP+Hw6jsseip5aZ8aUUT3M1y7jPaR2kwSQxe7V6HSQ8qCJ+5rqRsLuqIlU MA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39esfks6n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 09:29:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15S9K1KN126863;
        Mon, 28 Jun 2021 09:29:41 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by aserp3030.oracle.com with ESMTP id 39dt9cfgu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 09:29:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cusM2iPTNqDaWa+/7gqwg7pfwxRemjAdPTnouUK1COja14cVTKFSX2gg/SwICm+POqQbceg8lmeT5DcsbYre4CryMH4+wb3iJoJAOdys4TMiR1JwUGwcaQRO50JqGrdiRWwvK0jI5udTeOhXeogXKTe1ulnfXCEAepXffNhzMfci6s/+2yP1ecNkKQFvJpkQZ4Rw+p3Ezr1ILvelp2Q3NsTJHTDcmmoZrslOmDKSz8SAzdj55zi/q5CWeJPwXKqzOKNWrOu+JEEGLSybuBZppCSwdF1Q90B5Nt5nV6zX9Ajpp7P7fIMFYGux1d+FqBgxJdmfKMNlIi4sk7v8pIWmKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jc2HTXzMepww3QH2bWX+3YpvCGaGqs+ihG1ComwaOg=;
 b=Pi3DIxhePxg2TJZdKLZAyOPBedLXlGjVp5CqceW3ZKiX2QKOKHdLxldZ4qdo2fFSCMTYJhMa95Zb1bo5TMPsnoaWQFDIdukBMqXOGzGQAExDv/AP41nc7G7hyoEdPkCXqpbBYP8OG7D4zLFu3+o98A9jRWHDC0i5e//rAODXm00s7Mst0qaLftMlzVdRNiWEpWAtuM/QLGidr5bhtMMvdm86A7KH3LWV/UISC2iqoqYpspqgA+0yeWk4Ywkr4Cp+93OK9t68U7U/j47cPhGGXLJmZVJ9Y+e7tstX3sDp4foIS1DMDdLlIypiSv8N6znTQtKQr1gGBNK4lIXLJwvGnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jc2HTXzMepww3QH2bWX+3YpvCGaGqs+ihG1ComwaOg=;
 b=f2qAIUM7ajwttWfBjefGCUTX6LUB3cBg7/UfWBVfZe3DCWi40tIEdBXH87Sd6DNYK58DlUs5bzrGFtqfzSUGFeluxfucmgd383XaQnLUHhV/TSC3Ji9UT2Vh9kJR7k1QW5i020FEZylZ95yJA2SlQMJEOhw1rD5lXpGofyvZGrA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39) by CY4PR10MB1607.namprd10.prod.outlook.com
 (2603:10b6:910:e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Mon, 28 Jun
 2021 09:29:39 +0000
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::19cf:f38f:51e0:a5f4]) by CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::19cf:f38f:51e0:a5f4%5]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 09:29:39 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v7 for-next 1/2] IB/core: Updating cache for subnet_prefix in config_non_roce_gid_cache()
Date:   Mon, 28 Jun 2021 14:59:19 +0530
Message-Id: <20210628092920.1088-2-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210628092920.1088-1-anand.a.khoje@oracle.com>
References: <20210628092920.1088-1-anand.a.khoje@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [49.36.45.114]
X-ClientProxiedBy: TY2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:404:42::23) To CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (49.36.45.114) by TY2PR06CA0011.apcprd06.prod.outlook.com (2603:1096:404:42::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 09:29:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 376678af-6904-4b32-745b-08d93a1740a9
X-MS-TrafficTypeDiagnostic: CY4PR10MB1607:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB16072EFF48F84C1F85C6A222C5039@CY4PR10MB1607.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H8a++wa4XUnLnwVuYKVadWqhw6u714z4eGnZ7AMIaSuKaxcJJ/2mYjNzSthn0BzSHtIQ8uPMc0djVaDepGdTFbZ1y8u+ryCpfGGEGvB0naFf3PmXPfEkNO4bIIdgbRHSIPuziUYAbLODRpN4RLINOt/bQ/l155EiXX2sJBMCD4XW1C8OL/+U61rj39ch1BiE3+ZhnrxYT05xeZ7K8VIXafAERg1fMq44bMdX7dGmc63+cbMesYDnR0yB39W+SDpvpESL+KDF9z8qSK2SHTMHSx++Xd5TJ+APMYmuo9vBHnxzLtlJbp2lhKDvke0+3raD/Mfgjw+uwdlYriOoMnWnbLckiKB9QLll7B0ew/JjOnYHK0wVVPGkhVmxCbziQUVJxUcK3jE/pDU7/bCpsvngebJ4NTU3KjYb9rk+a5vDcJnCWtp6hIMHWEQ2maA8jrko5+kwp/JhBzMwLZOo1FRGMMZfw+y9nDrB0nTjI/fgvGnPTMXRw/WTdJlSNm58f4r+R/ZETKv7MEboYJrkr5xYdkDp5kJ0TOnNjX+/kJizKeB7KZvjCjqJiTOGo68axyYVaFnaPmJL1OI08bP6h6H3lKj2P5rOkonTgMFsac19L9PlAAuXjl8PlSDPLFrXjrQ1gGiZWg7HVI1uJX+pvHm07lxr639x0i+bDe2CiEO67beGaIRGBulXe4bPmOPKU++efbBNklyC8LyyVjo0m4c2+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2086.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(346002)(366004)(136003)(6486002)(8676002)(956004)(36756003)(2616005)(4326008)(7696005)(103116003)(478600001)(8936002)(5660300002)(2906002)(26005)(52116002)(83380400001)(1076003)(66946007)(186003)(16526019)(66556008)(66476007)(86362001)(38350700002)(6666004)(316002)(1006002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yww44T9epgdy9pkpstCO1KT36cZ5L1GPKbTC7RG3f3x4KJbX7a8aQwQ/S92k?=
 =?us-ascii?Q?VwDH6d1ykEezECX/hv+r8+FXl4uELcNE6w8Y80NQJvI+wettHngqk8zRu5lc?=
 =?us-ascii?Q?lC9rAYexbpm7ThBhuBI6fzvQKWfyHzeZhTT3qHf6e01KNxVnnvPK4CNUCyhX?=
 =?us-ascii?Q?4Vd0uX/DlrZcxvWx3kXildM3Ircd2zKFq5moqtIYlh/8PEAnJYD/OVONoUg8?=
 =?us-ascii?Q?FfuLOcpa3jAfw8gW3QA6cQY7ZSE5zO+krhwmQ+ZGuv7aC7Q3ACdiXzwklEWy?=
 =?us-ascii?Q?8s6DMgJxU/3hLTdQIBAe33guxMV2LHIHzmSM4okSNf/5qJGmRi5vMRCrHD5/?=
 =?us-ascii?Q?Qj8g1lBUY6UMZFnJwSXPwzZsP6pXGwm7RKzX8lE5juLsjvVVa1LFp7RglK9G?=
 =?us-ascii?Q?91VEWutLVQNyAbCsDFif0G4y6gObkgaRhie7+nM8M+Agr7uEwr4NcuHgm9nj?=
 =?us-ascii?Q?9gzcELKBYUV9VdBJZYw93Ou+6sfKqiq1n0rndnmqoN/PYnNamN1ACaJpNRtH?=
 =?us-ascii?Q?ZHI3NpJh48GZg1zHCUSSKs5W/2uA3nP7bjfJQcIapADrne9/wSwdwi11aTEL?=
 =?us-ascii?Q?ohLLeIzqh2gZi+xQNu78MNW4dK9S7XBlgZtZmdcs3JxCHKxKxu+Ox5qeiuY+?=
 =?us-ascii?Q?kGI22lKdj8EuJb2kJpUGXrcsr4OuEX3MFxQixsSTeSdpBJIxEUwlmgMVC1vw?=
 =?us-ascii?Q?ie4cuTuJLrMdy8SYFziONcOWy1qZkdoiY1Hp2saWn2bZOAP2xKtbY624vMEB?=
 =?us-ascii?Q?+VqSkWvqIUB4ytael6c6QZrTYJUIMFgYHNx6BtyAq514Huqj/VJy2qpq9KpE?=
 =?us-ascii?Q?pD9nXxNgM7j68ubY299iVbmgUvn9qIBIPkdJxnFTmeal5DafJJWCmyuxyGTe?=
 =?us-ascii?Q?hK2n/gmNr+PZTALlsMgkqPeoeQK8dqsZLM6kpW5LMJ33CDQQIPhCSo+hI94z?=
 =?us-ascii?Q?IZDtmLEG6Z4J/wvhkr/qqTIJuKAhBTGmDFUL9GJu82mVgfZ+GmG8HXAiS7M3?=
 =?us-ascii?Q?jYUH1XhyAS1p1EvMNINSquZN6/bfaRZ5uAoSjhUqFQOEZaIzdWMv2QM1XsWv?=
 =?us-ascii?Q?FudKe9MeBd0H7/G6jw2xEmVI9AIpt8VtoquSswtdfuDu6suqA/HTFmZOLCkA?=
 =?us-ascii?Q?N5pWdgyKR86z1Kaz/boIezUpWotZEPfpb8MabwPWq9Uy/Wwoo48TcWijZlLY?=
 =?us-ascii?Q?d6SlbDGBYvSN/k0qmtHudKpg7IPxD6xNuX45XSieS80c4C3R6SoSumudFvyl?=
 =?us-ascii?Q?YzKpMwe/xOS2+N/5LHvo9C9oC90izLE7yvOSbrxZ6XhebfWZX03whIhf92J1?=
 =?us-ascii?Q?KXfXDB13QIIMQGwzD0ua9dbC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376678af-6904-4b32-745b-08d93a1740a9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2086.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 09:29:39.7029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSfz9BQVdhI4cXkACF8PU632p7nUCpvPVlULF5IPpsYIfzEM6QFSaqaNrxYYyNW+CNNQh2JWozsC+HS6hs1ZXkHPZw6xmzI8VhEmecQLmM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1607
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10028 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280065
X-Proofpoint-ORIG-GUID: _Wc04Fv4aFjykfQZ4z5KQdeLGTgGxk1P
X-Proofpoint-GUID: _Wc04Fv4aFjykfQZ4z5KQdeLGTgGxk1P
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently cache for subnet_prefix was getting updated by reading port
attributes via ib_query_port. ib_query_port() calls ops.query_gid()
to get subnet_prefix and returns it via port_attr.

In ib_cache_update(), config_non_roce_gid_cache() obtains GIDs
by calling ops.query_gid(). We utilize this to store subnet_prefix
in cache.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Aru Kolappan <aru.kolappan@oracle.com>
Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/cache.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index c9e9fc8..929399e 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1429,7 +1429,7 @@ int rdma_read_gid_l2_fields(const struct ib_gid_attr *attr,
 EXPORT_SYMBOL(rdma_read_gid_l2_fields);
 
 static int config_non_roce_gid_cache(struct ib_device *device,
-				     u32 port, int gid_tbl_len)
+				     u32 port, struct ib_port_attr *tprops)
 {
 	struct ib_gid_attr gid_attr = {};
 	struct ib_gid_table *table;
@@ -1441,7 +1441,7 @@ static int config_non_roce_gid_cache(struct ib_device *device,
 	table = rdma_gid_table(device, port);
 
 	mutex_lock(&table->lock);
-	for (i = 0; i < gid_tbl_len; ++i) {
+	for (i = 0; i < tprops->gid_tbl_len; ++i) {
 		if (!device->ops.query_gid)
 			continue;
 		ret = device->ops.query_gid(device, port, i, &gid_attr.gid);
@@ -1452,6 +1452,8 @@ static int config_non_roce_gid_cache(struct ib_device *device,
 			goto err;
 		}
 		gid_attr.index = i;
+		tprops->subnet_prefix =
+			be64_to_cpu(gid_attr.gid.global.subnet_prefix);
 		add_modify_gid(table, &gid_attr);
 	}
 err:
@@ -1484,7 +1486,7 @@ static int config_non_roce_gid_cache(struct ib_device *device,
 
 	if (!rdma_protocol_roce(device, port) && update_gids) {
 		ret = config_non_roce_gid_cache(device, port,
-						tprops->gid_tbl_len);
+						tprops);
 		if (ret)
 			goto err;
 	}
-- 
1.8.3.1

