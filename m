Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9946E383A60
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 18:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237760AbhEQQtd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 12:49:33 -0400
Received: from mail-mw2nam10on2062.outbound.protection.outlook.com ([40.107.94.62]:7601
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238753AbhEQQtD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 12:49:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxZu3yOx5Rkuama28FXRhDD2Gk+PHJxoIHgC2Rata2nmKWfEaVBuhPo+LCDbzgj6hZbWwUOA6acMQUZQy1ffr0bpfTYREPQDUXdAZbzFOKaBk48zbNFgPtGDxhQBFIdf1CO15f/8kjVYAgtTBxLA+NjsuSmBIedqIpw3hmmLU4Mrrn1FQbkl7cS5IfYFjTs9xdJIef/pjdcBZCbdHOluWXBmjm2nTLEj7FhZPmA2fGldJ7Qkgv+SR8FBmA/95ETjk3C5tsFQ56Dw9zgIzTRMga4VwT3AdU1BhL/GH9hjUkWLap1bit3a9Haxcc/TAIQystaf/QYAPSwJjoH6gOzuSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekQpVYkXITK7tMec3qt3EbEAAwhMj9Kjf0r+fbxeLU4=;
 b=N4DqnjonoiGlvMtq5J67Thy684Wmww25VHsi4xV2Mh8qNLhUBk4Ut3nNuKberZ4UDm0eSvwWuDwKCyVQVsDTPZRa4H+xylxVryJXHTw6SF+8jDWa8S5Wx2CF5fhIkL1R6j517bGy5qv1g+dthX0XR3GPZ1KKrLWabPr53Uw3FsSp1xaRYmvTlmPVnSr+shVCvVO1WbHSTsYSId9Rhcp0rCYJaYJLXMQW7py0aMA9lpoq34zY/kuzuxsWOt2SRRdo0P1GjPixO4e6tA1bZgwhQHfDg4UAJ8Oq0rbtP3sNytvbPcseWOYBVECrIv5VjqyEAy22LoGkmnqquycxVAvliQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekQpVYkXITK7tMec3qt3EbEAAwhMj9Kjf0r+fbxeLU4=;
 b=KwgvvA0PMasyp9p5LTGBlMFBTUjUyQ3GsJnDiQUEw//FK3hOry3AUUo7q+ymgDiq8OHtyWBFWcwy1PfhpyQIICEVUtfZu3dR4j3gwP2OfGSvawSmXyqo1Hq4u7ITCEHn0OTNUji5dijF8g2xa3mm52kgOJ0EG9iwOCrehzAMaw+2NhgHKBP6LrRi/wSlzobCwZuRhzu2X4fpld+F2Kf4XUs8wM7Ps96JJSLeY1B9JvdhTNDVRrYbnMkTsjG91wXHNivoe/glqxNxEUIuvHFtdo5Cnd7I9wXhsAAi4HOoAJW1uw/o+DsRXYL0kqTVTzaf3+AdnWk5r6t0lOmu5TEPSw==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 16:47:43 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 16:47:43 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 04/13] RDMA/core: Split gid_attrs related sysfs from add_port()
Date:   Mon, 17 May 2021 13:47:32 -0300
Message-Id: <4-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
In-Reply-To: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:208:23a::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR03CA0018.namprd03.prod.outlook.com (2603:10b6:208:23a::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 16:47:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ligP7-009LYX-Tl; Mon, 17 May 2021 13:47:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db2cf5f2-d766-424d-bf25-08d919537d86
X-MS-TrafficTypeDiagnostic: DM6PR12MB2858:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2858E92E1BF18E5141B5330BC22D9@DM6PR12MB2858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q2zefgbhVBbXVT4T+2wiy80lNlndv//AM694CgHIus0FdIXbk7nxdToSiQ2fwjNpuQPAsU3RvO3OtgaP7a9X1H3+ogQlLOYsJP+jKdTS6n8V06CAoH1q0CHJ39czb2lKAgbhaQT8K3hsX2W0fVMkRVEQmxO7HRxkGT36/TyE7HjLZhKd6RnZ2NNgJilQdZ7eK5YfU0YRl5gNAP5CJoLyzOAwcaMLy++drZcTRr97ems8mGd3YrwpTbZOAs0AboxcUz8L8JwbpeN+ymxigxumisDGGfQdZDnRv6hmg58JF29MNczNsNIxsp7UbHmfphG0aBKGNpUL6METTMbirhDSBJWwv2NFdxgioyIEx0dexqIjDLzHcuKhnIgOBWCBACXkIOJHk8TR5jcVpkYkz9iF/se37Hn3KP5KpUO2QO3QVlXbxc4u8qbi5SWedu+Tw++JsSx1afI0xGWgEYk5HqKvJVCeG1HDiWqWzuD18KbpLdNIlI7LSE6QGlLMMBJdoDaQcrFKaudCkcIsvcHT3sovlPnBqwdDBAalqNkJaBqISIuWZK+A5zJzIGHI0PRYXBFlNcy3Yf8iFPcoPaXAbNO9PDOYIoez0LRiH/DneB92Upuc6jJosNasKdl5WYR8jVGAztslBhpEjM7laA0JAXuqaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(54906003)(6666004)(9746002)(8676002)(66556008)(426003)(83380400001)(36756003)(9786002)(26005)(66946007)(38100700002)(316002)(66476007)(4326008)(478600001)(86362001)(5660300002)(186003)(8936002)(2616005)(2906002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CMuKtkCl6iSiPk03DbILCbAcPEgijORMKwbWpkjGsRm4Jd4Te0AGMBbzUOla?=
 =?us-ascii?Q?uSSLfJ179ZzF8EtyWL296/NLPA4ohKyIedcQElD4Sp/H2CiO2Ybxe9elzfmZ?=
 =?us-ascii?Q?EbOteBDBPiu/7/iH2abjTfHUf/iWBzZvvZJw0jt+QnAhy7F6oGXawrm/B8ba?=
 =?us-ascii?Q?79lcQXHuF33zRn0dY0MBZnTJmQrA4FsIPOCxc3mK4KNJfO4o/JYAG6YvEktb?=
 =?us-ascii?Q?qWLLTBGFZjpYxgal+z7VG+seJ0VuSiLwtf8kappDZHyDKR8lDmmyxrf3EoYI?=
 =?us-ascii?Q?avit+q0NehjcihiMOllKuyo1/Tup3HXI5PcVgCcMASYM6guoT8eX95L3rKAy?=
 =?us-ascii?Q?9ybbptTBCAxKxpkFg8VwVfZ8ZLs0rJaz385r4vjy7hJjHauE08R4U/g6x8i6?=
 =?us-ascii?Q?GQR4kM0F6KlkzR09l2B9nHOOIl4XaAHTyAoAh/qhFqP72MFCz5M3PBLxP301?=
 =?us-ascii?Q?lxm2AH/3Ogb80bVUlPWAyFiJwBekOzqLBf0n06/QF9fLth+vn5c1Vzb/eO+a?=
 =?us-ascii?Q?+n8Gal1iuBRS358vyBPjhcsZB8ICmnXiaBznCNZIYUH9mEzePVkvSIzSyUGL?=
 =?us-ascii?Q?YMyZ+LZ/LJ8iWCiJnK2BFlkm0jEz3HFOkJccX9TAhj145wA2hEG/Dh4Vs+Pl?=
 =?us-ascii?Q?xCXLAYAry/fZlmeWq9cok74Q80WcnnELOEurl5gLtpOVep7J3qdy+/+jD8zQ?=
 =?us-ascii?Q?7LOaQnJepfiNUtOgyE30l0ydBv4BljjxZmflL1Qc3YX6JC0Jq3YqDcv7iJEC?=
 =?us-ascii?Q?BqCk07wYi+oPSDu7/X9Zywg+5qvablU8QiCw+kmaqbRLPW8b13zXj7/jucwN?=
 =?us-ascii?Q?DWZVxp4msE0sSui/nfILu0xwqjFgZIMcwHvZffzYF3Nlh1Z+OiVZPr6+skC4?=
 =?us-ascii?Q?HMN0Dd5agKzVPIkZE0DDaS5CoRoQ40He4ALTQjhGK5ufFbm/CcpaJyqEt39i?=
 =?us-ascii?Q?t1w3B4woIGBGI9IEfITum8RG92MOYaglfqROZVI79+S7yGM1SE8mGF1daK6y?=
 =?us-ascii?Q?+3k+8GSkk4zwyxFAqaCBteK9i1nFdyueo2H+ptsoOtvlt8yd9Ln33AUfnioH?=
 =?us-ascii?Q?G3c+sHOzW3djJPGrmtHTfT7LAq5VIK/qqRqiAY0nOEatiWNFAmzU2TnwkdYq?=
 =?us-ascii?Q?HOtuwsyt2oPakRLBm0KGg5xsucXa92phV1KI0KhhcXj+rdN8mDSO9NY0arRI?=
 =?us-ascii?Q?zQlH8qZM3BUH1W4rijz0goXDVd5YtpDNI1G8IpFVN/Ym61ZlB+y4iniWeMqe?=
 =?us-ascii?Q?iBktX8E45GNo7SkYcLvFJssmxLxeJe3P12ILYJg7Y3P560JS5QJTU+yx65zO?=
 =?us-ascii?Q?HxV0VJWvhQlMXbVy0oFkzgRk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2cf5f2-d766-424d-bf25-08d919537d86
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 16:47:43.1486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLEitCuVT1C66EwyUpWv29Yo75fDcXO50M4GGqSH/9o1kmJ/whDdc+gxr3Mha2xa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2858
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The gid_attrs directory is a dedicated kobj nested under the port,
construct/destruct it with its own pair of functions for
understandability. This is much more readable than having it weirdly
inlined out of order into the add_port() function.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/sysfs.c | 160 ++++++++++++++++++--------------
 1 file changed, 89 insertions(+), 71 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 114fecda97648e..d2a089a6f66639 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1178,6 +1178,85 @@ struct rdma_hw_stats *ib_get_hw_stats_port(struct ib_device *ibdev,
 	return ibdev->port_data[port_num].sysfs->hw_stats_data->stats;
 }
 
+/*
+ * Create the sysfs:
+ *  ibp0s9/ports/XX/gid_attrs/{ndevs,types}/YYY
+ * YYY is the gid table index in decimal
+ */
+static int setup_gid_attrs(struct ib_port *port,
+			   const struct ib_port_attr *attr)
+{
+	struct gid_attr_group *gid_attr_group;
+	int ret;
+	int i;
+
+	gid_attr_group = kzalloc(sizeof(*gid_attr_group), GFP_KERNEL);
+	if (!gid_attr_group)
+		return -ENOMEM;
+
+	gid_attr_group->port = port;
+	ret = kobject_init_and_add(&gid_attr_group->kobj, &gid_attr_type,
+				   &port->kobj, "gid_attrs");
+	if (ret)
+		goto err_put_gid_attrs;
+
+	gid_attr_group->ndev.name = "ndevs";
+	gid_attr_group->ndev.attrs =
+		alloc_group_attrs(show_port_gid_attr_ndev, attr->gid_tbl_len);
+	if (!gid_attr_group->ndev.attrs) {
+		ret = -ENOMEM;
+		goto err_put_gid_attrs;
+	}
+
+	ret = sysfs_create_group(&gid_attr_group->kobj, &gid_attr_group->ndev);
+	if (ret)
+		goto err_free_gid_ndev;
+
+	gid_attr_group->type.name = "types";
+	gid_attr_group->type.attrs = alloc_group_attrs(
+		show_port_gid_attr_gid_type, attr->gid_tbl_len);
+	if (!gid_attr_group->type.attrs) {
+		ret = -ENOMEM;
+		goto err_remove_gid_ndev;
+	}
+
+	ret = sysfs_create_group(&gid_attr_group->kobj, &gid_attr_group->type);
+	if (ret)
+		goto err_free_gid_type;
+
+	port->gid_attr_group = gid_attr_group;
+	return 0;
+
+err_free_gid_type:
+	for (i = 0; i < attr->gid_tbl_len; ++i)
+		kfree(gid_attr_group->type.attrs[i]);
+
+	kfree(gid_attr_group->type.attrs);
+	gid_attr_group->type.attrs = NULL;
+err_remove_gid_ndev:
+	sysfs_remove_group(&gid_attr_group->kobj, &gid_attr_group->ndev);
+err_free_gid_ndev:
+	for (i = 0; i < attr->gid_tbl_len; ++i)
+		kfree(gid_attr_group->ndev.attrs[i]);
+
+	kfree(gid_attr_group->ndev.attrs);
+	gid_attr_group->ndev.attrs = NULL;
+err_put_gid_attrs:
+	kobject_put(&gid_attr_group->kobj);
+	return ret;
+}
+
+static void destroy_gid_attrs(struct ib_port *port)
+{
+	struct gid_attr_group *gid_attr_group = port->gid_attr_group;
+
+	sysfs_remove_group(&gid_attr_group->kobj,
+			   &gid_attr_group->ndev);
+	sysfs_remove_group(&gid_attr_group->kobj,
+			   &gid_attr_group->type);
+	kobject_put(&gid_attr_group->kobj);
+}
+
 static int add_port(struct ib_core_device *coredev, int port_num)
 {
 	struct ib_device *device = rdma_device_to_ibdev(&coredev->dev);
@@ -1204,23 +1283,11 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	if (ret)
 		goto err_put;
 
-	p->gid_attr_group = kzalloc(sizeof(*p->gid_attr_group), GFP_KERNEL);
-	if (!p->gid_attr_group) {
-		ret = -ENOMEM;
-		goto err_put;
-	}
-
-	p->gid_attr_group->port = p;
-	ret = kobject_init_and_add(&p->gid_attr_group->kobj, &gid_attr_type,
-				   &p->kobj, "gid_attrs");
-	if (ret)
-		goto err_put_gid_attrs;
-
 	if (device->ops.process_mad && is_full_dev) {
 		p->pma_table = get_counter_table(device, port_num);
 		ret = sysfs_create_group(&p->kobj, p->pma_table);
 		if (ret)
-			goto err_put_gid_attrs;
+			goto err_put;
 	}
 
 	p->gid_group.name  = "gids";
@@ -1234,37 +1301,11 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	if (ret)
 		goto err_free_gid;
 
-	p->gid_attr_group->ndev.name = "ndevs";
-	p->gid_attr_group->ndev.attrs = alloc_group_attrs(show_port_gid_attr_ndev,
-							  attr.gid_tbl_len);
-	if (!p->gid_attr_group->ndev.attrs) {
-		ret = -ENOMEM;
-		goto err_remove_gid;
-	}
-
-	ret = sysfs_create_group(&p->gid_attr_group->kobj,
-				 &p->gid_attr_group->ndev);
-	if (ret)
-		goto err_free_gid_ndev;
-
-	p->gid_attr_group->type.name = "types";
-	p->gid_attr_group->type.attrs = alloc_group_attrs(show_port_gid_attr_gid_type,
-							  attr.gid_tbl_len);
-	if (!p->gid_attr_group->type.attrs) {
-		ret = -ENOMEM;
-		goto err_remove_gid_ndev;
-	}
-
-	ret = sysfs_create_group(&p->gid_attr_group->kobj,
-				 &p->gid_attr_group->type);
-	if (ret)
-		goto err_free_gid_type;
-
 	if (attr.pkey_tbl_len) {
 		p->pkey_group = kzalloc(sizeof(*p->pkey_group), GFP_KERNEL);
 		if (!p->pkey_group) {
 			ret = -ENOMEM;
-			goto err_remove_gid_type;
+			goto err_remove_gid;
 		}
 
 		p->pkey_group->name  = "pkeys";
@@ -1290,11 +1331,14 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 		if (ret && ret != -EOPNOTSUPP)
 			goto err_remove_pkey;
 	}
+	ret = setup_gid_attrs(p, &attr);
+	if (ret)
+		goto err_remove_stats;
 
 	if (device->ops.init_port && is_full_dev) {
 		ret = device->ops.init_port(device, port_num, &p->kobj);
 		if (ret)
-			goto err_remove_stats;
+			goto err_remove_gid_attrs;
 	}
 
 	list_add_tail(&p->kobj.entry, &coredev->port_list);
@@ -1304,6 +1348,9 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	kobject_uevent(&p->kobj, KOBJ_ADD);
 	return 0;
 
+err_remove_gid_attrs:
+	destroy_gid_attrs(p);
+
 err_remove_stats:
 	destroy_hw_port_stats(p);
 
@@ -1323,28 +1370,6 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 err_free_pkey_group:
 	kfree(p->pkey_group);
 
-err_remove_gid_type:
-	sysfs_remove_group(&p->gid_attr_group->kobj,
-			   &p->gid_attr_group->type);
-
-err_free_gid_type:
-	for (i = 0; i < attr.gid_tbl_len; ++i)
-		kfree(p->gid_attr_group->type.attrs[i]);
-
-	kfree(p->gid_attr_group->type.attrs);
-	p->gid_attr_group->type.attrs = NULL;
-
-err_remove_gid_ndev:
-	sysfs_remove_group(&p->gid_attr_group->kobj,
-			   &p->gid_attr_group->ndev);
-
-err_free_gid_ndev:
-	for (i = 0; i < attr.gid_tbl_len; ++i)
-		kfree(p->gid_attr_group->ndev.attrs[i]);
-
-	kfree(p->gid_attr_group->ndev.attrs);
-	p->gid_attr_group->ndev.attrs = NULL;
-
 err_remove_gid:
 	sysfs_remove_group(&p->kobj, &p->gid_group);
 
@@ -1359,9 +1384,6 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	if (p->pma_table)
 		sysfs_remove_group(&p->kobj, p->pma_table);
 
-err_put_gid_attrs:
-	kobject_put(&p->gid_attr_group->kobj);
-
 err_put:
 	kobject_put(&p->kobj);
 	return ret;
@@ -1498,11 +1520,7 @@ void ib_free_port_attrs(struct ib_core_device *coredev)
 		if (port->pkey_group)
 			sysfs_remove_group(p, port->pkey_group);
 		sysfs_remove_group(p, &port->gid_group);
-		sysfs_remove_group(&port->gid_attr_group->kobj,
-				   &port->gid_attr_group->ndev);
-		sysfs_remove_group(&port->gid_attr_group->kobj,
-				   &port->gid_attr_group->type);
-		kobject_put(&port->gid_attr_group->kobj);
+		destroy_gid_attrs(port);
 		kobject_put(p);
 	}
 
-- 
2.31.1

