Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DB6399B06
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 08:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhFCGwj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 02:52:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34742 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhFCGwi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Jun 2021 02:52:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1536ibWd093340;
        Thu, 3 Jun 2021 06:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=MWidZL4M6Z31aZWtVKlVX7T88bPx5cGEVfH74LaU8Vk=;
 b=d2YoMN7nuS7WxJ5D+11qQ6/Xa0N4ULeFLGYTH99CSqVd0CabL/Wn+oDfr2BIM/p7fOdR
 xLHRMV5tdjVR042isxGnmo0KkYid1o5DqsoqGGis6/tKRM2n/moqosLLi6NNSwBSqugx
 xNeeT5P0dedjXNGZercK3aCP3hJssFrXI84uIJIw6x8z4ubNC47m2HXvz+Zu4L2YQp7m
 +6JCh4riqVJ8tNvJEc1oIhbV3nL1n6Rh10rhRwjmI+bx/E26ANVrsVr+tMpiVXF0jcbD
 lUIuGDFP9p0PRPRCl2W+ZszdlL6MQO9lqRuD792EHFres1vYol3x+IKyaruDP459S3Nd wQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 38ue8pjd56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 06:50:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1536ohAC045092;
        Thu, 3 Jun 2021 06:50:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3020.oracle.com with ESMTP id 38x1bdm5dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 06:50:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZBFKiPhUVoCYRCKnCdahHmXnlQqJ+8x53uG+lgnPnQKex/VpeUJ9G66VCnACrISYi5E6PAe9Ooz/Xb4k3kG0OgvfEcghTKHn6ZugufnPc7WED/SBdFeeOXpNhzPa/X+gRgiFbcA7yL8V0MGTGXTiggqrUev1OF7Yh/qY7IzhT2nRV3qEpL+IXgWNrtwxAyGcUgh4Pny6jnwMK1t44N1F5DWZeKaoX9uEX0hKFbPOkYuhe0HbbjUWWDH3i0znYKPzM/3X/PMNFTZp325VqD1ciYRIbHxcMuCVJ1UFvu/Ko75MH/CYb01YtCUslQ1lS/gvBeWn0axAjqnIWVgroQiRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWidZL4M6Z31aZWtVKlVX7T88bPx5cGEVfH74LaU8Vk=;
 b=bFdiB7Dlc/oFeuUdz1MpriUNF1xW6ldTYR0NLD/+YOXeNDuu/5TTbjXkMy+m+xIS+GrqFdaFY73khikEU+H5KUtMiYSH/jS0vs6dkbhB36PyGz2gFPF/2uhlEetIeR7ylaVTKccvm7/AL1hlJveY3iHX5HfazmEqtkholFnNen80kVCPkgUdT0f8qE3myRaaAk/4S0ExdX6sMGZpMqGc7tlXteiChyopO4qYtbRgvHLgV8E3LbwUnQyC7Y/hQNMVgH0pj4BJkdok0dJ9UGTM/4ad0amPBXvGOGxeojTyP/QsmecZPoQq8LKbWKVpwNxek4timcAUZprENZjPx3mF6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWidZL4M6Z31aZWtVKlVX7T88bPx5cGEVfH74LaU8Vk=;
 b=AduDJI+mKeEUwPPmLNZwz3Atd0whtnw0bieZMlrwRERIYeJyJP8H4PUQlcWMNFpdZfJNU3XZ+Qsx4Tb4v/yIkQP4UUsNHvsCO2vwwZj5nrAdH008ynEwsFVWXc1PoLzxCBCH8t04oqlYWTn7zM+leW2/WNn2D635akSC9aHNciw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com (2603:10b6:4:2c::21)
 by DM6PR10MB3979.namprd10.prod.outlook.com (2603:10b6:5:1f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Thu, 3 Jun
 2021 06:50:48 +0000
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::5c05:40f0:dbae:4c71]) by DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::5c05:40f0:dbae:4c71%5]) with mapi id 15.20.4173.029; Thu, 3 Jun 2021
 06:50:48 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v2 3/3] IB/core: Obtain subnet_prefix from cache in IB devices
