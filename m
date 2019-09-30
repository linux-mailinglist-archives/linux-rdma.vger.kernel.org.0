Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E067C2ABE
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 01:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbfI3XRj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Sep 2019 19:17:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33345 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731985AbfI3XRj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Sep 2019 19:17:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id q1so219535pgb.0
        for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2019 16:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZxzmWX7e/SWmX32qz7KUHQIKpenE+NZIccmezNq7Fu4=;
        b=Ez5u3cM2k8Lo/6tTO2gOe95ajZqE+SvZW4tZJaM2JC0HiKaiNLiRxHfy60qFb5YR70
         Eoz0aGG6Ar9u5XDzBlA4ufpN/YTp1tdGlhB1+xMLdLi26stwCrWtkXkEltiN82qjcc3e
         PWYvGSVfbssfi4QoE6Wwq6b/X0VXbgpQkOTT1Hmzok7EKs/6VyHRXBEfAk12s3armcMH
         qIE3hFata7aFWCktP3K7WjEIFSfPjPzQ3TlDWREEphHYL4+MxII+zD7gjSCt3H+QZgwM
         PcwgH8Ezji6iJBkIOQ1tSFr9G63QNhFUN6GCrGr3B5sVD8/7Dw8NlbDUmSErzWZTEDu4
         e6Xw==
X-Gm-Message-State: APjAAAVmdhwWP2atmax1+mRKB8/xeUcRa045ib39hIrgUGedKn83HbXW
        mrDmUdWtCUQAeelpOn1Mo10=
X-Google-Smtp-Source: APXvYqwFZetuCGjw2KYGmQMZrCJYeDw4utpXRg6s7VvQ2/R9qxMl44beHoB4huMyDJXl03Xtx2penw==
X-Received: by 2002:a17:90a:17c5:: with SMTP id q63mr1958415pja.106.1569885458270;
        Mon, 30 Sep 2019 16:17:38 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l7sm585406pjy.12.2019.09.30.16.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:17:37 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Honggang LI <honli@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: [PATCH 14/15] RDMA/srpt: Make the code for handling port identities more systematic
Date:   Mon, 30 Sep 2019 16:17:06 -0700
Message-Id: <20190930231707.48259-15-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190930231707.48259-1-bvanassche@acm.org>
References: <20190930231707.48259-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Introduce a new data structure for the information about an RDMA port
name. This patch does not change any functionality.

Cc: Honggang LI <honli@redhat.com>
Cc: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 64 +++++++++++++++++----------
 drivers/infiniband/ulp/srpt/ib_srpt.h | 25 +++++++----
 2 files changed, 57 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 5e402f7b9692..0582b3d4ec4d 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -567,11 +567,12 @@ static int srpt_refresh_port(struct srpt_port *sport)
 	if (ret)
 		return ret;
 
