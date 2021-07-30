Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2F33DB934
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 15:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbhG3NSr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 09:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238960AbhG3NSr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Jul 2021 09:18:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AF1C061765
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 06:18:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z4so11301741wrv.11
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 06:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1I8y8GbTfIcLOGxJC+GhalbEZDN5CcEiTKmEbgcwKwY=;
        b=d8egKxtti9H3tqnaC55zcFNmddIpfKUsvlDqDAwntacFKaVLZjGa96DQAnOicwqEjk
         J3nJY90UPDZotvL2R6ICUtpHqsVvs+vWCfc0punQhVMOHDg6QPJcoK8Yrcf44z+FagCr
         p1BCJsJufg+kbBPq62pOuCWdcrkBHLnrzQN1fLsAGTv0W7SssCm+bUFAKXLPqGKJW8h/
         zmSR7LEL3n9BvvYdf+STl/aoB8/pWqgy42RoUOCXixm8jARnC7F1c05xH4VmSsneycHe
         vjrz1sCn3jwEP7osAMDUxCMaboC4pv43LvnC84+plmDuoQOTHrcCI21otLFBUr9XfR5T
         4htQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1I8y8GbTfIcLOGxJC+GhalbEZDN5CcEiTKmEbgcwKwY=;
        b=tJRgCXWYNGR+xBErYI6AJawS3iFLP1fTsVfeuaQKITLYg0YhsC7vShCYdM/0V+sK4D
         e6S3No7GiBG0jvdz32X6Ayjf09vwkE0uG3uaVgyQvd1Y//huz+DID6SfJNJ6F3hH9EpC
         BWfmJ3mYOPCZVq9sKCTWl+QNjgT97baDI9m8P+Pf7DCjOQf+bUyHJ2SG4VmyaFidiFNi
         6MLFagpUK2txUFjrhZIWaEoSd2b8KLcWFtDupny+1Q6k1uq2xuIt6xkoBWTS4SyoH9jn
         iaFD0zANoY5UT5K2OoQNhhA9NBheSNwxj0fn3EnswgJAt7/A8gLzfZMdo3ZbR9AiLqYt
         4x7g==
X-Gm-Message-State: AOAM533/5M60iKxf39MQFRrw7Y9L95p8fEvKLGDBWsximj1Kb2bUZftK
        R7jgHZA5hL1hmntWPFTZ9hw8dUc9T2JorQ==
X-Google-Smtp-Source: ABdhPJyBu2wHcHCVr0Za615l8Dc+tvB1/xcj41P8rUHIwdcZtPlzzArFCZA8UI0PcbFprLpF5/LR8g==
X-Received: by 2002:adf:f64b:: with SMTP id x11mr3025520wrp.155.1627651120721;
        Fri, 30 Jul 2021 06:18:40 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:496a:8500:4512:4a6e:16f3:2377])
        by smtp.gmail.com with ESMTPSA id z5sm1626012wmp.26.2021.07.30.06.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 06:18:40 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 09/10] RDMA/rtrs: Add support to disable an IB port on the storage side
Date:   Fri, 30 Jul 2021 15:18:31 +0200
Message-Id: <20210730131832.118865-10-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210730131832.118865-1-jinpu.wang@ionos.com>
References: <20210730131832.118865-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

This commit adds support to reject connection on a specific IB port which
can be specified in the added sysfs entry for the rtrs-server module.

Example,

$ echo "mlx4_0 1" > /sys/class/rtrs-server/ctl/disable_port

When a connection request is received on the above IB port, rtrs_srv
rejects the connection and notifies the client to disable reconnection
attempts. A manual reconnect has to be triggerred in such a case.

A manual reconnect can be triggered by doing the following,