Date:   Thu,  3 Jun 2021 12:20:24 +0530
Message-Id: <20210603065024.1051-4-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603065024.1051-1-anand.a.khoje@oracle.com>
References: <20210603065024.1051-1-anand.a.khoje@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [103.127.23.88]
X-ClientProxiedBy: SG2PR06CA0205.apcprd06.prod.outlook.com
 (2603:1096:4:68::13) To DM5PR1001MB2091.namprd10.prod.outlook.com
 (2603:10b6:4:2c::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (103.127.23.88) by SG2PR06CA0205.apcprd06.prod.outlook.com (2603:1096:4:68::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Thu, 3 Jun 2021 06:50:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0931585-33c9-467c-5434-08d9265beb3b
X-MS-TrafficTypeDiagnostic: DM6PR10MB3979:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB397972D669437278AA729894C53C9@DM6PR10MB3979.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PO7B5bLFZyIk5wbG5hoj6kw0j4wQbX7/Nzu8G522d3sqNNE4Izyortt8PXSRnCbY0E9K61C0UIipCS/nCGJMrp/nbnitm2kPp0MBhLHmiWv31MZcuRYgg+a98naqYjBj4Sd6RJqy3N1NSzuv63YJhASt348hyLZ5jJJCRYTrTog7EW19cN3AmsyV0gVHciFKZ7EQaIjzpU8ISxWQfefRj3QBaj8sNrh0mDA9uMj3PsF6jV9COjm+ArXag7Tla1K2vw8h/tb8SYfXI5C0nc0li+mX4GmPK0uSUJiY/KsBVafmCltK780fTSVRhol0/yGn78UAr+fUa8QolhXZdixrndgNF1LQ9RPUyKoXsU1hBmz/cyVxH3GHe7Kt8l38Ffx1cpLmeg2bWE1hwLGfup4OzJGRjmeHtBS725qjl1z9TTyE8zOTV1CMR3iVn5Aw7UwcmG3fc65EDyep4pPnskTibJBTmLVLlrW/ww7/33vdLobEUqa1N/dw6SVgY0WOq2bxvzkI/jT4G20QASa5Vs0uCORcz3DJRfQkBrvoSCiGBF1G1DlvRz8mwVBaYRnJzmElRyU9V48df+FYx6q6/YX78cyQgQHxZ7GXtywB+sLOZl5j4tdcVaVKzBKW3ViKCDiI4PZRzemYh1TryrEtStkjgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2091.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(396003)(346002)(366004)(66946007)(66556008)(66476007)(6666004)(6486002)(2616005)(7696005)(8676002)(86362001)(52116002)(5660300002)(1076003)(956004)(36756003)(38350700002)(4326008)(103116003)(38100700002)(186003)(478600001)(16526019)(2906002)(83380400001)(316002)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zSf2AanW6Kys3lezN4AzC92wepYmo9mh2zYoSDbvDiaQ0fV38FTBCBw8PcEO?=
 =?us-ascii?Q?XFU8MY6aH4tZhRpBBdvh9exIoQwBbHAU8mDXtKjQkOnm8bIBGhai5poyxoDr?=
 =?us-ascii?Q?6hRhnRwoBGVE0lCe/fLCBABomVXVW8aaeHtmRnQM2TBhpAJLxr8gna1nhZ8L?=
 =?us-ascii?Q?MczTPWEa5hcxNRORAE6btmfnzVoRF3fjt1kRglTSYcmg46A3XqjyefKbaZsA?=
 =?us-ascii?Q?BZS76nQ/bSDTAkD2ZcBfhV29fllXuCoxHOhEp9Pgf1Nb+2rCJU5yJVOrOSq2?=
 =?us-ascii?Q?ZGVhugaM1aXVy6OTpGc8ByXdbNCZfK6oKNi7K4ZAFpczgcuH5x/DBsqpl8jN?=
 =?us-ascii?Q?G910Rt9zLMvlQ6b0FC86C7OXv5qpEWX9Ue4kh6kV5o4EzTyRsMcXdNPKnjLK?=
 =?us-ascii?Q?6XvCBcJ7VmEKTmVI8wir2lRzgazIeeNpdsbl5NkfXlAsUqow5FQ2JG8uhJgf?=
 =?us-ascii?Q?5jpcldMg43UjdKWGkfYAKm65TH0aGCr/JK3wJ6iZuE7L9MpDGmrn1HUZsLAP?=
 =?us-ascii?Q?FPyMETc8NwFU+VEpjoRDDHQeipUDD1HQ/+9KLs+UeTyyrJ0JJe6a1QOh/Fk7?=
 =?us-ascii?Q?dE0Gekj4ed4MQoQoAB+Syhoyc2igXf6abmwDOmkglFRVLafOtk3No6IoU+Em?=
 =?us-ascii?Q?zG/CFefVhcGg17rbkMrWzdISY/8lO4BMDwm6UPntC3mW61lLJV4/vKm1Sn/E?=
 =?us-ascii?Q?4q2QJYm/kpBynrHIkR74NOabHz/032TCrYwwh2upfaYXTcLJuDX878afipE4?=
 =?us-ascii?Q?8M0yyiidUHucNuqeakr03GhjdPBkL+o7xbEPqO5Hso7MmxdwRjoVWWlWxGjC?=
 =?us-ascii?Q?7PY1HHopZQyhNrHQkJV4ABZm10hGfNS9hUyFDQYp3VLx6aT18cwP7Zbvu/n/?=
 =?us-ascii?Q?HmBiUFBt956kaFbCxS775wfVw3OaOR5TwipVi86MNhx2SzW9y7WAkmXnZFtO?=
 =?us-ascii?Q?Vgo2TYYt7GjlpAaKWYigJQO5FTzUPbXDmrmgxrZUgBuvTAY15+iAGpmx5k8Z?=
 =?us-ascii?Q?oj1v8XInZC7gpI/s8C5TNDL49sjrzcsdqSPfAe2TXM8g+WSXGTYZzEwxQsLQ?=
 =?us-ascii?Q?sxOBKbEyGsuzJfDFzFw25Dce1RpxaUiGKaaSx0EEvLXquB/fpbc9YFoOIJEx?=
 =?us-ascii?Q?cF/OggCMqTlfas1VeqZFGmWjB6WgfQsO3y4HKqSiz2QOdg2YgDc7d6uMd/gm?=
 =?us-ascii?Q?VKgs7VUNFwLWWU8tUJvhjR5HfT4/IqjfX2ws3fzsrq9UYrpgUoQTYlP7llJK?=
 =?us-ascii?Q?4k7jhYRbDLp8nFq/4hBXzMewpO6fEmhCDVJDa6L4HVeVJLP4fMkQRWUjvL97?=
 =?us-ascii?Q?3seQ1nvtobdDIhFMVo+hFcA9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0931585-33c9-467c-5434-08d9265beb3b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2091.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 06:50:48.3277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CokmtA9du5lM+CGRW3MsR/zB6yNqGt41zZh7heNBsR0jxrwr/mzGRUnzneeIilkqQAQJXfOOPMcH/G6yEmpGSaN9OE/EIeMejKlj5eMWJrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3979
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10003 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030046
X-Proofpoint-GUID: SzSg0Rxbgk_jcDzW3sted2xCPWwgMD9_
X-Proofpoint-ORIG-GUID: SzSg0Rxbgk_jcDzW3sted2xCPWwgMD9_
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10003 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106030045
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

Fixes: fad61ad ("IB/core: Add subnet prefix to port info")
Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/cache.c  | 7 ++++++-
 drivers/infiniband/core/device.c | 9 +++++++++
 include/rdma/ib_cache.h          | 6 ++++++
 include/rdma/ib_verbs.h          | 6 ++++++
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index b6700ad..724ac0e 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1624,6 +1624,8 @@ int ib_cache_setup_one(struct ib_device *device)
 		err = ib_cache_update(device, p, true);
 		if (err)
 			return err;
+		set_bit(IB_PORT_CACHE_INITIALIZED,
+			&device->port_data[p].flags);
 	}
 
 	return 0;
@@ -1639,8 +1641,11 @@ void ib_cache_release_one(struct ib_device *device)
 	 * all the device's resources when the cache could no
 	 * longer be accessed.
 	 */
-	rdma_for_each_port (device, p)
+	rdma_for_each_port (device, p) {
+		clear_bit(IB_PORT_CACHE_INITIALIZED,
+			 &device->port_data[p].flags);
 		kfree(device->port_data[p].cache.pkey);
+	}
 
 	gid_table_release_one(device);
 }
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index c2fa592..b3e20ac 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2060,6 +2060,15 @@ static int __ib_query_port(struct ib_device *device,
 	    IB_LINK_LAYER_INFINIBAND)
 		return 0;
 