-	sport->port_guid_wwn.priv = sport;
-	srpt_format_guid(sport->port_guid, sizeof(sport->port_guid),
+	sport->port_guid_id.wwn.priv = sport;
+	srpt_format_guid(sport->port_guid_id.name,
+			 sizeof(sport->port_guid_id.name),
 			 &sport->gid.global.interface_id);
-	sport->port_gid_wwn.priv = sport;
-	snprintf(sport->port_gid, sizeof(sport->port_gid),
+	sport->port_gid_id.wwn.priv = sport;
+	snprintf(sport->port_gid_id.name, sizeof(sport->port_gid_id.name),
 		 "0x%016llx%016llx",
 		 be64_to_cpu(sport->gid.global.subnet_prefix),
 		 be64_to_cpu(sport->gid.global.interface_id));
@@ -2287,17 +2288,17 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 
 	tag_num = ch->rq_size;
 	tag_size = 1; /* ib_srpt does not use se_sess->sess_cmd_map */
-	if (sport->port_guid_tpg.se_tpg_wwn)
-		ch->sess = target_setup_session(&sport->port_guid_tpg, tag_num,
+	if (sport->port_guid_id.tpg.se_tpg_wwn)
+		ch->sess = target_setup_session(&sport->port_guid_id.tpg, tag_num,
 						tag_size, TARGET_PROT_NORMAL,
 						ch->sess_name, ch, NULL);
-	if (sport->port_gid_tpg.se_tpg_wwn && IS_ERR_OR_NULL(ch->sess))
-		ch->sess = target_setup_session(&sport->port_gid_tpg, tag_num,
+	if (sport->port_gid_id.tpg.se_tpg_wwn && IS_ERR_OR_NULL(ch->sess))
+		ch->sess = target_setup_session(&sport->port_gid_id.tpg, tag_num,
 					tag_size, TARGET_PROT_NORMAL, i_port_id,
 					ch, NULL);
 	/* Retry without leading "0x" */
-	if (sport->port_gid_tpg.se_tpg_wwn && IS_ERR_OR_NULL(ch->sess))
-		ch->sess = target_setup_session(&sport->port_gid_tpg, tag_num,
+	if (sport->port_gid_id.tpg.se_tpg_wwn && IS_ERR_OR_NULL(ch->sess))
+		ch->sess = target_setup_session(&sport->port_gid_id.tpg, tag_num,
 						tag_size, TARGET_PROT_NORMAL,
 						i_port_id + 2, ch, NULL);
 	if (IS_ERR_OR_NULL(ch->sess)) {
@@ -2959,10 +2960,10 @@ static struct se_wwn *__srpt_lookup_wwn(const char *name)
 		for (i = 0; i < dev->phys_port_cnt; i++) {
 			sport = &sdev->port[i];
 
-			if (strcmp(sport->port_guid, name) == 0)
-				return &sport->port_guid_wwn;
-			if (strcmp(sport->port_gid, name) == 0)
-				return &sport->port_gid_wwn;
+			if (strcmp(sport->port_guid_id.name, name) == 0)
+				return &sport->port_guid_id.wwn;
+			if (strcmp(sport->port_gid_id.name, name) == 0)
+				return &sport->port_gid_id.wwn;
 		}
 	}
 
@@ -3241,14 +3242,33 @@ static struct srpt_port *srpt_tpg_to_sport(struct se_portal_group *tpg)
 	return tpg->se_tpg_wwn->priv;
 }
 
-static char *srpt_get_fabric_wwn(struct se_portal_group *tpg)
+static struct srpt_port_id *srpt_tpg_to_sport_id(struct se_portal_group *tpg)
 {
 	struct srpt_port *sport = srpt_tpg_to_sport(tpg);
 
-	WARN_ON_ONCE(tpg != &sport->port_guid_tpg &&
-		     tpg != &sport->port_gid_tpg);
-	return tpg == &sport->port_guid_tpg ? sport->port_guid :
-		sport->port_gid;
+	if (tpg == &sport->port_guid_id.tpg)
+		return &sport->port_guid_id;
+	if (tpg == &sport->port_gid_id.tpg)
+		return &sport->port_gid_id;
+	WARN_ON_ONCE(true);
+	return NULL;
+}
+
+static struct srpt_port_id *srpt_wwn_to_sport_id(struct se_wwn *wwn)
+{
+	struct srpt_port *sport = wwn->priv;
+
+	if (wwn == &sport->port_guid_id.wwn)
+		return &sport->port_guid_id;
+	if (wwn == &sport->port_gid_id.wwn)
+		return &sport->port_gid_id;
+	WARN_ON_ONCE(true);
+	return NULL;
+}
+
+static char *srpt_get_fabric_wwn(struct se_portal_group *tpg)
+{
+	return srpt_tpg_to_sport_id(tpg)->name;
 }
 
 static u16 srpt_get_tag(struct se_portal_group *tpg)
@@ -3705,13 +3725,9 @@ static struct se_portal_group *srpt_make_tpg(struct se_wwn *wwn,
 					     const char *name)
 {
 	struct srpt_port *sport = wwn->priv;
-	struct se_portal_group *tpg;
+	struct se_portal_group *tpg = &srpt_wwn_to_sport_id(wwn)->tpg;
 	int res;
 
-	WARN_ON_ONCE(wwn != &sport->port_guid_wwn &&
-		     wwn != &sport->port_gid_wwn);
-	tpg = wwn == &sport->port_guid_wwn ? &sport->port_guid_tpg :
-		&sport->port_gid_tpg;
 	res = core_tpg_register(wwn, tpg, SCSI_PROTOCOL_SRP);
 	if (res)
 		return ERR_PTR(res);
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/ulp/srpt/ib_srpt.h
index f3df791dd877..f8bd95302ac0 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.h
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
@@ -363,13 +363,26 @@ struct srpt_port_attrib {
 	bool			use_srq;
 };
 
+/**
+ * struct srpt_port_id - information about an RDMA port name
+ * @tpg: TPG associated with the RDMA port.
+ * @wwn: WWN associated with the RDMA port.
+ * @name: ASCII representation of the port name.
+ *
+ * Multiple sysfs directories can be associated with a single RDMA port. This
+ * data structure represents a single (port, name) pair.
+ */
+struct srpt_port_id {
+	struct se_portal_group	tpg;
+	struct se_wwn		wwn;
+	char			name[64];
+};
+
 /**
  * struct srpt_port - information associated by SRPT with a single IB port
  * @sdev:      backpointer to the HCA information.
  * @mad_agent: per-port management datagram processing information.
  * @enabled:   Whether or not this target port is enabled.
- * @port_guid: ASCII representation of Port GUID
- * @port_gid:  ASCII representation of Port GID
  * @port:      one-based port number.
  * @sm_lid:    cached value of the port's sm_lid.
  * @lid:       cached value of the port's lid.
@@ -390,17 +403,13 @@ struct srpt_port {
 	struct srpt_device	*sdev;
 	struct ib_mad_agent	*mad_agent;
 	bool			enabled;
-	u8			port_guid[24];
-	u8			port_gid[64];
 	u8			port;
 	u32			sm_lid;
 	u32			lid;
 	union ib_gid		gid;
 	struct work_struct	work;
-	struct se_portal_group	port_guid_tpg;
-	struct se_wwn		port_guid_wwn;
-	struct se_portal_group	port_gid_tpg;
-	struct se_wwn		port_gid_wwn;
+	struct srpt_port_id	port_guid_id;
+	struct srpt_port_id	port_gid_id;
 	struct srpt_port_attrib port_attrib;
 	atomic_t		refcount;
 	struct completion	*freed_channels;
-- 
2.23.0.444.g18eeb5a265-goog

