Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22EC383A6F
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 18:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240841AbhEQQtv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 12:49:51 -0400
Received: from mail-mw2nam10on2063.outbound.protection.outlook.com ([40.107.94.63]:14656
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235813AbhEQQtd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 12:49:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6Ji2xrkEb/157eaohtiRQcEnCGz1GqkGnA3rrx6FYuvmzlw1lULjM8+L+0T7OqrGcRpV743jJJNSCllkTcaCWjZ88DaqP9Q1NHwRU5FV1Oka+M3QXtPczv0YSMIRjPg/3Gh8jiU68riP8DC+lBFEeVFUIEHRIJFP4pPooV7BdbS/lUmU/w9gqbsOYuH/v1L9m576UQXcg5pxViXFj33Ay7IUM8WkT0Jqe35z9e51RwNKc+QAagzaCUn23+sdYNZl9HAIq8amMVjga0YpjlKwlZt3R//PqH31cvE6dGvt350W+zK+B4gXVAb8MTXlEfZqexW4Ru1+fMjFzb7FlTxzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yYlQCcKHAr+nIE2geBtLE58lcutW1vmW8LTNoMT9bo=;
 b=dGNLS1RPd8hrcGKOAWwV0bo4ksi9QYl4cTJQHd799KvWo8+v51Y9mxW3BdRka/v9RiqoeuJJaDm/U5qEi+XyZtZCERs8xC64HDzKeeq6eaZJJsJKK0TC/lYlbjGQxtaN5BS2GkNoqcZdX+k0pyBDemwx5kmBSVHAP2bEYJh+WaLy5SdkmUtRAXoqY+hpfJqSUNh169JyRnpCmxhGYz35dSwiOlH3XDlO3rgJf/xt18SC9vosWWaI2rahDO3pJ+MBamYfSc7Is+wXMVrM96x3DQeZFveiia/1UhbDcSN7FpB0M/97C06Fn4/Djto1MWaYUqLJvHHlJriaJj8N7IVNvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yYlQCcKHAr+nIE2geBtLE58lcutW1vmW8LTNoMT9bo=;
 b=fWJ3RinVn7x3qjlAlgKc0ROKP8NRZMdmTOxFSZRUca/QQqsPHSU8nx2vB+Hq+NQ27QFw3mvFHkLKyJPR/ZCnvSCOJE6P5ki9LjSdQMBAoYIAaHb3fgwtyIkuNPxSvgVIFQr4NOijASNnMuEs2qiGBD0hQkD12z3dr+GDM5sZfdGRMlYvv1Abl4dif/6zpYGfk6PQ18c9MACpfTXcTDjWFR+scYdzzAAj8oPhG8rkh66gTKQ0egXC72McgyS1HGYTtdSq1IpqnA0lDIEtUJMk/jYJSa3zBy/h1+dEQantnxh1HZ+gYniGC04PhSDabcZ4XqU9o65mTHvFEA2Sqx0e7Q==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 16:47:49 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 16:47:49 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 09/13] RDMA/core: Expose the ib port sysfs attribute machinery
