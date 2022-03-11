Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC99F4D6828
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Mar 2022 18:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350500AbiCKR6w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Mar 2022 12:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350562AbiCKR6v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Mar 2022 12:58:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76F4FA76CA
        for <linux-rdma@vger.kernel.org>; Fri, 11 Mar 2022 09:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647021463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nh9bTUIUacOod+DLliFISU6Ql6jfYfcDEklqeiHOHCg=;
        b=WpXbYT/5CbJdhAiGaFVBM0yulON60fqYK93lqDINEu6lTuA+wRr9ADI7EpIwbPCb7+OL0H
        4nZfeJwB50ALYi0v1tragKp+pFJn62uova2EG+xhbG6w+0vreOYeZ6bIRBBsCf1Oib+O3m
        qjN0ECooTC4LbS1na2ANsOBINjkB3uI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-QmyS2XJYMOawwSrBd2dxkg-1; Fri, 11 Mar 2022 12:57:38 -0500
X-MC-Unique: QmyS2XJYMOawwSrBd2dxkg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDDB71091DA3;
        Fri, 11 Mar 2022 17:57:37 +0000 (UTC)
Received: from gluttony.redhat.com (unknown [10.22.19.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 325A980685;
        Fri, 11 Mar 2022 17:57:37 +0000 (UTC)
From:   David Jeffery <djeffery@redhat.com>
To:     linux-rdma@vger.kernel.org
Cc:     target-devel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Laurence Oberman <loberman@redhat.com>,
        David Jeffery <djeffery@redhat.com>
Subject: [PATCH 1/2] isert: support for unsolicited NOPIN with no response.
Date:   Fri, 11 Mar 2022 12:57:12 -0500
Message-Id: <20220311175713.2344960-2-djeffery@redhat.com>
In-Reply-To: <20220311175713.2344960-1-djeffery@redhat.com>
References: <20220311175713.2344960-1-djeffery@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The isert module has only supported sending a NOPIN as a response to a
NOPOUT. In order to be able to use an unsolicited NOPIN to inform the
initiator of max_cmd_sn changes, isert needs to be able to send a NOPIN
as needed.

Signed-off-by: David Jeffery <djeffery@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 636d590765f9..b8390ad762eb 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -1469,6 +1469,7 @@ isert_put_cmd(struct isert_cmd *isert_cmd, bool comp_err)
 		break;
 	case ISCSI_OP_REJECT:
 	case ISCSI_OP_NOOP_OUT:
+	case ISCSI_OP_NOOP_IN:
 	case ISCSI_OP_TEXT:
 		hdr = (struct iscsi_text_rsp *)&isert_cmd->tx_desc.iscsi_header;
 		/* If the continue bit is on, keep the command alive */
@@ -1858,7 +1859,14 @@ isert_put_nopin(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
 
 	isert_dbg("conn %p Posting NOPIN Response\n", isert_conn);
 
-	return isert_post_response(isert_conn, isert_cmd);
+	if (nopout_response)
+		return isert_post_response(isert_conn, isert_cmd);
+
+	/* pointer init since didn't go through isert_allocate_cmd */
+	isert_cmd->conn = isert_conn;
+	isert_cmd->iscsi_cmd = cmd;
+
+	return ib_post_send(isert_conn->qp, send_wr, NULL);
 }
 
 static int
@@ -2159,6 +2167,7 @@ isert_immediate_queue(struct iscsi_conn *conn, struct iscsi_cmd *cmd, int state)
 		spin_unlock_bh(&conn->cmd_lock);
 		isert_put_cmd(isert_cmd, true);
 		break;
+	case ISTATE_SEND_NOPIN_NO_RESPONSE:
 	case ISTATE_SEND_NOPIN_WANT_RESPONSE:
 		ret = isert_put_nopin(cmd, conn, false);
 		break;
-- 
2.31.1

