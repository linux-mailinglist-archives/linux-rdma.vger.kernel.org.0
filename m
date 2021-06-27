Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED37F3B525C
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Jun 2021 08:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhF0Guq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Jun 2021 02:50:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4076 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229535AbhF0Gup (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Jun 2021 02:50:45 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15R6kh5j017706;
        Sun, 27 Jun 2021 06:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=UgbDiXmYLtEBW1+Q8USmI7zLzg2WSokfzz2o5rSHoJk=;
 b=R5TR7O9uSFuXvtnWUFy9kWnbRBeNOy+earnQXPGYxYYqVzHI8SxZe0Zx8BuTQlZ86G1t
 esCj34Ew4Er64RrDgNJqnXSAxveEVGkCdnZjfC52ZuUgPlvvTxI1FZXLNizOkBF3v14y
 VFM2ksJEecpxxHtG+lp0zZdHilPkuBGbJuKOvI9d8Uvz6ZkxAKiKnANO2dOXrohTb1bK
 U0qufXETuVOuACyhofP92ySKWSwIoUFTZYQTc5o4vlUk5LLrSAObo0dMubBal9pA6o/q
 j14rNIsUxzy9PpiXfHqXGtomdt9TC2FRqm9CN+4zcSuncXMyiD1/nrVcROSNZHUojnwf cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39dtnc14ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 27 Jun 2021 06:48:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15R6jhXF013354;
        Sun, 27 Jun 2021 06:48:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by aserp3020.oracle.com with ESMTP id 39dv21ug8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 27 Jun 2021 06:48:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+OUHYihPivUDZEK+taNMisXHffixCZcA7PKnQhIUI+F+jMjsiA0iH7QOonCcopFRjBQf3Dby7iI76W9s//1j4iut1Et+7wQdb1+vKdxCoVxl3ZN5+mrFV9uKXxnAj/K5d4F6wdFnQ+6OdOOb6z3tBA8RJXZVkNWKH0f/gAZroThvya7mlQLhpTmD6WnnRiTUM5vFazRA6E3YuNBSAR3P+1YdtbnMR24W/t+fVmJB90XP7ZBCt35MRVCp593CcmM/B5yDFspJ+fda3cf4DTIVFjXpR/3YvoklbbPFYpAyqVdUxz4TB2wYtVc8L7veJFd6vJ/Nd40rw2a27ryDo1u1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgbDiXmYLtEBW1+Q8USmI7zLzg2WSokfzz2o5rSHoJk=;
 b=P/a8Nwrs6WC1R4HYbJMooJ/hpQB50w583IimTbyuuT40A/t8aKflICBfJEUfDu3+mdJYp2vgenXx0AKDa84wYZjFyBwjsCgjK6AnBJSPpjwwIgs24ohV54eR72fcFuYFQmQImXjBUFFomQPf1Kf/5MsFh1J5dIWOphmBKwOy3o+NFhra8pmF8B6vD+GbAPh6aIIt07l4DuNgvu9VoYVfRkEw6za+rNAO3GhzBgUDMDgcBKcgr0k5+GWdxYITY3SMbomOhpmc0kDcYAyq2pz8O+6BmBfuHMq37H6NWelD7Zh0hBw6/T0RO/cr88KPzjket4zl9BiZNBXnfJ6v1IuZ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgbDiXmYLtEBW1+Q8USmI7zLzg2WSokfzz2o5rSHoJk=;
 b=hzG97xRhHw2wS4tmitiOy+5N6hjR4oWTf9vbE8yLgpKjuWz0tM6Wmh5qrXr6mI+GSikZA9n3lpQa0pPAWpgWEDrY2sWuL6KKj38Ghc9rsztJDJSpwoBb5r8OSr6yDyB0+JqvRbN0IiwuF0IFS9c+e+vBk7cRlQ79jJdpMBMN5rY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39) by CY4PR10MB1704.namprd10.prod.outlook.com
 (2603:10b6:910:8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Sun, 27 Jun
 2021 06:48:15 +0000
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::19cf:f38f:51e0:a5f4]) by CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::19cf:f38f:51e0:a5f4%5]) with mapi id 15.20.4264.026; Sun, 27 Jun 2021
 06:48:15 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v6 for-next 1/2] IB/core: Updating cache for subnet_prefix in config_non_roce_gid_cache()
