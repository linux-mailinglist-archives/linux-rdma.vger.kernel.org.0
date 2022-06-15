Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D336054CCDE
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 17:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352845AbiFOP27 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 11:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356115AbiFOP2o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 11:28:44 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2B84615B
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 08:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=R1jxQQe45vczPRNKdLsSJYVZvPiaBRAQEVVO1On1/ZY=; b=jTqYI7JZ9UMHLomPW+mVEZSmnD
        q7tORyQl+DzpSWz0BHoms+atXzEL4BwpqejShks9vY31MY0k3q46wouE+Voy6qsV3Gc1jiE/0D6iH
        isrFMouQ8ZIMfvHhjrTMQitCT/CfpH6MT/RsWFGJPB+rxHAl3gXVz8SClPctvJz8zkKrd55v1C1G0
        ad9vHwNUKyigB8lvA4rfo653HdIXeqV7+0RxaUSmQmyxBAvGUdaXdZ9pn5G4bJzHjETO0zj9I0cqb
        0MDRkOZHeyBbiSg8anL3WSQo7qO84FrEdCi0AG/6ZfDr4ASDH8W8RC8m9X5X0yf5c6AD90OQiSC2e
        Co9DM1cM5cdPxvgwn/9G7dQum3T3VFZ8OuQumpiIZeFE+utlUQSjZ66wX9iO+0k4kEJyV/tH3OWkW
        X+EJl6euCI9loysGekx5JpIGS1+oy1kakX3vj4d42sTw1z0j4Q9dnQ5VYDpjfRd8p+CE/SQeKny17
        BAkldcYVqF+Os43C5qPz4zqP;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1UwF-005rvp-3A; Wed, 15 Jun 2022 15:28:11 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     Stefan Metzmacher <metze@samba.org>
Subject: [PATCH v2 10/14] rdma/siw: create a temporary copy of private data
Date:   Wed, 15 Jun 2022 17:26:48 +0200
Message-Id: <3f660bd8e98c907cbef88623476b7c24ff2f3635.1655305567.git.metze@samba.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655305567.git.metze@samba.org>
References: <cover.1655305567.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The final patch will implement a non-blocking connect,
which means that siw_connect() will be split into
siw_connect() and siw_connected().

kernel_bindconnect() will be the last action
in siw_connect(), while the MPA negotiation
is deferred to siw_connected().

We should not rely on the callers private data
pointers to be still valid when siw_connected()
is called, so we better create a copy.

Also note that __siw_cep_dealloc() already calls
kfree(cep->mpa.pdata), so we already have the required cleanup
when we'll split out siw_connected() and an error will
prevent siw_connected() being called at all.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index c980e5035552..307494c6707a 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1480,13 +1480,27 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	}
 	memcpy(cep->mpa.hdr.key, MPA_KEY_REQ, 16);
 
+	if (pd_len > 0) {
+		cep->mpa.pdata = kmemdup(params->private_data, pd_len, GFP_KERNEL);
+		if (IS_ERR_OR_NULL(cep->mpa.pdata)) {
+			rv = -ENOMEM;
+			goto error;
+		}
+		cep->mpa.hdr.params.pd_len = pd_len;
+	}
+
 	cep->state = SIW_EPSTATE_AWAIT_MPAREP;
 
-	rv = siw_send_mpareqrep(cep, params->private_data, pd_len);
+	rv = siw_send_mpareqrep(cep, cep->mpa.pdata,
+				cep->mpa.hdr.params.pd_len);
 	/*
 	 * Reset private data.
 	 */
-	cep->mpa.hdr.params.pd_len = 0;
+	if (cep->mpa.hdr.params.pd_len) {
+		cep->mpa.hdr.params.pd_len = 0;
+		kfree(cep->mpa.pdata);
+		cep->mpa.pdata = NULL;
+	}
 
 	if (rv >= 0) {
 		rv = siw_cm_queue_work(cep, SIW_CM_WORK_MPATIMEOUT);
-- 
2.34.1

