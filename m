Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AC25833B4
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jul 2022 21:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbiG0Tea (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jul 2022 15:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiG0Tea (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jul 2022 15:34:30 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8733CBDC
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 12:34:28 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so3616479pjz.1
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 12:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wOrWIpXg62eHGvKZVv+xJ47vBojVpGqnNlzjm3McXi8=;
        b=qo+pLWz7Fc8uPENzl2720jgyVaHWmR2q4CIyXhenaXAlgS/aRvfVkPqX6eUdnJjFkJ
         OKcpalc1DTXSNWbaM0uyHPRaFp/ZIyMyXI7GI8z+6x1M6UpMs9y5U3ze7ZCbeIoYkDgH
         0NXaWlSq0LpQjx1OEueop387ycR+XpbAQ2xEM6llu8QU+sWmTRnLS7xiycklSPUuzBJO
         L2Gogb1ap6w7WzUxdhWbC343YDfUvUajIK0kZAwJLuIjvhau06z3iZweEcQ/G1R95Bas
         acF7XDhpHcU59B8gAQ6C5wloYcSSO5UHHnnxWUGZf5HP1MH98fnjvPZhrJjRtteVSKYN
         YgEQ==
X-Gm-Message-State: AJIora+2bgGn28mY1zhxuDxtNj0cnMPKdK62g6d4ic+wHg4jQGTSWhG3
        qRDX3Kv/Ou8jVvyzgH83mC8=
X-Google-Smtp-Source: AGRyM1sySDnKnHpEE8p7TYcyAosj8TW7ZVcvZu24lnj1JzVNzjjDqMh0z4LSuGZ1cnr8GN97zXuI3w==
X-Received: by 2002:a17:902:e747:b0:16c:3ffd:61e4 with SMTP id p7-20020a170902e74700b0016c3ffd61e4mr22536334plf.12.1658950468334;
        Wed, 27 Jul 2022 12:34:28 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:a84e:2ec1:1b57:b033])
        by smtp.gmail.com with ESMTPSA id y28-20020aa7943c000000b0052b94e757ecsm14221542pfo.213.2022.07.27.12.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 12:34:27 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>,
        Hillf Danton <hdanton@sina.com>,
        Mike Christie <michael.christie@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 3/3] RDMA/srpt: Fix a use-after-free
Date:   Wed, 27 Jul 2022 12:34:15 -0700
Message-Id: <20220727193415.1583860-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
In-Reply-To: <20220727193415.1583860-1-bvanassche@acm.org>
References: <20220727193415.1583860-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Change the LIO port members inside struct srpt_port from regular members
into pointers. Allocate the LIO port data structures from inside
srpt_make_tport() and free these from inside srpt_make_tport(). Keep struct
srpt_device as long as either an RDMA port or a LIO target port is
associated with it. This patch decouples the lifetime of struct srpt_port
(controlled by the RDMA core) and struct srpt_port_id (controlled by LIO).
This patch fixes the following KASAN complaint:

BUG: KASAN: use-after-free in srpt_enable_tpg+0x31/0x70 [ib_srpt]
Read of size 8 at addr ffff888141cc34b8 by task check/5093

Call Trace:
 <TASK>
 show_stack+0x4e/0x53
 dump_stack_lvl+0x51/0x66
 print_address_description.constprop.0.cold+0xea/0x41e
 print_report.cold+0x90/0x205
 kasan_report+0xb9/0xf0
 __asan_load8+0x69/0x90
 srpt_enable_tpg+0x31/0x70 [ib_srpt]
 target_fabric_tpg_base_enable_store+0xe2/0x140 [target_core_mod]
 configfs_write_iter+0x18b/0x210
 new_sync_write+0x1f2/0x2f0
 vfs_write+0x3e3/0x540
 ksys_write+0xbb/0x140
 __x64_sys_write+0x42/0x50
 do_syscall_64+0x34/0x80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
 </TASK>

Reported-by: Li Zhijian <lizhijian@fujitsu.com>
Tested-by: Li Zhijian <lizhijian@fujitsu.com>
Cc: Li Zhijian <lizhijian@fujitsu.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Mike Christie <michael.christie@oracle.com>
Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 130 ++++++++++++++++++--------
 drivers/infiniband/ulp/srpt/ib_srpt.h |  10 +-
 2 files changed, 94 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 1fbce9225424..c3036aeac89e 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -565,18 +565,12 @@ static int srpt_refresh_port(struct srpt_port *sport)
 	if (ret)
 		return ret;
 
-	sport->port_guid_id.wwn.priv = sport;
 	srpt_format_guid(sport->guid_name, ARRAY_SIZE(sport->guid_name),
 			 &sport->gid.global.interface_id);
-	memcpy(sport->port_guid_id.name, sport->guid_name,
-	       ARRAY_SIZE(sport->guid_name));
-	sport->port_gid_id.wwn.priv = sport;
 	snprintf(sport->gid_name, ARRAY_SIZE(sport->gid_name),
 		 "0x%016llx%016llx",
 		 be64_to_cpu(sport->gid.global.subnet_prefix),
 		 be64_to_cpu(sport->gid.global.interface_id));
