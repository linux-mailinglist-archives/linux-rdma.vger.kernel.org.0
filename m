Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7153918F1
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 15:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhEZNhO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 May 2021 09:37:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:4014 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbhEZNhO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 May 2021 09:37:14 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FqsMy4cRszmYpW;
        Wed, 26 May 2021 21:33:18 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 21:35:39 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 21:35:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <bvanassche@acm.org>, <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] RDMA/srp: use DEVICE_ATTR_*() macro
Date:   Wed, 26 May 2021 21:35:37 +0800
Message-ID: <20210526133537.5544-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use DEVICE_ATTR_*() helper instead of plain DEVICE_ATTR,
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 90 ++++++++++++++---------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 31f8aa2c40ed..e8ae75ab672c 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2891,23 +2891,23 @@ static int srp_slave_configure(struct scsi_device *sdev)
 	return 0;
 }
 
-static ssize_t show_id_ext(struct device *dev, struct device_attribute *attr,
-			   char *buf)
+static ssize_t id_ext_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
 
 	return sysfs_emit(buf, "0x%016llx\n", be64_to_cpu(target->id_ext));
 }
 
-static ssize_t show_ioc_guid(struct device *dev, struct device_attribute *attr,
-			     char *buf)
+static ssize_t ioc_guid_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
 
 	return sysfs_emit(buf, "0x%016llx\n", be64_to_cpu(target->ioc_guid));
 }
 
-static ssize_t show_service_id(struct device *dev,
+static ssize_t service_id_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
@@ -2918,8 +2918,8 @@ static ssize_t show_service_id(struct device *dev,
 			  be64_to_cpu(target->ib_cm.service_id));
 }
 
-static ssize_t show_pkey(struct device *dev, struct device_attribute *attr,
-			 char *buf)
+static ssize_t pkey_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
 
@@ -2929,16 +2929,16 @@ static ssize_t show_pkey(struct device *dev, struct device_attribute *attr,
 	return sysfs_emit(buf, "0x%04x\n", be16_to_cpu(target->ib_cm.pkey));
 }
 
-static ssize_t show_sgid(struct device *dev, struct device_attribute *attr,
-			 char *buf)
+static ssize_t sgid_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
 
 	return sysfs_emit(buf, "%pI6\n", target->sgid.raw);
 }
 
-static ssize_t show_dgid(struct device *dev, struct device_attribute *attr,
-			 char *buf)
+static ssize_t dgid_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
 	struct srp_rdma_ch *ch = &target->ch[0];
@@ -2949,7 +2949,7 @@ static ssize_t show_dgid(struct device *dev, struct device_attribute *attr,
 	return sysfs_emit(buf, "%pI6\n", ch->ib_cm.path.dgid.raw);
 }
 
