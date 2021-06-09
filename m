Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109053A0C16
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 07:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhFIF5v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 01:57:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53072 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhFIF5t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Jun 2021 01:57:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1595p4UQ052304;
        Wed, 9 Jun 2021 05:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=vOKFHp5LBI7G1d+5RrJEj+q6UJgsg+h4nc8KyOkirA8=;
 b=trvgULrgX/sXQ8yIWx1orSr4SLEoBE/1/ehaSdOrseEoBHoonSYNsxiCcyAOk9zHoO0W
 y1Sj0uBzV8RRdpXU8/J9y78mQZ1espaPm2+hXpCGknYHR+vjQ4jnzZFpGR+JYTkDNKtT
 axboLBXYdKra2w6dayAbPjZnknGDVITgbrkKhvWRU2SuZ8S927s5SAjmjWpIP3iKA1Qk
 z9E37Ov3kbKr7utR24JyfhlOkEBuiGpFE9bac9sTzlr0mJbGXrV/YVPxZNsrB+ztBmZU
 JNpONlV2YyqjzbhsbAP9vJ+J3HZdD9mJ5LqeqQJm5k7coPm+VK4zi7EUvngfDpYXjDfN Mw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 3914qupg57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 05:55:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1595oNqn106264;
        Wed, 9 Jun 2021 05:55:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by userp3030.oracle.com with ESMTP id 38yxcvce2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 05:55:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVvVSGNkM6eql6rKjkP9bAaUXKs2QlWNfQiodwX0GJJCpTJ7zNKqXaPUKLl43o4y9XoELVrNrXYT4B0b1m/XIWeSKPPjvfXkLe+4JdVeG029rVfEF/GzNP83Rwi+7/uBEOxut3UryzaNwKG72ihlobADvCRW0hhE4kbWVl5iRjDoFhipY85XqU5jkLPgj4bjRrjsJPiDHpeTrgtwbeI+O/ggvkVzXJX/qJQHhFV/G1I1He6j9UHuEOurvmSSwxEi5S7+nH9bNvJ9/hfLvpAfDNGOnKVW9bpFO9TLn2K8Ihtj3QBkpSBBw+oQR2Eup5qcFHPdyYbOxZhQPGmIsXmnBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOKFHp5LBI7G1d+5RrJEj+q6UJgsg+h4nc8KyOkirA8=;
 b=AP11tcRa5OPp2IvVrxuM3iZUXGN1keV5KDMsF4jGLsDxgZYqSG9qdnjM8WsM1+tYOLciOTU7o4fkxDZgcIFea+3ZlMevOH0ho5bv3jXwf+ZYyBjse0DGVimZNU12gY/q/q3NIJxpYsvNJx2CIHH2oZRAAG0W26PgIK5X2COPPSbbTEt14MpnFrMsCpcPKh39klAEujRbOtBc7FZe2XeJom9QnusWRjIuun1htOTITRm2712CyHxM+vY42ojsu+1J0x/VJUJxhPB2o08VZYngFe8E5XlGivwdz3HlMifP9tUjbQfHxd2Bb49nLHYEqUjPyIJ+ZU5Ku7gnBtF5i6ac7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOKFHp5LBI7G1d+5RrJEj+q6UJgsg+h4nc8KyOkirA8=;
 b=jPI6lWStf9KOOxx3PLwEmYnrMHAkVtuzxiyej+8J0SkMtjWEtlx0NjIGMFJT0BJpfEV1c74fTihu2AVJnOKgrvA6a4CIE9nB/iIRnbaLSoGSb6k/sco3nwpAp4FAq51vK9QoqMUNZTmcPT6F+rVq8Hkqxsj5jjRa1zt0o47+rYc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com (2603:10b6:4:2c::21)
 by DM5PR1001MB2217.namprd10.prod.outlook.com (2603:10b6:4:2e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 9 Jun
 2021 05:55:49 +0000
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::5c05:40f0:dbae:4c71]) by DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::5c05:40f0:dbae:4c71%5]) with mapi id 15.20.4173.029; Wed, 9 Jun 2021
 05:55:49 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v3 1/3] IB/core: Removed port validity check from ib_get_cached_subnet_prefix
