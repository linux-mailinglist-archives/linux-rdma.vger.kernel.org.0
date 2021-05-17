Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C3D383A6C
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 18:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbhEQQtj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 12:49:39 -0400
Received: from mail-mw2nam10on2062.outbound.protection.outlook.com ([40.107.94.62]:7601
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241895AbhEQQt3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 12:49:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anBIlxbKA37J5qkKADLs2yXLifLSJ8MO6rURzVnqyY5v9QSvuOiMnc/JeOcZKchuhQUORbSVJyVGEPhydGBB/84AV+vNBi564D4ChWbYiSTPbtUmr/uWZWSqTmGLDIEIlPmu7+387lqyHtYoawNpfdZ15mDgWXrtaJ1fjAw+lKinG2cjdpv2HlWv75x1sRxNtw56OInO7BxA2L1YUZHMuY7nix34JpwXQl6tj9u+l+kYK00Qz6f4dRyTNDyBKZd42BAJuJ88nuHLaMl17gZL/KpGVTGT0TRlgs2aiEyKFjXgI6s/UNWmMjgk9IG6tm8CzdCeI9egA8zOI2P4Jv6N6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=movQycWHJk+Std2n9t4SuXoJ47I5GwyVnxoaxhW3i98=;
 b=NsuaWTn9mk647i3gBJy47JlDVW2Q5PvPojEZPJhE2+3rvlv/P/Km+sK/rXtPQOULSV308tNxAfFyputt5VlUJMVffPN3zclxj+ejh5vQmutsVHesTV4eONiTtqK5NX55i1P7U7fP/xSQiSFQJnTitRoJ+A/ruHWX4tkR/HmSnQKSB0KcsMvq3a87cxfpdR853Gm85G3XrW4+CqXdNm5LDq93Q/iBw/RR2bq8nwgiazJakc8R6cMnOkB/jUI0fknpLyGSDJlQ2AgyGnXUV3Z6kltfGPt7hmJYznMtuUWuq3nwWZvi+7T+wb8ntIguy1Hq6WF22nqohpSerPDtTMIJhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=movQycWHJk+Std2n9t4SuXoJ47I5GwyVnxoaxhW3i98=;
 b=B80Cb16nyuRNqkLbMLF83xB8wSTVqA9GGr406yLVwzqnM5Q6kQAUVHzy0Y+NR7Jr8E3xMdkiIYKYJNgVXVu+OXZ632yLMH2oAfEVy+Sd5ZRaLhWmgj/zgTmTzb/HpSgyZD45CdBp9V5/u1FOgMPbddPhuk7LqyKVfA9sHUjfQhhsCEVr0pDBaX8QavBUv8uEMoeOyqHJGOSIrV07+W+0RZGXNkJ3c0BK852O2yfKzTtIzp2LCqrFA1cCsNQgC13P9Ud/6lT0JiB225YT6ZSnDFBn9D8Hl+FDFWga4vQDRd8IBQqjtax7WCBvoVKfY4KrAdQ/4DFtX4/dK5o6CoQt1w==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 16:47:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 16:47:48 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 05/13] RDMA/core: Simplify how the gid_attrs sysfs is created
