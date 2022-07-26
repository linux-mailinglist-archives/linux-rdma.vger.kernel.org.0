Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B024581BA5
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jul 2022 23:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbiGZVWN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jul 2022 17:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239648AbiGZVWM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jul 2022 17:22:12 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D4B2E9EE
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jul 2022 14:22:10 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id g12so14354378pfb.3
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jul 2022 14:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9EUHclYJWiklrf3SOzWOhs0p776MYywYcomlraMfTXU=;
        b=Oh3f5D0dkZwpb84B7gPp3wI89KK8vhZOuzINV1BaXfTjRlEME/w33MryiXyVBslkgw
         D9z9fgku4UsTmTDfytJQmIMnX3YNhNsei8teQT1GSEOrdpZ6YtzMK4InZlNq4lfL48gs
         uhQopV9XF2/tYU528XWQx80d4aVki79fwccC1MH9hzcce0LK8ucg2PvXZdBnLSzHZYwr
         cF10qZRI/iLzbgx+yWyNc5zei2vnfy02me1cRxJr/0w1SYJtds/MqcVzj85rNrLpKWAq
         Zm4lKLrwLIpaMKpqFhwXOCcBgsCHmolzN53RIaHukjE4n+xNzvuzbDZnfipr+HRYgqmV
         UFTQ==
X-Gm-Message-State: AJIora/Dk6bH0LmtZt9XU9GWoIb61jFoh0Bo8w2SiTNRZhzxU/3Sr/qw
        +V7y2mV7qQRwi/1Jwl6gBvo=
X-Google-Smtp-Source: AGRyM1v+2PNTO73u5AODRFQWH54xSHYs5jJlIwlJBSDwvkgkl2Y/iYIw8T7eV6pRjGVrBkBz0zux3A==
X-Received: by 2002:a63:504c:0:b0:419:d02e:f42a with SMTP id q12-20020a63504c000000b00419d02ef42amr15816940pgl.566.1658870529992;
        Tue, 26 Jul 2022 14:22:09 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:34f4:7aa8:57:d456])
        by smtp.gmail.com with ESMTPSA id g5-20020aa796a5000000b00528999fba99sm12398983pfk.175.2022.07.26.14.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 14:22:09 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>,
        Hillf Danton <hdanton@sina.com>,
        Mike Christie <michael.christie@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 3/3] RDMA/srpt: Fix a use-after-free
Date:   Tue, 26 Jul 2022 14:21:56 -0700
Message-Id: <20220726212156.1318010-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
In-Reply-To: <20220726212156.1318010-1-bvanassche@acm.org>
References: <20220726212156.1318010-1-bvanassche@acm.org>
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
Cc: Li Zhijian <lizhijian@fujitsu.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 133 ++++++++++++++++++--------
 drivers/infiniband/ulp/srpt/ib_srpt.h |  10 +-
 2 files changed, 96 insertions(+), 47 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 1fbce9225424..8d9eb1210d3b 100644
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
@@ -3295,6 +3307,7 @@ static int srpt_check_false(struct se_portal_group *se_tpg)
 
 static struct srpt_port *srpt_tpg_to_sport(struct se_portal_group *tpg)
 {
+	BUG_ON(!tpg->se_tpg_wwn->priv);
 	return tpg->se_tpg_wwn->priv;
 }
 
@@ -3302,11 +3315,11 @@ static struct srpt_port_id *srpt_wwn_to_sport_id(struct se_wwn *wwn)
 {
 	struct srpt_port *sport = wwn->priv;
 
-	if (wwn == &sport->port_guid_id.wwn)
-		return &sport->port_guid_id;
-	if (wwn == &sport->port_gid_id.wwn)
-		return &sport->port_gid_id;
-	WARN_ON_ONCE(true);
+	BUG_ON(!sport);
+	if (sport->guid_id && &sport->guid_id->wwn == wwn)
+		return sport->guid_id;
+	if (sport->gid_id && &sport->gid_id->wwn == wwn)
+		return sport->gid_id;
 	return NULL;
 }
 
@@ -3744,6 +3757,10 @@ static struct se_portal_group *srpt_make_tpg(struct se_wwn *wwn,
 	struct srpt_tpg *stpg;
 	int res = -ENOMEM;
 
+	if (!sport_id) {
+		pr_err("RDMA port does not exist\n");
+		return ERR_PTR(-EINVAL);
+	}
 	stpg = kzalloc(sizeof(*stpg), GFP_KERNEL);
 	if (!stpg)
 		return ERR_PTR(res);
@@ -3790,7 +3807,28 @@ static struct se_wwn *srpt_make_tport(struct target_fabric_configfs *tf,
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
+	if (*papi.port_id)
+		return &(*papi.port_id)->wwn;
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
@@ -3799,6 +3837,17 @@ static struct se_wwn *srpt_make_tport(struct target_fabric_configfs *tf,
  */
 static void srpt_drop_tport(struct se_wwn *wwn)
 {
+	struct srpt_port_id *port_id = container_of(wwn, typeof(*port_id), wwn);
+	struct srpt_port *sport = wwn->priv;
+
+	BUG_ON(!sport);
+	if (sport->guid_id == port_id)
+		sport->guid_id = NULL;
+	else if (sport->gid_id == port_id)
+		sport->gid_id = NULL;
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
