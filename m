Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171204D682D
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Mar 2022 18:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350503AbiCKR6x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Mar 2022 12:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350753AbiCKR6v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Mar 2022 12:58:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8A9A6CA41
        for <linux-rdma@vger.kernel.org>; Fri, 11 Mar 2022 09:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647021465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DVUBQ8FL4Hl/Ia3M5AmEcx8HiUggiZTeBF+BAgzy4rs=;
        b=S1/ZQ/PHW7AL7q6T5rde1jF1Hql+jecinOyvyxqxaY/26Huw6VKEggF705XLY1/VtBAIKS
        Wui/WB/CgCjnjXR7VARqRPWEKI6kVBdakj9vB2jdFsK2SiY88hVTiMWn/U3PGT517AIm4i
        6IlzbGUsP4GaqgIWpWMOBla2OBv8zyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-RMK7YtYSNEaDzeJ58SHfMQ-1; Fri, 11 Mar 2022 12:57:44 -0500
X-MC-Unique: RMK7YtYSNEaDzeJ58SHfMQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 573DE1006AA6;
        Fri, 11 Mar 2022 17:57:43 +0000 (UTC)
Received: from gluttony.redhat.com (unknown [10.22.19.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6EB68825ED;
        Fri, 11 Mar 2022 17:57:42 +0000 (UTC)
From:   David Jeffery <djeffery@redhat.com>
To:     linux-rdma@vger.kernel.org
Cc:     target-devel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Laurence Oberman <loberman@redhat.com>,
        David Jeffery <djeffery@redhat.com>
Subject: [PATCH 2/2] iscsit: increment max_cmd_sn for isert on command release
Date:   Fri, 11 Mar 2022 12:57:13 -0500
Message-Id: <20220311175713.2344960-3-djeffery@redhat.com>
In-Reply-To: <20220311175713.2344960-1-djeffery@redhat.com>
References: <20220311175713.2344960-1-djeffery@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

iscsit with isert currently can suffer a rare deadlock due to how rdma
delays the release of an iscsi_cmd. Because max_cmd_sn is increased and
sent to the initiator before the last rdma completes, iscsit can end up in
a state where all iscsi_cmd structs are active even though the number is
more than double the iscsi window.

Once out of iscsi_cmd structs, isert then deadlocks trying to receive new
commands. It waits for an iscsi_cmd to become available, but the wait also
blocks processing for receiving completion events which would release an
iscsi_cmd waiting on rdma to finish. So neither can advance.

This patch avoids the deadlock state by delaying the increase to max_cmd_sn
until an iscsi_cmd is released. In this way, the number of iscsi_cmd
structs in use for SCSI commands will be limited to the iscsi window size.

An unsolicited NOPIN is then used to inform the initiator of changes to
max_cmd_sn should the difference between the internal value and the value
the initiator has been informed of grow too large (currently set to half
the window).

Signed-off-by: David Jeffery <djeffery@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
---
 drivers/target/iscsi/iscsi_target.c        | 18 +++++------
 drivers/target/iscsi/iscsi_target_device.c | 35 +++++++++++++++++++++-
 drivers/target/iscsi/iscsi_target_login.c  |  1 +
 drivers/target/iscsi/iscsi_target_util.c   |  5 +++-
 drivers/target/iscsi/iscsi_target_util.h   |  1 +
 include/target/iscsi/iscsi_target_core.h   |  8 +++++
 include/target/iscsi/iscsi_transport.h     |  1 +
 7 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 2c54c5d8412d..f67e909c5546 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -2757,7 +2757,7 @@ static int iscsit_send_conn_drop_async_message(
 	cmd->stat_sn		= conn->stat_sn++;
 	hdr->statsn		= cpu_to_be32(cmd->stat_sn);
 	hdr->exp_cmdsn		= cpu_to_be32(conn->sess->exp_cmd_sn);
-	hdr->max_cmdsn		= cpu_to_be32((u32) atomic_read(&conn->sess->max_cmd_sn));
+	iscsit_set_max_cmdsn(hdr, conn);
 	hdr->async_event	= ISCSI_ASYNC_MSG_DROPPING_CONNECTION;
 	hdr->param1		= cpu_to_be16(cmd->logout_cid);
 	hdr->param2		= cpu_to_be16(conn->sess->sess_ops->DefaultTime2Wait);
@@ -2815,7 +2815,7 @@ iscsit_build_datain_pdu(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
 		hdr->statsn		= cpu_to_be32(0xFFFFFFFF);
 
 	hdr->exp_cmdsn		= cpu_to_be32(conn->sess->exp_cmd_sn);
-	hdr->max_cmdsn		= cpu_to_be32((u32) atomic_read(&conn->sess->max_cmd_sn));
+	iscsit_set_max_cmdsn(hdr, conn);
 	hdr->datasn		= cpu_to_be32(datain->data_sn);
 	hdr->offset		= cpu_to_be32(datain->offset);
 
@@ -2970,7 +2970,7 @@ iscsit_build_logout_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
 
 	iscsit_increment_maxcmdsn(cmd, conn->sess);
 	hdr->exp_cmdsn		= cpu_to_be32(conn->sess->exp_cmd_sn);
-	hdr->max_cmdsn		= cpu_to_be32((u32) atomic_read(&conn->sess->max_cmd_sn));
+	iscsit_set_max_cmdsn(hdr, conn);
 
 	pr_debug("Built Logout Response ITT: 0x%08x StatSN:"
 		" 0x%08x Response: 0x%02x CID: %hu on CID: %hu\n",
@@ -3013,7 +3013,7 @@ iscsit_build_nopin_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
 		iscsit_increment_maxcmdsn(cmd, conn->sess);
 
 	hdr->exp_cmdsn		= cpu_to_be32(conn->sess->exp_cmd_sn);
-	hdr->max_cmdsn		= cpu_to_be32((u32) atomic_read(&conn->sess->max_cmd_sn));
+	iscsit_set_max_cmdsn(hdr, conn);
 
 	pr_debug("Built NOPIN %s Response ITT: 0x%08x, TTT: 0x%08x,"
 		" StatSN: 0x%08x, Length %u\n", (nopout_response) ?
@@ -3094,7 +3094,7 @@ static int iscsit_send_r2t(
 	hdr->ttt		= cpu_to_be32(r2t->targ_xfer_tag);
 	hdr->statsn		= cpu_to_be32(conn->stat_sn);
 	hdr->exp_cmdsn		= cpu_to_be32(conn->sess->exp_cmd_sn);
-	hdr->max_cmdsn		= cpu_to_be32((u32) atomic_read(&conn->sess->max_cmd_sn));
+	iscsit_set_max_cmdsn(hdr, conn);
 	hdr->r2tsn		= cpu_to_be32(r2t->r2t_sn);
 	hdr->data_offset	= cpu_to_be32(r2t->offset);
 	hdr->data_length	= cpu_to_be32(r2t->xfer_len);
@@ -3234,7 +3234,7 @@ void iscsit_build_rsp_pdu(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
 
 	iscsit_increment_maxcmdsn(cmd, conn->sess);
 	hdr->exp_cmdsn		= cpu_to_be32(conn->sess->exp_cmd_sn);
-	hdr->max_cmdsn		= cpu_to_be32((u32) atomic_read(&conn->sess->max_cmd_sn));
+	iscsit_set_max_cmdsn(hdr, conn);
 
 	pr_debug("Built SCSI Response, ITT: 0x%08x, StatSN: 0x%08x,"
 		" Response: 0x%02x, SAM Status: 0x%02x, CID: %hu\n",
@@ -3314,7 +3314,7 @@ iscsit_build_task_mgt_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
 
 	iscsit_increment_maxcmdsn(cmd, conn->sess);
 	hdr->exp_cmdsn		= cpu_to_be32(conn->sess->exp_cmd_sn);
-	hdr->max_cmdsn		= cpu_to_be32((u32) atomic_read(&conn->sess->max_cmd_sn));
+	iscsit_set_max_cmdsn(hdr, conn);
 
 	pr_debug("Built Task Management Response ITT: 0x%08x,"
 		" StatSN: 0x%08x, Response: 0x%02x, CID: %hu\n",
@@ -3522,7 +3522,7 @@ iscsit_build_text_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
 	 */
 	cmd->maxcmdsn_inc = 0;
 	hdr->exp_cmdsn = cpu_to_be32(conn->sess->exp_cmd_sn);
-	hdr->max_cmdsn = cpu_to_be32((u32) atomic_read(&conn->sess->max_cmd_sn));
+	iscsit_set_max_cmdsn(hdr, conn);
 
 	pr_debug("Built Text Response: ITT: 0x%08x, TTT: 0x%08x, StatSN: 0x%08x,"
 		" Length: %u, CID: %hu F: %d C: %d\n", cmd->init_task_tag,
@@ -3563,7 +3563,7 @@ iscsit_build_reject(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
 	cmd->stat_sn		= conn->stat_sn++;
 	hdr->statsn		= cpu_to_be32(cmd->stat_sn);
 	hdr->exp_cmdsn		= cpu_to_be32(conn->sess->exp_cmd_sn);
-	hdr->max_cmdsn		= cpu_to_be32((u32) atomic_read(&conn->sess->max_cmd_sn));
+	iscsit_set_max_cmdsn(hdr, conn);
 
 }
 EXPORT_SYMBOL(iscsit_build_reject);
diff --git a/drivers/target/iscsi/iscsi_target_device.c b/drivers/target/iscsi/iscsi_target_device.c
index 8bf36ec86e3f..09b23c133dca 100644
--- a/drivers/target/iscsi/iscsi_target_device.c
+++ b/drivers/target/iscsi/iscsi_target_device.c
@@ -13,10 +13,14 @@
 #include <target/target_core_fabric.h>
 
 #include <target/iscsi/iscsi_target_core.h>
+#include <target/iscsi/iscsi_transport.h>
 #include "iscsi_target_device.h"
 #include "iscsi_target_tpg.h"
 #include "iscsi_target_util.h"
 
+#define iscsit_needs_delayed_maxcmdsn_increment(conn) \
+	(conn->conn_transport->transport_type == ISCSI_INFINIBAND)
+
 void iscsit_determine_maxcmdsn(struct iscsi_session *sess)
 {
 	struct se_node_acl *se_nacl;
@@ -42,7 +46,7 @@ void iscsit_determine_maxcmdsn(struct iscsi_session *sess)
 	atomic_add(se_nacl->queue_depth - 1, &sess->max_cmd_sn);
 }
 
-void iscsit_increment_maxcmdsn(struct iscsi_cmd *cmd, struct iscsi_session *sess)
+void __iscsit_increment_maxcmdsn(struct iscsi_cmd *cmd, struct iscsi_session *sess)
 {
 	u32 max_cmd_sn;
 
@@ -54,4 +58,33 @@ void iscsit_increment_maxcmdsn(struct iscsi_cmd *cmd, struct iscsi_session *sess
 	max_cmd_sn = atomic_inc_return(&sess->max_cmd_sn);
 	pr_debug("Updated MaxCmdSN to 0x%08x\n", max_cmd_sn);
 }
+
+void iscsit_increment_maxcmdsn(struct iscsi_cmd *cmd, struct iscsi_session *sess)
+{
+	if (!iscsit_needs_delayed_maxcmdsn_increment(cmd->conn))
+		__iscsit_increment_maxcmdsn(cmd, sess);
+}
 EXPORT_SYMBOL(iscsit_increment_maxcmdsn);
+
+
+
+void iscsit_increment_maxcmdsn_on_release(struct iscsi_cmd *cmd, struct iscsi_session *sess)
+{
+	if (iscsit_needs_delayed_maxcmdsn_increment(cmd->conn)) {
+		__iscsit_increment_maxcmdsn(cmd, sess);
+		if ((u32)atomic_read(&sess->max_cmd_sn) -
+		     READ_ONCE(sess->last_max_cmd_sn)
+		     > sess->cmdsn_window / 2) {
+			/*
+			 * Prevent nopin races if one may be needed by using
+			 * a lock and rechecking after grabbing the lock
+			 */
+			spin_lock_bh(&cmd->conn->nopin_timer_lock);
+			if ((u32)atomic_read(&sess->max_cmd_sn) -
+			    READ_ONCE(sess->last_max_cmd_sn)
+			    > sess->cmdsn_window / 2)
+				iscsit_add_nopin(cmd->conn, 0);
+			spin_unlock_bh(&cmd->conn->nopin_timer_lock);
+		}
+	}
+}
diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
index 1a9c50401bdb..d97c3792f140 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -307,6 +307,7 @@ static int iscsi_login_zero_tsih_s1(
 	 * Initiator Node's ACL once the login has been successfully completed.
 	 */
 	atomic_set(&sess->max_cmd_sn, be32_to_cpu(pdu->cmdsn));
+	sess->last_max_cmd_sn = be32_to_cpu(pdu->cmdsn);
 
 	sess->sess_ops = kzalloc(sizeof(struct iscsi_sess_ops), GFP_KERNEL);
 	if (!sess->sess_ops) {
diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
index 6dd5810e2af1..18685b23e1d0 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -708,6 +708,8 @@ void iscsit_release_cmd(struct iscsi_cmd *cmd)
 
 	BUG_ON(!sess || !sess->se_sess);
 
+	iscsit_increment_maxcmdsn_on_release(cmd, sess);
+
 	kfree(cmd->buf_ptr);
 	kfree(cmd->pdu_list);
 	kfree(cmd->seq_list);
@@ -867,7 +869,7 @@ void iscsit_inc_conn_usage_count(struct iscsi_conn *conn)
 	spin_unlock_bh(&conn->conn_usage_lock);
 }
 
-static int iscsit_add_nopin(struct iscsi_conn *conn, int want_response)
+int iscsit_add_nopin(struct iscsi_conn *conn, int want_response)
 {
 	u8 state;
 	struct iscsi_cmd *cmd;
@@ -877,6 +879,7 @@ static int iscsit_add_nopin(struct iscsi_conn *conn, int want_response)
 		return -1;
 
 	cmd->iscsi_opcode = ISCSI_OP_NOOP_IN;
+	cmd->immediate_cmd = 1;
 	state = (want_response) ? ISTATE_SEND_NOPIN_WANT_RESPONSE :
 				ISTATE_SEND_NOPIN_NO_RESPONSE;
 	cmd->init_task_tag = RESERVED_ITT;
diff --git a/drivers/target/iscsi/iscsi_target_util.h b/drivers/target/iscsi/iscsi_target_util.h
index 8ee1c133a9b7..c4474943f310 100644
--- a/drivers/target/iscsi/iscsi_target_util.h
+++ b/drivers/target/iscsi/iscsi_target_util.h
@@ -68,5 +68,6 @@ extern int tx_data(struct iscsi_conn *, struct kvec *, int, int);
 extern void iscsit_collect_login_stats(struct iscsi_conn *, u8, u8);
 extern struct iscsi_tiqn *iscsit_snmp_get_tiqn(struct iscsi_conn *);
 extern void iscsit_fill_cxn_timeout_err_stats(struct iscsi_session *);
+extern int iscsit_add_nopin(struct iscsi_conn *, int);
 
 #endif /*** ISCSI_TARGET_UTIL_H ***/
diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/iscsi/iscsi_target_core.h
index 1eccb2ac7d02..2983d3798432 100644
--- a/include/target/iscsi/iscsi_target_core.h
+++ b/include/target/iscsi/iscsi_target_core.h
@@ -643,6 +643,7 @@ struct iscsi_session {
 	u32			exp_cmd_sn;
 	/* session wide counter: maximum allowed command sequence number */
 	atomic_t		max_cmd_sn;
+	u32			last_max_cmd_sn;
 	struct list_head	sess_ooo_cmdsn_list;
 
 	/* LIO specific session ID */
@@ -923,4 +924,11 @@ static inline void iscsit_thread_check_cpumask(
 	 */
 	set_cpus_allowed_ptr(p, conn->conn_cpumask);
 }
+
+#define iscsit_set_max_cmdsn(hdr, conn) \
+{ \
+	u32 max_cmdsn = (u32) atomic_read(&conn->sess->max_cmd_sn); \
+	hdr->max_cmdsn = cpu_to_be32(max_cmdsn); \
+	conn->sess->last_max_cmd_sn = max_cmdsn; \
+}
 #endif /* ISCSI_TARGET_CORE_H */
diff --git a/include/target/iscsi/iscsi_transport.h b/include/target/iscsi/iscsi_transport.h
index b8feba7ffebc..878733ca584c 100644
--- a/include/target/iscsi/iscsi_transport.h
+++ b/include/target/iscsi/iscsi_transport.h
@@ -106,6 +106,7 @@ extern int iscsit_response_queue(struct iscsi_conn *, struct iscsi_cmd *, int);
  * From iscsi_target_device.c
  */
 extern void iscsit_increment_maxcmdsn(struct iscsi_cmd *, struct iscsi_session *);
+extern void iscsit_increment_maxcmdsn_on_release(struct iscsi_cmd *, struct iscsi_session *);
 /*
  * From iscsi_target_erl0.c
  */
-- 
2.31.1

