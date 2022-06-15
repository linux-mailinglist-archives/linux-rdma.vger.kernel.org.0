Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D9354C3C0
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 10:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346570AbiFOIlh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 04:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346459AbiFOIlf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 04:41:35 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7046F4AE17
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 01:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=s5HWzCEtMjmjkB+xRG1YT2W4LPFIUXExDZNg/wHwxPk=; b=R1EMRO7fyVRIgDz4IJSV7F2UNA
        I3sTLmvgtHAZF2gonYh2lL+oO609vP527mlzTiYlCoghs5XxlYdUwJk5n3ibfdtotqEYfZEoKW50P
        VYEN0zn3G+N1/y7z0pA94GHmWHAWwzLM5ry+TPco2PiCmr29qQc7MLzXiVim02gtvbEIcl2vyW5bJ
        GgQlCAh3IpRiZJVQxIAndKJT86pp/1RU8TAo5eF9DGo3k4jkhpXm/CPnYILuInhQr8jwOzv/e/BLf
        1+3hHU7XmooSEjaJa/uGLU/zBQdaLb1QB9wHHGuPeDBmDFUDswLh03J1YxUCQBWkjZ9icBkcd4M8Q
        /VaERwWfqNpi5Uw2uCg/PrwNwjCMAIEJEluQyq3Y+Mu0Y8AxV9CkB8UZVXptknbO6l4qMqKc0/t9j
        cKUBEpq2kVIQHCVnR/qp02c/M4IZbfCCCf3yf2SySyIqtAWLIkaJaX6Q+ddJdYeAaQFjJOx5UQ/OI
        XjJm7WdoegXo773RhY5pzJsj;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1Oai-005p9t-Ev; Wed, 15 Jun 2022 08:41:32 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 4/7] rdma/siw: use error and out logic at the end of siw_connect()
Date:   Wed, 15 Jun 2022 10:40:04 +0200
Message-Id: <954c86484412d79ce9116e67fdf0efb94add67ba.1655248086.git.metze@samba.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655248086.git.metze@samba.org>
References: <cover.1655248086.git.metze@samba.org>
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

This will make the following changes easier.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 0e53219d29de..b19a2b777814 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1489,14 +1489,19 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 		cep->mpa.pdata = NULL;
 	}
 
-	if (rv >= 0) {
-		rv = siw_cm_queue_work(cep, SIW_CM_WORK_MPATIMEOUT);
-		if (!rv) {
-			siw_dbg_cep(cep, "[QP %u]: exit\n", qp_id(qp));
-			siw_cep_set_free(cep);
-			return 0;
-		}
+	if (rv < 0) {
+		goto error;
+	}
+
+	rv = siw_cm_queue_work(cep, SIW_CM_WORK_MPATIMEOUT);
+	if (rv != 0) {
+		goto error;
 	}
+
+	siw_dbg_cep(cep, "[QP %u]: exit\n", qp_id(qp));
+	siw_cep_set_free(cep);
+	return 0;
+
 error:
 	siw_dbg(id->device, "failed: %d\n", rv);
 
-- 
2.34.1

