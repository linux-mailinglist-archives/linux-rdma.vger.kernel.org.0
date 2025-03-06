Return-Path: <linux-rdma+bounces-8445-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E8FA55A89
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 00:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D863B2F87
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 23:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDA527E1DA;
	Thu,  6 Mar 2025 23:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="asfu8MdV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF871FBEA6
	for <linux-rdma@vger.kernel.org>; Thu,  6 Mar 2025 23:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741302249; cv=none; b=ogyHWCS2wIFrryegoVPqYTu4Vy+TrN+GJ+vE62buIzmVRrfgTbxcpf2bGgi6ptOPzb+9/nNDeoWwt6SaMruwBbycE6V0VCKFjvk7gxdylRupIn3fG/uKV+I8RfD23pSRblgiD35Md3AIu1lMj4aqZ7w8i59t4F2fgBLATHsXizk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741302249; c=relaxed/simple;
	bh=wYg6lFDju4MwSCX2v7KdEDVQKw2PzFuai0DklCho61I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTm3tNPQmejumkIA26WAidzbjlZEggegZjERvsg/NMCyStJyc8lbu0oN7GAG7QrrYiEsT/gSv1D9u2gX1LUeRa+90gsKEcPKfA36Wa8v5o29ueJkOhuOqu3RiUlUksX60Vb09+hJ7VacMQGL/zYd1gd74e09FK5+KP3GBvzL8ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=asfu8MdV; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c081915cf3so164073085a.1
        for <linux-rdma@vger.kernel.org>; Thu, 06 Mar 2025 15:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1741302246; x=1741907046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XROOKg8tgS+XFar/TPgH4HyrmnuBnyWnrGnnHBmR0+U=;
        b=asfu8MdV4U0vs8mt/5845HUv7BqLf1xfFRBTkuwTx81Xa3MtolnPDlNBXJgz5amQhz
         YCAldIoEPfafMvB6BvSabMmJB9BHns1AOH/pNmox/4GWgu+9McyslSMdcSRo2e5ibxCf
         VGSHgShYY1unLtlgikS/jlMxu2fDlLDF/DZeJ8nSB1IwzGUcUwfUlV4jwG4D9iU0Ff9r
         s+Rnx10E8NPPiLLui5KqoO+bxxISTOPIXGwbnzhi8MguRIp+mpk9L6pjvNREFdJLkncA
         chsp+F51TP9runxJ390wqzx9ayeXdVGi/TYHIIyj8zHwf75V4E/XyINn/CYFpyc6WPdl
         0B1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741302246; x=1741907046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XROOKg8tgS+XFar/TPgH4HyrmnuBnyWnrGnnHBmR0+U=;
        b=JHcYihtsS+XTfuDSOZkdiFyBYjGKe2joFl8eYp2Flwc099Y3GogRxetUXnghzIpCvB
         t5k59FbuQcVoVgYbwVYvpWgi5QQ9JUMFaJCajfXKqNBHo9mtnjp8t+HB5yEUxsqa0YsM
         F+OoRtpu9B+LXJyB2o3I/MEoPcTA6YBpGVx977rgsnp6H2aM/MawMpe/9/bSild/Mcib
         8Vf8Ke6SldbDDz0YXC+EVN8XtFd03qHi5OSDJazMLh4OIv4rN9qqgZE88RYBUtgYMDDM
         EvHfq91O/v1DiR3/yy8Llv9XtPZhr/MafjhADOV+r+h27tWLeArjzUoLBEGxSUX2HZmL
         bRXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUebS68B4l93dAzl9PAvdeXIqmzy0A1JgBYqCRo7HJm0iUuU9+Jxkq68pb2efcWtDykPQ6El+LWvjaS@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6nQyn9fKiRjbn33OBI/56b4uWS5jMF/QJwjpF1cGel/Yg/6Qu
	uuJouEPut1mjTFLaL9DV1QJ3TGqC8hD+08Fw5mch8VjVcVrK7ksoABCADTdfFe0=
X-Gm-Gg: ASbGncvsH5LCyMFIefsdK4XUBxZKK8bclcnQ+1oiSX2wgibUJFpjg+j4MkLl8tpjwBA
	T8WRLZRZpSWYrme2F0f/HtfBVoFTDwY5srHAdVLD8RpfjNvU3uZkJJDyNGfqwsa9e08TOTt9GCb
	YuelbFQ79+My/xvPQe4TFfi3llZRJuzFiAozS0K67h90NA2sMZFAOnwUS4yYVaMmD06gO8GIg2G
	IKrNrbNQRoxliUG8BCSUItWFqyJYf5Xdk4JCXu/zeLh+LJ1DdvEVXHCKieA85x9mYc/oSSt+1Ej
	+f1KzkIFroVeRthUjEokTgguDIOON2o42CdnpdNRxqhsDFkbC4YyLGDJm+HPjVSfKy24
X-Google-Smtp-Source: AGHT+IHABfobyGcfE7W8wGZq5vTIyQjIr95DOZim/xF7tcvT96CCCt+5Wdl6Y0QxBg1dfm/gwpPW9w==
X-Received: by 2002:a05:620a:47a4:b0:7c3:bdce:d1f7 with SMTP id af79cd13be357-7c4e8dd2430mr121616285a.58.1741302245496;
        Thu, 06 Mar 2025 15:04:05 -0800 (PST)
