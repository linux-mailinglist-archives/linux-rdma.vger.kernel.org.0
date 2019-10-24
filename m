Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF73E24B1
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 22:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733071AbfJWUlO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 16:41:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42114 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732293AbfJWUlO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 16:41:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id 21so2389785pfj.9
        for <linux-rdma@vger.kernel.org>; Wed, 23 Oct 2019 13:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z67jKGEQkmm8jqRe/yiyRCitZv3IsFgtYUS4Nu+P5Lc=;
        b=rI5xFWmiujG07keD6yM0j5Xfk33aEQcGN1RSNAvZcSL2jVLKeUU26vKzK19ADPfIeq
         fP5dgJ6eqofyBwH9En0EL8xUiEytEAuxcYpppj/vljGZ3Urr3MuwoVSw3tba5HpsB3Wr
         RxPpBsnTjH8dPg94BMQF0rdCubgS6aF9SNBRhR0/JMJnqKr4JbffFt8Da8hI1GqyjCms
         W0Kc9GYMQykd6R6hzKhTp2hvl+QLD356fED2XW984jwudfEF65actH2fcUA3Kca60prJ
         Oj1+s0zenUljETPfbovzObZXSDWGSDd0JbdQbxI1OEs2VzADnpf6iKDs1hIMRdW0lQlb
         1j+Q==
X-Gm-Message-State: APjAAAUPhXmoKwXjo3ItUafK6AhtOmQsnLTlCAkQu0VcM1aSWjy+RZN+
        53SuKoTTo/CI+em0gYGix6SLBD6C
X-Google-Smtp-Source: APXvYqw086EePie4zYr6LaBbj5zNjy4RA9vlu1CkvHnIPZVJeNeRdemU4rDAADAB+GQ/pF3SmDJjxw==
X-Received: by 2002:a63:471b:: with SMTP id u27mr11922489pga.96.1571863273181;
        Wed, 23 Oct 2019 13:41:13 -0700 (PDT)
Received: from localhost.net ([2601:647:4000:c3:e5ef:65f1:8f3f:3a78])
        by smtp.gmail.com with ESMTPSA id 4sm9437605pfz.185.2019.10.23.13.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 13:41:12 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Honggang LI <honli@redhat.com>
Subject: [PATCH] RDMA/srpt: Fix TPG creation
Date:   Wed, 23 Oct 2019 13:41:06 -0700
Message-Id: <20191023204106.23326-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Unlike the iSCSI target driver, for the SRP target driver it is sufficient
if a single TPG can be associated with each RDMA port name. However, users
started associating multiple TPGs with RDMA port names. Support this by
converting the single TPG in struct srpt_port_id into a list. This patch
fixes the following list corruption issue:

list_add corruption. prev->next should be next (ffffffffc0a080c0), but was ffffa08a994ce6f0. (prev=ffffa08a994ce6f0).
WARNING: CPU: 2 PID: 2597 at lib/list_debug.c:28 __list_add_valid+0x6a/0x70
CPU: 2 PID: 2597 Comm: targetcli Not tainted 5.4.0-rc1.3bfa3c9602a7 #1
RIP: 0010:__list_add_valid+0x6a/0x70
Call Trace:
 core_tpg_register+0x116/0x200 [target_core_mod]
 srpt_make_tpg+0x3f/0x60 [ib_srpt]
 target_fabric_make_tpg+0x41/0x290 [target_core_mod]
 configfs_mkdir+0x158/0x3e0
 vfs_mkdir+0x108/0x1a0
 do_mkdirat+0x77/0xe0
 do_syscall_64+0x55/0x1d0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Cc: Honggang LI <honli@redhat.com>
Reported-by: Honggang LI <honli@redhat.com>
Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 77 ++++++++++++++++++---------
 drivers/infiniband/ulp/srpt/ib_srpt.h | 25 +++++++--
 2 files changed, 73 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index daf811abf40a..a278e76b9e02 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2131,6 +2131,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 	char i_port_id[36];
 	u32 it_iu_len;
 	int i, tag_num, tag_size, ret;
