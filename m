Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCC93A932E
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 08:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhFPGyr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 02:54:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33242 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230515AbhFPGyq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 02:54:46 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15G6lTSH018815;
        Wed, 16 Jun 2021 06:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=yeBI8FSZcSZ2HuoFYJWWHI+BaT2vYAXqtgajDl10RR0=;
 b=Wu7hf48SUV03jsNIiCm7UXMt7bi5Pkn5uI/9CrAi9+8FbpI1C/pOqWDpq3+D8tZjsAfn
 G9hY5kJ+COgiOIg5lbZldvkPodYqmfVngRL5724LQ0Xe6Uz/mUGIzNZiacjaPSC8Ju8P
 oRcpMYD5vLUWLcaSKI7hvHJqe56bI+v3zFH268ecgV1JyMC865Oh+o3PWSxSPSUNR0St
 ad2DrZt6LYhsdYyEGsL5He06Nwj+t4B9SsVnbBwR3VuQliOKH5eWQRRlQ/tfq9Vh7ATs
 d6deEi7jvOVNNyUkzHxp36DAFyS2ZpHuQjp1TCa6SY99h2wTCR9YxP1n4lmM60d0uatn /g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 396tjdshm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 06:52:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15G6p2rI089782;
        Wed, 16 Jun 2021 06:52:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by aserp3020.oracle.com with ESMTP id 396waseytp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 06:52:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fD7MjIBeTDm3Du7N3W1nG52T1GiGx/zHjSh/UAE+OJKuMuWX4+UdIA0+22Z+GgmkZwkPX/xaggpGo1Bv0nTe768ShNuPp/SLwqSIXkicSNYSIOGVqXTRHhs+Oj+XNrShjIJT5IBfiIcIsIavpgS4KWizQkT6GwJaS7tJ45lPXH1T7l1Hj1Jw/bnbBq8d5rDnDG1zPD/gFFz8tAwss0GT6IEaDvvaJ6gnPagh2VDc058piouVS+kVPvce+itEMprBOs31e+tCJQoahCHSgYYN8Z1LvcpA8dwPCqQhtL+iBqMPYu4jeG/+HxgN45iQDpbu0HAay4rajjrdCrZyC6mkZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeBI8FSZcSZ2HuoFYJWWHI+BaT2vYAXqtgajDl10RR0=;
 b=gDSgYnB4gEY3CMV15/0X0/Dpc2gCZWuyp1CuUQiHAPzyw7nCB/1QkiJBBQolZz5maxZUnQfu3fs20uEjGyJI6QJU2DY7nYc4OxIQSyjZc0KuhnHM5bXq1rCfREVstXXrSPEwuePCpE0+JVfScDWKHKOQz4wZeqjzy+OtQYNBTqCOfZLMKzwgNn1w26VhZ87qyTgscQHM7+QWXqv7zE43DFbFTztI8AIfKgaAqO2EpJ/c/3TxVILDXehxvuh/VaitKg6dRM1RZa/3si24bv4/TuANaxmszpIKgY7NHj3RNp6OmRxmennyvch841GkK0fobLKLe/W9cDeRUQNxdcWzYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeBI8FSZcSZ2HuoFYJWWHI+BaT2vYAXqtgajDl10RR0=;
 b=qiA5GPThSFtWHB/eq8gopktZb/0Ckd01VLmaPsubkp6opG/isGBs4GaKRNjOzXHUlbKrz5NrVhbS+aUxaWxBcfK6811L/EqNsKyWsKxcFL91JHC4y5NbS96NSUYbJASDe6V6KdIv+yj41XQ2+qVqe8tvZ6qrI1yd+oz2fxPl42c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com (2603:10b6:4:2c::21)
 by DM5PR10MB2043.namprd10.prod.outlook.com (2603:10b6:3:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Wed, 16 Jun
 2021 06:52:34 +0000
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::211c:a5c4:2259:e508]) by DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::211c:a5c4:2259:e508%3]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 06:52:34 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v4 for-next 1/3] IB/core: Removed port validity check from ib_get_cached_subnet_prefix
Date:   Wed, 16 Jun 2021 12:22:11 +0530
Message-Id: <20210616065213.987-2-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616065213.987-1-anand.a.khoje@oracle.com>
References: <20210616065213.987-1-anand.a.khoje@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [182.70.80.33]
X-ClientProxiedBy: SG2PR03CA0139.apcprd03.prod.outlook.com
 (2603:1096:4:c8::12) To DM5PR1001MB2091.namprd10.prod.outlook.com
 (2603:10b6:4:2c::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (182.70.80.33) by SG2PR03CA0139.apcprd03.prod.outlook.com (2603:1096:4:c8::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Wed, 16 Jun 2021 06:52:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e84ad91-afe5-4fd3-3437-08d9309351fa
X-MS-TrafficTypeDiagnostic: DM5PR10MB2043:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB20437983F3E2377322E4FA75C50F9@DM5PR10MB2043.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m2FCRAEcw9Y1m2y/tzx+Iv6+8/0C46NpzHsy+X0eH9pnhBOBBKs4pMO/wd9zMmGpoA4k4zxTiCzOnCFE+wbWIIXQ3ytHBMB52TEgU32AiAp+i/zuK2LynIb0o2eBENP6L7u43b2204zwWYPhh1FodVMZcatMOR6ldy3gS6gI+fzL1Mnym9E5Fvk48QP1mLUazKXH5Rxc8kxcdZjayDNWlJiiZHth3+X3QccKzplj9YmjiQGUP8w1se47HWVzeHGc+rcfZ1MQYVBxM2PFLzxay1atIJMoTQZnzxx1lvIo5VzjiXuBEElvJ7PGgygEJMlbaFiFJGOz80T7fiLvWLwPsKRNZunmsI5tt3bl4IelnlJOvg9TGiw1jC/J1yYmkLwZe4KKK7D4WwMrH1rI67LYpgatDaF+YdtLRV5ykZUz0JkW4bBHpcSHx7EIbcsdccB8zM7JkNNcxQ9MidlSBqA9aOVi9f904DM2CCZX8WdHwqVBhe5FAEN/z+3NHRRHyDvHB0dRZ6Qof5Usua3O9KldE0CYhDWwMj7CuBzCu/WdUcMTLYxvk+iB2Q3azqudZihy5QGnRWO0NX/jMLzxavDwP5PtSXOMs5/zijoedMTyj/E+ofq48LAXl4MBtNocnI5fkl4lyN+hkyANetJ55+2tQ8RJPIGgmA7rdZtidecbLYSlt4tL17kspUuGCkX0paJ0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2091.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(396003)(346002)(39860400002)(6486002)(66476007)(316002)(7696005)(36756003)(52116002)(16526019)(186003)(5660300002)(66556008)(66946007)(8936002)(4326008)(1076003)(103116003)(38100700002)(83380400001)(2616005)(86362001)(8676002)(478600001)(26005)(956004)(2906002)(38350700002)(6666004)(120606002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OkvGvvvBeyXIf18DGAZ2YHLrzYVhY2XoVEneD6mSXFHTZ1Ea4Hs2f+h0t0uv?=
 =?us-ascii?Q?Q2NmNOWajDlE9hGcT83RQTuoYHdv4smIgIC4kBh92fiXY9T5VfPRRsaFFoBa?=
 =?us-ascii?Q?/6VK9s1/jSwVJJXwBhYlKNrDEp8k2q9uaplsI5EvIgxwRsCijrSGdoalEdjl?=
 =?us-ascii?Q?Ztxpk31qYiC/uJNWu04V/rw/+TEXQ1qjtmNPe35lsQu3aMraeGDRFCFOssTN?=
 =?us-ascii?Q?FOiH71/bGhzkN2gSxvgfQU2+/wrLO/I0P2zIPk0G7TYkXv0tyACzMhqJI8ev?=
 =?us-ascii?Q?C7YF6skwMCaE942t2+KkIdM9jWWvfaTRi3NdKC1EH/OZQ0/yML/2qtTJ8C3h?=
 =?us-ascii?Q?ZnXsno+4lFsM8g5XP/k4NNRc8ePG+YlFhJkJgpNIAthHExuvcbCna8x8ROfU?=
 =?us-ascii?Q?krWxeOtbeQIV6tlqVbdzDZGgrS//JE2S9VePWdFwSDlfSJfqEO6BMKqgn/oD?=
 =?us-ascii?Q?3ajrIRfYSUzQUkOCq9D1zxN3QIEI80q/f52OFewI1Cr4yiqP/HjfRAsjzzvK?=
 =?us-ascii?Q?rIvdNbbOaCY6FrjCZRzrmJUeWNy158VMndcAHvF7KuHvtIEcoglnbvqMMQBt?=
 =?us-ascii?Q?JC0A/0DFMd2drytn/LhoNZRhCNirGh+/Y5MlmBy1d4LXMko4McCjZ0oUt5NR?=
 =?us-ascii?Q?OyPtuE5RAPwtCG89q2h4l4J89DyuYXapoJFWpjX8e8rZBMNdH/sMQFMHB3jE?=
 =?us-ascii?Q?vJBHFM9PV+QmMxN0UHOiKeeXsNnl9zymGyahOHAQ//3uCefyQWotzgotzXhg?=
 =?us-ascii?Q?dop+0VYEyQ18Mh/ZC+aAvSHSsPxeagjR0sW6nfD0n5fwoFpQEHLZKD5nZLBh?=
 =?us-ascii?Q?eWgZ0qyun/LeNomMaoLlobYMSQUbzIDhp2SJnkjn0PDkpj028OKWBMV5RijO?=
 =?us-ascii?Q?oCA7eSdlEA9VF+mLukA80nKfFrY4NGZVWBcXK22JIFO9bCTFL5CxN+0RMQ9H?=
 =?us-ascii?Q?QI6pos1T24EWwPd3owsEingxz8ubUIZoakmF/qrb09//qZuC/tA7NZIgn1lN?=
 =?us-ascii?Q?KSbwvBgGnvKHRdlWC8nmF98W9hweNphZq0c6G5cyzez6Y2lnFKi8QpIaACMV?=
 =?us-ascii?Q?AhFwTMUAkChQF/iYn/CWZ8DVh63dNo3dIFGl4KQoVGwr7vWFphWB0JuhwpfC?=
 =?us-ascii?Q?Po8/ioI1Coo9b7YbKdOSbzlMaBfWT9uQ+Q/RIleCjZSP3stiMtR+jS4BMcdO?=
 =?us-ascii?Q?6Ubl+n32eIamO0L4ZUv86yBnrI+714Ht4rjVdS0YX3B4fGNHA4YZx44fE94z?=
 =?us-ascii?Q?ikfAVk2spdSSb51m+wdHgoPzp0x5sZvHoh+S12vXwoBf9Hz5gicSQf1A1/u9?=
 =?us-ascii?Q?m0bo/R0JK3l+RYNaB1qI3gbY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e84ad91-afe5-4fd3-3437-08d9309351fa
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2091.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 06:52:34.7101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNYptMjBeyWYASV0X1eFpjeDfWEjr/862BaOFws1a5ukpZHyEUDmMEBXoW1fKchPw8LwsXzp+0SzbstgslNiNLypU3RdQRDXaFVpJRxQeKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB2043
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160042
X-Proofpoint-ORIG-GUID: ooT5FvgiBaIJuzDqzn3aYw741zCNbmFh
X-Proofpoint-GUID: ooT5FvgiBaIJuzDqzn3aYw741zCNbmFh
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