Date:   Wed,  9 Jun 2021 11:25:32 +0530
Message-Id: <20210609055534.855-2-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609055534.855-1-anand.a.khoje@oracle.com>
References: <20210609055534.855-1-anand.a.khoje@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [171.50.202.152]
X-ClientProxiedBy: TYAPR01CA0029.jpnprd01.prod.outlook.com
 (2603:1096:404:28::17) To DM5PR1001MB2091.namprd10.prod.outlook.com
 (2603:10b6:4:2c::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (171.50.202.152) by TYAPR01CA0029.jpnprd01.prod.outlook.com (2603:1096:404:28::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 05:55:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f7fe617-3687-4b5e-6f1c-08d92b0b3bac
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2217:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1001MB22173C030426F18C0B7701BCC5369@DM5PR1001MB2217.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1tt52OYNeL4b0DEd/np0pSBFxxLT5h48h6Sxi9yRu7SWBjKI8T9RFxTTe3D7R8GYM6D8tRGXRHJSWl8+lkk+aqvLmn6F9E25h1I6sIu3pCTq7WPVNjVD+Ub8NenmDND3RsX1Lrwn2BrMHWTWr5pZQI5BcBAhXXRjfxidpvQavvqYmBwvbyniXNA5cGTClOJsmNMuhWViE37H6Ls/BkZ42dSUPC0retw03QgwYoADskrz95Douc3shjCfYN2XAPZQdr04sv4s5JcidKFdKiIg2sgzSK9JNvM2MnR+F6CUexMudMoq9NPNaz3RdbOsKckVw4C1UyOp3TIBxfWnw1bTEAPRnIBaLKk6bHxRigaS7k1PYNTYSg0KIj7DrCopbbwSA/Z2tH94NtMeJ1IYgwBV90aksfuT+dY0mNe9L4F7H4aSRoxVyLVMPOXXcUSwh1aplrFIsPo5v+dM9jOu2js4mJHUu1pSmVB3OTkFCAcN0BpzdJgHuRrUYGcKtLtYgRQ3NY4NgL6gBsVHr3JVAQnBMnS8VYO6R8hCCZHCgTTHCA8oj9YsRh5RVGtSMEywfrwxQX12oxemH5vLk3977owPmwDc59hAWAWoaWpwettFtLunipJo8/FjFZZz7K0g51iphQMQsGHDGmhqsoBbm9PbJqMGwRQprw6NbfMgyIJtTCs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2091.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(136003)(366004)(346002)(956004)(2616005)(26005)(6486002)(1076003)(2906002)(316002)(5660300002)(8936002)(186003)(38100700002)(6666004)(16526019)(66556008)(38350700002)(86362001)(103116003)(66476007)(52116002)(7696005)(478600001)(83380400001)(4326008)(8676002)(36756003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pvIXxbMdMbWOo8RHhDv3Ht17B8x4P8s7FNvMHgXHx9UCRucjG3uP9FZJuO5D?=
 =?us-ascii?Q?xIuL4DgcaNqh/tU/AHC3h+5y1lzF5lVMHdhp9DNxZvLE4eNP+dG+a/pu1b4L?=
 =?us-ascii?Q?YQotnLJzaLwFFooldT9evxFYDZFQCGaUARq6U6zh2v5OehmUw9cPbQqS5cLR?=
 =?us-ascii?Q?ZP1fEPeawz450cJIgf09LkWCJyB2zFQwBYlHDfibx6+nsfeuB/DzLzvD2wT6?=
 =?us-ascii?Q?7I1LlxuT5iFU2BJtaHWfQg0PsLrPmqa5+ar1MxQCv2HiocV8uoG8EDjNQJQ7?=
 =?us-ascii?Q?J28fkVcokKRx7DZpQCxuZWj6Md/XCkeu1XEZoFvp/rKNUvEsF3H0NhLEfNSa?=
 =?us-ascii?Q?cTA9T87AFxNF4Dnkjq2QufmQn0xogVQBiAZwZ/QBMAHlUgNMl28Ltme1G0hf?=
 =?us-ascii?Q?07rwUafFXBSGIiNgCNNtSS+EREDzNEDUhgN444yUX6piMqLVKQexnZ9i7QFb?=
 =?us-ascii?Q?AT3nwOc7J8PKDr+u/o+/d7yAKtxj89QJ0bxdsv0G/axSLV8JH9wTfo2eXWCb?=
 =?us-ascii?Q?fwpsQT50NGiF2wOcFR6DGHpeuNnuxV4/nSm4s6qII4cSJZ3mnTZfAQg8P8Xi?=
 =?us-ascii?Q?k2pn1726HTPHLTRRNO/AcbbaLznXWceZLyDaGkYUU9q+4ci2mSOBy9ywtoRH?=
 =?us-ascii?Q?Gwp6PlAo8+Xqw4CdaFyJcbtxX+6IzK0gw/ksjm3SbH1pFMdX70ZKiy0HZVIB?=
 =?us-ascii?Q?TMQQG5FrMH8lL1rfikv7AmReBe05Am4LEcIsmEmkJM0pi5Y7kahyjhHvIW6M?=
 =?us-ascii?Q?jZbn/XMiz5rjsy5oKBJLBN79HBNpoaOOWU7StmZpCW8iMQr3It7/AKXwMAik?=
 =?us-ascii?Q?2EwSaXbJc5m1UmFFfRdanpTkDVXWOnZMtygP5Mry3sz6m4OULszISWj/YONn?=
 =?us-ascii?Q?J6kUU2JSrkT7eWbI+u+9+C/X2m7KwxC4j9ENnxVz2c0tOftDF5g7vseHEzHD?=
 =?us-ascii?Q?QoQUQdiLMcGBymNUpr6vvJIxVXNoeJIvGzL0U765sY82rZoR6VH+qLWCfpoU?=
 =?us-ascii?Q?Al/6HbJWAhXpkwaSfIWoMOpPP6RIgVohUul8yTqeT2mZHS2KFwrpThEK7f93?=
 =?us-ascii?Q?FBgXKfzbCQXl9Jf5nFHrOTKQqFH9OVoy5hSNbYnenHn/X/MfemzNxvbEACSx?=
 =?us-ascii?Q?58lK6hZ1AEw0uY9yjnoDIgGWZp6Lmzmcib0mU/5IiHP/jOvZgPReXVxnb0eP?=
 =?us-ascii?Q?eBQpUiD3Mg5JWDd8XWFhkZTHe6o3rmFBDNjYFBqRuVm+j0Zk1gCZ4wYQ0lc8?=
 =?us-ascii?Q?lEwAHUNawH9HyLFPP9Wfkg11/e1IWgBk0foUyWSiqLr8jGtgceBFzBS0xnXw?=
 =?us-ascii?Q?gmxWqB6qdMkaBrJ5kuJTgNF4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7fe617-3687-4b5e-6f1c-08d92b0b3bac
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2091.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 05:55:49.7865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQV9Wz6GTKyl6uHNKIP+EU/SzaLlo9rDdwV3quctHkjgij32tca2rKtObRJAt0bCqpdxIwo6VgH0/+XFjbfh63dyUw98OIju+dNxv7/1vqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2217
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106090018
X-Proofpoint-ORIG-GUID: G-hne0KJIVuObOZm6CyejLU47AnKxLGF
X-Proofpoint-GUID: G-hne0KJIVuObOZm6CyejLU47AnKxLGF
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090018
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Removed port validity check from ib_get_cached_subnet_prefix()
as this check is not needed because "port_num" is valid.

Suggested-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>

---

v1 -> v2:
    -	Added changes as per Leon's suggestion of removing port
    validity check from ib_get_cached_subnet_prefix().
    -	Split the v1 patch in 3 patches as per Leon's suggestion.
v2 -> v3:
    -	Added some formatting changes per Leon's suggestions
    and removed return from ib_get_cached_subnet_prefix.

---
 drivers/infiniband/core/cache.c     |  6 +-----
 drivers/infiniband/core/core_priv.h |  2 +-
 drivers/infiniband/core/device.c    | 13 ++++---------
 drivers/infiniband/core/security.c  |  7 ++-----
 4 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 3b0991fedd81..e957f0c915a3 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1069,19 +1069,15 @@ int ib_get_cached_pkey(struct ib_device *device,
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
 
-	return 0;
 }
 EXPORT_SYMBOL(ib_get_cached_subnet_prefix);
 
diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 29809dd30041..0b23f50fa958 100644
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
index c660cef66ac6..595128b26c34 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -886,15 +886,10 @@ static void ib_policy_change_task(struct work_struct *work)
 
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
+
+			ib_get_cached_subnet_prefix(dev, i, &sp);
+
+			ib_security_cache_change(dev, i, sp);
 		}
 	}
 	up_read(&devices_rwsem);
diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index e5a78d1a63c9..543391273b82 100644
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
2.27.0