+	struct srpt_tpg *stpg;
 
 	WARN_ON_ONCE(irqs_disabled());
 
@@ -2288,19 +2289,33 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 
 	tag_num = ch->rq_size;
 	tag_size = 1; /* ib_srpt does not use se_sess->sess_cmd_map */
-	if (sport->port_guid_id.tpg.se_tpg_wwn)
-		ch->sess = target_setup_session(&sport->port_guid_id.tpg, tag_num,
+
+	mutex_lock(&sport->port_guid_id.mutex);
+	list_for_each_entry(stpg, &sport->port_guid_id.tpg_list, entry) {
+		if (!IS_ERR_OR_NULL(ch->sess))
+			break;
+		ch->sess = target_setup_session(&stpg->tpg, tag_num,
 						tag_size, TARGET_PROT_NORMAL,
 						ch->sess_name, ch, NULL);
-	if (sport->port_gid_id.tpg.se_tpg_wwn && IS_ERR_OR_NULL(ch->sess))
-		ch->sess = target_setup_session(&sport->port_gid_id.tpg, tag_num,
+	}
+	mutex_unlock(&sport->port_guid_id.mutex);
+
+	mutex_lock(&sport->port_gid_id.mutex);
+	list_for_each_entry(stpg, &sport->port_gid_id.tpg_list, entry) {
+		if (!IS_ERR_OR_NULL(ch->sess))
+			break;
+		ch->sess = target_setup_session(&stpg->tpg, tag_num,
 					tag_size, TARGET_PROT_NORMAL, i_port_id,
 					ch, NULL);
-	/* Retry without leading "0x" */
-	if (sport->port_gid_id.tpg.se_tpg_wwn && IS_ERR_OR_NULL(ch->sess))
-		ch->sess = target_setup_session(&sport->port_gid_id.tpg, tag_num,
+		if (!IS_ERR_OR_NULL(ch->sess))
+			break;
+		/* Retry without leading "0x" */
+		ch->sess = target_setup_session(&stpg->tpg, tag_num,
 						tag_size, TARGET_PROT_NORMAL,
 						i_port_id + 2, ch, NULL);
+	}
+	mutex_unlock(&sport->port_gid_id.mutex);
+
 	if (IS_ERR_OR_NULL(ch->sess)) {
 		WARN_ON_ONCE(ch->sess == NULL);
 		ret = PTR_ERR(ch->sess);
@@ -3140,6 +3155,10 @@ static void srpt_add_one(struct ib_device *device)
 		sport->port_attrib.srp_sq_size = DEF_SRPT_SQ_SIZE;
 		sport->port_attrib.use_srq = false;
 		INIT_WORK(&sport->work, srpt_refresh_port_work);
+		mutex_init(&sport->port_guid_id.mutex);
+		INIT_LIST_HEAD(&sport->port_guid_id.tpg_list);
+		mutex_init(&sport->port_gid_id.mutex);
+		INIT_LIST_HEAD(&sport->port_gid_id.tpg_list);
 
 		if (srpt_refresh_port(sport)) {
 			pr_err("MAD registration failed for %s-%d.\n",
@@ -3242,18 +3261,6 @@ static struct srpt_port *srpt_tpg_to_sport(struct se_portal_group *tpg)
 	return tpg->se_tpg_wwn->priv;
 }
 
-static struct srpt_port_id *srpt_tpg_to_sport_id(struct se_portal_group *tpg)
-{
-	struct srpt_port *sport = srpt_tpg_to_sport(tpg);
-
-	if (tpg == &sport->port_guid_id.tpg)
-		return &sport->port_guid_id;
-	if (tpg == &sport->port_gid_id.tpg)
-		return &sport->port_gid_id;
-	WARN_ON_ONCE(true);
-	return NULL;
-}
-
 static struct srpt_port_id *srpt_wwn_to_sport_id(struct se_wwn *wwn)
 {
 	struct srpt_port *sport = wwn->priv;
@@ -3268,7 +3275,9 @@ static struct srpt_port_id *srpt_wwn_to_sport_id(struct se_wwn *wwn)
 
 static char *srpt_get_fabric_wwn(struct se_portal_group *tpg)
 {
-	return srpt_tpg_to_sport_id(tpg)->name;
+	struct srpt_tpg *stpg = container_of(tpg, typeof(*stpg), tpg);
+
+	return stpg->sport_id->name;
 }
 
 static u16 srpt_get_tag(struct se_portal_group *tpg)
@@ -3725,16 +3734,27 @@ static struct se_portal_group *srpt_make_tpg(struct se_wwn *wwn,
 					     const char *name)
 {
 	struct srpt_port *sport = wwn->priv;
-	struct se_portal_group *tpg = &srpt_wwn_to_sport_id(wwn)->tpg;
-	int res;
+	struct srpt_port_id *sport_id = srpt_wwn_to_sport_id(wwn);
+	struct srpt_tpg *stpg;
+	int res = -ENOMEM;
 
-	res = core_tpg_register(wwn, tpg, SCSI_PROTOCOL_SRP);
-	if (res)
+	stpg = kzalloc(sizeof(*stpg), GFP_KERNEL);
+	if (!stpg)
+		return ERR_PTR(res);
+	stpg->sport_id = sport_id;
+	res = core_tpg_register(wwn, &stpg->tpg, SCSI_PROTOCOL_SRP);
+	if (res) {
+		kfree(stpg);
 		return ERR_PTR(res);
+	}
+
+	mutex_lock(&sport_id->mutex);
+	list_add_tail(&stpg->entry, &sport_id->tpg_list);
+	mutex_unlock(&sport_id->mutex);
 
 	atomic_inc(&sport->refcount);
 
-	return tpg;
+	return &stpg->tpg;
 }
 
 /**
@@ -3743,10 +3763,17 @@ static struct se_portal_group *srpt_make_tpg(struct se_wwn *wwn,
  */
 static void srpt_drop_tpg(struct se_portal_group *tpg)
 {
+	struct srpt_tpg *stpg = container_of(tpg, typeof(*stpg), tpg);
+	struct srpt_port_id *sport_id = stpg->sport_id;
 	struct srpt_port *sport = srpt_tpg_to_sport(tpg);
 
+	mutex_lock(&sport_id->mutex);
+	list_del(&stpg->entry);
+	mutex_unlock(&sport_id->mutex);
+
 	sport->enabled = false;
 	core_tpg_deregister(tpg);
+	kfree(stpg);
 	srpt_drop_sport_ref(sport);
 }
 
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/ulp/srpt/ib_srpt.h
index f8bd95302ac0..27a54f777e3b 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.h
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
@@ -363,17 +363,34 @@ struct srpt_port_attrib {
 	bool			use_srq;
 };
 
+/**
+ * struct srpt_tpg - information about a single "target portal group"
+ * @entry:	Entry in @sport_id->tpg_list.
+ * @sport_id:	Port name this TPG is associated with.
+ * @tpg:	LIO TPG data structure.
+ *
+ * Zero or more target portal groups are associated with each port name
+ * (srpt_port_id). With each TPG an ACL list is associated.
+ */
+struct srpt_tpg {
+	struct list_head	entry;
+	struct srpt_port_id	*sport_id;
+	struct se_portal_group	tpg;
+};
+
 /**
  * struct srpt_port_id - information about an RDMA port name
- * @tpg: TPG associated with the RDMA port.
- * @wwn: WWN associated with the RDMA port.
- * @name: ASCII representation of the port name.
+ * @mutex:	Protects @tpg_list changes.
+ * @tpg_list:	TPGs associated with the RDMA port name.
+ * @wwn:	WWN associated with the RDMA port name.
+ * @name:	ASCII representation of the port name.
  *
  * Multiple sysfs directories can be associated with a single RDMA port. This
  * data structure represents a single (port, name) pair.
  */
 struct srpt_port_id {
-	struct se_portal_group	tpg;
+	struct mutex		mutex;
+	struct list_head	tpg_list;
 	struct se_wwn		wwn;
 	char			name[64];
 };
-- 
2.23.0

