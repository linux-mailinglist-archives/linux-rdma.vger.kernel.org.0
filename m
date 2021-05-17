Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CE1383A77
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 18:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbhEQQuw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 12:50:52 -0400
Received: from mail-mw2nam10on2066.outbound.protection.outlook.com ([40.107.94.66]:65527
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240969AbhEQQtV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 12:49:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+O7JiGp5PRyiDOWj0icC9x9c9Uj/sCYSywXl/BdoM7taTSZvSzQ77e6CoLo2j96Ko6lYv6myVrSx+E486PFY1xeyr1tJQm4HZPsgYyfz51fV6FYlSCH0Ci2GI7apneUXiRU7gaCT93kBFM2Fi97TCtLvrdwZSy5619ahITvBld7eB0ttsJKPNMHZPLUlANr4jD032Po3GJXawYLs47zAz2AVTZdvNuA/Gy40Us161FjsfEDQtfrjfG8LTg4xdDI740wC69ccHyWh0O8qPDXwYPojKc+Z2qCCrqljW0UCOJmioonwGA654ZQ9Q/mk5/5j/bmJEnXgGWyD1SEg/ExwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx032982MoUPcoYIloagYcvwQb0/AJx0TCZd/Vp4Rxc=;
 b=QtinbF87z/Y8sRxGxJq8JaMGMHOTM5kNI5ITvqAq6VEoc0B/6RrCFAhpMV1lqOH3Yn6mi4F0J9TBB3DyapTBNoOyrNBPX+mPmfrlouruSUEXwmzZLb6NP3op4BqR2oBVA1gQsnHRjE0y+9mIieCZdOPSvz0C9eS7VprKdqltVEouwWU8MDxA323KX1IFT+p0rOJ5yrGplb89/DpG9yrd1iKtBeDsQ/XSel54i2EjK0FTqtPWGwKuIyC5u7aUi5k+VCp1exnF/k5c//aVKmf16vjfkzcGkp1nbKRDrnZe7YRWm85QM9/ovo9iMqj09PLhTgjbyEXXiNgG1nbpUvpZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx032982MoUPcoYIloagYcvwQb0/AJx0TCZd/Vp4Rxc=;
 b=fag1OtPnp6bCjOJ3kyCIhv9tQac5FOtDaxqQB7UCKIdmGWe5PIpu6phqNwYnMFOat6qWghHbFEwu4pyrhLChKxJplXDRnp7W8BR6zTSHS+OxG/vteN0ezl7tWnmj6DhgLJuy7KKckjJWVwQxBbQcH7Lc77RA0bBWFj54x8vz+lkfjO96xT2s8jSf86OsOHuZdtoSNkkXYWvBO/GYMrmd3AwMd7o6spIs9gIWX3Ob9lr6tpHj6f75HCgi4aM4g1RbVqSwFLWatAtXeYricDvnsSccDHA3Tl2zqq93GDX7q3bhhN7TvBpcAv/OkEWny9fTGwqXYQ1M8G3Co2GDia1Afg==
Authentication-Results: googlegroups.com; dkim=none (message not signed)
 header.d=none;googlegroups.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 16:47:47 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 16:47:47 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     clang-built-linux@googlegroups.com,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 03/13] RDMA/core: Split port and device counter sysfs attributes
