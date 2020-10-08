Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8CB286CD3
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 04:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgJHCgr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Oct 2020 22:36:47 -0400
Received: from smtprelay0169.hostedemail.com ([216.40.44.169]:35518 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727698AbgJHCgr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Oct 2020 22:36:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id CE748100E7B45;
        Thu,  8 Oct 2020 02:36:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:2:41:69:355:379:541:800:960:968:973:982:988:989:1260:1311:1314:1345:1359:1515:1535:1605:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3876:3877:4049:4118:4321:5007:6114:6261:6642:10004:10848:11026:11473:11657:11658:11914:12043:12048:12296:12297:12438:12555:12895:12986:13894:14394:21080:21627:21990:30029:30045:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: tramp20_270d61a271d4
X-Filterd-Recvd-Size: 7627
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu,  8 Oct 2020 02:36:44 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 2/4] RDMA: Convert sysfs kobject * show functions to use sysfs_emit()
Date:   Wed,  7 Oct 2020 19:36:25 -0700
Message-Id: <7761c1efaebb96c432c85171d58405c25a824ccd.1602122880.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1602122879.git.joe@perches.com>
References: <cover.1602122879.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Done with cocci script:

@@
identifier k_show;
identifier arg1, arg2, arg3;
@@
ssize_t k_show(struct kobject *
-	arg1
+	kobj
	, struct kobj_attribute *
-	arg2
+	attr
	, char *
-	arg3
+	buf
	)
{
	...
(
-	arg1
+	kobj
|
-	arg2
+	attr
|
-	arg3
+	buf
)
	...
}

@@
identifier k_show;
identifier kobj, attr, buf;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
	return
-	sprintf(buf,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier k_show;
identifier kobj, attr, buf;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
	return
-	snprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier k_show;
identifier kobj, attr, buf;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
	return
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier k_show;
identifier kobj, attr, buf;
expression chr;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
	return
-	strcpy(buf, chr);
+	sysfs_emit(buf, chr);
	...>
}

@@
identifier k_show;
identifier kobj, attr, buf;
identifier len;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
	len =
-	sprintf(buf,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier k_show;
identifier kobj, attr, buf;
identifier len;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
	len =
-	snprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier k_show;
identifier kobj, attr, buf;
identifier len;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
	len =
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier k_show;
identifier kobj, attr, buf;
identifier len;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
-	len += scnprintf(buf + len, PAGE_SIZE - len,
+	len += sysfs_emit_at(buf, len,
	...);
	...>
	return len;
}

@@
identifier k_show;
identifier kobj, attr, buf;
expression chr;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	...
-	strcpy(buf, chr);
-	return strlen(buf);
+	return sysfs_emit(buf, chr);
}

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 26 ++++++++++----------
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 14 +++++------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index 7f71f10126fc..0c767582286b 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -187,9 +187,9 @@ static ssize_t rtrs_clt_state_show(struct kobject *kobj,
 
 	sess = container_of(kobj, struct rtrs_clt_sess, kobj);
 	if (sess->state == RTRS_CLT_CONNECTED)
-		return sprintf(page, "connected\n");
+		return sysfs_emit(page, "connected\n");
 
-	return sprintf(page, "disconnected\n");
+	return sysfs_emit(page, "disconnected\n");
 }
 
 static struct kobj_attribute rtrs_clt_state_attr =