+	if (!ib_cache_is_initialised(device, port_num))
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
diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h
index 226ae37..1526fc6 100644
--- a/include/rdma/ib_cache.h
+++ b/include/rdma/ib_cache.h
@@ -114,4 +114,10 @@ ssize_t rdma_query_gid_table(struct ib_device *device,
 			     struct ib_uverbs_gid_entry *entries,
 			     size_t max_entries);
 
+static inline bool ib_cache_is_initialised(struct ib_device *device,
+					  u8 port_num)
+{
+	return test_bit(IB_PORT_CACHE_INITIALIZED,
+			&device->port_data[port_num].flags);
+}
 #endif /* _IB_CACHE_H */
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 41cbec5..ad2a55e 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2169,6 +2169,10 @@ struct ib_port_immutable {
 	u32                           max_mad_size;
 };
 
+enum ib_port_data_flags {
+	IB_PORT_CACHE_INITIALIZED = 1 << 0,
+};
+
 struct ib_port_data {
 	struct ib_device *ib_dev;
 
@@ -2178,6 +2182,8 @@ struct ib_port_data {
 
 	spinlock_t netdev_lock;
 
+	unsigned long flags;
+
 	struct list_head pkey_list;
 
 	struct ib_port_cache cache;
-- 
1.8.3.1

