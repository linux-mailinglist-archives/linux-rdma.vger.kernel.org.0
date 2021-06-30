Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDF33B8048
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jun 2021 11:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbhF3JtJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Jun 2021 05:49:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45688 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233541AbhF3JtI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Jun 2021 05:49:08 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15U9b1eM024391;
        Wed, 30 Jun 2021 09:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=2jc2HTXzMepww3QH2bWX+3YpvCGaGqs+ihG1ComwaOg=;
 b=zccrbRF2QPat26ftPaYwydg6sEv1KDOy3JrxB3006Bv8bKyF8DaiOKF3NIjLOXClgzTF
 IBG5laSHkUOOh1TBldJZBDCwMAJPxB5BtTN7wrwiuo1K32t6L9l4G5THQHVIqBz1/s67
 vBSXTf5NP8qGjATF/onvfvgqwGJdNZA05KueRZ5Q3bTfNCWQ7QumwZifdOCqhbrOIwjl
 Z37x5V+UEj23BkFxZBiTuyxSWWc5dpkTwItHMtqUtUyrexRiNSA7Pn60aNMtwP39SsCz
 trbbOwBwLiHvfwYmA0KhAEtDQlF7Q8/2iDFGrCKtmj9Dlvjz1bBfvrwFHEIGO5Ybonww HA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gguq0kpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 09:46:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15U9jtm6109781;
        Wed, 30 Jun 2021 09:46:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by aserp3020.oracle.com with ESMTP id 39dv27m88k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 09:46:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rbl2yY59IjpQcIRp0W2317OnEZOcjoUwZnDRlscDgCwZj+NYpXwKRs8CVjYDNkZeDdVkDCmHU5rv0pyvw8c83J5Bzr5eopL+33pUAAcOffz3nsXcqHSmcwbmo7rxm67RKAJfOMsWy5y5j3qB4NRPMGShXwpHLSgVr20Ws5QzIZ3okR1u65NPThbKFDPuMJng97gIEZbr2Ij/ZhjjjOqqcAIN8CNU0F4TFxdvrJOiR+U++GiQ727IJ87CwhoiaG4V/KCv7y06G1kEfN/0K49tiI8ZqeLcDKGBQwd9BLB+kL8jHXwQBaNu4rHOZpNer92tEzoa4HfoKZYN0T03ylxDKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jc2HTXzMepww3QH2bWX+3YpvCGaGqs+ihG1ComwaOg=;
 b=baFY4nR49Ju4E7hhxYrvdGb48IjP4MuXnwZ2PUGUsNoBIwJyLnxZmC+uV3DyPE0y+T68Bay+e/Lko3ZqQUDcLUUb9gznetuT9Xppnf2y1MkVdRN88/LOx6/UH5JFnig9SP5ytqMd+EyIAbUF65sgRF03NHVJJV1zNMrMz1rI4SU00QCUITO9ZyAqbBFPwUniCve8PkOvjPlXlIrQ+Bpv2CE8Yq3kYvaOI8+KFSnm71dxiCFdRrf/LgdD35visiIxiUGs5svFxA8UU+JTH9YBp4FCbjLI/kMjJKQBopd+eaWXEPjmUb6g00L4TP7254/fku/it+3YgpCR/C5ABCLy/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jc2HTXzMepww3QH2bWX+3YpvCGaGqs+ihG1ComwaOg=;
 b=cwVPHxZfRY4fZCYIFD2aDLBsbb3DVL2z0aSwzGBFbCPLUDL4DdnDIDphKKqm3npOwHuiDcUExpgBQjMykE/84aagybg2KqaWJXPScJVbdDQk27SqMhN/LxNgHCSN5qMfRCNL7ZEEpJNKyKvzkwMNIEI4RqWt1fth83P0c/fJz9g=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39) by CY4PR10MB1557.namprd10.prod.outlook.com
 (2603:10b6:903:23::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Wed, 30 Jun
 2021 09:46:34 +0000
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::19cf:f38f:51e0:a5f4]) by CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::19cf:f38f:51e0:a5f4%5]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 09:46:34 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v7 for-next 1/3] IB/core: Updating cache for subnet_prefix in config_non_roce_gid_cache()
Date:   Wed, 30 Jun 2021 15:16:13 +0530
Message-Id: <20210630094615.808-2-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630094615.808-1-anand.a.khoje@oracle.com>
References: <20210630094615.808-1-anand.a.khoje@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [49.36.45.114]
X-ClientProxiedBy: TYAPR01CA0007.jpnprd01.prod.outlook.com (2603:1096:404::19)
 To CY4PR1001MB2086.namprd10.prod.outlook.com (2603:10b6:910:49::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (49.36.45.114) by TYAPR01CA0007.jpnprd01.prod.outlook.com (2603:1096:404::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 09:46:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5358733d-92bb-42ec-c146-08d93babf248
X-MS-TrafficTypeDiagnostic: CY4PR10MB1557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB15575D383E923EF7F4292D3AC5019@CY4PR10MB1557.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: naTRi1UAI9pJ7CVMfR95ma5Oj56nCCN1EGB5IsV3iEyyfN1HNAJwBpUmQsvYcwz/lNepcZPZuJH+vOFfUMf5gzeTF5GaHJz+H/xUdhVYGExL4jgyd21yaw7AeZP8F7o0EdS+LHylgnAUj8eLtsG5p13rlqyYWvFXdUoO75bnyBGWybpkChpiXXoyZ9BRxmqMxWQRSIHckF3kmdSWXvZgSQnm7z3fj0m7hBjTKdjr/r+I1/CKWP5YnnAFv2bmG6u7cx+n7fsJbaxXiUVkbV1olcBVM6lknQlzZi8ec7ipr59kHofLrfBeL6s8B3hQKvvUcErEYQF0KR16j8FNSb5uOUSrEoDTxWWP1SC0dtp1trC1bUE5L0NJDgbsC6Sb4YUfkRZQBd/ai44McrRT8PXY1PbBWWHpaQoKh46MNLpCR0WyGXk4qEMUj/HXU/8RlSnNvW1dTy9xPpLt2ONB3ndqYqgJAP8OLYUhNOQhywiUstswkUb4H5my2F+r9/Tom3s2xN4GtFR5tuYOoV2e3+5b3RfhLewXCecJcbuIqlk221uE42ptOQlXel0hKdQPwZrU7+FBZWgSyoiNIJvTzcKVWK4sEVLWA2J2+nTV+pt8G9z1UqbWnG+qRDDfFPqSWCQPOuBGldqKPPUr/mDqMqdydq8i34zFL8hzP6qTrDKN7fUhU+krVN7HvuWGP9nA+OgSw0wl3Vf4MxsTOLsLK7WEjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2086.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(136003)(376002)(346002)(66946007)(66556008)(66476007)(1076003)(16526019)(186003)(1006002)(6486002)(6666004)(36756003)(83380400001)(26005)(8936002)(8676002)(52116002)(478600001)(38100700002)(38350700002)(5660300002)(103116003)(2906002)(4326008)(86362001)(956004)(2616005)(7696005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UI6i3aWEmWkDHHHeUTU+QG0XUtQK2XQqY33jdwlBA6fXEEIuV3pnUtiGOWch?=
 =?us-ascii?Q?9AWshw3PLVqvNcaxGPnMkJLMZs0XMz20s6XQaMwl+RcXxFBUk+bpTxfbWpca?=
 =?us-ascii?Q?q6L4CJhrlAOzldlZS7Ovi6BH6gXMvMzcQF0gIN0c8TYHli2diFiOz3GmwHyh?=
 =?us-ascii?Q?H2SarniMMXkWqRgZoXCgiY3FFlfybVKSs2NtIyQX/N8zFR+q5DoQjrN5Dqti?=
 =?us-ascii?Q?D7YLbxqcP+F+xBDQ4Yjn5iW/OkKEEHqpDCybk3OqwFVK1AI3Nk1Dy7HsRdPi?=
 =?us-ascii?Q?V4oOVevgyIW1DD5IgXbnsY8v8uIkdfKe9FiSct2m8dyOrN7cM+iAZg/VR/QW?=
 =?us-ascii?Q?qsbyBGbHp5kwbjQHt+CKiPrdZlYO9JaWE/OfiCNwaTL5PtHiO+k/8OUmvoY7?=
 =?us-ascii?Q?a7LTNS3n52p6POE0AKiAX4qugDjW3OjE2iz1Q5s5e8ph4uCDDTpFg2a8VCDx?=
 =?us-ascii?Q?DapaE3fd6YDodILRjB8sN6bIZgfG/iYAMMsjvKhaCpbz7XijT4cqHr93aEGD?=
 =?us-ascii?Q?Rm6RBQ8lTyH8Al4pNP4iJn3/WWOU8lTsqeCeSaGmymksBMnKtOGQI68L0ST7?=
 =?us-ascii?Q?mIC5nsoa3qDnk6hMWu2DMpOJYslXFSFN+3lmPBVj6khTGMTInJx1UOOQ/B6L?=
 =?us-ascii?Q?Z6uJoKJqenM+XcWPNe9kTS73KI6lJuDplwN+Dv1oJJxpyYtL69sPhTa0C9Rz?=
 =?us-ascii?Q?D+qMjYXiQ3dgIIvy21lb16TFSypn6yc9leLwB37jqxhPzvu1Jq4rtFNcqTs3?=
 =?us-ascii?Q?8+eBN9JmVdx4yzIgsvJgiSAsiNAEaJ/1V3WNotMLJGTqEmLhz6vzkUR47TxZ?=
 =?us-ascii?Q?I5WT0SEYGQtZQsflAtxZCmymrFL8InMNU8vGCZykcsMm9Nhg6QDzIw4OAqFt?=
 =?us-ascii?Q?GR0kgcZ9aR99Vs6TaTH10NCrlqNO8/7Xgn4wMJBTxfQgtArfHa87PLDwTTqL?=
 =?us-ascii?Q?7DaoWqZPNYC6YWkGWZ2SmAHWVCBLj4+sK6PQFvebHl9yQ0dE7mYvLoz4Yoy+?=
 =?us-ascii?Q?E+5nnW3PkRlXR6QFvI9CHDB0ye5zK/Ru0IS6LJClCWc+zdyn+3wo0pnZ7IyP?=
 =?us-ascii?Q?TFjJyC8y+ccLQzpGv9U9/c4EO0p3lInZqII7WGLF1x+X64zgjh4/WnvsLcI5?=
 =?us-ascii?Q?mLPxKT+5p/VTrPr7Kaj+qwyhswYLQ1EJkJYNnX45ILiip7TmR6qCRdYAwKWs?=
 =?us-ascii?Q?fsoVIMAx3G93ycP0cnLcKc3fh/qGhQwxui2X4h1hMJziPdDBeA5NT/fIwKIi?=
 =?us-ascii?Q?2Jfq+BlWbbFS25lcR1lDnRG38+PUNWu/Qb2seeFnohOH0y6pMH3CV0u9ig3t?=
 =?us-ascii?Q?osOtiJyebVeK17n8/p6wdG1J?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5358733d-92bb-42ec-c146-08d93babf248
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2086.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 09:46:34.4284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jU7hYh2ZRrEGukNjWoR8NaoQGti3NDsJF392zznJugHi5dDA/tMZhnZtWiQBAVX1AOI1lSuRA8y4UbLFt6lVhUV91Mi843+ehRpYyCWIBLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1557
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10030 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106300063
X-Proofpoint-ORIG-GUID: rOWHF9UpKBu6rZ-LQyyDY-lV121ztVRz
X-Proofpoint-GUID: rOWHF9UpKBu6rZ-LQyyDY-lV121ztVRz
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