-static ssize_t show_orig_dgid(struct device *dev,
+static ssize_t orig_dgid_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
@@ -2960,7 +2960,7 @@ static ssize_t show_orig_dgid(struct device *dev,
 	return sysfs_emit(buf, "%pI6\n", target->ib_cm.orig_dgid.raw);
 }
 
-static ssize_t show_req_lim(struct device *dev,
+static ssize_t req_lim_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
@@ -2975,7 +2975,7 @@ static ssize_t show_req_lim(struct device *dev,
 	return sysfs_emit(buf, "%d\n", req_lim);
 }
 
-static ssize_t show_zero_req_lim(struct device *dev,
+static ssize_t zero_req_lim_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
@@ -2983,7 +2983,7 @@ static ssize_t show_zero_req_lim(struct device *dev,
 	return sysfs_emit(buf, "%d\n", target->zero_req_lim);
 }
 
-static ssize_t show_local_ib_port(struct device *dev,
+static ssize_t local_ib_port_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
@@ -2991,7 +2991,7 @@ static ssize_t show_local_ib_port(struct device *dev,
 	return sysfs_emit(buf, "%d\n", target->srp_host->port);
 }
 
-static ssize_t show_local_ib_device(struct device *dev,
+static ssize_t local_ib_device_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
@@ -3000,15 +3000,15 @@ static ssize_t show_local_ib_device(struct device *dev,
 			  dev_name(&target->srp_host->srp_dev->dev->dev));
 }
 
-static ssize_t show_ch_count(struct device *dev, struct device_attribute *attr,
-			     char *buf)
+static ssize_t ch_count_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
 
 	return sysfs_emit(buf, "%d\n", target->ch_count);
 }
 
-static ssize_t show_comp_vector(struct device *dev,
+static ssize_t comp_vector_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
@@ -3016,7 +3016,7 @@ static ssize_t show_comp_vector(struct device *dev,
 	return sysfs_emit(buf, "%d\n", target->comp_vector);
 }
 
-static ssize_t show_tl_retry_count(struct device *dev,
+static ssize_t tl_retry_count_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
@@ -3024,7 +3024,7 @@ static ssize_t show_tl_retry_count(struct device *dev,
 	return sysfs_emit(buf, "%d\n", target->tl_retry_count);
 }
 
-static ssize_t show_cmd_sg_entries(struct device *dev,
+static ssize_t cmd_sg_entries_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
@@ -3032,7 +3032,7 @@ static ssize_t show_cmd_sg_entries(struct device *dev,
 	return sysfs_emit(buf, "%u\n", target->cmd_sg_cnt);
 }
 
-static ssize_t show_allow_ext_sg(struct device *dev,
+static ssize_t allow_ext_sg_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
@@ -3040,22 +3040,22 @@ static ssize_t show_allow_ext_sg(struct device *dev,
 	return sysfs_emit(buf, "%s\n", target->allow_ext_sg ? "true" : "false");
 }
 
-static DEVICE_ATTR(id_ext,	    S_IRUGO, show_id_ext,	   NULL);
-static DEVICE_ATTR(ioc_guid,	    S_IRUGO, show_ioc_guid,	   NULL);
-static DEVICE_ATTR(service_id,	    S_IRUGO, show_service_id,	   NULL);
-static DEVICE_ATTR(pkey,	    S_IRUGO, show_pkey,		   NULL);
-static DEVICE_ATTR(sgid,	    S_IRUGO, show_sgid,		   NULL);
-static DEVICE_ATTR(dgid,	    S_IRUGO, show_dgid,		   NULL);
-static DEVICE_ATTR(orig_dgid,	    S_IRUGO, show_orig_dgid,	   NULL);
-static DEVICE_ATTR(req_lim,         S_IRUGO, show_req_lim,         NULL);
-static DEVICE_ATTR(zero_req_lim,    S_IRUGO, show_zero_req_lim,	   NULL);
-static DEVICE_ATTR(local_ib_port,   S_IRUGO, show_local_ib_port,   NULL);
-static DEVICE_ATTR(local_ib_device, S_IRUGO, show_local_ib_device, NULL);
-static DEVICE_ATTR(ch_count,        S_IRUGO, show_ch_count,        NULL);
-static DEVICE_ATTR(comp_vector,     S_IRUGO, show_comp_vector,     NULL);
-static DEVICE_ATTR(tl_retry_count,  S_IRUGO, show_tl_retry_count,  NULL);
-static DEVICE_ATTR(cmd_sg_entries,  S_IRUGO, show_cmd_sg_entries,  NULL);
-static DEVICE_ATTR(allow_ext_sg,    S_IRUGO, show_allow_ext_sg,    NULL);
+static DEVICE_ATTR_RO(id_ext);
+static DEVICE_ATTR_RO(ioc_guid);
+static DEVICE_ATTR_RO(service_id);
+static DEVICE_ATTR_RO(pkey);
+static DEVICE_ATTR_RO(sgid);
+static DEVICE_ATTR_RO(dgid);
+static DEVICE_ATTR_RO(orig_dgid);
+static DEVICE_ATTR_RO(req_lim);
+static DEVICE_ATTR_RO(zero_req_lim);
+static DEVICE_ATTR_RO(local_ib_port);
+static DEVICE_ATTR_RO(local_ib_device);
+static DEVICE_ATTR_RO(ch_count);
+static DEVICE_ATTR_RO(comp_vector);
+static DEVICE_ATTR_RO(tl_retry_count);
+static DEVICE_ATTR_RO(cmd_sg_entries);
+static DEVICE_ATTR_RO(allow_ext_sg);
 
 static struct device_attribute *srp_host_attrs[] = {
 	&dev_attr_id_ext,
@@ -3617,9 +3617,9 @@ static int srp_parse_options(struct net *net, const char *buf,
 	return ret;
 }
 
-static ssize_t srp_create_target(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf, size_t count)
+static ssize_t add_target_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
 {
 	struct srp_host *host =
 		container_of(dev, struct srp_host, dev);
@@ -3870,17 +3870,17 @@ static ssize_t srp_create_target(struct device *dev,
 	goto out;
 }
 
-static DEVICE_ATTR(add_target, S_IWUSR, NULL, srp_create_target);
+static DEVICE_ATTR_WO(add_target);
 
-static ssize_t show_ibdev(struct device *dev, struct device_attribute *attr,
-			  char *buf)
+static ssize_t ibdev_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
 {
 	struct srp_host *host = container_of(dev, struct srp_host, dev);
 
 	return sysfs_emit(buf, "%s\n", dev_name(&host->srp_dev->dev->dev));
 }
 
-static DEVICE_ATTR(ibdev, S_IRUGO, show_ibdev, NULL);
+static DEVICE_ATTR_RO(ibdev);
 
 static ssize_t show_port(struct device *dev, struct device_attribute *attr,
 			 char *buf)
-- 
2.17.1

