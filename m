Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF88B3AA04F
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 17:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbhFPPsf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 11:48:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:29488 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235507AbhFPPrs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 11:47:48 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GFfeku015093;
        Wed, 16 Jun 2021 15:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=yTeUlyRNJvW8yMYzcV8ZblFPULmO0leTtximW5ZrTCQ=;
 b=V1adcTZhLpmMge0l9vfWTH4L/4DJKrSAp/VSjDQVWfFhJTBVxElJUV2xnPOBMJhyBo3S
 pZhcmT0TFS139lMRn3TBu6lTsKO1qNJC1ZZHMRUAYxCpNJ1AjPPYkFDVsVkmqquBOIC8
 Sj31lbrm01a1uGZqSuK9m2iCuMQlUEgiXEfUU6lkh648H7bc300+LaDOwWe5dwqOekkC
 tY4KcFsmLqilCWLCEdLT15k1FR4DB/atlfnU2WqYuqW2KWM/goeQuya7tBZNpouXj4pc
 2H35IDHCAe46KOxGoGAPlwMNtlfTYI+3zI52duadxUF4O0Z/wNg6A6ZQqcXbjTlLty+B 7g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 397jnqr85y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 15:45:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15GFf4xl078126;
        Wed, 16 Jun 2021 15:45:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3020.oracle.com with ESMTP id 396watguu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 15:45:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amNKYTwbLQQCWZrBv3H+X+23eqrpwClIqmSKsbnJpHx+OvxrDD//h2gH8V8Gbo0IWv58oqtxyBpHLLeCVXOtucbUGl6qtImZdSyB9pQISv4Hrcjxv0RYBeNYhMHUCdx759gaGiWVl/83oQS+TDIkLPaneSC2JQvV+h/gooID6Dokv4+1hGbZ4uWokCIw9ZAm4gXEl91+KV4v0dZC08eQG4w9igmuPbro/KPWqmnigw17l0LXG6jvInUYaOMRIz8KqUUU/8+OcPS9Ez+v4e6KHfVHYh5zX6BxXI0eEGzbFCvZYqWlsONp9EAvQGrFCPleJcVlrPSgpgDhwMYCyZ8f9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTeUlyRNJvW8yMYzcV8ZblFPULmO0leTtximW5ZrTCQ=;
 b=A/RMJmGZ946Dc4IqQ/Rk25+iTiQiqPYCKSpaZpm3Xy6kX90c5zCXYkX0gmYhxX9fNgXQNqenjGLg3RBNLOa3DE9dWEVG3fcCbRiKpiiahwXCJqebeEKkbjYQn34xI4AHUcwJOy4yprOwkCQsa5W8zFZvQXIX1DAYATwcBvMljZm+WqobzO+n1tj2DcMAX3q9zsq8LSDpcTfnrYgfO9KEOlSkiWnS3tlYXW7rX+cqoK9WC+MmMzmepjhW3/7oG5s1TSTjcSedCpf7yu30P04TNa265/sIx1uj46PBMyW+lAZy9ldnNjcrsb3ZNN5dHYxf9z00c1j1H9hAF09hSZfjDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTeUlyRNJvW8yMYzcV8ZblFPULmO0leTtximW5ZrTCQ=;
 b=dyKeMonCWexwGRTnSWJmtdKD7i59nSGdFeV1PteZ5RAYibC9oXIaKtxDCu9GWqxY1VYXJOVZCZXaW5dP726VyMg0+XrRD9kwzZUQYWCzQAQCbeq26RmioZ1TFyB23KE/YEL/cZIfZNk3yU0nYs5i8X7fuDu0NQPe4wsaYKurQy0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com (2603:10b6:4:2c::21)
 by DM6PR10MB3754.namprd10.prod.outlook.com (2603:10b6:5:1f5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Wed, 16 Jun
 2021 15:45:30 +0000
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::211c:a5c4:2259:e508]) by DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::211c:a5c4:2259:e508%3]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 15:45:30 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v5 for-next 1/3] IB/core: Removed port validity check from ib_get_cached_subnet_prefix
Date:   Wed, 16 Jun 2021 21:15:07 +0530
Message-Id: <20210616154509.1047-2-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616154509.1047-1-anand.a.khoje@oracle.com>
References: <20210616154509.1047-1-anand.a.khoje@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [182.70.80.33]
X-ClientProxiedBy: SG2PR06CA0129.apcprd06.prod.outlook.com
 (2603:1096:1:1d::31) To DM5PR1001MB2091.namprd10.prod.outlook.com
 (2603:10b6:4:2c::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (182.70.80.33) by SG2PR06CA0129.apcprd06.prod.outlook.com (2603:1096:1:1d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 15:45:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b7d3d8b-a837-4a47-4ba9-08d930ddc4cf
X-MS-TrafficTypeDiagnostic: DM6PR10MB3754:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB3754815EE5692493BDDBE9C6C50F9@DM6PR10MB3754.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XnS0aF5sykwFrqIe03i/GsBF3hMBzAcpLYtsDw6HeT2XkhyGeS90fUElP/n+P9SCSv461RDXqPZrYqYiFkIEAmxD1tSfTokOYXQY/yc2SzhPZtjwlF6OnHdJHXqbFoXzJZhh8B/GMwrjy9wrsSV+GypXQL8K/M7QyWrGTWmowW+oK5iwwLdhNnHK4LlJhJf3rC2TLmoYiKgpl6dedZzZXzrC6VesBfmOutquYlwc8vEI5RH7x5iiByEymxkyR6+xWF69im7HFRfCsE8r2eN1w9iQ7DtkOUyN5Qx1kax6iUsPNF+GPPAXMKUw+yQlyL8K3s13XfhUxRrSfwRyHRNOBO6HJ67t0wIFWteFGlg7U2h06eCxqX8ce6Mzij5kTHdWR7xTYuwj3xS3Gw0ZVtWj/MDZ8zsM5QvrrRSRMy69WnL9EyjC0V+NB2Pc/pBaxx8u9CliJ/pLQN6kOE7lNTYqLLgs4pxWnztvMxhFNs03OkvHnIr+HeO3dDL3y0qCUZ4+3Ox57sbbecziSOg9s1Qg61ITjMwA6zCccr+v2Nzpul2ERaBrAra1rA9oyO4P1JR9glUi3gxXBqEzWDiqLxxn2xIFbqkyZTJxMdSgy9c2iYpsxu2EP4eFR/yZTo5Oj3mlAojEdt9csFYegf2vNaC+y2woHLmnufmkc2QffACvPpcTpPTikuG68qHvJXrQazEc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2091.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(366004)(136003)(396003)(2906002)(38350700002)(86362001)(6486002)(38100700002)(8676002)(186003)(26005)(66556008)(316002)(6666004)(5660300002)(16526019)(4326008)(2616005)(103116003)(1076003)(52116002)(956004)(7696005)(66946007)(478600001)(83380400001)(8936002)(36756003)(66476007)(120606002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5T8a0FQpPJLx+ioGirarCc7kFLaqI9YAUnnSFihpzctK1QEfRGfOpec26lQjR06TRtpSC8M9Fe55Z88omli5u2opTXto8UNN5D/0fhQrLRvO//hMwRVl68xAsG8bYBBGDGCEZrcTV2QqNLKj7OGC8T2SCk/Aj36OryIGT6cdH4p4ehRjMhSN0zfDggyYTlroLo+Zi08RJHFPtdirTq0CEDXVJvF4PQ+GZbo0BQDrCvKxV27WD1FM+pMynIFtpIU9EPcyT1/BViruhMP5UGM8zZ8c2vpj8Ek/iFZMis/HZ8+BhKoFnibbXZIu43z8kzl3p9W5J9FCf0DPZni8+u16C1lNMbANjV7a9QB5nZsVv7yvTqyS0wJKMpNnKD2RgHxUDeJnLXI5U+/cTNDSNnzRXhmSRE2RYkoFW/Iclso06JBh1ugXxNQKJ2Z8ttu/kwlpQ17Q4Ru8cHKCBIbcVBYUhS7OxitiLwfJ4UXaxgSDigGNzOdzqe9RfyL9/4Wbc3/Bz6p085AOTc+s2IP7UNfsSoNAJBTDrMJlbfErQftsn8brKGLQ3EtyIHHrAgc//tOLuqaXOzgVJzfgcVdqO/HSLiAIV6mQ3y58YOdiu3bgegS0HhZlstKX68Kf9akOt3do/Yw4TfjBt/OYJf4nWX1ZoqEqMfCpTZLcvMdtZGNi0lvwWEbQ5Anr7o2nG9hN2Qu+onSvBny0b37ejcihlcbnot5FKbp7WNCjNzWUYEKY0MbjZQ7HiWqe6t0K4u2go43b
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7d3d8b-a837-4a47-4ba9-08d930ddc4cf
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2091.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 15:45:30.1099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u84uXKlMzl2BknKtZ9bQkmz2Ev99Yd6hzEQoGWzQ622rB9cbCJtZGzA0Ih3fJCuGTamp8kFaj5R1uC8XoQpoVGZgFoczEVjP5hrfWmSu1fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3754
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160090
X-Proofpoint-GUID: mHNWu-rZOBTvGwn8TaZ6PKfyRYIzRhfl
X-Proofpoint-ORIG-GUID: mHNWu-rZOBTvGwn8TaZ6PKfyRYIzRhfl
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Removed port validity check from ib_get_cached_subnet_prefix()
as this check is not needed because "port_num" is valid.

Suggested-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---

v1 -> v2:
    -   Added changes as per Leon's suggestion of removing port
    validity check from ib_get_cached_subnet_prefix().
    -   Split the v1 patch in 3 patches as per Leon's suggestion.
v2 -> v3:
    -   Added some formatting changes per Leon's suggestions
    and removed return from ib_get_cached_subnet_prefix.
v3 -> v4:
    -   Removed a newline in ib_policy_change_task().
v4 -> v5:
    -   No changes.

---
 drivers/infiniband/core/cache.c     |  7 +------
 drivers/infiniband/core/core_priv.h |  2 +-
 drivers/infiniband/core/device.c    | 11 ++---------
 drivers/infiniband/core/security.c  |  7 ++-----
 4 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index d320459..2325171 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1069,19 +1069,14 @@ int ib_get_cached_pkey(struct ib_device *device,
 }
 EXPORT_SYMBOL(ib_get_cached_pkey);
 
-int ib_get_cached_subnet_prefix(struct ib_device *device, u32 port_num,
+void ib_get_cached_subnet_prefix(struct ib_device *device, u32 port_num,
 				u64 *sn_pfx)
 {
 	unsigned long flags;
 
-	if (!rdma_is_port_valid(device, port_num))
-		return -EINVAL;
-
 	read_lock_irqsave(&device->cache_lock, flags);
 	*sn_pfx = device->port_data[port_num].cache.subnet_prefix;
 	read_unlock_irqrestore(&device->cache_lock, flags);
-
-	return 0;
 }
 EXPORT_SYMBOL(ib_get_cached_subnet_prefix);
 
diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 29809dd..0b23f50 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -214,7 +214,7 @@ int ib_nl_handle_ip_res_resp(struct sk_buff *skb,
 			     struct nlmsghdr *nlh,
 			     struct netlink_ext_ack *extack);
 
-int ib_get_cached_subnet_prefix(struct ib_device *device,
+void ib_get_cached_subnet_prefix(struct ib_device *device,
 				u32 port_num,
 				u64 *sn_pfx);
 
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index c660cef..7a617e4 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -886,15 +886,8 @@ static void ib_policy_change_task(struct work_struct *work)
 
 		rdma_for_each_port (dev, i) {
 			u64 sp;
-			int ret = ib_get_cached_subnet_prefix(dev,
-							      i,
-							      &sp);
-
-			WARN_ONCE(ret,
-				  "ib_get_cached_subnet_prefix err: %d, this should never happen here\n",
-				  ret);
-			if (!ret)
-				ib_security_cache_change(dev, i, sp);
+			ib_get_cached_subnet_prefix(dev, i, &sp);
+			ib_security_cache_change(dev, i, sp);
 		}
 	}
 	up_read(&devices_rwsem);
diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index e5a78d1..5433912 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -72,7 +72,7 @@ static int get_pkey_and_subnet_prefix(struct ib_port_pkey *pp,
 	if (ret)
 		return ret;
 
-	ret = ib_get_cached_subnet_prefix(dev, pp->port_num, subnet_prefix);
+	ib_get_cached_subnet_prefix(dev, pp->port_num, subnet_prefix);
 
 	return ret;
 }
@@ -664,10 +664,7 @@ static int ib_security_pkey_access(struct ib_device *dev,
 	if (ret)
 		return ret;
 
-	ret = ib_get_cached_subnet_prefix(dev, port_num, &subnet_prefix);
-
-	if (ret)
-		return ret;
+	ib_get_cached_subnet_prefix(dev, port_num, &subnet_prefix);
 
 	return security_ib_pkey_access(sec, subnet_prefix, pkey);
 }
-- 
1.8.3.1