-	memcpy(sport->port_gid_id.name, sport->gid_name,
-	       ARRAY_SIZE(sport->gid_name));
 
 	if (rdma_protocol_iwarp(sport->sdev->device, sport->port))
 		return 0;
@@ -2317,31 +2311,35 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 	tag_num = ch->rq_size;
 	tag_size = 1; /* ib_srpt does not use se_sess->sess_cmd_map */
 
-	mutex_lock(&sport->port_guid_id.mutex);
-	list_for_each_entry(stpg, &sport->port_guid_id.tpg_list, entry) {
-		if (!IS_ERR_OR_NULL(ch->sess))
-			break;
-		ch->sess = target_setup_session(&stpg->tpg, tag_num,
+	if (sport->guid_id) {
+		mutex_lock(&sport->guid_id->mutex);
+		list_for_each_entry(stpg, &sport->guid_id->tpg_list, entry) {
+			if (!IS_ERR_OR_NULL(ch->sess))
+				break;
+			ch->sess = target_setup_session(&stpg->tpg, tag_num,
 						tag_size, TARGET_PROT_NORMAL,
 						ch->sess_name, ch, NULL);
+		}
+		mutex_unlock(&sport->guid_id->mutex);
 	}
-	mutex_unlock(&sport->port_guid_id.mutex);
 
-	mutex_lock(&sport->port_gid_id.mutex);
-	list_for_each_entry(stpg, &sport->port_gid_id.tpg_list, entry) {
-		if (!IS_ERR_OR_NULL(ch->sess))
-			break;
-		ch->sess = target_setup_session(&stpg->tpg, tag_num,
+	if (sport->gid_id) {
+		mutex_lock(&sport->gid_id->mutex);
+		list_for_each_entry(stpg, &sport->gid_id->tpg_list, entry) {
+			if (!IS_ERR_OR_NULL(ch->sess))
+				break;
+			ch->sess = target_setup_session(&stpg->tpg, tag_num,
 					tag_size, TARGET_PROT_NORMAL, i_port_id,
 					ch, NULL);
-		if (!IS_ERR_OR_NULL(ch->sess))
-			break;
-		/* Retry without leading "0x" */
-		ch->sess = target_setup_session(&stpg->tpg, tag_num,
+			if (!IS_ERR_OR_NULL(ch->sess))
+				break;
+			/* Retry without leading "0x" */
+			ch->sess = target_setup_session(&stpg->tpg, tag_num,
 						tag_size, TARGET_PROT_NORMAL,
 						i_port_id + 2, ch, NULL);
+		}
+		mutex_unlock(&sport->gid_id->mutex);
 	}
-	mutex_unlock(&sport->port_gid_id.mutex);
 
 	if (IS_ERR_OR_NULL(ch->sess)) {
 		WARN_ON_ONCE(ch->sess == NULL);
@@ -2986,7 +2984,12 @@ static int srpt_release_sport(struct srpt_port *sport)
 	return 0;
 }
 
-static struct se_wwn *__srpt_lookup_wwn(const char *name)
+struct port_and_port_id {
+	struct srpt_port *sport;
+	struct srpt_port_id **port_id;
+};
+
+static struct port_and_port_id __srpt_lookup_port(const char *name)
 {
 	struct ib_device *dev;
 	struct srpt_device *sdev;
@@ -3001,25 +3004,38 @@ static struct se_wwn *__srpt_lookup_wwn(const char *name)
 		for (i = 0; i < dev->phys_port_cnt; i++) {
 			sport = &sdev->port[i];
 
-			if (strcmp(sport->port_guid_id.name, name) == 0)
-				return &sport->port_guid_id.wwn;
-			if (strcmp(sport->port_gid_id.name, name) == 0)
-				return &sport->port_gid_id.wwn;
+			if (strcmp(sport->guid_name, name) == 0) {
+				kref_get(&sdev->refcnt);
+				return (struct port_and_port_id){
+					sport, &sport->guid_id};
+			}
+			if (strcmp(sport->gid_name, name) == 0) {
+				kref_get(&sdev->refcnt);
+				return (struct port_and_port_id){
+					sport, &sport->gid_id};
+			}
 		}
 	}
 
-	return NULL;
+	return (struct port_and_port_id){};
 }
 
-static struct se_wwn *srpt_lookup_wwn(const char *name)
+/**
+ * srpt_lookup_port() - Look up an RDMA port by name
+ * @name: ASCII port name
+ *
+ * Increments the RDMA port reference count if an RDMA port pointer is returned.
+ * The caller must drop that reference count by calling srpt_port_put_ref().
+ */
+static struct port_and_port_id srpt_lookup_port(const char *name)
 {
-	struct se_wwn *wwn;
+	struct port_and_port_id papi;
 
 	spin_lock(&srpt_dev_lock);
-	wwn = __srpt_lookup_wwn(name);
+	papi = __srpt_lookup_port(name);
 	spin_unlock(&srpt_dev_lock);
 
-	return wwn;
+	return papi;
 }
 
 static void srpt_free_srq(struct srpt_device *sdev)
@@ -3198,10 +3214,6 @@ static int srpt_add_one(struct ib_device *device)
 		sport->port_attrib.srp_sq_size = DEF_SRPT_SQ_SIZE;
 		sport->port_attrib.use_srq = false;
 		INIT_WORK(&sport->work, srpt_refresh_port_work);
-		mutex_init(&sport->port_guid_id.mutex);
-		INIT_LIST_HEAD(&sport->port_guid_id.tpg_list);
-		mutex_init(&sport->port_gid_id.mutex);
-		INIT_LIST_HEAD(&sport->port_gid_id.tpg_list);
 
 		ret = srpt_refresh_port(sport);
 		if (ret) {
@@ -3302,10 +3314,10 @@ static struct srpt_port_id *srpt_wwn_to_sport_id(struct se_wwn *wwn)
 {
 	struct srpt_port *sport = wwn->priv;
 
-	if (wwn == &sport->port_guid_id.wwn)
-		return &sport->port_guid_id;
-	if (wwn == &sport->port_gid_id.wwn)
-		return &sport->port_gid_id;
+	if (sport->guid_id && &sport->guid_id->wwn == wwn)
+		return sport->guid_id;
+	if (sport->gid_id && &sport->gid_id->wwn == wwn)
+		return sport->gid_id;
 	WARN_ON_ONCE(true);
 	return NULL;
 }
@@ -3790,7 +3802,31 @@ static struct se_wwn *srpt_make_tport(struct target_fabric_configfs *tf,
 				      struct config_group *group,
 				      const char *name)
 {
-	return srpt_lookup_wwn(name) ? : ERR_PTR(-EINVAL);
+	struct port_and_port_id papi = srpt_lookup_port(name);
+	struct srpt_port *sport = papi.sport;
+	struct srpt_port_id *port_id;
+
+	if (!papi.port_id)
+		return ERR_PTR(-EINVAL);
+	if (*papi.port_id) {
+		/* Attempt to create a directory that already exists. */
+		WARN_ON_ONCE(true);
+		return &(*papi.port_id)->wwn;
+	}
+	port_id = kzalloc(sizeof(*port_id), GFP_KERNEL);
+	if (!port_id) {
+		srpt_sdev_put(sport->sdev);
+		return ERR_PTR(-ENOMEM);
+	}
+	mutex_init(&port_id->mutex);
+	INIT_LIST_HEAD(&port_id->tpg_list);
+	port_id->wwn.priv = sport;
+	memcpy(port_id->name, port_id == sport->guid_id ? sport->guid_name :
+	       sport->gid_name, ARRAY_SIZE(port_id->name));
+
+	*papi.port_id = port_id;
+
+	return &port_id->wwn;
 }
 
 /**
@@ -3799,6 +3835,18 @@ static struct se_wwn *srpt_make_tport(struct target_fabric_configfs *tf,
  */
 static void srpt_drop_tport(struct se_wwn *wwn)
 {
+	struct srpt_port_id *port_id = container_of(wwn, typeof(*port_id), wwn);
+	struct srpt_port *sport = wwn->priv;
+
+	if (sport->guid_id == port_id)
+		sport->guid_id = NULL;
+	else if (sport->gid_id == port_id)
+		sport->gid_id = NULL;
+	else
+		WARN_ON_ONCE(true);
+
+	srpt_sdev_put(sport->sdev);
+	kfree(port_id);
 }
 
 static ssize_t srpt_wwn_version_show(struct config_item *item, char *buf)
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/ulp/srpt/ib_srpt.h
index 0cb867d580f1..4c46b301eea1 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.h
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
@@ -393,7 +393,7 @@ struct srpt_port_id {
 };
 
 /**
- * struct srpt_port - information associated by SRPT with a single IB port
+ * struct srpt_port - SRPT RDMA port information
  * @sdev:      backpointer to the HCA information.
  * @mad_agent: per-port management datagram processing information.
  * @enabled:   Whether or not this target port is enabled.
@@ -403,9 +403,9 @@ struct srpt_port_id {
  * @gid:       cached value of the port's gid.
  * @work:      work structure for refreshing the aforementioned cached values.
  * @guid_name: port name in GUID format.
- * @port_guid_id: LIO target port information for the port name in GUID format.
+ * @guid_id:   LIO target port information for the port name in GUID format.
  * @gid_name:  port name in GID format.
- * @port_gid_id: LIO target port information for the port name in GID format.
+ * @gid_id:    LIO target port information for the port name in GID format.
  * @port_attrib:   Port attributes that can be accessed through configfs.
  * @refcount:	   Number of objects associated with this port.
  * @freed_channels: Completion that will be signaled once @refcount becomes 0.
@@ -422,9 +422,9 @@ struct srpt_port {
 	union ib_gid		gid;
 	struct work_struct	work;
 	char			guid_name[64];
-	struct srpt_port_id	port_guid_id;
+	struct srpt_port_id	*guid_id;
 	char			gid_name[64];
-	struct srpt_port_id	port_gid_id;
+	struct srpt_port_id	*gid_id;
 	struct srpt_port_attrib port_attrib;
 	atomic_t		refcount;
 	struct completion	*freed_channels;
