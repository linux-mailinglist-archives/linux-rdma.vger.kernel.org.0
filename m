Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A2B383A68
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 18:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbhEQQth (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 12:49:37 -0400
Received: from mail-mw2nam10on2063.outbound.protection.outlook.com ([40.107.94.63]:14656
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240504AbhEQQtR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 12:49:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsGy09jvzAuUKhtph+mAF8JaAVNVeiwRsjwBM9JX2B22flhcO0W9QMJkEuaist71SN3ieZ4Ld7WNmAgL+SdU0mGzOv5MclqHJCrpndp0DoYT6g1Qe5ddzB66SueGjtF9WSwV4wpK+zEMcl15PHNhgcpK7dvHB8Wz8Z7O/LS8hyxv555dPLOISwpNvsNxMeFSzVltWjS10fWHufNStV0G0oceKGvsGE3AV+YBb9adC1r86cDvDyM5ZqgNX9E8ay5QwCiGwriGKmrLASMjHlRy5KSIWBGq1TpSIXq8fLpIe/AzPbcgDa1CRz6cddYsx3j0wSMrm9qey/LPdfBsGJYteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4trntPRBi12qCS0o1Ip8Pss73ZdKATBQ10rPUxnpQs=;
 b=HN3KW/x12a7Ia4j9GkdS0OuPfVIKKk/lYXUJeyQljfm0i8B5S3BOB/6/o9SxvdqNdtDHxzakbu+lHKlBs6xzswVVJzGkrjQiAGGaOaTBxWA+FC6C1k2qpmG16o9KlufJqXn7CpWHHwS7qQsaCMM+7YZLHb+DmObEjH6cNjASVLmS/4u4I3qWZS6aKMNonQrAgLdDGvE/iWynycTjweHNC97ibgzAS1e9QBRoG87T6qlTwPXnnz6+ax9ciVxceYzA2oIPb2fZU7G1cXk7+JvBzjjrNrCXD62avd1Swv4qUDnk/eNeV/12KNXmg5PbeVwWlWGn8sVE0bP8aRG9D+71KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4trntPRBi12qCS0o1Ip8Pss73ZdKATBQ10rPUxnpQs=;
 b=sbB4nVT+DNWkX3nleJPEpkkYsDBFKKyffg9GgdmN4JU4FXQbb7fc6FUpl4gGydE8Ilxqfdvq56+TSMp12/SfQcohZ3B7+7306MfnBXIQ7RiwTz3RX0g+ejUWcrEl+0XnitwbNh+TOxG2NstMd91IaHL+M1ndkLcqCjoXdGG8jTGgPxJ/ziMdCUQUtJyrtUPea6CchdgPzeuAO7DvJ+WqsU02VQ1fNROK0ITd9LVaMOTVqbDQNiwKl2N839sIwf6fIGLY+afk9UJsCJwnZsMlA3dMhJIcwJAfdIyPK0+r1iE+GoFBh6xsOGi9IefW6Q/cQ9SNQF2NyF2KAeKobZEsBw==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 16:47:46 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 16:47:46 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 02/13] RDMA/core: Replace the ib_port_data hw_stats pointers with a ib_port pointer
Date:   Mon, 17 May 2021 13:47:30 -0300
Message-Id: <2-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
In-Reply-To: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:208:23a::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR03CA0030.namprd03.prod.outlook.com (2603:10b6:208:23a::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 16:47:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ligP7-009LYP-QO; Mon, 17 May 2021 13:47:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 885a31e6-361c-42b9-f590-08d919537e62
X-MS-TrafficTypeDiagnostic: DM6PR12MB2858:
X-Microsoft-Antispam-PRVS: <DM6PR12MB285837FCAAA94E533358CCD0C22D9@DM6PR12MB2858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2yYxfsGoSjBE6jipeBJHA+kKY53qwekh8qN5/BTX4lNbaz9+1qTfsH/MQPOSNAMTcHWptgKLuUOiVUj+hA2h9aNjgKz6jbrhWhcCrPZC/XQLDr/lOLV02sLMk/+mvjYoyANGOq6X9upcYtT39bUSXDq+Gp4Tin7csltkl6We7q6r54AMF/FNViQWdCtRSoahjxmGOQibDYAXKdhiw98NjcYqSCpp7lGJH0/EREABh0zZ+7olGWi1z+Lpp3H7GmVhk+oc2TZ7K19i1ieakLvd42scBpkgBGek3igA/cpgL0BXlKOuJJKQQfeTpVP6+0NnS9Igrw4pSnXTNOrMQiYlExk/N/KgTeddBTqV0R4+ySkdgRsgynIZfWsnPl0iR0dU5PemsgGYczM4YFIECuNrFk+14CZCwOtWqQiovz28JbTBjWlvOhzBcO1qIwA8vrXZrETBObzDe3HojBOtWTHYUU8fCrrtbej9pdhhnEnyqpa/ClcPTvDTL/LVskk/TvP3U2y2A+ixV6KcxYV7suzPyT7Zprz4YLghvzjEfQOFQwJbv5rIXx1dbJdCtzP0rLHw21yKK8rkpN4iVRgke/SsjnLa5oeBnEJoPxOCEMEb1D9ZZz2Tf4DWuex1y199a3Gyko/M+bAy7sSEDbKbTw8tYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(54906003)(6666004)(9746002)(8676002)(66556008)(426003)(83380400001)(36756003)(9786002)(26005)(66946007)(38100700002)(316002)(66476007)(4326008)(478600001)(86362001)(5660300002)(186003)(8936002)(2616005)(2906002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?z03RZuTpN1G9B7BjuXZEZCro/YvGoMEy0CW+ndTpGp1lOlff0Ps9KamGBoSY?=
 =?us-ascii?Q?gke16F1IgPkO+cnW381q+fpBLV/CD2G/Gpdp0YLpzTUtf9w1tWfw6mNE801U?=
 =?us-ascii?Q?2BMaKxr7kI9QSOwNib9Ch/AGeiMLvci2DyP1LIgAT60pYJUYPDUfxMe4Qcvk?=
 =?us-ascii?Q?SZd3CWq5qOl92x8CrMVBt+fFnuRs56k9stW71nJA0hsRilYQi3zBe0Jizsis?=
 =?us-ascii?Q?PT27gwv0nR2ID/SSdIxtu/PBzFoIHP8QO4qrsu2thE9eO9zfLwbdwLB3oXd6?=
 =?us-ascii?Q?Sq8Ln3BchBb2BTFD01fqTelFrDrp+vP8dgKk03TGLTjMNBhwMA+HGimmJjKA?=
 =?us-ascii?Q?5ola9eKfNI6mp/M5Tw/hFDUHQ7Ne46zj2bPWMxCga/eWgHVOgaiqC1Hy7Ogp?=
 =?us-ascii?Q?K7AfO++cx0ifuWhVf3MK/kQ7PBKGM1mH0PAhtNSiGRf0+L0MENUWuhHxD991?=
 =?us-ascii?Q?nbeB6n+9Xy2/hffAxuzW9ZG0OaiJUiPBeqG1FxCPft9dq0FZzI1AY2dEGaTi?=
 =?us-ascii?Q?8F+XC1IXz6MHJ5MbvelxbA9q24k9Q9nkDAOxEBPlwBZvq1HBJslMm+B20h64?=
 =?us-ascii?Q?jn2BW/Z9pE4ySuxoV8ozoLjhsnMsfXxXjNnZcnWlnJJMXqFJSobgOY+S9M6A?=
 =?us-ascii?Q?XbJ/UoYhJMTAbLmJfTqX2jESAe4oHf/jsdfftloExJZj05cr6D03H8pzITdO?=
 =?us-ascii?Q?Znt5ME28MTamx3RvCl/Tj6iRTZqWsFv7eJ1k84hjrYrRyjc6uv5oLJbCr5XU?=
 =?us-ascii?Q?t0g7pf29CoZGdxau57DBmWEVn6SR9F00lFCgClk7jONYN+kGgT0HNFk2+Gw6?=
 =?us-ascii?Q?A//RexHGBdytyi+LHuVdmwsHbUzqe/2D82ej9slF5cqPydngyeDCalD5YqmJ?=
 =?us-ascii?Q?zP+Z6FUv+kQagQJ/bX0sj1TEMEZfwA/McxHBZklhZWyEgAHgJaykg45EWVgO?=
 =?us-ascii?Q?GyHrb2q5oiYWNyK8p8W8hiHRnZNfguwL9IMqwQcwDVgvU0CzwR9HYRFbdOOF?=
 =?us-ascii?Q?Df1aTqsDw+lGY1zRyIGTyyHQOg6px3HTb/uas4apxgruQg8Awv/suoY0vsQR?=
 =?us-ascii?Q?ThLeLc/3K+enJ4HDcvRC488kOFDFGkEAepahOS4vLwMKaNd39/JM2h+VnVXT?=
 =?us-ascii?Q?J0WBc9F3Y9lPrNjWsNd154kSQvYnUyvaUOA8bni6Vl2kiCF1lc/Y9Yfczexr?=
 =?us-ascii?Q?lrIbsllzN4myr33vqisCu5/jre+C/LjyIUaNEKc0fmQqunX4HJ/iYx59f6mV?=
 =?us-ascii?Q?n+LZlMd8LZjQxEwm5hTXa5tbc970zYwgzbiJJ29eVEmS07ZJJ2dx6dTymfb5?=
 =?us-ascii?Q?ElvDj6Rk3qsnCxe3LmCoCJoK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885a31e6-361c-42b9-f590-08d919537e62
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 16:47:44.4509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bS8oA78q7GveCH9GpaF6kOF+iih+jntkBpE/e75Kj6X9fMRcSPcmOss/96c5MVPK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2858
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It is much saner to store a pointer to the kobject structure that contains
the cannonical stats pointer than to copy the stats pointers into a public
structure.

Future patches will require the sysfs pointer for other purposes.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/core_priv.h |  1 +
 drivers/infiniband/core/nldev.c     |  8 ++------
 drivers/infiniband/core/sysfs.c     | 14 +++++++++++---
 include/rdma/ib_verbs.h             |  3 ++-
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 29809dd300419f..ec5c2c3db42303 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -378,6 +378,7 @@ struct net_device *rdma_read_gid_attr_ndev_rcu(const struct ib_gid_attr *attr);
 
 void ib_free_port_attrs(struct ib_core_device *coredev);
 int ib_setup_port_attrs(struct ib_core_device *coredev);
+struct rdma_hw_stats *ib_get_hw_stats_port(struct ib_device *ibdev, u32 port_num);
 
 int rdma_compatdev_set(u8 enable);
 
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 01316926cef63d..e9b4b2cccaa0ff 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -2066,7 +2066,8 @@ static int stat_get_doit_default_counter(struct sk_buff *skb,
 	}
 
 	port = nla_get_u32(tb[RDMA_NLDEV_ATTR_PORT_INDEX]);
-	if (!rdma_is_port_valid(device, port)) {
+	stats = ib_get_hw_stats_port(device, port);
+	if (!stats) {
 		ret = -EINVAL;
 		goto err;
 	}
@@ -2088,11 +2089,6 @@ static int stat_get_doit_default_counter(struct sk_buff *skb,
 		goto err_msg;
 	}
 
-	stats = device->port_data ? device->port_data[port].hw_stats : NULL;
-	if (stats == NULL) {
-		ret = -EINVAL;
-		goto err_msg;
-	}
 	mutex_lock(&stats->lock);
 
 	num_cnts = device->ops.get_hw_stats(device, stats, port, 0);
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 29082d8d45fc4f..5f8b1677e1237b 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1036,8 +1036,6 @@ static void setup_hw_stats(struct ib_device *device, struct ib_port *port,
 			goto err;
 		port->hw_stats_ag = hsag;
 		port->hw_stats = stats;
-		if (device->port_data)
-			device->port_data[port_num].hw_stats = stats;
 	} else {
 		struct kobject *kobj = &device->dev.kobj;
 		ret = sysfs_create_group(kobj, hsag);
@@ -1058,6 +1056,14 @@ static void setup_hw_stats(struct ib_device *device, struct ib_port *port,
 	kfree(stats);
 }
 
+struct rdma_hw_stats *ib_get_hw_stats_port(struct ib_device *ibdev,
+					   u32 port_num)
+{
+	if (!ibdev->port_data || !rdma_is_port_valid(ibdev, port_num))
+		return NULL;
+	return ibdev->port_data[port_num].sysfs->hw_stats;
+}
+
 static int add_port(struct ib_core_device *coredev, int port_num)
 {
 	struct ib_device *device = rdma_device_to_ibdev(&coredev->dev);
@@ -1176,6 +1182,8 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 		setup_hw_stats(device, p, port_num);
 
 	list_add_tail(&p->kobj.entry, &coredev->port_list);
+	if (device->port_data && is_full_dev)
+		device->port_data[port_num].sysfs = p;
 
 	kobject_uevent(&p->kobj, KOBJ_ADD);
 	return 0;
@@ -1366,7 +1374,7 @@ void ib_free_port_attrs(struct ib_core_device *coredev)
 			free_hsag(&port->kobj, port->hw_stats_ag);
 		kfree(port->hw_stats);
 		if (device->port_data && is_full_dev)
-			device->port_data[port->port_num].hw_stats = NULL;
+			device->port_data[port->port_num].sysfs = NULL;
 
 		if (port->pma_table)
 			sysfs_remove_group(p, port->pma_table);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 8fa7fd20e94aa7..e3be93e7096616 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -50,6 +50,7 @@ struct ib_uqp_object;
 struct ib_usrq_object;
 struct ib_uwq_object;
 struct rdma_cm_id;
+struct ib_port;
 
 extern struct workqueue_struct *ib_wq;
 extern struct workqueue_struct *ib_comp_wq;
@@ -2183,7 +2184,7 @@ struct ib_port_data {
 	struct net_device __rcu *netdev;
 	struct hlist_node ndev_hash_link;
 	struct rdma_port_counter port_counter;
-	struct rdma_hw_stats *hw_stats;
+	struct ib_port *sysfs;
 };
 
 /* rdma netdev type - specifies protocol type */
-- 
2.31.1