Date:   Mon, 17 May 2021 13:47:31 -0300
Message-Id: <3-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
In-Reply-To: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:208:236::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR05CA0045.namprd05.prod.outlook.com (2603:10b6:208:236::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Mon, 17 May 2021 16:47:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ligP7-009LYU-S5; Mon, 17 May 2021 13:47:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57856b62-ddc5-4d79-de97-08d919537e75
X-MS-TrafficTypeDiagnostic: DM6PR12MB2858:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2858900C6568F44CFA05ED3BC22D9@DM6PR12MB2858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1qsoP5pgnvol3WvOswjCGUWc9lIpy6VKvoJrqsACkEaWbAiQEpAzPWHp9OgBiqZpm+xk3UOI2tpXxc1xvKUA+1fRFJTA79b3wYe80xcIMCgnJWiHAVMx9LAfyl3G53zfEJlRcakBjUFV6WtZteUZMcj8vuhGyrdP8YECeKA9S6oIgXLkGKi7WrcbTZz7KG3r+gx0w3j6EwTPz3RnFkBHGITKZvVhiOgCZoUYz5BfK0tdmcdKuks7KDRz9EDhU0Qet2S7teu5ELeMoHgcSQd2r+Vd/ghNQpetXrimPe0pZ/wfMzRjoK83tE6EeUxJ6k9gp9sDfrUx0dPYC1zptDWnPap1TSc/7LLQy/A5B7thAnby6ppmzqWrUREZUCRoOnxneibMjqxMr3q8odFPkiFMA00cc2dpkzg6SnwPsxBMg5oGv11AFe07N1cS1noGHofixV3esqGnJp9Pf9NJNS7dYwY/3rLfMP4fkD1nNe3vPnvezj1Sh1N/zsWmATNTqLCbnjukWyaEnG/zGTXVIb4KjNAniWXrxJPxO6Z1vkdpaWfhmhGrHWk0GeAp4cqoKz4vbMuNvTmGUYfspkUF0ENKn8CqZz498vuJ00a3Me5cXWLSkmdXWwFTUZWKe6FvJKeJhl6sr8rS4xPXNx0cVO1xQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(54906003)(6666004)(110136005)(9746002)(8676002)(66556008)(426003)(83380400001)(36756003)(30864003)(9786002)(26005)(66946007)(38100700002)(316002)(66476007)(4326008)(478600001)(86362001)(5660300002)(186003)(8936002)(2616005)(2906002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Bla8zNZyPARwploaPragsWl2ALitCxZQJNk8p8YqL1jj65+0LQ8B1vknK0wN?=
 =?us-ascii?Q?6h4lUp0YkdUkQx1bGcB8+mt3HCcDjqPkWLZHJdA3tZ8T80EoC6lbWSQZGr7X?=
 =?us-ascii?Q?bHWsvOz2SW6JH7YsJyy2QUeL3161y54VExz6tuKFILv6vq2McWrZaxXEdN32?=
 =?us-ascii?Q?kveep/ai1oBzBb5aT8x2p6Yg1R1viX2o2aCVQqi6SQ1RRfahs2sJpyigbc/j?=
 =?us-ascii?Q?LyeCRx+SLgrovWVCNiYx47NnNJV+HOR4Py0b+1+wO65dRdiMhqB6I8NqKAip?=
 =?us-ascii?Q?8RLbchTjBne08Sq8m9gLWoXuasfNs5F0fMstQjxKpEUMH/0bE6jKeVNn9i6r?=
 =?us-ascii?Q?c85tupu/W1sd3LahOYD494ieIsIbAu7HkZagnRU5Xs4MCyVOLYcLGImWuPHJ?=
 =?us-ascii?Q?+/iVwESWw7esgGZfziv5GltcU2OmnwTqB0gtJ69rbXBpUNp53FSFvH9D/zek?=
 =?us-ascii?Q?8QClGLT2jyXDBgB+te/xNwY3gGdOfsbgsk4XUK+czFFbj2GYCw1Xp9ZdsBzw?=
 =?us-ascii?Q?k3PXcsbWAuENfcxoBMcRck1A3N1YNRwXre/gCASUORxq3lTvZRuDiTf2bKIB?=
 =?us-ascii?Q?2bWIXLTF6wpTh+BC0+dm510r32lX/ZLj1XBsXebK45v1c/ebbGthWKrlc4vn?=
 =?us-ascii?Q?ilT42PpTPF7jLxk/76LbZtibgFBfNrAa2wDaHV1F8ARcCwNP+cUXOzA7X9WE?=
 =?us-ascii?Q?sErGfYPaXvRqf4GpPE2hT58SrYuv2eLkm4ri3RWe3SgDqEtjMQSWaa5EH2Cs?=
 =?us-ascii?Q?UJTDKC6AKruy9Qkpgo8hO7wojtRet0Nky7OteCV7shbNGJm045a5wARzBPFV?=
 =?us-ascii?Q?9WFC7SmW+tVIGo73QAn2OrmWwIyBxTVdIRqqewQPUj5DFWWsqsX7lp2PMSMA?=
 =?us-ascii?Q?Ax04qVfuLeAgrrjKoLvf5Ih86t///wbVuise19YdVHDp8aIOySjsnwLUeb/T?=
 =?us-ascii?Q?Sej/NItZ6YOg4i3BwebOvv2jxa1nIZC72Y6zNQ10ua66Rz7ayxA228oomgd3?=
 =?us-ascii?Q?W7GGGJNh2fnJaUYdCqZwYHlHGPqWTfujjxzt6Ts9+sYWYSCnrKOrLYAQwATD?=
 =?us-ascii?Q?UKfm+OcFg8/F2NuSLQKv5KIzOIw7fgmxDyBbtiPmwbOPe8YRxBnk7IPCDNAp?=
 =?us-ascii?Q?imz565FPcTYMlDURkrrKoVARvEtBfSuGSZRExxMMvDvSXeDt5EQZVU8MiP6B?=
 =?us-ascii?Q?5KWAH3O7xLvkqtXRyrLb7mUagC6AP3Q+1TCmyoZegoQQ5gRGu1UzL61WN7lr?=
 =?us-ascii?Q?O43hmludNKzzdD9u/gIhmr+7enfIi68A6utGF8KIlydcKscPe+M56n5nCbyW?=
 =?us-ascii?Q?gvl0yn2oT4JM5nKRioXRmYsT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57856b62-ddc5-4d79-de97-08d919537e75
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 16:47:44.7847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNmseQY2ArhSfJgssdizGULN+a4lkGwODUKsnT7lNDoXOmXXhQdm8yRPDlW9nR+P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2858
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This code creates a 'struct hw_stats_attribute' for each sysfs entry that
contains a naked 'struct attribute' inside.

It then proceeds to attach this same structure to a 'struct device' kobj
and a 'struct ib_port' kobj. However, this violates the typing
requirements.  'struct device' requires the attribute to be a 'struct
device_attribute' and 'struct ib_port' requires the attribute to be
'struct port_attribute'.

This happens to work because the show/store function pointers in all three
structures happen to be at the same offset and happen to be nearly the
same signature. This means when container_of() was used to go between the
wrong two types it still managed to work.

However clang CFI detection notices that the function pointers have a
slightly different signature. As with show/store this was only working
because the device and port struct layouts happened to have the kobj at
the front.

Correct this by have two independent sets of data structures for the port
and device case. The two different attributes correctly include the
port/device_attribute struct and everything from there up is kept
split. The show/store function call chains start with device/port unique
functions that invoke a common show/store function pointer.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/sysfs.c | 463 ++++++++++++++++++++------------
 include/rdma/ib_verbs.h         |   4 +-
 2 files changed, 292 insertions(+), 175 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 5f8b1677e1237b..114fecda97648e 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -60,8 +60,7 @@ struct ib_port {
 	struct attribute_group gid_group;
 	struct attribute_group *pkey_group;
 	const struct attribute_group *pma_table;
-	struct attribute_group *hw_stats_ag;
-	struct rdma_hw_stats   *hw_stats;
+	struct hw_stats_port_data *hw_stats_data;
 	u32                     port_num;
 };
 
@@ -85,16 +84,35 @@ struct port_table_attribute {
 	__be16			attr_id;
 };
 
-struct hw_stats_attribute {
-	struct attribute	attr;
-	ssize_t			(*show)(struct kobject *kobj,
-					struct attribute *attr, char *buf);
-	ssize_t			(*store)(struct kobject *kobj,
-					 struct attribute *attr,
-					 const char *buf,
-					 size_t count);
-	int			index;
-	u32			port_num;
+struct hw_stats_device_attribute {
+	struct device_attribute attr;
+	ssize_t (*show)(struct ib_device *ibdev, struct rdma_hw_stats *stats,
+			unsigned int index, unsigned int port_num, char *buf);
+	ssize_t (*store)(struct ib_device *ibdev, struct rdma_hw_stats *stats,
+			 unsigned int index, unsigned int port_num,
+			 const char *buf, size_t count);
+};
+
+struct hw_stats_port_attribute {
+	struct port_attribute attr;
+	ssize_t (*show)(struct ib_device *ibdev, struct rdma_hw_stats *stats,
+			unsigned int index, unsigned int port_num, char *buf);
+	ssize_t (*store)(struct ib_device *ibdev, struct rdma_hw_stats *stats,
+			 unsigned int index, unsigned int port_num,
+			 const char *buf, size_t count);
+};
+
+struct hw_stats_device_data {
+	struct attribute_group group;
+	const struct attribute_group *groups[2];
+	struct rdma_hw_stats *stats;
+	struct hw_stats_device_attribute attrs[];
+};
+
+struct hw_stats_port_data {
+	struct attribute_group group;
+	struct rdma_hw_stats *stats;
+	struct hw_stats_port_attribute attrs[];
 };
 
 static ssize_t port_attr_show(struct kobject *kobj,
@@ -128,6 +146,53 @@ static const struct sysfs_ops port_sysfs_ops = {
 	.store	= port_attr_store
 };
 
+static ssize_t hw_stat_device_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct hw_stats_device_attribute *stat_attr =
+		container_of(attr, struct hw_stats_device_attribute, attr);
+	struct ib_device *ibdev = container_of(dev, struct ib_device, dev);
+
+	return stat_attr->show(ibdev, ibdev->hw_stats_data->stats,
+			       stat_attr - ibdev->hw_stats_data->attrs, 0, buf);
+}
+
+static ssize_t hw_stat_device_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct hw_stats_device_attribute *stat_attr =
+		container_of(attr, struct hw_stats_device_attribute, attr);
+	struct ib_device *ibdev = container_of(dev, struct ib_device, dev);
+
+	return stat_attr->store(ibdev, ibdev->hw_stats_data->stats,
+				stat_attr - ibdev->hw_stats_data->attrs, 0, buf,
+				count);
+}
+
+static ssize_t hw_stat_port_show(struct ib_port *port,
+				 struct port_attribute *attr, char *buf)
+{
+	struct hw_stats_port_attribute *stat_attr =
+		container_of(attr, struct hw_stats_port_attribute, attr);
+
+	return stat_attr->show(port->ibdev, port->hw_stats_data->stats,
+			       stat_attr - port->hw_stats_data->attrs,
+			       port->port_num, buf);
+}
+
+static ssize_t hw_stat_port_store(struct ib_port *port,
+				  struct port_attribute *attr, const char *buf,
+				  size_t count)
+{
+	struct hw_stats_port_attribute *stat_attr =
+		container_of(attr, struct hw_stats_port_attribute, attr);
+
+	return stat_attr->store(port->ibdev, port->hw_stats_data->stats,
+				stat_attr - port->hw_stats_data->attrs,
+				port->port_num, buf, count);
+}
+
 static ssize_t gid_attr_show(struct kobject *kobj,
 			     struct attribute *attr, char *buf)
 {
@@ -835,56 +900,30 @@ static int print_hw_stat(struct ib_device *dev, int port_num,
 	return sysfs_emit(buf, "%llu\n", stats->value[index] + v);
 }
 
-static ssize_t show_hw_stats(struct kobject *kobj, struct attribute *attr,
-			     char *buf)
+static ssize_t show_hw_stats(struct ib_device *ibdev,
+			     struct rdma_hw_stats *stats, unsigned int index,
+			     unsigned int port_num, char *buf)
 {
-	struct ib_device *dev;
-	struct ib_port *port;
-	struct hw_stats_attribute *hsa;
-	struct rdma_hw_stats *stats;
 	int ret;
 
-	hsa = container_of(attr, struct hw_stats_attribute, attr);
-	if (!hsa->port_num) {
-		dev = container_of((struct device *)kobj,
-				   struct ib_device, dev);
-		stats = dev->hw_stats;
-	} else {
-		port = container_of(kobj, struct ib_port, kobj);
-		dev = port->ibdev;
-		stats = port->hw_stats;
-	}
 	mutex_lock(&stats->lock);
-	ret = update_hw_stats(dev, stats, hsa->port_num, hsa->index);
+	ret = update_hw_stats(ibdev, stats, port_num, index);
 	if (ret)
 		goto unlock;
-	ret = print_hw_stat(dev, hsa->port_num, stats, hsa->index, buf);
+	ret = print_hw_stat(ibdev, port_num, stats, index, buf);
 unlock:
 	mutex_unlock(&stats->lock);
 
 	return ret;
 }
 
-static ssize_t show_stats_lifespan(struct kobject *kobj,
-				   struct attribute *attr,
+static ssize_t show_stats_lifespan(struct ib_device *ibdev,
+				   struct rdma_hw_stats *stats,
+				   unsigned int index, unsigned int port_num,
 				   char *buf)
 {
-	struct hw_stats_attribute *hsa;
-	struct rdma_hw_stats *stats;
 	int msecs;
 
-	hsa = container_of(attr, struct hw_stats_attribute, attr);
-	if (!hsa->port_num) {
-		struct ib_device *dev = container_of((struct device *)kobj,
-						     struct ib_device, dev);
-
-		stats = dev->hw_stats;
-	} else {
-		struct ib_port *p = container_of(kobj, struct ib_port, kobj);
-
-		stats = p->hw_stats;
-	}
-
 	mutex_lock(&stats->lock);
 	msecs = jiffies_to_msecs(stats->lifespan);
 	mutex_unlock(&stats->lock);
@@ -892,12 +931,11 @@ static ssize_t show_stats_lifespan(struct kobject *kobj,
 	return sysfs_emit(buf, "%d\n", msecs);
 }
 
-static ssize_t set_stats_lifespan(struct kobject *kobj,
-				  struct attribute *attr,
-				  const char *buf, size_t count)
+static ssize_t set_stats_lifespan(struct ib_device *ibdev,
+				   struct rdma_hw_stats *stats,
+				   unsigned int index, unsigned int port_num,
+				   const char *buf, size_t count)
 {
-	struct hw_stats_attribute *hsa;
-	struct rdma_hw_stats *stats;
 	int msecs;
 	int jiffies;
 	int ret;
@@ -908,17 +946,6 @@ static ssize_t set_stats_lifespan(struct kobject *kobj,
 	if (msecs < 0 || msecs > 10000)
 		return -EINVAL;
 	jiffies = msecs_to_jiffies(msecs);
-	hsa = container_of(attr, struct hw_stats_attribute, attr);
-	if (!hsa->port_num) {
-		struct ib_device *dev = container_of((struct device *)kobj,
-						     struct ib_device, dev);
-
-		stats = dev->hw_stats;
-	} else {
-		struct ib_port *p = container_of(kobj, struct ib_port, kobj);
-
-		stats = p->hw_stats;
-	}
 
 	mutex_lock(&stats->lock);
 	stats->lifespan = jiffies;
@@ -927,72 +954,125 @@ static ssize_t set_stats_lifespan(struct kobject *kobj,
 	return count;
 }
 
-static void free_hsag(struct kobject *kobj, struct attribute_group *attr_group)
+static struct hw_stats_device_data *
+alloc_hw_stats_device(struct ib_device *ibdev)
 {
-	struct attribute **attr;
+	struct hw_stats_device_data *data;
+	struct rdma_hw_stats *stats;
+
+	if (!ibdev->ops.alloc_hw_device_stats)
+		return ERR_PTR(-EOPNOTSUPP);
+	stats = ibdev->ops.alloc_hw_device_stats(ibdev);
+	if (!stats)
+		return ERR_PTR(-ENOMEM);
+	if (!stats->names || stats->num_counters <= 0)
+		goto err_free_stats;
+
+	/*
+	 * Two extra attribue elements here, one for the lifespan entry and
+	 * one to NULL terminate the list for the sysfs core code
+	 */
+	data = kzalloc(struct_size(data, attrs, stats->num_counters + 1),
+		       GFP_KERNEL);
+	if (!data)
+		goto err_free_stats;
+	data->group.attrs = kcalloc(stats->num_counters + 2,
+				    sizeof(*data->group.attrs), GFP_KERNEL);
+	if (!data->group.attrs)
+		goto err_free_data;
 
-	sysfs_remove_group(kobj, attr_group);
+	mutex_init(&stats->lock);
+	data->group.name = "hw_counters";
+	data->stats = stats;
+	data->groups[0] = &data->group;
+	return data;
 
-	for (attr = attr_group->attrs; *attr; attr++)
-		kfree(*attr);
-	kfree(attr_group);
+err_free_data:
+	kfree(data);
+err_free_stats:
+	kfree(stats);
+	return ERR_PTR(-ENOMEM);
 }
 
-static struct attribute *alloc_hsa(int index, u32 port_num, const char *name)
+static void free_hw_stats_device(struct hw_stats_device_data *data)
 {
-	struct hw_stats_attribute *hsa;
+	kfree(data->group.attrs);
+	kfree(data->stats);
+	kfree(data);
+}
 
-	hsa = kmalloc(sizeof(*hsa), GFP_KERNEL);
-	if (!hsa)
-		return NULL;
+static int setup_hw_device_stats(struct ib_device *ibdev)
+{
+	struct hw_stats_device_attribute *attr;
+	struct hw_stats_device_data *data;
+	int i, ret;
 
-	hsa->attr.name = (char *)name;
-	hsa->attr.mode = S_IRUGO;
-	hsa->show = show_hw_stats;
-	hsa->store = NULL;
-	hsa->index = index;
-	hsa->port_num = port_num;
+	data = alloc_hw_stats_device(ibdev);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
 
-	return &hsa->attr;
-}
+	ret = ibdev->ops.get_hw_stats(ibdev, data->stats, 0,
+				      data->stats->num_counters);
+	if (ret != data->stats->num_counters) {
+		if (WARN_ON(ret >= 0))
+			ret = -EINVAL;
+		goto err_free;
+	}
 
-static struct attribute *alloc_hsa_lifespan(char *name, u32 port_num)
-{
-	struct hw_stats_attribute *hsa;
+	data->stats->timestamp = jiffies;
 
-	hsa = kmalloc(sizeof(*hsa), GFP_KERNEL);
-	if (!hsa)
-		return NULL;
+	for (i = 0; i < data->stats->num_counters; i++) {
+		attr = &data->attrs[i];
+		sysfs_attr_init(&attr->attr.attr);
+		attr->attr.attr.name = data->stats->names[i];
+		attr->attr.attr.mode = 0444;
+		attr->attr.show = hw_stat_device_show;
+		attr->show = show_hw_stats;
+		data->group.attrs[i] = &attr->attr.attr;
+	}
 
-	hsa->attr.name = name;
-	hsa->attr.mode = S_IWUSR | S_IRUGO;
-	hsa->show = show_stats_lifespan;
-	hsa->store = set_stats_lifespan;
-	hsa->index = 0;
-	hsa->port_num = port_num;
+	attr = &data->attrs[i];
+	sysfs_attr_init(&attr->attr.attr);
+	attr->attr.attr.name = "lifespan";
+	attr->attr.attr.mode = 0644;
+	attr->attr.show = hw_stat_device_show;
+	attr->show = show_stats_lifespan;
+	attr->attr.store = hw_stat_device_store;
+	attr->store = set_stats_lifespan;
+	data->group.attrs[i] = &attr->attr.attr;
+
+	ibdev->hw_stats_data = data;
+	ret = device_add_groups(&ibdev->dev, data->groups);
+	if (ret)
+		goto err_free;
+	return 0;
 
-	return &hsa->attr;
+err_free:
+	free_hw_stats_device(data);
+	ibdev->hw_stats_data = NULL;
+	return ret;
 }
 
-static void setup_hw_stats(struct ib_device *device, struct ib_port *port,
-			   u32 port_num)
+static void destroy_hw_device_stats(struct ib_device *ibdev)
 {
-	struct attribute_group *hsag;
+	if (!ibdev->hw_stats_data)
+		return;
+	device_remove_groups(&ibdev->dev, ibdev->hw_stats_data->groups);
+	free_hw_stats_device(ibdev->hw_stats_data);
+	ibdev->hw_stats_data = NULL;
+}
+
+static struct hw_stats_port_data *alloc_hw_stats_port(struct ib_port *port)
+{
+	struct ib_device *ibdev = port->ibdev;
+	struct hw_stats_port_data *data;
 	struct rdma_hw_stats *stats;
-	int i, ret;
 
-	if (port_num) {
-		if (!device->ops.alloc_hw_port_stats)
-			return;
-		stats = device->ops.alloc_hw_port_stats(device, port_num);
-	} else {
-		if (!device->ops.alloc_hw_device_stats)
-			return;
-		stats = device->ops.alloc_hw_device_stats(device);
-	}
+	if (!ibdev->ops.alloc_hw_port_stats)
+		return ERR_PTR(-EOPNOTSUPP);
+	stats = ibdev->ops.alloc_hw_port_stats(port->ibdev, port->port_num);
 	if (!stats)
-		return;
-
+		return ERR_PTR(-ENOMEM);
 	if (!stats->names || stats->num_counters <= 0)
 		goto err_free_stats;
 
@@ -1000,68 +1080,102 @@ static void setup_hw_stats(struct ib_device *device, struct ib_port *port,
 	 * Two extra attribue elements here, one for the lifespan entry and
 	 * one to NULL terminate the list for the sysfs core code
 	 */
-	hsag = kzalloc(sizeof(*hsag) +
-		       sizeof(void *) * (stats->num_counters + 2),
+	data = kzalloc(struct_size(data, attrs, stats->num_counters + 1),
 		       GFP_KERNEL);
-	if (!hsag)
+	if (!data)
 		goto err_free_stats;
+	data->group.attrs = kcalloc(stats->num_counters + 2,
+				    sizeof(*data->group.attrs), GFP_KERNEL);
+	if (!data->group.attrs)
+		goto err_free_data;
 
-	ret = device->ops.get_hw_stats(device, stats, port_num,
-				       stats->num_counters);
-	if (ret != stats->num_counters)
-		goto err_free_hsag;
+	mutex_init(&stats->lock);
+	data->group.name = "hw_counters";
+	data->stats = stats;
+	return data;
 
-	stats->timestamp = jiffies;
+err_free_data:
+	kfree(data);
+err_free_stats:
+	kfree(stats);
+	return ERR_PTR(-ENOMEM);
+}
 
-	hsag->name = "hw_counters";
-	hsag->attrs = (void *)hsag + sizeof(*hsag);
+static void free_hw_stats_port(struct hw_stats_port_data *data)
+{
+	kfree(data->group.attrs);
+	kfree(data->stats);
+	kfree(data);
+}
 
-	for (i = 0; i < stats->num_counters; i++) {
-		hsag->attrs[i] = alloc_hsa(i, port_num, stats->names[i]);
-		if (!hsag->attrs[i])
-			goto err;
-		sysfs_attr_init(hsag->attrs[i]);
-	}
+static int setup_hw_port_stats(struct ib_port *port)
+{
+	struct hw_stats_port_attribute *attr;
+	struct hw_stats_port_data *data;
+	int i, ret;
 
-	mutex_init(&stats->lock);
-	/* treat an error here as non-fatal */
-	hsag->attrs[i] = alloc_hsa_lifespan("lifespan", port_num);
-	if (hsag->attrs[i])
-		sysfs_attr_init(hsag->attrs[i]);
-
-	if (port) {
-		struct kobject *kobj = &port->kobj;
-		ret = sysfs_create_group(kobj, hsag);
-		if (ret)
-			goto err;
-		port->hw_stats_ag = hsag;
-		port->hw_stats = stats;
-	} else {
-		struct kobject *kobj = &device->dev.kobj;
-		ret = sysfs_create_group(kobj, hsag);
-		if (ret)
-			goto err;
-		device->hw_stats_ag = hsag;
-		device->hw_stats = stats;
+	data = alloc_hw_stats_port(port);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	ret = port->ibdev->ops.get_hw_stats(port->ibdev, data->stats,
+					    port->port_num,
+					    data->stats->num_counters);
+	if (ret != data->stats->num_counters) {
+		if (WARN_ON(ret >= 0))
+			ret = -EINVAL;
+		goto err_free;
+	}
+	data->stats->timestamp = jiffies;
+
+	for (i = 0; i < data->stats->num_counters; i++) {
+		attr = &data->attrs[i];
+		sysfs_attr_init(&attr->attr.attr);
+		attr->attr.attr.name = data->stats->names[i];
+		attr->attr.attr.mode = 0444;
+		attr->attr.show = hw_stat_port_show;
+		attr->show = show_hw_stats;
+		data->group.attrs[i] = &attr->attr.attr;
 	}
 
-	return;
+	attr = &data->attrs[i];
+	sysfs_attr_init(&attr->attr.attr);
+	attr->attr.attr.name = "lifespan";
+	attr->attr.attr.mode = 0644;
+	attr->attr.show = hw_stat_port_show;
+	attr->show = show_stats_lifespan;
+	attr->attr.store = hw_stat_port_store;
+	attr->store = set_stats_lifespan;
+	data->group.attrs[i] = &attr->attr.attr;
+
+	port->hw_stats_data = data;
+	ret = sysfs_create_group(&port->kobj, &data->group);
+	if (ret)
+		goto err_free;
+	return 0;
 
-err:
-	for (; i >= 0; i--)
-		kfree(hsag->attrs[i]);
-err_free_hsag:
-	kfree(hsag);
-err_free_stats:
-	kfree(stats);
+err_free:
+	free_hw_stats_port(data);
+	port->hw_stats_data = NULL;
+	return ret;
+}
+
+static void destroy_hw_port_stats(struct ib_port *port)
+{
+	if (!port->hw_stats_data)
+		return;
+	sysfs_remove_group(&port->kobj, &port->hw_stats_data->group);
+	free_hw_stats_port(port->hw_stats_data);
+	port->hw_stats_data = NULL;
 }
 
 struct rdma_hw_stats *ib_get_hw_stats_port(struct ib_device *ibdev,
 					   u32 port_num)
 {
-	if (!ibdev->port_data || !rdma_is_port_valid(ibdev, port_num))
+	if (!ibdev->port_data || !rdma_is_port_valid(ibdev, port_num) ||
+	    !ibdev->port_data[port_num].sysfs->hw_stats_data)
 		return NULL;
-	return ibdev->port_data[port_num].sysfs->hw_stats;
+	return ibdev->port_data[port_num].sysfs->hw_stats_data->stats;
 }
 
 static int add_port(struct ib_core_device *coredev, int port_num)
@@ -1166,21 +1280,23 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 			goto err_free_pkey;
 	}
 
+	/*
+	 * If port == 0, it means hw_counters are per device and not per
+	 * port, so holder should be device. Therefore skip per port
+	 * counter initialization.
+	 */
+	if (port_num && is_full_dev) {
+		ret = setup_hw_port_stats(p);
+		if (ret && ret != -EOPNOTSUPP)
+			goto err_remove_pkey;
+	}
 
 	if (device->ops.init_port && is_full_dev) {
 		ret = device->ops.init_port(device, port_num, &p->kobj);
 		if (ret)
-			goto err_remove_pkey;
+			goto err_remove_stats;
 	}
 
-	/*
-	 * If port == 0, it means hw_counters are per device and not per
-	 * port, so holder should be device. Therefore skip per port conunter
-	 * initialization.
-	 */
-	if (device->ops.alloc_hw_port_stats && port_num && is_full_dev)
-		setup_hw_stats(device, p, port_num);
-
 	list_add_tail(&p->kobj.entry, &coredev->port_list);
 	if (device->port_data && is_full_dev)
 		device->port_data[port_num].sysfs = p;
@@ -1188,6 +1304,9 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	kobject_uevent(&p->kobj, KOBJ_ADD);
 	return 0;
 
+err_remove_stats:
+	destroy_hw_port_stats(p);
+
 err_remove_pkey:
 	if (p->pkey_group)
 		sysfs_remove_group(&p->kobj, p->pkey_group);
@@ -1370,9 +1489,7 @@ void ib_free_port_attrs(struct ib_core_device *coredev)
 		struct ib_port *port = container_of(p, struct ib_port, kobj);
 
 		list_del(&p->entry);
-		if (port->hw_stats_ag)
-			free_hsag(&port->kobj, port->hw_stats_ag);
-		kfree(port->hw_stats);
+		destroy_hw_port_stats(port);
 		if (device->port_data && is_full_dev)
 			device->port_data[port->port_num].sysfs = NULL;
 
@@ -1424,18 +1541,18 @@ int ib_device_register_sysfs(struct ib_device *device)
 	if (ret)
 		return ret;
 
-	if (device->ops.alloc_hw_device_stats)
-		setup_hw_stats(device, NULL, 0);
+	ret = setup_hw_device_stats(device);
+	if (ret && ret != -EOPNOTSUPP) {
+		ib_free_port_attrs(&device->coredev);
+		return ret;
+	}
 
 	return 0;
 }
 
 void ib_device_unregister_sysfs(struct ib_device *device)
 {
-	if (device->hw_stats_ag)
-		free_hsag(&device->dev.kobj, device->hw_stats_ag);
-	kfree(device->hw_stats);
-
+	destroy_hw_device_stats(device);
 	ib_free_port_attrs(&device->coredev);
 }
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index e3be93e7096616..53eba744ad8fb6 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -51,6 +51,7 @@ struct ib_usrq_object;
 struct ib_uwq_object;
 struct rdma_cm_id;
 struct ib_port;
+struct hw_stats_device_data;
 
 extern struct workqueue_struct *ib_wq;
 extern struct workqueue_struct *ib_comp_wq;
@@ -2696,8 +2697,7 @@ struct ib_device {
 	u8                           node_type;
 	u32			     phys_port_cnt;
 	struct ib_device_attr        attrs;
-	struct attribute_group	     *hw_stats_ag;
-	struct rdma_hw_stats         *hw_stats;
+	struct hw_stats_device_data *hw_stats_data;
 
 #ifdef CONFIG_CGROUP_RDMA
 	struct rdmacg_device         cg_device;
-- 
2.31.1

