Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AE33C5C21
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jul 2021 14:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhGLM3k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jul 2021 08:29:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42574 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232342AbhGLM3j (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Jul 2021 08:29:39 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16CCNFXY027745;
        Mon, 12 Jul 2021 12:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=v3bg3YxFwnBDKbMXYaAbBRZlM1cz8e3lMy86gTPvvaU=;
 b=sRB0KGfWibn/+4jwAQG9ZAtnlJQlt/EKHKVbVo57eJpsmK0CWZE5e+pONVTjAgWw43uL
 wrA0uLSEVWefDS5RBtyYgXvJkT4qD78M5RF0B28eb8vkHL41Ukd/7eSMkJzTZjzZpbHl
 M/3iT0+552VmUv7jJ7GjzBdpZ0UFgcZTN11zoZ/2vN7rHLQGpU47bC3FBcOMdMseOVUk
 3X3RjGj5UzlEoLizwShGxOEEMG3tOay9xGJ5gUiIvdodGsNtn6w/xb+WMkgUYS6EskMK
 APtMDdclHGGq4RXHp8zlPn6HIrfPZrUhiYJ/Cm0GgipMEi4Leojc/o5MB7GO5lrQfeqD 1g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39r9hch0y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 12:26:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16CCKmJU134677;
        Mon, 12 Jul 2021 12:26:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3030.oracle.com with ESMTP id 39qycrhjsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 12:26:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipSaeiCyIkQKEGIhYcgSR6vCfzEm5HJLECgeDz7KoPuT/SxhUT1mgLB5/vJcJzmbqExXg+Pmq9yOQ4r6kLH9fR3wMg1mZ2wP6ddhKA/qz1viTJHZx95Y3pR1MLNHuQ1nPKmBGk6j7hFWnVxwc1/VWwcNRE5iYdqoN5RHyaYdmu3WKXHRTVXB/hEyK9zgopBd6Odn7Fka1bhk+lf8ku/ID39SIm3BJp5XCAN8T0qyq0me9Uuec0ClthboPeqmJrqVdzW6voVOfNfCakAkFKDoALJWbEdxIj8geSkh+KgUnRl4ccMwzSUuATjw1CwNr1U7gERuTbEogLMkBPjFXEq0Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3bg3YxFwnBDKbMXYaAbBRZlM1cz8e3lMy86gTPvvaU=;
 b=mr0zWhqKZtgq7aDa/1hDP+pRUxZpfuVpWSxxLcfvupKHO6hc9eaTPPSo0jkaEJPKZ3KTuuD7NzO6eoJUFwFa8XIjLfO5qIEckBLb6z6ktzsaoXiFXtLJ9wkCFr+LPWtUA6FweBvR2Ay6cKndIhum52bal0wnf1Kqi/pizIkS6GiFSUZs0RGPEyK1Y22Fslz5F0fGKOiNRDe6ocYKPOPe24tXYou0NweaYun67lIEmZzsHezden99RwQ0IVmEJQZx4ryy7CWvVXp/qWX26QFyW+WEuLya7mHAvoRmVFDQpbaroqXVT0nykMdkNkGS/UBU//IrYebsKQ6+EVx8iOWMuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3bg3YxFwnBDKbMXYaAbBRZlM1cz8e3lMy86gTPvvaU=;
 b=fJWnrNz96o+JMbE3h3T9dkN38+9ZL11VKILIGtuMcnolMEzBka+JPisTwFRp58qTLL6WjOCf5iCF5iZd2rGvMef/nzTQzpIYSOI8dLdp2fZif4PeZUqS6sjYixnuG3LlqyTi2PBIRtL3GNZhPmxG3dFuNNx8VvPKZh5StyfmQmE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39) by CY4PR1001MB2309.namprd10.prod.outlook.com
 (2603:10b6:910:3f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Mon, 12 Jul
 2021 12:26:43 +0000
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::9dcb:26d6:7408:b4d5]) by CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::9dcb:26d6:7408:b4d5%6]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 12:26:43 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v8 for-next 1/3] IB/core: Updating cache for subnet_prefix in config_non_roce_gid_cache()
Date:   Mon, 12 Jul 2021 17:56:23 +0530
Message-Id: <20210712122625.1147-2-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712122625.1147-1-anand.a.khoje@oracle.com>
References: <20210712122625.1147-1-anand.a.khoje@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8015::10) To CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (122.170.228.204) by TYAP286CA0005.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8015::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Mon, 12 Jul 2021 12:26:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8b69ea8-ae3a-4378-2302-08d945304e5b
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1001MB23091E89EAA7018B87A6646AC5159@CY4PR1001MB2309.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ntl2g8R7dyrHkHHb6os2NCLGBaOs703cdGZ6n58P0ETjAGmKb/klGBLVgiy71AD8oxnGWFndQUthcvVk53+6YIdgqcDArHgZkquBg0tcbS5KGFnnmsL06tlcdtb6qj12scHiMlb2dQhZZyIxi7Jm3P8QkHsTMgktWxirUR3wV3aAq9lvRZ9feD5oCK6bPgaqK0Q+Oclkhq/jc8Fm/9aeBznDQICUoPKFv1rTAq2300l4vPXJetrYZ+AJ20yIuHpwkDAvL2DIqw45KCotu+dx4hjxDkkY4VJu/vZWkQAJd+mVz6csv6vD9Xoagcvo3DSDdbkHhP9LgXRgbZ/EefouT8EqshoYT9lxGZLOgfTZMSPAenxXo/13nQv44xqFuu3wdfKgbJJbp90IsFOzTEJpnu14qYrxvgPRukYLk5u/R2rNyn3sBzRcaUEtuR5qGhmhdeVogwWttqEHOawxOkvJl9Aq2lcjZdbCVf9eBZW1PxUXafi7Qd/f6rnVJpmiaThP5tsOW+IHWkfPjGZYfNfKVGIEXONk37N0Mtgj3WefWaWCAA6dNa5wkzzJ2GG8qtYiUuRflAw/M0uw7VL6PHsDH02+kgszkjJcgwlRYN5ZZ3WssrrkhayoxoVw5VEv4D+awfTgmQr+14gIzNx7QlTVEoysO+a9NL7aEpjhRpwiZdUSor08zeCCyyfAFIjRFDzge/Egb4nD/ODPcb6J/4xNuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2086.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(39860400002)(376002)(346002)(6666004)(2906002)(36756003)(2616005)(66946007)(66556008)(1076003)(66476007)(86362001)(38350700002)(4326008)(6486002)(83380400001)(316002)(956004)(55236004)(186003)(38100700002)(8676002)(103116003)(7696005)(52116002)(478600001)(8936002)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O1tK6MBg/VkUKyWcY+8/u3DHumicvnwl6vJo1/4ddBIHnTv5cNFv16xFCQWU?=
 =?us-ascii?Q?i/YkwO34bmqlhmoQxm9ndjFsptkBV6WMGvqurEXdLThX+MV4/mKiaRIw/By/?=
 =?us-ascii?Q?k6cNdkE2KKEYzisRZr/QKvlOkzSIjZwQnfuM7d6cJiaL7AAGUjvjlaCZLPeS?=
 =?us-ascii?Q?fLRppqAB7K/u/GEZNQ7pWUHj112Zsh/LX0VmoXbxIxVTPcFz5Ig2xhhlvDek?=
 =?us-ascii?Q?ifICJ2Fwktlo7pknoUAMwn7T9iUF2oIEh2aS7CCO2UndnBfsr0DgZWiKwNA/?=
 =?us-ascii?Q?p94plckWAImMhS5iudIrJQa2Ssy5PaKs6Ksthf8iyd0Kjv+ZKWOvjThBKgaM?=
 =?us-ascii?Q?IfEhq/0XXY6WUk0/VvUJ7UWgQn8zoejpoYJwV5L2LsK2uUvMB8/5JomzCYi2?=
 =?us-ascii?Q?LmMyaJOhCHwH9MjwpDyshJmp3UZ1mRzogu5yTqUioxE3wzYHazYkZE/5svB2?=
 =?us-ascii?Q?/Dw3Gd+THmvI2F0uqXRPaTwapKCtmCXsLyro3FJ3RIQbXZtKtgu0WtE8Q32V?=
 =?us-ascii?Q?ZSEw8q1pie2Y/0CrO5RDRiUuOk5rMknaZL9T3gXzcvrT3ggG4VrNHPWgJJsc?=
 =?us-ascii?Q?rXDeR1diN6zFJeKjG9tUrTM0jqCUWmXlHrSxamnRjtlKOl/qTsslVh70iHth?=
 =?us-ascii?Q?lPmIm/6etkjEPVuSL1p4tL5byP3Vkby+uzcGkLS62DT0XikCvj+ncIF4qihN?=
 =?us-ascii?Q?q49i8NT2zrWQNNAJ01i888C+RFEVia8gpBBg0+iPh2pfZUF/W5XKG7sD1rCu?=
 =?us-ascii?Q?TyQ6RMafymK0hZxVvTqmpJ1a8FT56n9hxsTU9+XrbpUVAGe76Fj9lztk8iJ1?=
 =?us-ascii?Q?kMsJ5AgjeV3Xb0iOIucZy4LSkEOS/4O6tizMy8vkrtDwwMcVZazAq4uXtr80?=
 =?us-ascii?Q?oUWSdV83DUntGmNvIdb7PZ/2UE25rXhhXNC3ZThh8vNpi3I6B9Q5vC8XTfJV?=
 =?us-ascii?Q?R5O2si+zmGQTQkZJZbJH+epUK02aMaysxWr1P7/axYmIn3JxJ+J92DXisrbl?=
 =?us-ascii?Q?FEk1YUSu9I5Almn0wTWNvaga0v4/RbGMVlLeF2Ke3HDGDxzRJKUq+frzxFoq?=
 =?us-ascii?Q?cT/0j4zJzXxygKkaWsZRGXy6dyt/G4uDChhxbI//XXBjzfMW0f74MTxMoVlU?=
 =?us-ascii?Q?SCLbvhdUWeWmsZkj92t6c1k7V6cB8FlPw9uoMb92fRDL8YaG7/Qi4HPppj+d?=
 =?us-ascii?Q?wyLwHYxZhcXd5Mna0fvLcWlFpkOKJbYS/LPFz+ibqrs23VKM6vXTlvwEIsH8?=
 =?us-ascii?Q?ED8k/riWBmdbQLyOHXvoD1aws+D37fCXlygp83nONtIwvZ8s84eZVwXxczD/?=
 =?us-ascii?Q?tdoXYSyAWxMLYe6u+JYFn9Hc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b69ea8-ae3a-4378-2302-08d945304e5b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2086.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 12:26:43.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xXnix+dqgT/kPilaOYU6puqaQY0ccjaVtxqnQGBhAaEi3o6nVgaWz9G57tKKPEzHH8RgWKsPzNbp2pXoSXaEDUSo3hZ5wCP9ynPzauEnDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2309
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10042 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107120097
X-Proofpoint-ORIG-GUID: NsrshBeXhEgk7YUcCionIesyfPoVtfyX
X-Proofpoint-GUID: NsrshBeXhEgk7YUcCionIesyfPoVtfyX
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently, cache for subnet_prefix was getting updated by reading port
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

