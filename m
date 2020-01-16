Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9CCE13D343
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 05:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgAPEro (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 23:47:44 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34316 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729138AbgAPEro (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jan 2020 23:47:44 -0500
Received: by mail-pj1-f67.google.com with SMTP id s94so2671554pjc.1;
        Wed, 15 Jan 2020 20:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C8K92N6Wm09L11+pWle56w1bj7a3AtfPt0806DIP60o=;
        b=Qo3zIbVpQFtvkYcvZvkEVnRTia9/dRBW3IWnh+dAD5IDh23ezCuBPFKYPq8I+P/gIT
         zjywzFZUFqcqYLMOW3dtBIMIIUfe45+HhxmP9dngZ4ZEWXgL5/IRXi9QBpvU2qhX63zC
         UGnpRGamhyap+CY05vvhw+RPhR79Gk3985y/o/Lk+u6Ut4D2UWZqKTAQSRefRmefqMRL
         UQSbQg9/ArD17pd8gVJoAQdT4iaYFtMFPP0vDGZ8gaQ49PvAoVWkdCBDQdA602//ZYHl
         tWtC1u6fyVRlePRni/d25gOBjrRm5R6im8Lzh1bjRxgdQg/6mGfE72eVTv592uHQIVzq
         lgqQ==
X-Gm-Message-State: APjAAAX1TWNB/ThKkJiNmaI3TT9r84J/oa2v6PRlcXD+va3kE+mRoOq2
        NkTTxrnsMsJP7YAEGdctz4M=
X-Google-Smtp-Source: APXvYqwtU3eWhZAVhZezyPLinkOToEc3068Tn5JlAZJ34vbhSg/i/k8NRtEdNo5lwQrGx9LHQNf+qQ==
X-Received: by 2002:a17:902:82c9:: with SMTP id u9mr29838905plz.264.1579150063542;
        Wed, 15 Jan 2020 20:47:43 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:e955:e36b:c3d8:ecb2])
        by smtp.gmail.com with ESMTPSA id j94sm1495228pje.8.2020.01.15.20.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 20:47:42 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Rahul Kundu <rahul.kundu@chelsio.com>
Subject: [PATCH] RDMA/isert: Fix a recently introduced regression related to logout
Date:   Wed, 15 Jan 2020 20:47:37 -0800
Message-Id: <20200116044737.19507-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

iscsit_close_connection() calls isert_wait_conn(). Due to commit
e9d3009cb936 both functions call target_wait_for_sess_cmds() although
that last function should be called only once. Fix this by removing
the target_wait_for_sess_cmds() call from isert_wait_conn() and by
only calling isert_wait_conn() after target_wait_for_sess_cmds().

Reported-by: Rahul Kundu <rahul.kundu@chelsio.com>
Fixes: e9d3009cb936 ("scsi: target: iscsi: Wait for all commands to finish before freeing a session").
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 12 ------------
 drivers/target/iscsi/iscsi_target.c     |  6 +++---
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index a1a035270cab..b273e421e910 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2575,17 +2575,6 @@ isert_wait4logout(struct isert_conn *isert_conn)
 	}
 }
 
-static void
-isert_wait4cmds(struct iscsi_conn *conn)
-{
-	isert_info("iscsi_conn %p\n", conn);
-
-	if (conn->sess) {
-		target_sess_cmd_list_set_waiting(conn->sess->se_sess);
-		target_wait_for_sess_cmds(conn->sess->se_sess);
-	}
-}
-
 /**
  * isert_put_unsol_pending_cmds() - Drop commands waiting for
  *     unsolicitate dataout
@@ -2633,7 +2622,6 @@ static void isert_wait_conn(struct iscsi_conn *conn)
 
 	ib_drain_qp(isert_conn->qp);
 	isert_put_unsol_pending_cmds(conn);
-	isert_wait4cmds(conn);
 	isert_wait4logout(isert_conn);
 
 	queue_work(isert_release_wq, &isert_conn->release_work);
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 7251a87bb576..b94ed4e30770 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4149,9 +4149,6 @@ int iscsit_close_connection(
 	iscsit_stop_nopin_response_timer(conn);
 	iscsit_stop_nopin_timer(conn);
 
-	if (conn->conn_transport->iscsit_wait_conn)
-		conn->conn_transport->iscsit_wait_conn(conn);
-
 	/*
 	 * During Connection recovery drop unacknowledged out of order
 	 * commands for this connection, and prepare the other commands
@@ -4237,6 +4234,9 @@ int iscsit_close_connection(
 	target_sess_cmd_list_set_waiting(sess->se_sess);
 	target_wait_for_sess_cmds(sess->se_sess);
 
+	if (conn->conn_transport->iscsit_wait_conn)
+		conn->conn_transport->iscsit_wait_conn(conn);
+
 	ahash_request_free(conn->conn_tx_hash);
 	if (conn->conn_rx_hash) {
 		struct crypto_ahash *tfm;
