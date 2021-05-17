Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9A6383A6A
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 18:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbhEQQti (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 12:49:38 -0400
Received: from mail-mw2nam10on2062.outbound.protection.outlook.com ([40.107.94.62]:7601
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240701AbhEQQtS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 12:49:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFs7Z2y9lzfgCVEhDfhOIDRZzMsQrssAiEI4tgaadS6FCsngmcMfQIzmFRsz52oZkgJIG2I3Dc8z6fQ/X9mbzuQ6fWLkuwCDCfYAbAijgptUMEKStS0oZ4IqPjHz8WpEmtT6EGGTt0F+hgVsnVjPCCH8/3YEnHQ7p4DfjkxI0IzB8zYqtAPW7XjIvzqSH8YONKxCr4bDQ9oUbL4HmlnpOvInGmbkD/5SZbmg48/Q6gAVxi8MimK4PM6rxvYipZXj0NECyiJ4qDwuYC1HqUUKUbft1uwP4xSZt+18yOR8phj3IdSAZwAZg3lqqCHjBX55MNV7sAkNE2ijnY5F6EuA6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHpOdrXBgajIh5l/zciUhVu/dVlG7o7N/a5l1oobY8U=;
 b=FU1+mczkvSBFKZGzhUPNSyAsLmxGrcq8zDGjoIi8rWnBPp2FCA329t65vXTbPmNh6DLSMTJHTW5oNenE5+rlytow3+/RY6UVE3eUqgNhKdVN5ILPuc+dyd/YEhaWQKAZoOL5REP5JvFY7wX7kT7OhCQJVLV3Sq5JsseiZb0Hl8h3f0gUfGnbxkdmEOamBAyOq12MwAkvQ1BJ2oH5YWJ4L+Z7qFHXvlZj8H5O5XRkSpptQ29J5s2q17h4BktdXlOc0kk7xpSKKfcQrCZIcGrAXWjiDQpcSrCJ38hLZ1YfJovpB0aedQCLHBaf9dakK0EhEuoBxnoOaUfpomXM+7C4Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHpOdrXBgajIh5l/zciUhVu/dVlG7o7N/a5l1oobY8U=;
 b=UFNo0MoLKJtjAVOr6wkvhwEzXwz7u+h1Dvh0toKvkAB832lO0+2vNCGBgLAtYGjck2DIizV7Kzs/8SbBapW7K6uwzEeG1w9DH4bcufH+Ybu1sSRLqG0kG7qvEOrUGd4AwRRX6FNiF1Nfm7tHZ53z56tEJoPCwvGPeWQafkXFdAF/MhWz4RxF/Wwoab61caC1GW1BKkDXnzT8E4ZphmhMLVMWs6dvuYy0xXPja2UhyZdzbgm8OGFXYkezcneo7wkaDDU9iwf6xUvbRbAMyxPUn41lULkicX6DJUUsua+zRONjiPxbs1qannces192eCdtXrL3Z6dumRG66/fyK2vZJQ==
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
Subject: [PATCH 06/13] RDMA/core: Simplify how the port sysfs is created
Date:   Mon, 17 May 2021 13:47:34 -0300
Message-Id: <6-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
In-Reply-To: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:208:23a::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:23a::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 16:47:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ligP8-009LYg-0D; Mon, 17 May 2021 13:47:42 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 685af235-4782-44f2-ff25-08d919537e55
X-MS-TrafficTypeDiagnostic: DM6PR12MB2858:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28584C6A4C09F4979B061064C22D9@DM6PR12MB2858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ashxCYCnKe7TysEldkVjGrfe3WgI6MWGpiQsjiNiAYK1xQQo2yNsX03LM39Iyqg0Ylu322idwg7Qa8yCRG6R7c5mmAfQbf04/CQUFqM+hn7ND3vHuuJcgtdZCZ/XT17WfOPtq+kpB+6LHrIWs5fOsmigWEehC/sGgQIvnFPtuwrYo8oRrW1UFeUkuIG5z9jFUgDav/RvSZ1FmZ4RXtDV+r3C1pJkKzlRUMz1LOElo9dt9kYe1H3lWh2vd0d+fyCcBhcwGX9lsav0G1KlJ1RZoWAq+Vjor2Rndn8Cjmp3SczwYnIjKdiQsYK6nnv/brCBB3gt0hM5cWZP0RCe5euZ4Tu9jiL9EqXlzALmjnGE/RCpWOWzfS4bsyB1gl6g6zlMwuaWoY77kgP3fdIw86cR2AXQZrwUJt0jSR6rrmHmlm3H32SHG69KZ4X81mzuSXJrHYQpbyL95AgYCUut2RgzFGJhLPxmDhGjDhzCgMoYFpvyIhpfNBEWyDzvLUXM0b5yuy9XWehl7QJ5KdlRaEBIonX/CdWpO1sHzQRONC0jUrV2cnnWqisDJtrLVo92nbIZNBlW3I9QAeif9rd7jGBSzORGZujcSuRAmPWNN+jEauBGSAZMMGsoqZNA8ZPdsUmsDSTCoSMvKLiOLPG1Sex1kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(54906003)(6666004)(9746002)(8676002)(66556008)(426003)(83380400001)(36756003)(30864003)(9786002)(26005)(66946007)(38100700002)(316002)(66476007)(4326008)(478600001)(86362001)(5660300002)(186003)(8936002)(2616005)(2906002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wXL6Rvs1geeQ49Pv+6nknMWCR4SIX+eyBUcb7TAeITK3k2cRTYNdZofrA2kz?=
 =?us-ascii?Q?jOzA5Ee/0K8zvekP/G4k3nj5A007RMC2sOuFnwAOJV8YTzK7N4+i8fjo9tb6?=
 =?us-ascii?Q?1IeHOKUFMzPFgNZp2Z1HsfGCgwKzpwMf+dv8aIDhzkDiFek+Fvo+58kBBUW3?=
 =?us-ascii?Q?ApZKRnCfZBIua9uvi4DRD/zrwOqMPE7mH44uKbLGnqkxMTBWAFIGMLAOrt2G?=
 =?us-ascii?Q?i6spXAjfzJoV9cMUZJRgg+qug6ysIbDUndF4Zp7yEnmzTDQ+OWjYO5USQmq/?=
 =?us-ascii?Q?mTxoxI9lql8l4YZ4bwQ6tsolUOMiGwsWzrx8ornpSqHAh6NyZkVpT5hPqb+o?=
 =?us-ascii?Q?7M5qkMTmqLblvH0Zx1McoMc9MuOZrfhgTfRBWlPdabdwgbyjOHWnv+FjAMyF?=
 =?us-ascii?Q?XQ7+5bvqQs9zGPNN5myRq2jQUiA5R8R+3r1kNw4G74HA2HBusXmvJvdheOTN?=
 =?us-ascii?Q?kdNpLrd/0Fm3aL3gG6AScMAYkCYwGQumoxxAhkiq8+9jWPginK3t2H/wtzb7?=
 =?us-ascii?Q?eMUmPeMIWVBV3Knxhjc1vl8MNwZbIt8eWvo95OGkONuOn7SogpGGU7BabwkU?=
 =?us-ascii?Q?aLbLP91RQuQj23PizuAbVHU7Op7A+l/nR8g9l3ULsOZ2qZs1teEZKZ/sbZ84?=
 =?us-ascii?Q?eE0jez3L1HRFCuV+GPIQXIwLIqak9+5jVLrjtyjFL48CHd9C4lKi25oLUfr3?=
 =?us-ascii?Q?Y7dYxCqDqefz7ND71wMqImiuCBlaeiUjs8NueD5brY+yC8JWAhMXu8undj+U?=
 =?us-ascii?Q?YKC4N5LkGd45IcKPYKDblRDhzIIBI+JGmOk5n8okCfXN9ptXjiOc6perAHOx?=
 =?us-ascii?Q?4aE0tkwvU1fM61iEaTD5BpYf6Wi0JIoLdHcrUqLTzluxtcYKyxr2luNeIL+P?=
 =?us-ascii?Q?UIMHFfnA9b+JMZUu+yYdNo+GSqtYepIt41PEjpQkdInwEopPbtaBXNfPh96X?=
 =?us-ascii?Q?220o7RC2XVXM5tdkUQtYlyawXiWkDwx/XNTaWG7nlhDvXSAcrU9gxeKiCxM6?=
 =?us-ascii?Q?4v8bNXtkrkRJBILnM8vkWarXwc7QHLDP+q7gTVRVgWzYCH3FHHJOo+XgeB42?=
 =?us-ascii?Q?15utWYe+1YpggyjULV9o/Tbt0grswApYf+xmkoOZ+Oyh4Xe+4pBPH07zoE6s?=
 =?us-ascii?Q?MlRnUsSi/7Zb5r9nQnhhmO3zry9c8nztEXb5CIDhTSR3ZfeOyLLeMBd4RRf9?=
 =?us-ascii?Q?ZspOTO7j8qLIB3msRXElJNVgTbzMT3uHM9i8l6xgU+VdPzGOXeWLFSFscFMc?=
 =?us-ascii?Q?/lDAx8JJBGV/A3NKV1pYm+YyMkNvOJHqDA+otjeE7shPR9vn1l9BYCUExtAS?=
 =?us-ascii?Q?HCmBb1MsIBOByfc8IYr2kvkf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685af235-4782-44f2-ff25-08d919537e55
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 16:47:44.4599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCp4KicDC1RkuQIQlpQBzERvL9zkDC7PiHcyTBt0vP8MqlmVQCwfZdsLKQulNHiU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2858
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use the same technique as gid_attrs now uses to manage the port
sysfs. Bundle everything into three allocations and use a single
sysfs_create_groups() to build everything in one shot.

All the memory is always freed in the kobj release function, removing most
of the error unwinding.

The gid_attr technique and the hw_counters are very similar, merge the two
together and combine the sysfs_create_group() call for hw_counters with
the single sysfs group setup.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/sysfs.c | 321 ++++++++++----------------------
 1 file changed, 103 insertions(+), 218 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 569e847757b944..53838bce574264 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -79,11 +79,12 @@ struct ib_port {
 	struct kobject kobj;
 	struct ib_device *ibdev;
 	struct gid_attr_group *gid_attr_group;
-	struct attribute_group gid_group;
-	struct attribute_group *pkey_group;
-	const struct attribute_group *pma_table;
 	struct hw_stats_port_data *hw_stats_data;
+
+	struct attribute_group groups[3];
+	const struct attribute_group *groups_list[5];
 	u32 port_num;
+	struct port_table_attribute attrs_list[];
 };
 
 struct hw_stats_device_attribute {
@@ -112,7 +113,6 @@ struct hw_stats_device_data {
 };
 
 struct hw_stats_port_data {
-	struct attribute_group group;
 	struct rdma_hw_stats *stats;
 	struct hw_stats_port_attribute attrs[];
 };
@@ -750,30 +750,16 @@ static const struct attribute_group pma_group_noietf = {
 
 static void ib_port_release(struct kobject *kobj)
 {
-	struct ib_port *p = container_of(kobj, struct ib_port, kobj);
-	struct attribute *a;
+	struct ib_port *port = container_of(kobj, struct ib_port, kobj);
 	int i;
 
-	if (p->gid_group.attrs) {
-		for (i = 0; (a = p->gid_group.attrs[i]); ++i)
-			kfree(a);
-
-		kfree(p->gid_group.attrs);
+	for (i = 0; i != ARRAY_SIZE(port->groups); i++)
+		kfree(port->groups[i].attrs);
+	if (port->hw_stats_data) {
+		kfree(port->hw_stats_data->stats);
+		kfree(port->hw_stats_data);
 	}
-
-	if (p->pkey_group) {
-		if (p->pkey_group->attrs) {
-			for (i = 0; (a = p->pkey_group->attrs[i]); ++i)
-				kfree(a);
-
-			kfree(p->pkey_group->attrs);
-		}
-
-		kfree(p->pkey_group);
-		p->pkey_group = NULL;
-	}
-
-	kfree(p);
+	kfree(port);
 }
 
 static void ib_port_gid_attr_release(struct kobject *kobj)
@@ -798,49 +784,6 @@ static struct kobj_type gid_attr_type = {
 	.release        = ib_port_gid_attr_release
 };
 
-static struct attribute **
-alloc_group_attrs(ssize_t (*show)(struct ib_port *,
-				  struct port_attribute *, char *buf),
-		  int len)
-{
-	struct attribute **tab_attr;
-	struct port_table_attribute *element;
-	int i;
-
-	tab_attr = kcalloc(1 + len, sizeof(struct attribute *), GFP_KERNEL);
-	if (!tab_attr)
-		return NULL;
-
-	for (i = 0; i < len; i++) {
-		element = kzalloc(sizeof(struct port_table_attribute),
-				  GFP_KERNEL);
-		if (!element)
-			goto err;
-
-		if (snprintf(element->name, sizeof(element->name),
-			     "%d", i) >= sizeof(element->name)) {
-			kfree(element);
-			goto err;
-		}
-
-		element->attr.attr.name  = element->name;
-		element->attr.attr.mode  = S_IRUGO;
-		element->attr.show       = show;
-		element->index		 = i;
-		sysfs_attr_init(&element->attr.attr);
-
-		tab_attr[i] = &element->attr.attr;
-	}
-
-	return tab_attr;
-
-err:
-	while (--i >= 0)
-		kfree(tab_attr[i]);
-	kfree(tab_attr);
-	return NULL;
-}
-
 /*
  * Figure out which counter table to use depending on
  * the device capabilities.
@@ -1051,7 +994,8 @@ static void destroy_hw_device_stats(struct ib_device *ibdev)
 	ibdev->hw_stats_data = NULL;
 }
 
-static struct hw_stats_port_data *alloc_hw_stats_port(struct ib_port *port)
+static struct hw_stats_port_data *
+alloc_hw_stats_port(struct ib_port *port, struct attribute_group *group)
 {
 	struct ib_device *ibdev = port->ibdev;
 	struct hw_stats_port_data *data;
@@ -1073,13 +1017,13 @@ static struct hw_stats_port_data *alloc_hw_stats_port(struct ib_port *port)
 		       GFP_KERNEL);
 	if (!data)
 		goto err_free_stats;
-	data->group.attrs = kcalloc(stats->num_counters + 2,
-				    sizeof(*data->group.attrs), GFP_KERNEL);
-	if (!data->group.attrs)
+	group->attrs = kcalloc(stats->num_counters + 2,
+				    sizeof(*group->attrs), GFP_KERNEL);
+	if (!group->attrs)
 		goto err_free_data;
 
 	mutex_init(&stats->lock);
-	data->group.name = "hw_counters";
+	group->name = "hw_counters";
 	data->stats = stats;
 	return data;
 
@@ -1090,20 +1034,14 @@ static struct hw_stats_port_data *alloc_hw_stats_port(struct ib_port *port)
 	return ERR_PTR(-ENOMEM);
 }
 
-static void free_hw_stats_port(struct hw_stats_port_data *data)
-{
-	kfree(data->group.attrs);
-	kfree(data->stats);
-	kfree(data);
-}
-
-static int setup_hw_port_stats(struct ib_port *port)
+static int setup_hw_port_stats(struct ib_port *port,
+			       struct attribute_group *group)
 {
 	struct hw_stats_port_attribute *attr;
 	struct hw_stats_port_data *data;
 	int i, ret;
 
-	data = alloc_hw_stats_port(port);
+	data = alloc_hw_stats_port(port, group);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
@@ -1112,9 +1050,10 @@ static int setup_hw_port_stats(struct ib_port *port)
 					    data->stats->num_counters);
 	if (ret != data->stats->num_counters) {
 		if (WARN_ON(ret >= 0))
-			ret = -EINVAL;
-		goto err_free;
+			return -EINVAL;
+		return ret;
 	}
+
 	data->stats->timestamp = jiffies;
 
 	for (i = 0; i < data->stats->num_counters; i++) {
@@ -1124,7 +1063,7 @@ static int setup_hw_port_stats(struct ib_port *port)
 		attr->attr.attr.mode = 0444;
 		attr->attr.show = hw_stat_port_show;
 		attr->show = show_hw_stats;
-		data->group.attrs[i] = &attr->attr.attr;
+		group->attrs[i] = &attr->attr.attr;
 	}
 
 	attr = &data->attrs[i];
@@ -1135,27 +1074,10 @@ static int setup_hw_port_stats(struct ib_port *port)
 	attr->show = show_stats_lifespan;
 	attr->attr.store = hw_stat_port_store;
 	attr->store = set_stats_lifespan;
-	data->group.attrs[i] = &attr->attr.attr;
+	group->attrs[i] = &attr->attr.attr;
 
 	port->hw_stats_data = data;
-	ret = sysfs_create_group(&port->kobj, &data->group);
-	if (ret)
-		goto err_free;
 	return 0;
-
-err_free:
-	free_hw_stats_port(data);
-	port->hw_stats_data = NULL;
-	return ret;
-}
-
-static void destroy_hw_port_stats(struct ib_port *port)
-{
-	if (!port->hw_stats_data)
-		return;
-	sysfs_remove_group(&port->kobj, &port->hw_stats_data->group);
-	free_hw_stats_port(port->hw_stats_data);
-	port->hw_stats_data = NULL;
 }
 
 struct rdma_hw_stats *ib_get_hw_stats_port(struct ib_device *ibdev,
@@ -1266,68 +1188,42 @@ static void destroy_gid_attrs(struct ib_port *port)
 	kobject_put(&gid_attr_group->kobj);
 }
 
-static int add_port(struct ib_core_device *coredev, int port_num)
+/*
+ * Create the sysfs:
+ *  ibp0s9/ports/XX/{gids,pkeys,counters}/YYY
+ */
+static struct ib_port *setup_port(struct ib_core_device *coredev, int port_num,
+				  const struct ib_port_attr *attr)
 {
 	struct ib_device *device = rdma_device_to_ibdev(&coredev->dev);
 	bool is_full_dev = &device->coredev == coredev;
+	const struct attribute_group **cur_group;
 	struct ib_port *p;
-	struct ib_port_attr attr;
-	int i;
 	int ret;
 
-	ret = ib_query_port(device, port_num, &attr);
-	if (ret)
-		return ret;
-
-	p = kzalloc(sizeof *p, GFP_KERNEL);
+	p = kzalloc(struct_size(p, attrs_list,
+				attr->gid_tbl_len + attr->pkey_tbl_len),
+		    GFP_KERNEL);
 	if (!p)
-		return -ENOMEM;
-
-	p->ibdev      = device;
-	p->port_num   = port_num;
+		return ERR_PTR(-ENOMEM);
+	p->ibdev = device;
+	p->port_num = port_num;
+	kobject_init(&p->kobj, &port_type);
 
-	ret = kobject_init_and_add(&p->kobj, &port_type,
-				   coredev->ports_kobj,
-				   "%d", port_num);
+	cur_group = p->groups_list;
+	ret = alloc_port_table_group("gids", &p->groups[0], p->attrs_list,
+				     attr->gid_tbl_len, show_port_gid);
 	if (ret)
 		goto err_put;
+	*cur_group++ = &p->groups[0];
 
-	if (device->ops.process_mad && is_full_dev) {
-		p->pma_table = get_counter_table(device, port_num);
-		ret = sysfs_create_group(&p->kobj, p->pma_table);
+	if (attr->pkey_tbl_len) {
+		ret = alloc_port_table_group("pkeys", &p->groups[1],
+					     p->attrs_list + attr->gid_tbl_len,
+					     attr->pkey_tbl_len, show_port_pkey);
 		if (ret)
 			goto err_put;
-	}
-
-	p->gid_group.name  = "gids";
-	p->gid_group.attrs = alloc_group_attrs(show_port_gid, attr.gid_tbl_len);
-	if (!p->gid_group.attrs) {
-		ret = -ENOMEM;
-		goto err_remove_pma;
-	}
-
-	ret = sysfs_create_group(&p->kobj, &p->gid_group);
-	if (ret)
-		goto err_free_gid;
-
-	if (attr.pkey_tbl_len) {
-		p->pkey_group = kzalloc(sizeof(*p->pkey_group), GFP_KERNEL);
-		if (!p->pkey_group) {
-			ret = -ENOMEM;
-			goto err_remove_gid;
-		}
-
-		p->pkey_group->name  = "pkeys";
-		p->pkey_group->attrs = alloc_group_attrs(show_port_pkey,
-							 attr.pkey_tbl_len);
-		if (!p->pkey_group->attrs) {
-			ret = -ENOMEM;
-			goto err_free_pkey_group;
-		}
-
-		ret = sysfs_create_group(&p->kobj, p->pkey_group);
-		if (ret)
-			goto err_free_pkey;
+		*cur_group++ = &p->groups[1];
 	}
 
 	/*
@@ -1336,66 +1232,45 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	 * counter initialization.
 	 */
 	if (port_num && is_full_dev) {
-		ret = setup_hw_port_stats(p);
+		ret = setup_hw_port_stats(p, &p->groups[2]);
 		if (ret && ret != -EOPNOTSUPP)
-			goto err_remove_pkey;
+			goto err_put;
+		if (!ret)
+			*cur_group++ = &p->groups[2];
 	}
-	ret = setup_gid_attrs(p, &attr);
-	if (ret)
-		goto err_remove_stats;
 
-	if (device->ops.init_port && is_full_dev) {
-		ret = device->ops.init_port(device, port_num, &p->kobj);
-		if (ret)
-			goto err_remove_gid_attrs;
-	}
+	if (device->ops.process_mad && is_full_dev)
+		*cur_group++ = get_counter_table(device, port_num);
+
+	ret = kobject_add(&p->kobj, coredev->ports_kobj, "%d", port_num);
+	if (ret)
+		goto err_put;
+	ret = sysfs_create_groups(&p->kobj, p->groups_list);
+	if (ret)
+		goto err_del;
 
 	list_add_tail(&p->kobj.entry, &coredev->port_list);
 	if (device->port_data && is_full_dev)
 		device->port_data[port_num].sysfs = p;
 
-	kobject_uevent(&p->kobj, KOBJ_ADD);
-	return 0;
-
-err_remove_gid_attrs:
-	destroy_gid_attrs(p);
-
-err_remove_stats:
-	destroy_hw_port_stats(p);
-
-err_remove_pkey:
-	if (p->pkey_group)
-		sysfs_remove_group(&p->kobj, p->pkey_group);
-
-err_free_pkey:
-	if (p->pkey_group) {
-		for (i = 0; i < attr.pkey_tbl_len; ++i)
-			kfree(p->pkey_group->attrs[i]);
-
-		kfree(p->pkey_group->attrs);
-		p->pkey_group->attrs = NULL;
-	}
-
-err_free_pkey_group:
-	kfree(p->pkey_group);
-
-err_remove_gid:
-	sysfs_remove_group(&p->kobj, &p->gid_group);
-
-err_free_gid:
-	for (i = 0; i < attr.gid_tbl_len; ++i)
-		kfree(p->gid_group.attrs[i]);
-
-	kfree(p->gid_group.attrs);
-	p->gid_group.attrs = NULL;
-
-err_remove_pma:
-	if (p->pma_table)
-		sysfs_remove_group(&p->kobj, p->pma_table);
+	return p;
 
+err_del:
+	kobject_del(&p->kobj);
 err_put:
 	kobject_put(&p->kobj);
-	return ret;
+	return ERR_PTR(ret);
+}
+
+static void destroy_port(struct ib_port *port)
+{
+	if (port->ibdev->port_data &&
+	    port->ibdev->port_data[port->port_num].sysfs == port)
+		port->ibdev->port_data[port->port_num].sysfs = NULL;
+	list_del(&port->kobj.entry);
+	sysfs_remove_groups(&port->kobj, port->groups_list);
+	kobject_del(&port->kobj);
+	kobject_put(&port->kobj);
 }
 
 static const char *node_type_string(int node_type)
@@ -1512,25 +1387,13 @@ const struct attribute_group ib_dev_attr_group = {
 
 void ib_free_port_attrs(struct ib_core_device *coredev)
 {
-	struct ib_device *device = rdma_device_to_ibdev(&coredev->dev);
-	bool is_full_dev = &device->coredev == coredev;
 	struct kobject *p, *t;
 
 	list_for_each_entry_safe(p, t, &coredev->port_list, entry) {
 		struct ib_port *port = container_of(p, struct ib_port, kobj);
 
-		list_del(&p->entry);
-		destroy_hw_port_stats(port);
-		if (device->port_data && is_full_dev)
-			device->port_data[port->port_num].sysfs = NULL;
-
-		if (port->pma_table)
-			sysfs_remove_group(p, port->pma_table);
-		if (port->pkey_group)
-			sysfs_remove_group(p, port->pkey_group);
-		sysfs_remove_group(p, &port->gid_group);
 		destroy_gid_attrs(port);
-		kobject_put(p);
+		destroy_port(port);
 	}
 
 	kobject_put(coredev->ports_kobj);
@@ -1539,7 +1402,8 @@ void ib_free_port_attrs(struct ib_core_device *coredev)
 int ib_setup_port_attrs(struct ib_core_device *coredev)
 {
 	struct ib_device *device = rdma_device_to_ibdev(&coredev->dev);
-	u32 port;
+	bool is_full_dev = &device->coredev == coredev;
+	u32 port_num;
 	int ret;
 
 	coredev->ports_kobj = kobject_create_and_add("ports",
@@ -1547,12 +1411,33 @@ int ib_setup_port_attrs(struct ib_core_device *coredev)
 	if (!coredev->ports_kobj)
 		return -ENOMEM;
 
-	rdma_for_each_port (device, port) {
-		ret = add_port(coredev, port);
+	rdma_for_each_port (device, port_num) {
+		struct ib_port_attr attr;
+		struct ib_port *port;
+
+		ret = ib_query_port(device, port_num, &attr);
+		if (ret)
+			goto err_put;
+
+		port = setup_port(coredev, port_num, &attr);
+		if (IS_ERR(port)) {
+			ret = PTR_ERR(port);
+			goto err_put;
+		}
+
+		ret = setup_gid_attrs(port, &attr);
 		if (ret)
 			goto err_put;
-	}
 
+		if (device->ops.init_port && is_full_dev) {
+			ret = device->ops.init_port(device, port_num,
+						    &port->kobj);
+			if (ret)
+				goto err_put;
+		}
+
+		kobject_uevent(&port->kobj, KOBJ_ADD);
+	}
 	return 0;
 
 err_put:
-- 
2.31.1