Date:   Mon, 17 May 2021 13:47:33 -0300
Message-Id: <5-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
In-Reply-To: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:208:236::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR05CA0057.namprd05.prod.outlook.com (2603:10b6:208:236::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Mon, 17 May 2021 16:47:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ligP7-009LYb-Ub; Mon, 17 May 2021 13:47:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50984d43-3571-4e5c-0aa4-08d919537f2b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2858:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28583A459FD566C784B7B698C22D9@DM6PR12MB2858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:357;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pNIPUAxCaOaVaI2Q4jJ5FlzJjtb5Z2bCnIB1N6J5cVgIzB21sNL26m5mJ2+xFw723pN+Cg7Z9J5j//ukOQ7bjSuNPTkhDoDSjNdAqIvgrRmFmqa9mgkqTLqQeZYEpfAL4eCpMlHGoTqs+IaoxlZNYO3/qdNN7o04Uy7Tp7xNvQ77bhh7BeJwCveO8/axt94BDs+6UL+uKgw07Bi1ewTC4iLUbEpNRcidXbRPpB67aCGZz31tWPwTe/PKqDfh2JJVIVJcl1jxFYA1rW9aPuMTV7P+lscoPq1Tx5L0Ezi7hYwliBo/kpCYToviimGYJk5WdJs9GXQxhFwWNXOicDkBoLFGb3t3NYVJ2Ph5qumt1eiWCx7WorQ5/lPuzSLGpBPWPTlHCTtCsj5wfZDXW0kfkG3wR6KjPmousNVUwTrY6wcoD/5SVmLPLZj/dHS3wpXBAwFn5v+n+6lxCgvtzN2VBxtF15ABekaWEM1zT5+zgJnKIkymqlRAQuPaZ35lrdWOUNYfog2GpkAXjzMZGfxUX9JiTfOOoKfctdTzXMIC6Q6ldjCkd4mFV17tNBZOrhOJpZwn8fmctGlSJ45pvEhlZ+61dYbIjtrkoGBDdfRZBLsO4nHvjITQgcUIl8hC7e7jxvUTNuilsdk/btM62xEgrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(54906003)(6666004)(9746002)(8676002)(66556008)(426003)(83380400001)(36756003)(9786002)(26005)(66946007)(38100700002)(316002)(66476007)(4326008)(478600001)(86362001)(5660300002)(186003)(8936002)(2616005)(2906002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?axGKrz6/y47cKj3perkKVz89aJdtfLxy0QsMIy8i04W1GlqYTBcMQKCuJ3V1?=
 =?us-ascii?Q?5/IWLChpcwVfiCKB10zWuulb1331gxsiKQKVRUVGVVdf0X7H+3T37cm71a7/?=
 =?us-ascii?Q?H8t+3k3yQJmXHyjEWqbTwO5xCkBs3GbpIuXan+PlcC6yVOpdlwZ3GeI2BJBm?=
 =?us-ascii?Q?wlMlyX+SMVsKSQ4YCPzmtoOGHpBsXOFkf1uDi0/1/9I9qzcdmEuaTtXOvtut?=
 =?us-ascii?Q?9e5VY6PcRa0S0fOKemQNiODzRerLT4KBuL3kVAJzcy0PFRicrG1JPOOWK+xC?=
 =?us-ascii?Q?gdYxIpTeWDzbichgoDSATJLWjuWgMteeOo2bdKVoEp3IaOlLsyxDb3PQx42d?=
 =?us-ascii?Q?zywDsDKUdnRbmL6ROm9XQE4UbEUzZeHv2PR4sAVMyrJlWkKuoFIGQkTZCg9t?=
 =?us-ascii?Q?10dSi3tVzRDYsMwN185qqgKTkQfJ0ayM/KySu/zvJ/4gFNI4GUa48HN4Mrpi?=
 =?us-ascii?Q?YFPGnzJwYTmCSK+cqgX1/hGBEKJQsD+PmOhFIdKpJfc2CBIgUGd7ZN7B68wT?=
 =?us-ascii?Q?OrJoG/RYbPJwWkvemj/a3MFod1re8N8JaEmxrgVMveMP/qETUvLWzXu6rt4h?=
 =?us-ascii?Q?IX2z1NV+mRuomRF30lD1Gubx6fnaS5LuXXaisN4tgI8jwpqXsA+eskTzHkJL?=
 =?us-ascii?Q?Pcnm72DyTUxiimvlBIgdrulIUjymxp0rkA/B5etYGTN3MjwYCBYGV3KcKW4Q?=
 =?us-ascii?Q?oMV2q5mqKGBvwEKmkrJk7XpcA9XdwaOk94wZwKytYlroiRItkV0fIvBoSvFB?=
 =?us-ascii?Q?gQyht6cBdq8YBlE2iZMCyfh8J2DaARX+0nkr7UIXFVvtlKj2lkMZ7rpAEMDs?=
 =?us-ascii?Q?JaTKg4/9E/U9kFzuqvMaB1Wskmw2a71APmIHz/RJxhZgQdfBY0ZLfYeTNTez?=
 =?us-ascii?Q?iDdNLMhdWBsBNmIPpjk6HAASD2FQRZqUvnmpXKDqrNbZ1HW/azEBU10UAlTP?=
 =?us-ascii?Q?Nncl4pzQuCym4lnlBKVvZmehTdr1KukJZMqMLDLWYxbScNIrIQlEJRR1u/37?=
 =?us-ascii?Q?vhRraeH1QgVtkHLdlJnTybQzma617Y47JJ/Es4FEGbHKqQzPi/bjctbpBCM/?=
 =?us-ascii?Q?q6nkY51eHJbINmKowy0goHHXBNZbdGTJfPoVCoGE/02tKYHy1D42o+BMvDHn?=
 =?us-ascii?Q?AmYk7FZ1sIW1LfVC/IzNRbiQWJ1uVMHVAfCDbpc6+SLBL7B6u1VC/2RPmOU3?=
 =?us-ascii?Q?S+1BJ9JNZgK1BbWm5aTaV2iINaN34PKoeidY+Ltvu0qt+zvL3PnX6w/SF5Bh?=
 =?us-ascii?Q?EItolAUBQv12VzBKD/SxBtTrXfU6cf0i862QPlK3YVIBWIbOgVxOqT1ps0MM?=
 =?us-ascii?Q?Edqi9YgAbbDrgCpOFpwk/rXE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50984d43-3571-4e5c-0aa4-08d919537f2b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 16:47:45.8431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nm62hy1d4e0PKkk+JuP9cuzYs78uz2vmzFJXN8OzsWk+Uk/7BOViyeuUpglFZxjn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2858
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Instead of having an whole bunch of different allocations to create the
gid_attr kobjects reduce it to three, one for the kobj struct plus the
attributes, and one for the attribute list for each of the two
groups.

Move the freeing of all allocations to the release function.

Reorder the operations so all the allocations happen first then the
kobject & sysfs operations are last.

This removes the majority of the complicated error unwind since the
release function will always undo all the memory allocations. Freeing the
memory is also much simpler since there is a lot less of it.

Consolidate creating the "group of array indexes" pattern into one helper
function. Ensure kobject_del is used.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/sysfs.c | 171 +++++++++++++++++---------------
 1 file changed, 90 insertions(+), 81 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index d2a089a6f66639..569e847757b944 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -47,23 +47,6 @@
 
 struct ib_port;
 
-struct gid_attr_group {
-	struct ib_port		*port;
-	struct kobject		kobj;
-	struct attribute_group	ndev;
-	struct attribute_group	type;
-};
-struct ib_port {
-	struct kobject         kobj;
-	struct ib_device      *ibdev;
-	struct gid_attr_group *gid_attr_group;
-	struct attribute_group gid_group;
-	struct attribute_group *pkey_group;
-	const struct attribute_group *pma_table;
-	struct hw_stats_port_data *hw_stats_data;
-	u32                     port_num;
-};
-
 struct port_attribute {
 	struct attribute attr;
 	ssize_t (*show)(struct ib_port *, struct port_attribute *, char *buf);
@@ -84,6 +67,25 @@ struct port_table_attribute {
 	__be16			attr_id;
 };
 
+struct gid_attr_group {
+	struct ib_port *port;
+	struct kobject kobj;
+	struct attribute_group groups[2];
+	const struct attribute_group *groups_list[3];
+	struct port_table_attribute attrs_list[];
+};
+
+struct ib_port {
+	struct kobject kobj;
+	struct ib_device *ibdev;
+	struct gid_attr_group *gid_attr_group;
+	struct attribute_group gid_group;
+	struct attribute_group *pkey_group;
+	const struct attribute_group *pma_table;
+	struct hw_stats_port_data *hw_stats_data;
+	u32 port_num;
+};
+
 struct hw_stats_device_attribute {
 	struct device_attribute attr;
 	ssize_t (*show)(struct ib_device *ibdev, struct rdma_hw_stats *stats,
@@ -776,26 +778,13 @@ static void ib_port_release(struct kobject *kobj)
 
 static void ib_port_gid_attr_release(struct kobject *kobj)
 {
-	struct gid_attr_group *g = container_of(kobj, struct gid_attr_group,
-						kobj);
-	struct attribute *a;
+	struct gid_attr_group *gid_attr_group =
+		container_of(kobj, struct gid_attr_group, kobj);
 	int i;
 
-	if (g->ndev.attrs) {
-		for (i = 0; (a = g->ndev.attrs[i]); ++i)
-			kfree(a);
-
-		kfree(g->ndev.attrs);
-	}
-
-	if (g->type.attrs) {
-		for (i = 0; (a = g->type.attrs[i]); ++i)
-			kfree(a);
-
-		kfree(g->type.attrs);
-	}
-
-	kfree(g);
+	for (i = 0; i != ARRAY_SIZE(gid_attr_group->groups); i++)
+		kfree(gid_attr_group->groups[i].attrs);
+	kfree(gid_attr_group);
 }
 
 static struct kobj_type port_type = {
@@ -1178,6 +1167,42 @@ struct rdma_hw_stats *ib_get_hw_stats_port(struct ib_device *ibdev,
 	return ibdev->port_data[port_num].sysfs->hw_stats_data->stats;
 }
 
+static int alloc_port_table_group(
+	const char *name, struct attribute_group *group,
+	struct port_table_attribute *attrs, size_t num,
+	ssize_t (*show)(struct ib_port *, struct port_attribute *, char *buf))
+{
+	struct attribute **attr_list;
+	int i;
+
+	attr_list = kcalloc(num + 1, sizeof(*attr_list), GFP_KERNEL);
+	if (!attr_list)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++) {
+		struct port_table_attribute *element = &attrs[i];
+
+		if (snprintf(element->name, sizeof(element->name), "%d", i) >=
+		    sizeof(element->name)) {
+			goto err;
+		}
+
+		sysfs_attr_init(&element->attr.attr);
+		element->attr.attr.name = element->name;
+		element->attr.attr.mode = 0444;
+		element->attr.show = show;
+		element->index = i;
+
+		attr_list[i] = &element->attr.attr;
+	}
+	group->name = name;
+	group->attrs = attr_list;
+	return 0;
+err:
+	kfree(attr_list);
+	return -EINVAL;
+}
+
 /*
  * Create the sysfs:
  *  ibp0s9/ports/XX/gid_attrs/{ndevs,types}/YYY
@@ -1188,60 +1213,44 @@ static int setup_gid_attrs(struct ib_port *port,
 {
 	struct gid_attr_group *gid_attr_group;
 	int ret;
-	int i;
 
-	gid_attr_group = kzalloc(sizeof(*gid_attr_group), GFP_KERNEL);
+	gid_attr_group = kzalloc(struct_size(gid_attr_group, attrs_list,
+					     attr->gid_tbl_len * 2),
+				 GFP_KERNEL);
 	if (!gid_attr_group)
 		return -ENOMEM;
-
 	gid_attr_group->port = port;
-	ret = kobject_init_and_add(&gid_attr_group->kobj, &gid_attr_type,
-				   &port->kobj, "gid_attrs");
-	if (ret)
-		goto err_put_gid_attrs;
-
-	gid_attr_group->ndev.name = "ndevs";
-	gid_attr_group->ndev.attrs =
-		alloc_group_attrs(show_port_gid_attr_ndev, attr->gid_tbl_len);
-	if (!gid_attr_group->ndev.attrs) {
-		ret = -ENOMEM;
-		goto err_put_gid_attrs;
-	}
+	kobject_init(&gid_attr_group->kobj, &gid_attr_type);
 
-	ret = sysfs_create_group(&gid_attr_group->kobj, &gid_attr_group->ndev);
+	ret = alloc_port_table_group("ndevs", &gid_attr_group->groups[0],
+				     gid_attr_group->attrs_list,
+				     attr->gid_tbl_len,
+				     show_port_gid_attr_ndev);
 	if (ret)
-		goto err_free_gid_ndev;
-
-	gid_attr_group->type.name = "types";
-	gid_attr_group->type.attrs = alloc_group_attrs(
-		show_port_gid_attr_gid_type, attr->gid_tbl_len);
-	if (!gid_attr_group->type.attrs) {
-		ret = -ENOMEM;
-		goto err_remove_gid_ndev;
-	}
+		goto err_put;
+	gid_attr_group->groups_list[0] = &gid_attr_group->groups[0];
 
-	ret = sysfs_create_group(&gid_attr_group->kobj, &gid_attr_group->type);
+	ret = alloc_port_table_group(
+		"types", &gid_attr_group->groups[1],
+		gid_attr_group->attrs_list + attr->gid_tbl_len,
+		attr->gid_tbl_len, show_port_gid_attr_gid_type);
 	if (ret)
-		goto err_free_gid_type;
+		goto err_put;
+	gid_attr_group->groups_list[1] = &gid_attr_group->groups[1];
 
+	ret = kobject_add(&gid_attr_group->kobj, &port->kobj, "gid_attrs");
+	if (ret)
+		goto err_put;
+	ret = sysfs_create_groups(&gid_attr_group->kobj,
+				  gid_attr_group->groups_list);
+	if (ret)
+		goto err_del;
 	port->gid_attr_group = gid_attr_group;
 	return 0;
 
-err_free_gid_type:
-	for (i = 0; i < attr->gid_tbl_len; ++i)
-		kfree(gid_attr_group->type.attrs[i]);
-
-	kfree(gid_attr_group->type.attrs);
-	gid_attr_group->type.attrs = NULL;
-err_remove_gid_ndev:
-	sysfs_remove_group(&gid_attr_group->kobj, &gid_attr_group->ndev);
-err_free_gid_ndev:
-	for (i = 0; i < attr->gid_tbl_len; ++i)
-		kfree(gid_attr_group->ndev.attrs[i]);
-
-	kfree(gid_attr_group->ndev.attrs);
-	gid_attr_group->ndev.attrs = NULL;
-err_put_gid_attrs:
+err_del:
+	kobject_del(&gid_attr_group->kobj);
+err_put:
 	kobject_put(&gid_attr_group->kobj);
 	return ret;
 }
@@ -1250,10 +1259,10 @@ static void destroy_gid_attrs(struct ib_port *port)
 {
 	struct gid_attr_group *gid_attr_group = port->gid_attr_group;
 
-	sysfs_remove_group(&gid_attr_group->kobj,
-			   &gid_attr_group->ndev);
-	sysfs_remove_group(&gid_attr_group->kobj,
-			   &gid_attr_group->type);
+	if (!gid_attr_group)
+		return;
+	sysfs_remove_groups(&gid_attr_group->kobj, gid_attr_group->groups_list);
+	kobject_del(&gid_attr_group->kobj);
 	kobject_put(&gid_attr_group->kobj);
 }
 
-- 
2.31.1