Date:   Sun, 27 Jun 2021 12:17:52 +0530
Message-Id: <20210627064753.1012-2-anand.a.khoje@oracle.com>
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
Received: from AAKHOJE-T480.in.oracle.com (49.36.45.114) by SG2PR01CA0109.apcprd01.prod.exchangelabs.com (2603:1096:4:40::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend Transport; Sun, 27 Jun 2021 06:48:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6c3020c-0670-4106-34f2-08d939378a23
X-MS-TrafficTypeDiagnostic: CY4PR10MB1704:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB17046537C2863D2BA20A8CE3C5049@CY4PR10MB1704.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tpxD9/ndCk9TENFv0+O457Yef3SXUuWANO3eYNLOYrlqV2hBuHtnjMIZ8O7QQBhBYUDEQpCoQ0nZSVujlXfBUVhXFkFCPVwAZA1kWP8rC/5rd3hKua1If/LBfiYxXo0X8p1k0xi94qDQThjUjkUm23kh1hzuqvElM4Jv/sY8wkBLTH3Z66wH9balsSEiENwddNPYtwHyB3thf0VkNuWQsHfKVvZCDiG9cDh+SKWUcNED4/YX/I9OkDfowNv+CmjXvj57cCtY92jgbNsf9xnVGiSHCnn9yvqnttpbhUWkUD13ltnTVUR2Pqe79hKF066+9BE5QmBH6OjylyRsxxfh/dGoNhPhY5W6jjb5hfeFjTpUF3zCkA+KTi+V7asmMWqCbfelYYbT9yDJnO7l4Kk0G041CHTBSd58Ih9JV2peCkhSXr+qZs46jm4BqK2npJPr6E4Hu9Uio2Pm473ZwG1U4klJXFxOXF9dFvDkETNvKBdv6Z1vX9+JkL2cqrSeWxwlMFplcmSayN18vLlIMnJZj1CiwJXwAiUrooeEyK4coC6/cdhbSEvepEp34Dc19y+Av8V3UHLJYNTq+lPBHaAvHwgVCyiX0FZPwrUAEmEFTdWKqKwjqGNvEok5JPq0sc0lEcMvPZiZaYsURBXDfDhesuYaeXL9GITnEGLYDV+8wDA0woSsJczedrxsq65dExBVMT5J6IRflRMnqi3exy8d9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2086.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(396003)(39860400002)(376002)(6666004)(2616005)(8676002)(36756003)(6486002)(16526019)(66946007)(103116003)(1076003)(478600001)(1006002)(4326008)(186003)(86362001)(956004)(2906002)(66476007)(66556008)(7696005)(8936002)(83380400001)(26005)(38350700002)(316002)(52116002)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o38G5myg7SLy9lzQxXeo4ijncRSnk6JgjDbcuF8QWOkMadLuJmTPtXRTKeBJ?=
 =?us-ascii?Q?u7VjZ2mt6fAD74ft6p8xiUoa/LTcm/XXFy+SzD++nZyj/g6lTyySa7QGBOSb?=
 =?us-ascii?Q?n07xh5WlPH8St7ILbtaf89DI/5ubtn2tB3LWQoBZ8CIsx2B+5uQIXTv6U3z1?=
 =?us-ascii?Q?HbnN0HOv7eCcBvFHNodjUqNEZCgKzAOcuKS9+gCbmLI7cL4DvnBDZ1af+aVc?=
 =?us-ascii?Q?w5tnMN/RxQbYRpxyAP8Qbxw6BehvfE0abv6TwOOyQtMklaWQOYJJfY8oRsNq?=
 =?us-ascii?Q?zKibpaIJaj6DsOAa+BuFPEv5RlhpkiwIBZiSlAnHcl1C/RSqTJ7k9jXFShq7?=
 =?us-ascii?Q?x4i9pNCoZuN651g9iAXJ+k85Ks5eUjUb1X4W5FNQz+lf7ZMijEZDpDtHOUvS?=
 =?us-ascii?Q?Us2+7IuUvYjbraPkWy3pBaivAZdPdzfCipPLHUdq6WGREFTcUUYGARLzdEwL?=
 =?us-ascii?Q?ip9SJZsTUYu9hRWjpCk6tvdFQNpJo7zoUKJ7g1pxxEB8QWGe5DrYII3H+0Ww?=
 =?us-ascii?Q?GAHxDI+eOpzj0fNyEHsT3MI65obfjZHRzJlWd3SVWNxA8jLsZCHwhPqYprh3?=
 =?us-ascii?Q?GVDQG14Eu/Q2TsKdnKtK2JKUMEfxJI0iWoaDOtHz/ZjJvmQjn756bI7J6KH5?=
 =?us-ascii?Q?YBiMVTysWoPfL0wC/myxuVRF+IuQhbJV4byCOTedmRO1d+uevuU54+gdyVio?=
 =?us-ascii?Q?DJHyPameX07SnCt0bgtChBBd2YQT84gK+XjS8/ZqMrPxEmj1CmUMuQGT6w/V?=
 =?us-ascii?Q?bILL8M9WHZCGyy6o1z/6cVMoTHBdBYHGgvIuFdupHT6XcInvKK5E7u+dpI8A?=
 =?us-ascii?Q?eZJlNRoVbp/SvFSt7R+ihgTWxVEwEpoKvTdC0YM0A4Seg1wfXNSxUQyqv8BS?=
 =?us-ascii?Q?AtDC2fv/pMDzAQmmc5+fQP7QP7OZDoDE4d/jeVuXzsM0djkAhZnnqZxQV3AO?=
 =?us-ascii?Q?Ifdeq3tsOizCZU8P8vQgTGW544HD8m/2ZFNradWlypcL+fhktI7K6TGicNcj?=
 =?us-ascii?Q?vIyPJwlHG08Gp7La0vH8DmhxWn9LTc1dpfbGZRdJEKdIHC676ZZNYdAAB69S?=
 =?us-ascii?Q?aU4QuC5CW9ybA+Mxylo+765M/MSYRv6UGIO/rRAb+3YmilfR8HxAYjhEurFs?=
 =?us-ascii?Q?cxPU+7UUlHUHWlnVlkUVY9ir6ajuCwXAiqGcWDUYAiJPOLxkmGCeGhcEzyTS?=
 =?us-ascii?Q?D4uhjb4LOvh0aaTWkMS674kRGtCA0ih10Y9x74CEWV1Aj1mzAXZn/QNjPbgh?=
 =?us-ascii?Q?bSjiOPvTd5lCO6DOH/NeQ6OZF5cdedtBAsPgDyUnfKwUTG9zQ+GkTxpFTmNy?=
 =?us-ascii?Q?xk2XtPWAW0RODtbnPCvRWtnT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c3020c-0670-4106-34f2-08d939378a23
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2086.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2021 06:48:15.7630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jazdZIR2WFcD86144jnjWW5kJVd3VWgkXzGiDDWuEpe4ocu0UcI7ZgllO4oww9XmN3f0rtB+I9yC+BBSrNSkTWNThhlDNOWjvdFq2RD8e54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1704
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10027 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106270048
X-Proofpoint-ORIG-GUID: t0kl287UTZ_100mD2tUpmupc3ynZhihv
X-Proofpoint-GUID: t0kl287UTZ_100mD2tUpmupc3ynZhihv
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently cache for subnet_prefix is getting updated by reading port
attributes via ib_query_port. ib_query_port() calls ops.query_gid()
to get subnet_prefix and returns it via port_attr.

In ib_cache_update(), config_non_roce_gid_cache() obtains GIDs
by calling ops.query_gid(). We utilize this to store subnet_prefix
in cache.

Fixes: fad61ad ("IB/core: Add subnet prefix to port info")
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