Date:   Mon, 17 May 2021 13:47:37 -0300
Message-Id: <9-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
In-Reply-To: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:208:236::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR05CA0056.namprd05.prod.outlook.com (2603:10b6:208:236::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Mon, 17 May 2021 16:47:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ligP8-009LYs-3g; Mon, 17 May 2021 13:47:42 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1424f5ae-3fa1-4406-964e-08d919537f5e
X-MS-TrafficTypeDiagnostic: DM6PR12MB2858:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28581B0E771D3F205727D106C22D9@DM6PR12MB2858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKIPY7qpIxKY3Feohr3oqzfANAm7iExpyw8NipB2Y9KILwja9ar9mHLLFAWDlSq/2h6He+sb+4rktyfeU+HbHruIV+4qlFksa0bunJjU8z/He9Ocmh5WVBpU+yv6QzB8ZwkuKRBGXhMz5o/ZtOXB0GrjFiNC+IdJFvgCSmm01ClqKyPDP9IQUJtsRxcPx2+jlta9XJ+Z+6VFuKnSJ1NC2ZEVAers1Kujb+QF7MxsFgqt8s8AmmlxqiiQWdB58/nimc4x28wjWPbmOG1VGL14Sj++7/t0LN6c25ZbrFdf/8udPjlDSZtu0s+/SAfnhnlbimWlKCr6icQZxzV0fwsYxGCym6pqi8yYGCk8s9rQ3htipJ8ATNlxawfr/CwiPXfih5zYwi6O0f92DTfrmpXKcZIcjSKdjpskP/BZFFKCRovgLz+CgRY77EBdMCTFVqZKkFEdXjHu9aph8tB/8EhxpTy9Lati50+KuCt8CnqLSD/gEs4kBIXHJJrnF0B+yqK1luZJ4cZdkHJcpd/W8OuQdpzyukJOjXEHz2afBHnoOTY9YuioLLSTNLPy6BL4D/jXNtGch45QfbsGPpXU87NiVm3rDH26JGytcGyZZagGH99NyUEkqCWks7PjIetk5huuC3yVTccXDMSrcpYkAOBPxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(54906003)(6666004)(9746002)(8676002)(66556008)(426003)(83380400001)(36756003)(30864003)(9786002)(26005)(66946007)(38100700002)(316002)(66476007)(4326008)(478600001)(86362001)(5660300002)(186003)(8936002)(2616005)(2906002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KzZERGvslN5QOVHswG+nNxozNopVGonvk2Ke0di/lLDM67iLv0dWlGlGucMe?=
 =?us-ascii?Q?F4deTSHT/moyiPR7lvbb72m1H9S/zZsXrXPsUOMvO6a1g1dCzwr5+2opQuNQ?=
 =?us-ascii?Q?lKuoqCzyxqMZXhjDb2rTcCelQExdU1p/EFZ0KiXhICUE0A7R/HGqHpdAFjBK?=
 =?us-ascii?Q?mAe5zsGV7JTkdu4wFXED7UtN9dLuLcQtd+acDd+9eHAyX8v6pkOBNhon099O?=
 =?us-ascii?Q?FzWcrbicqC3ZdesN1Gs9XTP4gxX0kaJF/XXtoPaOiJI6S99dtcG5ZLe7VRWh?=
 =?us-ascii?Q?2dnA1NieiZV9bnaZaEGxF1rwDr4i0oN3bl3HZBqzWGVmxMEe74aKvVjTQEBY?=
 =?us-ascii?Q?8UumOe/vO7mvEfW84t5wgr6C7LLkzvSO3qE/niOZE5BEuOj3sqDSfgHPvabl?=
 =?us-ascii?Q?MA21O8uoTEH3g5pZZxabvjhMKko8aVgvP6cABbmgg5+TC2dtf4H4kdgYztX5?=
 =?us-ascii?Q?WIyA1bl0QhiNlYPpsf4jN6t4mRjxnbCnmLPTqL1OPc89mlTulFMFyAnEN50l?=
 =?us-ascii?Q?y9wYQp3mGYmuYVmy1YyCMA/07wbnbQjk648VhEXdPEYMjbUjaQakP/PLqaSU?=
 =?us-ascii?Q?9Tm5qKbxwgYYfxOv0ApRAGb/uczsCmpJ9Y4ud359C40IlAvCgYIn8+BQZkWm?=
 =?us-ascii?Q?JLX+xC667xRdvUBDB0G90vbBGzOQ5muUWkp67nK08laJSmsg37q+dbnMV2e0?=
 =?us-ascii?Q?B/s06iCYoI/JXA8bC2110emf5zwpPCv0d8gQZIgeehiaxRUG6NbTr4qgmerr?=
 =?us-ascii?Q?tTe2czArn1nEd0ZmlwgatuK/w1PuosMKcj7YZlpusLj8/t48RXhv/YtvZPe+?=
 =?us-ascii?Q?vUM/A0Mjve+szpH4YgtHwSNvmxMMSvnagFBzzXwDsfl1owXnGktSTZGz7+Fk?=
 =?us-ascii?Q?PApziKeh5SDTiSbpldkN10LACqrF5XZcunP94Rh2xHXiFtT2EIa+RIIgpUzz?=
 =?us-ascii?Q?OgXP1nlBC58DDk3O7njRs66Q+zO36t7yb60PM+1UoHIc7TbGYb8KIOEbn81S?=
 =?us-ascii?Q?rPSHlHXxDRE4oi94KxX/jZa8IcCCXlROurSHXXYjk4Oenm7/gqtSakdhjYR4?=
 =?us-ascii?Q?DVESIScBwRy4wYtcY6y/20/hdmgc6ddTlFGvpazTnGto1mm03rTvcUlCDZt+?=
 =?us-ascii?Q?NO1NMKcZfXR0GM+S7o1uyc1Hps4q2fXlWERaX+yfEr/83S6EaBtjvjrHn7TG?=
 =?us-ascii?Q?e74mZNysewrRLEytmX/CdTX8WkFTdw5CdzSd5iB0UfA09zK5tsJvndU4fv2f?=
 =?us-ascii?Q?No8CdN4A0T8XIpawLYK/NMOOWyI5o8CCTd4aucdufgSo00g02l5gfW0o4ec2?=
 =?us-ascii?Q?YPCXmqTqEMfrX3wdNd+2vXnC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1424f5ae-3fa1-4406-964e-08d919537f5e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 16:47:46.2569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtj2o5teI7tjrONI2WxoM49Pvdh0a7VbosWjhJ8yyOQGQ7JzsRSgrJ8m884efs0M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2858
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Other things outside the core code are creating attributes against the
port. This patch exposes the basic machinery to do this.

The ib_port_attribute type allows creating groups of attributes attatched
to the port and comes with the usual machinery to do this.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/sysfs.c | 217 +++++++++++++++++---------------
 include/rdma/ib_sysfs.h         |  41 ++++++
 2 files changed, 158 insertions(+), 100 deletions(-)
 create mode 100644 include/rdma/ib_sysfs.h

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index ce6aecbb5a7616..58a45548bf1568 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -44,24 +44,10 @@
 #include <rdma/ib_pma.h>
 #include <rdma/ib_cache.h>
 #include <rdma/rdma_counter.h>
-
-struct ib_port;
-
-struct port_attribute {
-	struct attribute attr;
-	ssize_t (*show)(struct ib_port *, struct port_attribute *, char *buf);
-	ssize_t (*store)(struct ib_port *, struct port_attribute *,
-			 const char *buf, size_t count);
-};
-
-#define PORT_ATTR(_name, _mode, _show, _store) \
-struct port_attribute port_attr_##_name = __ATTR(_name, _mode, _show, _store)
-
-#define PORT_ATTR_RO(_name) \
-struct port_attribute port_attr_##_name = __ATTR_RO(_name)
+#include <rdma/ib_sysfs.h>
 
 struct port_table_attribute {
-	struct port_attribute	attr;
+	struct ib_port_attribute attr;
 	char			name[8];
 	int			index;
 	__be16			attr_id;
@@ -97,7 +83,7 @@ struct hw_stats_device_attribute {
 };
 
 struct hw_stats_port_attribute {
-	struct port_attribute attr;
+	struct ib_port_attribute attr;
 	ssize_t (*show)(struct ib_device *ibdev, struct rdma_hw_stats *stats,
 			unsigned int index, unsigned int port_num, char *buf);
 	ssize_t (*store)(struct ib_device *ibdev, struct rdma_hw_stats *stats,
@@ -119,29 +105,55 @@ struct hw_stats_port_data {
 static ssize_t port_attr_show(struct kobject *kobj,
 			      struct attribute *attr, char *buf)
 {
-	struct port_attribute *port_attr =
-		container_of(attr, struct port_attribute, attr);
+	struct ib_port_attribute *port_attr =
+		container_of(attr, struct ib_port_attribute, attr);
 	struct ib_port *p = container_of(kobj, struct ib_port, kobj);
 
 	if (!port_attr->show)
 		return -EIO;
 
-	return port_attr->show(p, port_attr, buf);
+	return port_attr->show(p->ibdev, p->port_num, port_attr, buf);
 }
 
 static ssize_t port_attr_store(struct kobject *kobj,
 			       struct attribute *attr,
 			       const char *buf, size_t count)
 {
-	struct port_attribute *port_attr =
-		container_of(attr, struct port_attribute, attr);
+	struct ib_port_attribute *port_attr =
+		container_of(attr, struct ib_port_attribute, attr);
 	struct ib_port *p = container_of(kobj, struct ib_port, kobj);
 
 	if (!port_attr->store)
 		return -EIO;
-	return port_attr->store(p, port_attr, buf, count);
+	return port_attr->store(p->ibdev, p->port_num, port_attr, buf, count);
 }
 
+int ib_port_sysfs_create_groups(struct ib_device *ibdev, u32 port_num,
+				const struct attribute_group **groups)
+{
+	return sysfs_create_groups(&ibdev->port_data[port_num].sysfs->kobj,
+				   groups);
+}
+EXPORT_SYMBOL(ib_port_sysfs_create_groups);
+
+void ib_port_sysfs_remove_groups(struct ib_device *ibdev, u32 port_num,
+				 const struct attribute_group **groups)
+{
+	return sysfs_remove_groups(&ibdev->port_data[port_num].sysfs->kobj,
+				   groups);
+}
+EXPORT_SYMBOL(ib_port_sysfs_remove_groups);
+
+struct ib_device *ib_port_sysfs_get_ibdev_kobj(struct kobject *kobj,
+					       u32 *port_num)
+{
+	struct ib_port *port = container_of(kobj, struct ib_port, kobj);
+
+	*port_num = port->port_num;
+	return port->ibdev;
+}
+EXPORT_SYMBOL(ib_port_sysfs_get_ibdev_kobj);
+
 static const struct sysfs_ops port_sysfs_ops = {
 	.show	= port_attr_show,
 	.store	= port_attr_store
@@ -171,25 +183,27 @@ static ssize_t hw_stat_device_store(struct device *dev,
 				count);
 }
 
-static ssize_t hw_stat_port_show(struct ib_port *port,
-				 struct port_attribute *attr, char *buf)
+static ssize_t hw_stat_port_show(struct ib_device *ibdev, u32 port_num,
+				 struct ib_port_attribute *attr, char *buf)
 {
 	struct hw_stats_port_attribute *stat_attr =
 		container_of(attr, struct hw_stats_port_attribute, attr);
+	struct ib_port *port = ibdev->port_data[port_num].sysfs;
 
-	return stat_attr->show(port->ibdev, port->hw_stats_data->stats,
+	return stat_attr->show(ibdev, port->hw_stats_data->stats,
 			       stat_attr - port->hw_stats_data->attrs,
 			       port->port_num, buf);
 }
 
-static ssize_t hw_stat_port_store(struct ib_port *port,
-				  struct port_attribute *attr, const char *buf,
-				  size_t count)
+static ssize_t hw_stat_port_store(struct ib_device *ibdev, u32 port_num,
+				  struct ib_port_attribute *attr,
+				  const char *buf, size_t count)
 {
 	struct hw_stats_port_attribute *stat_attr =
 		container_of(attr, struct hw_stats_port_attribute, attr);
+	struct ib_port *port = ibdev->port_data[port_num].sysfs;
 
-	return stat_attr->store(port->ibdev, port->hw_stats_data->stats,
+	return stat_attr->store(ibdev, port->hw_stats_data->stats,
 				stat_attr - port->hw_stats_data->attrs,
 				port->port_num, buf, count);
 }
@@ -197,23 +211,23 @@ static ssize_t hw_stat_port_store(struct ib_port *port,
 static ssize_t gid_attr_show(struct kobject *kobj,
 			     struct attribute *attr, char *buf)
 {
-	struct port_attribute *port_attr =
-		container_of(attr, struct port_attribute, attr);
+	struct ib_port_attribute *port_attr =
+		container_of(attr, struct ib_port_attribute, attr);
 	struct ib_port *p = container_of(kobj, struct gid_attr_group,
 					 kobj)->port;
 
 	if (!port_attr->show)
 		return -EIO;
 
-	return port_attr->show(p, port_attr, buf);
+	return port_attr->show(p->ibdev, p->port_num, port_attr, buf);
 }
 
 static const struct sysfs_ops gid_attr_sysfs_ops = {
 	.show = gid_attr_show
 };
 
-static ssize_t state_show(struct ib_port *p, struct port_attribute *unused,
-			  char *buf)
+static ssize_t state_show(struct ib_device *ibdev, u32 port_num,
+			  struct ib_port_attribute *unused, char *buf)
 {
 	struct ib_port_attr attr;
 	ssize_t ret;
@@ -227,7 +241,7 @@ static ssize_t state_show(struct ib_port *p, struct port_attribute *unused,
 		[IB_PORT_ACTIVE_DEFER]	= "ACTIVE_DEFER"
 	};
 
-	ret = ib_query_port(p->ibdev, p->port_num, &attr);
+	ret = ib_query_port(ibdev, port_num, &attr);
 	if (ret)
 		return ret;
 
@@ -238,81 +252,80 @@ static ssize_t state_show(struct ib_port *p, struct port_attribute *unused,
 				  "UNKNOWN");
 }
 
-static ssize_t lid_show(struct ib_port *p, struct port_attribute *unused,
-			char *buf)
+static ssize_t lid_show(struct ib_device *ibdev, u32 port_num,
+			struct ib_port_attribute *unused, char *buf)
 {
 	struct ib_port_attr attr;
 	ssize_t ret;
 
-	ret = ib_query_port(p->ibdev, p->port_num, &attr);
+	ret = ib_query_port(ibdev, port_num, &attr);
 	if (ret)
 		return ret;
 
 	return sysfs_emit(buf, "0x%x\n", attr.lid);
 }
 
-static ssize_t lid_mask_count_show(struct ib_port *p,
-				   struct port_attribute *unused,
-				   char *buf)
+static ssize_t lid_mask_count_show(struct ib_device *ibdev, u32 port_num,
+				   struct ib_port_attribute *unused, char *buf)
 {
 	struct ib_port_attr attr;
 	ssize_t ret;
 
-	ret = ib_query_port(p->ibdev, p->port_num, &attr);
+	ret = ib_query_port(ibdev, port_num, &attr);
 	if (ret)
 		return ret;
 
 	return sysfs_emit(buf, "%d\n", attr.lmc);
 }
 
-static ssize_t sm_lid_show(struct ib_port *p, struct port_attribute *unused,
-			   char *buf)
+static ssize_t sm_lid_show(struct ib_device *ibdev, u32 port_num,
+			   struct ib_port_attribute *unused, char *buf)
 {
 	struct ib_port_attr attr;
 	ssize_t ret;
 
-	ret = ib_query_port(p->ibdev, p->port_num, &attr);
+	ret = ib_query_port(ibdev, port_num, &attr);
 	if (ret)
 		return ret;
 
 	return sysfs_emit(buf, "0x%x\n", attr.sm_lid);
 }
 
-static ssize_t sm_sl_show(struct ib_port *p, struct port_attribute *unused,
-			  char *buf)
+static ssize_t sm_sl_show(struct ib_device *ibdev, u32 port_num,
+			  struct ib_port_attribute *unused, char *buf)
 {
 	struct ib_port_attr attr;
 	ssize_t ret;
 
-	ret = ib_query_port(p->ibdev, p->port_num, &attr);
+	ret = ib_query_port(ibdev, port_num, &attr);
 	if (ret)
 		return ret;
 
 	return sysfs_emit(buf, "%d\n", attr.sm_sl);
 }
 
-static ssize_t cap_mask_show(struct ib_port *p, struct port_attribute *unused,
-			     char *buf)
+static ssize_t cap_mask_show(struct ib_device *ibdev, u32 port_num,
+			     struct ib_port_attribute *unused, char *buf)
 {
 	struct ib_port_attr attr;
 	ssize_t ret;
 
-	ret = ib_query_port(p->ibdev, p->port_num, &attr);
+	ret = ib_query_port(ibdev, port_num, &attr);
 	if (ret)
 		return ret;
 
 	return sysfs_emit(buf, "0x%08x\n", attr.port_cap_flags);
 }
 
-static ssize_t rate_show(struct ib_port *p, struct port_attribute *unused,
-			 char *buf)
+static ssize_t rate_show(struct ib_device *ibdev, u32 port_num,
+			 struct ib_port_attribute *unused, char *buf)
 {
 	struct ib_port_attr attr;
 	char *speed = "";
 	int rate;		/* in deci-Gb/sec */
 	ssize_t ret;
 
-	ret = ib_query_port(p->ibdev, p->port_num, &attr);
+	ret = ib_query_port(ibdev, port_num, &attr);
 	if (ret)
 		return ret;
 
@@ -379,14 +392,14 @@ static const char *phys_state_to_str(enum ib_port_phys_state phys_state)
 	return "<unknown>";
 }
 
-static ssize_t phys_state_show(struct ib_port *p, struct port_attribute *unused,
-			       char *buf)
+static ssize_t phys_state_show(struct ib_device *ibdev, u32 port_num,
+			       struct ib_port_attribute *unused, char *buf)
 {
 	struct ib_port_attr attr;
 
 	ssize_t ret;
 
-	ret = ib_query_port(p->ibdev, p->port_num, &attr);
+	ret = ib_query_port(ibdev, port_num, &attr);
 	if (ret)
 		return ret;
 
@@ -394,12 +407,12 @@ static ssize_t phys_state_show(struct ib_port *p, struct port_attribute *unused,
 			  phys_state_to_str(attr.phys_state));
 }
 
-static ssize_t link_layer_show(struct ib_port *p, struct port_attribute *unused,
-			       char *buf)
+static ssize_t link_layer_show(struct ib_device *ibdev, u32 port_num,
+			       struct ib_port_attribute *unused, char *buf)
 {
 	const char *output;
 
-	switch (rdma_port_get_link_layer(p->ibdev, p->port_num)) {
+	switch (rdma_port_get_link_layer(ibdev, port_num)) {
 	case IB_LINK_LAYER_INFINIBAND:
 		output = "InfiniBand";
 		break;
@@ -414,26 +427,26 @@ static ssize_t link_layer_show(struct ib_port *p, struct port_attribute *unused,
 	return sysfs_emit(buf, "%s\n", output);
 }
 
-static PORT_ATTR_RO(state);
-static PORT_ATTR_RO(lid);
-static PORT_ATTR_RO(lid_mask_count);
-static PORT_ATTR_RO(sm_lid);
-static PORT_ATTR_RO(sm_sl);
-static PORT_ATTR_RO(cap_mask);
-static PORT_ATTR_RO(rate);
-static PORT_ATTR_RO(phys_state);
-static PORT_ATTR_RO(link_layer);
+static IB_PORT_ATTR_RO(state);
+static IB_PORT_ATTR_RO(lid);
+static IB_PORT_ATTR_RO(lid_mask_count);
+static IB_PORT_ATTR_RO(sm_lid);
+static IB_PORT_ATTR_RO(sm_sl);
+static IB_PORT_ATTR_RO(cap_mask);
+static IB_PORT_ATTR_RO(rate);
+static IB_PORT_ATTR_RO(phys_state);
+static IB_PORT_ATTR_RO(link_layer);
 
 static struct attribute *port_default_attrs[] = {
-	&port_attr_state.attr,
-	&port_attr_lid.attr,
-	&port_attr_lid_mask_count.attr,
-	&port_attr_sm_lid.attr,
-	&port_attr_sm_sl.attr,
-	&port_attr_cap_mask.attr,
-	&port_attr_rate.attr,
-	&port_attr_phys_state.attr,
-	&port_attr_link_layer.attr,
+	&ib_port_attr_state.attr,
+	&ib_port_attr_lid.attr,
+	&ib_port_attr_lid_mask_count.attr,
+	&ib_port_attr_sm_lid.attr,
+	&ib_port_attr_sm_sl.attr,
+	&ib_port_attr_cap_mask.attr,
+	&ib_port_attr_rate.attr,
+	&ib_port_attr_phys_state.attr,
+	&ib_port_attr_link_layer.attr,
 	NULL
 };
 
@@ -457,7 +470,8 @@ static ssize_t print_gid_type(const struct ib_gid_attr *gid_attr, char *buf)
 }
 
 static ssize_t _show_port_gid_attr(
-	struct ib_port *p, struct port_attribute *attr, char *buf,
+	struct ib_device *ibdev, u32 port_num, struct ib_port_attribute *attr,
+	char *buf,
 	ssize_t (*print)(const struct ib_gid_attr *gid_attr, char *buf))
 {
 	struct port_table_attribute *tab_attr =
@@ -465,7 +479,7 @@ static ssize_t _show_port_gid_attr(
 	const struct ib_gid_attr *gid_attr;
 	ssize_t ret;
 
-	gid_attr = rdma_get_gid_attr(p->ibdev, p->port_num, tab_attr->index);
+	gid_attr = rdma_get_gid_attr(ibdev, port_num, tab_attr->index);
 	if (IS_ERR(gid_attr))
 		/* -EINVAL is returned for user space compatibility reasons. */
 		return -EINVAL;
@@ -475,15 +489,15 @@ static ssize_t _show_port_gid_attr(
 	return ret;
 }
 
-static ssize_t show_port_gid(struct ib_port *p, struct port_attribute *attr,
-			     char *buf)
+static ssize_t show_port_gid(struct ib_device *ibdev, u32 port_num,
+			     struct ib_port_attribute *attr, char *buf)
 {
 	struct port_table_attribute *tab_attr =
 		container_of(attr, struct port_table_attribute, attr);
 	const struct ib_gid_attr *gid_attr;
 	int len;
 
-	gid_attr = rdma_get_gid_attr(p->ibdev, p->port_num, tab_attr->index);
+	gid_attr = rdma_get_gid_attr(ibdev, port_num, tab_attr->index);
 	if (IS_ERR(gid_attr)) {
 		const union ib_gid zgid = {};
 
@@ -504,28 +518,30 @@ static ssize_t show_port_gid(struct ib_port *p, struct port_attribute *attr,
 	return len;
 }
 
-static ssize_t show_port_gid_attr_ndev(struct ib_port *p,
-				       struct port_attribute *attr, char *buf)
+static ssize_t show_port_gid_attr_ndev(struct ib_device *ibdev, u32 port_num,
+				       struct ib_port_attribute *attr,
+				       char *buf)
 {
-	return _show_port_gid_attr(p, attr, buf, print_ndev);
+	return _show_port_gid_attr(ibdev, port_num, attr, buf, print_ndev);
 }
 
-static ssize_t show_port_gid_attr_gid_type(struct ib_port *p,
-					   struct port_attribute *attr,
+static ssize_t show_port_gid_attr_gid_type(struct ib_device *ibdev,
+					   u32 port_num,
+					   struct ib_port_attribute *attr,
 					   char *buf)
 {
-	return _show_port_gid_attr(p, attr, buf, print_gid_type);
+	return _show_port_gid_attr(ibdev, port_num, attr, buf, print_gid_type);
 }
 
-static ssize_t show_port_pkey(struct ib_port *p, struct port_attribute *attr,
-			      char *buf)
+static ssize_t show_port_pkey(struct ib_device *ibdev, u32 port_num,
+			      struct ib_port_attribute *attr, char *buf)
 {
 	struct port_table_attribute *tab_attr =
 		container_of(attr, struct port_table_attribute, attr);
 	u16 pkey;
 	int ret;
 
-	ret = ib_query_pkey(p->ibdev, p->port_num, tab_attr->index, &pkey);
+	ret = ib_query_pkey(ibdev, port_num, tab_attr->index, &pkey);
 	if (ret)
 		return ret;
 
@@ -594,8 +610,8 @@ static int get_perf_mad(struct ib_device *dev, int port_num, __be16 attr,
 	return ret;
 }
 
-static ssize_t show_pma_counter(struct ib_port *p, struct port_attribute *attr,
-				char *buf)
+static ssize_t show_pma_counter(struct ib_device *ibdev, u32 port_num,
+				struct ib_port_attribute *attr, char *buf)
 {
 	struct port_table_attribute *tab_attr =
 		container_of(attr, struct port_table_attribute, attr);
@@ -605,7 +621,7 @@ static ssize_t show_pma_counter(struct ib_port *p, struct port_attribute *attr,
 	u8 data[8];
 	int len;
 
-	ret = get_perf_mad(p->ibdev, p->port_num, tab_attr->attr_id, &data,
+	ret = get_perf_mad(ibdev, port_num, tab_attr->attr_id, &data,
 			40 + offset / 8, sizeof(data));
 	if (ret < 0)
 		return ret;
@@ -1077,10 +1093,11 @@ struct rdma_hw_stats *ib_get_hw_stats_port(struct ib_device *ibdev,
 	return ibdev->port_data[port_num].sysfs->hw_stats_data->stats;
 }
 
-static int alloc_port_table_group(
-	const char *name, struct attribute_group *group,
-	struct port_table_attribute *attrs, size_t num,
-	ssize_t (*show)(struct ib_port *, struct port_attribute *, char *buf))
+static int
+alloc_port_table_group(const char *name, struct attribute_group *group,
+		       struct port_table_attribute *attrs, size_t num,
+		       ssize_t (*show)(struct ib_device *ibdev, u32 port_num,
+				       struct ib_port_attribute *, char *buf))
 {
 	struct attribute **attr_list;
 	int i;
diff --git a/include/rdma/ib_sysfs.h b/include/rdma/ib_sysfs.h
new file mode 100644
index 00000000000000..f869d0e4fd3030
--- /dev/null
+++ b/include/rdma/ib_sysfs.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (c) 2021 Mellanox Technologies Ltd.  All rights reserved.
+ */
+#ifndef DEF_RDMA_IB_SYSFS_H
+#define DEF_RDMA_IB_SYSFS_H
+
+#include <linux/sysfs.h>
+
+struct ib_device;
+
+struct ib_port_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct ib_device *ibdev, u32 port_num,
+			struct ib_port_attribute *attr, char *buf);
+	ssize_t (*store)(struct ib_device *ibdev, u32 port_num,
+			 struct ib_port_attribute *attr, const char *buf,
+			 size_t count);
+};
+
+#define IB_PORT_ATTR_RW(_name)                                                 \
+	struct ib_port_attribute ib_port_attr_##_name = __ATTR_RW(_name)
+
+#define IB_PORT_ATTR_ADMIN_RW(_name)                                           \
+	struct ib_port_attribute ib_port_attr_##_name =                        \
+		__ATTR_RW_MODE(_name, 0600)
+
+#define IB_PORT_ATTR_RO(_name)                                                 \
+	struct ib_port_attribute ib_port_attr_##_name = __ATTR_RO(_name)
+
+#define IB_PORT_ATTR_WO(_name)                                                 \
+	struct ib_port_attribute ib_port_attr_##_name = __ATTR_WO(_name)
+
+int ib_port_sysfs_create_groups(struct ib_device *ibdev, u32 port_num,
+				const struct attribute_group **groups);
+void ib_port_sysfs_remove_groups(struct ib_device *ibdev, u32 port_num,
+				 const struct attribute_group **groups);
+struct ib_device *ib_port_sysfs_get_ibdev_kobj(struct kobject *kobj,
+					       u32 *port_num);
+
+#endif
-- 
2.31.1