@@ -197,10 +197,10 @@ static struct kobj_attribute rtrs_clt_state_attr =
 
 static ssize_t rtrs_clt_reconnect_show(struct kobject *kobj,
 					struct kobj_attribute *attr,
-					char *page)
+					char *buf)
 {
-	return scnprintf(page, PAGE_SIZE, "Usage: echo 1 > %s\n",
-			 attr->attr.name);
+	return sysfs_emit(buf, "Usage: echo 1 > %s\n",
+			  attr->attr.name);
 }
 
 static ssize_t rtrs_clt_reconnect_store(struct kobject *kobj,
@@ -229,10 +229,10 @@ static struct kobj_attribute rtrs_clt_reconnect_attr =
 
 static ssize_t rtrs_clt_disconnect_show(struct kobject *kobj,
 					 struct kobj_attribute *attr,
-					 char *page)
+					 char *buf)
 {
-	return scnprintf(page, PAGE_SIZE, "Usage: echo 1 > %s\n",
-			 attr->attr.name);
+	return sysfs_emit(buf, "Usage: echo 1 > %s\n",
+			  attr->attr.name);
 }
 
 static ssize_t rtrs_clt_disconnect_store(struct kobject *kobj,
@@ -261,10 +261,10 @@ static struct kobj_attribute rtrs_clt_disconnect_attr =
 
 static ssize_t rtrs_clt_remove_path_show(struct kobject *kobj,
 					  struct kobj_attribute *attr,
-					  char *page)
+					  char *buf)
 {
-	return scnprintf(page, PAGE_SIZE, "Usage: echo 1 > %s\n",
-			 attr->attr.name);
+	return sysfs_emit(buf, "Usage: echo 1 > %s\n",
+			  attr->attr.name);
 }
 
 static ssize_t rtrs_clt_remove_path_store(struct kobject *kobj,
@@ -327,7 +327,7 @@ static ssize_t rtrs_clt_hca_port_show(struct kobject *kobj,
 
 	sess = container_of(kobj, typeof(*sess), kobj);
 
-	return scnprintf(page, PAGE_SIZE, "%u\n", sess->hca_port);
+	return sysfs_emit(page, "%u\n", sess->hca_port);
 }
 
 static struct kobj_attribute rtrs_clt_hca_port_attr =
@@ -341,7 +341,7 @@ static ssize_t rtrs_clt_hca_name_show(struct kobject *kobj,
 
 	sess = container_of(kobj, struct rtrs_clt_sess, kobj);
 
-	return scnprintf(page, PAGE_SIZE, "%s\n", sess->hca_name);
+	return sysfs_emit(page, "%s\n", sess->hca_name);
 }
 
 static struct kobj_attribute rtrs_clt_hca_name_attr =
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index 07fbb063555d..381a776ce404 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -28,10 +28,10 @@ static struct kobj_type ktype = {
 
 static ssize_t rtrs_srv_disconnect_show(struct kobject *kobj,
 					 struct kobj_attribute *attr,
-					 char *page)
+					 char *buf)
 {
-	return scnprintf(page, PAGE_SIZE, "Usage: echo 1 > %s\n",
-			 attr->attr.name);
+	return sysfs_emit(buf, "Usage: echo 1 > %s\n",
+			  attr->attr.name);
 }
 
 static ssize_t rtrs_srv_disconnect_store(struct kobject *kobj,
@@ -72,8 +72,8 @@ static ssize_t rtrs_srv_hca_port_show(struct kobject *kobj,
 	sess = container_of(kobj, typeof(*sess), kobj);
 	usr_con = sess->s.con[0];
 
-	return scnprintf(page, PAGE_SIZE, "%u\n",
-			 usr_con->cm_id->port_num);
+	return sysfs_emit(page, "%u\n",
+			  usr_con->cm_id->port_num);
 }
 
 static struct kobj_attribute rtrs_srv_hca_port_attr =
@@ -87,8 +87,8 @@ static ssize_t rtrs_srv_hca_name_show(struct kobject *kobj,
 
 	sess = container_of(kobj, struct rtrs_srv_sess, kobj);
 
-	return scnprintf(page, PAGE_SIZE, "%s\n",
-			 sess->s.dev->ib_dev->name);
+	return sysfs_emit(page, "%s\n",
+			  sess->s.dev->ib_dev->name);
 }
 
 static struct kobj_attribute rtrs_srv_hca_name_attr =
-- 
2.26.0