echo 1 > /sys/class/rtrs-client/blya/paths/<select-path>/reconnect

Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 10 ++++
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 82 +++++++++++++++++++++++++-
 2 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 5cce727abca0..21001818e607 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1898,6 +1898,7 @@ static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
 				    struct rdma_cm_event *ev)
 {
 	struct rtrs_sess *s = con->c.sess;
+	struct rtrs_clt_sess *sess = to_clt_sess(s);
 	const struct rtrs_msg_conn_rsp *msg;
 	const char *rej_msg;
 	int status, errno;
@@ -1916,6 +1917,15 @@ static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
 			rtrs_err(s,
 				  "Connect rejected: status %d (%s), rtrs errno %d\n",
 				  status, rej_msg, errno);
+
+		if (errno == -ENETDOWN) {
+			/*
+			 * Stop reconnection attempts
+			 */
+			sess->reconnect_attempts = -1;
+			rtrs_err(s,
+				"Disabling auto-reconnect. Trigger a manual reconnect after issue is resolved\n");
+		}
 	} else {
 		rtrs_err(s,
 			  "Connect rejected but with malformed message: status %d (%s)\n",
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index cc65cffdc65a..90d833041ccf 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -32,7 +32,9 @@ MODULE_LICENSE("GPL");
 static struct rtrs_rdma_dev_pd dev_pd;
 static mempool_t *chunk_pool;
 struct class *rtrs_dev_class;
+static struct device *rtrs_dev;
 static struct rtrs_srv_ib_ctx ib_ctx;
+static char disabled_port[NAME_MAX];
 
 static int __read_mostly max_chunk_size = DEFAULT_MAX_CHUNK_SIZE;
 static int __read_mostly sess_queue_depth = DEFAULT_SESS_QUEUE_DEPTH;
@@ -1826,6 +1828,20 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 	u16 recon_cnt;
 	int err = -ECONNRESET;
 
+	if (strnlen(disabled_port, NAME_MAX) > 0) {
+		char ib_device[NAME_MAX];
+
+		snprintf(ib_device, NAME_MAX, "%s %u", cm_id->device->name, cm_id->port_num);
+		if (strncmp(disabled_port, ib_device, NAME_MAX) == 0) {
+			/*
+			 * Reject connection attempt on disabled port
+			 */
+			pr_err("Error: Connection request on a disabled port");
+			err = -ENETDOWN;
+			goto reject_w_err;
+		}
+	}
+
 	if (len < sizeof(*msg)) {
 		pr_err("Invalid RTRS connection request\n");
 		goto reject_w_err;
@@ -2242,6 +2258,56 @@ static int check_module_params(void)
 	return 0;
 }
 
+static ssize_t disable_port_show(struct kobject *kobj,
+				 struct kobj_attribute *attr,
+				 char *page)
+{
+	return sysfs_emit(page, "%s\n", disabled_port);
+}
+
+static ssize_t disable_port_store(struct kobject *kobj,
+				  struct kobj_attribute *attr,
+				  const char *buf, size_t count)
+{
+	int ret, len;
+
+	if (count > 1 && strnlen(disabled_port, NAME_MAX) > 0) {
+		pr_err("A disabled port already exists.\n");
+		return -EINVAL;
+	}
+
+	ret = strscpy(disabled_port, buf, NAME_MAX);
+	if (ret == -E2BIG) {
+		pr_err("String too big.\n");
+		disabled_port[0] = '\0';
+		return ret;
+	}
+
+	len = strlen(disabled_port);
+	if (len > 0 && disabled_port[len-1] == '\n')
+		disabled_port[len-1] = '\0';
+
+	return ret;
+}
+
+static struct kobj_attribute rtrs_srv_disable_port_device_attr =
+	__ATTR(disable_port, 0644,
+	       disable_port_show, disable_port_store);
+
+static struct attribute *default_attrs[] = {
+	&rtrs_srv_disable_port_device_attr.attr,
+	NULL,
+};
+
+static struct attribute_group default_attr_group = {
+	.attrs = default_attrs,
+};
+
+static const struct attribute_group *default_attr_groups[] = {
+	&default_attr_group,
+	NULL,
+};
+
 static int __init rtrs_server_init(void)
 {
 	int err;
@@ -2268,15 +2334,26 @@ static int __init rtrs_server_init(void)
 		err = PTR_ERR(rtrs_dev_class);
 		goto out_chunk_pool;
 	}
+
+	rtrs_dev = device_create_with_groups(rtrs_dev_class, NULL,
+					      MKDEV(0, 0), NULL,
+					      default_attr_groups, "ctl");
+	if (IS_ERR(rtrs_dev)) {
+		err = PTR_ERR(rtrs_dev);
+		goto out_class;
+	}
+
 	rtrs_wq = alloc_workqueue("rtrs_server_wq", 0, 0);
 	if (!rtrs_wq) {
 		err = -ENOMEM;
-		goto out_dev_class;
+		goto out_dev;
 	}
 
 	return 0;
 
-out_dev_class:
+out_dev:
+	device_destroy(rtrs_dev_class, MKDEV(0, 0));
+out_class:
 	class_destroy(rtrs_dev_class);
 out_chunk_pool:
 	mempool_destroy(chunk_pool);
@@ -2287,6 +2364,7 @@ static int __init rtrs_server_init(void)
 static void __exit rtrs_server_exit(void)
 {
 	destroy_workqueue(rtrs_wq);
+	device_destroy(rtrs_dev_class, MKDEV(0, 0));
 	class_destroy(rtrs_dev_class);
 	mempool_destroy(chunk_pool);
 	rtrs_rdma_dev_pd_deinit(&dev_pd);
-- 
2.25.1