Received: from debil.. (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac256654fa6sm14971966b.93.2025.03.06.15.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:04:04 -0800 (PST)
From: Nikolay Aleksandrov <nikolay@enfabrica.net>
To: netdev@vger.kernel.org
Cc: shrijeet@enfabrica.net,
	alex.badea@keysight.com,
	eric.davis@broadcom.com,
	rip.sohan@amd.com,
	dsahern@kernel.org,
	bmt@zurich.ibm.com,
	roland@enfabrica.net,
	nikolay@enfabrica.net,
	winston.liu@keysight.com,
	dan.mihailescu@keysight.com,
	kheib@redhat.com,
	parth.v.parikh@keysight.com,
	davem@redhat.com,
	ian.ziemba@hpe.com,
	andrew.tauferner@cornelisnetworks.com,
	welch@hpe.com,
	rakhahari.bhunia@keysight.com,
	kingshuk.mandal@keysight.com,
	linux-rdma@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC PATCH 04/13] drivers: ultraeth: add job support
Date: Fri,  7 Mar 2025 01:01:54 +0200
Message-ID: <20250306230203.1550314-5-nikolay@enfabrica.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306230203.1550314-1-nikolay@enfabrica.net>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A UE job identifies an application that a communicating process belongs
to within a distributed parallel application. Jobs are assigned to the
initiating process and are a part of addressing, they are present in all
packets. Jobs are supposed to be assigned by a provisioning system. Job
ids must be globally unique within a UE context. Every UE context
contains a job registry with all current jobs, regardless if they're
associated with a fabric endpoint (FEP) or not. The Ultra Ethernet
netlink spec is updated with job support to create, delete and list jobs.

Signed-off-by: Nikolay Aleksandrov <nikolay@enfabrica.net>
Signed-off-by: Alex Badea <alex.badea@keysight.com>
---
 Documentation/netlink/specs/ultraeth.yaml | 147 +++++++
 drivers/ultraeth/Makefile                 |   2 +-
 drivers/ultraeth/uet_context.c            |   7 +
 drivers/ultraeth/uet_job.c                | 455 ++++++++++++++++++++++
 drivers/ultraeth/uet_netlink.c            |  59 +++
 drivers/ultraeth/uet_netlink.h            |   8 +
 include/net/ultraeth/uet_context.h        |   3 +
 include/net/ultraeth/uet_job.h            |  78 ++++
 include/uapi/linux/ultraeth.h             |  44 +++
 include/uapi/linux/ultraeth_nl.h          |  76 ++++
 10 files changed, 878 insertions(+), 1 deletion(-)
 create mode 100644 drivers/ultraeth/uet_job.c
 create mode 100644 include/net/ultraeth/uet_job.h
 create mode 100644 include/uapi/linux/ultraeth.h

diff --git a/Documentation/netlink/specs/ultraeth.yaml b/Documentation/netlink/specs/ultraeth.yaml
index 55ab4d9b82a9..e95c73a36892 100644
--- a/Documentation/netlink/specs/ultraeth.yaml
+++ b/Documentation/netlink/specs/ultraeth.yaml
@@ -24,6 +24,119 @@ attribute-sets:
         type: nest
         nested-attributes: context
         multi-attr: true
+  -
+    name: fep-in-addr
+    attributes:
+      -
+        name: ip
+        type: binary
+        display-hint: ipv4
+      -
+        name: ip6
+        type: binary
+        byte-order: big-endian
+        display-hint: ipv6
+      -
+        name: family
+        type: u16
+  -
+    name: fep-address
+    attributes:
+      -
+        name: in-address
+        type: nest
+        nested-attributes: fep-in-addr
+      -
+        name: flags
+        type: u16
+      -
+        name: caps
+        type: u16
+      -
+        name: start-resource-index
+        type: u16
+      -
+        name: num-resource-indices
+        type: u16
+      -
+        name: initiator-id
+        type: u32
+      -
+        name: pid-on-fep
+        type: u16
+      -
+        name: padding
+        type: u16
+      -
+        name: version
+        type: u8
+  -
+    name: fep-entry
+    attributes:
+      -
+        name: address
+        type: nest
+        nested-attributes: fep-address
+  -
+    name: flist
+    attributes:
+      -
+        name: fep
+        type: nest
+        multi-attr: true
+        nested-attributes: fep-entry
+  -
+    name: job-req
+    attributes:
+      -
+        name: context-id
+        type: s32
+      -
+        name: id
+        type : u32
+      -
+        name: address
+        type: nest
+        nested-attributes: fep-address
+      -
+        name: service-name
+        type: string
+  -
+    name: job
+    attributes:
+      -
+        name: id
+        type : u32
+      -
+        name: address
+        type: nest
+        nested-attributes: fep-address
+      -
+        name: service-name
+        type: string
+      -
+        name: flist
+        type: nest
+        nested-attributes: flist
+        multi-attr: true
+  -
+    name: jlist
+    attributes:
+      -
+        name: job
+        type: nest
+        nested-attributes: job
+        multi-attr: true
+  -
+    name: jobs
+    attributes:
+      -
+        name: context-id
+        type: s32
+      -
+        name: jlist
+        type: nest
+        nested-attributes: jlist
 
 operations:
   name-prefix: ultraeth-cmd-
@@ -54,3 +167,37 @@ operations:
         request:
           attributes:
             - id
+    -
+      name: job-get
+      doc: dump uecon context jobs
+      attribute-set: jobs
+      dump:
+        request:
+          attributes:
+            - context-id
+        reply:
+          attributes:
+            - context-id
+            - jlist
+    -
+      name: job-new
+      doc: add a new job to uecon context
+      attribute-set: job-req
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - context-id
+            - id
+            - address
+            - service-name
+    -
+      name: job-del
+      doc: delete a job in uecon context
+      attribute-set: job-req
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - context-id
+            - id
diff --git a/drivers/ultraeth/Makefile b/drivers/ultraeth/Makefile
index 599d91d205c1..bf41a62273f9 100644
--- a/drivers/ultraeth/Makefile
+++ b/drivers/ultraeth/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_ULTRAETH) += ultraeth.o
 
