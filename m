Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5273AA04D
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 17:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbhFPPsY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 11:48:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:28702 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235677AbhFPPrr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 11:47:47 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GFgbQY032164;
        Wed, 16 Jun 2021 15:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=WOp52UuK3k7mrwgaUDa2D/jW3QwaECgKihn3Jyu7aeU=;
 b=jCgCq/NuvmEPgX6BzObXS+hFSGk2VpT/SaoIoUs7ZZ7W7O6HHPB6RtnXm9kDoVOrfnuq
 HjGfSo4ImhSIpsQVE7jGzc6ZTksMccTqkfBMJGnxkCQNIOpTnZhAg3jUZosjrrbTQAHb
 3lMPr6lz0doTNApUZbBPEAUeZu8ask+BziqWv2cV+mTc7dNXh/d17cRQIrDEUIaYBdHH
 1PwJIwKdt4jEl0+FE/9GEEIJyUi0RFrkA+ECNRccTiLtifcPBayCVpfmyMf8OhRmkQ2f
 mBb4EDbNqmbMPAAV87D33McFj8FrKd1+6h7+ZYhxnq4aXnZ4bM2h2Wuj6FwU/jx7mcPN eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 395y1ku5kv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 15:45:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15GFf73i078459;
        Wed, 16 Jun 2021 15:45:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by aserp3020.oracle.com with ESMTP id 396watgv2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 15:45:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0iAYnMs03mjvnXdMFbn/J2CmJyVOpjyMOe6McECrInDWxeafeSmD1vTuw2sBAcHLCphdIz1VhrCAVeyM/3+N3wkUqABLGlDXqyAH0ef8JR9sJ8H3QDim5t7rTLxrA+WzeWev/nFa32PQpnLaO0/Dpq/DqVq4UI356/c8EZji3IgczGnFBmrqR+JJ8Klkiwi9ZlT4u4I2jg8do/y5BA6hEPkRMatquVUzERhQmMAb4Kluo560gPp/ocfts9HOpvF9mAc9MaWr2+7WEittZ76aJHcdU2yoDGVXUHtMpv5Nf8DdPD+83nm6j6dczzm0jxjPmeRietSk7Mz6YlmPlQnGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOp52UuK3k7mrwgaUDa2D/jW3QwaECgKihn3Jyu7aeU=;
 b=RLNOeimMNvNltIg2wiiyqBA2jeC+fVuDGRlKtmamwWz33IH2hurinFCLxcyrTGb7osXdeWZeYAuzJ4hHI5cm+eMOrBHJn4aLwsI0OTtDBqFXbA1R6TNM88/Vku1pI7wJGhFUx/q9ok7IvqBa4VbQu8pivqWbEXKFiAdR/6biwFjUvuLqN24ysxsnA0OsDORUdUdNIcSWqEB9L8XwspcAy6C1aRLJDODpJqk5QEQqwB4XonDncS62QPk6Ym6Shxnu0TPB+zmcyBBhcQiXvpE0KJm3KWslVs+9Kn3tg1UymPmivG0ukQTCbaYnefTig2iXk6tJAAE05RmY1YH3KBjf+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOp52UuK3k7mrwgaUDa2D/jW3QwaECgKihn3Jyu7aeU=;
 b=sbyWnwl4OIXS4jXJ/GmVUQtDENN54s9bIpf5cJ8D7CUkZWfTnL0j+VJrIzpL+dgGK26uQbIdaWoaeUT9k6ZGZgVocEaeAAKglVPzPTjRjnw6nc9wVy/0Onb6zT/xXnqaJnNMAVEPo35Z6MSsYrK2fQREJckTaFct7Q+VhyUtjEM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com (2603:10b6:4:2c::21)
 by DM6PR10MB3577.namprd10.prod.outlook.com (2603:10b6:5:152::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Wed, 16 Jun
 2021 15:45:36 +0000
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::211c:a5c4:2259:e508]) by DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::211c:a5c4:2259:e508%3]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 15:45:36 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v5 for-next 3/3] IB/core: Obtain subnet_prefix from cache in IB devices
Date:   Wed, 16 Jun 2021 21:15:09 +0530
Message-Id: <20210616154509.1047-4-anand.a.khoje@oracle.com>
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
Received: from AAKHOJE-T480.in.oracle.com (182.70.80.33) by SG2PR06CA0129.apcprd06.prod.outlook.com (2603:1096:1:1d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 15:45:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0f7359a-1a9a-420d-32ce-08d930ddc85c
X-MS-TrafficTypeDiagnostic: DM6PR10MB3577:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB3577757265F0B1EEB9FE2A14C50F9@DM6PR10MB3577.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tMQLrDLzeqCEmY5F5O0kTLbfU35Xqpl2UYGlwskyAVaUAXpiNVrQIbUMnL9U+VFi6DoPEtXOORi0Nx0NQ1ANOdEvq1WMnEcsAKsoOlPRj2kVJpN3wS6RRuNvdaApmFnlUrFMTvIyHNpPuUFw/RE+PTZ0hmRQUyAMvK7kFUjFgKkl29UhuHYZFuZetOJUXPNrN6MNgBD10qfMN11Bp6Jy9dVFp0C8zyE86EpIqoq6lBDLaO8Bu+d9oAj0n/BpPHaoLRYSCggR3WzmljFKEntsDahh8lgxoEMDjaOj//sPkUTD6FSwS5ix4ogDTTqd15DJqFpTBLTwEzVbtruwEeOor6WPNK0fVGaERhzb6tFTjDs7zI25S0EVZs0xofjMvTdUAyNE7sNypQl1GtN7+Y7R13Wi3ii4ZohgjE2fTrVCsAnr+zCwl5E5r6c0qG3HJWEpqS32lS6iOzNAUmu5uMvBQyC/5IZEXMdkPxybucRbXh2JKD8z0BrrpNG6ixgfc9o0WHPJuoHPnqwwabCehSdCedAS2YtF/M5Bj5dcMNKANnA8dBqDDCzddevBWr6VAwhng29K/m36ZwWC9LmWYUGMO35ssu2v3nr36kBqpqPB+efCrx3EPqw0/v4AXxhUtDDEnY4pQCxbGHJfWXwDgXrBZHeWsQm40otKKdb/wHcvwojFivnadJDxKCOeGxnWjRVT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2091.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(396003)(39860400002)(2906002)(66946007)(4326008)(478600001)(38100700002)(8936002)(66556008)(186003)(16526019)(7696005)(316002)(6666004)(66476007)(52116002)(103116003)(38350700002)(6486002)(26005)(8676002)(36756003)(86362001)(83380400001)(1076003)(956004)(5660300002)(2616005)(120606002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A6+1yWl/IDOOiS7v7hAfaK4Z39jqUHEOjf/3Xc2Mh/5Spvlz5UXwJi3nsPu6/X6WX5FnXeC2rdnFu/iO+mwS3mVqoDM4QxAChdKXopAI1XNZdGI5YDD9eHprp4fCHyVrbqwkDz4J6crfzwb3WRuJnmeZSNl9pjmrbPvRn6EEnWJlDypTXkoBi5GE8drn+O4lQQ17rSFoPG2orCdpv5QaCHaLxSfZG+le0ON9r8W+dY0nk/rfVFRXJ/yQyEVOJC/mx1HXF+6S+dVRClIP79DvqXug9n3r9McdJXiTo+eiPxUyEVlEbKxSAVQQHEotfuqxuNenZ/5aaRGr5rR5IxbIEc6CKhH3r/4mtDoxQIs227D1kFZIy3tuHfiAhfWJ5zBTbKDknWsUsjDNJggKP5JN9HEEbhZiMkeoCe90nmnZLqW2IHV1uPgzKD47+zLZb5N3Ku9yTw90IvsHHkZhFPTq+pMcSZP3zWpjIRhe2Pw7llREOnL1N3kl34uhPXO1qb6OvHJQCoSZzrY5wdOF0W8DNolX9vYZfpfVEafHexso0N//BUpknzf6mxSTnDgw32frLCiC2W4qaM7LInkJzLApAX9WmnaHBuYEptwmzzxPtubAvU5DLxxJ+Ru1qM2etd+pAKI7Fp3hfG14hg07RSod6ehXstlg2EWKGPXQpRHn/SUqtxT/cPECuT7F1XRmd5EIIcgoX0EhA5J2X4RMGzVASF9N6bpB+oU75j0NgIMkkNwgHXNQzxUpJhnXEifw7EtL
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f7359a-1a9a-420d-32ce-08d930ddc85c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2091.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 15:45:36.0255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+sIXBgFeOF9d5ZjkE9h+LecgNMhlWvF/RIlcEyLXOqwiRlz827lXZJqI8Zz643wn3WXH3ACUA/JjUHff509e1zx7LSrZ3Oh/5AWaRxqves=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3577
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160090
X-Proofpoint-ORIG-GUID: -WtHbQTES_hwav38h0HQz3ErEXJfxwSm
X-Proofpoint-GUID: -WtHbQTES_hwav38h0HQz3ErEXJfxwSm
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

The function ib_cache_is_initialised() is introduced because
ib_query_port() gets called early in the stage when the cache is not
built while reading port immutable property.

In that case, the default GID still gets read from HCA for IB link-
layer devices.

In the situation of an event causing cache update, the subnet_prefix
will get retrieved from newly updated GID cache in ib_cache_update(),
so that we do not end up reading a stale value from cache via
ib_query_port().

Fixes: fad61ad ("IB/core: Add subnet prefix to port info")
Suggested-by: Leon Romanovsky <leonro@nvidia.com>
Suggested-by: Aru Kolappan <aru.kolappan@oracle.com>
Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
---

v1 -> v2:
    -   Split the v1 patch in 3 patches as per Leon's suggestion.

v2 -> v3:
    -   Added changes as per Mark Zhang's suggestion of clearing
        flags in git_table_cleanup_one().
v3 -> v4:
    -   Removed the enum ib_port_data_flags and 8 byte flags from
        struct ib_port_data, and the set_bit()/clear_bit() API
        used to update this flag as that was not necessary.
        Done to keep the code simple.
    -   Added code to read subnet_prefix from updated GID cache in the
        event of cache update. Prior to this change, ib_cache_update
        was reading the value for subnet_prefix via ib_query_port(),
        due to this patch, we ended up reading a stale cached value of
        subnet_prefix.
v4 -> v5:
    -   Removed the code to reset cache_is_initialised bit from cleanup
        as per Leon's suggestion.
    -   Removed ib_cache_is_initialised() function.

---
 drivers/infiniband/core/cache.c  | 14 ++++++++++++--
 drivers/infiniband/core/device.c |  9 +++++++++
 include/rdma/ib_verbs.h          |  1 +
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 2325171..88517b5 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1466,6 +1466,7 @@ static int config_non_roce_gid_cache(struct ib_device *device,
 	struct ib_port_attr       *tprops = NULL;
 	struct ib_pkey_cache      *pkey_cache = NULL;
 	struct ib_pkey_cache      *old_pkey_cache = NULL;
+	union ib_gid               gid;
 	int                        i;
 	int                        ret;
 
@@ -1523,13 +1524,21 @@ static int config_non_roce_gid_cache(struct ib_device *device,
 	device->port_data[port].cache.lmc = tprops->lmc;
 	device->port_data[port].cache.port_state = tprops->state;
 
-	device->port_data[port].cache.subnet_prefix = tprops->subnet_prefix;
+	ret = rdma_query_gid(device, port, 0, &gid);
+	if (ret) {
+		write_unlock_irq(&device->cache_lock);
+		goto err;
+	}
+
+	device->port_data[port].cache.subnet_prefix =
+			be64_to_cpu(gid.global.subnet_prefix);
+
 	write_unlock_irq(&device->cache_lock);
 
 	if (enforce_security)
 		ib_security_cache_change(device,
 					 port,
-					 tprops->subnet_prefix);
+					 be64_to_cpu(gid.global.subnet_prefix));
 
 	kfree(old_pkey_cache);
 	kfree(tprops);
@@ -1629,6 +1638,7 @@ int ib_cache_setup_one(struct ib_device *device)
 		err = ib_cache_update(device, p, true, true, true);
 		if (err)
 			return err;
+		device->port_data[p].cache_is_initialized = 1;
 	}
 
 	return 0;
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 7a617e4..76fbca2 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2057,6 +2057,15 @@ static int __ib_query_port(struct ib_device *device,
 	    IB_LINK_LAYER_INFINIBAND)
 		return 0;
 
+	if (!device->port_data[port_num].cache_is_initialized)
+		goto query_gid_from_device;
+
+	ib_get_cached_subnet_prefix(device, port_num,
+				    &port_attr->subnet_prefix);
+
+	return 0;
+
+query_gid_from_device:
 	err = device->ops.query_gid(device, port_num, 0, &gid);
 	if (err)
 		return err;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index c96d601..405f7da 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2177,6 +2177,7 @@ struct ib_port_data {
 
 	spinlock_t netdev_lock;
 
+	u8 cache_is_initialized:1;
 	struct list_head pkey_list;
 
 	struct ib_port_cache cache;
-- 
1.8.3.1