-ultraeth-objs := uet_main.o uet_context.o uet_netlink.o
+ultraeth-objs := uet_main.o uet_context.o uet_netlink.o uet_job.o
diff --git a/drivers/ultraeth/uet_context.c b/drivers/ultraeth/uet_context.c
index 2444fa3f35cd..3d738c02e992 100644
--- a/drivers/ultraeth/uet_context.c
+++ b/drivers/ultraeth/uet_context.c
@@ -102,10 +102,16 @@ int uet_context_create(int id)
 		goto ctx_id_err;
 	}
 
+	err = uet_jobs_init(&ctx->job_reg);
+	if (err)
+		goto ctx_jobs_err;
+
 	uet_context_link(ctx);
 
 	return 0;
 
+ctx_jobs_err:
+	uet_context_put_id(ctx);
 ctx_id_err:
 	kfree(ctx);
 
@@ -115,6 +121,7 @@ int uet_context_create(int id)
 static void __uet_context_destroy(struct uet_context *ctx)
 {
 	uet_context_unlink(ctx);
+	uet_jobs_uninit(&ctx->job_reg);
 	uet_context_put_id(ctx);
 	kfree(ctx);
 }
diff --git a/drivers/ultraeth/uet_job.c b/drivers/ultraeth/uet_job.c
new file mode 100644
index 000000000000..3a55a0f70749
--- /dev/null
+++ b/drivers/ultraeth/uet_job.c
@@ -0,0 +1,455 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/bug.h>
+#include <net/ipv6.h>
+#include <net/ultraeth/uet_context.h>
+
+#include "uet_netlink.h"
+
+static const struct rhashtable_params uet_job_registry_rht_params = {
+	.head_offset = offsetof(struct uet_job, rht_node),
+	.key_offset = offsetof(struct uet_job, id),
+	.key_len = sizeof(u32),
+	.nelem_hint = 128,
+	.automatic_shrinking = true,
+};
+
+int uet_jobs_init(struct uet_job_registry *jreg)
+{
+	int ret;
+
+	mutex_init(&jreg->jobs_lock);
+
+	ret = rhashtable_init(&jreg->jobs_hash, &uet_job_registry_rht_params);
+	if (ret)
+		mutex_destroy(&jreg->jobs_lock);
+
+	return ret;
+}
+
+static int __job_associate(struct uet_job *job, struct uet_fep *fep)
+{
+	lockdep_assert_held_once(&job->jreg->jobs_lock);
+
+	if (rcu_access_pointer(job->fep))
+		return -EBUSY;
+
+	WRITE_ONCE(fep->job_id, job->id);
+	rcu_assign_pointer(job->fep, fep);
+
+	return 0;
+}
+
+/* disassociate and close all PDCs related to the job */
+static void __job_disassociate(struct uet_job *job)
+{
+	struct uet_fep *fep;
+
+	fep = rcu_dereference_check(job->fep,
+				    lockdep_is_held(&job->jreg->jobs_lock));
+	if (!fep)
+		return;
+
+	WRITE_ONCE(fep->job_id, 0);
+	RCU_INIT_POINTER(job->fep, NULL);
+	synchronize_rcu();
+}
+
+struct uet_job *uet_job_find(struct uet_job_registry *jreg, u32 id)
+{
+	return rhashtable_lookup_fast(&jreg->jobs_hash, &id,
+				      uet_job_registry_rht_params);
+}
+
+static struct uet_job *uet_job_find_svc_name(struct uet_job_registry *jreg,
+					     char *service_name)
+{
+	struct uet_job *job;
+
+	lockdep_assert_held_once(&jreg->jobs_lock);
+
+	hlist_for_each_entry(job, &jreg->jobs_list, hnode) {
+		if (!strcmp(job->service_name, service_name))
+			return job;
+	}
+
+	return NULL;
+}
+
+static void __uet_job_remove(struct uet_job *job)
+{
+	struct uet_job_registry *jreg = job->jreg;
+
+	__job_disassociate(job);
+	hlist_del_init_rcu(&job->hnode);
+	rhashtable_remove_fast(&jreg->jobs_hash, &job->rht_node,
+			       uet_job_registry_rht_params);
+	kfree_rcu(job, rcu);
+}
+
+bool uet_job_remove(struct uet_job_registry *jreg, u32 job_id)
+{
+	bool removed = false;
+	struct uet_job *job;
+
+	mutex_lock(&jreg->jobs_lock);
+	job = uet_job_find(jreg, job_id);
+	if (job) {
+		__uet_job_remove(job);
+		removed = true;
+	}
+	mutex_unlock(&jreg->jobs_lock);
+
+	return removed;
+}
+
+void uet_jobs_uninit(struct uet_job_registry *jreg)
+{
+	struct hlist_node *tmp;
+	struct uet_job *job;
+
+	mutex_lock(&jreg->jobs_lock);
+	hlist_for_each_entry_safe(job, tmp, &jreg->jobs_list, hnode)
+		__uet_job_remove(job);
+	mutex_unlock(&jreg->jobs_lock);
+
+	rhashtable_destroy(&jreg->jobs_hash);
+	rcu_barrier();
+	mutex_destroy(&jreg->jobs_lock);
+}
+
+struct uet_job *uet_job_create(struct uet_job_registry *jreg,
+			       struct uet_job_ctrl_addr_req *job_req)
+{
+	struct uet_job *job;
+	int ret;
+
+	if (job_req->job_id == 0)
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&jreg->jobs_lock);
+	if (uet_job_find_svc_name(jreg, job_req->service_name)) {
+		mutex_unlock(&jreg->jobs_lock);
+		return ERR_PTR(-EEXIST);
+	}
+
+	job = kzalloc(sizeof(*job), GFP_KERNEL);
+	if (!job)
+		return ERR_PTR(-ENOMEM);
+
+	job->jreg = jreg;
+	job->id = job_req->job_id;
+	strscpy(job->service_name, job_req->service_name, sizeof(job->service_name));
+
+	ret = rhashtable_lookup_insert_fast(&jreg->jobs_hash, &job->rht_node,
+					    uet_job_registry_rht_params);
+	if (ret) {
+		kfree_rcu(job, rcu);
+		mutex_unlock(&jreg->jobs_lock);
+		return ERR_PTR(ret);
+	}
+	hlist_add_head_rcu(&job->hnode, &jreg->jobs_list);
+	mutex_unlock(&jreg->jobs_lock);
+
+	return job;
+}
+
+int uet_job_reg_associate(struct uet_job_registry *jreg, struct uet_fep *fep,
+			  char *service_name)
+{
+	struct uet_job *job;
+	int ret = -ENOENT;
+
+	mutex_lock(&jreg->jobs_lock);
+	job = uet_job_find_svc_name(jreg, service_name);
+	if (job)
+		ret = __job_associate(job, fep);
+	mutex_unlock(&jreg->jobs_lock);
+
+	return ret;
+}
+
+void uet_job_reg_disassociate(struct uet_job_registry *jreg, u32 job_id)
+{
+	struct uet_job *job;
+
+	mutex_lock(&jreg->jobs_lock);
+	job = uet_job_find(jreg, job_id);
+	if (job)
+		__job_disassociate(job);
+	mutex_unlock(&jreg->jobs_lock);
+}
+
+/* returns <0 (error) or 1 (queued the skb) */
+int uet_job_fep_queue_skb(struct uet_context *ctx,
+			  u32 job_id, struct sk_buff *skb,
+			  __be32 remote_fep_addr)
+{
+	struct uet_job *job = uet_job_find(&ctx->job_reg, job_id);
+	struct uet_fep *fep;
+
+	if (!job)
+		return -ENOENT;
+
+	fep = rcu_dereference(job->fep);
+	if (!fep)
+		return -ENODEV;
+
+	skb_dst_drop(skb);
+	skb_queue_tail(&fep->rxq, skb);
+
+	return 1;
+}
+
+static int __nl_fep_addr_fill_one(struct sk_buff *skb,
+				  const struct fep_in_address *fep_addr,
+				  int fep_attr)
+{
+	struct nlattr *nest;
+	int attr, len;
+
+	if (!fep_addr->family)
+		return 0;
+
+	nest = nla_nest_start(skb, fep_attr);
+	if (!nest)
+		return -EMSGSIZE;
+
+	switch (fep_addr->family) {
+	case AF_INET:
+		attr = ULTRAETH_A_FEP_IN_ADDR_IP;
+		len = sizeof(fep_addr->ip);
+		break;
+	case AF_INET6:
+		attr = ULTRAETH_A_FEP_IN_ADDR_IP6;
+		len = sizeof(fep_addr->ip6);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		nla_nest_cancel(skb, nest);
+		return 0;
+	}
+
+	if (nla_put(skb, attr, len, &fep_addr->ip) ||
+	    nla_put_u16(skb, ULTRAETH_A_FEP_IN_ADDR_FAMILY, fep_addr->family)) {
+		nla_nest_cancel(skb, nest);
+		return -EMSGSIZE;
+	}
+
+	nla_nest_end(skb, nest);
+
+	return 0;
+}
+
+static int __nl_uet_addr_fill_one(struct sk_buff *skb,
+				    const struct fep_address *addr, int attr)
+{
+	struct nlattr *nest;
+
+	nest = nla_nest_start(skb, attr);
+	if (!nest)
+		return -EMSGSIZE;
+	if (__nl_fep_addr_fill_one(skb, &addr->in_address,
+				   ULTRAETH_A_FEP_ADDRESS_IN_ADDRESS) ||
+	    nla_put_u16(skb, ULTRAETH_A_FEP_ADDRESS_FLAGS, addr->flags) ||
+	    nla_put_u16(skb, ULTRAETH_A_FEP_ADDRESS_CAPS, addr->fep_caps) ||
+	    nla_put_u16(skb, ULTRAETH_A_FEP_ADDRESS_START_RESOURCE_INDEX,
+			addr->start_resource_index) ||
+	    nla_put_u16(skb, ULTRAETH_A_FEP_ADDRESS_NUM_RESOURCE_INDICES,
+			addr->num_resource_indices) ||
+	    nla_put_u32(skb, ULTRAETH_A_FEP_ADDRESS_INITIATOR_ID,
+			addr->initiator_id) ||
+	    nla_put_u16(skb, ULTRAETH_A_FEP_ADDRESS_PID_ON_FEP,
+			addr->pid_on_fep) ||
+	    nla_put_u8(skb, ULTRAETH_A_FEP_ADDRESS_VERSION, addr->version)) {
+		nla_nest_cancel(skb, nest);
+		return -EMSGSIZE;
+	}
+	nla_nest_end(skb, nest);
+
+	return 0;
+}
+
+static int __nl_fep_fill_one(struct sk_buff *skb,
+			     const struct uet_fep *fep, int attr)
+{
+	struct nlattr *nest;
+
+	nest = nla_nest_start(skb, attr);
+	if (!nest)
+		return -EMSGSIZE;
+	if (__nl_uet_addr_fill_one(skb, &fep->addr, ULTRAETH_A_FEP_ENTRY_ADDRESS)) {
+		nla_nest_cancel(skb, nest);
+		return -EMSGSIZE;
+	}
+	nla_nest_end(skb, nest);
+
+	return 0;
+}
+
+static int __nl_job_feps_fill(struct sk_buff *skb, const struct uet_fep *fep)
+{
+	struct nlattr *nest;
+
+	nest = nla_nest_start(skb, ULTRAETH_A_JOB_FLIST);
+	if (!nest)
+		return -EMSGSIZE;
+	if (fep && __nl_fep_fill_one(skb, fep, ULTRAETH_A_FLIST_FEP)) {
+		nla_nest_cancel(skb, nest);
+		return -EMSGSIZE;
+	}
+	nla_nest_end(skb, nest);
+
+	return 0;
+}
+
+static int __nl_job_fill_one(struct sk_buff *skb, const struct uet_job *job)
+{
+	struct nlattr *nest;
+
+	nest = nla_nest_start(skb, ULTRAETH_A_JLIST_JOB);
+	if (!nest)
+		return -EMSGSIZE;
+
+	if (__nl_uet_addr_fill_one(skb, &job->addr, ULTRAETH_A_JOB_ADDRESS) ||
+	    nla_put_u32(skb, ULTRAETH_A_JOB_ID, job->id) ||
+	    nla_put_string(skb, ULTRAETH_A_JOB_SERVICE_NAME, job->service_name) ||
+	    __nl_job_feps_fill(skb, rcu_dereference(job->fep))) {
+		nla_nest_cancel(skb, nest);
+		return -EMSGSIZE;
+	}
+
+	nla_nest_end(skb, nest);
+	return 0;
+}
+
+int ultraeth_nl_job_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+	int idx = 0, s_idx = cb->args[0], err;
+	struct uet_context *ctx;
+	struct uet_job *job;
+	struct nlattr *nest;
+	int context_id;
+	void *hdr;
+
+	if (!info->attrs[ULTRAETH_A_JOBS_CONTEXT_ID]) {
+		NL_SET_ERR_MSG(info->extack, "context id must be specified");
+		return -EINVAL;
+	}
+
+	context_id = nla_get_s32(info->attrs[ULTRAETH_A_JOBS_CONTEXT_ID]);
+	ctx = uet_context_get_by_id(context_id);
+	if (!ctx) {
+		NL_SET_ERR_MSG(info->extack, "context doesn't exist");
+		return -ENOENT;
+	}
+
+	/* filled all, return 0 */
+	if (s_idx == atomic_read(&ctx->job_reg.jobs_hash.nelems))
+		goto out_put;
+
+	err = -EMSGSIZE;
+	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			  &ultraeth_nl_family, NLM_F_MULTI, ULTRAETH_CMD_JOB_GET);
+	if (!hdr)
+		goto out_put;
+	if (nla_put_s32(skb, ULTRAETH_A_JOBS_CONTEXT_ID, ctx->id))
+		goto out_end;
+	nest = nla_nest_start(skb, ULTRAETH_A_JOBS_JLIST);
+	if (!nest)
+		goto out_end;
+	err = 0;
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(job, &ctx->job_reg.jobs_list, hnode) {
+		if (idx < s_idx) {
+			idx++;
+			continue;
+		}
+		err = __nl_job_fill_one(skb, job);
+		if (err)
+			break;
+		idx++;
+	}
+	cb->args[0] = idx;
+	rcu_read_unlock();
+	nla_nest_end(skb, nest);
+out_end:
+	genlmsg_end(skb, hdr);
+out_put:
+	uet_context_put(ctx);
+
+	return err ? err : skb->len;
+}
+
+int ultraeth_nl_job_new_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct uet_job_ctrl_addr_req jreq;
+	struct uet_context *ctx;
+	int context_id, job_id;
+	struct uet_job *job;
+	char *service_name;
+	int ret = 0;
+
+	if (!info->attrs[ULTRAETH_A_JOB_REQ_CONTEXT_ID]) {
+		NL_SET_ERR_MSG(info->extack, "context id must be specified");
+		return -EINVAL;
+	}
+	if (!info->attrs[ULTRAETH_A_JOB_REQ_ID]) {
+		NL_SET_ERR_MSG(info->extack, "Job id must be specified");
+		return -EINVAL;
+	}
+	if (!info->attrs[ULTRAETH_A_JOB_REQ_SERVICE_NAME]) {
+		NL_SET_ERR_MSG(info->extack, "Job service name must be specified");
+		return -EINVAL;
+	}
+	service_name = nla_data(info->attrs[ULTRAETH_A_JOB_REQ_SERVICE_NAME]);
+	job_id = nla_get_u32(info->attrs[ULTRAETH_A_JOB_REQ_ID]);
+	context_id = nla_get_s32(info->attrs[ULTRAETH_A_JOB_REQ_CONTEXT_ID]);
+	ctx = uet_context_get_by_id(context_id);
+	if (!ctx) {
+		NL_SET_ERR_MSG(info->extack, "context doesn't exist");
+		return -ENOENT;
+	}
+
+	memset(&jreq, 0, sizeof(jreq));
+	jreq.job_id = job_id;
+	strscpy(jreq.service_name, service_name, sizeof(jreq.service_name));
+	job = uet_job_create(&ctx->job_reg, &jreq);
+	if (IS_ERR(job))
+		ret = PTR_ERR(job);
+
+	uet_context_put(ctx);
+
+	return ret;
+}
+
+int ultraeth_nl_job_del_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct uet_context *ctx;
+	bool destroyed = false;
+	int context_id, job_id;
+
+	if (!info->attrs[ULTRAETH_A_JOB_REQ_CONTEXT_ID]) {
+		NL_SET_ERR_MSG(info->extack, "context id must be specified");
+		return -EINVAL;
+	}
+	if (!info->attrs[ULTRAETH_A_JOB_REQ_ID]) {
+		NL_SET_ERR_MSG(info->extack, "Job id must be specified");
+		return -EINVAL;
+	}
+	job_id = nla_get_u32(info->attrs[ULTRAETH_A_JOB_REQ_ID]);
+	context_id = nla_get_s32(info->attrs[ULTRAETH_A_JOB_REQ_CONTEXT_ID]);
+	ctx = uet_context_get_by_id(context_id);
+	if (!ctx) {
+		NL_SET_ERR_MSG(info->extack, "context doesn't exist");
+		return -ENOENT;
+	}
+
+	destroyed = uet_job_remove(&ctx->job_reg, job_id);
+	uet_context_put(ctx);
+
+	return destroyed ? 0 : -ENOENT;
+}
diff --git a/drivers/ultraeth/uet_netlink.c b/drivers/ultraeth/uet_netlink.c
index 39e4aa6092a9..7fdaf15e43e3 100644
--- a/drivers/ultraeth/uet_netlink.c
+++ b/drivers/ultraeth/uet_netlink.c
@@ -10,6 +10,25 @@
 
 #include <uapi/linux/ultraeth_nl.h>
 
+/* Common nested types */
+const struct nla_policy ultraeth_fep_address_nl_policy[ULTRAETH_A_FEP_ADDRESS_VERSION + 1] = {
+	[ULTRAETH_A_FEP_ADDRESS_IN_ADDRESS] = NLA_POLICY_NESTED(ultraeth_fep_in_addr_nl_policy),
+	[ULTRAETH_A_FEP_ADDRESS_FLAGS] = { .type = NLA_U16, },
+	[ULTRAETH_A_FEP_ADDRESS_CAPS] = { .type = NLA_U16, },
+	[ULTRAETH_A_FEP_ADDRESS_START_RESOURCE_INDEX] = { .type = NLA_U16, },
+	[ULTRAETH_A_FEP_ADDRESS_NUM_RESOURCE_INDICES] = { .type = NLA_U16, },
+	[ULTRAETH_A_FEP_ADDRESS_INITIATOR_ID] = { .type = NLA_U32, },
+	[ULTRAETH_A_FEP_ADDRESS_PID_ON_FEP] = { .type = NLA_U16, },
+	[ULTRAETH_A_FEP_ADDRESS_PADDING] = { .type = NLA_U16, },
+	[ULTRAETH_A_FEP_ADDRESS_VERSION] = { .type = NLA_U8, },
+};
+
+const struct nla_policy ultraeth_fep_in_addr_nl_policy[ULTRAETH_A_FEP_IN_ADDR_FAMILY + 1] = {
+	[ULTRAETH_A_FEP_IN_ADDR_IP] = { .type = NLA_BINARY, },
+	[ULTRAETH_A_FEP_IN_ADDR_IP6] = { .type = NLA_BINARY, },
+	[ULTRAETH_A_FEP_IN_ADDR_FAMILY] = { .type = NLA_U16, },
+};
+
 /* ULTRAETH_CMD_CONTEXT_NEW - do */
 static const struct nla_policy ultraeth_context_new_nl_policy[ULTRAETH_A_CONTEXT_ID + 1] = {
 	[ULTRAETH_A_CONTEXT_ID] = NLA_POLICY_RANGE(NLA_S32, 0, 255),
@@ -20,6 +39,25 @@ static const struct nla_policy ultraeth_context_del_nl_policy[ULTRAETH_A_CONTEXT
 	[ULTRAETH_A_CONTEXT_ID] = NLA_POLICY_RANGE(NLA_S32, 0, 255),
 };
 
+/* ULTRAETH_CMD_JOB_GET - dump */
+static const struct nla_policy ultraeth_job_get_nl_policy[ULTRAETH_A_JOBS_CONTEXT_ID + 1] = {
+	[ULTRAETH_A_JOBS_CONTEXT_ID] = { .type = NLA_S32, },
+};
+
+/* ULTRAETH_CMD_JOB_NEW - do */
+static const struct nla_policy ultraeth_job_new_nl_policy[ULTRAETH_A_JOB_REQ_SERVICE_NAME + 1] = {
+	[ULTRAETH_A_JOB_REQ_CONTEXT_ID] = { .type = NLA_S32, },
+	[ULTRAETH_A_JOB_REQ_ID] = { .type = NLA_U32, },
+	[ULTRAETH_A_JOB_REQ_ADDRESS] = NLA_POLICY_NESTED(ultraeth_fep_address_nl_policy),
+	[ULTRAETH_A_JOB_REQ_SERVICE_NAME] = { .type = NLA_NUL_STRING, },
+};
+
+/* ULTRAETH_CMD_JOB_DEL - do */
+static const struct nla_policy ultraeth_job_del_nl_policy[ULTRAETH_A_JOB_REQ_ID + 1] = {
+	[ULTRAETH_A_JOB_REQ_CONTEXT_ID] = { .type = NLA_S32, },
+	[ULTRAETH_A_JOB_REQ_ID] = { .type = NLA_U32, },
+};
+
 /* Ops table for ultraeth */
 static const struct genl_split_ops ultraeth_nl_ops[] = {
 	{
@@ -41,6 +79,27 @@ static const struct genl_split_ops ultraeth_nl_ops[] = {
 		.maxattr	= ULTRAETH_A_CONTEXT_ID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= ULTRAETH_CMD_JOB_GET,
+		.dumpit		= ultraeth_nl_job_get_dumpit,
+		.policy		= ultraeth_job_get_nl_policy,
+		.maxattr	= ULTRAETH_A_JOBS_CONTEXT_ID,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= ULTRAETH_CMD_JOB_NEW,
+		.doit		= ultraeth_nl_job_new_doit,
+		.policy		= ultraeth_job_new_nl_policy,
+		.maxattr	= ULTRAETH_A_JOB_REQ_SERVICE_NAME,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= ULTRAETH_CMD_JOB_DEL,
+		.doit		= ultraeth_nl_job_del_doit,
+		.policy		= ultraeth_job_del_nl_policy,
+		.maxattr	= ULTRAETH_A_JOB_REQ_ID,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 struct genl_family ultraeth_nl_family __ro_after_init = {
diff --git a/drivers/ultraeth/uet_netlink.h b/drivers/ultraeth/uet_netlink.h
index 9dd9df24513a..6e7226f39ddf 100644
--- a/drivers/ultraeth/uet_netlink.h
+++ b/drivers/ultraeth/uet_netlink.h
@@ -11,10 +11,18 @@
 
 #include <uapi/linux/ultraeth_nl.h>
 
+/* Common nested types */
+extern const struct nla_policy ultraeth_fep_address_nl_policy[ULTRAETH_A_FEP_ADDRESS_VERSION + 1];
+extern const struct nla_policy ultraeth_fep_in_addr_nl_policy[ULTRAETH_A_FEP_IN_ADDR_FAMILY + 1];
+
 int ultraeth_nl_context_get_dumpit(struct sk_buff *skb,
 				   struct netlink_callback *cb);
 int ultraeth_nl_context_new_doit(struct sk_buff *skb, struct genl_info *info);
 int ultraeth_nl_context_del_doit(struct sk_buff *skb, struct genl_info *info);
+int ultraeth_nl_job_get_dumpit(struct sk_buff *skb,
+			       struct netlink_callback *cb);
+int ultraeth_nl_job_new_doit(struct sk_buff *skb, struct genl_info *info);
+int ultraeth_nl_job_del_doit(struct sk_buff *skb, struct genl_info *info);
 
 extern struct genl_family ultraeth_nl_family;
 
diff --git a/include/net/ultraeth/uet_context.h b/include/net/ultraeth/uet_context.h
index 150ad2c9b456..7638c768597e 100644
--- a/include/net/ultraeth/uet_context.h
+++ b/include/net/ultraeth/uet_context.h
@@ -9,12 +9,15 @@
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/wait.h>
+#include <net/ultraeth/uet_job.h>
 
 struct uet_context {
 	int id;
 	refcount_t refcnt;
 	wait_queue_head_t refcnt_wait;
 	struct list_head list;
+
+	struct uet_job_registry job_reg;
 };
 
 struct uet_context *uet_context_get_by_id(int id);
diff --git a/include/net/ultraeth/uet_job.h b/include/net/ultraeth/uet_job.h
new file mode 100644
index 000000000000..fac1f0752a78
--- /dev/null
+++ b/include/net/ultraeth/uet_job.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+
+#ifndef _UET_JOB_H
+#define _UET_JOB_H
+
+#include <linux/types.h>
+#include <linux/rhashtable.h>
+#include <linux/skbuff.h>
+#include <linux/mutex.h>
+#include <uapi/linux/ultraeth.h>
+
+struct uet_context;
+
+struct uet_job_registry {
+	struct mutex jobs_lock;
+	struct hlist_head jobs_list;
+	struct rhashtable jobs_hash;
+};
+
+struct uet_fep {
+	struct uet_context *context;
+	struct sk_buff_head rxq;
+	struct fep_address addr;
+	u32 job_id;
+};
+
+/**
+ * struct uet_job - single job
+ *
+ * @rht_node: link into the job registry's job hash table
+ * @hnode: link into the job registry's list
+ * @jreg: pointer to job registry (owner)
+ * @service_name: service name used for lookups on address req
+ * @addr: job specific address (XXX)
+ * @job_id: unique job id
+ * @rcu: used for freeing
+ *
+ * if @fep is set then the job is considered associated, i.e. there is
+ * an fd for the context's character device which is bound to this
+ * job (FEP)
+ */
+struct uet_job {
+	struct rhash_head rht_node;
+	struct hlist_node hnode;
+
+	struct uet_job_registry *jreg;
+
+	char service_name[UET_SVC_MAX_LEN];
+
+	struct fep_address addr;
+	struct uet_fep __rcu *fep;
+
+	u32 id;
+
+	struct rcu_head rcu;
+};
+
+struct uet_job_ctrl_addr_req {
+	char service_name[UET_SVC_MAX_LEN];
+	struct fep_in_address address;
+	__u32 job_id;
+	__u32 os_pid;
+	__u8 flags;
+};
+
+int uet_jobs_init(struct uet_job_registry *jreg);
+void uet_jobs_uninit(struct uet_job_registry *jreg);
+
+struct uet_job *uet_job_create(struct uet_job_registry *jreg,
+			       struct uet_job_ctrl_addr_req *job_req);
+bool uet_job_remove(struct uet_job_registry *jreg, u32 job_id);
+struct uet_job *uet_job_find(struct uet_job_registry *jreg, u32 id);
+void uet_job_reg_disassociate(struct uet_job_registry *jreg, u32 job_id);
+int uet_job_reg_associate(struct uet_job_registry *jreg, struct uet_fep *fep,
+			  char *service_name);
+int uet_job_fep_queue_skb(struct uet_context *ctx, u32 job_id,
+			  struct sk_buff *skb, __be32 remote_fep_addr);
+#endif /* _UET_JOB_H */
diff --git a/include/uapi/linux/ultraeth.h b/include/uapi/linux/ultraeth.h
new file mode 100644
index 000000000000..a6f244de6d75
--- /dev/null
+++ b/include/uapi/linux/ultraeth.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+
+#ifndef _UAPI_LINUX_ULTRAETH_H
+#define _UAPI_LINUX_ULTRAETH_H
+
+#include <asm/byteorder.h>
+#include <linux/types.h>
+
+#define UET_SVC_MAX_LEN 64
+
+enum {
+	UET_ADDR_F_VALID_FEP_CAP	= (1 << 0),
+	UET_ADDR_F_VALID_ADDR		= (1 << 1),
+	UET_ADDR_F_VALID_PID_ON_FEP	= (1 << 2),
+	UET_ADDR_F_VALID_RI		= (1 << 3),
+	UET_ADDR_F_VALID_INIT_ID	= (1 << 4),
+	UET_ADDR_F_ADDRESS_MODE		= (1 << 5),
+	UET_ADDR_F_ADDRESS_TYPE		= (1 << 6),
+	UET_ADDR_F_MTU_LIMITED		= (1 << 7),
+};
+
+#define UET_ADDR_FLAG_IP_VER (1 << 6)
+
+struct fep_in_address {
+	union {
+		__be32 ip;
+		__u8 ip6[16];
+	};
+	__u16 family;
+};
+
+struct fep_address {
+	struct fep_in_address in_address;
+
+	__u16 flags;
+	__u16 fep_caps;
+	__u16 start_resource_index;
+	__u16 num_resource_indices;
+	__u32 initiator_id;
+	__u16 pid_on_fep;
+	__u16 padding;
+	__u8 version;
+};
+#endif /* _UAPI_LINUX_ULTRAETH_H */
diff --git a/include/uapi/linux/ultraeth_nl.h b/include/uapi/linux/ultraeth_nl.h
index f3bdf8111623..d65521de196a 100644
--- a/include/uapi/linux/ultraeth_nl.h
+++ b/include/uapi/linux/ultraeth_nl.h
@@ -23,10 +23,86 @@ enum {
 	ULTRAETH_A_CONTEXTS_MAX = (__ULTRAETH_A_CONTEXTS_MAX - 1)
 };
 
+enum {
+	ULTRAETH_A_FEP_IN_ADDR_IP = 1,
+	ULTRAETH_A_FEP_IN_ADDR_IP6,
+	ULTRAETH_A_FEP_IN_ADDR_FAMILY,
+
+	__ULTRAETH_A_FEP_IN_ADDR_MAX,
+	ULTRAETH_A_FEP_IN_ADDR_MAX = (__ULTRAETH_A_FEP_IN_ADDR_MAX - 1)
+};
+
+enum {
+	ULTRAETH_A_FEP_ADDRESS_IN_ADDRESS = 1,
+	ULTRAETH_A_FEP_ADDRESS_FLAGS,
+	ULTRAETH_A_FEP_ADDRESS_CAPS,
+	ULTRAETH_A_FEP_ADDRESS_START_RESOURCE_INDEX,
+	ULTRAETH_A_FEP_ADDRESS_NUM_RESOURCE_INDICES,
+	ULTRAETH_A_FEP_ADDRESS_INITIATOR_ID,
+	ULTRAETH_A_FEP_ADDRESS_PID_ON_FEP,
+	ULTRAETH_A_FEP_ADDRESS_PADDING,
+	ULTRAETH_A_FEP_ADDRESS_VERSION,
+
+	__ULTRAETH_A_FEP_ADDRESS_MAX,
+	ULTRAETH_A_FEP_ADDRESS_MAX = (__ULTRAETH_A_FEP_ADDRESS_MAX - 1)
+};
+
+enum {
+	ULTRAETH_A_FEP_ENTRY_ADDRESS = 1,
+
+	__ULTRAETH_A_FEP_ENTRY_MAX,
+	ULTRAETH_A_FEP_ENTRY_MAX = (__ULTRAETH_A_FEP_ENTRY_MAX - 1)
+};
+
+enum {
+	ULTRAETH_A_FLIST_FEP = 1,
+
+	__ULTRAETH_A_FLIST_MAX,
+	ULTRAETH_A_FLIST_MAX = (__ULTRAETH_A_FLIST_MAX - 1)
+};
+
+enum {
+	ULTRAETH_A_JOB_REQ_CONTEXT_ID = 1,
+	ULTRAETH_A_JOB_REQ_ID,
+	ULTRAETH_A_JOB_REQ_ADDRESS,
+	ULTRAETH_A_JOB_REQ_SERVICE_NAME,
+
+	__ULTRAETH_A_JOB_REQ_MAX,
+	ULTRAETH_A_JOB_REQ_MAX = (__ULTRAETH_A_JOB_REQ_MAX - 1)
+};
+
+enum {
+	ULTRAETH_A_JOB_ID = 1,
+	ULTRAETH_A_JOB_ADDRESS,
+	ULTRAETH_A_JOB_SERVICE_NAME,
+	ULTRAETH_A_JOB_FLIST,
+
+	__ULTRAETH_A_JOB_MAX,
+	ULTRAETH_A_JOB_MAX = (__ULTRAETH_A_JOB_MAX - 1)
+};
+
+enum {
+	ULTRAETH_A_JLIST_JOB = 1,
+
+	__ULTRAETH_A_JLIST_MAX,
+	ULTRAETH_A_JLIST_MAX = (__ULTRAETH_A_JLIST_MAX - 1)
+};
+
+enum {
+	ULTRAETH_A_JOBS_CONTEXT_ID = 1,
+	ULTRAETH_A_JOBS_JLIST,
+
+	__ULTRAETH_A_JOBS_MAX,
+	ULTRAETH_A_JOBS_MAX = (__ULTRAETH_A_JOBS_MAX - 1)
+};
+
 enum {
 	ULTRAETH_CMD_CONTEXT_GET = 1,
 	ULTRAETH_CMD_CONTEXT_NEW,
 	ULTRAETH_CMD_CONTEXT_DEL,
+	ULTRAETH_CMD_JOB_GET,
+	ULTRAETH_CMD_JOB_NEW,
+	ULTRAETH_CMD_JOB_DEL,
 
 	__ULTRAETH_CMD_MAX,
 	ULTRAETH_CMD_MAX = (__ULTRAETH_CMD_MAX - 1)
-- 
2.48.1


